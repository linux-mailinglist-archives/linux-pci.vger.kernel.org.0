Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25F8665BD8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 13:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbjAKMyZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 07:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbjAKMyC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 07:54:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133CF15F35;
        Wed, 11 Jan 2023 04:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673441641; x=1704977641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d3ILmxLhUQCg16hzLFqT6vDkBfV/GFcRb/040yX8hPI=;
  b=siESYRlYcIag5zKexm+C02QI6bjHbmJbbVGEUPBgidXQNcYeFrSDM22Z
   VrdV1B1t1fMkdoIIsfFhJufpzjELPhiCDeytiO/6B5lawLHW9W1FAwdxs
   rZy8WNID3RpqrV/t0kfDZUAG38yFfnwhhcW5kcz6Pc4DzeZ2ZxV30bQCO
   RV9sSMCuBAjV7H4+ryp8bJMmPDDuHkKn9uDeaxIzM6OSuQ74IkDFDXDwP
   pJivdIPUKL2dnf7tHCTQWjrGeIOtmboeKu6Ja647IDXiDdCaZ0EtHd1hU
   gzBXtAVIRfFZH9ocyuzOI6VAlUpQ5W8D2HAZmQsFXuMG+G9btzg/raS3P
   A==;
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="195261380"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2023 05:54:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 05:53:58 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 05:53:56 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v3 10/11] PCI: microchip: Partition inbound address translation
Date:   Wed, 11 Jan 2023 12:53:22 +0000
Message-ID: <20230111125323.1911373-11-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
References: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
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

On Microchip PolarFire SoC the PCIe Root Port is behind a set of Fabric
Interface Controller (FIC) buses that encapsulate buses like ABP/AHP,
AXI-S, and AXI-M. Depending on which FIC(s) the Root Port is wired
through to cpu space, the Root Port driver needs to take account of the
address translation done by a parent (e.g. fabric) node before setting
up its own inbound address translation tables from attached devices.

Parse the dma-range properties to determine how much address translation
to perform in the Root Port and how much is being provided by the
fabric.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 178 ++++++++++++++++++-
 1 file changed, 172 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index f3dfcdf39c8a..2eb70fd01879 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -22,6 +22,9 @@
 /* Number of MSI IRQs */
 #define MC_MAX_NUM_MSI_IRQS			32
 
+#define MC_MAX_NUM_INBOUND_WINDOWS		8
+#define MC_ATT_MASK				GENMASK_ULL(63, 31)
+
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
 #define MC_PCIE1_CTRL_ADDR			0x0000a000u
@@ -86,10 +89,13 @@
 #define ISTATUS_MSI				0x194
 
 #define ATR_WINDOW_DESC_SIZE			32
-#define ATR_PCIE_ATR_SIZE			0x25
 #define ATR_SIZE_SHIFT				1
 #define ATR_IMPL_ENABLE				1
 
+#define ATR_PCIE_WIN0_SRCADDR			0x80000000
+#define ATR_PCIE_ATR_SIZE			(512 * 1024 * 1024ul)
+#define ATR_PCIE_NUM_WINDOWS			8
+
 /* PCIe Master table init defines */
 #define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
 #define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
@@ -278,6 +284,12 @@ struct mc_msi {
 	DECLARE_BITMAP(used, MC_MAX_NUM_MSI_IRQS);
 };
 
+struct inbound_windows {
+	u64 axi_addr;
+	u64 pci_addr;
+	u64 size;
+};
+
 struct mc_pcie {
 	void __iomem *axi_base_addr;
 	struct device *dev;
@@ -286,6 +298,8 @@ struct mc_pcie {
 	raw_spinlock_t lock;
 	struct mc_msi msi;
 	u64 outbound_range_offset;
+	u32 num_inbound_windows;
+	struct inbound_windows inbound_windows[MC_MAX_NUM_INBOUND_WINDOWS];
 };
 
 struct cause {
@@ -948,6 +962,43 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
 	return mc_allocate_msi_domains(port);
 }
 
+static int mc_pcie_setup_inbound_ranges(struct platform_device *pdev, struct mc_pcie *port)
+{
+	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	phys_addr_t pcie_addr;
+	phys_addr_t axi_addr;
+	u32 atr_size;
+	u32 val;
+	int i;
+
+	for (i = 0; i < port->num_inbound_windows; i++) {
+		atr_size = ilog2(port->inbound_windows[i].size) - 1;
+		atr_size &= GENMASK(5, 0);
+
+		pcie_addr = port->inbound_windows[i].pci_addr;
+
+		val = lower_32_bits(pcie_addr) & GENMASK(31, 12);
+		val |= (atr_size << ATR_SIZE_SHIFT);
+		val |= ATR_IMPL_ENABLE;
+		writel(val, bridge_base_addr +
+		       ATR0_PCIE_WIN0_SRCADDR_PARAM + (i * ATR_WINDOW_DESC_SIZE));
+		writel(upper_32_bits(pcie_addr), bridge_base_addr +
+		       ATR0_PCIE_WIN0_SRC_ADDR + (i * ATR_WINDOW_DESC_SIZE));
+
+		axi_addr = port->inbound_windows[i].axi_addr;
+
+		writel(lower_32_bits(axi_addr), bridge_base_addr +
+		       ATR0_PCIE_WIN0_TRSL_ADDR_LSB + (i * ATR_WINDOW_DESC_SIZE));
+		writel(upper_32_bits(axi_addr), bridge_base_addr +
+		       ATR0_PCIE_WIN0_TRSL_ADDR_UDW + (i * ATR_WINDOW_DESC_SIZE));
+
+		writel(TRSL_ID_AXI4_MASTER_0, bridge_base_addr +
+		       ATR0_PCIE_WIN0_TRSL_PARAM + (i * ATR_WINDOW_DESC_SIZE));
+	}
+
+	return 0;
+}
+
 static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 				 phys_addr_t axi_addr, phys_addr_t pci_addr,
 				 size_t size)
