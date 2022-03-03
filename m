Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399E54CC56A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 19:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiCCSr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 13:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiCCSr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 13:47:58 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EE219F449
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 10:47:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSDRmRRbQVG8h6TwWjVj0FS2ukzhbRCWDWcxf4HmS9gwBL+aXbPTvRUgIN2Y/jSERPK+9SYTl2H6OdJfpXfDIX9qyESvGrAch+mBdxesZoa9bPmZftRInESKcTnbCgce1WPSb3QcCm2eyZmpwxCFIRjWYC7WVcyIfKuH6TUkSYs9IvtlIgR6osAjmaqWUa0ivBHQeiblxyOBbUf8q3AD06cFjuu/xHRe6eISg+w8QkxayFvxR/t5L0np+YoDQ20Wq26UsCfRocTSzuRTPdKs6fmAd29x3DcF4q2cYNBgdsePXUaXtuZrzKiYqTBP0QziwWKwVShOh77XX2Mt7NENTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKu/5HrhConOV90+75WsEWjk/iJ6zwGVX611C+beSFE=;
 b=dYfxPRYuPogHVBrmGuq04BvUdx/dVByo/F4IjL1NKHjsnUGDQiOhVeZzLqPXjBI4RCcw6BtrCaeCKGQuQ66NbBTx/mNNUcdmpCet5RXJ8FHXc0sMYc3H4CPGMkILq1Bgw1ApJxbxPEZrfp6t2g/Srp7NAQJoA1pUiP17kEOhivYZ8NZf369nXv1WAgMqeCeg+irJuwprOwyaiFqpK2PCi8WsIi5Y9WJBMXo+YE/Kz+5RC/76P+HZ+J+u++S2eD2q7SHRR/tZ598UtXPxAt48FlmtLi4DbvbrL+7ue0EvvZUQAd6RGzTM0GA0NeyFi/fx2q4JeX2E7cBOywz2hGWqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKu/5HrhConOV90+75WsEWjk/iJ6zwGVX611C+beSFE=;
 b=YnDJMV+O7UkkD1uWBoyfyw0X+u1dylfwz31g393aGw09UnDPWqDhWi6smdTXSJlDzyvh2Irb4QvUuLO8zaPa8zjnhHlMJ4SJQ2r6KNLis7ysBdK8UQfm0zWmEB/EZerF0pNwrmi21jrJTMqLuIz3wBxn/dJf5uaIo3caShByqfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 18:47:10 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 18:47:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v2 5/5] PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
