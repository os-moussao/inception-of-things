const express = require('express');
// const ejs = require('ejs');

const PORT = process.env.PORT ?? 3000;

const app = express();

app.use(
  express.json(),
  express.urlencoded({ extended: false }),
  express.text(),
  express.static('public')
);

app.set('view engine', 'ejs');
app.use(express.static('public'));

app.get('', (req, res) => {
  res.render('index', {
    message: process.env.APP_MESSAGE ?? 'Hello World !',
    hostname: process.env.HOSTNAME ?? 'K8S Pod',
  });
});

app.listen(PORT, () => {
  console.log(`Application running on port ${PORT}...`);
});
