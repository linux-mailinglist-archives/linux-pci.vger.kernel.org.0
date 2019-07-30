Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA17B555
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2019 23:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbfG3V4a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jul 2019 17:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387630AbfG3V4a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jul 2019 17:56:30 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D24672067D;
        Tue, 30 Jul 2019 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564523788;
        bh=3RjKuBNK6iJwGQYzm4u3Tg3Ye0rW1o3Fq7uPfncfUSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bnhk5d/5ca4U8xEs8I0CjpEIpq6Kzvbif9gN11zczZV6QHg3mcrU0IRCAq9UbLEAm
         Oko2Y3px1qQCDRQgOHk0FN+Wr07AJZpqih5xdAuW+DhA1MLFCzLo8fOwCZnNmanS9E
         ZyxuAHdOBF7tAsHRx3GNrtlkW1+0qnFoHvYI3f0c=
Date:   Tue, 30 Jul 2019 16:56:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v6 31/57] pci: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190730215626.GA151852@google.com>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-32-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-32-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo, maintainer of native host bridge drivers]
[+cc maintainers of drivers with additional questions below]

Please run "git log --oneline drivers/pci/controller" and match the
style, e.g.,

  PCI: Remove dev_err() usage after platform_get_irq()

On Tue, Jul 30, 2019 at 11:15:31AM -0700, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.

Lorenzo will take care of this, but it looks good to me.

