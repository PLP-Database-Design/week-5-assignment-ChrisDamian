Database Configuration and Connection First, set up the MySQL connection in server.js using the credentials from .env.

js
Copy code
const mysql = require('mysql2')
const dotenv = require('dotenv')

// Load .env configuration
dotenv.config()

// Create MySQL connection
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
})

// Connect to the database
db.connect((err) => {
  if (err) {
    console.error('Error connecting to the database:', err)
    return
  }
  console.log('Connected to the MySQL database')
})

// Middleware to parse JSON
app.use(express.json())
Implementing the Questions
Retrieve All Patients (Question 1) Create a GET endpoint to retrieve and display all patients:

js
Copy code
app.get('/patients', (req, res) => {
  const query = 'SELECT patient_id, first_name, last_name, date_of_birth FROM patients'
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching patients:', err)
      return res.status(500).send('Server Error')
    }
    res.json(results)
  })
})
Retrieve All Providers (Question 2) Create a GET endpoint to retrieve and display all providers:

js
Copy code
app.get('/providers', (req, res) => {
  const query = 'SELECT first_name, last_name, provider_specialty FROM providers'
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching providers:', err)
      return res.status(500).send('Server Error')
    }
    res.json(results)
  })
})
Filter Patients by First Name (Question 3) Create a GET endpoint to filter patients by their first name using query parameters:

js
Copy code
app.get('/patients/filter', (req, res) => {
  const { first_name } = req.query
  if (!first_name) {
    return res.status(400).send('First name is required')
  }
  const query = 'SELECT * FROM patients WHERE first_name = ?'
  db.query(query, [first_name], (err, results) => {
    if (err) {
      console.error('Error filtering patients:', err)
      return res.status(500).send('Server Error')
    }
    res.json(results)
  })
})
Retrieve Providers by Specialty (Question 4) Create a GET endpoint to retrieve providers by their specialty:

js
Copy code
app.get('/providers/specialty', (req, res) => {
  const { provider_specialty } = req.query
  if (!provider_specialty) {
    return res.status(400).send('Provider specialty is required')
  }
  const query = 'SELECT * FROM providers WHERE provider_specialty = ?'
  db.query(query, [provider_specialty], (err, results) => {
    if (err) {
      console.error('Error fetching providers by specialty:', err)
      return res.status(500).send('Server Error')
    }
    res.json(results)
  })
})
Run the Application
Start the server using the following command:

bash
Copy code
nodemon server.js
