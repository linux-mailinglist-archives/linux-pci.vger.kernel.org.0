Return-Path: <linux-pci+bounces-8306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4018FC60F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1CCB21438
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF52195FEF;
	Wed,  5 Jun 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuXzzy2Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77704195FE8;
	Wed,  5 Jun 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575489; cv=none; b=q9UfIFBANL3cNMcAY4GjukZV9jaO4nz7L3Y7dtXe4+WPt8J29YkNCdYV3lv/UJsHWbHSPRuaYESv+YiAQB+21KXEk8j50EqdmmqM3Ko27FQBYjHr9AOjBCJTgUKGh56hCVkhV3B+y+Cc4UG5pt5lhYNAXR1DmUTb18o9G1ZYtcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575489; c=relaxed/simple;
	bh=AaNMFa474izpGRkn1s2bqhLMgtZao6BeoKtAM/4bkRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck+mCDPLn68NN13aJ56Yaaqls5HAKiMuggskxPrN36M0aGwcEMtnNX2dK30w7hpfJmcds0D403eXFy6xVd2mrefSGwx724bS8px9UzIXUEKSdulAvlHjkFWwghC2LMpZ9Xb5SHVq+tHlL0v2kxKSdwIHnn++NDbSJiJsQgdcZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuXzzy2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A334C32781;
	Wed,  5 Jun 2024 08:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717575488;
	bh=AaNMFa474izpGRkn1s2bqhLMgtZao6BeoKtAM/4bkRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QuXzzy2QmnMeVrq08FbdVt/73QHryni6SoM0SVxGGuiz6A4ghxNqCCZLNCEecbtu4
	 IdgdnbLINDiAizZoS+N79/csAIyM4fv+50RhuZY1Z/d5cyYdzmFXLSezPJP9czv3cy
	 NF2BUTwaug+THss1Oo4UscXBvOJctBQrTyB21nc8fEMRkZj45V4MVoK4vY6hijv331
	 Ldvx61iNLXJgcnHTMN8JvVtuqlk+rqy55z2CbuSVMc55eI7TPwiUZ3x6loS3DoX9PE
	 Dsjim1vDbwOHx2HXWV/DDwFKYd8ghDGYwXgDHgqxWQA08+Lz8M43+p2xmiB/rsKaRL
	 woG/EIr73aK6w==
Date: Wed, 5 Jun 2024 13:47:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 10/13] PCI: dw-rockchip: Add endpoint mode support
Message-ID: <20240605081753.GK5085@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-10-3dc00fe21a78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-10-3dc00fe21a78@kernel.org>

On Wed, May 29, 2024 at 10:29:04AM +0200, Niklas Cassel wrote:
> The PCIe controller in rk3568 and rk3588 can operate in endpoint mode.
> This endpoint mode support heavily leverages the existing code in
> pcie-designware-ep.c.
> 
> Add support for endpoint mode to the existing pcie-dw-rockchip glue
> driver.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Couple of comments below. With those addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/pci/controller/dwc/Kconfig            |  17 ++-
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 210 ++++++++++++++++++++++++++
>  2 files changed, 224 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 8afacc90c63b..9fae0d977271 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -311,16 +311,27 @@ config PCIE_RCAR_GEN4_EP
>  	  SoCs. To compile this driver as a module, choose M here: the module
>  	  will be called pcie-rcar-gen4.ko. This uses the DesignWare core.
>  
> +config PCIE_ROCKCHIP_DW
> +	bool

Where is this symbol used?

> +
>  config PCIE_ROCKCHIP_DW_HOST
> -	bool "Rockchip DesignWare PCIe controller"
> -	select PCIE_DW
> +	bool "Rockchip DesignWare PCIe controller (host mode)"
>  	select PCIE_DW_HOST
>  	depends on PCI_MSI
>  	depends on ARCH_ROCKCHIP || COMPILE_TEST
>  	depends on OF
>  	help
>  	  Enables support for the DesignWare PCIe controller in the
> -	  Rockchip SoC except RK3399.
> +	  Rockchip SoC (except RK3399) to work in host mode.
> +
> +config PCIE_ROCKCHIP_DW_EP
> +	bool "Rockchip DesignWare PCIe controller (endpoint mode)"
> +	select PCIE_DW_EP
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Enables support for the DesignWare PCIe controller in the
> +	  Rockchip SoC (except RK3399) to work in endpoint mode.
>  
>  config PCI_EXYNOS
>  	tristate "Samsung Exynos PCIe controller"
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index e133511692af..347721207161 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c

[...]

> +static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> +{
> +	struct rockchip_pcie *rockchip = arg;
> +	struct dw_pcie *pci = &rockchip->pci;
> +	struct device *dev = pci->dev;
> +	u32 reg, val;
> +
> +	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
> +
> +	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
> +	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
> +
> +	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
> +		dev_dbg(dev, "hot reset or link-down reset\n");
> +		dw_pcie_ep_linkdown(&pci->ep);
> +	}
> +
> +	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> +		val = rockchip_pcie_get_ltssm(rockchip);
> +		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
> +			dev_dbg(dev, "link up\n");
> +			dw_pcie_ep_linkup(&pci->ep);
> +		}
> +	}
> +
> +	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);

It is recommended to clear the IRQs at the start of the handler (after status
read).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

