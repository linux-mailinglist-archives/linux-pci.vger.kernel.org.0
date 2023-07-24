Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F567601AA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 23:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGXV7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 17:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjGXV7D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 17:59:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AF118C;
        Mon, 24 Jul 2023 14:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGG9cMbeKPCrVDqBo/NnxPCiSilxliWNbKmF4wX8PscGAVRCN2MXEU6CT/qkiiLiPXYdzyDkhZffFBOOZ95ncSL8QkrTQB2dN/DOqsT5zjUq2ZYNwHPPaF/LyerdBE03zLrue4tPRwoiUILGEdok0BPQ1NQZ+v7Zx7xiS0i1rkuDb9rTYjbZq7fpr62mSo+Me40Ghcqow27x4sdtfac1GRcLRzA4nB4XoY3kE0HS0X/aYuQG6LQqlDVEYhjrXlblh47ZGRqZCjWPVUPGXWDgIw9Lbrwx77PyRnL33L0M1woE2Dp7eu/uKqHzqajL0vlcb/0amD/LSJPQa/Wp9eTxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQG80CaiH1M0PX3wnepyz+mTBxfuubeOkwAtbLZiRWE=;
 b=h+GShAfb1ZQ76NJ8gQsqNPqss2ekuGet3b2KCMUvxC5jpqsFRVKx7axlFHlS7bj843QcprM8LzIMqq3koLDDsHvbsJ0kr94/+I3Tc0qLcPnzP0ayruYTEB+j6lu04tnbDRTwGS+ZJe6kD+nUhMRGznnx69e0SW/39Wqnh4d3WI76+8SJX1EHxSvaUiJMdA92nJAaIV/EiZ+4xJgPTtREUUGJidXhno5qsSGfCYzFVDSqYxx0v8uBshhiev+xvA1URPBFNygWBZ1lV/lMr1PHlsd00e9dOPIvnx48GEfJpf9DSJFnj3NK4ebW9VFzfJ803c9TAFOZMf5+xXRPJONQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQG80CaiH1M0PX3wnepyz+mTBxfuubeOkwAtbLZiRWE=;
 b=B5wNXANFtvZ0Ygd8yrk11O1dL9rbY1kuqu28I+HDq19Em0rRpFceBMWc+z3ZphJXxoM1clFwRpgXV5gdjGJgnVqSLZdD9QMPW40MOYqFGUuZ/tZDFcO61Ng3fJ1VN9dWKrciIyzT3vfuIeVHDjSJcNjM656eWBck3Wc4F7tiN6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 21:58:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 21:58:59 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, lorenzo.pieralisi@arm.com,
        manivannan.sadhasivam@linaro.org
Cc:     bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mani@kernel.org, minghuan.lian@nxp.com, mingkai.hu@nxp.com,
        robh+dt@kernel.org, roy.zang@nxp.com, shawnguo@kernel.org,
        zhiqiang.hou@nxp.com
