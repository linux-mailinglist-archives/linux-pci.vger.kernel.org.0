Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4B1C8918
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgEGL74 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 07:59:56 -0400
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:23540
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbgEGL7z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 07:59:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHezk4p1kM6CeFpeVKYwr9Heu/f3CIjsnkO9ofmGTRDHC7rUugTY4nQ0TlQjdVWtRIfAoYfCuMb/MtQ65cp5A+QSWE0LI2J9AvTlSku1sFzhb5IjA8UJTkOBv4FZ6VVeGm3rp7RfBKyBhFcGcMs8M9guiTbDSxYWIl4UIQs1Z8S1p3n/Kps660dedDNRQpxWsmbShTbf0HqlJ+adsqZR6YuNhvNNjNoTYKEkyyMwDpTDrbRLfnGl0BY4Fj2NM/0h1BzzHtAOz5dFsLSMKpB3okIlDw3Wl4QcADzIrwWuA7lTy0MuY0R97TTimrSyNrJG05/WOMeMlxvShbsfZiRr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaOQhPM4dwm6mB4EWm7dv71QZO0qyAk4bNKT2bPKUiw=;
 b=VyJsEI8Bpzkn3V6ty59ciIJh2xpZPLY9FbEjl/tVmKwvC2jUj70t25+ufK3mtcV5qpXdJkHpM9E4M2GPljocZ/HESUHk2qLBA1CvD5L8r8ayejCTcrJMGY/sysbj17qJIYYFAfy9LIV0/hnkjwH0xwrijXJ62CpSUNT24yLesS6IvCujnuAwCUWLZeGalfm1OKaabI5azrhmQ1SKCwOfFSQZ0jUggX2MGVwC1wTPD9c8/yov40pZ5YOKBK7tBd2La88lF76qZNOGabhqyhykndgvtNLidqukGgiGRXmHgWyYrA9/TjVR+JQXtfBPd1znt+3CQ9/HpqNBHqHWDUD9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaOQhPM4dwm6mB4EWm7dv71QZO0qyAk4bNKT2bPKUiw=;
 b=oHkT8Kk9hq/N4BneXnqXKUwrWS6KXFMhrf3dqCeKNsSqaKh1vEl9R+I6NyC0079lhTdutjkw/n2UHlVLk88jflKmC0FdNzz/fA4q0DAwBeOYWz9HMd74kHYWJda26Eyk96kZjxFhMUmLqyHozGJp2IgZmJkbPYH/pFeHJRBgzTY=
