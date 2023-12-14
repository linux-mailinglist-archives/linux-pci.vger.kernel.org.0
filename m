Return-Path: <linux-pci+bounces-958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6137A812927
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 08:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D13281AFF
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA00F1095C;
	Thu, 14 Dec 2023 07:29:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B49109;
	Wed, 13 Dec 2023 23:29:03 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 1CF8924E302;
	Thu, 14 Dec 2023 15:29:02 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 15:29:02 +0800
Received: from ubuntu.localdomain (113.72.145.168) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 15:28:59 +0800
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Daire
 McNamara" <daire.mcnamara@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>, Minda Chen
	<minda.chen@starfivetech.com>
Subject: [PATCH v13 03/21] PCI: microchip: Move PLDA IP register macros to pcie-plda.h
Date: Thu, 14 Dec 2023 15:28:21 +0800
Message-ID: <20231214072839.2367-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231214072839.2367-1-minda.chen@starfivetech.com>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag

Move PLDA PCIe host controller IP registers macros to pcie-plda.h,
including bridge registers and local IRQ event number.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS                                   |   8 ++
 .../pci/controller/plda/pcie-microchip-host.c | 108 +++---------------
 drivers/pci/controller/plda/pcie-plda.h       | 102 +++++++++++++++++
 3 files changed, 126 insertions(+), 92 deletions(-)
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 46728cc258ca..a034ef4cce93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16610,6 +16610,14 @@ S:	Maintained
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
index cb09a8137e25..a34ec6aad4be 100644
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
@@ -179,20 +102,21 @@
 #define EVENT_LOCAL_DMA_END_ENGINE_1		12
 #define EVENT_LOCAL_DMA_ERROR_ENGINE_0		13
 #define EVENT_LOCAL_DMA_ERROR_ENGINE_1		14
-#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		15
-#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		16
-#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	17
-#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		18
-#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		19
-#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		20
-#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	21
-#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		22
-#define EVENT_LOCAL_PM_MSI_INT_INTX		23
-#define EVENT_LOCAL_PM_MSI_INT_MSI		24
-#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		25
-#define EVENT_LOCAL_PM_MSI_INT_EVENTS		26
-#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		27
-#define NUM_EVENTS				28
+#define NUM_MC_EVENTS				15
+#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		(NUM_MC_EVENTS + EVENT_A_ATR_EVT_POST_ERR)
+#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS + EVENT_A_ATR_EVT_FETCH_ERR)
+#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS + EVENT_A_ATR_EVT_DISCARD_ERR)
+#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		(NUM_MC_EVENTS + EVENT_A_ATR_EVT_DOORBELL)
+#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		(NUM_MC_EVENTS + EVENT_P_ATR_EVT_POST_ERR)
+#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS + EVENT_P_ATR_EVT_FETCH_ERR)
+#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS + EVENT_P_ATR_EVT_DISCARD_ERR)
+#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		(NUM_MC_EVENTS + EVENT_P_ATR_EVT_DOORBELL)
+#define EVENT_LOCAL_PM_MSI_INT_INTX		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_INTX)
+#define EVENT_LOCAL_PM_MSI_INT_MSI		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_MSI)
+#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_AER_EVT)
+#define EVENT_LOCAL_PM_MSI_INT_EVENTS		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_EVENTS)
+#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_SYS_ERR)
+#define NUM_EVENTS				(NUM_MC_EVENTS + NUM_PLDA_EVENTS)
 
 #define PCIE_EVENT_CAUSE(x, s)	\
 	[EVENT_PCIE_ ## x] = { __stringify(x), s }
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
new file mode 100644
index 000000000000..727fc54312c9
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -0,0 +1,102 @@
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
+#define EVENT_A_ATR_EVT_POST_ERR		0
+#define EVENT_A_ATR_EVT_FETCH_ERR		1
+#define EVENT_A_ATR_EVT_DISCARD_ERR		2
+#define EVENT_A_ATR_EVT_DOORBELL		3
+#define EVENT_P_ATR_EVT_POST_ERR		4
+#define EVENT_P_ATR_EVT_FETCH_ERR		5
+#define EVENT_P_ATR_EVT_DISCARD_ERR		6
+#define EVENT_P_ATR_EVT_DOORBELL		7
+#define EVENT_PM_MSI_INT_INTX			8
+#define EVENT_PM_MSI_INT_MSI			9
+#define EVENT_PM_MSI_INT_AER_EVT		10
+#define EVENT_PM_MSI_INT_EVENTS			11
+#define EVENT_PM_MSI_INT_SYS_ERR		12
+#define NUM_PLDA_EVENTS				13
+
+#endif
-- 
2.17.1


