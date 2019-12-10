import Helpers from "./helpers"

const CreateConversationFormHooks = {
  disconnected() {
    console.log("Disconnected", this)
  },

  reconnected() {
    console.log("Reconnected", this)
    Helpers.restoreRemoteFormState(this, this.el)
  },

  mounted() {
    console.log("Mounted", this)
  },

  destroyed() {
    console.log("Destroyed", this)
  },

  updated() {
    console.log("Updated", this)
  }
}

export default CreateConversationFormHooks