Return-Path: <linux-pci+bounces-8111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 234098D5D39
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 10:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B669B2170D
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD5155CBA;
	Fri, 31 May 2024 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aF8IS/I7"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB0155A47;
	Fri, 31 May 2024 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145665; cv=none; b=pnd+q0PtzzHywE722q6GMRXlameCu9i11+3QJpssCMciiOyFbD/gXw88e4nQu4rqDfJ4yKL8rxfhTfWpoDrdWlGIWXy2yPJIbDZSnPOz+Fyz9u7nli/p0HVXWluRJ/W/yOfaeJjEb4rwyQ4ldBH2m3pAxiXB68QjX2ai+ax8M2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145665; c=relaxed/simple;
	bh=KScAjbC3/N4XqPhpvZ4fxFgXP2QfN9P2zjaYB9sejkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suSsL1kX71Csob1U7oiwvl9H7z6RBtwXRSNs5ngLOkzEYm7fjkQXAyXJz3xT7y8dJNhZB73sENReK8B40D5C86V2rb/9hmWpO3fPNRk4lNhJV8czo7Dp6lGxoLp4pNPmYL+EVYxtBy43cehynzaEaqhIoXQR/8aLD22pE0B92E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aF8IS/I7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717145663; x=1748681663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KScAjbC3/N4XqPhpvZ4fxFgXP2QfN9P2zjaYB9sejkQ=;
  b=aF8IS/I7XdO6x2gQfqJMa65QYr/HrMLiFu6mqYAiYqk0HXXzyLv2WQ9X
   WpieHhequGYu4ZFRljCtGqX6SfkCBSCopZNCbtZDl9NsXkH07US5nCBUf
   0qIjVn7kiDT9m5SBWyjWF8FEnrKkUouNYWdyQoT2zk4e/xlScXugGiLGy
   VLJOte0ejxKQYgkiBxtHRwTdvOCOv68spQseTNbxqFbfknJgP5v30OrqL
   mT3NVKTN61606KhEYUDzCVwF1+FiVw36y+97byj55rITozKNtP2gbF5tv
   a3KSp8Ai1fWubsbyYPRwc1OiqPdQMJd4cWGsEKdtY1gc77t2bm4ZV9XSh
   A==;
X-CSE-ConnectionGUID: l/lpyU7jQm+PQYj0dIm0ag==
X-CSE-MsgGUID: 2euRoBfQQnajzmqfAz1L6A==
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="194194718"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2024 01:54:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 01:54:03 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 31 May 2024 01:54:02 -0700
From: Daire McNamara <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, Daire McNamara
	<daire.mcnamara@microchip.com>
Subject: [PATCH 2/2] PCI: microchip: Fix inbound address translation tables
Date: Fri, 31 May 2024 09:53:33 +0100
Message-ID: <20240531085333.2501399-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240531085333.2501399-1-daire.mcnamara@microchip.com>
References: <20240531085333.2501399-1-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On Microchip PolarFire SoC the PCIe Root Port can be behind one of three
general purpose Fabric Interface Controller (FIC) buses that encapsulates
an AXI-S bus. Depending on which FIC(s) the Root Port is connected
through to CPU space, and what address translation is done by that FIC,
the Root Port driver's inbound address translation may vary.

For all current supported designs and all future expected designs,
inbound address translation done by a FIC on PolarFire SoC varies
depending on whether PolarFire SoC in operating in dma-coherent mode or
dma-noncoherent mode.

The setup of the outbound address translation tables in the root port
driver only needs to handle these two cases.

Setup the inbound address translation tables to one of two address
translations, depending on whether the rootport is marked as dma-coherent or
dma-noncoherent.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 97 +++++++++++++++++++-
 1 file changed, 92 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 0795cd122a4a..3042e00cc44e 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -30,6 +30,9 @@
 #define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
 #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
 
+#define MC_MAX_NUM_INBOUND_WINDOWS		8
+#define MPFS_NC_BOUNCE_ADDR			0x80000000
+
 /* PCIe Bridge Phy Regs */
 #define PCIE_PCI_IRQ_DW0			0xa8
 #define  MSIX_CAP_MASK				BIT(31)
@@ -105,6 +108,7 @@
 #define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
 #define  PCIE_TX_RX_INTERFACE			0x00000000u
 #define  PCIE_CONFIG_INTERFACE			0x00000001u
+#define  TRSL_ID_AXI4_MASTER_0			0x00000004u
 
 #define ATR_ENTRY_SIZE				32
 
@@ -931,6 +935,89 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
 	return mc_allocate_msi_domains(port);
 }
 
+static void mc_pcie_setup_inbound_atr(int window_index, u64 axi_addr, u64 pcie_addr, size_t size)
+{
+	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	u32 table_offset = window_index * ATR_ENTRY_SIZE;
+	u32 atr_sz;
+	u32 val;
+
+	atr_sz = ilog2(size) - 1;
+	atr_sz &= GENMASK(5, 0);
+
+	val = lower_32_bits(pcie_addr) & GENMASK(31, 12);
+	val |= (atr_sz << ATR_SIZE_SHIFT);
+	val |= ATR_IMPL_ENABLE;
+	writel(val, bridge_base_addr + table_offset + ATR0_PCIE_WIN0_SRCADDR_PARAM);
+
+	writel(upper_32_bits(pcie_addr), bridge_base_addr + table_offset +
+	       ATR0_PCIE_WIN0_SRC_ADDR);
+
+	writel(lower_32_bits(axi_addr), bridge_base_addr + table_offset +
+	       ATR0_PCIE_WIN0_TRSL_ADDR_LSB);
+	writel(upper_32_bits(axi_addr), bridge_base_addr + table_offset +
+	       ATR0_PCIE_WIN0_TRSL_ADDR_UDW);
+
+	writel(TRSL_ID_AXI4_MASTER_0, bridge_base_addr + table_offset +
+	       ATR0_PCIE_WIN0_TRSL_PARAM);
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
+	 * MPFS PCIe root port is 32-bit only, behind a Fabric Interface
+	 * Controller FPGA logic block which contains the AXI-S interface.
+	 *
+	 * From the point of view of the PCIe root port, There are only
+	 * two supported Root Port configurations
+	 *
+	 * Configuration 1: for use with fully coherent designs; supports a
+	 * window from 0x0 (CPU space) to specified PCIe space.
+	 *
+	 * Configuration 2: for use with non-coherent designs; supports two
+	 * 1 Gb wide windows to CPU space; one mapping cpu space 0 to pcie
+	 * space 0x80000000 and mapping cpu space 0x40000000 to pcie
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
+		/* Find any dma-ranges */
+		if (of_pci_dma_range_parser_init(&parser, dn)) {
+			/* No dma-range property - setup default */
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
 static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 				 phys_addr_t axi_addr, phys_addr_t pci_addr,
 				 size_t size)
@@ -962,11 +1049,6 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	val = upper_32_bits(pci_addr);
 	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
 	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
-
-	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
-	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
 
 static int mc_pcie_setup_windows(struct platform_device *pdev,
@@ -1130,6 +1212,11 @@ static int mc_platform_init(struct pci_config_window *cfg)
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
2.34.1


