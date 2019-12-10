// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import { Socket } from "phoenix"
import LiveSocket from "phoenix_live_view"
import CreateConversationFormHooks from "./dashboard_live";
import Helpers from "./helpers";

let Hooks = { CreateConversationFormHooks };

let liveSocket = new LiveSocket("/live", Socket, { hooks: Hooks })
liveSocket.connect()

window.liveSocket = liveSocket

window.onbeforeunload = e => {
  let createConversationForm = document.getElementById("create_conversation_form")

  if (createConversationForm) {
    let liveViewElement = createConversationForm.closest("[data-phx-view]")
    let liveView = liveSocket.views[liveViewElement.id]
    let liveHook = Object.values(liveView.viewHooks).find(e => e.el == createConversationForm)

    console.log("benis")

    Helpers.storeFormState(liveHook, createConversationForm)

    e.returnValue = true
  }
}