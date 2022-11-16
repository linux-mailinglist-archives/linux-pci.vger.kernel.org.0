Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9301462C051
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 15:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiKPOA3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 09:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiKPN6U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 08:58:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1790F419A7;
        Wed, 16 Nov 2022 05:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668606947; x=1700142947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JVMVueLVB8HtkyvMUefDocGpunNluaoCVILmnKw0WGA=;
  b=vlqFubcIHft3MEMXyK34j3SRXR8XOGeDxdXJ0dPMqqWRkECacU4/J9c2
   87y5vd1x4ZlVV9WSiu6PdC35BTWGVlrQossRESlfgM6nge73oTnvD35s1
   s05wLDb7L9QIJva0AzEDBgzTLrx6MM65Tw6xduZqmTUsQidj/gqPm33Tv
   WzvpXHSMhI1Tvjl7msYzyAlZ2rDRbebdFhSqXB+gEtbaeaaqdR7LbHc2a
   d/JApQog1AmnTdI6KG5ON//8R3bMo2ef+aJPULJl0TmN8iMBztyNkLX3x
   Bc0m0U2gnfwB3R3DkF0YN/XqZCf+ETiuS5ygkbyqDhBVmk8WkSJCIJwpE
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="187263402"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2022 06:55:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 16 Nov 2022 06:55:36 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 16 Nov 2022 06:55:33 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v1 8/9] PCI: microchip: Partition inbound address translation
Date:   Wed, 16 Nov 2022 13:55:03 +0000
Message-ID: <20221116135504.258687-9-daire.mcnamara@microchip.com>
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

On Microchip PolarFire SoC the PCIe rootport is behind a set of fabric
inter connect (fic) busses that encapsulate busses like ABP/AHP, AXI-S
and AXI-M. Depending on which fic(s) the rootport is wired through to
cpu space, the rootport driver needs to take account of the address
translation done by a parent (e.g. fabric) node before setting up its
own inbound address translation tables from attached devices.

Parse the dma-range properties to determine how much address translation
to perform in the root port and how much is being provided by the
fabric.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 184 ++++++++++++++++++-
 1 file changed, 178 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 62f8c5edfd0e..a90a0a675f14 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -22,6 +22,9 @@
 /* Number of MSI IRQs */
 #define MC_MAX_NUM_MSI_IRQS			32
 
+#define MC_MAX_NUM_INBOUND_WINDOWS		8
+#define MC_ATT_MASK				GENMASK(63, 31)
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
@@ -276,6 +282,12 @@ struct mc_msi {
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
@@ -284,6 +296,8 @@ struct mc_pcie {
 	raw_spinlock_t lock;
 	struct mc_msi msi;
 	u64 outbound_range_offset;
+	u32 num_inbound_windows;
+	struct inbound_windows inbound_windows[MC_MAX_NUM_INBOUND_WINDOWS];
 };
 
 struct cause {
@@ -940,6 +954,46 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
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
+
+		dev_dbg(&pdev->dev, "0x%010llx..0x%010llx -> 0x%010llx\n",
+			pcie_addr, pcie_addr + port->inbound_windows[i].size - 1, axi_addr);
+	}
+
+	return 0;
+}
+
 static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 				 phys_addr_t axi_addr, phys_addr_t pci_addr,
 				 size_t size)
@@ -971,11 +1025,6 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
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
@@ -1147,6 +1196,119 @@ static int mc_check_for_parent_range_handling(struct platform_device *pdev, stru
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
+	u64 start_axi = GENMASK(63, 0);
+	u64 end_axi = 0;
+	u64 start_pci = GENMASK(63, 0);
+	u64 end_pci = 0;
+	s64 size;
+	u64 window_size;
+	int i;
+
+	/* find all dma-ranges */
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
+	 * check for one level up; will need to adjust
+	 * address translation tables for these
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
+	/* merge ranges */
+	for (i = 0; i < num_ranges; i++) {
+		struct inbound_windows *range = &ranges[i];
+
+		if (range->axi_addr < start_axi) {
+			start_axi = range->axi_addr;
+			start_pci = range->pci_addr;
+		}
+
+		if (range->axi_addr + range->size > end_axi) {
+			end_axi = range->axi_addr + range->size;
+			end_pci = range->pci_addr + range->size;
+		}
+	}
+
+	/* move starts back as far as possible */
+	start_axi &= MC_ATT_MASK;
+	start_pci &= MC_ATT_MASK;
+
+	/* adjust size to take account of that change */
+	size = end_axi - start_axi;
+
+	/* may need to adjust size up to the next largest power of 2 */
+	if (size < 1ull << ilog2(size))
+		size = 1ull << (ilog2(size) + 1);
+
+	window_size = 1ull << (ilog2(size) - 1);
+
+	/* divide merged range into windows */
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
@@ -1164,6 +1326,11 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
+	/* and similarly, check for inbound address translation */
+	ret = mc_check_for_parent_dma_range_handling(pdev, port);
+	if (ret)
+		return ret;
+
 	/* Configure address translation table 0 for PCIe config space */
 	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start - port->outbound_range_offset,
 			     cfg->res.start - port->outbound_range_offset,
@@ -1177,6 +1344,11 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
+	/* configure inbound translation tables */
+	ret = mc_pcie_setup_inbound_ranges(pdev, port);
+	if (ret)
+		return ret;
+
 	/* address translation is up; safe to enable interrupts */
 	ret = mc_init_interrupts(pdev, port);
 	if (ret)
-- 
2.25.1

