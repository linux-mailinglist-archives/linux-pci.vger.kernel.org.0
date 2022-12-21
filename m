Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014946533E8
	for <lists+linux-pci@lfdr.de>; Wed, 21 Dec 2022 17:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLUQ1A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Dec 2022 11:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiLUQ0u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2022 11:26:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD2822516;
        Wed, 21 Dec 2022 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671640008; x=1703176008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yg77R9/0SlYotqT/uDCCo0A3oEcsPEczZsq0iSXM/t0=;
  b=K4SDOxBORslrxjOjSMcgC0m0ham/S5yWSGWe+FTf4x5HsRroZvgGGmZ0
   mi/2q0Vs0BWFeszZDidxJf69aAmDj9bhGAwsOy8jrtu7mSlDva89WtCZy
   FNBep+r7y1Dx7d4/d57AFe3XZgsH4S+/UDfwnhaCuX/mmkiT5vIX+wWsh
   xPBJzJHuuzFQw7A2/1iYT6RTURFCwwGSw2tP1/TzTpQDBMyY55I5IwyZ+
   8G50wiTl2l/Wv86COVBtlTn3+6D9errkRIx/k69HKsvTZD52OG6Esl3hP
   kp7qfa8G9wzpfL9T3vqTkYcfzo5FcJYnlruDJWfucU3tw+b6Uqht3docI
   w==;
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="204941815"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Dec 2022 09:26:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 09:26:46 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 09:26:44 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v2 4/9] PCI: microchip: Clean up initialisation of interrupts
Date:   Wed, 21 Dec 2022 16:26:25 +0000
Message-ID: <20221221162630.3632486-5-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221221162630.3632486-1-daire.mcnamara@microchip.com>
References: <20221221162630.3632486-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Refactor interrupt handling in _init() function into
disable_interrupts(), init_interrupts(), clear_sec_errors() and clear
ded_errors().  It was unwieldy and prone to bugs. Then clearly disable
interrupts as soon as possible and only enable interrupts after address
translation is setup to prevent spurious axi2pcie and pcie2axi
translation errors being reported

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 156 ++++++++++++-------
 1 file changed, 100 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index a81e6d25e347..7b212eea42d2 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -112,6 +112,7 @@
 #define  SEC_ERROR_INT_RX_RAM_SEC_ERR_INT	GENMASK(7, 4)
 #define  SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT	GENMASK(11, 8)
 #define  SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT	GENMASK(15, 12)
+#define  SEC_ERROR_INT_ALL_RAM_SEC_ERR_INT	GENMASK(15, 0)
 #define  NUM_SEC_ERROR_INTS			(4)
 #define SEC_ERROR_INT_MASK			0x2c
 #define DED_ERROR_INT				0x30
@@ -119,6 +120,7 @@
 #define  DED_ERROR_INT_RX_RAM_DED_ERR_INT	GENMASK(7, 4)
 #define  DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT	GENMASK(11, 8)
 #define  DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT	GENMASK(15, 12)
+#define  DED_ERROR_INT_ALL_RAM_DED_ERR_INT	GENMASK(15, 0)
 #define  NUM_DED_ERROR_INTS			(4)
 #define DED_ERROR_INT_MASK			0x34
 #define ECC_CONTROL				0x38
@@ -986,39 +988,73 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
 	return 0;
 }
 
-static int mc_platform_init(struct pci_config_window *cfg)
+static inline void mc_clear_secs(struct mc_pcie *port)
 {
-	struct device *dev = cfg->parent;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct mc_pcie *port;
-	void __iomem *bridge_base_addr;
-	void __iomem *ctrl_base_addr;
-	int ret;
-	int irq;
-	int i, intx_irq, msi_irq, event_irq;
+	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
+
+	writel_relaxed(SEC_ERROR_INT_ALL_RAM_SEC_ERR_INT, ctrl_base_addr +
+		       SEC_ERROR_INT);
+	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_EVENT_CNT);
+}
+
+static inline void mc_clear_deds(struct mc_pcie *port)
+{
+	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
+
+	writel_relaxed(DED_ERROR_INT_ALL_RAM_DED_ERR_INT, ctrl_base_addr +
+		       DED_ERROR_INT);
+	writel_relaxed(0, ctrl_base_addr + DED_ERROR_EVENT_CNT);
+}
+
+static void mc_disable_interrupts(struct mc_pcie *port)
+{
+	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
 	u32 val;
-	int err;
 
-	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-	if (!port)
-		return -ENOMEM;
-	port->dev = dev;
+	/* Ensure ECC bypass is enabled */
+	val = ECC_CONTROL_TX_RAM_ECC_BYPASS |
+	      ECC_CONTROL_RX_RAM_ECC_BYPASS |
+	      ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS |
+	      ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS;
+	writel_relaxed(val, ctrl_base_addr + ECC_CONTROL);
 
-	ret = mc_pcie_init_clks(dev);
-	if (ret) {
-		dev_err(dev, "failed to get clock resources, error %d\n", ret);
-		return -ENODEV;
-	}
+	/* Disable SEC errors and clear any outstanding */
+	writel_relaxed(SEC_ERROR_INT_ALL_RAM_SEC_ERR_INT, ctrl_base_addr +
+		       SEC_ERROR_INT_MASK);
+	mc_clear_secs(port);
 
-	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(port->axi_base_addr))
-		return PTR_ERR(port->axi_base_addr);
+	/* Disable DED errors and clear any outstanding */
+	writel_relaxed(DED_ERROR_INT_ALL_RAM_DED_ERR_INT, ctrl_base_addr +
+		       DED_ERROR_INT_MASK);
+	mc_clear_deds(port);
 
