Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D0914B46A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 13:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgA1MpX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 07:45:23 -0500
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:39584
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbgA1MpW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jan 2020 07:45:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXsvxGCuAlfvEtsO3iihtw2EZwoepq0B/P6bIXgw8Gx6ExTCRmrkzQsUSs7HUlTpjxAjos3GyxW+/Tf1cP2jesxvup5LwX5C4QiXw5QQuxnGDmtcuDYRDi2u8A2damnM7IO301blCAtLJ7KFEPZypTqHw8ftMDtSqSXVWeUrmkrb6CIed+J/4DcyTjM9U4o2sHXfxe+fffieH3u86TPGHfhiJ6+c2Rvs9tFeuhJDsPoAeek391r4zbAfUrgaGHdxPn+zJmNs57/2C0R9VDFCYJq0qenlzntPjiqEuVhWa3nW76yRp8MeS24YwG0b8B485H7cPxGERj82utVa1iFSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VAu1DyOFgrtqQZSXfhBXBHR8QWa+cSHmuaMW2tRBX8=;
 b=G5P3AdwmB5PIHzsiSW/XcypvOSrB8AAZXF+LaV7mSEOjsc+H6+a/dERUJISOmP6L1Ji58hQUjUkOFIcu0cSDRBsYJzfyIOyjmSfdTaCY6yUWycJN1UG+zTvDkx8E8i1mnbWCpeAHBDO2QmliVfXGoMgFtlBrDp0raj9vLaaDs9i1tfl5234EGggFhlNibhsFN89th/gBHAkO0cS1R30mZJvRtNn1MjTh1NGthuBhBc5cR44bRXtyKZSNeRFFeOn5PWWB/7UDlYccAg3HI6YtzOP4Ci1ptHBUG/AWjPmoMdzoDMqrru8efnk40pBiP2xbGj9AFDZ3gtHSRUcEJB39wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=google.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VAu1DyOFgrtqQZSXfhBXBHR8QWa+cSHmuaMW2tRBX8=;
 b=df7ihO0G/I8mYKdAp7orUuj6A/CqTx11ypgGWxJ59eISa+uCjhIkWhXKZeKEgwryMay3h8xkGq9UHPkEZDwXEdcEsl13T/ZfUFwKzPB9mp+yeWNPERLRahzMftBtFF6duFHf0pgNJvnOh0yeUh4i6Kmo9+hZTXbZfasfOfIUuV0=
