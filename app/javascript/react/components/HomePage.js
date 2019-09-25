import React, { Component } from 'react'
import {Hint, Sankey} from 'react-vis'

class HomePage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      nodes: [],
      links: [],
      hint: null
    }
    this.createHint = this.createHint.bind(this)
    this.hideHint = this.hideHint.bind(this)
  }

  componentDidMount() {
    fetch('/api/v1/sankey', { credentials: 'same-origin' })
    .then(response => {
      if (response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText})`,
            error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => {
      return response.json();
    })
    .then(body => {
      this.setState({ nodes: body.nodes, links: body.links })
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }

  createHint(data) {
    this.setState({ hint: data })
  }

  hideHint(data) {
    this.setState({ hint: null })
  }

  getXy(data) {
    let s = data.source
    let t = data.target
    let x = (s.x0 + s.x1 + t.x0 + t.x1) / 4
    let y = (s.y0 + s.y1 + t.y0 + t.y1) / 4
    return [x, y]
  }

  render() {

    let hint
    if (this.state.hint) {
      let data = this.state.hint
      if (data.source) {
        let xy = this.getXy(data)
        let dataStyle = {
          width: `${data.value.toString()}%`
        }
        hint = (
          <Hint
            x={xy[0]}
            y={xy[1]}
            value={data}
          >
            <div className="link-hint horizontal rounded">
              <p>
                {data.source.full_name}
                <br/>
                <i class="fas fa-arrow-down"></i>
                <br/>
                {data.target.full_name}
              </p>
                <div className="progress-bar horizontal">
                <span>Betavalue:</span>
                  <div className="progress-track">
                    <div className="progress-fill" style={dataStyle}>
                      <span>{`${data.value}%`}</span>
                  </div>
                </div>
              </div>
            </div>
          </Hint>

        )
      } else {
        hint = (
          <Hint
          x={data.x}
          y={data.y}
          value={data}
          >
          <div className="node-hint">
          <p className="node-header">{data.full_name}</p>
          <p>
            {`Category: ${data.category}`}
            <br/>{`Topics: ${data.topic}`}
            <br/>{`Patients: ${data.patient}`}
            <br/>{`Diseases: ${data.disease}`}
          </p>
          </div>
          </Hint>
        )
      }
    }

    return(
      <div>
        <Sankey
          nodes={this.state.nodes}
          links={this.state.links}
          width={1250}
          height={550}
          nodePadding={24}
          layout={1000}
          hideLabels={false}
          style={{
            labels: {
              fontSize: '7pt',
              fontWeight: 'bold'
            }
          }}
          onValueMouseOver={(datapoint, event)=>{
            this.createHint(datapoint)
          }}
          onValueMouseOut={()=>{
            this.hideHint()
          }}
          onLinkMouseOver={(datapoint, event)=>{
            this.createHint(datapoint)
          }}
          onLinkMouseOut={()=>{
            this.hideHint()
          }}
        >
        {hint}
        </Sankey>
      </div>
    )
  }
}

export default HomePage;
