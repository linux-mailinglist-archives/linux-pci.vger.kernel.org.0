Return-Path: <linux-pci+bounces-29664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E958FAD8869
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AB11897F58
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431C189BB0;
	Fri, 13 Jun 2025 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tISg5Fdz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34792DA75E
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808156; cv=none; b=BLbGf20Jpo0vBOxyUiy+vIacpntXgpgRNr6RqEl+23A6xzCwILdvZAhdSeiavfE+70TpDwEjUQd7lcloSRcK0Qd/+DWMwBi0MumLhgMmMHeYvHfvbKoZdqdfRfkuBCRsCKsq7wNuaAP1nBrqIGwrz2+wsfrpXTUHp3PJvIfdFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808156; c=relaxed/simple;
	bh=FD3+a0qSWnfO5GoGBElixxKXQCsxJ+r+ACcIJE+ksE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCc0erYDLwEEem/e2S6sM8f22oVpGUJ3ROkMawrWNrlLahpPKiIli8ysdcNJw49mSJXqJsf2/MvTwpAXrNKlvDQMy87stFS6cYT4slpBKfTe/B3ODH6RTQrpkpMkhq9RbRX47NzE3W239miK3Oqn+FnIBtnO5avsKkXgHWeeAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tISg5Fdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF083C4CEE3;
	Fri, 13 Jun 2025 09:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749808155;
	bh=FD3+a0qSWnfO5GoGBElixxKXQCsxJ+r+ACcIJE+ksE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tISg5FdzAiM8LkPj/G3D3XHzC5+0wKGP5Zbp/S4yJDs1HpYJZub+rCZcy205U2HYL
	 8sfKp3yDD+HR5fL6SsNKJnzR483P1fgGEkuIm3g4CgMlZ+VNe2plowNZerSjiKicOc
	 V6zZdZhrxiGAYpwK215/0ndEBW+F2KgZw7eESvwS8V0P9JHKvKSDSOnvQelLEomnDf
	 lU8vqheLzkwOAdo6pyXBRKxUdI2sdZSju/tO0Z1QoS9QddCJjTAvukJBBl9HqL10zH
	 qfV1+t9/cxJW08fHEyDuRJ1u+b1XLLBTGO5lM7z1RspZ2qziKktyBwKTYviUUHTE3r
	 60ChV+NqxDK6A==
Date: Fri, 13 Jun 2025 15:19:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Delay link training after hot reset in
 EP mode
Message-ID: <wlrcincpfir65cvqbgromy7gc25vtkynxzoqmnebp7r62pce5z@iipm4r7j5aot>
References: <20250522123958.1518205-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250522123958.1518205-2-cassel@kernel.org>

On Thu, May 22, 2025 at 02:39:59PM +0200, Niklas Cassel wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> RK3588 TRM, section "11.6.1.3.3 Hot Reset and Link-Down Reset" states that:
> """
> If you want to delay link re-establishment (after reset) so that you can
> reprogram some registers through DBI, you must set app_ltssm_enable =0
> immediately after core_rst_n as shown in above. This can be achieved by
> enable the app_dly2_en, and end-up the delay by assert app_dly2_done.
> """
> 
> I.e. setting app_dly2_en will automatically deassert app_ltssm_enable on
> a hot reset, and setting app_dly2_done will re-assert app_ltssm_enable,
> re-enabling link training.
> 
> When receiving a hot reset/link-down IRQ when running in EP mode, we will
> call dw_pcie_ep_linkdown(), which will call the .link_down() callback in
> the currently bound endpoint function (EPF) drivers.
> 
> The callback in an EPF driver can theoretically take a long time to
> complete, so make sure that the link is not re-established until after
> dw_pcie_ep_linkdown() (which calls the .link_down() callback(s)
> synchronously).
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Co-developed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

This patch is not applying on top of v6.16-rc1. Please post it after rebasing.

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index c4bd7e0abdf0..05b8e4cbd30b 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -61,6 +61,8 @@
>  
>  /* Hot Reset Control Register */
>  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
> +#define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
> +#define  PCIE_LTSSM_APP_DLY2_DONE	BIT(3)
>  #define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
>  
>  /* LTSSM Status Register */
> @@ -487,7 +489,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>  	struct rockchip_pcie *rockchip = arg;
>  	struct dw_pcie *pci = &rockchip->pci;
>  	struct device *dev = pci->dev;
> -	u32 reg;
> +	u32 reg, val;
>  
>  	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
>  	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
> @@ -498,6 +500,10 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>  	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
>  		dev_dbg(dev, "hot reset or link-down reset\n");
>  		dw_pcie_ep_linkdown(&pci->ep);
> +		/* Stop delaying link training. */
> +		val = HIWORD_UPDATE_BIT(PCIE_LTSSM_APP_DLY2_DONE);
> +		rockchip_pcie_writel_apb(rockchip, val,
> +					 PCIE_CLIENT_HOT_RESET_CTRL);
>  	}
>  
>  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> @@ -585,8 +591,11 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	/* LTSSM enable control mode */
> -	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> +	/*
> +	 * LTSSM enable control mode, and automatically delay link training on
> +	 * hot reset/link-down reset.
> +	 */
> +	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE | PCIE_LTSSM_APP_DLY2_EN);
>  	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
>  
>  	/*
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

