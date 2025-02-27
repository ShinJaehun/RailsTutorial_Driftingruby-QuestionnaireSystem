import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  static targets = ["add_item", "template"]
  static values = { index: String }

  connect(){
    console.log("hello")
  }
  add_association(event) {
    event.preventDefault()
    // var content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, new Date().getTime())
    let content = this.templateTarget.innerHTML.replace(new RegExp(this.indexValue, "g"), new Date().getTime());
    this.add_itemTarget.insertAdjacentHTML('beforebegin', content);
  }

  remove_association(event) {
    event.preventDefault()
    let item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = 'none'
  }
}
