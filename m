Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C747B5A6380
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 14:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiH3MhG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 08:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiH3Mgz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 08:36:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A50EEC4D;
        Tue, 30 Aug 2022 05:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B17EB81AAC;
        Tue, 30 Aug 2022 12:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86322C433C1;
        Tue, 30 Aug 2022 12:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661863002;
        bh=7panBRG4MSKwt47eG+3s8rY7XvJkg/NH8Zgv55EBlz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6AR805INCGVYh1EYUKXjDpbvKpb+LLDckp3jVT+rc8QgBkL5cShi0f9dnU4hcJnH
         kBY7NMp+UFtcqhaAtHeS9T5C4vb/1uZGRzsJCdFgSCEDISCx1GxslQDkrj3nIoiCLp
         malYwzpH8TEiH2mM5ebxHyd1BAn6lVfx21p5v6MBM329Z0FsCFPO/4A2J3dWgMtWxm
         gyHNiDTvBgDPIkEpYOXtKHNBBdPNKqAcaOgF0DrA4ZoOBYz+m2Wj1GZfXR1pzbMmn4
         l0zvJQ4dQTr6w9bbAjy/w1f23DDfI9ssoGvyxmQD6+kgJ9rHPs11OUWebon6WSQI19
         LPNN/l62EUvuA==
Received: by pali.im (Postfix)
        id 6B941834; Tue, 30 Aug 2022 14:36:39 +0200 (CEST)
Date:   Tue, 30 Aug 2022 14:36:39 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] PCI: mvebu: Implement support for interrupts on
 emulated bridge
Message-ID: <20220830123639.4zpvvvlrsaqs2rls@pali>
References: <20220817230036.817-1-pali@kernel.org>
 <20220817230036.817-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817230036.817-3-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 18 August 2022 01:00:34 Pali Rohár wrote:
> This adds support for PME and ERR interrupts reported by emulated bridge
> (for PME and AER kernel drivers) via new Root Port irq chip as these
> interrupts from PCIe Root Ports are handled by mvebu hardware completely
> separately from INTx and MSI interrupts send by real PCIe devices.
> 
> With this change, kernel PME and AER drivers start working as they can
> acquire required interrupt lines (provided by mvebu rp virtual irq chip).
> 
> Note that for this support, device tree files has to be properly adjusted
> to provide "interrupts" or "interrupts-extended" property with error
> interrupt source and "interrupt-names" property with "error" string.
> 
> If device tree files do not provide these properties then driver would work
> as before and would not provide interrupts on emulated bridge, like before.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---

Just to note that because these error interrupts are shared on some
mvebu platforms, this patch depends on another patch which convert
driver to devm_request_irq() and which I sent more months before:
https://lore.kernel.org/linux-pci/20220524122817.7199-1-pali@kernel.org/

