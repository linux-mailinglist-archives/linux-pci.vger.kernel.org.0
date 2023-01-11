Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B1665BCC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 13:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjAKMyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 07:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjAKMxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 07:53:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729319286;
        Wed, 11 Jan 2023 04:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673441624; x=1704977624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZNue7NifwnVEDIxRwj5YcGOlgVFtkgjYvNNA9HhCHm8=;
  b=cc4KSK0FRjAMV1QmfAYlBeY9w1ue1hcTji5RSEsM97MZzvds8S/esew/
   zbrbtwJqItkkz2KoBFTiXnR8zjkhBGn03fp3GZ8GQ9EwZltEWi30e3Ouo
   3tENDS2YpdXzrZrZyQxE6yIIYA4G/C/6rrZI2LsuMn41pFuYj6PPBlqRB
   7Z+IqJs2CxQ8+0TAltW6V6AOFtqPW+qQf4LZyrkoh7m0/liNtiXaz/2ev
   dLGRlklV6OY1lBDgRP24iqnCIly4UIAFlkm+EgCtJ4hAxBdDzw2xNWqVa
   Q9YwTNA7xTVkd8/mpjTk8904omOWV1/uDlbDp6qG+jyJu+BU28ptO33xN
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="196330337"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2023 05:53:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 05:53:42 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 05:53:40 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v3 04/11] PCI: microchip: Align register, offset, and mask names with hw docs
Date:   Wed, 11 Jan 2023 12:53:16 +0000
Message-ID: <20230111125323.1911373-5-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
References: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Minor re-organisation so that macros representing registers ascend in
numerical order and use the same names as their hardware documentation.
Removed registers not used by the driver.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 122 +++++++++----------
 1 file changed, 60 insertions(+), 62 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 5efd480e42fa..2efd48ef79d8 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -30,66 +30,7 @@
 #define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
 #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
 
-/* PCIe Controller Phy Regs */
-#define SEC_ERROR_CNT				0x20
-#define DED_ERROR_CNT				0x24
-#define SEC_ERROR_INT				0x28
-#define  SEC_ERROR_INT_TX_RAM_SEC_ERR_INT	GENMASK(3, 0)
-#define  SEC_ERROR_INT_RX_RAM_SEC_ERR_INT	GENMASK(7, 4)
-#define  SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT	GENMASK(11, 8)
-#define  SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT	GENMASK(15, 12)
-#define  NUM_SEC_ERROR_INTS			(4)
-#define SEC_ERROR_INT_MASK			0x2c
-#define DED_ERROR_INT				0x30
-#define  DED_ERROR_INT_TX_RAM_DED_ERR_INT	GENMASK(3, 0)
-#define  DED_ERROR_INT_RX_RAM_DED_ERR_INT	GENMASK(7, 4)
-#define  DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT	GENMASK(11, 8)
-#define  DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT	GENMASK(15, 12)
-#define  NUM_DED_ERROR_INTS			(4)
-#define DED_ERROR_INT_MASK			0x34
-#define ECC_CONTROL				0x38
-#define  ECC_CONTROL_TX_RAM_INJ_ERROR_0		BIT(0)
-#define  ECC_CONTROL_TX_RAM_INJ_ERROR_1		BIT(1)
-#define  ECC_CONTROL_TX_RAM_INJ_ERROR_2		BIT(2)
-#define  ECC_CONTROL_TX_RAM_INJ_ERROR_3		BIT(3)
-#define  ECC_CONTROL_RX_RAM_INJ_ERROR_0		BIT(4)
-#define  ECC_CONTROL_RX_RAM_INJ_ERROR_1		BIT(5)
-#define  ECC_CONTROL_RX_RAM_INJ_ERROR_2		BIT(6)
-#define  ECC_CONTROL_RX_RAM_INJ_ERROR_3		BIT(7)
-#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_0	BIT(8)
-#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_1	BIT(9)
-#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_2	BIT(10)
-#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_3	BIT(11)
-#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_0	BIT(12)
-#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_1	BIT(13)
-#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_2	BIT(14)
-#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_3	BIT(15)
-#define  ECC_CONTROL_TX_RAM_ECC_BYPASS		BIT(24)
-#define  ECC_CONTROL_RX_RAM_ECC_BYPASS		BIT(25)
-#define  ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS	BIT(26)
-#define  ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS	BIT(27)
-#define LTSSM_STATE				0x5c
-#define  LTSSM_L0_STATE				0x10
-#define PCIE_EVENT_INT				0x14c
-#define  PCIE_EVENT_INT_L2_EXIT_INT		BIT(0)
-#define  PCIE_EVENT_INT_HOTRST_EXIT_INT		BIT(1)
-#define  PCIE_EVENT_INT_DLUP_EXIT_INT		BIT(2)
-#define  PCIE_EVENT_INT_MASK			GENMASK(2, 0)
-#define  PCIE_EVENT_INT_L2_EXIT_INT_MASK	BIT(16)
-#define  PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK	BIT(17)
-#define  PCIE_EVENT_INT_DLUP_EXIT_INT_MASK	BIT(18)
-#define  PCIE_EVENT_INT_ENB_MASK		GENMASK(18, 16)
-#define  PCIE_EVENT_INT_ENB_SHIFT		16
-#define  NUM_PCIE_EVENTS			(3)
-
 /* PCIe Bridge Phy Regs */
-#define PCIE_PCI_IDS_DW1			0x9c
-
-/* PCIe Config space MSI capability structure */
-#define MC_MSI_CAP_CTRL_OFFSET			0xe0u
-#define  MC_MSI_MAX_Q_AVAIL			(MC_NUM_MSI_IRQS_CODED << 1)
-#define  MC_MSI_Q_SIZE				(MC_NUM_MSI_IRQS_CODED << 4)
-
 #define IMASK_LOCAL				0x180
 #define  DMA_END_ENGINE_0_MASK			0x00000000u
 #define  DMA_END_ENGINE_0_SHIFT			0
