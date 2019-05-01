## Docker image generation for custom Clickhouse version.

For building a docker image from custom Clickhouse version simply update `clickhouse_debian_packages.txt`
with links on the corresponding packages.
They usually could be found by executing following steps:

1. Go to the official Clickhouse repository
2. Find a commit with version you need in `master` branch
3. Click on green check mark near the commit name
4. Click on `Details`
5. Find a row with gcc-8, relwithdebuginfo, none, bundled
