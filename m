Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7AE216DDC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGGNhQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 09:37:16 -0400
Received: from foss.arm.com ([217.140.110.172]:50238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGNhP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 09:37:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 227D5C0A;
        Tue,  7 Jul 2020 06:37:15 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79CE93F71E;
        Tue,  7 Jul 2020 06:37:13 -0700 (PDT)
Date:   Tue, 7 Jul 2020 14:37:07 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     jingoohan1@gmail.com, robh@kernel.org, bhelgaas@google.com,
        kgene@kernel.org, thomas.petazzoni@bootlin.com,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        jquinlan@broadcom.com, krzk@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: controller: convert to
 devm_platform_ioremap_resource()
Message-ID: <20200707133707.GA17163@e121166-lin.cambridge.arm.com>
References: <20200526160110.31898-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526160110.31898-1-zhengdejin5@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 27, 2020 at 12:01:10AM +0800, Dejin Zheng wrote:
> use devm_platform_ioremap_resource() to simplify code, it
> contains platform_get_resource() and devm_ioremap_resource().
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 4 +---
>  drivers/pci/controller/pci-aardvark.c   | 5 ++---
>  drivers/pci/controller/pci-ftpci100.c   | 4 +---
>  drivers/pci/controller/pci-versatile.c  | 6 ++----
>  drivers/pci/controller/pcie-brcmstb.c   | 4 +---
>  5 files changed, 7 insertions(+), 16 deletions(-)

Can you rebase it please against:

git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/misc

I will apply it then (please carry over the review tags).

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index c5043d951e80..5791039d6a54 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -84,14 +84,12 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
>  {
>  	struct dw_pcie *pci = ep->pci;
>  	struct device *dev = pci->dev;
> -	struct resource *res;
>  
>  	ep->mem_res = devm_kzalloc(dev, sizeof(*ep->mem_res), GFP_KERNEL);
>  	if (!ep->mem_res)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	ep->mem_res->elbi_base = devm_ioremap_resource(dev, res);
> +	ep->mem_res->elbi_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(ep->mem_res->elbi_base))
>  		return PTR_ERR(ep->mem_res->elbi_base);
>  
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 90ff291c24f0..0d98f9b04daa 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1105,7 +1105,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct advk_pcie *pcie;
> -	struct resource *res, *bus;
> +	struct resource *bus;
>  	struct pci_host_bridge *bridge;
>  	int ret, irq;
>  
> @@ -1116,8 +1116,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	pcie = pci_host_bridge_priv(bridge);
>  	pcie->pdev = pdev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	pcie->base = devm_ioremap_resource(dev, res);
> +	pcie->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcie->base))
>  		return PTR_ERR(pcie->base);
>  
> diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
> index 1b67564de7af..221dfc9dc81b 100644
> --- a/drivers/pci/controller/pci-ftpci100.c
> +++ b/drivers/pci/controller/pci-ftpci100.c
> @@ -422,7 +422,6 @@ static int faraday_pci_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	const struct faraday_pci_variant *variant =
>  		of_device_get_match_data(dev);
> -	struct resource *regs;
>  	struct resource_entry *win;
>  	struct faraday_pci *p;
>  	struct resource *io;
> @@ -465,8 +464,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	p->base = devm_ioremap_resource(dev, regs);
> +	p->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(p->base))
>  		return PTR_ERR(p->base);
>  
> diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
> index b911359b6d81..b34bbfe611e7 100644
> --- a/drivers/pci/controller/pci-versatile.c
> +++ b/drivers/pci/controller/pci-versatile.c
> @@ -77,13 +77,11 @@ static int versatile_pci_probe(struct platform_device *pdev)
>  	if (!bridge)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	versatile_pci_base = devm_ioremap_resource(dev, res);
> +	versatile_pci_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(versatile_pci_base))
>  		return PTR_ERR(versatile_pci_base);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	versatile_cfg_base[0] = devm_ioremap_resource(dev, res);
> +	versatile_cfg_base[0] = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(versatile_cfg_base[0]))
>  		return PTR_ERR(versatile_cfg_base[0]);
>  
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 7730ea845ff2..04bbf9b40193 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -934,7 +934,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	struct device_node *fw_np;
>  	struct brcm_pcie *pcie;
>  	struct pci_bus *child;
> -	struct resource *res;
>  	int ret;
>  
>  	/*
> @@ -959,8 +958,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	pcie->dev = &pdev->dev;
>  	pcie->np = np;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	pcie->base = devm_ioremap_resource(&pdev->dev, res);
> +	pcie->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcie->base))
>  		return PTR_ERR(pcie->base);
>  
> -- 
> 2.25.0
> 
