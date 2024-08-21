Return-Path: <linux-pci+bounces-11951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB39959CB9
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 15:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED281C2219F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 13:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDDA199FCF;
	Wed, 21 Aug 2024 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zycyBxzs"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F1192D90;
	Wed, 21 Aug 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245378; cv=none; b=quGPWjqSrG6lBHfgkPmJPqjXKiRPkNlrLRib5X//OSE+HtZUguLj+04CCyt1Q/zepXA4/0VZ+AnBlNleOyCFxBmWS5yPQ/9E+pHU++9HRAWkZ3OwkQL96qbekW+sqnS5lZnAjhPXrSH0PB9eMPZ5vd1r4jqv1kiBC93HLIqp+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245378; c=relaxed/simple;
	bh=3tOxpbbZA5ciuSgU83YgsAoyHBL3szfNDXchKaiOH8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4R+OzVgP7Cf38AVDsmHpIJynYu44jus+jPk/8MPXhyTJbVME4IEQWdhPsFJHyrrO8KIvT7BUM78jwGRLB+b3TyAFz8mAYHObqwiho3qR4j9Uy3KsCiVfT8rf0kmmI55olEVmgn1TZfEjslgclfLKkOzDeXDU+lpqCyIurcnyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zycyBxzs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724245376; x=1755781376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3tOxpbbZA5ciuSgU83YgsAoyHBL3szfNDXchKaiOH8I=;
  b=zycyBxzszW5dIHuxkDVho7OTCJpGw7+NrBDmnIsfE9PrDyd2D27aFkXr
   zUUN5iNNyD4ysm4WE/vT7nb6DMwvNHOMB1w8VyP6m3derJDGuh5fHs9Ba
   Nve0UM8jQgLs/W3Kz0nwO67kljfrzxXmBHzKdP/gulcp9xCopOlLIUmlv
   TNPwTJa12fBUoUx+NBxulBVESR1cCAGU07CsU/8MvUhvAPvzvqlnScEzn
   QrzGAXlWnb/Ybc8px2NwwuhUTSdigFXK7jtRZLH6vjCn10IENUJfAQNXL
   NSdgfmFVTbmSZi13mg1++tQAp5/tyBqPVIYzpB3BU69MgzrB0dySjDUrR
   A==;
X-CSE-ConnectionGUID: hYt9Btb/Rtq04w/yiOUfIw==
X-CSE-MsgGUID: nqJdkwd7R8SwtlxKBtRQMg==
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="30743855"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2024 06:02:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Aug 2024 06:02:35 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 21 Aug 2024 06:02:32 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v8 2/3] PCI: microchip: Fix inbound address translation tables
Date: Wed, 21 Aug 2024 14:02:16 +0100
Message-ID: <20240821130217.957424-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821130217.957424-1-daire.mcnamara@microchip.com>
References: <20240821130217.957424-1-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Daire McNamara <daire.mcnamara@microchip.com>

On Microchip PolarFire SoC the PCIe Root Port can be behind one of three
general purpose Fabric Interface Controller (FIC) buses that encapsulates
an AXI-S bus. Depending on which FIC(s) the Root Port is connected
through to CPU space, and what address translation is done by that FIC,
the Root Port driver's inbound address translation may vary.

For all current supported designs and all future expected designs,
inbound address translation done by a FIC on PolarFire SoC varies
depending on whether PolarFire SoC in operating in coherent DMA mode or
noncoherent DMA mode.

The setup of the outbound address translation tables in the Root Port
driver only needs to handle these two cases.

Setup the inbound address translation tables to one of two address
translations, depending on whether the rootport is being used with coherent
DMA or noncoherent DMA.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 90 +++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda-host.c  | 17 +++-
 drivers/pci/controller/plda/pcie-plda.h       |  6 +-
 drivers/pci/controller/plda/pcie-starfive.c   |  5 ++
 4 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index da766de347bd..fd88331a90f8 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -7,21 +7,27 @@
  * Author: Daire McNamara <daire.mcnamara@microchip.com>
  */
 
