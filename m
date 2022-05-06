Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61FC51D970
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441819AbiEFNo3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 09:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352819AbiEFNo2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 09:44:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F2FFEF;
        Fri,  6 May 2022 06:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8A90620C0;
        Fri,  6 May 2022 13:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8B8C385B6;
        Fri,  6 May 2022 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651844443;
        bh=zIIw6XCAEpxNTqxanLLraeRQ6N5E8O0yhBukjo7ea78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k19azJxpNO/MBhjI/HcZ5VJopuFnB7dF2itSD+UoSQj0VY3H13zZJN3gdjOlnPC4z
         f5QD4dNgqGTC44pjA4slW3dqHaX+vmuqqroSYXcZ1LlYXZhyWRK5AKdXdCSiA4GMxd
         9ejA/+ZCs8YxOiuLIlM3aO4c6feaJIGoCuaT/3kFmrPA7Bkn5arsvRXQVNzoDVu9vJ
         Yybx7Gzf8ffV/dIGnsEs/lt8VWIfxcrgc1/0LxRcrfLZKxLv0xsP9Fhv5YWzcKw7yz
         ctBDY4ZYVL/9xkuk3Nqe1bnXeEWmaqJxjkyK7IFM5RjQ2PEkgiCBOtb9dRCShRwcca
         9+fqjB/7Bq0Hg==
Received: by pali.im (Postfix)
        id 9A47D13C0; Fri,  6 May 2022 15:40:41 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] PCI: mvebu: Implement support for interrupts on emulated bridge
Date:   Fri,  6 May 2022 15:40:28 +0200
Message-Id: <20220506134029.21470-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220506134029.21470-1-pali@kernel.org>
References: <20220506134029.21470-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds support for PME and ERR interrupts reported by emulated bridge
(for PME and AER kernel drivers) via new Root Port irq chip as these
interrupts from PCIe Root Ports are handled by mvebu hardware completely
separately from INTx and MSI interrupts send by real PCIe devices.

With this change, kernel PME and AER drivers start working as they can
acquire required interrupt lines (provided by mvebu rp virtual irq chip).

Note that for this support, device tree files has to be properly adjusted
to provide "interrupts" or "interrupts-extended" property with summary
interrupt source and "interrupt-names" property with "summary" string.

If device tree files do not provide these properties then driver would work
as before and would not provide interrupts on emulated bridge, like before.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 208 ++++++++++++++++++++++++++---
 1 file changed, 189 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 3c48b15e3948..74923202fe95 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -56,8 +56,16 @@
 #define PCIE_CONF_DATA_OFF	0x18fc
 #define PCIE_INT_CAUSE_OFF	0x1900
 #define PCIE_INT_UNMASK_OFF	0x1910
+#define  PCIE_INT_DET_COR		BIT(8)
+#define  PCIE_INT_DET_NONFATAL		BIT(9)
+#define  PCIE_INT_DET_FATAL		BIT(10)
+#define  PCIE_INT_ERR_FATAL		BIT(16)
+#define  PCIE_INT_ERR_NONFATAL		BIT(17)
+#define  PCIE_INT_ERR_COR		BIT(18)
 #define  PCIE_INT_INTX(i)		BIT(24+i)
 #define  PCIE_INT_PM_PME		BIT(28)
+#define  PCIE_INT_DET_MASK		(PCIE_INT_DET_COR | PCIE_INT_DET_NONFATAL | PCIE_INT_DET_FATAL)
+#define  PCIE_INT_ERR_MASK		(PCIE_INT_ERR_FATAL | PCIE_INT_ERR_NONFATAL | PCIE_INT_ERR_COR)
 #define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
 #define PCIE_CTRL_OFF		0x1a00
 #define  PCIE_CTRL_X1_MODE		0x0001
@@ -120,9 +128,12 @@ struct mvebu_pcie_port {
 	struct resource regs;
 	u8 slot_power_limit_value;
 	u8 slot_power_limit_scale;
+	struct irq_domain *rp_irq_domain;
 	struct irq_domain *intx_irq_domain;
 	raw_spinlock_t irq_lock;
+	int summary_irq;
 	int intx_irq;
+	bool pme_pending;
 };
 
 static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
@@ -321,12 +332,27 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	/* Clear all interrupt causes. */
 	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
 
