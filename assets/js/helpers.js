const Helpers = {
  restoreRemoteFormState(liveHook, form) {
    let queryString = this.dumpFormStateToQueryString(form)
    liveHook.pushEvent("restore_state", { form_data: queryString })
  },

  storeFormState(liveHook, form) {
    let queryString = this.dumpFormStateToQueryString(form)
    liveHook.pushEvent("store_state", { form_data: queryString })
  },

  dumpFormStateToQueryString(form) {
    let formData = new FormData(form)
    let queryString = new URLSearchParams(formData)
    return queryString.toString()
  }
}

export default Helpers