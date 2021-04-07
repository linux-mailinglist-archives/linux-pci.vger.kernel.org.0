Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA13561A4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 05:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348196AbhDGDDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 23:03:50 -0400
Received: from mail-db8eur05on2051.outbound.protection.outlook.com ([40.107.20.51]:53742
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344228AbhDGDDs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 23:03:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cy0pOKh05fT2UcEg3vS7QbdouYe2TWUZPznsjiq55wNWmK/Y2OaIGEaDCL0gcHZiZYKbQBTcZMxKraYGQVFkDsM49+lHUWgmlPbDRHOf/vkvCCYUBsAiaK17YwGOfmCfejI57+eASwrvarcf40OQFfcRqGv8eAi0v3/Qk11oU34Xrx1kRzWO3SP8Dde7oiL3pGmCha0j58YucumCJIvnkqdmkpi1JhSMVwkyHQhWHtHnO+b5TxwJtiIbg2Cajeft26w3xWcr+A9v/g1tn7YxQWL7FxDG2KMPyEQCz3JC0lNwTn/KbVXPKp1wxg94mE9QJYq5JVgqVO//UilUO78sGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd4LBIl497Z/8EhxUuh8fAaPBU3gOEtpyREcVhDxmmY=;
 b=DEqKE28lCmvR98I+Ad/nNxCrueLkhgSF3P5bcEvZcHjbLrul11AiUF1FiANbRuTSe7qW/Atdbt1VaAAexqhogM2Qt8p8BFmCnvAo9yFHJ/+RGCoAxc/YaZvMecC4h+U0s0wUjdRMx7bb7OrAR+hRi/7ksRU7/cXIkc4pdNXOhT3ppRhH+GjySyx0F/W9ChjAm2YEo+sRWt1G/u4OUUFwXktcd+0cfTz82zIjn8y8xh5gqTUPoPXHd5+eTZnjCwZn5eQUFlr3j8KUc2FQ+j68AUhBlrhrY5UkwA0AKyo2kh4byJMM0vZdQSoGs+2TjNqPkxCYOaDQJjNGa1K6dM6trA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd4LBIl497Z/8EhxUuh8fAaPBU3gOEtpyREcVhDxmmY=;
 b=V6lsuq2ocfjLZXOybpIIvDkvA/gtmb0nYJ4qBmEjqCk8rPFn7hzawooVA04GgeDXs3tLyKq7+xP6nRlmbkz88R6DNhiWjLySLgEggu3VnXLlaPFjdJ94gsHgyKv9hrMN5f/LGoD9+VP9PdN2zKz7lJFn2wCpUeiwfEwnfPyOQrY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3276.eurprd04.prod.outlook.com (2603:10a6:7:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 03:03:38 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 03:03:38 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 1/6] PCI: layerscape: Change to use the DWC common link-up check function
Date:   Wed,  7 Apr 2021 11:09:43 +0800
Message-Id: <20210407030948.3845-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
References: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 03:03:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6b546b9-020c-4f4c-c4ea-08d8f971bd51
X-MS-TrafficTypeDiagnostic: HE1PR04MB3276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR04MB3276A5BEEBCDBBACA870228B84759@HE1PR04MB3276.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAKkz7thBEWYnG0HW1m/EOIE7hmDfIOzw7uKbh+M/P0jhZThZFgryTCJg1Fuy0T68rtV5qPoo6Fm0xJ4N/9tT+sAf7SWkGUFOmL5QvVQVE4lg0mDDitdbhl5LFSv3x1Ucl7HSPUF9uQsxqqWo1wV3V8gPYwP1b1b1BTwoh8vNeV/Lhsja18iwxdqWUm1EADMCGhlj1/Fqk0TewOo3EVL3psIgI9hfTgCbrNGDSle6XgbTr1Uoc1lhZqox92fkwQmrKyTm1KGVTbQYxs0jCbcwULL3dEvpsp+fQlIY7fM/dU0KBUsabh39Nd2piFC8zmBSybODmeFNTzue2WJI/ly+gOth0qrwv95lFcBX6yBu6K1YmzfiG2yqaVPeXjSpzuVoiLRsDnSKA53n2DCShbD+xITEZP1sgQ9J31Jp4t+ycxUNFS+K/pIfYydL0um/h4PdcWBvCYeVb1oh7BaH7ejP3OrNdFEmQvwSW21UFr9u7hYGTrpLhIIBIdnpUuOg3JecQ6ufr6fJV92X5PjZdEgrgxy7NlkaOxjQ16/TwUTa5CM7/Jl+gjWivEQgEndZ4kh+eQbECbWhy3+0sCIM4j5CxusOApcSyzoT/q4VdXQ7iGgioID2Y0OgXe0upDZdy2pHdDDZVcDCDA4q0wXVMOIvjdVGSN8LjKTP5NYAgEFcxo1e9ECa/qJ5quIHcV8rbOD/o75YEt24mEzJfVyqNmmuRx7JmF0QzHVugCck0PZcwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(4326008)(6506007)(36756003)(38350700001)(26005)(2906002)(6666004)(6486002)(1076003)(66476007)(16526019)(186003)(66556008)(956004)(86362001)(66946007)(38100700001)(69590400012)(316002)(6512007)(83380400001)(478600001)(8936002)(2616005)(8676002)(5660300002)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Og219T1YiS2RunU/uTeQIaVEOHJQF37130RAA1VjF+GbHattbFVywjimfufB?=
 =?us-ascii?Q?FzvUSJ70JnVmfKmCenAVU4XpV57AUOoL17PNc76Xoabh4tvtDKp3PXb1X12I?=
 =?us-ascii?Q?oVEfh/oTwGKfP++6goKwFN2wO08G+ZDzepRaitvkSIpYi2hEWE/S/XSLmiD1?=
 =?us-ascii?Q?bCJj0XqMDFraAhvsPCQ7pBU1U9IW0KxOl7rTXxXPUWVkDjGUJrBK+EoL5dBp?=
 =?us-ascii?Q?CkNuFyjaQVZJ0dFatCJ5zu9RhoIj84rWmhhgXAeHuprNrXJBVFlO9hdqKsba?=
 =?us-ascii?Q?tO+9YsGHAzEJwqvgwU3LJTyY3wPSIOHdL8Aqx8X7dKh2tfB6E+lob8bSbCF/?=
 =?us-ascii?Q?MIigo7aMIfr0OByedmAhZ0C7rSG4odX2jOxL3u8Kz/05212O598qsOeUp9yD?=
 =?us-ascii?Q?Pnr3bT9HNAyR8RpgmrHFSX1Qgks4IlM4mQ20ClOC+9/mcQkhEFtVsqarLWXQ?=
 =?us-ascii?Q?jY/eDdXh5HbctCWrFm0wlQWkuIj85Ojnz8KxNfMVj332bmM+iGFoaOeyiu/L?=
 =?us-ascii?Q?CojpWnFu3vo8tUxpcG7stxujgWDCM+NLjXZt7YtDCTkEhOQWWa/9zIC83NlQ?=
 =?us-ascii?Q?KDCZicQ8BIeW3w3uN+AXNgJdG9nraC3IoC/KRjtJg3JOMsvTz2iA3ytb22Ou?=
 =?us-ascii?Q?j7UGcA3MeSPKkY9B+1HEO558+hSyhPU3AgrOf+LSobSyvqz80zuFurIJwG4w?=
 =?us-ascii?Q?iQ7zG/NNkQQ+Bk+CeCMZSqS+dUWjQE/Duu1BNqMM+YHKKMcKkZ47UEKkVMjd?=
 =?us-ascii?Q?ABffthSytFnx/wRGcOHLu7SBV2B0Oxz6100kYzCe8f6vozj3yI5uKHKf5Vzb?=
 =?us-ascii?Q?788EV0EwYC11S6CF4wVxbgSVow5zCgjO1/QFR6Piv0mjSKb9eBpwc7SHfhbY?=
 =?us-ascii?Q?+9SpoKwedmU4giG0SQN7AzEnxFtFQgi/RoCeh3MEbRa9j9rGbUmcm9vtStPt?=
 =?us-ascii?Q?v4rH8UGaeBiUTnynHxFQohnfzdlB8JbeCWv9xBKgvyXwWfgdNAdnlqhN2bjW?=
 =?us-ascii?Q?n3PhaJ5BrFjufTYvANw8aR4Oowu8NY0EMgFHdDAJtNEDNZlB0M50lI88BdRi?=
 =?us-ascii?Q?0Fbuo54D00UTM+rjJgQfc4reQ9Hl9ULOB4MnPSxO8ZcWr6Yy9gH875byTA1k?=
 =?us-ascii?Q?C3kvERPqL+HOkzAnHYX3QGNWyb0rY9BU7/gMSag0E+9qkaED994jxJOwZIgh?=
 =?us-ascii?Q?4TJRTkODnjjwBtrRGkTgOP+zImHOYEAGNR4HA92vr7YyT1+yN9u1l4D+SU69?=
 =?us-ascii?Q?jSRatGz5kZTweSDAEq1Ku3/UrNyYeUNK5/TW5CPDGTr2AtraIlwKiOmOXLsc?=
 =?us-ascii?Q?m9UwzYPvI40edmGfx9OUx738?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b546b9-020c-4f4c-c4ea-08d8f971bd51
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 03:03:38.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5qQ8jkG/glxBjnhad9D9tIQzwc3ZtNIEHGv0613RnflykYywJhHZfjEf70C4cav67PPnECkVQN0u/xeREO0Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3276
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current Layerscape PCIe driver directly uses the physical layer
LTSSM code to check the link-up state, which treats the > L0 states
as link-up. This is not correct, since there is not explicit map
between link-up state and LTSSM. So this patch changes to use the
DWC common link-up check function.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V5:
 - No change

 drivers/pci/controller/dwc/pci-layerscape.c | 140 ++------------------
 1 file changed, 10 insertions(+), 130 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 5b9c625df7b8..71911ca4c589 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -22,12 +22,6 @@
 
 #include "pcie-designware.h"
 
-/* PEX1/2 Misc Ports Status Register */
-#define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
-#define LTSSM_STATE_SHIFT	20
-#define LTSSM_STATE_MASK	0x3f
-#define LTSSM_PCIE_L0		0x11 /* L0 state */
-
 /* PEX Internal Configuration Registers */
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
 #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
@@ -36,19 +30,12 @@
 #define PCIE_IATU_NUM		6
 
 struct ls_pcie_drvdata {
-	u32 lut_offset;
-	u32 ltssm_shift;
-	u32 lut_dbg;
 	const struct dw_pcie_host_ops *ops;
-	const struct dw_pcie_ops *dw_pcie_ops;
 };
 
 struct ls_pcie {
 	struct dw_pcie *pci;
-	void __iomem *lut;
-	struct regmap *scfg;
 	const struct ls_pcie_drvdata *drvdata;
-	int index;
 };
 
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
@@ -83,38 +70,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
 }
 