Received: from BL0PR02CA0051.namprd02.prod.outlook.com (2603:10b6:207:3d::28)
 by BYAPR02MB5816.namprd02.prod.outlook.com (2603:10b6:a03:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22; Tue, 28 Jan
 2020 12:45:16 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BL0PR02CA0051.outlook.office365.com
 (2603:10b6:207:3d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.27 via Frontend
 Transport; Tue, 28 Jan 2020 12:45:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2665.18
 via Frontend Transport; Tue, 28 Jan 2020 12:45:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iwQF0-0007bX-Uq; Tue, 28 Jan 2020 04:45:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iwQEv-00077w-RD; Tue, 28 Jan 2020 04:45:09 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00SCix5Z016832;
        Tue, 28 Jan 2020 04:44:59 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iwQEl-0006pq-29; Tue, 28 Jan 2020 04:44:59 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v4 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Date:   Tue, 28 Jan 2020 18:14:43 +0530
Message-Id: <1580215483-8835-3-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580215483-8835-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1580215483-8835-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(107886003)(4326008)(5660300002)(2906002)(478600001)(7696005)(426003)(81166006)(2616005)(8936002)(9786002)(81156014)(8676002)(26005)(70586007)(70206006)(356004)(6666004)(36756003)(186003)(30864003)(316002)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5816;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a327eea-ecf8-475f-0ecd-08d7a3efec80
X-MS-TrafficTypeDiagnostic: BYAPR02MB5816:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5816391BCF23E791809D90C6A50A0@BYAPR02MB5816.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-Forefront-PRVS: 029651C7A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrFnbsipa5N6LHMGBOQiif2XIQdXhn568/fPYiDbyNf8bKv8VXwGudQU76ciBMGI3S0wZkuQXAr9TfAphXMi92GhlRrN7QEywgwduOBKe+0KYJDi/wR63YSy8qGIgQDBdvJdzJ7TxBVD7a3Tz3y/o5R7joHCt8skqB75WGOTMenyzM2QemjvjT7eOOuBVTFq/vpQmSMIcbNw8Ft0qOSgkDOYyYO2rRvxnLTg9y5QYifYCouOo++GOfRkr/ffLTAwqDM1limpBC8IMtwNPz4tCcvn3v9fw2MvMUCkMbrghx8hYtYGvZ5InOyKbdEWZKgOHy/T+a9gMtSNqpbG8aJnXLD9lL9/tKXY/j2ddEYAgd4NDNGolPtuFgj2T+plmCV/GtcbpUUIYKJ6VI5f5OP9tSmxIh9xXNmW32zceWwqW+Gsyf5lngQzq5LdE7RIZfN1
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 12:45:15.3979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a327eea-ecf8-475f-0ecd-08d7a3efec80
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5816
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

- Add support for Versal CPM as Root Port.
- The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
  block for CPM along with the integrated bridge can function
  as PCIe Root Port.
- CPM Versal uses GICv3 ITS feature for achieving assigning MSI/MSI-X
  vectors and handling MSI/MSI-X interrupts.
- Bridge error and legacy interrupts in Versal CPM are handled using
  Versal CPM specific MISC interrupt line.

Changes v4:
- change commit subject.
- Remove unnecessary comments and type cast.
- Added comments for CPM block register access using readl/writel.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/Kconfig           |   8 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c | 506 +++++++++++++++++++++++++++++++
 3 files changed, 515 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index c77069c..362f4db 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -81,6 +81,14 @@ config PCIE_XILINX
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
 
+config PCIE_XILINX_CPM
+	bool "Xilinx Versal CPM host bridge support"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  Say 'Y' here if you want kernel support for the
+	  Xilinx Versal CPM host bridge. The driver supports
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
index 0000000..49ec5c7
--- /dev/null
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -0,0 +1,506 @@
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
+/**
+ * struct xilinx_cpm_pcie_port - PCIe port information
+ * @reg_base: Bridge Register Base
+ * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
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
+static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port)
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
+static bool xilinx_cpm_pcie_valid_device(struct pci_bus *bus,
+					 unsigned int devfn)
+{
+	struct xilinx_cpm_pcie_port *port = bus->sysdata;
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
+	struct xilinx_cpm_pcie_port *port = data;
+	struct device *dev = port->dev;
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
+		dev_warn(dev, "Link Down\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_HOT_RESET)
+		dev_info(dev, "Hot reset\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_CFG_TIMEOUT)
+		dev_warn(dev, "ECAM access timeout\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_CORRECTABLE) {
+		dev_warn(dev, "Correctable error message\n");
+		cpm_pcie_clear_err_interrupts(port);
+	}
+
+	if (status & XILINX_CPM_PCIE_INTR_NONFATAL) {
+		dev_warn(dev, "Non fatal error message\n");
+		cpm_pcie_clear_err_interrupts(port);
+	}
+
+	if (status & XILINX_CPM_PCIE_INTR_FATAL) {
+		dev_warn(dev, "Fatal error message\n");
+		cpm_pcie_clear_err_interrupts(port);
+	}
+
+	if (status & XILINX_CPM_PCIE_INTR_INTX) {
+		/* Handle INTx Interrupt */
+		intr_val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN);
+		intr_val = intr_val >> XILINX_CPM_PCIE_IDRN_SHIFT;
+
+		for_each_set_bit(bit, &intr_val, PCI_NUM_INTX)
+			generic_handle_irq(irq_find_mapping(port->leg_domain,
+							    bit));
+	}
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_UNSUPP)
+		dev_warn(dev, "Slave unsupported request\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_UNEXP)
+		dev_warn(dev, "Slave unexpected completion\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_COMPL)
+		dev_warn(dev, "Slave completion timeout\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_ERRP)
+		dev_warn(dev, "Slave Error Poison\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_CMPABT)
+		dev_warn(dev, "Slave Completer Abort\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_ILLBUR)
+		dev_warn(dev, "Slave Illegal Burst\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_MST_DECERR)
+		dev_warn(dev, "Master decode error\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_MST_SLVERR)
+		dev_warn(dev, "Master slave error\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT)
+		dev_warn(dev, "PCIe ECAM access timeout\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_CFG_ERR_POISON)
+		dev_warn(dev, "ECAM poisoned completion received\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD)
+		dev_warn(dev, "PME_TO_ACK message received\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_PM_PME_RCVD)
+		dev_warn(dev, "PM_PME message received\n");
+
+	if (status & XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT)
+		dev_warn(dev, "PCIe completion timeout received\n");
+
+	/* Clear the Interrupt Decode register */
+	pcie_write(port, status, XILINX_CPM_PCIE_REG_IDR);
+
+	/*
+	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
+	 * CPM SLCR block.
+	 */
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
+		return -EINVAL;
+	}
+
+	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						 &intx_domain_ops,
+						 port);
+	if (!port->leg_domain) {
+		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		return -ENOMEM;
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
+	/* Enable all interrupts */
+	pcie_write(port, XILINX_CPM_PCIE_IMR_ALL_MASK,
+		   XILINX_CPM_PCIE_REG_IMR);
+	pcie_write(port, XILINX_CPM_PCIE_IDRN_MASK,
+		   XILINX_CPM_PCIE_REG_IDRN_MASK);
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
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+	int err;
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

