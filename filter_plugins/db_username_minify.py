# arg is expected to be a unicode string.
# Remove vowels occuring after the first character and truncate to 16 characters
def db_username_minify(arg):
    remove_dict = dict((ord(char), None) for char in "aeiouy")
    mini = arg[1:].translate(remove_dict)
    mini = arg[0] + mini
    return mini[0:15]

class FilterModule(object):
    def filters(self):
        return {'db_username_minify': db_username_minify}
