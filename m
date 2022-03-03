Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E274CC568
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 19:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiCCSr4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 13:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiCCSrz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 13:47:55 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C48719F444
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 10:47:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVVh78W2Cx1IjysaOPYv1Svz3vkYI4vLHSsQc01/URxvBo2zsDDhpGMUbTBEIRD9JDkKoSaIExfRyHhssTC5aidMbmGqkWiSI4fkYEczDECkrCXNueDUM/0VoZNRESDcVTyCq29fphcUaa7meMDQexxAiN4YWpwSLu2CyAA+gWypr6hbbqjUzCj+gEhYYdExpqCO5Z7V+5D/5HG+2Nnw7ddrup5URTkrDjNs1hGMFzgGUM+G4WXqx/+WFvPErNkMJMwbAOuAEgMswkdubNpDqjl8AHubb1bj4xRhj81oVtUwcZK0zCnUkAr3WXqfh2GDiaOC0hcr3qB5JGJtjFDzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXSoxdnpXarDIzKoxGd+EpI7eU0ep4UBWF7EoocH11A=;
 b=iL5+tjBLome1ZNm/fRg8pX0RRrZE06Pqg3sAKGDJ9MIDETg2wuqQJZG3mboPwthMYvYGgbO5L7mD1uaDv7AG06EWijDbp3jdz2tiytEJnKTQfJ3dTkyGLvpyW09xYxZ5sf3Qng/9zJikbDQ4xhVkRpIDJsEgbCs+eMlAQae8t/ZHdw+KrPvimXq5WqMeE7dwn0mAouVkt+RXAOS2xNmSi3VE7q5+JdAtX3plbNLcdj5ACz4ZZUL0l/gUTjFGFGmmd2Wav2gTJ5Xnd2C03JRPSbS2swnPmI04WXiHZkDIoTTEq8ytS+xBLPc6HaDwqxpQ/OESx/AZ5IGrwDdvjxDuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXSoxdnpXarDIzKoxGd+EpI7eU0ep4UBWF7EoocH11A=;
 b=D05QrBFE8NdlkpdQq9CelRDoitNzBZe2xSM9SkfYdu3ZvWPHHl+O2691VL4lV1VGYDjT7BNEv2WRL/uOUpi6++U6KwNC+UswZ6hw7dTRxVdgDPBqVY3NFqc9YVmV8Mf5ScIZKfNG+zjUQunjUAPfhm5NEVG1bvJoa9zrHk9OcOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 18:47:03 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 18:47:03 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v2 3/5] dmaengine: dw-edma: add flags at struct dw_edma_chip
