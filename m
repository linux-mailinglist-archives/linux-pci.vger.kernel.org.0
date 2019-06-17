Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028524807A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 13:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfFQLSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 07:18:25 -0400
Received: from foss.arm.com ([217.140.110.172]:45898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfFQLSY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 07:18:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 358F6344;
        Mon, 17 Jun 2019 04:18:24 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B5C3F246;
        Mon, 17 Jun 2019 04:20:08 -0700 (PDT)
Date:   Mon, 17 Jun 2019 12:18:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: armada8k: Add PHYs support
Message-ID: <20190617111817.GA24968@e121166-lin.cambridge.arm.com>
References: <20190401131239.17008-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401131239.17008-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 01, 2019 at 03:12:39PM +0200, Miquel Raynal wrote:
> Bring PHY support for the Armada8k driver.
> 
> The Armada8k IP only supports x1, x2 or x4 link widths. Iterate over
> the DT 'phys' entries and configure them one by one. Use
> phy_set_mode_ext() to make use of the submode parameter (initially
> introduced for Ethernet modes). For PCI configuration, let the submode
> be the width (1, 2, 4, etc) so that the PHY driver knows how many
> lanes are bundled. Do not error out in case of error for compatibility
> reasons.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 82 +++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)

Applied to pci/armada for v5.3, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 0c389a30ef5d..e567a7cfa3d7 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -25,10 +25,14 @@
>  
>  #include "pcie-designware.h"
>  
> +#define ARMADA8K_PCIE_MAX_LANES PCIE_LNK_X4
> +
>  struct armada8k_pcie {
>  	struct dw_pcie *pci;
>  	struct clk *clk;
>  	struct clk *clk_reg;
> +	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
> +	unsigned int phy_count;
>  };
>  
>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -67,6 +71,76 @@ struct armada8k_pcie {
>  
>  #define to_armada8k_pcie(x)	dev_get_drvdata((x)->dev)
>  
> +static void armada8k_pcie_disable_phys(struct armada8k_pcie *pcie)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARMADA8K_PCIE_MAX_LANES; i++) {
> +		phy_power_off(pcie->phy[i]);
> +		phy_exit(pcie->phy[i]);
> +	}
> +}
> +
> +static int armada8k_pcie_enable_phys(struct armada8k_pcie *pcie)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < ARMADA8K_PCIE_MAX_LANES; i++) {
> +		ret = phy_init(pcie->phy[i]);
> +		if (ret)
> +			return ret;
> +
> +		ret = phy_set_mode_ext(pcie->phy[i], PHY_MODE_PCIE,
> +				       pcie->phy_count);
> +		if (ret) {
> +			phy_exit(pcie->phy[i]);
> +			return ret;
> +		}
> +
> +		ret = phy_power_on(pcie->phy[i]);
> +		if (ret) {
> +			phy_exit(pcie->phy[i]);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int armada8k_pcie_setup_phys(struct armada8k_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	struct device_node *node = dev->of_node;
> +	int ret = 0;
> +	int i;
> +
> +	for (i = 0; i < ARMADA8K_PCIE_MAX_LANES; i++) {
> +		pcie->phy[i] = devm_of_phy_get_by_index(dev, node, i);
> +		if (IS_ERR(pcie->phy[i]) &&
> +		    (PTR_ERR(pcie->phy[i]) == -EPROBE_DEFER))
> +			return PTR_ERR(pcie->phy[i]);
> +
> +		if (IS_ERR(pcie->phy[i])) {
> +			pcie->phy[i] = NULL;
> +			continue;
> +		}
> +
> +		pcie->phy_count++;
> +	}
> +
> +	/* Old bindings miss the PHY handle, so just warn if there is no PHY */
> +	if (!pcie->phy_count)
> +		dev_warn(dev, "No available PHY\n");
> +
> +	ret = armada8k_pcie_enable_phys(pcie);
> +	if (ret)
> +		dev_err(dev, "Failed to initialize PHY(s) (%d)\n", ret);
> +
> +	return ret;
> +}
> +
>  static int armada8k_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u32 reg;
> @@ -249,14 +323,20 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  		goto fail_clkreg;
>  	}
>  
> +	ret = armada8k_pcie_setup_phys(pcie);
> +	if (ret)
> +		goto fail_clkreg;
> +
>  	platform_set_drvdata(pdev, pcie);
>  
>  	ret = armada8k_add_pcie_port(pcie, pdev);
>  	if (ret)
> -		goto fail_clkreg;
> +		goto disable_phy;
>  
>  	return 0;
>  
> +disable_phy:
> +	armada8k_pcie_disable_phys(pcie);
>  fail_clkreg:
>  	clk_disable_unprepare(pcie->clk_reg);
>  fail:
> -- 
> 2.19.1
> 