Received: from BL0PR02CA0094.namprd02.prod.outlook.com (2603:10b6:208:51::35)
 by CH2PR02MB6757.namprd02.prod.outlook.com (2603:10b6:610:a5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 11:59:50 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:51:cafe::a7) by BL0PR02CA0094.outlook.office365.com
 (2603:10b6:208:51::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Thu, 7 May 2020 11:59:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Thu, 7 May 2020 11:59:50
 +0000
Received: from [149.199.38.66] (port=60063 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jWfBk-0004yZ-6F; Thu, 07 May 2020 04:59:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jWfBt-00083A-My; Thu, 07 May 2020 04:59:49 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 047Bxhrr012829;
        Thu, 7 May 2020 04:59:43 -0700
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jWfBm-00081d-BT; Thu, 07 May 2020 04:59:42 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v7 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Date:   Thu,  7 May 2020 17:28:36 +0530
Message-Id: <1588852716-23132-3-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588852716-23132-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1588852716-23132-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(396003)(376002)(46966005)(33430700001)(8676002)(478600001)(356005)(7696005)(316002)(70206006)(5660300002)(70586007)(36756003)(9786002)(33440700001)(2906002)(30864003)(336012)(6666004)(8936002)(26005)(2616005)(47076004)(107886003)(82740400003)(82310400002)(81166007)(186003)(4326008)(426003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49d4018f-1970-431d-7c4d-08d7f27e2541
X-MS-TrafficTypeDiagnostic: CH2PR02MB6757:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR02MB67574CA6475DC04E049B054CA5A50@CH2PR02MB6757.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:299;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihcSjIXHt1hEfvEskqMmJv793QJ6lggcSUmAAygl/ILyMe/GILSBsYIYJm5g3tU8GNgCscxX4vTTE8osZgIPMlDC6a5Sc8dm9iXxtGyMklziFpjj+CP6fytBjMW9HTO+Br1eZRd5iVoSx8j2aRXaL80ya8QzMakghtiCD+bq9i29Q7iU5b9YSu663PddZ26oEDLgFis/i4qLEExMw/qDFpbAEDVJafoKPoH4dTnfx/DgoVwyozBnJMYoHQJrIgE89wrR86rQiUrV1zGuiRl97MNMx8xMN/6DXVfCsjKNIImhEWFtJdcFWgOCp+AbC5Eb4JswtVDeSHcsTwfRz0eO0YYjDTFhAqlpdy9UmUz04aRh1id7CR1Lr1yMQY7a6Dy5u77f6e/cp82Q1u59thCoIUUUPu1lJVsVlFozXFdoFTdWrZpxSulppxM0gsDHyc2LEfbqmIXX8qsYb/V3F/X0sWODUO9pskFIKckZatGNB5JcohDBUwRXO/mDfIe9Lejc7ckFbkK4t1DEQmy/DKHa3wkwnBa3SlOia5c647m/wgZlRHBgGa/vDTbo/8khmw6o73+xj9eAmwdr2ThQPMPcVA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 11:59:50.0984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d4018f-1970-431d-7c4d-08d7f27e2541
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6757
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
 drivers/pci/controller/Kconfig           |   9 +
 drivers/pci/controller/Makefile          |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c | 506 +++++++++++++++++++++++++++++++
 3 files changed, 516 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 20bf00f..ca0ae24 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -81,6 +81,15 @@ config PCIE_XILINX
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
 
+config PCIE_XILINX_CPM
+	bool "Xilinx Versal CPM host bridge support"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	select PCI_HOST_COMMON
+	help
+	  Say 'Y' here if you want kernel support for the
+	  Xilinx Versal CPM host bridge. The driver supports
+	  MSI/MSI-X interrupts using GICv3 ITS feature.
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
index 0000000..e8c0aa7
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
+/**
+ * struct xilinx_cpm_pcie_port - PCIe port information
+ * @reg_base: Bridge Register Base
+ * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
+ * @dev: Device pointer
+ * @leg_domain: Legacy IRQ domain pointer
+ * @cfg: Holds mappings of config space window
+ * @irq_misc: Legacy and error interrupt number
+ * @leg_mask_lock: lock for legacy interrupts
+ */
+struct xilinx_cpm_pcie_port {
+	void __iomem *reg_base;
+	void __iomem *cpm_base;
+	struct device *dev;
+	struct irq_domain *leg_domain;
+	struct pci_config_window *cfg;
+	int irq_misc;
+	raw_spinlock_t leg_mask_lock;
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
+static void xilinx_cpm_mask_leg_irq(struct irq_data *data)
+{
+	struct irq_desc *desc = irq_to_desc(data->irq);
+	struct xilinx_cpm_pcie_port *port;
+	unsigned long flags;
+	u32 mask;
+	u32 val;
+
+	port = irq_desc_get_chip_data(desc);
+	mask = (1 << data->hwirq) << XILINX_CPM_PCIE_IDRN_SHIFT;
+	raw_spin_lock_irqsave(&port->leg_mask_lock, flags);
+	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
+	pcie_write(port, (val & (~mask)), XILINX_CPM_PCIE_REG_IDRN_MASK);
+	raw_spin_unlock_irqrestore(&port->leg_mask_lock, flags);
+}
+
+static void xilinx_cpm_unmask_leg_irq(struct irq_data *data)
+{
+	struct irq_desc *desc = irq_to_desc(data->irq);
+	struct xilinx_cpm_pcie_port *port;
+	unsigned long flags;
+	u32 mask;
+	u32 val;
+
+	port = irq_desc_get_chip_data(desc);
+	mask = (1 << data->hwirq) << XILINX_CPM_PCIE_IDRN_SHIFT;
+	raw_spin_lock_irqsave(&port->leg_mask_lock, flags);
+	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
+	pcie_write(port, (val | mask), XILINX_CPM_PCIE_REG_IDRN_MASK);
+	raw_spin_unlock_irqrestore(&port->leg_mask_lock, flags);
+}
+
+static struct irq_chip xilinx_cpm_leg_irq_chip = {
+	.name = "xilinx_cpm_pcie:legacy",
+	.irq_enable = xilinx_cpm_unmask_leg_irq,
+	.irq_disable = xilinx_cpm_mask_leg_irq,
+	.irq_mask = xilinx_cpm_mask_leg_irq,
+	.irq_unmask = xilinx_cpm_unmask_leg_irq,
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
+	of_node_put(pcie_intc_node);
+	if (!port->leg_domain) {
+		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	raw_spin_lock_init(&port->leg_mask_lock);
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
+	port->irq_misc = platform_get_irq(pdev, 0);
+	if (port->irq_misc <= 0) {
+		dev_err(dev, "Unable to find misc IRQ line\n");
+		return port->irq_misc;
+	}
+
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
+	int err;
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
+	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
+							       "cpm_slcr");
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
+	err = xilinx_cpm_pcie_parse_dt(port, bus_range);
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
+	bridge->dev.parent = dev;
+	bridge->sysdata = port->cfg;
+	bridge->busnr = port->cfg->busr.start;
+	bridge->ops = &pci_generic_ecam_ops.pci_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
+
+	err = pci_host_probe(bridge);
+	if (err < 0) {
+		irq_domain_remove(port->leg_domain);
+		devm_free_irq(dev, port->irq_misc, port);
+		return err;
+	}
+
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

