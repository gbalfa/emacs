def Settings( **kwargs ):
  language = kwargs[ 'language' ]
  if language == 'cfamily':
    return {
      # Settings for the C-family completer.
      'flags': [ '-x', 'c++', '-Wall', '-Wextra', '-Werror', 
                 '-fretain-comments-from-system-headers' ]
    }
  if language == 'python':
    return {
      # Settings for the Python completer.
      'interpreter_path': '/usr/bin/python'
    }
  return {}
