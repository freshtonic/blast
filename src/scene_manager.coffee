Scene = THREE.Scene
OrthographicCamera = THREE.OrthographicCamera
AmbientLight = THREE.AmbientLight
DirectionalLight = THREE.DirectionalLight
WebGLRenderer = THREE.WebGLRenderer

class @SceneManager

  constructor: ->
    @models = []

    @camera = new OrthographicCamera(-500, 500, 500, -500, 1, 2000)
    @camera.position.z = 1000

    @scene = new Scene
    light = new AmbientLight(0xffffff)
    @scene.add(light)
    light = new DirectionalLight(0xffffff, 0.7)
    light.position.set(-800, 900, 300)
    @scene.add(light)

    @renderer = new WebGLRenderer(antialias: true, clearColor: 0x0, clearAlpha: 1)
    @setRendererSize()
    addEventListener('resize', @onResize)
    document.body.appendChild(@renderer.domElement)

  add: (model) ->
    @models.push(model) if model.mesh
    @scene.add(model.mesh || model)

  remove: (model) ->
    @models.splice(@models.indexOf(model), 1)
    @scene.remove(model)

  render: =>
    model.update() for model in @models
    @renderer.render(@scene, @camera)

  setRendererSize: ->
    size = Math.min(innerWidth, innerHeight)
    @renderer.setSize(size, size)

  onResize: =>
    @camera.aspect = innerWidth / innerHeight
    @camera.updateProjectionMatrix()
    @setRendererSize()
