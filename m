Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ECB77B3E1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 10:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjHNIUz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 04:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjHNIUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 04:20:25 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A785110D;
        Mon, 14 Aug 2023 01:20:23 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 669F224E280;
        Mon, 14 Aug 2023 16:20:22 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:20:22 +0800
Received: from ubuntu.localdomain (183.27.98.20) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:20:20 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v3 03/11] PCI: microchip: Move PLDA IP register macros to pcie-plda.h
Date:   Mon, 14 Aug 2023 16:20:08 +0800
Message-ID: <20230814082016.104181-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230814082016.104181-1-minda.chen@starfivetech.com>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.20]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move PLDA PCIe host controller IP registers macros to
pcie-plda.h, Including bridge and configuration space
registers.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 MAINTAINERS                                   |  8 ++
 .../pci/controller/plda/pcie-microchip-host.c | 82 +----------------
 drivers/pci/controller/plda/pcie-plda.h       | 90 +++++++++++++++++++
 3 files changed, 99 insertions(+), 81 deletions(-)
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d604643a033b..f46b0cfc8ef9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16278,6 +16278,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
 
+PCI DRIVER FOR PLDA PCIE IP
+M:	Daire McNamara <daire.mcnamara@microchip.com>
+M:	Kevin Xie <kevin.xie@starfivetech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/plda,*
+F:	drivers/pci/controller/plda/*plda*
+
 PCI DRIVER FOR RENESAS R-CAR
 M:	Marek Vasut <marek.vasut+renesas@gmail.com>
 M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index a953ba1c9b0f..5ab11741f406 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 
 #include "../../pci.h"
+#include "pcie-plda.h"
 
 /* Number of MSI IRQs */
 #define MC_MAX_NUM_MSI_IRQS			32
@@ -30,84 +31,6 @@
 #define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
 #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
 
-/* PCIe Bridge Phy Regs */
-#define PCIE_PCI_IRQ_DW0			0xa8
-#define  MSIX_CAP_MASK				BIT(31)
-#define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
-#define  NUM_MSI_MSGS_SHIFT			4
-
-#define IMASK_LOCAL				0x180
-#define  DMA_END_ENGINE_0_MASK			0x00000000u
-#define  DMA_END_ENGINE_0_SHIFT			0
-#define  DMA_END_ENGINE_1_MASK			0x00000000u
-#define  DMA_END_ENGINE_1_SHIFT			1
-#define  DMA_ERROR_ENGINE_0_MASK		0x00000100u
-#define  DMA_ERROR_ENGINE_0_SHIFT		8
-#define  DMA_ERROR_ENGINE_1_MASK		0x00000200u
-#define  DMA_ERROR_ENGINE_1_SHIFT		9
-#define  A_ATR_EVT_POST_ERR_MASK		0x00010000u
-#define  A_ATR_EVT_POST_ERR_SHIFT		16
-#define  A_ATR_EVT_FETCH_ERR_MASK		0x00020000u
-#define  A_ATR_EVT_FETCH_ERR_SHIFT		17
-#define  A_ATR_EVT_DISCARD_ERR_MASK		0x00040000u
-#define  A_ATR_EVT_DISCARD_ERR_SHIFT		18
-#define  A_ATR_EVT_DOORBELL_MASK		0x00000000u
-#define  A_ATR_EVT_DOORBELL_SHIFT		19
-#define  P_ATR_EVT_POST_ERR_MASK		0x00100000u
-#define  P_ATR_EVT_POST_ERR_SHIFT		20
-#define  P_ATR_EVT_FETCH_ERR_MASK		0x00200000u
-#define  P_ATR_EVT_FETCH_ERR_SHIFT		21
-#define  P_ATR_EVT_DISCARD_ERR_MASK		0x00400000u
-#define  P_ATR_EVT_DISCARD_ERR_SHIFT		22
-#define  P_ATR_EVT_DOORBELL_MASK		0x00000000u
-#define  P_ATR_EVT_DOORBELL_SHIFT		23
-#define  PM_MSI_INT_INTA_MASK			0x01000000u
-#define  PM_MSI_INT_INTA_SHIFT			24
-#define  PM_MSI_INT_INTB_MASK			0x02000000u
-#define  PM_MSI_INT_INTB_SHIFT			25
-#define  PM_MSI_INT_INTC_MASK			0x04000000u
-#define  PM_MSI_INT_INTC_SHIFT			26
-#define  PM_MSI_INT_INTD_MASK			0x08000000u
-#define  PM_MSI_INT_INTD_SHIFT			27
-#define  PM_MSI_INT_INTX_MASK			0x0f000000u
-#define  PM_MSI_INT_INTX_SHIFT			24
-#define  PM_MSI_INT_MSI_MASK			0x10000000u
-#define  PM_MSI_INT_MSI_SHIFT			28
-#define  PM_MSI_INT_AER_EVT_MASK		0x20000000u
-#define  PM_MSI_INT_AER_EVT_SHIFT		29
-#define  PM_MSI_INT_EVENTS_MASK			0x40000000u
-#define  PM_MSI_INT_EVENTS_SHIFT		30
-#define  PM_MSI_INT_SYS_ERR_MASK		0x80000000u
-#define  PM_MSI_INT_SYS_ERR_SHIFT		31
-#define  NUM_LOCAL_EVENTS			15
-#define ISTATUS_LOCAL				0x184
-#define IMASK_HOST				0x188
-#define ISTATUS_HOST				0x18c
-#define IMSI_ADDR				0x190
-#define ISTATUS_MSI				0x194
-
-/* PCIe Master table init defines */
-#define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
-#define  ATR0_PCIE_ATR_SIZE			0x25
-#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
-#define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
-#define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
-#define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
-#define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
-
-/* PCIe AXI slave table init defines */
-#define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
-#define  ATR_SIZE_SHIFT				1
-#define  ATR_IMPL_ENABLE			1
-#define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
-#define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
-#define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
-#define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
-#define  PCIE_TX_RX_INTERFACE			0x00000000u
-#define  PCIE_CONFIG_INTERFACE			0x00000001u
-
-#define ATR_ENTRY_SIZE				32
-
 /* PCIe Controller Phy Regs */
 #define SEC_ERROR_EVENT_CNT			0x20
 #define DED_ERROR_EVENT_CNT			0x24
