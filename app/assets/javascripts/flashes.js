var Flashes = Flashes || {};

Flashes.Flash = function(type, message){
  this.message = message;
  this.type = type;
};

Flashes.Manager = function() {
  var $flashes = $('#flashes');

  this.show = function() {
    $flashes.fadeIn(500).delay(1000).fadeOut('slow');
  };

  this.set = function(flash) {
    $flashes.html('<div class="flash-' + flash.type + '">' + flash.message + '</div>');
  };

  this.getFlashesFromHeader = function(request) {
    var flashes = []

    if(request.getResponseHeader('X-Message')) {
      var messages = request.getResponseHeader('X-Message').split(',');

      flashes = _.map(messages, function(message) {
        var messageAndType = message.split(':');

        return new Flashes.Flash(messageAndType[0], messageAndType[1]);
      });
    }

    return flashes;
  };

  return this;
};

$(function() {
  var flashesManager = new Flashes.Manager;

  flashesManager.show();
});

$(document).ajaxComplete(function(event, request) {
  var flashesManager = new Flashes.Manager;
  var flashes = flashesManager.getFlashesFromHeader(request);

  _.each(flashes, function(flash) {
    flashesManager.set(flash);
  });

  flashesManager.show();
});