Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73431FB151
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 14:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgFPM5d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 08:57:33 -0400
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:34229
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728746AbgFPM5Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 08:57:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmuR7FyKopsKepS5MD+LTXeKnZl5JiHYZZ9vP30YJzUTAKcC2AN17ZD2VQG2uGqEQHD1iIhqoVq7VboMmdDrjSSjRDJPAfHlnls72P43HoSxkzYp+f1zYNDkXi6EVfhTduz32bgyWvGTEztw4wGGKPKaIzmZbclRW1XCGh8cdNeQzjA3Q0hKNiaGyompG0wiq5rxGKxAIFsVeUNLVlJVBpSQumJn9Uhkjp2spNS+2tHlUs9cVzwnWtCzDZk9w6ngOnWYtFf6J48SHRF3Hnj2Loc7teIUh71D9C54wRAcxM56F3FC7cz4jqjq+Tl4KePXxB/8kRuLW4bhrHlQH6HMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDftiwUA95qts/z1YNn/xJcMjXj9oSRQPd4g7ZrQMXA=;
 b=Fjr36Nop3MXOY2UIUsLoKbeCOwElsmLTJrQP7Xc3Z5S+8RgbfEuaaXKRV+w0p/d96TbN47joFt+IeX4A74UATOGjyVBLr6aItLZBk0bDqTNVXI4PkNreGx6m2cOp+3mSxvgbOMQjDwfJrlrdVI17Hh63N32E7/t291yNj+NHZKLk7dk4K1FKcUIH8UXfkfMqJzc1tWB6Mmm8OwUXfBgeidOiMDzo+q6ErgwlwYu2+eq5aLvuWtdrAmeo0waF26JOl9XRFCBO35Leo+FH1wRKTRrooEakE9aJwlMSrhEDqxKSSTWZXZXLft1bY7fSzTiHKjS8Ad0E9URwSmYLJfqnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDftiwUA95qts/z1YNn/xJcMjXj9oSRQPd4g7ZrQMXA=;
 b=c9viDkNH5b1oZumVafRCcJzILRmk5Acgl+r5wHq/ofNykXTMmZSHp6sF0QS9IpXxgI3YajK8uP73+fi+hI5S2HnPGCXZe3EAcvSomx3MEUGfmDk+O1nYaI8kwjtwYHR/7sX6ApEPOrpOIwVhxbJ1NAi1vvjy1XutzCh4JMZjYjo=
