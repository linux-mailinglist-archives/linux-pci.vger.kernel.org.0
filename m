Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13EF2EEFAE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 10:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbhAHJ3Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 04:29:25 -0500
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:11339
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728605AbhAHJ3Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 04:29:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5rvCsL6If010vdakGwjuQQfW+4irMDLbW84RjxpMM9kNprqpQpXcicy6z5ID0aHColMZw54ux6ydpYWCpyAiImuVY0oE6wX2H9X3w8lvM6Fv6N+B60eHl3Yue9NNPHK+TSYcGzXzcIzoluMhwAAMVljKfAexZBvn/WcBCcUPTKr3J1uzmGzrwzkFUOGI+V67N3DmMomY9U1jxj1zNXi3GCqYfXGD5sVtlqGa9BauM1hNJY6moL1ynies0/rQcq4WYIYf6sVZsiRj3wkzakv4LohDrn4XfaMMD4S84uCD5ASs2WtqmTWBMzE7uNQmPEbr5HnpK3bz3mDzZSFBLZ+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yw+GGMOukJlipndIjUO2kd01Ee96i+0UkVSNiYWZec=;
 b=R6PKcM3nLSw54DSAQToBZFf9jVTx8OJv5/NQ0wo95NF2YNJL+9XCz0st7p9X4oAu/j52j1RgQRnVbudpCxCXEiqHVaOCDXp+XkuDpX5hXx4vA/NDlZ/CE5xSQwo5riWZYQPft2VuQr/J5YaBws4w/ac7LQ/v5xgFkZFBIUywMWnHxxII90EJy/SKL4j0pSktVQ8DBTBizUygarteciKFl6cMTew7imBHnYp9Cx5rvns+fkDEsaYwloihHapMYbEa/w5dmU03HlgjzrFcQFu6V6YzKVYT5VaeX+0zMBniarj4xtdCgM6BCux072DuWWSycRo9Yqx7DmeeJr2XfkJbpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yw+GGMOukJlipndIjUO2kd01Ee96i+0UkVSNiYWZec=;
 b=bp1N4mr2GYC8WmqxPAgQYog+nQxJv9pyJbhe90Oz0RZ+4bHgFPxZaOB+WiQndXTVkvnQRj5AfLtNsNnYnQLvHnnr5RGBuSfdIV5x4+X7YoprfUCxgdWGBq8S9A/Izmw1xwHaFXWY5u+n9Gmb084QwseymkDwqsHDOybF5OoZ8s4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Fri, 8 Jan
 2021 09:28:05 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 09:28:05 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 7/7] PCI: layerscape: Add power management support
