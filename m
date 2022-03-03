Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF374CC567
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 19:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiCCSry (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 13:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiCCSrx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 13:47:53 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A8B19F445
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 10:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgcxFAH5I4QpDsr7IDEO+kcQEwbFjNUMS97b39rTpSiqngNo5Q3vL6EaUaCsz1HmL1oda+u4uJyEuX7TyzFCcDyRiLd/IrzsuDBPtCB1AetL/VoN4zjR868MdCqi5vNweNbp93hIofDEi2Dbjmt7Khy362i9RIbbnIM1wXxS5o5xtHPXXCL34U3FjjzmiJoEnsftIRPicyyl+d5edcUWkHVlxny66tlkur1tONG/LsNgiKAQf5bzWQqnnoVDtqQYWvZmTUtb4mi5SKdACu1ex1yi7R8HucgKyzsVGwvyRxzosSEIymWholabG9X9JGIID7MmSSHczAATu4r6aAaW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaPjiTwiun+EFWXeh9s6jCfo5mCZ1uSOlIj/UVXFf8k=;
 b=K1FqEyyDdbNGh3SfM2sVYXgyqOb4/DO7litds+92VDiCtOFgH1drqfBqYZcpDqfAHO+duJFYa3jfsl/WYA0eT4qRnz8WHjBFtMbshbxgiJvQd9TU3CxAFxCnC0XSexTSceWPHw1O2Cl2r55mnPtFaYoHQNXK05M8oFe7gPM9BeOi8m2F9FrAmgHA5yr921TQOimD2yqv9jZ+IP7Pqx31P/8rfq21ls9awPSvhNgJ18V/sNU/lut6GRb8N1E1ApEspbg8Acr0Hebd9lUvfY4FLEmaopTkVsSJffrvyO1DR7HkqzN9IrWuait5In6EuEqoSuAXd+XcCQA/xEyvC3wUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaPjiTwiun+EFWXeh9s6jCfo5mCZ1uSOlIj/UVXFf8k=;
 b=FOXEgknV/O9/C2KKYfCFOMINVdI6r/p+/4HZEJqCgrUZZjvU/J7XvxYwaYTVu4etz50SPeOdY4XBqP0xeG2dIVJt4tyw6v+19JUC0dgEKFpPojsMgP6c1Teh9yj2QUmuUnSJ32tZyyAZiSa4sszTrponsUt+/MOGLh1kBcgnmA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 18:47:00 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 18:47:00 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v2 2/5] dmaengine: dw-edma-pcie: don't touch internal struct dw_edma
