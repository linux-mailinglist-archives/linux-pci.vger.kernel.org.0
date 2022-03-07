Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B974D040F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 17:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiCGQZy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 11:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiCGQZx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 11:25:53 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A315C85B
        for <linux-pci@vger.kernel.org>; Mon,  7 Mar 2022 08:24:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1afcEmt1dHbXewEOxIGwf0IKTR9j3Nvfs+8Wg23ZKQSHtheebGNMSffzX8QSSVYqzdFKCpKJ3E+cJLFfkPC3ilBlv7KEgilJRtXP8Q2rXRrlXoSfcH++7AluV+fHzES8NwBPa+GgpoiG8NQ7qUlYbzN3rLWZqLh/tQ/Pj2jb3/s8VKl6avL2u+K67O6xP2TBS1+98XylcaVWfEqKB723Jsw5CGpy+5xzdmjSduja0I6asKifEpYHdjrgY8GPQr//sG3PQu8QqzWfDg3N/1kLDwdxtcdNRHyAc8/8oTP0+ZwzhWGoBqs0DXjBs3QVo+pFSBNSZetpNjreL+NdpN0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OEHVTvMDGYptNN2602IY2JDvDQVXb3NSiktmJoAmhI=;
 b=CKTwwn7/JfIK0oTudSHCX9rHNblLjBv107JnQbuj93tlKiXxqOMwZv6R+IMyUyiLIUik8zj25IA/JorYnbA9ZZjq/frMrof6G4AwqgynB1MiFl7qYb5LzhhMRTFwEo2Kqw8j+fF6Yfc5Le9c3CsBwWz+8+TzJhgJqLSVB0BAmCwLLfoEaD3i8sjyLJQT2d7Drar7OrpuZR3C2F3LA5+aaVh1MwifKBMCKpkdZ6JwM3yad8OB6Vd6u0+wl2wBLlMmbjmgfjLnaRiLZ/2koYYSeMbaqwU5Q96jbTb9d6PNQXDrqrTqmY7edtD1wbIXQ8OfpxrdR4n86XXQuPUHGX5/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OEHVTvMDGYptNN2602IY2JDvDQVXb3NSiktmJoAmhI=;
 b=qR0LJyFpX6LexHJnZfSS8LoszTSNQz8Y6tqdSU9AST8WJJfJBsUv0AK+5YeIoJ0jCBxfgSXpAstrxmhsMrwk1gfdLCulLmibLC8i51qIB73vhheD/GnTufrl5tE45/m255H/IaQ2lNsJUK+4jS7uUV8o+wpuHVNf3tJ4AI1kQLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4530.eurprd04.prod.outlook.com (2603:10a6:208:70::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 16:24:54 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 16:24:54 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v3 2/6] dmaengine: dw-edma-pcie: don't touch internal struct dw_edma
