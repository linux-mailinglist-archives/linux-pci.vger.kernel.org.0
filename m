Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3706195494
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 10:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgC0J6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 05:58:09 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47096 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgC0J6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2020 05:58:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02R9w3pL108233;
        Fri, 27 Mar 2020 04:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585303083;
        bh=x646Qw6LDH3xePnNAUnlZzaXeVbRtrI4yQ8a5BcrEFA=;
        h=From:To:CC:Subject:Date;
        b=y/CXEjR4Ih5HuFF4k99W0nclHRkW/0zB/JvaZ4ja/PwmSceUXxa2w1UNwFCL4DOQG
         8/T3KJdyH/CPxu90hGIjdGTXl0gWz/goxFC8+4S403LmZnee3vFJzjmxQuQndSI8g9
         0mdd72+aSkmrCb+7FsrwYzDCnGcEGArvONzl1zvg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02R9w2vC025418;
        Fri, 27 Mar 2020 04:58:03 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 27
 Mar 2020 04:58:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 27 Mar 2020 04:58:01 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02R9vvJB057147;
        Fri, 27 Mar 2020 04:57:58 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v4] PCI: dwc: pci-dra7xx: Fix MSI IRQ handling
Date:   Fri, 27 Mar 2020 15:24:34 +0530
Message-ID: <20200327095434.945-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Due an issue with PCIe wrapper around DWC PCIe IP on dra7xx, driver
needs to ensure that there are no pending MSI IRQ vector set (i.e
PCIE_MSI_INTR0_STATUS reads 0 at least once) before exiting IRQ handler.
Else, the dra7xx PCIe wrapper will not register new MSI IRQs even though
PCIE_MSI_INTR0_STATUS shows IRQs are pending.

Therefore its no longer possible to use default IRQ handler provided by
DWC library. So, add irqchip implementation inside pci-dra7xx.c and
install new MSI IRQ handler to handle above errata.

This fixes a bug, where PCIe wifi cards with 4 DMA queues like Intel
8260 used to throw following error and stall during ping/iperf3 tests.

[   97.776310] iwlwifi 0000:01:00.0: Queue 9 stuck for 2500 ms.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
---

v4:
Simplify dra7xx_pcie_handle_msi_irq() by spliting inner loop into
separte function as suggested by Lorenzo

v3:
- Move loop to service all MSI IRQs into dra7xx_pcie_handle_msi_irq()
- Add a warning msg when loop counter overflows


 drivers/pci/controller/dwc/pci-dra7xx.c | 231 ++++++++++++++++++++----
 1 file changed, 195 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 9bf7fa99b103..3b0e58f2de58 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -215,10 +215,6 @@ static int dra7xx_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
-	.host_init = dra7xx_pcie_host_init,
-};
-
 static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 				irq_hw_number_t hwirq)
 {
@@ -233,43 +229,77 @@ static const struct irq_domain_ops intx_domain_ops = {
 	.xlate = pci_irqd_intx_xlate,
 };
 
-static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
+static int dra7xx_pcie_handle_msi(struct pcie_port *pp, int index)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct device *dev = pci->dev;
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
-	struct device_node *node = dev->of_node;
-	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
+	unsigned long val;
+	int pos, irq;
 
-	if (!pcie_intc_node) {
-		dev_err(dev, "No PCIe Intc node found\n");
-		return -ENODEV;
-	}
+	val = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
+				   (index * MSI_REG_CTRL_BLOCK_SIZE));
+	if (!val)
+		return 0;
 
-	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						   &intx_domain_ops, pp);
-	of_node_put(pcie_intc_node);
-	if (!dra7xx->irq_domain) {
-		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return -ENODEV;
+	pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL, 0);
+	while (pos != MAX_MSI_IRQS_PER_CTRL) {
+		irq = irq_find_mapping(pp->irq_domain,
+				       (index * MAX_MSI_IRQS_PER_CTRL) + pos);
+		generic_handle_irq(irq);
+		pos++;
+		pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL, pos);
 	}
 
-	return 0;
+	return 1;
 }
 
