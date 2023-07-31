Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B067276A167
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 21:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGaTkp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 15:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGaTkk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 15:40:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740B9199F;
        Mon, 31 Jul 2023 12:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0fjGfHZQyKhER4tDBJC0K+d+w99F+weaBrBmYbp8UzVpmfyPMfVdLxppW9cZb6xDrozsc2FAtnydDszaCY8AFEvTs5zu19JAlsWtgxWzq+3TbVNJiFyxEeKXmHeNwa0cecHDv5dy5723jFr0QRoi13LQ/ieK/beTCWC+zAxU6SLa6DiHj1GZgHHfAHMzUBy4wKDHNo2owzRaP44V9g9if78MzSUla6OfZKSAMwt3KleQR3Y8dlfiIq6qIrGYIuKnmSPZgJeL0slXj1/1yEvAi/VzQk54CtiaxVLFIYG4Oj4WdavZXhdq+O1Zikzi9NFc0rZilQ7dAB8pivBCcunVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK3JVtd0hBY4zvVsCFWwRi98AxDmHi8wbX8FY1pWbX8=;
 b=DKcCtQmWTSld84GcJnakQyrGU72npRHKzD7s9Jryi1zSGcZ4eiCNVtHZrXeLujOhTKmapZayvIkVsfGSnyCp7VMO7WpPKevC02nqPpyxkDw5fd6Ugij+ap1PzMJqfYRKE7qlr7RquNt9frmFpNdUX1LaP+Zy81JRExEGSG+FCf3cdedxio0h1xZq6vJ3GyyoK5WSuzvbPCLBlff5NiHDFc+cpT7dyTK5+1BRO6plHyhYmyvVisUUXahGhk9VEXsafEotk+Gjw24rY7+++XoRm5sGhs0YWLX4RpcWy2ETgwN0pgMjyZpw+vxPa1F6E7L7JKFiShvZusyvY0gvfKyn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK3JVtd0hBY4zvVsCFWwRi98AxDmHi8wbX8FY1pWbX8=;
 b=QnFAV0rFF9u11dzfXBsLUQaKvprKhOfNNVMxrjtkIbLXK9qF8Lb3XNIebNRgxLmEja/XhA5H6AkwL0HTYcQFdvObsbRR9rDAumVTmXUEnWtkUs8XVCGddAYVxjlvH8v2b5sqJQiU1Q2tvi8mR9TUFbz5xuAA7OR0Rnl8yqvIYdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 19:40:35 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 19:40:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     lpieralisi@kernel.org
