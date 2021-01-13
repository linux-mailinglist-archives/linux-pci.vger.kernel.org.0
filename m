Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4117E2F4A7A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 12:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbhAMLmE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 06:42:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34873 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725998AbhAMLmE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2021 06:42:04 -0500
X-UUID: 37fa59a4344c41feb5ac9937a6bad1da-20210113
X-UUID: 37fa59a4344c41feb5ac9937a6bad1da-20210113
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1660894844; Wed, 13 Jan 2021 19:41:00 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 Jan 2021 19:40:59 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jan 2021 19:40:57 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        <anson.chuang@mediatek.com>
Subject: [v7,5/7] PCI: mediatek-gen3: Add MSI support
Date:   Wed, 13 Jan 2021 19:39:59 +0800
Message-ID: <20210113114001.5804-6-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210113114001.5804-1-jianjun.wang@mediatek.com>
References: <20210113114001.5804-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B04B4118CFA533AB7E50A2A7063C9CD4D2B1FED9D840495C618749C553E592C82000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add MSI support for MediaTek Gen3 PCIe controller.

This PCIe controller supports up to 256 MSI vectors, the MSI hardware
block diagram is as follows:

                  +-----+
                  | GIC |
                  +-----+
                     ^
                     |
                 port->irq
                     |
             +-+-+-+-+-+-+-+-+
             |0|1|2|3|4|5|6|7| (PCIe intc)
             +-+-+-+-+-+-+-+-+
              ^ ^           ^
              | |    ...    |
      +-------+ +------+    +-----------+
      |                |                |
+-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
|0|1|...|30|31|  |0|1|...|30|31|  |0|1|...|30|31| (MSI sets)
+-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
 ^ ^      ^  ^    ^ ^      ^  ^    ^ ^      ^  ^
 | |      |  |    | |      |  |    | |      |  |  (MSI vectors)
 | |      |  |    | |      |  |    | |      |  |

  (MSI SET0)       (MSI SET1)  ...   (MSI SET7)

With 256 MSI vectors supported, the MSI vectors are composed of 8 sets,
each set has its own address for MSI message, and supports 32 MSI vectors
to generate interrupt.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 261 ++++++++++++++++++++
 1 file changed, 261 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 7979a2856c35..471d97cd1ef9 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -14,6 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
 #include <linux/of_pci.h>
@@ -52,11 +53,28 @@
 #define PCIE_LINK_STATUS_REG		0x154
 #define PCIE_PORT_LINKUP		BIT(8)
 
+#define PCIE_MSI_SET_NUM		8
+#define PCIE_MSI_IRQS_PER_SET		32
+#define PCIE_MSI_IRQS_NUM \
+	(PCIE_MSI_IRQS_PER_SET * (PCIE_MSI_SET_NUM))
+
 #define PCIE_INT_ENABLE_REG		0x180
+#define PCIE_MSI_ENABLE			GENMASK(PCIE_MSI_SET_NUM + 8 - 1, 8)
+#define PCIE_MSI_SHIFT			8
 #define PCIE_INTX_SHIFT			24
 #define PCIE_INTX_MASK			GENMASK(27, 24)
 
 #define PCIE_INT_STATUS_REG		0x184
+#define PCIE_MSI_SET_ENABLE_REG		0x190
+#define PCIE_MSI_SET_ENABLE		GENMASK(PCIE_MSI_SET_NUM - 1, 0)
+
+#define PCIE_MSI_SET_BASE_REG		0xc00
+#define PCIE_MSI_SET_OFFSET		0x10
+#define PCIE_MSI_SET_STATUS_OFFSET	0x04
+#define PCIE_MSI_SET_ENABLE_OFFSET	0x08
+
+#define PCIE_MSI_SET_ADDR_HI_BASE	0xc80
+#define PCIE_MSI_SET_ADDR_HI_OFFSET	0x04
 
 #define PCIE_TRANS_TABLE_BASE_REG	0x800
 #define PCIE_ATR_SRC_ADDR_MSB_OFFSET	0x4
@@ -76,6 +94,18 @@
 #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
 #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
 
