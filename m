Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE7F7B014C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjI0KIR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 06:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0KIP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 06:08:15 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D719F;
        Wed, 27 Sep 2023 03:08:12 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9DAC624E2F8;
        Wed, 27 Sep 2023 18:08:10 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 18:08:10 +0800
Received: from ubuntu.localdomain (113.72.144.128) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 18:08:08 +0800
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
Subject: [PATCH v7 04/19] PCI: microchip: Rename data structure
Date:   Wed, 27 Sep 2023 18:07:47 +0800
Message-ID: <20230927100802.46620-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230927100802.46620-1-minda.chen@starfivetech.com>
References: <20230927100802.46620-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.128]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PLDA PCIe related data structures by rename
data structure name from mc_* to plda_*.

The modification includes:
mc_pcie --> plda_pcie_rp (Get most of data members)
mc_msi  --> plda_msi

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 118 ++++++++----------
 drivers/pci/controller/plda/pcie-plda.h       |  20 +++
 2 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index a34ec6aad4be..f77aaf14909f 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -21,9 +21,6 @@
 #include "../../pci.h"
 #include "pcie-plda.h"
 
-/* Number of MSI IRQs */
-#define MC_MAX_NUM_MSI_IRQS			32
-
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
 #define MC_PCIE1_CTRL_ADDR			0x0000a000u
@@ -179,22 +176,9 @@ struct event_map {
 	u32 event_bit;
 };
 