Received: from CY4PR13CA0047.namprd13.prod.outlook.com (2603:10b6:903:99::33)
 by CY4PR02MB2278.namprd02.prod.outlook.com (2603:10b6:903:15::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 16 Jun
 2020 12:57:10 +0000
Received: from CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::a3) by CY4PR13CA0047.outlook.office365.com
 (2603:10b6:903:99::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.10 via Frontend
 Transport; Tue, 16 Jun 2020 12:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT021.mail.protection.outlook.com (10.152.75.187) with Microsoft SMTP
 Server id 15.20.3088.18 via Frontend Transport; Tue, 16 Jun 2020 12:57:09
 +0000
Received: from [149.199.38.66] (port=60998 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jlB8I-0000xW-HI; Tue, 16 Jun 2020 05:56:06 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jlB9J-0001rZ-J8; Tue, 16 Jun 2020 05:57:09 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05GCv8c6017279;
        Tue, 16 Jun 2020 05:57:08 -0700
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jlB9H-0001oA-Cd; Tue, 16 Jun 2020 05:57:08 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        maz@kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Date:   Tue, 16 Jun 2020 18:26:54 +0530
Message-Id: <1592312214-9347-3-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(136003)(396003)(46966005)(26005)(107886003)(4326008)(83380400001)(316002)(81166007)(8936002)(478600001)(47076004)(82740400003)(356005)(82310400002)(8676002)(426003)(336012)(7696005)(2616005)(70586007)(6666004)(70206006)(9786002)(5660300002)(2906002)(186003)(36756003)(30864003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 982e5cbc-e884-4bf3-424f-08d811f4c80c
X-MS-TrafficTypeDiagnostic: CY4PR02MB2278:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR02MB22783FB366D403B141D0F8C2A59D0@CY4PR02MB2278.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9e1XhiufVKmpPtvUnUSvF2skr6/NoLnNSEHVIwDy/Dh08vaNE1iVFMGCtTxUNHzqiRu5SV5x/Uq/K1LnlGxzK5e4X1JazpWYXWYdYv+4qDX9HQW7K7TXJSZanRtK6e4oebi+hwKMrBE2eGrhLrUxbgU1N2oJTQZLfO1kS1hLhKYgKWjnIoyvXzkqeqVEqaF+MizlOPuVhgcNlP0UUb3l867IXlUjEeO4Pkfd0asvKOvIYWeB3ycCeWR5RFO3Fi0wBVqlovhWaHSxmBwwxQWalhzboc9miM456Y62alJWywyC2NzWL6pxRvKC+UCJqXY2ZhsRfpnf6eRK/OAc53xIr+sK1m179G/EZhWEDzJlL3+s+cngYOcC2XCCOJHO8u564fccvLu+HvZ5M+MUHkfpvA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 12:57:09.8764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982e5cbc-e884-4bf3-424f-08d811f4c80c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2278
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

- Add support for Versal CPM as Root Port.
- The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
  block for CPM along with the integrated bridge can function
  as PCIe Root Port.
- Bridge error and legacy interrupts in Versal CPM are handled using
  Versal CPM specific interrupt line.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/Kconfig           |   8 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c | 617 +++++++++++++++++++++++++++++++
 3 files changed, 626 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 20bf00f..d9e393a 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -81,6 +81,14 @@ config PCIE_XILINX
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
 
+config PCIE_XILINX_CPM
+	bool "Xilinx Versal CPM host bridge support"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	select PCI_HOST_COMMON
+	help
+	  Say 'Y' here if you want kernel support for the
+	  Xilinx Versal CPM host bridge.
+
 config PCI_XGENE
 	bool "X-Gene PCIe controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 01b2502..78dabda 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
 obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
+obj-$(CONFIG_PCIE_XILINX_CPM) += pcie-xilinx-cpm.o
 obj-$(CONFIG_PCI_V3_SEMI) += pci-v3-semi.o
 obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
 obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
new file mode 100644
index 0000000..2592dbb4
--- /dev/null
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -0,0 +1,617 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCIe host controller driver for Xilinx Versal CPM DMA Bridge
+ *
+ * (C) Copyright 2019 - 2020, Xilinx, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/pci-ecam.h>
+
+#include "../pci.h"
+
+/* Register definitions */
+#define XILINX_CPM_PCIE_REG_IDR		0x00000E10
+#define XILINX_CPM_PCIE_REG_IMR		0x00000E14
+#define XILINX_CPM_PCIE_REG_PSCR	0x00000E1C
+#define XILINX_CPM_PCIE_REG_RPSC	0x00000E20
+#define XILINX_CPM_PCIE_REG_RPEFR	0x00000E2C
+#define XILINX_CPM_PCIE_REG_IDRN	0x00000E38
+#define XILINX_CPM_PCIE_REG_IDRN_MASK	0x00000E3C
+#define XILINX_CPM_PCIE_MISC_IR_STATUS	0x00000340
+#define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
+#define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
+
+/* Interrupt registers definitions */
+#define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
+#define XILINX_CPM_PCIE_INTR_HOT_RESET		3
+#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	4
+#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	8
+#define XILINX_CPM_PCIE_INTR_CORRECTABLE	9
+#define XILINX_CPM_PCIE_INTR_NONFATAL		10
+#define XILINX_CPM_PCIE_INTR_FATAL		11
+#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	12
+#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	15
+#define XILINX_CPM_PCIE_INTR_INTX		16
+#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	17
+#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		20
+#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		21
+#define XILINX_CPM_PCIE_INTR_SLV_COMPL		22
+#define XILINX_CPM_PCIE_INTR_SLV_ERRP		23
+#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		24
+#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		25
+#define XILINX_CPM_PCIE_INTR_MST_DECERR		26
+#define XILINX_CPM_PCIE_INTR_MST_SLVERR		27
+#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	28
+
+#define IMR(x) BIT(XILINX_CPM_PCIE_INTR_ ##x)
+
+#define XILINX_CPM_PCIE_IMR_ALL_MASK			\
+	(						\
+		IMR(LINK_DOWN)		|		\
+		IMR(HOT_RESET)		|		\
+		IMR(CFG_PCIE_TIMEOUT)	|		\
+		IMR(CFG_TIMEOUT)	|		\
+		IMR(CORRECTABLE)	|		\
+		IMR(NONFATAL)		|		\
+		IMR(FATAL)		|		\
+		IMR(CFG_ERR_POISON)	|		\
+		IMR(PME_TO_ACK_RCVD)	|		\
+		IMR(INTX)		|		\
+		IMR(PM_PME_RCVD)	|		\
+		IMR(SLV_UNSUPP)		|		\
+		IMR(SLV_UNEXP)		|		\
+		IMR(SLV_COMPL)		|		\
+		IMR(SLV_ERRP)		|		\
+		IMR(SLV_CMPABT)		|		\
+		IMR(SLV_ILLBUR)		|		\
+		IMR(MST_DECERR)		|		\
+		IMR(MST_SLVERR)		|		\
+		IMR(SLV_PCIE_TIMEOUT)			\
+	)
+
+#define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
+#define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
+#define XILINX_CPM_PCIE_IDRN_SHIFT		16
+
+/* Root Port Error FIFO Read Register definitions */
+#define XILINX_CPM_PCIE_RPEFR_ERR_VALID		BIT(18)
+#define XILINX_CPM_PCIE_RPEFR_REQ_ID		GENMASK(15, 0)
+#define XILINX_CPM_PCIE_RPEFR_ALL_MASK		0xFFFFFFFF
+
+/* Root Port Status/control Register definitions */
+#define XILINX_CPM_PCIE_REG_RPSC_BEN		BIT(0)
+
+/* Phy Status/Control Register definitions */
+#define XILINX_CPM_PCIE_REG_PSCR_LNKUP		BIT(11)
+
+/**
+ * struct xilinx_cpm_pcie_port - PCIe port information
+ * @reg_base: Bridge Register Base
+ * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
+ * @dev: Device pointer
+ * @intx_domain: Legacy IRQ domain pointer
+ * @cfg: Holds mappings of config space window
+ * @intx_irq: legacy interrupt number
+ * @irq: Error interrupt number
+ * @lock: lock protecting shared register access
+ */
+struct xilinx_cpm_pcie_port {
+	void __iomem			*reg_base;
+	void __iomem			*cpm_base;
+	struct device			*dev;
+	struct irq_domain		*intx_domain;
+	struct irq_domain		*cpm_domain;
+	struct pci_config_window	*cfg;
+	int				intx_irq;
+	int				irq;
+	raw_spinlock_t			lock;
+};
+
+static u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 reg)
+{
+	return readl_relaxed(port->reg_base + reg);
+}
+
+static void pcie_write(struct xilinx_cpm_pcie_port *port,
+		       u32 val, u32 reg)
+{
+	writel_relaxed(val, port->reg_base + reg);
+}
+
+static bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port)
+{
+	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
+		XILINX_CPM_PCIE_REG_PSCR_LNKUP);
+}
+
+/**
+ * xilinx_cpm_pcie_clear_err_interrupts - Clear Error Interrupts
+ * @port: PCIe port information
+ */
+static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie_port *port)
+{
+	unsigned long val = pcie_read(port, XILINX_CPM_PCIE_REG_RPEFR);
+
+	if (val & XILINX_CPM_PCIE_RPEFR_ERR_VALID) {
+		dev_dbg(port->dev, "Requester ID %lu\n",
+			val & XILINX_CPM_PCIE_RPEFR_REQ_ID);
+		pcie_write(port, XILINX_CPM_PCIE_RPEFR_ALL_MASK,
+			   XILINX_CPM_PCIE_REG_RPEFR);
+	}
+}
+
+static void xilinx_cpm_mask_leg_irq(struct irq_data *data)
+{
+	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 mask;
+	u32 val;
+
+	mask = BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
+	pcie_write(port, (val & (~mask)), XILINX_CPM_PCIE_REG_IDRN_MASK);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void xilinx_cpm_unmask_leg_irq(struct irq_data *data)
+{
+	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 mask;
+	u32 val;
+
+	mask = BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
+	pcie_write(port, (val | mask), XILINX_CPM_PCIE_REG_IDRN_MASK);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static struct irq_chip xilinx_cpm_leg_irq_chip = {
+	.name		= "INTx",
+	.irq_mask	= xilinx_cpm_mask_leg_irq,
+	.irq_unmask	= xilinx_cpm_unmask_leg_irq,
+};
+
+/**
+ * xilinx_cpm_pcie_intx_map - Set the handler for the INTx and mark IRQ as valid
+ * @domain: IRQ domain
+ * @irq: Virtual IRQ number
+ * @hwirq: HW interrupt number
+ *
+ * Return: Always returns 0.
+ */
+static int xilinx_cpm_pcie_intx_map(struct irq_domain *domain,
+				    unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &xilinx_cpm_leg_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
+
+	return 0;
+}
+
+/* INTx IRQ Domain operations */
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = xilinx_cpm_pcie_intx_map,
+};
+
+static void xilinx_cpm_pcie_intx_flow(struct irq_desc *desc)
+{
+	struct xilinx_cpm_pcie_port *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long val;
+	int i;
+
+	chained_irq_enter(chip, desc);
+
+	val = FIELD_GET(XILINX_CPM_PCIE_IDRN_MASK,
+			pcie_read(port, XILINX_CPM_PCIE_REG_IDRN));
+
+	for_each_set_bit(i, &val, PCI_NUM_INTX)
+		generic_handle_irq(irq_find_mapping(port->intx_domain, i));
+
+	chained_irq_exit(chip, desc);
+}
+
+static void xilinx_cpm_mask_event_irq(struct irq_data *d)
+{
+	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(d);
+	u32 val;
+
+	raw_spin_lock(&port->lock);
+	val = pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
+	val &= ~BIT(d->hwirq);
+	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
+	raw_spin_unlock(&port->lock);
+}
+
+static void xilinx_cpm_unmask_event_irq(struct irq_data *d)
+{
+	struct xilinx_cpm_pcie_port *port = irq_data_get_irq_chip_data(d);
+	u32 val;
+
+	raw_spin_lock(&port->lock);
+	val = pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
+	val |= BIT(d->hwirq);
+	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
+	raw_spin_unlock(&port->lock);
+}
+
+static struct irq_chip xilinx_cpm_event_irq_chip = {
+	.name		= "RC-Event",
+	.irq_mask	= xilinx_cpm_mask_event_irq,
+	.irq_unmask	= xilinx_cpm_unmask_event_irq,
+};
+
+static int xilinx_cpm_pcie_event_map(struct irq_domain *domain,
+				     unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &xilinx_cpm_event_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
+	return 0;
+}
+
+static const struct irq_domain_ops event_domain_ops = {
+	.map = xilinx_cpm_pcie_event_map,
+};
+
+static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
+{
+	struct xilinx_cpm_pcie_port *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long val;
+	int i;
+
+	chained_irq_enter(chip, desc);
+	val =  pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
+	val &= pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
+	for_each_set_bit(i, &val, 32)
+		generic_handle_irq(irq_find_mapping(port->cpm_domain, i));
+	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
+
+	/*
+	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
+	 * CPM SLCR block.
+	 */
+	val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
+	if (val)
+		writel_relaxed(val,
+			       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
+
+	chained_irq_exit(chip, desc);
+}
+
+#define _IC(x, s)                              \
+	[XILINX_CPM_PCIE_INTR_ ## x] = { __stringify(x), s }
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
+	_IC(SLV_UNSUPP,		"Slave unsupported request"),
+	_IC(SLV_UNEXP,		"Slave unexpected completion"),
+	_IC(SLV_COMPL,		"Slave completion timeout"),
+	_IC(SLV_ERRP,		"Slave Error Poison"),
+	_IC(SLV_CMPABT,		"Slave Completer Abort"),
+	_IC(SLV_ILLBUR,		"Slave Illegal Burst"),
+	_IC(MST_DECERR,		"Master decode error"),
+	_IC(MST_SLVERR,		"Master slave error"),
+	_IC(CFG_PCIE_TIMEOUT,	"PCIe ECAM access timeout"),
+	_IC(CFG_ERR_POISON,	"ECAM poisoned completion received"),
+	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
+	_IC(PM_PME_RCVD,	"PM_PME message received"),
+	_IC(SLV_PCIE_TIMEOUT,	"PCIe completion timeout received"),
+};
+
+static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *dev_id)
+{
+	struct xilinx_cpm_pcie_port *port = dev_id;
+	struct device *dev = port->dev;
+	struct irq_data *d;
+
+	d = irq_domain_get_irq_data(port->cpm_domain, irq);
+
+	switch (d->hwirq) {
+	case XILINX_CPM_PCIE_INTR_CORRECTABLE:
+	case XILINX_CPM_PCIE_INTR_NONFATAL:
+	case XILINX_CPM_PCIE_INTR_FATAL:
+		cpm_pcie_clear_err_interrupts(port);
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
+static void xilinx_cpm_free_irq_domains(struct xilinx_cpm_pcie_port *port)
+{
+	if (port->intx_domain) {
+		irq_domain_remove(port->intx_domain);
+		port->intx_domain = NULL;
+	}
+
+	if (port->cpm_domain) {
+		irq_domain_remove(port->cpm_domain);
+		port->cpm_domain = NULL;
+	}
+}
+
+/**
+ * xilinx_cpm_pcie_init_irq_domain - Initialize IRQ domain
+ * @port: PCIe port information
+ *
+ * Return: '0' on success and error value on failure
+ */
+static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port *port)
+{
+	struct device *dev = port->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *pcie_intc_node;
+
+	/* Setup INTx */
+	pcie_intc_node = of_get_next_child(node, NULL);
+	if (!pcie_intc_node) {
+		dev_err(dev, "No PCIe Intc node found\n");
+		return -EINVAL;
+	}
+
+	port->cpm_domain = irq_domain_add_linear(pcie_intc_node, 32,
+						 &event_domain_ops,
+						 port);
+	if (!port->cpm_domain)
+		goto out;
+
+	irq_domain_update_bus_token(port->cpm_domain, DOMAIN_BUS_NEXUS);
+
+	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						  &intx_domain_ops,
+						  port);
+	if (!port->intx_domain)
+		goto out;
+
+	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
+
+	of_node_put(pcie_intc_node);
+	raw_spin_lock_init(&port->lock);
+
+	return 0;
+out:
+	xilinx_cpm_free_irq_domains(port);
+	dev_err(dev, "Failed to allocate IRQ domains\n");
+
+	return -ENOMEM;
+}
+
+static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port)
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
+		irq = irq_create_mapping(port->cpm_domain, i);
+		if (!irq) {
+			dev_err(dev, "Failed to map interrupt\n");
+			return -ENXIO;
+		}
+
+		err = devm_request_irq(dev, irq, xilinx_cpm_pcie_intr_handler,
+				       0, intr_cause[i].sym, port);
+		if (err) {
+			dev_err(dev, "Failed to request IRQ %d\n", irq);
+			return err;
+		}
+	}
+
+	port->intx_irq = irq_create_mapping(port->cpm_domain,
+					    XILINX_CPM_PCIE_INTR_INTX);
+	if (!port->intx_irq) {
+		dev_err(dev, "Failed to map INTx interrupt\n");
+		return -ENXIO;
+	}
+
+	/* Plug the INTx chained handler */
+	irq_set_chained_handler_and_data(port->intx_irq,
+					 xilinx_cpm_pcie_intx_flow, port);
+
+	/* Plug the main event chained handler */
+	irq_set_chained_handler_and_data(port->irq,
+					 xilinx_cpm_pcie_event_flow, port);
+
+	return 0;
+}
+
+/**
+ * xilinx_cpm_pcie_init_port - Initialize hardware
+ * @port: PCIe port information
+ */
+static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port *port)
+{
+	if (cpm_pcie_link_up(port))
+		dev_info(port->dev, "PCIe Link is UP\n");
+	else
+		dev_info(port->dev, "PCIe Link is DOWN\n");
+
+	/* Disable all interrupts */
+	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
+		   XILINX_CPM_PCIE_REG_IMR);
+
+	/* Clear pending interrupts */
+	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
+		   XILINX_CPM_PCIE_IMR_ALL_MASK,
+		   XILINX_CPM_PCIE_REG_IDR);
+
+	/*
+	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
+	 * CPM SLCR block.
+	 */
+	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
+	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
+	/* Enable the Bridge enable bit */
+	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
+		   XILINX_CPM_PCIE_REG_RPSC_BEN,
+		   XILINX_CPM_PCIE_REG_RPSC);
+}
+
+/**
+ * xilinx_cpm_pcie_parse_dt - Parse Device tree
+ * @port: PCIe port information
+ * @bus_range: Bus resource
+ *
+ * Return: '0' on success and error value on failure
+ */
+static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port,
+				    struct resource *bus_range)
+{
+	struct device *dev = port->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+
+	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
+							       "cpm_slcr");
+	if (IS_ERR(port->cpm_base))
+		return PTR_ERR(port->cpm_base);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	if (!res)
+		return -ENXIO;
+
+	port->cfg = pci_ecam_create(dev, res, bus_range,
+				    &pci_generic_ecam_ops);
+	if (IS_ERR(port->cfg))
+		return PTR_ERR(port->cfg);
+
+	port->reg_base = port->cfg->win;
+
+	return 0;
+}
+
+void xilinx_cpm_free_interrupts(struct xilinx_cpm_pcie_port *port)
+{
+	irq_set_chained_handler_and_data(port->intx_irq, NULL, NULL);
+	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+}
+
+/**
+ * xilinx_cpm_pcie_probe - Probe function
+ * @pdev: Platform device pointer
+ *
+ * Return: '0' on success and error value on failure
+ */
+static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
+{
+	struct xilinx_cpm_pcie_port *port;
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	struct resource *bus_range;
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
+	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      &bridge->dma_ranges, &bus_range);
+	if (err) {
+		dev_err(dev, "Getting bridge resources failed\n");
+		return err;
+	}
+
+	err = xilinx_cpm_pcie_init_irq_domain(port);
+	if (err)
+		return err;
+
+	err = xilinx_cpm_pcie_parse_dt(port, bus_range);
+	if (err) {
+		dev_err(dev, "Parsing DT failed\n");
+		goto err_parse_dt;
+	}
+
+	xilinx_cpm_pcie_init_port(port);
+
+	err = xilinx_cpm_setup_irq(port);
+	if (err) {
+		dev_err(dev, "Failed to set up interrupts\n");
+		goto err_setup_irq;
+	}
+
+	bridge->dev.parent = dev;
+	bridge->sysdata = port->cfg;
+	bridge->busnr = port->cfg->busr.start;
+	bridge->ops = &pci_generic_ecam_ops.pci_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
+
+	err = pci_host_probe(bridge);
+	if (err < 0)
+		goto err_host_bridge;
+
+	return 0;
+
+err_host_bridge:
+	xilinx_cpm_free_interrupts(port);
+err_setup_irq:
+	pci_ecam_free(port->cfg);
+err_parse_dt:
+	xilinx_cpm_free_irq_domains(port);
+	return err;
+}
+
+static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
+	{ .compatible = "xlnx,versal-cpm-host-1.00", },
+	{}
+};
+
+static struct platform_driver xilinx_cpm_pcie_driver = {
+	.driver = {
+		.name = "xilinx-cpm-pcie",
+		.of_match_table = xilinx_cpm_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = xilinx_cpm_pcie_probe,
+};
+
+builtin_platform_driver(xilinx_cpm_pcie_driver);
-- 
2.7.4

