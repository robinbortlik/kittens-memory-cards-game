// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

// allows to postpone rendering of turbo streams
document.addEventListener("turbo:before-stream-render", (event) => {
  const defaultActions = event.detail.render;

  const parseDelay = (str) => {
    const regex = /data-delay="(\d+)"/;
    const match = str.match(regex);
    return match ? match[1] : null;
  };

  event.detail.render = function (streamElement) {
    let delay = parseDelay(streamElement.innerHTML);

    if (delay) {
      setTimeout(() => {
        defaultActions(streamElement);
      }, delay);
    } else {
      defaultActions(streamElement);
    }
  };
});
