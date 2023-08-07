Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9AE772B90
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 18:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjHGQxl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHGQxk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 12:53:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30710DC;
        Mon,  7 Aug 2023 09:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF/mu/qe8zrO8dYJab6q6yLaqeM/8JdD5LYoB4pPEqPvFRK0p1PPpPD0Ai8U9GZceKf2lugURobD4qwVT+ix2mdZ3BbRpMLSsMvdLGK9rwbJS9eXNAWUqPgtASxv2YaED9lBVH0JLl6YgRTxVGNB7VpsQnzb7ZGA1Kw2tq0qNR+nfTfHKU1zQPjgJ/vBuP6pgXhqxtxPrTFodrBTnfgw9e3AwGEhT6wdqY7MoPZ1mXsfOSzcNAO8iS2MhyS9Rl/58AkoX89k/q9y42m8Uz5LJDOwjJ0Djodc2TvtRyQQ4DJ5fpTdcww/q3Y9KQtLtEa1PDc8ncYXJoTK93/TuAemww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cemv0o+A4B4UVs6IecKdz+P02Zgm4E8Y/XAvJfrdSkY=;
 b=BXOzEDC/X08AtGjjGZFDFisD63PanY6o30BlzitttXGt16L2KfbLRO//iCBbxzeHXqLT87wzHj+N0+8CMlU2uM7UDohROUB/09dZMpE21PfmTpilecvqlX6nx2i4jZ2suWd0xSPWhsacktm/TPP+XZ6nk+CeNDXLvyLULe7Hc3Jf8kGHaZk33KZv2kXt2bcjL6xGX4Gv3qn/TttZUwUCQ4AvBk8FIUtX4iq+YAbA+TKDOEi3EX/3Flt1nP8QzcxVQHP/HEONGRMwJxKkjbrXAHkAgpCQCUPIciVoKodfHm5BY+kbTva8dXfu0/cQPnqcYwrKNtbldr43UXbx+NfN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cemv0o+A4B4UVs6IecKdz+P02Zgm4E8Y/XAvJfrdSkY=;
 b=Hffa5q+iHh2OWWWflBehs03zPcgBO+Iwd0etP8/6QaIGdh2ULLDS5L2USWOW9KjIZklVJrjvhOySv2eljvtCzWeR0btT6oiKtSyMBn6xWma2ZCpS3ZOediarm2Sc7j/sFotL6Z7Y2uOWvmMgQNatUwA9FNb8U8IbbDQCE5UYmcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 16:53:20 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:53:20 +0000
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
Subject: [PATCH v10 resent 3/3] PCI: layerscape: Add power management support for ls1028a
Date:   Mon,  7 Aug 2023 12:52:38 -0400
Message-Id: <20230807165238.569297-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807165238.569297-1-Frank.Li@nxp.com>
References: <20230807165238.569297-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b26cf6-2fb2-42bf-406b-08db9766cb89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mt32X455/BmZ20SL5kXiUrgvVLt4uL77e1CpCgvQ9ibkcbGEDx+GRCguMmQBFqsN8SwBVeTaUPaAY7NTeIJ+6qTi45lc+UwdM3286dXX2W+x1T1Pp5/mjTsU0hd0i8M4eVj6cCeCrW6XkFg12dKnMVPCRsJrgzOpFFA8GU9sJ5g+vWZEJEJPjpEpuvI/vh39lVETtXdwUCVpM6I7z9mPSMYHe2fRPLkNbGfqAliio8gUXlPK7j3UAkVRXxBgeOEEBkfWI5hRfNanTdCCOz57dv570p584TVkU27jDlEwKjq2mhnpQEVDln0IRoMlNEne8psbinV1YCXKv6erHWaSfRiP1BOmb8kYl2J2suIl4KE5cnA6gP0dB28iBk5M255Z/BPF3WR+VDuCzHOoCg3ev1QMMT6Z+MRzcPdCz+PSy51xYxd7WGTVxuiLJXZFZLrvBHA3kXSGk8AhZVv45BoFjhbnyX1n0zeKiNRPL0mfwSgYTV7Ixudg3bfXqSuSiXjjlXp4hnO09CgM7llrZtyU0hs5zqhazugajDnYdf98jumSo6YXd2SmoLTO4aYfMguHFcMR6H4sN0U/IROK2lnau9cOcOoJbG+UrGxKTU5Twn914C4qptvmC65vxKpv+jUC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(6916009)(86362001)(478600001)(38350700002)(38100700002)(52116002)(6666004)(66946007)(6486002)(66556008)(66476007)(6506007)(41300700001)(1076003)(26005)(8676002)(8936002)(2906002)(83380400001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1xb4FY5j72g4E1UMCfJhzo9mi65o4RFzZoHyhfE7xa/toNLVfb4f+7zJdQo6?=
 =?us-ascii?Q?S/WonHOOb38J1wq8Vctyw8lNn5pSN/FCY/FWMlvlYx77bY1pjeLs1nclW66f?=
 =?us-ascii?Q?3aBS/QgqhPgyAJHTe1nIC2bSTXbXmCGYFwgGXW/GT6TD0Im1YkgRvVwf0+d2?=
 =?us-ascii?Q?oO0Fqjwx0OrS3QG9sVaXKHKTRUes1EyHiDtkcSJ+tQiFT2z7k8cK80oNr5BQ?=
 =?us-ascii?Q?0/ltlvazgFflvGOPeQ92RWVQYHjQuh+En6wxEAz3ky9s9g+0XCzryWiqyYjk?=
 =?us-ascii?Q?xr1QkoFSsov5t+Q0kH5WjWWYAYEZzOHl8XjU05Sxg+ELEWx7lRCpTAKJ/efu?=
 =?us-ascii?Q?MF3JS2spKc25hi2HthwVjLYuytBAeWA3dTlfqxzLWyCsnOGU+aKzebjwG6yJ?=
 =?us-ascii?Q?XdM+/vrAmuTwBY6IADrFETQ49hb/cuuewhsfmo8FVbQfWaSO1YIlG6cxIWe7?=
 =?us-ascii?Q?eyz4HITHtHEGmHu66n3lDV+A0aLIz254NxK4YuuEsMQK+fLDnw1AJR9X3U+K?=
 =?us-ascii?Q?rhRP41Jd0mJTB32JoZdr8+VeFQ1eFMDk672EdrjMQxRXgm4Uke3wgEVd8WSu?=
 =?us-ascii?Q?4xFIZtIz5pUMvSlIDPUUS3hzUW4zw5/j0rpk7ysFSvCfmP0/Ve/RhqGs6M4B?=
 =?us-ascii?Q?4C6bKGJyQeZ5e69zmqncNQ4R3SCTONS+DoGvQ2JJ5o4qqsnK+dr63NNSuLmP?=
 =?us-ascii?Q?+rGdjw0C9+vhfDAIsvHnJhrd1D7E7us/0e9zrSXvrGtxMJUc4J1IOQpl79pI?=
 =?us-ascii?Q?BZA2mW/56lcJphabdMuecjFP+hWApB6ikPKoym9DJCVhIvw5q2vY6CXrvUZy?=
 =?us-ascii?Q?v/OGptNYGgBeUZHEECbroVPBxO4gqZhn1j3ADeTkfYsXuapiQuveURFNutup?=
 =?us-ascii?Q?357LIUJgnoq0txNVF0QpHX04sB4OPXusRt6XAqd+fe2eXBBmmqok+0tcx0ZX?=
 =?us-ascii?Q?el9RlRv+EclEB+6b7SzWLPYKn9wtSJ1s9YegbeRKcWGRMFL1OgN3NXQ2S7jd?=
 =?us-ascii?Q?WSrIFzYoaEbFg7sQAHH6hGPKCCh5u9J35oDEqRoOvqKxaY9ypFFxs6mG/doO?=
 =?us-ascii?Q?hcQImRIqbhVe0E/TMDQlv092P8SUgp5mIjpJPv9+B+JSjO08PlU0tAaSBG5L?=
 =?us-ascii?Q?Hb9pnvNBE/YKMTcL532OjdzQq4esLb75lHODkdW26ULif5HfaQ/SU4PjF3kw?=
 =?us-ascii?Q?mMJGzlesU5ak7wb92U8vqvsV3Xk1N0vhlLZvaDzRmLzY9mF5UKiRvfZF1c00?=
 =?us-ascii?Q?qUd3OkeWwNIdrf46Vn0YChD944Icc+sssmSeMgX/rVC7vF4Eg9Cl+M8NPjpp?=
 =?us-ascii?Q?kPEElu3jJrezADKSlO3sQGDeQ7SAZI3249BHCCYodQzHdN6qtDNmkmX4krkR?=
 =?us-ascii?Q?fh1qbJ7OVGWokkWWCaRCpYZzcFdwBEYn+TAS9kx6P6PZApG6FO0pOHAqdeg8?=
 =?us-ascii?Q?hljM10SSSpLdIxVH774nQ35ZdOhPC14OHpD0GQYPm84ceeG2d2wRBGd7FW9Y?=
 =?us-ascii?Q?QyegtFlVvsks1fTqvCPPhuIIdv3Gyh5/Y8/QwUoUSZPdutqKBIUh0amdqYqV?=
 =?us-ascii?Q?+vplvDHWbk9e6nCJlykatGhm/tQ4bCxz/PAaEwFT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b26cf6-2fb2-42bf-406b-08db9766cb89
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:53:16.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nB5tuuYPGj40ADKuOYngV2xeRLskmvVDXWsmvPRL9kqFduJK5mOeg8fJnoLGVRupyRj5vzL6FbF/L8zPUsTxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
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

