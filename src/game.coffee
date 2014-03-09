# depends: input_manager
# depends: physics_manager
# depends: network_manager
# depends: player_ship
# depends: enemy_ship
# depends: arena

class @Game

  @games: []

  @updateAllPhysics: ->
    game.updatePhysics() for game in Game.games

  constructor: ->
    Game.games.push(@)
    @scene = new SceneManager
    @partical = new ParticalManager
    @physics = new PhysicsManager(@)
    @input = new InputManager
    @gameItems = []
    @network = new NetworkManager
    @bindInput()
    @add(@partical)
    @enemies = {}
    @player = @add(new PlayerShip)
    @add(new Arena)
    @physics.start()
    @loadSounds()

  sounds:
    thrust: ['thrust1.wav']
    firePrimary: ['shoot1.wav']
    hit: ['explosion1.wav']

  playSound: (sound) ->
    sounds = @sounds[sound]
    file = sounds[parseInt(Math.random() * sounds.length)]
    SoundManager.playSound "sounds/#{file}"

  loadSounds: ->
    for sound, files of @sounds
      for file in files
        path = "sounds/#{file}"
        SoundManager.loadAsync path 

  add: (object) ->
    if object.body and object.mesh
      model = new SceneModel(object.mesh, object.body)
    else
      model = object.mesh
    @scene.add(model) if model
    @physics.add(object)
    @gameItems.push(object) if object.update
    object

  remove: (object) ->
    @scene.remove(object.mesh)
    @physics.remove(object.body)
    index = @gameItems.indexOf(object)
    @gameItems.splice(index, 1) unless index == -1

  bindInput: ->
    @input.bind(38, 'thrust')     # up
    @input.bind(39, 'right')      # right
    @input.bind(37, 'left')       # left
    @input.bind(32, 'primary')    # space
    @input.bind(16, 'secondary')  # shift
    @input.bind(77, 'mute')       # toggle sound

  updatePhysics: ->
    object.update(@) for object in @gameItems

  render: =>
    @load @network.data
    @network.update @
    @updateCollisions()
    @scene.render()

  serialize: ->
    data = @player.serialize()
    data['actions'] = @input.actions
    data

  load: (data) ->
    for id of data
      if enemy = data[id]
        @enemies[id] ?= @add new EnemyShip
          color: 0x00ff00
          ambient: 0x003300
        @enemies[id].load enemy
        @enemies[id].firePrimary(@) if enemy.actions.primary
        @enemies[id].thrust(@) if enemy.actions.thrust
        @enemies[id].turnRight() if enemy.actions.right
        @enemies[id].turnLeft() if enemy.actions.left
      else
        @remove @enemies[id] if @enemies[id]
        delete data[id]


  updateCollisions: ->
    for impact in @physics.engine.pairsList
      bodies = [impact.collision.bodyA, impact.collision.bodyB]
      for body in bodies
        body.owner.explode(@) if body.owner?.explode

Matter.MouseConstraint.update = Game.updateAllPhysics
