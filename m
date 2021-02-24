Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3E323739
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 07:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhBXGNl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 01:13:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:34569 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234128AbhBXGNi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 01:13:38 -0500
X-UUID: a299b459d3554442b04a8b1ebb0f35ee-20210224
X-UUID: a299b459d3554442b04a8b1ebb0f35ee-20210224
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1411409120; Wed, 24 Feb 2021 14:12:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Feb 2021 14:12:30 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Feb 2021 14:12:29 +0800
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
Subject: [v8,4/7] PCI: mediatek-gen3: Add INTx support
Date:   Wed, 24 Feb 2021 14:11:29 +0800
Message-ID: <20210224061132.26526-5-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210224061132.26526-1-jianjun.wang@mediatek.com>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add INTx support for MediaTek Gen3 PCIe controller.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 176 ++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index c602beb9afec..8b3b5f838b69 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -9,6 +9,9 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -45,6 +48,13 @@
 #define PCIE_LINK_STATUS_REG		0x154
 #define PCIE_PORT_LINKUP		BIT(8)
 
+#define PCIE_INT_ENABLE_REG		0x180
+#define PCIE_INTX_SHIFT			24
+#define PCIE_INTX_ENABLE \
+	GENMASK(PCIE_INTX_SHIFT + PCI_NUM_INTX - 1, PCIE_INTX_SHIFT)
+
+#define PCIE_INT_STATUS_REG		0x184
+
 #define PCIE_TRANS_TABLE_BASE_REG	0x800
 #define PCIE_ATR_SRC_ADDR_MSB_OFFSET	0x4
 #define PCIE_ATR_TRSL_ADDR_LSB_OFFSET	0x8
@@ -73,6 +83,9 @@
  * @phy: PHY controller block
  * @clks: PCIe clocks
  * @num_clks: PCIe clocks count for this port
+ * @irq: PCIe controller interrupt number
+ * @irq_lock: lock protecting IRQ register access
+ * @intx_domain: legacy INTx IRQ domain
  */
 struct mtk_pcie_port {
 	struct device *dev;
@@ -83,6 +96,10 @@ struct mtk_pcie_port {
 	struct phy *phy;
 	struct clk_bulk_data *clks;
 	int num_clks;
+
+	int irq;
+	raw_spinlock_t irq_lock;
+	struct irq_domain *intx_domain;
 };
 
 /**
@@ -199,6 +216,11 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 	val |= PCI_CLASS(PCI_CLASS_BRIDGE_PCI << 8);
 	writel_relaxed(val, port->base + PCIE_PCI_IDS_1);
 
+	/* Mask all INTx interrupts */
+	val = readl_relaxed(port->base + PCIE_INT_ENABLE_REG);
+	val &= ~PCIE_INTX_ENABLE;
+	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
+
 	/* Assert all reset signals */
 	val = readl_relaxed(port->base + PCIE_RST_CTRL_REG);
 	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
@@ -262,6 +284,154 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 	return 0;
 }
 
