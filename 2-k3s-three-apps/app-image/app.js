const express = require('express');

// this is for docker stop to exit immediately
exitOn('SIGINT', 'SIGABRT', 'SIGTERM');

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
    pod: process.env.HOSTNAME ?? 'K8S Pod Name',
    node: process.env.NODE_INFO ?? 'K8S Node Info',
  });
});

app.listen(PORT, () => {
  console.log(`Application running on port ${PORT}...`);
});

function exitOn(...signals) {
  signals.forEach((signal) => {
    process.on(signal, () => {
      console.log('process exists on', signal);
      process.exit(1);
    });
  });
}