Date:   Fri,  8 Jan 2021 17:36:10 +0800
Message-Id: <20210108093610.28595-8-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
References: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::29) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 09:27:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e5f6720-e5fb-4300-f639-08d8b3b7b45f
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB337140CD9BC9A22A861D445084AE0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1ZS3DnSFZtGabjczP5C0FZUgU7dc5sDLvJzWaCbYIt5wmOjwoKpYE8Cg72tvRiH0uCnKwR8IyBkT3A6IL6ABk0BXPRfatM1+R3h7pneFHxENcdXIizgd23ZPv6+L8fwhJGHVfHchfd1E/W0T8kvsQ+lViDiNwVqA1wDwcKNLRnCBbKU6LkMA4zvwTb6/NuKa5KcLfHx5a+ir2ZO85UlrZDXsxvtcEeV04UDBw4kI3aBhnuQXMOj0yDbw0SE/kDtLFtny0IAegJegxwY3vfxqXhQeTGIOeETZL2Jr3jEj2n01n4h1CglztwP096xbqEJIu75ae0dPV16+yvw6oM/X7Pq5Z4IYfNXoFDpQJg9Mfm1iKLG8Q7+cMgzqa7XU7AmVSUi0FT2IE4UlxkbpIfLla7vm1Jg4VeRzotwKXapRLr7r5tx2QaM9lIXDiNPJi70xXXUr2g+NYtbgqKPPgPYEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(186003)(6512007)(16526019)(26005)(30864003)(6506007)(36756003)(6666004)(66556008)(69590400011)(8676002)(6486002)(478600001)(66946007)(52116002)(2616005)(956004)(66476007)(86362001)(4326008)(2906002)(1076003)(921005)(5660300002)(83380400001)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vDlH1OEb2u77t5xUT5FOwlJsO8DVQo1fZIqEX9BYRuUKzosFFnA5pEQYKZTB?=
 =?us-ascii?Q?ebyEJ/81QSvPyb3qeFALOKAOifqkHTqhvE8YFPTgXALb+RWujAhFRko5LvAQ?=
 =?us-ascii?Q?ya4LbV46w6ASjBaQuHRa3E67My0+8xIM+PhDYmOl/uMJQvu+xhPnEtQzrMeY?=
 =?us-ascii?Q?mWTOptwgoIuK6cp0vb1BEO8Cb/cMd6LPyE2Y3zkplLLaA6lXaMbF4LJBgdVV?=
 =?us-ascii?Q?ipllbD9JU3nrAP/C58MgOHzqHF/mLZ2g+w3wz017AU+jsTDt5MdmGLTwW5Qx?=
 =?us-ascii?Q?UfUb5PZSAWVtCO921QIFSN6Ub31eJFn4NOlc2AyGAs4FijqhqkMycIUfbFHX?=
 =?us-ascii?Q?ilMQog0G5wdnIYjhKFJ8IYemFhiZw0LLkjNSC9ypB0xEU38HdKLGih7rpSph?=
 =?us-ascii?Q?+aD0oXipp1yGXCjZPUk8IOjbqGR2nxtyuuELNDBuHtcFvPSen66/DBMhAQij?=
 =?us-ascii?Q?w3WT9J0N/huWR5fam4/WKnaZJEgBkQbA6mtk8SbTqJ/5s3LhS4EilXWSnKKn?=
 =?us-ascii?Q?gzr3VZWCNd2orEJOa/OySP0ZLRS7XEbOqZBwoyuell91AmRnxziDNPo4WVK3?=
 =?us-ascii?Q?CznbmfSV7GBi4T3+nCC/xHcQftmi/oubcqnVW4SPmtgU93vagWh3rGmFPc0a?=
 =?us-ascii?Q?iudydv+hmzKWNLueQHZhJJ4sdWIEBJuvio/CpB+fHp6WWu41feiDLTYVkt/b?=
 =?us-ascii?Q?Oq2OVG5gRYO8orNXNOEJ14LBr+9X8RloqTqRSJTGSWKOLWyWTSrTUtY79UtI?=
 =?us-ascii?Q?5nekQuJ2SUfljgqVXhWRmnzJtKVUsU7i7gWOEwHKgyUX9CGa7e4VFfj/wCeO?=
 =?us-ascii?Q?08i4KWm6bpHlcBrUQesezLIJonJqEdETD+2kIuQQce4B9Rl5U39umtdasGy6?=
 =?us-ascii?Q?0sIQ3m03suXbZvgtKIS6RaYZohtvvzmwtw4mRvhcnd+Fncsf2Mz6v0rNFVUj?=
 =?us-ascii?Q?InN2QQbTZw5/MKQRSfkUst0XVCpQWNPq+Mkmhhou7rnBO1pVGRlxT41PFSrk?=
 =?us-ascii?Q?SxjD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 09:28:02.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5f6720-e5fb-4300-f639-08d8b3b7b45f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3HDquUNlfJV336ZRoyY7/fJFbU8Qx+ivO6mIWyEcR5nPoEPt57nyJzVB4EcPkH++f0x6gRZm2yIzyymwEdGEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PME_Turn_Off/PME_TO_Ack handshake sequence, and finally
put the PCIe controller into D3 state after the L2/L3 ready
state transition process completion.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - Rebased against the latest code base

 drivers/pci/controller/dwc/pci-layerscape.c  | 380 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h |   1 +
 2 files changed, 379 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 906fac676b6f..a590194c0f95 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -3,13 +3,16 @@
  * PCIe host controller driver for Freescale Layerscape SoCs
  *
  * Copyright (C) 2014 Freescale Semiconductor.
+ * Copyright 2020 NXP
  *
  * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
@@ -27,17 +30,60 @@
 #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
 #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
+/* PF Message Command Register */
+#define LS_PCIE_PF_MCR		0x2c
+#define PF_MCR_PTOMR		BIT(0)
+#define PF_MCR_EXL2S		BIT(1)
+
+/* LS1021A PEXn PM Write Control Register */
+#define SCFG_PEXPMWRCR(idx)	(0x5c + (idx) * 0x64)
+#define PMXMTTURNOFF		BIT(31)
+#define SCFG_PEXSFTRSTCR	0x190
+#define PEXSR(idx)		BIT(idx)
+
+/* LS1043A PEX PME control register */
+#define SCFG_PEXPMECR		0x144
+#define PEXPME(idx)		BIT(31 - (idx) * 4)
+
+/* LS1043A PEX LUT debug register */
+#define LS_PCIE_LDBG	0x7fc
+#define LDBG_SR		BIT(30)
+#define LDBG_WE		BIT(31)
+
 #define PCIE_IATU_NUM		6
 
