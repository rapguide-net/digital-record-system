-- Create the database
CREATE DATABASE IF NOT EXISTS web_design_records;
USE web_design_records;

-- Table for team members (users)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255) NOT NULL, -- In a real app, store hashed passwords
    name VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    image_path VARCHAR(255), -- Path to profile image
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data for team members (based on the HTML)
INSERT INTO users (username, email, password, name, role, image_path, bio) VALUES
('jean', 'jean@example.com', 'admin1', 'Jean Bundalian III', 'Research Writer', 'assets/images/team/Jean Bundalian III.jpg', 'Responsible for research and documentation.'),
('ashly', 'ashly@example.com', 'admin2', 'Ashly Montalvo', 'Capstone Project Leader', 'assets/images/team/Ashly Montalvo.jpg', 'Leads the project development.'),
('rashmir', 'rashmir@example.com', 'admin3', 'Rashmir Gemoto', 'Developer & Author', 'assets/images/team/Rashmir Gemoto.jpg', 'Handles coding and authoring.'),
('eduard', 'eduard@example.com', 'admin4', 'Eduard Damaso', 'Member', 'assets/images/team/Eduard Damaso.jpg', 'Contributes to project tasks.'),
('jaynard', 'jaynard@example.com', 'admin5', 'Jaynard Andaya', 'Member', 'assets/images/team/Jaynard Andaya.jpg', 'Assists in various project aspects.');

