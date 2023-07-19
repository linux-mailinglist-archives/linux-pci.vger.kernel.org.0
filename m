Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1427592B0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 12:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGSKVM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 06:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjGSKVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 06:21:09 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747FE1FCD;
        Wed, 19 Jul 2023 03:21:04 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C09D9817A;
        Wed, 19 Jul 2023 18:21:02 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:02 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:01 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 3/9] PCI: PLDA: Get PLDA common codes from Microchip PolarFire host
Date:   Wed, 19 Jul 2023 18:20:51 +0800
Message-ID: <20230719102057.22329-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230719102057.22329-1-minda.chen@starfivetech.com>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PLDA PCIe controller driver codes, extract from Microchip
PolarFire PCIe host driver codes first.

The change includes:
- copy the IP register marcos.
- Add related data structures of PCIe host instance.
  mc_pcie --> plda_pcie (Get most of data members)
  mc_msi  --> plda_msi
  add plda_pcie_ops and plda_evt data structures.
- function rename list:
  mc_pcie_enable_msi       --> plda_pcie_enable_msi
  mc_pcie_setup_window     --> plda_pcie_setup_window
  mc_pcie_setup_windows    --> plda_pcie_setup_iomems
  mc_pcie_init_irq_domains --> plda_pcie_init_irq_domains
  mc_allocate_msi_domains  --> plda_allocate_msi_domains
  mc_init_interrupts       --> plda_pcie_init_irq
  msi interrupts related functions and irq domain
  (primary function is mc_handle_msi):
  mc_handle_msi            --> plda_handle_msi
  intx interrupts related functions and irq domain
  (primary function is mc_handle_intx):
  mc_handle_intx           --> plda_handle_intx
  event interrupts:
  mc_handle_event	   --> plda_handle_event
- For PolarFire implements non-plda local interrupt events, most of
  event interrupt process codes can not be re-used. PLDA implements
  new codes and irq domain ops like PolarFire.
  New event functions:
    plda_event_handler
    plda_pcie_event_map
    plda_ack_event_irq
    plda_mask_event_irq
    plda_unmask_event_irq
    plda_hwirq_to_mask
- plda_handle_event adds a new irqnum to event num mapping codes for
  PLDA local event except DMA engine interrupt events. The DMA engine
  interrupt events are implemented by vendors. So do not add these
  events. PolarFire PCIe uses get_events function pointer to get
  their events num.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 MAINTAINERS                                  |   8 +
 drivers/pci/controller/Kconfig               |   1 +
 drivers/pci/controller/Makefile              |   1 +
 drivers/pci/controller/plda/Kconfig          |  11 +
 drivers/pci/controller/plda/Makefile         |   2 +
 drivers/pci/controller/plda/pcie-plda-host.c | 554 +++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h      | 173 ++++++
 7 files changed, 750 insertions(+)
 create mode 100644 drivers/pci/controller/plda/Kconfig
 create mode 100644 drivers/pci/controller/plda/Makefile
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e4f9d5dca55..3b3c4d8808ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16170,6 +16170,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/cdns,*
 F:	drivers/pci/controller/cadence/
 
