Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE74C9C1E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 04:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbiCBD1z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 22:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239346AbiCBD1z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 22:27:55 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20067.outbound.protection.outlook.com [40.107.2.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18DA6660D
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 19:27:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYJPRf6mXTib3OKfL6Uz/3hXNYROPQgYneiE4WXJS+Ri6twd8/dd5oEJS7BXcNS8O+ZJDZcQg2PcATNRidS8VN+p6nN9U7Wztwhb7rcfMVVSUygfkm0NJl7bBfCUNceHq36/GMAVEn9eLGfDMuLeRE1165ZbLbSGZTvKhQdbz7A/PSJ32y3cqo8+4bh7Hz5/ZV0dxAyfW8DUZ1cOrIAQ2770E8QG1DB7YngykAlKiLmusrGvEwkF7j6KrErudktfSEeTRxFCM/xtHiVDj9V93EtgT87xZskW4PhE/872OQEDcasCOYTHhQf+FWU5UkcE+Bd7E0v892nLQgNJdoX/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnsgH49SmFmF3N/boLNirwmQJv7YpV2RG4ZmnyGlNeY=;
 b=mhrimRSFpHueIw0Jxs/xVcbe/Vn5edKmx3uVAZj56SWEItIuVSHvslEv7dh0jNnJjVbw+0IrNVT2MMdPZOkstSbP+y8t3r4zFm1xLTCVYfQaqnE94V5kR/mORVfugXYVtQzJ1QZIFN9Cpk3R0OMEEvETAJDUu6raOSpoAjOzjZGzjDWFIKcE2aqaMqTodmu3TwhrLyHTLXR+TYskCqhkegyTGDwWlqFi40jOcGPLmBkHLgXtPXHY0UXPTK6Qll3z7ZzM+1EbOkFWRrGps7z+6g7iEeFhF1hItTV5FoAd2Ru/ZTqG8Fjh0n0CelKUl+SZJ5jn38dNF2hyHtFVzIfy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnsgH49SmFmF3N/boLNirwmQJv7YpV2RG4ZmnyGlNeY=;
 b=XoZWIu6nxONniR4XsFwLIW4NDiG9VhstRwlgfjbA4IZZpzFK0n+z9Cztla1eQf8Dy0g8EbfXnlOVK+0ryejxj0m+QumYa2EfP9v9x22i6K3eOXwEdbxUsZPdB5XcJnLrROc+3SkqSr60EMpUCvwIMVSK/XtzQslZmbTWl9D8ePw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB5926.eurprd04.prod.outlook.com (2603:10a6:20b:af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 03:27:10 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%6]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 03:27:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org
Subject: [PATCH 2/5] dmaengine: dw-edma-pcie: don't touch internal struct dw_edma
Date:   Tue,  1 Mar 2022 21:26:43 -0600
Message-Id: <20220302032646.3793-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e92b163-8c69-4540-63b1-08d9fbfc88e9
X-MS-TrafficTypeDiagnostic: AM6PR04MB5926:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5926B92E0229883CC047211488039@AM6PR04MB5926.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Okvjj4Opz/LiKSE8iScLkq6diYLVBK2cVTssdJP8lmRecUsB0Q+SFXuMmFyjRNsQKJJJbzFZJnyjPPDGcWV84sD4WdjeRmAfnnxrMaZ+FY1sdrWVwYPPTqcJuNmUpOyJ/5J38te8CEQx03WlqhUgCCkWKEnMFDwanyQUpzB5xN9R8WG5NrYtrJ/hsdBMft3+IJpR6hm20camKnSl6DleKURelYoKsK/WMpcoZ/Kapcvl9oAE/K85PC79Z2RMUOYa9msLiW/szHmSHD5goHfiAFZe3fyhlltazLx2KG8Mjp+JGVvuVeRfbsrDg7RMYqAozSsh/fzKlEZONGuKHA7YnKcziyuD+wWM8sVjilzEQ8JONifsBgLovHAPwiWZe+n2XCYA8vxZMRcN9co42R2PotgZEABciyxcZpPVDC88HBkiGHTCFozfEp+33TaxcPG2ogHSBS5pMC0JA0yPKE+rA9OzN6ww01sixtTPhQpCv//TvlO7q0gN+P9oajONDfD/kAAXwBq329FYmZW1aW2Yigr54ftxLq/DQscQFmwpQfpSDh6qXMuNzfG269LieTr6GkUwZJFfxRoZ4DomZwjOrH09OAesHa2G52gCyoaodPbNn8SeBpxaPp+hK9rPj83AofXDd7p5LbUjMzKEkVNy/Qe+yBhvPxT3NJ9k8uYXz0mvob2hfGvqf7LLotySDr1SarU/+AFS4gkoiZYr0F/dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(86362001)(66476007)(38100700002)(8676002)(66946007)(66556008)(4326008)(316002)(5660300002)(2906002)(7416002)(8936002)(26005)(2616005)(1076003)(186003)(83380400001)(508600001)(6486002)(52116002)(6666004)(6512007)(36756003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NoE46sfE6CNdgrbae/u7Il3HaFFet5Zwn9H5lUO6ZYhjjXINcbIdm6i+Eaph?=
 =?us-ascii?Q?Oq3LQa4pdNrblHqG06xIGQdADKZojBeXafAhg60xPT1X1/jsKaT0QSsPZOna?=
 =?us-ascii?Q?CbsRoe0F2YvGS451EB4Hy/4GYX9lNpUpTpifwwiww8v8x0gdzAVDtNxe6D/I?=
 =?us-ascii?Q?ZdU9W2uCNJkHu3D7185HNeWIrRyeyQfdFWy/qbLusQ2PDjCRrDNIdAV2R/A3?=
 =?us-ascii?Q?Ttzy8XPz8nMvgmqOsC84FCSMQGHdPB6HKmI9x9RXLOhizGjUanOwTaKOMwvW?=
 =?us-ascii?Q?yHPyaUE0pW9iczaF+xmWt4hBQDaE6M03NkWyPqvbb/+xBp2cRofejZ16I8Vm?=
 =?us-ascii?Q?pPvFohShsvALFIoBqr/wFROtqS51818w6dPZF7Klfc+kPftHdR5vR1GD+Hyh?=
 =?us-ascii?Q?SjHky2E+UZAGWci4HUmuJB2H1IaA3JO3oPogpfVAzRditFwXMPxS+deSwb+1?=
 =?us-ascii?Q?t6PxhqjHGePeB+SmYqdklQYsvwF1u9MskmX//Y+f+5tGdMe5rz16YV49KMff?=
 =?us-ascii?Q?wFOag8F95BcSGTmUfpLtZ+ts3grlKunITr8hE8NpfqDZ8+/LSCN35OFbAgaf?=
 =?us-ascii?Q?eQBtp7CuJs+VWa5aL2E5wwzfDNXCmq+xKADyFXZ7+ajgn13hbuWdKXi2Ldzs?=
 =?us-ascii?Q?P7NE/nxBd8bIBLPFY7pwAx8xWrtIafIvdy7thHJ6ysAnt+HzJZownHAYLeyZ?=
 =?us-ascii?Q?6uFQgjU4ejLfscBQiCWzXY6Rj9EN2lpui+3WsCBgF4xAapHzPH4SSHvZmTQC?=
 =?us-ascii?Q?H1NC9JR57mSVvAZyH1sOo7x9NzIwud4bL7L0merALNSPYVHPeaQ4MZW9zs1/?=
 =?us-ascii?Q?ORpPtweONlDwKkHoY4PhGhlwrlNRMEbq8pKICOcJxUqAj2TFQfxJO4fSVhn6?=
 =?us-ascii?Q?WM+YAk87LJksVaWj0fgVMiYXw7O+oCMW8wqok2edEBc0/+QYFkNxEWYXqMZL?=
 =?us-ascii?Q?kSiTbWuHhaN+xxzL8hIEZA4WcZTzGQJXuxbSsCKIV/NxO6fZXv4WoI+2Ln9Q?=
 =?us-ascii?Q?bewXn83rcIxbI4ZpMtRZTw1s5KWmcSeMyVDHkOX84MmHRx5ISwrhBftR2rgg?=
 =?us-ascii?Q?Uq8zDpSpE+FvSNjhjlQIKN4UPGBkFdcdGvOBUaUo5VHEXv98M4uInRuLbLWx?=
 =?us-ascii?Q?1DMYF6K6W6ycbvLwDmAbOgSBsfd1zV4dx9TIJvWmu2ygz/giGzFk6IVIUcAG?=
 =?us-ascii?Q?Gd7ckB5makukr+xQfRnwSkD4S+kIcP2EbwUYW4thh4dNhvtz96jMTHxeyiiF?=
 =?us-ascii?Q?XHBvEikbw1r7Mji3+H3R6t5uRbW4yc6ondQkDb/livVvkXxUrq6chJF0XeFD?=
 =?us-ascii?Q?hyNNj7AddpZLG3cQSYsIpiIJmcKHcMdzS9V3wqMoagdPORgPRQVZf6nnc6tw?=
 =?us-ascii?Q?KjpsDAVmeneAcQAQ8lhesogG1kM8iculFTDOaVnxmPT3sBzrNRKugKrB6N5M?=
 =?us-ascii?Q?i92/4xfoJop0Wy8QhYdzesLWhGyLIWG0+whMGGJgZbRTibSvoQ8wF529ZEW4?=
 =?us-ascii?Q?0Gszke6bN/YDSN3fPdttoQ/N1SMeZeUj32MjJe+8wz6DEpxqPUuZMfL54e9T?=
 =?us-ascii?Q?XbnlcaIr+SykOSJB/XPEmildrhbJdTOnIjfk9tzwtO5EIWS9RzGrCwm+OI03?=
 =?us-ascii?Q?HpW6KO8tnPnOmtbBUIrUGhI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e92b163-8c69-4540-63b1-08d9fbfc88e9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 03:27:09.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjnC+yJ2Jb63sSov73bGyus+a8b8+2Z2gDuXzZtvQn8UepwcUGiyQCBka1AUykPQohiKipqz9MEjRuS+oVhgyw==
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

dw_edma_probe() defined at include/linux/dma/edma.h

	@dw: struct dw_edma that is filed by dw_edma_probe()

dw_edma_pcie_probe() shouldn't access dw_edma, only filed
struct dw_edma_chip before call dw_edma_probe()

change all dw(struct dw_edma*)  to chip(struct dw_edma_chip*)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 83 +++++++++++++-----------------
 1 file changed, 36 insertions(+), 47 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 44f6e09bdb531..2262b1c196978 100644
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
@@ -228,29 +223,27 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
+	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
+	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
 
-	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
-	if (!dw->rg_region.vaddr)
+	chip->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
+	if (!chip->rg_region.vaddr)
 		return -ENOMEM;
 
-	dw->rg_region.vaddr += vsec_data.rg.off;
-	dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
-	dw->rg_region.paddr += vsec_data.rg.off;
-	dw->rg_region.sz = vsec_data.rg.sz;
+	chip->rg_region.vaddr += vsec_data.rg.off;
+	chip->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
+	chip->rg_region.paddr += vsec_data.rg.off;
+	chip->rg_region.sz = vsec_data.rg.sz;
 
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
+	for (i = 0; i < chip->wr_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
 
@@ -273,9 +266,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < dw->rd_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
+	for (i = 0; i < chip->rd_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
 
@@ -299,45 +292,45 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
-		dw->rg_region.vaddr, &dw->rg_region.paddr);
+		chip->rg_region.vaddr, &chip->rg_region.paddr);
 
 
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
+	for (i = 0; i < chip->wr_ch_cnt; i++) {
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
+	for (i = 0; i < chip->rd_ch_cnt; i++) {
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
@@ -345,10 +338,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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

