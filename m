Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA81B743F2F
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 17:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjF3Ptf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjF3Pte (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 11:49:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC93A89
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688140169; x=1719676169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z3xYhVEx72Z+f9tvRKEXppzoishp+v+MhHnaBZz+XpI=;
  b=avAaVE0dFeFbNli/0M9roTgKWdifUbwhRi3OieYISP7s4OmNoHx3jkF8
   vygwtOq9xUUgptk9NUU5NaL3UjBkYgwUS1R2X8ag2O8ZVkoxKD6f8FmAf
   iE4/u+xq6q23xZnclcicadJ4Odvy6JFPSEgnFiEfKbaTMcxlSdpBkKY37
   ymoZ2jrsLlsqrALF67qtlVCS7tZECnjwxxqA498ySW1HNg8u5Ze++ioHJ
   V08p36qahxzMbJXr27SbAXGXYVZdhnqxcOXTSaRsaovIW179gZTDNUqbB
   CbblsG+/P3EkenoGVoiJnVAi8djfEuEl76AMO5t+KnSEcZ8nfGGC/cVa1
   g==;
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="233133677"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2023 08:49:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 30 Jun 2023 08:49:21 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 30 Jun 2023 08:49:19 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 8/8] PCI: microchip: Re-partition code between probe() and init()
Date:   Fri, 30 Jun 2023 16:48:59 +0100
Message-ID: <20230630154859.2049521-9-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630154859.2049521-1-daire.mcnamara@microchip.com>
References: <20230630154859.2049521-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Continuing to use pci_host_common_probe() for the PCIe Root Complex on
PolarFire SoC was leading to an extremely large _init() function and
some unnatural code flow. Re-partition so some tasks are done in
a _probe() routine, which calls pci_host_common_probe() and then use a
much smaller _init() function, mainly to enable interrupts after address
translation tables are set up.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 58 +++++++++++++-------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 5bb467de9cc5..2ba96d7f9095 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -383,6 +383,8 @@ static struct {
 
 static char poss_clks[][5] = { "fic0", "fic1", "fic2", "fic3" };
 
+static struct mc_pcie *port;
+
 static void mc_pcie_fixup_ecam(struct mc_pcie *port, void __iomem *ecam)
 {
 	struct mc_msi *msi = &port->msi;
@@ -1105,7 +1107,34 @@ static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct mc_pcie *port;
+	void __iomem *bridge_base_addr =
+		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	int ret;
+
+	/* Configure address translation table 0 for PCIe config space */
+	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
+			     cfg->res.start,
+			     resource_size(&cfg->res));
+
+	/* Need some fixups in config space */
+	mc_pcie_fixup_ecam(port, cfg->win);
+
+	/* Configure non-config space outbound ranges */
+	ret = mc_pcie_setup_windows(pdev, port);
+	if (ret)
+		return ret;
+
+	/* Address translation is up; safe to enable interrupts */
+	ret = mc_init_interrupts(pdev, port);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mc_host_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
 	void __iomem *bridge_base_addr;
 	int ret;
 	u32 val;
@@ -1113,13 +1142,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
-	port->dev = dev;
 
-	ret = mc_pcie_init_clks(dev);
-	if (ret) {
-		dev_err(dev, "failed to get clock resources, error %d\n", ret);
-		return -ENODEV;
-	}
+	port->dev = dev;
 
 	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(port->axi_base_addr))
@@ -1141,22 +1165,16 @@ static int mc_platform_init(struct pci_config_window *cfg)
 
 	port->msi.num_vectors = 1 << val;
 
-	/* Need some fixups for MSI in config space */
-	mc_pcie_fixup_ecam(port, cfg->win);
-
 	/* Pick vector address from design */
 	port->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
 
-	/* Configure Address Translation Table 0 for PCIe config space */
-	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
-			     cfg->res.start, resource_size(&cfg->res));
-
-	ret = mc_pcie_setup_windows(pdev, port);
-	if (ret)
-		return ret;
+	ret = mc_pcie_init_clks(dev);
+	if (ret) {
+		dev_err(dev, "failed to get clock resources, error %d\n", ret);
+		return -ENODEV;
+	}
 
-	/* Address translation is up; safe to enable interrupts */
-	return mc_init_interrupts(pdev, port);
+	return pci_host_common_probe(pdev);
 }
 
 static const struct pci_ecam_ops mc_ecam_ops = {
@@ -1179,7 +1197,7 @@ static const struct of_device_id mc_pcie_of_match[] = {
 MODULE_DEVICE_TABLE(of, mc_pcie_of_match);
 
 static struct platform_driver mc_pcie_driver = {
-	.probe = pci_host_common_probe,
+	.probe = mc_host_probe,
 	.driver = {
 		.name = "microchip-pcie",
 		.of_match_table = mc_pcie_of_match,
-- 
2.25.1

