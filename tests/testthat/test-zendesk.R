context('Login')

# TODO: Add secure way to test successfull login

test_that('warn users when login unsuccessful', {
    expect_error(zendesk('fake@email.com','wrong_pw','https://abcfaketest.zendesk.com'))
    expect_error(zendesk('fake@email.com','wrong_pw'))
    expect_error(zendesk('fake@email.com', url = 'https://abcfaketest.zendesk.com'))
    expect_error(zendesk(password = 'wrong_pw', url = 'https://abcfaketest.zendesk.com'))
})