Date:   Mon,  7 Mar 2022 10:24:26 -0600
Message-Id: <20220307162430.15261-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220307162430.15261-1-Frank.Li@nxp.com>
References: <20220307162430.15261-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::31) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c48ee92-175e-4169-cf4f-08da0057030e
X-MS-TrafficTypeDiagnostic: AM0PR04MB4530:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4530EFBFB305AE91B4DD53EC88089@AM0PR04MB4530.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cd/FvEXAeFexA9vVDBdd47CVWqBUMoz3uzCxTO6au3Jkc/XDNhiR9SiVQeA7qbgCEWG/gtg4cdjieEUM1CvQbjQVBKXH/86k5r7P2W2mZVbQVtLeM/1DsKR+6k1tgu9KoRt780Xse1apVpp2Mh/i4CDcVE/2ZJuFHBvcBQfjprVuOJxJW/q8j8ofhmpvAp086sFXXTgE9Mm7KZuqnk7sE83Z3GtjAPhu612KGmPb2HV/x9HHh6dUzfr0v/amNQD/+Zkr1tYCMAvlAetm/ctWuc+yfkSmyUz9DIYIcOemzx/vfBGmVS1bwVjCBYn82Ki4cpzYG8MyMSswTf8+KnPKHpeRVIIfofIph+Hw9084p5441HdewjchxudTqnvKA8azCyvoPNoR7iTavurdYXH+b+tUCDr4HuLW8Vpgvl+6BmyUkR2A8cx2Bk0inNAgV5Frk5+zulUojOIaI7zaVr0RX/zeupCkUguQsHcnoqZGTHDW63lyFmMsWxQg+nVwDp3zDz+X+cm6G40zBsiw0KaUJ3kHmVUBRJVu9KlLvKUOl0DYhVhZhGiNY3glMQBrDzYQQCwMrJnzX4oHHWqjlPlF1PuGN/dkmaQDDziUxN/c8ZJibHLtZucN+EatR02G3YRGSChSZM2nFNU0AZmUQBhsPmUyBOkb1o1LhkWEaaiDgp4BrihO6DBxWD4AKbKFNWN3clRGFXnL+g+x4nhwcVjloA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(316002)(36756003)(83380400001)(38100700002)(38350700002)(2616005)(1076003)(26005)(186003)(86362001)(8936002)(7416002)(5660300002)(66476007)(66556008)(8676002)(66946007)(4326008)(6666004)(6512007)(6486002)(6506007)(508600001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O0jbhZAwTD6v9DPnKdChy93vo/BqLsm9uEPah5WPvjYio/353HZryDD5kUkW?=
 =?us-ascii?Q?YAyFLv9a23XDASMXaQ5nRcSyXfYrOAbOk7Ngvd2I1/YVCo1t9rmSjDQPrWZI?=
 =?us-ascii?Q?aVv6+BPfSScCXgcQPkXTRtzOsqXO6auNO9QktxY+4LoekUw37UbnUZB5kG43?=
 =?us-ascii?Q?X3zBdc/lvJaPalSZdQTjG9ntrmmZXy9lJgiInAI4njQoKAKXzMZHGDLs+ict?=
 =?us-ascii?Q?EFc3GRrsVpFcq4hHJWdZD2X0NWg5ecRh5njhE8TVQHT+/f9YusVzJx9qa3yK?=
 =?us-ascii?Q?a7pgw0U7S+huqsWtwedDTqvhY7AiRrqjeWUNMJeIa/lkhCsPCJUyIu1C0SoJ?=
 =?us-ascii?Q?uM0eOslmakWPxyni3pph9YS0PtdmwpXYAhcI0IKArfxBcZquO/lvnMUfFBWd?=
 =?us-ascii?Q?8PxVMmoX+XoG3MCqRAd4FvVs0hO1K+u3bN7CQoZ2M/LgxQ9xWW30/3hT5I1U?=
 =?us-ascii?Q?MznUshAG9X8ZRGKCI0cRFN4Ygkb+Tz1VWnR9fw+lMc/q0HqsvrD/T5aSZtQF?=
 =?us-ascii?Q?Z8SKbjStJr8mf7Vx9bk+HSRSYjVaoKAEiTMYgDvLfL0/Wb7Q1J1JMPBnt5Ie?=
 =?us-ascii?Q?2xJMeILCwX1VmeBGpKH3oyz9rgWEuv0sVjUbfVDhryYseG9det04ElyRlB7D?=
 =?us-ascii?Q?U8zB1lZ9T54nFTIlFMUuDlv/i35pcG81XNAU3nNt40j/aYqM6VQm9TUDH1FD?=
 =?us-ascii?Q?mA7O5b3Mu4aW5iumHWxgJW7HOYpUmg17AoYQNB9Lc74B+2uZpLwSkwyZ0cjL?=
 =?us-ascii?Q?MTG17EvviXSXJIOrQlCclo/CJLYU+C+Pu4zHSKxGDFHgDWsBEbD69nSteAj7?=
 =?us-ascii?Q?gcdWwY7q4qic7kVhbfw2bOs6vgawqCq6of0HPoJg9iSsb1D0cfFRknCJYRj5?=
 =?us-ascii?Q?O13t4Fb+1wlorod9VKTIv5MJ4Vvf4+uyNxYUDc6FCiJ+v1N9iKurCI0U9/7r?=
 =?us-ascii?Q?kF8hevkbkrqI/0b2EW8/PDoP+MeCK1DYHre8+LDT10TQF+nVRFrNyyY4/pFc?=
 =?us-ascii?Q?R5pW+ldJO8sGHDgA+aSO99/ppkWAbOGrEJj80UwwC8ilfEJrS20weNA1yyur?=
 =?us-ascii?Q?UHps9z8MIzXPPNdUOM809u7MM4D15k+oQiL/3xefy8Q3bwgVpWbZSBb0gabW?=
 =?us-ascii?Q?/HJ19Yf7VM/x7Fq4FYK6lEsmxtizc2bwtKe5vkKwSxcHUSwoi5gKnGvjGmtv?=
 =?us-ascii?Q?XjnAmYZSGgFkJ/Iv9UamYPmlKaNQt4g7AxOXkRbmd0iSkCgW1tyY8O7EeD7W?=
 =?us-ascii?Q?csrsaTlsCAOOv7JJNkquGg6FXqDvGCfzh8d+0P3pqpeLl+JqcOEong3r/CW6?=
 =?us-ascii?Q?MX3jZSJzCyOmb/S55lAVoXkXedwyidbuNhUnBi2WOrOIyf51Iq3sCXlZpRJY?=
 =?us-ascii?Q?VYkVFl/FrLf9tj2tFD7u1z1gENQRkl+N/Xhc4LoBGfs9MYR8r0MC6MrnwVRP?=
 =?us-ascii?Q?o+XISmSwT8bQS9/zyAizQWFTcvX/OPpyUhVcMVzvBki6aMsWzB1psl7VEa7t?=
 =?us-ascii?Q?PAT4LDwCUSvy6jrujWENGEIikH2wHNxIb/xvHTRV52CYLtDx5shECHHSm271?=
 =?us-ascii?Q?fPOxdhQ7lp/+CedVW70AKcqjVCaSICVWqSSBhCfe4L6U6679NDaRJQM6l305?=
 =?us-ascii?Q?OiESFXK2MUyjQqqHON7R8n0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c48ee92-175e-4169-cf4f-08da0057030e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:24:54.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7201T7JWdDAN63v3V0W2/rPipAdCVCYj+uJCO/QKtLaSiCjK075aQDOXE1Cg32aead6v6Wt8Ct1Zk0PjA50XGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4530
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
Change from v2 to v3:
 None

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

