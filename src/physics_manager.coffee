Engine = Matter.Engine
World = Matter.World

class @PhysicsManager

  constructor: (@game) ->
    @engine = Engine.create(document.createElement('div'))
    @engine.events.render = @game.render
    @world = @engine.world
    @world.gravity.y = 0

  add: (model) ->
    World.addBody(@world, model.body) if model.body
    World.addComposite(@world, model.composite) if model.composite

  remove: (body) ->
    @world.bodies.splice(@world.bodies.indexOf(body), 1)

  start: (game) ->
    Engine.run(@engine)
