# AWS Lambda Python Container Image With Latest Sqlite

> This project is in maintenance mode.

AWS publishes [docker images for use with lambda](https://gallery.ecr.aws/lambda/python). Unfortunately the underlying operating system (Amazon Linux 2) has an out of date version of sqlite installed that won't work with the current supported versions of Django. `aws-lambda-python-sqlite` images compile the latest sqlite version and replace the library for the lambda version of Python built in to the image. Everything else will work exactly the same as the official images.


## Supported Python Versions

**NOTE:** Only images that are [based on Amazon Linux 2](https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-base) have been built here.

- 3.8
- 3.9
- 3.10
- 3.11

## Usage

Inside your dockerfile instead of pulling the official images do as follows:

```diff
- FROM public.ecr.aws/lambda/python:3.9
+ FROM lukewiwa/aws-lambda-python-sqlite:3.9
```