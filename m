Return-Path: <linux-pci+bounces-14542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D0299EC30
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586002872D0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0212281D1;
	Tue, 15 Oct 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VMb0YAoc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083231EBA0A;
	Tue, 15 Oct 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998053; cv=fail; b=MWE78ckXdcMLqhWekUGcbBe/sn6XnV16yZFmf2l9yK9aSQUaOQqrvcYKktsyW7SPVAm9r90PXkpZK64XSQbz/T3bNGk65mctfgsIbnFW2aUTNbVDO6nsFiRigBM9VoEcq+YVlQWFxK2cAsNaags2r7lANvSYO9NVyztsOuoCO3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998053; c=relaxed/simple;
	bh=DXxE5sdv9kHRGjXKOaKSZU5gwo4AoPZZDDFXX5BcVSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XikuM6nvIFrGbJoVAsuJhqicg2fTjcovlZagQRxmuvtuqtyYIu2YqumkEcmjhhbiaaymkGZ+G4v38btayJGgJZg6QAX+3RCIw0x5ceQ1AeEZp55DziRsxl4Aiv7/0VRNyPjEu49EAFx8tPnuumV/k0g1/p9FldAb3D5JGzbnbNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VMb0YAoc; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvq1YS+lp+Rh+okzDUGsP4Zf0nZ1J5qkNdUkxjcVg4KZIDlerJdoTXQRKixBtmGz8Jl+9aqJagQfuJavNkxD9bPZAbLajILjSfhvNVd7eZPlmwCDNPzlk5FzUEeWJrxiFV4lqcPUrqNijLUagWLT55ixF5FGCsuzTKEHYwSaWfUnZ8rMMJTjBZxUTf0BV0V5wFjqH2u9XM21mPkMedi07a3K8hkkZol8uG2Z5R+J5ZyZtnVGQ3bx7FOhL3AOKC13zcq0UN1f9ufiX27/w9Wz3XEBMSkdZdC4z+JNVegHcpHxa+sQOoDPJu5x5v27qCxFPKGsckHjp9e6uyD4JHZpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzgW82gh+W7ywGDGYHLoWXNKz9H9Maz2cK013I48Ogs=;
 b=g4MI9vpyTjeKv2bqjn7KyLeC+JW145F+5iqXe2xKOsN2eDOAz94mlh4p07x9j/yFTajiytLHKu3djDFM1gFpCtQWe+yHWuWpVhN2bE00VTWBjC5xP6Ht4QbroAvXxjNlVy4dGGpuqR65sMhi+/C7b9u2EOtxV8aO+h8HVW0f8Jr768hKWH+ca5StYkb/CNpMV2Or3GYT5FGH+xLHvJWldbCSqqpEQXzXK/YvEO41yQrhmhoOXJHO52Rs5YMVJ+4QK5XPISiga2UTLfZC3z3pALS71qqIIXeP61ieRIy/T8SEQW0eGDG1Xlqerm/zZpAMNFLbAOdJXMXStRhvU/Z8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzgW82gh+W7ywGDGYHLoWXNKz9H9Maz2cK013I48Ogs=;
 b=VMb0YAoc3pEabL5LXyEoVZoWA+4Kg2L+vCHlIMEUqlxZG/L0mxLYb9bIS/TZ6TDfPPiZz+Xqrb3vKpBAj8opI8VWDYNf/WgwMksZLY7R95Dr4whGeV2ZyML5AGIUQImlnGWqMxb3dOF5YxBUfXVGLQfa41OMfN8HrmTmBK1CSelEJOw8BtwK8PrShUMuBm+4JwtjTzX48gklf7gOqGZ4nml+aZSOTEjSlQsUex+QTtLwutmn6UYzrkkIoo+KdknWWpx41yfWSOoHq7asAKsyI6r9ib0Sdim60BYTimtVihYqp4EI1+6hoPlJvAABCLuNqQ/91HolRIfqTNLaCqTNLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11041.eurprd04.prod.outlook.com (2603:10a6:150:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:14:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:14:07 +0000
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
Subject: [PATCH v2 net-next 06/13] net: enetc: build enetc_pf_common.c as a separate module
Date: Tue, 15 Oct 2024 20:58:34 +0800
Message-Id: <20241015125841.1075560-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf43f6b5-d4e1-40bf-ad93-08dced1b3fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X6yCSZQlGrcKCe0cLiqfC8KaBW9E8I0saZ56xIPNAfbuCtDCtLwdRzvvRZwg?=
 =?us-ascii?Q?1dHGC+KNBFEmBJWVzwTeYaOsEZhDwQr5jQufxSaMXMvpCHNTaELFRuw/L8WV?=
 =?us-ascii?Q?gwX11PjPzTgMdd6ZJKDOxvnseyA+WHAcvYtvdcWt94F8C1RAM359/CYvjz90?=
 =?us-ascii?Q?dn9rSzQlWupYvLl5tUCx3w4pZFE0x1H+nFFOwz6o7x0pc7/DC5zd6wQLR5MY?=
 =?us-ascii?Q?gl4yap21Tgm05glC1NcIJr5pkC4p3t5XIwLXPKNFoUEm1Mm0z/Pd5vAxfLGm?=
 =?us-ascii?Q?PU7vP4mcmAHcRe4hZ4/RlxxoJ/DxK6Wkjc3DnN40UHzdM54n3Lq4cutGTWrk?=
 =?us-ascii?Q?BvXLGqFI0LYFGUCTEQx+Petzv1ch4YbPtSwBQ3EtsQJtJqeRwxgg3RO11Yrx?=
 =?us-ascii?Q?i+7nXrTTGZ+rf7mEIlXFb6lZxeRRfaHmL3XV+SSjMQxjphLn+v6oci9VKAWj?=
 =?us-ascii?Q?IGxH9xpUG6Oe7PJiEpsn+pDVdwY2QE23wYsdfXwoYON5PMNQygtcdme1/WDi?=
 =?us-ascii?Q?teJUQj2f6BWCNzY+ieKFkLro/9XFozvn7D2eLVGfB4aGyGMi3h3BivUy8EFg?=
 =?us-ascii?Q?LkphL904sAo0TG3KAbGKPRfSLkBxYF1XeDncAy0G6Im+DREOp90iUwBNsS6N?=
 =?us-ascii?Q?PkSZhYV3WU70Bzt1OeI1BmxfkymrBT7e5I70/4FOcxdcHkJ8ZV4ny7ZohU6U?=
 =?us-ascii?Q?QoW9uu+etruIM9TN1hz9kzaRuR9A8oS+tr+O+Ihx1DnX2bdnQBH4mchmQ7bN?=
 =?us-ascii?Q?yzteQhunlK9U0K2a6vt7kGbDguTxud+aaaiLTLvG0ZSCjVYDyEWkrEKa1e90?=
 =?us-ascii?Q?gpsyu+y5lcon/KbqnG3Al68jNObnprGWeWaVRKMdkdxGIYFNEzOxi8YRBm6J?=
 =?us-ascii?Q?sKjB7XeyRGoz5PVY10IuJkzAfeOshv5ymxlmIkFWRmvL5tMAB0HFCdvLV/VY?=
 =?us-ascii?Q?DDjRZ5FF3E3g6uBTioDeaVFSD551GM5x1YdiNRaQJxOoHGxrmg2J1MQDDad7?=
 =?us-ascii?Q?2k5wL8Lj75+akJ/wq4D+5mlRqWQayKsktr2vBA/ZDus91Zek3zzLpcQ+lAiN?=
 =?us-ascii?Q?wdm1dv6Hh7NgaIs//MLq5M30HM0TyQUuzIWvR4cZJt4AMh3KcbOdl+b2Oi/M?=
 =?us-ascii?Q?kp5av2Tfz06Zsf0YxOjZ/UWuAzlmF/KwstEvOZXM17iHr31vPSmHW3QX6E82?=
 =?us-ascii?Q?XW2nnAuq18sTNOuDzsCRDI1j4/L0uf+okbmrNb7Gp5Srh52aFZ4zuxk/RyuA?=
 =?us-ascii?Q?ITbSRJcq0T5CZVoa2x/mu3vtK9+KJwRsqtiTvq0TKJnKaZKJrrOd+pYpSop5?=
 =?us-ascii?Q?XcfdCZ+yf+ZM+2Be8yPuPfpjhD225HSzZUkr9zezQwaQcT7UUluxBVlpK+Br?=
 =?us-ascii?Q?HLp4+Ps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QcybJ0r/P9mExUK5M7UrzIgNnTtqGFeExl0FYmRejRa77+7Myl5vRf2BJnYE?=
 =?us-ascii?Q?TZWku21YIH4elgitKq0mP4zyfNNuRnTfG/ktY91+X6kFU5ZO57uUHcQtO5xk?=
 =?us-ascii?Q?WKtccBxvKZHNEDrHZs6WG2bHhQpJOR1Z9fLcHit0lXZeqrZXtGmv1iX0RcJw?=
 =?us-ascii?Q?gJpIU2nK43bY5pcLMl/qqzjbxuqvVmevJlOfyZXWOF6i0D6PsfVpOR8jeH8F?=
 =?us-ascii?Q?OuEAkQZC+9lQqX0A8ZfqBBovcHpl32Byb6ruYHJ6kKWJA8xgINB465oIs6bN?=
 =?us-ascii?Q?cK3MbkWqT5g+SSzw+9ET1cicIpcNaQiiaxAXixeu47S1a/IYgo0tsT7Wmak1?=
 =?us-ascii?Q?QbvPzv9ZS1NstMUvdISUA+07Rb1pwxt+YBeEPuPwp9fapeJgMnfH6NPgQMbn?=
 =?us-ascii?Q?x+5wlqvtT37l/PKdOQCvW3xWTIzvJg62SWtDQEYevZjAAxcJ12vz0f7vODED?=
 =?us-ascii?Q?YlV25GbhrLLkmMgFrL2CDH3cF09pIjUB31lPCJvI4OVGUhjMKKQCUpn0uPFe?=
 =?us-ascii?Q?XB7CLxw9WMJbUDSQ7q9jRNhcBgrps5dz5xn7LoafKmzcbFc3WLyD55GyFzef?=
 =?us-ascii?Q?qn1Rhn3VEy+mJwd/2z3j980l2BX87VB8uDYcKW3ZK5H0iX3yfWJJuA3ZyIij?=
 =?us-ascii?Q?NVGfEiPPKQ1sJwMA9xS4xyUdLdYnZsxd01kYXgfkNVvk/RMV7XtS5Yt0dhb7?=
 =?us-ascii?Q?GAaJ9TDt+pujipTurLet2FMHZFVsx2hbmDiQWZA2PIYswl9jY8NbN39/6BYx?=
 =?us-ascii?Q?qT6fgDOJ5XrJMvGjqZsxvpkxRosiGN6+rztm1LAf+4HycCcpMBopYX5LYbLv?=
 =?us-ascii?Q?sR9bm/ZRXnKLJ0BxtGkSJtjEuSVQfi2jrfo04wTrL/NxTzszUiCEkDBLj6fa?=
 =?us-ascii?Q?Z4Sq3EVtDMwX1ubCFzLta97RHArWWNvPTkwJNk5vIhvQ/er4rn2NTXpCqUMa?=
 =?us-ascii?Q?76oP6aJJpVt5me/zExgCANXnZV33BbFd36ChDr07zrfG2GouvjRYKSiE6pRe?=
 =?us-ascii?Q?XoTZGBHSUMo51DfAq/eDltmJtK8jRggpFb+6whrX1uZwndxJ4tEKSbrWKBs2?=
 =?us-ascii?Q?Df2dSvG3xAUjeMZkmpvbrV3ZDQlBzzPFbaU38fe3YcMEHgD3PMx4TY31Fa+r?=
 =?us-ascii?Q?+uaGQ6ewCpxwW8wTxbTvAE7x922tqXVTjbXsyVhun6232GVluOCpNO4ob4jt?=
 =?us-ascii?Q?j6tMXXG69ZO45sxvicyu+Ln7K12rRvefYAjHD23mEFGOIHVX1GphXUllMvlQ?=
 =?us-ascii?Q?vUBm/16OGUSvG9/goQl0/P6DBUuOvSB8BIWsqyOvf0oubqhozNsBPMHeE+Cy?=
 =?us-ascii?Q?uQOL3Dcy44+y8ZCW/QN5Iv1Sc4N1Xf9MsFCa5kUKsV0fC+0G25EJo4cksUYR?=
 =?us-ascii?Q?hDhp4N3H07w+xMNTXxsoSEwKlTjOkiahbyR6FcMuLfshmjTVC1tn2yPHmlq/?=
 =?us-ascii?Q?iwti3gCfSfBckgkERKyFNcJBgESyzM+3zoOXIaHRXrK3z/2gWnVxlXW4hFXI?=
 =?us-ascii?Q?taQGv3yqdygscKvEaThDHUO0PYmfB383M5glGKaT+qDSNjqkvhO3xXCXm6Q7?=
 =?us-ascii?Q?1usXMLc4iFRjc/hRzZb9Zs168WS5CHKNzzJtAQGv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf43f6b5-d4e1-40bf-ad93-08dced1b3fc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:14:07.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6a/gad2EuaWXL0k/V5eEXY0EfiJVGg5cAvXJTPXXNOVekWteZU8UPUn4K2C0O+Sikg5pYGOqQtK/r9MsNOw+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11041

enetc_pf_common.c provides the common interfaces for the PF drivers of
ENETC v1 and v4. So it's better to make enetc_pf_common.c as a separate
module in order to prepare to add support for ENETC v4 PF driver in
subsequent patches.

Because the ENETC of the two versions is different, so some hardware
operations involved in these common interfaces will also be different,
Therefore, struct enetc_pf_ops is added to register different hardware
operation interfaces for both ENETC v1 and v4 PF drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-common
driver support"), only the changes to compile enetc_pf_common.c into a
separated driver are kept.
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  9 ++++
 drivers/net/ethernet/freescale/enetc/Makefile |  5 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 26 ++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf.h   | 21 ++++++--
 .../freescale/enetc/enetc_pf_common.c         | 50 ++++++++++++++++---
 5 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 51d80ea959d4..fdd3ecbd1dbf 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -7,6 +7,14 @@ config FSL_ENETC_CORE
 
 	  If compiled as module (M), the module name is fsl-enetc-core.
 
+config NXP_ENETC_PF_COMMON
+	tristate "ENETC PF common functionality driver"
+	help
+	  This module supports common functionality between drivers of
+	  different versions of NXP ENETC PF controllers.
+
+	  If compiled as module (M), the module name is nxp-enetc-pf-common.
+
 config FSL_ENETC
 	tristate "ENETC PF driver"
 	depends on PCI_MSI
@@ -14,6 +22,7 @@ config FSL_ENETC
 	select FSL_ENETC_CORE
 	select FSL_ENETC_IERB
 	select FSL_ENETC_MDIO
+	select NXP_ENETC_PF_COMMON
 	select PHYLINK
 	select PCS_LYNX
 	select DIMLIB
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 39675e9ff39d..b81ca462e358 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -3,8 +3,11 @@
 obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
 fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
 
+obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
+nxp-enetc-pf-common-y := enetc_pf_common.o
+
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
-fsl-enetc-y := enetc_pf.o enetc_pf_common.o
+fsl-enetc-y := enetc_pf.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 3cdd149056f9..7522316ddfea 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -11,7 +11,7 @@
 
 #define ENETC_DRV_NAME_STR "ENETC PF driver"
 
-void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
+static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 {
 	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
 	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
@@ -20,8 +20,8 @@ void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 	put_unaligned_le16(lower, addr + 4);
 }
 
-void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-				   const u8 *addr)
+static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+					  const u8 *addr)
 {
 	u32 upper = get_unaligned_le32(addr);
 	u16 lower = get_unaligned_le16(addr + 4);
@@ -30,6 +30,17 @@ void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
 	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
 }
 
