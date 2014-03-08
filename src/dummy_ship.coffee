class @DummyShip

  constructor: ->
    cube = new THREE.CubeGeometry(50, 20, 10)
    mat = new THREE.MeshLambertMaterial(color: 0xff0000, ambient: 0x330000)
    @mesh = new THREE.Mesh(cube, mat)
    @body = Matter.Bodies.rectangle(0, 0, 50, 20)

  update: ->
    @mesh.position.set(@body.position.x, -@body.position.y, 0)
    @mesh.rotation.z = @body.angle
