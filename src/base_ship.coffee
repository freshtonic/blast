Bodies = Matter.Bodies

class @BaseShip

  constructor: (options = {}) ->
    @rotationSpeed = 0.1
    @thrustPower = 0.0001
    cube = new THREE.CubeGeometry(50, 20, 10)
    mat = new THREE.MeshLambertMaterial
      color: options.color || 0xff0000
      ambient: options.ambient || 0x330000
    @ship = new THREE.Mesh(cube, mat)
    @mesh = new THREE.Object3D()
    @mesh.add(@ship)
    @body = Bodies.trapezoid(100, 0, 20, 50, 0.5)
    @primaryGunPower = 0.1

  update: (game) ->
    @ship.rotation.x += 0.1
    @firePrimary(game) if game.input.actions.primary
    @thrust(game) if game.input.actions.thrust
    @turnRight() if game.input.actions.right
    @turnLeft() if game.input.actions.left

  serialize: ->
    position: @body.position
    angle: @body.angle

  turnRight: ->
    Body.rotate(@body, @rotationSpeed)

  turnLeft: ->
    Body.rotate(@body, -@rotationSpeed)

  getAngle: ->
    angle = @body.angle - Math.PI / 2

  getDirectionalForce: (proportion) ->
    angle = @getAngle()
    {
      x: proportion * Math.cos(angle)
      y: proportion * Math.sin(angle)
    }

  thrust: (game) ->
    force = @getDirectionalForce(@thrustPower)
    Body.applyForce(@body, {x: 0, y: 0}, force)
    position = new Vector3(@body.position.x, -@body.position.y, 0)
    thrust = new Vector3(-force.x * 10000, force.y * 10000, 0)
    game.partical.cone(position, thrust, new Color(0x154492), 15)

  turnRight: ->
    Body.rotate(@body, @rotationSpeed)

  turnLeft: ->
    Body.rotate(@body, -@rotationSpeed)

  firePrimary: (game) ->
    particle = Bodies.circle @body.position.x, @body.position.y, 1 * @primaryGunPower
    Body.applyForce(particle, @getDirectionalForce(100), @getDirectionalForce(0.00001))
    particleGeometry = new THREE.CubeGeometry(10, 10, 10)
    mat = new THREE.MeshLambertMaterial(color: 0xffff00, ambient: 0x33ff00)
    mesh = new THREE.Mesh(particleGeometry, mat)
    game.add {
      mesh: mesh
      body: particle
    }

