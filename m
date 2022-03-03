Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E9A4CC566
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 19:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiCCSrr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 13:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiCCSrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 13:47:47 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10065.outbound.protection.outlook.com [40.107.1.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7872419F443
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 10:46:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1azp6UDUSzXjTESqBzdBD9KLhCgWDmpBXkHToUjsMzpk+MPAEsm503pRySsnT+qqVAUdgoM+vGN5tn43Wn322OOrlHvzSn6OywXmOTC7evUmWNOBIV4J9iiG3HIwjnmO1KatoeW+Yc5OsbIJrCjpe6dpBkdMs9Nkv+L5ZVKNnOaN6qDiLENt7hqAnIgMHUaaK8Bt/SnCLCUk7N6cZZckr0fg9jGqzrqvQhXNZrMshMAsBG0dj4xG8ylVIP6uxC3gMVG9g5y/W8BXqdfYy2la/4phSu15sHUpIDYEPkoHh3JtRn1roTvB/Fd6Eir5F2H6N8maItBqfoFUHOsoi0JHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUCSMWcjbteEahLQ+irWLlaNpPmiLBygnyt56OUzxAk=;
 b=XArIOYWUWElXmVNdfNP9e2ef3lSQ/9v2rR4XDvOcZyiQytAkrRQjb/JcGUfddTdp/v2u+ZA8J/lFbWLWLxUyOuWOy0BYrnAXtTPYuvGL8EnPM0tFOHlxpWaY+Y8aw6IkzvAhLgqeBH+lECmNzuz3pvRUP61j0e69Bc5SvtxfiObDg0O4z4zw/BFQs9BqUaLcA41LykdtXQjIK4xr5k9mX2UgbMp29gAt5bHcofDnh/l9GkdYJmWqDIMIuUONznEgt0g9qtqkatmHO8KocE1w8KtwP5dAwOUyrgYi7VSMz4AeoSDfCXXtHiM3F26Mp+iv9vwKoWP0KHuPQ+fZQPzbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUCSMWcjbteEahLQ+irWLlaNpPmiLBygnyt56OUzxAk=;
 b=KkKPIdIa8f3lpqRPDSo8quLhsmDC4Q52jq7l216Lk2r1UsDoc2uLM4DQyDDKuqfI8MJK4CMeboH7eiiGnqziXttkAZfDk4B9quZkuJiJwwpSWnlK0ONUyCWdr8gQnrm45dgsYAadnRoUagApVg4olBaErgoxAZT3x2PdRb7ewg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 18:46:56 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 18:46:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v2 1/5] dmaengine: dw-edma: fix dw_edma_probe() can't be call globally
