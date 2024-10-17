Return-Path: <linux-pci+bounces-14748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171DF9A1C76
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0C31C21B91
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE311D54E5;
	Thu, 17 Oct 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FjFrpWv4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CD1D54CD;
	Thu, 17 Oct 2024 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152189; cv=fail; b=TRL/GCOK4t3iTLV4/qt/9yoi7ct1Bo3JF1mMP8gpvgB+0E3EC137juOE8Ehwb3Ve2JpehnXxGXV0KfotwWDI7NKMMSqxxins4Dzl0j/8oVIB96bb6azjrNY+qo1YeMMaj928t97DZhnD5Eg3ZbN5fFSUlDKJ3qPILxs08iQ1+J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152189; c=relaxed/simple;
	bh=fHXC9g37zUTIH35Dle5bDy8VA29/sEh4c9mn6NsEjLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqHxNzGZfhtyS7yyQbdrvyDKYIOlLW1qkVpMpKJLdqjjpE5N+0zV4MT5eE5anQyzD12NLz+DUgmq2+qNR0Feyho5xBP9/RWptFQfZDLUFvb3YCpBvmEF2cImYlPAszSn0FMVHIdv6ApNYQoLsZOQsp8FZCEsXsAGRRZPC4xrBvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FjFrpWv4; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfG65kAN5tEacfHQFXKYEE1CpM68D7FZZ4TPA5Cg7SYUuI8DWnXFdSFwm/u7Z8JXgQP7ACisYwYQ6xkNmPwSm3jE2SMtv91Z1P/6YdZDWLzJ23lWhtyBap91QhMGIhMs+0rljOf7SZ1eIoxsf9n6wSxE5ETLk9OcENpMt5iurPmbdOaApNbE1nJXLMIb4gFSgr4wdc/OX6p8P1Tpk62J0XrEGrWO6aOwozPh95AaaPh5/cpf/S8mwqL4tDu5DWHPLR8LVOdovoeK5IN/V3H0etnnsYeGJ8r93f919hDBDSAZUHwwEglOHdz5bt58YWKRSfup2Bhn/Unv2NcmHtRenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbbb46IT419P/KO4dM5ME69Ll0S3sCytsv65q3JNGMM=;
 b=BQ/dGarK1saUVK8X8Ma5v0/XEkfo33DRKKc4Vz4tObz+2HoFAIocgC7CSjwNA0q28oqadmQJ0xeTkIjCdfuv73Vn7EKb0EiTn5wEoB4NQc2T9hhvFS+0xYXfCyGlSZqltHEU4afJn+5VtFMmrtzdXf07RAVN2MMmWrpYdbuplN+lfp3ktTZ8ofda7KYtQzZzdJvJIV2yUCq9cer8xeLKgIHcbzutx6JYib3fu/+gaXIm41ka5WEsq/huUy0bn1QePNlEbnisEDtxnAl98UEJGgw6Ci2PqxPQiLgi1jryvaqrpa0lcUjhy5CFOSfBvn7yiGf5pzbW4jBlNU9q0Bd1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbbb46IT419P/KO4dM5ME69Ll0S3sCytsv65q3JNGMM=;
 b=FjFrpWv4dPLzH3r6glwpB0j8mww9B1jbAd81xmtUdV54VzfH8P1/LkRSUQP0dHlUOYfh8bAVdxtU84UpHAqzyKb+/P4BFVEjUc2CNZSrEiVC36bYi3d9y1a3ycGz+wL1qRjjbZrkxm7bdTQwXdyGEgQQZSAdpJgwKquARj32igKlla2BG8mcSek5uvGup2eygSIj2WQTXmXVc5LanUisw9yY9i79o1OKv/YYwR6GQjn0lJFBaKurEqZXaw0y1MTF1rdgHNFg6OSQdmm072NhPo8vmLrFk7w0KLbZJ1bD1fgP2VkKhbMJEBDOxB4M2rYFcMmCD6iUDc+4BO53meIg3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:03:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:03:01 +0000
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
Subject: [PATCH v3 net-next 10/13] net: enetc: extract enetc_int_vector_init/destroy() from enetc_alloc_msix()
Date: Thu, 17 Oct 2024 15:46:34 +0800
Message-Id: <20241017074637.1265584-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017074637.1265584-1-wei.fang@nxp.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c1b32b-5a36-491c-b0c4-08dcee821eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EVhy5A9dmreRsoMPsoy1yXDKfyAhEtToOXkgknxP55bRi45v7q5NYKvrjVPr?=
 =?us-ascii?Q?Q2+iFeF8jJN+09vZg3qjDvC3G6fOZAhIC/Unx53WoTZjXcAUc05Hfd3XFpI5?=
 =?us-ascii?Q?Rg4xH66tXZht528HjtmFvw/J2MPLcsF99lM8+UDpV3awOBERWoKD3ybbdyJt?=
 =?us-ascii?Q?1nKLy3H/yNBlTsEF+/OXsNUJl2zLETCKDCy58Ut9vH2FMJq5M1mbLC89froB?=
 =?us-ascii?Q?VUiZqEhLMKdNRLNu0T0jh7q6cwlAUFyBDDt/KBBrlX9v8nEifuuMuyc++sZJ?=
 =?us-ascii?Q?v0zK8B7cBl/XZMgERir+JVoLbpb2SOHUrYmw31bWYC++ydzT1mxvKI91so8P?=
 =?us-ascii?Q?k47+swRLIXLDJGxxOJiUKT06Y7xgU1SGAT1irNBjC8/rZ8t3kPYdelGSqJMu?=
 =?us-ascii?Q?KXoGgoyLwtJBcXI7ws4ew1fIijYhPCvjqPtgB9xaRfRR7IVa5fnjF52CpC1I?=
 =?us-ascii?Q?VHZG25sNOrM7Oj+iY9/bWh6EJfKJQShAfpPmSGne/zQzCtGwGEn9GrX1M8+9?=
 =?us-ascii?Q?tKdmGHIWJvrcQhg1+3h+/iSmUkBFiYqIXinVwXoplX1mkmQDNotndpTMcxXB?=
 =?us-ascii?Q?Io/pQsXb3XFIkqQcH6inTbj9rqDXCu/o2IYZyf2hG7N0+/i/039PBPgODzmP?=
 =?us-ascii?Q?Jh2SQQ2Zrh8RIGnZY7Q2VR2CYMHpG1vqo+eeflwhWVjoe2bu2npnw6NB0y7l?=
 =?us-ascii?Q?floK1+Biq3t6lKfJ3IgBB6rv5q2jUxX6ljONXSrVCMNyk1Vs6yaTS9iwD4jo?=
 =?us-ascii?Q?etFSjcxy3+BYIuwGYFmg0WAf2EzeWmwfd6KUMK4wWt4KIK8CExOoXhW1ZUEh?=
 =?us-ascii?Q?Nb3w2ZsytoHxO/RES15UxOdkMyZ87d4dcDnTT6li+SylAVWsIWxhtzOf0pt/?=
 =?us-ascii?Q?t7xruhjdscJQUwq9LmSrxWvziZ4my3V076o63q1XAlti7cglJkhXgnY0lyPj?=
 =?us-ascii?Q?I1+wv5rAT4M9LwdkMnyOEYM5I6FQFqZjTfIdtww/2Giabg0WaYLiCCP/hciK?=
 =?us-ascii?Q?hqCZ2+J5ELPHeS0TEdZpptIAWr41dwS54WkmMoqFygjJLR6fG7EHq1kjRmAT?=
 =?us-ascii?Q?HLA7zP3s0UfVOhoD7jDzs7M5K1+VY0dZaiJLJwjPvTC3IUJ76na9k1n6wYBU?=
 =?us-ascii?Q?pEZdRzqWWj0Ffk35FvDS2U6bhzaScN62LFD8rNSlSKjVnNmn+gmv/iKRAFg4?=
 =?us-ascii?Q?CriqlX5oob8w84QYyB4R5yuEBrc4aiseXiIq9ItkZVy92WOzYLFPtuaU+Dj5?=
 =?us-ascii?Q?u7MDeEncL1VCxXncuGPhzpYM0+8THIcEAbw3G6JDrUxZV3v3AEPl2f0T4xWj?=
 =?us-ascii?Q?Gu5KQogbq+eHhub2B6VlXmF7H0bMAmSq4cYJASjyCQlgrmCYLzFvmJW7LNFQ?=
 =?us-ascii?Q?DtsLfo9IYsPgEHVkoDVy/pml5zY9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9fSgF1Sc/zA1mr0Q2x71qaQBLIhsOCWyPeGBkqSSDUUTze2L52+Bz4jri0sf?=
 =?us-ascii?Q?54QSR7Sr/O2bKY2V5HdUdvEoXljuMmO/Sa3gCzopqbO/LKjoqTRnPJsi4soW?=
 =?us-ascii?Q?cOpmOHwAC4SNdHS0B5HmUVoxnaswOfxEWl3AP4jp3+UWYf/Y7+JGc/UKMG2I?=
 =?us-ascii?Q?DPMw0QN0UZMDSUQGPgeujM7mED2F7Pnsn2Ftd5WZR3upL5D10w2VukPUDaCM?=
 =?us-ascii?Q?krN1bUPneiJm6mBrRDFwceLn70NjztWQSa8fcteJsejxPEatlrerhW+oS+cL?=
 =?us-ascii?Q?pgRk4EQBKiaGkc68dK6nyQTQ4UAzdTslx0Kon7D3VkKsxeQzFiQmen/BvH4Q?=
 =?us-ascii?Q?WkwYvQtEwsMlUKv7UiTuPrf5IUd9QgNNrKFKSt7kHfUzwj2hjA4tD2Q8DaqD?=
 =?us-ascii?Q?tGeCje1Eubu8AhAzG8OHFcyrg2WNYy5B8oExU+kWLC71lUsvdKZxm1+698mv?=
 =?us-ascii?Q?DIU+2esdqDd1N8MNTJoX8Uz+Goo5JrwZPemHEA52ukwDsQR53w0UR0oooWW8?=
 =?us-ascii?Q?3LhIcJ5Rk0zK9mB62tn7MdsQQQ3zie12som79G17DhhEzdejIKNxFsl+vqSy?=
 =?us-ascii?Q?6TD6XaLdCSHHfDtVN8yNRCNjLjulc9Jh61rJAkRxD9Hfv6S8NJ5JAIQW/LMu?=
 =?us-ascii?Q?NvOa6LFFMz3gacvbOSHJDKuWnPsVDtBretUC2hFTGxp3fVSzv8XS0AzvH1OJ?=
 =?us-ascii?Q?PrTeBsOjdczf4iyGzJjkDW/tyZakUxqmmD5Hr2g2azFg9VWTV0w14YTixRdY?=
 =?us-ascii?Q?7T+2Q0LENYrwYCMEah2uQZ3e4GjN4A3v5PFJCDbUcJqBUDovC83EUsUwnk7b?=
 =?us-ascii?Q?pUboVFEvqC1oJMGsP1UYuGGfEuU+cGr28x51aCd8AVbhPYYcMr1fCX9n6WUB?=
 =?us-ascii?Q?w7ZBy5sEZuXmdQnLG8s9o9iGER5yVoMrjm6uoU/DRlVZ+AS08ZyHCAXBiLVO?=
 =?us-ascii?Q?NOxMzJAChW4/e/i2oo70XTc6N+SuC8XOrMTfYBN8yTKQVdGW2z27Sw5n1/iZ?=
 =?us-ascii?Q?Mxa00ykQc6mOkFZm3VK7PCEKHWaVa4XOBys2l8sCSro4jtUyWpwPoQ2oOd/T?=
 =?us-ascii?Q?bGUvHaCyjHHV+XKsPiD6LOCNgkZUXLLUyQ2z7AiQGKbwdh1IlrBsaIapQNzy?=
 =?us-ascii?Q?19ZIsFKq/zDFqNFPOzaWLctPQRj8QUeFHGLVLQfzDmXiODOIN93H/7mQ1kpG?=
 =?us-ascii?Q?pRLiwbu0WtYI5sXBhhXklfdL11V9H8qlNiZtAOujswbMZQK1cVVnPbHbIC6J?=
 =?us-ascii?Q?SlEv9m5s7CtUzBZIh48grULbcFgtDnnm9SuOpq4rF+vuHlWUP8LWuxVYlNo4?=
 =?us-ascii?Q?P3RGNqg7n4P6iWO/6vrTyGWoiHTsZX04SPAMDIvEW4BSqzKm6FNrw21xMPx3?=
 =?us-ascii?Q?iPNjV9id2esJwidtqcRrMPfcZG4DL+wms/OzoPyqnC8Behq+iRhjAhOwtgAE?=
 =?us-ascii?Q?IQgK3l/S86jgS4XiTsRyxMFvycdqRFv62/gPcCby2jceGep5XYZDBZMnpA0O?=
 =?us-ascii?Q?LHdj7abKY6B8b/TRIIevVN2+QNkACKTc+snKSj0j2X2kc/vL9QhBebnV9s41?=
 =?us-ascii?Q?07kFnGhI2cGsn0FBob5RnVQxvcNcdOl/0h/+XRu6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c1b32b-5a36-491c-b0c4-08dcee821eb3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:03:01.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEm1IJGGATolNao1Klk0zCeih0sfFdzwX9EukvFDUpDqEQieQgfzsyY1Nc2d8LMw4qhhJ0IbZeOwQ31qlzcCkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

From: Clark Wang <xiaoning.wang@nxp.com>

Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
enetc_alloc_msix() so that the code is more concise and readable. In
addition, slightly different from before, the cleanup helper function
is used to manage dynamically allocated memory resources.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
This patch is separated from v1 patch 9 ("net: enetc: optimize the
allocation of tx_bdr"). Separate enetc_int_vector_init() from the
original patch. In addition, add new help function
enetc_int_vector_destroy().
v3 changes:
1. Add the description of cleanup helper function used
enetc_int_vector_init() to the commit message.
2. Fix the 'err' uninitialized issue when enetc_int_vector_init()
returns error.
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


