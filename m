Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5C361060
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 18:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhDOQqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 12:46:36 -0400
Received: from foss.arm.com ([217.140.110.172]:50672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhDOQqg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 12:46:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB1B111B3;
        Thu, 15 Apr 2021 09:46:12 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9FCC3FA35;
        Thu, 15 Apr 2021 09:46:11 -0700 (PDT)
Date:   Thu, 15 Apr 2021 17:46:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V5] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20210415164606.GA32085@lpieralisi>
References: <20210411185030.8818-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411185030.8818-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 11, 2021 at 08:50:30PM +0200, marek.vasut@gmail.com wrote:

[...]

> +#ifdef CONFIG_ARM
> +static DEFINE_SPINLOCK(pmsr_lock);
> +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
> +		unsigned int fsr, struct pt_regs *regs)
> +{
> +	unsigned long flags;
> +	int ret = 1;

I think we should return 1 only if the condition that triggered
the fault can't be fixed. If it is fixed on another core we
should not return 1 so ret should be set according to the PMSR
register state IIUC.

Lorenzo

> +	u32 pmsr;
> +
> +	spin_lock_irqsave(&pmsr_lock, flags);
> +
> +	if (!pcie_base || !__clk_is_enabled(pcie_bus_clk))
> +		goto unlock_exit;
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
> +		ret = 0;
> +	}
> +
> +unlock_exit:
> +	spin_unlock_irqrestore(&pmsr_lock, flags);
> +	return ret;
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
> 2.30.2
> 