@@ -979,11 +1030,6 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	val = upper_32_bits(pci_addr);
 	writel(val, bridge_base_addr + (index * ATR_WINDOW_DESC_SIZE) +
 	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
-
-	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	val |= (ATR_PCIE_ATR_SIZE << ATR_SIZE_SHIFT);
-	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
 
 static int mc_pcie_setup_windows(struct platform_device *pdev,
@@ -1163,6 +1209,116 @@ static int mc_check_for_parent_range_handling(struct platform_device *pdev, stru
 	return 0;
 }
 
+static int mc_check_for_parent_dma_range_handling(struct platform_device *pdev,
+						  struct mc_pcie *port)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *dn = dev->of_node;
+	struct of_range_parser parser;
+	struct of_range range;
+	int num_parent_ranges = 0;
+	int num_ranges = 0;
+	struct inbound_windows ranges[MC_MAX_NUM_INBOUND_WINDOWS] = { 0 };
+	u64 start_axi = GENMASK_ULL(63, 0);
+	u64 end_axi = 0;
+	u64 start_pci = GENMASK_ULL(63, 0);
+	s64 size;
+	u64 window_size;
+	int i;
+
+	/* Find all dma-ranges */
+	if (of_pci_dma_range_parser_init(&parser, dn)) {
+		dev_err(dev, "missing dma-ranges property\n");
+		return -EINVAL;
+	}
+
+	for_each_of_range(&parser, &range) {
+		if (num_ranges > MC_MAX_NUM_INBOUND_WINDOWS) {
+			dev_err(dev, "too many inbound ranges; %d available tables\n",
+				MC_MAX_NUM_INBOUND_WINDOWS);
+			return -EINVAL;
+		}
+		ranges[num_ranges].axi_addr = range.cpu_addr;
+		ranges[num_ranges].pci_addr = range.pci_addr;
+		ranges[num_ranges].size = range.size;
+
+		num_ranges++;
+	}
+
+	/*
+	 * Check for one level up; will need to adjust address translation
+	 * tables for these
+	 */
+	dn = of_get_parent(dn);
+	if (dn) {
+		of_pci_dma_range_parser_init(&parser, dn);
+
+		for_each_of_range(&parser, &range) {
+			if (num_parent_ranges > MC_MAX_NUM_INBOUND_WINDOWS) {
+				dev_err(dev, "too many parent inbound ranges; %d available tables\n",
+					MC_MAX_NUM_INBOUND_WINDOWS);
+				return -EINVAL;
+			}
+			ranges[num_parent_ranges].axi_addr = range.pci_addr;
+			num_parent_ranges++;
+		}
+	}
+
+	if (num_parent_ranges) {
+		if (num_ranges != num_parent_ranges) {
+			dev_err(dev, "num parent inbound ranges must be 0 or match num inbound ranges\n");
+			return -EINVAL;
+		}
+	}
+
+	/* Merge ranges */
+	for (i = 0; i < num_ranges; i++) {
+		struct inbound_windows *range = &ranges[i];
+
+		if (range->axi_addr < start_axi) {
+			start_axi = range->axi_addr;
+			start_pci = range->pci_addr;
+		}
+
+		if (range->axi_addr + range->size > end_axi)
+			end_axi = range->axi_addr + range->size;
+	}
+
+	/* Move starts back as far as possible */
+	start_axi &= MC_ATT_MASK;
+	start_pci &= MC_ATT_MASK;
+
+	/* Adjust size to take account of that change */
+	size = end_axi - start_axi;
+
+	/* May need to adjust size up to the next largest power of 2 */
+	if (size < 1ull << ilog2(size))
+		size = 1ull << (ilog2(size) + 1);
+
+	window_size = 1ull << (ilog2(size) - 1);
+
+	/* Divide merged range into windows */
+	i = 0;
+	while (size > 0 && i < MC_MAX_NUM_INBOUND_WINDOWS) {
+		port->inbound_windows[i].axi_addr = start_axi;
+		port->inbound_windows[i].pci_addr = start_pci;
+		port->inbound_windows[i].size = window_size;
+
+		size -= window_size;
+		start_axi += window_size;
+		start_pci += window_size;
+		i++;
+		port->num_inbound_windows = i;
+	}
+
+	if (size < 0) {
+		dev_err(dev, "insufficient windows to map inbound ranges\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -1180,6 +1336,11 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
+	/* And similarly, check for inbound address translation */
+	ret = mc_check_for_parent_dma_range_handling(pdev, port);
+	if (ret)
+		return ret;
+
 	/* Configure address translation table 0 for PCIe config space */
 	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start - port->outbound_range_offset,
 			     cfg->res.start - port->outbound_range_offset,
@@ -1193,6 +1354,11 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
+	/* Configure inbound translation tables */
+	ret = mc_pcie_setup_inbound_ranges(pdev, port);
+	if (ret)
+		return ret;
+
 	/* Address translation is up; safe to enable interrupts */
 	ret = mc_init_interrupts(pdev, port);
 	if (ret)
-- 
2.25.1

