Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3601875B95D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 23:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGTVJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 17:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjGTVJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 17:09:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C34A271D;
        Thu, 20 Jul 2023 14:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llKwQjRMFM3DJpOnE2iPK84NtVclTPXkQkbrc4KT4Kn8yL/L3BH/51yZPiUQlr2nvpzWhULrFArR1UUNpXTmAHaTiXwInxQDDusj53uZZT/Jx2jAF2A/JkbsOpBbDffxNH1Pvb3JiXR5U9O47FGoHo0pda21H9VWKOSquTLBRtSRUtMW84+kWr2L1N3vw/V/dhOsgZD+rh29ZSz/HtJ+tXEK1ibRb8J3YbfwASFTu1w/X8kd/1DPpIhYC7ynJzdEbru+ILSXt+kvW6PvKOWSihlBjvAYTA+UJ6dorlLCCVMkwZJl8R+M39kIDVcktplJsUKx2z+I1mPdQ08LLeSxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uthF2w5R0NQ4CXWx69tOD6VjTW8sR/IU5IXc7JQA7z8=;
 b=PRdzsVs/ZMfIPgtIq9+wguRO/FCUxUiKXNedS8x4KG9N6rUik5u7Zm7uES/L3TlVTEqcL05gL5za7alaR+q/wGKu48fR3fyBRczCRRY3rpwaH9cXSArgIuj6uOB7GYFn3zw5I0x8TimV361LMxJ3btrfmtU6NOHAgX9d630ym+A64jYD0WgOEu+1xfddx4QlVJuDwcF+/zxlp7GnG6KsqtwLULbz3DyVPQZ+hk2Tne2XRoX3d1ANhyeYlvd3MeafsBUL7QRh6cXHbnVVqqg423nzumC2vQY9DsirwypdoIFEQQVHEWU1FX06vS1JxZFWy9phtL1NUR2OqUJ33Qm2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uthF2w5R0NQ4CXWx69tOD6VjTW8sR/IU5IXc7JQA7z8=;
 b=WiivIiv18LybhpoXNvnufex2S4Y+lRL6ElhOdiiS/jBlYB3mO5g8WmRrX3mEPwK1CIy6OfDGzsuWHBi7BOMMSLuRCOBeRSsd8I1zJGfVvesr1QP0BPRfcFUgZ6+/UXksUWwIQ1UgKUGzTkeHb8uI+Zrw+NxpclvckO+Ujq5GWiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 21:09:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 21:09:43 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, manivannan.sadhasivam@linaro.org,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v4 2/2] PCI: layerscape: Add power management support for ls1028a
