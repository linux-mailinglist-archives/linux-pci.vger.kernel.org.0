Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715B97A1BFE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 12:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjIOKXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 06:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjIOKXC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 06:23:02 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC1810DF;
        Fri, 15 Sep 2023 03:22:55 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D70038543;
        Fri, 15 Sep 2023 18:22:53 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Sep
 2023 18:22:53 +0800
Received: from ubuntu.localdomain (113.72.144.67) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Sep
 2023 18:22:52 +0800
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
Subject: [PATCH v6 09/19] PCI: microchip: Rename interrupt related functions
Date:   Fri, 15 Sep 2023 18:22:33 +0800
Message-ID: <20230915102243.59775-10-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915102243.59775-1-minda.chen@starfivetech.com>
References: <20230915102243.59775-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.67]
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

Rename mc_* to plda_* for IRQ functions and related
IRQ domain ops data instances.

MSI, INTx interrupt codes and IRQ init codes are all
can be re-used.

- function rename list:
  mc_allocate_msi_domains()  --> plda_allocate_msi_domains()
  mc_init_interrupts()       --> plda_init_interrupts()
  mc_pcie_init_irq_domain()  --> plda_pcie_init_irq_domains()
  mc_handle_event()          --> plda_handle_event()
  get_events()               --> mc_get_events()
  MSI interrupts related functions and IRQ domain
  (primary function is mc_handle_msi()):
    mc_handle_msi()          --> plda_handle_msi()
  INTx interrupts related functions and IRQ domain
  (primary function is mc_handle_intx()):
    mc_handle_intx()         --> plda_handle_intx()

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 98 +++++++++----------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index ac7126b0bacf..81aac2d72a2f 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -317,7 +317,7 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
 		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
 }
 
-static void mc_handle_msi(struct irq_desc *desc)
+static void plda_handle_msi(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -345,7 +345,7 @@ static void mc_handle_msi(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void mc_msi_bottom_irq_ack(struct irq_data *data)
+static void plda_msi_bottom_irq_ack(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -354,7 +354,7 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
 	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
 }
 
-static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	phys_addr_t addr = port->msi.vector_phy;
@@ -367,21 +367,21 @@ static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		(int)data->hwirq, msg->address_hi, msg->address_lo);
 }
 
-static int mc_msi_set_affinity(struct irq_data *irq_data,
-			       const struct cpumask *mask, bool force)
+static int plda_msi_set_affinity(struct irq_data *irq_data,
+				 const struct cpumask *mask, bool force)
 {
 	return -EINVAL;
 }
 
-static struct irq_chip mc_msi_bottom_irq_chip = {
-	.name = "Microchip MSI",
-	.irq_ack = mc_msi_bottom_irq_ack,
-	.irq_compose_msi_msg = mc_compose_msi_msg,
-	.irq_set_affinity = mc_msi_set_affinity,
+static struct irq_chip plda_msi_bottom_irq_chip = {
+	.name = "PLDA MSI",
+	.irq_ack = plda_msi_bottom_irq_ack,
+	.irq_compose_msi_msg = plda_compose_msi_msg,
+	.irq_set_affinity = plda_msi_set_affinity,
 };
 
-static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-				   unsigned int nr_irqs, void *args)
+static int plda_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs, void *args)
 {
 	struct plda_pcie_rp *port = domain->host_data;
 	struct plda_msi *msi = &port->msi;
@@ -396,7 +396,7 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	set_bit(bit, msi->used);
 
-	irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip,
+	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
 			    domain->host_data, handle_edge_irq, NULL, NULL);
 
 	mutex_unlock(&msi->lock);
@@ -404,8 +404,8 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	return 0;
 }
 
-static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-				   unsigned int nr_irqs)
+static void plda_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(d);
@@ -422,24 +422,24 @@ static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops msi_domain_ops = {
-	.alloc	= mc_irq_msi_domain_alloc,
-	.free	= mc_irq_msi_domain_free,
+	.alloc	= plda_irq_msi_domain_alloc,
+	.free	= plda_irq_msi_domain_free,
 };
 
-static struct irq_chip mc_msi_irq_chip = {
-	.name = "Microchip PCIe MSI",
+static struct irq_chip plda_msi_irq_chip = {
+	.name = "PLDA PCIe MSI",
 	.irq_ack = irq_chip_ack_parent,
 	.irq_mask = pci_msi_mask_irq,
 	.irq_unmask = pci_msi_unmask_irq,
 };
 
-static struct msi_domain_info mc_msi_domain_info = {
+static struct msi_domain_info plda_msi_domain_info = {
 	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
 		  MSI_FLAG_PCI_MSIX),
-	.chip = &mc_msi_irq_chip,
+	.chip = &plda_msi_irq_chip,
 };
 
-static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
+static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
 	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
@@ -454,7 +454,7 @@ static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
 		return -ENOMEM;
 	}
 
