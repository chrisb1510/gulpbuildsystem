var li, renderable, template, ul, _ref;

_ref = this.teacup, renderable = _ref.renderable, ul = _ref.ul, li = _ref.li;

template = renderable(function(items) {
  return ul(function() {
    var item, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = items.length; _i < _len; _i++) {
      item = items[_i];
      _results.push(li(item));
    }
    return _results;
  });
});

console.log(template(['One', 'Two']));

//# sourceMappingURL=build/views/maps/tcuptest.js.map