// Importerar moduler
import express from 'express';
import bodyParser from 'body-parser';
import pg from 'pg';

//*** KONFIGURERAR SERVERN OCH DATABASEN ***

// Konfigurerar Express servern
const app = express();
const port = 3000;

// GAMMAL KOD!
// Konfigurerar PostgreSQL databasen
//const db = new pg.Pool({
//  user: 'postgres',
//  host: 'localhost',
//  database: 'guestbook',
//  password: '12345',
//  port: 5432,
//});

const db = new pg.Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
});


// *** MIDDLEWARE ***

// För att kunna tolka formdata
app.use(bodyParser.urlencoded({ extended: true }));

// För att public ska användas för statiska filer 
app.use(express.static('public'));

// Så att EJS-språket kan användas
app.set('view engine', 'ejs');


// *** HANTERA FÖRFRÅGNINGAR ***

// Startsida - Visa alla meddelanden
app.get('/', async (req, res) => {
  const result = await db.query('SELECT * FROM guestbook');
  res.render("index.ejs", { guestbook: result.rows }); // Skicka datan till EJS-filen 
});

// Startsida - Hantera formulär och spara meddelande
app.post('/add', async (req, res) => {
  // Fångar det som användaren skrivit och sparar i variabler
  const name = req.body.name;
  const message = req.body.message;
  
  // Uppdaterar databasen med namn och meddelande
  await db.query('INSERT INTO guestbook (namn, meddelande) VALUES ($1, $2)', [name, message]);
  
  // Uppdaterar frontend så att användaren ser att databasen blivit uppdaterad
  res.redirect('/');
  
  // Skriver ut värdet på variablerna i konsolen (detta är frivilligt, mest för utvecklarens skull)
  console.log(name, message)
});



// ### Adminsida - endast för ägaren av webbsidan ###

// Adminsida - Visa gästboksmeddelanden
app.get('/admin', async (req, res) => {
  const result = await db.query('SELECT * FROM guestbook ORDER BY namn');
  res.render("admin.ejs", { guestbook: result.rows });
});

// Adminsida - Uppdatera gästboksmeddelanden
app.post('/update/:id', async (req, res) => {
  const id = req.params.id;
  const newMessage = req.body.newMessage;

  await db.query('UPDATE guestbook SET meddelande = $1 WHERE id = $2', [newMessage, id]);

  res.redirect('/admin');
});

// Adminsida - Radera gästboksmeddelanden
app.post('/delete/:id', async (req, res) => {
  // Hämtar id-numret för gästboksinlägget
  const id = req.params.id;
  
  // Skickar SQL-kod som raderar inlägget utifrån dess id-nr
  await db.query('DELETE FROM guestbook WHERE id = $1', [id]);
  
  // Uppdaterar sidan så att användaren ser ändringen
  res.redirect('/admin');
});



// Lyssnar efter inkommande förfrågningar från den angivna porten
app.listen(port, () => {
  console.log(`Lyssnar på port ${port}`);
});
