module Godhead
  autoload :BeanstalkdRecipe,    'godhead/recipes/beanstalkd_recipe.rb'
  autoload :GenericWorkerRecipe, 'godhead/recipes/generic_worker_recipe.rb'
  autoload :NginxRecipe,         'godhead/recipes/nginx_recipe.rb'
  autoload :ThinRecipe,          'godhead/recipes/thin_recipe.rb'
  autoload :TyrantRecipe,        'godhead/recipes/tyrant_recipe.rb'
  autoload :MemcachedRecipe,     'godhead/recipes/memcached_recipe.rb'
  autoload :StarlingRecipe,      'godhead/recipes/starling_recipe.rb'
end
