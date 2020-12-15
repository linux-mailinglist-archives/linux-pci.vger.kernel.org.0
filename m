Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAAB2DB570
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 21:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgLOUwr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 15:52:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:44686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbgLOUvW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 15:51:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 666C3AC93;
        Tue, 15 Dec 2020 20:50:37 +0000 (UTC)
Date:   Tue, 15 Dec 2020 21:50:35 +0100
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: dwc: tegra194: issue with card containing a bridge
Message-ID: <20201215205035.GB20914@suse.de>
References: <20201215102442.GA20517@suse.de>
 <9a8abc90-cf18-b0c8-3bcb-efbe03f0ca4c@nvidia.com>
 <20201215132504.GA20914@suse.de>
 <20201215154147.GA3885265@robh.at.kernel.org>
 <20201215194421.GA89317@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201215194421.GA89317@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 15, 2020 at 01:44:21PM -0600, Rob Herring wrote:
> On Tue, Dec 15, 2020 at 09:41:47AM -0600, Rob Herring wrote:
> > On Tue, Dec 15, 2020 at 02:25:04PM +0100, Mian Yousaf Kaukab wrote:
> > > On Tue, Dec 15, 2020 at 05:45:59PM +0530, Vidya Sagar wrote:
> > > > Thanks Mian for bringing it to our notice.
> > > > Have you tried removing the dw_pcie_setup_rc(pp); call from pcie-tegra194.c
> > > > file on top of linux-next? and does that solve the issue?
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > index 5597b2a49598..1c9e9c054592 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > @@ -907,7 +907,7 @@ static void tegra_pcie_prepare_host(struct pcie_port
> > > > *pp)
> > > >                 dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF,
> > > > val);
> > > >         }
> > > > 
> > > > -       dw_pcie_setup_rc(pp);
> > > > +       //dw_pcie_setup_rc(pp);
> > > I still see the same issue with this change.
> > > Reverting b9ac0f9dc8ea works though.
> > > > 
> > > >         clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> > > > 
> > > > I took a quick look at the dw_pcie_setup_rc() implementation and I'm not
> > > > sure why calling it second time should create any issue for the enumeration
> > > > of devices behind a switch. Perhaps I need to spend more time to debug that
> > > > part.
> > > > In any case, since dw_pcie_setup_rc() is already part of
> > > > dw_pcie_host_init(), I think it can be removed from
> > > > tegra_pcie_prepare_host() implemention.
> > 
> > I think the 2nd time is making the link go down is my guess. Tegra was 
> > odd in that its start/stop link functions don't do link handling, so I 
> > didn't implement those functions and left the link handling in the Tegra 
> > driver.
> > 
> > Can you try the below patch. It needs some more work as it breaks 
> > endpoint mode.
> 
> That one missed some re-init. Try this one instead
> 
> 8<--------------------------------------------------------------------
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 5597b2a49598..d8fed3561e91 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -933,14 +933,24 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
>  
>  static int tegra_pcie_dw_host_init(struct pcie_port *pp)
>  {
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> -	u32 val, tmp, offset, speed;
> -
>  	pp->bridge->ops = &tegra_pci_ops;
>  
>  	tegra_pcie_prepare_host(pp);
>  
> +	return 0;
> +}
> +
> +static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
> +{
> +	u32 val, offset, speed, tmp;
> +	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> +	struct pcie_port *pp = &pci->pp;
> +
> +	if (pcie->mode == DW_PCIE_EP_TYPE) {
> +		enable_irq(pcie->pex_rst_irq);
> +		return 0;
> +	}
> +
>  	if (dw_pcie_wait_for_link(pci)) {
>  		/*
>  		 * There are some endpoints which can't get the link up if
> @@ -998,15 +1008,6 @@ static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
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
With USB3380 card PTM enabled... is the last message I see. It doesn't
boot further:
[    9.124500] tegra194-pcie 141a0000.pcie: iATU unroll: enabled
[    9.130310] tegra194-pcie 141a0000.pcie: Detected iATU regions: 8 outbound, 2 inbound
[    9.138915] tegra194-pcie 141a0000.pcie: Link up
[    9.144940] tegra194-pcie 141a0000.pcie: PCI host bridge to bus 0005:00
[    9.151849] pci_bus 0005:00: root bus resource [bus 00-ff]
[    9.157595] pci_bus 0005:00: root bus resource [mem 0x1c00000000-0x1f3fffffff pref]
[    9.165509] pci_bus 0005:00: root bus resource [mem 0x1f40000000-0x1ffffeffff] (bus address [0x40000000-0xfffeffff])
[    9.176444] pci_bus 0005:00: root bus resource [io  0x30000-0x3ffff] (bus address [0x0000-0xffff])
[    9.186189] pci 0005:00:00.0: [10de:1ad0] type 01 class 0x060400
[    9.193638] pci 0005:00:00.0: PME# supported from D0 D3hot D3cold
[    9.200626] pci 0005:00:00.0: PTM enabled (root), 16ns granularity

With a Nvidia GT530 It boots to the prompt:
[    9.133576] tegra194-pcie 141a0000.pcie: iATU unroll: enabled
[    9.139371] tegra194-pcie 141a0000.pcie: Detected iATU regions: 8 outbound, 2 inbound
[   10.152565] tegra194-pcie 141a0000.pcie: Phy link never came up
[   11.164571] tegra194-pcie 141a0000.pcie: Phy link never came up
[   11.172598] tegra194-pcie 141a0000.pcie: PCI host bridge to bus 0005:00
[   11.179999] pci_bus 0005:00: root bus resource [bus 00-ff]
[   11.185998] pci_bus 0005:00: root bus resource [mem 0x1c00000000-0x1f3fffffff pref]
[   11.194120] pci_bus 0005:00: root bus resource [mem 0x1f40000000-0x1ffffeffff] (bus address [0x40000000-0xfffeffff])
[   11.205339] pci_bus 0005:00: root bus resource [io  0x30000-0x3ffff] (bus address [0x0000-0xffff])
[   11.215464] pci 0005:00:00.0: [10de:1ad0] type 01 class 0x060400
[   11.224039] pci 0005:00:00.0: PME# supported from D0 D3hot D3cold
[   11.231086] pci 0005:00:00.0: PTM enabled (root), 16ns granularity
[   11.268132] pci 0005:00:00.0: PCI bridge to [bus 01-ff]
[   11.275849] pcieport 0005:00:00.0: PME: Signaling with IRQ 54
[   11.284553] pcieport 0005:00:00.0: AER: enabled with IRQ 54
[   11.291322] pcieport 0005:00:00.0: bw_notification: enabled with IRQ 54
[   11.299108] pci_bus 0005:01: busn_res: [bus 01-ff] is released
[   11.305119] pci_bus 0005:00: busn_res: [bus 00-ff] is released
...
However, lspci doesn't list GT530. Before the patch GT530 was working
properly.

BR,
Yousaf
