# depends: base_ship

Body = Matter.Body
Vector3 = THREE.Vector3
Color = THREE.Color

class @PlayerShip extends @BaseShip

  update: (game) ->
    @thrust(game) if game.input.actions.thrust
    @turnRight() if game.input.actions.right
    @turnLeft() if game.input.actions.left
    super

  thrust: (game) ->
    angle = @body.angle - Math.PI / 2
    force = {
      x: @thrustPower * Math.cos(angle),
      y: @thrustPower * Math.sin(angle)
    }
    Body.applyForce(@body, {x: 0, y: 0}, force)
    position = new Vector3(@body.position.x, -@body.position.y, 0)
    thrust = new Vector3(-force.x * 10000, force.y * 10000, 0)
    game.partical.cone(position, thrust, new Color(0x154492), 15)

  turnRight: ->
    Body.rotate(@body, @rotationSpeed)

  turnLeft: ->
    Body.rotate(@body, -@rotationSpeed)
