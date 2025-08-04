--Git integration
create or replace api integration github_roman
    api_provider = git_https_api
    api_allowed_prefixes = ('https://github.com/AfoD3V/snowflake_project')
    enabled = true
    allowed_authentication_secrets = all