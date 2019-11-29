const Helpers = {
  restoreRemoteFormState(live, form) {
    let queryString = this.dumpFormStateToQueryString(form)
    live.pushEvent("restore_state", { form_data: queryString })
  },

  storeFormState(live, form) {
    let queryString = this.dumpFormStateToQueryString(form)
    live.pushEvent("store_state", { form_data: queryString })
  },

  dumpFormStateToQueryString(form) {
    let formData = new FormData(form)
    let queryString = new URLSearchParams(formData)
    queryString.toString()
  }
}

export default Helpers