Return-Path: <linux-pci+bounces-14548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3242999EC56
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8601F250D8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141AA1C4A09;
	Tue, 15 Oct 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jjZ0zksH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F122737B;
	Tue, 15 Oct 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998080; cv=fail; b=PY8yP6l+u0kI9JwqZqAyU7zbb7CyZHeUtEl/ZEMHyozNsyqhGN+LpJpoJCV/Pc2fdrmwei0IQFI9XGA/tK5pFhiii8ivKjFFEDX0cQEQqBpYFfh0ESPXy53xI01Nmgq6W3618RvDMm0qc3uC63GLG3A8uYsFkfUi0V1IAqJCNK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998080; c=relaxed/simple;
	bh=sQLdV0v06zyyvLzB9Nv1+dtWHHhm+b8u8Jz1UJzn52w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kv9BIF7wpvJUIPbVlwXFklnPfQqOXRTmE+5dM+EPl7RCmCoFcvKhGszsIhpcFAO7a5NUotTSOywglWmHkqor3gilxRsYYSsumgJf2IXbxCzFlWPyUCzMPqPZB9c0kA1VlSIb/wz2u3darc1L83Dyp94VWa8AA3BrGyOyMDzuCn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jjZ0zksH; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9KS28CbWM0YmuUJ7wWY/ENFUHT1jwpgx5EfitvQ+YzI8Zz/CQAzGdWaXfFaezgyAPJYyuuqxTrIRzjIW82tv/FrwG2H0NgUMPQSNvnkd7WH8ZoIHt8GCAz3SHGPa7IM0QXZAiC4mCEPO5DZv631LczagKhJpon4Y6nlSosIZRMQT3eiVtM8BVbL3nH4ZFzV3E9gL5TcA7PJQYsyi10ToLldGkxOrtRyu4GfhUdrmHrBv371yXoqPXX2aJqrPu7JJG0LbjfMSTCeQNQuwcsO0as0h/wvBJLh1AjtuE4r5qjkdX+iUsyp/z3tNi83sQxlHkrQaff9FSIzIOIDQy42XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHPIArrijIa1XkRQC3JI75JkmI699A8/kvPPVkroewg=;
 b=tufoOw008+l34I56W2wFEV7roylPKgjuVzEVKc/4q+py7fH03ReHUge3B62s/vVi6TmA4jlDqTgtpXYUwsgqo0IUwyTmQmB9pgVXPakwnJ3BBDHeRCv+6flToNEOtuR3UH/u/VPegsCG9NkwfAUloU0BbRPCP5LhJcfO0HtDoRYvjk5aJPDxdemeki6TNpMgwoZ844xLFo5SzAI2TCuFczlGbcOZzcXYEI4gl99RQVvvmN1ArS+HPjWm3+ccPjKtHa1M0nMzuz8QaJ9TVIluV+7VlwgSrKY5RPokulX5/pBQo5Apr2RvGfccdBoF/iEcIlAVh/ZwBtNpcdL8i4wLJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHPIArrijIa1XkRQC3JI75JkmI699A8/kvPPVkroewg=;
 b=jjZ0zksH9CeiS2YWrDltypzkCbo8OX+CY6tyJHOsBgy7YOv4YstNrFkk95ITbgKg/6Z7KuSpxJz9dyrP0A+EhxKI/oDNtKyu/GBKQirnHWg64l/2HLKPPmHZeRPHfie7dP4flr2cq1pXJUWsG7jE3sZy0ulN6eyAM1xhRQhi9aKEMXiGDzOfC6cKGy+1wpe7evebsxl/C2bblckBW2tEE7Nvn3vpjQfPuxNiVbBt0UvWwJTooSpi26LDujPWv+WWjK4s4REUDRgxl3rhavusMWzruM96GMCwrRNOAM2uOGdpz5SUSHb++6uDVkNVQLp8YNqeG8IhXP/ygmDwMjmxbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS5PR04MB9876.eurprd04.prod.outlook.com (2603:10a6:20b:678::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 13:14:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:14:35 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 net-next 11/13] net: enetc: optimize the allocation of tx_bdr