Subject: [PATCH v5 2/2] PCI: layerscape: Add power management support for ls1028a
Date:   Mon, 24 Jul 2023 17:58:30 -0400
Message-Id: <20230724215830.2253112-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724215830.2253112-1-Frank.Li@nxp.com>
References: <20230724215830.2253112-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d644b7-951c-4a9b-7cd7-08db8c912f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6s/J27A2qE3XQ72wgTFKDXTFQWt0XIoSs8fbJPtnKAFQVseL3fXEXafmWd5BIx1PIMBK5hcVcOvsbByJriQIIWRDKK4ugEEno8r9smsNH2vvaif8O1cxi2qc5xNtIsVh9fyV8vxb0579MEyCL8wv4HmCtrNSw6bDWRsnA9FWUuHVYbAzA3xHjmzRbJzBWhI/nhE6S6NpqBhlVr6tEANMJ2ccNRlfM/aMUjsSmURfF7ado73FkACrCHBv1KsAM67gN3aE9u+pfaI13O5Uk7cwaQmMwikcZD6MqQ2qw+Gf1mODn6v6gtMkM9fqpcjEz9dD5XypbQQIvgUwQ+ShqyguYwhchhCrmG+wE+aw8UFi9E05Uu4dLgKk1/avh/cRiewiEMaJODLDUEfkmcLOL2mMe8JmNYZJK65UnY0c/x1/4q7oTpaJaRi3E25SX5RRwiCBUx4cRZUP7qGEEBxK7IW3gmuW+i92VYODInzVzWnvhZ7BQw6aHOVDrQ4apa+t5fcQAz8WhnPbXFXXNKH84cnWB8HmqG/4btfYzalmDgtXstlkD6QJj88rjWJYeRBbPW4zCNbej4VL5uGnc1x0cwDre78CflcCkmtDy1zHFujn62HzbETrdhaUciKwbVvOxue
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(38350700002)(38100700002)(36756003)(2616005)(83380400001)(7416002)(8676002)(8936002)(5660300002)(478600001)(66556008)(4326008)(66476007)(316002)(66946007)(41300700001)(26005)(1076003)(186003)(6506007)(52116002)(6512007)(6486002)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HrMYRKSl0kpTSiq+pgR2rx2PV+I6wpK8/EaGRg2Z+/hyp7xirbVAXSxn7FqH?=
 =?us-ascii?Q?lO+oy+55Mw8F4n8X4QdUfxHABhLwq2gTLwY4qkXPYbERibwcqGwpt4d3iLMz?=
 =?us-ascii?Q?bQTEKnAPpkQyMpBbJnYpGZyPsb3siNk3iggem8D19BcZTdaYlOqv7yJ/gDxP?=
 =?us-ascii?Q?fw4bzSE9HYsCTTO+pX7wgEFJzUhA5Gk6VTdm5YtQ0C4GPGgddfrADy7Yv10W?=
 =?us-ascii?Q?NGf9dvEHVsyslyahiTWdgmHcRvZ39d6bsUYsbi3nYW5xu+lbpMH43Xl898Bn?=
 =?us-ascii?Q?9/3GtKrwXHmNkJnct3dvJKd6MvNjE/JAc1eWrP1njumaPVj4ttrQdZTiVlvb?=
 =?us-ascii?Q?x9h0hAKHJgSas6/wRfEFr3bhcRtqpgeO1AUVNVUkVSTjCrkBxtqs4W4CoaP/?=
 =?us-ascii?Q?aS3aR0X6On/JSAuaWhi1Ib8hPXB+nxXF104+s7/YKHu1dMhdyHYbKquo508V?=
 =?us-ascii?Q?9PKQSeYx5qKEIt+KZAUapkIPoddXiuvMushWXx3KoDbuuXG5w92xgFIYAM+0?=
 =?us-ascii?Q?RB3T1LAomsf+ot9lfiNaWbEFGKaOpvuFBKWwWUqjVo0CFSdbcvuIa5Inf2hK?=
 =?us-ascii?Q?FMnoeK5tCbRm3iSQ26xIMIovFN4KAUgAp/u6hBkBx770ecg7liB9GYPBcZuq?=
 =?us-ascii?Q?lAWkxYOl8xTAnZcMHOnFC8WTx9tmQr7uiuSMJTpsRSdhiUfox3/Dj5XF7QM1?=
 =?us-ascii?Q?K1gq5xv/kEVKrI7GBFbR/nkI9gikgJ5pk2mvTeSFlCM+blvZEIjjD0UtSQ0K?=
 =?us-ascii?Q?wz6I3J4IJ0LYjPDg+08/Ytl5WAdg9y1Umfm6ojA5tZmdYAqJbXYVTILaFq9q?=
 =?us-ascii?Q?+T2Fvw/SnWsRjsfOQ7WHoSsRELKGYndpGiieuK7FCeuyi3TQ7hgnX+FQonGp?=
 =?us-ascii?Q?aWqQjF2LUspwCi5nNgZAwSSzZzsF0FKyzuJUduwALt9hveOhS3nnBgJMKL8I?=
 =?us-ascii?Q?JbukyEq+4Dxq28XotTCCzgvQ/9N26SlZY5b7cxppdw4vyhArbVsnyCL5tLlD?=
 =?us-ascii?Q?FTA/eiN2KBiLhxn9+WDRJeshZuOMhvGmKn4YTQGgX3/BVoso1Z526lvWjn0M?=
 =?us-ascii?Q?idyqQx/TpL3HAUWH2+yv3biLIV5JaSLQFDWDv15e9o93H9ru+Ma2Tjosdemx?=
 =?us-ascii?Q?3MfyaV69KtDfUGwADi2NAw+ZHiRSUw/1zx9K56gnLIVUwdSVr0M7ubS+Qv31?=
 =?us-ascii?Q?IciKcL9zUTQls+wS2mNaXX5omtLNttEiNMJRUlK+1lk867cJ+c/EGOoWhomO?=
 =?us-ascii?Q?orCX1VfGqGBxMBHh/d27TwmfzJA0D7FKbg+HTbCd9CafNRCx3E3cR1GkPSnQ?=
 =?us-ascii?Q?F5wpempOxDcrT8zkUwYczmvALnFGAECbVemFgfHQ5tK5puzj3uqNwLvRB+we?=
 =?us-ascii?Q?Kj/NRNws5iJo8hxG+2qwebdoH+w00OQLepDIHuIHei6zqITyh4rV12e7MBi2?=
 =?us-ascii?Q?Y7aoajozYxW+9iEdjt7BSX0aAFv9//O1uXgThrmy5pxMRTCnoHXYY3fOnPyN?=
 =?us-ascii?Q?rZS1YaDfMWwTnWp7wXoB+vA/OVvEA0d3BGLrFnZr1gTqs9f2Jw9WNeafYNE1?=
 =?us-ascii?Q?G7qVGEywq16YNr7w9nY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d644b7-951c-4a9b-7cd7-08db8c912f1a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 21:58:59.2627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDCLm0q0hZ/pNm4C/I1wC0R6HUegoCQBFoRO/83UJq0COE+X6wy6GKIzJUe6i3dIzYEvrQb+FJJ2URUYDoM3xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PME_Turn_Off/PME_TO_Ack handshake sequence, and finally
