Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA7578306F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 20:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjHUSxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 14:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHUSxH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 14:53:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C059F541BF;
        Mon, 21 Aug 2023 11:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7Z/Eq53fbVVySZG0GrDkA3d8XYrSWRzXdgmAFck20CVlDaIDOxxucr9E4dv3x35cO/6h/MFEr6vSs9BoqcBUytUtO7A7WiMcO3XbybKH5iHG6Hup7MLZK5nqoefu4b32nXVYEEjBFZaSguhQvw1M06fcA0fV5Eb+cfX3yj4M390qklJUaUP+rIXeXmDBy2xBqalD6OdW6NchacET7x3ybQvtfthqwmy94/pbo/SQaiAJhbYvn8/2qyO6A4ACfklRvemXkN/4XGgF9Zkv2b/rYgibt5bAO/1r47Nm8ESww3Xx+XSz7v/tGV+pnG7B9979hcTVun/499dH+nlItkgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh4j8R2AsEoSCwxNgCfAY9dclfLuEv1xBwyGi7KvZdw=;
 b=hk6NrlKIAU+kkGELtHhQ63tw9VWSkT1jATTdrXiwnehpljkI/nOYZGAWseNouIFiq5uqliyiMH++32gpQVth9smW8/Ujdhnf/dZsNQIzoMY//BmcWUI11dZnVJ5KpHS7y8kpATeJEA60GTRk70z1qqtIOxoJC/2tFDd3O6QChtrLnsio7xZtUMEwh0UI/vT/E1fpnkKcrn4YJyHwwKFcjIHTgfji4btOu6Xcp5+65HikTiP0H/OXueE84v7NcpgsB+7Z6HnZrAsPzggnrBdb9cvY/NeUKMLWS1rtTxYOJTs+uaU3U+NT6QltcN1vgnKyxkZVDyAn1Srt50gXfo+2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh4j8R2AsEoSCwxNgCfAY9dclfLuEv1xBwyGi7KvZdw=;
 b=B8RbyYIDYSERIN7QapAGI2UkzDrNxpg4P3B5s2SRpOdHCe2/3rqHrvcej/T4yBHnrim9EpHIRYFj6WIvigG4IULId7rh/zSkfuxSPKQklpOjkP3iWU6TikdCCqUq19aJrKiUGSVnm4LylTXw7H3XcA0tseyTQmzIwmAOUHP6v8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 18:48:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 18:48:51 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v12 3/3] PCI: layerscape: Add power management support for ls1028a
