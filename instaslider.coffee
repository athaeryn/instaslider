class InstaSlider
  constructor: (@options) ->
    @$container = $('#instaslider')

  run: ->
    feed = @_createInstafeed()
    feed.run()

  _createInstafeed: =>
    @options.get = 'user'
    @options.mock = true
    @options.success = @_processFeed
    new Instafeed @options

  _createHashtagFilter: (hashtag) ->
    return (e) -> e.tags.indexOf(hashtag) > -1

  _feedDataToImgEl: (data) ->
    url = data.images.standard_resolution.url
    titleText = data.caption.text
    return $('<img>', { src: url, title: titleText })

  _sliderFromImages: (images) =>
    $ul = $('<div>', { class: 'owl-carousel' })
    images.forEach ($img) =>
      @$container.append $('<div>').append $img

  _processFeed: (response) =>
    data = response.data
    if @options.filter?
      hashtagFilter = @_createHashtagFilter @options.filter
      filteredData = data.filter hashtagFilter
      images = filteredData.map @_feedDataToImgEl
    else
      images = data.map @_feedDataToImgEl
    @_sliderFromImages images
    @$container.owlCarousel(@options.flexslider || {})

window.InstaSlider = InstaSlider
