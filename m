Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC86E454C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 12:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDQKfD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 06:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjDQKfC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 06:35:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84237ECB;
        Mon, 17 Apr 2023 03:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtfFYZ8wTI3Z7AqlPzGMXb+FgYfl4xYlfVCCnWNgGOcIUAXJ82lTKAGp7V/XMFHKLq72MO6eDvy7m7HdqOw5tQeDtHFL077xV5M9hLpJf0FoKwwElcoAyteEFqEOIyDDWJZsPVPC9ZwTqnxSkTSsl6VaFkbH3wDXUz1Ll1M/K4ggL6GPv0ockzAWwaPQZo/EkMqmDwLkVqhbZkCoTJJRdMKkH0RVfuQ2z8n+6f1DdmVPB+vLqujffeCSZhIxc5cDt1i2VuDqrw41OYIO/sjY6KgKDVumLux+lW2HEqRfn+AB/qjQrmfFsvMSD5UOYiNgHPWIbKK6ocJ3K0IU7CKj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKtnoy4OunjJlSv8u+24q7X+Ia4ltOg0v7jwuiUUAkI=;
 b=SuQ5qwdE6oNQXXTcapg051KjDuWWsexsGzBCuNenkQ3zjiPL6YEFbrQu3FXi7X2Z2lylEnMeN2mr1aRhDlwvcyIy6/sO1KTdGbWp9z1uA1qpfuJGZCjau24S+QnZsxZx1qBRbVP0WSnjPAkqRdmPHkxy0IDq3pWLNLzgr29P6wEoNwMZtOQsqf1laUXqPB9TOXLN0pZMA+37+rt9ipbuTbTStE6bBFtdZjMz/VIBr5LmI5nsZFtelKfjwd4H1/SEc4EWqO586PYXSjpJiLsmjhBpcWqNStpZcf3E0tiR6kWkG/+dShWxs7gELbtmLhB3BckrFfSfAwMnNoNdOzwXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKtnoy4OunjJlSv8u+24q7X+Ia4ltOg0v7jwuiUUAkI=;
 b=ae+2Io/hBwbzoBUVjx4Tlsw9Xkt/+1gfOjfF4AKsYk4Yv4eY4eWV0XH93VX0f/CEUMrK8So9KTTEqqOjlktawPqK7lYHLoB+6fii2KwAlzt6w7n/gviRrIM1q5Jk5PNc8DSiD+5dv39BAxiYdpJAvxDwGOU0UQks3BeYZRfRim8=
Received: from BL0PR02CA0112.namprd02.prod.outlook.com (2603:10b6:208:35::17)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 10:33:25 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::63) by BL0PR02CA0112.outlook.office365.com
 (2603:10b6:208:35::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 10:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.16 via Frontend Transport; Mon, 17 Apr 2023 10:33:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 05:33:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 05:33:24 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 17 Apr 2023 05:33:21 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        <lorenzo.pieralisi@arm.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH 2/2] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Date:   Mon, 17 Apr 2023 16:02:26 +0530
