import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review"
export default class extends Controller {
  static targets = ["shortReview", "fullReview", "toggleButton"]

  toggle() {
    if (this.shortReviewTarget.classList.contains('hidden')) {
      this.shortReviewTarget.classList.remove('hidden');
      this.fullReviewTarget.classList.add('hidden');
      this.toggleButtonTarget.textContent = 'See More';
    } else {
      this.shortReviewTarget.classList.add('hidden');
      this.fullReviewTarget.classList.remove('hidden');
      this.toggleButtonTarget.textContent = 'See Less';
    }
  }
}
