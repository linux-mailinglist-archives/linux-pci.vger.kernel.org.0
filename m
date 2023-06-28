Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7259C740D7C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjF1JsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 05:48:05 -0400
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:52193
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233283AbjF1J2h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 05:28:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQjewSbp3uHWY8CFQbD0/OdTbQAY0zZj52mewo1FA5oDjgT7ZCqST63v6o9DZVPnPrZlULttggCnZtT1IeWMZMP+Ru5s1yNln3QMaqdrBG5ZKN83BWLfBddiRVgcu217zUxRU7zRsFFHlWeAMGcAQFYPdUjCP9WRHhASsc3ofvWsg+4w6KF5eSdLhCzyMSLGY2gYk+ywyOPiG+fk6lVCO2hkIelGR2UED7vi+lZrESue9hdDiw6o3hT9+4E8k0sgM6Lb4CAuDuhhVPsKl9Ykjem/1XJGFjp8MUug4YDHK5pPzy+p8v+4uRVLCqOaAC3tJU81P2IixStmnoav0MTO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O47UdB8HB1kXQtZ4OVOrWP3y+orUhyLh2hbFustCYJY=;
 b=ixQ+b0q+HkrRt1PT5mZk0ASfHaIf9omkeixaMvX92Mv7SWwg2ufA9KzzmmwNnVIXL3uwhcm8UxmVb5QoGpiE82YHVYSSDHivWUiWOBHHZL5m6c4YRYBxbxkFXOmohb/GHehJUSgLLZV5MhbZ6xr5nd/plSb7r5330kOX6nWW3uUd9iCb0oG63T6Oy8NBZt20osaUn7KgilMEM/c3W6zft1SYp+KhJKdv4AqDJKYdwiydPwCwIG+G3KrdKdRz7t8F5hg0apPyeq8QNxsA2saO9LduXU2Zd6FG885DbfEQF42zIzL1SGXDtNXKKTbnvOdKn+psvnxJ35706SpKF1VEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O47UdB8HB1kXQtZ4OVOrWP3y+orUhyLh2hbFustCYJY=;
 b=OZJ1L62pXXG2NLh0XDcB/hjV6c2vzkf1TlcqpDEhpO7D366p89D9ForPjGJfCfrKzRTbqzaHZoElDKZ9jF7eC1zHk9FsMW+RPgKHkEdZtJpMm1bAAlKg4yLl6ILqWiAobPqaIZPzyWPNfFStWRmIff/uL7zETKTtifdoz4ikauw=
