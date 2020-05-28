Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD11E65C4
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 17:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404257AbgE1PRw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 11:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404174AbgE1PRu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 11:17:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB59C08C5C7
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2020 08:17:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x29so333037qtv.4
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2020 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NTxT7SWo10bLWzsYYLMLSj2S++ZQQ9kZCXxJXBg9QXs=;
        b=Dn8X0tkIJpKTiWHBNsNfGNHFv4edrTKiFETTXeGSAUOI5TlUjGrbsFWJ88T4uXQbGo
         HtAw9G2JzBzEfaSl9CIvhBmPuLTBK7tu7cLRBr8OXDYA0FRQoWoSkM40yEsW2jUgrHsV
         UvnrQYM1i28isbBuNrInzSMnvcu8+eX1eTcF+nHnXwVM21a2UNfZRZ277M8Ov91m8R2w
         3E/XOkCgsai1aXlT7UHmXWRvRGmJcQ3JlUk17ETinYtUkEx5nMUOBuBqGTdxSN3vWerg
         mKLnLKtbgR5ZEzVTjGKJ7yAId+3UUHHI3NS79Lvb+rX7rshoFWwKNhFN0S91YnZjIPEb
         RULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NTxT7SWo10bLWzsYYLMLSj2S++ZQQ9kZCXxJXBg9QXs=;
        b=IW477/1r+MsdDdoXMo4HK/WS9UlknCXZIqbOogd+rTvsPvA5boLsW3bsMFZKFxA9mL
         e319SDlXWSz2RbabzZOH+3ZVBAyt0w8IMZjHaw3pXrE6xQOrNuSKsaaZsHrVvzNDo0rZ
         6Lw9BuiJI9kfZKCCNKCLWtobLNx2gQQdQcr7ubaldeSiSyo5W5dL9RET8hDCQiDgijem
         DX4RHlGQiI/2ZTJx9y7tU6wkBK8cpbAaZ5i2rWXJxzkjoEqApPIy6Pu4yzRw/NClXbPB
         bYyfuaRDqa83QtMCnzORIfcTaGPhVatoAfZM20YIB88Ps38w/KWmkBgf2BkBG7SBkaeW
         yuAg==
X-Gm-Message-State: AOAM532Yb60d6Fpkwjdbdc+IYnfasGrgbjDXYIKGKMOaqHwdWZoAiPAB
        KBsDsuU3jWx1t9c6K4mT5Q3Q9f3CcFR0wiRzziNA/g==
X-Google-Smtp-Source: ABdhPJwXlR90R/EcOkFknrl1AodgKa8Dt5Y1gxQFThfX7WpNBrbmqzfzI08g+deBs0fNS1d4htvpCxXxNzXhQeDucpE=
X-Received: by 2002:ac8:2242:: with SMTP id p2mr3466417qtp.27.1590679069935;
 Thu, 28 May 2020 08:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200528094955.16483-1-saraon640529@gmail.com>
In-Reply-To: <20200528094955.16483-1-saraon640529@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 28 May 2020 17:17:39 +0200
Message-ID: <CAMpxmJUdmQoGo93HKOzR7NTLemhhLmUom-6f3YmG+=nm9WSiBA@mail.gmail.com>
Subject: Re: [PATCH] gpio:Add ASMedia 28xx and 18xx GPIO driver
To:     Richard Hsu <saraon640529@gmail.com>
Cc:     Richard_Hsu@asmedia.com.tw, Yd_Tseng@asmedia.com.tw,
        Jesse1_Chang@asmedia.com.tw,
        Linus Walleij <linus.walleij@linaro.org>, bhelgaas@google.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

czw., 28 maj 2020 o 11:50 Richard Hsu <saraon640529@gmail.com> napisa=C5=82=
(a):
>
> Hi Bartosz Golaszewski and Linux Walleij,
>   I have modified code and created a new patch correctly.
>

Thanks, this looks much better.

Please make the title be: "gpio: asm28xx-18xx: new driver".

> Hi Bjorn Helgass,
>   Thanks for your reply and suggestions.I will explain it more detail.
> 1.Why i select driver's framework based on AMD South Bridge(gpio-amd
> 8111.c)?
>  Our device is similar as it and it is not the specific gpio controller
> like others.We can't use plain pci_driver mechanism,as it is really
> multiple function,main driver that binds to the pci_device is a bus
> driver(descrbed in gpio-8111.c).This driver is almost the same with
> amd8111.The different parts is the gpio register accessing methods
> between io and pci configuration.
>

I have zero knowledge of the PCI sub-system but I'm seeing some PCI
MFD devices in drivers/mfd. Maybe this is what you're looking for?

> 2.What's special about asm28xx that means you need PM stuff when
> almost nobody else does?
>   Main driver of asm28xx is a bus driver.And when no device be added
> on,bridge sometimes will enter power saving state.other
> sub-system or driver can access it after wake it up(ex.proc_bus_pci_
> read() in drivers/pci/Proc.c).
>
> 3.We end up with multiple drivers controlling the device without
> any coordination between them(ex. PM)?
>   This driver just wake it up before accessing specific gpio
> registers.AP(RW) also wake device up before accessing register.
> That might not be a problem for this particular case.
>
> This driver is used for particular condition and work well.And
> driver framework is the same with related AMD8111.It perhaps
> can keep in the same driver framework and i really hope so.
>
> I am grateful for your assistance.
>
> Signed-off-by: Richard Hsu <saraon640529@gmail.com>
> ---
>  drivers/gpio/Kconfig             |   8 +
>  drivers/gpio/Makefile            |   1 +
>  drivers/gpio/gpio-asm28xx-18xx.c | 278 +++++++++++++++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  mode change 100644 =3D> 100755 drivers/gpio/Kconfig
>  mode change 100644 =3D> 100755 drivers/gpio/Makefile
>  create mode 100755 drivers/gpio/gpio-asm28xx-18xx.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> old mode 100644
> index 1b96169d84f7..0676082efcb7
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -113,6 +113,14 @@ config GPIO_AMDPT
>           driver for GPIO functionality on Promontory IOHub
>           Require ACPI ASL code to enumerate as a platform device.
>
> +config GPIO_ASM28XX
> +       tristate "Asmedia 28XX/18XX GPIO support"
> +       depends on PCI
> +       select GPIO_GENERIC
> +       help
> +         Driver for GPIO functionality on Asmedia 28XX and 18XX PCI-E Br=
idge.
> +

Please remove all double newlines here and in the driver source code.

I'm not reviewing the rest of the driver on purpose: I'm 90% sure that
this device should be probed like a regular device in the linux driver
model. I'll review the code once we've sorted that out.

Bartosz