Date:   Thu,  3 Mar 2022 12:46:31 -0600
Message-Id: <20220303184635.2603-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be69819c-c8a0-424d-0c18-08d9fd4630e2
X-MS-TrafficTypeDiagnostic: AM8PR04MB7827:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB78279A13ACC615BECE93194488049@AM8PR04MB7827.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqBdq7ikYjMzsFA7gHPu227wp5JQDdyqyrGESHVmbP1i5faqL0ULdqxEOTvYXRyWYcIPuwduAlz0SpNs/xcxBsK7wYBKlnOSPYxCrOg680aFUGjs7zHOR/N8fAbKBe6/MwscdlH5MlAFE7nrmGgRCYUF/jmFQ9hjtxYLuhlYUVCAM59PBEeo1zkWOqghHr92wbKt90Q24+cACVJdHBVsxs7PzYnpKsGsRla/nzDylEvYMaP+De+lasNNwryJB6ecDcAqEyz7mqhx1dbUYE4n5ZRkAuun3UAATguiLS1FhYVypS/u5DDXdbTbiasQe2L9p+I7jJAW84rSDtp4qCyhrbaEqGYEyplEdm8KonDxFd4eaeXJukH55NIanGBye4/hOneL4ffwCJQqruNY3wonc9BX3dGPAq+e9A7GGAJogkT6n9vc3PKhrHaOI2yISu0Yej3cnt724ZLw7XKbir4YvJ2PZi/tFAijyTuW7H12MYyg7zHmu7L3cH/VAo8Zxj/nQnbO6KE4RZ9d1sQenqAT+9oKEEZevFdHJrxuK2hWE5S9SE5kBsJ81krgPF1xJzN4QPEpgGNBJYj9ThRJHlMwdpx+2N/ay8vp2AG+NQnHIBVkBqD037+ZwHilMYJWoMNosMkTzF2URP30utvdklegKmwyJXSw7j7/vQV1x3cboPkr+OGhk9Kp3lxwDwU5qW6fIwebwi1/St6LsBrHRASXlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6486002)(4326008)(86362001)(36756003)(8936002)(6666004)(6506007)(26005)(5660300002)(30864003)(498600001)(52116002)(83380400001)(8676002)(2906002)(66476007)(66946007)(66556008)(186003)(6512007)(1076003)(2616005)(38350700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGxa0p9FeC0MY6JSCGGuBDf+w8fzfZYX7sr3saKNEfnjVCVsuKQxjZ7fWzxi?=
 =?us-ascii?Q?NphjjN4XvCouQnQDaoR2wqio5/5YSuO1JIIuEBCxb+RpQGZsyvNjuuSEoQ6C?=
 =?us-ascii?Q?kY9gtjGWUsmGXlhBnlmMBCwF46i0MRK2ttAmHvEFWigvV4GqGRY9itP3IckR?=
 =?us-ascii?Q?g4yCsEiFemYP8YpE6hBdfmwXxpPBBkdNBj3taU2kgRmOiZNXzWtz9ibOr2J+?=
 =?us-ascii?Q?223jwfzKg90X5AcqF0fsL6Dv+CzHN1MEbmupZCk5TC5d22b2O0Cum4JfRIiV?=
 =?us-ascii?Q?SXu0um/usEcMCJDvWL3DAQ0s42kgQ+Qf3vgyrYe8uNivl2oRgWHWX7RP1Wrx?=
 =?us-ascii?Q?XlgghQ8TtNis12smZ0QCKgIneNAzOHlUDEKwEM5384EZZH8jqf/lk3F60ebR?=
 =?us-ascii?Q?PaJ+fLVG3Cr5E+jvSlrRky20t8lAbSQOByNf4rve1OqGQ62NQbre/dfPgC6m?=
 =?us-ascii?Q?T//7jyV8hJFwqlNciwsKa9kNddpfDU4onH7TRsr5B5VB2XTuSVK2DZjV4PMz?=
 =?us-ascii?Q?h+oiKYhvKRIWjHqwwkW6uB8+Qu9WH4twltcJuQBT09mZFKCt4EurnfzZj/wJ?=
 =?us-ascii?Q?e4F63S8inO1cdkhwWf2Rbwm5yq1230qeAxORNx93x+VjO9L8wGmcKeWctP9S?=
 =?us-ascii?Q?4DwlNdLY0x1SDrlyUe/tsqGNhH/roNHI7H38WbcO/bd4Vm3oUw+H/fXoIIhF?=
 =?us-ascii?Q?JT7TOfYv4DNCnqkaoTwnssuekx/5Sb9qBmTk7F/3yLRqZPyPa0VWBsLi0oMF?=
 =?us-ascii?Q?V7g7PzRxEgmVRWOg3TAXbctyQa7m/sO8As3AvCfyuUZKuVMdCDwAabfXmWX6?=
 =?us-ascii?Q?5figigTlp9J4z1Hv9ZPt0LZE4+HEYnbkloyM7pdL9Qz+YfjEAzHSxQplOO4Q?=
 =?us-ascii?Q?2iRS1z2/wMWKLrMSYXqhDPEAl9vU+58gU+U48J5PkygiJKAmmV3O1tJ2mD7e?=
 =?us-ascii?Q?bYxUPTfi6hncE4u2w6dI/lSxeMNZQTEGbwNRqy5V/D3v7FNqc1CmIRZa8MBe?=
 =?us-ascii?Q?f5Jzj3ZRzPXOI/jleV5r/ksl5WngGE2hBTngqJxOjMZuO+8DTtaFBkpGLm3b?=
 =?us-ascii?Q?kJs3LHub59g68byleqMuDgkn6p7pE0JtR5aEy1h9JSOeqBAdoAp1UvfMgxaY?=
 =?us-ascii?Q?Tt5wohdw+VhoPq34HM5Syyf9HtvELnMw8+E6pMMuCpz8VjrcR9/kN/fXD0up?=
 =?us-ascii?Q?kqwqopV7EaYy4o+DJrxd868q0Pn9VQ8uZz9wsr2i5Z0kBoikWoyxv/U4Vhrr?=
 =?us-ascii?Q?VcC8VMcTMhWIvgKDl9QntAmkb40qnipUqMCTHUASuUsFmHVBMkJAOFjh4uYL?=
 =?us-ascii?Q?a+dXJe+mfXuo10Hwo5XbmPQTVP6TRwyv4mf/p359kjGqpxXYLgtO6kIY+bRo?=
 =?us-ascii?Q?eV16XNOULwYiU5qVgjmBQZjkpyEVBV1egPdDkbxKStYueyLdjXmdoh6UIhzr?=
 =?us-ascii?Q?CBJEOweWMtOk7XG1fy9NPbiej35UWGhCicqLufQE4ahtIGbtFDpnLouSmSW7?=
 =?us-ascii?Q?+wTRTpkm+B+P5EPwuVjodjZ3A6imPEO6c7gbIedqYWBJG53AgxF5mUCURWqS?=
 =?us-ascii?Q?OWQHswRqxWc7fq5GqlxtfrtaqfaW2zK935H/ueNdIQnFsAKRCxpY8bSHPy+G?=
 =?us-ascii?Q?UO9zORfr/nhIlL2QUruMDV0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be69819c-c8a0-424d-0c18-08d9fd4630e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 18:46:56.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STsC61w+HQYPmPMjt1l8xIOx5zhjbul51IkpX8hG3VBnao+4dn+oKwFCXkPKZNBq3C9OHLksdmspGw0rBVWfcg==
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

"struct dw_edma_chip" contains an internal structure "struct dw_edma" that is
used by the eDMA core internally. This structure should not be touched
by the eDMA controller drivers themselves. But currently, the eDMA
controller drivers like "dw-edma-pci" allocates and populates this
internal structure then passes it on to eDMA core. The eDMA core further
populates the structure and uses it. This is wrong!

Hence, move all the "struct dw_edma" specifics from controller drivers
to the eDMA core.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
 - rework commit message
 - remove duplicate field in struct dw_edma

 drivers/dma/dw-edma/dw-edma-core.c       |  91 +++++-----
 drivers/dma/dw-edma/dw-edma-core.h       |  30 +---
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 206 ++++++++++++-----------
 drivers/dma/dw-edma/dw-edma-v0-core.h    |   8 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  37 ++--
 include/linux/dma/edma.h                 |  47 +++++-
 6 files changed, 230 insertions(+), 189 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 53289927dd0d6..0cb66434f9e14 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -65,7 +65,7 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 	struct dw_edma_chunk *chunk;
 
 	chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
@@ -82,11 +82,11 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
 	if (chan->dir == EDMA_DIR_WRITE) {
-		chunk->ll_region.paddr = dw->ll_region_wr[chan->id].paddr;
-		chunk->ll_region.vaddr = dw->ll_region_wr[chan->id].vaddr;
+		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
+		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
 	} else {
-		chunk->ll_region.paddr = dw->ll_region_rd[chan->id].paddr;
-		chunk->ll_region.vaddr = dw->ll_region_rd[chan->id].vaddr;
+		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
+		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
 	}
 
 	if (desc->chunk) {
@@ -601,7 +601,8 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
 {
 	struct dw_edma_irq *dw_irq = data;
-	struct dw_edma *dw = dw_irq->dw;
+	struct dw_edma_chip *chip = dw_irq->chip;
+	struct dw_edma *dw = chip->dw;
 	unsigned long total, pos, val;
 	unsigned long off;
 	u32 mask;
@@ -616,7 +617,7 @@ static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
 		mask = dw_irq->rd_mask;
 	}
 
-	val = dw_edma_v0_core_status_done_int(dw, write ?
+	val = dw_edma_v0_core_status_done_int(chip, write ?
 							  EDMA_DIR_WRITE :
 							  EDMA_DIR_READ);
 	val &= mask;
@@ -626,7 +627,7 @@ static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
 		dw_edma_done_interrupt(chan);
 	}
 
-	val = dw_edma_v0_core_status_abort_int(dw, write ?
+	val = dw_edma_v0_core_status_abort_int(chip, write ?
 							   EDMA_DIR_WRITE :
 							   EDMA_DIR_READ);
 	val &= mask;
@@ -718,7 +719,7 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 	}
 
 	INIT_LIST_HEAD(&dma->channels);
-	for (j = 0; (alloc || dw->nr_irqs == 1) && j < cnt; j++, i++) {
+	for (j = 0; (alloc || chip->nr_irqs == 1) && j < cnt; j++, i++) {
 		chan = &dw->chan[i];
 
 		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
@@ -735,15 +736,15 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		chan->status = EDMA_ST_IDLE;
 
 		if (write)
-			chan->ll_max = (dw->ll_region_wr[j].sz / EDMA_LL_SZ);
+			chan->ll_max = (chip->ll_region_wr[j].sz / EDMA_LL_SZ);
 		else
-			chan->ll_max = (dw->ll_region_rd[j].sz / EDMA_LL_SZ);
+			chan->ll_max = (chip->ll_region_rd[j].sz / EDMA_LL_SZ);
 		chan->ll_max -= 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
 			 write ? "write" : "read", j, chan->ll_max);
 
-		if (dw->nr_irqs == 1)
+		if (chip->nr_irqs == 1)
 			pos = 0;
 		else
 			pos = off_alloc + (j % alloc);
@@ -755,7 +756,7 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		else
 			irq->rd_mask |= BIT(j);
 
-		irq->dw = dw;
+		irq->chip = chip;
 		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
 
 		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
@@ -767,13 +768,13 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		vchan_init(&chan->vc, dma);
 
 		if (write) {
-			dt_region->paddr = dw->dt_region_wr[j].paddr;
-			dt_region->vaddr = dw->dt_region_wr[j].vaddr;
-			dt_region->sz = dw->dt_region_wr[j].sz;
+			dt_region->paddr = chip->dt_region_wr[j].paddr;
+			dt_region->vaddr = chip->dt_region_wr[j].vaddr;
+			dt_region->sz = chip->dt_region_wr[j].sz;
 		} else {
-			dt_region->paddr = dw->dt_region_rd[j].paddr;
-			dt_region->vaddr = dw->dt_region_rd[j].vaddr;
-			dt_region->sz = dw->dt_region_rd[j].sz;
+			dt_region->paddr = chip->dt_region_rd[j].paddr;
+			dt_region->vaddr = chip->dt_region_rd[j].vaddr;
+			dt_region->sz = chip->dt_region_rd[j].sz;
 		}
 
 		dw_edma_v0_core_device_config(chan);
@@ -840,16 +841,16 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
 
-	if (dw->nr_irqs < 1)
+	if (chip->nr_irqs < 1)
 		return -EINVAL;
 
-	if (dw->nr_irqs == 1) {
+	if (chip->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
-		irq = dw->ops->irq_vector(dev, 0);
+		irq = chip->ops->irq_vector(dev, 0);
 		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
-			dw->nr_irqs = 0;
+			chip->nr_irqs = 0;
 			return err;
 		}
 
@@ -857,7 +858,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 			get_cached_msi_msg(irq, &dw->irq[0].msi);
 	} else {
 		/* Distribute IRQs equally among all channels */
-		int tmp = dw->nr_irqs;
+		int tmp = chip->nr_irqs;
 
 		while (tmp && (*wr_alloc + *rd_alloc) < ch_cnt) {
 			dw_edma_dec_irq_alloc(&tmp, wr_alloc, dw->wr_ch_cnt);
@@ -868,7 +869,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
-			irq = dw->ops->irq_vector(dev, i);
+			irq = chip->ops->irq_vector(dev, i);
 			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
@@ -876,7 +877,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 					  IRQF_SHARED, dw->name,
 					  &dw->irq[i]);
 			if (err) {
-				dw->nr_irqs = i;
+				chip->nr_irqs = i;
 				return err;
 			}
 
@@ -884,7 +885,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 				get_cached_msi_msg(irq, &dw->irq[i].msi);
 		}
 
-		dw->nr_irqs = i;
+		chip->nr_irqs = i;
 	}
 
 	return err;
@@ -905,18 +906,24 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (!dev)
 		return -EINVAL;
 
-	dw = chip->dw;
-	if (!dw || !dw->irq || !dw->ops || !dw->ops->irq_vector)
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	chip->dw = dw;
+
+	if (!chip->nr_irqs || !chip->ops)
 		return -EINVAL;
 
 	raw_spin_lock_init(&dw->lock);
 
-	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt,
-			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
+
+	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
+			      dw_edma_v0_core_ch_count(chip, EDMA_DIR_WRITE));
 	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
 
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt,
-			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
+	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
+			      dw_edma_v0_core_ch_count(chip, EDMA_DIR_READ));
 	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
 
 	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
