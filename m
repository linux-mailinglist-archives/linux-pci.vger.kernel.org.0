Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423C515B847
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgBMEK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:10:56 -0500
Received: from mail-am6eur05on2073.outbound.protection.outlook.com ([40.107.22.73]:6034
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729440AbgBMEKz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:10:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqzAioj1u86WgMuIQC+9Xrva6sQXjgaD4EUJ2At0h5uaatLYy24wuLVWv2RFKEsryV0OeuR1lhih+Wn6FOstYV0fQcR5s7UoYil4LN/tp7f74fC00FR06nXE51yWTf0E5Bhc+h0S1CiJbzYI0Wvv/orgFauf1OLieZMrX1RgMao7Oy1Y4tHdXaNpOHtBDWGm1SYpE40yhmEjpU+w5my2wcWIc6bI0FkwGjX05nqfvKL8kkGKkyE2ZGSESqUJG9bb0ErakfdvmW7NvQ3v2jmWVFYNHs6yMeFkt3UhyIM0sXw+MTyBo8cUKoLZ1dro9BXoT5pxRuSYOemmxQeQKksuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na6v/LUEN6oBmQvXPo3e9TzJzHLT/2EZoqErM5TJDkw=;
 b=efwsoRAmkx0/f7G4w7AzsKWOmSlJqFirInR3Yg03W3LN009x39h2ukX0BegQd9pXYjtEX6jnAygaPzqFevUUA0WffwY6HCL51c+ZgcZwo88KSRGcVNorPG1t1JoRg6prcGaFGtYo5KoceEQ/R7RrlF3HeYqs/6faYXdeoeVRH00QN+iism8Fh9KZwHNdivQORS1As37UPuGeJbGG8GxE8L5Zdi36JwS/o34Uev0tmECJlPMKjwznuUjAkYSbTE/+Z0a0k8p0q3b4+nZCCRKEtZOimwlnzJW3an9JDe9EmdhUTDUJ6WPG8+/nxdpc1aY/0Hy/lVPkr865CCx0V+8Iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na6v/LUEN6oBmQvXPo3e9TzJzHLT/2EZoqErM5TJDkw=;
 b=j0k5xLV5rai7dQHBbTv+qLg++GK83QFpijqTgxYt4R75WrVAlKif9ctZL4AMeoGZSUgbDTjYwLYeiZBsOSF01aEXG9hVjVg3S9vyqQA3OvZceKR74dt3Nm/liFeqncZvnqr6Zlq+lCQ4pzub0muVN1dl7u40+V8aRUJqWQYxjbo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5660.eurprd04.prod.outlook.com (20.179.9.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 04:10:50 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:10:50 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv10 11/13] PCI: mobiveil: Add PCIe Gen4 RC driver for NXP Layerscape SoCs
Date:   Thu, 13 Feb 2020 12:06:42 +0800
Message-Id: <20200213040644.45858-12-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:10:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7ff05dd-6f88-4660-3649-08d7b03ab5d5
X-MS-TrafficTypeDiagnostic: DB8PR04MB5660:|DB8PR04MB5660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB566059C31BEB0AC23816F7A0841A0@DB8PR04MB5660.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(189003)(199004)(81156014)(5660300002)(478600001)(81166006)(8936002)(66476007)(4326008)(66556008)(8676002)(316002)(2616005)(86362001)(6512007)(2906002)(6486002)(7416002)(6506007)(1076003)(16526019)(26005)(36756003)(186003)(66946007)(52116002)(30864003)(956004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5660;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDxnjf8jhmjufLWB/yMSDjqmaV9YAZ4DWcJVFc4TrsD4dN2PGyqjHgrrJ1RLFfmHJ98SX20fTRcLWaYnh9NVztz+HHMoHYaHKVjdtY2ErWGYtnVDwsguQiuMMZ5ivKJbBtuXHc/Lw1bRPsrz5wyQ4RH/lqXmv/NfgNAuidI84s82hPT1dG0BpS1ad0qs1vdGlHOTmsmaBzda4xPpHV9n6GrMNzomaj+kDHvBEVKjEb6rCrk7aEFgrRrpCkk/NfQK0YIPzaS8OV71DcoVWl+AtHGrQvrsLeP3sOlyPZfmWx6HCvfC/9EjzqhKXqIa6ursPiugfP1raBBeHv13TYuFOZqv3+/tAkfQb8zq6mddiUrmdoGgx1cEadh/YMqJ2uRO4xgnE0jUKfCkwL66fLa0C2owYeeWF+gjxJfkj0UYH4s9kbf4pHfMkxzhm4OA1w1s3EBL/9j0WNwMIRdvZfm11ITG9/bCQ+kRFmYeXTVcVa+2a5/SFsNKJlfBGNhlMD/i
X-MS-Exchange-AntiSpam-MessageData: gEr44q+bUelgsMe8cnM9TdCscz3I4FgrjIbwRHNUrUAOQt0qiZcxledvZCZr6jr09LatbvqQhmLJGu/zMNXgPOYRn+rVq1FrAV1d1GP2sn+JrhXpQU3JQASDwkcCLpftLrkeTeRUfGeV3yZbhjj1hA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ff05dd-6f88-4660-3649-08d7b03ab5d5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:10:50.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+6bvmQC2eO0nLQuDEmDNy1EDYKj/Pk17ZGRJQACGFGGRbm4tlJusXJvyMLNzTSWrBHDXqv61VgwHbp3P3iWNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5660
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This PCIe controller is based on the Mobiveil GPEX IP, which is
compatible with the PCI Express™ Base Specification, Revision 4.0.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V10:
 - Changed the return type of ls_pcie_g4_reinit_hw() to void.
 - Moved Header Type check to mobiveil_pcie_host_probe().

 drivers/pci/controller/mobiveil/Kconfig       |   9 +
 drivers/pci/controller/mobiveil/Makefile      |   1 +
 .../mobiveil/pcie-layerscape-gen4.c           | 267 ++++++++++++++++++
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  16 +-
 4 files changed, 291 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c

diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index 54161d4ddb11..7439991ee82c 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -21,4 +21,13 @@ config PCIE_MOBIVEIL_PLAT
 	  Soft IP. It has up to 8 outbound and inbound windows
 	  for address translation and it is a PCIe Gen4 IP.
 
+config PCIE_LAYERSCAPE_GEN4
+	bool "Freescale Layerscape PCIe Gen4 controller"
+	depends on PCI
+	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_MOBIVEIL_HOST
+	help
+	  Say Y here if you want PCIe Gen4 controller support on
+	  Layerscape SoCs.
 endmenu
diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/controller/mobiveil/Makefile
index 9fb6d1c6504d..99d879de32d6 100644
--- a/drivers/pci/controller/mobiveil/Makefile
+++ b/drivers/pci/controller/mobiveil/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
 obj-$(CONFIG_PCIE_MOBIVEIL_HOST) += pcie-mobiveil-host.o
 obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) += pcie-mobiveil-plat.o
+obj-$(CONFIG_PCIE_LAYERSCAPE_GEN4) += pcie-layerscape-gen4.o
diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
new file mode 100644
index 000000000000..f3bd5f5ad229
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe Gen4 host controller driver for NXP Layerscape SoCs
+ *
+ * Copyright 2019-2020 NXP
+ *
+ * Author: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#include "pcie-mobiveil.h"
+
+/* LUT and PF control registers */
+#define PCIE_LUT_OFF			0x80000
+#define PCIE_PF_OFF			0xc0000
+#define PCIE_PF_INT_STAT		0x18
+#define PF_INT_STAT_PABRST		BIT(31)
+
+#define PCIE_PF_DBG			0x7fc
+#define PF_DBG_LTSSM_MASK		0x3f
+#define PF_DBG_LTSSM_L0			0x2d /* L0 state */
+#define PF_DBG_WE			BIT(31)
+#define PF_DBG_PABR			BIT(27)
+
+#define to_ls_pcie_g4(x)		platform_get_drvdata((x)->pdev)
+
+struct ls_pcie_g4 {
+	struct mobiveil_pcie pci;
+	struct delayed_work dwork;
+	int irq;
+};
+
+static inline u32 ls_pcie_g4_lut_readl(struct ls_pcie_g4 *pcie, u32 off)
+{
+	return ioread32(pcie->pci.csr_axi_slave_base + PCIE_LUT_OFF + off);
+}
+
+static inline void ls_pcie_g4_lut_writel(struct ls_pcie_g4 *pcie,
+					 u32 off, u32 val)
+{
+	iowrite32(val, pcie->pci.csr_axi_slave_base + PCIE_LUT_OFF + off);
+}
+
+static inline u32 ls_pcie_g4_pf_readl(struct ls_pcie_g4 *pcie, u32 off)
+{
+	return ioread32(pcie->pci.csr_axi_slave_base + PCIE_PF_OFF + off);
+}
+
+static inline void ls_pcie_g4_pf_writel(struct ls_pcie_g4 *pcie,
+					u32 off, u32 val)
+{
+	iowrite32(val, pcie->pci.csr_axi_slave_base + PCIE_PF_OFF + off);
+}
+
+static int ls_pcie_g4_link_up(struct mobiveil_pcie *pci)
+{
+	struct ls_pcie_g4 *pcie = to_ls_pcie_g4(pci);
+	u32 state;
+
+	state = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
+	state =	state & PF_DBG_LTSSM_MASK;
+
+	if (state == PF_DBG_LTSSM_L0)
+		return 1;
+
+	return 0;
+}
+
+static void ls_pcie_g4_disable_interrupt(struct ls_pcie_g4 *pcie)
+{
+	struct mobiveil_pcie *mv_pci = &pcie->pci;
+
+	mobiveil_csr_writel(mv_pci, 0, PAB_INTP_AMBA_MISC_ENB);
+}
+
+static void ls_pcie_g4_enable_interrupt(struct ls_pcie_g4 *pcie)
+{
+	struct mobiveil_pcie *mv_pci = &pcie->pci;
+	u32 val;
+
+	/* Clear the interrupt status */
+	mobiveil_csr_writel(mv_pci, 0xffffffff, PAB_INTP_AMBA_MISC_STAT);
+
+	val = PAB_INTP_INTX_MASK | PAB_INTP_MSI | PAB_INTP_RESET |
+	      PAB_INTP_PCIE_UE | PAB_INTP_IE_PMREDI | PAB_INTP_IE_EC;
+	mobiveil_csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_ENB);
+}
+
+static int ls_pcie_g4_reinit_hw(struct ls_pcie_g4 *pcie)
+{
+	struct mobiveil_pcie *mv_pci = &pcie->pci;
+	struct device *dev = &mv_pci->pdev->dev;
+	u32 val, act_stat;
+	int to = 100;
+
+	/* Poll for pab_csb_reset to set and PAB activity to clear */
+	do {
+		usleep_range(10, 15);
+		val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_INT_STAT);
+		act_stat = mobiveil_csr_readl(mv_pci, PAB_ACTIVITY_STAT);
+	} while (((val & PF_INT_STAT_PABRST) == 0 || act_stat) && to--);
+	if (to < 0) {
+		dev_err(dev, "Poll PABRST&PABACT timeout\n");
+		return -EIO;
+	}
+
+	/* clear PEX_RESET bit in PEX_PF0_DBG register */
+	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
+	val |= PF_DBG_WE;
+	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
+
+	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
+	val |= PF_DBG_PABR;
+	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
+
+	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
+	val &= ~PF_DBG_WE;
+	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
+
+	mobiveil_host_init(mv_pci, true);
+
+	to = 100;
+	while (!ls_pcie_g4_link_up(mv_pci) && to--)
+		usleep_range(200, 250);
+	if (to < 0) {
+		dev_err(dev, "PCIe link training timeout\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static irqreturn_t ls_pcie_g4_isr(int irq, void *dev_id)
+{
+	struct ls_pcie_g4 *pcie = (struct ls_pcie_g4 *)dev_id;
+	struct mobiveil_pcie *mv_pci = &pcie->pci;
+	u32 val;
+
+	val = mobiveil_csr_readl(mv_pci, PAB_INTP_AMBA_MISC_STAT);
+	if (!val)
+		return IRQ_NONE;
+
+	if (val & PAB_INTP_RESET) {
+		ls_pcie_g4_disable_interrupt(pcie);
+		schedule_delayed_work(&pcie->dwork, msecs_to_jiffies(1));
+	}
+
+	mobiveil_csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_STAT);
+
+	return IRQ_HANDLED;
+}
+
+static int ls_pcie_g4_interrupt_init(struct mobiveil_pcie *mv_pci)
+{
+	struct ls_pcie_g4 *pcie = to_ls_pcie_g4(mv_pci);
+	struct platform_device *pdev = mv_pci->pdev;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pcie->irq = platform_get_irq_byname(pdev, "intr");
+	if (pcie->irq < 0) {
+		dev_err(dev, "Can't get 'intr' IRQ, errno = %d\n", pcie->irq);
+		return pcie->irq;
+	}
+	ret = devm_request_irq(dev, pcie->irq, ls_pcie_g4_isr,
+			       IRQF_SHARED, pdev->name, pcie);
+	if (ret) {
+		dev_err(dev, "Can't register PCIe IRQ, errno = %d\n", ret);
+		return  ret;
+	}
+
+	return 0;
+}
+
+static void ls_pcie_g4_reset(struct work_struct *work)
+{
+	struct delayed_work *dwork = container_of(work, struct delayed_work,
+						  work);
+	struct ls_pcie_g4 *pcie = container_of(dwork, struct ls_pcie_g4, dwork);
+	struct mobiveil_pcie *mv_pci = &pcie->pci;
+	u16 ctrl;
+
+	ctrl = mobiveil_csr_readw(mv_pci, PCI_BRIDGE_CONTROL);
+	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+	mobiveil_csr_writew(mv_pci, ctrl, PCI_BRIDGE_CONTROL);
+
+	if (!ls_pcie_g4_reinit_hw(pcie))
+		return;
+
+	ls_pcie_g4_enable_interrupt(pcie);
+}
+
+static struct mobiveil_rp_ops ls_pcie_g4_rp_ops = {
+	.interrupt_init = ls_pcie_g4_interrupt_init,
+};
+
+static const struct mobiveil_pab_ops ls_pcie_g4_pab_ops = {
+	.link_up = ls_pcie_g4_link_up,
+};
+
+static int __init ls_pcie_g4_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	struct mobiveil_pcie *mv_pci;
+	struct ls_pcie_g4 *pcie;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	if (!of_parse_phandle(np, "msi-parent", 0)) {
+		dev_err(dev, "Failed to find msi-parent\n");
+		return -EINVAL;
+	}
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
+	if (!bridge)
+		return -ENOMEM;
+
+	pcie = pci_host_bridge_priv(bridge);
+	mv_pci = &pcie->pci;
+
+	mv_pci->pdev = pdev;
+	mv_pci->ops = &ls_pcie_g4_pab_ops;
+	mv_pci->rp.ops = &ls_pcie_g4_rp_ops;
+	mv_pci->rp.bridge = bridge;
+
+	platform_set_drvdata(pdev, pcie);
+
+	INIT_DELAYED_WORK(&pcie->dwork, ls_pcie_g4_reset);
+
+	ret = mobiveil_pcie_host_probe(mv_pci);
+	if (ret) {
+		dev_err(dev, "Fail to probe\n");
+		return  ret;
+	}
+
+	ls_pcie_g4_enable_interrupt(pcie);
+
+	return 0;
+}
+
+static const struct of_device_id ls_pcie_g4_of_match[] = {
+	{ .compatible = "fsl,lx2160a-pcie", },
+	{ },
+};
+
+static struct platform_driver ls_pcie_g4_driver = {
+	.driver = {
+		.name = "layerscape-pcie-gen4",
+		.of_match_table = ls_pcie_g4_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+builtin_platform_driver_probe(ls_pcie_g4_driver, ls_pcie_g4_probe);
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 72c62b4d8f7b..7b6a403a9fc0 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -43,6 +43,8 @@
 #define  PAGE_LO_MASK			0x3ff
 #define  PAGE_SEL_OFFSET_SHIFT		10
 
+#define PAB_ACTIVITY_STAT		0x81c
+
 #define PAB_AXI_PIO_CTRL		0x0840
 #define  APIO_EN_MASK			0xf
 
@@ -51,8 +53,18 @@
 
 #define PAB_INTP_AMBA_MISC_ENB		0x0b0c
 #define PAB_INTP_AMBA_MISC_STAT		0x0b1c
-#define  PAB_INTP_INTX_MASK		0x01e0
-#define  PAB_INTP_MSI_MASK		0x8
+#define  PAB_INTP_RESET			BIT(1)
+#define  PAB_INTP_MSI			BIT(3)
+#define  PAB_INTP_INTA			BIT(5)
+#define  PAB_INTP_INTB			BIT(6)
+#define  PAB_INTP_INTC			BIT(7)
+#define  PAB_INTP_INTD			BIT(8)
+#define  PAB_INTP_PCIE_UE		BIT(9)
+#define  PAB_INTP_IE_PMREDI		BIT(29)
+#define  PAB_INTP_IE_EC			BIT(30)
+#define  PAB_INTP_MSI_MASK		PAB_INTP_MSI
+#define  PAB_INTP_INTX_MASK		(PAB_INTP_INTA | PAB_INTP_INTB |\
+					PAB_INTP_INTC | PAB_INTP_INTD)
 
 #define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
 #define  WIN_ENABLE_SHIFT		0
-- 
2.17.1

