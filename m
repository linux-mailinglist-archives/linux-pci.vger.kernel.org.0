Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB32177B3ED
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjHNIVA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 04:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjHNIUb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 04:20:31 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7C310E5;
        Mon, 14 Aug 2023 01:20:28 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BFB398246;
        Mon, 14 Aug 2023 16:20:26 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:20:26 +0800
Received: from ubuntu.localdomain (183.27.98.20) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:20:25 +0800
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
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v3 08/11] PCI: microchip: Move IRQ init functions to pcie-plda-host.c
Date:   Mon, 14 Aug 2023 16:20:13 +0800
Message-ID: <20230814082016.104181-9-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230814082016.104181-1-minda.chen@starfivetech.com>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.20]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move IRQ init functions to pcie-plda-host.c. mc_handle_event
merge to plda_handle_event, Add get_events functions,
PolarFire PCIe uses get_events function pointer to get
their events num.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 125 +---------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 140 ++++++++++++++++--
 drivers/pci/controller/plda/pcie-plda.h       |  15 +-
 3 files changed, 139 insertions(+), 141 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 140e7ca1a5cb..e71e34afab2a 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -314,10 +314,6 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
 		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
 }
 
-static const struct irq_domain_ops intx_domain_ops = {
-	.map = plda_pcie_intx_map,
-};
-
 static inline u32 reg_to_event(u32 reg, struct event_map field)
 {
 	return (reg & field.reg_mask) ? BIT(field.event_bit) : 0;
@@ -404,23 +400,6 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void mc_handle_event(struct irq_desc *desc)
-{
-	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
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
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
@@ -559,45 +538,6 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
-static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port, struct plda_evt *evt)
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
-	port->event_domain = irq_domain_add_linear(pcie_intc_node, port->num_events,
-						   evt->domain_ops, port);
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
-	return plda_allocate_msi_domains(port);
-}
-
 static inline void mc_clear_secs(struct mc_pcie *port)
 {
 	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
@@ -658,66 +598,6 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int plda_init_interrupts(struct platform_device *pdev,
-				struct plda_pcie_rp *port, struct plda_evt *evt)
-{
-	struct device *dev = &pdev->dev;
-	int irq;
-	int i, intx_irq, msi_irq, event_irq;
-	int ret;
-
-	ret = plda_pcie_init_irq_domains(port, evt);
-	if (ret) {
-		dev_err(dev, "failed creating IRQ domains\n");
-		return ret;
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return -ENODEV;
-
-	for (i = 0; i < port->num_events; i++) {
-		event_irq = irq_create_mapping(port->event_domain, i);
-		if (!event_irq) {
-			dev_err(dev, "failed to map hwirq %d\n", i);
-			return -ENXIO;
-		}
-
-		if (evt->request_evt_irq)
-			ret = evt->request_evt_irq(port, event_irq, i);
-		else
-			ret = devm_request_irq(dev, event_irq, plda_event_handler,
-					       0, NULL, port);
-		if (ret) {
-			dev_err(dev, "failed to request IRQ %d\n", event_irq);
-			return ret;
-		}
-	}
-
-	intx_irq = irq_create_mapping(port->event_domain,
-				      evt->intx_evt);
-	if (!intx_irq) {
-		dev_err(dev, "failed to map INTx interrupt\n");
-		return -ENXIO;
-	}
-
-	/* Plug the INTx chained handler */
-	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
-
-	msi_irq = irq_create_mapping(port->event_domain,
-				     evt->msi_evt);
-	if (!msi_irq)
-		return -ENXIO;
-
-	/* Plug the MSI chained handler */
-	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
-
-	/* Plug the main event chained handler */
-	irq_set_chained_handler_and_data(irq, mc_handle_event, port);
-
-	return 0;
-}
-
 static int mc_request_evt_irq(struct plda_pcie_rp *plda, int event_irq,
 			      int evt)
 {
@@ -725,6 +605,10 @@ static int mc_request_evt_irq(struct plda_pcie_rp *plda, int event_irq,
 				0, event_cause[evt].sym, plda);
 }
 
+static const struct plda_pcie_ops plda_ops = {
+	.get_events = get_events,
+};
+
 static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -773,6 +657,7 @@ static int mc_host_probe(struct platform_device *pdev)
 	plda = &port->plda;
 	plda->dev = dev;
 	plda->num_events = NUM_EVENTS;
+	plda->ops = &plda_ops;
 
 	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(port->axi_base_addr))
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index bf63f220a518..73a7c10d379d 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -20,7 +20,7 @@
 
 #include "pcie-plda.h"
 
-void plda_handle_msi(struct irq_desc *desc)
+static void plda_handle_msi(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -83,7 +83,7 @@ static struct irq_chip plda_msi_bottom_irq_chip = {
 	.irq_set_affinity = plda_msi_set_affinity,
 };
 
-int plda_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+static int plda_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				     unsigned int nr_irqs, void *args)
 {
 	struct plda_pcie_rp *port = domain->host_data;
@@ -142,7 +142,7 @@ static struct msi_domain_info plda_msi_domain_info = {
 	.chip = &plda_msi_irq_chip,
 };
 
-int plda_allocate_msi_domains(struct plda_pcie_rp *port)
+static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
 	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
@@ -168,7 +168,7 @@ int plda_allocate_msi_domains(struct plda_pcie_rp *port)
 	return 0;
 }
 
-void plda_handle_intx(struct irq_desc *desc)
+static void plda_handle_intx(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -241,7 +241,7 @@ static struct irq_chip plda_intx_irq_chip = {
 	.irq_unmask = plda_unmask_intx_irq,
 };
 
-int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
 	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
@@ -250,12 +250,16 @@ int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 	return 0;
 }
 
-irqreturn_t plda_event_handler(int irq, void *dev_id)
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = plda_pcie_intx_map,
+};
+
+static irqreturn_t plda_event_handler(int irq, void *dev_id)
 {
 	return IRQ_HANDLED;
 }
 
