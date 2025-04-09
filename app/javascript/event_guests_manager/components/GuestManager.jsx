import React, { useState, useEffect } from 'react';

export const GuestManager = () => {
  const [guests, setGuests]   = useState([]);
  const [name, setName]       = useState('');
  const [email, setEmail]     = useState('');
  const [errors, setErrors]   = useState({});
  const [loading, setLoading] = useState(true);

  const eventId = window.location.pathname.split('/').pop();

  useEffect(() => {
    fetchGuests();
  }, []);

  // Fetch guests from the server
  const fetchGuests = async () => {
    try {
      const response = await fetch(`/events/${eventId}.json`);
      const data = await response.json();
      setGuests(data.guests || []);
    } catch (error) {
      console.error('Error fetching guests:', error);
    } finally {
      setLoading(false);
    }
  };

  // Handle form submission to add a new guest
  const handleSubmit = async (e) => {
    e.preventDefault();
    setErrors({});

    const newErrors = {};
    if (!name.trim()) newErrors.name = 'Name is required';
    if (!email.trim()) newErrors.email = 'Email is required';
    else if (!/\S+@\S+\.\S+/.test(email)) newErrors.email = 'Email is invalid';

    if (Object.keys(newErrors).length > 0) {
      setErrors(newErrors);
      return;
    }

    try {
      const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      const response = await fetch(`/events/${eventId}/guests`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-CSRF-Token': token,
        },
        body: JSON.stringify({ guest: { name, email } }),
      });

      if (response.ok) {
        const contentType = response.headers.get('Content-Type');
        if (contentType && contentType.includes('application/json')) {
          const newGuest = await response.json();
          setGuests([...guests, newGuest]);
          setName('');
          setEmail('');
        } else {
          // Handle non-JSON response
          console.log('Response is not JSON, refreshing guest list');
          await fetchGuests();
          setName('');
          setEmail('');
        }
      } else {
        // Handle error response
        if (response.headers.get('Content-Type')?.includes('application/json')) {
          const data = await response.json();
          setErrors(data);
        } else {
          setErrors({ general: 'An error occurred while adding the guest' });
        }
      }
    } catch (error) {
      console.error('Error adding guest:', error);
      setErrors({ general: 'An error occurred while adding the guest' });
    }
  };

  // Handle guest removal
  const handleRemove = async (guestId) => {
    try {
      const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      const response = await fetch(`/guests/${guestId}`, {
        method: 'DELETE',
        headers: {
          'Accept': 'application/json',
          'X-CSRF-Token': token,
        },
      });

      if (response.ok) {
        setGuests(guests.filter(guest => guest.id !== guestId));
      }
    } catch (error) {
      console.error('Error removing guest:', error);
    }
  };

  if (loading) {
    return <div>Loading guest list...</div>;
  }

  // Render the component
  return (
    <div className="guest-manager">
      <div className="guest-form">
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="name">Name</label>
            <input
              type="text"
              id="name"
              value={name}
              onChange={(e) => setName(e.target.value)}
              className={errors.name ? 'error' : ''}
              aria-describedby={errors.name ? 'name-error' : undefined}
            />
            {errors.name && <div id="name-error" className="error-message">{errors.name}</div>}
          </div>

          <div className="form-group">
            <label htmlFor="email">Email</label>
            <input
              type="email"
              id="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className={errors.email ? 'error' : ''}
              aria-describedby={errors.email ? 'email-error' : undefined}
            />
            {errors.email && <div id="email-error" className="error-message">{errors.email}</div>}
          </div>

          {errors.general && <div className="error-message">{errors.general}</div>}

          <button type="submit" className="button">Add Guest</button>
        </form>
      </div>

      {/* Guest list display section */}
      <div className="guest-list">
        <h3>Guest List</h3>
        {guests.length === 0 ? (
          <p>No guests yet</p>
        ) : (
          <ul>
            {guests.map((guest) => (
              <li key={guest.id} className="guest-item">
                <div className="guest-info">
                  <div className="guest-name">{guest.name}</div>
                  <div className="guest-email">{guest.email}</div>
                </div>
                <button
                  type="button"
                  className="remove-button"
                  onClick={() => handleRemove(guest.id)}
                  aria-label={`Remove ${guest.name}`}
                >
                  Remove
                </button>
              </li>
            ))}
          </ul>
        )}
      </div>
    </div>
  );
};