+static struct phylink_pcs *enetc_pf_create_pcs(struct enetc_pf *pf,
+					       struct mii_bus *bus)
+{
+	return lynx_pcs_create_mdiodev(bus, 0);
+}
+
+static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
+{
+	lynx_pcs_destroy(pcs);
+}
+
 static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
 {
 	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
@@ -970,6 +981,14 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
 	enetc_pci_remove(pdev);
 }
 
+static const struct enetc_pf_ops enetc_pf_ops = {
+	.set_si_primary_mac = enetc_pf_set_primary_mac_addr,
+	.get_si_primary_mac = enetc_pf_get_primary_mac_addr,
+	.create_pcs = enetc_pf_create_pcs,
+	.destroy_pcs = enetc_pf_destroy_pcs,
+	.enable_psfp = enetc_psfp_enable,
+};
+
 static int enetc_pf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -997,6 +1016,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	pf = enetc_si_priv(si);
 	pf->si = si;
 	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
+	enetc_pf_ops_register(pf, &enetc_pf_ops);
 
 	err = enetc_setup_mac_addresses(node, pf);
 	if (err)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 92a26b09cf57..39db9d5c2e50 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -28,6 +28,16 @@ struct enetc_vf_state {
 	enum enetc_vf_flags flags;
 };
 
