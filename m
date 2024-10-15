Return-Path: <linux-pci+bounces-14543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA9699EC34
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB051C235EF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0012281FD;
	Tue, 15 Oct 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dj4glOPU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC172281D8;
	Tue, 15 Oct 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998056; cv=fail; b=hgZfxKY33x5+X1HqFtra3cwEy2e+dj6nejs1g0M5eufZm24JtePr9dD/9r8BWyd8V3iG4LH8WM/lHxSD/DTeD373KyxC69vP+FEFMAWA0e+99pizoiEHQE+u0L4o1fvXyXBAUBC3US253KaZA/ywJwNDzaCor3anFzl5vr1yU84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998056; c=relaxed/simple;
	bh=rmBKb/g1LIxBAei6hcbiymqGc9ncmmzjPEbBmArZjK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LtOeCUMhMAChTPGReOgu1zgIcVbS/xKOonlf3JCzNaO3WXmR27WKuciRJ1OYaRITJIFP2y7M2GpUE7mG+qqxluztaFrP8pfL1i+YhXoFuUr3suuEZdIiCnSjnKkGB64C38yg4X8jhGTMKDuWaoSpbGS0gElhIkDbMLXNsm9f78E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dj4glOPU; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3EI/AIcGK3YHG5lB2CxcFhCD210cCFxL/xTzrHKPV6cHwv5rzz9UHuwNreu2uJ/mfwS2ZJ2fz/9Ma0ItLdDM9FdrUdBcOE0Lkl0RG/h0qvs9JSRvOTZEBeaRPWqTKdkLtXZ3lMxLyt/0d2Y3P3Ql7crqNzg1zbYWiXEGqSSvje9BCRQ/7o4oZMwYBDX/jxNPuszUHwMgIqcRvicq0TKjtw6FVsczx9OGftSD15eLPZkV0+pDpwKWEaoqQbxHK91/TKCA/K3Zeh1R1oqjMGncsfnaI708EJiBg6/6YDNrfqff0TfIXJd0NYd23XzU4ZsmYjx6HY6FYBDOH/yh4B1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRhAdL9GW3rTCSOeBdOXsogL4MAIz5gKonT1u4/rBUo=;
 b=qGnRwCY/VOjt8BQgqQimmR0ilZVRYLjVgYo6M2kKkL0JsA//sTx5ewCtgq1CgQCM6YgdnfN/gPms0b+QtjJACWcjvkXoOCE/M+/pVk/GRMPa7Mnxajg8xH7rpbWMZXUtzgXMmCy0nQo+0n5lAjdXiS7ozAZGtKbp7+janh1gqk/fw1vdI6TTRvBYHnYLjLdeLVZwAiKnXVr5Fgu+XTxqjsFfQTW1UNT8AHENm6XahLVZNBrZYplhqiLP9Gvxq1yC0cLZniZ2nhTXCOxP/XGTOPsMAlis5StpHOzRZhFmp6XZ+ywB8pv3Hf0Hhpm56vEC02go/g/cgL2OLBVRPyVBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRhAdL9GW3rTCSOeBdOXsogL4MAIz5gKonT1u4/rBUo=;
 b=Dj4glOPUrdJny4NCXCgeHrnXp1p727CbV4+xd2/dQcVvVDhzstFADWBswxEGe5fIeixoqwol5Fx7Fade83qHMclVubnDmDiInb1BuxEUcxZfC6dPMnFHK+DP8buGBfHnItd0pPMB+/A00mS6PS6anwwU/heQ0jTiSW/NMTUY/vzRxjeXziWcGW8j+zaKOCVxJxJQp+EfK2eQRWQ2SdnZp3JM7GAlaJT2UUQ5mT9aff8VTxlTBy7qz+zyff+mbYoMAfdi4YZ9kAiTSRJTcHOnZgseO2R//mzki7oJLUe4P3vg2jRF6aIlXehhAyZxWWq7uDRzRrE6fXrdJ6aH86OVMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11041.eurprd04.prod.outlook.com (2603:10a6:150:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:14:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:14:03 +0000
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
Subject: [PATCH v2 net-next 05/13] net: enetc: move some common interfaces to enetc_pf_common.c
Date: Tue, 15 Oct 2024 20:58:33 +0800
Message-Id: <20241015125841.1075560-6-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB11041:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e164b46-a21c-4652-2064-08dced1b3c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zx8rAnbkbli3X08W1NB3lbBX8R2xL7+ZDdaPLaN8QC2lCRLH+2tulmsD0y25?=
 =?us-ascii?Q?rI1KxRn1dh4999tqorX5pg2/MHSLDf7NHG9aMhqsMSmqNMJvzAaJjA653fez?=
 =?us-ascii?Q?YO9Q/xknD7w3iP3S/+/OgRkkbL2Zx/DTJgg7jR/MiXIvpMNG9tJD4zSJHWDc?=
 =?us-ascii?Q?v1qCMPXeLNDDLcYxt+FumMZRzaknOBpq7S1TH92W8S8Zyl/Bo3eUkRHvyWb4?=
 =?us-ascii?Q?KR9Z0jYUYRjcZrZjtFV8Gw3VQFKAT68tE2CLFiESeO5Ad0TopAu9QdQHLInJ?=
 =?us-ascii?Q?0IpaAVpiowQvSmqzFNXqKekKqASp7J7pkIGaFN7qXT3yXk4Fg2ru8M6aeuhX?=
 =?us-ascii?Q?YHD1MOeT2ScldcL4VMTKwfnpf0z130vWA9D/dY1ySQI9XkDCFBs3LkuifJhw?=
 =?us-ascii?Q?IHVr88B/AjgLIDLKrSMHSN38BZ54nSSOLZxLWk6vcCqIQaKpwqnpsyHWNwXk?=
 =?us-ascii?Q?O+grv4+aoT9AkHPfL0PSzKioufeOLsYLkK5ftA0BKEQWuGok9URrIN8Cwrbn?=
 =?us-ascii?Q?37/K88Ve4kT3yAulYSxZ8vZGPD9+0/7eHKeFrslc589Zb8ArqMnQVGXq4z1U?=
 =?us-ascii?Q?JmAVP4oerNS05scLonrt3dCO8JOFNSXhqNYOeKXCnIwnJjhsBaJc8sjJZCFK?=
 =?us-ascii?Q?OdrpHfwCMzwRHrF0VrzY9QM5Q2+MkjERgAlh/ZqrSAHYyHCFOrGcPGIZuNxL?=
 =?us-ascii?Q?I7Tl2ZX2ZSHLWwjsbd+WwJg1hdtJfb7jvu4fJ8VP8ilfikfQqGHqfSqFGN7w?=
 =?us-ascii?Q?TCbX75kVjcYzreupksTfBrRU0JvnEFrw//VgFcENHXJ9kDsp2uqHup1+omI5?=
 =?us-ascii?Q?S9lvomU/l9hUZjTAnfePsXsNGJHRreBXkPnr2kwq4H9iaH34DupXMpSuJMSg?=
 =?us-ascii?Q?Dp/q3I9cIdTaEPfBToWNMoutyV/U3Oo5YAj1eeX8ZeRrK/S/5qp69DhZBrnp?=
 =?us-ascii?Q?JL+RqmuXxnVGl70lpEa/XAu79nvUy1ZqyiG2HxIJcJ4Ot3pYj0P1NEad1sFi?=
 =?us-ascii?Q?tdC0QlVGCWJ37VscmzxAS2OQxgtxfeumTs28vq5FlC2XSooJ6/xJxhbICny6?=
 =?us-ascii?Q?YYcu+Mi5AmiLvibizSdcF0Zj01lK3z1B0nQXykBJITTDdKwNEHvwB6oeDSv1?=
 =?us-ascii?Q?vxyMURokcKZCWDYeVXKT4IUrJjs9Fl5//N1F5OowVNXbjapDInWaAEGgGSeD?=
 =?us-ascii?Q?thNm2mbF2s3zVi5wz4e4AfCELBg2y15WNQJj9En+oXpPkjX+dU0V4LHc/EpC?=
 =?us-ascii?Q?b1HcxDgG6E6iGQK2xBo5YbQ2AX9r+pje/poqh652RfiMQihXACMSJSFksSDw?=
 =?us-ascii?Q?VVu3Z+HuEXij7KobxqKxa+GNBR0JQE5sI/Q2nuvlalPaWwCjfvudI/RZg3sp?=
 =?us-ascii?Q?9AukTkQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V+vMtzwuIKgiiXNbTGrFTLLMhNNLZNsdx4BpaWVc6bMxmkANDG7S68gvWK3L?=
 =?us-ascii?Q?sXl4GdBveiqxhB2UcYRp99sg/Zolt7tBJVk/sPDdwfvU//l2pwJ9PyLc+Sve?=
 =?us-ascii?Q?vTIufj2tSgsbLfJrLkDIS9STYoIyxY05zKxZhVp1/UGU5ktHhMAKxLO3Sl8P?=
 =?us-ascii?Q?dr7s7eZB/j0GIKtdCd0+1tkopNxd8fnZoo7Z4V662fcemCYjClUU8C7hJd0t?=
 =?us-ascii?Q?BU+Gr92cL8ee9nZHC6trMeJa7T4ty6JlVk4w3d5JzFLxdNn0ZudiDF9ekjqd?=
 =?us-ascii?Q?t9Vaq0phJIr7Txy98s14e1AtbdtDJagfy7C2yn0hPaG1ZXZtjzPZZP6GmUFO?=
 =?us-ascii?Q?KgtSLlvGEtZQCjoFCv2iboRG/f9Bq71EZWOYLpt96QuQGy2Gi9TbYYSnhrtl?=
 =?us-ascii?Q?v6hiWqhluTbCDIxl+k2c5gylpZNRYYWFWY64cGaIqNaFXDNLwTqFY9cnB+e8?=
 =?us-ascii?Q?OoFkXt4+QWQPj+N0l7Ka1hlaytuHqx8FEbpWp4QrME34K4d5KIPS/JLVht1i?=
 =?us-ascii?Q?4SyT1XVEzJSpKr27ryMVgVfyrYHQaXg/6Rq4MYny7re6i8CHp8Ukvlo8NqHB?=
 =?us-ascii?Q?oTKIrw9ESGNG6TZYbIQlp6Ekfgd1OoAqncd4clQQjQpLE2CI+rA9wRLZgVNO?=
 =?us-ascii?Q?91qzt26Go0tXknSt55stXF/qU40BR6lu+HfpNvRCYyQ+imifHwOHtFjzUXG+?=
 =?us-ascii?Q?ZJlmXWzjI8PSOY53e81v/agrFz8lRyIxzYR6EfEqntu8q9NJCcBnmjptZ1nK?=
 =?us-ascii?Q?CRaGn4Pc3rv6NuPMC5X3rITCeXrdndBcAYR/FXzJtgXvOfa32FNpD5mLD21P?=
 =?us-ascii?Q?izJDDLQnzlckDlROg18zLRsq+c7bKi9B1vNqU7IhW7Xb5KnCoyiwcJkXB/jw?=
 =?us-ascii?Q?KXXTOcxJZXc2N7BaBvFlBBQKWBPYyZ0DWra3W2HT3gjb49zlbuyBbDuSppQe?=
 =?us-ascii?Q?80UFpndQ6fJvmUOYlnNgznSMLIUUlsq+VhxIWsj0PnDRJecbhwxAigJsHWgB?=
 =?us-ascii?Q?MZk1PB6fIIYkzpk60Y7n75xK5eK4zkZd6cnpN1WP9h3P9aMRZYqs/P4k/Ser?=
 =?us-ascii?Q?9iPcVB5UVBdFjeUZgNtUbeY/gaz3jmL07jN5O1VF64qozoIwi5uMiKpXwYfq?=
 =?us-ascii?Q?sgpIjpntxiwmr41sbvRDy2CZVnY91vyOAWJrtehynOhzlAIHQe/p2gB2zUSn?=
 =?us-ascii?Q?OopNgDCB1EKO4qQiEUvM+gxLS2IJYMqY2vN+F0OK+T9D6H4OtFfM5pV5BkQX?=
 =?us-ascii?Q?eL7f6h2870VlSJOWB85rXQUgbIB0jDxTr4i2nCC/cXkgNcD+tGMi7tDagsqW?=
 =?us-ascii?Q?xKJBsyoCdv86fFkg5btrNUU77OcUK6IzCLK+ki/JqJ4u6ugEQDuEyxF9WZD+?=
 =?us-ascii?Q?GpQRbcrwAwKiKeWIN1dslgj59sKRjECPOZPcepOvXapuEraBdSy9khXIPWGT?=
 =?us-ascii?Q?mwxVm+d5lr4hItzrbbR7ysif+a6khD3pZrGHHX06Oa0OLM/ZIDe8bapNM/US?=
 =?us-ascii?Q?g+jzdNUlDPGYW+vx8Xc2DGnQSe9JJYvbHxgQU7p96ghPunPP9VLt83i+ZqJg?=
 =?us-ascii?Q?hwR9xqd1iaH+ScCwMh17utt2g3/SD6lmee14LLaD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e164b46-a21c-4652-2064-08dced1b3c6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:14:01.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hb3F/DkhTvH1djWcf67woI4F4WhyOUA6sqcn4TimOA/1SSzrd4ns22P5VlMokMvWO0LlvqNEJjFjl+K9nCYoug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11041