@@ -934,7 +941,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
 
 	/* Disable eDMA, only to establish the ideal initial conditions */
-	dw_edma_v0_core_off(dw);
+	dw_edma_v0_core_off(chip);
+
+	dw->irq = devm_kcalloc(dev, chip->nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
+	if (!dw->irq)
+		return -ENOMEM;
 
 	/* Request IRQs */
 	err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
@@ -960,10 +971,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	return 0;
 
 err_irq_free:
-	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
+	for (i = (chip->nr_irqs - 1); i >= 0; i--)
+		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
-	dw->nr_irqs = 0;
+	chip->nr_irqs = 0;
 
 	return err;
 }
@@ -977,11 +988,11 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	int i;
 
 	/* Disable eDMA */
-	dw_edma_v0_core_off(dw);
+	dw_edma_v0_core_off(chip);
 
 	/* Free irqs */
-	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
+	for (i = (chip->nr_irqs - 1); i >= 0; i--)
+		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
 	/* Power management */
 	pm_runtime_disable(dev);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 60316d408c3e0..885f6719c9462 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -15,20 +15,12 @@
 #include "../virt-dma.h"
 
 #define EDMA_LL_SZ					24
-#define EDMA_MAX_WR_CH					8
-#define EDMA_MAX_RD_CH					8
 
 enum dw_edma_dir {
 	EDMA_DIR_WRITE = 0,
 	EDMA_DIR_READ
 };
 