+#include <linux/align.h>
+#include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
+#include <linux/wordpart.h>
 
 #include "../../pci.h"
 #include "pcie-plda.h"
 
 #define MC_OUTBOUND_TRANS_TBL_MASK		GENMASK(31, 0)
+#define MC_MAX_NUM_INBOUND_WINDOWS		8
+#define MPFS_NC_BOUNCE_ADDR			0x80000000
 
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
@@ -614,6 +620,86 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
+static void mc_pcie_setup_inbound_atr(int window_index, u64 axi_addr, u64 pcie_addr, u64 size)
+{
+	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	u32 table_offset = window_index * ATR_ENTRY_SIZE;
+	void __iomem *table_addr = bridge_base_addr + table_offset;
+	u32 atr_sz;
+	u32 val;
+
+	atr_sz = ilog2(size) - 1;
+
+	val = ALIGN_DOWN(lower_32_bits(pcie_addr), SZ_4K);
+	val |= FIELD_PREP(ATR_SIZE_MASK, atr_sz);
+	val |= ATR_IMPL_ENABLE;
+
+	writel(val, table_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
+
+	writel(upper_32_bits(pcie_addr), table_addr + ATR0_PCIE_WIN0_SRC_ADDR);
+
+	writel(lower_32_bits(axi_addr), table_addr + ATR0_PCIE_WIN0_TRSL_ADDR_LSB);
+	writel(upper_32_bits(axi_addr), table_addr + ATR0_PCIE_WIN0_TRSL_ADDR_UDW);
+
+	writel(TRSL_ID_AXI4_MASTER_0, table_addr + ATR0_PCIE_WIN0_TRSL_PARAM);
+}
+
+static int mc_pcie_setup_inbound_ranges(struct platform_device *pdev, struct mc_pcie *port)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *dn = dev->of_node;
+	struct of_range_parser parser;
+	struct of_range range;
+	int atr_index = 0;
+
+	/*
+	 * MPFS PCIe Root Port is 32-bit only, behind a Fabric Interface
+	 * Controller FPGA logic block which contains the AXI-S interface.
+	 *
+	 * From the point of view of the PCIe Root Port, there are only
+	 * two supported Root Port configurations:
+	 *
+	 * Configuration 1: for use with fully coherent designs; supports a
+	 * window from 0x0 (CPU space) to specified PCIe space.
+	 *
+	 * Configuration 2: for use with non-coherent designs; supports two
+	 * 1 GB wide windows to CPU space; one mapping CPU space 0 to PCIe
+	 * space 0x80000000 and mapping CPU space 0x40000000 to pcie
+	 * space 0xc0000000. This cfg needs two windows because of how
+	 * the MSI space is allocated in the AXI-S range on MPFS.
+	 *
+	 * The FIC interface outside the PCIe block *must* complete the inbound
+	 * address translation as per MCHP MPFS FPGA design guidelines.
+	 */
+	if (device_property_read_bool(dev, "dma-noncoherent")) {
+		/*
+		 * Always need same two tables in this case.  Need two tables
+		 * due to hardware interactions between address and size.
+		 */
+		mc_pcie_setup_inbound_atr(0, 0, MPFS_NC_BOUNCE_ADDR, SZ_1G);
+		mc_pcie_setup_inbound_atr(1, SZ_1G, MPFS_NC_BOUNCE_ADDR + SZ_1G, SZ_1G);
+	} else {
+		/* Find any DMA ranges */
+		if (of_pci_dma_range_parser_init(&parser, dn)) {
+			/* No DMA range property - setup default */
+			mc_pcie_setup_inbound_atr(0, 0, 0, SZ_4G);
+			return 0;
+		}
+
+		for_each_of_range(&parser, &range) {
+			if (atr_index >= MC_MAX_NUM_INBOUND_WINDOWS) {
+				dev_err(dev, "too many inbound ranges; %d available tables\n",
+					MC_MAX_NUM_INBOUND_WINDOWS);
+				return -EINVAL;
+			}
+			mc_pcie_setup_inbound_atr(atr_index, 0, range.pci_addr, range.size);
+			atr_index++;
+		}
+	}
+
+	return 0;
+}
+
 int mc_pcie_setup_iomems(struct pci_host_bridge *bridge,
 			   struct plda_pcie_rp *port)
 {
@@ -656,6 +742,10 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
+	ret = mc_pcie_setup_inbound_ranges(pdev, port);
+	if (ret)
+		return ret;
+
 	port->plda.event_ops = &mc_event_ops;
 	port->plda.event_irq_chip = &mc_event_irq_chip;
 	port->plda.events_bitmap = GENMASK(NUM_EVENTS - 1, 0);
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index a18923d7cea6..2a3cc2544200 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -8,11 +8,14 @@
  * Author: Daire McNamara <daire.mcnamara@microchip.com>
  */
 
+#include <linux/align.h>
+#include <linux/bitfield.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/pci_regs.h>
 #include <linux/pci-ecam.h>
+#include <linux/wordpart.h>
 
 #include "pcie-plda.h"
 
@@ -509,8 +512,9 @@ void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
 	       ATR0_AXI4_SLV0_TRSL_PARAM);
 