+struct enetc_pf;
+
+struct enetc_pf_ops {
+	void (*set_si_primary_mac)(struct enetc_hw *hw, int si, const u8 *addr);
+	void (*get_si_primary_mac)(struct enetc_hw *hw, int si, u8 *addr);
+	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
+	void (*destroy_pcs)(struct phylink_pcs *pcs);
+	int (*enable_psfp)(struct enetc_ndev_priv *priv);
+};
+
 struct enetc_pf {
 	struct enetc_si *si;
 	int num_vfs; /* number of active VFs, after sriov_init */
@@ -50,6 +60,8 @@ struct enetc_pf {
 
 	phy_interface_t if_mode;
 	struct phylink_config phylink_config;
+
+	const struct enetc_pf_ops *ops;
 };
 
 #define phylink_to_enetc_pf(config) \
@@ -59,9 +71,6 @@ int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
 
-void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
-void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-				   const u8 *addr);
 int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
 int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
@@ -71,3 +80,9 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf);
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops);
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
+
+static inline void enetc_pf_ops_register(struct enetc_pf *pf,
+					 const struct enetc_pf_ops *ops)
+{
+	pf->ops = ops;
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index be6aec19b1f3..2c6ce887f583 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -7,19 +7,37 @@
 
 #include "enetc_pf.h"
 
+static int enetc_set_si_hw_addr(struct enetc_pf *pf, int si, u8 *mac_addr)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+
+	if (pf->ops->set_si_primary_mac)
+		pf->ops->set_si_primary_mac(hw, si, mac_addr);
+	else
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct sockaddr *saddr = addr;
+	int err;
 
 	if (!is_valid_ether_addr(saddr->sa_data))
 		return -EADDRNOTAVAIL;
 
+	err = enetc_set_si_hw_addr(pf, 0, saddr->sa_data);
+	if (err)
+		return err;
+
 	eth_hw_addr_set(ndev, saddr->sa_data);
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_pf_set_mac_addr);
 
 static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 				   int si)
