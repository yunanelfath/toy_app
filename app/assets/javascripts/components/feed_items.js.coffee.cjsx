FeedItems = React.createClass
  propTypes:
    items: React.PropTypes.string

  getInitialState: ->
    {
      items: @props.items
    }

  componentDidMount: ->

  onClickInfo: (value)->
    debugger
    alert(value.author)

  render: ->
    { items } = @props
    { onClickInfo } = @

    itemComponent = (index) =>
      key = Object.keys(index)
      item = index[key.toString()]
      <li className="#{key.toString()}" onClick={onClickInfo.bind(@, item)}>{item.title}</li>

    <div className="btn test">
      <ul style={textAlign: 'left'}>
        {items.map(itemComponent)}
      </ul>
    </div>


window.FeedItems = FeedItems
