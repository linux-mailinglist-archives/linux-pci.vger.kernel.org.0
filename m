Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C2E4C9C1F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 04:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiCBD14 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 22:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbiCBD1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 22:27:53 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20067.outbound.protection.outlook.com [40.107.2.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F9BAEF27
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 19:27:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8NX4ilrE+/6Ww27IX+sxNfhxjeSttm3CEL7cuyd6AH7hRROWaEh//4F9yqFthz9J5AozAr7vTGmd9WUsrEOFRhXcPrEbZ+oI/7CFezkoiQ67AJIuOWQXkS+z+mtQWZd5KnulObQYMGlt4ZolfK5H1hO5TwwqA7lMRvvLRzopMOG90vkHAjuVBXnlWeKdbmTEDB/vJuch6nxKRdJyQxbO1i7mrYll1+xxFTb36LcIMFC7Rm75ugxP+Sabtlg6l3UsEZ/D++dq33WhIUyCvl6uiiSaiUN34ANNCD90qUbkqQs62EPNWDiXRJSaIX6O/AyJJTwy1pa0oo/WAUaaeOGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iacAdNaUm6Vi+8h2R15/RdpYlj9+UDECCDw5Nx9RE/A=;
 b=MiWnaPa17651OGQQV8H8UMVi2ibCp9T8v8pGZz1tRHG+lUHmJnzxEycB3zbEjFJ9xlfvsB41fhYgYCN6CqYNAxMoc9FmFJWE9QI0zdQ9gyF/5VVWLEagYMdxI2qfuKq63veUc1iUnKGmBg70sOuE6mL7OYbwfWlR8j+Ah3LTJq0hEi7eLiWFS+AKf2V2ipuc1nQ9EfBb3iY44ZfScSJSI1xTnBTTotLeqTplQx8EDToKFy3ql15pEAPLyNiRkFKVScF+3g5wjBuCWjlfdsEIYXTj+a3Z/Z1y+pcC6uEVDobc5PEhww/FJshYFJfyrhKKAg5afnqHF+FHNUE5NR6EuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iacAdNaUm6Vi+8h2R15/RdpYlj9+UDECCDw5Nx9RE/A=;
 b=cwbXS7JfNfMx48AJHVsisP5OouSC/vVgnF6BdocXjgql2A19lQIirB+RiJp2fcvim+Z03ootH34KOqacCpr4I7Ws2JXqc+5/tUs8hdDcvLO0O46/mx3UB0ALUO5vkWpEk9TK/coIT4cATilSweo0mmeyKcTzANKQK2v4qmK0yQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB5926.eurprd04.prod.outlook.com (2603:10a6:20b:af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 03:27:06 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%6]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 03:27:06 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org
Subject: [PATCH 1/5] dmaengine: dw-edma: fix dw_edma_probe() can't be call globally
Date:   Tue,  1 Mar 2022 21:26:42 -0600
Message-Id: <20220302032646.3793-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96e0bd14-3e89-4807-0ee1-08d9fbfc86eb
X-MS-TrafficTypeDiagnostic: AM6PR04MB5926:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5926986E602548158CE925E688039@AM6PR04MB5926.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9AwCWbtEtoDruj5RDoz3ZmWhWb3NvXRfH7gx7S/PAgxSAgIgI9aof0VZkt15wfNHSy/of3zEPKDBcdW8xEhm82puzCY5DeEjiyOR/HscY7468NIYjGloP+o14k6sIfu0GwAArP+Dw+3CH9OmEyn9Ay/CmEgIT5Zj21wgI9RLq5N4KpfiGFMzqflJMGzwJXUo5mHrVVWYi6dWyKmDqAVoXbgFxhqj0wO6PGtwkmMQ1ZG4aNkiACaIsfHziDQHNXjjkn+S9TL0uZ/CyPD7MHpETsQBONDujgi/s5OPYIER5pPpa1QlcFQxlzs+yCW6yz5L9nk9Kaj1yLqoaJXkgU6dODWGyjd0VymiKLF2FU91dX0HZKmYg8J/Z03vCvoxYP5rLf/N6QVIEE/Coavr5KSj5GEMNe8fjp2CyutDHkYFiIt6IaLxE7zfJB1O0T364+bbaz6fJe6CKLx+KIDUXA2lRn6TSbIzS0jlJ7KLSyJiqvGOgUUE5c7kIp5cMca/LEYQ+nzbC/qCxr2yLQSo9jOj7oK/8khQOLB5hHe2jLaVaM2yzH2caDCT+YgLrmTnws/UMvoBYkG555U/0FYCPszigga1sm89dGeNJ5pf8WBgzJ6NgSH4o1jSCrMmR25HWRzewziSuyib8cgTUsuZmxxMX8ZmLg5T+X1ypYS/WGjP7RDQzl7icXOb4+tmzEcknHNqBYSCy5aRmc9kngyQde2Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(86362001)(66476007)(38100700002)(8676002)(66946007)(66556008)(4326008)(316002)(5660300002)(2906002)(7416002)(8936002)(26005)(2616005)(1076003)(186003)(83380400001)(508600001)(6486002)(52116002)(6666004)(6512007)(36756003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2IpnXyD7IfMFlJ8PUdiGCWCrFh1EwRDG6/1G7U+Yc+rxFXBH0MeZ/Gf4p0xO?=
 =?us-ascii?Q?sGEV0X9A6v+uE2wsH2l4+JQW/m6ojKBDCiXEA+ErLzoOfO8JmUQe+tR5Dwy3?=
 =?us-ascii?Q?TSEoOon8d9tR/FSHKNfXiQrL38WhNtYFBZzqIL7LD8u/DS+824jQBLW5wXXT?=
 =?us-ascii?Q?KmxwtCEXm2lAm04jwTFEzAMY2ilZUGqU6y+BCV2MnGSRkQgTRMedp9Au0Bpm?=
 =?us-ascii?Q?XQBzdxPRJwNT2yZZao3Wc0yCiYjqjeHNMqvrfzSW0qQL1qU62QCm1wV6grOw?=
 =?us-ascii?Q?AD75kZ8ebG3RyW5k5hR5cwSplPTIEO+7Ew5WOCgUxwZTuOonxVihPHD9s9JS?=
 =?us-ascii?Q?EotHiGLp3XC+QpdoMYx7BJ3vThnX7y8+CiRA8kjrfsvSv9OE2dJjP1wt/KxX?=
 =?us-ascii?Q?xPUxfm4UrNPaepaXQWdTZLQ4VcrRAE44Fx4BC48RS5hvkjk6GNgSe3fVHiU2?=
 =?us-ascii?Q?yye4hK2jI3s4X9X7nRoQE8VQhBnPFIYgqjFwGq4Le+oq8/ASsNaUk71oGszs?=
 =?us-ascii?Q?cA6eI3kmOLpjCPz8j8GL9GsuQW6L7mFEPujcTEPEboLpUmez4YxS2TrO/FrH?=
 =?us-ascii?Q?N+IN1ZqdNf9hCrw++qS9UCZyKM5jpppQCYBdj+jzObi0K2/BuRK7ts+j+sUi?=
 =?us-ascii?Q?CtnlqvHdNGnmuJ0z8rQTQ6YViFZijx3H4zNThPxRJWQz2hKQf71xYVRTg0dP?=
 =?us-ascii?Q?dFPIolmSN2awoqKZR7BmZ5Nsj0wVLi/fLQCnkpmO2lZy2F71hc/7ejbsO23o?=
 =?us-ascii?Q?mRwvMI18az30MJm94cTN3xcA13hq+93LVGNvPaRf/yknU16hsK9Gy+o5OgWy?=
 =?us-ascii?Q?PmN+LQF6z/gGeURDqJAHE+ggb642VGCi9nFrOS++pSXSpRlkEoVoDgTwFRDf?=
 =?us-ascii?Q?eQMhHH1iFOmeOzEtxkQ8mxIkS5ENFeGZ/H5yvBut3C7KSDPte+LV0fUBWfwV?=
 =?us-ascii?Q?V8qZd5oaQyJ+ERy0YLcpnymPqwwQ+quLnPR5g+gtF3hueZCMyuzi5OqsoEbu?=
 =?us-ascii?Q?K+HuJFq5fkhObmTnWphbj6Bq+mwUy4ViCCToc8UCfWZgdX60D+ZNZEEga0+U?=
 =?us-ascii?Q?k3N7LJsw8626r2WbKtCo1eLggZo9R+DtDPFDCAw/m3l4LP4NoyeZlsRiTPRe?=
 =?us-ascii?Q?rMO2LQaKgQNyE6VdUD8Ir9bCiDGmCTswTn3QvOf8Sz+/GhdQqM79XBJ3Et44?=
 =?us-ascii?Q?svkNJl0Rgs4LPS0XRhB4B6dF36a70OuBgeW0YYmS6ONBf0o4UFdN8o3H2HK1?=
 =?us-ascii?Q?ZByx14o+gKpMXdMNjdm2ZuCulM2RyOw+IWpfaO9kSk55jQJ+YD+J+wVgT4ai?=
 =?us-ascii?Q?b2fRSgUNLhgYifWN4MUznzBnB1V3nSYx6MLrO1YGoS8KGCOeDFC16trAHHx/?=
 =?us-ascii?Q?gLTFnrXFsmCsAdaGilkBg0Uz+QQBYBk7YNQBbcOM2oWj88hRb5T4dLmQfkZY?=
 =?us-ascii?Q?mFRCc3eAV7L26Xaot4xZ5Gw19DSqRV4gKlF3ckMIVineHIuBBBxO/liIvZZn?=
 =?us-ascii?Q?VseVUa21RPpxlc24BdCtBVLqk1EJMPjKOdSRqwb0rn/km++UM2t2epfuxTd/?=
 =?us-ascii?Q?WipJWwYDj3yatx4NbJfVFfj+v1g1MTY01cnh9MiEo8sxEsVL85wqRj8NrxFZ?=
 =?us-ascii?Q?1XBnDQqRcK2RjymzS5P+mSI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e0bd14-3e89-4807-0ee1-08d9fbfc86eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 03:27:06.5549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jrTepbPYYsjlTfnA+okYM+GYJHXPSsh3yhm7piZ84Q3QOo5mPwy6FnEjJm+uPd+IK3sL632D7+OfgY2Zlz+Bw==
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

API dw_edma_probe(struct dw_edma_chip *chip) defined at include/linux/dma,
but struct dw_edma_chip have a hidden internal struct dw_edma *dw,
supposed dw should be allocated in API dw_edma_probe().

	@dw: struct dw_edma that is filed by dw_edma_probe()

but dw need allocate and fill chip related information  before call dw_edma_probe()
in current code. See ref
	drivers/dma/dw-edma/dw-edma-pci.c

Move chip related information from dw-edma-core.h to edma.h
allocate memory inside dw_edma_probe()

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c       | 31 ++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h       | 28 +++-----------
 drivers/dma/dw-edma/dw-edma-v0-core.c    |  2 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  2 +-
 include/linux/dma/edma.h                 | 48 +++++++++++++++++++++++-
 5 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 53289927dd0d6..029085c035067 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -905,19 +905,32 @@ int dw_edma_probe(struct dw_edma_chip *chip)
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
+	dw->rg_region = &chip->rg_region;
+	dw->ll_region_wr = chip->ll_region_wr;
+	dw->ll_region_rd = chip->ll_region_rd;
+	dw->dt_region_wr = chip->dt_region_wr;
+	dw->dt_region_rd = chip->dt_region_rd;
+
+	dw->mf = chip->mf;
+
+	dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
 			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
-	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
+	dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt, EDMA_MAX_WR_CH);
 
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt,
+	dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt,
 			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
+	dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt, EDMA_MAX_RD_CH);
 
 	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
 		return -EINVAL;