Date:   Thu,  3 Mar 2022 12:46:35 -0600
Message-Id: <20220303184635.2603-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93491e18-1777-4e3d-9fc0-08d9fd46396c
X-MS-TrafficTypeDiagnostic: AM8PR04MB7827:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB7827CE249A715256B2970AD288049@AM8PR04MB7827.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCGEgMD+VCKFPMQ+Noe0MtsO2dGWMGW4v822BjivwtLUj6uML8ndJIoiZerFKTyW2NOi6auT/BhiuIgzcS9btk7o7USSNa7MuP3UKWjMiOnrii10DBSZjb55Y0pZR/L+u9oaPh68xzaDrtcZkqT8DQkjYumw1J8z796hcElrgN3TFY2tu64mutklnoHhEQnKm1Bv6Q7nfZOivZt7yyKssxTpMAhJJ2EhIjB+qemmTRQ5Ns7vq5214JYSR5CvfBV1i7l1Sm7dS+EX+2jh5fJdcepZK/doM72y8pIPkz7nnZb/V4ldhv5GdlIbaoozZY+9mobblUrQgNGg+yGm6EuvLj8tEXkcfrrKhJH1yBMewyuLAOpcNl/8p8mjRXYx5g7az39uGwg+S45sOJyjHVGEC+P7qxP9gM2tbX3VET8y86WeDaQaEunevHmjQeB/jSsdy0tkBuHbqeDJ33+mRIcGbjXiBqPp9RNSdRMPPWqmSBnE+QDQEmuqbPZV0cx8URHrbcCf/JTcNhRP0f5GFhOwxFY4F6SuhSae08K1seiX7t3WsCJZxflwwy7TIZW5utMTT5tjdZoiznerPIT5uP6s7HCAo78Zj54foONhfq3cpkUJ+k11/P9PjivhWuGkDTeQyW/QiHPTnxnS3v60QsiAnklokOYQAZIP5CkJmn7rCqxkttrhQxlok3Ijtoj+gnL2HEX4MCeUUh6F4/N6rrcceg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6486002)(4326008)(86362001)(36756003)(8936002)(6666004)(6506007)(26005)(5660300002)(498600001)(52116002)(83380400001)(8676002)(2906002)(66476007)(66946007)(66556008)(186003)(6512007)(1076003)(2616005)(38350700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SW5W+8AATIWIObnFQIYCX+9VytFbEYIqQ61FqmTvHjOnHUWFucAfNBXd2QBQ?=
 =?us-ascii?Q?KjH6867frH3sDWO5jIZJBPoTxCYoCFzTELMuQYasV/Rh5SfzIXy05RB7ZmK9?=
 =?us-ascii?Q?iqKA6B/7kd5MfBbRgcGqxzSVfW0gO/hBzt+BcYQVYy/quoJgI2obsuoLZT1X?=
 =?us-ascii?Q?RgypX9I8/aRfLfHKH0di9xZ912oY104srd8fK7oyIlLLnmjQdaUgnQ25CDE2?=
 =?us-ascii?Q?w8kO7lvV6elTWtpTqZ7UVCAWbEed9WFBcSY0Wz38wEfwUcOD9jyf15MKmvJ/?=
 =?us-ascii?Q?5Q2xzKCmztlbIf5bUwmlDwkiHX73Wukev+oDmY5ZDinYfPqkuG3laJQrUdfH?=
 =?us-ascii?Q?/UGgoDIdoj75vEJO9dlXvgpb8v1Y7/pFpLDVVm3t51sjajU+PuSNoYwKCsE7?=
 =?us-ascii?Q?7PBpWFX6G/qAv/U9fRG6QYuxSe65jzX/FzE1sBgHrPLmGU1N/AgJB69J/sII?=
 =?us-ascii?Q?TBX/RczXfHBOlNrZZ5hlQy0og71tC/NcbyUpE4UZ8YMqH+Tq8fiu7sF20HgA?=
 =?us-ascii?Q?UR/WNiUMckzScIvaG4JYxn9Cr0hFkpBatXhpA0uJ41svwrEWIIo3fFzDa34E?=
 =?us-ascii?Q?XmCgyI48J1FmAxswjW2eBfnCg1qQegXnr2tXusYlMleyQGo8AGmZ3208jpGy?=
 =?us-ascii?Q?LdTu88TkoGokLTlhOXvZCEs2RU0xnpBmTKzY5YR4i8L7aBjF9dCvE7T9yxP1?=
 =?us-ascii?Q?Orvt6I3suVa8SO6j7A2t+2dxuMkJWkCFzl5Gg7P0r60Dwp5b0Dt3PqS2gQrb?=
 =?us-ascii?Q?O0R6gspQT2autycekkzijQ+f4SqGPzJ/sSbSTk/5dnORiANOk7ONkeDgMNt1?=
 =?us-ascii?Q?g3+/yuW80WXuAx7eqKHYm1gwDZHfmvNroT119ZkOggmISe9CMT4rbQkhalus?=
 =?us-ascii?Q?fQG+c825u0i/0Iaib7tyWOQzq+bHTiBkqwguHyyyiUPAguqHUPMMJOf2eCQT?=
 =?us-ascii?Q?yQgU5I7zaxCV+eR5lZ0i2uQlRJRuw8XvhmRGRizKgvGXWcFx8dvJo5xRSKCI?=
 =?us-ascii?Q?RpPPMxdIFb0ZGuqRaCOXj511+XsNK6XjAGlXTTiTIROnmi5zRfcqcq2FZxJB?=
 =?us-ascii?Q?GQ9BHY5xXEVH96lXwjMUQoA/vR/0ScKJ7eP8C8B4Q/+kwc1HVIHOdlnL1klU?=
 =?us-ascii?Q?ay19BHtbEuX6rWX1XLwvhcnzomtZrcut40gljup3UtJzboP0BBZKZPHjlWc2?=
 =?us-ascii?Q?4zpe2BqdAgHkqTIgqJX6zZ3vhDaYIu0I4VPJx1k2agkpGj6Ud6Mq4zTFdF2j?=
 =?us-ascii?Q?FsNcdNfYHZaL52jF2Wut48GA+Tc2LMaHoGvb3I67jZ/bD60A/C2EE5eZeBf1?=
 =?us-ascii?Q?qLdfRldz1VK4b6pEuJwXFQ7B5fT7+tTyZ3uMjaw+Aiq2KhWJ2uWyCvzRQfdh?=
 =?us-ascii?Q?Q2I97hGbac6bjFGBF7JK1SSeJ6B5wJP5aIIojM4cuEIyXFMHySOfeSpxdJIV?=
 =?us-ascii?Q?SlZg/QExvJoYD7r+uV6qKQLvfHUZSvAwDSsn9kJeS5Pficku9Ae8qsjCJ3oW?=
 =?us-ascii?Q?6n7uZjF214wefZSQrIU/3Le/llC+l+92aCPtDAi9cRp85ajT+vp3Zxw2exqG?=
 =?us-ascii?Q?xlTt5q3PGYRu9GFVvv9eXn6XpMXcEyyWMPdL8qqvLvVJAVlzwUwJSdtA7YN1?=
 =?us-ascii?Q?vpg7vOBeoNJj8nCTX7pOXCM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93491e18-1777-4e3d-9fc0-08d9fd46396c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 18:47:10.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19mt0mkRrX5O8IqDPYDlAT1SRaTMB/E9tuQn4ry4Ecg5ZcM83yScKWbJCBI2ciL1D9fkhvw8F8fcWXHDc6ZjOg==
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
Change from v1 to v2
 - none

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

