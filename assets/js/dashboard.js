import socket from './socket'

let channel = socket.channel("dashboard:lobby", {})

let init = () => {
  channel.on("connect", light => {
    console.log("light", light)
  })

  channel.on("change", light => {
    console.log("light", light)
  })

  channel.on("delete", light => {
    console.log("light", light)
  })
}


init()