Cc:     Frank.Li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v6 2/2] PCI: layerscape: Add power management support for ls1028a
Date:   Mon, 31 Jul 2023 15:40:10 -0400
Message-Id: <20230731194010.73016-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731194010.73016-1-Frank.Li@nxp.com>
References: <20230731194010.73016-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: ad32cd01-4011-468d-2202-08db91fe02ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXUPnSNV2DHdq2FYH0+Y6m4xQ5iyu/bCR5pjgEC2yJAG+qwB27ySOv7MMkRxnvE9mW5rbGoTDbmkyZrSBML89Iza/+IUmVUmIBESlWPGn89YiQdSpyDMuAjboydDOhAQ8t9z7VI+9f9h+juZeqRrRh3DzY/G0IKVQRBVBe3y7L/utMaCNhA6NnFvfbYpPuu0N2JH/Kih9lMpKMEhSAAddY842DgQa4X0QLN58CaTKG7F/kOlZW46QKYQkiN/bNUt7USL/yAOfOaAe/HQiJmYzuz7d1t2MngFVQ15z79MDnvD+WxA8J6zpddpG9oJxue7gQC3xPPiE+f+3zrg2tCkYTw3Ow4QQadv4RXROO3EcmJVHjle6KfqhIvQtiE4WQfr2cpV0ZFerwV04peJkfaA3eEVVDVSIkYnQQhurwsG4zzn0jP/Hmt4h6XEKJDYEnRtyHX/qaAq6uPIs67CUn/+SwhPjjQWA+KgckxNeWJEFdTwRB2/yDB1+gnM6lXbfN+8mpPDPSwGbyVOTi9+vGkejdVoCFiyTdwW3hWPEo0bVIurQBMhykNxl1Xk30lpLj/mZt5EmIujgnirHAlTByiU0nrIn+tIpAimb7uIir+MgElornGlkDW4MkuDEGWPSQsD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(38100700002)(66476007)(86362001)(8676002)(8936002)(5660300002)(316002)(4326008)(6916009)(7416002)(41300700001)(66556008)(66946007)(38350700002)(478600001)(2906002)(6666004)(36756003)(6512007)(52116002)(6486002)(6506007)(26005)(1076003)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h6FCGSCiyFf4egmIoVeDOeh2pPG33vGWOM+4TffSCARS/8+JkUosX8ZuhNuI?=
 =?us-ascii?Q?oGFafrd79ul8qrCjN25HgIHoQDUvjBPg0aD46tAJlvPRtqX8K4mmz1PA/jDu?=
 =?us-ascii?Q?E50SIgvDjoZkQQUEhw+lcFFK0Wu9oxJO0rcffORh8NDendx8Ii9JvndZXHUz?=
 =?us-ascii?Q?qqD7vXRw/FlMQnDYcorvAniEQhGAxnbt0D4A4HC/nF7tpeH85LvwHGIqmR9H?=
 =?us-ascii?Q?0qPCkVM5ra8rJ6FnmBUEgNy2RL8gevZd1tYLJ90fsVIBJg3uQIAaMhUTpkrb?=
 =?us-ascii?Q?gs5J+HTGyeTO5/iDlkAb7iUGlaZx2VnvOkGJNajpnod0ZaMYZoezWXDWOrhG?=
 =?us-ascii?Q?AxrUOQYeSvopeZSqnWXs2X/5hO9TiUhPE5ngVa2L7A/3Pn2Pue9X04gt5ziE?=
 =?us-ascii?Q?OEbnbG7j3qcjxk5mmyUnCkhPES1MX/YZld7Kr6mHdi8U5KCtN+ApSaAuUU6j?=
 =?us-ascii?Q?GI6HYFWvuZ9RwjsjMlCohpXqm9X5mRueHCO+8WC0Zx5pAZwHicwgp6Ms4ElH?=
 =?us-ascii?Q?ptqwQII0BFz28HjVE81NTNgkT3W4D6jg8gd2zwDT9tZ0InKxydT6kBVQknTq?=
 =?us-ascii?Q?vUDy233DmrB3NQJpdFx2CUrNDxIrY+h0MQcPhHRMFIh8LaFXPI3YrgSJCXgL?=
 =?us-ascii?Q?wlj4JCacX8tF35X02+3xsmqtzFavUWg6OkKLqhefhLHakjfmd3076+3NUTWs?=
 =?us-ascii?Q?66nkVO8iCE8V1WaGJdqAkgXKr6jmTet9MqdmGiRUse0eEZFGmvsaTi8aRphW?=
 =?us-ascii?Q?Wf+d5MAbtWgG7kiYjDQ9caZDoq+v2UFQVBwkHXc4z3RcoyOp7MXHlveOnuCL?=
 =?us-ascii?Q?d2SJ0RCyvwIzy5LfnAn9nRTCizfiheyDJauA18XHwZKZ1lnQ9IUFwY/GwdrE?=
 =?us-ascii?Q?YjGfQeCB4C1XL/cZj0WuDjivu3j1ZblJtkO3rD0ogr6P4YQMIoyuxsVOXdN/?=
 =?us-ascii?Q?br0yeiY2X7Qhy36sriEVSvb7G1Ou9PfiwWKEcGteVU04QKcs89y4F6pXdXqt?=
 =?us-ascii?Q?lf/79rGPWUHhANIQV1At/HVaDvRVCxr+Go4BDfn/WJHzi9F4b0elvvZRS1lS?=
 =?us-ascii?Q?OsSsDw60n+QO8jdhvvqQzmLWaI+5h8zJXkH5YE+83hgV9GXbleGPb88Xp2qp?=
 =?us-ascii?Q?hb1Luns13YmIk1uRATY+U3FSfytIB7UNGe+nYpfVwHpV0DjUAVY1EtPpb83O?=
 =?us-ascii?Q?HJ42LNSYl0AKXhXwhtd9vPwvn5rpzsUzY47YLkJsq0oPHufbDY2XYdjs8rg7?=
 =?us-ascii?Q?yHswD17C27PG35mWeqIOEuzmznatrqrxXqLQUyNujNt75R8S1ZH5/6aNfkIv?=
 =?us-ascii?Q?iIE8qfDHCDkVpR9ixsaUJSijw56PCsB9fgtBqiIEsXQUL0DPQbD36dL+Out8?=
 =?us-ascii?Q?ZKmuHRy71W4YHgziO0vOwl4wbSHH3He2eciHGj6R+eMvpAWE6NZ4gSJzfCIM?=
 =?us-ascii?Q?oELYAjwKQfkyYyi1/k4Mr550Dh6zSCO1KAq6fnMgrx27Jjh2yr+JPGCsvqzk?=
 =?us-ascii?Q?RRf6C+4K6AP6G8CEvT/G98kdaDpPHn1EhTIpN2/DdBCixi6fvE7SQTUCaYQD?=
 =?us-ascii?Q?XIboiKZe0ZrMp4/IWqI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad32cd01-4011-468d-2202-08db91fe02ba
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 19:40:35.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiGP0vQX+xoFMhwnlZx2rk2r7pO04lZ1w5ZUr7GjyUv4e55564yvV88nB4YGvvY+8A8um/J+7UXR9x0FJFBlmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344
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
- Change from v5 to v6
  change to NOIRQ_SYSTEM_SLEEP_PM_OPS to remove #ifdef PM_CONFIG
  
- Change from v3 to v5
  none

-  change at v3
  Basic rewrite whole patch according rob herry suggestion.
  put common function into dwc, so more soc can share the same logic.

 drivers/pci/controller/dwc/pci-layerscape.c | 146 ++++++++++++++++++--
 1 file changed, 137 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index ed5fb492fe084..f235c79600277 100644
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
 
@@ -139,12 +238,41 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	return dw_pcie_host_init(&pci->pp);
 }
 
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
+
+static const struct dev_pm_ops ls_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq,
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

