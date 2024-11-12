Return-Path: <linux-pci+bounces-16520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D096C9C52B8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 11:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905C928399F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B3B21265F;
	Tue, 12 Nov 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QwBa+r+q"
X-Original-To: linux-pci@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FA212EEF;
	Tue, 12 Nov 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405983; cv=none; b=p2/Ewwwz88mgpPIhqXPCFFrm1h34nirQlCK6X65GI9Te8EOEdwWdhLSkUM3KLm6H8gCJJpnCk/Bxlv5AOpBJIscBQ/HMkgA7dGLLEwPCqCI036B16XH4YBpLrcRMw2Ei2gW4McL5Z4LvSExPq9JFlI7PZRtTbuvnj+MURbuUI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405983; c=relaxed/simple;
	bh=PtwouKHAn/VHkgGXa42Miuf+DbfWJ6bCaJAhn+NoCYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hotUHrQzg3mIrvt2v7BN+fBasWE4TPyECbjRFmsBtC/Ekzq2IZybyGdIefzS/DyknSFtk5USW2OVO6q5G9pKRYgjtCHTCMI3Q+BbdDM+gQczAhmcwLjBj8mqhllDY5Ad8P5lbT7IE1yNUySzqGIL21ztFGxJl46TDUNuCEeA6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QwBa+r+q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qEqElcS5St5CaM+svgsscnrIfVD/nab9lkfJvbTL8nk=; b=QwBa+r+qb0XaTDVdiMDrGefwj7
	HUS93wehrhz0EGkwpNhgYywnJpOi3YvldcYW9FOmgWEHoX3NE/upVkS2IzViaPwCE5u/6zQIHaD4b
	Nw7VNVzwfcul5Chyb91FNpM3YvhzHW/8tCdn7aA1/F58l+G3EzfooWYzD8M8P/7zKzJ3Zl/ITXJhR
	iP1KUmkMT1WuX928BXG3bsPfpHUMFXZNHOkSPtVzJUhTdkxJnod5gBd4E2wxDYQNaZNbHZqrh8KoC
	LF1ftT7/1JwT51409ochdXi7RGjEc5R5OnBAG1gCBrXgLjFKY9WtdKR2txk6wu2f/f3km5LO5K6/e
	GqGyKwfw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44242)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tAnml-0003tT-0t;
	Tue, 12 Nov 2024 10:06:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tAnmj-0007Mx-14;
	Tue, 12 Nov 2024 10:06:09 +0000
Date: Tue, 12 Nov 2024 10:06:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: lpieralisi@kernel.org, thomas.petazzoni@bootlin.com, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	salee@marvell.com, dingwei@marvell.com
Subject: Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
Message-ID: <ZzMokT-2pop1Y5hh@shell.armlinux.org.uk>
References: <20241112064813.751736-1-jpatel2@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112064813.751736-1-jpatel2@marvell.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Overall, your recent patches look like they're part of a series - they
are dependent on each other, but you haven't sent them as a series. They
need to be sent as a series so people know what order these patches
should be applied in, and that they're all related.

On Mon, Nov 11, 2024 at 10:48:13PM -0800, Jenishkumar Maheshbhai Patel wrote:
> In PCIE ISR routine caused by RST_LINK_DOWN
> we schedule work to handle the link-down procedure.
> Link-down procedure will:
> 1. Remove PCIe bus
> 2. Reset the MAC
> 3. Reconfigure link back up
> 4. Rescan PCIe bus
> 
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
> +	/*
> +	 * Sleep needed to make sure all pcie transactions and access
> +	 * are flushed before resetting the mac
> +	 */
> +	msleep(100);
> +
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
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

