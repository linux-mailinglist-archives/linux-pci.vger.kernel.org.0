Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36934D0412
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 17:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbiCGQ0E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 11:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbiCGQ0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 11:26:03 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A7C5C85B
        for <linux-pci@vger.kernel.org>; Mon,  7 Mar 2022 08:25:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1kBUdTQXmKHT/Eshxc3V40XMEHTdwK5QtEr+ARaFqk65rNiZZxgHEZacNyouJ3Lt78C3vTdr44lbtfXqBeA5ccDrdox4yklEV8lHZIkUnMdjp6sHHpyUVQhOpAD9cgVItK/d0cZSoh7D8sMQqlud6DX/K0o+oWg1brOBayVjDua1wAvLqOZzwxSXlUB2F0IKzjqFnstypmngk3ui2tXck/l/11zgD/H7kaaW5Fd8ZgquJNadUb8CberWU9N5HN1x9qtBwHMKEn71k2DeV8WzeoMRcF2KI/iGS8/xtSxDrYGmqr5v+SQ/b68J0nxnOCw4VugE3s0MgnhGlY3TaaXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qirRNTxmjXJi/sAiojLNjCLoGnsMAibGsWUY7uVia4=;
 b=Ixsb/+GFlc0Bgu1o09GpR9FnuP3mvPEp8IL99H3lo69JHAT/tt9mbmjADqTDF3GwzoLtp5Tki3ZJlyV1Ftsw8KYU/5VAWdBGK1pyOyD0unPC5QSRo+eUkV6N70ZZO0srmJ+1s1QcHEXRpVtTUnEJuAjjkEAvIvytMyZX8opse5sK4FPRuoMflz3sB3xoUbDkqsU5lnDBMr+W1watyo+QaZ2buDVaKWrEFzmOZxVW85q3gjwrvd5l1vtaFouBMxdAU68JAx9vh7Y6NvU2UE8XLFVnWYzf6KjRJke67y9kOqSRSbdEW111Jllr23U/UJWwhj3TSxXD32zUQ9BHRdelMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qirRNTxmjXJi/sAiojLNjCLoGnsMAibGsWUY7uVia4=;
 b=r5/Svr/ArxPZrPCdPx8rgojehJxwqdwkPQgcI97Z/YTeW7Hfz0vtQT8txdTxFapNIj+8oAPfsOJqps/cvNTPLEfaZ+VDCQfwTXkZ1CjzI1w19DJN/Rkpa5gEnZPFW2hCNex5nLeas9QctFp1kyweAV6RMwV1IYEDffo2V2juxAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4530.eurprd04.prod.outlook.com (2603:10a6:208:70::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 16:25:06 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 16:25:06 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v3 5/6] dmaengine: dw-edma: add flags at struct dw_edma_chip
