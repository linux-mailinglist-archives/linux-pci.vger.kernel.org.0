Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A278E3CCFB2
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jul 2021 11:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhGSITV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 04:19:21 -0400
Received: from foss.arm.com ([217.140.110.172]:52986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235328AbhGSITU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jul 2021 04:19:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDB78ED1;
        Mon, 19 Jul 2021 01:59:59 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BFA93F73D;
        Mon, 19 Jul 2021 01:59:58 -0700 (PDT)
Date:   Mon, 19 Jul 2021 09:59:53 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     marek.vasut@gmail.com, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20210719085953.GA17481@lpieralisi>
References: <20210514200549.431275-1-marek.vasut@gmail.com>
 <20210717173334.GA2232818@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210717173334.GA2232818@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Pali]

On Sat, Jul 17, 2021 at 12:33:34PM -0500, Bjorn Helgaas wrote:
> On Fri, May 14, 2021 at 10:05:49PM +0200, marek.vasut@gmail.com wrote:
> > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > 
> > The R-Car PCIe controller is capable of handling L0s/L1 link states.
> > While the controller can enter and exit L0s link state, and exit L1
> > link state, without any additional action from the driver, to enter
> > L1 link state, the driver must complete the link state transition by
> > issuing additional commands to the controller.
> > 
> > The problem is, this transition is not atomic. The controller sets
> > PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> > the PCIe card, but then the controller enters some sort of inbetween
> > state. The driver must detect this condition and complete the link
> > state transition, by setting L1IATN bit in PMCTLR and waiting for
> > the link state transition to complete.
> > 
> > If a PCIe access happens inside this window, where the controller
> > is between L0 and L1 link states, the access generates a fault and
> > the ARM 'imprecise external abort' handler is invoked.
> > 
> > Just like other PCI controller drivers, here we hook the fault handler,
> > perform the fixup to help the controller enter L1 link state, and then
> > restart the instruction which triggered the fault. Since the controller
> > is in L1 link state now, the link can exit from L1 link state to L0 and
> > successfully complete the access.
> > 
> > While it was suggested to disable L1 link state support completely on
> > the controller level, this would not prevent the L1 link state entry
> > initiated by the link partner. This happens e.g. in case a PCIe card
> > enters D3Hot state, which could be initiated from pci_set_power_state()
> > if the card indicates D3Hot support, which in turn means link must enter
> > L1 state. So instead, fix up the L1 link state after all.
> > 
> > Note that this fixup is applicable only to Aarch32 R-Car controllers,
> > the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
> > 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> > [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
> 
> This patch is horribly ugly but it's working around a horrible
> hardware problem, and I don't have any better suggestions, so I guess
> we don't really have much choice.

Pali is doing some work on the matter (in particular [1] above) and I
was following that up to see if there was any outcome before merging
this code, I could not follow up myself for lack of time.

Lorenzo

> I do think the commit log is a bit glib:
> 
>   - "The R-Car PCIe controller is capable of handling L0s/L1 link
>     states."  AFAICT every PCIe device is required to handle L0 and L1
>     without software assistance.  So saying R-Car is "capable" puts a
>     better face on this than seems warranted.
> 
>     L0s doesn't seem relevant at all; at least it doesn't seem to play
>     a role in the patch.  There's no such thing as "returning to L0s"
>     as mentioned in the comment below; L0s is only reachable from L0.
>     Returns from L1 only go to L0 (PCIe r5.0, fig 5-1).
> 
>   - "The problem is, this transition is not atomic."  I think the
>     *problem* is the hardware is broken in the first place.  This
>     transition is supposed to be invisible to software.
> 
>   - "Just like other PCI controller drivers ..." suggests that this is
>     an ordinary situation that we shouldn't be concerned about.  This
>     patch may be the best we can do to work around a bad hardware
>     defect, but it's definitely not ordinary.
> 
>     I think the other hook_fault_code() uses are for reporting
>     legitimate PCIe errors, which most controllers log and turn
>     into ~0 data responses without generating an abort or machine
>     check, not things caused by hardware defects, so they're not
>     really comparable.
> 
> Has Renesas documented this as an erratum?  Will future devices
> require additions to rcar_pcie_abort_handler_of_match[]?
> 
> It'd be nice if the commit log mentioned the user-visible effect of
> this problem.  I guess it does mention external aborts -- I assume you
> see those when downstream devices go to D3hot or when ASPM puts the
> link in L1?  And the abort results in a reboot?
> 
> To be clear, I'm not objecting to the patch.  It's a hardware problem
> and we should work around it as best we can.
> 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> > V2: - Update commit message, add link to TFA repository commit
> >     - Handle the LPAE case as in ARM fault.c and fsr-{2,3}level.c
> >     - Cache clock and check whether they are enabled before register
> >       access
> > V3: - Fix commit message according to spellchecker
> >     - Use of_find_matching_node() to apply hook only on Gen1 and Gen2 RCar
> >       (in case the kernel is multiplatform)
> > V4: - Mark rcar_pcie_abort_handler_of_match with __initconst
> > V5: - Add mutex around rcar_pcie_aarch32_abort_handler()
> >     - Update commit message again to point out issues with L1/D3Hot states
> > V6: - Return 1 only if condition cannot be fixed
> > ---
> >  drivers/pci/controller/pcie-rcar-host.c | 84 +++++++++++++++++++++++++
> >  drivers/pci/controller/pcie-rcar.h      |  7 +++
> >  2 files changed, 91 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> > index 765cf2b45e24..0d3f8dc5ff8a 100644
> > --- a/drivers/pci/controller/pcie-rcar-host.c
> > +++ b/drivers/pci/controller/pcie-rcar-host.c
> > @@ -13,6 +13,7 @@
> >  
> >  #include <linux/bitops.h>
> >  #include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> >  #include <linux/delay.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > @@ -41,6 +42,21 @@ struct rcar_msi {
> >  	int irq2;
> >  };
> >  
> > +#ifdef CONFIG_ARM
> > +/*
> > + * Here we keep a static copy of the remapped PCIe controller address.
> > + * This is only used on aarch32 systems, all of which have one single
> > + * PCIe controller, to provide quick access to the PCIe controller in
> > + * the L1 link state fixup function, called from the ARM fault handler.
> > + */
> > +static void __iomem *pcie_base;
> > +/*
> > + * Static copy of bus clock pointer, so we can check whether the clock
> > + * is enabled or not.
> > + */
> > +static struct clk *pcie_bus_clk;
> > +#endif
> > +
> >  /* Structure representing the PCIe interface */
> >  struct rcar_pcie_host {
> >  	struct rcar_pcie	pcie;
> > @@ -776,6 +792,12 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
> >  	}
> >  	host->msi.irq2 = i;
> >  
> > +#ifdef CONFIG_ARM
> > +	/* Cache static copy for L1 link state fixup hook on aarch32 */
> > +	pcie_base = pcie->base;
> > +	pcie_bus_clk = host->bus_clk;
> > +#endif
> > +
> >  	return 0;
> >  
> >  err_irq2:
> > @@ -1031,4 +1053,66 @@ static struct platform_driver rcar_pcie_driver = {
> >  	},
> >  	.probe = rcar_pcie_probe,
> >  };
> > +
> > +#ifdef CONFIG_ARM
> > +static DEFINE_SPINLOCK(pmsr_lock);
> > +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
> > +		unsigned int fsr, struct pt_regs *regs)
> > +{
> > +	unsigned long flags;
> > +	int ret = 0;
> > +	u32 pmsr;
> > +
> > +	spin_lock_irqsave(&pmsr_lock, flags);
> > +
> > +	if (!pcie_base || !__clk_is_enabled(pcie_bus_clk)) {
> > +		ret = 1;
> > +		goto unlock_exit;
> > +	}
> > +
> > +	pmsr = readl(pcie_base + PMSR);
> > +
> > +	/*
> > +	 * Test if the PCIe controller received PM_ENTER_L1 DLLP and
> > +	 * the PCIe controller is not in L1 link state. If true, apply
> > +	 * fix, which will put the controller into L1 link state, from
> > +	 * which it can return to L0s/L0 on its own.
> > +	 */
> > +	if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
> > +		writel(L1IATN, pcie_base + PMCTLR);
> > +		while (!(readl(pcie_base + PMSR) & L1FAEG))
> > +			;
> > +		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
> > +	}
> > +
> > +unlock_exit:
> > +	spin_unlock_irqrestore(&pmsr_lock, flags);
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
> > +	{ .compatible = "renesas,pcie-r8a7779" },
> > +	{ .compatible = "renesas,pcie-r8a7790" },
> > +	{ .compatible = "renesas,pcie-r8a7791" },
> > +	{ .compatible = "renesas,pcie-rcar-gen2" },
> > +	{},
> > +};
> > +
> > +static int __init rcar_pcie_init(void)
> > +{
> > +	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> > +#ifdef CONFIG_ARM_LPAE
> > +		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > +				"asynchronous external abort");
> > +#else
> > +		hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > +				"imprecise external abort");
> > +#endif
> > +	}
> > +
> > +	return platform_driver_register(&rcar_pcie_driver);
> > +}
> > +device_initcall(rcar_pcie_init);
> > +#else
> >  builtin_platform_driver(rcar_pcie_driver);
> > +#endif
> > diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
> > index d4c698b5f821..9bb125db85c6 100644
> > --- a/drivers/pci/controller/pcie-rcar.h
> > +++ b/drivers/pci/controller/pcie-rcar.h
> > @@ -85,6 +85,13 @@
> >  #define  LTSMDIS		BIT(31)
> >  #define  MACCTLR_INIT_VAL	(LTSMDIS | MACCTLR_NFTS_MASK)
> >  #define PMSR			0x01105c
> > +#define  L1FAEG			BIT(31)
> > +#define  PMEL1RX		BIT(23)
> > +#define  PMSTATE		GENMASK(18, 16)
> > +#define  PMSTATE_L1		(3 << 16)
> > +#define PMCTLR			0x011060
> > +#define  L1IATN			BIT(31)
> > +
> >  #define MACS2R			0x011078
> >  #define MACCGSPSETR		0x011084
> >  #define  SPCNGRSN		BIT(31)
> > -- 
> > 2.30.2
> > 
