Engine = Matter.Engine
World = Matter.World

class @PhysicsManager

  constructor: ->
    @engine = Engine.create(document.createElement('div'))
    @world = @engine.world

  add: (body) ->
    World.addBody(@world, body)

  remove: (body) ->
    @world.bodies.splice(@world.bodies.indexOf(body), 1)

  tick: ->
    @engine.events.tick(@engine)
