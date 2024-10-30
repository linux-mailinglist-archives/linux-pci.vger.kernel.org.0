Return-Path: <linux-pci+bounces-15578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73229B5F7D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B6A1C21327
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 09:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35391E909E;
	Wed, 30 Oct 2024 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eWf1EqE/"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0CD1E3784;
	Wed, 30 Oct 2024 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282144; cv=fail; b=GdwCnTxBniUiGuOssB/onD8s6WnbICv0q7KmGbGGyOniB8IMund/+6L13HIxiDt0HyimraT6xsmbdXKLFAxm9mZT8dsdOfQCXsZzWCH6YHltmEpgx0S3etBzYcjpaoRK6krdxiQL2FT9pzcCVM2p4FkZcAIp7Y+SzowZJPE28a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282144; c=relaxed/simple;
	bh=dLlg/2utw/KVdtGSn44OntDeTHoruscl/LecP9o+yaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a/mRz8TAeW04Bnq2O6Qsn0Y2UlCP7hzUOEorz9orGOmjZgMvdPJIOUVuKWwSEb6hZB6YijOcVNNgtMf+omZ3D2entVon/OjpZxDsvyJNSglafBxY8TYPcqhTtJecPMysOzskXhHotMq4cWbX0MdWgIzxIrIkj0WY41Kg3+KLMHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eWf1EqE/; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kmz0ZG1Og5tNputNrpiK6X6nlqQlznMQ5pw3mfF3kImZ3jWotOzQj2O78B51M1PtjHeqxzdGS6mSeqcZOxLMBpIs+Xv8qmWOuiOu9SnUN5knf+fM4QABadATChpakUSUegEDjEMtQ6BiE9gGNnY9TKGEssEaVm/bXjMejyIDWlv3qxgEotuDn8/YsHLYMbJVx3pObLvXqU4HR6P3wBOGMPGY5ffvlcxaGQjUmaf2ImgQascr2BElhNHLXCKAb3FfiYnEdGMbFX8Hqx2FpKcpOfJBpkSisRdd5MujfXUQFyTGe7WngstnejhW8RUsIaBiR05svpk4c+VR5bGaFwHc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZuOxz8yzyturV6RHu8PVydjVmO/8OC8k5rAVJeKBnY=;
 b=OeJgitG7CKAwOLlDwuBzBs+p8lJgqqM+/rwoUzmt3A/Kq4u7j4euE0xagYpVGHw3WcoBT5FoFiCk4W6BQ9m5JH0TkNHyTVMpLzwU+KjDyyfVa2xfq1AFXz1zpC8n+JOR4R7UK/DD7Q64/kmpqCAXsf3Zsn7Qn/ldMvyKnnTI6VLrKJyCzaWMvWqdcTTmwDceVZpXtPGeRWoQ6EeOjJ+onF7SI078HLPmbKg36gCGlFVtphJv6cqAhlZAsxSwKhpUXEHAl7mlK20MLHyjj24lpmXqMdYm/UngQ07EVHw0fgs+0RY67Uyb6Wv3YSMcnK4TLtOwz5rLFBl7v87L8cZIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZuOxz8yzyturV6RHu8PVydjVmO/8OC8k5rAVJeKBnY=;
 b=eWf1EqE/k+Lyy3LftNTWVpX7Dd+H75JRzVY0hyex9Z2Wef/iJJXNc+qN2rXFpuME8pw4uGw+CWLf7M8SPhnB2R4jJguQzmyDGhVxcCkK+EAUHrcvnPhM98Z7ytf8N3ywvD5qjcyUrN98MSUU+KPNjuqtw5tcXkO/3AAF6/MBRsIpBawyZHJR8vX1GS5T3YI2ow3Ny9stpnrh+26YueFJ51/lib7v7wV0HA53g0wYr/eSLkVDRr6whqWQ9SQJdaxeD3nsievh+5WSGEQDCJLN2f4tV6QTHm4MHRv57V6RJ/ska6XBVcp9hF14Pf7ObVAf8s81qRm0pM/DIKNmt1ru2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8912.eurprd04.prod.outlook.com (2603:10a6:102:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 09:55:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:55:38 +0000
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
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v6 net-next 09/12] net: enetc: extract enetc_int_vector_init/destroy() from enetc_alloc_msix()
Date: Wed, 30 Oct 2024 17:39:20 +0800
Message-Id: <20241030093924.1251343-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030093924.1251343-1-wei.fang@nxp.com>
References: <20241030093924.1251343-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: cb03506d-67f7-4445-13f0-08dcf8c901fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/9TS3Bm6Gz13tN4r1J/T7JW49JDdJnvJQ+4E78snrabMefGrPqBIN1BQ/APS?=
 =?us-ascii?Q?b4hwPBdVVZxXG7Iu8gq0LuEY3Na7uQ6RZYtl9dxNtd6m8rtAkwbiN9gX0hLP?=
 =?us-ascii?Q?vzIrlj0E7ufG6btCFG4guyuSV0hwN6xCBxtwmaOI/fi9NsCDYD65KmJ26zY2?=
 =?us-ascii?Q?Jp5PAGAd8weQUS2kXDQ9rKJDfqhEx+5gksd4/46k05ppHA/1O1meIsJMHnYW?=
 =?us-ascii?Q?B47G8hnPr4VFh69IuFWWuKkIKrRLY1K0qmmFJvu9oPRABX+Rv3TorZym5/XM?=
 =?us-ascii?Q?8fwrTGLIuSUZ/4nC2c+jlejOYlpGw+DzWTVcaKeXam7573IF/Z37J73HeRwu?=
 =?us-ascii?Q?SYIkYOgqZCXbOOlw7pC3IO53k8kumJHqNF42dVF4iNWOkd4FsSJKsauzv5i1?=
 =?us-ascii?Q?/yMpr10rfJxRV6tIeunMr/4XRPAl1C0zaLeUJOLl7Kip8Bdas/B04Lq6HQTO?=
 =?us-ascii?Q?BBmIOvNZo+PO4YF3CR7SRx+3/+eP2Jvp8ldfXe+vMqjZy+VPr8+IoaGZUagN?=
 =?us-ascii?Q?U/aItG85l6dEuu49IlhxOZqbNkqNlYgh/fjWd6sk+257MK7R+ZzXgKjc6w07?=
 =?us-ascii?Q?Zt2UYLSbkEOoqHQNm9HFv3rkqwCXgOUlxlcavrOz4pOfw3MItH6q/TdCySBX?=
 =?us-ascii?Q?pJmRYYJiA7wViwE7/JfouDRmL6CtotOAqiAHB/pbCQAh3x6LSWbPs+ihyPKc?=
 =?us-ascii?Q?mDA9CM/evI3gE+f8zrH88l8gYfDwOc2dLWTr9FGf/PKAkqaBWx2tXlLq73sK?=
 =?us-ascii?Q?GReEAukRYNNWSkxyuAKcO8xYq5Swd8LQH+A6h7TqkN56afUuBQy2sbb3W5Sw?=
 =?us-ascii?Q?dFccMObt1t/bi3ZydBooxXsJXDrpOuNQmgD17DqQyJnu/LmsuGCiZ7DXokRq?=
 =?us-ascii?Q?wqZ573W7neqUG0D9s1mwtXsqKivyPI0zTaMWdgugbyBpE/HaROas/SiQbR7k?=
 =?us-ascii?Q?4o1PX8jH6X42A5/9tDkMlvTsCWyp989+fWpYTuGOzj5QA5OfYNaOv1/JEsRY?=
 =?us-ascii?Q?eFlsrmhw2jpaCnc6TwHITXYhmwb0aOZlNC5bewYWwj4q0azBst0NRXWCNC+4?=
 =?us-ascii?Q?COxoFSWr3m5QQemsTgDyeBk4YSeLtoiTR+w9jkFXDofOFL0dALmJRG6hKrem?=
 =?us-ascii?Q?FueBPWxko7WnKULHQTJ7mt9+jNDV3d92GJTB9efLopw9ctnmCvypNY9RylaQ?=
 =?us-ascii?Q?kOfIw0E3v32/tD3AL23+3cUtPXLiguze6pnrvNImtrl7Vf3/Io7UVz9ATjDe?=
 =?us-ascii?Q?aogd70yUoPdPz66szhy00JNwA+GPFkBqxJ6lCOgzNhXq1F90CVES+pANssjM?=
 =?us-ascii?Q?o8E5XJ3+0abN32TspmWZ1F/pjipsHJlAHon37ly7ICffJSqya3YDCtj21O6m?=
 =?us-ascii?Q?XyBginsabgRy92UAJgM3J2R1iCSk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KWuxzeYPr/ckBjF873SsPPCVwG1b/WYOt7HHLxNHecrZm2z8YrKAgwsNiS+X?=
 =?us-ascii?Q?6B/KcXujQ5Zo+0aD0b0A95c70mZF6hjbcrqVEK60V4ya/sLlZoFPPcSrWLQz?=
 =?us-ascii?Q?4SA+DGj/9MJH91Q7U9qtSZCLCt57f6S+MUTZ0g3pSLkOGKwewG4tP1x8vkkE?=
 =?us-ascii?Q?tSU+252fdJq2wK1owhcBFLwdK82Re2g6FQuldyNjRCgo56fxpPUruQIsyuV9?=
 =?us-ascii?Q?6Mbk+CBkXy+hQIlRCoHww5QZ6FCnANmqq0NLL/bRjs1yp0Uv7fjEuOE3zhrh?=
 =?us-ascii?Q?45u7VXQlHgykzxcecwVLXI57Cw3LoijQy7jh6qU9skQ5NGTQaszSfnJeFLpz?=
 =?us-ascii?Q?48nxa/lug9vLPcJ40JASllnSotWr9uUmJAxIhjiQUR8k9pN1WjikXuNc3eJ7?=
 =?us-ascii?Q?X/jGP6D9DAJvnjLyBb6M4pdtmNq1osSFjf9+mJvyMJziU02J7TZCkjERABFB?=
 =?us-ascii?Q?Y8m3MdJDQOoKVtBR1K6g3vnH/qK0zV6/yd2Yq5v/j/zZjRryjCyCSOapJ8b0?=
 =?us-ascii?Q?9RdHcv3ueGT/4erit1I1lVJ67ZivBNAFf7Cr5rOEWAHRi7+ngdx4ITyK417E?=
 =?us-ascii?Q?bVBM6pYmQQx2dQ2XAvxPmtBg7ECTaf5QTioClZ98kk3iTqlP6a3awO/p0KM1?=
 =?us-ascii?Q?AlXsxCV3eTgcN/WhAJN4VF8pp/eT9O/0keOzKnqwb3PUwAU+E8YS0Q1Y3qW7?=
 =?us-ascii?Q?1VRguq5vKwnUGS1KP3XjrZ1B7hpil1bq3EvTQM1A6w/qaA4XfxSvGNWRIoRE?=
 =?us-ascii?Q?+M97d6v0FyOzkELD4GJ+4Ju8cdv3mHMct/CrNoXBH8JfhWV1dCw0h9HI3WrF?=
 =?us-ascii?Q?O5Zv3cGGIn1nfu3uEXiXP5tRGqO+61KTx8QZougOfxmt7O2y2szVUUMtqWqF?=
 =?us-ascii?Q?F7qeuMiuRcz3Jk3XiGN5I0gG7Kal4s16W1HxnNdcMHZtWyr8NC5x7SsKkBKs?=
 =?us-ascii?Q?7YQf0211eXujilYpnS8WTKvedsjUZUrmaQnNsdXcEo4XUjU7YdMCN7/JN/P4?=
 =?us-ascii?Q?wURvvOmTnAbtdtBJtTfmJ41vAp1KRtneBRR5G+W2We8AlOBf0gGa5Mj0LYXs?=
 =?us-ascii?Q?jG7NbxdozHwgKXPtO518ESUapuBrlcklNixCkzSTKiOA3ko4xpNQBBPFk0J7?=
 =?us-ascii?Q?5AVcz6c8me0X+NKAbr5uKpTrxCUUBf3+k+Eyqr70o9zHVvbA7frAoodh8gW3?=
 =?us-ascii?Q?Q8NbkCy8xFxBpDViZrrxRBGzpZrRWvMZJAzn+MqlUsCHgbT7YjjYtTmN5+2R?=
 =?us-ascii?Q?TjrDUspoel9dgxwyPxORJyGJGHLlM4QyjAAiLogIaKhCXj1BrIcTQTqZHJBe?=
 =?us-ascii?Q?ANwrjqtqSZKgv1MBV3CtPNCDFjwdafcrwySb6gReo9/x7UFL/guDSTw12m+/?=
 =?us-ascii?Q?19GxgkhCe3I4+r0BfSUWZ4QiHR2TfXnx9XI2XvXXEMORoaQYlIE5mfQfHLu2?=
 =?us-ascii?Q?f+Jn5a2HHrkm/Cli5fv5+GNhxp1R4tAkfmyJLW8+logUBWJRpHb7t0wtxcXJ?=
 =?us-ascii?Q?KsX2xczzhX5BMBzROWJ42nPjNhikm2rOmJMYmYiXueHXHfJvR8a4ZP3fn9wy?=
 =?us-ascii?Q?QKx9M/NQrdSd4hsHIwPsnTSCqgk+J9Oax6Ebr4iC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb03506d-67f7-4445-13f0-08dcf8c901fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:55:38.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHV4ZU0eb99GYEU+2ToanTPtN8NkCQVbI4rHyaXacmzouTMheTxRN2Y87DLpmry2ypuXxOrfzqBTU7PU0nDiMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8912

