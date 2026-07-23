import { StrictMode } from 'react'
import './style/main.scss'
import App from './App.jsx'

import { createRoot } from '@wordpress/element';

import domReady from '@wordpress/dom-ready';

domReady(() => {
    createRoot(document.getElementById('root')).render(
        <StrictMode>
            <App />
        </StrictMode>,
    )
})