The ENETC of LS1028A is revision 1.0. Now, ENETC is used on the i.MX95
platform and the revision is upgraded to version 4.1. The two versions
are incompatible except for the station interface (SI) part. Therefore,
A new driver is needed for ENETC revision 4.1 and later. However, the
logic of some interfaces of the two drivers is basically the same, and
the only difference is the hardware configuration. In order to reuse
these interfaces and reduce code redundancy, so extract the interfaces
from enetc_pf.c and move them to enetc_pf_common.c. This is just the
first step, later enetc_pf_common.c will be compiled into a separate
driver for use by both PF drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-common
driver support"), it just moved some common functions from enetc_pf.c to
enetc_pf_common.c.
---
 drivers/net/ethernet/freescale/enetc/Makefile |   2 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 297 +-----------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  13 +
 .../freescale/enetc/enetc_pf_common.c         | 294 +++++++++++++++++
 4 files changed, 312 insertions(+), 294 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 5c277910d538..39675e9ff39d 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
 fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
 
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
-fsl-enetc-y := enetc_pf.o
+fsl-enetc-y := enetc_pf.o enetc_pf_common.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 8f6b0bf48139..3cdd149056f9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -2,11 +2,8 @@
 /* Copyright 2017-2019 NXP */
 
 #include <linux/unaligned.h>