I *would* like to include the reference for the commit that added the
error message in platform_get_irq() (or maybe it's in something
*called* by platform_get_irq() -- I didn't bother to dig deeper).  But
folks might care about making sure that message is there before
back-porting this patch.

There are a few comments below, but they don't affect *this* patch;
they're incidental comments for things in the context lines that look
wrong.

So, after fixing the subject and adding the commit reference, you can
add my

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please apply directly to subsystem trees
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c     |  8 ++------
>  drivers/pci/controller/dwc/pci-exynos.c     |  8 ++------
>  drivers/pci/controller/dwc/pci-imx6.c       |  4 +---
>  drivers/pci/controller/dwc/pci-keystone.c   |  4 +---
>  drivers/pci/controller/dwc/pci-meson.c      |  4 +---
>  drivers/pci/controller/dwc/pcie-armada8k.c  |  4 +---
>  drivers/pci/controller/dwc/pcie-artpec6.c   |  4 +---
>  drivers/pci/controller/dwc/pcie-histb.c     |  4 +---
>  drivers/pci/controller/dwc/pcie-kirin.c     |  5 +----
>  drivers/pci/controller/dwc/pcie-spear13xx.c |  4 +---
>  drivers/pci/controller/pci-tegra.c          |  8 ++------
>  drivers/pci/controller/pci-v3-semi.c        |  4 +---
>  drivers/pci/controller/pci-xgene-msi.c      |  2 --
>  drivers/pci/controller/pcie-altera-msi.c    |  1 -
>  drivers/pci/controller/pcie-altera.c        |  4 +---
>  drivers/pci/controller/pcie-mobiveil.c      |  4 +---
>  drivers/pci/controller/pcie-rockchip-host.c | 12 +++---------
>  drivers/pci/controller/pcie-tango.c         |  4 +---
>  drivers/pci/controller/pcie-xilinx-nwl.c    | 11 ++---------
>  19 files changed, 23 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 4234ddb4722f..5ab34ce963f1 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -462,10 +462,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  	struct resource *res;
>  
>  	pp->irq = platform_get_irq(pdev, 1);
> -	if (pp->irq < 0) {
> -		dev_err(dev, "missing IRQ resource\n");
> +	if (pp->irq < 0)
>  		return pp->irq;
> -	}
>  
>  	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
>  			       IRQF_SHARED | IRQF_NO_THREAD,
> @@ -713,10 +711,8 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	pci->ops = &dw_pcie_ops;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "missing IRQ resource: %d\n", irq);
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
>  	base = devm_ioremap_nocache(dev, res->start, resource_size(res));
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index cee5f2f590e2..a3e005b5f93d 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -402,10 +402,8 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
>  	int ret;
>  
>  	pp->irq = platform_get_irq(pdev, 1);
> -	if (pp->irq < 0) {
> -		dev_err(dev, "failed to get irq\n");
> +	if (pp->irq < 0)
>  		return pp->irq;
> -	}
>  	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
>  				IRQF_SHARED, "exynos-pcie", ep);
>  	if (ret) {
> @@ -415,10 +413,8 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		pp->msi_irq = platform_get_irq(pdev, 0);
> -		if (pp->msi_irq < 0) {
> -			dev_err(dev, "failed to get msi irq\n");
> +		if (pp->msi_irq < 0)
>  			return pp->msi_irq;
> -		}
>  	}
>  
>  	pp->ops = &exynos_pcie_host_ops;
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 9b5cb5b70389..a969ec82ca5f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -867,10 +867,8 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> -		if (pp->msi_irq <= 0) {
> -			dev_err(dev, "failed to get MSI irq\n");
> +		if (pp->msi_irq <= 0)
>  			return -ENODEV;

Why does this return -ENODEV when most of the others return the error
from platform_get_irq()?  Obviously *this* patch is fine; the possible
return change is material for a different patch.

> -		}
>  	}
>  
>  	pp->ops = &imx6_pcie_host_ops;
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index af677254a072..3878208cfd44 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1247,10 +1247,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	pci->version = version;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "missing IRQ resource: %d\n", irq);
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
>  			  "ks-pcie-error-irq", ks_pcie);
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index e35e9eaa50ee..419c30034dc8 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -500,10 +500,8 @@ static int meson_add_pcie_port(struct meson_pcie *mp,
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		pp->msi_irq = platform_get_irq(pdev, 0);
> -		if (pp->msi_irq < 0) {
> -			dev_err(dev, "failed to get MSI IRQ\n");
> +		if (pp->msi_irq < 0)
>  			return pp->msi_irq;
> -		}
>  	}
>  
>  	pp->ops = &meson_pcie_host_ops;
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 3d55dc78d999..33309ce70ad5 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -249,10 +249,8 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
>  	pp->ops = &armada8k_pcie_host_ops;
>  
>  	pp->irq = platform_get_irq(pdev, 0);
> -	if (pp->irq < 0) {
> -		dev_err(dev, "failed to get irq for port\n");
> +	if (pp->irq < 0)
>  		return pp->irq;
> -	}
>  
>  	ret = devm_request_irq(dev, pp->irq, armada8k_pcie_irq_handler,
>  			       IRQF_SHARED, "armada8k-pcie", pcie);
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index d00252bd8fae..7fa7f8d134b6 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -393,10 +393,8 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> -		if (pp->msi_irq < 0) {
> -			dev_err(dev, "failed to get MSI irq\n");
> +		if (pp->msi_irq < 0)
>  			return pp->msi_irq;
> -		}
>  	}
>  
>  	pp->ops = &artpec6_pcie_host_ops;
> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> index 954bc2b74bbc..6612072bd720 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -402,10 +402,8 @@ static int histb_pcie_probe(struct platform_device *pdev)
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> -		if (pp->msi_irq < 0) {
> -			dev_err(dev, "Failed to get MSI IRQ\n");
> +		if (pp->msi_irq < 0)
>  			return pp->msi_irq;
> -		}
>  	}
>  
>  	hipcie->phy = devm_phy_get(dev, "phy");
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 8df1914226be..dc08551e3f8d 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -455,11 +455,8 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		irq = platform_get_irq(pdev, 0);
> -		if (irq < 0) {
> -			dev_err(&pdev->dev,
> -				"failed to get MSI IRQ (%d)\n", irq);
> +		if (irq < 0)
>  			return irq;
> -		}
>  
>  		pci->pp.msi_irq = irq;
>  	}
> diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
> index 7d0cdfd8138b..26d3a734ce0d 100644
> --- a/drivers/pci/controller/dwc/pcie-spear13xx.c
> +++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
> @@ -198,10 +198,8 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
>  	int ret;
>  
>  	pp->irq = platform_get_irq(pdev, 0);
> -	if (pp->irq < 0) {
> -		dev_err(dev, "failed to get irq\n");
> +	if (pp->irq < 0)
>  		return pp->irq;
> -	}
>  	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
>  			       IRQF_SHARED | IRQF_NO_THREAD,
>  			       "spear1340-pcie", spear13xx_pcie);
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 9a917b2456f6..43b6e0848b91 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -1549,10 +1549,8 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>  
>  	/* request interrupt */
>  	err = platform_get_irq_byname(pdev, "intr");
> -	if (err < 0) {
> -		dev_err(dev, "failed to get IRQ: %d\n", err);
> +	if (err < 0)
>  		goto phys_put;
> -	}
>  
>  	pcie->irq = err;
>  
> @@ -1767,10 +1765,8 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
>  	}
>  
>  	err = platform_get_irq_byname(pdev, "msi");
> -	if (err < 0) {
> -		dev_err(dev, "failed to get IRQ: %d\n", err);
> +	if (err < 0)
>  		goto free_irq_domain;
> -	}
>  
>  	msi->irq = err;
>  
> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> index d219404bad92..7c9d898cde71 100644
> --- a/drivers/pci/controller/pci-v3-semi.c
> +++ b/drivers/pci/controller/pci-v3-semi.c
> @@ -804,10 +804,8 @@ static int v3_pci_probe(struct platform_device *pdev)
>  
>  	/* Get and request error IRQ resource */
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(dev, "unable to obtain PCIv3 error IRQ\n");
> +	if (irq <= 0)

