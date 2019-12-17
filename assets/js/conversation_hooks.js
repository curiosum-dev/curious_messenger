const ConversationHooks = {
  updated() {
    if (!this.notifiedMessages)
      this.notifiedMessages = []
    
    this.el.querySelectorAll('[data-incoming]').forEach(element => {
      if (!this.notifiedMessages.includes(element)) {
        this.notifiedMessages.push(element)
        let notification = new Notification(element.innerText)
        notification.onclick = () => window.focus()    
      }
    })
  }
}

export default ConversationHooks