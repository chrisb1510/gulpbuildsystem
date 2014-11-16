{renderable, ul, li} = @teacup

template = renderable (items)->
  ul ->
    li item for item in items

console.log template(['One', 'Two'])