Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3D15C4E8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 16:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgBMPvn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 10:51:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50674 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgBMP0L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 10:26:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so6709684wmb.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3z0GeNna29gwRdMMOKl3LqQuwXqLwU33hOnQJ+7Vb0=;
        b=KzwM0hCK5nh55Ewb3efIHVrhUtAv0ETsT0xyEaZwnKFX5LhYzyzCPFrg5IGsoc2CTZ
         EDKjPafC21JsM4cR3VWC/I3BoXkd5zGhgJ0KHoJesPnyl/vX2zjDPrT6To6zZdoKwnEP
         BuynLs+Io3t1+QfAcvqiY/hC5knCYY+I62i1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3z0GeNna29gwRdMMOKl3LqQuwXqLwU33hOnQJ+7Vb0=;
        b=pjv79IXz89zriaRtPFn9XXVSEjXOqSu60eJSZrMnH4GDd4yxZjQydLzcAhMH63E0Wn
         LyTMDSymDn4o+vO8PzueRcG1yVsHnsVLaO0VLqXxoJDimXs723Uo1sRFl3xKdS5N3JYv
         6C1c45FYJhB7Z6gfM+R3H1ZrdqOy4Kxc+Z4tvAAKvhZNyt8t/ctzVaV7lRvlfcj/Gzr2
         4YyMs8BC13KBvIuFwYd3XSr58pxFldSOkiyfCEfqgBwtgbvWHFR0CmIuz6tbGyacXhVS
         AYQNKghF7usM7NR/pa+B7auQYFpDNMRfoNhIAI88ph6wYN8Pu2Za7WTHqEGRl7mEdmFG
         RCLQ==
X-Gm-Message-State: APjAAAVTKH7GkXqvd+jfBxfFdTtPJYA5v1/40MeUrSDItWAUuPD0k/AP
        +5Ot0/ZW894wAIIGyEukcasCdAwH1BnmHuu2puH6yQ==
X-Google-Smtp-Source: APXvYqw7LJ3y9EC/0ec46LvdlfSV1Ie8xgbuyVlK3yn3UmXw3YpS8twtFHNDErOnjjs7+s/ie9sogvRAdemhZOmdHZk=
X-Received: by 2002:a7b:c183:: with SMTP id y3mr6063317wmi.45.1581607568832;
 Thu, 13 Feb 2020 07:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20200213025930.27943-1-jaedon.shin@gmail.com> <20200213025930.27943-3-jaedon.shin@gmail.com>
