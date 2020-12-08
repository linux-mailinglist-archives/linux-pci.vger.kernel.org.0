Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D60E2D28B1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 11:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgLHKTQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 05:19:16 -0500
Received: from foss.arm.com ([217.140.110.172]:46982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgLHKTQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 05:19:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FE061FB;
        Tue,  8 Dec 2020 02:18:30 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E9613F68F;
        Tue,  8 Dec 2020 02:18:29 -0800 (PST)
Date:   Tue, 8 Dec 2020 10:18:23 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20201208101823.GA30579@e121166-lin.cambridge.arm.com>
References: <20201016120416.7008-1-marek.vasut@gmail.com>
 <20201119173553.GB23852@e121166-lin.cambridge.arm.com>
 <57358982-ef8c-ed91-c011-00b8a48c4ebd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57358982-ef8c-ed91-c011-00b8a48c4ebd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 29, 2020 at 02:05:08PM +0100, Marek Vasut wrote:
> On 11/19/20 6:35 PM, Lorenzo Pieralisi wrote:
> > > +#ifdef CONFIG_ARM
> > > +/*
> > > + * Here we keep a static copy of the remapped PCIe controller address.
> > > + * This is only used on aarch32 systems, all of which have one single
> > > + * PCIe controller, to provide quick access to the PCIe controller in
> > > + * the L1 link state fixup function, called from the ARM fault handler.
> > > + */
> > > +static void __iomem *pcie_base;
> > > +/*
> > > + * Static copy of bus clock pointer, so we can check whether the clock
> > > + * is enabled or not.
> > > + */
> > > +static struct clk *pcie_bus_clk;
> > > +#endif
> > 
> > Don't think you can have multiple host bridges in a given platform,
> > if it is a possible configuration this won't work.
> 
> Correct, all the affected platforms have only one host bridge.
> 
> > >   static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
> > >   {
> > >   	return container_of(chip, struct rcar_msi, chip);
> > > @@ -804,6 +820,12 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
> > >   	}
> > >   	host->msi.irq2 = i;
> > > +#ifdef CONFIG_ARM
> > > +	/* Cache static copy for L1 link state fixup hook on aarch32 */
> > > +	pcie_base = pcie->base;
> > > +	pcie_bus_clk = host->bus_clk;
> > > +#endif
> > > +
> > >   	return 0;
> > >   err_irq2:
> > > @@ -1050,4 +1072,58 @@ static struct platform_driver rcar_pcie_driver = {
> > >   	},
> > >   	.probe = rcar_pcie_probe,
> > >   };
> > > +
> > > +#ifdef CONFIG_ARM
> > > +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
> > > +		unsigned int fsr, struct pt_regs *regs)
> > > +{
> > > +	u32 pmsr;
> > > +
> > > +	if (!pcie_base || !__clk_is_enabled(pcie_bus_clk))
> > > +		return 1;
> > > +
> > > +	pmsr = readl(pcie_base + PMSR);
> > > +
> > > +	/*
> > > +	 * Test if the PCIe controller received PM_ENTER_L1 DLLP and
> > > +	 * the PCIe controller is not in L1 link state. If true, apply
> > > +	 * fix, which will put the controller into L1 link state, from
> > > +	 * which it can return to L0s/L0 on its own.
> > > +	 */
> > > +	if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
> > > +		writel(L1IATN, pcie_base + PMCTLR);
> > > +		while (!(readl(pcie_base + PMSR) & L1FAEG))
> > > +			;
> > > +		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
> > > +		return 0;
> > > +	}
> > 
> > I suppose a fault on multiple cores can happen simultaneously, if it
> > does this may not work well either - I assume all config/io/mem would
> > trigger a fault.
> > 
> > As I mentioned in my reply to v1, is there a chance we can move
> > this quirk into config accessors (if the PM_ENTER_L1_DLLP is
> > subsequent to a write into PMCSR to programme a D state) ?
> 
> I don't think we can, since the userspace can do such a config space write
> with e.g. setpci and then this fixup is still needed.


Userspace goes via the kernel config accessors anyway, right ?

I would like to avoid having arch specific hooks in PCI drivers so
if we can work around it somehow it is much better.

I can still merge this patch this week but I would like to explore
alternatives before committing it.

Lorenzo
> 
> > Config access is serialized but I suspect as I said above that this
> > triggers on config/io/mem alike.
> > 
> > Just asking to try to avoid a fault handler if possible.
> 
> See above, I doubt we can fully avoid this workaround.
> 
> [...]
