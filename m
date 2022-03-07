Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4684D0411
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 17:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244163AbiCGQ0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 11:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244162AbiCGQZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 11:25:59 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF435C858
        for <linux-pci@vger.kernel.org>; Mon,  7 Mar 2022 08:25:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdMfFjskO4mO0gTtJquVqWkAmQi1sdV0bV/ldCrbGkcrUhr0NJ/+nbXZ2dWVBxtsJowqKf0GIji0ctEJ6XFmMSRAjn2N5/8IDYM84OXTRZDhe/xC+a+qVbJmGg61OLvB/RDVqtYcEsTRJbszrv8n9+Vs6Z5X4q7Ii+Jh+xTlAYizlrUgRuiWpDV6Cv/8fB6HkdgQq+qOANuJjcf2rMiLWCoqPZkY2CSLMlgMZ3z0M4POXQKgEFUBqUJHWq5S8vJxxUuVNZFt1g9tBX91hWNCs7t2kPELe4ju8nDfwXK8lnoF4ozhxGl4j+eI7ccj7c12b/PMszaxx0uYqYnoREe3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhW87EliIWUugHJYYrbQrzomjaHVOffFyqOAywjagwY=;
 b=jcfADR6mZBSwn15fJ1GZ6szNhuYbAIuXg0+pmgmtbfhztzHPlgkVVL7gchMIhWUdaffD6RoskjOF4wWtKkwG9YhdJfe3IL+fNZbjrsey2sj+07vR1jYsixG5MzJ4N8IORbuUlV3awPnyyk82XgfmKVqZUUiupiHKzKEu64t40DJLGgPsIktcjbXMYJ4TK9WVT1snGsC7fOTuQaNa/tYRq7UhhEsIL0uLf5+VSGs/Ear1piu4EoTT1LES+teTr5pcrFGMLE03rl7IZrqku4BKdzzT2sypFXPRdpxJKf9t7S9cYLEOo6e698z6+gPgs5nY8VTF827oGiTo4mDvHcPHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhW87EliIWUugHJYYrbQrzomjaHVOffFyqOAywjagwY=;
 b=EVJjQj44iPSXR2PJAp8DotYHI0Nm61XQ4ISUpSaIbEoaAVhgBlp71ukfc+1FV/eBTR+FMioUXCrP2VcFTULD7D4zjTVfI37RR0Ix4y0xS6DDsleyflyaDemziXc6guo0RsYamvHoKh6qOupuGsbhsifqhNlxy2lfu2SBc4aAuo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4530.eurprd04.prod.outlook.com (2603:10a6:208:70::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 16:25:02 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 16:25:02 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v3 4/6] dmaengine: dw-edma: Don't rely on the deprecated "direction" member
