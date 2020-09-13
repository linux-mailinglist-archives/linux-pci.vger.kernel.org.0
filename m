Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6848268087
	for <lists+linux-pci@lfdr.de>; Sun, 13 Sep 2020 19:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgIMRWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Sep 2020 13:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgIMRWL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 13 Sep 2020 13:22:11 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21802151B;
        Sun, 13 Sep 2020 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600017729;
        bh=L+G60qOld9gQ4n3uC2LMEr5C+IqrrVi7NZsHJNmEbFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mFBgSjvHKxib39aSHn8K4gs7cxrRqnmfBLkAOqamLy4ZSCzlkFr7FzXMtNirVgfdc
         S60uG37YuvJTk4rRw9U2AoY4pEn7WwcT7QRzh7PACxBG3bSB7LkFN5m6D3VqJ6g/Fb
         4o7wOyMjp1ZM67z941amR+R6/P6/KVR6H5ew16cY=
Date:   Sun, 13 Sep 2020 12:22:07 -0500
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
Subject: Re: [PATCH] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20200913172207.GA1194428@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912211853.15321-1-marek.vasut@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 12, 2020 at 11:18:53PM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> The R-Car PCIe controller is capable of handling L0s/L1 link states.
> While the controller can enter and exit L0s link state, and exit L1
> link state, without any additional action from the driver, to enter
> L1 link state, the driver must complete the link state transition by
> issuing additional commands to the controller.

So IIUC an R-Car Root Port can't enter L1 without help from the
driver?  That *sounds* like a hardware defect, since ASPM is supposed
to be "hardware-autonomous" once configured.

> The problem is, this transition is not atomic. The controller sets
> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> the PCIe card, but then the controller enters some sort of inbetween
> state. The driver must detect this condition and complete the link
> state transition, by setting L1IATN bit in PMCTLR and waiting for
> the link state transition to complete.
> 
> If a PCIe access happens inside of this window, where the controller
> is inbetween L0 and L1 link states, the access generates a fault and
> the ARM 'imprecise external abort' handler is invoked.

Let me see if I understand this.

  1) Endpoint sends PM_ENTER_L1
  2) R-Car Root Port receives PM_ENTER_L1, sets PMEL1RX
  3) R-Car driver does something to complete transition to L1

And if the Endpoint driver does an MMIO access between 2) and 3), it
causes an external abort?

I couldn't find anything in the R-Car driver today that completes the
transition to L1.

And the MMIO access will immediately bring the link back to L0, won't
it?

Is there any benefit to L1 at all for this Root Port?  If it can't
enter L1 and just stays in the in-between state until some event that
will bring it *out* of L1, maybe we just need a quirk to stop
advertising support for L1 in the first place.

> Just like other PCI controller drivers, here we hook the fault handler,
> perform the fixup to help the controller enter L1 link state, and then
> restart the instruction which triggered the fault. Since the controller
> is in L1 link state now, the link can exit from L1 link state to L0 and
> successfully complete the access.
> 
> Note that this fixup is applicable only to Aarch32 R-Car controllers,
> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit
> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")

TFA?  This doesn't seem to be an upstream Linux commit; can you give a
more specific reference?

> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 58 +++++++++++++++++++++++++
>  drivers/pci/controller/pcie-rcar.h      |  7 +++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index cdc0963f154e..949de5b2d699 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -42,6 +42,16 @@ struct rcar_msi {
>  	int irq2;
>  };
>  
> +#ifdef CONFIG_ARM
> +/*
> + * Here we keep a static copy of the remapped PCIe controller address.
> + * This is only used on aarch32 systems, all of which have one single
> + * PCIe controller, to provide quick access to the PCIe controller in
> + * the L1 link state fixup function, called from ARM fault handler.
> + */
> +static void __iomem *pcie_base;
> +#endif
> +
>  static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
>  {
>  	return container_of(chip, struct rcar_msi, chip);
> @@ -804,6 +814,11 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
>  	}
>  	host->msi.irq2 = i;
>  
> +#ifdef CONFIG_ARM
> +	/* Cache static copy for L1 link state fixup hook on aarch32 */
> +	pcie_base = pcie->base;
> +#endif
> +
>  	return 0;
>  
>  err_irq2:
> @@ -1050,4 +1065,47 @@ static struct platform_driver rcar_pcie_driver = {
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
> +}
> +
> +static int __init rcar_pcie_init(void)
> +{
> +	/*
> +	 * Since probe() can be deferred we need to make sure that
> +	 * hook_fault_code is not called after __init memory is freed
> +	 * by kernel and since rcar_pcie_abort_handler() is a no-op,
> +	 * we can install the handler here without risking it
> +	 * accessing some uninitialized driver state.
> +	 */
> +	hook_fault_code(16 + 6, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> +			"imprecise external abort");
> +
> +	return platform_driver_register(&rcar_pcie_driver);
> +}
> +device_initcall(rcar_pcie_init);
> +#else
>  builtin_platform_driver(rcar_pcie_driver);
> +#endif
> diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
> index d4c698b5f821..73269296ae05 100644
> --- a/drivers/pci/controller/pcie-rcar.h
> +++ b/drivers/pci/controller/pcie-rcar.h
> @@ -85,6 +85,13 @@
>  #define  LTSMDIS		BIT(31)
>  #define  MACCTLR_INIT_VAL	(LTSMDIS | MACCTLR_NFTS_MASK)
>  #define PMSR			0x01105c
> +#define  L1FAEG			BIT(31)
> +#define  PMEL1RX		BIT(23)
> +#define  PMSTATE		GENMASK(18, 16)
> +#define  PMSTATE_L1		GENMASK(17, 16)
> +#define PMCTLR			0x011060
> +#define  L1IATN			BIT(31)
> +
>  #define MACS2R			0x011078
>  #define MACCGSPSETR		0x011084
>  #define  SPCNGRSN		BIT(31)
> -- 
> 2.28.0
> 