Date:   Thu,  3 Mar 2022 12:46:33 -0600
Message-Id: <20220303184635.2603-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7558614b-d6da-4ded-3d10-08d9fd463547
X-MS-TrafficTypeDiagnostic: AM8PR04MB7827:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB78273E3B32A447EA03BB6A9A88049@AM8PR04MB7827.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+erHAsBJ02SyH7Xn2DOOa1DXLoUU+DneQ61kzZE3fs0nn4+DgT8g/4DKtn9p8yafVxlaLwFvtav4dkjdRPeDoL0rgS/CsDtP6w0/PEgLogQ5AJvtepZ39pjQxtcRj2xEUmGgcKS61D2PcVfL+kfBmQF/Z47v7K/dNmzVwQAyzV06o3ZNUYbZoHsq0HKGPHUD9WQOrMr9ywQA1cad2xe/kJO3cL3mqwho8u2evuZ+uF+kMR7496Q27OWHCLjvm80pijZx9ZL2OVKZzyyd1yMig7v4UM6S2KnJzY8NwjUHm0upvczOccq9CMIZESpIiCI2B7/2nI2BeQqYXxlEf3kDANAylDv4/CN0PyLlmJeTRtYyslA4iY8bkA3X7PhlqL/O9TdDLdv27N5OcooIqb+6kCC6yc+k6ZN7kXjPzKm9a//LSHLvlbIEdNrW3DIKJ//wQX2D5Klr7/IErDRVdn3M57IEkevVEgHslvK9qaYTTz3Jh7YFHLvpkq2TDHHza63xY70OCc/ZVDOpLwyNUEb5y+r5UrPXyx/kILr6g7uHv2wVFMhD2T1litsPtDoq2nAvdXPig/cE7KV4z7V7tISmZH9Fwc99f2s/BiHtRer9gpEMfO+3johWqNABxE+THXih3uksw5QIXgVpqP1xm2I0f709p2qvDuikqvkuc2SDrwfnyn5irwnUAvgV7CUSrcAI6AfI/8ru//ESwuDgnz4gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6486002)(4326008)(86362001)(36756003)(8936002)(6666004)(6506007)(26005)(5660300002)(498600001)(52116002)(83380400001)(8676002)(2906002)(66476007)(66946007)(66556008)(186003)(6512007)(1076003)(2616005)(38350700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IgvcDXPcJ73AXi9YjK8duOiEhEgxyNsKRa2O6o4K9+juZZ/pHLT1r7RdhuxP?=
 =?us-ascii?Q?d4UhA0aZy472EezosIlO6yaCGm4F3P+eNT7hvyMftAMAnI3EvS4ysD9H1/Yh?=
 =?us-ascii?Q?+S23DZfOWDn0hm+lEBb4fXt0cnv33qRhcWH+oev9o+KnmbcnxC3fdBLQAJVp?=
 =?us-ascii?Q?s76yJVi8tLIN6kuBrkUN23SD6O1H2/zTrhN5kU1HPWjeHRyL1BUkHcVGWXOo?=
 =?us-ascii?Q?CDDbdiJELKZ1WPxUmfcSdtELQfLWYPi4smcBhYiHa6cBm/hLqYtyYjNDmvT+?=
 =?us-ascii?Q?f10DepNk1ZlGlQA020jSwN9n5vTPVqryAIRUplgH+Ejka28l5Y4JPk+YODCb?=
 =?us-ascii?Q?ie1BNLGljvZY1ZfigcvuE8xcro/XBDM6JhbSRnzAjy8i58UgtQngcYW0mWKT?=
 =?us-ascii?Q?WP8Or1dgAMyf0OF4z/sNHICYj2cZbcfYHy3Dq4f4f2TPilYLJbo1sPdX8JvO?=
 =?us-ascii?Q?Hb9SVcj1p2Oyum3Qqfj0SkPuXNQcAah0uZzze6laILIOM0CuxzspIJe5TmF7?=
 =?us-ascii?Q?/2zF73c369B3tW6UlksQruge1y+sTOZR0hn0/TLxUK1IQHaIlk6XCCqbrz6m?=
 =?us-ascii?Q?1t8xlcgSPjQfy5FsBn7Tbu1S6iy6XlZzs2PqOWdF28QP8tKEB+TYOiFI//Ib?=
 =?us-ascii?Q?DAMWvVEdnulOWoBmtAOdmboWugAHa2N6BmQlCrQnrzzUkqJdn3QFNU8giqHA?=
 =?us-ascii?Q?a/BpZPcu8LUEEKMQVmdcxSnBYZmBbA3jcQkjRVNFWUsOGaMdXDZ0iH9AwQhY?=
 =?us-ascii?Q?MTFFEVRdOMteu5QOeJ5Sgs2lWbWhRHPPAArabEUIKUFzkY7z/J8Dbaf6eZwE?=
 =?us-ascii?Q?MKhLH5Ng2heoPE6030453l7yr+LsMHqihDuqV6Adgl0brESYYUwp5WcBLa58?=
 =?us-ascii?Q?aKOWbSGEM5AetV+yblwAbDvhiJFGDrW1NRx7eiuJrinTCuPcVHT4hwjXNlzT?=
 =?us-ascii?Q?jBiRQ5LP6PTliiHrtG+0quTQ7ofzPecNnl467TDQLfcnIEmgeI5SHR/13bC0?=
 =?us-ascii?Q?brKItVfNSD+8GV6JkzzhUbIjduRQZ3kq3GpLdte8c2JQXiZoiLrwpDeubruv?=
 =?us-ascii?Q?UR2nH9rHDjHE9XPPEAjGWnsbnh71EcQkTlzK4NR+G5L41fqWwakWCHnwsIjn?=
 =?us-ascii?Q?GIB1L/2ISa1ZnrTdmwwoikigrIFTcp3eomiIlRr8ejVzbed18jl0ZG7Y06Vt?=
 =?us-ascii?Q?CqrmWerH+ICfDqffspRbMkBlWTRGCj5E++7KZvRSam6zlpVL53yHtFOI0GFb?=
 =?us-ascii?Q?37vA0DUibhWrKWMpQgQAUrtyio0LxJvuuMi4duVF7xv9og0TrvnpIxx4kGws?=
 =?us-ascii?Q?hnNaPSpx6ya6Befd+XnOy9gJLPisbSkwYdd6pbigKEh/BkywapQ9mp5oD4X/?=
 =?us-ascii?Q?X4JgHnHrM3jcnWlAryBF8Ri7zpEvjqm4NRv/03+idxIeGOGp79l0K2mqafnt?=
 =?us-ascii?Q?OCvXfPVwHdDDxgwJ6mTX4oQuXowp/LlIO3gBbq+z/Q9jcHrK/fCH3X1J8Hhm?=
 =?us-ascii?Q?eOSpMg1sPI1eFLKMepQadrL7cjpdyNoy0TS9rBOXloYSghPB1pDit0qt98/v?=
 =?us-ascii?Q?Gw4HRFXFc4d+sakdv/3ojHFtXtTyNJeI4ZZtOgnkckZLijJ+82+YxbwfJ7WQ?=
 =?us-ascii?Q?/3xHsUj61+EJI/nQEIAb/4M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7558614b-d6da-4ded-3d10-08d9fd463547
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 18:47:03.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/qqI/vua53wbjwpp5PA8MxZNxSCLIhWk/CK/4BGI/T12qLfRJSY+eqfw5U4IuvugbQKp8W4f0i99d1auv/6bw==
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

