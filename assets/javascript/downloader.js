function downloader(file_name) {
  console.log(`Downloading ${file_name}...`);

  // getSVGString ( svgNode ) and svgString2Image( svgString, width, height, format, callback )

  svgString = getSVGString($("#beaukeh"));

  console.log(svgString);
  svgString2Image(svgString, 4700, 2000, "png", "");
}