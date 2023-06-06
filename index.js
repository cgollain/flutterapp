const express = require('express');
const app = express();

const dummyData1 = [
  { x: 0, y: 0 },
  { x: 1, y: 1 },
  { x: 2, y: 4 },
  { x: 3, y: 5 }
];

const dummyData2 = [
  { x: 0, y: 0 },
  { x: 1, y: 2 },
  { x: 2, y: 3 },
  { x: 3, y: 6 }
];

const dummyData3 = [
  { x: 0, y: 0 },
  { x: 1, y: 1 },
  { x: 2, y: 2 },
  { x: 3, y: 3 }
];

app.get('/', (req, res) => {
  const data = {
    dummyData1: dummyData1,
    dummyData2: dummyData2,
    dummyData3: dummyData3
  };

  res.json(data);
});


app.listen(3000, () => {
  console.log('L\'API est en écoute sur le port 3000');
});
