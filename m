Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2B32CD540
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 13:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbgLCMMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 07:12:37 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:35408 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387902AbgLCMMg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 07:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606997555; x=1638533555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ST3A1l5XsrbH/zaKGOsGUCxFHV32aKzMOA//lN2JXWY=;
  b=xUhneWivRibSerxtSKFSoyNhF3rSO0BhExktPP4E1SOu1ZB6VUJ+7Xwt
   7cG/cSUeJTNoWcmQ/MSfz8sfKhsXFM8sh59ZkjEBKyfdvSIzen5GoGEGR
   S9UZ9chZqQKlO4d5+2pVBm1EaqK6oTIwdvbtB7VefMhnqT9oGNMCJwVJy
   cbL285j8/K6LFNjXKXT+Po2YXr0MhlPhF7eQNhbmmGxFCElt0Wx0PWVHG
   Ytx5N/pvqje+fknz0ZyN/GXvHJlKKOzsTh+bZbIzECmbpkSa+nyphDJAu
   V0mAhiERrBDN9gIg7wegELiKgg64xX1YV4sIDBAWhZVc+uU09qNYpkWY8
   A==;
IronPort-SDR: i8vaV2+FwnhJSuhJCyzN+cD7nseb39rL7tR8VWyI7op23yvEZu5oOllMNnh5YPoQ9FFSfOjkxC
 v3N7fmJ+sKDTxUyQ9UqTQZ7nm9z1EJAaQN+vIxz7ULtw8QISU8YEGPigYBWA185/upE7+OU+rj
 yvnfty0Dws+Me46HE6ejKDOJ/G5zqJPm8ls4GGMoAq/gjEcqBHPclMzZCJWLw6gSrqvOp0Aq/L
 VEhcP5PUNuOfktHibyuBmOzgUE5dUC8KiySGZnwvlV6UJMQGlC1KjG30jjKjHJ9in1RZJY3tzr
 si0=
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="95700032"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Dec 2020 05:10:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 05:10:52 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 3 Dec 2020 05:10:50 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        <ben.dooks@codethink.co.uk>,
        Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v18 3/4] PCI: microchip: Add host driver for Microchip PCIe controller
Date:   Thu, 3 Dec 2020 12:10:17 +0000
Message-ID: <20201203121018.16432-4-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203121018.16432-1-daire.mcnamara@microchip.com>
References: <20201203121018.16432-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Add support for the Microchip PolarFire PCIe controller when
configured in host (Root Complex) mode.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/Kconfig               |  10 +
 drivers/pci/controller/Makefile              |   1 +
 drivers/pci/controller/pcie-microchip-host.c | 607 +++++++++++++++++++
 3 files changed, 618 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-microchip-host.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 64e2f5e379aa..bca2f8949510 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -298,6 +298,16 @@ config PCI_LOONGSON
 	  Say Y here if you want to enable PCI controller support on
 	  Loongson systems.
 
+config PCIE_MICROCHIP_HOST
+	bool "Microchip AXI PCIe host bridge support"
+	depends on PCI_MSI && OF
+	select PCI_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ_DOMAIN
+	select PCI_HOST_COMMON
+	help
+	  Say Y here if you want kernel to support the Microchip AXI PCIe
+	  Host Bridge driver.
+
 config PCIE_HISI_ERR
 	depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
 	bool "HiSilicon HIP PCIe controller error handling driver"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 04c6edc285c5..b85fcd574ff6 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
 obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
+obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
 obj-$(CONFIG_VMD) += vmd.o
 obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
 obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
