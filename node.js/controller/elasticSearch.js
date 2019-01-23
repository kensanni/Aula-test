import client from '../helpers/esConnection';
import { makebulk, indexall } from '../mockData/constituencies';
import datasets from '../mockData/constituencies.json';

 /**
 * @class ElasticSearch
 */
class ElasticSearch {
  /**
   * @description Check cluster Health
   *
   * @param {object} req HTTP request object
   * @param {object} res   HTTP response object
   *
   * @returns {object} returns a JSON object
   */
  static clusterHealth(req, res) {
    return client.cluster
      .health({}, (err, resp) => {
        res.send({
          ClusterHealth: resp
        })
      })
  }

  /**
   * @description Create ElasticSearch Index
   *
   * @param {object} req HTTP request object
   * @param {object} res   HTTP response object
   *
   * @returns {object} returns a JSON object
   */
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

  /**
   * @description Add random sample data to elasticSearch
   *
   * @param {object} req HTTP request object
   * @param {object} res   HTTP response object
   *
   * @returns {object} returns a JSON object
   */
  static indexRandomData(req, res) {
    makebulk(datasets, (response) => {
      indexall(response, (response) => {
        res.json({
          status: false,
          data: response
        })
      })
    });
  }
}


export default ElasticSearch