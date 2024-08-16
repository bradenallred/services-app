import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = ["slides"]
  index = 0

  connect() {
    this.showSlide(this.index)
  }

  next() {
    this.index = (this.index + 1) % this.slidesTarget.children.length
    this.showSlide(this.index)
  }

  previous() {
    this.index = (this.index - 1 + this.slidesTarget.children.length) % this.slidesTarget.children.length
    this.showSlide(this.index)
  }

  showSlide(index) {
    const offset = -index * this.slidesTarget.children[0].offsetWidth
    this.slidesTarget.style.transform = `translateX(${offset}px)`
  }
}
