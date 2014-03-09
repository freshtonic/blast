Composite = Matter.Composite
Bodies = Matter.Bodies
Body = Matter.Body

Vector3 = THREE.Vector3
Color = THREE.Color

class @BaseShip

  constructor: ->
    @rotationSpeed = 0.1
    @thrustPower = 0.0001
    cube = new THREE.CubeGeometry(50, 20, 10)
    mat = new THREE.MeshLambertMaterial(color: 0xff0000, ambient: 0x330000)
    @ship = new THREE.Mesh(cube, mat)
    @mesh = new THREE.Object3D()
    @mesh.add(@ship)
    @body = Bodies.trapezoid(100, 0, 20, 50, 0.5)

  update: (game) ->
    @ship.rotation.x += 0.1
    @thrust(game) if game.input.actions.thrust
    @turnRight() if game.input.actions.right
    @turnLeft() if game.input.actions.left
    @mesh.position.set(@body.position.x, -@body.position.y, 0)
    @mesh.rotation.z = @body.angle

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

  serialize: ->
    position: @body.position
    angle: @body.angle
