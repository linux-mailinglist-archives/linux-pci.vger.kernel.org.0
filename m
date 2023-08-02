Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FF476D322
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjHBP6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 11:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbjHBP6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 11:58:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF95FB;
        Wed,  2 Aug 2023 08:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr1y0V8qrROZy31c1pJ3CcWYRmrp299eY5jLU1FnImtqWvZRbn4qVITsNKbrzQNd7wTS+wFOWdVqGZE7I7Ndu19SSbPdizqT4W0RYmfzOneiQukA3sfJGCj/CZ7f9ZhsMvT3Qb2DrfyFNPTSYkr2E/OU6dzqQSGJmOdS+ycUE+chERzE5mPlPHv1vcap5HObUZo01CSxJqxipzH62mxH+tncWcgKOsx36ptUz7BsBCZZ61OldThmPkFKSg80LXSud3OxOszqkOOCZN5c1Y01b2Ru98mIhRup83SWriunm6nMOneemjcttY+Ta+XUbFW7IDYIcLmTpkT5aStjeWFZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4ougJ1qdmVHhUfSUBCtWBF5L9TgKMJ86imTSVpt1Cg=;
 b=jIY2zj++an4BYeufXHMWjt/GwS0GYUJ4ElxTiorTosTFUb1zLKA9Crc74mndxIA/lOzVLHQ9aGe1N7wWLl1NeT+a+TSA4ovGPbTVEwwtVP2mWCP7L14yVk2nVYX89+ryuPGNjWjHwn8AaRdw9O4FaEnYPxOgWT5jypC7ZU8p53MfxHPcC/Lu+8HbVAp556NufyIqQPxSGbW9YC18KXXPzui3xAdZSescKHutUFuBnsao4MoOpXAXfHlCsY+hmjByoVYqClov31Z0sH61xihzVA9MGC5KxhaMRcvaSBt2T2/XoXr9oRCeidtX2vz5BGmzSFixBcmV/oNV3A+YrcrH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4ougJ1qdmVHhUfSUBCtWBF5L9TgKMJ86imTSVpt1Cg=;
 b=MfGbyEg+bYiBzbh1lFmhIBd/k9GiDfZVAA9369jctPJ26/mCGvB2+zhUoOIrS9tOwWzpFM8WqghKEZPWixMiCIg981WF+PR3LwnbDQGdzUNaKwvnDAw04y5TJKThB4XbKyUVd5zq2ltiytMHFgnREiq1hNFWtUKZj5CMbdV27sE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 2 Aug
 2023 15:58:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 15:58:17 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.Li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v7 2/2] PCI: layerscape: Add power management support for ls1028a
