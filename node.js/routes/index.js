import ElasticSearch from '../controller/elasticSearch';

export default (app) => {
  app.get('/healthCheck', ElasticSearch.clusterHealth)
  app.post('/createIndex', ElasticSearch.createIndex)
}