-static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
+static void dra7xx_pcie_handle_msi_irq(struct pcie_port *pp)
 {
-	struct dra7xx_pcie *dra7xx = arg;
-	struct dw_pcie *pci = dra7xx->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	int ret, i, count, num_ctrls;
+
+	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
+	/**
+	 * Need to make sure all MSI status bits read 0 before exiting.
+	 * Else, new MSI IRQs are not registered by the wrapper. Have an
+	 * upperbound for the loop and exit the IRQ in case of IRQ flood
+	 * to avoid locking up system in interrupt context.
+	 */
+	count = 0;
+	do {
+		ret = 0;
+
+		for (i = 0; i < num_ctrls; i++)
+			ret |= dra7xx_pcie_handle_msi(pp, i);
+		count++;
+	} while (ret && count <= 1000);
+
+	if (count > 1000)
+		dev_warn_ratelimited(pci->dev,
+				     "Too many MSI IRQs to handle\n");
+}
+
+static void dra7xx_pcie_msi_irq_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct dra7xx_pcie *dra7xx;
+	struct dw_pcie *pci;
+	struct pcie_port *pp;
 	unsigned long reg;
 	u32 virq, bit;
 
+	chained_irq_enter(chip, desc);
+
+	pp = irq_desc_get_handler_data(desc);
+	pci = to_dw_pcie_from_pp(pp);
+	dra7xx = to_dra7xx_pcie(pci);
+
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
 
 	switch (reg) {
 	case MSI:
-		dw_handle_msi_irq(pp);
+		dra7xx_pcie_handle_msi_irq(pp);
 		break;
 	case INTA:
 	case INTB:
@@ -283,9 +313,7 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 		break;
 	}
 
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
-
-	return IRQ_HANDLED;
+	chained_irq_exit(chip, desc);
 }
 
 static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
@@ -347,6 +375,145 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
+	struct device_node *node = dev->of_node;
+	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
+
+	if (!pcie_intc_node) {
+		dev_err(dev, "No PCIe Intc node found\n");
+		return -ENODEV;
+	}
+
+	irq_set_chained_handler_and_data(pp->irq, dra7xx_pcie_msi_irq_handler,
+					 pp);
+	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						   &intx_domain_ops, pp);
+	of_node_put(pcie_intc_node);
+	if (!dra7xx->irq_domain) {
+		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void dra7xx_pcie_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u64 msi_target;
+
+	msi_target = (u64)pp->msi_data;
+
+	msg->address_lo = lower_32_bits(msi_target);
+	msg->address_hi = upper_32_bits(msi_target);
+
+	msg->data = d->hwirq;
+
+	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
+		(int)d->hwirq, msg->address_hi, msg->address_lo);
+}
+
+static int dra7xx_pcie_msi_set_affinity(struct irq_data *d,
+					const struct cpumask *mask,
+					bool force)
+{
+	return -EINVAL;
+}
+
+static void dra7xx_pcie_bottom_mask(struct irq_data *d)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	unsigned int res, bit, ctrl;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
+
+	pp->irq_mask[ctrl] |= BIT(bit);
+	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res,
+			   pp->irq_mask[ctrl]);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+}
+
+static void dra7xx_pcie_bottom_unmask(struct irq_data *d)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	unsigned int res, bit, ctrl;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
+
+	pp->irq_mask[ctrl] &= ~BIT(bit);
+	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res,
+			   pp->irq_mask[ctrl]);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+}
+
+static void dra7xx_pcie_bottom_ack(struct irq_data *d)
+{
+	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	unsigned int res, bit, ctrl;
+
+	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
+
+	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
+}
+
+static struct irq_chip dra7xx_pci_msi_bottom_irq_chip = {
+	.name = "DRA7XX-PCI-MSI",
+	.irq_ack = dra7xx_pcie_bottom_ack,
+	.irq_compose_msi_msg = dra7xx_pcie_setup_msi_msg,
+	.irq_set_affinity = dra7xx_pcie_msi_set_affinity,
+	.irq_mask = dra7xx_pcie_bottom_mask,
+	.irq_unmask = dra7xx_pcie_bottom_unmask,
+};
+
+static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u32 ctrl, num_ctrls;
+
+	pp->msi_irq_chip = &dra7xx_pci_msi_bottom_irq_chip;
+
+	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+	/* Initialize IRQ Status array */
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+		pp->irq_mask[ctrl] = ~0;
+		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
+				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+				    pp->irq_mask[ctrl]);
+		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
+				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+				    ~0);
+	}
+
+	return dw_pcie_allocate_domains(pp);
+}
+
+static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
+	.host_init = dra7xx_pcie_host_init,
+	.msi_host_init = dra7xx_pcie_msi_host_init,
+};
+
 static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -467,14 +634,6 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 		return pp->irq;
 	}
 
-	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
-			       IRQF_SHARED | IRQF_NO_THREAD,
-			       "dra7-pcie-msi",	dra7xx);
-	if (ret) {
-		dev_err(dev, "failed to request irq\n");
-		return ret;
-	}
-
 	ret = dra7xx_pcie_init_irq_domain(pp);
 	if (ret < 0)
 		return ret;
-- 
2.26.0

