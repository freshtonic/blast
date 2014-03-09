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

  update: (game) ->
    @ship.rotation.x += 0.1
    @mesh.position.set(@body.position.x, -@body.position.y, 0)
    @mesh.rotation.z = @body.angle

  serialize: ->
    position: @body.position
    angle: @body.angle
