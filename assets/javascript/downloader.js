function svg_to_png(svg_string) {
  return new Promise(function(resolve, reject) {
    try {
      var domUrl = window.URL || window.webkitURL || window;
      if (!domUrl) {
        throw new Error("(DOM URL objects not available.)")
      }

      // Make an SVG blob.
      var svg = new Blob([svg_string], {
        type: "image/svg+xml;charset=utf-8"
      });

      // Make a canvas.
      var canvas = document.createElement("canvas");
      canvas.width = 4700;
      canvas.height = 2000;
      var context = canvas.getContext("2d");

      // Make a DOM URL object.
      var url = domUrl.createObjectURL(svg);

      var img = new Image;

      img.onload = function() {
        context.drawImage(img, 0, 0, canvas.width, canvas.height);
        
        var styled = document.createElement("canvas");
        styled.width = canvas.width;
        styled.height = canvas.height;
        
        var styled_context = styled.getContext("2d");
        styled_context.save();
        styled_context.fillStyle = $("body").css("background-color");   
        styled_context.fillRect(0, 0, canvas.width, canvas.height);
        styled_context.strokeRect(0, 0, canvas.width, canvas.height);
        styled_context.restore();
        styled_context.drawImage (canvas, 0, 0);
        
        canvas = styled;
        
        domUrl.revokeObjectURL(url);

        resolve(canvas.toDataURL('image/png'));
      };

      img.src = url;
    } catch (err) {
      reject("Failed to convert SVG to PNG: " + err);
    }
  });
}

function downloader(file_name) {
  console.log(`Prepping ${file_name} for download.`);

  svg_string = $("#beaukeh")[0].outerHTML;

  svg_to_png(svg_string)
  .then(function(data) {
    $("#gimme-beaukeh").attr("href", `${data}`);
  })
  .catch(function(err){
    console.log("Error! " + err);
  });
}