-enum dw_edma_map_format {
-	EDMA_MF_EDMA_LEGACY = 0x0,
-	EDMA_MF_EDMA_UNROLL = 0x1,
-	EDMA_MF_HDMA_COMPAT = 0x5
-};
-
 enum dw_edma_request {
 	EDMA_REQ_NONE = 0,
 	EDMA_REQ_STOP,
@@ -57,12 +49,6 @@ struct dw_edma_burst {
 	u32				sz;
 };
 
-struct dw_edma_region {
-	phys_addr_t			paddr;
-	void				__iomem *vaddr;
-	size_t				sz;
-};
-
 struct dw_edma_chunk {
 	struct list_head		list;
 	struct dw_edma_chan		*chan;
@@ -106,11 +92,7 @@ struct dw_edma_irq {
 	struct msi_msg                  msi;
 	u32				wr_mask;
 	u32				rd_mask;
-	struct dw_edma			*dw;
-};
-
-struct dw_edma_core_ops {
-	int	(*irq_vector)(struct device *dev, unsigned int nr);
+	struct dw_edma_chip		*chip;
 };
 
 struct dw_edma {
@@ -122,19 +104,9 @@ struct dw_edma {
 	struct dma_device		rd_edma;
 	u16				rd_ch_cnt;
 
-	struct dw_edma_region		rg_region;	/* Registers */
-	struct dw_edma_region		ll_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		ll_region_rd[EDMA_MAX_RD_CH];
-	struct dw_edma_region		dt_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		dt_region_rd[EDMA_MAX_RD_CH];
-
 	struct dw_edma_irq		*irq;
-	int				nr_irqs;
-
-	enum dw_edma_map_format		mf;
 
 	struct dw_edma_chan		*chan;
-	const struct dw_edma_core_ops	*ops;
 
 	raw_spinlock_t			lock;		/* Only for legacy */
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 329fc2e57b703..6e2f83e31a03a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -23,92 +23,94 @@ enum dw_edma_control {
 	DW_EDMA_V0_LLE					= BIT(9),
 };
 
-static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
+static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma_chip *chip)
 {
-	return dw->rg_region.vaddr;
+	return chip->reg_base;
 }
 
-#define SET_32(dw, name, value)				\
-	writel(value, &(__dw_regs(dw)->name))
+#define SET_32(chip, name, value)				\
+	writel(value, &(__dw_regs(chip)->name))
 
-#define GET_32(dw, name)				\
-	readl(&(__dw_regs(dw)->name))
+#define GET_32(chip, name)				\
+	readl(&(__dw_regs(chip)->name))
 
-#define SET_RW_32(dw, dir, name, value)			\
+#define SET_RW_32(chip, dir, name, value)			\
 	do {						\
 		if ((dir) == EDMA_DIR_WRITE)		\
-			SET_32(dw, wr_##name, value);	\
+			SET_32(chip, wr_##name, value);	\
 		else					\
-			SET_32(dw, rd_##name, value);	\
+			SET_32(chip, rd_##name, value);	\
 	} while (0)
 
-#define GET_RW_32(dw, dir, name)			\
+#define GET_RW_32(chip, dir, name)			\
 	((dir) == EDMA_DIR_WRITE			\
-	  ? GET_32(dw, wr_##name)			\
-	  : GET_32(dw, rd_##name))
+	  ? GET_32(chip, wr_##name)			\
+	  : GET_32(chip, rd_##name))
 
-#define SET_BOTH_32(dw, name, value)			\
+#define SET_BOTH_32(chip, name, value)			\
 	do {						\
-		SET_32(dw, wr_##name, value);		\
-		SET_32(dw, rd_##name, value);		\
+		SET_32(chip, wr_##name, value);		\
+		SET_32(chip, rd_##name, value);		\
 	} while (0)
 
 #ifdef CONFIG_64BIT
 
-#define SET_64(dw, name, value)				\
-	writeq(value, &(__dw_regs(dw)->name))
+#define SET_64(chip, name, value)				\
+	writeq(value, &(__dw_regs(chip)->name))
 
-#define GET_64(dw, name)				\
-	readq(&(__dw_regs(dw)->name))
+#define GET_64(chip, name)				\
+	readq(&(__dw_regs(chip)->name))
 
-#define SET_RW_64(dw, dir, name, value)			\
+#define SET_RW_64(chip, dir, name, value)			\
 	do {						\
 		if ((dir) == EDMA_DIR_WRITE)		\
-			SET_64(dw, wr_##name, value);	\
+			SET_64(chip, wr_##name, value);	\
 		else					\
-			SET_64(dw, rd_##name, value);	\
+			SET_64(chip, rd_##name, value);	\
 	} while (0)
 
-#define GET_RW_64(dw, dir, name)			\
+#define GET_RW_64(chip, dir, name)			\
 	((dir) == EDMA_DIR_WRITE			\
-	  ? GET_64(dw, wr_##name)			\
-	  : GET_64(dw, rd_##name))
+	  ? GET_64(chip, wr_##name)			\
+	  : GET_64(chip, rd_##name))
 
-#define SET_BOTH_64(dw, name, value)			\
+#define SET_BOTH_64(chip, name, value)			\
 	do {						\
-		SET_64(dw, wr_##name, value);		\
-		SET_64(dw, rd_##name, value);		\
+		SET_64(chip, wr_##name, value);		\
+		SET_64(chip, rd_##name, value);		\
 	} while (0)
 
 #endif /* CONFIG_64BIT */
 
-#define SET_COMPAT(dw, name, value)			\
-	writel(value, &(__dw_regs(dw)->type.unroll.name))
+#define SET_COMPAT(chip, name, value)			\
+	writel(value, &(__dw_regs(chip)->type.unroll.name))
 
-#define SET_RW_COMPAT(dw, dir, name, value)		\
+#define SET_RW_COMPAT(chip, dir, name, value)		\
 	do {						\
 		if ((dir) == EDMA_DIR_WRITE)		\
-			SET_COMPAT(dw, wr_##name, value); \
+			SET_COMPAT(chip, wr_##name, value); \
 		else					\
-			SET_COMPAT(dw, rd_##name, value); \
+			SET_COMPAT(chip, rd_##name, value); \
 	} while (0)
 
 static inline struct dw_edma_v0_ch_regs __iomem *
-__dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
+__dw_ch_regs(struct dw_edma_chip *chip, enum dw_edma_dir dir, u16 ch)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY)
-		return &(__dw_regs(dw)->type.legacy.ch);
+	if (chip->mf == EDMA_MF_EDMA_LEGACY)
+		return &(__dw_regs(chip)->type.legacy.ch);
 
 	if (dir == EDMA_DIR_WRITE)
-		return &__dw_regs(dw)->type.unroll.ch[ch].wr;
+		return &__dw_regs(chip)->type.unroll.ch[ch].wr;
 
-	return &__dw_regs(dw)->type.unroll.ch[ch].rd;
+	return &__dw_regs(chip)->type.unroll.ch[ch].rd;
 }
 
-static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+static inline void writel_ch(struct dw_edma_chip *chip, enum dw_edma_dir dir, u16 ch,
 			     u32 value, void __iomem *addr)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	struct dw_edma *dw = chip->dw;
+
+	if (chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -119,7 +121,7 @@ static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			viewport_sel |= BIT(31);
 
 		writel(viewport_sel,
-		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		       &(__dw_regs(chip)->type.legacy.viewport_sel));
 		writel(value, addr);
 
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
@@ -128,12 +130,13 @@ static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 	}
 }
 
-static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+static inline u32 readl_ch(struct dw_edma_chip *chip, enum dw_edma_dir dir, u16 ch,
 			   const void __iomem *addr)
 {
+	struct dw_edma *dw = chip->dw;
 	u32 value;
 
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -144,7 +147,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			viewport_sel |= BIT(31);
 
 		writel(viewport_sel,
-		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		       &(__dw_regs(chip)->type.legacy.viewport_sel));
 		value = readl(addr);
 
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
@@ -166,10 +169,12 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 
 #ifdef CONFIG_64BIT
 
-static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+static inline void writeq_ch(struct dw_edma_chip *chip, enum dw_edma_dir dir, u16 ch,
 			     u64 value, void __iomem *addr)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	struct dw_edma *dw = chip->dw;
+
+	if (chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -180,7 +185,7 @@ static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			viewport_sel |= BIT(31);
 
 		writel(viewport_sel,
-		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		       &(__dw_regs(chip)->type.legacy.viewport_sel));
 		writeq(value, addr);
 
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
@@ -189,12 +194,13 @@ static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 	}
 }
 
-static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+static inline u64 readq_ch(struct dw_edma_chip *chip, enum dw_edma_dir dir, u16 ch,
 			   const void __iomem *addr)
 {
+	struct dw_edma *dw = chip->dw;
 	u32 value;
 
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -205,7 +211,7 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			viewport_sel |= BIT(31);
 
 		writel(viewport_sel,
-		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		       &(__dw_regs(chip)->type.legacy.viewport_sel));
 		value = readq(addr);
 
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
@@ -228,25 +234,25 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #endif /* CONFIG_64BIT */
 
 /* eDMA management callbacks */
-void dw_edma_v0_core_off(struct dw_edma *dw)
+void dw_edma_v0_core_off(struct dw_edma_chip *chip)
 {
-	SET_BOTH_32(dw, int_mask,
+	SET_BOTH_32(chip, int_mask,
 		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
-	SET_BOTH_32(dw, int_clear,
+	SET_BOTH_32(chip, int_clear,
 		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
-	SET_BOTH_32(dw, engine_en, 0);
+	SET_BOTH_32(chip, engine_en, 0);
 }
 
-u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
+u16 dw_edma_v0_core_ch_count(struct dw_edma_chip *chip, enum dw_edma_dir dir)
 {
 	u32 num_ch;
 
 	if (dir == EDMA_DIR_WRITE)
 		num_ch = FIELD_GET(EDMA_V0_WRITE_CH_COUNT_MASK,
-				   GET_32(dw, ctrl));
+				   GET_32(chip, ctrl));
 	else
 		num_ch = FIELD_GET(EDMA_V0_READ_CH_COUNT_MASK,
-				   GET_32(dw, ctrl));
+				   GET_32(chip, ctrl));
 
 	if (num_ch > EDMA_V0_MAX_NR_CH)
 		num_ch = EDMA_V0_MAX_NR_CH;
@@ -256,11 +262,11 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 
 enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 	u32 tmp;
 
 	tmp = FIELD_GET(EDMA_V0_CH_STATUS_MASK,
-			GET_CH_32(dw, chan->dir, chan->id, ch_control1));
+			GET_CH_32(chip, chan->dir, chan->id, ch_control1));
 
 	if (tmp == 1)
 		return DMA_IN_PROGRESS;
@@ -272,30 +278,30 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 
 void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 
-	SET_RW_32(dw, chan->dir, int_clear,
+	SET_RW_32(chip, chan->dir, int_clear,
 		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
 }
 
 void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 
-	SET_RW_32(dw, chan->dir, int_clear,
+	SET_RW_32(chip, chan->dir, int_clear,
 		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
 }
 
-u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
+u32 dw_edma_v0_core_status_done_int(struct dw_edma_chip *chip, enum dw_edma_dir dir)
 {
 	return FIELD_GET(EDMA_V0_DONE_INT_MASK,
-			 GET_RW_32(dw, dir, int_status));
+			 GET_RW_32(chip, dir, int_status));
 }
 
-u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
+u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir dir)
 {
 	return FIELD_GET(EDMA_V0_ABORT_INT_MASK,
-			 GET_RW_32(dw, dir, int_status));
+			 GET_RW_32(chip, dir, int_status));
 }
 
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
@@ -357,109 +363,109 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
 
 	if (first) {
 		/* Enable engine */
-		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
-		if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+		SET_RW_32(chip, chan->dir, engine_en, BIT(0));
+		if (chip->mf == EDMA_MF_HDMA_COMPAT) {
 			switch (chan->id) {
 			case 0:
-				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch0_pwr_en,
 					      BIT(0));
 				break;
 			case 1:
-				SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch1_pwr_en,
 					      BIT(0));
 				break;
 			case 2:
-				SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch2_pwr_en,
 					      BIT(0));
 				break;
 			case 3:
-				SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch3_pwr_en,
 					      BIT(0));
 				break;
 			case 4:
-				SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch4_pwr_en,
 					      BIT(0));
 				break;
 			case 5:
-				SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch5_pwr_en,
 					      BIT(0));
 				break;
 			case 6:
-				SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch6_pwr_en,
 					      BIT(0));
 				break;
 			case 7:
-				SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch7_pwr_en,
 					      BIT(0));
 				break;
 			}
 		}
 		/* Interrupt unmask - done, abort */
-		tmp = GET_RW_32(dw, chan->dir, int_mask);
+		tmp = GET_RW_32(chip, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, int_mask, tmp);
+		SET_RW_32(chip, chan->dir, int_mask, tmp);
 		/* Linked list error */
-		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
+		tmp = GET_RW_32(chip, chan->dir, linked_list_err_en);
 		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+		SET_RW_32(chip, chan->dir, linked_list_err_en, tmp);
 		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
+		SET_CH_32(chip, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
 		#ifdef CONFIG_64BIT
-			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
+			SET_CH_64(chip, chan->dir, chan->id, llp.reg,
 				  chunk->ll_region.paddr);
 		#else /* CONFIG_64BIT */
-			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+			SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
 				  lower_32_bits(chunk->ll_region.paddr));
-			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+			SET_CH_32(chip, chan->dir, chan->id, llp.msb,
 				  upper_32_bits(chunk->ll_region.paddr));
 		#endif /* CONFIG_64BIT */
 	}
 	/* Doorbell */
-	SET_RW_32(dw, chan->dir, doorbell,
+	SET_RW_32(chip, chan->dir, doorbell,
 		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
 }
 
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 	u32 tmp = 0;
 
 	/* MSI done addr - low, high */
-	SET_RW_32(dw, chan->dir, done_imwr.lsb, chan->msi.address_lo);
-	SET_RW_32(dw, chan->dir, done_imwr.msb, chan->msi.address_hi);
+	SET_RW_32(chip, chan->dir, done_imwr.lsb, chan->msi.address_lo);
+	SET_RW_32(chip, chan->dir, done_imwr.msb, chan->msi.address_hi);
 	/* MSI abort addr - low, high */
-	SET_RW_32(dw, chan->dir, abort_imwr.lsb, chan->msi.address_lo);
-	SET_RW_32(dw, chan->dir, abort_imwr.msb, chan->msi.address_hi);
+	SET_RW_32(chip, chan->dir, abort_imwr.lsb, chan->msi.address_lo);
+	SET_RW_32(chip, chan->dir, abort_imwr.msb, chan->msi.address_hi);
 	/* MSI data - low, high */
 	switch (chan->id) {
 	case 0:
 	case 1:
-		tmp = GET_RW_32(dw, chan->dir, ch01_imwr_data);
+		tmp = GET_RW_32(chip, chan->dir, ch01_imwr_data);
 		break;
 
 	case 2:
 	case 3:
-		tmp = GET_RW_32(dw, chan->dir, ch23_imwr_data);
+		tmp = GET_RW_32(chip, chan->dir, ch23_imwr_data);
 		break;
 
 	case 4:
 	case 5:
-		tmp = GET_RW_32(dw, chan->dir, ch45_imwr_data);
+		tmp = GET_RW_32(chip, chan->dir, ch45_imwr_data);
 		break;
 
 	case 6:
 	case 7:
-		tmp = GET_RW_32(dw, chan->dir, ch67_imwr_data);
+		tmp = GET_RW_32(chip, chan->dir, ch67_imwr_data);
 		break;
 	}
 
@@ -478,22 +484,22 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 	switch (chan->id) {
 	case 0:
 	case 1:
-		SET_RW_32(dw, chan->dir, ch01_imwr_data, tmp);
+		SET_RW_32(chip, chan->dir, ch01_imwr_data, tmp);
 		break;
 
 	case 2:
 	case 3:
-		SET_RW_32(dw, chan->dir, ch23_imwr_data, tmp);
+		SET_RW_32(chip, chan->dir, ch23_imwr_data, tmp);
 		break;
 
 	case 4:
 	case 5:
-		SET_RW_32(dw, chan->dir, ch45_imwr_data, tmp);
+		SET_RW_32(chip, chan->dir, ch45_imwr_data, tmp);
 		break;
 
 	case 6:
 	case 7:
-		SET_RW_32(dw, chan->dir, ch67_imwr_data, tmp);
+		SET_RW_32(chip, chan->dir, ch67_imwr_data, tmp);
 		break;
 	}
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
index 2afa626b8300c..01a29c74c0c43 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -12,13 +12,13 @@
 #include <linux/dma/edma.h>
 
 /* eDMA management callbacks */
-void dw_edma_v0_core_off(struct dw_edma *chan);
-u16 dw_edma_v0_core_ch_count(struct dw_edma *chan, enum dw_edma_dir dir);
+void dw_edma_v0_core_off(struct dw_edma_chip *chip);
+u16 dw_edma_v0_core_ch_count(struct dw_edma_chip *chip, enum dw_edma_dir dir);
 enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan);
 void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan);
 void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan);
-u32 dw_edma_v0_core_status_done_int(struct dw_edma *chan, enum dw_edma_dir dir);
-u32 dw_edma_v0_core_status_abort_int(struct dw_edma *chan, enum dw_edma_dir dir);
+u32 dw_edma_v0_core_status_done_int(struct dw_edma_chip *chip, enum dw_edma_dir dir);
+u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir dir);
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
 /* eDMA debug fs callbacks */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 4b3bcffd15ef1..5819a64aceb0f 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -38,7 +38,7 @@
 #define CHANNEL_STR				"channel"
 #define REGISTERS_STR				"registers"
 
-static struct dw_edma				*dw;
+static struct dw_edma_chip			*chip;
 static struct dw_edma_v0_regs			__iomem *regs;
 
 static struct {
@@ -53,8 +53,10 @@ struct debugfs_entries {
 
 static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 {
+	struct dw_edma *dw = chip->dw;
+
 	void __iomem *reg = (void __force __iomem *)data;
-	if (dw->mf == EDMA_MF_EDMA_LEGACY &&
+	if (chip->mf == EDMA_MF_EDMA_LEGACY &&
 	    reg >= (void __iomem *)&regs->type.legacy.ch) {
 		void __iomem *ptr = &regs->type.legacy.ch;
 		u32 viewport_sel = 0;
@@ -127,6 +129,8 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
 
 static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 {
+	struct dw_edma *dw = chip->dw;
+
 	const struct debugfs_entries debugfs_regs[] = {
 		/* eDMA global registers */
 		WR_REGISTER(engine_en),
@@ -173,7 +177,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+	if (chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -195,6 +199,8 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 
 static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 {
+	struct dw_edma *dw = chip->dw;
+
 	const struct debugfs_entries debugfs_regs[] = {
 		/* eDMA global registers */
 		RD_REGISTER(engine_en),
@@ -242,7 +248,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+	if (chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -264,6 +270,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 
 static void dw_edma_debugfs_regs(void)
 {
+	struct dw_edma *dw = chip->dw;
 	const struct debugfs_entries debugfs_regs[] = {
 		REGISTER(ctrl_data_arb_prior),
 		REGISTER(ctrl),
@@ -282,13 +289,15 @@ static void dw_edma_debugfs_regs(void)
 	dw_edma_debugfs_regs_rd(regs_dir);
 }
 
-void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
+void dw_edma_v0_debugfs_on(struct dw_edma_chip *p)
 {
-	dw = chip->dw;
-	if (!dw)
+	struct dw_edma *dw;
+	chip = p;
+	if (!chip)
 		return;
 
-	regs = dw->rg_region.vaddr;
+	dw = chip->dw;
+	regs = chip->reg_base;
 	if (!regs)
 		return;
 
@@ -296,19 +305,19 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!dw->debugfs)
 		return;
 
-	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->mf);
+	debugfs_create_u32("mf", 0444, dw->debugfs, &chip->mf);
 	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
 	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
 
 	dw_edma_debugfs_regs();
 }
 
-void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
+void dw_edma_v0_debugfs_off(struct dw_edma_chip *p)
 {
-	dw = chip->dw;
-	if (!dw)
+	chip = p;
+	if (!chip)
 		return;
 
-	debugfs_remove_recursive(dw->debugfs);
-	dw->debugfs = NULL;
+	debugfs_remove_recursive(chip->dw->debugfs);
+	chip->dw->debugfs = NULL;
 }
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index cab6e18773dad..fcfbc0f47f83d 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -12,19 +12,62 @@
 #include <linux/device.h>
 #include <linux/dmaengine.h>
 
+#define EDMA_MAX_WR_CH                                  8
+#define EDMA_MAX_RD_CH                                  8
+
 struct dw_edma;
 
+struct dw_edma_region {
+	phys_addr_t	paddr;
+	void __iomem	*vaddr;
+	size_t		sz;
+};
+
+struct dw_edma_core_ops {
+	int (*irq_vector)(struct device *dev, unsigned int nr);
+};
+
+enum dw_edma_map_format {
+	EDMA_MF_EDMA_LEGACY = 0x0,
+	EDMA_MF_EDMA_UNROLL = 0x1,
+	EDMA_MF_HDMA_COMPAT = 0x5
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
- * @irq:		 irq line
+ * @nr_irqs:		 total dma irq number
+ * reg64bit		 if support 64bit write to register
+ * @ops			 DMA channel to IRQ number mapping
+ * @wr_ch_cnt		 DMA write channel number
+ * @rd_ch_cnt		 DMA read channel number
+ * @rg_region		 DMA register region
+ * @ll_region_wr	 DMA descriptor link list memory for write channel
+ * @ll_region_rd	 DMA descriptor link list memory for read channel
+ * @mf			 DMA register map format
  * @dw:			 struct dw_edma that is filed by dw_edma_probe()
  */
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
-	int			irq;
+	int			nr_irqs;
+	const struct dw_edma_core_ops   *ops;
+
+	void __iomem		*reg_base;
+
+	u16			ll_wr_cnt;
+	u16			ll_rd_cnt;
+	/* link list address */
+	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
+
+	/* data region */
+	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
+
+	enum dw_edma_map_format	mf;
+
 	struct dw_edma		*dw;
 };
 
-- 
2.24.0.rc1