Date:   Mon,  7 Mar 2022 10:24:29 -0600
Message-Id: <20220307162430.15261-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 729f537e-91fd-47d0-4da2-08da00570a04
X-MS-TrafficTypeDiagnostic: AM0PR04MB4530:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4530F6D0F6A4143582F7EFBE88089@AM0PR04MB4530.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1tlupcFnWKYFSaZC04hAXAj8HouQlDmbTy1r4CMmYwLL0l8KKRHqN0NKD7gKpmUn9kEJQKm6ce7r8RQL5UIs4l3y+fZNRdZPzXAH2w8/JjBaIPRJoFRVud0R60KNDoh/KXJAKpUNU8D0TC/mCyMxztRpIiAS86/WMzdWDakHy2iXI3RAeu6rF9bNuwSZUjtZHGIDlizoCWK1EPECD3veo49PDG66vd2lG5rL0UAktIomTD1iFoKCS2O3O91ZksniVhEkCTo7xRCBMlWXo+GrFuFx72ovO1XKD37jOKOdig1DdHMbSHl9vhlMjvOl1CARyFKCLhUGZ7HkAVuTMpyxbhbGlJNEfYnRFSaCJ3xAZx+wfMYA+wAkEcCMx/agG0j4vX/vgxYXMlypOFJiOSq5Bo7Og8r+eV7C1TXjB3QNtSkmxuZQqHCQ+7UvVUTh1lpXlj0pBz97cYMVINOJl94S5yZMER/mGA3if3xj1LtLyhJPrKmWvOX7WqoCBCQL/mzOKNZbwo2Ild+JCuiIwqk9jCMm/zWWAjhPmJitSlhUBbB0UtzKJnhMsHr1+ZnBHSx2wuqep17upKO7EvskBrMYFPJvJD959uKzK2cF/8t0YWtonxOTETU4W+qPVA3gZZ8gUvxPdSd/ZhmQDBkSgb71x/kgqfNw8fxEkEI0H4M+C35OVG85zpB9PyR/41NR3bbxDg7xPXOmAwR9N045k3afw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(316002)(36756003)(83380400001)(38100700002)(38350700002)(2616005)(1076003)(26005)(186003)(86362001)(8936002)(7416002)(5660300002)(66476007)(66556008)(8676002)(66946007)(4326008)(6666004)(6512007)(6486002)(6506007)(508600001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MWfzfDi6as087K6qEUdis/FZtYyv/xYm8ycSPBShqCrQj/ArSnJ+l1Dn8I7g?=
 =?us-ascii?Q?U+Rygsd7+GvEgbl7ehOZue/5ren0PpKu+EjiVzBP4Ap1TULoh6Yj4VtQAl7Z?=
 =?us-ascii?Q?ZJTM21sdNe/5xjvHg78IFEOgzP7BzJrJ59w8ZPkk7KNML26VQte5Wf6Ag4Ry?=
 =?us-ascii?Q?5bt+xT169pgZ9nJuS8M36cXEnpxHhrnpCJ1Un2XuZmM2EUMGxwap2lCLQeHZ?=
 =?us-ascii?Q?YN3Xp6ma59wUCuPWUSB6YXIsVTnxRhU2f/9DqKqpsFePN4aTKrcS1PEfeHvL?=
 =?us-ascii?Q?YIB2lfv5IOnScVUCsqQoPvkSJ7rI6pvi8jYnIyI2KW8+6CQBY852Pchaybbz?=
 =?us-ascii?Q?aWTDuXrNkSDo2lH/xNtU8uet7I9KYCOc3lballEn/Gs77JNYKyGPxf2w5Pka?=
 =?us-ascii?Q?zS9I26k568hTpOw+XJ4dmfbvi9/BtcSd6U7mwWAYX2ijPdzTFfj13iaMVis+?=
 =?us-ascii?Q?trtoixgGXOYd+MYmWXSx+Ygg+2pQnntVVAOAe/1U00D/IQoq2ng31pVt4R5C?=
 =?us-ascii?Q?ODhfRBHI4IY0Q/89M+QnoqPgGn/00gYc4VkzFsNEtterdQq4+ndM/C68oRBd?=
 =?us-ascii?Q?iKgTDHOsuxrRPv4c3mhM0ZEJt10jFqJSVSTP8g6NUvCd0mL2KvbNMfLfa0FH?=
 =?us-ascii?Q?vgYfxxg0jjDwDOnHDPdsJktEsvUhIC2x2o5YEMH+YjN48bWbOPmAmGdbxIP5?=
 =?us-ascii?Q?D2ZAZRGV5a0de+9ch3BYR/Hkdv6WxrN7U84U4R2ZKCeiNDX4tVXwo0sVrBlA?=
 =?us-ascii?Q?dsrmWd5mz98adJUfjX87HWHOZQFx7vKuw6ux71qM/1es+i90oGjPAqC9zhWU?=
 =?us-ascii?Q?Ltt4qXp+JYzH8BXnRuiPfeDkYYYUR0V90ObFg0hs7CgPnq7nxSaB9Mqum+dt?=
 =?us-ascii?Q?YWtMKp40b/2rilMl2vTaPFp0C1P6wLspTpCwGCuvzKnvMDONFiMHc2NeT/uu?=
 =?us-ascii?Q?4VITkQTTTeWzQ0jxPFavsa6XXbjBUOt+4lU0eYR5GY5+i/uChu7uZYrpGwak?=
 =?us-ascii?Q?hI7PASkEgaiV/t8Uu9UlNcW7hFygE4GM95WDJA17uGXFTuLi2xp7cONNgXO8?=
 =?us-ascii?Q?u8ea5nK4z6Ucv9pZ4Z9gtXJr4qZdpx22FL53MnJV8Ewf6Z8f5GfttzpHob/H?=
 =?us-ascii?Q?kqkDgUSqshz/GlAZ6p0L7PF1ItOuz1pU2P+OPfDCNRGSwX+poZFml6RvmtoV?=
 =?us-ascii?Q?7UxUPMP7HqlEF+ugccqSp7uDYsE3gYLGEhxqzOgJv9IQTbe+xKiJPVVKT/l6?=
 =?us-ascii?Q?ZdsofXcQ0nc6hRqAqMM64Gh2krXGtRnH3hKpeOfGRUAo1qqRAmMxLKfkmNnb?=
 =?us-ascii?Q?RBJCapEeMK1ZeBEcqNp6J+khrWS78k9QD5gv2T9ZK72Wxw2FOwHC9hD7EOOp?=
 =?us-ascii?Q?r+UaJjoK5gm/CbgBgPsiNn5RV4/q9TijPJpfr8N3T5qqwrjXYFvEt/4b13Iw?=
 =?us-ascii?Q?zGBa0bKaj+hjjAUrIwQCa4FoCB2Ag6aBWV0MopmHdqzbHOx7FbChrG0UAffl?=
 =?us-ascii?Q?hNtUC2lOi1itZJJAVWu9IfSoRlG6EvHUGCxVOhFHJLNzVRwDYvoymCJtAAs1?=
 =?us-ascii?Q?VdUhlN78USlLVHS2PeQM0U7yKX9ECP1DX6E49CtUA96ZKA6FED/lWcanqRpW?=
 =?us-ascii?Q?wUXMZO35Gt7km/M1ETtIJ3g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729f537e-91fd-47d0-4da2-08da00570a04
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:25:06.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wR84XXci3/GKVuMtiaPV07RvdpRDpci01y+I+MACApkXFNRoAEoZtHtIu83e1lZ1CQ2FyBwT7sU/834hdBxbQw==
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

Allow PCI EP probe DMA locally and prevent use of remote MSI
to remote PCI host.

Add option to force 32bit DBI register access even on
64-bit systems. i.MX8 hardware only allowed 32bit register
access.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
 - rework commit message
 - Change to DW_EDMA_CHIP_32BIT_DBI
 - using DW_EDMA_CHIP_LOCAL control msi
 - Apply Bjorn's comments, 
	if (!j) {
               control |= DW_EDMA_V0_LIE;
               if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
                               control |= DW_EDMA_V0_RIE;
        }

	if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
              !IS_ENABLED(CONFIG_64BIT)) {
          SET_CH_32(...);
          SET_CH_32(...);
       } else {
          SET_CH_64(...);
       }


