Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA3B6E7FD5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 18:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjDSQl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 12:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjDSQlw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 12:41:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E5E5FFB;
        Wed, 19 Apr 2023 09:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0Y7Af9GBtaTXg4udQ8aInkQ61Z8fuOJXS04bl6iiR8Yyqg7A6JBlsyICxg1cavlhVa0/HOFDgvZNWHiTjGB1oNOwx9sK4M7ZRXWAmmo9cTgJsEjRT9p9BvsXVJTU4GP0dRtit/KeYBCAHWQ9wGzmDr5Yzr6mu/QTyhVNMTo8RVvfniYwH8MbTliZCfkx9drBLifR7qPHVlc1QAml0EQyAtJ7iffFw1pRezye0RIANNWvgo2yh6Rt/Ct8IPJgsk73nnz0wmcN0h0KIMZXgqMfvSlhs0UDLWuoQTQPYjIgP5HgCyPOtTYQnrs76CZgl9+KGLj6hP1GYqZKQkviiLG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8K18crXITgfnCuv4u9zu/hl/Ui8RAR5f2IJYKJj9Hk=;
 b=kqDEm9GpBea4YKIsl/k2p4go6aP5z0OqCJdDVoPoBGHSwkLJc31bbwkeSyCU1e5/IMetC7LAuR1pvrOBC67L6Y63B2UinxgzB9sWqptI/UaDk4lerS/SEsKBbbXOE+WGKlmEupYQQSZhz5nBZ6Y5TjH/vBwLE8JlpSCQKP3tCXRFP6M61eWBTHH+juV7s1S9wEeG/57vujv5iSjYCp1eNqtkN+uhMIVfIUOSFMtfwYi0i9/4tf33pktuVliqdb/cwkNlnVH3Lx6FCFn0cBOWrSNhXalgswhlH4+6fjARxRglo1Ugleslb2wvP1qu5IAaCUtIyL6MVKh0noXCtPoo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8K18crXITgfnCuv4u9zu/hl/Ui8RAR5f2IJYKJj9Hk=;
 b=Os7h53CVlRMTF04axP1aGyFDFesaODPxUOouUirmXTdJRL/Sy2L/kym17/m9odB6dHkK8xdGGBq/Sv3riFsVPmdZBx1oOnAl3LofvCSgTe6m+55ZIdYaNEsHijDQFzvJi60fmaQQ+Prq80wpWjh78G5mA+trOpyJX9tYFnQVT7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7535.eurprd04.prod.outlook.com (2603:10a6:102:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 16:41:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353%6]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 16:41:47 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, frank.li@nxp.com,
        gustavo.pimentel@synopsys.com, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v3 2/2] PCI: layerscape: Add power management support for ls1028a