@@ -936,6 +949,12 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	/* Disable eDMA, only to establish the ideal initial conditions */
 	dw_edma_v0_core_off(dw);
 
+	dw->nr_irqs = chip->nr_irqs;
+	dw->ops = chip->ops;
+	dw->irq = devm_kcalloc(dev, dw->nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
+	if (!dw->irq)
+		return -ENOMEM;
+
 	/* Request IRQs */
 	err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
 	if (err)
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 60316d408c3e0..8ca195814a878 100644
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
@@ -109,10 +95,6 @@ struct dw_edma_irq {
 	struct dw_edma			*dw;
 };
 
-struct dw_edma_core_ops {
-	int	(*irq_vector)(struct device *dev, unsigned int nr);
-};
-
 struct dw_edma {
 	char				name[20];
 
@@ -122,11 +104,11 @@ struct dw_edma {
 	struct dma_device		rd_edma;
 	u16				rd_ch_cnt;
 
-	struct dw_edma_region		rg_region;	/* Registers */
-	struct dw_edma_region		ll_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		ll_region_rd[EDMA_MAX_RD_CH];
-	struct dw_edma_region		dt_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		dt_region_rd[EDMA_MAX_RD_CH];
+	struct dw_edma_region		*rg_region;	/* Registers */
+	struct dw_edma_region		*ll_region_wr;
+	struct dw_edma_region		*ll_region_rd;
+	struct dw_edma_region		*dt_region_wr;
+	struct dw_edma_region		*dt_region_rd;
 
 	struct dw_edma_irq		*irq;
 	int				nr_irqs;
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 329fc2e57b703..884ba55fbd530 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -25,7 +25,7 @@ enum dw_edma_control {
 
 static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 {
-	return dw->rg_region.vaddr;
+	return dw->rg_region->vaddr;
 }
 
 #define SET_32(dw, name, value)				\
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 4b3bcffd15ef1..a42047791e727 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -288,7 +288,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!dw)
 		return;
 
-	regs = dw->rg_region.vaddr;
+	regs = dw->rg_region->vaddr;
 	if (!regs)
 		return;
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index cab6e18773dad..fdb19c717aa09 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -12,19 +12,63 @@
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
+	u16			wr_ch_cnt;
+	u16			rd_ch_cnt;
+
+	struct dw_edma_region	rg_region;      /* Registers */
+
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