Date: Tue, 15 Oct 2024 20:58:39 +0800
Message-Id: <20241015125841.1075560-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015125841.1075560-1-wei.fang@nxp.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS5PR04MB9876:EE_
X-MS-Office365-Filtering-Correlation-Id: 4491cf10-da53-43eb-5e23-08dced1b50ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oM6SOMveA6PZWgteFpFYx6F2/61csWTw9D+jS8HhqPQmH/PkbpYbohhmPiSO?=
 =?us-ascii?Q?bY3qeE71EGTA4n4K2I1obZrRfEAYpihQv1ofJMDawXkEyJYzAjzfbGleCQbU?=
 =?us-ascii?Q?F6kbJbwKUabeYTiowc1PKX7HFQlw01R7Slvfit+YOKHRWjk7WKXg82i0KsPo?=
 =?us-ascii?Q?cq6xJTebWyeNd1lqMv4pTvkOKBqIt20uxtAvF8gIY3bgqqRX+hOStx+axnCZ?=
 =?us-ascii?Q?1dy6+KVjiQuPlkzZt10+XiNyFGoUM0R2TbfKhGWecOgd0Z9TLpUVqEOaoLHF?=
 =?us-ascii?Q?Bq17QQqzH4lFX5+1n7Mms4AhZ7cL+MKAz/V9jPp1hOPZElah/xM6o7g2gDwF?=
 =?us-ascii?Q?VvqfdLmWwmSQ42G5aMtGIi8iEh/2GETCie61PaH1FetDqppFLwIn5H1WdBIc?=
 =?us-ascii?Q?e2yF29IMDneO4FyEJ5lCx3Tjg21BDm/ya7kS5jitB9eS+nxuVGRaXz5QMSZu?=
 =?us-ascii?Q?V7Qp5fG9RnJHISGJbGPAw8iTPaxftciLtR1qV9rmdy1iq61DZ/aJ6KzoEv/J?=
 =?us-ascii?Q?H0BcJrbqTRuYSb9jnhVECegB6jW32T4A8H1UpwlVCzBRTRz64idzQSQItQ/h?=
 =?us-ascii?Q?ewROSsQXvZ0nBT/2/s19+7D7HrmAp3aGtsXFCutIvYbk1m9TOpC4XF4ljpmO?=
 =?us-ascii?Q?kujz/Wqw+f1kuu4bXboZhq9zeBF8LZKQVgMQgPIKgcrGId4rR77z2NYfGCmZ?=
 =?us-ascii?Q?7Nh1puinVwJcdSUph4xmOEjBPgOWVLOTgCeM43kEVICA8z1odDj8MBcjHC4I?=
 =?us-ascii?Q?OrSDfReLl7vFzkLO6KFX9S7PQdN3Q0DgC6jfSpWiHwLmW2mUHUDCTG8ydLFv?=
 =?us-ascii?Q?oSexGpGQYcXdh5bK7KkiVywirnN7v970DP7JRLX8Uuhj8Zv3g6zV0h/vaA2q?=
 =?us-ascii?Q?c7Mmtz0xubg7wTZ0R4oynIadCOzWKpQnOtjXHD7AX7zc0PV8Q3ntdc2ViuCD?=
 =?us-ascii?Q?ArK3u4t7Dm1FErrPivpMmoBqcA46/Ppd78xYzYSpvxw6F3pQvysbyhK1VxPi?=
 =?us-ascii?Q?UV9ksl4gN4zmyUFJHvDtMfKKd/lhFDZgI9W4NqHc04MKRut6xjQETQ86dD0/?=
 =?us-ascii?Q?vksoYZ2Q95K515JLWcEFP0Q1VGhQMpSr+4xil7XAEb1ecIsbH9TM1/O8C9sx?=
 =?us-ascii?Q?4dcgFFykghAJo4rBe2oHS3G7yEamUEiBC7NRhqpEOof6TtyT8WAqu/zBmmaq?=
 =?us-ascii?Q?CD7UQV4bLsB4A/03c+7huXt/vqJEbiDfUQnJ71WKx4hhBp/61cPsk89yC5AK?=
 =?us-ascii?Q?ZfoZa7RWpbTAcNcfh71HxG++0uNRHGfWq5xKACgDlMYMObW1D9BT2+l9Swu6?=
 =?us-ascii?Q?UFM9WZtppYSsv73Zu5eQr6l9PODnCqThIRGyLk0a7aUr6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j2Wd9MlnApb339V6tYn2R6zNFiY7J4N+hn6G0JC7xj5nwMR7fzOyZU4wTRfn?=
 =?us-ascii?Q?MeQldO1cnOSHlwdmPXYTxL6MM4OwzpRkPO7NGeN2gGcZ5cEYrIixuu7Z5on4?=
 =?us-ascii?Q?ANoaOUkFdNGcMPF5xsQcgUQBH0pXofjCJ7FSqGJrFVHQ+BMtjZvK6CLoJJ7N?=
 =?us-ascii?Q?u5RbnaKDecTdDv2kAg0JZIFdtAtrKGvCbILS49WfP8jkVE09USGerOAr0idn?=
 =?us-ascii?Q?ppP7JS9GF+tU5N85lUapo6pInb0ChRFCv7wBzgVYEnwennpCNMvyZ603Dl/A?=
 =?us-ascii?Q?qtHOBibWqizEj9Aufu6yIcLgtSZUBWPQYlLYvdnZy2UCO9BKNbkIOQDjGOWm?=
 =?us-ascii?Q?TlpHb6j41qVWmtQgMWAo2ti8E0by4f4n61W5X2s4LKw6Ms3y+Ijl/oTZ17nT?=
 =?us-ascii?Q?/okLJOdjM1mr27ZwAGbuDlLA/tSY0qx7VBCHU/MvSFbw5xEqL4qQYp8jNNuo?=
 =?us-ascii?Q?yYAlrChiFhO/dxjy51p8kzfxvRxnSUZ4axrb2RMylFNNd/3cuhYVA78y4Il2?=
 =?us-ascii?Q?e79OZS4AqmHXdefpRA1ELuZdKofcOVgFX7ZrXbdSMRNDiautA3Ek0u03G42h?=
 =?us-ascii?Q?AzgYYuulpxrGi6uWhjIFszbuIisuQ7TKvqjOOlAbOU9jE7potcciwdtvL7gU?=
 =?us-ascii?Q?/JdXMRi8NcIf3EpptgwfUzCFsFOTP3dSnLvWTtn/Stx4y80CCwEnTwvzN0EI?=
 =?us-ascii?Q?4YpT1eT+i6/B4oxnoKKPwqcWNrknJhYcv2xhg1g0P6pPSGkYk/DQx6Aw4KmY?=
 =?us-ascii?Q?zvZdU4kLQTuGMxPK/Zbupxa+RRSqMn133rkibc83xcp+H0Z2qKiVOVYIYzDv?=
 =?us-ascii?Q?DtUa6GPAuu3y+drwvSM+KxjZhAbRqk/TFRjYLXGzwnarpSf7pQyIVQ9D/roo?=
 =?us-ascii?Q?vhRv0WiwSa0UcFAaOQl3LCiAedBKk1lXvbvoFXJlWo69zo2J3KGhXp/oHD7j?=
 =?us-ascii?Q?S9ePP21HQSusiUTLDY5jGwe0kdWzuHFvc4/wqrkxAIIlA3eiW2kAJtenkLJy?=
 =?us-ascii?Q?IpzrzCWs4mYhXcyfQqSLSnNx5kkaY7T+auJ6Epb0ASBjBLSsBQGtVFwRZnm2?=
 =?us-ascii?Q?BHxCqX/tFHFlvTuY25TqNjfbqWHMDPOzddXgPTgLKy3XT2R6XN5dqXQJIxR+?=
 =?us-ascii?Q?dcSINyrbnaXgNY6lCxFaDmZQPigHsxeUeb5Bx91HQNwgSlL0FulaXZNJT9Ar?=
 =?us-ascii?Q?Uhg2saxoYEu+Edn8nr91hL3mlSVE+nLhpy2xds1WbyBAAxpIFduUictluOND?=
 =?us-ascii?Q?3k8lqCeb+EwyGVhzHVrNiFTbUQZccLB90S+Yuim96AyanxS00bFFAOzhX2Tf?=
 =?us-ascii?Q?xODpoLKYIEknWzzv9soQ8pjmmzJQHdBhXCGtgWK1+DmaprEElgK35eewUC3a?=
 =?us-ascii?Q?rfBPCTvC28RRwLuVaz1bh9A17K49FXBaNWcr9u7BDxOHvyvyU9Uwds9e5F+k?=
 =?us-ascii?Q?K2Fuczz+9+jYwddsgaIP/xyvGw9aTffQiOdsuAFkJkbZg4Hg0CoPy66yckcR?=
 =?us-ascii?Q?xDwr0LAojXXJjcwXE3K/QAFeDwrEEcR/KgYEgZnoiMoUm7KPcmsl2OTQ5eBk?=
 =?us-ascii?Q?2pRvokZ6GS9GfdACxwi6N8ESVMMJ9Zx4cMfKkwc8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4491cf10-da53-43eb-5e23-08dced1b50ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:14:35.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKZMAqT8JImtYCkY/v0MHeJLALRdiMTYeFIo/tG6Ytu2O3gjnBWEjqX/em9W3J0+vJMFaZSTCG8KmsF3pt83pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9876

