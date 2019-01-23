import ElasticSearch from '../controller/elasticSearch';

export default (app) => {
  // API endpoint to check ElasticSearch Health
  app.get('/api/healthCheck', ElasticSearch.clusterHealth)
  // API endpoint to create ElasticSearch
  app.post('/api/createIndex', ElasticSearch.createIndex)
  // API endpoint to index random data into ElasticSearch
  app.get('/api/indexData', ElasticSearch.indexRandomData)
}