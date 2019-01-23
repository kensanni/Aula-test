import elasticsearch from 'elasticsearch';

const client = new elasticsearch.Client({
  host: {
    protocol: 'http',
    host: 'ec2-18-218-3-152.us-east-2.compute.amazonaws.com',
    port: 9200
  }
})

export default client;