Date:   Wed, 19 Apr 2023 12:41:18 -0400
Message-Id: <20230419164118.596300-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419164118.596300-1-Frank.Li@nxp.com>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af25212-e5ae-4870-b685-08db40f4f748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DfYupWuvG1Zu6TsIFvxWP+Y+cixufWO0XOwAnBt/6iEA5dJVt3aPU1j3+g1h1iIwkEDjP7UJPyjzVvfHlWsakH1Q7p8bsmMWRbn6VsNWmE76y5+Oir2Mgs80BbNH2aGL0BUdX1lEDo20CNRavw9SZMjKOMbYSU2v+V+/oxEzBO/p+pY8DICH5KLfe9Sv0b6jwlSeh6qtAb3M+H9+SC4aNMZTdl65yetlucDqGV5/lCjXh63STKtl+9bl5q9g0IJ78+dk+f6CLulkWLdqLsubQeFyasDJHzhh9NFqJOPGqJxEZph5flipRAVU5omeMqO+WF7kd5FXWmtRGRpi9duZiwsgsFdDtZ77RrCsX2Kya514RUveHzfbY089LwYe2Kr1SHUG7JbAQs1PO1G27RosQdgVy8NGHc0xb9zx50ZtIRwbq9kudg7H6UcyoGC8/+Dz0nEbfxl7D9DDx/uaUFZQ/+Qgm0/jjrOWzbaUlyBOAeiuuk35oRiO6zJZvbg6ySIrPG8qXeHZZl1vUsEGGVsz7BdNlbF0wNJFKHnlcoGbkSBkHQheGowDVpvBOGABjEXfeimKQMAAmefe+CT59pnpBeQCbdwSBMZgOzNhhQ1t3DK8ka4MiEpD9cFqEclOkHDT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(316002)(8936002)(8676002)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(2616005)(83380400001)(6486002)(6666004)(52116002)(6512007)(6506007)(1076003)(26005)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGZISI2TuvIhJ6wl1Tq41UCIDQaT1+un4CCqENtVD1/we3cwpJUyipraegFV?=
 =?us-ascii?Q?GLVvPxnaS39I5oFK4pMM4wd8YnjPrUksZ4KaOTutsvWmBJrqkrPZhS93jEZO?=
 =?us-ascii?Q?UrkRDrPWuI7Mi6SeJ1k/xUWGwYBffnAHZ8o+jffjfoDsLnR4s/z1kZpUy8Ic?=
 =?us-ascii?Q?aDHhXV4SKrAdtYs0l3vHnKGey+Rt0DS6fNeKdz6f9254Q6L/wuTKYbcvjBuF?=
 =?us-ascii?Q?82CictWg+E9use+0sfSReUOlAWZm7urhpxPOXrWwGrv49oF+OTWATpix5q1a?=
 =?us-ascii?Q?uF0W6/cmWv9ERVNESQg9ayc4nOUvnd4Hh2x/DcRXB/cTzZ6/2rzkyQjgJxNi?=
 =?us-ascii?Q?yzHpNvxgRS5Sa91v6306bX5SeHiSTtQlSbN9UQLJEukw84VdVhPIAF0d/PTM?=
 =?us-ascii?Q?dUhUDhwME+s0QKSJVDqJyhLLl3rW6MaG+UMph8SLJji44qEmkIAOVyyUjNqt?=
 =?us-ascii?Q?bE+IsS0PGoL/uOlUXbFu2E58psRjXQ3Ir9NN3iEsR/eTe6Rp48QGjf0QrbhN?=
 =?us-ascii?Q?4N9t9Qrsv4pSM31K1CUi5u+TSFjkfz+GSQ70mwuYvMcfrkuA+PPVyi3ldkMf?=
 =?us-ascii?Q?dE0TJ9omOGptShZJZwMMQ8Bo69Kegg561gcIZKqsn1hYZ3pKfZc4nCG51OFD?=
 =?us-ascii?Q?RQN3q1m62ts6/aYn2Wn2mr8mDUdjHhcAMkfhwvrb9P+JdI0mzNM2tQhaEuAn?=
 =?us-ascii?Q?v7EcxkVIoYXSi7Pz1CheAEgWpayFBj7ByXmTncg4PId8FXFNJ90Rg3C/FnW+?=
 =?us-ascii?Q?+IMJe8sZQwHFjcTdcMOKF63xQPgFxmRVYpgiYODxjwtuGFZOxmPFiLWHeLam?=
 =?us-ascii?Q?sP7+EX12/WNpv6JfdKpmVFYW5XRnpXzM7TSJm24ndBAH7nvYc0Ddwx+dmLT6?=
 =?us-ascii?Q?QxQpL9spFQ8j+5cJXyjdAQa2k5KIuPTka0z+yYEOG8fjuDeSBZ8zm3cAFUlk?=
 =?us-ascii?Q?ICUEeSln1cCGeKYwlYDheF6xm6RV/HOlFsPRdByLK5VbG57Nf1H/0J1G51Gz?=
 =?us-ascii?Q?hGrBDlY6BNq7avKrqe7m+TB0NfB+A9ntzn1W+GHRkNuJFVu0K0kkYBAwp11I?=
 =?us-ascii?Q?KyRniL7VqsxrDTKmeq2NYDV6cetlNshMZkJuHRk1bWOC3gPNfzJdJxHIucRY?=
 =?us-ascii?Q?xcLBxvJfIng70WGkk0vmA5Q5JXXq7rRX7yroCVfm4b4RphgZpPZmhLzA5/u7?=
 =?us-ascii?Q?851Vv27ywNS2LJyDnCugbMzXA0x52G9HC2nS53FtSOVqngn7OzBLxkcdQos+?=
 =?us-ascii?Q?N8kN5+u2EQe78D1q8vxjB2GLUMps3XMaQ434tIJ1QPcHk7vEqs4AZXjmvne9?=
 =?us-ascii?Q?ilUP7NAZkDImj1cy1gDeXyj1RyGULD33hnfKkGBgsXFR0tq45KPZbVMQp8lp?=
 =?us-ascii?Q?NG0Xc7xv7Halvrj9lCjsGXpuI+bISZ9xDzt0cWyuqXXnn9ReXUWBWcdZTw9q?=
 =?us-ascii?Q?h7qkKlIu+kFGzZcL+njEBBa6nEgetNML9dehlzwND/u39NEFTHHiCZ8lnkqj?=
 =?us-ascii?Q?heYd8gAFqDRK1zUYRM+Y2IOUh9vXSeznfXp2kA8uzIRsjauEtxwqnwnYYcxB?=
 =?us-ascii?Q?lzu9oG6OHp5fUF9+DvM9o3jVnLPrAa1R9eUCPdVh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af25212-e5ae-4870-b685-08db40f4f748
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 16:41:47.1355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNxNMi82DKeoSz/lGPNjO0Fmz3GoSL//H6Y4HIAtX6Rd8rtebmHyyT+fQYOx0EbjpCgomzdDBlHS4DrynTuIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
- Basic rewrite whole patch according rob herry suggestion.
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

