class @Game

  constructor: ->
    @animate()

  animate: =>
    requestAnimationFrame(@animate)
    console.log(if Math.random() > 0.8 then 'blast' else 'need coffee!')
