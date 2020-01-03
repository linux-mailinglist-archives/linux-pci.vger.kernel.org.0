Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A6E12F7F3
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 13:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgACMEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 07:04:49 -0500
Received: from mail-co1nam11on2041.outbound.protection.outlook.com ([40.107.220.41]:3552
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727350AbgACMEs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Jan 2020 07:04:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7C4Qq28Qm9edtRKl0mwf2W8wUGHTQhvNeR19cCSk5kc14PG05yIubrXvWEl3mTT4ZaQmWJc5jibUZQjc6q/i+kNBVnIzzDp+5Bxj0YPY2d5dRQbWubnsKi/9yTY/ChACqgNutUnqWJioGD+LgdN8D6j4k84W1NT8brbajOMHVtRlRfV4hRRN7e5iqvs4+JjQJ6BuffSj341q7oRhfzS4PfMbHYiNRSK+hpOK85JILBvMgvE34O0/0LSN0VVQYDeDIijrn+9nfGfJLEZaO0SEkPYu8zdDG+oGvBnq20KGjClskjI/L7gRhufQ/YPj+ZoWPNeIlj7GQimedOUug9Crg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQheWOtxV8KYBNVUSLJreetq4dlT+XKUGNIygDEC+RI=;
 b=od6OndEXaRNpMXi5IBNUVerbsaQekfWRLQlUwzN59kkBXlTfA6gMfJq4PDLagcugLAxLqjGbiUotdkoT18VWiWeBCTwMRaSfW8kvbN6cREwQyhOSruMHUPz0IqGim6fhjAzmgIgoOxMThbN4RcTwFahmSpGKBzeXEKXJH8oIntncYtDcX5tNxcUeGnOW1ti6jNXgJpuamo4j9A6SOVtNNvUU7yFYjCId/M7lggLYCmbp3x5NmRCmYmeMHCMXPtp6BH1k101AsSlsccBRqon6FdLhqCkn28qDAPDBf0LOYhktoP50k0rNWvOhXdT6gY5N4D376uEyCXXF2AkwgeaOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQheWOtxV8KYBNVUSLJreetq4dlT+XKUGNIygDEC+RI=;
 b=PKdWNrv/4iDdacfxsEHT0jnq2B6E8XPYTutjZxXUjsRDWV0i+XgNCh4BMABoddaPBj6n6qt0UQMriE6UQy7Olqiv3sOGkU58SP+ii2i3+tBNwZwiOwv5k/hPBp8JqyaCAijpQR3AJWtixxj6LHPXmgpD6PUauNjmNeRcqdlDDX8=
Received: from DM6PR02CA0107.namprd02.prod.outlook.com (2603:10b6:5:1f4::48)
 by SN4PR0201MB3453.namprd02.prod.outlook.com (2603:10b6:803:50::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12; Fri, 3 Jan
 2020 12:04:43 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by DM6PR02CA0107.outlook.office365.com
 (2603:10b6:5:1f4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Fri, 3 Jan 2020 12:04:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Fri, 3 Jan 2020 12:04:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1inLh4-0000Jj-J7; Fri, 03 Jan 2020 04:04:42 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1inLgz-0007pu-FX; Fri, 03 Jan 2020 04:04:37 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1inLgw-0007nw-4l; Fri, 03 Jan 2020 04:04:34 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2 2/2] PCI: Versal CPM: Add support for Versal CPM Root Port driver
Date:   Fri,  3 Jan 2020 17:34:22 +0530
Message-Id: <1578053062-391-3-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578053062-391-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1578053062-391-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(199004)(189003)(336012)(316002)(26005)(5660300002)(36756003)(9786002)(8936002)(2616005)(426003)(6666004)(356004)(8676002)(81166006)(186003)(81156014)(7696005)(70586007)(70206006)(107886003)(478600001)(30864003)(2906002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3453;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4b6d4f5-bc40-48fe-3658-08d790451e80
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3453:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3453AA063177082A9858E25AA5230@SN4PR0201MB3453.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:335;
X-Forefront-PRVS: 0271483E06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Rm16K1/zENdHS2E7Aa9SsUiQePUwx53RztJjMXogOSCGRNyHNlSMnq2wYj4UmN1TO9CIqxsIrEnxdz4N4N3Qyo8Q+W49CQxluPNjnG0HPEjGTYeYonwwIscFWsMVskFVO1aOpuzk6IJsNc3G7uvhwhrfqEehk8Ena52VxpEppAk6RN/c09ECPc8YroK2N0xSWX4mNUD4HlMGfaVuSMFoRro8srEBrpFjLW1o+B/zMGdNhuvYzfxxEhee21hd/ppos1YFXLI2qJ6T8oZeJOIzW/b2khwOubiZyFvd+FCYR3GTjyqcJy1gp6OF2nIQXhKAW0ZF+QMVZfgyn1j25AL/tcC4oYacc/H7BkLIw7GaILlj6DGIrrnNAzWFSJl8OECTErOoLUK3nKg580ouME9nbcbt23uuFpQmgh+lOoWhQcp9jpiWQZbwQnQM886JTai
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 12:04:43.1543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b6d4f5-bc40-48fe-3658-08d790451e80
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3453
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

- Adding support for Versal CPM as Root Port.
- The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
  block for CPM along with the integrated bridge can function
  as PCIe Root Port.
- CPM Versal uses GICv3 ITS feature for acheiving assigning MSI/MSI-X
  vectors and handling MSI/MSI-X interrupts.
- Bridge error and legacy interrupts in Versal CPM are handled using
  Versal CPM specific MISC interrupt line.

Changes v2:
- Using PCI_NUM_INTX macro for legacy interrupts.
- Removed checking link up for downstream devices
- Reduced repition of port->dev in xilinx_cpm_pcie_intr_handler
- Renamed cpm_pcie_link_is_up to cpm_pcie_link_up

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/Kconfig           |   8 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c | 505 +++++++++++++++++++++++++++++++
 3 files changed, 514 insertions(+)
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
index 0000000..0217f11
--- /dev/null
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -0,0 +1,505 @@
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
+	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
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

