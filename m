Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0584C9C22
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 04:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiCBD2I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 22:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbiCBD2H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 22:28:07 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20083.outbound.protection.outlook.com [40.107.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CB6BE0
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 19:27:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5fAhpEoWbl2e9weNhR406FcxksKffEd3iWTmihlgzPKLiaiQ5Ejj5c66tAWKqAd9lCyZ60Crdq/H+UAw09RGRvsg0YwPOFMWglxHbFvlXIFiLmehiYy8hJ23f03cb8D7Z7V9ykaKxHtd/AYR/cWdbG8dbwc1J/+UGxbFjcd5knqfo7XVVqdxwNGN2eEQSEgGGAvoZ8W6PAIEWAdPCwXCH176gWvt2Afe+O8pkJopo2yQUgV8/0g8F8mYajrmHrHNvILKTMepGwp9PF1IJTTiRqx6zJvwj6D6F8ayDNoG1QZhS4JuvgGiPT4cnEIDTkNqmSaU17sk4bYEzmdnoZwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yQFjfaRLRZELElH1zG5fuUDfBNs8TI9DJ8BaTK8xBw=;
 b=OarpODN1h8Vtf2MWhOwOQ2kQx52OOdqgTVr8BdsmBDNI5N4KQc260mmtAgF+xG+dvyRJzcZLlfLOHos3Qemn+uNjQLpz41tZVFtqF0OqxZPYCGyhXsuoaTdovBx7DxoclEsfMD+ySPjkAN5QGltonTzmEIuvAz1ISm7fAfHOAtZhjy0S8QhMUFwAGWveIdSNB7muF0t/aTA8TD/XXsjg4u/qDL3GUO5AkZC78cSHvC1SuQHSlpkYE6HpG5OxxpslmGlckTm/UnVg8pf/QmyMPzfNukcxCxRFa7VTSsEr6jVhtzArgIOSS/0iJL+tSPXDIbyBvlYx0/pmRsGHJCSQqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yQFjfaRLRZELElH1zG5fuUDfBNs8TI9DJ8BaTK8xBw=;
 b=AF3RHm0Gi1mAs9zjhlM0DWZTX+eCA2oHP/9A4wONlJbnx1tM8Jo7cMVtwOLd/8YsfuWb2rtARhZAPpjWd+RK1c49hyh2tj6hazJQSb9F0I5Hnogk/rSZqIcDcf0CS8FkPMhdnCZG4WSOMY0dXzd29HAgmXT0nSawszFiKojKxyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB5926.eurprd04.prod.outlook.com (2603:10a6:20b:af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 03:27:19 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%6]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 03:27:19 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org
Subject: [PATCH 5/5] PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
Date:   Tue,  1 Mar 2022 21:26:46 -0600
Message-Id: <20220302032646.3793-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d6cc6be-cf1a-4d0d-c8e0-08d9fbfc8ecc
X-MS-TrafficTypeDiagnostic: AM6PR04MB5926:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB592675875FFA2AE237E0C1FE88039@AM6PR04MB5926.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNEz2+QFHC5msspARMyza53a6R0K3pnSlpIdGYsY5gRgOn+s2tvlTznq0mbNHVcg2gv5ZH+gR91dL14RyoPLfuykIRfUjD2a8Ucuvwyd8f6wIXNRfS6OC1SY6D536Z2ml+SrYpwZpUZZit007KIPJuq/XAAyXTtH6zpx5Wpp7nmdqW9A7tfmpvr25iwo4MLmPSnzOA95ZjBFlEsndJNwpUpsNCXygi2G7OPLCiLxG5gjp1mdDuzPbze5Oi2qzyaX5+/wWikmJIwucQqXhBoR4OOrVmLsTERbqXTYGuefEyjr85lI95bkCAkIuW4ah9KCJSbZJaHU+DoCyZq6OfAVPmtHjgJBxupj5M7wgKYotV63vIqfCUizSE2ZyFX2E4T7VMbzW8XuY4L2DzGZGkDnHvajQhakwWlriN/D3tsw6BVVOQzMOs3nZdOGVp2y7y7t4LULMHDX1Jh1VdP+qlY+mMi282NMKHFZIHxUY2VvwmTMe9DMt2Ti9Ibp8k9lJ3EE0wwRpmp5RAPE8r3stoxlHwB/8LKtKWh2HK7Dey9llYoM8HPKxIKdne1rw920OPOs+WAPwkLJpYpj/Xjt+f0s6GsgENI0CHp/aOGCxXtlhqvCsGgsfb2M7vlqv7H3HLyFqTGYUSsz4/RIZl7+PMGB24TKA/R5rkZJEgUOYXiBzjSveIm6MEypIYz7C0urSE8UGJBZSXoGNKI+Pwe6Ai3uvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(86362001)(66476007)(38100700002)(8676002)(66946007)(66556008)(4326008)(316002)(5660300002)(2906002)(7416002)(8936002)(26005)(2616005)(1076003)(186003)(83380400001)(508600001)(6486002)(52116002)(6666004)(6512007)(36756003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ufxPkMruKJJsEAOCOQBShREwSTv1dY+AT9DMuK7BpN2buDx4gPcWZQr6F4PU?=
 =?us-ascii?Q?aeGE5hBVi5YrYVO8vDYlKkUDPoKsh5GMrRtEfHKNwvCryh5wBA+vNNuL4Al5?=
 =?us-ascii?Q?6g2C2S571FznHSt/0NsWmECxSfqJVrttkc6PaGarbNgD5T+4SzM7TGgDOFY0?=
 =?us-ascii?Q?UEhjBI275ZMIjwBmbxmv9Scy+F60VSx6ddXcgqauBSmYHVnrIIAlIoVlGyJu?=
 =?us-ascii?Q?FGG7/bmMcr7R8B19OocoOD0A6ckNy49e6tbZrMEoD6Scpwo/JVsVCsW0km7C?=
 =?us-ascii?Q?wlibAIbPp8DFA4R7QEQOg7XuEFjf03ilFGPXqrsf5V0Q6JFWjHjz/DMiMm4B?=
 =?us-ascii?Q?Najr2o00CGb9/LSUM+88Z1aT+j5df9WiTEj/MGKrRs8zZNADy6I4Q+7L3vKw?=
 =?us-ascii?Q?zaTrUnow9odaKQkkzb+GYVcYxMM/IS8vwnRyPOfGC8iIQyCSGII0JLwUaP/w?=
 =?us-ascii?Q?o6q5g/qPFr5SudZT4gmmdrL7FS+/1dqWomJoyB/591SUD+D3XQTCxEW0Mi6R?=
 =?us-ascii?Q?+DWw0XMyi+fIK1F6sbzrEfqfeKX8u+jTenaBpRffJFrO+o9aKWLW2W30x8ov?=
 =?us-ascii?Q?SAcCMIyjssJ171Ar6QqXHAdQRlrCKFUspxkr4+0/rE6mvwtiZiYD6+eRaM8M?=
 =?us-ascii?Q?0RiQKt43if+pKMRFP6OuMc1WvBdX0DBexxJ1zs4uf4Q7HHAISx0uX4QZjHTw?=
 =?us-ascii?Q?5XOsOLwv5isgzGJ4jwS4ElY5YCyR7crFR244WTQwj5zNnPGWRd+gXiawJSRb?=
 =?us-ascii?Q?OxwZ5OEc1zExIm6Fg95p85Mk4Iio2HWg/s/ffA1yc7/82Rw6suLW1vphxxFU?=
 =?us-ascii?Q?htn00Dmq3/sI9Z+qDf/Mh5vsyBSo365D4XnxffPQKQNzfLO/g3pdN1tJDaXr?=
 =?us-ascii?Q?w5FSA7HOJKfDNM0mt4jN4xmm6mBQ9D+XvX6cmVnzF4J4sg4QSjE0Mjl0K+Fv?=
 =?us-ascii?Q?AlDK/ZLXu0Alv1cR9w3fW8luErWhc1GqQLRppkTM5/JZtlIA9LxNNmUYwMZW?=
 =?us-ascii?Q?IgM+X6I5ersGcr0s2ALpmzl9Tu17vIZXt05fxsPyiDaYiHgn4THZXW6/3QFJ?=
 =?us-ascii?Q?CN7fUfpxtVZo0CKmeJfwJdij3IB9sEoGYWTPe8DANgMgoyFiKfYKq+KJMHQ/?=
 =?us-ascii?Q?WdyGIJYnmWr2hvT5c8WLVyo5ZNAK1f+oMGrNxjDeTO4Bmsa1Qi3hCXjFbT0m?=
 =?us-ascii?Q?wMPo8B0YclPwhRGPCIIa/2geYoSUZ+3Z1XzrtJVA7uC0RS/7MXFmmN7u0QBO?=
 =?us-ascii?Q?r2Deq/lqeujfhI/M7lqkYDQtXr66bUJGM4+l/kwSt7slCOhfa6AaC3Tl6Q1E?=
 =?us-ascii?Q?2KSQDeK4HNR5z+Psn4gOd2s9RfdxcRPAi6g8RKenfcYDR24E7PAvc8WI9UXz?=
 =?us-ascii?Q?FB6cHRV9tVeR8F84tTZ7ZnUu5mvxMk5avbZTf3OfvopZXJ0JlGk55VhH9Qhb?=
 =?us-ascii?Q?EQMMpFuMnH3CCiXQAfxswY0kzVIq4pCbHe5DaNwWImqDVEj3Phgns6xqQ9ys?=
 =?us-ascii?Q?4Ee25j4FJeKTRkUn1k2zFd5NmnyPvGbK7YRTYYlGP2fHLfsdILUlkxKjrN9d?=
 =?us-ascii?Q?+L5NHtFZskcbzCBUiTzZmi1uiywFGB1oJEHuHkZ6I8N/kcantEwFETan3NBF?=
 =?us-ascii?Q?nTmNLUBEuZAra5nEZ1oGbwc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6cc6be-cf1a-4d0d-c8e0-08d9fbfc8ecc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 03:27:19.7313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6s19xYEk+hSFV36e7og1dX9Y1vlkZfVbwq5GF96tpFjEiidlOlh+tZFdwLLyhGHGgGgNl71bOEuTNGo5eU3V1w==
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

Designware provided DMA support in controller. This enabled use
this DMA controller to transfer data.

The whole flow align with standard DMA usage module

1. Using dma_request_channel() and filter function to find correct
RX and TX Channel.
2. dmaengine_slave_config() config remote side physcial address.
3. using dmaengine_prep_slave_single() create transfer descriptor
4. tx_submit();
5. dma_async_issue_pending();

Tested at i.MX8DXL platform.

root@imx8qmmek:~# /usr/bin/pcitest -d -w
WRITE ( 102400 bytes):          OKAY
root@imx8qmmek:~# /usr/bin/pcitest -d -r
READ ( 102400 bytes):           OKAY

WRITE => Size: 102400 bytes DMA: YES  Time: 0.000180145 seconds Rate: 555108 KB/s
READ => Size: 102400 bytes  DMA: YES  Time: 0.000194397 seconds Rate: 514411 KB/s

READ => Size: 102400 bytes  DMA: NO   Time: 0.013532597 seconds Rate: 7389 KB/s
WRITE => Size: 102400 bytes DMA: NO   Time: 0.000857090 seconds Rate: 116673 KB/s

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 106 ++++++++++++++++--
 1 file changed, 96 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3bc868f..22ae420c30693 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -52,9 +52,11 @@ struct pci_epf_test {
 	enum pci_barno		test_reg_bar;
 	size_t			msix_table_offset;
 	struct delayed_work	cmd_handler;
-	struct dma_chan		*dma_chan;
+	struct dma_chan		*dma_chan_tx;
+	struct dma_chan		*dma_chan_rx;
 	struct completion	transfer_complete;
 	bool			dma_supported;
+	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 };
 
@@ -105,14 +107,17 @@ static void pci_epf_test_dma_callback(void *param)
  */
 static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 				      dma_addr_t dma_dst, dma_addr_t dma_src,
-				      size_t len)
+				      size_t len, dma_addr_t remote,
+				      enum dma_transfer_direction dir)
 {
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
-	struct dma_chan *chan = epf_test->dma_chan;
+	struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ? epf_test->dma_chan_tx : epf_test->dma_chan_rx;
 	struct pci_epf *epf = epf_test->epf;
 	struct dma_async_tx_descriptor *tx;
 	struct device *dev = &epf->dev;
 	dma_cookie_t cookie;
+	struct dma_slave_config	sconf;
+	dma_addr_t local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
 	int ret;
 
 	if (IS_ERR_OR_NULL(chan)) {
@@ -120,7 +125,20 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		return -EINVAL;
 	}
 
-	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
+	if (epf_test->dma_private) {
+		memset(&sconf, 0, sizeof(sconf));
+		sconf.direction = dir;
+		if (dir == DMA_MEM_TO_DEV)
+			sconf.dst_addr = remote;
+		else
+			sconf.src_addr = remote;
+
+		dmaengine_slave_config(chan, &sconf);
+		tx = dmaengine_prep_slave_single(chan, local, len, dir, flags);
+	} else {
+		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
+	}
+
 	if (!tx) {
 		dev_err(dev, "Failed to prepare DMA memcpy\n");
 		return -EIO;
@@ -148,6 +166,23 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 	return 0;
 }
 
+struct epf_dma_filter {
+	struct device *dev;
+	u32 dma_mask;
+};
+
+static bool epf_dma_filter_fn(struct dma_chan *chan, void *node)
+{
+	struct epf_dma_filter *filter = node;
+	struct dma_slave_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	dma_get_slave_caps(chan, &caps);
+
+	return chan->device->dev == filter->dev
+		&& (filter->dma_mask & caps.directions);
+}
+
 /**
  * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
  * @epf_test: the EPF test device that performs data transfer operation
@@ -160,8 +195,42 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	struct device *dev = &epf->dev;
 	struct dma_chan *dma_chan;
 	dma_cap_mask_t mask;
+	struct epf_dma_filter filter;
 	int ret;
 
+	filter.dev = epf->epc->dev.parent;
+	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
+	if (IS_ERR(dma_chan)) {
+		dev_info(dev, "Failure get built-in DMA channel, fail back to try allocate general DMA channel\n");
+		goto fail_back_tx;
+	}
+
+	epf_test->dma_chan_rx = dma_chan;
+
+	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
+	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
+
+	if (IS_ERR(dma_chan)) {
+		dev_info(dev, "Failure get built-in DMA channel, fail back to try allocate general DMA channel\n");
+		goto fail_back_rx;
+	}
+
+	epf_test->dma_chan_tx = dma_chan;
+	epf_test->dma_private = true;
+
+	init_completion(&epf_test->transfer_complete);
+
+	return 0;
+
+fail_back_rx:
+	dma_release_channel(epf_test->dma_chan_rx);
+	epf_test->dma_chan_tx = NULL;
+
+fail_back_tx:
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
 
@@ -174,7 +243,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	}
 	init_completion(&epf_test->transfer_complete);
 
-	epf_test->dma_chan = dma_chan;
+	epf_test->dma_chan_tx = epf_test->dma_chan_rx = dma_chan;
 
 	return 0;
 }
@@ -190,8 +259,17 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 	if (!epf_test->dma_supported)
 		return;
 
-	dma_release_channel(epf_test->dma_chan);
-	epf_test->dma_chan = NULL;
+	dma_release_channel(epf_test->dma_chan_tx);
+	if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+		epf_test->dma_chan_tx = NULL;
+		epf_test->dma_chan_rx = NULL;
+		return;
+	}
+
+	dma_release_channel(epf_test->dma_chan_rx);
+	epf_test->dma_chan_rx = NULL;
+
+	return;
 }
 
 static void pci_epf_test_print_rate(const char *ops, u64 size,
@@ -280,8 +358,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 			goto err_map_addr;
 		}
 
+		if (epf_test->dma_private) {
+			dev_err(dev, "Cannot transfer data using DMA\n");
+			ret = -EINVAL;
+			goto err_map_addr;
+		}
+
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 src_phys_addr, reg->size);
+						 src_phys_addr, reg->size, 0, DMA_MEM_TO_MEM);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 	} else {
@@ -363,7 +447,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 
 		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 phys_addr, reg->size);
+						 phys_addr, reg->size,
+						 reg->src_addr, DMA_DEV_TO_MEM);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 		ktime_get_ts64(&end);
@@ -453,8 +538,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		}
 
 		ktime_get_ts64(&start);
+
 		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
-						 src_phys_addr, reg->size);
+						 src_phys_addr, reg->size, reg->dst_addr, DMA_MEM_TO_DEV);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 		ktime_get_ts64(&end);
-- 
2.24.0.rc1