Change from v1 to v2
- none

 drivers/dma/dw-edma/dw-edma-v0-core.c | 20 ++++++++++++--------
 include/linux/dma/edma.h              |  9 +++++++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 6e2f83e31a03a..081cd7997348d 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -307,6 +307,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_v0_lli __iomem *lli;
 	struct dw_edma_v0_llp __iomem *llp;
 	u32 control = 0, i = 0;
@@ -320,9 +321,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	j = chunk->bursts_alloc;
 	list_for_each_entry(child, &chunk->burst->list, list) {
 		j--;
-		if (!j)
-			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
-
+		if (!j) {
+			control |= DW_EDMA_V0_LIE;
+			if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
+				control |= DW_EDMA_V0_RIE;
+		}
 		/* Channel control */
 		SET_LL_32(&lli[i].control, control);
 		/* Transfer size */
@@ -420,15 +423,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(chip, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
-		#ifdef CONFIG_64BIT
-			SET_CH_64(chip, chan->dir, chan->id, llp.reg,
-				  chunk->ll_region.paddr);
-		#else /* CONFIG_64BIT */
+		if ((chan->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
+		    !IS_ENABLED(CONFIG_64BIT)) {
 			SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
 				  lower_32_bits(chunk->ll_region.paddr));
 			SET_CH_32(chip, chan->dir, chan->id, llp.msb,
 				  upper_32_bits(chunk->ll_region.paddr));
-		#endif /* CONFIG_64BIT */
+		} else {
+			SET_CH_64(chip, chan->dir, chan->id, llp.reg,
+				  chunk->ll_region.paddr);
+		}
 	}
 	/* Doorbell */
 	SET_RW_32(chip, chan->dir, doorbell,
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index fcfbc0f47f83d..4321f6378ef66 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -33,6 +33,12 @@ enum dw_edma_map_format {
 	EDMA_MF_HDMA_COMPAT = 0x5
 };
 
+/* Probe EDMA engine locally and prevent generate MSI to host side*/
+#define DW_EDMA_CHIP_LOCAL	BIT(0)
+
+/* Only support 32bit DBI register access */
+#define DW_EDMA_CHIP_32BIT_DBI	BIT(1)
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -40,6 +46,8 @@ enum dw_edma_map_format {
  * @nr_irqs:		 total dma irq number
  * reg64bit		 if support 64bit write to register
  * @ops			 DMA channel to IRQ number mapping
+ * @flags		 - DW_EDMA_CHIP_LOCAL
+ *			 - DW_EDMA_CHIP_32BIT_DBI
  * @wr_ch_cnt		 DMA write channel number
  * @rd_ch_cnt		 DMA read channel number
  * @rg_region		 DMA register region
@@ -53,6 +61,7 @@ struct dw_edma_chip {
 	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
+	u32			flags;
 
 	void __iomem		*reg_base;
 
-- 
2.24.0.rc1

