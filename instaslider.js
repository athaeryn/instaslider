/*jslint browser:true */

window.InstaSlider = (function () {
    "use strict";

    function InstaSlider(options) {
        this.options = options;
    }

    InstaSlider.prototype.run = function () {
        console.log('InstaSlider.run() with options: ', this.options);
    };

    return InstaSlider;
}());
