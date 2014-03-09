class @ParticalManager

  vShader: """
      attribute float size;
      attribute vec3 ccolor;
      varying vec3 vColor;
      void main() {
        vColor = ccolor;
        vec4 mvPosition = modelViewMatrix * vec4( position, 1.0 );
        gl_PointSize = size;
        gl_Position = projectionMatrix * mvPosition;
      }
  """

  fShader: """
      uniform vec3 color;
      uniform sampler2D texture;
      varying vec3 vColor;
      void main() {
        gl_FragColor = vec4( color * vColor, 1.0 );
        gl_FragColor = gl_FragColor * texture2D( texture, gl_PointCoord );
      }
  """

  particles: 5000

  constructor: ->
    @motion = []
    @decay = []
    attributes = {
      start: {type: 'l', value: []},
      size: {type: 'f', value: []},
      ccolor: {type: 'c', value: []}
    }
    uniforms = {
      color: {type: 'c', value: new THREE.Color(0xffffff)},
      texture: {type: "t", value: THREE.ImageUtils.loadTexture("textures/spark1.png")},
    }

    @geometry = new THREE.Geometry()
    for i in [0...@particles]
      attributes.size.value.push(0.0)
      attributes.ccolor.value.push(new THREE.Color(0xff0000))
      this.geometry.vertices.push(new THREE.Vector3(99999999999999, 99999999999999, 0))
      this.motion.push(new THREE.Vector3())

    shaderMaterial = new THREE.ShaderMaterial( {
      uniforms:     uniforms,
      attributes:     attributes,
      vertexShader:   @vShader,
      fragmentShader: @fShader,
      blending:     THREE.AdditiveBlending,
      depthTest:    false,
      transparent:  true
    })

    @nextParticle = 0

    particleSystem = new THREE.ParticleSystem( @geometry, shaderMaterial )
    particleSystem.dynamic = true
    @mesh = particleSystem

  update: ->
    positions = @geometry.vertices
    size = @mesh.material.attributes.size
    innerWidth = 1000
    innerHeight = 1000
    for i in [0...positions.length]
      positions[i].x += @motion[i].x
      positions[i].y += @motion[i].y
      positions[i].z += @motion[i].z
      positions[i].x -= (x / positions[i].x) * innerWidth if (x = Math.abs(positions[i].x)) > innerWidth/2
      positions[i].y -= (y / positions[i].y) * innerHeight if (y = Math.abs(positions[i].y)) > innerHeight/2
      size.value[i] = Math.max(0, size.value[i] - @decay[i])
    size.needsUpdate = true
    @geometry.verticesNeedUpdate = true

  explode: (position, color, count) ->
    color = color || new THREE.Color(0xff0000)
    count = count || 100
    positions = @geometry.vertices
    motions = @motion
    colors = @mesh.material.attributes.ccolor.value
    start = @nextParticle
    end = (@nextParticle + Math.floor(count)) % positions.length
    @nextParticle = end
    i = start
    while i != end
      positions[i].x = position.x
      positions[i].y = position.y
      a = Math.random() * 2 * Math.PI
      s = Math.random() * 10
      motions[i].x = s * Math.cos(a)
      motions[i].y = s * Math.sin(a)
      @mesh.material.attributes.ccolor.value[i].copy(color)
      @mesh.material.attributes.size.value[i] = 30.0
      @decay[i] = Math.max(0.2, s * Math.random())
      i = (i + 1) % positions.length
    @mesh.material.attributes.ccolor.needsUpdate = true

  cone: (position, direction, color, count) ->
    color = color || new THREE.Color(0xff0000)
    count = count || 100
    positions = @geometry.vertices
    motions = @motion
    colors = @mesh.material.attributes.ccolor.value
    start = @nextParticle
    end = (@nextParticle + Math.floor(count)) % positions.length
    @nextParticle = end
    i = start
    while i != end
      positions[i].copy(position)
      motions[i].copy(direction)
      motions[i].x += Math.random() - 0.5
      motions[i].y += Math.random() - 0.5
      @mesh.material.attributes.ccolor.value[i].copy(color)
      @mesh.material.attributes.size.value[i] = 30.0
      @decay[i] = Math.max(0.2, 10 * Math.random())
      i = (i + 1) % positions.length
    @mesh.material.attributes.ccolor.needsUpdate = true
