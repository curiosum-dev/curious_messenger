import Helpers from "./helpers"

const CreateConversationFormHooks = {
  disconnected() {
    console.log("Disconnected", this)
    Helpers.storeFormState(this, this.el)
  },

  reconnected() {
    console.log("Reconnected", this)
    Helpers.restoreRemoteFormState(this, this.el)
  },

  mounted() {
    debugger
    console.log("Mounted", this)
  },

  destroyed() {
    console.log("Destroyed", this)
    Helpers.storeFormState(this, this.el)
  },

  updated() {
    console.log("Updated", this)
  }
}

export default CreateConversationFormHooks