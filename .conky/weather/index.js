var fetch = require('node-fetch');
var cheerio = require('cheerio');
var download = require('download');
var fs = require('fs');
var path = require('path');
var moment = require('moment');

const confileName = 'weather.conf';
const confilePath = process.env.HOME + '/.cache/weather';
const imgPath = path.join(confilePath , 'img');

fetch('https://tianqi.moji.com/weather/china/beijing/chaoyang-district')
    .then(res => res.text())
    .then(body => {
      // console.log(body);
      const $ = cheerio.load(body);
      var pm25 = $('.wea_alert').find('em').text().trim();
      //温度
      var tem = $('.wea_weather').children('em').text().trim();
      var uptime = $('.wea_weather').children('.info_uptime').text().trim().replace(/[^0-9:]/g, "");
      //天气图片
      var weather_img = $('.wea_weather').find('img').attr('src');
      var weather = $('.wea_weather').find('b').text().trim();
      //湿度
      var hum = $('.wea_about').children('span').text().trim();
      console.log(pm25, tem, hum, weather_img, weather, uptime);
      downloadIfNotExist(weather_img);
      var forecast = $('.forecast').children('ul').map((index, elem) => {
        elem = cheerio(elem);
        let firstLi = elem.children().first();
        let secondLi = firstLi.next();
        let thirdLi = secondLi.next();
        let fourthLi = thirdLi.next();
        let fifthLi = fourthLi.next();
        downloadIfNotExist(secondLi.find('img').attr('src'));
        return {
          day: firstLi.children('a').text().trim(),
          weather: secondLi.text().trim(),
          weather_img: secondLi.find('img').attr('src').split('/').slice(-1)[0],
          tem: thirdLi.text().trim(),
          wind: fourthLi.children('em').text().trim(),
          wind_level: fourthLi.children('b').text().trim(),
          pm25: fifthLi.children('strong').text().trim(),
        }
      }).toArray()
      return {
        tem: tem,
        uptime: uptime,
        weather: weather,
        weather_img: weather_img.split('/').slice(-1)[0],
        hum: hum,
        forecast: forecast
      }
    })
    .then(info => writeFile(info));
// fetch('https://tianqi.moji.com/weather/china/beijing/chaoyang-district', function(err, resp, html) {
//         if (!err){
//           const $ = cheerio.load(html);
//           console.log(html); 
//       }
// });

function downloadIfNotExist(uri) {
  let fileName = uri.split('/').slice(-1)[0];
  try {
    fs.statSync(path.join(imgPath, fileName));
    //如果可以执行到这里那么就表示存在了
  } catch(e){
    console.log('start download ', uri);
    //捕获异常
    download(uri, imgPath).then(function () {});
  }
}

function writeFile(info) {
  console.log(info);
  var txt = `t_tem=${info.tem}\n` +
    `t_uptime=${info.uptime}\n` +
    `t_weather=${info.weather}\n` +
    `t_hum=${info.hum}\n` +
    `${info.forecast[0].day}weather=${info.forecast[0].weather}\n` +
    `${info.forecast[0].day}weather_img=${info.forecast[0].weather_img}\n` +
    `${info.forecast[0].day}tem=${info.forecast[0].tem}\n` +
    `${info.forecast[0].day}wind=${info.forecast[0].wind}\n` +
    `${info.forecast[0].day}wind_level=${info.forecast[0].wind_level}\n` +
    `${info.forecast[0].day}pm25=${info.forecast[0].pm25 }\n` +
    `${info.forecast[1].day}weather=${info.forecast[1].weather}\n` +
    `${info.forecast[1].day}weather_img=${info.forecast[1].weather_img}\n` +
    `${info.forecast[1].day}tem=${info.forecast[1].tem}\n` +
    `${info.forecast[1].day}wind=${info.forecast[1].wind}\n` +
    `${info.forecast[1].day}wind_level=${info.forecast[1].wind_level}\n` +
    `${info.forecast[1].day}pm25=${info.forecast[1].pm25 }\n` +
    `${info.forecast[2].day}weather=${info.forecast[2].weather}\n` +
    `${info.forecast[2].day}weather_img=${info.forecast[2].weather_img}\n` +
    `${info.forecast[2].day}tem=${info.forecast[2].tem}\n` +
    `${info.forecast[2].day}wind=${info.forecast[2].wind}\n` +
    `${info.forecast[2].day}wind_level=${info.forecast[2].wind_level}\n` +
    `${info.forecast[2].day}pm25=${info.forecast[2].pm25 }\n`;
  try {
    var fileDate = fs.statSync(path.join(confilePath, confileName)).mtime.getTime();
  } catch (e) {
    var w_data = new Buffer(txt);
    fs.writeFile(path.join(confilePath, confileName), w_data, {flag: 'a'}, function (err) {
      if(err) {
        console.error(err);
      } else {
        console.log('写入成功');
      }
    });
  }
}
