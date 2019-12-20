Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CBC127A27
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 12:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLTLnZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 06:43:25 -0500
Received: from mail-eopbgr760081.outbound.protection.outlook.com ([40.107.76.81]:11589
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727185AbfLTLnY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 06:43:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anbtrEYvrDBmWdMz2v4g+BrE9ATgk0hS153nsv3XVw+T4w07ds/ezgEYf8vwzFpkQBIxnmNVGw3Rd4CRWXMQPwRA+M6/AUPelTUaylLP9UJzx1MPNKjbkndYmgHJIVG6PGPZgrjTECNrcukabod+escSWkbcsjfnooUgy1/WkejYPYYwIbbOeX45ZfIqUbTwjoZJUFR6nI115j6AzVVdHjFWt2uBmyhOjWwGJOjJmukU1PrrZ6MQgaM+Sld+SXzDfzicXiViJC/174wooVOUEc6iC4agaFgAUiZboXixyMrfo4Wx3Np2JomBTURSq7HfjGlppvWsBdZ1nNOmwwQMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7s7xuOhLuVlUul8EY6kRGw5Z5DAvL8vhZKml0HwEk0=;
 b=oK7SCeFNp99Pe8ui1jQKWAej3h26v26284kVx/EE1fpgcBqO/PMK0YrGh0b0LberKvvUe/wrbC0w2S0dakn/BvTVUFxvdlqAKoIx00qNkzZldQ26oEYvemQCyxJyTCBY4A9NaSAwhDxMc30Xvjs4HxCaoZNrH0lI10V7PIxcN3Ic1gIiljbL95wgLVOpYTBhKCsOvm2nayzfF4U8dqJgUsyfhWKxZ/WdeCb6eHT6lKEBVla0CtI7Z/l83ipeNApGzpb0uTHOjfp3frVnS1CQquKoNvq17KNWt+pdtvhmRlPe1dqIAKWWk4BjsCccxmqGQ8gDC4wZHZPtn/SmlNvQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=google.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7s7xuOhLuVlUul8EY6kRGw5Z5DAvL8vhZKml0HwEk0=;
 b=CjGXUQI4bS5ssGUG2XdHOWN7MdE6i1p7smw8q+QlbRPELJZMNsm5/9R28qh4xJ3UQRUhUa/PpSPmOBkb08CHfqjsNRoit7l/cHKtDc8pPXtnxRVfcNbgrtnBreGXtnUIkTvR8qyqFd40D88zNpC4/eTtMePRmJ98YADSwpVwxh0=
Received: from SN4PR0201CA0066.namprd02.prod.outlook.com
 (2603:10b6:803:20::28) by DM5PR02MB3354.namprd02.prod.outlook.com
 (2603:10b6:4:6a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Fri, 20 Dec
 2019 11:41:32 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by SN4PR0201CA0066.outlook.office365.com
 (2603:10b6:803:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15 via Frontend
 Transport; Fri, 20 Dec 2019 11:41:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Fri, 20 Dec 2019 11:41:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iiGex-0001Hf-Ne; Fri, 20 Dec 2019 03:41:31 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iiGes-0006Ne-KB; Fri, 20 Dec 2019 03:41:26 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xBKBfP4b011915;
        Fri, 20 Dec 2019 03:41:25 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iiGeq-0006LD-KX; Fri, 20 Dec 2019 03:41:25 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 2/2] PCI: Versal CPM: Add support for Versal CPM Root Port driver
Date:   Fri, 20 Dec 2019 17:11:12 +0530
Message-Id: <1576842072-32027-3-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576842072-32027-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1576842072-32027-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(186003)(9786002)(4326008)(70586007)(26005)(36756003)(356004)(426003)(5660300002)(81156014)(7696005)(107886003)(2616005)(6666004)(2906002)(81166006)(30864003)(70206006)(8676002)(336012)(316002)(8936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3354;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fef2a5aa-5b37-4d62-a216-08d785418f96
X-MS-TrafficTypeDiagnostic: DM5PR02MB3354:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3354B8094DA9D0F03DC6BB44A52D0@DM5PR02MB3354.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-Forefront-PRVS: 025796F161
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KTbX8+TSBWwvdQHtDUHl9AZr1kWHDAXhAYmI4MPYrZbBFgjSM6igeRtAdR6mtiV1/q5n1p3vOJyivkilfp9yHu4oaPNte1QhLfyeQAtvStkB2zNQ/CiNHSHgj/zt+YM62f3Sebq3gCO6Tu7Mb7p/PPSUouGTj4d3zr2rWiaDLa3HznracFVTuDu43Pb80pumKa+TzObZMM1D71R+I/3vNHvBV3p8gKF6Peb76nHpVaiulBWxjufHzxz1AcaAkv1pCe3Kze5NZm0DsdztkdvvE15bNvYrihPWXrJyEFHPfUoYRRKQy2QqSnP5O9l1p6iK9gJVFK8+Kq1z60Uc9axks+ytmS7JNtdsziqfrTOt/v0/EFpCfZ96WnIrkg/Ph2lmNG/F+M9+lA3AsbrNsh4zMbsD2QA/akQrrnIp4fhkGZqHpq08sUHai1OTIoUdCVI
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 11:41:32.2404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef2a5aa-5b37-4d62-a216-08d785418f96
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3354
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

- Adding support for versal CPM as Root Port.
- The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
  block for CPM along with the integrated bridge can function
  as PCIe Root Port.
- Versal CPM uses GICv3 ITS feature for assigning MSI/MSI-X
  vectors and handling MSI/MSI-X interrupts.
- Bridge error and legacy interrupts in versal CPM are handled using
  versal CPM specific MISC interrupt line.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/Kconfig           |   8 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c | 511 +++++++++++++++++++++++++++++++
 3 files changed, 520 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index c77069c..eca496d 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -81,6 +81,14 @@ config PCIE_XILINX
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
 
+config PCIE_XILINX_CPM
+	bool "Xilinx Versal CPM host bridge support"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  Say 'Y' here if you want kernel to enable support the
+	  Xilinx Versal CPM host Bridge driver.The driver supports
+	  MSI/MSI-X interrupts using GICv3 ITS feature.
+
 config PCI_XGENE
 	bool "X-Gene PCIe controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 3d4f597..6c936e9 100644
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
index 0000000..9c0852a
--- /dev/null
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -0,0 +1,511 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCIe host controller driver for Xilinx Versal CPM DMA Bridge
+ *
+ * (C) Copyright 2019 - 2020, Xilinx, Inc.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
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
+#define XILINX_CPM_PCIE_INTR_LINK_DOWN		BIT(0)
+#define XILINX_CPM_PCIE_INTR_HOT_RESET		BIT(3)
+#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	BIT(8)
+#define XILINX_CPM_PCIE_INTR_CORRECTABLE	BIT(9)
+#define XILINX_CPM_PCIE_INTR_NONFATAL		BIT(10)
+#define XILINX_CPM_PCIE_INTR_FATAL		BIT(11)
+#define XILINX_CPM_PCIE_INTR_INTX		BIT(16)
+#define XILINX_CPM_PCIE_INTR_MSI		BIT(17)
+#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		BIT(20)
+#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		BIT(21)
+#define XILINX_CPM_PCIE_INTR_SLV_COMPL		BIT(22)
+#define XILINX_CPM_PCIE_INTR_SLV_ERRP		BIT(23)
+#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		BIT(24)
+#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		BIT(25)
+#define XILINX_CPM_PCIE_INTR_MST_DECERR		BIT(26)
+#define XILINX_CPM_PCIE_INTR_MST_SLVERR		BIT(27)
+#define XILINX_CPM_PCIE_IMR_ALL_MASK		0x1FF39FF9
+#define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
+#define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
+#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	BIT(4)
+#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	BIT(12)
+#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	BIT(15)
+#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	BIT(17)
+#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	BIT(28)
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
+/* ECAM definitions */
+#define ECAM_BUS_NUM_SHIFT		20
+#define ECAM_DEV_NUM_SHIFT		12
+
+#define INTX_NUM                        4
+
+/**
+ * struct xilinx_cpm_pcie_port - PCIe port information
+ * @reg_base: Bridge Register Base
+ * @cpm_base: CPM SLCR Register Base
+ * @irq: Interrupt number
+ * @root_busno: Root Bus number
+ * @dev: Device pointer
+ * @leg_domain: Legacy IRQ domain pointer
+ * @irq_misc: Legacy and error interrupt number
+ */
+struct xilinx_cpm_pcie_port {
+	void __iomem *reg_base;
+	void __iomem *cpm_base;
+	u32 irq;
+	u8 root_busno;
+	struct device *dev;
+	struct irq_domain *leg_domain;
+	int irq_misc;
+};
+
+static inline u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 reg)
+{
+	return readl(port->reg_base + reg);
+}
+
+static inline void pcie_write(struct xilinx_cpm_pcie_port *port,
+			      u32 val, u32 reg)
+{
+	writel(val, port->reg_base + reg);
+}
+
+static inline bool cpm_pcie_link_is_up(struct xilinx_cpm_pcie_port *port)
+{
+	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
+		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
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
+/**
+ * xilinx_cpm_pcie_valid_device - Check if a valid device is present on bus
+ * @bus: PCI Bus structure
+ * @devfn: device/function
+ *
+ * Return: 'true' on success and 'false' if invalid device is found
+ */
+static bool xilinx_cpm_pcie_valid_device(struct pci_bus *bus,
+					 unsigned int devfn)
+{
+	struct xilinx_cpm_pcie_port *port = bus->sysdata;
+
+	/* Check if link is up when trying to access downstream ports */
+	if (bus->number != port->root_busno)
+		if (!cpm_pcie_link_is_up(port))
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
+ * xilinx_cpm_pcie_map_bus - Get configuration base
+ * @bus: PCI Bus structure
+ * @devfn: Device/function
+ * @where: Offset from base
+ *
+ * Return: Base address of the configuration space needed to be
+ *	   accessed.
+ */
+static void __iomem *xilinx_cpm_pcie_map_bus(struct pci_bus *bus,
+					     unsigned int devfn, int where)
+{
+	struct xilinx_cpm_pcie_port *port = bus->sysdata;
+	int relbus;
+
+	if (!xilinx_cpm_pcie_valid_device(bus, devfn))
+		return NULL;
+
+	relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
+		 (devfn << ECAM_DEV_NUM_SHIFT);
+
+	return port->reg_base + relbus + where;
+}
+
+/* PCIe operations */
+static struct pci_ops xilinx_cpm_pcie_ops = {
+	.map_bus = xilinx_cpm_pcie_map_bus,
+	.read	= pci_generic_config_read,
+	.write	= pci_generic_config_write,
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
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
+
+	return 0;
+}
+
+/* INTx IRQ Domain operations */
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = xilinx_cpm_pcie_intx_map,
+	.xlate = pci_irqd_intx_xlate,
+};
+
+/**
+ * xilinx_cpm_pcie_intr_handler - Interrupt Service Handler
+ * @irq: IRQ number
+ * @data: PCIe port information
+ *
+ * Return: IRQ_HANDLED on success and IRQ_NONE on failure
+ */
+static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *data)
+{
+	struct xilinx_cpm_pcie_port *port =
+				(struct xilinx_cpm_pcie_port *)data;
+	u32 val, mask, status, bit;
+	unsigned long intr_val;
+
+	/* Read interrupt decode and mask registers */
+	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
+	mask = pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
+
+	status = val & mask;
+	if (!status)
+		return IRQ_NONE;
+
+	if (status & XILINX_CPM_PCIE_INTR_LINK_DOWN)
+		dev_warn(port->dev, "Link Down\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_HOT_RESET)
+		dev_info(port->dev, "Hot reset\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_CFG_TIMEOUT)
+		dev_warn(port->dev, "ECAM access timeout\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_CORRECTABLE) {
+		dev_warn(port->dev, "Correctable error message\n");
+		cpm_pcie_clear_err_interrupts(port);
+	}
+
+	if (status & XILINX_CPM_PCIE_INTR_NONFATAL) {
+		dev_warn(port->dev, "Non fatal error message\n");
+		cpm_pcie_clear_err_interrupts(port);
+	}
+
+	if (status & XILINX_CPM_PCIE_INTR_FATAL) {
+		dev_warn(port->dev, "Fatal error message\n");
+		cpm_pcie_clear_err_interrupts(port);
+	}
+
+	if (status & XILINX_CPM_PCIE_INTR_INTX) {
+		/* Handle INTx Interrupt */
+		intr_val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN);
+		intr_val = intr_val >> XILINX_CPM_PCIE_IDRN_SHIFT;
+
+		for_each_set_bit(bit, &intr_val, INTX_NUM)
+			generic_handle_irq(irq_find_mapping(port->leg_domain,
+							    bit));
+	}
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_UNSUPP)
+		dev_warn(port->dev, "Slave unsupported request\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_UNEXP)
+		dev_warn(port->dev, "Slave unexpected completion\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_COMPL)
+		dev_warn(port->dev, "Slave completion timeout\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_ERRP)
+		dev_warn(port->dev, "Slave Error Poison\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_CMPABT)
+		dev_warn(port->dev, "Slave Completer Abort\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_ILLBUR)
+		dev_warn(port->dev, "Slave Illegal Burst\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_MST_DECERR)
+		dev_warn(port->dev, "Master decode error\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_MST_SLVERR)
+		dev_warn(port->dev, "Master slave error\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT)
+		dev_warn(port->dev, "PCIe ECAM access timeout\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_CFG_ERR_POISON)
+		dev_warn(port->dev, "ECAM poisoned completion received\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD)
+		dev_warn(port->dev, "PME_TO_ACK message received\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_PM_PME_RCVD)
+		dev_warn(port->dev, "PM_PME message received\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT)
+		dev_warn(port->dev, "PCIe completion timeout received\n");
+
+	/* Clear the Interrupt Decode register */
+	pcie_write(port, status, XILINX_CPM_PCIE_REG_IDR);
+	val = readl(port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
+	if (val)
+		writel(val, port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
+
+	return IRQ_HANDLED;
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
+		return PTR_ERR(pcie_intc_node);
+	}
+
+	port->leg_domain = irq_domain_add_linear(pcie_intc_node, INTX_NUM,
+						 &intx_domain_ops,
+						 port);
+	if (!port->leg_domain) {
+		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		return PTR_ERR(port->leg_domain);
+	}
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
+	if (cpm_pcie_link_is_up(port))
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
+	/* Enable all interrupts */
+	pcie_write(port, XILINX_CPM_PCIE_IMR_ALL_MASK,
+		   XILINX_CPM_PCIE_REG_IMR);
+	pcie_write(port, XILINX_CPM_PCIE_IDRN_MASK,
+		   XILINX_CPM_PCIE_REG_IDRN_MASK);
+
+	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
+	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
+	/* Enable the Bridge enable bit */
+	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
+		   XILINX_CPM_PCIE_REG_RPSC_BEN,
+		   XILINX_CPM_PCIE_REG_RPSC);
+}
+
+static int xilinx_cpm_request_misc_irq(struct xilinx_cpm_pcie_port *port)
+{
+	struct device *dev = port->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int err;
+
+	port->irq_misc = platform_get_irq_byname(pdev, "misc");
+	if (port->irq_misc <= 0) {
+		dev_err(dev, "Unable to find misc IRQ line\n");
+		return port->irq_misc;
+	}
+	err = devm_request_irq(dev, port->irq_misc,
+			       xilinx_cpm_pcie_intr_handler,
+			       IRQF_SHARED | IRQF_NO_THREAD,
+			       "xilinx-pcie", port);
+	if (err) {
+		dev_err(dev, "unable to request misc IRQ line %d\n",
+			port->irq_misc);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * xilinx_cpm_pcie_parse_dt - Parse Device tree
+ * @port: PCIe port information
+ *
+ * Return: '0' on success and error value on failure
+ */
+static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port)
+{
+	struct device *dev = port->dev;
+	struct resource *res;
+	int err;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	port->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(port->reg_base))
+		return PTR_ERR(port->reg_base);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "cpm_slcr");
+	port->cpm_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(port->cpm_base))
+		return PTR_ERR(port->cpm_base);
+
+	err = xilinx_cpm_request_misc_irq(port);
+	if (err)
+		return err;
+
+	return 0;
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
+	struct pci_bus *bus;
+	struct pci_bus *child;
+	struct pci_host_bridge *bridge;
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
+	err = xilinx_cpm_pcie_parse_dt(port);
+	if (err) {
+		dev_err(dev, "Parsing DT failed\n");
+		return err;
+	}
+
+	xilinx_cpm_pcie_init_port(port);
+
+	err = xilinx_cpm_pcie_init_irq_domain(port);
+	if (err) {
+		dev_err(dev, "Failed creating IRQ Domain\n");
+		return err;
+	}
+
+	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      &bridge->dma_ranges, NULL);
+	if (err) {
+		dev_err(dev, "Getting bridge resources failed\n");
+		return err;
+	}
+
+	bridge->dev.parent = dev;
+	bridge->sysdata = port;
+	bridge->busnr = port->root_busno;
+	bridge->ops = &xilinx_cpm_pcie_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
+
+	err = pci_scan_root_bus_bridge(bridge);
+	if (err)
+		return err;
+
+	bus = bridge->bus;
+
+	pci_assign_unassigned_bus_resources(bus);
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+	pci_bus_add_devices(bus);
+	return 0;
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