@@ -137,7 +78,8 @@
 #define ISTATUS_LOCAL				0x184
 #define IMASK_HOST				0x188
 #define ISTATUS_HOST				0x18c
-#define MSI_ADDR				0x190
+#define IMSI_ADDR				0x190
+#define  MSI_ADDR				0x190
 #define ISTATUS_MSI				0x194
 
 /* PCIe Master table init defines */
@@ -162,6 +104,62 @@
 
 #define ATR_ENTRY_SIZE				32
 
+/* PCIe Controller Phy Regs */
+#define SEC_ERROR_EVENT_CNT			0x20
+#define DED_ERROR_EVENT_CNT			0x24
+#define SEC_ERROR_INT				0x28
+#define  SEC_ERROR_INT_TX_RAM_SEC_ERR_INT	GENMASK(3, 0)
+#define  SEC_ERROR_INT_RX_RAM_SEC_ERR_INT	GENMASK(7, 4)
+#define  SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT	GENMASK(11, 8)
+#define  SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT	GENMASK(15, 12)
+#define  NUM_SEC_ERROR_INTS			(4)
+#define SEC_ERROR_INT_MASK			0x2c
+#define DED_ERROR_INT				0x30
+#define  DED_ERROR_INT_TX_RAM_DED_ERR_INT	GENMASK(3, 0)
+#define  DED_ERROR_INT_RX_RAM_DED_ERR_INT	GENMASK(7, 4)
+#define  DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT	GENMASK(11, 8)
+#define  DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT	GENMASK(15, 12)
+#define  NUM_DED_ERROR_INTS			(4)
+#define DED_ERROR_INT_MASK			0x34
+#define ECC_CONTROL				0x38
+#define  ECC_CONTROL_TX_RAM_INJ_ERROR_0		BIT(0)
+#define  ECC_CONTROL_TX_RAM_INJ_ERROR_1		BIT(1)
+#define  ECC_CONTROL_TX_RAM_INJ_ERROR_2		BIT(2)
+#define  ECC_CONTROL_TX_RAM_INJ_ERROR_3		BIT(3)
+#define  ECC_CONTROL_RX_RAM_INJ_ERROR_0		BIT(4)
+#define  ECC_CONTROL_RX_RAM_INJ_ERROR_1		BIT(5)
+#define  ECC_CONTROL_RX_RAM_INJ_ERROR_2		BIT(6)
+#define  ECC_CONTROL_RX_RAM_INJ_ERROR_3		BIT(7)
+#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_0	BIT(8)
+#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_1	BIT(9)
+#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_2	BIT(10)
+#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_3	BIT(11)
+#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_0	BIT(12)
+#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_1	BIT(13)
+#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_2	BIT(14)
+#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_3	BIT(15)
+#define  ECC_CONTROL_TX_RAM_ECC_BYPASS		BIT(24)
+#define  ECC_CONTROL_RX_RAM_ECC_BYPASS		BIT(25)
+#define  ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS	BIT(26)
+#define  ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS	BIT(27)
+#define PCIE_EVENT_INT				0x14c
+#define  PCIE_EVENT_INT_L2_EXIT_INT		BIT(0)
+#define  PCIE_EVENT_INT_HOTRST_EXIT_INT		BIT(1)
+#define  PCIE_EVENT_INT_DLUP_EXIT_INT		BIT(2)
+#define  PCIE_EVENT_INT_MASK			GENMASK(2, 0)
+#define  PCIE_EVENT_INT_L2_EXIT_INT_MASK	BIT(16)
+#define  PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK	BIT(17)
+#define  PCIE_EVENT_INT_DLUP_EXIT_INT_MASK	BIT(18)
+#define  PCIE_EVENT_INT_ENB_MASK		GENMASK(18, 16)
+#define  PCIE_EVENT_INT_ENB_SHIFT		16
+#define  NUM_PCIE_EVENTS			(3)
+
+/* PCIe Config space MSI capability structure */
+#define MC_MSI_CAP_CTRL_OFFSET			0xe0u
+#define  MC_MSI_MAX_Q_AVAIL			(MC_NUM_MSI_IRQS_CODED << 1)
+#define  MC_MSI_Q_SIZE				(MC_NUM_MSI_IRQS_CODED << 4)
+
+/* Events */
 #define EVENT_PCIE_L2_EXIT			0
 #define EVENT_PCIE_HOTRST_EXIT			1
 #define EVENT_PCIE_DLUP_EXIT			2
@@ -1092,7 +1090,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	      SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT;
 	writel_relaxed(val, ctrl_base_addr + SEC_ERROR_INT);
 	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_INT_MASK);
-	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_CNT);
+	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_EVENT_CNT);
 
 	val = DED_ERROR_INT_TX_RAM_DED_ERR_INT |
 	      DED_ERROR_INT_RX_RAM_DED_ERR_INT |
@@ -1100,7 +1098,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	      DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT;
 	writel_relaxed(val, ctrl_base_addr + DED_ERROR_INT);
 	writel_relaxed(0, ctrl_base_addr + DED_ERROR_INT_MASK);
-	writel_relaxed(0, ctrl_base_addr + DED_ERROR_CNT);
+	writel_relaxed(0, ctrl_base_addr + DED_ERROR_EVENT_CNT);
 
 	writel_relaxed(0, bridge_base_addr + IMASK_HOST);
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
-- 
2.25.1