-#include <linux/mdio.h>
 #include <linux/module.h>
-#include <linux/fsl/enetc_mdio.h>
 #include <linux/of_platform.h>
-#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/pcs-lynx.h>
 #include "enetc_ierb.h"
@@ -14,7 +11,7 @@
 
 #define ENETC_DRV_NAME_STR "ENETC PF driver"
 
-static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
+void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 {
 	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
 	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
@@ -23,8 +20,8 @@ static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-					  const u8 *addr)
+void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+				   const u8 *addr)
 {
 	u32 upper = get_unaligned_le32(addr);
 	u16 lower = get_unaligned_le16(addr + 4);
@@ -33,20 +30,6 @@ static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
 	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
 }
 
-static int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct sockaddr *saddr = addr;
-
-	if (!is_valid_ether_addr(saddr->sa_data))
-		return -EADDRNOTAVAIL;
-
-	eth_hw_addr_set(ndev, saddr->sa_data);
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
-
-	return 0;
-}
-
 static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
 {
 	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
@@ -393,56 +376,6 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
 	return 0;
 }
 
-static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
-				   int si)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_hw *hw = &pf->si->hw;
-	u8 mac_addr[ETH_ALEN] = { 0 };
-	int err;
-
-	/* (1) try to get the MAC address from the device tree */
-	if (np) {
-		err = of_get_mac_address(np, mac_addr);
-		if (err == -EPROBE_DEFER)
-			return err;
-	}
-
-	/* (2) bootloader supplied MAC address */
-	if (is_zero_ether_addr(mac_addr))
-		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
-
-	/* (3) choose a random one */
-	if (is_zero_ether_addr(mac_addr)) {
-		eth_random_addr(mac_addr);
-		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
-			 si, mac_addr);
-	}
-
-	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
-
-	return 0;
-}
-
-static int enetc_setup_mac_addresses(struct device_node *np,
-				     struct enetc_pf *pf)
-{
-	int err, i;
-
-	/* The PF might take its MAC from the device tree */
-	err = enetc_setup_mac_address(np, pf, 0);
-	if (err)
-		return err;
-
-	for (i = 0; i < pf->total_vfs; i++) {
-		err = enetc_setup_mac_address(NULL, pf, i + 1);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 static void enetc_port_assign_rfs_entries(struct enetc_si *si)
 {
 	struct enetc_pf *pf = enetc_si_priv(si);
@@ -775,187 +708,6 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_xdp_xmit		= enetc_xdp_xmit,
 };
 
-static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
-				  const struct net_device_ops *ndev_ops)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-
-	SET_NETDEV_DEV(ndev, &si->pdev->dev);
-	priv->ndev = ndev;
-	priv->si = si;
-	priv->dev = &si->pdev->dev;
-	si->ndev = ndev;
-
-	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
-	ndev->netdev_ops = ndev_ops;
-	enetc_set_ethtool_ops(ndev);
-	ndev->watchdog_timeo = 5 * HZ;
-	ndev->max_mtu = ENETC_MAX_MTU;
-
-	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
-			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
-	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
-			 NETIF_F_HW_VLAN_CTAG_TX |
-			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
-	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
-			      NETIF_F_TSO | NETIF_F_TSO6;
-
-	if (si->num_rss)
-		ndev->hw_features |= NETIF_F_RXHASH;
-
-	ndev->priv_flags |= IFF_UNICAST_FLT;
-	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
-			     NETDEV_XDP_ACT_NDO_XMIT_SG;
-
-	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
-		priv->active_offloads |= ENETC_F_QCI;
-		ndev->features |= NETIF_F_HW_TC;
-		ndev->hw_features |= NETIF_F_HW_TC;
-	}
-
-	/* pick up primary MAC address from SI */
-	enetc_load_primary_mac_addr(&si->hw, ndev);
-}
-
-static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_mdio_priv *mdio_priv;
-	struct mii_bus *bus;
-	int err;
-
-	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
-
-	bus->name = "Freescale ENETC MDIO Bus";
-	bus->read = enetc_mdio_read_c22;
-	bus->write = enetc_mdio_write_c22;
-	bus->read_c45 = enetc_mdio_read_c45;
-	bus->write_c45 = enetc_mdio_write_c45;
-	bus->parent = dev;
-	mdio_priv = bus->priv;
-	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
-
-	err = of_mdiobus_register(bus, np);
-	if (err)
-		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
-
-	pf->mdio = bus;
-
-	return 0;
-}
-
-static void enetc_mdio_remove(struct enetc_pf *pf)
-{
-	if (pf->mdio)
-		mdiobus_unregister(pf->mdio);
-}
-
-static int enetc_imdio_create(struct enetc_pf *pf)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_mdio_priv *mdio_priv;
-	struct phylink_pcs *phylink_pcs;
-	struct mii_bus *bus;
-	int err;
-
-	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
-
-	bus->name = "Freescale ENETC internal MDIO Bus";
-	bus->read = enetc_mdio_read_c22;
-	bus->write = enetc_mdio_write_c22;
-	bus->read_c45 = enetc_mdio_read_c45;
-	bus->write_c45 = enetc_mdio_write_c45;
-	bus->parent = dev;
-	bus->phy_mask = ~0;
-	mdio_priv = bus->priv;
-	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
-
-	err = mdiobus_register(bus);
-	if (err) {
-		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
-		goto free_mdio_bus;
-	}
-
-	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
-	if (IS_ERR(phylink_pcs)) {
-		err = PTR_ERR(phylink_pcs);
-		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
-		goto unregister_mdiobus;
-	}
-
-	pf->imdio = bus;
-	pf->pcs = phylink_pcs;
-
-	return 0;
-
-unregister_mdiobus:
-	mdiobus_unregister(bus);
-free_mdio_bus:
-	mdiobus_free(bus);
-	return err;
-}
-
-static void enetc_imdio_remove(struct enetc_pf *pf)
-{
-	if (pf->pcs)
-		lynx_pcs_destroy(pf->pcs);
-	if (pf->imdio) {
-		mdiobus_unregister(pf->imdio);
-		mdiobus_free(pf->imdio);
-	}
-}
-
-static bool enetc_port_has_pcs(struct enetc_pf *pf)
-{
-	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
-		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
-}
-
-static int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
-{
-	struct device_node *mdio_np;
-	int err;
-
-	mdio_np = of_get_child_by_name(node, "mdio");
-	if (mdio_np) {
-		err = enetc_mdio_probe(pf, mdio_np);
-
-		of_node_put(mdio_np);
-		if (err)
-			return err;
-	}
-
-	if (enetc_port_has_pcs(pf)) {
-		err = enetc_imdio_create(pf);
-		if (err) {
-			enetc_mdio_remove(pf);
-			return err;
-		}
-	}
-
-	return 0;
-}
-
-static void enetc_mdiobus_destroy(struct enetc_pf *pf)
-{
-	enetc_mdio_remove(pf);
-	enetc_imdio_remove(pf);
-}
-
 static struct phylink_pcs *
 enetc_pl_mac_select_pcs(struct phylink_config *config, phy_interface_t iface)
 {
@@ -1101,47 +853,6 @@ static const struct phylink_mac_ops enetc_mac_phylink_ops = {
 	.mac_link_down = enetc_pl_mac_link_down,
 };
 
-static int enetc_phylink_create(struct enetc_ndev_priv *priv,
-				struct device_node *node)
-{
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct phylink *phylink;
-	int err;
-
-	pf->phylink_config.dev = &priv->ndev->dev;
-	pf->phylink_config.type = PHYLINK_NETDEV;
-	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
-
-	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_USXGMII,
-		  pf->phylink_config.supported_interfaces);
-	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
-
-	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
-				 pf->if_mode, &enetc_mac_phylink_ops);
-	if (IS_ERR(phylink)) {
-		err = PTR_ERR(phylink);
-		return err;
-	}
-
-	priv->phylink = phylink;
-
-	return 0;
-}
-
-static void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
-{
-	phylink_destroy(priv->phylink);
-}
-
 /* Initialize the entire shared memory for the flow steering entries
  * of this port (PF + VFs)
  */
