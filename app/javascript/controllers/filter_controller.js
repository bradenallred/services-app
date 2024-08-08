import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["form", "categoryInput"]

  submitCategory(event) {
    event.preventDefault()
    const category = event.params.category
    this.categoryInputTarget.value = category
    this.formTarget.submit()
  }
}
