import ElasticSearch from '../controller/elasticSearch';

export default (app) => {
  // API endpoint to check ElasticSearch Health
  app.get('/healthCheck', ElasticSearch.clusterHealth)
  // API endpoint to create ElasticSearch
  app.post('/createIndex', ElasticSearch.createIndex)
  // API endpoint to index random data into ElasticSearch
  app.get('/indexData', ElasticSearch.indexRandomData)
}