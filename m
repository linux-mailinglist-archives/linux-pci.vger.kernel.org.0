Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9342C2B0780
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 15:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgKLOWq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 09:22:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33324 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOWq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 09:22:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id i18so5735407ots.0;
        Thu, 12 Nov 2020 06:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1znkW0HgEmiXsc2ZQpjRgzk+7RYxqagCkZTU6WnPcc=;
        b=aor+YjBHW1tM8JLxDqw7SzS8mDY5E2d/aywqHR+YfezCjXZbULbJgutJbNycaSq40j
         Iw/bhvYC8Pyx8LSQWFmvJGOVJ+owj8BZRLNi8IKkiqtvj4il7bBdcDej3DxZlIoZaacB
         Yc1hwyjsNnaTMebLTe8zzM1BwYXOhCT5fOgCMjvaSN80O/ZsCqe3UZLBiMDuz3d53nA8
         ksSYcof7kn95JOlNJnrBFYZVid6KGRhaxiwSuJ1B01fKmwQh6VTffq3CPYkb0+scUjd1
         iqEjtjGLu2ZDNlQGaDPETLfh9UiS0ncMOBR2AWoDKET5vaagHMIaADkLRWd2Z5tSdYcY
         +fAQ==
X-Gm-Message-State: AOAM533CERCg6qwS7DQ2VtX28QyXDGCVJs8JYVNpNpxBtpxObe7ZOMFI
        krdLbgH4Vr6nbBziHecNDyGP9J1nJh1J8EPUtmQ=
X-Google-Smtp-Source: ABdhPJxmEcMZsihNWgfhAAZu+ZePZFUBi7ZntIAUm1alRFg5RTF09I9+pS/f1kS1nIAGWm1u1j5Cy9ZYhWq54liz2s4=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr21221022otc.145.1605190965038;
 Thu, 12 Nov 2020 06:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20200528161510.31935-1-zhengdejin5@gmail.com>
In-Reply-To: <20200528161510.31935-1-zhengdejin5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Nov 2020 15:22:33 +0100
Message-ID: <CAMuHMdWXf-AB4ZKHkvpEKwTVj-qjV9TDk67QV2F+8X8dU8X5rA@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: dwc: convert to devm_platform_ioremap_resource_byname()
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dejin,

On Thu, May 28, 2020 at 6:18 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> Use devm_platform_ioremap_resource_byname() to simplify codes.
> it contains platform_get_resource_byname() and devm_ioremap_resource().
>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Thanks for your patch, which is now commit 936fa5cd7b8e3e2a ("PCI: dwc:
Convert to devm_platform_ioremap_resource_byname()") in v5.9.

> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -593,13 +593,12 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
>         ep = &pci->ep;
>         ep->ops = &pcie_ep_ops;
>
> -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
> -       pci->dbi_base = devm_ioremap_resource(dev, res);
> +       pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "ep_dbics");
>         if (IS_ERR(pci->dbi_base))
>                 return PTR_ERR(pci->dbi_base);
>
> -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
> -       pci->dbi_base2 = devm_ioremap_resource(dev, res);
> +       pci->dbi_base2 =
> +               devm_platform_ioremap_resource_byname(pdev, "ep_dbics2");
>         if (IS_ERR(pci->dbi_base2))
>                 return PTR_ERR(pci->dbi_base2);

The part above looks fine.

> @@ -626,7 +625,6 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>         struct dw_pcie *pci = dra7xx->pci;
>         struct pcie_port *pp = &pci->pp;
>         struct device *dev = pci->dev;
> -       struct resource *res;
>
>         pp->irq = platform_get_irq(pdev, 1);
>         if (pp->irq < 0) {
> @@ -638,8 +636,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>         if (ret < 0)
>                 return ret;
>
> -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
> -       pci->dbi_base = devm_ioremap_resource(dev, res);
> +       pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "rc_dbics");

Are you sure this is equivalent?
Before, devm_ioremap_resource() was called on "dev" (= pci->dev),
after it is called on "&pdev->dev" .

> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -253,11 +253,9 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
>         struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
>         struct dw_pcie *pci = &lpp->pci;
>         struct device *dev = pci->dev;
> -       struct resource *res;
>         int ret;
>
> -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> -       pci->dbi_base = devm_ioremap_resource(dev, res);
> +       pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");

Same  issue here...

>         if (IS_ERR(pci->dbi_base))
>                 return PTR_ERR(pci->dbi_base);
>
> @@ -291,8 +289,7 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
>         ret = of_pci_get_max_link_speed(dev->of_node);
>         lpp->link_gen = ret < 0 ? 0 : ret;
>
> -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> -       lpp->app_base = devm_ioremap_resource(dev, res);
> +       lpp->app_base = devm_platform_ioremap_resource_byname(pdev, "app");
>         if (IS_ERR(lpp->app_base))
>                 return PTR_ERR(lpp->app_base);

... and here.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
