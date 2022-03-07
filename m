Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8234D0410
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 17:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiCGQ0B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 11:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244127AbiCGQZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 11:25:58 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C615C872
        for <linux-pci@vger.kernel.org>; Mon,  7 Mar 2022 08:25:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbsevfGIL+7WEuVLKh5lda8qnx4/xnM9RQdiIQCsGxAYkMhSmV/t7SNXNk4z76Bp7NHvhKTGja7If6oqUADYV1a0BiCf+pUruu21QnqBImCDzq2iGeO4QMlMrerqlQ6Xt9WN4eZK96x1hND4mIz/oOc+rgjd80k/kwAbxZwVUd/rmn93BuGrFYSkiDp2ocIshPUk53hWoi3EIXaXPCDKH9w6zXcqcYjT01SOheYDQ+o6rvDIwtSElJi2ZEwl49obPiyju5guw0CX8pAl3iLybN0oCjWt2oz0JiE79KTupKcnareied1MjSSpiOnORqwpjXjXyZCsOKwVECVGI8uVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+izjo9vorlwak5B2rQPAous7WnTsyGkABrTduvVjs4=;
 b=ZPyKJoxJEETuQASo0drWnU0kq3nWbrNhu4Jazofr6yl05IpwfaprQa0pA5SpH5sAZC6+OxZKu0eHtFBwxpbp7hrzfJJF6CvRS0ioQazkkgCzp6n8cK7zYnsZfgm3XWPJ3P5/0kX4etnVO5Ru3UrOOE6PfmlUTdlrNFkSkldrzhhdmH3B7IVjJU7CbYWBk8EfHqYDNZOYQzUOoFw0tLtPsx0bpXEAT7Ijly4d/xMKdh9VDc3yGnCPMSUQGU1YeqjcTkLOIq2CSi2hM5kwlkVVMDyXM9MiOKKXoysza075Rmr8jFmwx5vPpBDcENEAhe/zDZ+DoSyBNzl3JitC+0uDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+izjo9vorlwak5B2rQPAous7WnTsyGkABrTduvVjs4=;
 b=VRTi78a2OK/e0upEM+Hy5bWRX9IxTEktmkg+DFjAflC+COCI4okyAYl5c9xaOSpyu6Y2lp//ItlbYfYuplFOIOa6r4FUXhA+LcNOf47tU3WkWBCyf76muPonKyvUmjPVvuZTAJPtdVAB4unPWi+6ArfzIYnWHit8xoet8Tm5+n8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4530.eurprd04.prod.outlook.com (2603:10a6:208:70::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 16:24:58 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 16:24:58 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v3 3/6] dmaengine: dw-edma: Fix programming the source & dest addresses for ep