-	/* Check if "intx" interrupt was specified in DT. */
-	if (port->intx_irq > 0)
+	/*
+	 * Unmask all error interrupts which are internally generated.
+	 * They cannot be disabled by SERR# Enable bit in PCI Command register,
+	 * see Figure 6-3: Pseudo Logic Diagram for Error Message Controls in
+	 * PCIe base specification.
+	 * Internally generated mvebu interrupts are reported via mvebu summary
+	 * interrupt which requires "summary" interrupt to be specified in DT.
+	 */
+	if (port->summary_irq > 0) {
+		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+		unmask |= PCIE_INT_DET_MASK;
+		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+	}
+
+	/* Check if "summary" or "intx" interrupt was specified in DT. */
+	if (port->summary_irq > 0 || port->intx_irq > 0)
 		return;
 
 	/*
-	 * Fallback code when "intx" interrupt was not specified in DT:
+	 * Fallback code when neither "summary" interrupt, nor "intx"
+	 * interrupt was specified in DT:
 	 * Unmask all legacy INTx interrupts as driver does not provide a way
 	 * for masking and unmasking of individual legacy INTx interrupts.
 	 * Legacy INTx are reported via one shared GIC source and therefore
@@ -603,11 +629,16 @@ mvebu_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_INTERRUPT_LINE: {
 		/*
 		 * From the whole 32bit register we support reading from HW only
-		 * one bit: PCI_BRIDGE_CTL_BUS_RESET.
+		 * two bits: PCI_BRIDGE_CTL_BUS_RESET and PCI_BRIDGE_CTL_SERR.
 		 * Other bits are retrieved only from emulated config buffer.
 		 */
 		__le32 *cfgspace = (__le32 *)&bridge->conf;
 		u32 val = le32_to_cpu(cfgspace[PCI_INTERRUPT_LINE / 4]);
+		if ((mvebu_readl(port, PCIE_INT_UNMASK_OFF) &
+		      PCIE_INT_ERR_MASK) == PCIE_INT_ERR_MASK)
+			val |= PCI_BRIDGE_CTL_SERR << 16;
+		else
+			val &= ~(PCI_BRIDGE_CTL_SERR << 16);
 		if (mvebu_readl(port, PCIE_CTRL_OFF) & PCIE_CTRL_MASTER_HOT_RESET)
 			val |= PCI_BRIDGE_CTL_BUS_RESET << 16;
 		else
@@ -675,6 +706,11 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		break;
 	}
 
+	case PCI_EXP_RTCTL:
+		*value = (mvebu_readl(port, PCIE_INT_UNMASK_OFF) &
+			  PCIE_INT_PM_PME) ? PCI_EXP_RTCTL_PMEIE : 0;
+		break;
+
 	case PCI_EXP_RTSTA:
 		*value = mvebu_readl(port, PCIE_RC_RTSTA);
 		break;
@@ -780,6 +816,14 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 		break;
 
 	case PCI_INTERRUPT_LINE:
+		if (mask & (PCI_BRIDGE_CTL_SERR << 16)) {
+			u32 unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+			if (new & (PCI_BRIDGE_CTL_SERR << 16))
+				unmask |= PCIE_INT_ERR_MASK;
+			else
+				unmask &= ~PCIE_INT_ERR_MASK;
+			mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+		}
 		if (mask & (PCI_BRIDGE_CTL_BUS_RESET << 16)) {
 			u32 ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
 			if (new & (PCI_BRIDGE_CTL_BUS_RESET << 16))
@@ -838,10 +882,25 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		 * PME Status bit in Root Status Register (PCIE_RC_RTSTA)
 		 * is read-only and can be cleared only by writing 0b to the
 		 * Interrupt Cause RW0C register (PCIE_INT_CAUSE_OFF). So
-		 * clear PME via Interrupt Cause.
+		 * clear PME via Interrupt Cause and also set port->pme_pending
+		 * variable to false value to start processing PME interrupts
+		 * in interrupt handler again.
 		 */
-		if (new & PCI_EXP_RTSTA_PME)
+		if (new & PCI_EXP_RTSTA_PME) {
 			mvebu_writel(port, ~PCIE_INT_PM_PME, PCIE_INT_CAUSE_OFF);
+			port->pme_pending = false;
+		}
+		break;
+
+	case PCI_EXP_RTCTL:
+		if (mask & PCI_EXP_RTCTL_PMEIE) {
+			u32 unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+			if (new & PCI_EXP_RTCTL_PMEIE)
+				unmask |= PCIE_INT_PM_PME;
+			else
+				unmask &= ~PCIE_INT_PM_PME;
+			mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+		}
 		break;
 
 	case PCI_EXP_DEVCTL2:
@@ -924,6 +983,14 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 		bridge_flags |= PCI_BRIDGE_EMUL_NO_IO_FORWARD;
 	}
 
