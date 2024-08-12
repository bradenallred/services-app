import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fill"
export default class extends Controller {
  static targets = ["icon"]

  changeFill(event) {
    // Access the SVG element using the target
    const svgElement = this.iconTarget;

    // Change the fill attribute
    const darkPink = "rgb(248 113 113)"; // A darker shade of pink

    // Toggle between dark pink fill/stroke and no fill with original stroke
    if (svgElement.style.fill === darkPink) {
      svgElement.style.fill = "none";
      svgElement.classList.remove("text-red-400");
      svgElement.classList.add("text-gray-800");
    } else {
      svgElement.style.fill = darkPink;
      svgElement.classList.add("text-red-400");
      svgElement.classList.remove("text-gray-800");
    }
  }
}