From: Clark Wang <xiaoning.wang@nxp.com>

There is a situation where num_tx_rings cannot be divided by bdr_int_num.
For example, num_tx_rings is 8 and bdr_int_num is 3. According to the
previous logic, this results in two tx_bdr corresponding memories not
being allocated, so when sending packets to tx ring 6 or 7, wild pointers
will be accessed. Of course, this issue doesn't exist on LS1028A, because
its num_tx_rings is 8, and bdr_int_num is either 1 or 2. However, there
is a risk for the upcoming i.MX95. Therefore, it is necessary to ensure
that each tx_bdr can be allocated to the corresponding memory.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
This patch is separated from v1 patch 9 ("net: enetc: optimize the
allocation of tx_bdr"). Only the optimized part is kept.
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index d36af3f8ba31..72ddf8b16271 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3049,10 +3049,10 @@ static void enetc_int_vector_destroy(struct enetc_ndev_priv *priv, int i)
 int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 {
 	struct pci_dev *pdev = priv->si->pdev;
+	int v_tx_rings, v_remainder;
 	int num_stack_tx_queues;
 	int first_xdp_tx_ring;
 	int i, n, err, nvec;
-	int v_tx_rings;
 
 	nvec = ENETC_BDR_INT_BASE_IDX + priv->bdr_int_num;
 	/* allocate MSIX for both messaging and Rx/Tx interrupts */
@@ -3066,10 +3066,14 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 
 	/* # of tx rings per int vector */
 	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
+	v_remainder = priv->num_tx_rings % priv->bdr_int_num;
 
-	for (i = 0; i < priv->bdr_int_num; i++)
-		if (enetc_int_vector_init(priv, i, v_tx_rings))
+	for (i = 0; i < priv->bdr_int_num; i++) {
+		int num_tx_rings = i < v_remainder ? v_tx_rings + 1 : v_tx_rings;
+
+		if (enetc_int_vector_init(priv, i, num_tx_rings))
 			goto fail;
+	}
 
 	num_stack_tx_queues = enetc_num_stack_tx_queues(priv);
 
-- 
2.34.1


