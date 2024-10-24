Return-Path: <linux-pci+bounces-15179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF769ADD43
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8F61C20F26
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8371B4F0C;
	Thu, 24 Oct 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YtZ/Tlvc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6792F1AF0DD;
	Thu, 24 Oct 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753788; cv=fail; b=RDQebvxTtcUSjeF4ng2bFLZHteKcSEC2r9KYUDzOuDYLiZ2hdgVIjn7vDEYe3/9UaO2aOckABKNtzUIpu97sNGwYe48gtKXT3eltvaebmUEXXzyZnjvXGoSJ8RsWAQhlM5lA/Br11QMNq1dmTTnBCdYgehUWOTqPsT38qXucJ8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753788; c=relaxed/simple;
	bh=431VT20+X17/zmdPhcZ6WHGqJ/lklitOzX41+aUF3Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FlzBux0YkzW//87uPE3gTdqePSt8av48I5TkfmtR5CB8i/oLm4UwhnXNktaUv60XzZHnR82WBd1/u052XMNPB37AyHA+tUwKQlelP9t/r8iV0ospZUNwHkaKnjM68b0exBUx4GAb4Wgt/3zw1dEtWvZyfnbwcTwO9sfH+9UVBqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YtZ/Tlvc; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcyJKgjKZQt0/jKQ2sGoeZqleXDgtBJXlruI3sklETDLtCBlOAahhnktHhDuezgP39yyqRaJnL02SUo6jhKLZm3g51lX9dfhQPS1CWvvIw4UXGkEvI32nK1jVOsVPkcC3H9zGnciAZmSqClay99tN49+Td+s6/1CkDNJC5J+FefntMMqlCDvL+P0U7kXbZ3z8QHxRftVc9c9XqLuhNOXo8UEGaLgcWno5taKUhID8SwWRIzJOlW7E8AcSjZ0HaJ2GLl4mtwgPF7lI6cNEInmGO1h4sqXIgTqPnKw0AK2dwpXMguAxvG2K3aeVr1zgMVupHKLBEo6oRRH6TdsepUZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DdV5S42GfQOzPvrP2P3a4IPZxI3/IMya1aiLmSIYg8=;
 b=rPvjaqujNge5+s0i49p3HC7PcxdyecPc/jYwwqHnYvCZoYs0c5OLk4cAgqECO0ASRLB0DBe5SrkfilJ9Kv//lFQo1MmbTsIi/X8aYvtpLiammIOasJE9Ah9cWHuh9r5d5MkhaCtm+JY7fbhn2QPvK9zX8KD0zpwxzZFX7Tk9sPwpaMVq8j2E+nWR3P42dvsA9ETT2XZL2qtlfC8lCMAiHlISuTBqY7mE3ds3lTEkCg6/w2LcL9nB6DJh9tO4+7tb0ADkLhGFbI/1DYwEXGn8fO7gKLq9bhA0+6AyBxigoVWGafRTQ72fKCRmJXsNGkrxSQz78rwNp/rkTRaAYeCW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DdV5S42GfQOzPvrP2P3a4IPZxI3/IMya1aiLmSIYg8=;
 b=YtZ/TlvcI6SmTROlHRLLChifB6cVl8adHoPDZAhdOLfyLDpp3FUa6cfHfNbkqaKIZfh5qxQ40kO4BLI8mZOGDsjWRA38mX6R2jcZw5FYzAg8qEywgfjI2r0cdqRDML6z18FiRfqdKDeLCyVcyKJCaEdsc9SsHrBNQaL2F4JBG9EFJE60XBuHKE8EM0OnkMQccPwsaEIHBgYObn7vjTVKwhZQw8zrTZXNtoanstwZI6Qp6k5R3l25Ou4kS7/JQDNOUSSc/AZjQ6U570yYU12pUgo1GMWgm3SaKPXKGLAsmBqFqLgOTWaUZB5csAiuHK7ZoLMozMdEkRnZYvAfRQeiVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8627.eurprd04.prod.outlook.com (2603:10a6:20b:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 07:09:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:09:42 +0000
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
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v5 net-next 10/13] net: enetc: extract enetc_int_vector_init/destroy() from enetc_alloc_msix()
Date: Thu, 24 Oct 2024 14:53:25 +0800
Message-Id: <20241024065328.521518-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024065328.521518-1-wei.fang@nxp.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: b07793c0-553f-4ebe-774f-08dcf3fad4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NS2lb7ERP2g8T3w6yd4AkjQBywR9NfKxJ2CVf3OtOWwJ6Z19SrvrOhjkIX9m?=
 =?us-ascii?Q?FxGlf8a9zxbM0I6SIlI1OBvnAEFI0Fg7ZOXJeMl+6p7Lx5/+9l3LGjicAKI7?=
 =?us-ascii?Q?mSG8QjV7v8z2f8yV1z7ORzI7Zr8l4gD/QdEWZEj96fYsR4ZUH50dBGkRAYBj?=
 =?us-ascii?Q?DWyg8z54qLwsp+HVlwV3hnN2Fqlnvwpxu0dN0ieu/7bxpe184qkqlwuUja9a?=
 =?us-ascii?Q?hsNSeNh4lp1m5azF/OXPxzgr3WA2QHhpl5fSencSrGwOoo4+Hli80ioSP7l3?=
 =?us-ascii?Q?/Xqea8KpyuEJDw2yWKn+lpn4kh1BYpTturbti+eeoTwH9xO0m7u+O5mBm6Lh?=
 =?us-ascii?Q?TyfvGBWl3Fpw39nOj5ltW5SRv1g4tGZVMvnrXRyFm1giHyBQuiHX51VnJ9VD?=
 =?us-ascii?Q?y09PcDZwxfGc09XA1LEGBenrZ3TSEjP2+Dieq6UXNm/HZHG4K64GUFwlWMAq?=
 =?us-ascii?Q?JZkdeUjcD+bnuCEiQduQ91L5qtX0bxW2BAkg8+etfBVyfeJjZX1dKUEYSjf0?=
 =?us-ascii?Q?kiZL7c938ACQ1oYk1Im8E10cqQsjpi4sKtUB4HR2WAnbjdln2UgeAhlTX61P?=
 =?us-ascii?Q?Y45Ri0+I9VREhkaEkyhYp9s9y8cgHZgCFrjYdZpFsChOBL+QGA1faRKC4IqX?=
 =?us-ascii?Q?bMYRhlPxFAZLKu+HaE82sr24NEDGIG1h/2gUxPCfsgiHcpajOgDMHo4h2JWU?=
 =?us-ascii?Q?7g/GudrOPhVNRgCf91ib1zo4w43k/wRVHxqcem356Z++Mo4AgdDbubNOPwbV?=
 =?us-ascii?Q?XlyzmAoJp8NK93uVu/Fh3Vm+mQ+D1B8qNriNolG101fLMSN1puptFHJDGMYD?=
 =?us-ascii?Q?vnxMOSaDIgj/gbnGf+EvpQrmdVf7rEZzv8iKTzlRRBFbOch8tetTVXdLxqpP?=
 =?us-ascii?Q?IqajyycMCD+G1wPvdm3vO9MyAY6fMBZK2Dlqh9CWaecd6KstZLQBv0qLvOsL?=
 =?us-ascii?Q?8ZbJzotXNPX6UZXOalb+WUK2e6jd3XTcsQ7H0tL2cbCsvAsEaYMrybu7LgjQ?=
 =?us-ascii?Q?AlAsj3bd6gkYuCVtBrTNMuzjj1FFWE3zRaJ2g3V+LOUVJXvTTd7npoGj20Gz?=
 =?us-ascii?Q?mwc4pzQOZQOZ0QpzmRmhnhLXBW7LnJpd2Dtr/lVIXRbHYPIMXXHxrg+j3/X6?=
 =?us-ascii?Q?8T/lLjY4vIM7WUYSMmdUKcMjsQlWxKaUL1a6yNNqvby/Cx+Zucw8aOb+WG/u?=
 =?us-ascii?Q?s2zP+pg+SmQ9HcpcayQkj+ASnhhDKHiOFznS+k2s8ktCmWPYB3yVFe2U4dfS?=
 =?us-ascii?Q?+np+kYGVA0RmVzzXThs/1gOz5DmiUOkDJCTfKX5Hts02wdDAkzt2WbFm6puy?=
 =?us-ascii?Q?QRGk8i3xxZwcbT/azqUhOxYBB0gulLUIBEaOtPGobvv2oXZqjq6RkphZARXp?=
 =?us-ascii?Q?D8VjAGxZd8acx3wvuVug+tPMAh3x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5F9ciE7Ob8sYT14HyYeGqGeGjcrwb1t3R6lHEB7rar0SXxIqjA8t/+wPlErH?=
 =?us-ascii?Q?WXkOHc2g+6WSNM2t6CqySaHaLMHQ73Exqgy9b2lMr1nZPkqz/qcFkdhVcFdL?=
 =?us-ascii?Q?OMryLq7PgaSMQQG20NoqEeYsXCJN6a+c0KqGC0W4/O/j7L+GyUZquVEgfnBM?=
 =?us-ascii?Q?mFetut/rh4l4SFgmEgMFsuc90glWUc2vDO3gZzJnYi+64VNFREYHWg/5tcO4?=
 =?us-ascii?Q?Q2AQ4JB+cvqMeL04J6MdY5hElyWH4+QwF4qs9rXc5pwCroAX/xD61sls7tsu?=
 =?us-ascii?Q?Z09Pie85nQwP9/FO1MNDoCsC29KzdvuuNqzZPcfNsYD588JI5Vt3OsaVGc03?=
 =?us-ascii?Q?E9toV5YJY/UmtLFlYFHz2uVQvCb8oZ9AT58+kxTTby3hagCKA6R5aGM4VrR3?=
 =?us-ascii?Q?5T4s8r75R1d1CXUe/pWKbmGr9KWFROCMqMvDiROstZnJAdRPXRz/cb8yFJIr?=
 =?us-ascii?Q?qGI0vZVPk0Zh635jKw4SP2J0RizeuJA9BEfhH4WV2qdjorN3ZrE7A5GyfGww?=
 =?us-ascii?Q?2ko4hqOtXDvEwPe6AdBNdKGe6OZdm8GQS7o4yF8T88bXlyqxvPYs4BI6W0RT?=
 =?us-ascii?Q?t/PTPRoIwG7zKI9voAdmnxZ/02QVy/x/Yn3wOER3g/bSn1WCrVfhQDDiVrra?=
 =?us-ascii?Q?Ltxnoj3SeFfjfeCBEPZD1LHkwmrVZf9eYpm/IFLDk8uQS7yINoG1HMHSJgwv?=
 =?us-ascii?Q?78eOv7KzYbilsos2ofVDYd4DiPoZ4SOesRROvoxZ0l6cD3+8BMcbsDDBPkW/?=
 =?us-ascii?Q?0ff6/lJoQedIiJ262qs7glg5zO/jTAf/9xe/E+iOgrran152uHI1Vmc9hQdF?=
 =?us-ascii?Q?R7XW5KFpHu92qVqkfqIgZI/hONdMrfhYoXo6p2NbhibVqoOyiyoVb9jB75O0?=
 =?us-ascii?Q?YJaWkBwfCKKHzcVDyJglqHljnJyvAqvSrFc5Uyrkb69zOX4TN5dHV7+++rlB?=
 =?us-ascii?Q?AvmFFO0J+NsNhQK5oEtUhs7cVUnRmKiOaqun9goJEkWto1um9OBtJTxy4MYm?=
 =?us-ascii?Q?vODzVnxqsObVI3YxataME7BdnEHyV20PnkWula/iMkhuUi7D2Wkph9ewmiQZ?=
 =?us-ascii?Q?cvwAJIPLk4IGv4pXoMTb/IeIJBdQubdeL3o5kfYutUEFlnju2ryGTuVzJM9c?=
 =?us-ascii?Q?+X7jxPnIUCmdU5YHcLxpJJm7wVGFC3KbAIODkcrjNTk9W9IXISyjVEm94tKJ?=
 =?us-ascii?Q?usgPiCNwX1RbqaAnoxiz3708oU7eZlKaYf4v7xuv00wxj12mmk5gesPCM5Lj?=
 =?us-ascii?Q?eF6r7zBmYQkwtCkS/0o6KY9KNtOXG/hf4zUyysh8ZRpawBuQn3BwsxFlEHYH?=
 =?us-ascii?Q?jSnSRGYeRdHglDXNAlfSe6JXZQZy5uTDpKOymrD/3ugY+tUS4IEjtND0yIHQ?=
 =?us-ascii?Q?oz0M/PiJ41eLUgWvv07dG/MsaRHz1e0RAmBI+MSYjDpY5a4IOqqOfxBqKcF1?=
 =?us-ascii?Q?tC1ApPA0zmIcV1+/tRCh88Ng/iM0SCRpV3zO4H4ZydxYxOZPHsSSDTwRzvyZ?=
 =?us-ascii?Q?aV6NcYx5FOL1tGjLEx0kU6JB/kjX6eCNA/VSh8wzdoIuJLpcZZ83N17En8/A?=
 =?us-ascii?Q?jGO5S6P8XVLkFWX9hMlOWtjTwta/gKikzBETYVo2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07793c0-553f-4ebe-774f-08dcf3fad4a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:09:42.3155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v26q2McaZTVKuJRLEjPfyJZDF6RQbudY53JhGPVHtei/poQgR2aanzErIl1/Plqxh10ZItlNmyhqcpZGzoxmcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8627

