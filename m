Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A154C9C20
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 04:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbiCBD17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 22:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbiCBD16 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 22:27:58 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20066.outbound.protection.outlook.com [40.107.2.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EC8B0D28
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 19:27:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUNlkVUW2SFjn7a3cl/Mlt6UbIg+gT0+S0is8Yjo2H//SNJwDwwIKhA5wUH/3DOwCRShAx4ZaPCisU1yRQQZT4Zhd5DjcmStqerXwsNKcDY1AhnGrEx2h8p5DRzsR7HCeE7/ZZWz56pUGFtKEqjsqCxSkBFuJYZ4AHFmHHY2XI9O+pQNp6l5MdLw9vMrx7CBQVDShmU5aUs90Lagx/uDXJXtUrmCPX57zqoBO/kQjHlEQ9LCX78xpdpvMqxs9333ZgE9urEeYcejGc4ijndbYX3alHBK0y/X5MyRKlVykoDSfS7tXvpZ9iTWnbaWnL2p1JJf8zxq5RAcUwFnv6BqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkxrD0Y34vwds2dIjo1woyuEqlK1JnSUDaaBFn+yvjI=;
 b=TfL0HZsd8WSSsaTCXE58MES+7Dz83L60XaFbdWcMp1FKdQh84NozI8Rt1fT12EIk4fqPbbpBBevDtCwkIxQwpBIaqOiyjaldEIa6h8iSD/FdEWRp0QG8sFXGcOP2vOgjgkeON7LvuueNY6xmH4B0pZMNxIkfN/OJ6v+GvYu0aBKakQb3TXooqeoARox185wFV7Ls+K+peg3jFsguUxCBcdyR6LszcgG7YpIIx5L89nvUVaBDmk2TT60HHfn5jvYFrXl5iRyw90u/psQDEkvRprRNSjLoOYvrC3I28EErVPPV618XNq/QgTs1VQVyAoq7Cwi2KcvbJ42UxXRfE0w2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkxrD0Y34vwds2dIjo1woyuEqlK1JnSUDaaBFn+yvjI=;
 b=dJ8Ufud5P4trVZpntCRMcjl0pzeT7nmFjZqgPHMtNyARlqzToT2YrDjapH0kj5ulJTKUVntWmvPOvTZoOmHiQJguW3MkJSzHpu8kCGtzWIt+htiDweKTERfThIl3LC8bO2SHjUFDwPwFFYzO+TZ18dZWJqtFzWxqYtRTSR1hKKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB5926.eurprd04.prod.outlook.com (2603:10a6:20b:af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 03:27:13 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%6]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 03:27:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org
Subject: [PATCH 3/5] dmaengine: dw-edma: add flags at struct dw_edma_chip
Date:   Tue,  1 Mar 2022 21:26:44 -0600
Message-Id: <20220302032646.3793-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e5ec5892-2307-490c-ef3a-08d9fbfc8ae7
X-MS-TrafficTypeDiagnostic: AM6PR04MB5926:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB59265B4C6E13108BC6BFB80988039@AM6PR04MB5926.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAM+3DBelPAfscThccbJo3CUSbFx5zXlCw4wwFcDVvRWHQX+NbRW8KY7rCJDk+sZJha0+b0qHoZ3Z2cHBX/hwWzDOyj0oI/1ZrXYHCz5ViAP3xzVLozKf+RWfWUgw+HQmVU1ZGOis10KSdRImK8BPc3RCiQO3m6Qe/jw1lAlxyZmvO8RUprnz5wxj0A0UctV/s9h+zqnHzO5X4NmLnh9jO4G/BtHM0/Zr+sbltjnrQhqtF4Dypdh7nNJLFDCT/P8QNqkGFaCJC0AEccOmWAVyYLY58ClB7NkjJ747wpyS0lxpFfCr8QZ9ZKpVVum1xtNTFBqpCdQ4LhkoXtjWjW14Uv95wLAeCg7YVM3USvne5XEQMR/D35N4JfHD/4hWANE+MOthxRoxmNYjjhmbN8qK2fD+ElXQ9Niu4mMdIhq8b1LtxtQoUcThjPmaJOZ67LZ5y+Fjkg/LLB/adMD0YKR/5A/92Zv1inop9sU26eHI4b1JV28Juv7DHe0CkuqFyX8RRaHxFdJz6I6P2xQ3VgMT+CyX6EI/n9b0itsZzUVOlbFVTsJddqG2YQeLonvFDupsZXcFANlQw+mMP6pRC9OG8rR4iKfMO2GYVONLAl2BAYEA9mK+NFJiRtwF2jr4rEXwF94onzdaBpGbGaeo9xJDGoRiHqEGqyB8vkk4HVj35EtacNaLB33i9fvAVBZPO3psvrosOQjvd5bl6ghxwAYcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(86362001)(66476007)(38100700002)(8676002)(66946007)(66556008)(4326008)(316002)(5660300002)(2906002)(7416002)(8936002)(26005)(2616005)(1076003)(186003)(83380400001)(508600001)(6486002)(52116002)(6666004)(6512007)(36756003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZxXl8BmrBrFDj4+H64xhZc9NCEfl2XVNbkxpBBrTSzwERJyGoX4lPvpVN+So?=
 =?us-ascii?Q?qycmEq48mMiQ6E7bM9ZdF98lOHdnjNxbKr69d1X6UTvAKxRQ2y8hkwMsdqVs?=
 =?us-ascii?Q?BrBschUauHys0GHHLSxgN5idZDsKuZEFVHbjhydgie8Ow8iEbbUqz4GTPAhm?=
 =?us-ascii?Q?CVcoNZ7w4Xy85zAl9FL573jGWikYZpZnAqELlDYyhWFpWpLp/BTVsVBzazsz?=
 =?us-ascii?Q?mqbgHUS/7Og/YBFf6KRx94lb49KsR6GD0xOrbWVymBKn1hi1y9sqh6nmPsbh?=
 =?us-ascii?Q?UOlOfEFEZwkHl09sM+1GYNYYZun02dCn+Y0qiv+cgGtoLUq2jQSQMD+AhktU?=
 =?us-ascii?Q?6TUXo0t6FxLorO+NBocUub3pzIiG6mKmYuNXwaGePNbUs4YcPR9w7+5r8mRn?=
 =?us-ascii?Q?iBedDWbImBOLJ96cX08H3JI2q+kBwp1Ciw1rpBfXCfcy1BLEJgtN0no3QWLU?=
 =?us-ascii?Q?48CTWsGeH0azrW6Ud3NbpgztpehKmYUgqvQOkE4S36cu20wFIORo61L+yvXv?=
 =?us-ascii?Q?CthD72+H4Sl2TRTaP8PpEy2cBa26rH+2m8gmw8quAZ6qRsJFjqD4ZBD/uytq?=
 =?us-ascii?Q?Caimz+Ln44yp474p1AebEzi7Rg4B4IK6ft6T1whYwra9eB4nYtipbOvipxAG?=
 =?us-ascii?Q?7SOn/8lJe7dllNNKBEELyy7NPMYiib6RXoSsow++dT768C/hHaXXCeGA39Ua?=
 =?us-ascii?Q?8/X/KGD2OCzRpMLH+UYRoi6tTDWOZd9Eeh22xBH0nPGX4V/A/S5WqVMomEjJ?=
 =?us-ascii?Q?SxWx4GPyKxt9SnyudYfPasKp5tH1tttomPQ0bHRTO3GD+1TzYKpLoNFP3jOV?=
 =?us-ascii?Q?xCuk48YuKYQm13JqTvgcD1WI7JZTXYeKVbftJgrnCSlnsWLHLVewt0URAlIO?=
 =?us-ascii?Q?J/8l0oRjRG8CSH9SxHlIivvAXLrqNkxbA07h0jC0aVcoHju35nqcnRZN0GSw?=
 =?us-ascii?Q?zPbxcgg2XJOehVZRCqltb37BZODqjhBXZ3xJaf0vHaL/y0Uilc0VnM/jkHAa?=
 =?us-ascii?Q?+5pALKaNoG7L2gdOcsAQphdNLtemSONzeFYfQvusw1fWN/ABmTttbbKiesMj?=
 =?us-ascii?Q?EMoOnpcdlqdQ6Fl6farQBlPxHuJqVFSlUmdoMUIO9OmwxLHHB5BmTcrX8n4C?=
 =?us-ascii?Q?BkRIcy+EqqUQSxsRUfdNbz80WlsRiiE+MR1gpP+L7VmH3DY48SSyyQI81jiX?=
 =?us-ascii?Q?YxtskSOq6UPRRH/zyIgtisEjtQGoHzVvZ+hTrmIvMJxHSUD778nbKfmEa8gs?=
 =?us-ascii?Q?jSuJrjxWnqvo+eaZzp3all8HYgEyhuoQabFnxJ10YREMaLQUw/fN48l1dXY+?=
 =?us-ascii?Q?XuTGeoadGGPq3jxHbjvJkfjopzAmlMuoZFfM/wmQg3f4+BVfDkgQOwf6AtO1?=
 =?us-ascii?Q?W2+jYFbyCLdEai9NiUk1OyHEXgxDRiz0F0dTYAXRrjdTXmKCmipUIrLsNKgo?=
 =?us-ascii?Q?LdksvLTkOf303qreIje8HzEbrGvIc3LAuSAcEPuAc5nWmQ5a/YtapkPexEbZ?=
 =?us-ascii?Q?v8B4uj2OIhmHOXa+qcvFn5YrkriJN4MHuh6JSPJcr5avNCO5oU1VzLkq2DBu?=
 =?us-ascii?Q?WsDu8hDPjpB4NIGG+r5G+aEZIWAW9bRb9pfGcZx7/pgNHGDBs0rUeq92eplp?=
 =?us-ascii?Q?Q+R5Aqmhk3yC5Y+Qm6e0ujc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ec5892-2307-490c-ef3a-08d9fbfc8ae7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 03:27:13.2139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1inYHHoQEdF1FoG/NCuItiqeWCoO5ig8W7GgaxPoXmdItYgtjJpRBeZeIoUmaoJp7QnlGgvecP/LjOT97oskw==
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
 drivers/dma/dw-edma/dw-edma-core.c    |  7 ++++++-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 15 +++++++++++----
 include/linux/dma/edma.h              |  7 +++++++
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 029085c035067..8134909a46fed 100644
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
index 884ba55fbd530..322f1db7226c6 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -301,13 +301,18 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
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
 
@@ -315,7 +320,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	list_for_each_entry(child, &chunk->burst->list, list) {
 		j--;
 		if (!j)
-			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
+			control |= (DW_EDMA_V0_LIE | rie);
 
 		/* Channel control */
 		SET_LL_32(&lli[i].control, control);
@@ -414,15 +419,17 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
-		#ifdef CONFIG_64BIT
+
+		if (!(chan->chip->flags & DW_EDMA_CHIP_REG32BIT) &&
+		    IS_ENABLED(CONFIG_64BIT)) {
 			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
 				  chunk->ll_region.paddr);
-		#else /* CONFIG_64BIT */
+		} else {
 			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
 				  lower_32_bits(chunk->ll_region.paddr));
 			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 				  upper_32_bits(chunk->ll_region.paddr));
-		#endif /* CONFIG_64BIT */
+		}
 	}
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index fdb19c717aa09..a7b9898e8d356 100644
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
 
 	u16			wr_ch_cnt;
 	u16			rd_ch_cnt;
-- 
2.24.0.rc1