+/**
+ * struct mtk_pcie_msi - MSI information for each set
+ * @dev: pointer to PCIe device
+ * @base: IO mapped register base
+ * @msg_addr: MSI message address
+ */
+struct mtk_msi_set {
+	struct device *dev;
+	void __iomem *base;
+	phys_addr_t msg_addr;
+};
+
 /**
  * struct mtk_pcie_port - PCIe port information
  * @dev: pointer to PCIe device
@@ -88,6 +118,11 @@
  * @num_clks: PCIe clocks count for this port
  * @irq: PCIe controller interrupt number
  * @intx_domain: legacy INTx IRQ domain
+ * @msi_domain: MSI IRQ domain
+ * @msi_bottom_domain: MSI IRQ bottom domain
+ * @msi_sets: MSI sets information
+ * @lock: lock protecting IRQ bit map
+ * @msi_irq_in_use: bit map for assigned MSI IRQ
  */
 struct mtk_pcie_port {
 	struct device *dev;
@@ -101,6 +136,11 @@ struct mtk_pcie_port {
 
 	int irq;
 	struct irq_domain *intx_domain;
+	struct irq_domain *msi_domain;
+	struct irq_domain *msi_bottom_domain;
+	struct mtk_msi_set msi_sets[PCIE_MSI_SET_NUM];
+	struct mutex lock;
+	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
 };
 
 /**
@@ -243,6 +283,15 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 		return err;
 	}
 
+	/* Enable MSI */
+	val = readl_relaxed(port->base + PCIE_MSI_SET_ENABLE_REG);
+	val |= PCIE_MSI_SET_ENABLE;
+	writel_relaxed(val, port->base + PCIE_MSI_SET_ENABLE_REG);
+
+	val = readl_relaxed(port->base + PCIE_INT_ENABLE_REG);
+	val |= PCIE_MSI_ENABLE;
+	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
+
 	/* Set PCIe translation windows */
 	resource_list_for_each_entry(entry, &host->windows) {
 		struct resource *res = entry->res;
@@ -286,6 +335,129 @@ static int mtk_pcie_set_affinity(struct irq_data *data,
 	return -EINVAL;
 }
 
+static struct irq_chip mtk_msi_irq_chip = {
+	.name = "MSI",
+	.irq_ack = irq_chip_ack_parent,
+};
+
+static struct msi_domain_info mtk_msi_domain_info = {
+	.flags		= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_PCI_MSIX |
+			   MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI),
+	.chip		= &mtk_msi_irq_chip,
+};
+
+static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
+	unsigned long hwirq;
+
+	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
+
+	msg->address_hi = upper_32_bits(msi_set->msg_addr);
+	msg->address_lo = lower_32_bits(msi_set->msg_addr);
+	msg->data = hwirq;
+	dev_dbg(msi_set->dev, "msi#%#lx address_hi %#x address_lo %#x data %d\n",
+		hwirq, msg->address_hi, msg->address_lo, msg->data);
+}
+
+static void mtk_msi_bottom_irq_ack(struct irq_data *data)
+{
+	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
+	unsigned long hwirq;
+
+	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
+
+	writel_relaxed(BIT(hwirq), msi_set->base + PCIE_MSI_SET_STATUS_OFFSET);
+}
+
+static struct irq_chip mtk_msi_bottom_irq_chip = {
+	.irq_ack		= mtk_msi_bottom_irq_ack,
+	.irq_compose_msi_msg	= mtk_compose_msi_msg,
+	.irq_set_affinity	= mtk_pcie_set_affinity,
+	.name			= "PCIe",
+};
+
+static int mtk_msi_bottom_domain_alloc(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs,
+				       void *arg)
+{
+	struct mtk_pcie_port *port = domain->host_data;
+	struct mtk_msi_set *msi_set;
+	int i, hwirq, set_idx;
+
+	mutex_lock(&port->lock);
+
+	hwirq = bitmap_find_free_region(port->msi_irq_in_use, PCIE_MSI_IRQS_NUM,
+					order_base_2(nr_irqs));
+
+	mutex_unlock(&port->lock);
+
+	if (hwirq < 0)
+		return -ENOSPC;
+
+	set_idx = hwirq / PCIE_MSI_IRQS_PER_SET;
+	msi_set = &port->msi_sets[set_idx];
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &mtk_msi_bottom_irq_chip, msi_set,
+				    handle_edge_irq, NULL, NULL);
+
+	return 0;
+}
+
+static void mtk_msi_bottom_domain_free(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs)
+{
+	struct mtk_pcie_port *port = domain->host_data;
+	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
+
+	mutex_lock(&port->lock);
+
+	bitmap_clear(port->msi_irq_in_use, data->hwirq, nr_irqs);
+
+	mutex_unlock(&port->lock);
+
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+}
+
+static int mtk_msi_bottom_domain_activate(struct irq_domain *domain,
+					  struct irq_data *data, bool reserve)
+{
+	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
+	unsigned long hwirq;
+	u32 val;
+
+	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
+
+	val = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
+	val |= BIT(hwirq);
+	writel_relaxed(val, msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
+
+	return 0;
+}
+
+static void mtk_msi_bottom_domain_deactivate(struct irq_domain *domain,
+					     struct irq_data *data)
+{
+	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
+	unsigned long hwirq;
+	u32 val;
+
+	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
+
+	val = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
+	val &= ~BIT(hwirq);
+	writel_relaxed(val, msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
+}
+
+static const struct irq_domain_ops mtk_msi_bottom_domain_ops = {
+	.alloc = mtk_msi_bottom_domain_alloc,
+	.free = mtk_msi_bottom_domain_free,
+	.activate = mtk_msi_bottom_domain_activate,
+	.deactivate = mtk_msi_bottom_domain_deactivate,
+};
+
 static void mtk_intx_mask(struct irq_data *data)
 {
 	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
@@ -350,6 +522,9 @@ static int mtk_pcie_init_irq_domains(struct mtk_pcie_port *port,
 {
 	struct device *dev = port->dev;
 	struct device_node *intc_node;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(node);
+	struct msi_domain_info *info;
+	int i, ret;
 
 	/* Setup INTx */
 	intc_node = of_get_child_by_name(node, "interrupt-controller");
@@ -365,7 +540,57 @@ static int mtk_pcie_init_irq_domains(struct mtk_pcie_port *port,
 		return -ENODEV;
 	}
 
+	/* Setup MSI */
+	mutex_init(&port->lock);
+
+	port->msi_bottom_domain = irq_domain_add_linear(node, PCIE_MSI_IRQS_NUM,
+				  &mtk_msi_bottom_domain_ops, port);
+	if (!port->msi_bottom_domain) {
+		dev_info(dev, "failed to create MSI bottom domain\n");
+		ret = -ENODEV;
+		goto err_msi_bottom_domain;
+	}
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		ret = -ENOMEM;
+		goto err_msi_bottom_domain;
+	}
+
+	memcpy(info, &mtk_msi_domain_info, sizeof(*info));
+	info->chip_data = port;
+
+	port->msi_domain = pci_msi_create_irq_domain(fwnode, info,
+						     port->msi_bottom_domain);
+	if (!port->msi_domain) {
+		dev_info(dev, "failed to create MSI domain\n");
+		ret = -ENODEV;
+		goto err_msi_domain;
+	}
+
+	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
+		struct mtk_msi_set *msi_set = &port->msi_sets[i];
+
+		msi_set->dev = port->dev;
+		msi_set->base = port->base + PCIE_MSI_SET_BASE_REG +
+				i * PCIE_MSI_SET_OFFSET;
+		msi_set->msg_addr = port->reg_base + PCIE_MSI_SET_BASE_REG +
+				    i * PCIE_MSI_SET_OFFSET;
+
+		writel_relaxed(lower_32_bits(msi_set->msg_addr), msi_set->base);
+		writel_relaxed(upper_32_bits(msi_set->msg_addr),
+			       port->base + PCIE_MSI_SET_ADDR_HI_BASE +
+			       i * PCIE_MSI_SET_ADDR_HI_OFFSET);
+	}
+
 	return 0;
+
+err_msi_domain:
+	irq_domain_remove(port->msi_bottom_domain);
+err_msi_bottom_domain:
+	irq_domain_remove(port->intx_domain);
+
+	return ret;
 }
 
 static void mtk_pcie_irq_teardown(struct mtk_pcie_port *port)
@@ -375,9 +600,34 @@ static void mtk_pcie_irq_teardown(struct mtk_pcie_port *port)
 	if (port->intx_domain)
 		irq_domain_remove(port->intx_domain);
 
+	if (port->msi_domain)
+		irq_domain_remove(port->msi_domain);
+
+	if (port->msi_bottom_domain)
+		irq_domain_remove(port->msi_bottom_domain);
+
 	irq_dispose_mapping(port->irq);
 }
 
+static void mtk_pcie_msi_handler(struct mtk_pcie_port *port, int set_idx)
+{
+	struct mtk_msi_set *msi_set = &port->msi_sets[set_idx];
+	unsigned long msi_enable, msi_status;
+	unsigned int virq;
+	irq_hw_number_t bit, hwirq;
+
+	msi_enable = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
+	while ((msi_status =
+		readl_relaxed(msi_set->base + PCIE_MSI_SET_STATUS_OFFSET) &
+			      msi_enable)) {
+		for_each_set_bit(bit, &msi_status, PCIE_MSI_IRQS_PER_SET) {
+			hwirq = bit + set_idx * PCIE_MSI_IRQS_PER_SET;
+			virq = irq_find_mapping(port->msi_bottom_domain, hwirq);
+			generic_handle_irq(virq);
+		}
+	}
+}
+
 static void mtk_pcie_irq_handler(struct irq_desc *desc)
 {
 	struct mtk_pcie_port *port = irq_desc_get_handler_data(desc);
@@ -398,6 +648,17 @@ static void mtk_pcie_irq_handler(struct irq_desc *desc)
 		}
 	}
 
+	if (status & PCIE_MSI_ENABLE) {
+		irq_bit = PCIE_MSI_SHIFT;
+		for_each_set_bit_from(irq_bit, &status, PCIE_MSI_SET_NUM +
+				      PCIE_MSI_SHIFT) {
+			mtk_pcie_msi_handler(port, irq_bit - PCIE_MSI_SHIFT);
+
+			writel_relaxed(BIT(irq_bit),
+				       port->base + PCIE_INT_STATUS_REG);
+		}
+	}
+
 	chained_irq_exit(irqchip, desc);
 }
 
-- 
2.25.1