new file mode 100644
index 000000000000..6051b17073ae
--- /dev/null
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip AXI PCIe Bridge host controller driver
+ *
+ * Copyright (c) 2018 - 2020 Microchip Corporation. All rights reserved.
+ *
+ * Author: Daire McNamara <daire.mcnamara@microchip.com>
+ *
+ * Based on:
+ *	pcie-rcar.c
+ *	pcie-xilinx.c
+ *	pcie-altera.c
+ */
+
+#include <linux/clk.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci-ecam.h>
+#include <linux/platform_device.h>
+
+#include "../pci.h"
+
+/* Number of MSI IRQs */
+#define MC_NUM_MSI_IRQS				32
+#define MC_NUM_MSI_IRQS_CODED			5
+
+/* PCIe Bridge Phy and Controller Phy offsets */
+#define MC_PCIE1_BRIDGE_ADDR			0x00008000u
+#define MC_PCIE1_CTRL_ADDR			0x0000a000u
+
+/* PCIe Controller Phy Regs */
+#define MC_SEC_ERROR_INT			0x28
+#define  SEC_ERROR_INT_TX_RAM_SEC_ERR_INT	GENMASK(3, 0)
+#define  SEC_ERROR_INT_RX_RAM_SEC_ERR_INT	GENMASK(7, 4)
+#define  SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT	GENMASK(11, 8)
+#define  SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT	GENMASK(15, 12)
+#define MC_SEC_ERROR_INT_MASK			0x2c
+#define MC_DED_ERROR_INT			0x30
+#define  DED_ERROR_INT_TX_RAM_DED_ERR_INT	GENMASK(3, 0)
+#define  DED_ERROR_INT_RX_RAM_DED_ERR_INT	GENMASK(7, 4)
+#define  DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT	GENMASK(11, 8)
+#define  DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT	GENMASK(15, 12)
+#define MC_DED_ERROR_INT_MASK			0x34
+#define MC_ECC_CONTROL				0x38
+#define  ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS	BIT(27)
+#define  ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS	BIT(26)
+#define  ECC_CONTROL_RX_RAM_ECC_BYPASS		BIT(25)
+#define  ECC_CONTROL_TX_RAM_ECC_BYPASS		BIT(24)
+#define MC_LTSSM_STATE				0x5c
+#define  LTSSM_L0_STATE				0x10
+#define MC_PCIE_EVENT_INT			0x14c
+#define  PCIE_EVENT_INT_L2_EXIT_INT		BIT(0)
+#define  PCIE_EVENT_INT_HOTRST_EXIT_INT		BIT(1)
+#define  PCIE_EVENT_INT_DLUP_EXIT_INT		BIT(2)
+#define  PCIE_EVENT_INT_L2_EXIT_INT_MASK	BIT(16)
+#define  PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK	BIT(17)
+#define  PCIE_EVENT_INT_DLUP_EXIT_INT_MASK	BIT(18)
+
+/* PCIe Bridge Phy Regs */
+#define MC_PCIE_PCI_IDS_DW1			0x9c
+
+/* PCIe Config space MSI capability structure */
+#define MC_MSI_CAP_CTRL_OFFSET			0xe0u
+#define  MC_MSI_MAX_Q_AVAIL			(MC_NUM_MSI_IRQS_CODED << 1)
+#define  MC_MSI_Q_SIZE				(MC_NUM_MSI_IRQS_CODED << 4)
+
+#define MC_IMASK_LOCAL				0x180
+#define  PCIE_LOCAL_INT_ENABLE			0x0f000000u
+#define  PCI_INTS				0x0f000000u
+#define  PM_MSI_INT_SHIFT			24
+#define  PCIE_ENABLE_MSI			0x10000000u
+#define  MSI_INT				0x10000000u
+#define  MSI_INT_SHIFT				28
+#define MC_ISTATUS_LOCAL			0x184
+#define MC_IMASK_HOST				0x188
+#define MC_ISTATUS_HOST				0x18c
+#define MC_MSI_ADDR				0x190
+#define MC_ISTATUS_MSI				0x194
+
+/* PCIe Master table init defines */
+#define MC_ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
+#define  ATR0_PCIE_ATR_SIZE			0x1f
+#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
+#define MC_ATR0_PCIE_WIN0_SRC_ADDR		0x604u
+#define MC_ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
+#define MC_ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
+#define MC_ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
+
+/* PCIe AXI slave table init defines */
+#define MC_ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
+#define  ATR_SIZE_SHIFT				1
+#define  ATR_IMPL_ENABLE			1
+#define MC_ATR0_AXI4_SLV0_SRC_ADDR		0x804u
+#define MC_ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
+#define MC_ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
+#define MC_ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
+#define  PCIE_TX_RX_INTERFACE			0x00000000u
+#define  PCIE_CONFIG_INTERFACE			0x00000001u
+
+#define ATR_ENTRY_SIZE				32
+
+struct mc_msi {
+	struct mutex lock;		/* Protect used bitmap */
+	struct irq_domain *msi_domain;
+	struct irq_domain *dev_domain;
+	u32 num_vectors;
+	u64 vector_phy;
+	DECLARE_BITMAP(used, MC_NUM_MSI_IRQS);
+};
+
+struct mc_port {
+	void __iomem *axi_base_addr;
+	struct device *dev;
+	struct irq_domain *intx_domain;
+	raw_spinlock_t intx_mask_lock;
+	struct mc_msi msi;
+};
+
+static char poss_clks[][5] = { "fic0", "fic1", "fic2", "fic3" };
+
+static void mc_pcie_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct mc_port *port = irq_desc_get_handler_data(desc);
+	struct device *dev = port->dev;
+	struct mc_msi *msi = &port->msi;
+	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
+	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE1_CTRL_ADDR;
+	u32 status;
+	unsigned long intx_status;
+	unsigned long msi_status;
+	u32 bit;
+	u32 virq;
+
+	/*
+	 * The core provides a single interrupt for both INTx/MSI messages.
+	 * So we'll read both INTx and MSI status.
+	 */
+	chained_irq_enter(chip, desc);
+
+	status = readl_relaxed(ctrl_base_addr + MC_SEC_ERROR_INT);
+	if (status)
+		writel_relaxed(status, ctrl_base_addr + MC_SEC_ERROR_INT);
+
+	status = readl_relaxed(ctrl_base_addr + MC_DED_ERROR_INT);
+	if (status)
+		writel_relaxed(status, ctrl_base_addr + MC_DED_ERROR_INT);
+
+	/* Acknowledge L2 exit, hot reset exit, and DLUp exit interrrupts */
+	status = readl_relaxed(ctrl_base_addr + MC_PCIE_EVENT_INT);
+	if (status & GENMASK(15, 0))
+		writel_relaxed(status, ctrl_base_addr + MC_PCIE_EVENT_INT);
+
+	status = readl_relaxed(bridge_base_addr + MC_ISTATUS_HOST);
+	if (status)
+		writel_relaxed(status, ctrl_base_addr + MC_ISTATUS_HOST);
+
+	status = readl_relaxed(bridge_base_addr + MC_ISTATUS_LOCAL);
+	while (status & (PCI_INTS | MSI_INT)) {
+		intx_status = (status & PCI_INTS) >> PM_MSI_INT_SHIFT;
+		for_each_set_bit(bit, &intx_status, PCI_NUM_INTX) {
+			virq = irq_find_mapping(port->intx_domain, bit + 1);
+			if (virq)
+				generic_handle_irq(virq);
+			else
+				dev_err_ratelimited(dev, "bad INTx IRQ %d\n", bit);
+
+			/* Clear that interrupt bit */
+			writel_relaxed(1 << (bit + PM_MSI_INT_SHIFT), bridge_base_addr +
+				       MC_ISTATUS_LOCAL);
+		}
+
+		msi_status = (status & MSI_INT);
+		if (msi_status) {
+			msi_status = readl_relaxed(bridge_base_addr + MC_ISTATUS_MSI);
+			for_each_set_bit(bit, &msi_status, msi->num_vectors) {
+				virq = irq_find_mapping(msi->dev_domain, bit);
+				if (virq)
+					generic_handle_irq(virq);
+				else
+					dev_err_ratelimited(dev, "bad MSI IRQ %d\n", bit);
+
+				/* Clear that MSI interrupt bit */
+				writel_relaxed((1 << bit), bridge_base_addr + MC_ISTATUS_MSI);
+			}
+			/* Clear the ISTATUS MSI bit */
+			writel_relaxed(1 << MSI_INT_SHIFT, bridge_base_addr + MC_ISTATUS_LOCAL);
+		}
+
+		status = readl_relaxed(bridge_base_addr + MC_ISTATUS_LOCAL);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void mc_pcie_enable_msi(struct mc_port *port, void __iomem *base)
+{
+	struct mc_msi *msi = &port->msi;
+	u32 cap_offset = MC_MSI_CAP_CTRL_OFFSET;
+	u16 msg_ctrl = readw_relaxed(base + cap_offset + PCI_MSI_FLAGS);
+
+	msg_ctrl |= PCI_MSI_FLAGS_ENABLE;
+	msg_ctrl &= ~PCI_MSI_FLAGS_QMASK;
+	msg_ctrl |= MC_MSI_MAX_Q_AVAIL;
+	msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
+	msg_ctrl |= MC_MSI_Q_SIZE;
+	msg_ctrl |= PCI_MSI_FLAGS_64BIT;
+
+	writew_relaxed(msg_ctrl, base + cap_offset + PCI_MSI_FLAGS);
+
+	writel_relaxed(lower_32_bits(msi->vector_phy), base + cap_offset + PCI_MSI_ADDRESS_LO);
+	writel_relaxed(upper_32_bits(msi->vector_phy), base + cap_offset + PCI_MSI_ADDRESS_HI);
+}
+
+static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct mc_port *port = irq_data_get_irq_chip_data(data);
+	phys_addr_t addr = port->msi.vector_phy;
+
+	msg->address_lo = lower_32_bits(addr);
+	msg->address_hi = upper_32_bits(addr);
+	msg->data = data->hwirq;
+
+	dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n", (int)data->hwirq,
+		msg->address_hi, msg->address_lo);
+}
+
+static int mc_msi_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip mc_msi_bottom_irq_chip = {
+	.name = "Microchip MSI",
+	.irq_compose_msi_msg = mc_compose_msi_msg,
+	.irq_set_affinity = mc_msi_set_affinity,
+};
+
+static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *args)
+{
+	struct mc_port *port = domain->host_data;
+	struct mc_msi *msi = &port->msi;
+	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
+	unsigned long bit;
+	u32 reg;
+
+	WARN_ON(nr_irqs != 1);
+	mutex_lock(&msi->lock);
+	bit = find_first_zero_bit(msi->used, msi->num_vectors);
+	if (bit >= msi->num_vectors) {
+		mutex_unlock(&msi->lock);
+		return -ENOSPC;
+	}
+
+	set_bit(bit, msi->used);
+
+	irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip, domain->host_data,
+			    handle_simple_irq, NULL, NULL);
+
+	/* Enable MSI interrupts */
+	reg = readl_relaxed(bridge_base_addr + MC_IMASK_LOCAL);
+	reg |= PCIE_ENABLE_MSI;
+	writel_relaxed(reg, bridge_base_addr + MC_IMASK_LOCAL);
+
+	mutex_unlock(&msi->lock);
+
+	return 0;
+}
+
+static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct mc_port *port = irq_data_get_irq_chip_data(d);
+	struct mc_msi *msi = &port->msi;
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
+	.alloc	= mc_irq_msi_domain_alloc,
+	.free	= mc_irq_msi_domain_free,
+};
+
+static struct irq_chip mc_msi_irq_chip = {
+	.name = "Microchip PCIe MSI",
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static struct msi_domain_info mc_msi_domain_info = {
+	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_PCI_MSIX),
+	.chip = &mc_msi_irq_chip,
+};
+
+static int mc_allocate_msi_domains(struct mc_port *port)
+{
+	struct device *dev = port->dev;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct mc_msi *msi = &port->msi;
+
+	mutex_init(&port->msi.lock);
+
+	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors, &msi_domain_ops, port);
+	if (!msi->dev_domain) {
+		dev_err(dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode, &mc_msi_domain_info, msi->dev_domain);
+	if (!msi->msi_domain) {
+		dev_err(dev, "failed to create MSI domain\n");
+		irq_domain_remove(msi->dev_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void mc_mask_intx_irq(struct irq_data *data)
+{
+	struct mc_port *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->intx_mask_lock, flags);
+	val = readl_relaxed(bridge_base_addr + MC_IMASK_LOCAL);
+	val &= ~PCIE_LOCAL_INT_ENABLE;
+	writel_relaxed(val, bridge_base_addr + MC_IMASK_LOCAL);
+	raw_spin_unlock_irqrestore(&port->intx_mask_lock, flags);
+}
+
+static void mc_unmask_intx_irq(struct irq_data *data)
+{
+	struct mc_port *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->intx_mask_lock, flags);
+	val = readl_relaxed(bridge_base_addr + MC_IMASK_LOCAL);
+	val |= PCIE_LOCAL_INT_ENABLE;
+	writel_relaxed(val, bridge_base_addr + MC_IMASK_LOCAL);
+	raw_spin_unlock_irqrestore(&port->intx_mask_lock, flags);
+}
+
+static struct irq_chip mc_intx_irq_chip = {
+	.name = "Microchip PCIe INTx",
+	.irq_mask = mc_mask_intx_irq,
+	.irq_unmask = mc_unmask_intx_irq,
+};
+
+static int mc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			    irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &mc_intx_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = mc_pcie_intx_map,
+};
+
+static int mc_pcie_init_irq_domains(struct mc_port *port)
+{
+	struct device *dev = port->dev;
+	struct device_node *node = dev->of_node;
+
+	port->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX, &intx_domain_ops, port);
+	if (!port->intx_domain) {
+		dev_err(dev, "failed to get an INTx IRQ domain\n");
+		return -ENOMEM;
+	}
+	raw_spin_lock_init(&port->intx_mask_lock);
+
+	return mc_allocate_msi_domains(port);
+}
+
+static void mc_setup_window(void __iomem *bridge_base_addr, u32 index, phys_addr_t axi_addr,
+			    phys_addr_t pci_addr, size_t size)
+{
+	u32 atr_sz = ilog2(size) - 1;
+	u32 val;
+
+	if (index == 0)
+		val = PCIE_CONFIG_INTERFACE;
+	else
+		val = PCIE_TX_RX_INTERFACE;
+
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) + MC_ATR0_AXI4_SLV0_TRSL_PARAM);
+
+	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) | ATR_IMPL_ENABLE;
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       MC_ATR0_AXI4_SLV0_SRCADDR_PARAM);
+
+	val = upper_32_bits(axi_addr);
+
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       MC_ATR0_AXI4_SLV0_SRC_ADDR);
+
+	val = lower_32_bits(pci_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       MC_ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
+
+	val = upper_32_bits(pci_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       MC_ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
+
+	val = readl(bridge_base_addr + MC_ATR0_PCIE_WIN0_SRCADDR_PARAM);
+	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
+	writel(val, bridge_base_addr + MC_ATR0_PCIE_WIN0_SRCADDR_PARAM);
+	writel(0, bridge_base_addr + MC_ATR0_PCIE_WIN0_SRC_ADDR);
+}
+
+static int mc_setup_windows(struct platform_device *pdev, struct mc_port *port)
+{
+	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
+	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
+	struct resource_entry *entry;
+	u64 pci_addr;
+	u32 index = 1;
+
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		if (resource_type(entry->res) == IORESOURCE_MEM) {
+			pci_addr = entry->res->start - entry->offset;
+			mc_setup_window(bridge_base_addr, index, entry->res->start,
+					pci_addr, resource_size(entry->res));
+			index++;
+		}
+	}
+
+	return 0;
+}
+
+static inline struct clk *mc_pcie_init_clk(struct device *dev, const char *id)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = devm_clk_get_optional(dev, id);
+	if (IS_ERR(clk))
+		return clk;
+	if (!clk)
+		return clk;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare, clk);
+
+	return clk;
+}
+
+static int mc_pcie_init_clks(struct device *dev)
+{
+	struct clk *fic;
+	int i;
+
+	/*
+	 * PCIe may be clocked via Fabric Interface
+	 * using between 1 and 4 clocks. Scan DT for
+	 * clocks and enable them if present
+	 */
+	for (i = 0; i < ARRAY_SIZE(poss_clks); i++) {
+		fic = mc_pcie_init_clk(dev, poss_clks[i]);
+		if (IS_ERR(fic))
+			return PTR_ERR(fic);
+	}
+
+	return 0;
+}
+
+static int mc_platform_init(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mc_port *port;
+	void __iomem *bridge_base_addr;
+	void __iomem *ctrl_base_addr;
+	int ret;
+	int irq;
+	u32 val;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+	port->dev = dev;
+
+	ret = mc_pcie_init_clks(dev);
+	if (ret) {
+		dev_err(dev, "failed to get clock resources, error %d\n", ret);
+		return -ENODEV;
+	}
+
+	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(port->axi_base_addr))
+		return PTR_ERR(port->axi_base_addr);
+
+	bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
+	ctrl_base_addr = port->axi_base_addr + MC_PCIE1_CTRL_ADDR;
+
+	port->msi.vector_phy = MC_MSI_ADDR;
+	port->msi.num_vectors = MC_NUM_MSI_IRQS;
+	ret = mc_pcie_init_irq_domains(port);
+	if (ret) {
+		dev_err(dev, "failed creating IRQ domains\n");
+		return ret;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "unable to request IRQ%d\n", irq);
+		return -ENODEV;
+	}
+
+	irq_set_chained_handler_and_data(irq, mc_pcie_isr, port);
+
+	/* Hardware doesn't setup MSI by default */
+	mc_pcie_enable_msi(port, cfg->win);
+
+	val = PCIE_ENABLE_MSI | PCIE_LOCAL_INT_ENABLE;
+	writel_relaxed(val, bridge_base_addr + MC_IMASK_LOCAL);
+
+	val = readl_relaxed(bridge_base_addr + MC_LTSSM_STATE);
+	val |= LTSSM_L0_STATE;
+	writel_relaxed(val, bridge_base_addr + MC_LTSSM_STATE);
+
+	val = ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS | ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS |
+	      ECC_CONTROL_RX_RAM_ECC_BYPASS | ECC_CONTROL_TX_RAM_ECC_BYPASS;
+	writel_relaxed(val, ctrl_base_addr + MC_ECC_CONTROL);
+
+	val = PCIE_EVENT_INT_L2_EXIT_INT | PCIE_EVENT_INT_HOTRST_EXIT_INT |
+	      PCIE_EVENT_INT_DLUP_EXIT_INT | PCIE_EVENT_INT_L2_EXIT_INT_MASK |
+	      PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK | PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
+	writel_relaxed(val, ctrl_base_addr + MC_PCIE_EVENT_INT);
+
+	val = SEC_ERROR_INT_TX_RAM_SEC_ERR_INT | SEC_ERROR_INT_RX_RAM_SEC_ERR_INT |
+	      SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT | SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT;
+	writel_relaxed(val, ctrl_base_addr + MC_SEC_ERROR_INT);
+	writel_relaxed(val, ctrl_base_addr + MC_SEC_ERROR_INT_MASK);
+
+	val = DED_ERROR_INT_TX_RAM_DED_ERR_INT | DED_ERROR_INT_RX_RAM_DED_ERR_INT |
+	      DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT | DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT;
+	writel_relaxed(val, ctrl_base_addr + MC_DED_ERROR_INT);
+	writel_relaxed(val, ctrl_base_addr + MC_DED_ERROR_INT_MASK);
+
+	writel_relaxed(0, bridge_base_addr + MC_IMASK_LOCAL);
+	writel_relaxed(GENMASK(31, 0), bridge_base_addr + MC_ISTATUS_LOCAL);
+	writel_relaxed(0, bridge_base_addr + MC_IMASK_HOST);
+	writel_relaxed(GENMASK(31, 0), bridge_base_addr + MC_ISTATUS_HOST);
+
+	/* Configure Address Translation Table 0 for PCIe config space */
+	mc_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff, cfg->res.start,
+			resource_size(&cfg->res));
+
+	return mc_setup_windows(pdev, port);
+}
+
+static const struct pci_ecam_ops mc_ecam_ops = {
+	.bus_shift = 20,
+	.init = mc_platform_init,
+	.pci_ops = {
+		.map_bus = pci_ecam_map_bus,
+		.read = pci_generic_config_read,
+		.write = pci_generic_config_write,
+	}
+};
+
+static const struct of_device_id mc_pcie_of_match[] = {
+	{
+		.compatible = "microchip,pcie-host-1.0",
+		.data = &mc_ecam_ops,
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mc_pcie_of_match)
+
+static struct platform_driver mc_pcie_driver = {
+	.probe = pci_host_common_probe,
+	.driver = {
+		.name = "microchip-pcie",
+		.of_match_table = mc_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+builtin_platform_driver(mc_pcie_driver);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Microchip PCIe host controller driver");
+MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
-- 
2.25.1