@@ -160,9 +83,6 @@
 #define  PCIE_EVENT_INT_ENB_SHIFT		16
 #define  NUM_PCIE_EVENTS			(3)
 
-/* PCIe Config space MSI capability structure */
-#define MC_MSI_CAP_CTRL_OFFSET			0xe0u
-
 /* Events */
 #define EVENT_PCIE_L2_EXIT			0
 #define EVENT_PCIE_HOTRST_EXIT			1
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
new file mode 100644
index 000000000000..faee30b0a761
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PLDA PCIe host controller driver
+ */
+
+#ifndef _PCIE_PLDA_H
+#define _PCIE_PLDA_H
+
+/* PCIe Bridge Phy Regs */
+#define PCIE_PCI_IRQ_DW0			0xa8
+#define  MSIX_CAP_MASK				BIT(31)
+#define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
+#define  NUM_MSI_MSGS_SHIFT			4
+
+#define IMASK_LOCAL				0x180
+#define  DMA_END_ENGINE_0_MASK			0x00000000u
+#define  DMA_END_ENGINE_0_SHIFT			0
+#define  DMA_END_ENGINE_1_MASK			0x00000000u
+#define  DMA_END_ENGINE_1_SHIFT			1
+#define  DMA_ERROR_ENGINE_0_MASK		0x00000100u
+#define  DMA_ERROR_ENGINE_0_SHIFT		8
+#define  DMA_ERROR_ENGINE_1_MASK		0x00000200u
+#define  DMA_ERROR_ENGINE_1_SHIFT		9
+#define  A_ATR_EVT_POST_ERR_MASK		0x00010000u
+#define  A_ATR_EVT_POST_ERR_SHIFT		16
+#define  A_ATR_EVT_FETCH_ERR_MASK		0x00020000u
+#define  A_ATR_EVT_FETCH_ERR_SHIFT		17
+#define  A_ATR_EVT_DISCARD_ERR_MASK		0x00040000u
+#define  A_ATR_EVT_DISCARD_ERR_SHIFT		18
+#define  A_ATR_EVT_DOORBELL_MASK		0x00000000u
+#define  A_ATR_EVT_DOORBELL_SHIFT		19
+#define  P_ATR_EVT_POST_ERR_MASK		0x00100000u
+#define  P_ATR_EVT_POST_ERR_SHIFT		20
+#define  P_ATR_EVT_FETCH_ERR_MASK		0x00200000u
+#define  P_ATR_EVT_FETCH_ERR_SHIFT		21
+#define  P_ATR_EVT_DISCARD_ERR_MASK		0x00400000u
+#define  P_ATR_EVT_DISCARD_ERR_SHIFT		22
+#define  P_ATR_EVT_DOORBELL_MASK		0x00000000u
+#define  P_ATR_EVT_DOORBELL_SHIFT		23
+#define  PM_MSI_INT_INTA_MASK			0x01000000u
+#define  PM_MSI_INT_INTA_SHIFT			24
+#define  PM_MSI_INT_INTB_MASK			0x02000000u
+#define  PM_MSI_INT_INTB_SHIFT			25
+#define  PM_MSI_INT_INTC_MASK			0x04000000u
+#define  PM_MSI_INT_INTC_SHIFT			26
+#define  PM_MSI_INT_INTD_MASK			0x08000000u
+#define  PM_MSI_INT_INTD_SHIFT			27
+#define  PM_MSI_INT_INTX_MASK			0x0f000000u
+#define  PM_MSI_INT_INTX_SHIFT			24
+#define  PM_MSI_INT_MSI_MASK			0x10000000u
+#define  PM_MSI_INT_MSI_SHIFT			28
+#define  PM_MSI_INT_AER_EVT_MASK		0x20000000u
+#define  PM_MSI_INT_AER_EVT_SHIFT		29
+#define  PM_MSI_INT_EVENTS_MASK			0x40000000u
+#define  PM_MSI_INT_EVENTS_SHIFT		30
+#define  PM_MSI_INT_SYS_ERR_MASK		0x80000000u
+#define  PM_MSI_INT_SYS_ERR_SHIFT		31
+#define  NUM_LOCAL_EVENTS			15
+#define ISTATUS_LOCAL				0x184
+#define IMASK_HOST				0x188
+#define ISTATUS_HOST				0x18c
+#define IMSI_ADDR				0x190
+#define ISTATUS_MSI				0x194
+
+/* PCIe Master table init defines */
+#define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
+#define  ATR0_PCIE_ATR_SIZE			0x25
+#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
+#define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
+#define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
+#define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
+#define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
+
+/* PCIe AXI slave table init defines */
+#define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
+#define  ATR_SIZE_SHIFT				1
+#define  ATR_IMPL_ENABLE			1
+#define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
+#define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
+#define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
+#define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
+#define  PCIE_TX_RX_INTERFACE			0x00000000u
+#define  PCIE_CONFIG_INTERFACE			0x00000001u
+
+#define ATR_ENTRY_SIZE				32
+
+/* PCIe Config space MSI capability structure */
+#define MC_MSI_CAP_CTRL_OFFSET			0xe0u
+
+#endif
-- 
2.17.1

