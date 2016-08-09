TestForm = React.createClass
  propTypes:
    test: React.PropTypes.string

  getDefaultProps: ->
    {
      test: 'hallo'
    }

  getInitialState: ->
    {
      me: 'well'
    }

  componentDidMount: ->

  render: ->
    <div className="btn test">
      <ul>
        <li>menu 1</li>
        <li>menu 2</li>
        <li>menu 3</li>
        <li>menu 4</li>
      </ul>
    </div>


window.TestForm = TestForm
