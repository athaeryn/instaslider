class InstaSlider
  constructor: (@options) ->

  run: ->
    feed = @_createInstafeed()
    feed.run()

  _createInstafeed: =>
    @options.mock = true
    @options.success = @_processFeed
    new Instafeed @options

  _createHashtagFilter: (hashtag) ->
    return (e) -> e.tags.indexOf(hashtag) > -1

  _feedDataToImgEl: (data) ->
    url = data.images.standard_resolution.url
    return $('<img>', { src: url })

  _addImageToPage: ($img) ->
    $('#instaslider').append($img)

  _processFeed: (response) =>
    data = response.data
    if @options.filter?
      hashtagFilter = @_createHashtagFilter @options.filter
      filteredData = data.filter hashtagFilter
      images = filteredData.map @_feedDataToImgEl
    else
      images = data.map @_feedDataToImgEl
    images.forEach @_addImageToPage

window.InstaSlider = InstaSlider
