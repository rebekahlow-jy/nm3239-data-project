$(document).ready(function() {
  fetchData(function(csvArray) {
    let dataArray = processData(csvArray);

    let marriageRateByAgeData = {
      "15-19": [],
      "20-24": [],
      "25-29": [],
      "30-34": [],
      "35-39": [],
      "40-44": [],
      "45-49": []
    };
    // Use Female Array Size to Loop (Same as Male Array)
    for (let i = 0; i < dataArray[1].length; i++) {
      let x = parseFloat(dataArray[1][i].year);
      let y = (parseFloat(dataArray[1][i].value) + parseFloat(dataArray[3][i].value)) / 2;
      let dataPoint = [x, y];
      let ageGroup = dataArray[1][i].level_2;
      switch (ageGroup) {
        case "15 - 19 Years":
          marriageRateByAgeData["15-19"].push(dataPoint);
          break;
        case "20 - 24 Years":
          marriageRateByAgeData["20-24"].push(dataPoint);
          break;
        case "25 - 29 Years":
          marriageRateByAgeData["25-29"].push(dataPoint);
          break;
        case "30 - 34 Years":
          marriageRateByAgeData["30-34"].push(dataPoint);
          break;
        case "35 - 39 Years":
          marriageRateByAgeData["35-39"].push(dataPoint);
          break;
        case "40 - 44 Years":
          marriageRateByAgeData["40-44"].push(dataPoint);
          break;
        case "45 - 49 Years":
          marriageRateByAgeData["45-49"].push(dataPoint);
          break;
        default:
          console.log("Error: Age group not found.")
      }
    }

    let flatsConstructedRateData = [];
    for (let i = 0; i < dataArray[5].length; i++) {
      let x = parseFloat(dataArray[5][i].year);
      let y = parseFloat(dataArray[5][i].flats_constructed);
      let dataPoint = [x, y];
      flatsConstructedRateData.push(dataPoint);
    }

    createMarriageRateChartByAge(marriageRateByAgeData);
    createFlatsConstructedRateChart(flatsConstructedRateData)
    createMixedMarriageFlatsRateChart(marriageRateByAgeData, flatsConstructedRateData)
  });
});

function createMixedMarriageFlatsRateChart(marriageRateByAgeData, flatsConstructedRateData) {
  let mixedChartOptions = {
    chart: {
      alignTicks: false,
      type: 'line',
      renderTo: 'mixed-marriage-flats-rate-chart'
    },
    title: {
      text: 'Marriage and Flat Construction Rate'
    },
    subtitle: {
      text: 'Source: data.gov.sg'
    },
    yAxis: [{
      title: {
        text: 'Per 1,000 Residents'
      }
    }, {
      title: {
        text: 'Number of Flats'
      },
      gridLineWidth: 0,
      opposite: true
    }],
    xAxis: {
      tickInterval: 10,
      title: {
        text: 'Years'
      }
    },
    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'middle'
    },
    series: [{
      name: '15-19',
      data: marriageRateByAgeData["15-19"]
    }, {
      name: '20-24',
      data: marriageRateByAgeData["20-24"]
    }, {
      name: '25-29',
      data: marriageRateByAgeData["25-29"]
    }, {
      name: '30-34',
      data: marriageRateByAgeData["30-34"]
    }, {
      name: '35-39',
      data: marriageRateByAgeData["35-39"]
    }, {
      name: '40-44',
      data: marriageRateByAgeData["40-44"]
    }, {
      name: '45-49',
      data: marriageRateByAgeData["45-49"]
    }, {
      name: 'Flats Constructed',
      data: flatsConstructedRateData,
      yAxis: 1
    }]
  };
  let mixedChart = new Highcharts.Chart(mixedChartOptions);
}

function createFlatsConstructedRateChart(flatsConstructedRateData) {
  let chartOptions = {
    chart: {
      renderTo: 'flats-constructed-rate-chart'
    },
    title: {
      text: 'Flat Construction Rate'
    },
    subtitle: {
      text: 'Source: data.gov.sg'
    },
    yAxis: {
      title: {
        text: 'Number of Flats'
      }
    },
    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'middle'
    },
    series: [{
      name: 'Flats Constructed',
      data: flatsConstructedRateData
    }]
  };
  let chart = new Highcharts.Chart(chartOptions);
}

function createMarriageRateChartByAge(marriageRateByAgeData) {
  let chartOptions = {
    chart: {
      renderTo: 'marriage-rate-by-age-chart'
    },
    title: {
      text: 'Marriage Rate by Age'
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
      name: '15-19',
      data: marriageRateByAgeData["15-19"]
    }, {
      name: '20-24',
      data: marriageRateByAgeData["20-24"]
    }, {
      name: '25-29',
      data: marriageRateByAgeData["25-29"]
    }, {
      name: '30-34',
      data: marriageRateByAgeData["30-34"]
    }, {
      name: '35-39',
      data: marriageRateByAgeData["35-39"]
    }, {
      name: '40-44',
      data: marriageRateByAgeData["40-44"]
    }, {
      name: '45-49',
      data: marriageRateByAgeData["45-49"]
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
    dataArray[i] = $.csv.toObjects(csvArray[i]);
  }
  return dataArray;
}