-- Table for features (based on HTML Features section)
CREATE TABLE features (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    icon_class VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO features (title, description, icon_class) VALUES
('Advanced Diagnostics', 'Utilize AI-powered tools for precise issue identification and instant solutions.', 'fas fa-search-plus'),
('Comprehensive Database', 'Access an extensive library of fixes, tutorials, and maintenance guides.', 'fas fa-cogs'),
('Collaborative Platform', 'Connect with experts and peers for shared knowledge and support.', 'fas fa-users'),
('Easy to Use', 'Using the app in a proper way that will help you to become a complete css student.', 'fas fa-pen'),
('Record System', 'Allows you to view your previous records using the app.', 'fas fa-signal'),
('Pre Assessment', 'Take a quiz/pre-test to test your knowledge about CSS.', 'fas fa-file');

-- Table for projects (web design projects recorded in the system)
CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    image_path VARCHAR(255), -- Path to project image
    status ENUM('draft', 'published', 'archived') DEFAULT 'draft',
    created_by INT, -- Foreign key to users.id
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Insert sample projects (based on features/portfolio in HTML)
INSERT INTO projects (title, description, image_path, status, created_by) VALUES
('E-Commerce Website', 'A responsive e-commerce site with modern UI/UX design.', 'assets/images/project1.jpg', 'published', 3),
('Portfolio Template', 'A customizable portfolio template for designers.', 'assets/images/project2.jpg', 'published', 3),
('Blog Platform', 'A dynamic blog platform with interactive features.', 'assets/images/project3.jpg', 'draft', 2);

-- Table for tutorials (based on HTML Tutorial section)
CREATE TABLE tutorials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    video_link VARCHAR(255),
    icon_class VARCHAR(50),
    category ENUM('hardware', 'software', 'safety', 'general') DEFAULT 'general',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample tutorials (based on HTML)
INSERT INTO tutorials (title, video_link, icon_class, category) VALUES
('Networking Step by Step', '#VIDEO_ID', 'fas fa-network-wired', 'general'),
('Computer - Components', '#VIDEO_ID', 'fas fa-laptop', 'hardware'),
('PPE - Personal Protective Equipment ', '#VIDEO_ID', 'fas fa-tools', 'safety');

-- Table for downloads/publications (to track app downloads or publications)
CREATE TABLE downloads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(255) NOT NULL, -- Path to downloadable file
    description TEXT,
    is_published BOOLEAN DEFAULT FALSE, -- Flag for publication status
    uploaded_by INT, -- Foreign key to users.id
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Insert sample download (for the app mentioned in HTML)
INSERT INTO downloads (file_name, file_path, description, is_published, uploaded_by) VALUES
('Web Designing Record System App', 'assets/downloads/app.zip', 'The full application for recording web design projects.', FALSE, 3);

-- Table for logs (to record system activities, e.g., project views, downloads)
CREATE TABLE activity_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT, -- Foreign key to users.id (nullable for anonymous)
    action VARCHAR(255) NOT NULL, -- e.g., 'viewed_project', 'downloaded_app'
    details TEXT,
    ip_address VARCHAR(45),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

--Log entry
INSERT INTO activity_logs (user_id, action, details) VALUES
(3, 'downloaded_app', 'Attempted download of Web Designing Record System App.');

-- Table for Quiz Questions (for quiz.html)
CREATE TABLE quiz_questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_text TEXT NOT NULL,
    option_a VARCHAR(255) NOT NULL,
    option_b VARCHAR(255) NOT NULL,
    option_c VARCHAR(255) NOT NULL,
    option_d VARCHAR(255) NOT NULL,
    correct_option CHAR(1) NOT NULL, -- 'A', 'B', 'C', or 'D'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert quiz questions (based on Computer System Servicing context)
INSERT INTO quiz_questions (question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
('What does IP stand for in networking?', 'Internet Protocol', 'Internal Processor', 'Integrated Port', 'Instant Packet', 'A'),
('Which device is used to connect multiple computers in a local area network (LAN)?', 'Router', 'Switch', 'Modem', 'Firewall', 'B'),
('What is the primary function of a subnet mask?', 'To encrypt data', 'To divide an IP address into network and host portions', 'To assign IP addresses automatically', 'To block unauthorized access', 'B'),
('Which protocol is commonly used for secure web browsing?', 'HTTP', 'FTP', 'HTTPS', 'SMTP', 'C'),
('In a wireless network, what does SSID stand for?', 'Secure System Identifier', 'Service Set Identifier', 'Simple Signal Indicator', 'Standard Security Interface', 'B'),
('What is the first step in troubleshooting a computer that won''t boot?', 'Replace the hard drive', 'Check power connections and cables', 'Run a virus scan', 'Update the operating system', 'B'),
('Which tool is essential for diagnosing hardware issues like faulty RAM?', 'Antivirus software', 'Multimeter', 'Diagnostic software (e.g., MemTest)', 'Web browser', 'C'),
('If a computer is overheating, what should you check first?', 'The monitor resolution', 'The CPU fan and vents for dust', 'The network settings', 'The keyboard layout', 'B'),
('What does a "blue screen of death" (BSOD) typically indicate?', 'A successful system update', 'A hardware or driver failure', 'A full hard drive', 'A network disconnection', 'B'),
('When troubleshooting slow internet, what should you test first?', 'The router''s firmware', 'The speed using an online tool', 'The computer''s antivirus', 'The monitor''s refresh rate', 'B'),
('What is the primary purpose of wearing an anti-static wrist strap during computer servicing?', 'To prevent cuts from sharp edges', 'To ground static electricity and protect components', 'To block electromagnetic interference', 'To improve grip on tools', 'B'),
('Which PPE item should be worn to protect eyes from dust or debris when opening a computer case?', 'Gloves', 'Safety goggles', 'Earplugs', 'Hard hat', 'B'),
('Why is it important to use insulated tools when working with electrical components?', 'To reduce tool weight', 'To prevent electric shock', 'To improve precision', 'To avoid tool rust', 'B'),
('What should you do if you spill liquid on a computer component?', 'Immediately power it on to dry it', 'Use a hairdryer to blow it dry', 'Unplug and let it air dry, then inspect for damage', 'Wipe it with a cloth and continue working', 'C'),
('Which of the following is NOT a standard PPE for computer servicing?', 'Anti-static mat', 'Safety glasses', 'Steel-toed boots', 'ESD-safe gloves', 'C'),
('What is the first component you should install when building a PC?', 'Graphics card', 'Motherboard in the case', 'Power supply', 'RAM modules', 'B'),
('Which tool is typically used to secure components like the motherboard to the case?', 'Screwdriver', 'Pliers', 'Hammer', 'Wrench', 'A'),
('When installing an operating system, what is the minimum requirement for most modern OSes?', '2GB RAM', '4GB RAM', '8GB RAM', '16GB RAM', 'B'),
('What should you do after connecting all cables to ensure proper set-up?', 'Run a benchmark test', 'Double-check connections and power on for POST (Power-On Self-Test)', 'Install antivirus software immediately', 'Update the BIOS', 'B'),
('Which peripheral is essential for initial computer set-up and troubleshooting?', 'Printer', 'Keyboard and mouse', 'Webcam', 'External hard drive', 'B');

-- Table for User Quiz Attempts
CREATE TABLE user_quiz_attempts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    score INT,
    total_questions INT,
    attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Optional: Create indexes for better performance
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_downloads_published ON downloads(is_published);
CREATE INDEX idx_logs_timestamp ON activity_logs(timestamp);