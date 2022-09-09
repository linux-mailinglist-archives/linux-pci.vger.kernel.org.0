Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A385B3B46
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 16:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiIIO5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 10:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIIO5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 10:57:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F55E13463D
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 07:57:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31DC7B82548
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 14:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34EBC433D6;
        Fri,  9 Sep 2022 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662735438;
        bh=GFcCwju6Fd+i041A70JAc5lOxGI2CJy++wv+eJOFxgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXYcRIM16Q/X/ZDDTjILE++WfRwxObnQ/tirpzmEhFRF4ZtFZ3x2i/XZyiJTrc1/T
         Q3edC0Buk5OJPLdy9K/2KraSQ6UWaafzdaBMOPLCcjTi5Zx5if7kYswE5N6+gQTm0t
         NuJMxGOIWyE+bBjtsfkz6wR2CkZQVwKFVfEwJux2T/tQdQzljI5coqtKMFxgjK1Jw9
         YbL7yUC8Sq+Bjj8bfoP371K209wKbdof8Ir9YXNIaV6IGrQVgogcU8t5jEFHAKB+Gl
         PyQG1u3keXvavFOUa6Dt1DrigFoXMhOQf2Ap2/RSAYJSP+E+6feDKhcDxg+hvvKptR
         48ELmCWzB43ng==
Date:   Fri, 9 Sep 2022 16:57:11 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 03/11] PCI: aardvark: Add support for DLLSC and hotplug
 interrupt
Message-ID: <YxtUR0+dBZut8QZH@lpieralisi>
References: <20220818135140.5996-1-kabel@kernel.org>
 <20220818135140.5996-4-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818135140.5996-4-kabel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Marc, Thomas - I can't merge this code without them reviewing it,
I am not sure at all you can mix the timer/IRQ code the way you do]

On Thu, Aug 18, 2022 at 03:51:32PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Add support for Data Link Layer State Change in the emulated slot
> registers and hotplug interrupt via the emulated root bridge.
> 
> This is mainly useful for when an error causes link down event. With
> this change, drivers can try recovery.
> 
> Link down state change can be implemented because Aardvark supports Link
> Down event interrupt. Use it for signaling that Data Link Layer Link is
> not active anymore via Hot-Plug Interrupt on emulated root bridge.
> 
> Link up interrupt is not available on Aardvark, but we check for whether
> link is up in the advk_pcie_link_up() function. By triggering Hot-Plug
> Interrupt from this function we achieve Link up event, so long as the
> function is called (which it is after probe and when rescanning).
> Although it is not ideal, it is better than nothing.

So before even coming to the code review: this patch does two things.

1) It adds support for handling the Link down state
2) It adds some code to emulate a Link-up event

Now, for (2). IIUC you are adding code to make sure that an HP
event is triggered if advk_pcie_link_up() is called and it
detects a Link-down->Link-up transition, that has to be notified
through an HP event.

If that's correct, you have to explain to me please what this is
actually achieving and a specific scenario where we want this to be
implemented, in fine details; then we add it to the commit log.

That aside, the interaction of the timer and the IRQ domain code
must be reviewed by Marc and Thomas to make sure this is not
a gross violation of the respective subsystems usage.

Lorenzo

