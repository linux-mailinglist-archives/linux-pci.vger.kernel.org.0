Return-Path: <linux-pci+bounces-16091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D16DB9BDB1B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 02:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B53B2141C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 01:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8BB187848;
	Wed,  6 Nov 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUUtCwOy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594CE10E5;
	Wed,  6 Nov 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856130; cv=none; b=Rj4sb+MftXf1Xz3GCNwlXzLf4DD7mMRBhauG6Vwedd1dqGz9fY1FiZMV1F8mG+fX0ODwRp9Qc90tr5IFkw93Mg3YWq0KX2UrmUXGoo/Y/C7gSqRNoKqZ80yI5FwdzNbZTcTw6iEFYJ7G01Tv1LaA2Wm8F6uBanh5x258L1S2E2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856130; c=relaxed/simple;
	bh=CTwxo+a59cKcPcqlad8C1Q83+2bZfWEFbSYDDoYvJmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G3jGCIh5aolqbb9a+TpYFICoiATZf6MqfrMeDun+Q+XQmwKi3nXUFV2dlPPu8DqKiW6OKRkPVh0zmEJ/uEvRhU9ydIP2NI0hiMKj8mD12fO7dH2p8tWek9eOw28vmSlzVY7vHwpkbRymh8bzPscOrNJsqt7Z+/pKk9EBS5s/sP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUUtCwOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA147C4CECF;
	Wed,  6 Nov 2024 01:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730856130;
	bh=CTwxo+a59cKcPcqlad8C1Q83+2bZfWEFbSYDDoYvJmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UUUtCwOyNqA2uQhwxK/bCvR5AxgRCgLxIvhCAKJ6ZkqGTjK9+Lv6B6AISY7MONKjH
	 DHko1vkEAmnr4dmI4M0s5rJMtG67zUfT7Qc1yvNrZAxnfFbV625iLjNA+kQpcl7aBG
	 DGpT80Vbse2wpr+mzJuxORmvpLBl4K+l4vFI5odhGeSKD276fog9x5EwxWWcp7qWId
	 WR+eUPL2KZCHRPualYGxUjMdEbbbvkFb/T4JgLLavQsNW5mVo5UMosWHgHJT1ChQ3x
	 0BRU59UP3/KY9SzPGZVx+sxsmbqZuVxePeHICwpi9ysQxV9oiF2g8j3xthRshkBdVK
	 KSqQVCDQgkEgA==
Date: Tue, 5 Nov 2024 19:22:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>
Cc: linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	fshao@chromium.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
Message-ID: <20241106012208.GA1498775@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104114935.172908-2-angelogioacchino.delregno@collabora.com>

On Mon, Nov 04, 2024 at 12:49:34PM +0100, AngeloGioacchino Del Regno wrote:
> Add support for respecting the max-link-speed devicetree property,
> forcing a maximum speed (Gen) for a PCI-Express port.
> 
> Since the MediaTek PCIe Gen3 controllers also expose the maximum
> supported link speed in the PCIE_BASE_CFG register, if property
> max-link-speed is specified in devicetree, validate it against the
> controller capabilities and proceed setting the limitations only
> if the wanted Gen is lower than the maximum one that is supported
> by the controller itself (otherwise it makes no sense!).
> 
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Can we get an ack from Ryder and/or Jianjun, since they're listed as
supporters for this driver?

> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -28,7 +28,11 @@
>  
>  #include "../pci.h"
>  
> +#define PCIE_BASE_CFG_REG		0x14
> +#define PCIE_BASE_CFG_SPEED		GENMASK(15, 8)
> +
>  #define PCIE_SETTING_REG		0x80
> +#define PCIE_SETTING_GEN_SUPPORT	GENMASK(14, 12)
>  #define PCIE_PCI_IDS_1			0x9c
>  #define PCI_CLASS(class)		(class << 8)
>  #define PCIE_RC_MODE			BIT(0)
> @@ -125,6 +129,9 @@
>  
>  struct mtk_gen3_pcie;
>  
> +#define PCIE_CONF_LINK2_CTL_STS		(PCIE_CFG_OFFSET_ADDR + 0xb0)
> +#define PCIE_CONF_LINK2_LCR2_LINK_SPEED	GENMASK(3, 0)

