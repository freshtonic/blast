Body = Matter.Body
Bodies = Matter.Bodies
Composite = Matter.Composite

class @Arena
  constructor: ->
    material = new THREE.MeshLambertMaterial(color: 0xffff00, ambient: 0x33ff00)

    @mesh = new THREE.Object3D()

    topLeftMesh = new THREE.Object3D()
    cube1 = new THREE.CubeGeometry(200, 20, 10)
    cube2 = new THREE.CubeGeometry(20, 200, 10)
    mesh1 =  new THREE.Mesh(cube1, material)
    mesh2 =  new THREE.Mesh(cube2, material)
    mesh1.position.set(-380, 490, 0)
    mesh2.position.set(-490, 380, 0)
    topLeftMesh.add mesh1
    topLeftMesh.add mesh2

    topRightMesh = topLeftMesh.clone()
    topRightMesh.scale.x = -1

    bottomRightMesh = topRightMesh.clone()
    bottomRightMesh.scale.y = -1

    bottomLeftMesh = bottomRightMesh.clone()
    bottomLeftMesh.scale.x = 1

    @mesh.add topLeftMesh
    @mesh.add topRightMesh
    @mesh.add bottomRightMesh
    @mesh.add bottomLeftMesh

    diamond = new THREE.CubeGeometry(100, 100, 10)
    diamondMesh = new THREE.Mesh(diamond, material)
    diamondMesh.rotation.z = Math.PI / 4
    @mesh.add diamondMesh

    bottomLeft1 = Bodies.rectangle(-380, 490, 200, 20, isStatic: true)
    bottomLeft2 = Bodies.rectangle(-490, 380, 20, 200, isStatic: true)
    bottomRigth1 = Bodies.rectangle(380, 490, 200, 20, isStatic: true)
    bottomRigth2 = Bodies.rectangle(490, 380, 20, 200, isStatic: true)
    topLeft1 = Bodies.rectangle(-380, -490, 200, 20, isStatic: true)
    topLeft2 = Bodies.rectangle(-490, -380, 20, 200, isStatic: true)
    topRigth1 = Bodies.rectangle(380, -490, 200, 20, isStatic: true)
    topRigth2 = Bodies.rectangle(490, -380, 20, 200, isStatic: true)
    dimond = Bodies.rectangle(0, 0, 100, 100, isStatic: true)
    Body.rotate(dimond, Math.PI / 4)

    @composite = Composite.create(bodies: [
      bottomLeft1, bottomLeft2, bottomRigth1, bottomRigth2,
      topLeft1, topLeft2, topRigth1, topRigth2,
      dimond
    ])
