FeedItems = React.createClass
  propTypes:
    items: React.PropTypes.array
    limit: React.PropTypes.number
    page: React.PropTypes.number

  getInitialState: ->
    {
      items: @props.items
      page: @props.page
      requesting: false
      completed: false
    }

  componentDidMount: ->
    $(window).on('scroll', $.proxy(@recordScroll, @))

  componentWillReceiveProps: (newProps) ->
    { limit } = @props
    { items, page } = @state

    if items.length > 0 && newProps.items.length > 0
      for item in newProps.items
        items.push(item)
    @setState(items: items, page: newProps.page, requesting: newProps.requesting)

  recordScroll: (event) ->
    _this = @
    elementUl = $(ReactDOM.findDOMNode(this)).find('ul')
    getLoadFeeds = _.debounce((event) =>
      unless _this.state.requesting
        nextPage = _this.state.page + 1
        $.ajax
          url: Routes.feeds_path({format: 'js',limit: _this.props.limit, page: nextPage})
          dataType: 'json'
          beforeSend: =>
            _this.setState(requesting: true)
          success: ((data)=>
            if data
              _this.componentWillReceiveProps({items: data, page: nextPage, requesting: false})
            else
              alert('data completed') #stop ajax if is loaded all
              _this.setState(completed: true)
          )
    ,800)

    # console.log scrollY: event.currentTarget.scrollY, maxY: (event.currentTarget.scrollMaxY - 100)
    bottomLimit = if event.currentTarget.scrollMaxY == undefined then elementUl.outerHeight() else event.currentTarget.scrollMaxY
    bottomLimit = bottomLimit - 550
    scrollTop = if event.currentTarget.document.documentElement.scrollTop then event.currentTarget.document.documentElement.scrollTop else event.currentTarget.scrollY # IE 9 condition
    console.log "scrollY: "+scrollTop+",  bottomLmit:" +bottomLimit # for ie
    # console.log scrollY: event.currentTarget.scrollY, maxY: (bottomLimit - 250)
    if scrollTop > bottomLimit
      getLoadFeeds(event)
      console.log elementUl.outerHeight()
      console.log _this.state.items.length

  onClickInfo: (value)->
    alert(value?.author)

  render: ->
    { limit } = @props
    { items, page, requesting, completed } = @state
    { onClickInfo } = @

    itemComponent = (index) =>
      key = Object.keys(index)
      item = index[key.toString()]
      if key.toString() == 'ad'
        <li className="#{key.toString()}" onClick={onClickInfo.bind(@, item)}>{item.content}</li>
      else
        <li className="#{key.toString()}" onClick={onClickInfo.bind(@, item)}>{item.title}</li>

    <div className="btn test">
      <ul style={textAlign: 'left', display: 'inline-block', padding: 0}>
        {items.map(itemComponent)}
      </ul>
      <div>
        {
          if requesting && completed == false
            "Loading ....!"
        }
      </div>
    </div>


window.FeedItems = FeedItems
