class @InputManager

  constructor: ->
    @bindings = {}
    @actions = {}
    addEventListener('keydown', @onKeyDown)
    addEventListener('keyup', @onKeyUp)

  bind: (keyCode, action) ->
    @bindings[keyCode] = action
    @actions[action] = false

  onKeyDown: (event) =>
    action = @bindings[event.keyCode]
    if action
      event.preventDefault()
      @actions[action] = true

  onKeyUp: (event) =>
    action = @bindings[event.keyCode]
    if action
      event.preventDefault()
      @actions[action] = false
