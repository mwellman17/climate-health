import React from 'react';
import { Router, Route, browserHistory, IndexRoute } from 'react-router';
import { createBrowserHistory } from 'history'
import HomePage from './HomePage'

const App = props => {
  return(

  <Router history={browserHistory}>
    <Route path='/' component={HomePage} />
  </Router>

  )
}

export default App