In-Reply-To: <20200213025930.27943-3-jaedon.shin@gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 13 Feb 2020 10:25:57 -0500
Message-ID: <CA+-6iNzj46rrd1=i_0oO5mOzP-KUxkxPRd=Qb0mX2fAJnt9Zpw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: brcmstb: Add regulator support
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 12, 2020 at 9:59 PM Jaedon Shin <jaedon.shin@gmail.com> wrote:
>
> ARM-based Broadcom STB SoCs have GPIO-based voltage regulator for PCIe
> turning off/on power supplies.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/gpio/gpio-brcmstb.c           | 13 ++++-
>  drivers/pci/controller/pcie-brcmstb.c | 76 +++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
> index 05e3f99ae59c..0cee5fcd2782 100644
> --- a/drivers/gpio/gpio-brcmstb.c
> +++ b/drivers/gpio/gpio-brcmstb.c
> @@ -777,7 +777,18 @@ static struct platform_driver brcmstb_gpio_driver = {
>         .remove = brcmstb_gpio_remove,
>         .shutdown = brcmstb_gpio_shutdown,
>  };
> -module_platform_driver(brcmstb_gpio_driver);
> +
> +static int __init brcmstb_gpio_init(void)
> +{
> +       return platform_driver_register(&brcmstb_gpio_driver);
> +}
> +subsys_initcall(brcmstb_gpio_init);
> +
> +static void __exit brcmstb_gpio_exit(void)
> +{
> +       platform_driver_unregister(&brcmstb_gpio_driver);
> +}
> +module_exit(brcmstb_gpio_exit);
>
>  MODULE_AUTHOR("Gregory Fong");
>  MODULE_DESCRIPTION("Driver for Broadcom BRCMSTB SoC UPG GPIO");
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 34581a6a7313..0e0ca39a680b 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/printk.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -173,8 +174,79 @@ struct brcm_pcie {
>         int                     gen;
>         u64                     msi_target_addr;
>         struct brcm_msi         *msi;
> +#ifdef CONFIG_REGULATOR
> +       int                     num_regs;
> +       struct regulator        **regs;
> +#endif
>  };
Hi,
Just a nit but I would lean towards using 'regulator' as opposed to
'reg', as the 'reg' term's common association is  'register'.  You
don't seem to be anywhere near the 80-col limit on your code so that
doesn't seem to be an issue.
Thanks,
Jim
>
> +#ifdef CONFIG_REGULATOR
> +static void brcm_pcie_regulator_enable(struct brcm_pcie *pcie)
> +{
> +       int i, ret;
> +
> +       for (i = 0; i < pcie->num_regs; i++) {
> +               if (!pcie->regs[i])
> +                       continue;
> +
> +               ret = regulator_enable(pcie->regs[i]);
> +               if (ret)
> +                       dev_err(pcie->dev, "Failed to enable regulator\n");
> +       }
> +}
> +
> +static void brcm_pcie_regulator_disable(struct brcm_pcie *pcie)
> +{
> +       int i, ret;
> +
> +       for (i = 0; i < pcie->num_regs; i++) {
> +               if (!pcie->regs[i])
> +                       continue;
> +
> +               ret = regulator_disable(pcie->regs[i]);
> +               if (ret)
> +                       dev_err(pcie->dev, "Failed to disable regulator\n");
> +       }
> +}
> +
> +static void brcm_pcie_regulator_init(struct brcm_pcie *pcie)
> +{
> +       struct device_node *np = pcie->dev->of_node;
> +       struct device *dev = pcie->dev;
> +       const char *name;
> +       struct regulator *reg;
> +       int i;
> +
> +       pcie->num_regs = of_property_count_strings(np, "supply-names");
> +       if (pcie->num_regs <= 0) {
> +               pcie->num_regs = 0;
> +               return;
> +       }
> +
> +       pcie->regs = devm_kcalloc(dev, pcie->num_regs, sizeof(pcie->regs[0]),
> +                                 GFP_KERNEL);
> +       if (!pcie->regs) {
> +               pcie->num_regs = 0;
> +               return;
> +       }
> +
> +       for (i = 0; i < pcie->num_regs; i++) {
> +               if (of_property_read_string_index(np, "supply-names", i, &name))
> +                       continue;
> +
> +               reg = devm_regulator_get_optional(dev, name);
> +               if (IS_ERR(reg))
> +                       continue;
> +
> +               pcie->regs[i] = reg;
> +       }
> +}
> +#else
> +static inline void brcm_pcie_regulator_enable(struct brcm_pcie *pcie) { }
> +static inline void brcm_pcie_regulator_disable(struct brcm_pcie *pcie) { }
> +static inline void brcm_pcie_regulator_init(struct brcm_pcie *pcie) { }
> +#endif
> +
>  /*
>   * This is to convert the size of the inbound "BAR" region to the
>   * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
> @@ -898,6 +970,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>  {
>         brcm_msi_remove(pcie);
>         brcm_pcie_turn_off(pcie);
> +       brcm_pcie_regulator_disable(pcie);
>         clk_disable_unprepare(pcie->clk);
>         clk_put(pcie->clk);
>  }
> @@ -955,6 +1028,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       brcm_pcie_regulator_init(pcie);
> +       brcm_pcie_regulator_enable(pcie);
> +
>         ret = brcm_pcie_setup(pcie);
>         if (ret)
>                 goto fail;
> --
> 2.21.0
>
