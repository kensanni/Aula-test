import client from '../helpers/esConnection';

const bulk = [];

// Loop through the datasets and add it to the bulk array
export const makebulk = (constituencylist, callback) => {
  for (let current in constituencylist) {
    bulk.push(
      { index: {_index: 'gov', _type: 'constituencies', _id: constituencylist[current].PANO } },
      {
        'constituencyname': constituencylist[current].ConstituencyName,
        'constituencyID': constituencylist[current].ConstituencyID,
        'constituencytype': constituencylist[current].ConstituencyType,
        'electorate': constituencylist[current].Electorate,
        'validvotes': constituencylist[current].ValidVotes,
        'regionID': constituencylist[current].RegionID,
        'county': constituencylist[current].County,
        'region': constituencylist[current].Region,
        'country': constituencylist[current].Country
      }
    );
  }
  callback(bulk);
}
// Use Elasticserch’s bulk method to import the data to elasticSearch cluster
export const indexall = (madebulk, callback) => {
  client.bulk({
    maxRetries: 5,
    index: 'gov',
    type: 'constituencies',
    body: madebulk,
  }, (err, res, status) => {
    if (err) {
      console.log(err);
    }
    else {
       callback(res.items);
    }
  });
}