Date:   Thu,  3 Mar 2022 12:46:32 -0600
Message-Id: <20220303184635.2603-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2cf0834-e4ee-42e9-fdad-08d9fd463314
X-MS-TrafficTypeDiagnostic: AM8PR04MB7827:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB7827170DC31DD2029678DE1788049@AM8PR04MB7827.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBwrpTXPKhZ4gmymf6VDrDkkZ0R58ZG5HoBdtyuK5cELdMz38sWwoJMthRbvjAW5z5ESBxZjggB2quTDOFKBv5sTd7u9ipokhHeZ9mxCrZgLy9tePQYVAEGbD83S/vOPwqE3yKFDsouVIjEWudYexglSpzDbOfRDPc6FRS2pXYCQvqDrahltIBk3mCsSvHLlLh3HPuhfQuNyC6xpQ9fc/gY9iFLA6QjswaQU/pzlJB9hClYyXgwXVqEYOi9w1yHkPoMryqqPkpSuF7+6+v7qJXV3Wo5tmLfncODciJEppP20KHwsjTJbfOoC08sDAXTtBRZFdHa+Mccd0aefhZBZTBW4HLsdVTYYe+24pUWoN5vJrisW4YoYHSX7SaGMmKej7FHso3F/PkSHDV8MhsRh7/OZEuqdMTOEr2ajcPZzJh3mbf/hW0dBZKb2yhorz6A+YSJd5CQPFtOlMW0QV/pdkkoNy9pUyjrKFN0uEXdVz0SUcDglhLJ/yCNbE96FPtRuoEi8GXNa99iNuQ7H7PhVit7JPzzGAkjWZTOpiMuXINa6n/BNaIYq5zEy53s+C9gevw3+BT1sWOWSars2mf8/NpXB7SzQV2cbRXfG6GZbo+WVDJ+qpRZOKC7xrFE7dmLIRn5pnNhCczgXSUku8HoSj7cPQkbH03UalLJyICVvLm4yHVBQnnAiBQygk9aPYDgqEB6ahLwDTV/dKy5Dqrs/uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6486002)(4326008)(86362001)(36756003)(8936002)(6666004)(6506007)(26005)(5660300002)(498600001)(52116002)(83380400001)(8676002)(2906002)(66476007)(66946007)(66556008)(186003)(6512007)(1076003)(2616005)(38350700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vj/wQxk0BBoXtgzIRlVUokvErerwwKAIiBUXT1SsE0BMaYxPPcDTJBwiQHC6?=
 =?us-ascii?Q?45WYTljxDoPecNN3DEo9M4PmruMEPqSyet36F3ap7MPF4GYUStE7cxFbakOU?=
 =?us-ascii?Q?qMjW+LsExwdJ4k9viSLVlWDxYrqQW/f+mr5uYWVMALNbvP5hyftszPqOOulK?=
 =?us-ascii?Q?1FfA8rz3dZvR+DHevaS2SsSdqzc9JhDLBOsDjfxjXcnvcSTHDVwriXdF/1Jl?=
 =?us-ascii?Q?QYK+MVA5bV9Th/6tCuhgBseO4x6fLfkmx37GoaCjubJgwoUAmfweDci57/6E?=
 =?us-ascii?Q?k6Uz8mbspmRezOLzJx/yte0zFoFFyV54NOcyu5prLx317FAWZZYZpcY/LKn4?=
 =?us-ascii?Q?94M8KznXdu2FsdnY/JHjguvyJkJsDHrU++x/Tn9i/4aVTM0upGgK+IdLXr/d?=
 =?us-ascii?Q?Cwc441HBX3RUOJIJPnrcTHwmcoaGCdGWLepHupxNo9UxO6VsvPqSqNYQ43l4?=
 =?us-ascii?Q?Qs1SH3ZaEsDWSJuRyeYC8uw6zp6GG3OudsKBtb/1pN+1NKPZfKzxwdPEsfYM?=
 =?us-ascii?Q?ZpKO7WxSHHgNE0F4qto3jAr/GeCOBD7J4MDwORFX8X0UF/ChNkaURmzNG7io?=
 =?us-ascii?Q?JqYbaC8ubUzKS/q7i1lKQ0QDRSxvog21F63UpjOOMmVVpcWyT8Wmxo1q/EW0?=
 =?us-ascii?Q?PScQEFJsN4XOmrYrd60/yCfVHEeIuCs8+L0JHha7kHzMGjRSuKk38JMR4N3X?=
 =?us-ascii?Q?RmmwX8EA8shZbhFer6U4DAUge93AmBrrUOV9/wJEJ0+L/kHDwOswIK/lvmsG?=
 =?us-ascii?Q?hD4qyh0VK1LNDeFzbqSmPIQDvcHm3xkA/9Z1OhIiixLuxj4nbSFx/m5efj3B?=
 =?us-ascii?Q?caNADqk4PuMVY7A/uWQXUbgyvUfWoOabtgWx9UdFTpTKP55u/pchTbYExuZk?=
 =?us-ascii?Q?gELiCUOiULWyvfxPxvSGa/Vk/qPIRX7s5c+FwNGKnofGnD5c6p+KXW/r9iro?=
 =?us-ascii?Q?FN+ghbhD+46i7YvslcgH6FNMWbOMjS1hcMgxh4nRGMH7NHaycOPlRX7BWwFw?=
 =?us-ascii?Q?eSdF+w2SxlyQwW3YP1fwK6V49UVWdM5xSrBUqEP63Ti6XgUkfS1AaCFRrRGf?=
 =?us-ascii?Q?57s6gyHXr2YBMdjSzxyZ0XK/Pzi5WX0Z0LszzbM8hNF83U2yecP1eKrs+FTz?=
 =?us-ascii?Q?gFYtO4/DGwTWMQ9yH/iZBTn+lifnDAy/U6NuCJHWLgIn+Zm0hecnYmTY0nio?=
 =?us-ascii?Q?TcqBI9aSYQ97daZMB7gxoVRPAPqBi9y6W/I6/w7XL2MOCN7IV/XSfSmjCFv5?=
 =?us-ascii?Q?+K1GWEx5H26Pm7x2xlR2uJwDt2dhyk5+fCmzVSVrEFM1lU7ai+BDRO7wdfqC?=
 =?us-ascii?Q?CsqFsBCC3Ohqd1E36y2afhGO0O/4Dh/g56w4LBc5p+HAYk/Nz9LcrS5pV9U7?=
 =?us-ascii?Q?8ShhfplOOHpxg9bKvu4ISe5RBhrTjfwz2TMpZhlEp3GQRVkbnb3dDQJpyAR3?=
 =?us-ascii?Q?QlwuJ77hiwDmlVqRaGsWZKj2oVx8fPgNpPuUW+p/MEsSPRjgP4ax/x8bC4Oo?=
 =?us-ascii?Q?PFT3McphICqFcWBNrqpX7eF37+fJ/5NU7M/4i16KphkOQ/UPR2eALDuj+7Oe?=
 =?us-ascii?Q?8kPBZbE9/9Ui1fwfBav149xYb89AM6jAkHzD9YdmRRkBjIbENraMQxQ8AzXz?=
 =?us-ascii?Q?kbP26qsG87UeI0IzA4DTsZc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cf0834-e4ee-42e9-fdad-08d9fd463314
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 18:46:59.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8Nr9ji9uLqwAkeJHVud1LDvHgXcb8k87GDFOispRsIP00jyJAtXiFjwOe+DePkdT8S4LCZyroj4c/rC1ztksw==
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

"struct dw_edma" is an internal structure of the eDMA core. This should not be
used by the eDMA controllers like "dw-edma-pcie" for passing the controller
specific information to the core.

Instead, use the fields local to the "struct dw_edma_chip" for passing the
controller specific info to the core.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2:
 - rework commit message
 - rg_region only use virtual address. using chip->reg_base instead

 drivers/dma/dw-edma/dw-edma-pcie.c | 83 ++++++++++++------------------
 1 file changed, 34 insertions(+), 49 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 44f6e09bdb531..7732537f96086 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -148,7 +148,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_pcie_data vsec_data;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
-	struct dw_edma *dw;
 	int err, nr_irqs;
 	int i, mask;
 
@@ -214,10 +213,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip)
 		return -ENOMEM;
 
