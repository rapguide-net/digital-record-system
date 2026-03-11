import React, { useState, useEffect } from 'react';
import './ProfileSidebar.css';

const ProfileSidebar = () => {
  // State to manage dropdown visibility
  const [isOpen, setIsOpen] = useState(false);
  const [userData, setUserData] = useState({
    username: "Guest",
    userId: "#0000",
    avatar: "assets/img/user.png"
  });

  // Effect to load data from sessionStorage on mount
  useEffect(() => {
    const loggedIn = sessionStorage.getItem('isLoggedIn');
    if (loggedIn === 'true') {
      setUserData({
        username: sessionStorage.getItem('activeUser') || "User",
        userId: sessionStorage.getItem('userId') || "#1024",
        avatar: "assets/img/user.png"
      });
    }
  }, []);

  const handleLogout = () => {
    sessionStorage.clear();
    window.location.href = "/";
  };

  return (
    <div className="sidebar-profile">
      {/* Profile Trigger */}
      <div className="profile-toggle" onClick={() => setIsOpen(!isOpen)}>
        <div className="profile-avatar">
          <img src={userData.avatar} alt="Profile" />
        </div>
        <div className="user-meta">
          <span className="display-username">{userData.username}</span>
          <small className="display-userid">ID: {userData.userId}</small>
        </div>
        <span className={`dropdown-icon ${isOpen ? 'rotate' : ''}`}>▼</span>
      </div>

      {/* Conditional Rendering for Dropdown */}
      {isOpen && (
        <div className="profile-links">
          <div className="dropdown-header">Account Actions</div>
          <a href="/records"><i className="fas fa-database"></i> Data Records</a>
          <a href="/settings"><i className="fas fa-cog"></i> Settings</a>
          <hr className="dropdown-divider" />
          <button onClick={handleLogout} className="logout-btn">
            <i className="fas fa-sign-out-alt"></i> Logout
          </button>
        </div>
      )}
    </div>
  );
};

export default ProfileSidebar;