import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["toggle", "menu"]

  connect() {
    this.outsideClickListener = this.handleOutsideClick.bind(this)
  }

  toggle() {
    this.menuTarget.classList.toggle('hidden')
    if (!this.menuTarget.classList.contains('hidden')) {
      window.addEventListener('click', this.outsideClickListener)
    }
  }

  handleOutsideClick(event) {
    if (!this.toggleTarget.contains(event.target) && !this.menuTarget.contains(event.target)) {
      this.menuTarget.classList.add('hidden')
      window.removeEventListener('click', this.outsideClickListener)
    }
  }
}