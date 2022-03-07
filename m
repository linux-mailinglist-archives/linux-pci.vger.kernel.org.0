Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B488A4D0413
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 17:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbiCGQ0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 11:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244162AbiCGQ0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 11:26:08 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054EF5D182
        for <linux-pci@vger.kernel.org>; Mon,  7 Mar 2022 08:25:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg/Ls481ZYtltXpiFhJ3UICmNCvG5vgsKTZ2HnmDhk6jCbAXHd5D2UUmExiGNV9elEOZuLg2V3Ekvmt2egNpzxnBlbkpZ9UIDxQmf6tMBKsOgT0spWjQ23DsOth88GExqRfintUHvg+PiSR+Z/M79CuWdcmOIOXLI6hylPbuMrjE1O/WBGfBW3ErBjmL3Wcnyqlvo4MG4in5t92ZhHMO9Ks3qzz61Nu22QHjKqXy/SSYw+f12Hi/VXCejs1XtUoCxPSzQVjE0AQI+RKo5FSnqZxIS1vbjhCWqAIOL51YZ5jkGcY+0vLds/4Bk4+OftB/ZTgX9xeNPnjEbdVmuA2YEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9l1hLDgkb9ZR6aA03u5B2+SVNcg0hUX/7QZ+Wn3sSuQ=;
 b=TDyIeFM9ZuSd/pwrP11YXgYizQOcHsbR3WewQ/QrwOP/I0njIQ2vDWvruYkcGjwJvdrd+bti02uviOViyHjeKQ3MQ1rvKhNsTxxXgRbeFzmWmrjZhK+6KMuqPI53X+a76wXcDIPC37llXWYmFMB5gPfN3J0UOWmnO1aN4Jubtjlt4xx/Qog9slfK4giEGxvGhJIAaCiPKaUuKHhFmRN/7fkpKzXHAO0tFZzHoZBw/DGm/QjBCiUb1wIDwLo864hprctA+//CJ8+JL/EhKlHUOOw21PLzX+ksLeKLha2HzpWyAgJzWozW/JpsQpwi/CvdFa+xdZR8kizqnVeVEx+BHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l1hLDgkb9ZR6aA03u5B2+SVNcg0hUX/7QZ+Wn3sSuQ=;
 b=OSnj/V5qU9eiFHTTVvi1kg/Kv2jB6RMmqOrF6OmcWJBLJahiUy+VjD5EYJ1VXgtZZszhQQKfaz4s9/l4VPgFrfUmzaCRniZ3YF0oDJcoS8uhIsDCHWOtbxdYkXtxFXd3/XnTO/fo5lq3Qz0LMNPyHTKRmidzUwgcVnrwO2LrrMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB7169.eurprd04.prod.outlook.com (2603:10a6:208:19a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 16:25:09 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 16:25:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v3 6/6] PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
