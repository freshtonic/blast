Scene = THREE.Scene
OrthographicCamera = THREE.OrthographicCamera
AmbientLight = THREE.AmbientLight
DirectionalLight = THREE.DirectionalLight
WebGLRenderer = THREE.WebGLRenderer

class @SceneManager

  constructor: ->
    halfWidth = innerWidth / 2
    halfHeight = innerHeight / 2
    @camera = new OrthographicCamera(-halfWidth, halfWidth, halfHeight, -halfHeight, 1, 2000)
    @camera.position.z = 1000

    @scene = new Scene
    light = new AmbientLight(0xffffff)
    @scene.add(light)
    light = new DirectionalLight(0xffffff, 0.7)
    light.position.set(-800, 900, 300)
    @scene.add(light)

    @renderer = new WebGLRenderer(antialias: true, clearColor: 0x0, clearAlpha: 1)
    @renderer.setSize(innerWidth, innerHeight)
    addEventListener('resize', @onResize)
    document.body.appendChild(@renderer.domElement)

  add: (model) ->
    @scene.add(model)

  remove: (model) ->
    @scene.remove(model)

  render: ->
    @renderer.render(@scene, @camera)

  onResize: =>
    @camera.aspect = innerWidth / innerHeight
    @camera.updateProjectionMatrix()
    @renderer.setSize(innerWidth, innerHeight)
