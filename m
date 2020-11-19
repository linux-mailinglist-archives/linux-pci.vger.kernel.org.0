Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2992B97D2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 17:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgKSQZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 11:25:16 -0500
Received: from foss.arm.com ([217.140.110.172]:33848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbgKSQZP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 11:25:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C49251478;
        Thu, 19 Nov 2020 08:25:14 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E8363F719;
        Thu, 19 Nov 2020 08:25:13 -0800 (PST)
Date:   Thu, 19 Nov 2020 16:25:08 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     marek.vasut@gmail.com, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20201119162508.GA23852@e121166-lin.cambridge.arm.com>
References: <20200912211853.15321-1-marek.vasut@gmail.com>
 <20200913172207.GA1194428@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913172207.GA1194428@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 13, 2020 at 12:22:07PM -0500, Bjorn Helgaas wrote:
> On Sat, Sep 12, 2020 at 11:18:53PM +0200, marek.vasut@gmail.com wrote:
> > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > 
> > The R-Car PCIe controller is capable of handling L0s/L1 link states.
> > While the controller can enter and exit L0s link state, and exit L1
> > link state, without any additional action from the driver, to enter
> > L1 link state, the driver must complete the link state transition by
> > issuing additional commands to the controller.
> 
> So IIUC an R-Car Root Port can't enter L1 without help from the
> driver?  That *sounds* like a hardware defect, since ASPM is supposed
> to be "hardware-autonomous" once configured.

Sorry for the late feedback, starting to queue patches for v5.11.

Is this issue ASPM related (ie is it supported by the host controller) ?

*Or* it is related to kernel driven device D-{1,2,3} L1 entry ?

I am asking because if it is only related to D-{1,2,3} device state
entry we could intercept the PMCSR write and move the quirk in config
space accessors.

Lorenzo

> > The problem is, this transition is not atomic. The controller sets
> > PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> > the PCIe card, but then the controller enters some sort of inbetween
> > state. The driver must detect this condition and complete the link
> > state transition, by setting L1IATN bit in PMCTLR and waiting for
> > the link state transition to complete.
> > 
> > If a PCIe access happens inside of this window, where the controller
> > is inbetween L0 and L1 link states, the access generates a fault and
> > the ARM 'imprecise external abort' handler is invoked.
> 
> Let me see if I understand this.
> 
>   1) Endpoint sends PM_ENTER_L1
>   2) R-Car Root Port receives PM_ENTER_L1, sets PMEL1RX
>   3) R-Car driver does something to complete transition to L1
> 
> And if the Endpoint driver does an MMIO access between 2) and 3), it
> causes an external abort?
> 
> I couldn't find anything in the R-Car driver today that completes the
> transition to L1.
> 
> And the MMIO access will immediately bring the link back to L0, won't
> it?
> 
> Is there any benefit to L1 at all for this Root Port?  If it can't
> enter L1 and just stays in the in-between state until some event that
> will bring it *out* of L1, maybe we just need a quirk to stop
> advertising support for L1 in the first place.
> 
> > Just like other PCI controller drivers, here we hook the fault handler,
> > perform the fixup to help the controller enter L1 link state, and then
> > restart the instruction which triggered the fault. Since the controller
> > is in L1 link state now, the link can exit from L1 link state to L0 and
> > successfully complete the access.
> > 
> > Note that this fixup is applicable only to Aarch32 R-Car controllers,
> > the Aarch64 R-Car perform the same fixup in TFA, see TFA commit
> > 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> 
> TFA?  This doesn't seem to be an upstream Linux commit; can you give a
> more specific reference?
> 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> >  drivers/pci/controller/pcie-rcar-host.c | 58 +++++++++++++++++++++++++
> >  drivers/pci/controller/pcie-rcar.h      |  7 +++
> >  2 files changed, 65 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> > index cdc0963f154e..949de5b2d699 100644
> > --- a/drivers/pci/controller/pcie-rcar-host.c
> > +++ b/drivers/pci/controller/pcie-rcar-host.c
> > @@ -42,6 +42,16 @@ struct rcar_msi {
> >  	int irq2;
> >  };
> >  
> > +#ifdef CONFIG_ARM
> > +/*
> > + * Here we keep a static copy of the remapped PCIe controller address.
> > + * This is only used on aarch32 systems, all of which have one single
> > + * PCIe controller, to provide quick access to the PCIe controller in
> > + * the L1 link state fixup function, called from ARM fault handler.
> > + */
> > +static void __iomem *pcie_base;
> > +#endif
> > +
> >  static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
> >  {
> >  	return container_of(chip, struct rcar_msi, chip);
> > @@ -804,6 +814,11 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
> >  	}
> >  	host->msi.irq2 = i;
> >  
> > +#ifdef CONFIG_ARM
> > +	/* Cache static copy for L1 link state fixup hook on aarch32 */
> > +	pcie_base = pcie->base;
> > +#endif
> > +
> >  	return 0;
> >  
> >  err_irq2:
> > @@ -1050,4 +1065,47 @@ static struct platform_driver rcar_pcie_driver = {
> >  	},
> >  	.probe = rcar_pcie_probe,
> >  };
> > +
> > +#ifdef CONFIG_ARM
> > +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
> > +		unsigned int fsr, struct pt_regs *regs)
> > +{
> > +	u32 pmsr;
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
> > +		return 0;
> > +	}
> > +
> > +	return 1;
> > +}
> > +
> > +static int __init rcar_pcie_init(void)
> > +{
> > +	/*
> > +	 * Since probe() can be deferred we need to make sure that
> > +	 * hook_fault_code is not called after __init memory is freed
> > +	 * by kernel and since rcar_pcie_abort_handler() is a no-op,
> > +	 * we can install the handler here without risking it
> > +	 * accessing some uninitialized driver state.
> > +	 */
> > +	hook_fault_code(16 + 6, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > +			"imprecise external abort");
> > +
> > +	return platform_driver_register(&rcar_pcie_driver);
> > +}
> > +device_initcall(rcar_pcie_init);
> > +#else
> >  builtin_platform_driver(rcar_pcie_driver);
> > +#endif
> > diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
> > index d4c698b5f821..73269296ae05 100644
> > --- a/drivers/pci/controller/pcie-rcar.h
> > +++ b/drivers/pci/controller/pcie-rcar.h
> > @@ -85,6 +85,13 @@
> >  #define  LTSMDIS		BIT(31)
> >  #define  MACCTLR_INIT_VAL	(LTSMDIS | MACCTLR_NFTS_MASK)
> >  #define PMSR			0x01105c
> > +#define  L1FAEG			BIT(31)
> > +#define  PMEL1RX		BIT(23)
> > +#define  PMSTATE		GENMASK(18, 16)
> > +#define  PMSTATE_L1		GENMASK(17, 16)
> > +#define PMCTLR			0x011060
> > +#define  L1IATN			BIT(31)
> > +
> >  #define MACS2R			0x011078
> >  #define MACCGSPSETR		0x011084
> >  #define  SPCNGRSN		BIT(31)
> > -- 
> > 2.28.0
> > 