+	/*
+	 * Interrupts on emulated bridge are supported only when "summary"
+	 * interrupt was specified in DT. Without it emulated bridge cannot
+	 * emulate interrupts.
+	 */
+	if (port->summary_irq > 0)
+		bridge->conf.intpin = PCI_INTERRUPT_INTA;
+
 	/*
 	 * Older mvebu hardware provides PCIe Capability structure only in
 	 * version 1. New hardware provides it in version 2.
@@ -1071,6 +1138,26 @@ static const struct irq_domain_ops mvebu_pcie_intx_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+static struct irq_chip rp_irq_chip = {
+	.name = "mvebu-rp",
+};
+
+static int mvebu_pcie_rp_irq_map(struct irq_domain *h,
+				   unsigned int virq, irq_hw_number_t hwirq)
+{
+	struct mvebu_pcie_port *port = h->host_data;
+
+	irq_set_chip_and_handler(virq, &rp_irq_chip, handle_simple_irq);
+	irq_set_chip_data(virq, port);
+
+	return 0;
+}
+
+static const struct irq_domain_ops mvebu_pcie_rp_irq_domain_ops = {
+	.map = mvebu_pcie_rp_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
 static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
 {
 	struct device *dev = &port->pcie->pdev->dev;
@@ -1093,6 +1180,22 @@ static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
 		return -ENOMEM;
 	}
 
+	/*
+	 * When "summary" interrupt was not specified in DT then there is no support
+	 * for interrupts on emulated root bridge. So skip following initialization.
+	 */
+	if (port->summary_irq <= 0)
+		return 0;
+
+	port->rp_irq_domain = irq_domain_add_linear(NULL, 1,
+						      &mvebu_pcie_rp_irq_domain_ops,
+						      port);
+	if (!port->rp_irq_domain) {
+		irq_domain_remove(port->intx_irq_domain);
+		dev_err(dev, "Failed to add Root Port IRQ domain for %s\n", port->name);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -1110,6 +1213,34 @@ static void mvebu_pcie_irq_handler(struct irq_desc *desc)
 	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
 	status = cause & unmask;
 
+	/* Process PME interrupt */
+	if ((status & PCIE_INT_PM_PME) && !port->pme_pending) {
+		/*
+		 * Do not clear PME interrupt bit in Cause Register as it
+		 * invalidates also content of Root Status Register. Instead
+		 * set port->pme_pending variable to true to indicate that
+		 * next time PME interrupt should be ignored until variable
+		 * is back to the false value.
+		 */
+		port->pme_pending = true;
+		if (generic_handle_domain_irq(port->rp_irq_domain, 0) == -EINVAL)
+			dev_err_ratelimited(dev, "unhandled PME IRQ\n");
+	}
+
+	/* Process ERR interrupt */
+	if (status & PCIE_INT_ERR_MASK) {
+		mvebu_writel(port, ~PCIE_INT_ERR_MASK, PCIE_INT_CAUSE_OFF);
+		if (generic_handle_domain_irq(port->rp_irq_domain, 0) == -EINVAL)
+			dev_err_ratelimited(dev, "unhandled ERR IRQ\n");
+	}
+
+	/* Process local ERR interrupt */
+	if (status & PCIE_INT_DET_MASK) {
+		mvebu_writel(port, ~PCIE_INT_DET_MASK, PCIE_INT_CAUSE_OFF);
+		if (generic_handle_domain_irq(port->rp_irq_domain, 0) == -EINVAL)
+			dev_err_ratelimited(dev, "unhandled ERR IRQ\n");
+	}
+
 	/* Process legacy INTx interrupts */
 	for (i = 0; i < PCI_NUM_INTX; i++) {
 		if (!(status & PCIE_INT_INTX(i)))
@@ -1124,9 +1255,29 @@ static void mvebu_pcie_irq_handler(struct irq_desc *desc)
 
 static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	/* Interrupt support on mvebu emulated bridges is not implemented yet */
-	if (dev->bus->number == 0)
-		return 0; /* Proper return code 0 == NO_IRQ */
+	struct mvebu_pcie_port *port;
+	struct mvebu_pcie *pcie;
+
+	if (dev->bus->number == 0) {
+		/*
+		 * Each emulated root bridge for every mvebu port has its own
+		 * Root Port irq chip and irq domain. Argument pin is the INTx
+		 * pin (1=INTA, 2=INTB, 3=INTC, 4=INTD) and hwirq for function
+		 * irq_create_mapping() is indexed from zero.
+		 */
+		pcie = dev->bus->sysdata;
+		port = mvebu_pcie_find_port(pcie, dev->bus, PCI_DEVFN(slot, 0));
+		if (!port)
+			return 0; /* Proper return code 0 == NO_IRQ */
+		/*
+		 * port->rp_irq_domain is available only when "summary"
+		 * interrupt was specified in DT. When is not available then
+		 * interrupts for emulated root bridge are not provided.
+		 */
+		if (port->summary_irq <= 0)
+			return 0; /* Proper return code 0 == NO_IRQ */
+		return irq_create_mapping(port->rp_irq_domain, pin - 1);
+	}
 
 	return of_irq_parse_and_map_pci(dev, slot, pin);
 }
@@ -1321,17 +1472,32 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	}
 
 	/*
-	 * Old DT bindings do not contain "intx" interrupt
+	 * Old DT bindings do not contain "summary" interrupt
 	 * so do not fail probing driver when interrupt does not exist.
 	 */