-	msi->msi_domain = pci_msi_create_irq_domain(fwnode, &mc_msi_domain_info,
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode, &plda_msi_domain_info,
 						    msi->dev_domain);
 	if (!msi->msi_domain) {
 		dev_err(dev, "failed to create MSI domain\n");
@@ -465,7 +465,7 @@ static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
 	return 0;
 }
 
-static void mc_handle_intx(struct irq_desc *desc)
+static void plda_handle_intx(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -492,7 +492,7 @@ static void mc_handle_intx(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void mc_ack_intx_irq(struct irq_data *data)
+static void plda_ack_intx_irq(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -501,7 +501,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
 	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
 }
 
-static void mc_mask_intx_irq(struct irq_data *data)
+static void plda_mask_intx_irq(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -516,7 +516,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static void mc_unmask_intx_irq(struct irq_data *data)
+static void plda_unmask_intx_irq(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
 	void __iomem *bridge_base_addr = port->bridge_addr;
@@ -531,24 +531,24 @@ static void mc_unmask_intx_irq(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static struct irq_chip mc_intx_irq_chip = {
-	.name = "Microchip PCIe INTx",
-	.irq_ack = mc_ack_intx_irq,
-	.irq_mask = mc_mask_intx_irq,
-	.irq_unmask = mc_unmask_intx_irq,
+static struct irq_chip plda_intx_irq_chip = {
+	.name = "PLDA PCIe INTx",
+	.irq_ack = plda_ack_intx_irq,
+	.irq_mask = plda_mask_intx_irq,
+	.irq_unmask = plda_unmask_intx_irq,
 };
 
-static int mc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-			    irq_hw_number_t hwirq)
+static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			      irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &mc_intx_irq_chip, handle_level_irq);
+	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
 
 	return 0;
 }
 
 static const struct irq_domain_ops intx_domain_ops = {
-	.map = mc_pcie_intx_map,
+	.map = plda_pcie_intx_map,
 };
 
 static inline u32 reg_to_event(u32 reg, struct event_map field)
@@ -608,7 +608,7 @@ static u32 local_events(struct mc_pcie *port)
 	return val;
 }
 
-static u32 get_events(struct plda_pcie_rp *port)
+static u32 mc_get_events(struct plda_pcie_rp *port)
 {
 	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
 	u32 events = 0;
@@ -637,7 +637,7 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void mc_handle_event(struct irq_desc *desc)
+static void plda_handle_event(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
 	unsigned long events;
@@ -646,7 +646,7 @@ static void mc_handle_event(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	events = get_events(port);
+	events = mc_get_events(port);
 
 	for_each_set_bit(bit, &events, NUM_EVENTS)
 		generic_handle_domain_irq(port->event_domain, bit);
@@ -749,7 +749,7 @@ static int mc_pcie_event_map(struct irq_domain *domain, unsigned int irq,
 	return 0;
 }
 
-static const struct irq_domain_ops event_domain_ops = {
+static const struct irq_domain_ops mc_event_domain_ops = {
 	.map = mc_pcie_event_map,
 };
 
@@ -798,7 +798,7 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
-static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
+static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
@@ -812,7 +812,7 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	}
 
 	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
-						   &event_domain_ops, port);
+						   &mc_event_domain_ops, port);
 	if (!port->event_domain) {
 		dev_err(dev, "failed to get event domain\n");
 		of_node_put(pcie_intc_node);
@@ -834,7 +834,7 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	of_node_put(pcie_intc_node);
 	raw_spin_lock_init(&port->lock);
 
-	return mc_allocate_msi_domains(port);
+	return plda_allocate_msi_domains(port);
 }
 
 static inline void mc_clear_secs(struct mc_pcie *port)
@@ -897,14 +897,14 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
+static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
 {
 	struct device *dev = &pdev->dev;
 	int irq;
 	int i, intx_irq, msi_irq, event_irq;
 	int ret;
 
-	ret = mc_pcie_init_irq_domains(port);
+	ret = plda_pcie_init_irq_domains(port);
 	if (ret) {
 		dev_err(dev, "failed creating IRQ domains\n");
 		return ret;
@@ -937,7 +937,7 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
 	}
 
 	/* Plug the INTx chained handler */
-	irq_set_chained_handler_and_data(intx_irq, mc_handle_intx, port);
+	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
 
 	msi_irq = irq_create_mapping(port->event_domain,
 				     EVENT_LOCAL_PM_MSI_INT_MSI);
@@ -945,10 +945,10 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
 		return -ENXIO;
 
 	/* Plug the MSI chained handler */
-	irq_set_chained_handler_and_data(msi_irq, mc_handle_msi, port);
+	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
 
 	/* Plug the main event chained handler */
-	irq_set_chained_handler_and_data(irq, mc_handle_event, port);
+	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
 
 	return 0;
 }
@@ -976,7 +976,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return ret;
 
 	/* Address translation is up; safe to enable interrupts */
-	ret = mc_init_interrupts(pdev, &port->plda);
+	ret = plda_init_interrupts(pdev, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.17.1

