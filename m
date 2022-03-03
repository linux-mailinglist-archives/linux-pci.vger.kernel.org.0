Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F654CC569
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 19:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiCCSr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 13:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiCCSr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 13:47:56 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732A919F445
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 10:47:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCfE3rsEzHmvWOq57awtVwsal1OgYjN1/iEdc9LHooWEwH5NVtT09DxgQak3HctIMf8bLpjSUxKYUXidzpIdIbAlhVvYSOh7FVVH41enyRop1ueO+kWzQ0Dra55nJdL/AK7w8+pTWJLvye3wlmIWapvWAgUWMZf7WFpa4IB/B/BP1PW6HxCzfzKF7JQBLkHrpLHBjArhcUxH/HY1uaAAVvg4KkxPx08cXbdoYpA2/qyUiCSTuEtwBn9WFweZ+0pYFpsxzBxi6g3aQFZIwbxpnzui6Rb0r4lc3U9JiX8ybaKhjr2iQ0JcdIsKu6Nzo9V2XgqBUq1S8J6DW0iVq5Qcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbg/mixWBiMWNaYQgswPVpXKegvRRh3aexiaY7lC6Ac=;
 b=mWN4U+s4yaX7g1A+IOkIckKffuV8uxuxohEL3YRT94by6zfXk8lBmMbnxOTOi5wDOG0X2szP092qvGVxPszoB6k4MYiOy3qeHGwVm9WBy3SzMvGxNAd5dU8rh81J5fSvKobYaZi5EwhZ2REeGFJ+aGWJwUhBfQw7UniMh786mekGRfRPwGnNpB4SQUrpqN7RhvIYSCG45G5ClRFmKFg4CsMFOmFdlZTSlHj0pKW5eXO+IX3qlLbAzEwOcQogFCFuW8R9lSzb8+RZHu/C5v/oZsst9cgOzzUBsqzT+E925znbnZ5NlO7IrI6rRE7W2nAFnQmU73snBvWyUrBT7NKbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbg/mixWBiMWNaYQgswPVpXKegvRRh3aexiaY7lC6Ac=;
 b=rxLy+OUVHol78HqpRVeNtSP+6cvsXLyV7hPBJWg+xvxsdFUX+dCgR8/JKvTq4CWHqDbLo80rqdm/NcGOWMFPWW0fCCXpFU3DdI95165ACtGNnfo9pWF3dtXYW9fnQu2Gv46lQRHVlzfgCwHDDybqaJUdhXApisXXezHBzVY2AfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 18:47:07 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 18:47:06 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v2 4/5] PCI: imx6: add PCIe embedded DMA support