+PCI DRIVER FOR PLDA PCIE IP
+M:	Daire McNamara <daire.mcnamara@microchip.com>
+M:	Minda Chen <minda.chen@starfivetech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/plda,*
+F:	drivers/pci/controller/plda/*plda*
+
 PCI DRIVER FOR FREESCALE LAYERSCAPE
 M:	Minghuan Lian <minghuan.Lian@nxp.com>
 M:	Mingkai Hu <mingkai.hu@nxp.com>
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8d49bad7f847..a106dabcb8dc 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -346,4 +346,5 @@ config PCIE_XILINX_CPM
 source "drivers/pci/controller/cadence/Kconfig"
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
+source "drivers/pci/controller/plda/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 37c8663de7fe..aa0a691ebcbc 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_PCIE_MT7621) += pcie-mt7621.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
 obj-y				+= mobiveil/
+obj-y				+= plda/
 
 
 # The following drivers are for devices that use the generic ACPI
diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
new file mode 100644
index 000000000000..37e17326671b
--- /dev/null
+++ b/drivers/pci/controller/plda/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "PLDA PCIe controllers support"
+	depends on PCI
+
+config PCIE_PLDA_HOST
+	bool "PLDA PCIe host controller"
+	depends on OF && PCI_MSI
+	select IRQ_DOMAIN
+
+endmenu
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
new file mode 100644
index 000000000000..79dbae655c2b
--- /dev/null
+++ b/drivers/pci/controller/plda/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
new file mode 100644
index 000000000000..ca720430721c
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLDA PCIe XpressRich host controller driver
+ *
+ * Copyright (C) 2023 Microchip Co. Ltd
+ *		      StarFive Co. Ltd.
+ *
+ * Author: Daire McNamara <daire.mcnamara@microchip.com>
+ * Author: Minda Chen <minda.chen@starfivetech.com>
+ */
+
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/pci_regs.h>
+#include <linux/pci-ecam.h>
+#include <linux/platform_device.h>
+
+#include "pcie-plda.h"
+
+void plda_pcie_enable_msi(struct plda_pcie *port)
+{
+	struct plda_msi *msi = &port->msi;
+	void __iomem *base = port->bridge_addr;
+	u32 cap_offset = MSI_CAP_CTRL_OFFSET;
+	u16 msg_ctrl = readw_relaxed(base + cap_offset + PCI_MSI_FLAGS);
+
+	msg_ctrl |= PCI_MSI_FLAGS_ENABLE;
+	msg_ctrl &= ~PCI_MSI_FLAGS_QMASK;
+	msg_ctrl |= MSI_MAX_Q_AVAIL;
+	msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
+	msg_ctrl |= MSI_Q_SIZE;
+	msg_ctrl |= PCI_MSI_FLAGS_64BIT;
+
+	writew_relaxed(msg_ctrl, base + cap_offset + PCI_MSI_FLAGS);
+
+	writel_relaxed(lower_32_bits(msi->vector_phy),
+		       base + cap_offset + PCI_MSI_ADDRESS_LO);
+	writel_relaxed(upper_32_bits(msi->vector_phy),
+		       base + cap_offset + PCI_MSI_ADDRESS_HI);
+}
+EXPORT_SYMBOL_GPL(plda_pcie_enable_msi);
+
+static void plda_handle_msi(struct irq_desc *desc)
+{
+	struct plda_pcie *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct device *dev = port->dev;
+	struct plda_msi *msi = &port->msi;
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long status;
+	u32 bit;
+	int ret;
+
+	chained_irq_enter(chip, desc);
+	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
+	if (status & PM_MSI_INT_MSI_MASK) {
+		writel_relaxed(BIT(PM_MSI_INT_MSI_SHIFT), bridge_base_addr + ISTATUS_LOCAL);
+		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
+		for_each_set_bit(bit, &status, msi->num_vectors) {
+			ret = generic_handle_domain_irq(msi->dev_domain, bit);
+			if (ret)
+				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
+						    bit);
+		}
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static void plda_msi_bottom_irq_ack(struct irq_data *data)
+{
+	struct plda_pcie *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	u32 bitpos = data->hwirq;
+
+	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
+}
+
+static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct plda_pcie *port = irq_data_get_irq_chip_data(data);
+	phys_addr_t addr = port->msi.vector_phy;
+
+	msg->address_lo = lower_32_bits(addr);
+	msg->address_hi = upper_32_bits(addr);
+	msg->data = data->hwirq;
+
+	dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n",
+		(int)data->hwirq, msg->address_hi, msg->address_lo);
+}
+
+static int plda_msi_set_affinity(struct irq_data *irq_data,
+				 const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip plda_msi_bottom_irq_chip = {
+	.name = "PLDA MSI",
+	.irq_ack = plda_msi_bottom_irq_ack,
+	.irq_compose_msi_msg = plda_compose_msi_msg,
+	.irq_set_affinity = plda_msi_set_affinity,
+};
+
+static int plda_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs, void *args)
+{
+	struct plda_pcie *port = domain->host_data;
+	struct plda_msi *msi = &port->msi;
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long bit;
+	u32 val;
+
+	mutex_lock(&msi->lock);
+	bit = find_first_zero_bit(msi->used, msi->num_vectors);
+	if (bit >= msi->num_vectors) {
+		mutex_unlock(&msi->lock);
+		return -ENOSPC;
+	}
+
+	set_bit(bit, msi->used);
+
+	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
+			    domain->host_data, handle_edge_irq, NULL, NULL);
+
+	/* Enable MSI interrupts */
+	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
+	val |= PM_MSI_INT_MSI_MASK;
+	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
+
+	mutex_unlock(&msi->lock);
+
+	return 0;
+}
+
+static void plda_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct plda_pcie *port = irq_data_get_irq_chip_data(d);
+	struct plda_msi *msi = &port->msi;
+
+	mutex_lock(&msi->lock);
+
+	if (test_bit(d->hwirq, msi->used))
+		__clear_bit(d->hwirq, msi->used);
+	else
+		dev_err(port->dev, "trying to free unused MSI%lu\n", d->hwirq);
+
+	mutex_unlock(&msi->lock);
+}
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.alloc	= plda_irq_msi_domain_alloc,
+	.free	= plda_irq_msi_domain_free,
+};
+
+static struct irq_chip plda_msi_irq_chip = {
+	.name = "PLDA PCIe MSI",
+	.irq_ack = irq_chip_ack_parent,
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static struct msi_domain_info plda_msi_domain_info = {
+	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_PCI_MSIX),
+	.chip = &plda_msi_irq_chip,
+};
+
+static int plda_allocate_msi_domains(struct plda_pcie *port)
+{
+	struct device *dev = port->dev;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct plda_msi *msi = &port->msi;
+
+	raw_spin_lock_init(&port->lock);
+	mutex_init(&port->msi.lock);
+
+	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors,
+						&msi_domain_ops, port);
+	if (!msi->dev_domain) {
+		dev_err(dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode, &plda_msi_domain_info,
+						    msi->dev_domain);
+	if (!msi->msi_domain) {
+		dev_err(dev, "failed to create MSI domain\n");
+		irq_domain_remove(msi->dev_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void plda_handle_intx(struct irq_desc *desc)
+{
+	struct plda_pcie *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct device *dev = port->dev;
+	unsigned long status;
+	u32 bit;
+	int ret;
+
+	chained_irq_enter(chip, desc);
+	status = readl_relaxed(port->bridge_addr + ISTATUS_LOCAL);
+	if (status & PM_MSI_INT_INTX_MASK) {
+		status &= PM_MSI_INT_INTX_MASK;
+		status >>= PM_MSI_INT_INTX_SHIFT;
+		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
+			ret = generic_handle_domain_irq(port->intx_domain, bit);
+			if (ret)
+				dev_err_ratelimited(dev, "bad INTx IRQ %d %d\n",
+						    bit, ret);
+		}
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static void plda_ack_intx_irq(struct irq_data *data)
+{
+	struct plda_pcie *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
+
+	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
+}
+
+static void plda_mask_intx_irq(struct irq_data *data)
+{
+	struct plda_pcie *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long flags;
+	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
+	val &= ~mask;
+	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void plda_unmask_intx_irq(struct irq_data *data)
+{
+	struct plda_pcie *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long flags;
+	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
+	val |= mask;
+	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static struct irq_chip plda_intx_irq_chip = {
+	.name = "PLDA PCIe INTx",
+	.irq_ack = plda_ack_intx_irq,
+	.irq_mask = plda_mask_intx_irq,
+	.irq_unmask = plda_unmask_intx_irq,
+};
+
+static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = plda_pcie_intx_map,
+};
+
+static void plda_handle_event(struct irq_desc *desc)
+{
+	struct plda_pcie *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long events = 0;
+	u32 bit, val, origin;
+
+	chained_irq_enter(chip, desc);
+
+	if (port->ops && port->ops->get_events) {
+		events = port->ops->get_events(port);
+	} else {
+		val = readl_relaxed(port->bridge_addr + ISTATUS_LOCAL);
+		origin = val;
+		val = val >> A_ATR_EVT_POST_ERR_SHIFT;
+		events |= val & 0xff;
+		if (origin & PM_MSI_INT_INTX_MASK)
+			events |= BIT(EVENT_PM_MSI_INT_INTX);
+		val = (origin >> PM_MSI_INT_MSI_SHIFT) & 0xf;
+		events |= val << EVENT_PM_MSI_INT_MSI;
+	}
+
+	for_each_set_bit(bit, &events, port->num_events)
+		generic_handle_domain_irq(port->event_domain, bit);
+
+	chained_irq_exit(chip, desc);
+}
+
+static u32 plda_hwirq_to_mask(int hwirq)
+{
+	u32 mask;
+
+	if (hwirq < EVENT_PM_MSI_INT_INTX)
+		mask = BIT(hwirq + A_ATR_EVT_POST_ERR_SHIFT);
+	else if (hwirq == EVENT_PM_MSI_INT_INTX)
+		mask = PM_MSI_INT_INTX_MASK;
+	else
+		mask = BIT(hwirq + PM_MSI_TO_MASK_OFFSET);
+
+	return mask;
+}
+
+static void plda_ack_event_irq(struct irq_data *data)
+{
+	struct plda_pcie *port = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(plda_hwirq_to_mask(data->hwirq),
+		       port->bridge_addr + ISTATUS_LOCAL);
+}
+
+static void plda_mask_event_irq(struct irq_data *data)
+{
+	struct plda_pcie *port = irq_data_get_irq_chip_data(data);
+	u32 mask, val;
+
+	mask = plda_hwirq_to_mask(data->hwirq);
+
+	raw_spin_lock(&port->lock);
+	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
+	val &= ~mask;
+	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
+	raw_spin_unlock(&port->lock);
+}
+
+static void plda_unmask_event_irq(struct irq_data *data)
+{
+	struct plda_pcie *port = irq_data_get_irq_chip_data(data);
+	u32 mask, val;
+
+	mask = plda_hwirq_to_mask(data->hwirq);
+
+	raw_spin_lock(&port->lock);
+	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
+	val |= mask;
+	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
+	raw_spin_unlock(&port->lock);
+}
+
+static struct irq_chip plda_event_irq_chip = {
+	.name = "PLDA PCIe EVENT",
+	.irq_ack = plda_ack_event_irq,
+	.irq_mask = plda_mask_event_irq,
+	.irq_unmask = plda_unmask_event_irq,
+};
+
+static int plda_pcie_event_map(struct irq_domain *domain, unsigned int irq,
+			       irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &plda_event_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops event_domain_ops = {
+	.map = plda_pcie_event_map,
+};
+
+static irqreturn_t plda_event_handler(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
+static int plda_pcie_init_irq_domains(struct plda_pcie *port,
+				      const struct irq_domain_ops *domain_ops)
+{
+	struct device *dev = port->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *pcie_intc_node;
+
+	/* Setup INTx */
+	pcie_intc_node = of_get_next_child(node, NULL);
+	if (!pcie_intc_node) {
+		dev_err(dev, "failed to find PCIe Intc node\n");
+		return -EINVAL;
+	}
+
+	port->event_domain = irq_domain_add_linear(pcie_intc_node,
+						   port->num_events,
+						   domain_ops, port);
+	if (!port->event_domain) {
+		dev_err(dev, "failed to get event domain\n");
+		of_node_put(pcie_intc_node);
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(port->event_domain, DOMAIN_BUS_NEXUS);
+
+	port->intx_domain =
+		irq_domain_add_linear(node, PCI_NUM_INTX, &intx_domain_ops, port);
+	if (!port->intx_domain) {
+		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		of_node_put(pcie_intc_node);
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
+
+	of_node_put(pcie_intc_node);
+	raw_spin_lock_init(&port->lock);
+
+	return plda_allocate_msi_domains(port);
+}
+
+int plda_pcie_init_irq(struct plda_pcie *port, struct platform_device *pdev,
+		       struct plda_evt *evt)
+{
+	struct device *dev = port->dev;
+	const struct irq_domain_ops *ops;
+	int i;
+	int ret, err, event_irq, intx_irq, msi_irq;
+
+	if (!evt->domain_ops)
+		ops = &event_domain_ops;
+	else
+		ops = evt->domain_ops;
+
+	ret = plda_pcie_init_irq_domains(port, ops);
+	if (ret)
+		return ret;
+
+	port->irq = platform_get_irq(pdev, 0);
+	if (port->irq < 0) {
+		dev_err(dev, "Failed to get IRQ: %d\n", port->irq);
+		return port->irq;
+	}
+
+	for (i = 0; i < port->num_events; i++) {
+		event_irq = irq_create_mapping(port->event_domain, i);
+		if (!event_irq) {
+			dev_err(dev, "failed to map hwirq %d\n", i);
+			return -ENXIO;
+		}
+
+		if (evt->request_evt_irq)
+			err = evt->request_evt_irq(port, event_irq, i);
+		else
+			err = devm_request_irq(dev, event_irq,
+					       plda_event_handler,
+					       0, NULL, port);
+		if (err) {
+			dev_err(dev, "failed to request IRQ %d\n", event_irq);
+			return err;
+		}
+	}
+
+	intx_irq = irq_create_mapping(port->event_domain,
+				      evt->intx_evt);
+	if (!intx_irq) {
+		dev_err(dev, "failed to map INTx interrupt\n");
+		return -ENXIO;
+	}
+	port->intx_irq = intx_irq;
+
+	/* Plug the INTx chained handler */
+	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
+
+	msi_irq = irq_create_mapping(port->event_domain,
+				     evt->msi_evt);
+	if (!msi_irq)
+		return -ENXIO;
+
+	port->msi_irq = msi_irq;
+	/* Plug the MSI chained handler */
+	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
+
+	/* Plug the main event chained handler */
+	irq_set_chained_handler_and_data(port->irq, plda_handle_event, port);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(plda_pcie_init_irq);
+
+void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
+			    phys_addr_t axi_addr, phys_addr_t pci_addr,
+			    size_t size)
+{
+	u32 atr_sz = ilog2(size) - 1;
+	u32 val;
+
+	if (index == 0)
+		val = PCIE_CONFIG_INTERFACE;
+	else
+		val = PCIE_TX_RX_INTERFACE;
+
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_PARAM);
+
+	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
+			    ATR_IMPL_ENABLE;
+	writel_relaxed(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
+
+	val = upper_32_bits(axi_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_SRC_ADDR);
+
+	val = lower_32_bits(pci_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
+
+	val = upper_32_bits(pci_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
+
+	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
+	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
+	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
+	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
+}
+EXPORT_SYMBOL_GPL(plda_pcie_setup_window);
+
+int plda_pcie_setup_iomems(struct plda_pcie *port, struct pci_host_bridge *bridge)
+{
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	struct resource_entry *entry;
+	u64 pci_addr;
+	u32 index = 1;
+
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		if (resource_type(entry->res) == IORESOURCE_MEM) {
+			pci_addr = entry->res->start - entry->offset;
+			plda_pcie_setup_window(bridge_base_addr, index,
+					       entry->res->start, pci_addr,
+					       resource_size(entry->res));
+			index++;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
new file mode 100644
index 000000000000..feb3a0d9ace5
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PLDA PCIe host controller driver
+ */
+
+#ifndef _PCIE_PLDA_H
+#define _PCIE_PLDA_H
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-epf.h>
+#include <linux/phy/phy.h>
+
+/* Number of MSI IRQs */
+#define PLDA_NUM_MSI_IRQS		32
+#define NUM_MSI_IRQS_CODED		5
+
+/* PCIe Bridge Phy Regs */
+#define PCIE_PCI_IDS_DW1		0x9c
+
+/* PCIe Config space MSI capability structure */
+#define MSI_CAP_CTRL_OFFSET		0xe0
+#define  MSI_MAX_Q_AVAIL		(NUM_MSI_IRQS_CODED << 1)
+#define  MSI_Q_SIZE			(NUM_MSI_IRQS_CODED << 4)
+
+#define IMASK_LOCAL				0x180
+#define  DMA_END_ENGINE_0_MASK			0x00000000u
+#define  DMA_END_ENGINE_0_SHIFT			0
+#define  DMA_END_ENGINE_1_MASK			0x00000000u
+#define  DMA_END_ENGINE_1_SHIFT			1
+#define  DMA_ERROR_ENGINE_0_MASK		BIT(8)
+#define  DMA_ERROR_ENGINE_0_SHIFT		8
+#define  DMA_ERROR_ENGINE_1_MASK		BIT(9)
+#define  DMA_ERROR_ENGINE_1_SHIFT		9
+#define  DMA_END_MASK				GENMASK(7, 0)
+#define  DMA_ERR_MASK				GENMASK(15, 8)
+#define  DMA_ERR_SHIFT				8
+#define  A_ATR_EVT_POST_ERR_MASK		BIT(16)
+#define  A_ATR_EVT_POST_ERR_SHIFT		16
+#define  A_ATR_EVT_FETCH_ERR_MASK		BIT(17)
+#define  A_ATR_EVT_FETCH_ERR_SHIFT		17
+#define  A_ATR_EVT_DISCARD_ERR_MASK		BIT(18)
+#define  A_ATR_EVT_DISCARD_ERR_SHIFT		18
+#define  A_ATR_EVT_DOORBELL_MASK		BIT(19)
+#define  A_ATR_EVT_DOORBELL_SHIFT		19
+#define  P_ATR_EVT_POST_ERR_MASK		BIT(20)
+#define  P_ATR_EVT_POST_ERR_SHIFT		20
+#define  P_ATR_EVT_FETCH_ERR_MASK		BIT(21)
+#define  P_ATR_EVT_FETCH_ERR_SHIFT		21
+#define  P_ATR_EVT_DISCARD_ERR_MASK		BIT(22)
+#define  P_ATR_EVT_DISCARD_ERR_SHIFT		22
+#define  P_ATR_EVT_DOORBELL_MASK		BIT(23)
+#define  P_ATR_EVT_DOORBELL_SHIFT		23
+#define  PM_MSI_INT_INTA_MASK			BIT(24)
+#define  PM_MSI_INT_INTA_SHIFT			24
+#define  PM_MSI_INT_INTB_MASK			BIT(25)
+#define  PM_MSI_INT_INTB_SHIFT			25
+#define  PM_MSI_INT_INTC_MASK			BIT(26)
+#define  PM_MSI_INT_INTC_SHIFT			26
+#define  PM_MSI_INT_INTD_MASK			BIT(27)
+#define  PM_MSI_INT_INTD_SHIFT			27
+#define  PM_MSI_INT_INTX_MASK			GENMASK(27, 24)
+#define  PM_MSI_INT_INTX_SHIFT			24
+#define  PM_MSI_INT_MSI_MASK			BIT(28)
+#define  PM_MSI_INT_MSI_SHIFT			28
+#define  PM_MSI_INT_AER_EVT_MASK		BIT(29)
+#define  PM_MSI_INT_AER_EVT_SHIFT		29
+#define  PM_MSI_INT_EVENTS_MASK			BIT(30)
+#define  PM_MSI_INT_EVENTS_SHIFT		30
+#define  PM_MSI_INT_SYS_ERR_MASK		BIT(31)
+#define  PM_MSI_INT_SYS_ERR_SHIFT		31
+
+#define ISTATUS_LOCAL				0x184
+#define IMASK_HOST				0x188
+#define ISTATUS_HOST				0x18c
+#define IMSI_ADDR				0x190
+#define ISTATUS_MSI				0x194
+
+/* PCIe Master table init defines */
+#define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
+#define  ATR0_PCIE_ATR_SIZE			0x25
+#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
+#define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
+#define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
+#define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
+#define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
+
+/* PCIe AXI slave table init defines */
+#define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
+#define  ATR_SIZE_SHIFT				1
+#define  ATR_IMPL_ENABLE			1
+#define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
+#define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
+#define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
+#define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
+#define ATR0_AXI4_TABLE_OFFSET			0x20
+#define  PCIE_TX_RX_INTERFACE			0x00000000u
+#define  PCIE_CONFIG_INTERFACE			0x00000001u
+
+#define ATR_ENTRY_SIZE				32
+
+#define EVENT_A_ATR_EVT_POST_ERR		0
+#define EVENT_A_ATR_EVT_FETCH_ERR		1
+#define EVENT_A_ATR_EVT_DISCARD_ERR		2
+#define EVENT_A_ATR_EVT_DOORBELL		3
+#define EVENT_P_ATR_EVT_POST_ERR		4
+#define EVENT_P_ATR_EVT_FETCH_ERR		5
+#define EVENT_P_ATR_EVT_DISCARD_ERR		6
+#define EVENT_P_ATR_EVT_DOORBELL		7
+#define EVENT_PM_MSI_INT_INTX			8
+#define EVENT_PM_MSI_INT_MSI			9
+#define EVENT_PM_MSI_INT_AER_EVT		10
+#define EVENT_PM_MSI_INT_EVENTS			11
+#define EVENT_PM_MSI_INT_SYS_ERR		12
+#define NUM_PLDA_EVENTS				13
+
+#define PM_MSI_TO_MASK_OFFSET			19
+
+struct plda_pcie;
+
+struct plda_msi {
+	struct mutex lock;		/* Protect used bitmap */
+	struct irq_domain *msi_domain;
+	struct irq_domain *dev_domain; /* inner_domain*/
+	u32 num_vectors;
+	u64 vector_phy;
+	DECLARE_BITMAP(used, PLDA_NUM_MSI_IRQS);
+};
+
+struct plda_pcie_ops {
+	int (*host_init)(struct plda_pcie *pcie);
+	void (*host_deinit)(struct plda_pcie *pcie);
+	u32 (*get_events)(struct plda_pcie *pcie);
+};
+
+struct plda_pcie {
+	struct pci_host_bridge *bridge;
+	void __iomem *bridge_addr;
+	void __iomem *config_base;
+	struct irq_domain *intx_domain;
+	struct irq_domain *event_domain;
+	struct device *dev;
+	raw_spinlock_t lock;
+	struct plda_msi msi;
+	const struct plda_pcie_ops *ops;
+	struct phy *phy;
+	int irq;
+	int msi_irq;
+	int intx_irq;
+	int num_events;
+};
+
+struct plda_evt {
+	const struct irq_domain_ops *domain_ops;
+	int (*request_evt_irq)(struct plda_pcie *pcie, int evt_irq, int event);
+	int intx_evt;
+	int msi_evt;
+};
+
+void plda_pcie_enable_msi(struct plda_pcie *port);
+void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
+			    phys_addr_t axi_addr, phys_addr_t pci_addr,
+			    size_t size);
+int plda_pcie_setup_iomems(struct plda_pcie *port, struct pci_host_bridge *host_bridge);
+int plda_pcie_init_irq(struct plda_pcie *port, struct platform_device *pdev,
+		       struct plda_evt *evt);
+
+static inline void plda_set_default_msi(struct plda_msi *msi)
+{
+	msi->vector_phy = IMSI_ADDR;
+	msi->num_vectors = PLDA_NUM_MSI_IRQS;
+}
+#endif /* _PCIE_PLDA_H */
-- 
2.17.1

