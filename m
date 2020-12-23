Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249B92E2085
	for <lists+linux-pci@lfdr.de>; Wed, 23 Dec 2020 19:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgLWSjp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Dec 2020 13:39:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgLWSjp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Dec 2020 13:39:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F23D122287;
        Wed, 23 Dec 2020 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608748744;
        bh=IZ8pQJgK4JEcx+I6z3wHFfBvNcw3TuumYonqGmKzUh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RDINOx4X2BGZ2jOyvn0K27LmPQKDWXXaYVQJNSuZ+1q9yMPBuF/vrwS63CxQlFJNW
         12CoX3KpvT1dQWWMAxzrB5OQVZFVgMPNNtCl+vwEpmuT1NhffFxM+0TFAnexT0MbJZ
         iVmZ67TFrZelObyYmJmL5nWjAHdjXiwU6wD4m/7RpXvgTSN89bW+QZ2e4ipHt7ZknO
         d3puUUbtXBz/4nGfIr4Tg3NbingsFsbbY42jDzcELX0NdOkW9AP+PmOar27NB7gPsa
         rrVCtSI7P/wT/suRkFOsHCHNgmsD1e8HNE6gnHeKcgsS7iBzc9Xrmm1rIHl33w3cQF
         qL7QcpxnTW0SA==
Date:   Wed, 23 Dec 2020 12:39:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc/tegra: Fix host link initialization
Message-ID: <20201223183902.GA310430@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218143905.1614098-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 18, 2020 at 08:39:05AM -0600, Rob Herring wrote:
> Commit b9ac0f9dc8ea ("PCI: dwc: Move dw_pcie_setup_rc() to DWC common
> code") broke enumeration of downstream devices on Tegra:
> 
> In non working case (next-20201211):
> 0001:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad2 (rev a1)
> 0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 (rev 13)
> 0005:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1)
> 
> In working case (v5.10-rc7):
> 0001:00:00.0 PCI bridge: Molex Incorporated Device 1ad2 (rev a1)
> 0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 (rev 13)
> 0005:00:00.0 PCI bridge: Molex Incorporated Device 1ad0 (rev a1)
> 0005:01:00.0 PCI bridge: PLX Technology, Inc. Device 3380 (rev ab)
> 0005:02:02.0 PCI bridge: PLX Technology, Inc. Device 3380 (rev ab)
> 0005:03:00.0 USB controller: PLX Technology, Inc. Device 3380 (rev ab)
> 
> The problem seems to be dw_pcie_setup_rc() is now called twice before
> and after the link up handling. The fix is to move Tegra's link up
> handling to .start_link() function like other DWC drivers. Tegra is a
> bit more complicated than others as it re-inits the whole DWC controller
> to retry the link. With this, the initialization ordering is restored to
> match the prior sequence.
> 
> Fixes: b9ac0f9dc8ea ("PCI: dwc: Move dw_pcie_setup_rc() to DWC common code")
> Reported-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Vidya Sagar <vidyas@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> Tested-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Mian, One addition to what you tested. The resume hook also needs to
> call start_link and that part was moved out of host_init.
> 
> Also, I noticed it looks like suspend/resume is broken for endpoint mode
> as the hooks are for host mode only.
> 
> Bjorn, please apply this for v5.11.

Applied to for-linus for (hopefully) v5.11-rc1, since b9ac0f9dc8ea
will also appear in v5.11-rc1.  Thanks!

> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 55 ++++++++++++----------
>  1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 5597b2a49598..6fa216e52d14 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -853,12 +853,14 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
>  	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
>  }
>  
> -static void tegra_pcie_prepare_host(struct pcie_port *pp)
> +static int tegra_pcie_dw_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>  	u32 val;
>  
> +	pp->bridge->ops = &tegra_pci_ops;
> +
>  	if (!pcie->pcie_cap_base)
>  		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>  							      PCI_CAP_ID_EXP);
> @@ -907,10 +909,24 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
>  		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
>  	}
>  
> -	dw_pcie_setup_rc(pp);
> -
>  	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
>  
> +	return 0;
> +}
> +
> +static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
> +{
> +	u32 val, offset, speed, tmp;
> +	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> +	struct pcie_port *pp = &pci->pp;
> +	bool retry = true;
> +
> +	if (pcie->mode == DW_PCIE_EP_TYPE) {
> +		enable_irq(pcie->pex_rst_irq);
> +		return 0;
> +	}
> +
> +retry_link:
>  	/* Assert RST */
>  	val = appl_readl(pcie, APPL_PINMUX);
>  	val &= ~APPL_PINMUX_PEX_RST;
> @@ -929,19 +945,10 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
>  	appl_writel(pcie, val, APPL_PINMUX);
>  
>  	msleep(100);
> -}
> -
> -static int tegra_pcie_dw_host_init(struct pcie_port *pp)
> -{
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> -	u32 val, tmp, offset, speed;
> -
> -	pp->bridge->ops = &tegra_pci_ops;
> -
> -	tegra_pcie_prepare_host(pp);
>  
>  	if (dw_pcie_wait_for_link(pci)) {
> +		if (!retry)
> +			return 0;
>  		/*
>  		 * There are some endpoints which can't get the link up if
>  		 * root port has Data Link Feature (DLF) enabled.
> @@ -975,10 +982,11 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
>  		val &= ~PCI_DLF_EXCHANGE_ENABLE;
>  		dw_pcie_writel_dbi(pci, offset, val);
>  
> -		tegra_pcie_prepare_host(pp);
> +		tegra_pcie_dw_host_init(pp);
> +		dw_pcie_setup_rc(pp);
>  
> -		if (dw_pcie_wait_for_link(pci))
> -			return 0;
> +		retry = false;
> +		goto retry_link;
>  	}
>  
>  	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> @@ -998,15 +1006,6 @@ static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
>  	return !!(val & PCI_EXP_LNKSTA_DLLLA);
>  }
>  
> -static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
> -{
> -	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> -
> -	enable_irq(pcie->pex_rst_irq);
> -
> -	return 0;
> -}
> -
>  static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
>  {
>  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> @@ -2215,6 +2214,10 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
>  		goto fail_host_init;
>  	}
>  
> +	ret = tegra_pcie_dw_start_link(&pcie->pci);
> +	if (ret < 0)
> +		goto fail_host_init;
> +
>  	/* Restore MSI interrupt vector */
>  	dw_pcie_writel_dbi(&pcie->pci, PORT_LOGIC_MSI_CTRL_INT_0_EN,
>  			   pcie->msi_ctrl_int);
> -- 
> 2.25.1
> 
