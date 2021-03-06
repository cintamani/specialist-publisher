(function(Modules) {
  "use strict";
  Modules.DropdownSelectAll = function() {
    var self = this;
    self.init = function(elements) {
      elements.each(function() {
        var selectId = $(this).attr("id");
        $(this).parent()
          .append('<a href="#" class="dropdown-select-all" data-select-id="#' + selectId  + '">Select all</a>')
      });

      $(".dropdown-select-all").click(function() {
        var selectId = $(this).data("select-id");
        $(selectId + " option:not(:selected)")
          .prop("selected", true)
          .parent()
          .trigger("change");
        return false;
      });
    };
  };

  Modules.DropdownClearAll = function() {
    var self = this;
    self.init = function(elements) {
      elements.each(function() {
        var selectId = $(this).attr("id");
        $(this).parent()
          .append('<a href="#" class="dropdown-clear-all" data-select-id="#' + selectId + '">Clear all</a>');
      });

      $(".dropdown-clear-all").click(function() {
        var selectId = $(this).data("select-id");
        $(selectId + " option:selected")
          .prop("selected", false)
          .parent()
          .trigger("change");
        return false;
      });
    };
  };
})(window.GOVUKAdmin.Modules);
