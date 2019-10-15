Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62B6D7C89
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfJOQ4x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 12:56:53 -0400
Received: from foss.arm.com ([217.140.110.172]:43382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfJOQ4w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 12:56:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4DFA337;
        Tue, 15 Oct 2019 09:56:51 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B74A23F68E;
        Tue, 15 Oct 2019 09:56:49 -0700 (PDT)
Date:   Tue, 15 Oct 2019 17:56:47 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Yue Wang <yue.wang@Amlogic.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>
Subject: Re: [PATCH] PCI: dwc: Use PTR_ERR_OR_ZERO() in five functions
Message-ID: <20191015165647.GD25674@e121166-lin.cambridge.arm.com>
References: <95c9dfae-af81-82ad-e989-1fdf5f29808e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95c9dfae-af81-82ad-e989-1fdf5f29808e@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 06, 2019 at 08:50:07PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 6 Sep 2019 20:40:06 +0200
> 
> Simplify these function implementations by using a known function.
> 
> Generated by: scripts/coccinelle/api/ptr_ret.cocci
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c |  5 +----
>  drivers/pci/controller/dwc/pci-meson.c  | 10 ++--------
>  drivers/pci/controller/dwc/pcie-kirin.c | 10 ++--------
>  3 files changed, 5 insertions(+), 20 deletions(-)

https://lore.kernel.org/linux-pci/20190527140952.GB7202@ulmo/

Dropped, sorry.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index cee5f2f590e2..b6ab1cc5d895 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -92,10 +92,7 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	ep->mem_res->elbi_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(ep->mem_res->elbi_base))
> -		return PTR_ERR(ep->mem_res->elbi_base);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(ep->mem_res->elbi_base);
>  }
> 
>  static int exynos5440_pcie_get_clk_resources(struct exynos_pcie *ep)
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index e35e9eaa50ee..713059918002 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -182,10 +182,7 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
> 
>  	/* Meson SoC has two PCI controllers use same phy register*/
>  	mp->mem_res.phy_base = meson_pcie_get_mem_shared(pdev, mp, "phy");
> -	if (IS_ERR(mp->mem_res.phy_base))
> -		return PTR_ERR(mp->mem_res.phy_base);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(mp->mem_res.phy_base);
>  }
> 
>  static void meson_pcie_power_on(struct meson_pcie *mp)
> @@ -259,10 +256,7 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
>  		return PTR_ERR(res->general_clk);
> 
>  	res->clk = meson_pcie_probe_clock(dev, "pcie", 0);
> -	if (IS_ERR(res->clk))
> -		return PTR_ERR(res->clk);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(res->clk);
>  }
> 
>  static inline void meson_elb_writel(struct meson_pcie *mp, u32 val, u32 reg)
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index c19617a912bd..75b1f1dde747 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -138,10 +138,7 @@ static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
>  		return PTR_ERR(kirin_pcie->apb_sys_clk);
> 
>  	kirin_pcie->pcie_aclk = devm_clk_get(dev, "pcie_aclk");
> -	if (IS_ERR(kirin_pcie->pcie_aclk))
> -		return PTR_ERR(kirin_pcie->pcie_aclk);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(kirin_pcie->pcie_aclk);
>  }
> 
>  static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> @@ -174,10 +171,7 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> 
>  	kirin_pcie->sysctrl =
>  		syscon_regmap_lookup_by_compatible("hisilicon,hi3660-sctrl");
> -	if (IS_ERR(kirin_pcie->sysctrl))
> -		return PTR_ERR(kirin_pcie->sysctrl);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(kirin_pcie->sysctrl);
>  }
> 
>  static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
> --
> 2.23.0
> 
