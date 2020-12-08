Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F7F2D2FF0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 17:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgLHQks (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 11:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbgLHQkr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 11:40:47 -0500
Date:   Tue, 8 Dec 2020 10:40:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607445606;
        bh=y5R/PHkMkePjYfWp1LEP1GQ/tGw7gPi+NVuOiUuaQCY=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=NnM1LXoI4A5PSYPpVJtBc4Rd1WWMiYkLvNhTlT1L6nZLmOy9+UZkDZDhyxO+Dii5K
         +y6l/ZVkujx2F3RyHa+NteSNNkrKxC6An32HExYgz/0C3ZMStA4py+5higRN5b68OE
         W6U3hYTgTJ3RFiCEZkqju4x2uZTEIwMlSmpKmHTuEYmfJp5gm5dwyPUyp1twGlUIzS
         LQp4IDgmR/4vUth6owmhp3vajHNpc8IzKsaySybI/UaMlE3vUe3mL4V3wa/vkAXHH0
         8symJCsdQsSs8n+7Zioi69Y3LWjGN3NWW0oNqyc0n/v+lMl/XRD5vi+fFSXO6SbE3t
         nAV0HXtJ8waBg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20201208164004.GA2377933@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016120416.7008-1-marek.vasut@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 16, 2020 at 02:04:16PM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> The R-Car PCIe controller is capable of handling L0s/L1 link states.

Minor wording nit: L0s seems irrelevant to this patch.

All PCIe functions are required to support the Power Management
Capability (PCIe r5.0, sec 7.5.2), and that in turn requires D0,
D3hot, and D3cold support, and D3hot requires L1 (sec 5.2).

So saying this device "is capable of handling L1" really doesn't tell
us anything, and it glosses over the fact that it doesn't do it
*correctly* and requires help from the driver to work around this
hardware defect.

Does this problem occur in both these cases?

  1) When ASPM enters L1, and

  2) When software writes PCI_PM_CTRL to put the device in D3hot?

IIUC both cases require the link to go to L1.  I guess the same
software workaround applies to both cases?

> While the controller can enter and exit L0s link state, and exit L1
> link state, without any additional action from the driver, to enter
> L1 link state, the driver must complete the link state transition by
> issuing additional commands to the controller.
> 
> The problem is, this transition is not atomic. The controller sets
> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> the PCIe card, but then the controller enters some sort of inbetween
> state. The driver must detect this condition and complete the link
> state transition, by setting L1IATN bit in PMCTLR and waiting for
> the link state transition to complete.
> 
> If a PCIe access happens inside this window, where the controller
> is between L0 and L1 link states, the access generates a fault and
> the ARM 'imprecise external abort' handler is invoked.
> 
> Just like other PCI controller drivers, here we hook the fault handler,
> perform the fixup to help the controller enter L1 link state, and then
> restart the instruction which triggered the fault. Since the controller
> is in L1 link state now, the link can exit from L1 link state to L0 and
> successfully complete the access.
> 
> Note that this fixup is applicable only to Aarch32 R-Car controllers,
> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Update commit message, add link to TFA repository commit
>     - Handle the LPAE case as in ARM fault.c and fsr-{2,3}level.c
>     - Cache clock and check whether they are enabled before register
>       access
> V3: - Fix commit message according to spellchecker
>     - Use of_find_matching_node() to apply hook only on Gen1 and Gen2 RCar
>       (in case the kernel is multiplatform)
> V4: - Mark rcar_pcie_abort_handler_of_match with __initconst
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 76 +++++++++++++++++++++++++
>  drivers/pci/controller/pcie-rcar.h      |  7 +++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index cdc0963f154e..1194d5f3341b 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -42,6 +43,21 @@ struct rcar_msi {
>  	int irq2;
>  };
>  
> +#ifdef CONFIG_ARM
> +/*
> + * Here we keep a static copy of the remapped PCIe controller address.
> + * This is only used on aarch32 systems, all of which have one single
> + * PCIe controller, to provide quick access to the PCIe controller in
> + * the L1 link state fixup function, called from the ARM fault handler.
> + */
> +static void __iomem *pcie_base;
> +/*
> + * Static copy of bus clock pointer, so we can check whether the clock
> + * is enabled or not.
> + */
> +static struct clk *pcie_bus_clk;
> +#endif
> +
>  static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
>  {
>  	return container_of(chip, struct rcar_msi, chip);
> @@ -804,6 +820,12 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
>  	}
>  	host->msi.irq2 = i;
>  
> +#ifdef CONFIG_ARM
> +	/* Cache static copy for L1 link state fixup hook on aarch32 */
> +	pcie_base = pcie->base;
> +	pcie_bus_clk = host->bus_clk;
> +#endif
> +
>  	return 0;
>  
>  err_irq2:
> @@ -1050,4 +1072,58 @@ static struct platform_driver rcar_pcie_driver = {
>  	},
>  	.probe = rcar_pcie_probe,
>  };
> +
> +#ifdef CONFIG_ARM
> +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
> +		unsigned int fsr, struct pt_regs *regs)
> +{
> +	u32 pmsr;
> +
> +	if (!pcie_base || !__clk_is_enabled(pcie_bus_clk))
> +		return 1;
> +
> +	pmsr = readl(pcie_base + PMSR);
> +
> +	/*
> +	 * Test if the PCIe controller received PM_ENTER_L1 DLLP and
> +	 * the PCIe controller is not in L1 link state. If true, apply
> +	 * fix, which will put the controller into L1 link state, from
> +	 * which it can return to L0s/L0 on its own.
> +	 */
> +	if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
> +		writel(L1IATN, pcie_base + PMCTLR);
> +		while (!(readl(pcie_base + PMSR) & L1FAEG))
> +			;
> +		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
> +		return 0;
> +	}
> +
> +	return 1;