-struct mc_msi {
-	struct mutex lock;		/* Protect used bitmap */
-	struct irq_domain *msi_domain;
-	struct irq_domain *dev_domain;
-	u32 num_vectors;
-	u64 vector_phy;
-	DECLARE_BITMAP(used, MC_MAX_NUM_MSI_IRQS);
-};
-
 struct mc_pcie {
+	struct plda_pcie_rp plda;
 	void __iomem *axi_base_addr;
-	struct device *dev;
-	struct irq_domain *intx_domain;
-	struct irq_domain *event_domain;
-	raw_spinlock_t lock;
-	struct mc_msi msi;
 };
 
 struct cause {
@@ -312,7 +296,7 @@ static struct mc_pcie *port;
 
 static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
 {
-	struct mc_msi *msi = &port->msi;
+	struct plda_msi *msi = &port->plda.msi;
 	u16 reg;
 	u8 queue_size;
 
@@ -335,12 +319,11 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
 
 static void mc_handle_msi(struct irq_desc *desc)
 {
-	struct mc_pcie *port = irq_desc_get_handler_data(desc);
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct device *dev = port->dev;
-	struct mc_msi *msi = &port->msi;
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	struct plda_msi *msi = &port->msi;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long status;
 	u32 bit;
 	int ret;
@@ -364,9 +347,8 @@ static void mc_handle_msi(struct irq_desc *desc)
 
 static void mc_msi_bottom_irq_ack(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	u32 bitpos = data->hwirq;
 
 	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
@@ -374,7 +356,7 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
 
 static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	phys_addr_t addr = port->msi.vector_phy;
 
 	msg->address_lo = lower_32_bits(addr);
@@ -401,8 +383,8 @@ static struct irq_chip mc_msi_bottom_irq_chip = {
 static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
-	struct mc_pcie *port = domain->host_data;
-	struct mc_msi *msi = &port->msi;
+	struct plda_pcie_rp *port = domain->host_data;
+	struct plda_msi *msi = &port->msi;
 	unsigned long bit;
 
 	mutex_lock(&msi->lock);
@@ -426,8 +408,8 @@ static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct mc_pcie *port = irq_data_get_irq_chip_data(d);
-	struct mc_msi *msi = &port->msi;
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(d);
+	struct plda_msi *msi = &port->msi;
 
 	mutex_lock(&msi->lock);
 
@@ -457,11 +439,11 @@ static struct msi_domain_info mc_msi_domain_info = {
 	.chip = &mc_msi_irq_chip,
 };
 
-static int mc_allocate_msi_domains(struct mc_pcie *port)
+static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
 	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
-	struct mc_msi *msi = &port->msi;
+	struct plda_msi *msi = &port->msi;
 
 	mutex_init(&port->msi.lock);
 
@@ -485,11 +467,10 @@ static int mc_allocate_msi_domains(struct mc_pcie *port)
 
 static void mc_handle_intx(struct irq_desc *desc)
 {
-	struct mc_pcie *port = irq_desc_get_handler_data(desc);
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct device *dev = port->dev;
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long status;
 	u32 bit;
 	int ret;
@@ -513,9 +494,8 @@ static void mc_handle_intx(struct irq_desc *desc)
 
 static void mc_ack_intx_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
 
 	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
@@ -523,9 +503,8 @@ static void mc_ack_intx_irq(struct irq_data *data)
 
 static void mc_mask_intx_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long flags;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
 	u32 val;
@@ -539,9 +518,8 @@ static void mc_mask_intx_irq(struct irq_data *data)
 
 static void mc_unmask_intx_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	unsigned long flags;
 	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
 	u32 val;
@@ -630,21 +608,22 @@ static u32 local_events(struct mc_pcie *port)
 	return val;
 }
 
-static u32 get_events(struct mc_pcie *port)
+static u32 get_events(struct plda_pcie_rp *port)
 {
+	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
 	u32 events = 0;
 
-	events |= pcie_events(port);
-	events |= sec_errors(port);
-	events |= ded_errors(port);
-	events |= local_events(port);
+	events |= pcie_events(mc_port);
+	events |= sec_errors(mc_port);
+	events |= ded_errors(mc_port);
+	events |= local_events(mc_port);
 
 	return events;
 }
 
 static irqreturn_t mc_event_handler(int irq, void *dev_id)
 {
-	struct mc_pcie *port = dev_id;
+	struct plda_pcie_rp *port = dev_id;
 	struct device *dev = port->dev;
 	struct irq_data *data;
 
@@ -660,7 +639,7 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 
 static void mc_handle_event(struct irq_desc *desc)
 {
-	struct mc_pcie *port = irq_desc_get_handler_data(desc);
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	unsigned long events;
 	u32 bit;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -677,12 +656,13 @@ static void mc_handle_event(struct irq_desc *desc)
 
 static void mc_ack_event_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
 
-	addr = port->axi_base_addr + event_descs[event].base +
+	addr = mc_port->axi_base_addr + event_descs[event].base +
 		event_descs[event].offset;
 	mask = event_descs[event].mask;
 	mask |= event_descs[event].enb_mask;
@@ -692,13 +672,14 @@ static void mc_ack_event_irq(struct irq_data *data)
 
 static void mc_mask_event_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
 	u32 val;
 
-	addr = port->axi_base_addr + event_descs[event].base +
+	addr = mc_port->axi_base_addr + event_descs[event].base +
 		event_descs[event].mask_offset;
 	mask = event_descs[event].mask;
 	if (event_descs[event].enb_mask) {
@@ -722,13 +703,14 @@ static void mc_mask_event_irq(struct irq_data *data)
 
 static void mc_unmask_event_irq(struct irq_data *data)
 {
-	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
 	u32 event = data->hwirq;
 	void __iomem *addr;
 	u32 mask;
 	u32 val;
 
-	addr = port->axi_base_addr + event_descs[event].base +
+	addr = mc_port->axi_base_addr + event_descs[event].base +
 		event_descs[event].mask_offset;
 	mask = event_descs[event].mask;
 
@@ -816,7 +798,7 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
-static int mc_pcie_init_irq_domains(struct mc_pcie *port)
+static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
@@ -894,10 +876,9 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 }
 
 static int mc_pcie_setup_windows(struct platform_device *pdev,
-				 struct mc_pcie *port)
+				 struct plda_pcie_rp *port)
 {
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *bridge_base_addr = port->bridge_addr;
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	struct resource_entry *entry;
 	u64 pci_addr;
@@ -976,7 +957,7 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int mc_init_interrupts(struct platform_device *pdev, struct mc_pcie *port)
+static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
 {
 	struct device *dev = &pdev->dev;
 	int irq;
@@ -1049,12 +1030,12 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = mc_pcie_setup_windows(pdev, port);
+	ret = mc_pcie_setup_windows(pdev, &port->plda);
 	if (ret)
 		return ret;
 
 	/* Address translation is up; safe to enable interrupts */
-	ret = mc_init_interrupts(pdev, port);
+	ret = mc_init_interrupts(pdev, &port->plda);
 	if (ret)
 		return ret;
 
@@ -1065,6 +1046,7 @@ static int mc_host_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	void __iomem *bridge_base_addr;
+	struct plda_pcie_rp *plda;
 	int ret;
 	u32 val;
 
@@ -1072,7 +1054,8 @@ static int mc_host_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
-	port->dev = dev;
+	plda = &port->plda;
+	plda->dev = dev;
 
 	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(port->axi_base_addr))
@@ -1081,6 +1064,7 @@ static int mc_host_probe(struct platform_device *pdev)
 	mc_disable_interrupts(port);
 
 	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	plda->bridge_addr = bridge_base_addr;
 
 	/* Allow enabling MSI by disabling MSI-X */
 	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
@@ -1092,10 +1076,10 @@ static int mc_host_probe(struct platform_device *pdev)
 	val &= NUM_MSI_MSGS_MASK;
 	val >>= NUM_MSI_MSGS_SHIFT;
 
-	port->msi.num_vectors = 1 << val;
+	plda->msi.num_vectors = 1 << val;
 
 	/* Pick vector address from design */
-	port->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
+	plda->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
 
 	ret = mc_pcie_init_clks(dev);
 	if (ret) {
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 727fc54312c9..d04a571404b9 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -6,6 +6,9 @@
 #ifndef _PCIE_PLDA_H
 #define _PCIE_PLDA_H
 
+/* Number of MSI IRQs */
+#define PLDA_MAX_NUM_MSI_IRQS			32
+
 /* PCIe Bridge Phy Regs */
 #define PCIE_PCI_IRQ_DW0			0xa8
 #define  MSIX_CAP_MASK				BIT(31)
@@ -99,4 +102,21 @@
 #define EVENT_PM_MSI_INT_SYS_ERR		12
 #define NUM_PLDA_EVENTS				13
 
+struct plda_msi {
+	struct mutex lock;		/* Protect used bitmap */
+	struct irq_domain *msi_domain;
+	struct irq_domain *dev_domain;
+	u32 num_vectors;
+	u64 vector_phy;
+	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
+};
+
+struct plda_pcie_rp {
+	struct device *dev;
+	struct irq_domain *intx_domain;
+	struct irq_domain *event_domain;
+	raw_spinlock_t lock;
+	struct plda_msi msi;
+	void __iomem *bridge_addr;
+};
 #endif
-- 
2.17.1

