Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4010862C048
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 15:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiKPOA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 09:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiKPN6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 08:58:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422872DA8F;
        Wed, 16 Nov 2022 05:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668606930; x=1700142930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GVC0fqQDHO00F2S490lpyaTTUl8A651t/4LiF4d2aws=;
  b=huEXjDnEWIio6zySBPwCeCIRImXqdMTtBPJsXtk+j1VnrJqxdELM0ZtZ
   t+5uVrIK8jwiLgshde5mDM8jmrz72EUzuS0hdQwf80OWtS6+pe6bAcRby
   melRNWNgROphUZe/l3FjuWsk14t5a72EgbK/WayeLfOHXt7wMHW/Vq5Yx
   Yl3wdNeEvziFjd6Yx/bJnJeuWQOb0mU8Ra1Z+mgRvSBtL6c2YM/UZMi6f
   kqku/keAHEyXBrh9JlfmslPF7IHUmPbAyWF5aJfhEJIiS84LcrQNk5b11
   B8dxzZkyp5CVc32wF5IvZFMI2e5e/ufVkqT2ollN5NJ/S6HMtxGHFFh/Y
   g==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="123709435"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2022 06:55:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 16 Nov 2022 06:55:24 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 16 Nov 2022 06:55:22 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v1 4/9] PCI: microchip: Clean up initialisation of interrupts
Date:   Wed, 16 Nov 2022 13:54:59 +0000
Message-ID: <20221116135504.258687-5-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116135504.258687-1-daire.mcnamara@microchip.com>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
translation errors are setup to prevent spurious axi2pcie and pcie2axi
translation errors being reported

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 148 ++++++++++++-------
 1 file changed, 92 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index a81e6d25e347..ecd4d3f3e3d4 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -986,39 +986,65 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
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
+	writel_relaxed(GENMASK(15, 0), ctrl_base_addr + SEC_ERROR_INT);
+	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_EVENT_CNT);
+}
+
+static inline void mc_clear_deds(struct mc_pcie *port)
+{
+	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
+
+	writel_relaxed(GENMASK(15, 0), ctrl_base_addr + DED_ERROR_INT);
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
+	/* ensure ecc bypass is enabled */
+	val = ECC_CONTROL_TX_RAM_ECC_BYPASS | ECC_CONTROL_RX_RAM_ECC_BYPASS |
+		ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS | ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS;
+	writel_relaxed(val, ctrl_base_addr + ECC_CONTROL);
 
-	ret = mc_pcie_init_clks(dev);
-	if (ret) {
-		dev_err(dev, "failed to get clock resources, error %d\n", ret);
-		return -ENODEV;
-	}
+	/* disable sec errors and clear any outstanding */
+	writel_relaxed(GENMASK(15, 0), ctrl_base_addr + SEC_ERROR_INT_MASK);
+	mc_clear_secs(port);
 
-	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(port->axi_base_addr))
-		return PTR_ERR(port->axi_base_addr);
+	/* disable ded errors and clear any outstanding */
+	writel_relaxed(GENMASK(15, 0), ctrl_base_addr + DED_ERROR_INT_MASK);
+	mc_clear_deds(port);
 
-	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
+	/* disable local interrupts and clear any outstanding */
+	writel_relaxed(0, bridge_base_addr + IMASK_LOCAL);
+	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_LOCAL);
+	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_MSI);
+
+	/* disable PCIe events and clear any outstanding */
+	val = PCIE_EVENT_INT_L2_EXIT_INT | PCIE_EVENT_INT_HOTRST_EXIT_INT |
+	      PCIE_EVENT_INT_DLUP_EXIT_INT | PCIE_EVENT_INT_L2_EXIT_INT_MASK |
+	      PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK |
+	      PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
+	writel_relaxed(val, ctrl_base_addr + PCIE_EVENT_INT);
+
+	/* disable host interrupts and clear any outstanding */
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
@@ -1036,11 +1062,11 @@ static int mc_platform_init(struct pci_config_window *cfg)
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
 
@@ -1065,44 +1091,54 @@ static int mc_platform_init(struct pci_config_window *cfg)
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
+	void __iomem *ctrl_base_addr;
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
+	ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
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
+	/* address translation is up; safe to enable interrupts */
+	return mc_init_interrupts(pdev, port);
 }
 
 static const struct pci_ecam_ops mc_ecam_ops = {
-- 
2.25.1

