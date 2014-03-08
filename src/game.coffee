# depends: input_manager
# depends: physics_manager
# depends: dummy_ship
# depends: arena 

class @Game

  constructor: ->
    @scene = new SceneManager
    @physic = new PhysicsManager
    @input = new InputManager
    @gameItems = []
    @network = new NetworkManager
    @ship = new DummyShip()
    @scene.add(@ship.mesh)
    @physic.add(@ship.body)
    @bindInput()
    @add(new DummyShip)
    @add(new Arena)
    @animate()

  add: (object) ->
    @scene.add(object.mesh) if object.mesh
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

  animate: =>
    requestAnimationFrame(@animate)
    @processInput()
    @physic.tick()
    object.update(@) for object in @gameItems
    @scene.render()

  processInput: ->
    console.log('thrust') if(@input.actions.thrust)
    console.log('right') if(@input.actions.right)
    console.log('left') if(@input.actions.left)
    console.log('primary') if(@input.actions.primary)
    console.log('secondary') if(@input.actions.secondary)
    console.log('mute') if(@input.actions.mute)