@@ -1338,7 +1049,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_mdiobus_create;
 
-	err = enetc_phylink_create(priv, node);
+	err = enetc_phylink_create(priv, node, &enetc_mac_phylink_ops);
 	if (err)
 		goto err_phylink_create;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index c26bd66e4597..92a26b09cf57 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -58,3 +58,16 @@ struct enetc_pf {
 int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
+
+void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
+void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+				   const u8 *addr);
+int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
+int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
+void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
+			   const struct net_device_ops *ndev_ops);
+int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node);
+void enetc_mdiobus_destroy(struct enetc_pf *pf);
+int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
+			 const struct phylink_mac_ops *ops);
+void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
new file mode 100644
index 000000000000..be6aec19b1f3
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2024 NXP */
+#include <linux/fsl/enetc_mdio.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/pcs-lynx.h>
+
+#include "enetc_pf.h"
+
+int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct sockaddr *saddr = addr;
+
+	if (!is_valid_ether_addr(saddr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	eth_hw_addr_set(ndev, saddr->sa_data);
+	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
+
+	return 0;
+}
+
+static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
+				   int si)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_hw *hw = &pf->si->hw;
+	u8 mac_addr[ETH_ALEN] = { 0 };
+	int err;
+
+	/* (1) try to get the MAC address from the device tree */
+	if (np) {
+		err = of_get_mac_address(np, mac_addr);
+		if (err == -EPROBE_DEFER)
+			return err;
+	}
+
+	/* (2) bootloader supplied MAC address */
+	if (is_zero_ether_addr(mac_addr))
+		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
+
+	/* (3) choose a random one */
+	if (is_zero_ether_addr(mac_addr)) {
+		eth_random_addr(mac_addr);
+		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
+			 si, mac_addr);
+	}
+
+	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
+
+	return 0;
+}
+
+int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
+{
+	int err, i;
+
+	/* The PF might take its MAC from the device tree */
+	err = enetc_setup_mac_address(np, pf, 0);
+	if (err)
+		return err;
+
+	for (i = 0; i < pf->total_vfs; i++) {
+		err = enetc_setup_mac_address(NULL, pf, i + 1);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
+			   const struct net_device_ops *ndev_ops)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+
+	SET_NETDEV_DEV(ndev, &si->pdev->dev);
+	priv->ndev = ndev;
+	priv->si = si;
+	priv->dev = &si->pdev->dev;
+	si->ndev = ndev;
+
+	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
+	ndev->netdev_ops = ndev_ops;
+	enetc_set_ethtool_ops(ndev);
+	ndev->watchdog_timeo = 5 * HZ;
+	ndev->max_mtu = ENETC_MAX_MTU;
+
+	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
+			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
+			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
+			 NETIF_F_HW_VLAN_CTAG_TX |
+			 NETIF_F_HW_VLAN_CTAG_RX |
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
+			      NETIF_F_TSO | NETIF_F_TSO6;
+
+	if (si->num_rss)
+		ndev->hw_features |= NETIF_F_RXHASH;
+
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
+			     NETDEV_XDP_ACT_NDO_XMIT_SG;
+
+	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
+		priv->active_offloads |= ENETC_F_QCI;
+		ndev->features |= NETIF_F_HW_TC;
+		ndev->hw_features |= NETIF_F_HW_TC;
+	}
+
+	/* pick up primary MAC address from SI */
+	enetc_load_primary_mac_addr(&si->hw, ndev);
+}
+
+static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_mdio_priv *mdio_priv;
+	struct mii_bus *bus;
+	int err;
+
+	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "Freescale ENETC MDIO Bus";
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
+	bus->parent = dev;
+	mdio_priv = bus->priv;
+	mdio_priv->hw = &pf->si->hw;
+	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+
+	err = of_mdiobus_register(bus, np);
+	if (err)
+		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
+
+	pf->mdio = bus;
+
+	return 0;
+}
+
+static void enetc_mdio_remove(struct enetc_pf *pf)
+{
+	if (pf->mdio)
+		mdiobus_unregister(pf->mdio);
+}
+
+static int enetc_imdio_create(struct enetc_pf *pf)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_mdio_priv *mdio_priv;
+	struct phylink_pcs *phylink_pcs;
+	struct mii_bus *bus;
+	int err;
+
+	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "Freescale ENETC internal MDIO Bus";
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
+	bus->parent = dev;
+	bus->phy_mask = ~0;
+	mdio_priv = bus->priv;
+	mdio_priv->hw = &pf->si->hw;
+	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
+
+	err = mdiobus_register(bus);
+	if (err) {
+		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
+		goto free_mdio_bus;
+	}
+
+	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
+	if (IS_ERR(phylink_pcs)) {
+		err = PTR_ERR(phylink_pcs);
+		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
+		goto unregister_mdiobus;
+	}
+
+	pf->imdio = bus;
+	pf->pcs = phylink_pcs;
+
+	return 0;
+
+unregister_mdiobus:
+	mdiobus_unregister(bus);
+free_mdio_bus:
+	mdiobus_free(bus);
+	return err;
+}
+
+static void enetc_imdio_remove(struct enetc_pf *pf)
+{
+	if (pf->pcs)
+		lynx_pcs_destroy(pf->pcs);
+
+	if (pf->imdio) {
+		mdiobus_unregister(pf->imdio);
+		mdiobus_free(pf->imdio);
+	}
+}
+
+static bool enetc_port_has_pcs(struct enetc_pf *pf)
+{
+	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
+		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
+		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
+		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
+}
+
+int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
+{
+	struct device_node *mdio_np;
+	int err;
+
+	mdio_np = of_get_child_by_name(node, "mdio");
+	if (mdio_np) {
+		err = enetc_mdio_probe(pf, mdio_np);
+
+		of_node_put(mdio_np);
+		if (err)
+			return err;
+	}
+
+	if (enetc_port_has_pcs(pf)) {
+		err = enetc_imdio_create(pf);
+		if (err) {
+			enetc_mdio_remove(pf);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+void enetc_mdiobus_destroy(struct enetc_pf *pf)
+{
+	enetc_mdio_remove(pf);
+	enetc_imdio_remove(pf);
+}
+
+int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
+			 const struct phylink_mac_ops *ops)
+{
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct phylink *phylink;
+	int err;
+
+	pf->phylink_config.dev = &priv->ndev->dev;
+	pf->phylink_config.type = PHYLINK_NETDEV;
+	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
+
+	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_USXGMII,
+		  pf->phylink_config.supported_interfaces);
+	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
+
+	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
+				 pf->if_mode, ops);
+	if (IS_ERR(phylink)) {
+		err = PTR_ERR(phylink);
+		return err;
+	}
+
+	priv->phylink = phylink;
+
+	return 0;
+}
+
+void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
+{
+	phylink_destroy(priv->phylink);
+}
-- 
2.34.1


