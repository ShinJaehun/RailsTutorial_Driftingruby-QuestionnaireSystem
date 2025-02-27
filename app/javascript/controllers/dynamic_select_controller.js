import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dynamic-select"
export default class extends Controller {
  static targets = ["select", "choice", "long"]

  connect() {
    this.selected()
  }

  selected() {
    this.hideFields()
    switch (this.selectTarget.value) {
      case 'single_choice':
        this.choiceTarget.classList.remove('hidden')
        break;
      case 'multiple_choice':
        this.choiceTarget.classList.remove('hidden')
        break;
      case 'long_answer':
        this.longTarget.classList.remove('hidden')
        break;
    }
  }

  hideFields() {
    this.choiceTarget.classList.add('hidden')
    this.longTarget.classList.add('hidden')
  }
}
