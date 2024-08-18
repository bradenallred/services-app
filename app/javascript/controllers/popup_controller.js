import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="popup"
export default class extends Controller {
  static targets = ["modal","rmodal", "rcontent", "rname", "rrating"]
  open() {
    this.modalTarget.classList.remove('hidden');
    this.overlay = document.createElement("div");
    this.overlay.className = "fixed inset-0 z-20 bg-black opacity-50";
    document.body.appendChild(this.overlay);
  }
  
  close() {
    this.modalTarget.classList.add('hidden');
    if (this.overlay) {
      document.body.removeChild(this.overlay);
    }
  }

  ropen(event) {
    this.rmodalTarget.classList.remove('hidden');
    this.roverlay = document.createElement("div");
    this.roverlay.className = "fixed inset-0 z-20 bg-black opacity-50";
    document.body.appendChild(this.roverlay);

    const reviewContent = event.currentTarget.getAttribute('data-popup-rcontent');
    this.rcontentTarget.innerHTML = reviewContent;
    const reviewName = event.currentTarget.getAttribute('data-popup-rname');
    this.rnameTarget.innerHTML = reviewName;
    const rating = event.currentTarget.getAttribute('data-popup-rrating');
    this.rratingTarget.innerHTML = rating;
  }

  rclose() {
    this.rmodalTarget.classList.add('hidden');
    if (this.roverlay) {
      document.body.removeChild(this.roverlay);
    }
  }

}
