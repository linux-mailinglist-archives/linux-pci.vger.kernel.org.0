Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A602492D7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 04:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHSCVe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 22:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbgHSCVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 22:21:31 -0400
Received: from localhost (unknown [12.195.163.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFFB1205CB;
        Wed, 19 Aug 2020 02:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597803691;
        bh=tTd6dZ3NlZC+UPHZ2QtCzG/g0WugnXRx0IlELaokIjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lIS6eyp32dSzoHIz4UfGjqqP6fNmQEYpSxugsDG+oeVbZEaZqRu3/FTcFEbY0q9IJ
         nmIUcl4sGaBdlQTmPFiHCFlcYvgJtjcJR9+p24XQI2USYpI0UwPb/v/rKRjwIAAs48
         qozQmKPP/dJIXgBunOp7RHJ3r42zO8ZNddv7aRDc=
Date:   Tue, 18 Aug 2020 21:21:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Subject: Re: [RFC PATCH 08/17] gpio: Drop uses of pci_read_config_*() return
 value
Message-ID: <20200819022127.GA1496569@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJX8SV6RTgy4vKNRPzKvnVaJZpZKQmOf1pX1wGd+H2zaeA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 18, 2020 at 09:59:50PM +0200, Bartosz Golaszewski wrote:
> On Sat, Aug 1, 2020 at 2:24 PM Saheed O. Bolarinwa
> <refactormyself@gmail.com> wrote:
> >
> > The return value of pci_read_config_*() may not indicate a device error.
> > However, the value read by these functions is more likely to indicate
> > this kind of error. This presents two overlapping ways of reporting
> > errors and complicates error checking.
> >
> > It is possible to move to one single way of checking for error if the
> > dependency on the return value of these functions is removed, then it
> > can later be made to return void.
> >
> > Remove all uses of the return value of pci_read_config_*().
> > Check the actual value read for ~0. In this case, ~0 is an invalid
> > value thus it indicates some kind of error.
> >
> > Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> > Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> > ---
> >  drivers/gpio/gpio-amd8111.c |  7 +++++--
> >  drivers/gpio/gpio-rdc321x.c | 21 ++++++++++++---------
> >  2 files changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-amd8111.c b/drivers/gpio/gpio-amd8111.c
> > index fdcebe59510d..7b9882380cbc 100644
> > --- a/drivers/gpio/gpio-amd8111.c
> > +++ b/drivers/gpio/gpio-amd8111.c
> > @@ -198,9 +198,12 @@ static int __init amd_gpio_init(void)
> >         goto out;
> >
> >  found:
> > -       err = pci_read_config_dword(pdev, 0x58, &gp.pmbase);
> > -       if (err)
> > +       pci_read_config_dword(pdev, 0x58, &gp.pmbase);
> > +       if (gp.pmbase == (u32)~0) {
> > +               err = -ENODEV;
> >                 goto out;
> > +       }
> > +
> >         err = -EIO;
> >         gp.pmbase &= 0x0000FF00;
> >         if (gp.pmbase == 0)
> > diff --git a/drivers/gpio/gpio-rdc321x.c b/drivers/gpio/gpio-rdc321x.c
> > index 01ed2517e9fd..03f1ff07b844 100644
> > --- a/drivers/gpio/gpio-rdc321x.c
> > +++ b/drivers/gpio/gpio-rdc321x.c
> > @@ -85,10 +85,13 @@ static int rdc_gpio_config(struct gpio_chip *chip,
> >         gpch = gpiochip_get_data(chip);
> >
> >         spin_lock(&gpch->lock);
> > -       err = pci_read_config_dword(gpch->sb_pdev, gpio < 32 ?
> > -                       gpch->reg1_ctrl_base : gpch->reg2_ctrl_base, &reg);
> > -       if (err)
> > +       pci_read_config_dword(gpch->sb_pdev,
> > +                               (gpio < 32) ? gpch->reg1_ctrl_base
> > +                                       : gpch->reg2_ctrl_base, &reg);
> > +       if (reg == (u32)~0) {
> > +               err = -ENODEV;
> >                 goto unlock;
> > +       }
> >
> >         reg |= 1 << (gpio & 0x1f);
> >
> > @@ -166,17 +169,17 @@ static int rdc321x_gpio_probe(struct platform_device *pdev)
> >         /* This might not be, what others (BIOS, bootloader, etc.)
> >            wrote to these registers before, but it's a good guess. Still
> >            better than just using 0xffffffff. */
> > -       err = pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
> > +       pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
> >                                         rdc321x_gpio_dev->reg1_data_base,
> >                                         &rdc321x_gpio_dev->data_reg[0]);
> > -       if (err)
> > -               return err;
> > +       if (rdc321x_gpio_dev->data_reg[0] == (u32)~0)
> > +               return -ENODEV;
> >
> > -       err = pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
> > +       pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
> >                                         rdc321x_gpio_dev->reg2_data_base,
> >                                         &rdc321x_gpio_dev->data_reg[1]);
> > -       if (err)
> > -               return err;
> > +       if (rdc321x_gpio_dev->data_reg[1] == (u32)~0)
> > +               return -ENODEV;
> >
> >         dev_info(&pdev->dev, "registering %d GPIOs\n",
> >                                         rdc321x_gpio_dev->chip.ngpio);
> > --
> > 2.18.4
> >
> 
> Bjorn,
> 
> I don't know the pci sub-system at all. Does this look good to you?

I wouldn't apply this at this point.  It's definitely true that when
pci_read_config_dword() returns an error, it's likely an alignment
problem or some other programming error, not an actual PCI error.

If an actual PCI error occurs (device failed to respond, transaction
failed because of noise or electrical issue, etc),
pci_read_config_dword() will *not* return an error; the data it reads,
e.g., rdc321x_gpio_dev->data_reg[1], will be ~0.

So with the current pci_read_config_dword() implementation, we really
need to test *both* the return value and the read data to be
completely, obsessively correct.  But that's really not practical,
hence this RFC patch where we're considering getting rid of the return
value and just making it set the read data to ~0 for all errors.

We might still get there someday, but we don't yet set the read data
to ~0 on all errors, and if/when we do that, we should have some sort
of descriptive macro that we can grep for instead of open-coding "~0"
everywhere.

Bjorn
