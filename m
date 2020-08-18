Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5A248F38
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 22:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHRUAE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgHRUAC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2020 16:00:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041E0C061342
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2020 13:00:02 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 62so19479937qkj.7
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2020 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZDCPDwW9euB1yf1r32n/nOxApA5CLlHLcrrfHIoPe0=;
        b=mY9/qM2MC8h80QmH/L2o3ebU+oUQNUCW63wm7YBmbeK4YBE5Xe3Rjqtwof4g90Gl5j
         Nashil2BSJxW/GC+DcTms+MTs3zm8+LkClOf/U2jUP/YJlxAmvLXG+Y1SxzjQuQdOmRe
         FaeRrNHm7nBp0Ire6IgS6r1s0gdLxjr1afa0E+smJ3xN4nEInrIvlWBT7CW0TEmor1mO
         FIgviwqTSYceSMveg047w1orQVPvufjnGz94qi/TKhCr8AbTj6GPs3BxF/aFHmnO4n+M
         XlWMZtYVdzdVxOkWy4H/ual/TZMNFFmE2xwQGOV4ybgkF4mcBltQ5wgUueSnWH61nlUt
         zm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZDCPDwW9euB1yf1r32n/nOxApA5CLlHLcrrfHIoPe0=;
        b=o/7M08hHS2IOC3NfenKDv/9PyHu1WHy7BsDun3VyVJ4FsRto6SZzHYrX03jm/JL7EW
         nlXgS3pbX1tfpWT2UriJFoPXEAA5EVP5iD8MvRxZTGFT9UQ2ewIZtnfvB9Z8M34AH4V1
         P5cuJ8PuPrxIfAI0f312FSfJu0ELPeudN4FzobOXZMUI17UNveNvGclkODAtcRrfDs3X
         onZjGVxRUAjMaXIsATeJT7C8RUtwaghpwVY5OxOVKrcZRjMZvu67Htpbk/sDtlIRAz3I
         Bkbbf7v4aDF5QlV9fx4Q78mVIHBfgA12vgNzj/vjKpdO5bVFZ2hX7PaE43jcakMDMlZh
         +09Q==
X-Gm-Message-State: AOAM530tqy2oBd7TpqO6W7iecT32yYbROcsIXxIiSOgaB+9aymdzwsSD
        KWMMY7+J1JehAA36lB+RlB6KWGOPK6wOcnYHTqaMtA==
X-Google-Smtp-Source: ABdhPJzURAYX1VluYbg81khU/4BFMEQ5XggeNrYg7amfOd007KJmuQPkzQNHuZnA3kRR7pjm2ZwfV6zrZkG75TYorqc=
X-Received: by 2002:a37:a495:: with SMTP id n143mr19146148qke.330.1597780801253;
 Tue, 18 Aug 2020 13:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200801112446.149549-1-refactormyself@gmail.com> <20200801112446.149549-9-refactormyself@gmail.com>
In-Reply-To: <20200801112446.149549-9-refactormyself@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 18 Aug 2020 21:59:50 +0200
Message-ID: <CAMpxmJX8SV6RTgy4vKNRPzKvnVaJZpZKQmOf1pX1wGd+H2zaeA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/17] gpio: Drop uses of pci_read_config_*() return value
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 1, 2020 at 2:24 PM Saheed O. Bolarinwa
<refactormyself@gmail.com> wrote:
>
> The return value of pci_read_config_*() may not indicate a device error.
> However, the value read by these functions is more likely to indicate
> this kind of error. This presents two overlapping ways of reporting
> errors and complicates error checking.
>
> It is possible to move to one single way of checking for error if the
> dependency on the return value of these functions is removed, then it
> can later be made to return void.
>
> Remove all uses of the return value of pci_read_config_*().
> Check the actual value read for ~0. In this case, ~0 is an invalid
> value thus it indicates some kind of error.
>
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> ---
>  drivers/gpio/gpio-amd8111.c |  7 +++++--
>  drivers/gpio/gpio-rdc321x.c | 21 ++++++++++++---------
>  2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpio/gpio-amd8111.c b/drivers/gpio/gpio-amd8111.c
> index fdcebe59510d..7b9882380cbc 100644
> --- a/drivers/gpio/gpio-amd8111.c
> +++ b/drivers/gpio/gpio-amd8111.c
> @@ -198,9 +198,12 @@ static int __init amd_gpio_init(void)
>         goto out;
>
>  found:
> -       err = pci_read_config_dword(pdev, 0x58, &gp.pmbase);
> -       if (err)
> +       pci_read_config_dword(pdev, 0x58, &gp.pmbase);
> +       if (gp.pmbase == (u32)~0) {
> +               err = -ENODEV;
>                 goto out;
> +       }
> +
>         err = -EIO;
>         gp.pmbase &= 0x0000FF00;
>         if (gp.pmbase == 0)
> diff --git a/drivers/gpio/gpio-rdc321x.c b/drivers/gpio/gpio-rdc321x.c
> index 01ed2517e9fd..03f1ff07b844 100644
> --- a/drivers/gpio/gpio-rdc321x.c
> +++ b/drivers/gpio/gpio-rdc321x.c
> @@ -85,10 +85,13 @@ static int rdc_gpio_config(struct gpio_chip *chip,
>         gpch = gpiochip_get_data(chip);
>
>         spin_lock(&gpch->lock);
> -       err = pci_read_config_dword(gpch->sb_pdev, gpio < 32 ?
> -                       gpch->reg1_ctrl_base : gpch->reg2_ctrl_base, &reg);
> -       if (err)
> +       pci_read_config_dword(gpch->sb_pdev,
> +                               (gpio < 32) ? gpch->reg1_ctrl_base
> +                                       : gpch->reg2_ctrl_base, &reg);
> +       if (reg == (u32)~0) {
> +               err = -ENODEV;
>                 goto unlock;
> +       }
>
>         reg |= 1 << (gpio & 0x1f);
>
> @@ -166,17 +169,17 @@ static int rdc321x_gpio_probe(struct platform_device *pdev)
>         /* This might not be, what others (BIOS, bootloader, etc.)
>            wrote to these registers before, but it's a good guess. Still
>            better than just using 0xffffffff. */
> -       err = pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
> +       pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
>                                         rdc321x_gpio_dev->reg1_data_base,
>                                         &rdc321x_gpio_dev->data_reg[0]);
> -       if (err)
> -               return err;
> +       if (rdc321x_gpio_dev->data_reg[0] == (u32)~0)
> +               return -ENODEV;
>
> -       err = pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
> +       pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
>                                         rdc321x_gpio_dev->reg2_data_base,
>                                         &rdc321x_gpio_dev->data_reg[1]);
> -       if (err)
> -               return err;
> +       if (rdc321x_gpio_dev->data_reg[1] == (u32)~0)
> +               return -ENODEV;
>
>         dev_info(&pdev->dev, "registering %d GPIOs\n",
>                                         rdc321x_gpio_dev->chip.ngpio);
> --
> 2.18.4
>

Bjorn,

I don't know the pci sub-system at all. Does this look good to you?

Bartosz
