Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1733E32373B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 07:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhBXGNt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 01:13:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34517 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234131AbhBXGNp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 01:13:45 -0500
X-UUID: 1a16b7095d76478781160091c42dbd2f-20210224
X-UUID: 1a16b7095d76478781160091c42dbd2f-20210224
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1038681379; Wed, 24 Feb 2021 14:12:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Feb 2021 14:12:31 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Feb 2021 14:12:30 +0800
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
Subject: [v8,5/7] PCI: mediatek-gen3: Add MSI support
Date:   Wed, 24 Feb 2021 14:11:30 +0800
Message-ID: <20210224061132.26526-6-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210224061132.26526-1-jianjun.wang@mediatek.com>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6E9964958EFEC5B4C82C958689EF9C1FD65DDDC13CD3D46ADB9C85213E29B6A12000:8
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
 drivers/pci/controller/pcie-mediatek-gen3.c | 277 ++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 8b3b5f838b69..3cbec22ece0c 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -14,6 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -48,12 +49,29 @@
 #define PCIE_LINK_STATUS_REG		0x154
 #define PCIE_PORT_LINKUP		BIT(8)
 
+#define PCIE_MSI_SET_NUM		8
+#define PCIE_MSI_IRQS_PER_SET		32
+#define PCIE_MSI_IRQS_NUM \
+	(PCIE_MSI_IRQS_PER_SET * PCIE_MSI_SET_NUM)
+
 #define PCIE_INT_ENABLE_REG		0x180
+#define PCIE_MSI_ENABLE			GENMASK(PCIE_MSI_SET_NUM + 8 - 1, 8)
+#define PCIE_MSI_SHIFT			8
 #define PCIE_INTX_SHIFT			24
 #define PCIE_INTX_ENABLE \
 	GENMASK(PCIE_INTX_SHIFT + PCI_NUM_INTX - 1, PCIE_INTX_SHIFT)
 
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
@@ -73,6 +91,16 @@
 #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
 #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
 
+/**
+ * struct mtk_pcie_msi - MSI information for each set
+ * @base: IO mapped register base
+ * @msg_addr: MSI message address
+ */
+struct mtk_msi_set {
+	void __iomem *base;
+	phys_addr_t msg_addr;
+};
+
 /**
  * struct mtk_pcie_port - PCIe port information
  * @dev: pointer to PCIe device
@@ -86,6 +114,11 @@
  * @irq: PCIe controller interrupt number
  * @irq_lock: lock protecting IRQ register access
  * @intx_domain: legacy INTx IRQ domain
+ * @msi_domain: MSI IRQ domain
+ * @msi_bottom_domain: MSI IRQ bottom domain
+ * @msi_sets: MSI sets information
+ * @lock: lock protecting IRQ bit map
+ * @msi_irq_in_use: bit map for assigned MSI IRQ
  */
 struct mtk_pcie_port {
 	struct device *dev;
@@ -100,6 +133,11 @@ struct mtk_pcie_port {
 	int irq;
 	raw_spinlock_t irq_lock;
 	struct irq_domain *intx_domain;
+	struct irq_domain *msi_domain;
+	struct irq_domain *msi_bottom_domain;
+	struct mtk_msi_set msi_sets[PCIE_MSI_SET_NUM];
+	struct mutex lock;
+	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
 };
 
 /**
@@ -197,6 +235,35 @@ static int mtk_pcie_set_trans_table(struct mtk_pcie_port *port,
 	return 0;
 }
 
+static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
+{
+	int i;
+	u32 val;
+
+	val = readl_relaxed(port->base + PCIE_MSI_SET_ENABLE_REG);
+	val |= PCIE_MSI_SET_ENABLE;
+	writel_relaxed(val, port->base + PCIE_MSI_SET_ENABLE_REG);
+
+	val = readl_relaxed(port->base + PCIE_INT_ENABLE_REG);
+	val |= PCIE_MSI_ENABLE;
+	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
+
+	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
+		struct mtk_msi_set *msi_set = &port->msi_sets[i];
+
+		msi_set->base = port->base + PCIE_MSI_SET_BASE_REG +
+				i * PCIE_MSI_SET_OFFSET;
+		msi_set->msg_addr = port->reg_base + PCIE_MSI_SET_BASE_REG +
+				    i * PCIE_MSI_SET_OFFSET;
+
+		/* Configure the MSI capture address */
+		writel_relaxed(lower_32_bits(msi_set->msg_addr), msi_set->base);
+		writel_relaxed(upper_32_bits(msi_set->msg_addr),
+			       port->base + PCIE_MSI_SET_ADDR_HI_BASE +
+			       i * PCIE_MSI_SET_ADDR_HI_OFFSET);
+	}
+}
+
 static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 {
 	struct resource_entry *entry;
@@ -247,6 +314,8 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 		return err;
 	}
 