Are these the same as PCI_EXP_LNKCTL2 and PCI_EXP_LNKCTL2_TLS?

It looks like you access these registers via an ioremapped MMIO access
instead of config space, but if they reach the same internal register,
please define the appropriate offset and use PCI_EXP_LNKCTL2 and
related definitions so grep can find them and we'll know how to
interpret the PCIE_CONF_LINK2_LCR2_LINK_SPEED field.

>  /**
>   * struct mtk_gen3_pcie_pdata - differentiate between host generations
>   * @power_up: pcie power_up callback
> @@ -160,6 +167,7 @@ struct mtk_msi_set {
>   * @phy: PHY controller block
>   * @clks: PCIe clocks
>   * @num_clks: PCIe clocks count for this port
> + * @max_link_speed: Maximum link speed (PCIe Gen) for this port
>   * @irq: PCIe controller interrupt number
>   * @saved_irq_state: IRQ enable state saved at suspend time
>   * @irq_lock: lock protecting IRQ register access
> @@ -180,6 +188,7 @@ struct mtk_gen3_pcie {
>  	struct phy *phy;
>  	struct clk_bulk_data *clks;
>  	int num_clks;
> +	u8 max_link_speed;
>  
>  	int irq;
>  	u32 saved_irq_state;
> @@ -381,11 +390,27 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  	int err;
>  	u32 val;
>  
> -	/* Set as RC mode */
> +	/* Set as RC mode and set controller PCIe Gen speed restriction, if any */
>  	val = readl_relaxed(pcie->base + PCIE_SETTING_REG);
>  	val |= PCIE_RC_MODE;
> +	if (pcie->max_link_speed) {
> +		val &= ~PCIE_SETTING_GEN_SUPPORT;
> +
> +		/* Can enable link speed support only from Gen2 onwards */
> +		if (pcie->max_link_speed >= 2)
> +			val |= FIELD_PREP(PCIE_SETTING_GEN_SUPPORT,
> +					  GENMASK(pcie->max_link_speed - 2, 0));
> +	}
>  	writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
>  
> +	/* Set Link Control 2 (LNKCTL2) speed restriction, if any */
> +	if (pcie->max_link_speed) {
> +		val = readl_relaxed(pcie->base + PCIE_CONF_LINK2_CTL_STS);
> +		val &= ~PCIE_CONF_LINK2_LCR2_LINK_SPEED;
> +		val |= FIELD_PREP(PCIE_CONF_LINK2_LCR2_LINK_SPEED, pcie->max_link_speed);
> +		writel_relaxed(val, pcie->base + PCIE_CONF_LINK2_CTL_STS);
> +	}
> +
>  	/* Set class code */
>  	val = readl_relaxed(pcie->base + PCIE_PCI_IDS_1);
>  	val &= ~GENMASK(31, 8);
> @@ -1004,9 +1029,21 @@ static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
>  	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
>  }
>  
> +static int mtk_pcie_get_controller_max_link_speed(struct mtk_gen3_pcie *pcie)
> +{
> +	u32 val;
> +	int ret;
> +
> +	val = readl_relaxed(pcie->base + PCIE_BASE_CFG_REG);
> +	val = FIELD_GET(PCIE_BASE_CFG_SPEED, val);
> +	ret = fls(val);
> +
> +	return ret > 0 ? ret : -EINVAL;
> +}
> +
>  static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  {
> -	int err;
> +	int err, max_speed;
>  
>  	err = mtk_pcie_parse_port(pcie);
>  	if (err)
> @@ -1031,6 +1068,20 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  	if (err)
>  		return err;
>  
> +	err = of_pci_get_max_link_speed(pcie->dev->of_node);
> +	if (err > 0) {
> +		/* Get the maximum speed supported by the controller */
> +		max_speed = mtk_pcie_get_controller_max_link_speed(pcie);
> +
> +		/* Set max_link_speed only if the controller supports it */
> +		if (max_speed >= 0 && max_speed <= err) {
> +			pcie->max_link_speed = err;
> +			dev_dbg(pcie->dev,
> +				"Max controller link speed Gen%d, override to Gen%u",
> +				max_speed, pcie->max_link_speed);
> +		}
> +	}
> +
>  	/* Try link up */
>  	err = mtk_pcie_startup_port(pcie);
>  	if (err)
> -- 
> 2.46.1
> 

