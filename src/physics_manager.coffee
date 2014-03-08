Engine = Matter.Engine
World = Matter.World

class @PhysicsManager

  constructor: (@game) ->
    @engine = Engine.create(document.body)
    @engine.events.render = @game.render
    @world = @engine.world
    @world.gravity.y = 0

  add: (body) ->
    World.addBody(@world, body)

  remove: (body) ->
    @world.bodies.splice(@world.bodies.indexOf(body), 1)

  start: (game) ->
    Engine.run(@engine)
