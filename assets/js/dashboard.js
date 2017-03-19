import socket from './socket'
import $ from 'jquery'

let channel = socket.channel("dashboard:lobby", {})

let init = () => {
  channel.on("connect", light => {
    let color = light["color"]
    let $list = $(".lights")
    let $newLight = $(lightElement(light["slack_handle"], light["color"]))
    $newLight.attr("data-cpuid", light["cpuid"])

    $list.append($newLight)
  })

  channel.on("change", light => {
    let $li = $(`li[data-cpuid='${light["cpuid"]}']`)
    $li.css({"backgroundColor": light["color"]})
  })

  channel.on("delete", light => {
    let $li = $(`li[data-cpuid='${light["cpuid"]}']`)
    $li.remove()
  })
}

let lightElement = (slack_handle, color) => (
  `<li class='light' style="background-color:${color}">
    <div class='outer-div'>
      <div class='username'>
        <p>${slack_handle.toUpperCase()}</p>
      </div>
    </div>
  </li>`
)



init()
