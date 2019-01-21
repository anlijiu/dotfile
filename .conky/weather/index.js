var fetch = require('node-fetch');
var cheerio = require('cheerio');
var download = require('download');
var fs = require('fs');
var path = require('path');
var moment = require('moment');
var shell = require('shelljs');

const confileName = 'weather.conf';
const confilePath = process.env.HOME + '/.cache/weather';
const imgPath = path.join(confilePath , 'img');
const pm25ImgPath = path.join(imgPath, 'pm25');

fetch('https://tianqi.moji.com/weather/china/beijing/chaoyang-district')
    .then(res => res.text())
    .then(body => {
      // console.log(body);
      const $ = cheerio.load(body);
      var pm25Elem = $('.wea_alert').find('em').first();
      var pm25ImgElem = $('.wea_alert').find('img').first();

      downloadIfNotExist({uri:pm25ImgElem.attr('src'), img_path: pm25ImgPath });
      let nowPm25FileName = pm25ImgElem.attr('src').split('/').slice(-1)[0];
      shell.ln('-sf', path.join(pm25ImgPath, nowPm25FileName), path.join(pm25ImgPath, 'nowPm25Img.png'));
      var pm25Img = pm25ImgElem.attr('src'); 
      var pm25 = pm25Elem.text().trim().replace(/[^0-9]/g, "");
      var warning = pm25Elem.next().text().trim();
      //温度
      var tem = $('.wea_weather').children('em').text().trim();
      var uptime = $('.wea_weather').children('.info_uptime').text().trim().replace(/[^0-9:]/g, "");
      //天气图片
      var weather_img = $('.wea_weather').find('img').attr('src');
      var weather = $('.wea_weather').find('b').text().trim();
      //湿度
      var hum = $('.wea_about').children('span').text().trim();
      console.log(pm25, tem, hum, weather_img, weather, uptime);
      downloadIfNotExist({uri:weather_img});
      let nowWeatherFileName = weather_img.split('/').slice(-1)[0];
      shell.ln('-sf', path.join(imgPath, nowWeatherFileName), path.join(imgPath, 'nowWeatherImg.png'));
      var forecast = $('.forecast').children('ul').map((index, elem) => {
        elem = cheerio(elem);
        let firstLi = elem.children().first();
        let day = firstLi.children('a').text().trim()
        let secondLi = firstLi.next();
        let thirdLi = secondLi.next();
        let fourthLi = thirdLi.next();
        let fifthLi = fourthLi.next();
        let uri = secondLi.find('img').attr('src');
        downloadIfNotExist({uri});
        let weatherFileName = uri.split('/').slice(-1)[0];
        shell.ln('-sf', path.join(imgPath, weatherFileName), path.join(imgPath, `${day}.png`));

        return {
          day: day,
          weather: secondLi.text().trim(),
          weather_img: secondLi.find('img').attr('src').split('/').slice(-1)[0],
          tem: thirdLi.text().trim(),
          wind: fourthLi.children('em').text().trim(),
          wind_level: fourthLi.children('b').text().trim(),
          pm25: fifthLi.children('strong').text().trim().replace(/[^0-9]/g, ""),
        }
      }).toArray()
      return {
        tem: tem,
        uptime: uptime,
        weather: weather,
        weather_img: weather_img.split('/').slice(-1)[0],
        hum: hum,
        pm25: pm25,
        forecast: forecast
      }
    })
    .then(info => tryWriteFile(info));
// fetch('https://tianqi.moji.com/weather/china/beijing/chaoyang-district', function(err, resp, html) {
//         if (!err){
//           const $ = cheerio.load(html);
//           console.log(html); 
//       }
// });

function downloadIfNotExist({uri, img_path=imgPath}) {
  let fileName = uri.split('/').slice(-1)[0];
  try {
    fs.statSync(path.join(img_path, fileName));
    //如果可以执行到这里那么就表示存在了
  } catch(e){
    console.log('start download ', uri);
    //捕获异常
    download(uri, img_path).then(function () {});
  }
}

function tryWriteFile(info) {
  try {
    var fileUnixTime = fs.statSync(path.join(confilePath, confileName)).mtime.getTime();
    var isToday = moment(fileUnixTime).isSame(moment(), 'day');
    if(isToday) {
      console.log("文件修改日期为今天");
      var grepresult = shell.grep('t_uptime=', path.join(confilePath, confileName)).toString();
      var weatherUptime = moment(grepresult.substring(9, grepresult.length), 'HH:mm');

      var uptime = moment(info.uptime, 'HH:mm');
      var isSameUpTime = weatherUptime.isSame(uptime, 'time');
      console.log("weather upate time is ", uptime.format(), " 文件中weather uptime is ", weatherUptime.format());
      if(!isSameUpTime) {
        writeFile(info);
        return;
      } else {
        console.log("weather update time 相同");
        return;
      }
    } else {
        console.log("文件修改日期不同");
        writeFile(info);
        return;
    }
  } catch (e) {
    console.log("statSync 错误", e);
    writeFile(info);
  }
}

function writeFile(info) {
  var txt = `t_tem=${info.tem}\n` +
    `t_uptime=${info.uptime}\n` +
    `t_weather=${info.weather}\n` +
    `t_hum=${info.hum}\n` +
    `t_pm25=${info.pm25}\n` +
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
  var w_data = new Buffer(txt);
  fs.writeFile(path.join(confilePath, confileName), w_data, function (err) {
    if(err) {
      console.error(err);
    } else {
      console.log('写入成功');
    }
  });
}