+static int mtk_pcie_set_affinity(struct irq_data *data,
+				 const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static void mtk_intx_mask(struct irq_data *data)
+{
+	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->irq_lock, flags);
+	val = readl_relaxed(port->base + PCIE_INT_ENABLE_REG);
+	val &= ~BIT(data->hwirq + PCIE_INTX_SHIFT);
+	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
+	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+}
+
+static void mtk_intx_unmask(struct irq_data *data)
+{
+	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->irq_lock, flags);
+	val = readl_relaxed(port->base + PCIE_INT_ENABLE_REG);
+	val |= BIT(data->hwirq + PCIE_INTX_SHIFT);
+	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
+	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+}
+
+/**
+ * mtk_intx_eoi
+ * @data: pointer to chip specific data
+ *
+ * As an emulated level IRQ, its interrupt status will remain
+ * until the corresponding de-assert message is received; hence that
+ * the status can only be cleared when the interrupt has been serviced.
+ */
+static void mtk_intx_eoi(struct irq_data *data)
+{
+	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
+	unsigned long hwirq;
+
+	hwirq = data->hwirq + PCIE_INTX_SHIFT;
+	writel_relaxed(BIT(hwirq), port->base + PCIE_INT_STATUS_REG);
+}
+
+static struct irq_chip mtk_intx_irq_chip = {
+	.irq_enable		= mtk_intx_unmask,
+	.irq_disable		= mtk_intx_mask,
+	.irq_mask		= mtk_intx_mask,
+	.irq_unmask		= mtk_intx_unmask,
+	.irq_eoi		= mtk_intx_eoi,
+	.irq_set_affinity	= mtk_pcie_set_affinity,
+	.name			= "INTx",
+};
+
+static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_chip_and_handler_name(irq, &mtk_intx_irq_chip,
+				      handle_fasteoi_irq, "INTx");
+	return 0;
+}
+
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = mtk_pcie_intx_map,
+};
+
+static int mtk_pcie_init_irq_domains(struct mtk_pcie_port *port)
+{
+	struct device *dev = port->dev;
+	struct device_node *intc_node, *node = dev->of_node;
+
+	raw_spin_lock_init(&port->irq_lock);
+
+	/* Setup INTx */
+	intc_node = of_get_child_by_name(node, "interrupt-controller");
+	if (!intc_node) {
+		dev_err(dev, "missing PCIe Intc node\n");
+		return -ENODEV;
+	}
+
+	port->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
+						  &intx_domain_ops, port);
+	if (!port->intx_domain) {
+		dev_err(dev, "failed to get INTx IRQ domain\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void mtk_pcie_irq_teardown(struct mtk_pcie_port *port)
+{
+	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+
+	if (port->intx_domain)
+		irq_domain_remove(port->intx_domain);
+
+	irq_dispose_mapping(port->irq);
+}
+
+static void mtk_pcie_irq_handler(struct irq_desc *desc)
+{
+	struct mtk_pcie_port *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *irqchip = irq_desc_get_chip(desc);
+	unsigned long status;
+	unsigned int virq;
+	irq_hw_number_t irq_bit = PCIE_INTX_SHIFT;
+
+	chained_irq_enter(irqchip, desc);
+
+	status = readl_relaxed(port->base + PCIE_INT_STATUS_REG);
+	for_each_set_bit_from(irq_bit, &status, PCI_NUM_INTX +
+			      PCIE_INTX_SHIFT) {
+		virq = irq_find_mapping(port->intx_domain,
+					irq_bit - PCIE_INTX_SHIFT);
+		generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(irqchip, desc);
+}
+
+static int mtk_pcie_setup_irq(struct mtk_pcie_port *port)
+{
+	struct device *dev = port->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int err;
+
+	err = mtk_pcie_init_irq_domains(port);
+	if (err) {
+		dev_err(dev, "failed to init PCIe IRQ domain\n");
+		return err;
+	}
+
+	port->irq = platform_get_irq(pdev, 0);
+	if (port->irq < 0)
+		return port->irq;
+
+	irq_set_chained_handler_and_data(port->irq, mtk_pcie_irq_handler, port);
+
+	return 0;
+}
+
 static int mtk_pcie_clk_init(struct mtk_pcie_port *port)
 {
 	int ret;
@@ -384,6 +554,10 @@ static int mtk_pcie_setup(struct mtk_pcie_port *port)
 		goto err_setup;
 	}
 
+	err = mtk_pcie_setup_irq(port);
+	if (err)
+		goto err_setup;
+
 	return 0;
 
 err_setup:
@@ -417,6 +591,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 	err = pci_host_probe(host);
 	if (err) {
+		mtk_pcie_irq_teardown(port);
 		mtk_pcie_power_down(port);
 		return err;
 	}
@@ -434,6 +609,7 @@ static int mtk_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(host->bus);
 	pci_unlock_rescan_remove();
 
+	mtk_pcie_irq_teardown(port);
 	mtk_pcie_power_down(port);
 
 	return 0;
-- 
2.25.1

