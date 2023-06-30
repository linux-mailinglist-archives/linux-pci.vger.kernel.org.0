Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0E743F31
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjF3Pth (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 11:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjF3Ptf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 11:49:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96153A93
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688140172; x=1719676172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YPpoEmBl+Fmm4/uZPPWUVxXiMPINCj27HNgIRLpHDeo=;
  b=FijnKyfeMMFdzPFnxra5SsNUuq2oLZ/nhsvi0rETg3tec73P5dj5Of9N
   krbScnP1Pmr/b6eFzU+drFU+FblW57BXHndmTMT8ghrDLSRiMrk9/xsYJ
   G1aoIlN4ntsUGmngv+LgDIsrxZlSxSbGv0CM0Vs+lUmX26mSK6lTZH0Am
   0QQdG/JiLQH3cBl94eahE+/MU8tdQHKFfn2tAWBy9HpBrY4iyqtl4QWx/
   cAz84HwZHPTIPRk4fGKchCfzc4Rj1IfPqmXB4iR7H3KpHTRQkOTfDqz5F
   LF6bL+9T65Be8PL8dNsBnhi+8d4zeZPGS0AXosFnRBl9pC4cVkqWGG1HM
   A==;
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="159339770"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2023 08:49:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 30 Jun 2023 08:49:17 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 30 Jun 2023 08:49:15 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 6/8] PCI: microchip: Gather MSI information from hardware config registers
Date:   Fri, 30 Jun 2023 16:48:57 +0100
Message-ID: <20230630154859.2049521-7-daire.mcnamara@microchip.com>
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

The PCIe Root Complex on PolarFire SoC is configured at bitstream creation
time using Libero.  Key MSI-related parameters include the number of
MSIs (1/2/4/8/16/32) and the MSI address. In the device driver, extract
this information from hw registers at init time, and use it to configure
MSI system, including configuring MSI capability structure correctly in
configuration space.

This is backward compatible with all devices in the field.  All devices
report their MSI parameters.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 40 +++++++++++++-------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 6b28442ffe5a..20ce21438a7e 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -20,8 +20,7 @@
 #include "../pci.h"
 
 /* Number of MSI IRQs */
-#define MC_NUM_MSI_IRQS				32
-#define MC_NUM_MSI_IRQS_CODED			5
+#define MC_MAX_NUM_MSI_IRQS			32
 
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
@@ -31,6 +30,11 @@
 #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
 
 /* PCIe Bridge Phy Regs */
+#define PCIE_PCI_IRQ_DW0			0xa8
+#define  MSIX_CAP_MASK				BIT(31)
+#define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
+#define  NUM_MSI_MSGS_SHIFT			4
+
 #define IMASK_LOCAL				0x180
 #define  DMA_END_ENGINE_0_MASK			0x00000000u
 #define  DMA_END_ENGINE_0_SHIFT			0
@@ -79,7 +83,6 @@
 #define IMASK_HOST				0x188
 #define ISTATUS_HOST				0x18c
 #define IMSI_ADDR				0x190
-#define  MSI_ADDR				0x190
 #define ISTATUS_MSI				0x194
 
 /* PCIe Master table init defines */
@@ -158,8 +161,6 @@
 
 /* PCIe Config space MSI capability structure */
 #define MC_MSI_CAP_CTRL_OFFSET			0xe0u
-#define  MC_MSI_MAX_Q_AVAIL			(MC_NUM_MSI_IRQS_CODED << 1)
-#define  MC_MSI_Q_SIZE				(MC_NUM_MSI_IRQS_CODED << 4)
 
 /* Events */
 #define EVENT_PCIE_L2_EXIT			0
@@ -259,7 +260,7 @@ struct mc_msi {
 	struct irq_domain *dev_domain;
 	u32 num_vectors;
 	u64 vector_phy;
-	DECLARE_BITMAP(used, MC_NUM_MSI_IRQS);
+	DECLARE_BITMAP(used, MC_MAX_NUM_MSI_IRQS);
 };
 
 struct mc_pcie {
@@ -387,14 +388,14 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *base)
 	struct mc_msi *msi = &port->msi;
 	u32 cap_offset = MC_MSI_CAP_CTRL_OFFSET;
 	u16 msg_ctrl = readw_relaxed(base + cap_offset + PCI_MSI_FLAGS);
+	u8 queue_size;
 
 	msg_ctrl |= PCI_MSI_FLAGS_ENABLE;
-	msg_ctrl &= ~PCI_MSI_FLAGS_QMASK;
-	msg_ctrl |= MC_MSI_MAX_Q_AVAIL;
+	/* Fixup PCI MSI queue flags */
+	queue_size = msg_ctrl & PCI_MSI_FLAGS_QMASK;
+	queue_size >>= 1;
 	msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
-	msg_ctrl |= MC_MSI_Q_SIZE;
-	msg_ctrl |= PCI_MSI_FLAGS_64BIT;
-
+	msg_ctrl |= queue_size << 4;
 	writew_relaxed(msg_ctrl, base + cap_offset + PCI_MSI_FLAGS);
 
 	writel_relaxed(lower_32_bits(msi->vector_phy),
@@ -1103,6 +1104,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	struct mc_pcie *port;
 	void __iomem *bridge_base_addr;
 	int ret;
+	u32 val;
 
 	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
@@ -1123,12 +1125,24 @@ static int mc_platform_init(struct pci_config_window *cfg)
 
 	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 
-	port->msi.vector_phy = MSI_ADDR;
-	port->msi.num_vectors = MC_NUM_MSI_IRQS;
+	/* Allow enabling MSI by disabling MSI-X */
+	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
+	val &= ~MSIX_CAP_MASK;
+	writel(val, bridge_base_addr + PCIE_PCI_IRQ_DW0);
+
+	/* Pick num vectors from bitfile programmed onto FPGA fabric */
+	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
+	val &= NUM_MSI_MSGS_MASK;
+	val >>= NUM_MSI_MSGS_SHIFT;
+
+	port->msi.num_vectors = 1 << val;
 
 	/* Hardware doesn't setup MSI by default */
 	mc_pcie_enable_msi(port, cfg->win);
 
+	/* Pick vector address from design */
+	port->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
+
 	/* Configure Address Translation Table 0 for PCIe config space */
 	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
 			     cfg->res.start, resource_size(&cfg->res));
-- 
2.25.1