I have no insight into how these abort handlers work.  Looks awfully
kludgy to me, but if it's the only way and the ARM folks are on board
with it, I can't object.

I guess the other alternative would be to have a quirk to stop
advertising ASPM L1 support and D1/D2/D3hot support.  Obviously that
may give up some power savings.

If people aren't comfortable with the reliability or maintainability
of this approach in the upstream kernel, there's always the option of
the users who need it carrying this as an out-of-tree patch.

> +}
> +
> +static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
> +	{ .compatible = "renesas,pcie-r8a7779" },
> +	{ .compatible = "renesas,pcie-r8a7790" },
> +	{ .compatible = "renesas,pcie-r8a7791" },
> +	{ .compatible = "renesas,pcie-rcar-gen2" },
> +	{},
> +};

Why do we need another copy of these, as opposed to doing something
with of_device_get_match_data(), e.g., like brcm_pcie_probe() does?

> +static int __init rcar_pcie_init(void)
> +{
> +	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> +#ifdef CONFIG_ARM_LPAE
> +		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> +				"asynchronous external abort");
> +#else
> +		hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> +				"imprecise external abort");
> +#endif
> +	}
> +
> +	return platform_driver_register(&rcar_pcie_driver);
> +}
> +device_initcall(rcar_pcie_init);
> +#else
>  builtin_platform_driver(rcar_pcie_driver);
> +#endif

Is the device_initcall() vs builtin_platform_driver() something
related to the hook_fault_code()?  What would break if this were
always builtin_platform_driver()?

> diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
> index d4c698b5f821..9bb125db85c6 100644
> --- a/drivers/pci/controller/pcie-rcar.h
> +++ b/drivers/pci/controller/pcie-rcar.h
> @@ -85,6 +85,13 @@
>  #define  LTSMDIS		BIT(31)
>  #define  MACCTLR_INIT_VAL	(LTSMDIS | MACCTLR_NFTS_MASK)
>  #define PMSR			0x01105c
> +#define  L1FAEG			BIT(31)
> +#define  PMEL1RX		BIT(23)
> +#define  PMSTATE		GENMASK(18, 16)
> +#define  PMSTATE_L1		(3 << 16)
> +#define PMCTLR			0x011060
> +#define  L1IATN			BIT(31)
> +
>  #define MACS2R			0x011078
>  #define MACCGSPSETR		0x011084
>  #define  SPCNGRSN		BIT(31)
> -- 
> 2.28.0
> 
