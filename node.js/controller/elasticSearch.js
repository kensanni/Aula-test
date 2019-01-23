import elasticsearch from 'elasticsearch';

const client = new elasticsearch.Client({
  host: {
    protocol: 'http',
    host: 'ec2-52-15-233-199.us-east-2.compute.amazonaws.com',
    port: 9200
  }
})


class ElasticSearch {
  static clusterHealth(req, res) {
    client.cluster.health({}, (err,resp,status) => {  
      console.log("-- Client Health --",resp, status);
    });
  }

  static createIndex(req, res) {
      const { indexName } = req.body;
      return client.indices
        .create({
          index: req.body.indexName
        })
        .then(index => res.status(201).send({
          index: index
        }))
        .catch(err => res.status(400).send(err))
  }
}


export default ElasticSearch