>  drivers/pci/controller/pci-mvebu.c | 256 ++++++++++++++++++++++++++---
>  1 file changed, 237 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 54ce5d43b695..e69bdaa8de43 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -56,8 +56,16 @@
>  #define PCIE_CONF_DATA_OFF	0x18fc
>  #define PCIE_INT_CAUSE_OFF	0x1900
>  #define PCIE_INT_UNMASK_OFF	0x1910
> +#define  PCIE_INT_DET_COR		BIT(8)
> +#define  PCIE_INT_DET_NONFATAL		BIT(9)
> +#define  PCIE_INT_DET_FATAL		BIT(10)
> +#define  PCIE_INT_ERR_FATAL		BIT(16)
> +#define  PCIE_INT_ERR_NONFATAL		BIT(17)
> +#define  PCIE_INT_ERR_COR		BIT(18)
>  #define  PCIE_INT_INTX(i)		BIT(24+i)
>  #define  PCIE_INT_PM_PME		BIT(28)
> +#define  PCIE_INT_DET_MASK		(PCIE_INT_DET_COR | PCIE_INT_DET_NONFATAL | PCIE_INT_DET_FATAL)
> +#define  PCIE_INT_ERR_MASK		(PCIE_INT_ERR_FATAL | PCIE_INT_ERR_NONFATAL | PCIE_INT_ERR_COR)
>  #define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
>  #define PCIE_CTRL_OFF		0x1a00
>  #define  PCIE_CTRL_X1_MODE		0x0001
> @@ -120,9 +128,12 @@ struct mvebu_pcie_port {
>  	struct resource regs;
>  	u8 slot_power_limit_value;
>  	u8 slot_power_limit_scale;
> +	struct irq_domain *rp_irq_domain;
>  	struct irq_domain *intx_irq_domain;
>  	raw_spinlock_t irq_lock;
> +	int error_irq;
>  	int intx_irq;
> +	bool pme_pending;
>  };
>  
>  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
> @@ -321,9 +332,19 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
>  	/* Clear all interrupt causes. */
>  	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
>  
> -	/* Check if "intx" interrupt was specified in DT. */
> -	if (port->intx_irq > 0)
> -		return;
> +	/*
> +	 * Unmask all error interrupts which are internally generated.
> +	 * They cannot be disabled by SERR# Enable bit in PCI Command register,
> +	 * see Figure 6-3: Pseudo Logic Diagram for Error Message Controls in
> +	 * PCIe base specification.
> +	 * Internally generated mvebu interrupts are reported via mvebu summary
> +	 * interrupt which requires "error" interrupt to be specified in DT.
> +	 */
> +	if (port->error_irq > 0) {
> +		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> +		unmask |= PCIE_INT_DET_MASK;
> +		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> +	}
>  
>  	/*
>  	 * Fallback code when "intx" interrupt was not specified in DT:
> @@ -335,10 +356,12 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
>  	 * performance penalty as every PCIe interrupt handler needs to be
>  	 * called when some interrupt is triggered.
>  	 */
> -	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> -	unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> -		  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
> -	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> +	if (port->intx_irq <= 0) {
> +		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> +		unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> +			  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
> +		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> +	}
>  }
>  
>  static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
> @@ -603,11 +626,16 @@ mvebu_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
>  	case PCI_INTERRUPT_LINE: {
>  		/*
>  		 * From the whole 32bit register we support reading from HW only
> -		 * one bit: PCI_BRIDGE_CTL_BUS_RESET.
> +		 * two bits: PCI_BRIDGE_CTL_BUS_RESET and PCI_BRIDGE_CTL_SERR.
>  		 * Other bits are retrieved only from emulated config buffer.
>  		 */
>  		__le32 *cfgspace = (__le32 *)&bridge->conf;
>  		u32 val = le32_to_cpu(cfgspace[PCI_INTERRUPT_LINE / 4]);
> +		if ((mvebu_readl(port, PCIE_INT_UNMASK_OFF) &
> +		      PCIE_INT_ERR_MASK) == PCIE_INT_ERR_MASK)
> +			val |= PCI_BRIDGE_CTL_SERR << 16;
> +		else
> +			val &= ~(PCI_BRIDGE_CTL_SERR << 16);
>  		if (mvebu_readl(port, PCIE_CTRL_OFF) & PCIE_CTRL_MASTER_HOT_RESET)
>  			val |= PCI_BRIDGE_CTL_BUS_RESET << 16;
>  		else
> @@ -675,6 +703,11 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
>  		break;
>  	}
>  
> +	case PCI_EXP_RTCTL:
> +		*value = (mvebu_readl(port, PCIE_INT_UNMASK_OFF) &
> +			  PCIE_INT_PM_PME) ? PCI_EXP_RTCTL_PMEIE : 0;
> +		break;
> +
>  	case PCI_EXP_RTSTA:
>  		*value = mvebu_readl(port, PCIE_RC_RTSTA);
>  		break;
> @@ -780,6 +813,14 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
>  		break;
>  
>  	case PCI_INTERRUPT_LINE:
> +		if ((mask & (PCI_BRIDGE_CTL_SERR << 16)) && port->error_irq > 0) {
> +			u32 unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> +			if (new & (PCI_BRIDGE_CTL_SERR << 16))
> +				unmask |= PCIE_INT_ERR_MASK;
> +			else
> +				unmask &= ~PCIE_INT_ERR_MASK;
> +			mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> +		}
>  		if (mask & (PCI_BRIDGE_CTL_BUS_RESET << 16)) {
>  			u32 ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
>  			if (new & (PCI_BRIDGE_CTL_BUS_RESET << 16))
> @@ -838,10 +879,25 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
>  		 * PME Status bit in Root Status Register (PCIE_RC_RTSTA)
>  		 * is read-only and can be cleared only by writing 0b to the
>  		 * Interrupt Cause RW0C register (PCIE_INT_CAUSE_OFF). So
> -		 * clear PME via Interrupt Cause.
> +		 * clear PME via Interrupt Cause and also set port->pme_pending
> +		 * variable to false value to start processing PME interrupts
> +		 * in interrupt handler again.
>  		 */
> -		if (new & PCI_EXP_RTSTA_PME)
> +		if (new & PCI_EXP_RTSTA_PME) {
>  			mvebu_writel(port, ~PCIE_INT_PM_PME, PCIE_INT_CAUSE_OFF);
> +			port->pme_pending = false;
> +		}
> +		break;
> +
> +	case PCI_EXP_RTCTL:
> +		if ((mask & PCI_EXP_RTCTL_PMEIE) && port->error_irq > 0) {
> +			u32 unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> +			if (new & PCI_EXP_RTCTL_PMEIE)
> +				unmask |= PCIE_INT_PM_PME;
> +			else
> +				unmask &= ~PCIE_INT_PM_PME;
> +			mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
> +		}
>  		break;
>  
>  	case PCI_EXP_DEVCTL2:
> @@ -924,6 +980,14 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
>  		bridge_flags |= PCI_BRIDGE_EMUL_NO_IO_FORWARD;
>  	}
>  
> +	/*
> +	 * Interrupts on emulated bridge are supported only when "error"
> +	 * interrupt was specified in DT. Without it emulated bridge cannot
> +	 * emulate interrupts.
> +	 */
> +	if (port->error_irq > 0)
> +		bridge->conf.intpin = PCI_INTERRUPT_INTA;
> +
>  	/*
>  	 * Older mvebu hardware provides PCIe Capability structure only in
>  	 * version 1. New hardware provides it in version 2.
> @@ -1072,6 +1136,26 @@ static const struct irq_domain_ops mvebu_pcie_intx_irq_domain_ops = {
>  	.xlate = irq_domain_xlate_onecell,
>  };
>  
> +static struct irq_chip rp_irq_chip = {
> +	.name = "mvebu-rp",
> +};
> +
> +static int mvebu_pcie_rp_irq_map(struct irq_domain *h,
> +				   unsigned int virq, irq_hw_number_t hwirq)
> +{
> +	struct mvebu_pcie_port *port = h->host_data;
> +
> +	irq_set_chip_and_handler(virq, &rp_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(virq, port);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops mvebu_pcie_rp_irq_domain_ops = {
> +	.map = mvebu_pcie_rp_irq_map,
> +	.xlate = irq_domain_xlate_onecell,
> +};
> +
>  static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
>  {
>  	struct device *dev = &port->pcie->pdev->dev;
> @@ -1094,10 +1178,72 @@ static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
>  		return -ENOMEM;
>  	}
>  
> +	/*
> +	 * When "error" interrupt was not specified in DT then there is no
> +	 * support for interrupts on emulated root bridge. So skip following
> +	 * initialization.
> +	 */
> +	if (port->error_irq <= 0)
> +		return 0;
> +
> +	port->rp_irq_domain = irq_domain_add_linear(NULL, 1,
> +						      &mvebu_pcie_rp_irq_domain_ops,
> +						      port);
> +	if (!port->rp_irq_domain) {
> +		irq_domain_remove(port->intx_irq_domain);
> +		dev_err(dev, "Failed to add Root Port IRQ domain for %s\n", port->name);
> +		return -ENOMEM;
> +	}
> +
>  	return 0;
>  }
>  
> -static irqreturn_t mvebu_pcie_irq_handler(int irq, void *arg)
> +static irqreturn_t mvebu_pcie_error_irq_handler(int irq, void *arg)
> +{
> +	struct mvebu_pcie_port *port = arg;
> +	struct device *dev = &port->pcie->pdev->dev;
> +	u32 cause, unmask, status;
> +
> +	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
> +	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> +	status = cause & unmask;
> +
> +	/* "error" interrupt handler does not process INTX interrupts */
> +	status &= ~(PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> +		    PCIE_INT_INTX(2) | PCIE_INT_INTX(3));
> +
> +	/* Process PME interrupt */
> +	if ((status & PCIE_INT_PM_PME) && !port->pme_pending) {
> +		/*
> +		 * Do not clear PME interrupt bit in Cause Register as it
> +		 * invalidates also content of Root Status Register. Instead
> +		 * set port->pme_pending variable to true to indicate that
> +		 * next time PME interrupt should be ignored until variable
> +		 * is back to the false value.
> +		 */
> +		port->pme_pending = true;
> +		if (generic_handle_domain_irq(port->rp_irq_domain, 0) == -EINVAL)
> +			dev_err_ratelimited(dev, "unhandled PME IRQ\n");
> +	}
> +
> +	/* Process ERR interrupt */
> +	if (status & PCIE_INT_ERR_MASK) {
> +		mvebu_writel(port, ~PCIE_INT_ERR_MASK, PCIE_INT_CAUSE_OFF);
> +		if (generic_handle_domain_irq(port->rp_irq_domain, 0) == -EINVAL)
> +			dev_err_ratelimited(dev, "unhandled ERR IRQ\n");
> +	}
> +
> +	/* Process local ERR interrupt */
> +	if (status & PCIE_INT_DET_MASK) {
> +		mvebu_writel(port, ~PCIE_INT_DET_MASK, PCIE_INT_CAUSE_OFF);
> +		if (generic_handle_domain_irq(port->rp_irq_domain, 0) == -EINVAL)
> +			dev_err_ratelimited(dev, "unhandled ERR IRQ\n");
> +	}
> +
> +	return status ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static irqreturn_t mvebu_pcie_intx_irq_handler(int irq, void *arg)
>  {
>  	struct mvebu_pcie_port *port = arg;
>  	struct device *dev = &port->pcie->pdev->dev;
> @@ -1108,6 +1254,10 @@ static irqreturn_t mvebu_pcie_irq_handler(int irq, void *arg)
>  	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
>  	status = cause & unmask;
>  
> +	/* "intx" interrupt handler process only INTX interrupts */
> +	status &= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> +		  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
> +
>  	/* Process legacy INTx interrupts */
>  	for (i = 0; i < PCI_NUM_INTX; i++) {
>  		if (!(status & PCIE_INT_INTX(i)))
> @@ -1122,9 +1272,29 @@ static irqreturn_t mvebu_pcie_irq_handler(int irq, void *arg)
>  
>  static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
> -	/* Interrupt support on mvebu emulated bridges is not implemented yet */
> -	if (dev->bus->number == 0)
> -		return 0; /* Proper return code 0 == NO_IRQ */
> +	struct mvebu_pcie_port *port;
> +	struct mvebu_pcie *pcie;
> +
> +	if (dev->bus->number == 0) {
> +		/*
> +		 * Each emulated root bridge for every mvebu port has its own
> +		 * Root Port irq chip and irq domain. Argument pin is the INTx
> +		 * pin (1=INTA, 2=INTB, 3=INTC, 4=INTD) and hwirq for function
> +		 * irq_create_mapping() is indexed from zero.
> +		 */
> +		pcie = dev->bus->sysdata;
> +		port = mvebu_pcie_find_port(pcie, dev->bus, PCI_DEVFN(slot, 0));
> +		if (!port)
> +			return 0; /* Proper return code 0 == NO_IRQ */
> +		/*
> +		 * port->rp_irq_domain is available only when "error" interrupt
> +		 * was specified in DT. When is not available then interrupts
> +		 * for emulated root bridge are not provided.
> +		 */
> +		if (port->error_irq <= 0)
> +			return 0; /* Proper return code 0 == NO_IRQ */
> +		return irq_create_mapping(port->rp_irq_domain, pin - 1);
> +	}
>  
>  	return of_irq_parse_and_map_pci(dev, slot, pin);
>  }
> @@ -1333,6 +1503,21 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
>  			 port->name, child);
>  	}
>  
> +	/*
> +	 * Old DT bindings do not contain "error" interrupt
> +	 * so do not fail probing driver when interrupt does not exist.
> +	 */
> +	port->error_irq = of_irq_get_byname(child, "error");
> +	if (port->error_irq == -EPROBE_DEFER) {
> +		ret = port->error_irq;
> +		goto err;
> +	}
> +	if (port->error_irq <= 0) {
> +		dev_warn(dev, "%s: interrupts on Root Port are unsupported, "
> +			      "%pOF does not contain error interrupt\n",
> +			 port->name, child);
> +	}
> +
>  	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
>  	if (reset_gpio == -EPROBE_DEFER) {
>  		ret = reset_gpio;
> @@ -1538,7 +1723,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < pcie->nports; i++) {
>  		struct mvebu_pcie_port *port = &pcie->ports[i];
> -		int irq = port->intx_irq;
>  
>  		child = port->dn;
>  		if (!child)
> @@ -1566,7 +1750,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  			continue;
>  		}
>  
> -		if (irq > 0) {
> +		if (port->error_irq > 0 || port->intx_irq > 0) {
>  			ret = mvebu_pcie_init_irq_domain(port);
>  			if (ret) {
>  				dev_err(dev, "%s: cannot init irq domain\n",
> @@ -1577,14 +1761,42 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  				mvebu_pcie_powerdown(port);
>  				continue;
>  			}
> +		}
> +
> +		if (port->error_irq > 0) {
> +			ret = devm_request_irq(dev, port->error_irq,
> +					       mvebu_pcie_error_irq_handler,
> +					       IRQF_SHARED | IRQF_NO_THREAD,
> +					       port->name, port);
> +			if (ret) {
> +				dev_err(dev, "%s: cannot register error interrupt handler: %d\n",
> +					port->name, ret);
> +				if (port->intx_irq_domain)
> +					irq_domain_remove(port->intx_irq_domain);
> +				if (port->rp_irq_domain)
> +					irq_domain_remove(port->rp_irq_domain);
> +				pci_bridge_emul_cleanup(&port->bridge);
> +				devm_iounmap(dev, port->base);
> +				port->base = NULL;
> +				mvebu_pcie_powerdown(port);
> +				continue;
> +			}
> +		}
>  
> -			ret = devm_request_irq(dev, irq, mvebu_pcie_irq_handler,
> +		if (port->intx_irq > 0) {
> +			ret = devm_request_irq(dev, port->intx_irq,
> +					       mvebu_pcie_intx_irq_handler,
>  					       IRQF_SHARED | IRQF_NO_THREAD,
>  					       port->name, port);
>  			if (ret) {
> -				dev_err(dev, "%s: cannot register interrupt handler: %d\n",
> +				dev_err(dev, "%s: cannot register intx interrupt handler: %d\n",
>  					port->name, ret);
> -				irq_domain_remove(port->intx_irq_domain);
> +				if (port->error_irq > 0)
> +					devm_free_irq(dev, port->error_irq, port);
> +				if (port->intx_irq_domain)
> +					irq_domain_remove(port->intx_irq_domain);
> +				if (port->rp_irq_domain)
> +					irq_domain_remove(port->rp_irq_domain);
>  				pci_bridge_emul_cleanup(&port->bridge);
>  				devm_iounmap(dev, port->base);
>  				port->base = NULL;
> @@ -1722,6 +1934,12 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
>  			}
>  			irq_domain_remove(port->intx_irq_domain);
>  		}
> +		if (port->rp_irq_domain) {
> +			int virq = irq_find_mapping(port->rp_irq_domain, 0);
> +			if (virq > 0)
> +				irq_dispose_mapping(virq);
> +			irq_domain_remove(port->rp_irq_domain);
> +		}
>  
>  		/* Free config space for emulated root bridge. */
>  		pci_bridge_emul_cleanup(&port->bridge);
> -- 
> 2.20.1
> 
