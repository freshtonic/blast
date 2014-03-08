# depends: input_manager

class @Game

  constructor: ->
    @scene = new SceneManager
    @input = new InputManager
    @bindInput()
    @animate()

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
    @scene.render()

  processInput: ->
    console.log('thrust') if(@input.actions.thrust)
    console.log('right') if(@input.actions.right)
    console.log('left') if(@input.actions.left)
    console.log('primary') if(@input.actions.primary)
    console.log('secondary') if(@input.actions.secondary)
    console.log('mute') if(@input.actions.mute)
