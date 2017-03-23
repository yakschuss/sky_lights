import socket from './socket'
import $ from 'jquery'

let channel = socket.channel("dashboard:lobby", {})

let init = () => {
  channel.on("connect", light => {
    let color = light["color"]
    let $list = $(".lights")
    let $newLight = $(lightElement(light["slack_handle"]))
    $newLight.attr("data-uid", light["uid"])
    $newLight.css({"background": `radial-gradient(circle at 100px 100px, ${light["color"]}, ${nameShadow(light["color"])})`})
    $list.append($newLight)
    $newLight.textfill();
    console.log(light)
  })

  channel.on("change", light => {
    let $li = $(`li[data-uid='${light["uid"]}']`)
    $li.css({"background": `radial-gradient(circle at 100px 100px, ${light["color"]}, ${nameShadow(light["color"])})`})
    console.log(light)
  })

  channel.on("delete", light => {
    let $li = $(`li[data-uid='${light["uid"]}']`)
    $li.remove()
    console.log(light)
  })

  $.fn.textfill = function(options) {
    return this.each(function(){
      var textDiv = this;
      var textSpan = $(this).find("p")[0];
      console.log(textDiv, textSpan);

      if (textSpan.getClientRects()[0].width < textDiv.getClientRects()[0].width)
        return;

      textSpan.style.fontSize = '64px';

      while(textSpan.getClientRects()[0].width > textDiv.getClientRects()[0].width)
      {
        textSpan.style.fontSize = (parseInt(textSpan.style.fontSize) - 1)+"px";
      }
    });
  }

  $(".light").textfill();

}

let lightElement = (slack_handle) => (
  `<li class='light'>
    <div class='outer-div'>
      <div class='username'>
        <p>${slack_handle.toUpperCase()}</p>
      </div>
    </div>
  </li>`
)

let nameShadow = (hex) => {
  console.log("tits!");
  let c = hex.substring(1).split('')
  c = '0x' + c.join('');
  return 'rgb('+[(c>>16)&160, (c>>8)&160, c&160].join(',')+')';
}

init()
