# depends: input_manager
# depends: physics_manager
# depends: renderer
# depends: dummy_ship
# depends: arena 

class @Game

  @games: []

  @updateAll: ->
    game.update() for game in Game.games

  constructor: ->
    Game.games.push(@)
    @scene = new SceneManager
    @physic = new PhysicsManager(@scene)
    @input = new InputManager
    @gameItems = []
    @network = new NetworkManager
    @ship = new DummyShip()
    @scene.add(@ship.mesh)
    @physic.add(@ship.body)
    @bindInput()
    @add(new DummyShip)
    @add(new Arena)
    @physic.start()

  add: (object) ->
    if object.body and object.mesh
      model = new SceneModel(object.mesh, object.body)
    else
      model = object.mesh
    @scene.add(model) if model
    @physic.add(object.body) if object.body
    @gameItems.push(object) if object.update

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
    @input.bind(77, 'mute')       # m

  update: ->
    object.update(@) for object in @gameItems

Matter.MouseConstraint.update = Game.updateAll