-static int ls1021_pcie_link_up(struct dw_pcie *pci)
-{
-	u32 state;
-	struct ls_pcie *pcie = to_ls_pcie(pci);
-
-	if (!pcie->scfg)
-		return 0;
-
-	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
-	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
-
-	if (state < LTSSM_PCIE_L0)
-		return 0;
-
-	return 1;
-}
-
-static int ls_pcie_link_up(struct dw_pcie *pci)
-{
-	struct ls_pcie *pcie = to_ls_pcie(pci);
-	u32 state;
-
-	state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
-		 pcie->drvdata->ltssm_shift) &
-		 LTSSM_STATE_MASK;
-
-	if (state < LTSSM_PCIE_L0)
-		return 0;
-
-	return 1;
-}
-
 /* Forward error response of outbound non-posted requests */
 static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
 {
@@ -139,96 +94,24 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int ls1021_pcie_host_init(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct ls_pcie *pcie = to_ls_pcie(pci);
-	struct device *dev = pci->dev;
-	u32 index[2];
-	int ret;
-
-	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
-						     "fsl,pcie-scfg");
-	if (IS_ERR(pcie->scfg)) {
-		ret = PTR_ERR(pcie->scfg);
-		dev_err(dev, "No syscfg phandle specified\n");
-		pcie->scfg = NULL;
-		return ret;
-	}
-
-	if (of_property_read_u32_array(dev->of_node,
-				       "fsl,pcie-scfg", index, 2)) {
-		pcie->scfg = NULL;
-		return -EINVAL;
-	}
-	pcie->index = index[1];
-
-	return ls_pcie_host_init(pp);
-}
-
-static const struct dw_pcie_host_ops ls1021_pcie_host_ops = {
-	.host_init = ls1021_pcie_host_init,
-};
-
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
 };
 