Date:   Mon, 21 Aug 2023 14:48:15 -0400
Message-Id: <20230821184815.2167131-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821184815.2167131-1-Frank.Li@nxp.com>
References: <20230821184815.2167131-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d98819-f2e2-44c2-4880-08dba27742c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVL2yQYMAhy9WT8IuIj6rLUTm9vR2koZSAOk3D+c6Y0b7JhSBXc6nen1LTipcnyQXyDE+WiaidywvRGvpcJz6bfSv9JqRmamjDQWr8vADY/EdxJaYiRWLp3eWI410ZZib3PJg54c3XTqlWiO/piRVIONPW19pV7XsonIfXNIZTDBOJRxkch3RTteruf0ifXSrTYLpW7m6YrfugZEwciTNJQNWJnkwG7NbZwOof1lOVJXPuFfJb/z08W0D1jyfjrtmwO1ENiLCUtF4oPfcrSDKm9vgmx49I3h1kQUBuISBA6RZYyGCCAC0WTIxe+e9jqCqR4K+vaKfPObi6bl+iBjXfEo7CiXgBeDyYXKDBoxOj2EyxmKr3zWo3ekT6ERsUq4DBx2d9vveO3pgXrO+IK1Sw0ms/ORJPtKx+ItXFC1NEDVu9BGY6zW9Z2keaKRCYeNvjOD+0kKuDvH3mcmFO9Y1AZ5EVNe4SZbRKtk8LzVlcj69WK+KJs/b1FGxXK19s26jz6oELWFW6SnTh8aAl60SebtWW+7EgaO1J3IxR0+g67NLGyGEwBEhLA8546850Lkm6WD8+Nd2WXz1HF5538ePn7bN7YE6nUnTd6Cced/Jn4RawfIu58gODequJbmqaG0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66946007)(66556008)(37006003)(66476007)(34206002)(316002)(41300700001)(38100700002)(38350700002)(6486002)(26005)(6666004)(6512007)(52116002)(1076003)(8676002)(2906002)(5660300002)(7416002)(6506007)(4326008)(2616005)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qt8rD/7Foddj/EKSqKeKO8o4xWWrrI7TFvd/4RAVcSDuLtNuhpKiXiorfvIl?=
 =?us-ascii?Q?SE1Kebs7581bV6E+5STw02hGAJFsHl/39LEE3nfU8hDNmW7DeEZYQlXLsIzQ?=
 =?us-ascii?Q?IqUAiVzn7FbFgSTIzJllEnOBIhXDvz8pzmZNpg/M36k2h8DBroBJ8gpXdSBy?=
 =?us-ascii?Q?L/f0ypQDciAY1AaM5HYoVEMyoZmLkWFZ7zH+Hx9Bt/3u3I3yGYYV40JXRdWY?=
 =?us-ascii?Q?eHGm6Fjtq2GSippIWIp0uTtE3R/bLIwRdB1nS44mGY8TptUSF+uMMOjgD+YI?=
 =?us-ascii?Q?BfOBtYnyOC7urbRr/iHmICa4q1ONno7/skpX39laffwTiXIhR2Uflj7e9q3V?=
 =?us-ascii?Q?m91f0lBUExp+dPWD1jpbE6kxGZlpPFJdFXYFIJTbV1Sorh80fNftCy46+kqV?=
 =?us-ascii?Q?h78FpkL9tFrmGsVoWS2sSdVtKC5fmsGRbH0JkWnRwBKytyQ4moAxv6FRC+hb?=
 =?us-ascii?Q?TilHQ0uFYzE2umGABV3vbtGqEbXeRwxGpFkfwGMdxaPNXRSs1fSR4BEPIN9o?=
 =?us-ascii?Q?jbu90a0CoW+cB+gscZMGE2zhV3+FQspqpMifxvDLNVFL0FCFWQbswUB1+3x3?=
 =?us-ascii?Q?+s0/Kzq8LAeOptJR14E2VwdWi9Z+IemxL9nmJ/aqbSbo6FJuyd5nTaESeeN8?=
 =?us-ascii?Q?AOVwf2CZBFZW1ZvCrgc5wKt7eCRIf1HFocPFH8lOCPP+wNEsn59maFMqHiHp?=
 =?us-ascii?Q?7PXcdiO0sKlYTq1eYlMl6YyXM/XnW7t18u+b2NvtsG7Gwk0tMwv6c0WhA7Jn?=
 =?us-ascii?Q?safiDZUo9MN7FZ4hUaYwp+wKNRc2iSt1aH5D1/Sa7d8d6RysSVe/oJbDrYxy?=
 =?us-ascii?Q?c78k91erb6VULMPOEKCvLSL8tNKnpbZN/rn6in87+fzyYG3xU4L5LRWd62eL?=
 =?us-ascii?Q?Dd/jg/V4+5A5iPgZZ6p3mMVQR1tkKiDl4lj4GTRpMXNfNtRKrupOqekOv+Zf?=
 =?us-ascii?Q?SIesNmN71WVOcI5FREC63Ev514y6vQje0GsrLaX8qK3EXpXwpK837KRspQSJ?=
 =?us-ascii?Q?tEE9pLcmb9nLGt6rdEQ8k4zSNpbTteCrM6Ixey2tmu/FfAJ23x9IgpTdy4xd?=
 =?us-ascii?Q?a+c9XnFfzHaRNJxzTeadAcOw/rXzoLmDidbU2RNfwbEy2MeYLNZlUjW0ozIs?=
 =?us-ascii?Q?Nx7/98RVQHNQ2//9ZHR/zgMvFn8EyHNH3LL5sc3+eo6YxRMama6iKwrq3B33?=
 =?us-ascii?Q?MkUVy//BZnh/1mnPFUGkV8ZFGag6b5XyyKihtaYTPX3GkgTTpa5DWh9yrlFI?=
 =?us-ascii?Q?88NEe8qy1Cq6lS/QndrIBud5Oxs073U7GP97k/OWzttwTKE2b8wcOJPLGQ+M?=
 =?us-ascii?Q?rLktXLUV5UAPmDRg+lbsluoOeD6UZwSpM6I/5HWI90z3W1sFL3FSr0+ZxfdY?=
 =?us-ascii?Q?cY+i4+pL/7o/sXXYJrrakNL79T2MviUNnIoajFTX54EQQnVAzsc5DC9ZRMIJ?=
 =?us-ascii?Q?TwnvWTWayX0mm8+y7NfzOZsNr7EXjguDuFtd9YoI22rG4w+R2teLHQWtS98N?=
 =?us-ascii?Q?CClYqc6M/+cIBPK3vvl2VKc0E1eREbPcUxzxeUSs0jXGZ12gGve170fnNDEl?=
 =?us-ascii?Q?JZX/KLydDM/HfCJm1sC+8N3TullhV4lSvIrY+eDn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d98819-f2e2-44c2-4880-08dba27742c9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 18:48:51.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2FRSy9K/BJF3U7gHx7Mbc+k8VJFfk6O7d3IhuGVbNwxfsl6wU9VB1Tqqm4xC3DDj3wtqoLFwNH8X1qOhsbDGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 135 ++++++++++++++++++--
 1 file changed, 126 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index ed5fb492fe08..97b8d3329df7 100644
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
@@ -73,6 +90,64 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
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
+		dev_err(pcie->pci->dev, "PME_Turn_off timeout\n");
+}
+
+static void ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct ls_pcie *pcie = to_ls_pcie(pci);
+	u32 val;
+	int ret;
+
+	/*
+	 * Set PF_MCR_EXL2S bit in LS_PCIE_PF_MCR register for the link
+	 * to exit L2 state.
+	 */
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_EXL2S;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_EXL2S),
+				 1000,
+				 10000);
+	if (ret)
+		dev_err(pcie->pci->dev, "L2 exit timeout\n");
+}
+
 static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -91,18 +166,27 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
+	.pme_turn_off = ls_pcie_send_turnoff_msg,
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
 
@@ -121,6 +205,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pcie->drvdata = of_device_get_match_data(dev);
+
 	pci->dev = dev;
 	pci->pp.ops = &ls_pcie_host_ops;
 
@@ -131,6 +217,10 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
+
+	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
+
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
@@ -139,12 +229,39 @@ static int ls_pcie_probe(struct platform_device *pdev)
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
+	ls_pcie_exit_from_l2(&pcie->pci->pp);
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