From: Clark Wang <xiaoning.wang@nxp.com>

Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
enetc_alloc_msix() so that the code is more concise and readable.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v6:
1. remove the cleanup helper functions
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 177 ++++++++++---------
 1 file changed, 92 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c09370eab319..f292c5ef27b7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2995,6 +2995,92 @@ int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 }
 EXPORT_SYMBOL_GPL(enetc_ioctl);
 
+static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
+				 int v_tx_rings)
+{
+	struct enetc_int_vector *v;
+	struct enetc_bdr *bdr;
+	int j, err;
+
+	v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
+	if (!v)
+		return -ENOMEM;
+
+	priv->int_vector[i] = v;
+	bdr = &v->rx_ring;
+	bdr->index = i;
+	bdr->ndev = priv->ndev;
+	bdr->dev = priv->dev;
+	bdr->bd_count = priv->rx_bd_count;
+	bdr->buffer_offset = ENETC_RXB_PAD;
+	priv->rx_ring[i] = bdr;
+
+	err = xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
+	if (err)
+		goto free_vector;
+
+	err = xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq, MEM_TYPE_PAGE_SHARED,
+					 NULL);
+	if (err) {
+		xdp_rxq_info_unreg(&bdr->xdp.rxq);
+		goto free_vector;
+	}
+
+	/* init defaults for adaptive IC */
+	if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
+		v->rx_ictt = 0x1;
+		v->rx_dim_en = true;
+	}
+
+	INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
+	netif_napi_add(priv->ndev, &v->napi, enetc_poll);
+	v->count_tx_rings = v_tx_rings;
+
+	for (j = 0; j < v_tx_rings; j++) {
+		int idx;
+
+		/* default tx ring mapping policy */
+		idx = priv->bdr_int_num * j + i;
+		__set_bit(idx, &v->tx_rings_map);
+		bdr = &v->tx_ring[j];
+		bdr->index = idx;
+		bdr->ndev = priv->ndev;
+		bdr->dev = priv->dev;
+		bdr->bd_count = priv->tx_bd_count;
+		priv->tx_ring[idx] = bdr;
+	}
+
+	return 0;
+
+free_vector:
+	priv->rx_ring[i] = NULL;
+	priv->int_vector[i] = NULL;
+	kfree(v);
+
+	return err;
+}
+
+static void enetc_int_vector_destroy(struct enetc_ndev_priv *priv, int i)
+{
+	struct enetc_int_vector *v = priv->int_vector[i];
+	struct enetc_bdr *rx_ring = &v->rx_ring;
+	int j, tx_ring_index;
+
+	xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
+	xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
+	netif_napi_del(&v->napi);
+	cancel_work_sync(&v->rx_dim.work);
+
+	for (j = 0; j < v->count_tx_rings; j++) {
+		tx_ring_index = priv->bdr_int_num * j + i;
+		priv->tx_ring[tx_ring_index] = NULL;
+	}
+
+	priv->rx_ring[i] = NULL;
+	priv->int_vector[i] = NULL;
+	kfree(v);
+}
+
 int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 {
 	struct pci_dev *pdev = priv->si->pdev;
@@ -3017,62 +3103,9 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
 
 	for (i = 0; i < priv->bdr_int_num; i++) {
-		struct enetc_int_vector *v;
-		struct enetc_bdr *bdr;
-		int j;
-
-		v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
-		if (!v) {
-			err = -ENOMEM;
-			goto fail;
-		}
-
-		priv->int_vector[i] = v;
-
-		bdr = &v->rx_ring;
-		bdr->index = i;
-		bdr->ndev = priv->ndev;
-		bdr->dev = priv->dev;
-		bdr->bd_count = priv->rx_bd_count;
-		bdr->buffer_offset = ENETC_RXB_PAD;
-		priv->rx_ring[i] = bdr;
-
-		err = xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
-		if (err) {
-			kfree(v);
-			goto fail;
-		}
-
-		err = xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
-						 MEM_TYPE_PAGE_SHARED, NULL);
-		if (err) {
-			xdp_rxq_info_unreg(&bdr->xdp.rxq);
-			kfree(v);
+		err = enetc_int_vector_init(priv, i, v_tx_rings);
+		if (err)
 			goto fail;
-		}
-
-		/* init defaults for adaptive IC */
-		if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
-			v->rx_ictt = 0x1;
-			v->rx_dim_en = true;
-		}
-		INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
-		netif_napi_add(priv->ndev, &v->napi, enetc_poll);
-		v->count_tx_rings = v_tx_rings;
-
-		for (j = 0; j < v_tx_rings; j++) {
-			int idx;
-
-			/* default tx ring mapping policy */
-			idx = priv->bdr_int_num * j + i;
-			__set_bit(idx, &v->tx_rings_map);
-			bdr = &v->tx_ring[j];
-			bdr->index = idx;
-			bdr->ndev = priv->ndev;
-			bdr->dev = priv->dev;
-			bdr->bd_count = priv->tx_bd_count;
-			priv->tx_ring[idx] = bdr;
-		}
 	}
 
 	num_stack_tx_queues = enetc_num_stack_tx_queues(priv);
