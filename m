Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095431FC162
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 00:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFPWF2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 18:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgFPWF1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 18:05:27 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29BDF2065F;
        Tue, 16 Jun 2020 22:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592345126;
        bh=cjg56MtFckAMNiGqiqesfllN8oo0rmNVNmB85mlA4Gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W8srtufbe+T01VF0pOcteIR1VQgrqfBUimEIAW0zpUUvZSynaxgMAr2DG33cch51c
         VSveF2ucBNY5/1Uvr5BVcKkt8Kcv9lUl/Hd0T9N3XUnf3a2CTxtSwP09KHRDKaB/X3
         4hlq8jLWz6KspsghiP1VbW5Wb2J13QXjhW7QE29s=
Date:   Tue, 16 Jun 2020 17:05:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 07/12] PCI: brcmstb: Add control of rescal reset
Message-ID: <20200616220523.GA1984295@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616205533.3513-8-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 04:55:14PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Some STB chips have a special purpose reset controller named RESCAL (reset
> calibration).  The PCIe HW can now control RESCAL to start and stop its
> operation.

The HW *can* now control RESCAL, but what does this patch do?

I guess maybe this patch uses RESCAL to turn on the PHY in probe and
resume and turn it off in suspend and remove?

> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 81 ++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index d0e256d8578a..9189406fd35c 100644
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
> @@ -248,6 +259,7 @@ struct brcm_pcie {
>  	const int		*reg_offsets;
>  	const int		*reg_field_info;
>  	enum pcie_type		type;
> +	struct reset_control	*rescal;
>  };
>  
>  /*
> @@ -963,6 +975,47 @@ static void brcm_pcie_enter_l23(struct brcm_pcie *pcie)
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
> @@ -990,11 +1043,15 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
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
> @@ -1007,6 +1064,12 @@ static int brcm_pcie_resume(struct device *dev)
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
> @@ -1032,6 +1095,9 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>  {
>  	brcm_msi_remove(pcie);
>  	brcm_pcie_turn_off(pcie);
> +	if (brcm_phy_stop(pcie))
> +		dev_err(pcie->dev, "failed to stop phy\n");
> +	reset_control_assert(pcie->rescal);
>  	clk_disable_unprepare(pcie->clk);
>  }
>  
> @@ -1117,6 +1183,19 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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
> +		return ret;
> +	}
>  
>  	ret = brcm_pcie_setup(pcie);
>  	if (ret)
> -- 
> 2.17.1
> 
