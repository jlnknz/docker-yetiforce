# Docker deployment for YetiForce

=== Draft work, please ignore for now. ==

## TODO
- still quite a bit of work;
- ... and proper documentation.

## Quick reference:

### Build fresh images

    $ time docker-compose build --no-cache --pull

### Start YetiForce

    $ cd docker-compose
    # create a .env file, based on .env.dist 
    $ docker-compose up 
    # Logs will be printed in the console
    # Access http://127.0.0.1/ in your browser
    # Install YetiForce. Use:
    #   - `yeti-mysql` as db hostname
    #   - `yeti` as db username
    #   - `yetiforce` as db name
    #   - the password you have defined in your .env (APP_DATABASE_YETI_USER_PASSWORD)
    # The first run may take quite a bit of time

### Stop YetiForce

    $ cd docker-compose
    $ docker-compose down
    # Created volumes won't be deleted


## Random notes

### Different environments, same code

- Ideally, prod and dev environments should use the same images. 
- We could extend the PHP-FPM to include XDebug for instance, but the rest of the deployment stack should be the same


### Waiting for MySQL
Need to wait for MySQL before accepting connections in PHP-FPM container? TODO.
```
while ! nc -z yeti-mysql 3306 </dev/null; do
    echo "Waiting for MySQL... (5 seconds)";
    sleep 5;
done
```