Date:   Thu,  3 Mar 2022 12:46:34 -0600
Message-Id: <20220303184635.2603-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220303184635.2603-1-Frank.Li@nxp.com>
References: <20220303184635.2603-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0462c0db-6bdf-4530-51bd-08d9fd46374f
X-MS-TrafficTypeDiagnostic: AM8PR04MB7827:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB78271F2F7F046CF07CAB46BB88049@AM8PR04MB7827.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xS6WDfqdcrgmjoXrG/H+rkciMV8pqr2OuVGGb4ZHKFnzpcF9zmLVKWDltY3skwVsMnuhoITKhLb6ahyr6rpKDXO2NRz5VUlre9eTT/qe9Z12ZWTmWHX85tpME+lOnTNC10WIqSyRFWzgiaKkRU/OMVHAW5ndJAU7uS00PbVS6PUbTjW6EpLf/FMfECbyjS7pg6TYOeg2v+x8UDX17U5cQdw2AtWvVnN3i3b5B0HFDHy6EAMD4C+lTihs2TNfR+CpADnrIN/pDqIDdQK6lCrgjIzzK4Z/xcDKFTNZI2+BAp3IjGQD6DUfCN9jitcpUTYT0HzTDE3pgKP6jQCl0x8l8aalGNVw6F+fw5ciyBOzb81sL5hTBfBzi87h0mlnwy99G+yTBY88LjjptD5JeJw9ozMr7AKl0eJisvBzQZrmrVcx1SxmRi/2xuneqnylVXHAHwBowoCSCzEHDzDXLaep2pwbYiuoqQ0SPjfXMgWXwNTMNxBmXiKPAPE/emiXVGdQv9qfbI5Oe8kRLaHJ3sGaH1JQuxf4bK2r308M25IFX1w7sDInXYrjH0JrbJHTClzniRsjqZNt7ITKRpRhwUfBDHE5NBt8qoorUFqLSVFod/GYYVGtWPSL2md9oyHcFmRZlQlq2zxR1sCcAhAEs5a7zmOobUERVlCcjKuAjd264QoZ0e7kG9TRlGSCieC4hbt2jIcmWEqhIWKzwpMKUupnRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6486002)(4326008)(86362001)(36756003)(8936002)(6666004)(6506007)(26005)(5660300002)(498600001)(52116002)(83380400001)(8676002)(2906002)(66476007)(66946007)(66556008)(186003)(6512007)(1076003)(2616005)(38350700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZCPoM3ksTPZAnG8dbS1eLNGuCPJ5y1RgJjsD1jxNnl+qfhe7jhx0+TVa33fH?=
 =?us-ascii?Q?AkoCJBBzGnL9JG+Q0dEReK8whilruH37FDBH4NHRNMP/ro6lhu2wc5fdMX2q?=
 =?us-ascii?Q?HFuxHJyRlrTB3zV5K7iLm71JNttTbmJl24upA8+4/PlGRV0fvUgwMuDijSw6?=
 =?us-ascii?Q?uL3ybcGFEhPY0c6oLdwzwKoA1O3QSuKfNM6Ex3XgeFGtFSWBIVuoSFn4f/lt?=
 =?us-ascii?Q?2Sxv40u+6K5L0i/iDw+WQFKwNDjd8au0e8ZaXm0pQ3Sa5J8UrH4Mm4Vz9CPU?=
 =?us-ascii?Q?EhkkE2W/Uok5nK2UDwEcI3nMSr6dtiwfyjxICmxIU0HGAY43xxJCUoX3Ujg4?=
 =?us-ascii?Q?zY8v1yXAmSBokC/GimM29b2Utq+/aJ1qudfxezfl+GjPcF5GVPWS0cEDQUw/?=
 =?us-ascii?Q?/+p6xUqnqzMtRIg4gs8SAgVz/d1g8kTLYQUBd4r5YVtUcjKETgfqu4JZ6Rdo?=
 =?us-ascii?Q?dgwh4uawEt/0YKKl6lc1kWSH8ar9XuZPlc/qFSGN6NZ3AhrSD3cRhXO0t2MU?=
 =?us-ascii?Q?MmbmWBBEb0Xlu/IOMtcSwYhZJWQuLmZJaVlB7b7Ig/lNeShT4SZodaPL40YL?=
 =?us-ascii?Q?kaPvqkElE3eaO1c+b2vhrL38BhML//6W1h877LZc2MaVCBoo1hMkYPWKfqP4?=
 =?us-ascii?Q?h9DSCLcSfjTQE2/KP5irrAnSy53/KkmavBm0ulLMBN6v9ehDS/aH+WOVAhcv?=
 =?us-ascii?Q?ALzBq+zY+H3MM8NBqC+n3Hg0Wn45ZcETXlBSjFARgDEiYit++lKsJURHv9Ud?=
 =?us-ascii?Q?9f0THNT4QM7zs8mZlWvsNtuYEB7wJrU24WVgEmu06j2+2OyGzdrEMJ/57Uda?=
 =?us-ascii?Q?kKif8ymtRCmUGBxArDfDZ2MfDDpM4aPIumszlMcw20tMjUauxPXdPRkG9aKl?=
 =?us-ascii?Q?t55byuZlm6vLTmZMPw0oWS0l/xmmUowTCO7oWqTlujx6V3cmjx4oiQE5ri8A?=
 =?us-ascii?Q?WV2nbByD4mj0M+QtoL+2hJyPtmf50DfP7HbWWj3LvlEp3Z9vaY2TAQJKDFZp?=
 =?us-ascii?Q?Qsatjy0MiCjjfgFDFjIvUW2ssab6l0PXkWdSGNghn5H5pNHo1jnDnX3VYQP4?=
 =?us-ascii?Q?TRtCOsH85DS/KkVonNoWyf6++xJWPp5+PiBtdXUiA5m3yi1+dBZvfO5ttlpL?=
 =?us-ascii?Q?PvGaPivldxvmnp/Q3wISJfv1YiTvvnYFFVp0pg2HEEha6PFiB50FVH+uskNu?=
 =?us-ascii?Q?NNSEbLmuzAL2g60M7iYX8uhgnp/al9otPpAZOsgYLy+o8TjziU02vAtpmK59?=
 =?us-ascii?Q?/RmE15AO1+LZQd0BUgbjtxPjlF8nUtyM9ddaZDTVxBJ0/Odn38MjCbDL51hO?=
 =?us-ascii?Q?vrFoOfyILe9YjREeiw2XV2oEaovEVIPHNgO52tbY5lchEVUUrS/8aWRN4/9m?=
 =?us-ascii?Q?Ed8kRY3ChvL78T5nGvi7RmqHzTi1yjGXmrPuIbHsKd0QMAFhHizCDZKRbTK4?=
 =?us-ascii?Q?fe2jagUYEsbUWSFTjVmtowrwqX1aG9FZeFuWnZAyZtOkLlb+V8jBT18KO3Rs?=
 =?us-ascii?Q?AEt0xMbZluC068fQ6R+RmEdJHQzH7b9hyH7eOHOOBVBwmERo1KDOuvFR+9o6?=
 =?us-ascii?Q?3xFX5eAAHlf8N4lU/0OWnsmQ4o3myrUsM0xJuuN+HE72v2dZdnfi3QqxCpje?=
 =?us-ascii?Q?p/9oINFi4r5Y1y63U9rVKoI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0462c0db-6bdf-4530-51bd-08d9fd46374f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 18:47:06.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWPM1MqeJSRnxxtaVVvxcowu3/Xy7hpv8kXRG3n0GDwSI1vsv9+gHyaBLQOkc3FMi9yWOAkK0UE3dM5pLuVlPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for the DMA controller in the DesignWare PCIe core

The DMA can transfer data to any remote address location
regardless PCI address space size.

Prepare struct dw_edma_chip() and call dw_edma_probe()

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

This patch depended on some ep enable patch for imx.

Change from v1 to v2
- rework commit message
- align dw_edma_chip change

 drivers/pci/controller/dwc/pci-imx6.c | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index efa8b81711090..7dc55986c947d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -38,6 +38,7 @@
 #include "../../pci.h"
 
 #include "pcie-designware.h"
+#include "linux/dma/edma.h"
 
 #define IMX8MQ_PCIE_LINK_CAP_REG_OFFSET		0x7c
 #define IMX8MQ_PCIE_LINK_CAP_L1EL_64US		GENMASK(18, 17)
@@ -164,6 +165,8 @@ struct imx6_pcie {
 	const struct imx6_pcie_drvdata *drvdata;
 	struct regulator	*epdev_on;
 	struct phy		*phy;
+
+	struct dw_edma_chip	dma_chip;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -2031,6 +2034,51 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.get_features = imx_pcie_ep_get_features,
 };
 
+static int imx_dma_irq_vector(struct device *dev, unsigned int nr)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return platform_get_irq_byname(pdev, "dma");
+}
+
+static struct dw_edma_core_ops dma_ops = {
+	.irq_vector = imx_dma_irq_vector,
+};
+
+static int imx_add_pcie_dma(struct imx6_pcie *imx6_pcie)
+{
+	unsigned int pcie_dma_offset;
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
+	struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
+	int i = 0;
+	int sz = PAGE_SIZE;
+
+	pcie_dma_offset = 0x970;
+
+	dma->dev = dev;
+
+	dma->reg_base = pci->dbi_base + pcie_dma_offset;
+
+	dma->ops = &dma_ops;
+	dma->nr_irqs = 1;
+
+	dma->flags = DW_EDMA_CHIP_NO_MSI | DW_EDMA_CHIP_REG32BIT | DW_EDMA_CHIP_LOCAL_EP;
+
+	dma->ll_wr_cnt = dma->ll_rd_cnt=1;
+	dma->ll_region_wr[0].sz = sz;
+	dma->ll_region_wr[0].vaddr = dmam_alloc_coherent(dev, sz,
+							 &dma->ll_region_wr[i].paddr,
+							 GFP_KERNEL);
+
+	dma->ll_region_rd[0].sz = sz;
+	dma->ll_region_rd[0].vaddr = dmam_alloc_coherent(dev, sz,
+							 &dma->ll_region_rd[i].paddr,
+							 GFP_KERNEL);
+
+	return dw_edma_probe(dma);
+}
+
 static int imx_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 					struct platform_device *pdev)
 {
@@ -2694,6 +2742,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		goto err_ret;
 	}
 
+	if (imx_add_pcie_dma(imx6_pcie))
+		dev_info(dev, "pci edma probe failure\n");
+
 	return 0;
 
 err_ret:
-- 
2.24.0.rc1

