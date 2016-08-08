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
    <div className="btn test">testeing{@props.test}</div>


window.TestForm = TestForm
