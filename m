Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B77770794
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHDSIz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 14:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjHDSIs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 14:08:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7075251;
        Fri,  4 Aug 2023 11:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7NCH22QXVipLfI0mTIezycBZvLaKEAmv6mS7cPcdEbOmCAvmvPjewmoZE7MRCd9o7/K+t5C8k/Cxhn0p6coBMU7fdjMq25lCE1ikNpxLL3jzfYsnyV89X4NLcFqIkp5lI3GDzokGJXt16gj23bmdIYIo9Huuez46/Kh7UFwjU3s/36W/gzJErWcZyyOJEyARBg/InpesT/3tYmKkeakdvG9w9z4UmUgX1T4XCDVY+PXnIXSuWKSNhgl6Ug0rvH9d0YFSOYhj94u4cjh29ps6PWdLqIQcj69dGJCN8u48qgvtM9lWp+h6YtqIgAB7TrAmPUWBaeWbF282gSS32cb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTI1FDwVFHEIcMxT/Kb94jED7qZSnUIDLYRWLWFvxec=;
 b=Q5VCdIvoWF+2S2FqGiLh5HZjg+47HSW/6Jiw3+cFpEwTdd8oGEZMf7APIn4cX4bo5W1t++Fiw1lejh0g3BnFsDkIwt8r6xeO0jfFToISb12tZ/d8AhEujKvWic/IJ4qMAFbq5R2dHy9yMIShlv7ulV02orLmGzh1Y7ETW4sTcGDYHteoyesNMMmZHzut6puksKOPnueC7R4G/U4/8BEsBH+zmPyl1Gl/saZqRKFh+IPO+GrSumwuKQsYUlOmOsOWGtoYTEoMrWm1b+F19kCPD7U7DvzTZi4ojh9FMqE0mj35htTVI4ERtSRNeNmGD0SvJ/4d/iM1cn58BnWM7wG9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTI1FDwVFHEIcMxT/Kb94jED7qZSnUIDLYRWLWFvxec=;
 b=dkGl1KMogibzScma41MSAUTfaab3Iot1V/b3hAOl2og8VHfquJyKh6tbYqp0s4gqc25GCDt0rZtaZC0Sde7KnlcNDishM9hCvfL4Vshmm27xvHQaifChPrEl4kCMgkV74ppCJuqo7RzV7UST1ZXbLsjnnVIqCWkMpCgQhQL4osY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9273.eurprd04.prod.outlook.com (2603:10a6:10:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 18:07:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.049; Fri, 4 Aug 2023
 18:07:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v9 3/3] PCI: layerscape: Add power management support for ls1028a
