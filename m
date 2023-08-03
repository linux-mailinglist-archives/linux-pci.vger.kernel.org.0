Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3776ED8D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 17:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbjHCPFE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbjHCPE4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 11:04:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B299530E5;
        Thu,  3 Aug 2023 08:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEj8Htzz/qpTBdl688IMTNodnfyjv02xQrJo/x1kfAvYg7FfFe87yP/JL1o1uTtRPP+QTq6Fbz3lI3btq4Yy5WOQOxg9yDvPvE6tthUnxYBsMS/lFQR+Ip+RoFNocWkcq9QrRj2A1oh3JSub+VCpNb0c3VQH5tSg9yOWzO8XnONBbX6FhPnw+sE14SRlyiPWbLLyqKB0lkD0VCay1emi58fp1ysMdBUbKk5Hj1lkzaNcegY1WS0uKeogvkIr0UB7+H6ZMEj0WmW6MVNqwjQWhq5hokNAJ5zFSy4Vtlxu3IWR1uVph7Pu+PIXVtcppDCA8ahJc+QjyRMY0P/xyzrEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eVQ/gUKsRrgSYNWJMpMkCNkyHPHy17Uk/S/LIMiuL8=;
 b=QFsoTsuJ/6VceHTjMj8RIKzr3kXnBrKdv0aV02z9ngB12UypUWYi92lvIgljPEUlSk/VI8QwiUJtLJYfeg7KHXqtivrC7cEDL60fi33dVR3wJJ/2ZZ66VGr8svzqgf7vlE3PIbnwzQosXVBKUK7CxNl1MObk2z0reIVeQvOWrtgIX0zVe0dAfNMokxd2urvW73dwiU7QbeHyp0Z4DM8JQ3RxK3GgtzIq19QzRI4osjkxnXDhmnOzcEEDqZvCZzXUWVw8QaY9vpXBT0y1m2Pm5Qum4og/TCmocjh543NgmprU3143AZEGE7RiG4jgTW+4m8locwcQarG+dCLQnu93QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eVQ/gUKsRrgSYNWJMpMkCNkyHPHy17Uk/S/LIMiuL8=;
 b=M97cgWuK15nOtfZQQu19uP5FqGmMi92BPPnHxrq/x5ldYJBdq0Dv7YYr8asyW9SE1Ofv2c+BSAJiqVkNND3WnEq6NC8p60KJpuqTjOQN4jBVi51ej1SOYmFdkub1OV1H4UC+OXByx309s8rIZ1SbW+immFqRKFkm5AfWCafcQTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9769.eurprd04.prod.outlook.com (2603:10a6:20b:679::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 15:04:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:04:47 +0000
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
Subject: [PATCH v8 3/3] PCI: layerscape: Add power management support for ls1028a
Date:   Thu,  3 Aug 2023 11:04:09 -0400
Message-Id: <20230803150409.271155-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803150409.271155-1-Frank.Li@nxp.com>
References: <20230803150409.271155-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4d0a8d-0158-47b6-7da2-08db9432fa91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bs48QJOjpnEX15wvJsV5XgEtKlUIRjzz8Sp5XNw9KPNM0VNUP8ouP+cEjHX8o61VzEqXJD9s2Y0keFU3Zs22gop5W8JXbWnWi8y252zdqe2zsqgXLgdCZBbn16aQtOs8WpEeQy+olI3FMeFLXjaPkP/9wzyIJ7kjgRQzgborpxIpTrodhS3y4hPE6xSCOpmcW02+mtY6xKSvW1p5f/papqTbOBnvmViWHUBzBCsudjqsDqLM2T9VJ5YBpo3EGCKuEf9s1NNGCQqGyYAPzSEKpfM3ZrYP29Hjgd94FRlbKpN3XNoDxWmUg1LWTnDG4liq5y/3KUUxAgBVOx3pLcn78DEqw5omhIsCtU6yhlH7twP93kkcS9qivqbMpe5RsXxiuwKDFVW2j1AK1R7akHWVPM/2B7Y3/OtSL1u5XgwENfDtsTwDjjp6uXZHblCuDHFEtRNb5dcC51mOg9BP6d+MVkNPl91/dlFfHXsnM5doaB3xOcMw+81KljJ1vP53vOm0XSN5x4mi4LjTyuhdSLLv5ckWrTiHgcdrA/XnrL0cezME5LWKtw0RAc/F8ASidCzHCJKwTRfQ5FN95LNewIddh50r9ASs693bm7mV8G9oRIcttZ62KFmv+JYH3Tt3VwNp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(52116002)(1076003)(2616005)(83380400001)(6506007)(41300700001)(26005)(186003)(8676002)(8936002)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(316002)(66476007)(7416002)(6666004)(6486002)(6512007)(478600001)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VH+3LX4quCodzjqHBgjSpfcMLON/aHAxj1pSW6fnFfyFyAg7WCtCIriE/WG2?=
 =?us-ascii?Q?NmvX7vSbpI1HRM6FHqigUCLx2hzk3Cq/v8EkKv3CNZbKy4NzA+oPj2owk80t?=
 =?us-ascii?Q?GQEXLQ4Vk6WZnsZmxCxeOedSXJHkX2JJk0CgnY2BdCHOoD3MLmXQUpvHrN+w?=
 =?us-ascii?Q?ayXIPfuoZjGnxRff9BTdFgz9tR1tOxRDzpvgt+2OEmXpAQh2VmqDxnDwjqAp?=
 =?us-ascii?Q?ugot+JPjhpNIO5gQzJWSeoo5M/KHa+VjKzuJQ4Jf8u2xNKerG8P6M073o+mJ?=
 =?us-ascii?Q?7KPZutbl8wKJJkjIAgwP5qBd7ukw7IinAiMz+xx/XWT3076Qf/EFuBAWJRpl?=
 =?us-ascii?Q?k4XdQaJuUQ5210sjbCqGW31oug3uNwEHEEa0AdKbsws2zsLTyS3UxhvkgfRg?=
 =?us-ascii?Q?R0598lctX1XUT/DBITju3LjC8kcgdRtEtBvoKRhkVhkOD2E6+dGEWwqU4r9Q?=
 =?us-ascii?Q?+YYUrQu86uCcmSXL+Z0MPStEWcZ5WQS6EMy9j/RqCmDwPgmJ0APRUupStAk1?=
 =?us-ascii?Q?GEri0S6kZN7aPHmSjhJcVaGCNjE4oxiVnqT7jTFss5LvrOm6KPIsAGXEBeK9?=
 =?us-ascii?Q?vBeEKf7NnMnCpp1kzjqxN4NXgO1iYye+0wC3khbrElXj23uSXR4K3R31LaCv?=
 =?us-ascii?Q?asCP+FqxFJ5aHC5ouOnqVST6y9ZttyHj+AbHbi7/mzTGno6PxDqDOOavhNh3?=
 =?us-ascii?Q?irzjoOd8Y2vrURcG6QQ2478WGOEiLEnm4G6AxXJniTQ/Yi0I/x29BhvmNvnO?=
 =?us-ascii?Q?YO4/CiesRr+qiOGNzklUNLqK+cHNT8A9XEacafhlORSRqXHq0JHpMmGoScGI?=
 =?us-ascii?Q?iwK3nlPlqoonBmiAevWxmpsO3P5Txk+greGIOUQtZcYb0FvB3kA3WJr2cEqs?=
 =?us-ascii?Q?svBUUPQ7CIN7p5mQ+Y3WJTYPFJtKFupjp6ed6lSkeDm+7J2sguz1O9IwiRVX?=
 =?us-ascii?Q?ERlp0rox4/MvB2WCi6/6W4eUDDxUs7ZVMosu4kLqE9xoYCcbolvWc/+632vI?=
 =?us-ascii?Q?cqDb/NvooVGpcKbDKEdFtNtxXqCCkVL4MyqAamG/FA4DCNxvPa+IBjTGs7eL?=
 =?us-ascii?Q?kk4C49nzmiHrSyLWZYRx334xUkaSFkRO4A7R5QLkSiSQKeiLPtCFcmdi4uf8?=
 =?us-ascii?Q?L9iw28x01HH3TpOwuMZ+bAqWlCn2M2oniqQ2qe+cf8fmp1qlkzgQRYNilmK2?=
 =?us-ascii?Q?j3OBnJz9VEryUqjYF9dHYclYitQKKXQDR0HcybKMqZm9kfMDYnXJenttsP46?=
 =?us-ascii?Q?MPJUZXqluAUFIy/rm7zt90OjqL2OjpoJXtF4wgmSgHZt4msxiAQb9VFp9z/V?=
 =?us-ascii?Q?ZUT1falxVeJW3sudOVJAXEYFjpDWjhB253YE/8XyFmcO4syDkuL9y/OcshYy?=
 =?us-ascii?Q?h/NGaRTmYnOdEH0WgWGiSdwD/FRQplgeBY6iRrK5tfs4C9P+gudizbvCUz9m?=
 =?us-ascii?Q?NIJQpSDVg5bLwJHwbO6IpHwMe7E9EhoXFckBzIVbNzZf6tyy0TWTn2Hj0DnZ?=
 =?us-ascii?Q?EjMbW1wMHSMXiJM9jrPJoGiiq4YyPaw6tCcucWxzGNO0/RS/Dq6b2uUPxqXw?=
 =?us-ascii?Q?AtPzbdCldBNT9n1TRgg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4d0a8d-0158-47b6-7da2-08db9432fa91
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:04:47.8705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zqq+Epwv2JyuprPU539jO56BMYSfQyTamLn7MXNeJKlrDcYmKiS+x2LcFByOZrqHninSj2mgN6Mty0DTQK8Nrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9769
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

Add PME_Turn_off/PME_TO_Ack handshake sequence for ls1028a platform. Call
common dwc dw_pcie_suspend(resume)_noirq() function when system enter/exit
suspend state.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 129 ++++++++++++++++++--
 1 file changed, 120 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index ed5fb492fe084..531b2680fa9d2 100644
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
@@ -73,6 +89,60 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
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
@@ -91,18 +161,28 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 
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
 
@@ -121,6 +201,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pcie->drvdata = of_device_get_match_data(dev);
+
 	pci->dev = dev;
 	pci->pp.ops = &ls_pcie_host_ops;
 
@@ -131,6 +213,10 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
+
+	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
+
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
@@ -139,12 +225,37 @@ static int ls_pcie_probe(struct platform_device *pdev)
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

