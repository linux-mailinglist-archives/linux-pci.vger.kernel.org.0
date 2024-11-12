Return-Path: <linux-pci+bounces-16603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9D9C63A1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 22:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886C1285153
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E4221A6F1;
	Tue, 12 Nov 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK8PUPXg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19F21A6ED;
	Tue, 12 Nov 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447696; cv=none; b=h/rbQ40RM/Bah+BsCMZ0j8C/jNglbiAa4VhnE4sekJouiLE+Fgoc8Y4lFC+j+OHO9KTOZSWh2AYzr+fBEtS12o2ZFi0CpktaAI02aVlpXbsJKfB70nHoKOTbXeidJRMplU/e3hI6kdQdQcwjoPx5QwTgfUkgSuYC8nZZQCQblWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447696; c=relaxed/simple;
	bh=+r1zjWFmIgf8fAjGCmjFjRtm3GAxhQNL1/z2KLtcs9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=t4klvUUvm/SuWr1kqku1ZZPdB1BswU3No7Lq84MLZwrEyLvFy9+7XP/YNNQjaZIzX0vgi2ZlCLpWhLMIeBZxGoplnYNvGbDSg//cQXqLyn+bVDN7QzlE0fkQZojHITrsLp0320zq/HFFLPN57KSVA4VrAoWc0/T5JgF1z3GWH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK8PUPXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013FBC4CED6;
	Tue, 12 Nov 2024 21:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731447696;
	bh=+r1zjWFmIgf8fAjGCmjFjRtm3GAxhQNL1/z2KLtcs9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qK8PUPXg/DWALAXo3BBuqgdkp4YMaXv9aQkA5TNaW23k41Ku4q60rQWaXnQr7CvJX
	 ZAI4TeJa5/FmFwju6GXCUUMDaYND+pA9iQxbI0MmLP6EpY5u3EflRf5tPGuHFe2wTO
	 d+jnQ1f7iMEPiFCedEld/kRnoynqu127yAdbcCK9Tuj8eHSzOLhh1aftYo97RD+PeJ
	 f/1XN91h0rk4beRpQuSgNVpYllOorY3XcGEx8hYD9Zr1ODKf/Nr5+YqGM4dANa4pEA
	 AnBD+B6r+mMVvA7Im3xPW1v/AfE2Ia69phuOyxY9ACg3mka3hNV/Amw/lGyCvxmRNa
	 89PVAabGdknsg==
Date: Tue, 12 Nov 2024 15:41:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: lpieralisi@kernel.org, thomas.petazzoni@bootlin.com, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	salee@marvell.com, dingwei@marvell.com
Subject: Re: [PATCH 1/1] PCI: armada8k: use reset controller to reset mac
Message-ID: <20241112214134.GA1861807@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112070745.759678-1-jpatel2@marvell.com>

Observe subject line capitalization convention.

On Mon, Nov 11, 2024 at 11:07:45PM -0800, Jenishkumar Maheshbhai Patel wrote:
> change mac reset and mac reset bits to reset controller

Capitalize sentence.

s/mac/MAC/

Explain why we want this.  Apparently you're changing from one MAC
reset method to another method?

Collect these into a series instead of posting individual random
patches.

> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 30 +++++++---------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 9a48ef60be51..f9d6907900d1 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -21,7 +21,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/resource.h>
>  #include <linux/of_pci.h>
> -#include <linux/mfd/syscon.h>
> +#include <linux/reset.h>
>  #include <linux/regmap.h>
>  #include <linux/of_gpio.h>
>  
> @@ -35,11 +35,10 @@ struct armada8k_pcie {
>  	struct clk *clk_reg;
>  	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
>  	unsigned int phy_count;
> -	struct regmap *sysctrl_base;
> -	u32 mac_rest_bitmask;
>  	struct work_struct recover_link_work;
>  	enum of_gpio_flags flags;
>  	struct gpio_desc *reset_gpio;
> +	struct reset_control *reset;
>  };
>  
>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -257,12 +256,9 @@ static void armada8k_pcie_recover_link(struct work_struct *ws)
>  	msleep(100);
>  
>  	/* Reset mac */
> -	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
> -				pcie->mac_rest_bitmask, 0, NULL, false, true);
> +	reset_control_assert(pcie->reset);
>  	udelay(1);
> -	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
> -				pcie->mac_rest_bitmask, pcie->mac_rest_bitmask,
> -				NULL, false, true);
> +	reset_control_deassert(pcie->reset);
>  	udelay(1);
>  
>  	ret = dw_pcie_setup_rc(pp);
> @@ -331,7 +327,7 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>  		 * initiate a link retrain. If link retrains were
>  		 * possible, that is.
>  		 */
> -		if (pcie->sysctrl_base && pcie->mac_rest_bitmask)
> +		if (pcie->reset)
>  			schedule_work(&pcie->recover_link_work);
>  
>  		dev_dbg(pci->dev, "%s: link went down\n", __func__);
> @@ -440,18 +436,10 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  	if (gpio_is_valid(reset_gpio))
>  		pcie->reset_gpio = gpio_to_desc(reset_gpio);
>  
> -	pcie->sysctrl_base = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> -						       "marvell,system-controller");
> -	if (IS_ERR(pcie->sysctrl_base)) {
> -		dev_warn(dev, "failed to find marvell,system-controller\n");
> -		pcie->sysctrl_base = 0x0;
> -	}
> -
> -	ret = of_property_read_u32(pdev->dev.of_node, "marvell,mac-reset-bit-mask",
> -				   &pcie->mac_rest_bitmask);
> -	if (ret < 0) {
> -		dev_warn(dev, "couldn't find mac reset bit mask: %d\n", ret);
> -		pcie->mac_rest_bitmask = 0x0;
> +	pcie->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(pcie->reset)) {
> +		dev_warn(dev, "failed to find mac reset\n");
> +		pcie->reset = 0x0;
>  	}
>  	ret = armada8k_pcie_setup_phys(pcie);
>  	if (ret)
> -- 
> 2.25.1
> 