-void plda_handle_event(struct irq_desc *desc)
+static void plda_handle_event(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -264,14 +268,18 @@ void plda_handle_event(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	val = readl_relaxed(port->bridge_addr + ISTATUS_LOCAL);
-	origin = val;
-	val = val >> A_ATR_EVT_POST_ERR_SHIFT;
-	events |= val & 0xff;
-	if (origin & PM_MSI_INT_INTX_MASK)
-		events |= BIT(EVENT_PM_MSI_INT_INTX);
-	val = (origin >> PM_MSI_INT_MSI_SHIFT) & 0xf;
-	events |= val << EVENT_PM_MSI_INT_MSI;
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
 
 	for_each_set_bit(bit, &events, port->num_events)
 		generic_handle_domain_irq(port->event_domain, bit);
@@ -349,6 +357,108 @@ static const struct irq_domain_ops plda_evt_dom_ops = {
 	.map = plda_pcie_event_map,
 };
 
+static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port, struct plda_evt *evt)
+{
+	struct device *dev = port->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *pcie_intc_node;
+	const struct irq_domain_ops *ops;
+
+	/* Setup INTx */
+	pcie_intc_node = of_get_next_child(node, NULL);
+	if (!pcie_intc_node) {
+		dev_err(dev, "failed to find PCIe Intc node\n");
+		return -EINVAL;
+	}
+
+	ops = evt->domain_ops ? evt->domain_ops : &plda_evt_dom_ops;
+	port->event_domain = irq_domain_add_linear(pcie_intc_node, port->num_events,
+						   ops, port);
+	if (!port->event_domain) {
+		dev_err(dev, "failed to get event domain\n");
+		of_node_put(pcie_intc_node);
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(port->event_domain, DOMAIN_BUS_NEXUS);
+
+	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						  &intx_domain_ops, port);
+	if (!port->intx_domain) {
+		dev_err(dev, "failed to get an INTx IRQ domain\n");
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
+int plda_init_interrupts(struct platform_device *pdev,
+			 struct plda_pcie_rp *port, struct plda_evt *evt)
+{
+	struct device *dev = &pdev->dev;
+	int irq;
+	int i, intx_irq, msi_irq, event_irq;
+	int ret;
+
+	ret = plda_pcie_init_irq_domains(port, evt);
+	if (ret) {
+		dev_err(dev, "failed creating IRQ domains\n");
+		return ret;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENODEV;
+
+	for (i = 0; i < port->num_events; i++) {
+		event_irq = irq_create_mapping(port->event_domain, i);
+		if (!event_irq) {
+			dev_err(dev, "failed to map hwirq %d\n", i);
+			return -ENXIO;
+		}
+
+		if (evt->request_evt_irq)
+			ret = evt->request_evt_irq(port, event_irq, i);
+		else
+			ret = devm_request_irq(dev, event_irq, plda_event_handler,
+					       0, NULL, port);
+		if (ret) {
+			dev_err(dev, "failed to request IRQ %d\n", event_irq);
+			return ret;
+		}
+	}
+
+	intx_irq = irq_create_mapping(port->event_domain,
+				      evt->intx_evt);
+	if (!intx_irq) {
+		dev_err(dev, "failed to map INTx interrupt\n");
+		return -ENXIO;
+	}
+
+	/* Plug the INTx chained handler */
+	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
+
+	msi_irq = irq_create_mapping(port->event_domain,
+				     evt->msi_evt);
+	if (!msi_irq)
+		return -ENXIO;
+
+	/* Plug the MSI chained handler */
+	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
+
+	/* Plug the main event chained handler */
+	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(plda_init_interrupts);
+
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size)
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 7571b0bbf37f..099a4fdd1148 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -107,6 +107,12 @@
 
 #define PM_MSI_TO_MASK_OFFSET			19
 
+struct plda_pcie_rp;
+
+struct plda_pcie_ops {
+	u32 (*get_events)(struct plda_pcie_rp *pcie);
+};
+
 struct plda_msi {
 	struct mutex lock;		/* Protect used bitmap */
 	struct irq_domain *msi_domain;
@@ -122,6 +128,7 @@ struct plda_pcie_rp {
 	struct irq_domain *event_domain;
 	raw_spinlock_t lock;
 	struct plda_msi msi;
+	const struct plda_pcie_ops *ops;
 	void __iomem *bridge_addr;
 	int num_events;
 };
@@ -133,12 +140,8 @@ struct plda_evt {
 	int msi_evt;
 };
 
-void plda_handle_msi(struct irq_desc *desc);
-int plda_allocate_msi_domains(struct plda_pcie_rp *port);
-irqreturn_t plda_event_handler(int irq, void *dev_id);
-void plda_handle_intx(struct irq_desc *desc);
-int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-		       irq_hw_number_t hwirq);
+int plda_init_interrupts(struct platform_device *pdev,
+			 struct plda_pcie_rp *port, struct plda_evt *evt);
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size);
-- 
2.17.1

