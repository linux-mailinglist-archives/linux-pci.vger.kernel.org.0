Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5113D7A9D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhG0QLu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 12:11:50 -0400
Received: from foss.arm.com ([217.140.110.172]:40818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhG0QLu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 12:11:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A0C931B;
        Tue, 27 Jul 2021 09:11:49 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01B953F70D;
        Tue, 27 Jul 2021 09:11:47 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:11:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, marek.vasut@gmail.com,
        linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20210727161142.GA15814@lpieralisi>
References: <20210514200549.431275-1-marek.vasut@gmail.com>
 <20210717173334.GA2232818@bjorn-Precision-5520>
 <20210719085953.GA17481@lpieralisi>
 <20210719172340.vvtnddbli2vgxndi@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210719172340.vvtnddbli2vgxndi@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 19, 2021 at 07:23:40PM +0200, Pali Rohár wrote:

[...]

> > > > +#ifdef CONFIG_ARM
> > > > +static DEFINE_SPINLOCK(pmsr_lock);
> > > > +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
> > > > +		unsigned int fsr, struct pt_regs *regs)
> > > > +{
> > > > +	unsigned long flags;
> > > > +	int ret = 0;
> > > > +	u32 pmsr;
> > > > +
> > > > +	spin_lock_irqsave(&pmsr_lock, flags);
> > > > +
> > > > +	if (!pcie_base || !__clk_is_enabled(pcie_bus_clk)) {
> > > > +		ret = 1;
> > > > +		goto unlock_exit;
> > > > +	}
> > > > +
> > > > +	pmsr = readl(pcie_base + PMSR);
> > > > +
> > > > +	/*
> > > > +	 * Test if the PCIe controller received PM_ENTER_L1 DLLP and
> > > > +	 * the PCIe controller is not in L1 link state. If true, apply
> > > > +	 * fix, which will put the controller into L1 link state, from
> > > > +	 * which it can return to L0s/L0 on its own.
> > > > +	 */
> > > > +	if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
> > > > +		writel(L1IATN, pcie_base + PMCTLR);
> > > > +		while (!(readl(pcie_base + PMSR) & L1FAEG))
> > > > +			;
> 
> Infinite loop in abort handler is not a good idea. If this software
> workaround is not able to fix HW in broken state then it is better to
> let kernel finish abort handler and reboot machine (or whatever is
> default action for particular abort handler).

Probably worth adding a timeout, I can do it before merging it.

Lorenzo

> > > > +		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
> > > > +	}
> > > > +
> > > > +unlock_exit:
> > > > +	spin_unlock_irqrestore(&pmsr_lock, flags);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
> > > > +	{ .compatible = "renesas,pcie-r8a7779" },
> > > > +	{ .compatible = "renesas,pcie-r8a7790" },
> > > > +	{ .compatible = "renesas,pcie-r8a7791" },
> > > > +	{ .compatible = "renesas,pcie-rcar-gen2" },
> > > > +	{},
> > > > +};
> > > > +
> > > > +static int __init rcar_pcie_init(void)
> > > > +{
> > > > +	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> > > > +#ifdef CONFIG_ARM_LPAE
> > > > +		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > > > +				"asynchronous external abort");
> > > > +#else
> > > > +		hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > > > +				"imprecise external abort");
> > > > +#endif
> > > > +	}
> > > > +
> > > > +	return platform_driver_register(&rcar_pcie_driver);
> > > > +}
> > > > +device_initcall(rcar_pcie_init);
> > > > +#else
> > > >  builtin_platform_driver(rcar_pcie_driver);
> > > > +#endif
> > > > diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
> > > > index d4c698b5f821..9bb125db85c6 100644
> > > > --- a/drivers/pci/controller/pcie-rcar.h
> > > > +++ b/drivers/pci/controller/pcie-rcar.h
> > > > @@ -85,6 +85,13 @@
> > > >  #define  LTSMDIS		BIT(31)
> > > >  #define  MACCTLR_INIT_VAL	(LTSMDIS | MACCTLR_NFTS_MASK)
> > > >  #define PMSR			0x01105c
> > > > +#define  L1FAEG			BIT(31)
> > > > +#define  PMEL1RX		BIT(23)
> > > > +#define  PMSTATE		GENMASK(18, 16)
> > > > +#define  PMSTATE_L1		(3 << 16)
> > > > +#define PMCTLR			0x011060
> > > > +#define  L1IATN			BIT(31)
> > > > +
> > > >  #define MACS2R			0x011078
> > > >  #define MACCGSPSETR		0x011084
> > > >  #define  SPCNGRSN		BIT(31)
> > > > -- 
> > > > 2.30.2
> > > > 