-	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
-			    ATR_IMPL_ENABLE;
+	val = ALIGN_DOWN(lower_32_bits(axi_addr), SZ_4K);
+	val |= FIELD_PREP(ATR_SIZE_MASK, atr_sz);
+	val |= ATR_IMPL_ENABLE;
 	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
 	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
 
@@ -525,13 +529,20 @@ void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	val = upper_32_bits(pci_addr);
 	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
 	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
+}
+EXPORT_SYMBOL_GPL(plda_pcie_setup_window);
+
+void plda_pcie_setup_inbound_address_translation(struct plda_pcie_rp *port)
+{
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	u32 val;
 
 	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
 	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
 	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
 	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
-EXPORT_SYMBOL_GPL(plda_pcie_setup_window);
+EXPORT_SYMBOL_GPL(plda_pcie_setup_inbound_address_translation);
 
 int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
 			   struct plda_pcie_rp *port)
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 0e7dc0d8e5ba..61ece26065ea 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -89,14 +89,15 @@
 
 /* PCIe AXI slave table init defines */
 #define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
-#define  ATR_SIZE_SHIFT				1
-#define  ATR_IMPL_ENABLE			1
+#define  ATR_SIZE_MASK				GENMASK(6, 1)
+#define  ATR_IMPL_ENABLE			BIT(0)
 #define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
 #define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
 #define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
 #define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
 #define  PCIE_TX_RX_INTERFACE			0x00000000u
 #define  PCIE_CONFIG_INTERFACE			0x00000001u
+#define  TRSL_ID_AXI4_MASTER_0			0x00000004u
 
 #define CONFIG_SPACE_ADDR_OFFSET		0x1000u
 
@@ -204,6 +205,7 @@ int plda_init_interrupts(struct platform_device *pdev,
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size);
+void plda_pcie_setup_inbound_address_translation(struct plda_pcie_rp *port);
 int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
 			   struct plda_pcie_rp *port);
 int plda_pcie_host_init(struct plda_pcie_rp *port, struct pci_ops *ops,
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index c9933ecf6833..20cb30580959 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -355,6 +355,11 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 	 */
 	plda_pcie_set_pref_win_64bit(plda);
 
+	/*
+	 * Setup the inbound address translation
+	 */
+	plda_pcie_setup_inbound_address_translation(plda);
+
 	/*
 	 * Ensure that PERST has been asserted for at least 100 ms,
 	 * the sleep value is T_PVPERL from PCIe CEM spec r2.0 (Table 2-4)
-- 
2.34.1


