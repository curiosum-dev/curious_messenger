const ConversationListHooks = {
  updated() {
    let newConversationLink = this.el.querySelector('[data-notify]')
    if (!newConversationLink) return

    let notification = new Notification(newConversationLink.innerText)
    notification.onclick = () => window.open(newConversationLink.href)
  }
}

export default ConversationListHooks