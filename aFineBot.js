// Use the Twit node package
// https://github.com/ttezel/twit
var Twit = require('twit');

// Pulling all my twitter account info from another file
var config = require('./config.js');

// Making a Twit object for connection to the API
var T = new Twit(config);

// Require child_process for triggering script for Processing
var exec = require('child_process').exec;

// For reading image files
var fs = require('fs');

// For pausing 
var sleep = require('system-sleep');

// Set parameters 
/** 
* @async
* @param {String} status
* @param {Array<String>} photoFileNames
*/

// Start once
tweeter();

// Once every N milliseconds
setInterval(tweeter, 60*60*1000);

// Here is the bot!
function tweeter() { 

    // Run the Processing sketches
  // You need to have Processing command line installed
  // See: https://github.com/processing/processing/wiki/Command-Line

  var cmd = 'processing-java --sketch=`pwd`/Shape01/ --run';
  exec(cmd, processing);
  console.log('Generating Shape.png FILE');
  
  sleep(10*1000); // sleep for 10 seconds
  console.log('Sleeping 10 seconds');

  var cmd = 'processing-java --sketch=`pwd`/Shape02/ --run';
  exec(cmd, processing);
  console.log('Generating Shape01.png file');

  sleep(10*1000); // sleep for 10 seconds
  console.log('Sleeping 10 seconds');

  var cmd = 'processing-java --sketch=`pwd`/Shape03/ --run';
  exec(cmd, processing);
  console.log('Generating Shape02.png file');

  sleep(10*1000); // sleep for 10 seconds
  console.log('Sleeping 10 seconds');

  var cmd = 'processing-java --sketch=`pwd`/Shape04/ --run';
  exec(cmd, processing);
  console.log('Generating Shape03.png file');

  sleep(10*1000); // sleep for 10 seconds
  console.log('Sleeping 10 seconds');

  var cmd = 'processing-java --sketch=`pwd`/RandomLetters/ --run';
  exec(cmd, processing);
  console.log('Generating final.png file');

  
  // Callback for command line process
  function processing(error, stdout, stderr) { 
  // Error checking 
      console.log(stdout);

      const photoFileNameArray = ['final.png', 'shape1.png', 'shape2.png', 'shape3.png'];
      var status = '...'; 
  
      const uploadedMedia = photoFileNameArray.map((filename) => {
      const fileContent = fs.readFileSync(filename, { encoding: 'base64' });
      return T.post('media/upload', { media_data: fileContent });
      
       });
       console.log('Uploading photos');

  Promise.all(uploadedMedia).then((results) => {
    const mediaIds = results.map(({ data }) => {
      const { media_id_string: mediaId } = data;

      T.post('media/metadata/create', { media_id: mediaId });

      return mediaId;
    });
  
      T.post('statuses/update', { status, media_ids: mediaIds });
    });

    console.log('Posted');

    fs.unlink('final.png', function (err) {
      if (err) throw err;
      // if no error, file has been deleted successfully
      console.log('File deleted!');
  }); 
  fs.unlink('shape.png', function (err) {
    if (err) throw err;
    // if no error, file has been deleted successfully
    console.log('File deleted!');
}); 
fs.unlink('shape1.png', function (err) {
  if (err) throw err;
  // if no error, file has been deleted successfully
  console.log('File deleted!');
}); 
fs.unlink('shape2.png', function (err) {
  if (err) throw err;
  // if no error, file has been deleted successfully
  console.log('File deleted!');
}); 
fs.unlink('shape3.png', function (err) {
  if (err) throw err;
  // if no error, file has been deleted successfully
  console.log('File deleted!');
}); 
  }
}