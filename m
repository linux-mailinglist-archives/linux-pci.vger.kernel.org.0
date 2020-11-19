Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA302B995F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 18:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgKSRf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 12:35:58 -0500
Received: from foss.arm.com ([217.140.110.172]:35906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgKSRf5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 12:35:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9B8F1396;
        Thu, 19 Nov 2020 09:35:56 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE6B13F718;
        Thu, 19 Nov 2020 09:35:55 -0800 (PST)
Date:   Thu, 19 Nov 2020 17:35:53 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20201119173553.GB23852@e121166-lin.cambridge.arm.com>
References: <20201016120416.7008-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016120416.7008-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 16, 2020 at 02:04:16PM +0200, marek.vasut@gmail.com wrote:

[...]

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

Don't think you can have multiple host bridges in a given platform,
if it is a possible configuration this won't work.

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

I suppose a fault on multiple cores can happen simultaneously, if it
does this may not work well either - I assume all config/io/mem would
trigger a fault.

As I mentioned in my reply to v1, is there a chance we can move
this quirk into config accessors (if the PM_ENTER_L1_DLLP is
subsequent to a write into PMCSR to programme a D state) ?

Config access is serialized but I suspect as I said above that this
triggers on config/io/mem alike.

Just asking to try to avoid a fault handler if possible.

Thanks,
Lorenzo

> +
> +	return 1;
> +}
> +
> +static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
> +	{ .compatible = "renesas,pcie-r8a7779" },
> +	{ .compatible = "renesas,pcie-r8a7790" },
> +	{ .compatible = "renesas,pcie-r8a7791" },
> +	{ .compatible = "renesas,pcie-rcar-gen2" },
> +	{},
> +};
> +
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
