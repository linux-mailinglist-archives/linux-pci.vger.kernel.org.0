Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF332DB574
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 21:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgLOUxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 15:53:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:45300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgLOUxU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 15:53:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4480DACC4;
        Tue, 15 Dec 2020 20:52:37 +0000 (UTC)
Date:   Tue, 15 Dec 2020 21:52:35 +0100
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: dwc: tegra194: issue with card containing a bridge
Message-ID: <20201215205235.GC20914@suse.de>
References: <20201215102442.GA20517@suse.de>
 <9a8abc90-cf18-b0c8-3bcb-efbe03f0ca4c@nvidia.com>
 <20201215132504.GA20914@suse.de>
 <20201215154147.GA3885265@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201215154147.GA3885265@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 15, 2020 at 09:41:47AM -0600, Rob Herring wrote:
> On Tue, Dec 15, 2020 at 02:25:04PM +0100, Mian Yousaf Kaukab wrote:
> > On Tue, Dec 15, 2020 at 05:45:59PM +0530, Vidya Sagar wrote:
> > > Thanks Mian for bringing it to our notice.
> > > Have you tried removing the dw_pcie_setup_rc(pp); call from pcie-tegra194.c
> > > file on top of linux-next? and does that solve the issue?
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index 5597b2a49598..1c9e9c054592 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -907,7 +907,7 @@ static void tegra_pcie_prepare_host(struct pcie_port
> > > *pp)
> > >                 dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF,
> > > val);
> > >         }
> > > 
> > > -       dw_pcie_setup_rc(pp);
> > > +       //dw_pcie_setup_rc(pp);
> > I still see the same issue with this change.
> > Reverting b9ac0f9dc8ea works though.
> > > 
> > >         clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> > > 
> > > I took a quick look at the dw_pcie_setup_rc() implementation and I'm not
> > > sure why calling it second time should create any issue for the enumeration
> > > of devices behind a switch. Perhaps I need to spend more time to debug that
> > > part.
> > > In any case, since dw_pcie_setup_rc() is already part of
> > > dw_pcie_host_init(), I think it can be removed from
> > > tegra_pcie_prepare_host() implemention.
> 
> I think the 2nd time is making the link go down is my guess. Tegra was 
> odd in that its start/stop link functions don't do link handling, so I 
> didn't implement those functions and left the link handling in the Tegra 
> driver.
> 
> Can you try the below patch. It needs some more work as it breaks 
> endpoint mode.
> 
> 8<--------------------------------------------------------------------
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 648e731bccfa..49bb487b16ae 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -907,9 +907,32 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
>  		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
>  	}
>  
> -	dw_pcie_setup_rc(pp);
> -
>  	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> +}
> +
> +static int tegra_pcie_dw_host_init(struct pcie_port *pp)
> +{
> +	pp->bridge->ops = &tegra_pci_ops;
> +
> +	tegra_pcie_prepare_host(pp);
> +	tegra_pcie_enable_interrupts(pp);
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
> +{
> +	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> +	u32 val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
> +
> +	return !!(val & PCI_EXP_LNKSTA_DLLLA);
> +}
> +
> +static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
> +{
> +	u32 val, offset, speed, tmp;
> +	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> +	struct pcie_port *pp = &pci->pp;
>  
>  	/* Assert RST */
>  	val = appl_readl(pcie, APPL_PINMUX);
> @@ -929,17 +952,6 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
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
>  		/*
> @@ -975,7 +987,8 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
>  		val &= ~PCI_DLF_EXCHANGE_ENABLE;
>  		dw_pcie_writel_dbi(pci, offset, val);
>  
> -		tegra_pcie_prepare_host(pp);
> +		tegra_pcie_dw_host_init(pp);
> +		dw_pcie_setup_rc(pp);
>  
>  		if (dw_pcie_wait_for_link(pci))
>  			return 0;
> @@ -985,25 +998,6 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
>  		PCI_EXP_LNKSTA_CLS;
>  	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>  
> -	tegra_pcie_enable_interrupts(pp);
> -
> -	return 0;
> -}
> -
> -static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
> -{
> -	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> -	u32 val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
> -
> -	return !!(val & PCI_EXP_LNKSTA_DLLLA);
> -}
> -
> -static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
> -{
> -	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> -
> -	enable_irq(pcie->pex_rst_irq);
> -
>  	return 0;
>  }
>  
Boot is ok with this patch. Some improvement in lspci as well:
# lspci
0001:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad2 (rev a1)
0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 (rev 13)
0005:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1)
0005:01:00.0 PCI bridge: PLX Technology, Inc. Device 3380 (rev ab)

BR,
Yousaf
