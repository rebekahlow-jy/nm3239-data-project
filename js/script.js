$(document).ready(function() {
  fetchData(function(csvArray) {
    let dataArray = processData(csvArray);
    createCrudeMarriageRateChart(dataArray[0]);
  });
});

function createCrudeMarriageRateChart(crudeMarriageRateArray) {
  let crudeMarriageRateData = [];
  // Start from 1990 instead of 1980
  for (let i = 10; i < crudeMarriageRateArray.length; i++) {
    let x = parseFloat(crudeMarriageRateArray[i].year);
    let y = parseFloat(crudeMarriageRateArray[i].value);
    let dataPoint = [x, y];
    crudeMarriageRateData.push(dataPoint);
  }
  console.log(crudeMarriageRateData);
  let chartOptions = {
    chart: {
      renderTo: 'crude-marriage-rate-chart'
    },
    title: {
      text: 'Crude Marriage Rate'
    },
    subtitle: {
      text: 'Source: data.gov.sg'
    },
    yAxis: {
      title: {
        text: 'Per 1,000 Residents'
      }
    },
    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'middle'
    },
    series: [{
      name: 'Marriage Rate',
      data: crudeMarriageRateData
    }]
  };
  let chart = new Highcharts.Chart(chartOptions);
}

function fetchData(callback) {
  let requests = [];
  requests.push($.get("../csv/crude-marriage-rate.csv"));
  requests.push($.get("../csv/female-age-specific-marriage-rate.csv"));
  requests.push($.get("../csv/female-general-marriage-rate.csv"));
  requests.push($.get("../csv/male-age-specific-marriage-rate.csv"));
  requests.push($.get("../csv/male-general-marriage-rate.csv"));
  requests.push($.get("../csv/flats-constructed-by-housing-and-development-board-annual.csv"));

  $.when.apply($, requests).then(function () {
    let csvArray = $.map(arguments, function (arg) {
      return arg[0];
    });
    callback(csvArray);
  })
}

function processData(csvArray) {
  let dataArray = [];
  for (let i = 0; i < csvArray.length; i++) {
    // dataArray[0]: crudeMarriageRateArray
    // dataArray[1]: femaleAgeSpecificMarriageRateArray
    // dataArray[2]: femaleGeneralMarriageRateArray
    // dataArray[3]: maleAgeSpecificMarriageRateArray
    // dataArray[4]: maleGeneralMarriageRateArray
    // dataArray[5]: flatsConstructedRateArray
    dataArray[i] = $.csv.toObjects(csvArray[i]);
  }
  return dataArray;
}