+#define LS_PCIE_IS_L2(v)	\
+	(((v) & PORT_LOGIC_LTSSM_STATE_MASK) == PORT_LOGIC_LTSSM_STATE_L2)
+
+struct ls_pcie;
+
+struct ls_pcie_host_pm_ops {
+	int (*pm_init)(struct ls_pcie *pcie);
+	void (*send_turn_off_message)(struct ls_pcie *pcie);
+	void (*exit_from_l2)(struct ls_pcie *pcie);
+};
+
 struct ls_pcie_drvdata {
+	const u32 pf_off;
+	const u32 lut_off;
 	const struct dw_pcie_host_ops *ops;
+	const struct ls_pcie_host_pm_ops *pm_ops;
 };
 
 struct ls_pcie {
 	struct dw_pcie *pci;
 	const struct ls_pcie_drvdata *drvdata;
+	void __iomem *pf_base;
+	void __iomem *lut_base;
+	bool big_endian;
+	bool ep_presence;
+	bool pm_support;
+	struct regmap *scfg;
+	int index;
 };
 
+#define ls_pcie_lut_readl_addr(addr)	ls_pcie_lut_readl(pcie, addr)
+#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
 
 static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
@@ -78,6 +124,210 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
 	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
 }
 
+static u32 ls_pcie_lut_readl(struct ls_pcie *pcie, u32 off)
+{
+	if (pcie->big_endian)
+		return ioread32be(pcie->lut_base + off);
+
+	return ioread32(pcie->lut_base + off);
+}
+
+static void ls_pcie_lut_writel(struct ls_pcie *pcie, u32 off, u32 val)
+{
+	if (pcie->big_endian)
+		return iowrite32be(val, pcie->lut_base + off);
+
+	return iowrite32(val, pcie->lut_base + off);
+
+}
+
+static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
+{
+	if (pcie->big_endian)
+		return ioread32be(pcie->pf_base + off);
+
+	return ioread32(pcie->pf_base + off);
+}
+
+static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
+{
+	if (pcie->big_endian)
+		return iowrite32be(val, pcie->pf_base + off);
+
+	return iowrite32(val, pcie->pf_base + off);
+
+}
+
+static void ls_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_PTOMR;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_PTOMR), 100, 10000);
+	if (ret)
+		dev_info(pcie->pci->dev, "poll turn off message timeout\n");
+}
+
+static void ls1021a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	if (!pcie->scfg) {
+		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
+		return;
+	}
+
+	/* Send Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
+	val |= PMXMTTURNOFF;
+	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
+
+	mdelay(10);
+
+	/* Clear Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
+	val &= ~PMXMTTURNOFF;
+	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
+}
+
+static void ls1043a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	if (!pcie->scfg) {
+		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
+		return;
+	}
+
+	/* Send Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
+	val |= PEXPME(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
+
+	mdelay(10);
+
+	/* Clear Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
+	val &= ~PEXPME(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
+}
+
+static void ls_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_EXL2S;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_EXL2S), 100, 10000);
+	if (ret)
+		dev_info(pcie->pci->dev, "poll exit L2 state timeout\n");
+}
+
+static void ls_pcie_retrain_link(struct ls_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
+	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL);
+	val |= PCI_EXP_LNKCTL_RL;
+	dw_pcie_writew_dbi(pci, offset + PCI_EXP_LNKCTL, val);
+}
+
+static void ls1021a_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
+	val |= PEXSR(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
+
+	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
+	val &= ~PEXSR(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
+
+	mdelay(1);
+
+	ls_pcie_retrain_link(pcie);
+}
+static void ls1043a_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val |= LDBG_WE;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val |= LDBG_SR;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val &= ~LDBG_SR;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val &= ~LDBG_WE;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	mdelay(1);
+
+	ls_pcie_retrain_link(pcie);
+}
+
+static int ls1021a_pcie_pm_init(struct ls_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	u32 index[2];
+	int ret;
+
+	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
+						     "fsl,pcie-scfg");
+	if (IS_ERR(pcie->scfg)) {
+		ret = PTR_ERR(pcie->scfg);
+		dev_err(dev, "No syscfg phandle specified\n");
+		pcie->scfg = NULL;
+		return ret;
+	}
+
+	ret = of_property_read_u32_array(dev->of_node, "fsl,pcie-scfg",
+					 index, 2);
+	if (ret) {
+		pcie->scfg = NULL;
+		return ret;
+	}
+
+	pcie->index = index[1];
+
+	return 0;
+}
+
+static int ls_pcie_pm_init(struct ls_pcie *pcie)
+{
+	return 0;
+}
+
+static void ls_pcie_set_dstate(struct ls_pcie *pcie, u32 dstate)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
+	u32 val;
+
+	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
+	val &= ~PCI_PM_CTRL_STATE_MASK;
+	val |= dstate;
+	dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
+}
+
 static int ls_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -91,22 +341,63 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 
 	ls_pcie_drop_msg_tlp(pcie);
 
+	if (dw_pcie_link_up(pci)) {
+		dev_dbg(pci->dev, "Endpoint is present\n");
+		pcie->ep_presence = true;
+	}
+
+	if (pcie->drvdata->pm_ops && pcie->drvdata->pm_ops->pm_init &&
+	    !pcie->drvdata->pm_ops->pm_init(pcie))
+		pcie->pm_support = true;
+
 	return 0;
 }
 
+static struct ls_pcie_host_pm_ops ls1021a_pcie_host_pm_ops = {
+	.pm_init = &ls1021a_pcie_pm_init,
+	.send_turn_off_message = &ls1021a_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls1021a_pcie_exit_from_l2,
+};
+
+static struct ls_pcie_host_pm_ops ls1043a_pcie_host_pm_ops = {
+	.pm_init = &ls1021a_pcie_pm_init,
+	.send_turn_off_message = &ls1043a_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls1043a_pcie_exit_from_l2,
+};
+
+static struct ls_pcie_host_pm_ops ls_pcie_host_pm_ops = {
+	.pm_init = &ls_pcie_pm_init,
+	.send_turn_off_message = &ls_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls_pcie_exit_from_l2,
+};
+
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
 };
 
+static const struct ls_pcie_drvdata ls1021a_drvdata = {
+	.ops = &ls_pcie_host_ops,
+	.pm_ops = &ls1021a_pcie_host_pm_ops,
+};
+
+static const struct ls_pcie_drvdata ls1043a_drvdata = {
+	.ops = &ls_pcie_host_ops,
+	.lut_off = 0x10000,
+	.pm_ops = &ls1043a_pcie_host_pm_ops,
+};
+
 static const struct ls_pcie_drvdata layerscape_drvdata = {
 	.ops = &ls_pcie_host_ops,
+	.lut_off = 0x80000,
+	.pf_off = 0xc0000,
+	.pm_ops = &ls_pcie_host_pm_ops,
 };
 
 static const struct of_device_id ls_pcie_of_match[] = {
 	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
-	{ .compatible = "fsl,ls1021a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
 	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
-	{ .compatible = "fsl,ls1043a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043a_drvdata },
 	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
 	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
 	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
@@ -142,6 +433,14 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
+
+	if (pcie->drvdata->lut_off)
+		pcie->lut_base = pci->dbi_base + pcie->drvdata->lut_off;
+
+	if (pcie->drvdata->pf_off)
+		pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
+
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
@@ -150,11 +449,88 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	return dw_pcie_host_init(&pci->pp);
 }
 
+static bool ls_pcie_pm_check(struct ls_pcie *pcie)
+{
+	if (!pcie->ep_presence) {
+		dev_dbg(pcie->pci->dev, "Endpoint isn't present\n");
+		return false;
+	}
+
+	if (!pcie->pm_support)
+		return false;
+
+	return true;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ls_pcie_suspend_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	u32 val;
+	int ret;
+
+	if (!ls_pcie_pm_check(pcie))
+		return 0;
+
+	pcie->drvdata->pm_ops->send_turn_off_message(pcie);
+
+	/* 10ms timeout to check L2 ready */
+	ret = readl_poll_timeout(pci->dbi_base + PCIE_PORT_DEBUG0,
+				 val, LS_PCIE_IS_L2(val), 100, 10000);
+	if (ret) {
+		dev_err(dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
+		return ret;
+	}
+
+	ls_pcie_set_dstate(pcie, 0x3);
+
+	return 0;
+}
+
+static int ls_pcie_resume_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	int ret;
+
+	if (!ls_pcie_pm_check(pcie))
+		return 0;
+
+	ls_pcie_set_dstate(pcie, 0x0);
+
+	pcie->drvdata->pm_ops->exit_from_l2(pcie);
+
+	/* delay 10ms to access EP */
+	mdelay(10);
+
+	ret = ls_pcie_host_init(&pci->pp);
+	if (ret) {
+		dev_err(dev, "ls_pcie_host_init failed! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret) {
+		dev_err(dev, "wait link up timeout! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops ls_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq,
+				      ls_pcie_resume_noirq)
+};
+
 static struct platform_driver ls_pcie_driver = {
 	.driver = {
 		.name = "layerscape-pcie",
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &ls_pcie_pm_ops,
 	},
 };
 builtin_platform_driver_probe(ls_pcie_driver, ls_pcie_probe);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0207840756c4..98710bf5ab0e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -54,6 +54,7 @@
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
+#define PORT_LOGIC_LTSSM_STATE_L2	0x15
 #define PCIE_PORT_DEBUG1		0x72C
 #define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
 #define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
-- 
2.17.1