-	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
+	/* Disable local interrupts and clear any outstanding */
+	writel_relaxed(0, bridge_base_addr + IMASK_LOCAL);
+	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_LOCAL);
+	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_MSI);
+
+	/* Disable PCIe events and clear any outstanding */
+	val = PCIE_EVENT_INT_L2_EXIT_INT |
+	      PCIE_EVENT_INT_HOTRST_EXIT_INT |
+	      PCIE_EVENT_INT_DLUP_EXIT_INT |
+	      PCIE_EVENT_INT_L2_EXIT_INT_MASK |
+	      PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK |
+	      PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
+	writel_relaxed(val, ctrl_base_addr + PCIE_EVENT_INT);
+
+	/* Disable host interrupts and clear any outstanding */
+	writel_relaxed(0, bridge_base_addr + IMASK_HOST);
+	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
+}
+
+static int mc_init_interrupts(struct platform_device *pdev, struct mc_pcie *port)
+{
+	struct device *dev = &pdev->dev;
+	int irq;
+	int i, intx_irq, msi_irq, event_irq;
+	int ret;
 
-	port->msi.vector_phy = MSI_ADDR;
-	port->msi.num_vectors = MC_NUM_MSI_IRQS;
 	ret = mc_pcie_init_irq_domains(port);
 	if (ret) {
 		dev_err(dev, "failed creating IRQ domains\n");
@@ -1036,11 +1072,11 @@ static int mc_platform_init(struct pci_config_window *cfg)
 			return -ENXIO;
 		}
 
-		err = devm_request_irq(dev, event_irq, mc_event_handler,
+		ret = devm_request_irq(dev, event_irq, mc_event_handler,
 				       0, event_cause[i].sym, port);
-		if (err) {
+		if (ret) {
 			dev_err(dev, "failed to request IRQ %d\n", event_irq);
-			return err;
+			return ret;
 		}
 	}
 
@@ -1065,44 +1101,52 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	/* Plug the main event chained handler */
 	irq_set_chained_handler_and_data(irq, mc_handle_event, port);
 
-	/* Hardware doesn't setup MSI by default */
-	mc_pcie_enable_msi(port, cfg->win);
+	return 0;
+}
 
-	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
-	val |= PM_MSI_INT_INTX_MASK;
-	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
+static int mc_platform_init(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mc_pcie *port;
+	void __iomem *bridge_base_addr;
+	int ret;
 
-	writel_relaxed(val, ctrl_base_addr + ECC_CONTROL);
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+	port->dev = dev;
 
-	val = PCIE_EVENT_INT_L2_EXIT_INT |
-	      PCIE_EVENT_INT_HOTRST_EXIT_INT |
-	      PCIE_EVENT_INT_DLUP_EXIT_INT;
-	writel_relaxed(val, ctrl_base_addr + PCIE_EVENT_INT);
+	ret = mc_pcie_init_clks(dev);
+	if (ret) {
+		dev_err(dev, "failed to get clock resources, error %d\n", ret);
+		return -ENODEV;
+	}
 
-	val = SEC_ERROR_INT_TX_RAM_SEC_ERR_INT |
-	      SEC_ERROR_INT_RX_RAM_SEC_ERR_INT |
-	      SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT |
-	      SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT;
-	writel_relaxed(val, ctrl_base_addr + SEC_ERROR_INT);
-	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_INT_MASK);
-	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_EVENT_CNT);
+	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(port->axi_base_addr))
+		return PTR_ERR(port->axi_base_addr);
 
-	val = DED_ERROR_INT_TX_RAM_DED_ERR_INT |
-	      DED_ERROR_INT_RX_RAM_DED_ERR_INT |
-	      DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT |
-	      DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT;
-	writel_relaxed(val, ctrl_base_addr + DED_ERROR_INT);
-	writel_relaxed(0, ctrl_base_addr + DED_ERROR_INT_MASK);
-	writel_relaxed(0, ctrl_base_addr + DED_ERROR_EVENT_CNT);
+	mc_disable_interrupts(port);
 
-	writel_relaxed(0, bridge_base_addr + IMASK_HOST);
-	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
+	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+
+	port->msi.vector_phy = MSI_ADDR;
+	port->msi.num_vectors = MC_NUM_MSI_IRQS;
+
+	/* Hardware doesn't setup MSI by default */
+	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure Address Translation Table 0 for PCIe config space */
 	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
 			     cfg->res.start, resource_size(&cfg->res));
 
-	return mc_pcie_setup_windows(pdev, port);
+	ret = mc_pcie_setup_windows(pdev, port);
+	if (ret)
+		return ret;
+
+	/* Address translation is up; safe to enable interrupts */
+	return mc_init_interrupts(pdev, port);
 }
 
 static const struct pci_ecam_ops mc_ecam_ops = {
-- 
2.25.1

