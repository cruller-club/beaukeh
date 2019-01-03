function draw() {
  // Clean up.
  d3.selectAll("#beaukeh > *").remove();

  // Make a "canvas".
  beaukeh.attr("width", width)
      .attr("height", height);

  // Paint a background.
  background_color = generateColor(0.50, 0.10, 1.00);
  //console.log(background_color.hex() + "");
  document.body.style.backgroundColor = background_color.hex() + "";
  beaukeh.append("rect")
      .attr("width", width)
      .attr("height", height)
      .attr("fill", background_color);

  // Beaukeh time!
  var beaukehs = d3.randomUniform(25, 200)();
  for (i = 0; i < beaukehs; i++) {
      generateCircle();
  }

  //convert();
}

// function convert() {
//     var svgString = new XMLSerializer().serializeToString(document.querySelector('svg'));

//     var canvas = document.getElementById("canvas");
//     var ctx = canvas.getContext("2d");
//     var DOMURL = self.URL || self.webkitURL || self;
//     var img = new Image();
//     var svg = new Blob([svgString], {type: "image/svg+xml;charset=utf-8"});
//     var url = DOMURL.createObjectURL(svg);
//     img.onload = function() {
//         ctx.drawImage(img, 0, 0);
//         // var png = canvas.toDataURL("image/png");
//         // document.querySelector('#png-container').innerHTML = '<img src="'+png+'"/>';
//         // DOMURL.revokeObjectURL(png);
//     };
//     img.src = url;
// }

function generateColor(saturation = 0.50, brightness = 0.50, alpha = 0.10) {
  var hue = d3.randomUniform(0, 360)();
  var color = d3.hsl(hue, saturation, brightness, alpha);

  return color;
}

function generateBackground() {
  beaukeh.append("rect");
}

function generateCircle() {
  beaukeh.append("circle")
      .attr("r", Math.abs(d3.randomNormal()() * (height / 10)))
      .attr("cx", d3.randomNormal((width / 2), (width / 3))())
      .attr("cy", d3.randomNormal((height / 2), (height / 10))())
      .attr("fill", generateColor());
}
