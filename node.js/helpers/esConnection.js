import elasticsearch from 'elasticsearch';

const client = new elasticsearch.Client({
  host: {
    protocol: 'http',
    host: 'ec2-52-15-233-199.us-east-2.compute.amazonaws.com',
    port: 9200
  }
})

export default client;