Date:   Thu, 20 Jul 2023 17:09:14 -0400
Message-Id: <20230720210914.2030897-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720210914.2030897-1-Frank.Li@nxp.com>
References: <20230720210914.2030897-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 409eb9a5-8597-4232-cdf5-08db8965a3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WCeyal0Zqkm0yRNDYOvGwQwJ0tJl09IFuSTXaIXN7IdhtUjOcS3/JILJsZ67QK7p+y4+KtNEFv0Vn4NYBs/6RNk96jwR63Har+KUpBE6nOpd3Tz1DMSFV4kNvK0QQp0tpOJLlXHuSI33+yextc0C7U10PPJ4kIAEwbp2es3uxetjxADv441rplw6ctlGyy3BbPyU5nihljwG/pY4hf0nOtwMrCHJuVABGih0hgNdDlPxDeQlPYft56Vxg1/RNMbRuUJnP5cllr4QTqHrYGdpQHriOnetDQS1VyGVoty7uvPOw5RCmN2jvrtV82tcWqlhgqFicoOPYWcEtX/GgvKADLYBxvtSx6463fH+ZeO8uc7zF1hLjjq/zxKQd4KF92NGT69Y+Aimgpy3ofifHWpKwT+84ql+0aUMPTtm9DtKNh7Ba1zrOkYc1VB3wGEIb6ltILR2JMZY/r7Yk3wqXsZEJYP2twWrol0sBrl++yU50r7hb25Hs81N2LhP8akpr58P5kvAKTyb5SHud4Eya8YZWVF4ZrImrHvAOfhuYmo33oE6aRjV0bbhQ9d2D+jJDDxy2pPNMS5w+6cGBiRjh4cGVc2LG53kMYjnyzGegl/HqZqpyKpCP6UoK1JB/hVF4RM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(66946007)(6512007)(66556008)(6666004)(66476007)(6486002)(2906002)(6916009)(8676002)(7416002)(316002)(8936002)(4326008)(36756003)(38350700002)(5660300002)(6506007)(52116002)(2616005)(38100700002)(186003)(1076003)(26005)(41300700001)(83380400001)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kw6TZ0vSCUokEFsBMYPY3ncXiCZTgtzV2eFKYGeSIrCROR1DfT3rOve/Iq/0?=
 =?us-ascii?Q?glFfczntmdRCmYLVPw76AOmko8gg7F7WuDDwUgYf8F4HhQHyMhAE7QqlKjmj?=
 =?us-ascii?Q?YEidLVinxmkMQN7AY+nTQV/g//DyjIbzuLN8HctN5gJBKdsZuJMR2subhA8m?=
 =?us-ascii?Q?gTK2+EE31Xfan76tp4Gsho1wbWleq/zr6Fg+UTmTL4F8UwUNfKu41czkphL0?=
 =?us-ascii?Q?j3+jNqrLFleIvmGHEQekpse1JCjSVATJoRftWbEk2xN9VLkvUG7/0IZAVRfs?=
 =?us-ascii?Q?ZC7fYMkSUR0ukmOyLxM57xdLajExBFtsnbaig7xO2pZ1eWySBp3Mc9DIZVCP?=
 =?us-ascii?Q?flstY1/qcLR1/ETIjSI51f9/nvelhNkgfCVfhc7tELLphLx+eAwnpOnq/osJ?=
 =?us-ascii?Q?cBm5sya9r+qt5TJTcRdZaQ9iLwV/WMFrIJycFC1wLIo7rI5kl1uW46TV0Ne4?=
 =?us-ascii?Q?1iYksPCMIeUkuX0b7uwWIDrOg/4Z/9inV9xqgkNJGw4IHwZy//tkLkb82WI+?=
 =?us-ascii?Q?GqODXnMfwshopr03dNjIuqiF9cGwMvVH+oBFdbNKyUWkM4ySOf2Liz725aFN?=
 =?us-ascii?Q?3cj0E3lJXvGL2yGEw4XZdqoE+DiRGY7833jGHzJDWOKMSmXmO5dC/xH+V5cS?=
 =?us-ascii?Q?KpP6UhMh6aX2Fc3dmdILNFDZxJk6Fg3Q1glyIZNCySwYBS6/IJpxkXjwrXdH?=
 =?us-ascii?Q?SBXj4Z7xq2lC8mL+ltcZCahoyXrGUVr7yoOEaepVTv+iUEXblg65hCYnD1PM?=
 =?us-ascii?Q?4VeYs0lCiN1skDseqjLNw+w0sOO5VKemMWoOW5xfeXbPyFuCmQs7Kg+DiMud?=
 =?us-ascii?Q?3Bdsmb6VE2ZKE8dD0EMmRu5dZ1pao/tOvUJxSNs6aWT1aOVTrhCDOlV1IMiZ?=
 =?us-ascii?Q?p6wWmyv8eYDVINNGRu8MWZcuPUFvz8FEm27VLyYxJ1StJfYzsvOPfubVu4qz?=
 =?us-ascii?Q?M9FoDhKJ79sYwkbM22W0/rX+z4W2J12nmqeV3evkH6BUscY4udaIrULYcFEf?=
 =?us-ascii?Q?6Bs4LIvzDUMPQLW/HQcFJhtcChfgegzE9pK/AKmY253lf4KlL/jPBWu1/a1b?=
 =?us-ascii?Q?nnkMPZAwSsojnK+B6EnN+Mma16pqbo4EdsXsXV4jxFy9ZwHHc5VFX4owfPyO?=
 =?us-ascii?Q?ikeShizg2BUXjiSW28P3poxCkVyFKzA8iwncDLP+kHHTEFp5wJqKwDe3G4Lu?=
 =?us-ascii?Q?cI1Gmcg8vfWLLKNO1vA8vBDt9LLb7kSzdT5KTp9duIRaQpJz0SPWA2ElJn6/?=
 =?us-ascii?Q?Ef89dlCn8IF3uI2pIb2zK+YlMT47XRObQk86rkGNTS1i8BkQPVI9uNJUdO3a?=
 =?us-ascii?Q?H4Nag47o3vM1NJYJmJpPxLz5WlvXooUbQICjujOYbMjeLXuiSUMXa9r2j6eG?=
 =?us-ascii?Q?Ckdc5Tjl+I43N23NW+fDGyua7m38B4R85vBN9D6X/x3XlvxkzN0XlQA0FHzz?=
 =?us-ascii?Q?EX7mNM9kpWa0It5DhQKv20Qek6D4spuMZPJnYZYmWMoKX5vsTZtM+SqLKcTW?=
 =?us-ascii?Q?zpvUtipu4SJpZd2j3gCFmKm5kHtsa8pb2ieyeNtanEp6eatDRLLB5dtOM2jl?=
 =?us-ascii?Q?tfoXlaEVrSHqFHcTKpKQHfztJzT1DzvEMK653uk7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409eb9a5-8597-4232-cdf5-08db8965a3c6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 21:09:43.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+e7396rNB72wH4lpQhgADofnokoZT1urIqaFSOU3B4VKa6Ce4NlUSOxpfnOpNEZC1FlRQxrOUGymY5w9lP5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9417
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
- Change from v3 to v4
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