-static const struct dw_pcie_ops dw_ls1021_pcie_ops = {
-	.link_up = ls1021_pcie_link_up,
-};
-
-static const struct dw_pcie_ops dw_ls_pcie_ops = {
-	.link_up = ls_pcie_link_up,
-};
-
-static const struct ls_pcie_drvdata ls1021_drvdata = {
-	.ops = &ls1021_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls1021_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls1043_drvdata = {
-	.lut_offset = 0x10000,
-	.ltssm_shift = 24,
-	.lut_dbg = 0x7fc,
+static const struct ls_pcie_drvdata layerscape_drvdata = {
 	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls1046_drvdata = {
-	.lut_offset = 0x80000,
-	.ltssm_shift = 24,
-	.lut_dbg = 0x407fc,
-	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls2080_drvdata = {
-	.lut_offset = 0x80000,
-	.ltssm_shift = 0,
-	.lut_dbg = 0x7fc,
-	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls2088_drvdata = {
-	.lut_offset = 0x80000,
-	.ltssm_shift = 0,
-	.lut_dbg = 0x407fc,
-	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
 static const struct of_device_id ls_pcie_of_match[] = {
-	{ .compatible = "fsl,ls1012a-pcie", .data = &ls1046_drvdata },
-	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
-	{ .compatible = "fsl,ls1028a-pcie", .data = &ls2088_drvdata },
-	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
-	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
-	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
-	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
-	{ .compatible = "fsl,ls2088a-pcie", .data = &ls2088_drvdata },
-	{ .compatible = "fsl,ls1088a-pcie", .data = &ls2088_drvdata },
+	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1021a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1043a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },
 	{ },
 };
 
@@ -250,7 +133,6 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	pcie->drvdata = of_device_get_match_data(dev);
 
 	pci->dev = dev;
-	pci->ops = pcie->drvdata->dw_pcie_ops;
 	pci->pp.ops = pcie->drvdata->ops;
 
 	pcie->pci = pci;
@@ -260,8 +142,6 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-	pcie->lut = pci->dbi_base + pcie->drvdata->lut_offset;
-
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
-- 
2.17.1

