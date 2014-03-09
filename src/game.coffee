# depends: input_manager
# depends: physics_manager
# depends: network_manager
# depends: player_ship
# depends: arena

class @Game

  @games: []

  @updateAll: ->
    game.update() for game in Game.games

  constructor: ->
    Game.games.push(@)
    @scene = new SceneManager
    @partical = new ParticalManager
    @physic = new PhysicsManager(@)
    @input = new InputManager
    @gameItems = []
    @network = new NetworkManager
    @bindInput()
    @add(@partical)
    @ship = @add(new PlayerShip)
    @add(new Arena)
    @physic.start()

  add: (object) ->
    if object.body and object.mesh
      model = new SceneModel(object.mesh, object.body)
    else
      model = object.mesh
    @scene.add(model) if model
    @physic.add(object)
    @gameItems.push(object) if object.update
    object

  remove: (object) ->
    @scene.remove(object.mesh)
    @physic.remove(object.body)
    index = @gameItems.indexOf(object)
    @gameItems.splice(index, 1) unless index == -1

  bindInput: ->
    @input.bind(38, 'thrust')     # up
    @input.bind(39, 'right')      # right
    @input.bind(37, 'left')       # left
    @input.bind(32, 'primary')    # space
    @input.bind(16, 'secondary')  # shift
    @input.bind(77, 'mute')       # toggle sound

  update: ->
    object.update(@) for object in @gameItems

  render: =>
    if data = @network.data
      @enemy ?= @add new BaseShip
        color: 0x00ff00
        ambient: 0x003300
      @enemy.body.position = data.position
      @enemy.body.angle = data.angle

    @network.update @ship
    @scene.render()

Matter.MouseConstraint.update = Game.updateAll