From: Clark Wang <xiaoning.wang@nxp.com>

Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
enetc_alloc_msix() so that the code is more concise and readable. In
addition, slightly different from before, the cleanup helper function
is used to manage dynamically allocated memory resources.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v5: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 172 ++++++++++---------
 1 file changed, 87 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 032d8eadd003..bd725561b8a2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2965,6 +2965,87 @@ int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 }
 EXPORT_SYMBOL_GPL(enetc_ioctl);
 
+static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
+				 int v_tx_rings)
+{
+	struct enetc_int_vector *v __free(kfree);
+	struct enetc_bdr *bdr;
+	int j, err;
+
+	v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
+	if (!v)
+		return -ENOMEM;
+
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
+		return err;
+
+	err = xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
+					 MEM_TYPE_PAGE_SHARED, NULL);
+	if (err) {
+		xdp_rxq_info_unreg(&bdr->xdp.rxq);
+		return err;
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
+	priv->int_vector[i] = no_free_ptr(v);
+
+	return 0;
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
+	priv->rx_ring[i] = NULL;
+
+	for (j = 0; j < v->count_tx_rings; j++) {
+		tx_ring_index = priv->bdr_int_num * j + i;
+		priv->tx_ring[tx_ring_index] = NULL;
+	}
+
+	kfree(v);
+	priv->int_vector[i] = NULL;
+}
+
 int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 {
 	struct pci_dev *pdev = priv->si->pdev;
@@ -2987,62 +3068,9 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
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
@@ -3062,16 +3090,8 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
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
 
@@ -3083,26 +3103,8 @@ void enetc_free_msix(struct enetc_ndev_priv *priv)
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


