Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE6F261487
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbgIHQZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 12:25:16 -0400
Received: from foss.arm.com ([217.140.110.172]:57366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731892AbgIHQZH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 12:25:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AD1315EC;
        Tue,  8 Sep 2020 06:33:02 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB4823F73C;
        Tue,  8 Sep 2020 06:33:00 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:32:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 06/11] PCI: brcmstb: Add control of rescal reset
Message-ID: <20200908133258.GC22909@e121166-lin.cambridge.arm.com>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-7-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824193036.6033-7-james.quinlan@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 24, 2020 at 03:30:19PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Some STB chips have a special purpose reset controller named RESCAL (reset
> calibration).  The PCIe HW can now control RESCAL to start and stop its
> operation.  On probe(), the RESCAL is deasserted and the driver goes
> through the sequence of setting registers and reading status in order to
> start the internal PHY that is required for the PCIe.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 82 ++++++++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index acf2239b0251..041b8d109563 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/printk.h>
> +#include <linux/reset.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -158,6 +159,16 @@
>  #define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
>  #define PCIE_RGR1_SW_INIT_1(pcie)	(pcie->reg_offsets[RGR1_SW_INIT_1])
>  
> +/* Rescal registers */
> +#define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
> +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS			0x3
> +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_MASK		0x4
> +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_SHIFT	0x2
> +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_MASK		0x2
> +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_SHIFT		0x1
> +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK		0x1
> +#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT		0x0
> +
>  enum {
>  	RGR1_SW_INIT_1,
>  	EXT_CFG_INDEX,
> @@ -247,6 +258,7 @@ struct brcm_pcie {
>  	const int		*reg_offsets;
>  	const int		*reg_field_info;
>  	enum pcie_type		type;
> +	struct reset_control	*rescal;
>  };
>  
>  /*
> @@ -965,6 +977,47 @@ static void brcm_pcie_enter_l23(struct brcm_pcie *pcie)
>  		dev_err(pcie->dev, "failed to enter low-power link state\n");
>  }
>  
> +static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
> +{
> +	static const u32 shifts[PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS] = {
> +		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT,
> +		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_SHIFT,
> +		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_SHIFT,};
> +	static const u32 masks[PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS] = {
> +		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK,
> +		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_MASK,
> +		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_MASK,};
> +	const int beg = start ? 0 : PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS - 1;
> +	const int end = start ? PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS : -1;
> +	u32 tmp, combined_mask = 0;
> +	u32 val = !!start;

Quick note: I think it would be nicer to init val within the loop
below (IIUC how this works):

val = start ? BIT_MASK(shifts[i]) : 0;

and then use it in the tmp computation but I leave it up to you.

Lorenzo

> +	void __iomem *base = pcie->base;
> +	int i;
> +
> +	for (i = beg; i != end; start ? i++ : i--) {
> +		tmp = readl(base + PCIE_DVT_PMU_PCIE_PHY_CTRL);
> +		tmp = (tmp & ~masks[i]) | ((val << shifts[i]) & masks[i]);
> +		writel(tmp, base + PCIE_DVT_PMU_PCIE_PHY_CTRL);
> +		usleep_range(50, 200);
> +		combined_mask |= masks[i];
> +	}
> +
> +	tmp = readl(base + PCIE_DVT_PMU_PCIE_PHY_CTRL);
> +	val = start ? combined_mask : 0;
> +
> +	return (tmp & combined_mask) == val ? 0 : -EIO;
> +}
> +
> +static inline int brcm_phy_start(struct brcm_pcie *pcie)
> +{
> +	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
> +}
> +
> +static inline int brcm_phy_stop(struct brcm_pcie *pcie)
> +{
> +	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
> +}
> +
>  static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  {
>  	void __iomem *base = pcie->base;
> @@ -992,11 +1045,15 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  static int brcm_pcie_suspend(struct device *dev)
>  {
>  	struct brcm_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
>  
>  	brcm_pcie_turn_off(pcie);
> +	ret = brcm_phy_stop(pcie);
> +	if (ret)
> +		dev_err(pcie->dev, "failed to stop phy\n");
>  	clk_disable_unprepare(pcie->clk);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int brcm_pcie_resume(struct device *dev)
> @@ -1009,6 +1066,12 @@ static int brcm_pcie_resume(struct device *dev)
>  	base = pcie->base;
>  	clk_prepare_enable(pcie->clk);
>  
> +	ret = brcm_phy_start(pcie);
> +	if (ret) {
> +		dev_err(pcie->dev, "failed to start phy\n");
> +		return ret;
> +	}
> +
>  	/* Take bridge out of reset so we can access the SERDES reg */
>  	brcm_pcie_bridge_sw_init_set(pcie, 0);
>  
> @@ -1034,6 +1097,9 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>  {
>  	brcm_msi_remove(pcie);
>  	brcm_pcie_turn_off(pcie);
> +	if (brcm_phy_stop(pcie))
> +		dev_err(pcie->dev, "failed to stop phy\n");
> +	reset_control_assert(pcie->rescal);
>  	clk_disable_unprepare(pcie->clk);
>  }
>  
> @@ -1112,6 +1178,20 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "could not enable clock\n");
>  		return ret;
>  	}
> +	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> +	if (IS_ERR(pcie->rescal))
> +		return PTR_ERR(pcie->rescal);
> +
> +	ret = reset_control_deassert(pcie->rescal);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> +
> +	ret = brcm_phy_start(pcie);
> +	if (ret) {
> +		dev_err(pcie->dev, "failed to start phy\n");
> +		reset_control_assert(pcie->rescal);
> +		return ret;
> +	}
>  
>  	ret = brcm_pcie_setup(pcie);
>  	if (ret)
> -- 
> 2.17.1
> 
