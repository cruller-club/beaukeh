import { Controller } from "@hotwired/stimulus"
import sap from "sap"

export default class extends Controller {
  download(event) {
    console.log("Downloading Beaukeh!")

    let svg = document.getElementById('beaukeh')
    
    sap.saveSvgAsPng(
      svg,
      event.params['signature'],
      { scale: 10, // This produces 4700 x 2000 pixel images.
        excludeCss: true,
        encoderOptions: 1
      }
    )
  }
}
