import React from 'react';
import ReactDOM from 'react-dom';
import { GuestManager } from './components/GuestManager';

document.addEventListener('DOMContentLoaded', () => {
  const eventGuestsManagerElement = document.getElementById('x-event-guests-manager');

  if (eventGuestsManagerElement) {
    ReactDOM.render(<GuestManager />, eventGuestsManagerElement);
  }
});
