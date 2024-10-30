Return-Path: <linux-pci+bounces-15576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9F9B5F75
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715AAB224C9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27F61E3776;
	Wed, 30 Oct 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mFbldHw+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644FF1E882E;
	Wed, 30 Oct 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282131; cv=fail; b=QOP0936F4bFkAHnxzkF2MAmOFafTChmdtW3wBfvIwd+pnzglua94Hq8XT/vfdb4XENaCsgBbN1HE4syE0pfObf9GYKVo3H81MfjVG/VwsaX+vIMSYK7vmsoo905xA2mRBoghJfsoyjcBBkoossVzDFX3apgxvr3xaErO6Ie8bUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282131; c=relaxed/simple;
	bh=LoUsaxQvi5J2FenkG0OgttwaDu0kjbKp1DRV2sJvJZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aIek+B4Cq6oHoBFHd0ufL/Ov1+XYsI82yK2TzHAcrKf9jk3AbzxLudidct/4mk2GdzTlpHFG5PhjujlnFV6OW9gsECG3MQ7eq9E4xLulI/cZ8n7Pa/MReGkm6MEep5aOjkH5dNqu4hykPdYiJgnueh3KZx31Ne7xf7IwPwyNtaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mFbldHw+; arc=fail smtp.client-ip=40.107.247.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pk6yQc1NHW2Ru+6OCKtXxN4o4jeDefvcBoQkNmF3r0Zhg7f4do213cY1Dbe+fF6xwdO3YGlkBMnWv+xpGPk0dkwd82vh0xyTJIaLw8LAd9mbfadid/iM60A75rjtYs20srQrBleu0BTPw/SqDiSpIFU3vx5Qolx8YT0yQWhZuO5C0QnedYP+mIAaCn6tgWmDOBUMKteNk+viystBVRXQ+2lHB1p9qy/khQgEymK73MnGCYsDXfZ9sPH+9zOjTBvXwoF3qYiO7N2Yn+pvNGnVXrynGdlnE0bjxosCYYVz5F43K3a2VuU+9CL7CpB6TWypu34N7eu/ZCwt6cFEE8DCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qGdonxkWsA0PHrlZn2YAzdO0pw9VKF0Ky5FzaXdeNQ=;
 b=fF6IxnIghux+x1nVfyQzLGtRPTFWUPRAx5cImSzTCsOr8aWkqSXwxITFrNZxEvHwWJo9VF1zZ1GIA0G6RLNsYKJpPpDQgb2LJY4tlXQlVWJZKy1cj5zrnCrwUEVp4gHvo5p9kDyRr2gjl06Ev0Zb5YRdgUIP2jKuFxdQrqrAYeRA/l+BO/VpdemATE9xysLzptvrGLBXYS2VIvbqidZxs5KZw3BLqXrLCSF9VZbb2Kpp9USvgbOnOZxSYquy+mSMmjSrDmxK7Exx03Pe8DOsHNtTtoLF0EDgbz6Mwwj5g3DTWy3Lbzwm5vmR96UEMbX7zHbzUPkCdCcgB2X3tpM51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qGdonxkWsA0PHrlZn2YAzdO0pw9VKF0Ky5FzaXdeNQ=;
 b=mFbldHw+tYgVSjEO2XNoBx959OxQ9jKXKgL2Fu6wqNuNwYpATIJZwbCmeyBKWgM8PQq8fGErqtCWiEep+ZKiMyey9DLMxEhK5jKUnsEwwOTNSPYnROysnP88Aomec8LnZfn2NQhGfxZ1W7m5cYYCjwLtnOzBPmLF6jbTmoyp8I2yJxSSnhog5dbPlJWb89kFx3dmpz81PZT4XKEk00YGM71FuzA1e9fArvreJ4j27/fWcry12YL/suqjpZqMu8RAUPUNSHQwJVbodYyAH+qRK5tNvJSMzVuBi1lgl0CltBuBwp6FwagWyoIeoAkk3AGD2w4l80C2SpmDj3e7ELtnOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10347.eurprd04.prod.outlook.com (2603:10a6:102:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 09:55:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:55:25 +0000
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
Subject: [PATCH v6 net-next 07/12] net: enetc: remove ERR050089 workaround for i.MX95
Date: Wed, 30 Oct 2024 17:39:18 +0800
Message-Id: <20241030093924.1251343-8-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: d03f02bc-2390-4b65-b173-08dcf8c8fa4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l7kwhRFcLU6xc0clJHUHSG6vsoc3BoKxlYQavQgnedJXwWG/Q6roq80qRvlf?=
 =?us-ascii?Q?7oJ1SGe1flS2f/uxGcNdl5IatP8e2VMv/xnG8+8EHDkUo2kPezd+pB7paBtC?=
 =?us-ascii?Q?6H6BMKu37eEw9A6h9maj45ezR7pPpAiUj9u3TsjdW4qihmHseyxdqYs9Nq4G?=
 =?us-ascii?Q?KxTACwnubOWLhenZ/ZNaJu/bqkUxNS1zNDjrKmS4iglSdQZttcANR1eIqbJk?=
 =?us-ascii?Q?QkRfOX4pssMPymb3KEBQDR0Q3p9G9b4zHwn4XqV35LHUsBE4mfgMmh9wKH0k?=
 =?us-ascii?Q?D9PnpEiiY7GxhHFhpVj6qszwUN0aWZI2Ju2j6LV7Xz+upn3pjfKBAjln3i1j?=
 =?us-ascii?Q?oy5RzA4SdjxHacuXko1wJk7rU7OknUyXX3FKT51+fcjNnGZgOGgBu0DWpRlD?=
 =?us-ascii?Q?hzmNCXAjoWbKGHVD7+hUj/H1Mly5a8BoBbzz5tELexn8GyJd/e7DkIuY9Myw?=
 =?us-ascii?Q?UaNRIVZ/RyWNVFDd4nnjRSH3sU9R2jMSYlaFcqnzmRzaOSd21nTJI9B+kwxS?=
 =?us-ascii?Q?Iss1aPeOAh/NpKCeQtvn+EshzhpoTZErqyNkWUrOU95LTG8axm1l3hPbwj1F?=
 =?us-ascii?Q?F3ivE9s/+hTsKkrliQig6E4AxCBHOQWgcBz2YI+ni3vGrSyBfObUP6d4HNty?=
 =?us-ascii?Q?z3XceZpzeSk+c+YcL55ZhWqniN2e9uNyXsp5BE6LnpMFwNyVnoGjHigd0yYL?=
 =?us-ascii?Q?nmsjgtVU0t3xHP7c8azL3aZLM/KmO6h9cNP2pi0yQMevjGcSLwZ/yW4C3d6B?=
 =?us-ascii?Q?dV2lpmF1BPhcBqEKfKAtihfdR6t5DncWh9b49QQ0uEQ46IFJG/dhHr2PR0M6?=
 =?us-ascii?Q?JozVinDonCSISf0hlST3ZrT4ql/DUJOk7RdGX669CVy72o10NSrS2RyedCir?=
 =?us-ascii?Q?95Vupzoa51ND/W4bGBmYzWAHqhL1+HVA/E1dqcBfy7Fb3XTKlB6DDgdaxExT?=
 =?us-ascii?Q?LxNpaNUn1d9/SsPG+gmsVsMMlxdlwvXLCzus2rmKS3wuMzsB9ai4tM2gmCs0?=
 =?us-ascii?Q?rxsx9TmPaHRHWQGgvi7c0Kuy1buFXGh6rYxT+SLFTKPvWapO0NB7AAVTHr68?=
 =?us-ascii?Q?cewQZfIGeKWFS5ly8JzXCtsRsRgY+XnZBaCGZVPHbtxIbH09tmqYV4rSSTYY?=
 =?us-ascii?Q?czZMrELSZx4U0zCDmPEZ9kQOnoHNQpkso0HmXMmIdeMe3gR5VFbDyZdAgJli?=
 =?us-ascii?Q?BaRvGg3C0/TV+I3yW+IgSwNDBrZ6HfV9NZc0G0lhuEitZAMra4XZ8idw/udw?=
 =?us-ascii?Q?Sju5UCqpDwwkY1iMaoQubWNVxUsMFmFX4rbKTOnul2L54jtI/NEh+koIPO5K?=
 =?us-ascii?Q?jmZHIwk38pWTPwHup4q9FioJG+My0MET9idJ/NAxPkklvLIWuVwDQFDHMSoJ?=
 =?us-ascii?Q?UDIzlmBCADUb6xvlm3mb5VlE6x1J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1NHb9UVewLxIq2lHqtfr80ZI7xZT8lISNXDKcdr4MsjuRTpDlxXo0lQ5O+Qz?=
 =?us-ascii?Q?1aZqeDPM3JO0MF4G2AaAN9zDZRO3QjMikvfScE5FBBc5qqUk2AFb3KfACaCo?=
 =?us-ascii?Q?qsUFHcoe55uSQo15gUUKHLwgluDqD+p4C1bC+iTWePfhxcbOPnsEXBZoAIsg?=
 =?us-ascii?Q?Re0JF1lQ+ijb3qKzH2KlR3OZTtyqiY+fWtoTUgHppIzvPc34xSIT5vpBgb73?=
 =?us-ascii?Q?UlobM+M6neRR8ykhy388dviToMDa1enVKMkAT3KLXUPFYXYAs6z3q58jQqOn?=
 =?us-ascii?Q?mCCQgO+x3hePtv5uLsWeaHbRKWOmrkq1bhSJXgyHiqvZnOLsfInATI5Jkgry?=
 =?us-ascii?Q?zXX1T8OqCfJ0bXKRGxv0HUk134BbKmJ509gW7C8420RmmPB1wXp1RH3q9HHm?=
 =?us-ascii?Q?qF8utaz04fgRDw3XlGV0t47kcBnRwvl5YH2ULTWXEnEBVRpKFdxz9TFtA6NK?=
 =?us-ascii?Q?1aFqGuFDEPwzU7vlHDOxW3GIlBVNqxvnHgIt6CVHlFF14E2QTlMPY9BDVFRs?=
 =?us-ascii?Q?cnv9V7LEvh85sGzBgpELpqWwergJWRn7pvTcwvkktad++rRgjUaPv1HbWNWB?=
 =?us-ascii?Q?0i1IZCw4+TT3o56zw6R8yJK0QzybrDUCEGTcdh87EeIP5XizKxMusr9G58mL?=
 =?us-ascii?Q?OEI2p4szrDdenEYp5AH5jNEg4k0OEeGUEQlLbumw11+qZdn0h6PD68tOOBTB?=
 =?us-ascii?Q?F/5s4C+fXyeVIHVggf74yxlxNTOKJVWQyc8myMZU5DMbWib2W07QoPJkTpuL?=
 =?us-ascii?Q?BB5j5gFCDABiRW1aj9vb+eOnLWN9SDIM1wiCQ4a4AojpAueUYCc8Vg6HfOIN?=
 =?us-ascii?Q?Lf3nfsiEjJrnQ8fPLWzwcxjiZT+fAZsmygj17mgaRdVqlm7+wuSGz35r5Jng?=
 =?us-ascii?Q?0rzjkeuzAX19fiWtMWzUBvg7s8rMoffFEY49oTT1gF4aeSGm1K0iopWGop9T?=
 =?us-ascii?Q?98qHEwz3i2+tg/NtQJpxxCoz4zQB8lvQ6tHDohYWAK1khoe4PgsHf6N9Gd1A?=
 =?us-ascii?Q?kXjnaxekHpA0ENs1GKE0LQj9FaBsCtOhCAxkBu8TRuR64nepJQlTsfvCnVoz?=
 =?us-ascii?Q?KpRlyFfobzw0jR2B8jzjzUPWJI3ON1l2e4KNbX+6DQz0byCq3Ssz+CRMc4wP?=
 =?us-ascii?Q?P3FAEnmWO6oNqarCKeE4Z9AT4Nov+z9tbd3n/O8MXLxaecdwFp+CGTCte9Ys?=
 =?us-ascii?Q?7O8zTiq+qTXrKmHPUgDybQkbrYSOEQrevkqd0BLJahSWN+9vM6PMd7/Q7khM?=
 =?us-ascii?Q?LkJ3+AlRr73rlW6+G7rxXHe+HH1ZlOQ+qpd9qeL58wRLhHuV3GVxWeeFiKaD?=
 =?us-ascii?Q?h6dPbtLf361F2s50w04juZiK2PMTHOCEnwWdoNItKbpcWUWdtKmgTXqMAoL9?=
 =?us-ascii?Q?dDvZygBAgRWcweStMz6j6z4ZLmwj6whi+qOu5h3a8wU/5eIsr9CDJMhQlNsw?=
 =?us-ascii?Q?4EQ+UQ31HbE2pMyL8HnDO8PwTeIrJOD35AR0FDDNGk17t59Vbyr70Y5FvzkU?=
 =?us-ascii?Q?hHpd1EXJ83Vlpr8v4Mt0dHKnvSeNcr73i7H673rPk8Nguw0r6Ds+beABzLS8?=
 =?us-ascii?Q?G4pQNiHL+X8Qc5/pt8Pq8GgEKoCNs4vbjB2aQueD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03f02bc-2390-4b65-b173-08dcf8c8fa4b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:55:25.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZY0pv/rcJkCUpXLCIRPIUE7aAHwK0l8Zx6Itch/t84HYCU8IfpupXaUzPLfMzumELsRrAbokkYmuOlz0aaT/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10347

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The ERR050089 workaround causes performance degradation and potential
functional issues (e.g., RCU stalls) under certain workloads. Since
new SoCs like i.MX95 do not require this workaround, use a static key
to compile out enetc_lock_mdio() and enetc_unlock_mdio() at runtime,
improving performance and avoiding unnecessary logic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v6:
1. add helper functions to enable/disable the static key
2. disable the static key if of_mdiobus_register() returns error
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 34 +++++++++++++------
 .../ethernet/freescale/enetc/enetc_pci_mdio.c | 28 +++++++++++++++
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 1619943fb263..6a7b9b75d660 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -396,18 +396,22 @@ struct enetc_hw {
  */
 extern rwlock_t enetc_mdio_lock;
 
+DECLARE_STATIC_KEY_FALSE(enetc_has_err050089);
+
 /* use this locking primitive only on the fast datapath to
  * group together multiple non-MDIO register accesses to
  * minimize the overhead of the lock
  */
 static inline void enetc_lock_mdio(void)
 {
-	read_lock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_lock(&enetc_mdio_lock);
 }
 
 static inline void enetc_unlock_mdio(void)
 {
-	read_unlock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_unlock(&enetc_mdio_lock);
 }
 
 /* use these accessors only on the fast datapath under
@@ -416,14 +420,16 @@ static inline void enetc_unlock_mdio(void)
  */
 static inline u32 enetc_rd_reg_hot(void __iomem *reg)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	return ioread32(reg);
 }
 
 static inline void enetc_wr_reg_hot(void __iomem *reg, u32 val)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	iowrite32(val, reg);
 }
