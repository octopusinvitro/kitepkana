// Inspired on: http://codepen.io/SitePoint/pen/vNvEwE
// See also: https://jsfiddle.net/jfriend00/v9g1x0o6/

(function() {
  'use strict';

  document.body.addEventListener('click', copy, true);

  function copy(event) {
    var
      target = event.target,
      copytarget = target.dataset.copytarget,
      input = (copytarget ? document.querySelector(copytarget) : null);

    if (input && input.select) {
      input.select();

      try {
        document.execCommand('copy');
        input.blur();
        target.classList.add('copied');
        setTimeout(function() { target.classList.remove('copied'); }, 1500);

      } catch (err) {
        alert('Please press Ctrl/Cmd+C to copy');
      }
    }
  }
})();