Date:   Fri,  4 Aug 2023 14:06:37 -0400
Message-Id: <20230804180637.462573-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804180637.462573-1-Frank.Li@nxp.com>
References: <20230804180637.462573-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e20147d-0c39-4284-0fc2-08db9515a1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPmsOc9bvtRyPNmJEqPbsUDWySaugSMOdH67TYgZDpXR559qPPOpk+Tumx/aES2rqF0a5JDHePwpcwpl4/TO8tBjHObqOL5L7AvX9no+m5zzSoZO03JXRkmgeY7G2CTP8NAzEroE5Duu+aCxLC89Yb74uxX3zmeG7rGGv406tx9XQMuD1fyTJNHODTmFMULs8Um7m3r7CJ0kETCFlvnGs8lLIyv95rOjGBZNoVv7Ich250c6qmltWZkpNoek9616nhYcek5/VENbrOA/jvQGJcwvmi8Bh/fZPCA1U+YotEiQAd/bJxfRIPIfVgTJFxSz4v7QK/ySeDmrH5U7LCM5baV12sPPr7wmYCKpa/hZA85/gdTJsS71lP947CTzFNqQL+xUM4emxpHYGO2TF7PjmmSw/pOBOfYFd3qAtwH/AMPxkX1g4Ou3Vq/uJHuvcRqvnYUtfPZoC+mvBh+aXd5UZPttOcZjw1vzwUJNyGF0Q8Ohj7aOaGfBdOz8BN0DhJJzQ+eJEQxIlgE/Ejbu9ECmg36gSZpuSXDc8kbpBFqft/VcFgkYIChtr15e5ZpjRnS5vrhlnUwYoRM4Uo6N0rp3tCtQp3NEuY4ZOzzzsPb0MPTQnnAyxT9UhSgwkR6XRS5X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(1800799003)(186006)(83380400001)(1076003)(2616005)(26005)(6506007)(8676002)(316002)(2906002)(66556008)(5660300002)(66946007)(66476007)(4326008)(6916009)(7416002)(41300700001)(8936002)(6486002)(6512007)(6666004)(52116002)(478600001)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZdbM4yhrizV5oOS/XHkMOtVeqDKiKi2opvcHMHjJRjh2j1meYG9fbkpIOn/v?=
 =?us-ascii?Q?10JvW5eNpDEBhTZPQwUy02sgD2Pg6q6lO2SChG4VvB/Ttl2Ge92HE4kEBUwe?=
 =?us-ascii?Q?xflbGrWrtjGqYCopvFgESdPvmZMhf4eDAWalBzDlHw9mC5FmQlThGZhxqJ0w?=
 =?us-ascii?Q?4HEopxQmMD2s4BVdtS2LmS9F+fkwENkt34E5Og337WUvWUuw1rw9b9dBd5fO?=
 =?us-ascii?Q?67wLpN3uCzu53sHenzf6xJTos+WYwIaS3p8dJ9Lj8dfH151fzMVwZ5P3BH3a?=
 =?us-ascii?Q?L2gnwdWWeIktxej5k1hD6KlZt7lDcNtXl5I6/nKqCW8qNHWVtRmR/YtRRQdN?=
 =?us-ascii?Q?iwH2RA9s/IidYQvkf2ag9Oyl44HFUsc1a7s8xt8sShN2R147keGeTTlEq2Eq?=
 =?us-ascii?Q?dD3GqHHLMiY18rRRsLCVru9tvQcmcjKkI8UYW9O7oyTWpjqf47ZdnsZkRV1p?=
 =?us-ascii?Q?ZPShUkIaSz3RRAgNi8fyYUNgIqfEA+ofGz/j/PDYYuKhgb0NcNGjOLdMjBIJ?=
 =?us-ascii?Q?1jX+fumU3ousX9SOMGCAX6J45MSBGloEKb9syfWy0sDyYv2Da4JYF2ra+HOs?=
 =?us-ascii?Q?cgx/q2xSyau32BCD8AkqoMMKFqgRsE8I7Z0J6V1g0j52qD0tdLn2fE2UChWx?=
 =?us-ascii?Q?XhSUPM6fmN1mWrmvTEKPABxiJBcpSmtmcpPJHbKzWKp9K3LMcBvN23bNbcuo?=
 =?us-ascii?Q?9Y5jfich8+yLiUdVt5bCy22HR49xWepPJrqh62bAbNU0AWKV/a7sjnrqgftA?=
 =?us-ascii?Q?2rUbIXrj6F3Rn5BsLGvFczk5YNvYNd/7FjlFqwB/x6nwhEUIN21xVliUeNl7?=
 =?us-ascii?Q?SLpnpGonubYLxcLRxLrkHUb/YXevFsGgs9a0HBqQhY4n+AlIpEjZ0i30M+0I?=
 =?us-ascii?Q?jw6LMU9nrMsUg2t6cjSD6s1YLjkfs0nJL36sSCsGhziNxfbkJY/tspUVUjmg?=
 =?us-ascii?Q?rAmV2tWlgX5pnPick2uCu31yZYWe9HFyG3SGn1gBNeHdScHCvPi1surkOUFS?=
 =?us-ascii?Q?1ILVxRzZwEmAnZfCbm6SxXM9zc00nBElecISXecu7ikuVMhbD9hTGR4uvFbT?=
 =?us-ascii?Q?f0WJIYeJLGwKYa9l3/4s7iFb29zuz/TQljG1WetwcXkGz7jyWKNFypSfcqa/?=
 =?us-ascii?Q?VkvFMKtSHoTRmDpsW1r7Vht7SjbJAoXvcH/WimB/vaqedY85mT/K1MNP6LOy?=
 =?us-ascii?Q?MK308w0m1WxzhKqWQRzWqNn41WBcQppwlk0geYoUduVtuAxmvm4gwaC0fMvz?=
 =?us-ascii?Q?aQ7vootD9iz5qeMSnXWosfzvzjDWVc1lSvm+mc1kDhxVFzXquoIe732Iray5?=
 =?us-ascii?Q?pOvTCwr1qSadxi8Hbmocn9Uxm8RbG6o5LkoiY2Yu0j4By7pVR3kucSrHs4NS?=
 =?us-ascii?Q?6lXzuCE39PyE2YIfR7b/3u4G4FqH0ExBYE57NK15URUfUCCpZcbACK1Wx9ll?=
 =?us-ascii?Q?IPrGwxJC50NhAtt+zjgmXM5CQcL+75w785gmC9C1TiG3qkcR1kkQXvA6rSVY?=
 =?us-ascii?Q?7v8Q9uXdwySytrOpOC7O9aQKPiIVTQbwdVUxQNcj6602z40N2L/cTjEGoSfb?=
 =?us-ascii?Q?AhMHWRwOAa9SaiFytsM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e20147d-0c39-4284-0fc2-08db9515a1d5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 18:07:14.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2gl8C306F+rRNPObnGeQjiPoFtT29eE0pZXC/1YB2ASnm6XQgrshRF1K4kB5FaMKEkfqy7YyyMLTHpVd66UvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/pci/controller/dwc/pci-layerscape.c | 130 ++++++++++++++++++--
 1 file changed, 121 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index ed5fb492fe084..7586aece769b2 100644
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
@@ -20,6 +22,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 /* PEX Internal Configuration Registers */
@@ -27,12 +30,26 @@
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
@@ -73,6 +90,60 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
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
+				 val, !(val & PF_MCR_PTOMR),
+				 PCIE_PME_TO_L2_TIMEOUT_US/10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
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
+				 val, !(val & PF_MCR_EXL2S),
+				 PCIE_PME_TO_L2_TIMEOUT_US/10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret)
+		dev_err(pcie->pci->dev, "poll exit L2 state timeout\n");
+}
+
 static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -91,18 +162,28 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 
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
 
@@ -121,6 +202,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pcie->drvdata = of_device_get_match_data(dev);
+
 	pci->dev = dev;
 	pci->pp.ops = &ls_pcie_host_ops;
 
@@ -131,6 +214,10 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
+
+	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
+
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
@@ -139,12 +226,37 @@ static int ls_pcie_probe(struct platform_device *pdev)
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