-	port->intx_irq = of_irq_get_byname(child, "intx");
-	if (port->intx_irq == -EPROBE_DEFER) {
-		ret = port->intx_irq;
+	port->summary_irq = of_irq_get_byname(child, "summary");
+	if (port->summary_irq == -EPROBE_DEFER) {
+		ret = port->summary_irq;
 		goto err;
-	}
-	if (port->intx_irq <= 0) {
-		dev_warn(dev, "%s: legacy INTx interrupts cannot be masked individually, "
-			      "%pOF does not contain intx interrupt\n",
+	} else if (port->summary_irq <= 0) {
+		/*
+		 * When "summary" interrupt (which includes also intx) is
+		 * unsupported then fallback to dedicated "intx" interrupt.
+		 * Old DT bindings do not contain "intx" interrupt so do not
+		 * fail probing driver when interrupt does not exist.
+		 */
+		port->intx_irq = of_irq_get_byname(child, "intx");
+		if (port->intx_irq == -EPROBE_DEFER) {
+			ret = port->intx_irq;
+			goto err;
+		}
+		if (port->intx_irq <= 0) {
+			dev_warn(dev, "%s: legacy INTx interrupts cannot be masked individually, "
+				      "%pOF does not contain intx interrupt\n",
+				 port->name, child);
+		}
+		dev_warn(dev, "%s: interrupts on Root Port are unsupported, "
+			      "%pOF does not contain summary interrupt\n",
 			 port->name, child);
 	}
 
@@ -1540,7 +1706,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
-		int irq = port->intx_irq;
+		int irq = (port->summary_irq > 0) ? port->summary_irq :
+			  (port->intx_irq > 0) ? port->intx_irq : 0;
 
 		child = port->dn;
 		if (!child)
@@ -1688,7 +1855,8 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
-		int irq = port->intx_irq;
+		int irq = (port->summary_irq > 0) ? port->summary_irq :
+			  (port->intx_irq > 0) ? port->intx_irq : 0;
 
 		if (!port->base)
 			continue;
@@ -1710,6 +1878,8 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 		/* Remove IRQ domains. */
 		if (port->intx_irq_domain)
 			irq_domain_remove(port->intx_irq_domain);
+		if (port->rp_irq_domain)
+			irq_domain_remove(port->rp_irq_domain);
 
 		/* Free config space for emulated root bridge. */
 		pci_bridge_emul_cleanup(&port->bridge);
-- 
2.20.1

