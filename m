Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF65AB48B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 16:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiIBO6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 10:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbiIBO5q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 10:57:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F331160E1;
        Fri,  2 Sep 2022 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662128557; x=1693664557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Obajmxu5RArASYmlyf62HbTUThXup5Mw1+gmQJFUCgI=;
  b=d6YKtR98ssdpcbztL0CDFMuGi1gJNqiBFlswx8XMCILe/qGgfYPaH1zK
   xMQrYUeoUH71by4xBFYIMAv1nrM7FELwwYKzTqd5Ki6g1a+9V8mBC/4jQ
   O46HUjn+FwiQrAsykPDTTqoZj1aEuYSoKAIp1xkU2vG6VwXTOQjoCXLcA
   RovohpSHOw9URqfVJ+dvGveCIEK4egnTh7SYkw76G4CM3O18KBTv2BBRj
   OurQUvKaZT4euzE1hVYbhXqNMzofLyhY9M5RgVHu5wW1p6BNLIm6Fnl+u
   qTH2hjEQAH1IHGxcBlMy4rferrC4/6kbH6WSWAtUJZvO+RVYHQWeGjBL/
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="178942567"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 07:22:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 07:22:36 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 07:22:33 -0700
From:   <daire.mcnamara@microchip.com>
To:     <aou@eecs.berkeley.edu>, <bhelgaas@google.com>,
        <conor.dooley@microchip.com>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <lpieralisi@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>, <robh@kernel.org>
CC:     <cyril.jean@microchip.com>, <padmarao.begari@microchip.com>,
        <heinrich.schuchardt@canonical.com>,
        <david.abdurachmanov@gmail.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v1 3/4] PCI: microchip: add fabric address translation properties
Date:   Fri, 2 Sep 2022 15:22:01 +0100
Message-ID: <20220902142202.2437658-4-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
References: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

On PolarFire SoC both in- & out-bound address translations occur in two
stages. The specific translations are tightly coupled to the FPGA
designs and supplement the {dma-,}ranges properties. The first stage of
the translation is done by the FPGA fabric & the second by the root
port.
Use outbound address translation information so that the translation
tables in the root port's bridge layer can be configured to account for
any translation done by the FPGA fabric, for example,  on Icicle Kit
reference design.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 59 +++++++++++++++++---
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 7263d175b5ad..d78745eaa4b4 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -269,6 +269,8 @@ struct mc_pcie {
 	struct irq_domain *event_domain;
 	raw_spinlock_t lock;
 	struct mc_msi msi;
+	u32 num_outbound_ranges;
+	u64 outbound_range_adjustments[32];
 };
 
 struct cause {
@@ -964,6 +966,37 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
 
+static void mc_pcie_parse_outbound_range_adjustments(struct mc_pcie *port, struct device_node *np)
+{
+	const __be32 *range;
+	int range_len, num_ranges, range_size, i;
+
+	range = of_get_property(np, "microchip,outbound-fabric-translation-ranges", &range_len);
+	if (!range)
+		return;
+
+	num_ranges = of_n_addr_cells(np);
+	range_size = range_len / sizeof(__be32) / num_ranges;
+
+	for (i = 0; i < num_ranges; i++, range += range_size) {
+		u64 pcieaddr = of_read_number(range + 1, 2);
+		u64 cpuaddr = of_read_number(range + 3, 2);
+
+		port->outbound_range_adjustments[i] = cpuaddr - pcieaddr;
+		port->num_outbound_ranges++;
+	}
+}
+
+static inline u64 mc_pcie_adjust_axi(struct mc_pcie *port, int index, u64 axi_addr)
+{
+	u64 offset = 0;
+
+	if (index < port->num_outbound_ranges)
+		offset = port->outbound_range_adjustments[index];
+
+	return axi_addr - offset;
+}
+
 static int mc_pcie_setup_windows(struct platform_device *pdev,
 				 struct mc_pcie *port)
 {
@@ -971,14 +1004,28 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	struct resource_entry *entry;
+	u64 axi_addr;
 	u64 pci_addr;
-	u32 index = 1;
+	u32 index = 0;
+	u32 num_outbound_ranges = 0;
+
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		if (resource_type(entry->res) == IORESOURCE_MEM || resource_type(entry->res) == 0)
+			num_outbound_ranges++;
+	}
+
+	if (port->num_outbound_ranges && port->num_outbound_ranges != num_outbound_ranges) {
+		dev_err(&pdev->dev, "Mismatches in outbound range adjustment\n");
+		return -EINVAL;
+	}
 
 	resource_list_for_each_entry(entry, &bridge->windows) {
-		if (resource_type(entry->res) == IORESOURCE_MEM) {
+		if (resource_type(entry->res) == IORESOURCE_MEM || resource_type(entry->res) == 0) {
+			axi_addr = entry->res->start;
+			axi_addr = mc_pcie_adjust_axi(port, index, axi_addr);
 			pci_addr = entry->res->start - entry->offset;
 			mc_pcie_setup_window(bridge_base_addr, index,
-					     entry->res->start, pci_addr,
+					     axi_addr, pci_addr,
 					     resource_size(entry->res));
 			index++;
 		}
@@ -1005,6 +1052,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return -ENOMEM;
 	port->dev = dev;
 
+	mc_pcie_parse_outbound_range_adjustments(port, dev->of_node);
+
 	ret = mc_pcie_init_clks(dev);
 	if (ret) {
 		dev_err(dev, "failed to get clock resources, error %d\n", ret);
@@ -1099,10 +1148,6 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	writel_relaxed(0, bridge_base_addr + IMASK_HOST);
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 
-	/* Configure Address Translation Table 0 for PCIe config space */
-	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
-			     cfg->res.start, resource_size(&cfg->res));
-
 	return mc_pcie_setup_windows(pdev, port);
 }
 
-- 
2.25.1