Why does this test for <= 0 when all the others test for < 0?  Again,
obviously that would be material for a separate patch.

>  		return -ENODEV;
> -	}
>  	ret = devm_request_irq(dev, irq, v3_irq, 0,
>  			"PCIv3 error", v3);
>  	if (ret < 0) {
> diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
> index f4c02da84e59..02271c6d17a1 100644
> --- a/drivers/pci/controller/pci-xgene-msi.c
> +++ b/drivers/pci/controller/pci-xgene-msi.c
> @@ -478,8 +478,6 @@ static int xgene_msi_probe(struct platform_device *pdev)
>  	for (irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
>  		virt_msir = platform_get_irq(pdev, irq_index);
>  		if (virt_msir < 0) {
> -			dev_err(&pdev->dev, "Cannot translate IRQ index %d\n",
> -				irq_index);
>  			rc = virt_msir;
>  			goto error;
>  		}
> diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
> index 16d938920ca5..bec666eda1eb 100644
> --- a/drivers/pci/controller/pcie-altera-msi.c
> +++ b/drivers/pci/controller/pcie-altera-msi.c
> @@ -256,7 +256,6 @@ static int altera_msi_probe(struct platform_device *pdev)
>  
>  	msi->irq = platform_get_irq(pdev, 0);
>  	if (msi->irq < 0) {
> -		dev_err(&pdev->dev, "failed to map IRQ: %d\n", msi->irq);
>  		ret = msi->irq;
>  		goto err;
>  	}
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index d2497ca43828..0ef01b06efda 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -747,10 +747,8 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
>  
>  	/* setup IRQ */
>  	pcie->irq = platform_get_irq(pdev, 0);
> -	if (pcie->irq < 0) {
> -		dev_err(dev, "failed to get IRQ: %d\n", pcie->irq);
> +	if (pcie->irq < 0)
>  		return pcie->irq;
> -	}
>  
>  	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
>  	return 0;
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 672e633601c7..34400ea5a7c3 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -453,10 +453,8 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  		pcie->ppio_wins = MAX_PIO_WINDOWS;
>  
>  	pcie->irq = platform_get_irq(pdev, 0);
> -	if (pcie->irq <= 0) {
> -		dev_err(dev, "failed to map IRQ: %d\n", pcie->irq);
> +	if (pcie->irq <= 0)
>  		return -ENODEV;

Why -ENODEV instead of the failure returned by platform_get_irq()?
And why <= 0 instead of < 0?

> -	}
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 8d20f1793a61..edbf872a76d5 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -549,10 +549,8 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
>  	struct platform_device *pdev = to_platform_device(dev);
>  
>  	irq = platform_get_irq_byname(pdev, "sys");
> -	if (irq < 0) {
> -		dev_err(dev, "missing sys IRQ resource\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
>  			       IRQF_SHARED, "pcie-sys", rockchip);
> @@ -562,20 +560,16 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
>  	}
>  
>  	irq = platform_get_irq_byname(pdev, "legacy");
> -	if (irq < 0) {
> -		dev_err(dev, "missing legacy IRQ resource\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	irq_set_chained_handler_and_data(irq,
>  					 rockchip_pcie_legacy_int_handler,
>  					 rockchip);
>  
>  	irq = platform_get_irq_byname(pdev, "client");
> -	if (irq < 0) {
> -		dev_err(dev, "missing client IRQ resource\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
>  			       IRQF_SHARED, "pcie-client", rockchip);
> diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
> index 21a208da3f59..b87aa9041480 100644
> --- a/drivers/pci/controller/pcie-tango.c
> +++ b/drivers/pci/controller/pcie-tango.c
> @@ -273,10 +273,8 @@ static int tango_pcie_probe(struct platform_device *pdev)
>  		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
>  
>  	virq = platform_get_irq(pdev, 1);
> -	if (virq <= 0) {
> -		dev_err(dev, "Failed to map IRQ\n");
> +	if (virq <= 0)
>  		return -ENXIO;

Why <= 0 and -ENXIO?

> -	}
>  
>  	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
>  	if (!irq_dom) {
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 45c0f344ccd1..743244db09d1 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -586,7 +586,6 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
>  	/* Get msi_1 IRQ number */
>  	msi->irq_msi1 = platform_get_irq_byname(pdev, "msi1");
>  	if (msi->irq_msi1 < 0) {
> -		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi1);
>  		ret = -EINVAL;

Why -EINVAL instead of error from platform_get_irq_byname()?

>  		goto err;
>  	}
> @@ -597,7 +596,6 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
>  	/* Get msi_0 IRQ number */
>  	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
>  	if (msi->irq_msi0 < 0) {
> -		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi0);
>  		ret = -EINVAL;

Again.

>  		goto err;
>  	}
> @@ -728,11 +726,8 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  
>  	/* Get misc IRQ number */
>  	pcie->irq_misc = platform_get_irq_byname(pdev, "misc");
> -	if (pcie->irq_misc < 0) {
> -		dev_err(dev, "failed to get misc IRQ %d\n",
> -			pcie->irq_misc);
> +	if (pcie->irq_misc < 0)
>  		return -EINVAL;

Again.

> -	}
>  
>  	err = devm_request_irq(dev, pcie->irq_misc,
>  			       nwl_pcie_misc_handler, IRQF_SHARED,
> @@ -797,10 +792,8 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
>  
>  	/* Get intx IRQ number */
>  	pcie->irq_intx = platform_get_irq_byname(pdev, "intx");
> -	if (pcie->irq_intx < 0) {
> -		dev_err(dev, "failed to get intx IRQ %d\n", pcie->irq_intx);
> +	if (pcie->irq_intx < 0)
>  		return pcie->irq_intx;
> -	}
>  
>  	irq_set_chained_handler_and_data(pcie->irq_intx,
>  					 nwl_pcie_leg_handler, pcie);
> -- 
> Sent by a computer through tubes
> 