+	mtk_pcie_enable_msi(port);
+
 	/* Set PCIe translation windows */
 	resource_list_for_each_entry(entry, &host->windows) {
 		struct resource *res = entry->res;
@@ -290,6 +359,148 @@ static int mtk_pcie_set_affinity(struct irq_data *data,
 	return -EINVAL;
 }
 
+static void mtk_pcie_irq_mask(struct irq_data *data)
+{
+	pci_msi_mask_irq(data);
+	irq_chip_mask_parent(data);
+}
+
+static void mtk_pcie_irq_unmask(struct irq_data *data)
+{
+	pci_msi_unmask_irq(data);
+	irq_chip_unmask_parent(data);
+}
+
+static struct irq_chip mtk_msi_irq_chip = {
+	.name = "MSI",
+	.irq_enable = mtk_pcie_irq_unmask,
+	.irq_disable = mtk_pcie_irq_mask,
+	.irq_ack = irq_chip_ack_parent,
+	.irq_mask = mtk_pcie_irq_mask,
+	.irq_unmask = mtk_pcie_irq_unmask,
+};
+
+static struct msi_domain_info mtk_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_PCI_MSIX |
+		   MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI),
+	.chip	= &mtk_msi_irq_chip,
+};
+
+static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
+	struct mtk_pcie_port *port = data->domain->host_data;
+	unsigned long hwirq;
+
+	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
+
+	msg->address_hi = upper_32_bits(msi_set->msg_addr);
+	msg->address_lo = lower_32_bits(msi_set->msg_addr);
+	msg->data = hwirq;
+	dev_dbg(port->dev, "msi#%#lx address_hi %#x address_lo %#x data %d\n",
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
+static void mtk_msi_bottom_irq_mask(struct irq_data *data)
+{
+	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
+	struct mtk_pcie_port *port = data->domain->host_data;
+	unsigned long hwirq, flags;
+	u32 val;
+
+	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
+
+	raw_spin_lock_irqsave(&port->irq_lock, flags);
+	val = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
+	val &= ~BIT(hwirq);
+	writel_relaxed(val, msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
+	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+}
+
+static void mtk_msi_bottom_irq_unmask(struct irq_data *data)
+{
+	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
+	struct mtk_pcie_port *port = data->domain->host_data;
+	unsigned long hwirq, flags;
+	u32 val;
+
+	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
+
+	raw_spin_lock_irqsave(&port->irq_lock, flags);
+	val = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
+	val |= BIT(hwirq);
+	writel_relaxed(val, msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
+	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+}
+
+static struct irq_chip mtk_msi_bottom_irq_chip = {
+	.irq_ack		= mtk_msi_bottom_irq_ack,
+	.irq_mask		= mtk_msi_bottom_irq_mask,
+	.irq_unmask		= mtk_msi_bottom_irq_unmask,
+	.irq_compose_msi_msg	= mtk_compose_msi_msg,
+	.irq_set_affinity	= mtk_pcie_set_affinity,
+	.name			= "MSI",
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
+static const struct irq_domain_ops mtk_msi_bottom_domain_ops = {
+	.alloc = mtk_msi_bottom_domain_alloc,
+	.free = mtk_msi_bottom_domain_free,
+};
+
 static void mtk_intx_mask(struct irq_data *data)
 {
 	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
@@ -360,6 +571,7 @@ static int mtk_pcie_init_irq_domains(struct mtk_pcie_port *port)
 {
 	struct device *dev = port->dev;
 	struct device_node *intc_node, *node = dev->of_node;
+	int ret;
 
 	raw_spin_lock_init(&port->irq_lock);
 
@@ -377,7 +589,34 @@ static int mtk_pcie_init_irq_domains(struct mtk_pcie_port *port)
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
+	port->msi_domain = pci_msi_create_irq_domain(dev->fwnode,
+						     &mtk_msi_domain_info,
+						     port->msi_bottom_domain);
+	if (!port->msi_domain) {
+		dev_info(dev, "failed to create MSI domain\n");
+		ret = -ENODEV;
+		goto err_msi_domain;
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
@@ -387,9 +626,39 @@ static void mtk_pcie_irq_teardown(struct mtk_pcie_port *port)
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
+
+	do {
+		msi_status = readl_relaxed(msi_set->base +
+					   PCIE_MSI_SET_STATUS_OFFSET);
+		msi_status &= msi_enable;
+		if (!msi_status)
+			break;
+
+		for_each_set_bit(bit, &msi_status, PCIE_MSI_IRQS_PER_SET) {
+			hwirq = bit + set_idx * PCIE_MSI_IRQS_PER_SET;
+			virq = irq_find_mapping(port->msi_bottom_domain, hwirq);
+			generic_handle_irq(virq);
+		}
+	} while (true);
+}
+
 static void mtk_pcie_irq_handler(struct irq_desc *desc)
 {
 	struct mtk_pcie_port *port = irq_desc_get_handler_data(desc);
@@ -408,6 +677,14 @@ static void mtk_pcie_irq_handler(struct irq_desc *desc)
 		generic_handle_irq(virq);
 	}
 
+	irq_bit = PCIE_MSI_SHIFT;
+	for_each_set_bit_from(irq_bit, &status, PCIE_MSI_SET_NUM +
+			      PCIE_MSI_SHIFT) {
+		mtk_pcie_msi_handler(port, irq_bit - PCIE_MSI_SHIFT);
+
+		writel_relaxed(BIT(irq_bit), port->base + PCIE_INT_STATUS_REG);
+	}
+
 	chained_irq_exit(irqchip, desc);
 }
 
-- 
2.25.1

