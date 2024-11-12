Return-Path: <linux-pci+bounces-16600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 327499C63C0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 22:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF5AB28859
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73A8217905;
	Tue, 12 Nov 2024 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1L6Of83"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F8120C460;
	Tue, 12 Nov 2024 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447177; cv=none; b=AA6PAgp5EdYmhbTIV5iOvCGPU/AFaoM/ATJ26S7UTmFsnpODIOqBa3Bkn9zEzWs8NQnAneq8gDH8qtnhsqb3s9yb0+zkWYqdndzvxcuMfvcNT4P4h0F//sfZuHC6myy/W4jlb56ALbG+omtlmD0+9FWykxcb/xxDFoBGGgBajK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447177; c=relaxed/simple;
	bh=ApKX+4cu9ZbBmnkzhOTLuP5wHHLAxK8wxcPwFeAA5tE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NkUO3FpHqfMDn2vnTVJrcc5AWxZ50paBhpFziz4rx0jWyaToZnOIowEXYnTSU1PBt+uySviXyjn2ZLDeoNV3OpMBev9wiiv76OCWBUeuisO69RT2uC2RaQm3EGpt4ELdABjLI5UcLQYrq4X+Q1XRsqDeKjaJksTP9CH06IdZ1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1L6Of83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D4AC4CECD;
	Tue, 12 Nov 2024 21:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731447177;
	bh=ApKX+4cu9ZbBmnkzhOTLuP5wHHLAxK8wxcPwFeAA5tE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g1L6Of83xy5e9DTMpuc+UgYYvaePl0u6G95G4My7ddrZ6KhsjLx4lhkk2s0TT3pJg
	 93UvmziBFu0SQOgDk1t7o9mjJtA/yOokeo7aI9ku4wp6x2ljwOXBN323w3UMPR6zLJ
	 f/ziXjOf56BGbQ6QVFg8OQ2y1RqQ325cBHWXFV7iu4YYS+qLLn0PcdQ8cGYUgs8NHL
	 eo2kh4sKoSH5j2wbpovPQDbt+YCH+a+sIYKO6DFtP99Ouru1MvIeBVcZwo1tEntOY2
	 dnc6uhN6vEI9pHSjSZx49Wl14fAwtoyVkEc4wGJ6E4g8mDfCXc2cummESwBcQ41Km5
	 uhijlWd0WvCpg==
Date: Tue, 12 Nov 2024 15:32:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: lpieralisi@kernel.org, thomas.petazzoni@bootlin.com, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	salee@marvell.com, dingwei@marvell.com
Subject: Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
Message-ID: <20241112213255.GA1861331@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112064813.751736-1-jpatel2@marvell.com>

In subject:

  PCI: armada8k: Add link-down handling

On Mon, Nov 11, 2024 at 10:48:13PM -0800, Jenishkumar Maheshbhai Patel wrote:
> In PCIE ISR routine caused by RST_LINK_DOWN
> we schedule work to handle the link-down procedure.
> Link-down procedure will:
> 1. Remove PCIe bus
> 2. Reset the MAC
> 3. Reconfigure link back up
> 4. Rescan PCIe bus

s/PCIE/PCIe/

Rewrap to fill 75 columns.

I assume this basically removes a Root Port (and the hierarchy below
it) if the link goes down, and then resets the MAC and tries to bring
up the link and enumerate the hierarchy again.

No other drivers do this, so why does armada8k need it?  Is this to
work around some unreliable link?

I would think this would be reported via AER and possibly handled
there already, but apparently not?

> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 07775539b321..b1b48c2016f7 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -21,6 +21,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/resource.h>
>  #include <linux/of_pci.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -32,6 +34,9 @@ struct armada8k_pcie {
>  	struct clk *clk_reg;
>  	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
>  	unsigned int phy_count;
> +	struct regmap *sysctrl_base;
> +	u32 mac_rest_bitmask;
> +	struct work_struct recover_link_work;
>  };
>  
>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -72,6 +77,8 @@ struct armada8k_pcie {
>  #define AX_USER_DOMAIN_MASK		0x3
>  #define AX_USER_DOMAIN_SHIFT		4
>  
> +#define UNIT_SOFT_RESET_CONFIG_REG	0x268
> +
>  #define to_armada8k_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  static void armada8k_pcie_disable_phys(struct armada8k_pcie *pcie)
> @@ -216,6 +223,65 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static void armada8k_pcie_recover_link(struct work_struct *ws)
> +{
> +	struct armada8k_pcie *pcie = container_of(ws, struct armada8k_pcie, recover_link_work);
> +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> +	struct pci_bus *bus = pp->bridge->bus;
> +	struct pci_dev *root_port;
> +	int ret;
> +
> +	root_port = pci_get_slot(bus, 0);
> +	if (!root_port) {
> +		dev_err(pcie->pci->dev, "failed to get root port\n");
> +		return;
> +	}
> +	pci_lock_rescan_remove();
> +	pci_stop_and_remove_bus_device(root_port);

Add blank line.

> +	/*
> +	 * Sleep needed to make sure all pcie transactions and access
> +	 * are flushed before resetting the mac
> +	 */
> +	msleep(100);

s/pcie/PCIe/
s/mac/MAC/ (also below)

What PCIe spec parameter is the 100ms?  If we don't already have a
#define for it, add one in drivers/pci/pci.h with spec citation.

> +	/* Reset mac */
> +	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
> +				pcie->mac_rest_bitmask, 0, NULL, false, true);
> +	udelay(1);
> +	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
> +				pcie->mac_rest_bitmask, pcie->mac_rest_bitmask,
> +				NULL, false, true);
> +	udelay(1);
> +
> +	ret = dw_pcie_setup_rc(pp);
> +	if (ret)
> +		goto fail;
> +
> +	ret = armada8k_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(pcie->pci->dev, "failed to initialize host: %d\n", ret);
> +		goto fail;
> +	}
> +
> +	if (!dw_pcie_link_up(pcie->pci)) {
> +		ret = dw_pcie_start_link(pcie->pci);
> +		if (ret)
> +			goto fail;
> +	}
> +
> +	/* Wait until the link becomes active again */
> +	if (dw_pcie_wait_for_link(pcie->pci))
> +		dev_err(pcie->pci->dev, "Link not up after reconfiguration\n");
> +
> +	bus = NULL;
> +	while ((bus = pci_find_next_bus(bus)) != NULL)
> +		pci_rescan_bus(bus);
> +
> +fail:
> +	pci_unlock_rescan_remove();
> +	pci_dev_put(root_port);
> +}
> +
>  static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>  {
>  	struct armada8k_pcie *pcie = arg;
> @@ -253,6 +319,9 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>  		 * initiate a link retrain. If link retrains were
>  		 * possible, that is.
>  		 */
> +		if (pcie->sysctrl_base && pcie->mac_rest_bitmask)
> +			schedule_work(&pcie->recover_link_work);
> +
>  		dev_dbg(pci->dev, "%s: link went down\n", __func__);
>  	}
>  
> @@ -322,6 +391,8 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->pci = pci;
>  
> +	INIT_WORK(&pcie->recover_link_work, armada8k_pcie_recover_link);
> +
>  	pcie->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(pcie->clk))
>  		return PTR_ERR(pcie->clk);
> @@ -349,6 +420,19 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  		goto fail_clkreg;
>  	}
>  
> +	pcie->sysctrl_base = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +						       "marvell,system-controller");
> +	if (IS_ERR(pcie->sysctrl_base)) {
> +		dev_warn(dev, "failed to find marvell,system-controller\n");
> +		pcie->sysctrl_base = 0x0;
> +	}
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "marvell,mac-reset-bit-mask",
> +				   &pcie->mac_rest_bitmask);
> +	if (ret < 0) {
> +		dev_warn(dev, "couldn't find mac reset bit mask: %d\n", ret);
> +		pcie->mac_rest_bitmask = 0x0;
> +	}
>  	ret = armada8k_pcie_setup_phys(pcie);
>  	if (ret)
>  		goto fail_clkreg;
> -- 
> 2.25.1
> 

