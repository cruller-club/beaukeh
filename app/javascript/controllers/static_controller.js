import { Controller } from "@hotwired/stimulus"
import sap from "sap"

export default class extends Controller {
  download(event) {
    console.log("Downloading Beaukeh!")

    let svg = document.getElementById('beaukeh')
    
    sap.saveSvgAsPng(
      svg,
      'beaukeh.png',
      { scale: 10,
        // height: 2000,
        excludeCss: true,
        encoderOptions: 1
      }
    )
  }
}
