import http from 'http';
import express from 'express';
import routes from './routes';
import bodyParser from 'body-parser';


const app = express();
const port = parseInt(process.env.PORT, 10) || 8000;
const server = http.createServer(app);

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

routes(app)

app.get('*', (req, res) => {
  console.log("hello world")
});

app.set('port', port);

server.listen(port, () => {
  console.log(`Server running at http://127.0.0.1:${port}/`);
});

export default app;