import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="appointment"
export default class extends Controller {
  static targets = ["error"]

  connect() {
    console.log("Appointment form controller connected")
  }

  submit(event) {
    const form = event.target
    if (!form.checkValidity()) {
      event.preventDefault()
      this.showError("Please fill out all required fields correctly")
      return false
    }
  }

  showError(message) {
    if (this.hasErrorTarget) {
      this.errorTarget.textContent = message
      this.errorTarget.style.display = 'block'
    }
  }

  hideError() {
    if (this.hasErrorTarget) {
      this.errorTarget.style.display = 'none'
    }
  }
}