@@ -3092,16 +3125,8 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 	return 0;
 
 fail:
-	while (i--) {
-		struct enetc_int_vector *v = priv->int_vector[i];
-		struct enetc_bdr *rx_ring = &v->rx_ring;
-
-		xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
-		xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
-		netif_napi_del(&v->napi);
-		cancel_work_sync(&v->rx_dim.work);
-		kfree(v);
-	}
+	while (i--)
+		enetc_int_vector_destroy(priv, i);
 
 	pci_free_irq_vectors(pdev);
 
@@ -3113,26 +3138,8 @@ void enetc_free_msix(struct enetc_ndev_priv *priv)
 {
 	int i;
 
-	for (i = 0; i < priv->bdr_int_num; i++) {
-		struct enetc_int_vector *v = priv->int_vector[i];
-		struct enetc_bdr *rx_ring = &v->rx_ring;
-
-		xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
-		xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
-		netif_napi_del(&v->napi);
-		cancel_work_sync(&v->rx_dim.work);
-	}
-
-	for (i = 0; i < priv->num_rx_rings; i++)
-		priv->rx_ring[i] = NULL;
-
-	for (i = 0; i < priv->num_tx_rings; i++)
-		priv->tx_ring[i] = NULL;
-
-	for (i = 0; i < priv->bdr_int_num; i++) {
-		kfree(priv->int_vector[i]);
-		priv->int_vector[i] = NULL;
-	}
+	for (i = 0; i < priv->bdr_int_num; i++)
+		enetc_int_vector_destroy(priv, i);
 
 	/* disable all MSIX for this device */
 	pci_free_irq_vectors(priv->si->pdev);
-- 
2.34.1