> Since advk_pcie_link_up() is not called from interrupt handler, we
> cannot call generic_handle_domain_irq() from it directly. Instead create
> a TIMER_IRQSAFE timer and trigger it from advk_pcie_link_up().
> 
> (We haven't been able to find any documentation for a Link Up interrupt
>  on Aardvark, but it is possible there is one, in some undocumented
>  register. If we manage to find this information, this can be
>  rewritten.)
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
> Change since batch 5:
> - changed commit message (add paragraph about why the change is needed)
> - select hotplug and pcieportbus in Kconfig
> ---
>  drivers/pci/controller/Kconfig        |   3 +
>  drivers/pci/controller/pci-aardvark.c | 101 ++++++++++++++++++++++++--
>  2 files changed, 99 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index d1c5fcf00a8a..5e8a84f5c654 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -21,6 +21,9 @@ config PCI_AARDVARK
>  	depends on OF
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCI_BRIDGE_EMUL
> +	select PCIEPORTBUS
> +	select HOTPLUG_PCI
> +	select HOTPLUG_PCI_PCIE
>  	help
>  	 Add support for Aardvark 64bit PCIe Host Controller. This
>  	 controller is part of the South Bridge of the Marvel Armada
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 966c8b48bd96..31da28ebc5d1 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -25,6 +25,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
> +#include <linux/timer.h>
>  
>  #include "../pci.h"
>  #include "../pci-bridge-emul.h"
> @@ -100,6 +101,7 @@
>  #define PCIE_MSG_PM_PME_MASK			BIT(7)
>  #define PCIE_ISR0_MASK_REG			(CONTROL_BASE_ADDR + 0x44)
>  #define     PCIE_ISR0_MSI_INT_PENDING		BIT(24)
> +#define     PCIE_ISR0_LINK_DOWN			BIT(1)
>  #define     PCIE_ISR0_CORR_ERR			BIT(11)
>  #define     PCIE_ISR0_NFAT_ERR			BIT(12)
>  #define     PCIE_ISR0_FAT_ERR			BIT(13)
> @@ -284,6 +286,8 @@ struct advk_pcie {
>  	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
>  	struct mutex msi_used_lock;
>  	int link_gen;
> +	bool link_was_up;
> +	struct timer_list link_irq_timer;
>  	struct pci_bridge_emul bridge;
>  	struct gpio_desc *reset_gpio;
>  	struct phy *phy;
> @@ -313,7 +317,24 @@ static inline bool advk_pcie_link_up(struct advk_pcie *pcie)
>  {
>  	/* check if LTSSM is in normal operation - some L* state */
>  	u8 ltssm_state = advk_pcie_ltssm_state(pcie);
> -	return ltssm_state >= LTSSM_L0 && ltssm_state < LTSSM_DISABLED;
> +	bool link_is_up;
> +	u16 slotsta;
> +
> +	link_is_up = ltssm_state >= LTSSM_L0 && ltssm_state < LTSSM_DISABLED;
> +
> +	if (link_is_up && !pcie->link_was_up) {
> +		dev_info(&pcie->pdev->dev, "link up\n");
> +
> +		pcie->link_was_up = true;
> +
> +		slotsta = le16_to_cpu(pcie->bridge.pcie_conf.slotsta);
> +		slotsta |= PCI_EXP_SLTSTA_DLLSC;
> +		pcie->bridge.pcie_conf.slotsta = cpu_to_le16(slotsta);
> +
> +		mod_timer(&pcie->link_irq_timer, jiffies + 1);
> +	}
> +
> +	return link_is_up;
>  }
>  
>  static inline bool advk_pcie_link_active(struct advk_pcie *pcie)
> @@ -442,8 +463,6 @@ static void advk_pcie_train_link(struct advk_pcie *pcie)
>  	ret = advk_pcie_wait_for_link(pcie);
>  	if (ret < 0)
>  		dev_err(dev, "link never came up\n");
> -	else
> -		dev_info(dev, "link up\n");
>  }
>  
>  /*
> @@ -592,6 +611,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
>  	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
>  
> +	/* Unmask Link Down interrupt */
> +	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
> +	reg &= ~PCIE_ISR0_LINK_DOWN;
> +	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
> +
>  	/* Unmask PME interrupt for processing of PME requester */
>  	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
>  	reg &= ~PCIE_MSG_PM_PME_MASK;
> @@ -918,6 +942,14 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
>  			advk_pcie_wait_for_retrain(pcie);
>  		break;
>  
> +	case PCI_EXP_SLTCTL: {
> +		u16 slotctl = le16_to_cpu(bridge->pcie_conf.slotctl);
> +		/* Only emulation of HPIE and DLLSCE bits is provided */
> +		slotctl &= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
> +		bridge->pcie_conf.slotctl = cpu_to_le16(slotctl);
> +		break;
> +	}
> +
>  	case PCI_EXP_RTCTL: {
>  		u16 rootctl = le16_to_cpu(bridge->pcie_conf.rootctl);
>  		/* Only emulation of PMEIE and CRSSVE bits is provided */
> @@ -1035,6 +1067,7 @@ static const struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
>  static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  {
>  	struct pci_bridge_emul *bridge = &pcie->bridge;
> +	u32 slotcap;
>  
>  	bridge->conf.vendor =
>  		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
> @@ -1061,6 +1094,13 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  	bridge->pcie_conf.cap = cpu_to_le16(2 | PCI_EXP_FLAGS_SLOT);
>  
>  	/*
> +	 * Mark bridge as Hot Plug Capable since this is the way how to enable
> +	 * delivering of Data Link Layer State Change interrupts.
> +	 *
> +	 * Set No Command Completed Support because bridge does not support
> +	 * Command Completed Interrupt. Every command is executed immediately
> +	 * without any delay.
> +	 *
>  	 * Set Presence Detect State bit permanently since there is no support
>  	 * for unplugging the card nor detecting whether it is plugged. (If a
>  	 * platform exists in the future that supports it, via a GPIO for
> @@ -1070,8 +1110,9 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  	 * value is reserved for ports within the same silicon as Root Port
>  	 * which is not our case.
>  	 */
> -	bridge->pcie_conf.slotcap = cpu_to_le32(FIELD_PREP(PCI_EXP_SLTCAP_PSN,
> -							   1));
> +	slotcap = PCI_EXP_SLTCAP_NCCS | PCI_EXP_SLTCAP_HPC |
> +		  FIELD_PREP(PCI_EXP_SLTCAP_PSN, 1);
> +	bridge->pcie_conf.slotcap = cpu_to_le32(slotcap);
>  	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
>  
>  	/* Indicates supports for Completion Retry Status */
> @@ -1568,6 +1609,24 @@ static void advk_pcie_remove_rp_irq_domain(struct advk_pcie *pcie)
>  	irq_domain_remove(pcie->rp_irq_domain);
>  }
>  
> +static void advk_pcie_link_irq_handler(struct timer_list *timer)
> +{
> +	struct advk_pcie *pcie = from_timer(pcie, timer, link_irq_timer);
> +	u16 slotctl;
> +
> +	slotctl = le16_to_cpu(pcie->bridge.pcie_conf.slotctl);
> +	if (!(slotctl & PCI_EXP_SLTCTL_DLLSCE) ||
> +	    !(slotctl & PCI_EXP_SLTCTL_HPIE))
> +		return;
> +
> +	/*
> +	 * Aardvark HW returns zero for PCI_EXP_FLAGS_IRQ, so use PCIe
> +	 * interrupt 0
> +	 */
> +	if (generic_handle_domain_irq(pcie->rp_irq_domain, 0) == -EINVAL)
> +		dev_err_ratelimited(&pcie->pdev->dev, "unhandled HP IRQ\n");
> +}
> +
>  static void advk_pcie_handle_pme(struct advk_pcie *pcie)
>  {
>  	u32 requester = advk_readl(pcie, PCIE_MSG_LOG_REG) >> 16;
> @@ -1619,6 +1678,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
>  {
>  	u32 isr0_val, isr0_mask, isr0_status;
>  	u32 isr1_val, isr1_mask, isr1_status;
> +	u16 slotsta;
>  	int i;
>  
>  	isr0_val = advk_readl(pcie, PCIE_ISR0_REG);
> @@ -1645,6 +1705,26 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
>  			dev_err_ratelimited(&pcie->pdev->dev, "unhandled ERR IRQ\n");
>  	}
>  
> +	/* Process Link Down interrupt as HP IRQ */
> +	if (isr0_status & PCIE_ISR0_LINK_DOWN) {
> +		advk_writel(pcie, PCIE_ISR0_LINK_DOWN, PCIE_ISR0_REG);
> +
> +		dev_info(&pcie->pdev->dev, "link down\n");
> +
> +		pcie->link_was_up = false;
> +
> +		slotsta = le16_to_cpu(pcie->bridge.pcie_conf.slotsta);
> +		slotsta |= PCI_EXP_SLTSTA_DLLSC;
> +		pcie->bridge.pcie_conf.slotsta = cpu_to_le16(slotsta);
> +
> +		/*
> +		 * Deactivate timer and call advk_pcie_link_irq_handler()
> +		 * function directly as we are in the interrupt context.
> +		 */
> +		del_timer_sync(&pcie->link_irq_timer);
> +		advk_pcie_link_irq_handler(&pcie->link_irq_timer);
> +	}
> +
>  	/* Process MSI interrupts */
>  	if (isr0_status & PCIE_ISR0_MSI_INT_PENDING)
>  		advk_pcie_handle_msi(pcie);
> @@ -1881,6 +1961,14 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * generic_handle_domain_irq() expects local IRQs to be disabled since
> +	 * normally it is called from interrupt context, so use TIMER_IRQSAFE
> +	 * flag for this link_irq_timer.
> +	 */
> +	timer_setup(&pcie->link_irq_timer, advk_pcie_link_irq_handler,
> +		    TIMER_IRQSAFE);
> +
>  	advk_pcie_setup_hw(pcie);
>  
>  	ret = advk_sw_pci_bridge_init(pcie);
> @@ -1969,6 +2057,9 @@ static int advk_pcie_remove(struct platform_device *pdev)
>  	advk_pcie_remove_msi_irq_domain(pcie);
>  	advk_pcie_remove_irq_domain(pcie);
>  
> +	/* Deactivate link event timer */
> +	del_timer_sync(&pcie->link_irq_timer);
> +
>  	/* Free config space for emulated root bridge */
>  	pci_bridge_emul_cleanup(&pcie->bridge);
>  
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