Message-ID: <20230417103226.334588-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417103226.334588-1-thippeswamy.havalige@amd.com>
References: <20230417103226.334588-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e3aa8b-e76c-46ec-dfde-08db3f2f2ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cm6seke4eaG19JU8Iqf6bMFRqupF/sWTUh87jf5fVorWLBdqszsqMzMQA5SyxV4ots2XpAFpJaQDVUDmda0hL9XFGavv7y2ObqmQ/SCtLKn0BHVF1Ep7mnwq97gQc5Br7tam21OULyYEPdgP0QCg6Vzanu+xFbIkNq9gRennGsnuXT25jmIOYm3Ot8T0L1rlSchLhMZ2wXwX4paKLTg9jt7M/HfmjY5YV+2XC1zjnBZwKpItyMuXC91+Mzz7yML2fXDrJvWA/J9UvAmrNwkDDDv6EZh0Fi4aFjtscn01GgwJqn42QTHgaFVjU7/N9Y4oIZQYpUxjteRufaQP4Y4Rkz+dBtBg2Zo9PQzR0AsKmkM7P1u+4fwIj+7bZI0U32LtH7AZ9I5rapsbrOGzNVkPP/02GmHiLMJ+JshFcSmxOH9pg5MWVDP5K2hk6LATYrHUAwt4ESUDrxWZAlMQetiWMW0sn9ary6TDcbO1H9IHAWnNDaSOnY919GP4Tm2nDbsh7LKhRmjktLwDOv4S/WhNTM8kO99f37RDbpMAJqXghNoxnZpT5OGTBKKNKj4gbOxgih9gUP/CoNhWaaSMfedfPZrOSFpovI+VL1/f3G6p6MS33eyRP7nrTPdpaPxl3V7VXQtdx1l6sTPRw89vtfwOX0hIVw/xSbaB3UcyeEUVyiEXRYP51vbnf5o4rQUm7luU64AwwH06rnJ5zizsyhYHibafVYLyqgCSHnuEVD3Px4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(70206006)(70586007)(30864003)(2906002)(1076003)(44832011)(336012)(82310400005)(426003)(478600001)(5660300002)(8676002)(40480700001)(4326008)(41300700001)(36756003)(40460700003)(110136005)(8936002)(54906003)(316002)(82740400003)(81166007)(47076005)(36860700001)(86362001)(26005)(83380400001)(2616005)(356005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 10:33:25.1536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e3aa8b-e76c-46ec-dfde-08db3f2f2ce0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
---
 drivers/pci/controller/Kconfig        |  10 +
 drivers/pci/controller/Makefile       |   1 +
 drivers/pci/controller/pcie-xdma-pl.c | 877 ++++++++++++++++++++++++++
 3 files changed, 888 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-xdma-pl.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 42654035654a..edc7812673ff 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -113,6 +113,16 @@ config PCIE_XILINX_CPM
 	  Say 'Y' here if you want kernel support for the
 	  Xilinx Versal CPM host bridge.
 
+config PCIE_XILINX_DMA
+	bool "Xilinx DMA PL PCIe host bridge support"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on PCI_MSI
+	select PCI_HOST_COMMON
+	help
+	  Say 'Y' here if you want kernel to enable support for the
+	  XILINX PL PCIe host bridge support, this PCIe controller
+	  includes DMA PL component.
+
 config PCI_XGENE
 	bool "X-Gene PCIe controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 37c8663de7fe..567890c7952e 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
 obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
 obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
+obj-$(CONFIG_PCIE_XILINX_DMA) += pcie-xdma-pl.o
 obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
diff --git a/drivers/pci/controller/pcie-xdma-pl.c b/drivers/pci/controller/pcie-xdma-pl.c
new file mode 100644
index 000000000000..487d2be3bf45
--- /dev/null
+++ b/drivers/pci/controller/pcie-xdma-pl.c
@@ -0,0 +1,877 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe host controller driver for Xilinx XDMA PCIe Bridge
+ *
+ * Copyright (C) 2017 Xilinx, Inc. All rights reserved.
+ */
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/pci-ecam.h>
+
+#include "../pci.h"
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
+/* Interrupt registers definitions */
+#define XILINX_PCIE_DMA_INTR_LINK_DOWN		0
+#define XILINX_PCIE_DMA_INTR_HOT_RESET		3
+#define XILINX_PCIE_DMA_INTR_CFG_TIMEOUT	8
+#define XILINX_PCIE_DMA_INTR_CORRECTABLE	9
+#define XILINX_PCIE_DMA_INTR_NONFATAL		10
+#define XILINX_PCIE_DMA_INTR_FATAL		11
+#define XILINX_PCIE_DMA_INTR_INTX		16
+#define XILINX_PCIE_DMA_INTR_MSI		17
+#define XILINX_PCIE_DMA_INTR_SLV_UNSUPP		20
+#define XILINX_PCIE_DMA_INTR_SLV_UNEXP		21
+#define XILINX_PCIE_DMA_INTR_SLV_COMPL		22
+#define XILINX_PCIE_DMA_INTR_SLV_ERRP		23
+#define XILINX_PCIE_DMA_INTR_SLV_CMPABT		24
+#define XILINX_PCIE_DMA_INTR_SLV_ILLBUR		25
+#define XILINX_PCIE_DMA_INTR_MST_DECERR		26
+#define XILINX_PCIE_DMA_INTR_MST_SLVERR		27
+
+#define IMR(x) BIT(XILINX_PCIE_DMA_INTR_ ##x)
+
+#define XILINX_PCIE_DMA_INTR_IMR_ALL_MASK	\
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
+#define XILINX_PCIE_DMA_IMR_ALL_MASK	0x0FF30FE9
+#define XILINX_PCIE_DMA_IDR_ALL_MASK	0xFFFFFFFF
+#define XILINX_PCIE_DMA_IDRN_MASK	GENMASK(19, 16)
+
+/* Root Port Error Register definitions */
+#define XILINX_PCIE_DMA_RPEFR_ERR_VALID	BIT(18)
+#define XILINX_PCIE_DMA_RPEFR_REQ_ID	GENMASK(15, 0)
+#define XILINX_PCIE_DMA_RPEFR_ALL_MASK	0xFFFFFFFF
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
+ * struct xilinx_pcie_dma - PCIe port information
+ * @reg_base: IO Mapped Register Base
+ * @irq: Interrupt number
+ * @cfg: Holds mappings of config space window
+ * @root_busno: Root Bus number
+ * @dev: Device pointer
+ * @phys_reg_base: Physical address of reg base
+ * @leg_domain: Legacy IRQ domain pointer
+ * @pldma_domain: PL DMA IRQ domain pointer
+ * @resources: Bus Resources
+ * @msi: MSI information
+ * @irq_misc: Legacy and error interrupt number
+ * @intx_irq: legacy interrupt number
+ * @lock: lock protecting shared register access
+ */
+struct xilinx_pcie_dma {
+	void __iomem			*reg_base;
+	u32				irq;
+	struct pci_config_window	*cfg;
+	u8				root_busno;
+	struct device			*dev;
+	phys_addr_t			phys_reg_base;
+	struct irq_domain		*leg_domain;
+	struct irq_domain		*pldma_domain;
+	struct list_head		resources;
+	struct xilinx_msi		msi;
+	int				irq_misc;
+	int				intx_irq;
+	raw_spinlock_t			lock;
+};
+
+static inline u32 pcie_read(struct xilinx_pcie_dma *port, u32 reg)
+{
+		return readl(port->reg_base + reg);
+}
+
+static inline void pcie_write(struct xilinx_pcie_dma *port, u32 val, u32 reg)
+{
+		writel(val, port->reg_base + reg);
+}
+
+static inline bool xilinx_pcie_dma_linkup(struct xilinx_pcie_dma *port)
+{
+	return (pcie_read(port, XILINX_PCIE_DMA_REG_PSCR) &
+		XILINX_PCIE_DMA_REG_PSCR_LNKUP) ? 1 : 0;
+}
+
+/**
+ * xilinx_pcie_dma_clear_err_interrupts - Clear Error Interrupts
+ * @port: PCIe port information
+ */
+static void xilinx_pcie_dma_clear_err_interrupts(struct xilinx_pcie_dma *port)
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
+/**
+ * xilinx_pcie_dma_valid_device - Check if a valid device is present on bus
+ * @bus: PCI Bus structure
+ * @devfn: device/function
+ *
+ * Return: 'true' on success and 'false' if invalid device is found
+ */
+static bool xilinx_pcie_dma_valid_device(struct pci_bus *bus, unsigned int devfn)
+{
+	struct xilinx_pcie_dma *port = bus->sysdata;
+
+	/* Check if link is up when trying to access downstream ports */
+	if (bus->number != port->root_busno)
+		if (!xilinx_pcie_dma_linkup(port))
+			return false;
+
+	/* Only one device down on each root port */
+	if (bus->number == port->root_busno && devfn > 0)
+		return false;
+
+	return true;
+}
+
+/**
+ * xilinx_pcie_dma_map_bus - Get configuration base
+ * @bus: PCI Bus structure
+ * @devfn: Device/function
+ * @where: Offset from base
+ *
+ * Return: Base address of the configuration space needed to be
+ *	   accessed.
+ */
+static void __iomem *xilinx_pcie_dma_map_bus(struct pci_bus *bus,
+					     unsigned int devfn, int where)
+{
+	struct xilinx_pcie_dma *port = bus->sysdata;
+	int relbus;
+
+	if (!xilinx_pcie_dma_valid_device(bus, devfn))
+		return NULL;
+
+	relbus = (bus->number << PCIE_ECAM_BUS_SHIFT) |
+		 (devfn << PCIE_ECAM_DEVFN_SHIFT);
+
+	return port->reg_base + relbus + where;
+}
+
+/* PCIe operations */
+static struct pci_ecam_ops xilinx_pcie_dma_ops = {
+	.pci_ops = {
+		.map_bus = xilinx_pcie_dma_map_bus,
+		.read	= pci_generic_config_read,
+		.write	= pci_generic_config_write,
+	}
+};
+
+/**
+ * xilinx_pcie_dma_enable_msi - Enable MSI support
+ * @port: PCIe port information
+ */
+static void xilinx_pcie_dma_enable_msi(struct xilinx_pcie_dma *port)
+{
+	phys_addr_t msi_addr = port->phys_reg_base;
+
+	pcie_write(port, upper_32_bits(msi_addr), XILINX_PCIE_DMA_REG_MSIBASE1);
+	pcie_write(port, lower_32_bits(msi_addr), XILINX_PCIE_DMA_REG_MSIBASE2);
+}
+
+static void xilinx_mask_leg_irq(struct irq_data *data)
+{
+	struct xilinx_pcie_dma *port = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 mask;
+	u32 val;
+
+	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
+	pcie_write(port, (val & (~mask)), XILINX_PCIE_DMA_REG_IDRN_MASK);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void xilinx_unmask_leg_irq(struct irq_data *data)
+{
+	struct xilinx_pcie_dma *port = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 mask;
+	u32 val;
+
+	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
+	pcie_write(port, (val | mask), XILINX_PCIE_DMA_REG_IDRN_MASK);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static struct irq_chip xilinx_leg_irq_chip = {
+	.name           = "INTx",
+	.irq_mask       = xilinx_mask_leg_irq,
+	.irq_unmask     = xilinx_unmask_leg_irq,
+};
+
+/**
+ * xilinx_pcie_dma_intx_map - Set the handler for the INTx and mark IRQ as valid
+ * @domain: IRQ domain
+ * @irq: Virtual IRQ number
+ * @hwirq: HW interrupt number
+ *
+ * Return: Always returns 0.
+ */
+static int xilinx_pcie_dma_intx_map(struct irq_domain *domain, unsigned int irq,
+				    irq_hw_number_t hwirq)
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
+	.map = xilinx_pcie_dma_intx_map,
+};
+
+static void xilinx_pcie_dma_handle_msi_irq(struct xilinx_pcie_dma *port,
+					   u32 status_reg)
+{
+	struct xilinx_msi *msi;
+	unsigned long status;
+	u32 bit;
+	u32 virq;
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
+static void xilinx_pcie_dma_msi_handler_high(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct xilinx_pcie_dma *port = irq_desc_get_handler_data(desc);
+
+	chained_irq_enter(chip, desc);
+	xilinx_pcie_dma_handle_msi_irq(port, XILINX_PCIE_DMA_REG_MSI_HI);
+	chained_irq_exit(chip, desc);
+}
+
+static void xilinx_pcie_dma_msi_handler_low(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct xilinx_pcie_dma *port = irq_desc_get_handler_data(desc);
+
+	chained_irq_enter(chip, desc);
+	xilinx_pcie_dma_handle_msi_irq(port, XILINX_PCIE_DMA_REG_MSI_LOW);
+	chained_irq_exit(chip, desc);
+}
+
+static void xilinx_pcie_dma_event_flow(struct irq_desc *desc)
+{
+	struct xilinx_pcie_dma *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long val;
+	int i;
+
+	chained_irq_enter(chip, desc);
+	val =  pcie_read(port, XILINX_PCIE_DMA_REG_IDR);
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
+	[XILINX_PCIE_DMA_INTR_ ## x] = { __stringify(x), s }
+
+static const struct {
+	const char      *sym;
+	const char      *str;
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
+static irqreturn_t xilinx_pcie_dma_intr_handler(int irq, void *dev_id)
+{
+	struct xilinx_pcie_dma *port = (struct xilinx_pcie_dma *)dev_id;
+	struct device *dev = port->dev;
+	struct irq_data *d;
+
+	d = irq_domain_get_irq_data(port->pldma_domain, irq);
+	switch (d->hwirq) {
+	case XILINX_PCIE_DMA_INTR_CORRECTABLE:
+	case XILINX_PCIE_DMA_INTR_NONFATAL:
+	case XILINX_PCIE_DMA_INTR_FATAL:
+		xilinx_pcie_dma_clear_err_interrupts(port);
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
+	.name = "xilinx_pcie_dmapcie:msi",
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
+	struct xilinx_pcie_dma *pcie = irq_data_get_irq_chip_data(data);
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
+	struct xilinx_pcie_dma *pcie = domain->host_data;
+	struct xilinx_msi *msi = &pcie->msi;
+	int bit;
+	int i;
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
+	struct xilinx_pcie_dma *pcie = irq_data_get_irq_chip_data(data);
+	struct xilinx_msi *msi = &pcie->msi;
+
+	mutex_lock(&msi->lock);
+	bitmap_release_region(msi->bitmap, data->hwirq,
+			      get_count_order(nr_irqs));
+	mutex_unlock(&msi->lock);
+}
+
+static const struct irq_domain_ops dev_msi_domain_ops = {
+	.alloc  = xilinx_irq_domain_alloc,
+	.free   = xilinx_irq_domain_free,
+};
+
+static void xilinx_pcie_dma_free_interrupts(struct xilinx_pcie_dma *port)
+{
+	irq_set_chained_handler_and_data(port->msi.irq_msi0, NULL, NULL);
+	irq_set_chained_handler_and_data(port->msi.irq_msi1, NULL, NULL);
+}
+
+static void xilinx_pcie_dma_free_irq_domains(struct xilinx_pcie_dma *port)
+{
+	struct xilinx_msi *msi = &port->msi;
+
+	if (port->leg_domain) {
+		irq_domain_remove(port->leg_domain);
+		port->leg_domain = NULL;
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
+static int xilinx_pcie_dma_init_msi_irq_domain(struct xilinx_pcie_dma *port)
+{
+	struct fwnode_handle *fwnode = of_node_to_fwnode(port->dev->of_node);
+	struct xilinx_msi *msi = &port->msi;
+	int size = BITS_TO_LONGS(XILINX_NUM_MSI_IRQS) * sizeof(long);
+	struct device *dev = port->dev;
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
+	xilinx_pcie_dma_enable_msi(port);
+
+	return 0;
+
+out:
+	xilinx_pcie_dma_free_irq_domains(port);
+	dev_err(dev, "Failed to allocate MSI IRQ domains\n");
+	return -ENOMEM;
+}
+
+static void xilinx_pcie_dma_intx_flow(struct irq_desc *desc)
+{
+	struct xilinx_pcie_dma *port = irq_desc_get_handler_data(desc);
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
+		generic_handle_domain_irq(port->leg_domain, i);
+
+	chained_irq_exit(chip, desc);
+}
+
+static void xilinx_pcie_dma_mask_event_irq(struct irq_data *d)
+{
+	struct xilinx_pcie_dma *port = irq_data_get_irq_chip_data(d);
+	u32 val;
+
+	raw_spin_lock(&port->lock);
+	val = pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
+	val &= ~BIT(d->hwirq);
+	pcie_write(port, val, XILINX_PCIE_DMA_REG_IMR);
+	raw_spin_unlock(&port->lock);
+}
+
+static void xilinx_pcie_dma_unmask_event_irq(struct irq_data *d)
+{
+	struct xilinx_pcie_dma *port = irq_data_get_irq_chip_data(d);
+	u32 val;
+
+	raw_spin_lock(&port->lock);
+	val = pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
+	val |= BIT(d->hwirq);
+	pcie_write(port, val, XILINX_PCIE_DMA_REG_IMR);
+	raw_spin_unlock(&port->lock);
+}
+
+static struct irq_chip xilinx_pcie_dma_event_irq_chip = {
+	.name           = "RC-Event",
+	.irq_mask       = xilinx_pcie_dma_mask_event_irq,
+	.irq_unmask     = xilinx_pcie_dma_unmask_event_irq,
+};
+
+static int xilinx_pcie_dma_event_map(struct irq_domain *domain,
+				     unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &xilinx_pcie_dma_event_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
+	return 0;
+}
+
+static const struct irq_domain_ops event_domain_ops = {
+	.map = xilinx_pcie_dma_event_map,
+};
+
+/**
+ * xilinx_pcie_dma_init_irq_domain - Initialize IRQ domain
+ * @port: PCIe port information
+ *
+ * Return: '0' on success and error value on failure
+ */
+static int xilinx_pcie_dma_init_irq_domain(struct xilinx_pcie_dma *port)
+{
+	struct device *dev = port->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *pcie_intc_node;
+	int ret;
+
+	/* Setup INTx */
+	pcie_intc_node = of_get_next_child(node, NULL);
+	if (!pcie_intc_node) {
+		dev_err(dev, "No PCIe Intc node found\n");
+		return PTR_ERR(pcie_intc_node);
+	}
+
+	port->pldma_domain = irq_domain_add_linear(pcie_intc_node, 32,
+						   &event_domain_ops, port);
+	if (!port->pldma_domain)
+		goto out;
+
+	irq_domain_update_bus_token(port->pldma_domain, DOMAIN_BUS_NEXUS);
+
+	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						 &intx_domain_ops,
+						 port);
+	if (!port->leg_domain) {
+		dev_err(dev, "Failed to get a legacy IRQ domain\n");
+		return PTR_ERR(port->leg_domain);
+	}
+
+	irq_domain_update_bus_token(port->leg_domain, DOMAIN_BUS_WIRED);
+
+	ret = xilinx_pcie_dma_init_msi_irq_domain(port);
+	if (ret != 0) {
+		irq_domain_remove(port->leg_domain);
+		return -ENOMEM;
+	}
+
+	of_node_put(pcie_intc_node);
+	raw_spin_lock_init(&port->lock);
+
+	return 0;
+out:
+	return -ENOMEM;
+}
+
+static int xilinx_pcie_dma_setup_irq(struct xilinx_pcie_dma *port)
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
+		err = devm_request_irq(dev, irq, xilinx_pcie_dma_intr_handler,
+				       0, intr_cause[i].sym, port);
+		if (err) {
+			dev_err(dev, "Failed to request IRQ %d\n", irq);
+			return err;
+		}
+	}
+
+	port->intx_irq = irq_create_mapping(port->pldma_domain,
+					    XILINX_PCIE_DMA_INTR_INTX);
+	if (!port->intx_irq) {
+		dev_err(dev, "Failed to map INTx interrupt\n");
+		return -ENXIO;
+	}
+
+	/* Plug the INTx chained handler */
+	irq_set_chained_handler_and_data(port->intx_irq,
+					 xilinx_pcie_dma_intx_flow, port);
+
+	/* Plug the main event chained handler */
+	irq_set_chained_handler_and_data(port->irq,
+					 xilinx_pcie_dma_event_flow, port);
+
+	return 0;
+}
+
+/**
+ * xilinx_pcie_dma_init_port - Initialize hardware
+ * @port: PCIe port information
+ */
+static void xilinx_pcie_dma_init_port(struct xilinx_pcie_dma *port)
+{
+	if (xilinx_pcie_dma_linkup(port))
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
+	/* Enable the Bridge enable bit */
+	pcie_write(port, pcie_read(port, XILINX_PCIE_DMA_REG_RPSC) |
+			 XILINX_PCIE_DMA_REG_RPSC_BEN,
+		   XILINX_PCIE_DMA_REG_RPSC);
+}
+
+static int xilinx_request_msi_irq(struct xilinx_pcie_dma *port)
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
+					 xilinx_pcie_dma_msi_handler_low,
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
+					 xilinx_pcie_dma_msi_handler_high,
+					 port);
+
+	return 0;
+}
+
+/**
+ * xilinx_pcie_dma_parse_dt - Parse Device tree
+ * @port: PCIe port information
+ *
+ * Return: '0' on success and error value on failure
+ */
+static int xilinx_pcie_dma_parse_dt(struct xilinx_pcie_dma *port,
+				    struct resource *bus_range)
+{
+	struct device *dev = port->dev;
+	struct device_node *node = dev->of_node;
+	struct resource regs;
+	int err;
+
+	err = of_address_to_resource(node, 0, &regs);
+	if (err) {
+		dev_err(dev, "missing \"reg\" property\n");
+		return err;
+	}
+	port->phys_reg_base = regs.start;
+
+	port->cfg = pci_ecam_create(dev, &regs, bus_range, &xilinx_pcie_dma_ops);
+	if (IS_ERR(port->cfg))
+		return -1;
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
+/**
+ * xilinx_pcie_dma_probe - Probe function
+ * @pdev: Platform device pointer
+ *
+ * Return: '0' on success and error value on failure
+ */
+static int xilinx_pcie_dma_probe(struct platform_device *pdev)
+{
+	struct xilinx_pcie_dma *port;
+	struct device *dev = &pdev->dev;
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
+	err = xilinx_pcie_dma_parse_dt(port, bus->res);
+	if (err) {
+		dev_err(dev, "Parsing DT failed\n");
+		return err;
+	}
+
+	xilinx_pcie_dma_init_port(port);
+
+	err = xilinx_pcie_dma_init_irq_domain(port);
+	if (err)
+		goto err_irq_domain;
+
+	err = xilinx_pcie_dma_setup_irq(port);
+
+	bridge->sysdata = port;
+	bridge->ops = (struct pci_ops *)&xilinx_pcie_dma_ops.pci_ops;
+
+	err = pci_host_probe(bridge);
+	if (err < 0)
+		goto err_host_bridge;
+
+	return 0;
+
+err_host_bridge:
+	xilinx_pcie_dma_free_irq_domains(port);
+
+err_irq_domain:
+	pci_ecam_free(port->cfg);
+	xilinx_pcie_dma_free_interrupts(port);
+	return err;
+}
+
+static const struct of_device_id xilinx_pcie_dma_of_match[] = {
+	{
+		.compatible = "xlnx,xdma-host-3.00",
+	},
+	{}
+};
+
+static struct platform_driver xilinx_pcie_dma_driver = {
+	.driver = {
+		.name = "xilinx-xdma-pcie",
+		.of_match_table = xilinx_pcie_dma_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = xilinx_pcie_dma_probe,
+};
+
+builtin_platform_driver(xilinx_pcie_dma_driver);
-- 
2.25.1