Date:   Mon,  7 Mar 2022 10:24:30 -0600
Message-Id: <20220307162430.15261-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f013fd40-c38c-4a90-ac4b-08da00570c40
X-MS-TrafficTypeDiagnostic: AM0PR04MB7169:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB71698B6D5153A7EDFD66FB3288089@AM0PR04MB7169.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KpnWFujSWmE6dWg/kh8NV7afCVSdny+m4eukfcVF7XO71SC+4Ts+1KlDKlxd3qd91FeGTRTAeCHEroLoesMzIBryqH9OK9Yi80ao0M4zNkiLw5vlgBJmtzgzNGSlkfAzDS503XYVEmm1xIwrTtYxO3tboGunPsJ99BpDIL/thvwOx5QE/hsQV6mhagPFZVg0uMr539LPqUWuj0VLf7Gx7N/jjIxnS7D5W71ip0niywUMYiSh7YPEPJzHZTChBykC/jjGuTIYQRYlkW0ZxbX6HRMahTsp6/9osueIptSyM0ZccHz7oShBnPFpqIEo422j+CDnM8LXZNwYKZSG9GZGyfoa9HWZ5TlGoKYytJgyAfGLZ7l4tKgJDF3q95No6RbbGaig1ccLoKXFabjq4IVi78rrRpqr1LQxcv6dv3XIKu2DFtB5GkuOkA9JLmUYJS1HHpggr9/Ay1BS/gOCa5v1VfgSQDins7xXV+QphyG/vfay7ZCNEu3TFm5Hjv/7DY4tnFTrHeuaq+qfIg8ilpZ33woGcowafmswKedPhlnFmdDWiw7yaKx+X21CWJgoQ6zwr6fytxLsL3Ta6oleofdPf7me9BXUlfhEydqgFgR+NW4xapJ/yhNS3IbzeJuMEvPeoinm48OYNLIJAvJNBZ7QS88ycaCPSqiFa7U2XXwCMU3+pUvb4kqCfQlVJVGW1KNPnhFEDW85YYdVSZ1c3YU5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(1076003)(6486002)(38350700002)(86362001)(498600001)(2616005)(4326008)(8676002)(66556008)(38100700002)(66946007)(66476007)(8936002)(5660300002)(7416002)(26005)(186003)(6666004)(6512007)(83380400001)(6506007)(36756003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nS4qRDnq5J9HBG/yR1VUFhA1O/TEbgSynOdF7gsa31rrSiBlr+Dx1W19nvNi?=
 =?us-ascii?Q?OaNzGFqe81bnTPSoMIp74XEHoWHCnTVg6JjtY9WayBdYhRJN9beFLhaPGEwP?=
 =?us-ascii?Q?bFdqzeIAgECL7FBlyQtm9CKRCOctLNeCUnuEIh0dy1J/sNpv1eYRkgaMrB1w?=
 =?us-ascii?Q?psgyCABhJWlNrIVqzP9RnQiGKkW9twdkjhBzNYRjfViVbboCu+9HYIRLFnpO?=
 =?us-ascii?Q?uunmJcYpSPgnzBrZvCKnVbyf5223ykCTKm0DBXfsha4ykx71jjM/pJdj6fzG?=
 =?us-ascii?Q?Cg7aaUR2nHyCWDimPkjxPMCOQxBrsPYAOgRdN+yDv6iAK3QM3Q5Kvm6pYLd+?=
 =?us-ascii?Q?RzIvii5SoMjin2/qUxJttqkuDnjjVC8YZP5Y62RaQ55oLHS0f3NOPnFBdQ9D?=
 =?us-ascii?Q?mAW1P96SN+D8G8UD7t27V41OnswGSBuX82SiK+5dxLKPF82YWL6iYA6QcvpD?=
 =?us-ascii?Q?aFhYSnVMv6KsJ49Q5236P+ayQWHqax0hKNzaQHiJvZxRyx8FEPXqFyye0qKY?=
 =?us-ascii?Q?PEQEBzJ99U7Zl998fBxpikiXQ7ZE4FStqaC1/Jp2Ccwb8/LIS1J1I4ukoNkB?=
 =?us-ascii?Q?wwv4RHivZSVZN2a9csA/Hro6fy+CQBr7XCBli85qdh3CaIIZTXl9cyBdWbUW?=
 =?us-ascii?Q?hKcEUE2ZdbYaVdCBpRkAQ/s+UFcBcjM8F+QFl8gZtfINo4odQa578pMeTb6H?=
 =?us-ascii?Q?CLE3Fx5roMPoSncAhHJl+Q9XyeoBoqIlQGNqx26u4L0GZf21yn3y7kDkcTz8?=
 =?us-ascii?Q?HS/eY1E9ITyc2YRNMC4zY3HKbeFWPgw3hpr2hrbAfqFSCHgjrTsczHCz+HX2?=
 =?us-ascii?Q?1mqOMlp6FK14NwTRSrvOqABGHIiHJwc+RYMXvIjM9EqlS963JU3k8dmUT5oK?=
 =?us-ascii?Q?bK9pc/ShbIq4H9hgBoCjt/Jxk+3oOE0VYFlWB1oQpNMOpzPyV5yogtGTRGLy?=
 =?us-ascii?Q?MoQZdKdh6arzsj+CUIcf2We53swjU3yJsKlP+2xH1Y417UhYIrr9cjfNoyDj?=
 =?us-ascii?Q?XBpA/vVXZTxKvED0iF+n9IWZtTRAZZnazsHcVKvtgVex0Wl+gYOfkaQvEaYj?=
 =?us-ascii?Q?g9wr+jiZTRCdnmsitrqKNiVYP/8SBHHA05IfszMYJImyffkMFkkZomliHTQZ?=
 =?us-ascii?Q?++q+i+Hf90cv6mbVGAR54bwQXMBR+/4x+T6uQtT+8cFf5onG9dfjpICmY+rr?=
 =?us-ascii?Q?MDuhFOs02gBg8eWGJIGOj5TaEk+Vni0p1udftHPCs7UxwJsS0HH2712w2IiM?=
 =?us-ascii?Q?cnc01xyEUKxTY7K2La1gU8NX2twj3aGBSyGp80ftx/v3y6Ok0zGvJ19YgkM3?=
 =?us-ascii?Q?P2apRqphgk3lUoTCRqJQ8wMmMtbJ9DPSQXCZ8bfQrZhgxFHYVt8sIBogu4qU?=
 =?us-ascii?Q?vXFsXbXfNHxBqBaEm4Yh3FYkpycF7NKBlbwlB3SIKvBJt8i5vN6A7rND4sgB?=
 =?us-ascii?Q?5Jiveuorfdb/ULKbevNjetpmw8yVFjb+E/k0kPLn4TuMC8uYKEQYYbPUzS7J?=
 =?us-ascii?Q?w7ZDkq0flAd0d+TZGcPXl1cwAXI7ubeUXBqKw8wiHm1M2QFtoG8wMEg/3MW8?=
 =?us-ascii?Q?dIbNnCc/rHsFMBZ/QbK4c2AgRavDkNDZxtWWOyVCNnjXOXmnNLwVzPcoG71W?=
 =?us-ascii?Q?Dal12LiUGYbZPMpZGpA/Kd0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f013fd40-c38c-4a90-ac4b-08da00570c40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:25:09.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnpiLBaLujz6dNnjZtxp/1ecVtxXSgru4LaEcKjeTq/OBZKn0qMt6ADWLtfPyji1l4PmNfYGRxq4PZmZdB6Ujw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7169
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

Change from v1 to v3
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

