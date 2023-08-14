Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C10477B3F1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 10:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjHNIVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjHNIU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 04:20:29 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55F0106;
        Mon, 14 Aug 2023 01:20:27 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E523B24E2AE;
        Mon, 14 Aug 2023 16:20:25 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:20:25 +0800
Received: from ubuntu.localdomain (183.27.98.20) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:20:24 +0800
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
Subject: [PATCH v3 07/11] PCI: microchip: Rename IRQ init function
Date:   Mon, 14 Aug 2023 16:20:12 +0800
Message-ID: <20230814082016.104181-8-minda.chen@starfivetech.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename IRQ init function and prepare for re-use
IRQ init function.

rename list:
mc_init_interrupts -> plda_init_interrupts
mc_pcie_init_irq_domain-> plda_pcie_init_irq_domains

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 37 +++++++++++++------
 drivers/pci/controller/plda/pcie-plda.h       |  7 ++++
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index b42f1aac3ec3..140e7ca1a5cb 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -559,7 +559,7 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
-static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
+static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port, struct plda_evt *evt)
 {
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
@@ -572,8 +572,8 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 		return -EINVAL;
 	}
 
-	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
-						   &event_domain_ops, port);
+	port->event_domain = irq_domain_add_linear(pcie_intc_node, port->num_events,
+						   evt->domain_ops, port);
 	if (!port->event_domain) {
 		dev_err(dev, "failed to get event domain\n");
 		of_node_put(pcie_intc_node);
@@ -658,14 +658,15 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
+static int plda_init_interrupts(struct platform_device *pdev,
+				struct plda_pcie_rp *port, struct plda_evt *evt)
 {
 	struct device *dev = &pdev->dev;
 	int irq;
 	int i, intx_irq, msi_irq, event_irq;
 	int ret;
 
-	ret = mc_pcie_init_irq_domains(port);
+	ret = plda_pcie_init_irq_domains(port, evt);
 	if (ret) {
 		dev_err(dev, "failed creating IRQ domains\n");
 		return ret;
@@ -675,15 +676,18 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
 	if (irq < 0)
 		return -ENODEV;
 
-	for (i = 0; i < NUM_EVENTS; i++) {
+	for (i = 0; i < port->num_events; i++) {
 		event_irq = irq_create_mapping(port->event_domain, i);
 		if (!event_irq) {
 			dev_err(dev, "failed to map hwirq %d\n", i);
 			return -ENXIO;
 		}
 
-		ret = devm_request_irq(dev, event_irq, mc_event_handler,
-				       0, event_cause[i].sym, port);
+		if (evt->request_evt_irq)
+			ret = evt->request_evt_irq(port, event_irq, i);
+		else
+			ret = devm_request_irq(dev, event_irq, plda_event_handler,
+					       0, NULL, port);
 		if (ret) {
 			dev_err(dev, "failed to request IRQ %d\n", event_irq);
 			return ret;
@@ -691,7 +695,7 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
 	}
 
 	intx_irq = irq_create_mapping(port->event_domain,
-				      EVENT_LOCAL_PM_MSI_INT_INTX);
+				      evt->intx_evt);
 	if (!intx_irq) {
 		dev_err(dev, "failed to map INTx interrupt\n");
 		return -ENXIO;
@@ -701,7 +705,7 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
 	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
 
 	msi_irq = irq_create_mapping(port->event_domain,
-				     EVENT_LOCAL_PM_MSI_INT_MSI);
+				     evt->msi_evt);
 	if (!msi_irq)
 		return -ENXIO;
 
@@ -714,6 +718,13 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
 	return 0;
 }
 
+static int mc_request_evt_irq(struct plda_pcie_rp *plda, int event_irq,
+			      int evt)
+{
+	return devm_request_irq(plda->dev, event_irq, mc_event_handler,
+				0, event_cause[evt].sym, plda);
+}
+
 static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -721,6 +732,9 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
+	struct plda_evt evt = {&event_domain_ops, mc_request_evt_irq,
+			       EVENT_LOCAL_PM_MSI_INT_INTX,
+			       EVENT_LOCAL_PM_MSI_INT_MSI};
 	int ret;
 
 	/* Configure address translation table 0 for PCIe config space */
@@ -737,7 +751,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return ret;
 
 	/* Address translation is up; safe to enable interrupts */
-	ret = mc_init_interrupts(pdev, &port->plda);
+	ret = plda_init_interrupts(pdev, &port->plda, &evt);
 	if (ret)
 		return ret;
 
@@ -758,6 +772,7 @@ static int mc_host_probe(struct platform_device *pdev)
 
 	plda = &port->plda;
 	plda->dev = dev;
+	plda->num_events = NUM_EVENTS;
 
 	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(port->axi_base_addr))
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 56483ebb678d..7571b0bbf37f 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -126,6 +126,13 @@ struct plda_pcie_rp {
 	int num_events;
 };
 
+struct plda_evt {
+	const struct irq_domain_ops *domain_ops;
+	int (*request_evt_irq)(struct plda_pcie_rp *pcie, int evt_irq, int event);
+	int intx_evt;
+	int msi_evt;
+};
+
 void plda_handle_msi(struct irq_desc *desc);
 int plda_allocate_msi_domains(struct plda_pcie_rp *port);
 irqreturn_t plda_event_handler(int irq, void *dev_id);
-- 
2.17.1

