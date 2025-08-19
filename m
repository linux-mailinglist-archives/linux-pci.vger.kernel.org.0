Return-Path: <linux-pci+bounces-34313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE6AB2C942
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 18:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174DA7A71C5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BDB2C08AA;
	Tue, 19 Aug 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSm0Q3pj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2C92BFC60;
	Tue, 19 Aug 2025 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620048; cv=none; b=hyiEoPhOt3AFgFV7tj2RwOOUOIWhzHrrU5Y/l0dW5uaSB7qaT/6MBDyN0xd6CzavZut1tyE5XU0BJyWFyv3LtMdj9aHjo1cTFnZlTkq/dJXq4GqrPBCbOKB/JlnZUswH9c4c3cUR8oXYge6+SDU3yZ3YW3bLB/TyMtVUrozvf4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620048; c=relaxed/simple;
	bh=7mkf/EqhebSrqdh5k2QADksG30ir99A1YyktolOn9J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvepx9D04+UclS2hMThAZVjcfY7SQdpSispUkjQKOAkmwkw0+N9himDfNOc9gYghJ4jfUNyyPWYLaGF4lnMlzb2j2kXa+YuiNKVofOUtiX7R6hKSxc1HLhTM5ttB1jFy9xsil+zwB8HQlbj00Pvef6BtUqIbDk7YQK4Ci6QVBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSm0Q3pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E8BC116B1;
	Tue, 19 Aug 2025 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755620047;
	bh=7mkf/EqhebSrqdh5k2QADksG30ir99A1YyktolOn9J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSm0Q3pjLsLdY1MXZuiq4rwR2K/cBlGRf5KZAcZXIpQzdPvDjh+SRvBLRB3WyTdgo
	 R9AFdkpqETBYl1rexcCKiX7hI3cFquQYDWtI1d+Gzd/sSPVeeDxXWoRRMv4AKy/kCc
	 KQUB2is0f46tmM0GyZ5byyG9xif/Kd5JkCI/Yivt1219xxOjn39l+EHgb5dX9xia2a
	 +rgP8tSBk30N6scO2PQC7qElTHEwc0pbucR81nTMxC68WfZlnT5UgKmnz05agZoYHU
	 BH/sauRG8oubY6Gi+iDVHetexvJc4AkG4vhPGgyK3WPqc8RStjY1WDLjx2L6x+cFZe
	 BuigNcKYViDYg==
Date: Tue, 19 Aug 2025 21:43:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: brcmstb: Add a way to indicate if PCIe
 bridge is active
Message-ID: <6maieqyzt2c73l7pbk37owh7dfjybnhgq746h5zxjhvmp3f472@dx4ibad3en6f>
References: <20250807221513.1439407-1-james.quinlan@broadcom.com>
 <20250807221513.1439407-2-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807221513.1439407-2-james.quinlan@broadcom.com>

On Thu, Aug 07, 2025 at 06:15:12PM GMT, Jim Quinlan wrote:
> In a future commit, a new handler will be introduced that in part does
> reads and writes to some of the PCIe registers.  When this handler is
> invoked, it is paramount that it does not do these register accesses when
> the PCIe bridge is inactive, as this will cause CPU abort errors.
> 
> To solve this we keep a spinlock that guards a variable which indicates
> whether the bridge is on or off.  When the bridge is on, access of the PCIe
> HW registers may proceed.
> 
> Since there are multiple ways to reset the bridge, we introduce a general
> function to obtain the spinlock, call the specific function that is used
> for the specific SoC, sets the bridge active indicator variable, and
> releases the spinlock.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 51 +++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 9afbd02ded35..ceb431a252b7 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -30,6 +30,7 @@
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
>  
> @@ -259,6 +260,7 @@ struct pcie_cfg_data {
>  	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  	int (*post_setup)(struct brcm_pcie *pcie);
> +	bool has_err_report;
>  };
>  
>  struct subdev_regulators {
> @@ -303,6 +305,8 @@ struct brcm_pcie {
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
>  	const struct pcie_cfg_data	*cfg;
> +	bool			bridge_on;
> +	spinlock_t		bridge_lock;
>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -310,6 +314,24 @@ static inline bool is_bmips(const struct brcm_pcie *pcie)
>  	return pcie->cfg->soc_base == BCM7435 || pcie->cfg->soc_base == BCM7425;
>  }
>  
> +static inline int brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)

No need to specify 'inline' keyword.

> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	if (pcie->cfg->has_err_report)
> +		spin_lock_irqsave(&pcie->bridge_lock, flags);
> +
> +	ret = pcie->cfg->bridge_sw_init_set(pcie, val);
> +	/* If we fail, assume the bridge is in reset (off) */
> +	pcie->bridge_on = ret ? false : !val;

s/bridge_on/bridge_in_reset

This callback is not necessarily turning the bridge ON/OFF.

> +
> +	if (pcie->cfg->has_err_report)
> +		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
> +
> +	return ret;
> +}
> +
>  /*
>   * This is to convert the size of the inbound "BAR" region to the
>   * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
> @@ -756,9 +778,8 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>  
>  static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  {
> -	u32 tmp, mask = RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> -	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> -	int ret = 0;
> +	u32 tmp;
> +	int ret;
>  
>  	if (pcie->bridge_reset) {
>  		if (val)
> @@ -774,10 +795,10 @@ static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  	}
>  
>  	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> -	tmp = (tmp & ~mask) | ((val << shift) & mask);
> +	u32p_replace_bits(&tmp, val, RGR1_SW_INIT_1_INIT_GENERIC_MASK);

This change doesn't belong to this patch.

>  	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
> @@ -1081,7 +1102,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	int memc, ret;
>  
>  	/* Reset the bridge */
> -	ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
> +	ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
>  	if (ret)
>  		return ret;
>  
> @@ -1097,7 +1118,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	usleep_range(100, 200);
>  
>  	/* Take the bridge out of reset */
> -	ret = pcie->cfg->bridge_sw_init_set(pcie, 0);
> +	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
>  	if (ret)
>  		return ret;
>  
> @@ -1565,7 +1586,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  
>  	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
>  		/* Shutdown PCIe bridge */
> -		ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
> +		ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
>  
>  	return ret;
>  }
> @@ -1653,7 +1674,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
>  		goto err_reset;
>  
>  	/* Take bridge out of reset so we can access the SERDES reg */
> -	pcie->cfg->bridge_sw_init_set(pcie, 0);
> +	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
> +	if (ret)
> +		goto err_reset;
>  
>  	/* SERDES_IDDQ = 0 */
>  	tmp = readl(base + HARD_DEBUG(pcie));
> @@ -1921,7 +1944,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>  
> -	pcie->cfg->bridge_sw_init_set(pcie, 0);
> +	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "could not un-reset the bridge\n");

I believe Bjorn asked you to change this error message to:
'could not deassert the bridge' or similar, but you ended up changing the
unrelated error message below.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