@@ -452,9 +458,13 @@ static inline u32 _enetc_rd_mdio_reg_wa(void __iomem *reg)
 	unsigned long flags;
 	u32 val;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	val = ioread32(reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		val = ioread32(reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		val = ioread32(reg);
+	}
 
 	return val;
 }
@@ -463,9 +473,13 @@ static inline void _enetc_wr_mdio_reg_wa(void __iomem *reg, u32 val)
 {
 	unsigned long flags;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	iowrite32(val, reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		iowrite32(val, reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		iowrite32(val, reg);
+	}
 }
 
 #ifdef ioread64
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index a1b595bd7993..e178cd9375a1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -9,6 +9,28 @@
 #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
 #define ENETC_MDIO_DRV_NAME	ENETC_MDIO_DEV_NAME " driver"
 
+DEFINE_STATIC_KEY_FALSE(enetc_has_err050089);
+EXPORT_SYMBOL_GPL(enetc_has_err050089);
+
+static void enetc_emdio_enable_err050089(struct pci_dev *pdev)
+{
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_inc(&enetc_has_err050089);
+		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
+	}
+}
+
+static void enetc_emdio_disable_err050089(struct pci_dev *pdev)
+{
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_dec(&enetc_has_err050089);
+		if (!static_key_enabled(&enetc_has_err050089.key))
+			dev_info(&pdev->dev, "Disabled ERR050089 workaround\n");
+	}
+}
+
 static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
@@ -62,6 +84,8 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 		goto err_pci_mem_reg;
 	}
 
+	enetc_emdio_enable_err050089(pdev);
+
 	err = of_mdiobus_register(bus, dev->of_node);
 	if (err)
 		goto err_mdiobus_reg;
@@ -71,6 +95,7 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 	return 0;
 
 err_mdiobus_reg:
+	enetc_emdio_disable_err050089(pdev);
 	pci_release_region(pdev, 0);
 err_pci_mem_reg:
 	pci_disable_device(pdev);
@@ -88,6 +113,9 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 	struct enetc_mdio_priv *mdio_priv;
 
 	mdiobus_unregister(bus);
+
+	enetc_emdio_disable_err050089(pdev);
+
 	mdio_priv = bus->priv;
 	iounmap(mdio_priv->hw->port);
 	pci_release_region(pdev, 0);
-- 
2.34.1