Received: from DM6PR02CA0142.namprd02.prod.outlook.com (2603:10b6:5:332::9) by
 IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 28 Jun
 2023 09:28:33 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::10) by DM6PR02CA0142.outlook.office365.com
 (2603:10b6:5:332::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19 via Frontend
 Transport; Wed, 28 Jun 2023 09:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 09:28:32 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 04:28:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 28 Jun
 2023 02:28:30 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 28 Jun 2023 04:28:28 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <krzysztof.kozlowski@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>
CC:     <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <bharat.kumar.gogada@amd.com>, <michals@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH V5 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Date:   Wed, 28 Jun 2023 14:58:12 +0530
Message-ID: <20230628092812.1592644-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628092812.1592644-1-thippeswamy.havalige@amd.com>
References: <20230628092812.1592644-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f0fedc-a15a-4f1c-f2b2-08db77ba0a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIt9Ahtj+PCJE4zhBbs/bL6Wuj3z+Y21+nub91lFTcZ+iKbb1LOmgeJNO5kAFZPuHT0yrtNBAZYDPLBvDMh+7L8U1pP6O7+Q1enQurH9bMIKHbAiDSGKMRsQiNxXnReX8Y27UWRJ1EfBqQODtfObjpAu9k0ZGqxiOSOcytSQ3vfHtZwZMl15BN0kqmMAX+VcxfL3f3ECIeu0uiD1ZtDe3IMTG8jLL4SLb6aqYbv9wrh7OkHwdW3pToeYbMWCatgi6S0NJJrE98em15rM6WQ+sdN0u8/R6SNYPFNSgv2wAjyelcLzm8TMA3Y4tbU29tMfC1Gq2d2etLYTjBcz0K5SpjGQvlkerhKELRCU5oQXLHbcBstfuU38Gc/S6UcXPVSsNYOvK+mdpZH+oubDh9GpDZW11V8hzHDWs9Qy1/g9/U2y7Sv/ReNswR65fe6MAvbOCYOBfu41/sdiqJCLp1I8dLLoIOPajxMuxaMDcJZVajrZShj03d6bPmt3HDgwUWvPrYLxpgn8a1lmxcwmZNkUxgGg0yxMvhQDYCCJLUaxa10ZLMPG779pWj/b504Igyq1YafMuvmJUzFpNUbU1yRqmdq1A49VYdcsoIgq1rSswAK2JhqzO9fBF3848FldAByK5uKupYt81evGTa/F+GvGhhSeM8CUof3AvlFHUYX6NMl0+vUmrKGYWghTTYbCq2S3PACd40px2YdANBkbDXlMRpY7L7nuR7CCmmgPI0YplPtd67jYAdm38dGPmbmIYvKr/S9V8v2RM93wpAYPXqhJvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(966005)(110136005)(6666004)(478600001)(83380400001)(2616005)(47076005)(36860700001)(336012)(40480700001)(82740400003)(86362001)(40460700003)(426003)(82310400005)(1076003)(26005)(30864003)(186003)(81166007)(2906002)(4326008)(36756003)(8936002)(41300700001)(70206006)(70586007)(316002)(356005)(44832011)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:28:32.7759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f0fedc-a15a-4f1c-f2b2-08db77ba0a99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Xilinx XDMA Soft IP core as Root Port.

The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
programmable logic.

The integrated XDMA soft IP block has integrated bridge function that
can act as PCIe Root Port.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
|Reported-by: kernel test robot <lkp@intel.com>
|Reported-by: Dan Carpenter <error27@gmail.com>
|Closes: https://lore.kernel.org/r/202305261250.2cs1phTS-lkp@intel.com/
---
changes in v5:
- Added detailed comments for link_up check.
- Modified upper case hex values to lower case. 
changes in v4:
- Fixed unsigned integer to integer.
- Fixed return type to EINVAL.
changes in v3:
- Changed license to 2023.
- Added bitfield header to avoid implicit warning.
- Fixed indentation issue.
- Fixed code-style.
changes in v2:
- Remove unnecessary inclusion of headerfiles.
- Added a subset of interrupt error bits to common header files.
- Added pci_is_root_bus function.
- Removed kerneldoc comments of private function.
- Modified of_get_next_child API to of_get_child_by_name.
- Modified of_address_to_resource API to platform_get_resource.
- Modified return value.
 drivers/pci/controller/Kconfig              |  11 +
 drivers/pci/controller/Makefile             |   1 +
 drivers/pci/controller/pcie-xilinx-common.h |   1 +
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 803 ++++++++++++++++++++++++++++
 4 files changed, 816 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-xilinx-dma-pl.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8d49bad..2df0cd0 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -325,6 +325,17 @@ config PCIE_XILINX
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
 
+config PCIE_XILINX_DMA_PL
+	bool "Xilinx DMA PL PCIe host bridge support"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on PCI_MSI
+	select PCI_HOST_COMMON
+	help
+	  Add support for the Xilinx PL DMA PCIe host bridge,
+	  The controller is soft IP which can act as Root Port.
+	  If you know your system provides Xilinx PCIe host controller
+	  bridge DMA as soft IP say Y; if you are not sure, say N.
+
 config PCIE_XILINX_NWL
 	bool "Xilinx NWL PCIe controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 37c8663..f2b19e6 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
 obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
 obj-$(CONFIG_PCIE_XILINX_CPM) += pcie-xilinx-cpm.o
+obj-$(CONFIG_PCIE_XILINX_DMA_PL) += pcie-xilinx-dma-pl.o
 obj-$(CONFIG_PCI_V3_SEMI) += pci-v3-semi.o
 obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
 obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
diff --git a/drivers/pci/controller/pcie-xilinx-common.h b/drivers/pci/controller/pcie-xilinx-common.h
index e97d272..1832770 100644
--- a/drivers/pci/controller/pcie-xilinx-common.h
+++ b/drivers/pci/controller/pcie-xilinx-common.h
@@ -19,6 +19,7 @@
 #define XILINX_PCIE_INTR_PME_TO_ACK_RCVD	15
 #define XILINX_PCIE_INTR_INTX			16
 #define XILINX_PCIE_INTR_PM_PME_RCVD		17
+#define XILINX_PCIE_INTR_MSI			17
 #define XILINX_PCIE_INTR_SLV_UNSUPP		20
 #define XILINX_PCIE_INTR_SLV_UNEXP		21
 #define XILINX_PCIE_INTR_SLV_COMPL		22
diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
new file mode 100644
index 0000000..f00438b
--- /dev/null
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -0,0 +1,803 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe host controller driver for Xilinx XDMA PCIe Bridge
+ *
+ * Copyright (C) 2023 Xilinx, Inc. All rights reserved.
+ */
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+
+#include "../pci.h"
+#include "pcie-xilinx-common.h"
+
+/* Register definitions */
+#define XILINX_PCIE_DMA_REG_IDR			0x00000138
+#define XILINX_PCIE_DMA_REG_IMR			0x0000013c
+#define XILINX_PCIE_DMA_REG_PSCR		0x00000144
+#define XILINX_PCIE_DMA_REG_RPSC		0x00000148
+#define XILINX_PCIE_DMA_REG_MSIBASE1		0x0000014c
+#define XILINX_PCIE_DMA_REG_MSIBASE2		0x00000150
+#define XILINX_PCIE_DMA_REG_RPEFR		0x00000154
+#define XILINX_PCIE_DMA_REG_IDRN		0x00000160
+#define XILINX_PCIE_DMA_REG_IDRN_MASK		0x00000164
+#define XILINX_PCIE_DMA_REG_MSI_LOW		0x00000170
+#define XILINX_PCIE_DMA_REG_MSI_HI		0x00000174
+#define XILINX_PCIE_DMA_REG_MSI_LOW_MASK	0x00000178
+#define XILINX_PCIE_DMA_REG_MSI_HI_MASK		0x0000017c
+
+#define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)
+
+#define XILINX_PCIE_INTR_IMR_ALL_MASK	\
+	(					\
+		IMR(LINK_DOWN)		|	\
+		IMR(HOT_RESET)		|	\
+		IMR(CFG_TIMEOUT)	|	\
+		IMR(CORRECTABLE)	|	\
+		IMR(NONFATAL)		|	\
+		IMR(FATAL)		|	\
+		IMR(INTX)		|	\
+		IMR(MSI)		|	\
+		IMR(SLV_UNSUPP)		|	\
+		IMR(SLV_UNEXP)		|	\
+		IMR(SLV_COMPL)		|	\
+		IMR(SLV_ERRP)		|	\
+		IMR(SLV_CMPABT)		|	\
+		IMR(SLV_ILLBUR)		|	\
+		IMR(MST_DECERR)		|	\
+		IMR(MST_SLVERR)		|	\
+	)
+
+#define XILINX_PCIE_DMA_IMR_ALL_MASK	0x0ff30fe9
+#define XILINX_PCIE_DMA_IDR_ALL_MASK	0xffffffff
+#define XILINX_PCIE_DMA_IDRN_MASK	GENMASK(19, 16)
+
+/* Root Port Error Register definitions */
+#define XILINX_PCIE_DMA_RPEFR_ERR_VALID	BIT(18)
+#define XILINX_PCIE_DMA_RPEFR_REQ_ID	GENMASK(15, 0)
+#define XILINX_PCIE_DMA_RPEFR_ALL_MASK	0xffffffff
+
+/* Root Port Interrupt Register definitions */
+#define XILINX_PCIE_DMA_IDRN_SHIFT	16
+
+/* Root Port Status/control Register definitions */
+#define XILINX_PCIE_DMA_REG_RPSC_BEN	BIT(0)
+
+/* Phy Status/Control Register definitions */
+#define XILINX_PCIE_DMA_REG_PSCR_LNKUP	BIT(11)
+
+/* Number of MSI IRQs */
+#define XILINX_NUM_MSI_IRQS	64
+
+struct xilinx_msi {
+	struct irq_domain	*msi_domain;
+	unsigned long		*bitmap;
+	struct irq_domain	*dev_domain;
+	struct mutex		lock;		/* protect bitmap variable */
+	int			irq_msi0;
+	int			irq_msi1;
+};
+
+/**
+ * struct pl_dma_pcie - PCIe port information
+ * @dev: Device pointer
+ * @reg_base: IO Mapped Register Base
+ * @irq: Interrupt number
+ * @cfg: Holds mappings of config space window
+ * @phys_reg_base: Physical address of reg base
+ * @intx_domain: Legacy IRQ domain pointer
+ * @pldma_domain: PL DMA IRQ domain pointer
+ * @resources: Bus Resources
+ * @msi: MSI information
+ * @irq_misc: Legacy and error interrupt number
+ * @intx_irq: legacy interrupt number
+ * @lock: lock protecting shared register access
+ */
+struct pl_dma_pcie {
+	struct device			*dev;
+	void __iomem			*reg_base;
+	int				irq;
+	struct pci_config_window	*cfg;
+	phys_addr_t			phys_reg_base;
+	struct irq_domain		*intx_domain;
+	struct irq_domain		*pldma_domain;
+	struct list_head		resources;
+	struct xilinx_msi		msi;
+	int				irq_misc;
+	int				intx_irq;
+	raw_spinlock_t			lock;
+};
+
+static inline u32 pcie_read(struct pl_dma_pcie *port, u32 reg)
+{
+	return readl(port->reg_base + reg);
+}
+
+static inline void pcie_write(struct pl_dma_pcie *port, u32 val, u32 reg)
+{
+	writel(val, port->reg_base + reg);
+}
+
+static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie *port)
+{
+	return (pcie_read(port, XILINX_PCIE_DMA_REG_PSCR) &
+		XILINX_PCIE_DMA_REG_PSCR_LNKUP) ? 1 : 0;
+}
+
+static void xilinx_pl_dma_pcie_clear_err_interrupts(struct pl_dma_pcie *port)
+{
+	unsigned long val = pcie_read(port, XILINX_PCIE_DMA_REG_RPEFR);
+
+	if (val & XILINX_PCIE_DMA_RPEFR_ERR_VALID) {
+		dev_dbg(port->dev, "Requester ID %lu\n",
+			val & XILINX_PCIE_DMA_RPEFR_REQ_ID);
+		pcie_write(port, XILINX_PCIE_DMA_RPEFR_ALL_MASK,
+			   XILINX_PCIE_DMA_REG_RPEFR);
+	}
+}
+
+static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
+{
+	struct pl_dma_pcie *port = bus->sysdata;
+
+	/* Check if link is up when trying to access downstream ports */
+	if (!pci_is_root_bus(bus)) {
+		/*
+		 * If the link goes down after we check for link-up, we have a problem:
+		 * if a PIO request is initiated while link-down, the whole controller
+		 * hangs, and even after link comes up again, previous PIO requests
+		 * won't work, and a reset of the whole PCIe controller is needed.
+		 * Henceforth we need link-up check here to avoid sending PIO request
+		 * when link is down.
+		 */
+		if (!xilinx_pl_dma_pcie_link_up(port))
+			return false;
+	} else if (devfn > 0)
+		/* Only one device down on each root port */
+		return false;
+
+	return true;
+}
+
+static void __iomem *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
+						unsigned int devfn, int where)
+{
+	struct pl_dma_pcie *port = bus->sysdata;
+
+	if (!xilinx_pl_dma_pcie_valid_device(bus, devfn))
+		return NULL;
+
+	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
+}
+
+/* PCIe operations */
+static const struct pci_ecam_ops xilinx_pl_dma_pcie_ops = {
+	.pci_ops = {
+		.map_bus = xilinx_pl_dma_pcie_map_bus,
+		.read	= pci_generic_config_read,
+		.write	= pci_generic_config_write,
+	}
+};
+
+static void xilinx_pl_dma_pcie_enable_msi(struct pl_dma_pcie *port)
+{
+	phys_addr_t msi_addr = port->phys_reg_base;
+
+	pcie_write(port, upper_32_bits(msi_addr), XILINX_PCIE_DMA_REG_MSIBASE1);
+	pcie_write(port, lower_32_bits(msi_addr), XILINX_PCIE_DMA_REG_MSIBASE2);
+}
+
+static void xilinx_mask_intx_irq(struct irq_data *data)
+{
+	struct pl_dma_pcie *port = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 mask, val;
+
+	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
+	pcie_write(port, (val & (~mask)), XILINX_PCIE_DMA_REG_IDRN_MASK);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void xilinx_unmask_intx_irq(struct irq_data *data)
+{
+	struct pl_dma_pcie *port = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 mask, val;
+
+	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
+	pcie_write(port, (val | mask), XILINX_PCIE_DMA_REG_IDRN_MASK);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static struct irq_chip xilinx_leg_irq_chip = {
+	.name		= "INTx",
+	.irq_mask	= xilinx_mask_intx_irq,
+	.irq_unmask	= xilinx_unmask_intx_irq,
+};
+
+static int xilinx_pl_dma_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+				       irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &xilinx_leg_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
+
+	return 0;
+}
+
+/* INTx IRQ Domain operations */
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = xilinx_pl_dma_pcie_intx_map,
+};
+
+static void xilinx_pl_dma_pcie_handle_msi_irq(struct pl_dma_pcie *port,
+					      u32 status_reg)
+{
+	struct xilinx_msi *msi;
+	unsigned long status;
+	u32 bit, virq;
+
+	msi = &port->msi;
+
+	while ((status = pcie_read(port, status_reg)) != 0) {
+		for_each_set_bit(bit, &status, 32) {
+			pcie_write(port, 1 << bit, status_reg);
+			if (status_reg == XILINX_PCIE_DMA_REG_MSI_HI)
+				bit = bit + 32;
+			virq = irq_find_mapping(msi->dev_domain, bit);
+			if (virq)
+				generic_handle_irq(virq);
+		}
+	}
+}
+
+static void xilinx_pl_dma_pcie_msi_handler_high(struct irq_desc *desc)
+{
+	struct pl_dma_pcie *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+	xilinx_pl_dma_pcie_handle_msi_irq(port, XILINX_PCIE_DMA_REG_MSI_HI);
+	chained_irq_exit(chip, desc);
+}
+
+static void xilinx_pl_dma_pcie_msi_handler_low(struct irq_desc *desc)
+{
+	struct pl_dma_pcie *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+	xilinx_pl_dma_pcie_handle_msi_irq(port, XILINX_PCIE_DMA_REG_MSI_LOW);
+	chained_irq_exit(chip, desc);
+}
+
+static void xilinx_pl_dma_pcie_event_flow(struct irq_desc *desc)
+{
+	struct pl_dma_pcie *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long val;
+	int i;
+
+	chained_irq_enter(chip, desc);
+	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDR);
+	val &= pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
+	for_each_set_bit(i, &val, 32)
+		generic_handle_domain_irq(port->pldma_domain, i);
+
+	pcie_write(port, val, XILINX_PCIE_DMA_REG_IDR);
+
+	chained_irq_exit(chip, desc);
+}
+
+#define _IC(x, s)                              \
+	[XILINX_PCIE_INTR_ ## x] = { __stringify(x), s }
+
+static const struct {
+	const char	*sym;
+	const char	*str;
+} intr_cause[32] = {
+	_IC(LINK_DOWN,		"Link Down"),
+	_IC(HOT_RESET,		"Hot reset"),
+	_IC(CFG_TIMEOUT,	"ECAM access timeout"),
+	_IC(CORRECTABLE,	"Correctable error message"),
+	_IC(NONFATAL,		"Non fatal error message"),
+	_IC(FATAL,		"Fatal error message"),
+	_IC(INTX,		"INTX error message"),
+	_IC(MSI,		"MSI message received"),
+	_IC(SLV_UNSUPP,		"Slave unsupported request"),
+	_IC(SLV_UNEXP,		"Slave unexpected completion"),
+	_IC(SLV_COMPL,		"Slave completion timeout"),
+	_IC(SLV_ERRP,		"Slave Error Poison"),
+	_IC(SLV_CMPABT,		"Slave Completer Abort"),
+	_IC(SLV_ILLBUR,		"Slave Illegal Burst"),
+	_IC(MST_DECERR,		"Master decode error"),
+	_IC(MST_SLVERR,		"Master slave error"),
+};
+
+static irqreturn_t xilinx_pl_dma_pcie_intr_handler(int irq, void *dev_id)
+{
+	struct pl_dma_pcie *port = (struct pl_dma_pcie *)dev_id;
+	struct device *dev = port->dev;
+	struct irq_data *d;
+
+	d = irq_domain_get_irq_data(port->pldma_domain, irq);
+	switch (d->hwirq) {
+	case XILINX_PCIE_INTR_CORRECTABLE:
+	case XILINX_PCIE_INTR_NONFATAL:
+	case XILINX_PCIE_INTR_FATAL:
+		xilinx_pl_dma_pcie_clear_err_interrupts(port);
+		fallthrough;
+
+	default:
+		if (intr_cause[d->hwirq].str)
+			dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
+		else
+			dev_warn(dev, "Unknown IRQ %ld\n", d->hwirq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irq_chip xilinx_msi_irq_chip = {
+	.name = "pl_dma_pciepcie:msi",
+	.irq_enable = pci_msi_unmask_irq,
+	.irq_disable = pci_msi_mask_irq,
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static struct msi_domain_info xilinx_msi_domain_info = {
+	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		MSI_FLAG_MULTI_PCI_MSI),
+	.chip = &xilinx_msi_irq_chip,
+};
+
+static void xilinx_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct pl_dma_pcie *pcie = irq_data_get_irq_chip_data(data);
+	phys_addr_t msi_addr = pcie->phys_reg_base;
+
+	msg->address_lo = lower_32_bits(msi_addr);
+	msg->address_hi = upper_32_bits(msi_addr);
+	msg->data = data->hwirq;
+}
+
+static int xilinx_msi_set_affinity(struct irq_data *irq_data,
+				   const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip xilinx_irq_chip = {
+	.name = "Xilinx MSI",
+	.irq_compose_msi_msg = xilinx_compose_msi_msg,
+	.irq_set_affinity = xilinx_msi_set_affinity,
+};
+
+static int xilinx_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *args)
+{
+	struct pl_dma_pcie *pcie = domain->host_data;
+	struct xilinx_msi *msi = &pcie->msi;
+	int bit, i;
+
+	mutex_lock(&msi->lock);
+	bit = bitmap_find_free_region(msi->bitmap, XILINX_NUM_MSI_IRQS,
+				      get_count_order(nr_irqs));
+	if (bit < 0) {
+		mutex_unlock(&msi->lock);
+		return -ENOSPC;
+	}
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, bit + i, &xilinx_irq_chip,
+				    domain->host_data, handle_simple_irq,
+				    NULL, NULL);
+	}
+	mutex_unlock(&msi->lock);
+	return 0;
+}
+
+static void xilinx_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs)
+{
+	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
+	struct pl_dma_pcie *pcie = irq_data_get_irq_chip_data(data);
+	struct xilinx_msi *msi = &pcie->msi;
+
+	mutex_lock(&msi->lock);
+	bitmap_release_region(msi->bitmap, data->hwirq,
+			      get_count_order(nr_irqs));
+	mutex_unlock(&msi->lock);
+}
+
+static const struct irq_domain_ops dev_msi_domain_ops = {
+	.alloc	= xilinx_irq_domain_alloc,
+	.free	= xilinx_irq_domain_free,
+};
+
+static void xilinx_pl_dma_pcie_free_interrupts(struct pl_dma_pcie *port)
+{
+	irq_set_chained_handler_and_data(port->msi.irq_msi0, NULL, NULL);
+	irq_set_chained_handler_and_data(port->msi.irq_msi1, NULL, NULL);
+}
+
+static void xilinx_pl_dma_pcie_free_irq_domains(struct pl_dma_pcie *port)
+{
+	struct xilinx_msi *msi = &port->msi;
+
+	if (port->intx_domain) {
+		irq_domain_remove(port->intx_domain);
+		port->intx_domain = NULL;
+	}
+
+	if (msi->dev_domain) {
+		irq_domain_remove(msi->dev_domain);
+		msi->dev_domain = NULL;
+	}
+
+	if (msi->msi_domain) {
+		irq_domain_remove(msi->msi_domain);
+		msi->msi_domain = NULL;
+	}
+}
+
+static int xilinx_pl_dma_pcie_init_msi_irq_domain(struct pl_dma_pcie *port)
+{
+	struct device *dev = port->dev;
+	struct xilinx_msi *msi = &port->msi;
+	int size = BITS_TO_LONGS(XILINX_NUM_MSI_IRQS) * sizeof(long);
+	struct fwnode_handle *fwnode = of_node_to_fwnode(port->dev->of_node);
+
+	msi->dev_domain = irq_domain_add_linear(NULL, XILINX_NUM_MSI_IRQS,
+						&dev_msi_domain_ops, port);
+	if (!msi->dev_domain)
+		goto out;
+
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
+						    &xilinx_msi_domain_info,
+						    msi->dev_domain);
+	if (!msi->msi_domain)
+		goto out;
+
+	mutex_init(&msi->lock);
+	msi->bitmap = kzalloc(size, GFP_KERNEL);
+	if (!msi->bitmap)
+		goto out;
+
+	raw_spin_lock_init(&port->lock);
+	xilinx_pl_dma_pcie_enable_msi(port);
+
+	return 0;
+
+out:
+	xilinx_pl_dma_pcie_free_irq_domains(port);
+	dev_err(dev, "Failed to allocate MSI IRQ domains\n");
+	return -ENOMEM;
+}
+
+static void xilinx_pl_dma_pcie_intx_flow(struct irq_desc *desc)
+{
+	struct pl_dma_pcie *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long val;
+	int i;
+
+	chained_irq_enter(chip, desc);
+
+	val = FIELD_GET(XILINX_PCIE_DMA_IDRN_MASK,
+			pcie_read(port, XILINX_PCIE_DMA_REG_IDRN));
+
+	for_each_set_bit(i, &val, PCI_NUM_INTX)
+		generic_handle_domain_irq(port->intx_domain, i);
+
+	chained_irq_exit(chip, desc);
+}
+
+static void xilinx_pl_dma_pcie_mask_event_irq(struct irq_data *d)
+{
+	struct pl_dma_pcie *port = irq_data_get_irq_chip_data(d);
+	u32 val;
+
+	raw_spin_lock(&port->lock);
+	val = pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
+	val &= ~BIT(d->hwirq);
+	pcie_write(port, val, XILINX_PCIE_DMA_REG_IMR);
+	raw_spin_unlock(&port->lock);
+}
+
+static void xilinx_pl_dma_pcie_unmask_event_irq(struct irq_data *d)
+{
+	struct pl_dma_pcie *port = irq_data_get_irq_chip_data(d);
+	u32 val;
+
+	raw_spin_lock(&port->lock);
+	val = pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
+	val |= BIT(d->hwirq);
+	pcie_write(port, val, XILINX_PCIE_DMA_REG_IMR);
+	raw_spin_unlock(&port->lock);
+}
+
+static struct irq_chip xilinx_pl_dma_pcie_event_irq_chip = {
+	.name		= "RC-Event",
+	.irq_mask	= xilinx_pl_dma_pcie_mask_event_irq,
+	.irq_unmask	= xilinx_pl_dma_pcie_unmask_event_irq,
+};
+
+static int xilinx_pl_dma_pcie_event_map(struct irq_domain *domain,
+					unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &xilinx_pl_dma_pcie_event_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
+
+	return 0;
+}
+
+static const struct irq_domain_ops event_domain_ops = {
+	.map = xilinx_pl_dma_pcie_event_map,
+};
+
+/**
+ * xilinx_pl_dma_pcie_init_irq_domain - Initialize IRQ domain
+ * @port: PCIe port information
+ *
+ * Return: '0' on success and error value on failure
+ */
+static int xilinx_pl_dma_pcie_init_irq_domain(struct pl_dma_pcie *port)
+{
+	struct device *dev = port->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *pcie_intc_node;
+	int ret;
+
+	/* Setup INTx */
+	pcie_intc_node = of_get_child_by_name(node, "interrupt-controller");
+	if (!pcie_intc_node) {
+		dev_err(dev, "No PCIe Intc node found\n");
+		return -EINVAL;
+	}
+
+	port->pldma_domain = irq_domain_add_linear(pcie_intc_node, 32,
+						   &event_domain_ops, port);
+	if (!port->pldma_domain)
+		return -ENOMEM;
+
+	irq_domain_update_bus_token(port->pldma_domain, DOMAIN_BUS_NEXUS);
+
+	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						  &intx_domain_ops, port);
+	if (!port->intx_domain) {
+		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		return PTR_ERR(port->intx_domain);
+	}
+
+	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
+
+	ret = xilinx_pl_dma_pcie_init_msi_irq_domain(port);
+	if (ret != 0) {
+		irq_domain_remove(port->intx_domain);
+		return -ENOMEM;
+	}
+
+	of_node_put(pcie_intc_node);
+	raw_spin_lock_init(&port->lock);
+
+	return 0;
+}
+
+static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port)
+{
+	struct device *dev = port->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int i, irq;
+
+	port->irq = platform_get_irq(pdev, 0);
+	if (port->irq < 0)
+		return port->irq;
+
+	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
+		int err;
+
+		if (!intr_cause[i].str)
+			continue;
+
+		irq = irq_create_mapping(port->pldma_domain, i);
+		if (!irq) {
+			dev_err(dev, "Failed to map interrupt\n");
+			return -ENXIO;
+		}
+
+		err = devm_request_irq(dev, irq, xilinx_pl_dma_pcie_intr_handler,
+				       0, intr_cause[i].sym, port);
+		if (err) {
+			dev_err(dev, "Failed to request IRQ %d\n", irq);
+			return err;
+		}
+	}
+
+	port->intx_irq = irq_create_mapping(port->pldma_domain,
+					    XILINX_PCIE_INTR_INTX);
+	if (!port->intx_irq) {
+		dev_err(dev, "Failed to map INTx interrupt\n");
+		return -ENXIO;
+	}
+
+	/* Plug the INTx chained handler */
+	irq_set_chained_handler_and_data(port->intx_irq,
+					 xilinx_pl_dma_pcie_intx_flow, port);
+
+	/* Plug the main event chained handler */
+	irq_set_chained_handler_and_data(port->irq,
+					 xilinx_pl_dma_pcie_event_flow, port);
+
+	return 0;
+}
+
+static void xilinx_pl_dma_pcie_init_port(struct pl_dma_pcie *port)
+{
+	if (xilinx_pl_dma_pcie_link_up(port))
+		dev_info(port->dev, "PCIe Link is UP\n");
+	else
+		dev_info(port->dev, "PCIe Link is DOWN\n");
+
+	/* Disable all interrupts */
+	pcie_write(port, ~XILINX_PCIE_DMA_IDR_ALL_MASK,
+		   XILINX_PCIE_DMA_REG_IMR);
+
+	/* Clear pending interrupts */
+	pcie_write(port, pcie_read(port, XILINX_PCIE_DMA_REG_IDR) &
+			 XILINX_PCIE_DMA_IMR_ALL_MASK,
+		   XILINX_PCIE_DMA_REG_IDR);
+
+	/* Needed for MSI DECODE MODE */
+	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK, XILINX_PCIE_DMA_REG_MSI_LOW_MASK);
+	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK, XILINX_PCIE_DMA_REG_MSI_HI_MASK);
+
+	/*set the Bridge enable bit */
+	pcie_write(port, pcie_read(port, XILINX_PCIE_DMA_REG_RPSC) |
+			 XILINX_PCIE_DMA_REG_RPSC_BEN,
+		   XILINX_PCIE_DMA_REG_RPSC);
+}
+
+static int xilinx_request_msi_irq(struct pl_dma_pcie *port)
+{
+	struct device *dev = port->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	port->msi.irq_msi0 = platform_get_irq_byname(pdev, "msi0");
+	if (port->msi.irq_msi0 <= 0) {
+		dev_err(dev, "Unable to find msi0 IRQ line\n");
+		return port->msi.irq_msi0;
+	}
+
+	irq_set_chained_handler_and_data(port->msi.irq_msi0,
+					 xilinx_pl_dma_pcie_msi_handler_low,
+					 port);
+
+	port->msi.irq_msi1 = platform_get_irq_byname(pdev, "msi1");
+	if (port->msi.irq_msi1 <= 0) {
+		irq_set_chained_handler_and_data(port->msi.irq_msi0,
+						 NULL, NULL);
+		dev_err(dev, "Unable to find msi1 IRQ line\n");
+		return port->msi.irq_msi1;
+	}
+
+	irq_set_chained_handler_and_data(port->msi.irq_msi1,
+					 xilinx_pl_dma_pcie_msi_handler_high,
+					 port);
+
+	return 0;
+}
+
+static int xilinx_pl_dma_pcie_parse_dt(struct pl_dma_pcie *port,
+				       struct resource *bus_range)
+{
+	struct device *dev = port->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+	int err;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "missing \"reg\" property\n");
+		return -ENXIO;
+	}
+	port->phys_reg_base = res->start;
+
+	port->cfg = pci_ecam_create(dev, res, bus_range, &xilinx_pl_dma_pcie_ops);
+	if (IS_ERR(port->cfg))
+		return PTR_ERR(port->cfg);
+
+	port->reg_base = port->cfg->win;
+
+	err = xilinx_request_msi_irq(port);
+	if (err) {
+		pci_ecam_free(port->cfg);
+		return err;
+	}
+
+	return 0;
+}
+
+static int xilinx_pl_dma_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pl_dma_pcie *port;
+	struct pci_host_bridge *bridge;
+	struct resource_entry *bus;
+	int err;
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
+	if (!bridge)
+		return -ENODEV;
+
+	port = pci_host_bridge_priv(bridge);
+
+	port->dev = dev;
+
+	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return -ENODEV;
+
+	err = xilinx_pl_dma_pcie_parse_dt(port, bus->res);
+	if (err) {
+		dev_err(dev, "Parsing DT failed\n");
+		return err;
+	}
+
+	xilinx_pl_dma_pcie_init_port(port);
+
+	err = xilinx_pl_dma_pcie_init_irq_domain(port);
+	if (err)
+		goto err_irq_domain;
+
+	err = xilinx_pl_dma_pcie_setup_irq(port);
+
+	bridge->sysdata = port;
+	bridge->ops = (struct pci_ops *)&xilinx_pl_dma_pcie_ops.pci_ops;
+
+	err = pci_host_probe(bridge);
+	if (err < 0)
+		goto err_host_bridge;
+
+	return 0;
+
+err_host_bridge:
+	xilinx_pl_dma_pcie_free_irq_domains(port);
+
+err_irq_domain:
+	pci_ecam_free(port->cfg);
+	xilinx_pl_dma_pcie_free_interrupts(port);
+	return err;
+}
+
+static const struct of_device_id xilinx_pl_dma_pcie_of_match[] = {
+	{
+		.compatible = "xlnx,xdma-host-3.00",
+	},
+	{}
+};
+
+static struct platform_driver xilinx_pl_dma_pcie_driver = {
+	.driver = {
+		.name = "xilinx-xdma-pcie",
+		.of_match_table = xilinx_pl_dma_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = xilinx_pl_dma_pcie_probe,
+};
+
+builtin_platform_driver(xilinx_pl_dma_pcie_driver);
-- 
1.8.3.1