Allow user don't enable remote MSI irq.
PCI ep probe dma locally, don't want to raise irq
to remote PCI host.

Add option allow force 32bit register access even at
64bit system. i.MX8 hardware only allowed 32bit register
access.

Add option allow EP side probe dma. remote side dma is
continue physical memory, local memory is scatter list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- none

 drivers/dma/dw-edma/dw-edma-core.c    |  7 ++++++-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 14 ++++++++++----
 include/linux/dma/edma.h              |  7 +++++++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 0cb66434f9e14..a43bb26c8bf96 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -336,6 +336,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	struct dw_edma_desc *desc;
 	u32 cnt = 0;
 	int i;
+	bool b;
 
 	if (!chan->configured)
 		return NULL;
@@ -424,7 +425,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		chunk->ll_region.sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
-		if (chan->dir == EDMA_DIR_WRITE) {
+		b = (chan->dir == EDMA_DIR_WRITE);
+		if (chan->chip->flags & DW_EDMA_CHIP_LOCAL_EP)
+			b = !b;
+
+		if (b) {
 			burst->sar = src_addr;
 			if (xfer->type == EDMA_XFER_CYCLIC) {
 				burst->dar = xfer->xfer.cyclic.paddr;
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 6e2f83e31a03a..d5c2415e2c616 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -307,13 +307,18 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_v0_lli __iomem *lli;
 	struct dw_edma_v0_llp __iomem *llp;
 	u32 control = 0, i = 0;
+	u32 rie = 0;
 	int j;
 
 	lli = chunk->ll_region.vaddr;
 
+	if (!(chan->chip->flags & DW_EDMA_CHIP_NO_MSI))
+		rie = DW_EDMA_V0_RIE;
+
 	if (chunk->cb)
 		control = DW_EDMA_V0_CB;
 
@@ -321,7 +326,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	list_for_each_entry(child, &chunk->burst->list, list) {
 		j--;
 		if (!j)
-			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
+			control |= (DW_EDMA_V0_LIE | rie);
 
 		/* Channel control */
 		SET_LL_32(&lli[i].control, control);
@@ -420,15 +425,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(chip, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
-		#ifdef CONFIG_64BIT
+		if (!(chan->chip->flags & DW_EDMA_CHIP_REG32BIT) &&
+			IS_ENABLED(CONFIG_64BIT)) {
 			SET_CH_64(chip, chan->dir, chan->id, llp.reg,
 				  chunk->ll_region.paddr);
-		#else /* CONFIG_64BIT */
+		} else {
 			SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
 				  lower_32_bits(chunk->ll_region.paddr));
 			SET_CH_32(chip, chan->dir, chan->id, llp.msb,
 				  upper_32_bits(chunk->ll_region.paddr));
-		#endif /* CONFIG_64BIT */
+		}
 	}
 	/* Doorbell */
 	SET_RW_32(chip, chan->dir, doorbell,
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index fcfbc0f47f83d..e74ee15d9832a 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -33,6 +33,10 @@ enum dw_edma_map_format {
 	EDMA_MF_HDMA_COMPAT = 0x5
 };
 
+#define DW_EDMA_CHIP_NO_MSI	BIT(0)
+#define DW_EDMA_CHIP_REG32BIT	BIT(1)
+#define DW_EDMA_CHIP_LOCAL_EP	BIT(2)
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -40,6 +44,8 @@ enum dw_edma_map_format {
  * @nr_irqs:		 total dma irq number
  * reg64bit		 if support 64bit write to register
  * @ops			 DMA channel to IRQ number mapping
+ * @flags		 - DW_EDMA_CHIP_NO_MSI can't generate remote MSI irq
+ *			 - DW_EDMA_CHIP_REG32BIT only support 32bit register write
  * @wr_ch_cnt		 DMA write channel number
  * @rd_ch_cnt		 DMA read channel number
  * @rg_region		 DMA register region
@@ -53,6 +59,7 @@ struct dw_edma_chip {
 	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
+	u32			flags;
 
 	void __iomem		*reg_base;
 
-- 
2.24.0.rc1