put the PCIe controller into D3 state after the L2/L3 ready
state transition process completion.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
- Change from v3 to v5
  none

-  change at v3
  Basic rewrite whole patch according rob herry suggestion.
  put common function into dwc, so more soc can share the same logic.

 drivers/pci/controller/dwc/pci-layerscape.c | 148 ++++++++++++++++++--
 1 file changed, 139 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index ed5fb492fe08..32832d74a074 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -8,9 +8,11 @@
  * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
@@ -27,12 +29,33 @@
 #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
 #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
+/* PF Message Command Register */
+#define LS_PCIE_PF_MCR		0x2c
+#define PF_MCR_PTOMR		BIT(0)
+#define PF_MCR_EXL2S		BIT(1)
+
 #define PCIE_IATU_NUM		6
 
+struct ls_pcie;
+
+struct ls_pcie_drvdata {
+	const u32 pf_off;
+	const u32 lut_off;
+	bool pm_support;
+};
+
 struct ls_pcie {
 	struct dw_pcie *pci;
+	const struct ls_pcie_drvdata *drvdata;
+	void __iomem *pf_base;
+	void __iomem *lut_base;
+	bool big_endian;
+	bool ep_presence;
+	struct regmap *scfg;
+	int index;
 };
 
+#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
 
 static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
@@ -73,6 +96,57 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
 	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
 }
 
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
+static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct ls_pcie *pcie = to_ls_pcie(pci);
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
+static void ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct ls_pcie *pcie = to_ls_pcie(pci);
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
 static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -91,18 +165,33 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
+	.pme_turn_off = ls_pcie_send_turnoff_msg,
+	.exit_from_l2 = ls_pcie_exit_from_l2,
+};
+
+static const struct ls_pcie_drvdata ls1021a_drvdata = {
+};
+
+static const struct ls_pcie_drvdata ls1043a_drvdata = {
+	.lut_off = 0x10000,
+};
+
+static const struct ls_pcie_drvdata layerscape_drvdata = {
+	.lut_off = 0x80000,
+	.pf_off = 0xc0000,
+	.pm_support = true,
 };
 
 static const struct of_device_id ls_pcie_of_match[] = {
-	{ .compatible = "fsl,ls1012a-pcie", },
-	{ .compatible = "fsl,ls1021a-pcie", },
-	{ .compatible = "fsl,ls1028a-pcie", },
-	{ .compatible = "fsl,ls1043a-pcie", },
-	{ .compatible = "fsl,ls1046a-pcie", },
-	{ .compatible = "fsl,ls2080a-pcie", },
-	{ .compatible = "fsl,ls2085a-pcie", },
-	{ .compatible = "fsl,ls2088a-pcie", },
-	{ .compatible = "fsl,ls1088a-pcie", },
+	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
+	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043a_drvdata },
+	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },
 	{ },
 };
 
@@ -121,6 +210,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pcie->drvdata = of_device_get_match_data(dev);
+
 	pci->dev = dev;
 	pci->pp.ops = &ls_pcie_host_ops;
 
@@ -131,6 +222,14 @@ static int ls_pcie_probe(struct platform_device *pdev)
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
 
@@ -139,12 +238,43 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	return dw_pcie_host_init(&pci->pp);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int ls_pcie_suspend_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+
+	if (!pcie->drvdata->pm_support)
+		return 0;
+
+	return dw_pcie_suspend_noirq(pci);
+}
+
+static int ls_pcie_resume_noirq(struct device *dev)
+{
+
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+
+	if (!pcie->drvdata->pm_support)
+		return 0;
+
+	return dw_pcie_resume_noirq(pci);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops ls_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq,
+				      ls_pcie_resume_noirq)
+};
+
 static struct platform_driver ls_pcie_driver = {
 	.probe = ls_pcie_probe,
 	.driver = {
 		.name = "layerscape-pcie",
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &ls_pcie_pm_ops,
 	},
 };
 builtin_platform_driver(ls_pcie_driver);
-- 
2.34.1

