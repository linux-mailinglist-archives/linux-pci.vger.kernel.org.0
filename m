Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5AC4C9C21
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 04:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiCBD2D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 22:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbiCBD2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 22:28:01 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10043.outbound.protection.outlook.com [40.107.1.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1C1B0D28
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 19:27:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8mkvzG7BefNkrGfoGlPKSd6LDk+ytkVk+RXnXGwSdVnDeHI4AuMVqCYoEGy18qVhrQsF/IZ6KvKvxVfgp6AINwd1jClR3ER4QlS55kys0GgeI1bSfiOwyHwdCR0gekvYVLKYIp6CzlRL/RHApK1+Rb1HpHnwnTm56rU/ySbuL+j9lFO2EXt+aNuLS6VtfFXOrWGyt6pIJ4S1+P5liKOeUChU68TOo+U5O6tv56/4q7nDL66jz3k+WLkTWgzpNNdW9nr5zk8CLvDDuN2pAXjWCm8ha1eVxtx9AktXbINOMmUydIlY4goDNi6DgRGYK01QxkQhqZv3PydFrqzQN1GyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Rz2+a/X1IY85jZWLRNTSbv8vPMw2vluNILKKSTArio=;
 b=N98AUOSCaxhVgJMIBZn2IoijBK1ctWNjVJZilKBxptfsU8XNwN1sdgAbtz/ieE7hEFL2/beQ4jDOSv6tNdmJO+0upLtR6263YnnpJRpLvJ5O18wtUSZvs7KD4GZ4+f7iPeaCYxzcvggAbBNnAYC0dhtcZBHkmv6uvBsthXRCj605SfNezTLJsSIcQ1TmF1dFxN8S732JDhAs2os+xS7Nw9iQjNmgH0hiEpAFmRK50ZRT1jBbXgwFbiasAz3SAu8lgt8ox+coT3euqe9lW2HdGyY59QOR0mOF6jdmEZfF3eO89erCm5W3mkGgrkG97PTlg+gZHx8F8ObgAiHoIIVrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rz2+a/X1IY85jZWLRNTSbv8vPMw2vluNILKKSTArio=;
 b=jZFSbWc8gKFuctoVPAv9WpZkLuuDeyIcAqUU4gsWBmhJCl4rrUVivEStD9HsbSdhLi7xJGt3BVD1k08EuTuxAHanKAWr6I88/3iDXddz+buM05i4PXWqAM8yLa4LZzf2ma4Vjvp4Ds26iGOliimjxJJ7avUenGOEz0MbRhOPWFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB5926.eurprd04.prod.outlook.com (2603:10a6:20b:af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 03:27:16 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%6]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 03:27:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org
Subject: [PATCH 4/5] PCI: imx6: add PCIe embedded DMA support
Date:   Tue,  1 Mar 2022 21:26:45 -0600
Message-Id: <20220302032646.3793-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220302032646.3793-1-Frank.Li@nxp.com>
References: <20220302032646.3793-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b8a176-1c63-4b85-e38c-08d9fbfc8ce3
X-MS-TrafficTypeDiagnostic: AM6PR04MB5926:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB59263B31CE5F763A1D65E46E88039@AM6PR04MB5926.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LH96a9fGitDcYnm6lUneWVz4WfPcNPjIZ8KqwcgLfhuxZ92XljWYXAOVjlS1IFaAsUf2vl6NiZ/RjKtaIGM9vU22yFXWSy7lrkccdp20iexboFs7QlHmvbc+2cWWje5ezxcoZbLLqXtFUQDwmbhS7xocjfvX7uBf7gAnzktjGVDAj80mIKEB8sKT2Jyii/E+1RyWHKvCsBDX/BNIbLGpFSv53dwbLgKj9pfponscqQn/4TeRfVCxY6+WaqUHQT9q0TMFsaOoZvwDMNNnp0TRRW5QsN7v1zvXot5Fp0snGUGwLNj3iOu47APhbPa3WKSM1cCB9xAuxciJAdkolptLV7t58TFJyC//aro5ht0ec8b5yk5SqY3LSeo8UbWw8uYoJ0UB/DgkMvs4lWxka+yAEqcUhDbx/2QepsZ2W7aLezMO07pzhOxFeRJeSTEcI+eOnhG6oqkzK+G/cYDo7Tx9YUeu2wrVlDsqT5e91OIstw51h8dP9WaOvXwOGUOYhbPooA+7/BANIUpzaOwxJ3qDrIP65dBhe5Jo97Sps0SPdOGH15e6NhE7q7fE8m1RhaX7axpDRJiFAgNCWDbGHWzlzbSF/xZXvAfM/z/IAxb/NlQkdN/VylyGxYmh0h3oGzY+eJaY7lhaJWwWtemM7+8xfS+4shZQw1pO2z/o8ge/K4FzYNm/Y4jVtfn2tpyJVHNEQpnXmTu9WSdY+cN4bqWnSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(86362001)(66476007)(38100700002)(8676002)(66946007)(66556008)(4326008)(316002)(5660300002)(2906002)(7416002)(8936002)(26005)(2616005)(1076003)(186003)(83380400001)(508600001)(6486002)(52116002)(6666004)(6512007)(36756003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0DRw/TtI+UiCNqqd1mHq4MgvobGly3zMMxCXEecJ3spj8jG/MiZKikizjdqb?=
 =?us-ascii?Q?mGBf5ncZ05beekiqYoTwOVALSnqQCVKhR+tWfZVINbmZnkeik/dsCrElOrk6?=
 =?us-ascii?Q?wnqDiaO2Nl52tlxfacQx9WsQ9MmowqXoO0ALxxEva9U5gIxTlGlXa+z0t8Yt?=
 =?us-ascii?Q?iVjMs58vhaiAPxFK4qiCRX0P7gQmuaubTmONB5MYzyFOV3OVVumgwjDcBcfS?=
 =?us-ascii?Q?FYxuI3hKB59saDlrwYEBPyKpLRp8CsDgiR9LwhYxjcFQfiQxaylLOUqpJ6SS?=
 =?us-ascii?Q?wPA2qVx6mDlH9LErakkbUDIeA/z3IiwnzkJx0I5fjaaE1RKlCwN6AdmgiW6L?=
 =?us-ascii?Q?U+SobZAYAvhRPAP9b33blTubuC0u/tvnrP5wBOLlwVxae0/b8JgMYIM+MVyx?=
 =?us-ascii?Q?okHCMcQGJA79lhHRylNJXy+tY6qivIXUBmRynlNqoPlkwpyv1YjQzP5kuLgk?=
 =?us-ascii?Q?4KGdKRc98i+qYjkpeM26Ilp3qXqnNcp+m7/gBupQ+e88ZaW4ksXprjEYYWfD?=
 =?us-ascii?Q?MBRQ4VhA/PmiUPqqC/lC+d8Tt9UObvDfzHUbTDSEwZQ6881b9vNQy1fUyBQx?=
 =?us-ascii?Q?C0ipYcIfF6Ge4fB3AWnnYeQaPst6Tp2YdzAStuU70hdzpbRRpXuUB4/bhlsk?=
 =?us-ascii?Q?8CTsC1MaevQafRRooMMAm9Mf4NB0jCX044/8LBfHD7jsVrGiU8NcwHNkXNzM?=
 =?us-ascii?Q?2bOvwxdk3nIzTobx2y37h4lA1ieVHJRQh5Azk4Ah8G+H132TqEXplbwdgRi5?=
 =?us-ascii?Q?iO3yWKLAtOdGDj1opDLUy16dNBM5dVYGHgl3g0+BNSB1WzjlF2/QNj1xxpZu?=
 =?us-ascii?Q?EAU+whsglsC2ZVYPJmm1mGS8SdjuU3pPqJzeWXE6nhPIWVoGhwP0WMMqO7JB?=
 =?us-ascii?Q?Rfte/NJ0WJro5e/fFCJPSR1Ar/LzBXlL4Y9lBnlxZkdQw9SH0y6qY3KMwpNL?=
 =?us-ascii?Q?5qOKkSQntwfDYWzywsjc9fUlkbsNtNM3YQXGRo9vufbzdR0ZLH/22DwneVne?=
 =?us-ascii?Q?U/QwklFPQinjwbvW92D2YCfxIIqyr22IG/y+sFlGM7R/opsfe1pP1tw8x5sb?=
 =?us-ascii?Q?enYmp2uheQF0conCgJhGcLaICDmSbz+wvJdalL3T+Cr3lG6IyxDW5WESIifo?=
 =?us-ascii?Q?7ufwmrlQIcb52TPr5RdlvsS65ULQmAM9U4ciA/tdxgso1O1QseupIoRWGUtl?=
 =?us-ascii?Q?/uNxrR3x7Jay4Dc3Rv13IiPpFBubiDEfUrh1H/LGfx4kDak0QVhwujig7DVp?=
 =?us-ascii?Q?2Br/hXGeyCa61hkPBIgGKZ6FgWvuO2kXoGpRKWQMBE0iErzA0grhVDmtLIaY?=
 =?us-ascii?Q?WVb8NSd7enEU5P4Bn9amraVxrs5Sd472mmXJ8bRL12NWl7MW6DPc9Lm/Javt?=
 =?us-ascii?Q?GvUklFKIIR8/iWb/9/7XTxZ/Zk34Kva4eNmIkLGWaR/bS0hMVOCQnVqkakeV?=
 =?us-ascii?Q?NUru+au211cVOSJvFotrOK5T4XtHeoL6Twv+kZ0LnrUNDM37eqSV0AoPQsb6?=
 =?us-ascii?Q?jxVzaFY6iO2oT44Ju2efAA4I6bdBY7tFAFrZDVvNKlpnHVePifU99SMkzvbc?=
 =?us-ascii?Q?yKoliVyxuqKxzY/XeF63yw9uiF2AODK8KsbZxGI7ZL91uWxoqNpwpmW9l8nY?=
 =?us-ascii?Q?MvdzMcyEujEC4NC4Cx6RsJo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b8a176-1c63-4b85-e38c-08d9fbfc8ce3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 03:27:16.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qy0F9AragnPRAY3Gb68rYnXd+VQ7hsPKHyeSFEBw0wCv47Pp/bLDdeiFUscR8V2Vk9U2jNZG5mVM6dwoknEkeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Designware PCIe control have embedded DMA controller.
This enable the DMA controller support.

The DMA can transfer data to any remote address location
regardless PCI address space size.

Prepare struct dw_edma_chip and call dw_edma_probe

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 61 +++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index efa8b81711090..a588b848a1650 100644
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
@@ -2031,6 +2034,61 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
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
+static int imx_add_pcie_dma(struct imx6_pcie *imx6_pcie,
+			    struct platform_device *pdev,
+			    struct resource *dbi_base)
+{
+	unsigned int pcie_dma_offset;
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
+	struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
+	int i = 0;
+	u64 pbase;
+	void *vbase;
+	int sz = PAGE_SIZE;
+
+	pcie_dma_offset = 0x970;
+
+	pbase = dbi_base->start + pcie_dma_offset;
+	vbase = pci->dbi_base + pcie_dma_offset;
+
+	dma->dev = dev;
+
+	dma->rg_region.paddr = pbase;
+	dma->rg_region.vaddr = vbase;
+	dma->rg_region.sz = 0x424;
+
+	dma->wr_ch_cnt = dma->rd_ch_cnt = 1;
+
+	dma->ops = &dma_ops;
+	dma->nr_irqs = 1;
+
+	dma->flags = DW_EDMA_CHIP_NO_MSI | DW_EDMA_CHIP_REG32BIT | DW_EDMA_CHIP_LOCAL_EP;
+
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
@@ -2694,6 +2752,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		goto err_ret;
 	}
 
+	if (imx_add_pcie_dma(imx6_pcie, pdev, dbi_base))
+		dev_info(dev, "pci edma probe failure\n");
+
 	return 0;
 
 err_ret:
-- 
2.24.0.rc1