Date:   Mon,  7 Mar 2022 10:24:27 -0600
Message-Id: <20220307162430.15261-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 775652ea-959a-4750-a484-08da00570560
X-MS-TrafficTypeDiagnostic: AM0PR04MB4530:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB453049DD69DB0D0D4049165588089@AM0PR04MB4530.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BAURQiXc6AkYsAzMwXM5+ugyHFMoIUduAMhMtAxqB4fiUT33+Ji996atdjihYea9g/Hucoyb/VpoNyjeTUYRpMJjfYmPm++W8AoRoAJrcTF1cYbh/4JR4IufEc1Jx04iq30Vi/FN3iRN+ol8Z/1gfs71zfsUS+HgdVVhI4jyH0R17qStL6ASP1A10UWg9tYXfTKV4l+2S/bHyzcMj/UvzZpt7O+VnUGHW3lvA6wZPG1YjkGG4U1gqdPWaecCGbmGeX1ZDgvnS7aluFgvKb4k6hrGt6CpwKPooGi8qvUuFMzsgl2/j7vUVGZ4nRpVxsdESKHRDqQeP48C8OKaAdAS2JWdJ8G2hE8qRdSZdQ504e3qBDbkJEtpnQkvTNsYD+JOsN9JGh/XYG7Sa62CX0k89BBC6hMyELhwrwbs3LgIh3oukoPBE7j2q0tvzXx6BoS+8+JC93CiASt2RVsTiyVa3dIN8UFWuuJ6NDe5xM1cdo+yBM0ZDzNvFJzLePx7p/KZVdcD3Ed+nORTkOKmy5QbaJWOH1Q6H1JbvXajZOW0CGgi32ydAlRd/uV9oQzQKzjEUEuJpcBMASEbsltFTNIyfl2NtOP5VfLJKPf3KPyORDnWX1qGxyCDebwqbZrdUXeQ1n5Ockzoj4V2z1Hr5+UEFilhqxHkBHKWrG+yn+yzJWKfOVs3hucQC16EAgNypuljUWm16Ej9kc15EU+/tudtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(316002)(36756003)(83380400001)(38100700002)(38350700002)(2616005)(1076003)(26005)(186003)(86362001)(8936002)(7416002)(5660300002)(66476007)(66556008)(8676002)(66946007)(4326008)(6666004)(6512007)(6486002)(6506007)(508600001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?khYpSZcSiwc7k1/4GGDukIOshPAwJMuzlteefNFY+jUq3uus6VlIxOEOglEr?=
 =?us-ascii?Q?zcEeWs8Fzn4zNK5GxLhjp44E0LDQgVl87qoqKmTat8iUFOsgVrYi9xm4Iow6?=
 =?us-ascii?Q?g1zoNc7jRT1vGzNZJmHyNTc4KqIZEJYTC8+MrOrMbM9/eLiT8kdfumj/cSvn?=
 =?us-ascii?Q?WWig3hXVYyISOP7HqpVJjwtIsTMnWKIkhiSoOpjNLngvTDLhorWzEVnZhN1+?=
 =?us-ascii?Q?+WRhxBnGP+7Ai4yjDRjYhH7rFmTcoyCjUU4HKB+ejRbJ4Ztjp198AcPj7ttB?=
 =?us-ascii?Q?NC8sJyfJoQLyrAbVn+TkonnH/ermmMCN9MFQElzlsqz1m3A/NOdKtH8DHBsJ?=
 =?us-ascii?Q?hMDou90s2aJBgV3W8QrKD8YrcVN9E/9X0EU+zXkvInIf6KABOFItczXslx5r?=
 =?us-ascii?Q?JESLjlzYv7fzH3ZqrbGCUygS+hiJKy3XZtoFXgqjNmn1s3EUZDsAKR+fisL4?=
 =?us-ascii?Q?j9L0hSwFKOjJLS9GZ7fYyBOhLSLlb96atP3oB5cvuWoX92jxP0KunmX59Xvo?=
 =?us-ascii?Q?lg0blgYp7sJppi0Z3JUp8VfJaw3ObBMqejsOUTeFATi0sGABon+FBwWmAsMk?=
 =?us-ascii?Q?09Cc0me+lcaDlCJzd9WkEqmV1nZPTOoif7KNzsbp+5k9VOFzdzTSeUFhzLok?=
 =?us-ascii?Q?40PiOdQmRYwoPZtnHw4HBZ1+8mpYiYyFyWQL+mn5SCUTGh2rw9AZBf2nCxK0?=
 =?us-ascii?Q?Q1goxL1uDdr5OuBHZIsDFkdxhn5l1ejlCK8UYsKmHiblfXI59Xd16aKaR1Az?=
 =?us-ascii?Q?1mmrWCq32OzlUYURcAfzJ4i3JAO2TMlXdIXcRYDIVRCaPZAd0q2jecHBYori?=
 =?us-ascii?Q?qO7C0kR7jUmEgvYabL1ixXBX+eVltL+4LGv8iuiUy2xuLgYke/jMANo/5HeT?=
 =?us-ascii?Q?idvMOAlO6rBFwJLgvxoXMGJRCmx5Rhb2aivLQZnMy/x4p+bOjJ9iioUt1QQP?=
 =?us-ascii?Q?5nXm+RE6meTSmNtiJgzGavkNL/L0WKsXoorYCLLinqy/WhiO5cRtr9DzB0Vj?=
 =?us-ascii?Q?YJROhLusIBFXnJgpzinhONpUdV3yi1VwEYBZ/GQ36tKyhPqO7VK6rh9Lcdss?=
 =?us-ascii?Q?RaDjqX1cHITnD921yKN1olTxQvcavWSaZGo8AjggmE3nzFyxeqoEWkLgco7Z?=
 =?us-ascii?Q?iMCzLa3OsFBuswzeMTFSlThRGYsnwLwvJmSiezj+JwtbT3r5o2bvvbxbCmml?=
 =?us-ascii?Q?NYc6z+dgcOcPPGjraTDIC2coS81oUH9D/2EK4Lmt6KgWGhGx5YE4zoN5a1s2?=
 =?us-ascii?Q?/ApAF6MabaGu9uaA87qShte2vJXlB4jwgtbBbrXXeB1gmYE77uB9T6of1OUl?=
 =?us-ascii?Q?pBeaTo4xrZKL4nl1vsC+Q5bo/B6YT6t6IQo7MbcLF6FGN3VIjgRrCOVSPj4H?=
 =?us-ascii?Q?SZ4WBpkBpUsTaAdU5Y2Mq2DUGsEyyD6UE9Sti2vwo3B+lE54sfWYJx0teRwL?=
 =?us-ascii?Q?3YtokRxONcM2GnELn9aa3GXmzGDAmvHlTGspkjOMWBUbHnH/Oj257KhEnxVq?=
 =?us-ascii?Q?denNNOdBqg5gXDNd4eSXreQWL7G0Qn6ZTrOeUQ5rgjwPMrP4wKfBd/ccPLrs?=
 =?us-ascii?Q?nb3IObpjUWKINOzkMWJb0a7aO/BPxQZ+iqkmbM8N7voX23qaFwNipD8pFxTm?=
 =?us-ascii?Q?nX8lrLTkE8As/kHVi6Zthhg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775652ea-959a-4750-a484-08da00570560
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:24:58.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gfxl9Ekt+8asycLPxj5fggx0oZRjfFHNL9ZoIMdKa0iXveXS+Xb8Kog4pkSkZT1NL+FHRefcU9AZmUO+IfDSQ==
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

When eDMA is controlled by the Endpoint (EP), the current logic incorrectly
programs the source and destination addresses for read and write. Since the
Root complex and Endpoint uses the opposite channels for read/write, fix the
issue by finding out the read operation first and program the eDMA accordingly.

Cc: stable@vger.kernel.org
Fixes: bd96f1b2f43a ("dmaengine: dw-edma: support local dma device transfer semantics")
Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Change from V1-v3
 - Direct pick up from Manivannan

 drivers/dma/dw-edma/dw-edma-core.c | 32 +++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 0cb66434f9e14..3636c48f5df15 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -334,6 +334,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	struct dw_edma_chunk *chunk;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
+	bool read = false;
 	u32 cnt = 0;
 	int i;
 
@@ -424,7 +425,36 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		chunk->ll_region.sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
-		if (chan->dir == EDMA_DIR_WRITE) {
+		/****************************************************************
+		 *
+		 *        Root Complex                           Endpoint
+		 * +-----------------------+             +----------------------+
+		 * |                       |    TX CH    |                      |
+		 * |                       |             |                      |
+		 * |      DEV_TO_MEM       <-------------+     MEM_TO_DEV       |
+		 * |                       |             |                      |
+		 * |                       |             |                      |
+		 * |      MEM_TO_DEV       +------------->     DEV_TO_MEM       |
+		 * |                       |             |                      |
+		 * |                       |    RX CH    |                      |
+		 * +-----------------------+             +----------------------+
+		 *
+		 * If eDMA is controlled by the Root complex, TX channel
+		 * (EDMA_DIR_WRITE) is used for memory read (DEV_TO_MEM) and RX
+		 * channel (EDMA_DIR_READ) is used for memory write (MEM_TO_DEV).
+		 *
+		 * If eDMA is controlled by the endpoint, RX channel
+		 * (EDMA_DIR_READ) is used for memory read (DEV_TO_MEM) and TX
+		 * channel (EDMA_DIR_WRITE) is used for memory write (MEM_TO_DEV).
+		 *
+		 ****************************************************************/
+
+		if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
+		    (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
+			read = true;
+
+		/* Program the source and destination addresses for DMA read/write */
+		if (read) {
 			burst->sar = src_addr;
 			if (xfer->type == EDMA_XFER_CYCLIC) {
 				burst->dar = xfer->xfer.cyclic.paddr;
-- 
2.24.0.rc1

