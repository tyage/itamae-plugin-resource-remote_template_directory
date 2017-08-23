node.reverse_merge!(
  var: 'value of node var'
)

remote_template_directory 'copy directory' do
  source 'sample_directories'
  path '/tmp/remote_template_directory_spec'
  variables(
    var1: 'value of var1',
    var2: 'value of var2'
  )
end