@@ -37,8 +55,8 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 	}
 
 	/* (2) bootloader supplied MAC address */
-	if (is_zero_ether_addr(mac_addr))
-		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
+	if (is_zero_ether_addr(mac_addr) && pf->ops->get_si_primary_mac)
+		pf->ops->get_si_primary_mac(hw, si, mac_addr);
 
 	/* (3) choose a random one */
 	if (is_zero_ether_addr(mac_addr)) {
@@ -47,7 +65,9 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 			 si, mac_addr);
 	}
 
-	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
+	err = enetc_set_si_hw_addr(pf, si, mac_addr);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -69,11 +89,13 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
 
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(si);
 
 	SET_NETDEV_DEV(ndev, &si->pdev->dev);
 	priv->ndev = ndev;
@@ -106,7 +128,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
 			     NETDEV_XDP_ACT_NDO_XMIT_SG;
 
-	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
+	if (si->hw_features & ENETC_SI_F_PSFP && pf->ops->enable_psfp &&
+	    !pf->ops->enable_psfp(priv)) {
 		priv->active_offloads |= ENETC_F_QCI;
 		ndev->features |= NETIF_F_HW_TC;
 		ndev->hw_features |= NETIF_F_HW_TC;
@@ -115,6 +138,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
+EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
 
 static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 {
@@ -161,6 +185,9 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 	struct mii_bus *bus;
 	int err;
 
+	if (!pf->ops->create_pcs)
+		return -EOPNOTSUPP;
+
 	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
 	if (!bus)
 		return -ENOMEM;
@@ -183,7 +210,7 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 		goto free_mdio_bus;
 	}
 
-	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
+	phylink_pcs = pf->ops->create_pcs(pf, bus);
 	if (IS_ERR(phylink_pcs)) {
 		err = PTR_ERR(phylink_pcs);
 		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
@@ -204,8 +231,8 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 
 static void enetc_imdio_remove(struct enetc_pf *pf)
 {
-	if (pf->pcs)
-		lynx_pcs_destroy(pf->pcs);
+	if (pf->pcs && pf->ops->destroy_pcs)
+		pf->ops->destroy_pcs(pf->pcs);
 
 	if (pf->imdio) {
 		mdiobus_unregister(pf->imdio);
@@ -245,12 +272,14 @@ int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_mdiobus_create);
 
 void enetc_mdiobus_destroy(struct enetc_pf *pf)
 {
 	enetc_mdio_remove(pf);
 	enetc_imdio_remove(pf);
 }
+EXPORT_SYMBOL_GPL(enetc_mdiobus_destroy);
 
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops)
@@ -287,8 +316,13 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_phylink_create);
 
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
 {
 	phylink_destroy(priv->phylink);
 }
+EXPORT_SYMBOL_GPL(enetc_phylink_destroy);
+
+MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


