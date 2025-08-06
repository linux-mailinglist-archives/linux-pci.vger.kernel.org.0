Return-Path: <linux-pci+bounces-33473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDD7B1CC61
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE6F7A6339
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 19:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438AB29E0EA;
	Wed,  6 Aug 2025 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQdhWvEg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7D13C01;
	Wed,  6 Aug 2025 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507691; cv=none; b=ORL96QFfdol+tttP10dkhZd1SK0YTV/gKHYy5qF+4Kbhb/N41oCG3T9XgsT/YR+sQMAcEIm6105brAMfIgAbF3f4/s+Bgo49DpVok82/b+Ku80R9pCnnjjdRBtn+pvIfiMONMVyt4XErmcI8jTeam4tw5a2BRKK+N9J1TCIv9hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507691; c=relaxed/simple;
	bh=ydQo/qDZK3xKlXT0YMaYteDL2FGoGeQkbdadaVZY63M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hwigCy8rcSxe7w8niPsj4FNsM+NtN2EfyA3/pnYAwVuYWCjfVdWgWcccDkc/N11pGr+2B/GtSOY46RwNOsgKXL4bHXSdybCBtbrPtm+qTbojUGwOtNVAqIQKF38hZeFODA6MU+pTocD1BG4Q7g9XIgJGn5BnznxjIub3n93UJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQdhWvEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614E5C4CEE7;
	Wed,  6 Aug 2025 19:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754507690;
	bh=ydQo/qDZK3xKlXT0YMaYteDL2FGoGeQkbdadaVZY63M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MQdhWvEgHPdVSeTX/z+JUajRTvqoAcxHTNRJqIhduPRIbyO2lWvEBIax3jQJ3Nfd6
	 sNrjSeQogRo3tjlaW6l3W9YFqW4FnDYFldaNOqVh/rPv1MGPhTIKcQUx2iSUKMj7ea
	 XDXGge1JXnyfYsabfYt0Q90qq646oQU6PvRW1ghNTYI19CR4UP8+1Zy5HxvAkX+13n
	 iiacjk6d58Dxb4fHt24A/dJCeElI/hXAMa9H74VFIm5glVxjrCaAtH1COi+9hma/I7
	 sYEaOFAM+w3kdKihYX2J7rRd9KUjvy91oQbPIkalAj4Cps/j4SQQuUUOJX5Ps7DpYS
	 7WUel1/hOmzYA==
Date: Wed, 6 Aug 2025 14:14:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge
 is active
Message-ID: <20250806191448.GA8432@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613220843.698227-2-james.quinlan@broadcom.com>

On Fri, Jun 13, 2025 at 06:08:42PM -0400, Jim Quinlan wrote:
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
>  drivers/pci/controller/pcie-brcmstb.c | 40 +++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 92887b394eb4..400854c893d8 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -29,6 +29,7 @@
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
>  
> @@ -254,6 +255,7 @@ struct pcie_cfg_data {
>  	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  	int (*post_setup)(struct brcm_pcie *pcie);
> +	bool has_err_report;

It doesn't look worth it to me to add this.  It only avoids locking in
a non-performance path.

>  };
>  
>  struct subdev_regulators {
> @@ -299,6 +301,8 @@ struct brcm_pcie {
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
>  	const struct pcie_cfg_data	*cfg;
> +	bool			bridge_on;
> +	spinlock_t		bridge_lock;
>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -306,6 +310,24 @@ static inline bool is_bmips(const struct brcm_pcie *pcie)
>  	return pcie->cfg->soc_base == BCM7435 || pcie->cfg->soc_base == BCM7425;
>  }
>  
> +static inline int brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	if (pcie->cfg->has_err_report)
> +		spin_lock_irqsave(&pcie->bridge_lock, flags);
> +
> +	ret = pcie->cfg->bridge_sw_init_set(pcie, val);
> +	if (ret)
> +		pcie->bridge_on = !val;

AFAICT, .bridge_sw_init_set(1) asserts reset, .bridge_sw_init_set(0)
deasserts reset, and it returns 0 for success, so I'm confused about
this.  If either assert or deassert failed (ret != 0), I guess we
don't know the state of the bridge and can't assume it's active, so I
would have expected something like:

  ret = pcie->cfg->bridge_sw_init_set(pcie, val);
  if (ret)
    pcie->bridge_on = false;
  else
    pcie->bridge_on = !val;

Tangent: the last "return ret" in brcm_pcie_bridge_sw_init_set_generic()
should be "return 0" and drop the unnecessary initialization of "ret".

And the code there would be vastly improved by using FIELD_PREP() or
u32p_replace_bits() and getting rid of the shifting.

> +	if (pcie->cfg->has_err_report)
> +		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
> +
> +	return ret;
> +}
> +
>  /*
>   * This is to convert the size of the inbound "BAR" region to the
>   * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
> @@ -1078,7 +1100,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	int memc, ret;
>  
>  	/* Reset the bridge */
> -	ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
> +	ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
>  	if (ret)
>  		return ret;
>  
> @@ -1094,7 +1116,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	usleep_range(100, 200);
>  
>  	/* Take the bridge out of reset */
> -	ret = pcie->cfg->bridge_sw_init_set(pcie, 0);
> +	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
>  	if (ret)
>  		return ret;
>  
> @@ -1545,7 +1567,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  
>  	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
>  		/* Shutdown PCIe bridge */
> -		ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
> +		ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
>  
>  	return ret;
>  }
> @@ -1633,7 +1655,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
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
> @@ -1901,7 +1925,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>  
> -	pcie->cfg->bridge_sw_init_set(pcie, 0);
> +	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "could not un-reset the bridge\n");

"un-reset" doesn't mean anything to me.  Is this the same as "could
not take the bridge out of reset"?  Or maybe "could not deassert
bridge reset"?

>  	if (pcie->swinit_reset) {
>  		ret = reset_control_assert(pcie->swinit_reset);
> @@ -1976,6 +2003,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	if (pcie->cfg->has_err_report)
> +		spin_lock_init(&pcie->bridge_lock);
> +
>  	return 0;
>  
>  fail:
> -- 
> 2.34.1
> 