Date:   Wed,  2 Aug 2023 11:57:48 -0400
Message-Id: <20230802155748.212377-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802155748.212377-1-Frank.Li@nxp.com>
References: <20230802155748.212377-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa4e96e-fcb8-4e4b-1ffc-08db93714949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYMjKkzYg3I4vcYlQ2rmX4tb2DS9/3dvU5eMu38uwyB+m/POg6XCaUSgasVKPKa2AlJ5uZC8zRmKfncvKlUcteCEkLFQe9wHyxob4EkXLVXqz46E949bgRTHLWi99FlApTlK9Pvp68hTKFqgQPk3foDfaqvAHvQ2x3tR52Vc4f/rqTlZYxNkb69AWuyASIji9XeRXtSeuss2NCZlRNzGt4hvG+sQvkSyCcu1x8IbcoQbmB2UukE4Ici1/MnCrVPoE/V/LBgjhfyQiNj47AcAN73z+M5i1yI2asINFlU+gqjSSEeXWJO21p+oBUs8YrNEn7PrrdPeaxKt/knu2tjvVebVR+FVnCnia/Q1kB447nuNTJdTAMz/OwlR6fWfkTkGhLOf7zNcJflF7A15gTK72KSmJTdjpiKX9+E7O8qHEVLix+sAFeVigdi/KiLnglh04eon8Pf62z4+BLwAHvMnJb7Y5peHGFqGYcYcL53klbGH3sOvnwekJDPAFzEfV94ODiPFRgDM7HBG1wyVlIXpAEncPp3w22EBrcwuDAW6e/x1QiT3hQ42izbm+Nz56I4Iv5QmH1csJFgBg4qzFQqF9y6jhFkaYJSi1CoVzTX0LfnZTf7ZsF4nh3QQ+ikAdgdc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(8936002)(7416002)(8676002)(316002)(5660300002)(6916009)(4326008)(41300700001)(2616005)(66556008)(2906002)(186003)(6486002)(66946007)(66476007)(52116002)(478600001)(6666004)(6512007)(6506007)(1076003)(86362001)(36756003)(83380400001)(26005)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3z/676RfpwEzHHgkYU8aqvA7hXzv+5vEVAZCaaBA9AHTxP39AdIx/5P1Itbn?=
 =?us-ascii?Q?PlVECqyfRQFjX4gXzywgOIQl7jJMGEqX0utPCK+bkIcmIWjmtPU1jZe1Nk5z?=
 =?us-ascii?Q?NydCFZ4D60SKblXEBH4s8jibLPTyir1+B2iD8GyBhsow7eNdrm5C3/2kwyC+?=
 =?us-ascii?Q?z6nANR8juhEbGPqw6wixE6UJxlQCDaEUgVi4ZADylj2REg9RxYpOs5QjfSVC?=
 =?us-ascii?Q?IXdunf93XLSViaL7zveUl+CvC5ltYi/1+8/9adj9zYOLswkRfXwuST7pl92y?=
 =?us-ascii?Q?7eAH4rW8nPQQ7HIDptO5Ougxse6tRrcQhefcF5z2Rs5j/3oJpK1+YpR8ckX4?=
 =?us-ascii?Q?QBEwX0I+L2d+5sM/YgKfE2PCUJlg9qH1m4Y+vnD6gVeheH2yuuIQOVSSHdmS?=
 =?us-ascii?Q?ukquil9j+8F7bvQzCcfk2zFMrQ+zO9RSDe21hrdjIe54oIaz0gzNMx6nmTfd?=
 =?us-ascii?Q?5nDhSlzbvY+9jeYPP8ISLLToBPSKoJlKJs5WCqoAJF/p0QvrHw4T3N2oPxvA?=
 =?us-ascii?Q?5HblCAGvA66ssQJtIx5VlnfHj6Ku5xb0DPG8EGEt23hTooFBPYE4El6pRDUP?=
 =?us-ascii?Q?VfcwB4LqSblDpqmoxy+LRjnAiPPXLqREAUQTibQPvtwYyb8UoWs0LFDKxQ81?=
 =?us-ascii?Q?mVP0HDcQ9jLsrtoaZP4s2+F5/+xzqlw4IdZr9Sqh4acX+GUfbUMmvN1Zqdoo?=
 =?us-ascii?Q?dP64fY01gyg5tmhdnOCt60cs8JDsSpgOi9nSIJgEw9a9r72Q5ELa8ueQJXOL?=
 =?us-ascii?Q?8fNGPfsmAK1Db1bDuF6NIXiGUzj3D7y0bg1offw+lMfdSOIxyICZ2D8UMabV?=
 =?us-ascii?Q?0CAhIqNMawV/K7BbFewQ+QxMjM/hJSVVVJoogKQyadBMj2P6/61g52wx8F13?=
 =?us-ascii?Q?CcXWLHflDPGnSKzq0jZKdp6EMI0saMkhm1DFe1UW2KRt41OurjV+hndkgAZT?=
 =?us-ascii?Q?BgsRknHq8Ol3/cR1gFZ8omis4sCEfErn6pgBfu5f+I0WcEUFQd5LMk7joq9S?=
 =?us-ascii?Q?FOZnl3Ggg404H2ZJAqo23VU26+tDIvHWPwlBLLokicjQKyr7IPvFayxVWP79?=
 =?us-ascii?Q?nIdnxKpQUVP1npKDypWP+JhPNeANzBTh8izRe2Ry4+EM/EUHxgpd0MLRlUkT?=
 =?us-ascii?Q?mqYzf9j6IoAhyOHEg3vZuDYGWoTLmov7Lr60PKWv3LR6wmzUlFfxS2mp0eXd?=
 =?us-ascii?Q?9+i+1OBuhzJkkwprVvSCyaNw9z2llCK+ldVq9D1AoHrdB7MjdwYUXM3Kvefs?=
 =?us-ascii?Q?VKonkPr14NA9iWvYQKhDLUUHly/b54G9dlLobJ7ik7UrXBDiPWdx3T2zHmNi?=
 =?us-ascii?Q?/8iWRnLTR1CWijognqSrTju0+0JXV3ePjvSXyXU5NzCFEoNN5nFtuZZTihhb?=
 =?us-ascii?Q?WE6FNBKmn2Se4nBPLP8ePwHlj6GqpGs0Ecs6oamXmryc5NoQ0U9VsM1tAWPH?=
 =?us-ascii?Q?StZDFfOml2wVLx3a/KDROEB8rjVW9TJ8KMdpBNmQSCpuqCDPb+RibHDmXxYo?=
 =?us-ascii?Q?2E15osKlheKLcaBSnoOLA2SiIKYlM1qRa2q69OixKr19mg/7N9eHTeYSHjfL?=
 =?us-ascii?Q?3RzqClM4oDZgHHf90qM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa4e96e-fcb8-4e4b-1ffc-08db93714949
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 15:58:17.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqr+R6FxkyJI4OkYLHT3EMhxLgeHS5sgY1DioIm2J9D+yjCOwc4sqMMZnuEoWXmAOs+Er016fQeuzl3YaSW71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PME_Turn_off/PME_TO_Ack handshake sequence for ls1028a platform. Call
common dwc dw_pcie_suspend(resume)_noirq() function when system enter/exit
suspend state.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 - Chnage from v6 to v7
   Remove local varible struct dw_pcie *pci = pcie->pci
   Change according to Manivannan's feedback
     remove unused lut_off and lut_base
     fixed  100 to 1000(for 1ms)
     using dev_err for timeout
     refine commit message
 - Change from v5 to v6
   change to NOIRQ_SYSTEM_SLEEP_PM_OPS to remove #ifdef PM_CONFIG

 - Change from v3 to v5
   none

 -  change at v3
   Basic rewrite whole patch according rob herry suggestion.
   put common function into dwc, so more soc can share the same logic.

 drivers/pci/controller/dwc/pci-layerscape.c | 125 ++++++++++++++++++--
 1 file changed, 116 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index ed5fb492fe084..80d0327d4ec7b 100644
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
@@ -27,12 +29,26 @@
 #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
 #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