Date:   Mon,  7 Mar 2022 10:24:28 -0600
Message-Id: <20220307162430.15261-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e292cfe-bdd2-40bf-ba44-08da005707eb
X-MS-TrafficTypeDiagnostic: AM0PR04MB4530:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB453096C566BDC6AC8562E13088089@AM0PR04MB4530.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9xknn9a3eKJCqKf9K98LTZKBJ+kj9jg/88Kvg+N4LCg5rPG4JItNZDu8i80MXxiPb/NVztOlv9zCV0YF/8qlnBw6DL8pme3nbUXDBXx2Vv21FAhOLF8ll0B1xCaSZgjnq4CQqOuOJPRgf5W2hgNgymb1leun4XgdrQDdWuP5wSKOfuW7zQfQbMxkPQOyoRLMBxAF1zczwtzST8Arzy1mNOCTzgeO+OEfjSGIJcaevUQvuUBVRaW/n0gw3BMr1UErlC7szi4+FLymnj+p2q+uO5aGiyg440keil6/A+/G6Ed5ff+3W2o5bTEh/fef8DfT/+DzrkJqSsTEF00QadS9o0dMMTPIRMHoNfZeegLXHNUohv5+LU5RpGnBggKESfTHBYB3S+YoYrEvfQk0fLaH4OOTYFwueSZdFr40Wr6oRmGArHX0aDBD80JJZZsjKK1js6nJ5J4D1a9le7KQV0tH6cEkhOOJLq752f4M5GRkjxn3D9zzAhNWq2alcq7QAV+dDY4Y7F6makEn+S5u8b4N18I7mwdys3jA28gvjvtciLX649ZZdEC8O2sAHuGG6vMdPKZ5UAyDUW416cSNfleRzcMPaY+kJa1A+JZ1/HXZZPPh7a6mMyqtFmEcB6G+1KbARik1vHmhbLY0XmCF3yxygYNw68x5i/eXiHIMkY3t+reEAA4COQ6ojeloSOO/bpnULUzRzT8Dfou46l/EwkqZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(316002)(36756003)(83380400001)(38100700002)(38350700002)(2616005)(1076003)(26005)(186003)(86362001)(8936002)(7416002)(5660300002)(66476007)(66556008)(8676002)(66946007)(4326008)(6666004)(6512007)(6486002)(6506007)(508600001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fc+tSsb6zIxEhAHsNquNLsxe7iCseLboSFLFiMfvwaircjgoJehXRQwMDztT?=
 =?us-ascii?Q?TwmcT3wLAjT+vXRONGiaeIvaKtTVVxbmYMoe59fzYmJonEnYJixD8eanwe0L?=
 =?us-ascii?Q?1/i5NuDhbcn4x1OvkQvAdmSNbGY19mmvMfaygw+5jTFxyQVHI3wldThzCy6n?=
 =?us-ascii?Q?PZRnHiaRZo5+Bl7LCpEB9mifdRMM5vLU1eCzIdo+3yR/mmvoChcHOyGJ4CZQ?=
 =?us-ascii?Q?tzteto9kQidxSS7zPp78wYxqcYM20bv3IwWi73/Ra6sc22j6w1GRL38BURbC?=
 =?us-ascii?Q?smUicSiT1b4D86g12Tea0dNUUKKkpEi5GfVHuvPMbuxmL4aHBUrF8nbMT5gO?=
 =?us-ascii?Q?/fHycsJYeAItn0tcgRlx3uhA1b4PC6HlRf66go7GvoRh1oa6CNPziG4EsO6e?=
 =?us-ascii?Q?PJys9GQfNWe5+tT3w+ou0+lyzlpiKb8BFNX7lPv25+KMJ433quWHFUwlemuU?=
 =?us-ascii?Q?P91VdlVpgpNnuokpf4oI+s44DgMagz0hfHKdeIWG0Qi6ZUqkIu2GDlolkubI?=
 =?us-ascii?Q?dGne5W8f7VdSnGZXgMQg26a3i8Tkpy/14BrHXCuMPE5GBxAdUBJE+07M+3wr?=
 =?us-ascii?Q?E26yMcjIF1JsuRgVV4xzlTHwPfOy3SMga8fVD4RrU2aE9ebjEvj0flLr3Bwe?=
 =?us-ascii?Q?SKNg4dZ6sRKi45wzBSBKwaBHmxSBndBeN0xrIfSD9JW/b/ASqShktfvkl0Qr?=
 =?us-ascii?Q?kVJ080Le/caL0waZwE3czuJcEWvULmRNG2vyFgzMfsb8hw88AyVxCqoLktcG?=
 =?us-ascii?Q?KoMwsBaCvx6qdx3foeSiPFfzgS0dV2GKq7m6okqYHug6K85x7XLxrEt561lR?=
 =?us-ascii?Q?YPzS/xMDkMVTl/Eh5iMUIMuEVczxncG7NYJLdEmSZK9v+hlJ5a+insZAePdV?=
 =?us-ascii?Q?IouFT/qHNHHmaaY7J6NJXQ8wdHI+lcyZ8WHJbOiO+/utNXochrqjjdLo37Ek?=
 =?us-ascii?Q?196VMFUOfyaO06iq/mAViJQl3DjK0WqzjNkXlH423GjeKMBeX7juS0pb80Dr?=
 =?us-ascii?Q?DHOUa8CxavypU4+4k53C3ULxYnAuv/dKZdWmiU6r3HM7lRJ3yq+SBeeC2wY5?=
 =?us-ascii?Q?qOgfsjFQO35DjiQW1Zd0Zt6y8vTX79sZ+LeSYZ6SNSccyaYulX3D4LRTsnCi?=
 =?us-ascii?Q?kuRUBIxf1Dth937wig7eiXkzLOhsVNcpoAc2w9sesOfZOvu9T5B+cytDKvQ4?=
 =?us-ascii?Q?9EOUoeG7Y1jjCRTiNbG/huXEm1J5njKXEAxhLBrAIduX+caM9p7FRmw71m/i?=
 =?us-ascii?Q?9av6Q+zIV+Y+LLgO3qO83s9rL6m+CUNSbQHiiAKiNdySZKqLs+jYRqcBIk2w?=
 =?us-ascii?Q?yLy3+pzZwouf01U/T8O7XZ63ReXrwbqEkWl3T/vynxw0nX6Oic6N9UhgpC/3?=
 =?us-ascii?Q?ghnXa/gCaXTJLdAz0j72ug9JJ87Hfyd5CPYVufq8pJ2M6fRPAqs68l6fZKVI?=
 =?us-ascii?Q?DqJL7xCZaPaYIyvjA8fPOjdaXva1cXNUHrIb9QzKU4WxZh0qQccRYfOEZPbF?=
 =?us-ascii?Q?9+HeKdIFn1Mr/AWNU3Tym1oyyvf/NM+tOJdYny2aKoGw/30LqJ63EDsxIi6B?=
 =?us-ascii?Q?TNQc1sFR89ZAWde4L4baMmqEG3nr5HvX6fAqFSEV6a+iCc+DgGClrIm6dbEq?=
 =?us-ascii?Q?Pqelek7IOpA8/+Sia+jMIC0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e292cfe-bdd2-40bf-ba44-08da005707eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:25:02.2952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMGh1y3yre2l8SELrxDMtthk291nbYly6VfyUuXKho6Ke6pezNXy/QedV6QECUP1o3D1saaYx8SCZruN68zbqg==
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

The "direction" member of the "dma_slave_config" structure is deprecated.
The clients no longer use this field to specify the direction of the slave
channel. But in the eDMA core, this field is used to differentiate between the
Root complex (remote) and Endpoint (local) DMA accesses.

Nevertheless, we can't differentiate between local and remote accesses without
a dedicated flag. So let's get rid of the old check and add a new check for
verifying the DMA operation between local and remote memory instead.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Change from v1 to v3
 - direct pick up from Manivannan

 drivers/dma/dw-edma/dw-edma-core.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 3636c48f5df15..0635157d260c1 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -341,22 +341,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	if (!chan->configured)
 		return NULL;
 
-	switch (chan->config.direction) {
-	case DMA_DEV_TO_MEM: /* local DMA */
-		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ)
-			break;
-		return NULL;
-	case DMA_MEM_TO_DEV: /* local DMA */
-		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE)
-			break;
+	/* eDMA supports only read and write between local and remote memory */
+	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
 		return NULL;
-	default: /* remote DMA */
-		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
-			break;
-		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
-			break;
-		return NULL;
-	}
 
 	if (xfer->type == EDMA_XFER_CYCLIC) {
 		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
-- 
2.24.0.rc1

