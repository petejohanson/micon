# The :controller component should be created and destroyed dynamically,
# for each request, we specifying that component is dynamic
# by declaring its :scope.
# And, we don't know beforehead what it actully will be, for different
# request there can be different controllers,
# so, here we just declaring it without any initialization block, it
# will be created at runtime later.
micon.register :controller, scope: :request