+/* PF Message Command Register */
+#define LS_PCIE_PF_MCR		0x2c
+#define PF_MCR_PTOMR		BIT(0)
+#define PF_MCR_EXL2S		BIT(1)
+
 #define PCIE_IATU_NUM		6
 
+struct ls_pcie_drvdata {
+	const u32 pf_off;
+	bool pm_support;
+};
+
 struct ls_pcie {
 	struct dw_pcie *pci;
+	const struct ls_pcie_drvdata *drvdata;
+	void __iomem *pf_base;
+	bool big_endian;
 };
 
+#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
 
 static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
@@ -73,6 +89,56 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
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
+		iowrite32be(val, pcie->pf_base + off);
+	else
+		iowrite32(val, pcie->pf_base + off);
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
+				 val, !(val & PF_MCR_PTOMR), 1000, 10000);
+	if (ret)
+		dev_err(pcie->pci->dev, "poll turn off message timeout\n");
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
+				 val, !(val & PF_MCR_EXL2S), 1000, 10000);
+	if (ret)
+		dev_err(pcie->pci->dev, "poll exit L2 state timeout\n");
+}
+
 static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -91,18 +157,28 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
+	.pme_turn_off = ls_pcie_send_turnoff_msg,
+	.exit_from_l2 = ls_pcie_exit_from_l2,
+};
+
+static const struct ls_pcie_drvdata ls1021a_drvdata = {
+};
+
+static const struct ls_pcie_drvdata layerscape_drvdata = {
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
+	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1021a_drvdata },
+	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },
 	{ },
 };
 
@@ -121,6 +197,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pcie->drvdata = of_device_get_match_data(dev);
+
 	pci->dev = dev;
 	pci->pp.ops = &ls_pcie_host_ops;
 
@@ -131,6 +209,10 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
+
+	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
+
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
@@ -139,12 +221,37 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	return dw_pcie_host_init(&pci->pp);
 }
 
+static int ls_pcie_suspend_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+
+	if (!pcie->drvdata->pm_support)
+		return 0;
+
+	return dw_pcie_suspend_noirq(pcie->pci);
+}
+
+static int ls_pcie_resume_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+
+	if (!pcie->drvdata->pm_support)
+		return 0;
+
+	return dw_pcie_resume_noirq(pcie->pci);
+}
+
+static const struct dev_pm_ops ls_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq, ls_pcie_resume_noirq)
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

