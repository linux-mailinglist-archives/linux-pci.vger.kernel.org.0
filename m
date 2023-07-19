Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703FE7592B4
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGSKVN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 06:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGSKVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 06:21:09 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B131BEF;
        Wed, 19 Jul 2023 03:21:04 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9CC7D24E263;
        Wed, 19 Jul 2023 18:21:03 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:03 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:02 +0800
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
Subject: [PATCH v1 4/9] PCI: microchip: Move PCIe driver to PLDA directory
Date:   Wed, 19 Jul 2023 18:20:52 +0800
Message-ID: <20230719102057.22329-5-minda.chen@starfivetech.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move Microchip specific platform codes to PLDA directory.
Including clock init, interrupt event handle and platform
init codes.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 MAINTAINERS                                   |   4 +-
 drivers/pci/controller/Kconfig                |   8 -
 drivers/pci/controller/Makefile               |   1 -
 drivers/pci/controller/plda/Kconfig           |  10 +-
 drivers/pci/controller/plda/Makefile          |   1 +
 .../{ => plda}/pcie-microchip-host.c          | 594 ++----------------
 6 files changed, 55 insertions(+), 563 deletions(-)
 rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (50%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b3c4d8808ae..f02618c2bdf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16503,7 +16503,7 @@ M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/microchip*
-F:	drivers/pci/controller/*microchip*
+F:	drivers/pci/controller/plda/*microchip*
 
 PCIE DRIVER FOR QUALCOMM MSM
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
@@ -18287,7 +18287,7 @@ F:	drivers/char/hw_random/mpfs-rng.c
 F:	drivers/clk/microchip/clk-mpfs*.c
 F:	drivers/i2c/busses/i2c-microchip-corei2c.c
 F:	drivers/mailbox/mailbox-mpfs.c
-F:	drivers/pci/controller/pcie-microchip-host.c
+F:	drivers/pci/controller/plda/pcie-microchip-host.c
 F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/reset/reset-mpfs.c
 F:	drivers/rtc/rtc-mpfs.c
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index a106dabcb8dc..107cdb69e15c 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -216,14 +216,6 @@ config PCIE_MT7621
 	help
 	  This selects a driver for the MediaTek MT7621 PCIe Controller.
 
-config PCIE_MICROCHIP_HOST
-	bool "Microchip AXI PCIe controller"
-	depends on PCI_MSI && OF
-	select PCI_HOST_COMMON
-	help
-	  Say Y here if you want kernel to support the Microchip AXI PCIe
-	  Host Bridge driver.
-
 config PCI_HYPERV_INTERFACE
 	tristate "Microsoft Hyper-V PCI Interface"
 	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index aa0a691ebcbc..93236dc97b21 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
 obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
 obj-$(CONFIG_PCIE_MEDIATEK_GEN3) += pcie-mediatek-gen3.o
-obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
 obj-$(CONFIG_VMD) += vmd.o
 obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
 obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
index 37e17326671b..fb274976b84b 100644
--- a/drivers/pci/controller/plda/Kconfig
+++ b/drivers/pci/controller/plda/Kconfig
@@ -4,8 +4,16 @@ menu "PLDA PCIe controllers support"
 	depends on PCI
 
 config PCIE_PLDA_HOST
-	bool "PLDA PCIe host controller"
+	bool
 	depends on OF && PCI_MSI
 	select IRQ_DOMAIN
 
+config PCIE_MICROCHIP_HOST
+	bool "Microchip AXI PCIe controller"
+	select PCI_HOST_COMMON
+	select PCIE_PLDA_HOST
+	help
+	  Say Y here if you want kernel to support the Microchip AXI PCIe
+	  Host Bridge driver.
+
 endmenu
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
index 79dbae655c2b..4340ab007f44 100644
--- a/drivers/pci/controller/plda/Makefile
+++ b/drivers/pci/controller/plda/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
+obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
similarity index 50%
rename from drivers/pci/controller/pcie-microchip-host.c
rename to drivers/pci/controller/plda/pcie-microchip-host.c
index 5e710e485464..4ff3d956c7f8 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -17,11 +17,8 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
-#include "../pci.h"
-
-/* Number of MSI IRQs */
-#define MC_NUM_MSI_IRQS				32
-#define MC_NUM_MSI_IRQS_CODED			5
+#include "../../pci.h"
+#include "pcie-plda.h"
 
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
@@ -29,6 +26,7 @@
 
 #define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
 #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
+#define MC_PCIE_CTRL_ADDR_OFFSET		0x00002000u
 
 /* PCIe Controller Phy Regs */
 #define SEC_ERROR_CNT				0x20
@@ -82,86 +80,6 @@
 #define  PCIE_EVENT_INT_ENB_SHIFT		16
 #define  NUM_PCIE_EVENTS			(3)
 
-/* PCIe Bridge Phy Regs */
-#define PCIE_PCI_IDS_DW1			0x9c
-
-/* PCIe Config space MSI capability structure */
-#define MC_MSI_CAP_CTRL_OFFSET			0xe0u
-#define  MC_MSI_MAX_Q_AVAIL			(MC_NUM_MSI_IRQS_CODED << 1)
-#define  MC_MSI_Q_SIZE				(MC_NUM_MSI_IRQS_CODED << 4)
-
-#define IMASK_LOCAL				0x180
-#define  DMA_END_ENGINE_0_MASK			0x00000000u
-#define  DMA_END_ENGINE_0_SHIFT			0
-#define  DMA_END_ENGINE_1_MASK			0x00000000u
-#define  DMA_END_ENGINE_1_SHIFT			1
-#define  DMA_ERROR_ENGINE_0_MASK		0x00000100u
-#define  DMA_ERROR_ENGINE_0_SHIFT		8
-#define  DMA_ERROR_ENGINE_1_MASK		0x00000200u
-#define  DMA_ERROR_ENGINE_1_SHIFT		9
-#define  A_ATR_EVT_POST_ERR_MASK		0x00010000u
-#define  A_ATR_EVT_POST_ERR_SHIFT		16
-#define  A_ATR_EVT_FETCH_ERR_MASK		0x00020000u
-#define  A_ATR_EVT_FETCH_ERR_SHIFT		17
-#define  A_ATR_EVT_DISCARD_ERR_MASK		0x00040000u
-#define  A_ATR_EVT_DISCARD_ERR_SHIFT		18
-#define  A_ATR_EVT_DOORBELL_MASK		0x00000000u
-#define  A_ATR_EVT_DOORBELL_SHIFT		19
-#define  P_ATR_EVT_POST_ERR_MASK		0x00100000u
-#define  P_ATR_EVT_POST_ERR_SHIFT		20
-#define  P_ATR_EVT_FETCH_ERR_MASK		0x00200000u
-#define  P_ATR_EVT_FETCH_ERR_SHIFT		21
-#define  P_ATR_EVT_DISCARD_ERR_MASK		0x00400000u
-#define  P_ATR_EVT_DISCARD_ERR_SHIFT		22
-#define  P_ATR_EVT_DOORBELL_MASK		0x00000000u
-#define  P_ATR_EVT_DOORBELL_SHIFT		23
-#define  PM_MSI_INT_INTA_MASK			0x01000000u
-#define  PM_MSI_INT_INTA_SHIFT			24
-#define  PM_MSI_INT_INTB_MASK			0x02000000u
-#define  PM_MSI_INT_INTB_SHIFT			25
-#define  PM_MSI_INT_INTC_MASK			0x04000000u
-#define  PM_MSI_INT_INTC_SHIFT			26
-#define  PM_MSI_INT_INTD_MASK			0x08000000u
-#define  PM_MSI_INT_INTD_SHIFT			27
-#define  PM_MSI_INT_INTX_MASK			0x0f000000u
-#define  PM_MSI_INT_INTX_SHIFT			24
-#define  PM_MSI_INT_MSI_MASK			0x10000000u
-#define  PM_MSI_INT_MSI_SHIFT			28
-#define  PM_MSI_INT_AER_EVT_MASK		0x20000000u
-#define  PM_MSI_INT_AER_EVT_SHIFT		29
-#define  PM_MSI_INT_EVENTS_MASK			0x40000000u
-#define  PM_MSI_INT_EVENTS_SHIFT		30
-#define  PM_MSI_INT_SYS_ERR_MASK		0x80000000u
-#define  PM_MSI_INT_SYS_ERR_SHIFT		31
-#define  NUM_LOCAL_EVENTS			15
-#define ISTATUS_LOCAL				0x184
-#define IMASK_HOST				0x188
-#define ISTATUS_HOST				0x18c
-#define MSI_ADDR				0x190
-#define ISTATUS_MSI				0x194
-
-/* PCIe Master table init defines */
-#define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
-#define  ATR0_PCIE_ATR_SIZE			0x25
-#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
-#define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
-#define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
-#define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
-#define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
-
-/* PCIe AXI slave table init defines */
-#define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
-#define  ATR_SIZE_SHIFT				1
-#define  ATR_IMPL_ENABLE			1
-#define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
-#define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
-#define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
-#define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
-#define  PCIE_TX_RX_INTERFACE			0x00000000u
-#define  PCIE_CONFIG_INTERFACE			0x00000001u
-
-#define ATR_ENTRY_SIZE				32
-
 #define EVENT_PCIE_L2_EXIT			0
 #define EVENT_PCIE_HOTRST_EXIT			1
 #define EVENT_PCIE_DLUP_EXIT			2
@@ -205,7 +123,7 @@
 	[EVENT_LOCAL_ ## x] = { __stringify(x), s }
 
 #define PCIE_EVENT(x) \
-	.base = MC_PCIE_CTRL_ADDR, \
+	.base = MC_PCIE_CTRL_ADDR_OFFSET, \
 	.offset = PCIE_EVENT_INT, \
 	.mask_offset = PCIE_EVENT_INT, \
 	.mask_high = 1, \
@@ -213,7 +131,7 @@
 	.enb_mask = PCIE_EVENT_INT_ENB_MASK
 
 #define SEC_EVENT(x) \
-	.base = MC_PCIE_CTRL_ADDR, \
+	.base = MC_PCIE_CTRL_ADDR_OFFSET, \
 	.offset = SEC_ERROR_INT, \
 	.mask_offset = SEC_ERROR_INT_MASK, \
 	.mask = SEC_ERROR_INT_ ## x ## _INT, \
@@ -221,7 +139,7 @@
 	.enb_mask = 0
 
 #define DED_EVENT(x) \
-	.base = MC_PCIE_CTRL_ADDR, \
+	.base = MC_PCIE_CTRL_ADDR_OFFSET, \
 	.offset = DED_ERROR_INT, \
 	.mask_offset = DED_ERROR_INT_MASK, \
 	.mask_high = 1, \
@@ -229,7 +147,7 @@
 	.enb_mask = 0
 
 #define LOCAL_EVENT(x) \
-	.base = MC_PCIE_BRIDGE_ADDR, \
+	.base = 0, \
 	.offset = ISTATUS_LOCAL, \
 	.mask_offset = IMASK_LOCAL, \
 	.mask_high = 0, \
@@ -253,22 +171,9 @@ struct event_map {
 	u32 event_bit;
 };
 
-struct mc_msi {
-	struct mutex lock;		/* Protect used bitmap */
-	struct irq_domain *msi_domain;
-	struct irq_domain *dev_domain;
-	u32 num_vectors;
-	u64 vector_phy;
-	DECLARE_BITMAP(used, MC_NUM_MSI_IRQS);
-};
-
 struct mc_pcie {
+	struct plda_pcie plda;
 	void __iomem *axi_base_addr;
-	struct device *dev;
-	struct irq_domain *intx_domain;
-	struct irq_domain *event_domain;
-	raw_spinlock_t lock;
-	struct mc_msi msi;
 };
 
 struct cause {
@@ -382,275 +287,6 @@ static struct {
 
 static char poss_clks[][5] = { "fic0", "fic1", "fic2", "fic3" };
 
-static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *base)
-{
-	struct mc_msi *msi = &port->msi;
-	u32 cap_offset = MC_MSI_CAP_CTRL_OFFSET;
-	u16 msg_ctrl = readw_relaxed(base + cap_offset + PCI_MSI_FLAGS);
-
-	msg_ctrl |= PCI_MSI_FLAGS_ENABLE;
-	msg_ctrl &= ~PCI_MSI_FLAGS_QMASK;
-	msg_ctrl |= MC_MSI_MAX_Q_AVAIL;
-	msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
-	msg_ctrl |= MC_MSI_Q_SIZE;
-	msg_ctrl |= PCI_MSI_FLAGS_64BIT;
-
-	writew_relaxed(msg_ctrl, base + cap_offset + PCI_MSI_FLAGS);
-
-	writel_relaxed(lower_32_bits(msi->vector_phy),
-		       base + cap_offset + PCI_MSI_ADDRESS_LO);
-	writel_relaxed(upper_32_bits(msi->vector_phy),
-		       base + cap_offset + PCI_MSI_ADDRESS_HI);
-}
-
-static void mc_handle_msi(struct irq_desc *desc)
-{
-	struct mc_pcie *port = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct device *dev = port->dev;
-	struct mc_msi *msi = &port->msi;
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	unsigned long status;
-	u32 bit;
-	int ret;
-
-	chained_irq_enter(chip, desc);
-
-	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
-	if (status & PM_MSI_INT_MSI_MASK) {
-		writel_relaxed(status & PM_MSI_INT_MSI_MASK, bridge_base_addr + ISTATUS_LOCAL);
-		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
-		for_each_set_bit(bit, &status, msi->num_vectors) {
-			ret = generic_handle_domain_irq(msi->dev_domain, bit);
-			if (ret)
-				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
-						    bit);
-		}
-	}
-
-	chained_irq_exit(chip, desc);
-}
-
-static void mc_msi_bottom_irq_ack(struct irq_data *data)
-{
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	u32 bitpos = data->hwirq;
-
-	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
-}
-
-static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	phys_addr_t addr = port->msi.vector_phy;
-
-	msg->address_lo = lower_32_bits(addr);
-	msg->address_hi = upper_32_bits(addr);
-	msg->data = data->hwirq;
-
-	dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n",
-		(int)data->hwirq, msg->address_hi, msg->address_lo);
-}
-
-static int mc_msi_set_affinity(struct irq_data *irq_data,
-			       const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
-static struct irq_chip mc_msi_bottom_irq_chip = {
-	.name = "Microchip MSI",
-	.irq_ack = mc_msi_bottom_irq_ack,
-	.irq_compose_msi_msg = mc_compose_msi_msg,
-	.irq_set_affinity = mc_msi_set_affinity,
-};
-
-static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-				   unsigned int nr_irqs, void *args)
-{
-	struct mc_pcie *port = domain->host_data;
-	struct mc_msi *msi = &port->msi;
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	unsigned long bit;
-	u32 val;
-
-	mutex_lock(&msi->lock);
-	bit = find_first_zero_bit(msi->used, msi->num_vectors);
-	if (bit >= msi->num_vectors) {
-		mutex_unlock(&msi->lock);
-		return -ENOSPC;
-	}
-
-	set_bit(bit, msi->used);
-
-	irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip,
-			    domain->host_data, handle_edge_irq, NULL, NULL);
-
-	/* Enable MSI interrupts */
-	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
-	val |= PM_MSI_INT_MSI_MASK;
-	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
-
-	mutex_unlock(&msi->lock);
-
-	return 0;
-}
-
-static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-				   unsigned int nr_irqs)
-{
-	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct mc_pcie *port = irq_data_get_irq_chip_data(d);
-	struct mc_msi *msi = &port->msi;
-
-	mutex_lock(&msi->lock);
-
-	if (test_bit(d->hwirq, msi->used))
-		__clear_bit(d->hwirq, msi->used);
-	else
-		dev_err(port->dev, "trying to free unused MSI%lu\n", d->hwirq);
-
-	mutex_unlock(&msi->lock);
-}
-
-static const struct irq_domain_ops msi_domain_ops = {
-	.alloc	= mc_irq_msi_domain_alloc,
-	.free	= mc_irq_msi_domain_free,
-};
-
-static struct irq_chip mc_msi_irq_chip = {
-	.name = "Microchip PCIe MSI",
-	.irq_ack = irq_chip_ack_parent,
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
-};
-
-static struct msi_domain_info mc_msi_domain_info = {
-	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_PCI_MSIX),
-	.chip = &mc_msi_irq_chip,
-};
-
-static int mc_allocate_msi_domains(struct mc_pcie *port)
-{
-	struct device *dev = port->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
-	struct mc_msi *msi = &port->msi;
-
-	mutex_init(&port->msi.lock);
-
-	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors,
-						&msi_domain_ops, port);
-	if (!msi->dev_domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-
-	msi->msi_domain = pci_msi_create_irq_domain(fwnode, &mc_msi_domain_info,
-						    msi->dev_domain);
-	if (!msi->msi_domain) {
-		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(msi->dev_domain);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void mc_handle_intx(struct irq_desc *desc)
-{
-	struct mc_pcie *port = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct device *dev = port->dev;
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	unsigned long status;
-	u32 bit;
-	int ret;
-
-	chained_irq_enter(chip, desc);
-
-	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
-	if (status & PM_MSI_INT_INTX_MASK) {
-		status &= PM_MSI_INT_INTX_MASK;
-		status >>= PM_MSI_INT_INTX_SHIFT;
-		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
-			ret = generic_handle_domain_irq(port->intx_domain, bit);
-			if (ret)
-				dev_err_ratelimited(dev, "bad INTx IRQ %d\n",
-						    bit);
-		}
-	}
-
-	chained_irq_exit(chip, desc);
-}
-
-static void mc_ack_intx_irq(struct irq_data *data)
-{
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
-
-	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
-}
-
-static void mc_mask_intx_irq(struct irq_data *data)
-{
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	unsigned long flags;
-	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
-	u32 val;
-
-	raw_spin_lock_irqsave(&port->lock, flags);
-	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
-	val &= ~mask;
-	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
-	raw_spin_unlock_irqrestore(&port->lock, flags);
-}
-
-static void mc_unmask_intx_irq(struct irq_data *data)
-{
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	unsigned long flags;
-	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
-	u32 val;
-
-	raw_spin_lock_irqsave(&port->lock, flags);
-	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
-	val |= mask;
-	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
-	raw_spin_unlock_irqrestore(&port->lock, flags);
-}
-
-static struct irq_chip mc_intx_irq_chip = {
-	.name = "Microchip PCIe INTx",
-	.irq_ack = mc_ack_intx_irq,
-	.irq_mask = mc_mask_intx_irq,
-	.irq_unmask = mc_unmask_intx_irq,
-};
-
-static int mc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-			    irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &mc_intx_irq_chip, handle_level_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops intx_domain_ops = {
-	.map = mc_pcie_intx_map,
-};
-
 static inline u32 reg_to_event(u32 reg, struct event_map field)
 {
 	return (reg & field.reg_mask) ? BIT(field.event_bit) : 0;
@@ -704,11 +340,10 @@ static u32 local_events(void __iomem *addr)
 	return val;
 }
 
-static u32 get_events(struct mc_pcie *port)
+static u32 get_events(struct plda_pcie *port)
 {
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	void __iomem *ctrl_base_addr = port->bridge_addr + MC_PCIE_CTRL_ADDR_OFFSET;
 	u32 events = 0;
 
 	events |= pcie_events(ctrl_base_addr + PCIE_EVENT_INT);
@@ -721,7 +356,7 @@ static u32 get_events(struct mc_pcie *port)
 
 static irqreturn_t mc_event_handler(int irq, void *dev_id)
 {
-	struct mc_pcie *port = dev_id;
+	struct plda_pcie *port = dev_id;
 	struct device *dev = port->dev;
 	struct irq_data *data;
 
@@ -735,31 +370,14 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void mc_handle_event(struct irq_desc *desc)
-{
-	struct mc_pcie *port = irq_desc_get_handler_data(desc);
-	unsigned long events;
-	u32 bit;
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	chained_irq_enter(chip, desc);
-
-	events = get_events(port);
-
-	for_each_set_bit(bit, &events, NUM_EVENTS)
-		generic_handle_domain_irq(port->event_domain, bit);
-
-	chained_irq_exit(chip, desc);
-}
-
 static void mc_ack_event_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie *port = irq_data_get_irq_chip_data(data);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
 
-	addr = port->axi_base_addr + event_descs[event].base +
+	addr = port->bridge_addr + event_descs[event].base +
 		event_descs[event].offset;
 	mask = event_descs[event].mask;
 	mask |= event_descs[event].enb_mask;
@@ -769,13 +387,13 @@ static void mc_ack_event_irq(struct irq_data *data)
 
 static void mc_mask_event_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie *port = irq_data_get_irq_chip_data(data);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
 	u32 val;
 
-	addr = port->axi_base_addr + event_descs[event].base +
+	addr = port->bridge_addr + event_descs[event].base +
 		event_descs[event].mask_offset;
 	mask = event_descs[event].mask;
 	if (event_descs[event].enb_mask) {
@@ -799,13 +417,13 @@ static void mc_mask_event_irq(struct irq_data *data)
 
 static void mc_unmask_event_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie *port = irq_data_get_irq_chip_data(data);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
 	u32 val;
 
-	addr = port->axi_base_addr + event_descs[event].base +
+	addr = port->bridge_addr + event_descs[event].base +
 		event_descs[event].mask_offset;
 	mask = event_descs[event].mask;
 
@@ -887,123 +505,42 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
-static int mc_pcie_init_irq_domains(struct mc_pcie *port)
-{
-	struct device *dev = port->dev;
-	struct device_node *node = dev->of_node;
-	struct device_node *pcie_intc_node;
-
-	/* Setup INTx */
-	pcie_intc_node = of_get_next_child(node, NULL);
-	if (!pcie_intc_node) {
-		dev_err(dev, "failed to find PCIe Intc node\n");
-		return -EINVAL;
-	}
-
-	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
-						   &event_domain_ops, port);
-	if (!port->event_domain) {
-		dev_err(dev, "failed to get event domain\n");
-		of_node_put(pcie_intc_node);
-		return -ENOMEM;
-	}
-
-	irq_domain_update_bus_token(port->event_domain, DOMAIN_BUS_NEXUS);
-
-	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops, port);
-	if (!port->intx_domain) {
-		dev_err(dev, "failed to get an INTx IRQ domain\n");
-		of_node_put(pcie_intc_node);
-		return -ENOMEM;
-	}
-
-	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
-
-	of_node_put(pcie_intc_node);
-	raw_spin_lock_init(&port->lock);
-
-	return mc_allocate_msi_domains(port);
-}
-
-static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-				 phys_addr_t axi_addr, phys_addr_t pci_addr,
-				 size_t size)
-{
-	u32 atr_sz = ilog2(size) - 1;
-	u32 val;
-
-	if (index == 0)
-		val = PCIE_CONFIG_INTERFACE;
-	else
-		val = PCIE_TX_RX_INTERFACE;
-
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_PARAM);
-
-	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
-			    ATR_IMPL_ENABLE;
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
-
-	val = upper_32_bits(axi_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_SRC_ADDR);
-
-	val = lower_32_bits(pci_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
-
-	val = upper_32_bits(pci_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
-
-	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
-	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
-}
+static const struct plda_pcie_ops pcie_ops = {
+	.get_events = get_events,
+};
 
-static int mc_pcie_setup_windows(struct platform_device *pdev,
-				 struct mc_pcie *port)
+static int mc_request_evt_irq(struct plda_pcie *plda, int event_irq,
+			      int evt)
 {
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
-	struct resource_entry *entry;
-	u64 pci_addr;
-	u32 index = 1;
-
-	resource_list_for_each_entry(entry, &bridge->windows) {
-		if (resource_type(entry->res) == IORESOURCE_MEM) {
-			pci_addr = entry->res->start - entry->offset;
-			mc_pcie_setup_window(bridge_base_addr, index,
-					     entry->res->start, pci_addr,
-					     resource_size(entry->res));
-			index++;
-		}
-	}
+	struct device *dev = plda->dev;
 
-	return 0;
+	return devm_request_irq(dev, event_irq, mc_event_handler,
+				0, event_cause[evt].sym, plda);
 }
 
 static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	struct mc_pcie *port;
+	struct plda_pcie *plda;
 	void __iomem *bridge_base_addr;
 	void __iomem *ctrl_base_addr;
+	struct plda_evt evt = {&event_domain_ops, mc_request_evt_irq,
+			       EVENT_LOCAL_PM_MSI_INT_INTX,
+			       EVENT_LOCAL_PM_MSI_INT_MSI};
 	int ret;
-	int irq;
-	int i, intx_irq, msi_irq, event_irq;
 	u32 val;
-	int err;
 
 	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
-	port->dev = dev;
+
+	plda = &port->plda;
+	plda->dev = dev;
+	plda->ops = &pcie_ops;
+	plda->num_events = NUM_EVENTS;
 
 	ret = mc_pcie_init_clks(dev);
 	if (ret) {
@@ -1017,57 +554,12 @@ static int mc_platform_init(struct pci_config_window *cfg)
 
 	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
+	plda->bridge_addr = bridge_base_addr;
 
-	port->msi.vector_phy = MSI_ADDR;
-	port->msi.num_vectors = MC_NUM_MSI_IRQS;
-	ret = mc_pcie_init_irq_domains(port);
-	if (ret) {
-		dev_err(dev, "failed creating IRQ domains\n");
-		return ret;
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return -ENODEV;
-
-	for (i = 0; i < NUM_EVENTS; i++) {
-		event_irq = irq_create_mapping(port->event_domain, i);
-		if (!event_irq) {
-			dev_err(dev, "failed to map hwirq %d\n", i);
-			return -ENXIO;
-		}
-
-		err = devm_request_irq(dev, event_irq, mc_event_handler,
-				       0, event_cause[i].sym, port);
-		if (err) {
-			dev_err(dev, "failed to request IRQ %d\n", event_irq);
-			return err;
-		}
-	}
-
-	intx_irq = irq_create_mapping(port->event_domain,
-				      EVENT_LOCAL_PM_MSI_INT_INTX);
-	if (!intx_irq) {
-		dev_err(dev, "failed to map INTx interrupt\n");
-		return -ENXIO;
-	}
-
-	/* Plug the INTx chained handler */
-	irq_set_chained_handler_and_data(intx_irq, mc_handle_intx, port);
-
-	msi_irq = irq_create_mapping(port->event_domain,
-				     EVENT_LOCAL_PM_MSI_INT_MSI);
-	if (!msi_irq)
-		return -ENXIO;
-
-	/* Plug the MSI chained handler */
-	irq_set_chained_handler_and_data(msi_irq, mc_handle_msi, port);
-
-	/* Plug the main event chained handler */
-	irq_set_chained_handler_and_data(irq, mc_handle_event, port);
-
+	plda_set_default_msi(&plda->msi);
+	plda_pcie_init_irq(plda, pdev, &evt);
 	/* Hardware doesn't setup MSI by default */
-	mc_pcie_enable_msi(port, cfg->win);
+	plda_pcie_enable_msi(plda);
 
 	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
 	val |= PM_MSI_INT_INTX_MASK;
@@ -1100,10 +592,10 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 
 	/* Configure Address Translation Table 0 for PCIe config space */
-	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
-			     cfg->res.start, resource_size(&cfg->res));
+	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
+			       cfg->res.start, resource_size(&cfg->res));
 
-	return mc_pcie_setup_windows(pdev, port);
+	return plda_pcie_setup_iomems(&port->plda, bridge);
 }
 
 static const struct pci_ecam_ops mc_ecam_ops = {
-- 
2.17.1

