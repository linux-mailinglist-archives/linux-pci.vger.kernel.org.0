Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECA6D165C73
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2020 12:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgBTLIM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 06:08:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56041 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgBTLIL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2020 06:08:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so1517947wmj.5;
        Thu, 20 Feb 2020 03:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ar2G2uxRG/czZkeC4MUfsnBfTqnZVt+SalROTcfSNAY=;
        b=LdSMyATcrqVq+1wkPrk2DT2ZfZt2yYVUkGrN3dZc2e9GCaYjFW2jfg6adajl9cTeR0
         Sh46U1Lcksm7ZWGzs9357FvencneOf4Dp7RBf084zYNUYdX4qccvc8UnIwJf5oim0agh
         LWbiNjL8OUKDNZtHvK9cY5QCnjbIBhUkorV/r3rF+Frpkmt0cwXzR5YsCFboiMgcAEiy
         t8UhNn8EQJIZfgdjftYudM4OBUMDpguUrTzk5yE64pCoD2MRltDerrR9/n/PT5Ef+mGg
         rdEU4d3BkHzR9UiwvQQu3JIRYqedO1eikPrL4Boi/NNf355DcVTNDVgYXX9VLinZdRyz
         Q24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ar2G2uxRG/czZkeC4MUfsnBfTqnZVt+SalROTcfSNAY=;
        b=pUDFnu8gdTBs2R0J6WmXV4Lyghf0VlaepQFqttnwwcil8vPUNeqXK2HNMyH/KM5LpB
         GtGLGMaQQSlIBRKLCMvXr4OoIGnvIrBPVC5sa5Pvz8dNeaIyoy0QSxkLHylXCwbD+MFv
         ztPj2heieAkSIov3GpkGH6M8fw+bRRzbWFy3hD0zndnQqrBNsqpFHoMX94xOJQ76sMml
         PcAVcoUvjgW+L/rWE4gC/Iwxl3KKzC56Te4CmouullmRkWQM3P4aeUxh8rUyAl6wnpW1
         Ili9sNwAQC08q/VoCWJGz2seqVegrjgmyFqepwEzLoFoU24sDy5H2lW/UK36f55g6pzj
         hERQ==
X-Gm-Message-State: APjAAAWdoceqrg+4qFH3ktnje9y5PrCFTEVsctYLUNxgwv/vFDrrZXJi
        yhvVHyp64KbkfQlaxWWBHSt2i8Fxq/bZJqh4pFs=
X-Google-Smtp-Source: APXvYqwdc8JQs/LddLHuBYujJ23zXBp/eT+FPZZtoMagGjYaa1MnuIvWCAZ57NpM1eGriyGn0BTbc3wrw1d/1bZ5oYw=
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr3838372wma.89.1582196889370;
 Thu, 20 Feb 2020 03:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20200213025930.27943-1-jaedon.shin@gmail.com> <20200213025930.27943-3-jaedon.shin@gmail.com>
 <aaa85a4d-8b36-893e-3e7a-dc27b4d6bae5@gmail.com>
In-Reply-To: <aaa85a4d-8b36-893e-3e7a-dc27b4d6bae5@gmail.com>
From:   Gregory Fong <gregory.0xf0@gmail.com>
Date:   Thu, 20 Feb 2020 03:07:41 -0800
Message-ID: <CADtm3G40-2EQcQxisiDTd=DkPbMP4gCi4E5TsvDRL6ph51TEVQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: brcmstb: Add regulator support
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 12, 2020 at 7:58 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 2/12/2020 6:59 PM, Jaedon Shin wrote:
> > ARM-based Broadcom STB SoCs have GPIO-based voltage regulator for PCIe
> > turning off/on power supplies.
> >
> > Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> > ---
> >  drivers/gpio/gpio-brcmstb.c           | 13 ++++-
> >  drivers/pci/controller/pcie-brcmstb.c | 76 +++++++++++++++++++++++++++
> >  2 files changed, 88 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
> > index 05e3f99ae59c..0cee5fcd2782 100644
> > --- a/drivers/gpio/gpio-brcmstb.c
> > +++ b/drivers/gpio/gpio-brcmstb.c
> > @@ -777,7 +777,18 @@ static struct platform_driver brcmstb_gpio_driver = {
> >       .remove = brcmstb_gpio_remove,
> >       .shutdown = brcmstb_gpio_shutdown,
> >  };
> > -module_platform_driver(brcmstb_gpio_driver);
> > +
> > +static int __init brcmstb_gpio_init(void)
> > +{
> > +     return platform_driver_register(&brcmstb_gpio_driver);
> > +}
> > +subsys_initcall(brcmstb_gpio_init);
> > +
> > +static void __exit brcmstb_gpio_exit(void)
> > +{
> > +     platform_driver_unregister(&brcmstb_gpio_driver);
> > +}
> > +module_exit(brcmstb_gpio_exit);
>
> We do this in the downstream tree, but there is no reason, we should
> just deal with EPROBE_DEFER being returned from the regulator subsystem
> until the GPIO provide is available.
>

Agreed, also see this thread from January 2016:
https://lore.kernel.org/linux-mips/568EAA99.1020603@gmail.com/

Best regards,
Gregory