-	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
-	if (!dw)
-		return -ENOMEM;
-
 	/* IRQs allocation */
 	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data.irqs,
 					PCI_IRQ_MSI | PCI_IRQ_MSIX);
@@ -228,29 +223,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Data structure initialization */
-	chip->dw = dw;
 	chip->dev = dev;
 	chip->id = pdev->devfn;
-	chip->irq = pdev->irq;
 
-	dw->mf = vsec_data.mf;
-	dw->nr_irqs = nr_irqs;
-	dw->ops = &dw_edma_pcie_core_ops;
-	dw->wr_ch_cnt = vsec_data.wr_ch_cnt;
-	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
+	chip->mf = vsec_data.mf;
+	chip->nr_irqs = nr_irqs;
+	chip->ops = &dw_edma_pcie_core_ops;
 
-	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
-	if (!dw->rg_region.vaddr)
-		return -ENOMEM;
+	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
+	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
 
-	dw->rg_region.vaddr += vsec_data.rg.off;
-	dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
-	dw->rg_region.paddr += vsec_data.rg.off;
-	dw->rg_region.sz = vsec_data.rg.sz;
+	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
+	if (!chip->reg_base)
+		return -ENOMEM;
 
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
+	for (i = 0; i < chip->ll_wr_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
 
@@ -273,9 +262,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < dw->rd_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
 
@@ -299,45 +288,45 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Debug info */
-	if (dw->mf == EDMA_MF_EDMA_LEGACY)
-		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", dw->mf);
-	else if (dw->mf == EDMA_MF_EDMA_UNROLL)
-		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", dw->mf);
-	else if (dw->mf == EDMA_MF_HDMA_COMPAT)
-		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", dw->mf);
+	if (chip->mf == EDMA_MF_EDMA_LEGACY)
+		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", chip->mf);
+	else if (chip->mf == EDMA_MF_EDMA_UNROLL)
+		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
+	else if (chip->mf == EDMA_MF_HDMA_COMPAT)
+		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
 	else
-		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", dw->mf);
+		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
 
-	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
 		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
-		dw->rg_region.vaddr, &dw->rg_region.paddr);
+		chip->reg_base);
 
 
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_wr[i].bar,
-			vsec_data.ll_wr[i].off, dw->ll_region_wr[i].sz,
-			dw->ll_region_wr[i].vaddr, &dw->ll_region_wr[i].paddr);
+			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
+			chip->ll_region_wr[i].vaddr, &chip->ll_region_wr[i].paddr);
 
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.dt_wr[i].bar,
-			vsec_data.dt_wr[i].off, dw->dt_region_wr[i].sz,
-			dw->dt_region_wr[i].vaddr, &dw->dt_region_wr[i].paddr);
+			vsec_data.dt_wr[i].off, chip->dt_region_wr[i].sz,
+			chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
 	}
 
-	for (i = 0; i < dw->rd_ch_cnt; i++) {
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_rd[i].bar,
-			vsec_data.ll_rd[i].off, dw->ll_region_rd[i].sz,
-			dw->ll_region_rd[i].vaddr, &dw->ll_region_rd[i].paddr);
+			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
+			chip->ll_region_rd[i].vaddr, &chip->ll_region_rd[i].paddr);
 
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.dt_rd[i].bar,
-			vsec_data.dt_rd[i].off, dw->dt_region_rd[i].sz,
-			dw->dt_region_rd[i].vaddr, &dw->dt_region_rd[i].paddr);
+			vsec_data.dt_rd[i].off, chip->dt_region_rd[i].sz,
+			chip->dt_region_rd[i].vaddr, &chip->dt_region_rd[i].paddr);
 	}
 
-	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
+	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
 
 	/* Validating if PCI interrupts were enabled */
 	if (!pci_dev_msi_enabled(pdev)) {
@@ -345,10 +334,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return -EPERM;
 	}
 
-	dw->irq = devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
-	if (!dw->irq)
-		return -ENOMEM;
-
 	/* Starting eDMA driver */
 	err = dw_edma_probe(chip);
 	if (err) {
-- 
2.24.0.rc1

