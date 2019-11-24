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

let Hooks = {
  CreateConversationForm: {
    disconnected() {
      console.log("Disconnected", this)
    },

    reconnected() {
      console.log("Reconnected", this)
      let formData = new FormData(this.el)
      let queryString = new URLSearchParams(formData)
      this.pushEvent("restore_state", { form_data: queryString.toString() })
    },

    mounted() {
      console.log("Mounted", this)
    },

    destroyed() {
      console.log("Destroyed", this)
    },

    disconnected() {
      console.log("Disconnected", this)
    },

    updated() {
      console.log("Updated", this)
    }
  }
};

let liveSocket = new LiveSocket("/live", Socket, { hooks: Hooks })
liveSocket.connect()