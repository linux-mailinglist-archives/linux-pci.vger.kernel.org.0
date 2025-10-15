Return-Path: <linux-pci+bounces-38113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE28BBDC420
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E5744EF2E1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970F2DC359;
	Wed, 15 Oct 2025 03:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eeP3XhJ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117B2D97B8;
	Wed, 15 Oct 2025 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497530; cv=fail; b=dKSCv2Q73AbPgdPl5tDMelATlSpReebqX3L45ydc3+19bhCuLNXiTEXdH2rCkSxZYztP6fOtNoipcqud5tnrTdeAHK/+VaCC9JqqWircjSH9VZ99u0GDO8F9F0OavMr57kCzQB2Lj1I1W03Gr5PkN44LkIQDSTZ6DOOSsPax5IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497530; c=relaxed/simple;
	bh=SF7cJBAAvt/TFSJ+8WTd5KZc8wINGHpdqCGuwldA7Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mj18kQaE77W9OO8RG/mdUJHB7ARk5tfVGxJRnx89faMu100HwMbOBFgT+1agmPUJMCQya9WTlqIa0CyEzMBuaZ1TwTc2WC0t7aNGcKj6ypZHcgg5QehiiW5dU/rQdoNzoakUEXe8V8K8eH+22oLXrSwAxviAjuVqPHnBQ9BKEWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eeP3XhJ8; arc=fail smtp.client-ip=40.107.159.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auCiPM0eLdNiueYn6oix6kdTSzLTFw0TVa2A7bz3pEr3VsCiI41f76IL1Qtv3tnN59I10IZYPoqkAO2uEXEc+7Vf6SuB6goiaG+/lrhMkIJp6F53EwbVxI7mJr3qJUJDkP/N0KGqRCqTcRtzqOf5qxHco2UuQZsNkjxLPIkeT3l3GGhs0r6+74Bquuk+VMpQC64drOyPHyHyvJ5q8yEXLpEF20UeVERml77uWs/NINUjvwgSLNj8/n+P8riXx5GKtLXKh/UH80hG7rO/KTpjFPHCh96o7B+H6C+H5lEzIAXKdUQTrPYPipeBko33EYzt1imLazbiFJZo8x0VBlBlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9905o66X8/jAFgoJuuDeEm9ga6dnPfyZniy9cRiyyzs=;
 b=K7RgbG7yCuB+eaO+V4/5UrlpsJREjwgCOmlaBrh1ALUMuMxGrdEmRJmlsaNHIWpd8+ZHRqx48bG3ws6TU4+fY/5BKRg+q/hwTW6dptEKg86ipri7mMFs7JtxX2J/2j4Cb0kXymXizhq63g+zn5MrQ/SYwJ0zQSYlgcD4bRd6ju/dYdP9Q7T16d1pKz+b5tPbYEmRLCGMrFMVbylgl0hjy+yR4qt04E1Ob6Y84RZNcLflP53fg5C23LmOME0m1tDsfor99QLYYS92T+/4hH0KF258arIXh6Bz/CL7dWvLFCYXZ3/QjVCBe/lopAk2C+aRmLaj2XUdn06d+gsVQQ0UZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9905o66X8/jAFgoJuuDeEm9ga6dnPfyZniy9cRiyyzs=;
 b=eeP3XhJ8J0FzS+wNPJqRYOQvMAwVSCxuKReD+8EUtHfccYNAzBcM48shAxoqZtjagCaJ9x8uGGrN4iaIzwkFgbxJtvD03b5j05GXdgWkkscfosmPUrq5UOsK3vyrwYThG4SUOaS23D4/Khu0YQ9aiEQOg417oVhjeHJ1JmiOLSSa7Zg262YVvWECnF2iKAI8nyJdj9K0RYVxotbTIPX5A958S2w/2UHN/oi8Zi7qR/VmI24mukUi/WF+V+g03fX/P84TZ0hqOlofADIX+kxvxRz4/8AkUEkRnX+yVxRfNrV/5yQLomgNG/bUY2jMlGVx3EuiAAf90qa89qbHI+6i9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 15 Oct
 2025 03:05:25 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 03:05:25 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v6 04/11] arm64: dts: imx8mp-evk: Add supports-clkreq property to PCIe M.2 port
Date: Wed, 15 Oct 2025 11:04:21 +0800
Message-Id: <20251015030428.2980427-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU2PR04MB8840.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|VI1PR04MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa11f38-1f17-4f47-5e88-08de0b97afd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KtTUkAxtr0o8X/huRzdREfqk6LdtXkq/+dLWqBAS6jsSobvx+qBTurwN/5ku?=
 =?us-ascii?Q?QPWQpNjhugZHmGYh+5tbC1AB+7PRnrk90D+IzXRow62fZEZlPA+QMNu/UyV1?=
 =?us-ascii?Q?IYTYFHqoVNeK8Culo1ssNDnibNm2bn9/bdN/I3WTO5C0UK6uikkHzxPqmnY2?=
 =?us-ascii?Q?fcSiv/wjAo34l5IrsLKCyh29O4D35P8dqg/MneRzRva0SB32jRORXqLp7zQD?=
 =?us-ascii?Q?iSXcrwl2JLWDo3bHidURgSxsCrKUSCWaUjzVq5lGfuNQrR7uSNP4j6gtCWSF?=
 =?us-ascii?Q?OcrcyVK8Urz1A8UQaXeo9jJg+RiS56dgDkayTGCh48+AmsvH0yB+f9h6KjZL?=
 =?us-ascii?Q?bPuh22a3EFSCR94oW0+3hB3aWtWbhte1qa4oFxniUnY8TyKSbKX0SBsKy/kT?=
 =?us-ascii?Q?5n7u+dMKU8zMYmjeBrSYUQK8ZFc8Pc7u5STCtG7IIsqX+3e+uJ0bvQwMzCeJ?=
 =?us-ascii?Q?klQEtBN/daAHqJpe1y9NrMwSWtMV8YOJZ48t8c3ZxQ+QmoA8C/TuPwgoWNup?=
 =?us-ascii?Q?wMfZcPG4ebxwkNKN52/IgZxswzNEm1TIUJbaoajajR4orQOy5rEqc7dwWnur?=
 =?us-ascii?Q?qb0O0l/meVt3GZzF7UWiF/48bpsgKJFFJMiKyDkXNF5TM4ybnBP9pVkSIx1p?=
 =?us-ascii?Q?aboyzOFn00+qYN2jcNMQRmRhEM2OuBWsUZNc4F1wHjSclddohI8kQO0qwILp?=
 =?us-ascii?Q?aheVZZ6cot63FKzzOYSqEqV3BUC6HAjWD+Fj34aXi3V4C2wcqiOX7Gpnp7i6?=
 =?us-ascii?Q?JI11iurkPFH58cU5kUbdSLfk+pbnlECQc0XrJsWmBYSP1dDgphvJL0eTUaa0?=
 =?us-ascii?Q?RNpHlw6PxIHsDtpUVdsurMBXh9Xzi6EDxnnuHASpWole+Z9ZkE84dshOityg?=
 =?us-ascii?Q?8VnnBPYeVB1yNIil3U7xHKQSD/GXqnbQD9NNGQUxH70m/cVSMI212+H5sVYY?=
 =?us-ascii?Q?eFWOG+fte6xJVYbjkU4rTPLwjxblND3XMu8F60AcXRwn/MX+yiCsPD2hpsiN?=
 =?us-ascii?Q?6HTHa6O2kNRaHtbXC1cn0JCWnwQbAekkldaNJYEsbZsUPrGri5sZb4CWC4xi?=
 =?us-ascii?Q?9DZuG4vBwmSSt+WEA+aG0DFUCMcTKQfavB7oVfj4t8vy88x3/9O3yFGNgjHu?=
 =?us-ascii?Q?HPDGi3e2Et98I7MTWRwCvL5LcVjoROA1cxSLv5kbHKyb8JFAue48YS+qxXps?=
 =?us-ascii?Q?3md7U6U6sjHXy3x/zm52KR0IrbdKlwxAuwn5uMYsPCjys00g2quRmKA7xoYe?=
 =?us-ascii?Q?1ewv5D8mJ5ld5E7duXZuSFCNusT80bHvHC/PZJoVmRjBs5+qkDfJYTZlVUoS?=
 =?us-ascii?Q?cqi7MidKZl8XRnYnJqz1VQmn6+6iDnluXnm9ljHcd8OB6mzVOHIlEs3La9K7?=
 =?us-ascii?Q?TWjWoReDmyW6txGf65ViAL5vZtAO5wyk8Uni+ml7st5EdX2HsSq/DLHpgONB?=
 =?us-ascii?Q?BCjFBCdlaL08+xl6lR8gDJUpn/rBvE6LkfE4dw6K2xNWaX/TJTa0B+r6NH4K?=
 =?us-ascii?Q?Ed3ZkAbY1vEiDwn0naj8LkmcHqr4fRm/3ClrySS9ekPlqDMpQyiCI40row?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b04mthzxCZNaOZx2AIgsZEuBd9YsUWqKe1D9o71okAziWl2bvq//UNjQXOPT?=
 =?us-ascii?Q?iVo2/vF13JcOHdlYsUl06cJ2cv308bMQDWEuJF4DAAQz4GUgws2fAUBW//oF?=
 =?us-ascii?Q?vkZpt64FhXjulluE1TT5Dxc7kkWc+2fJkDon28ypSzPYsgMtKK9iQBgODXYg?=
 =?us-ascii?Q?VvnTje+k329UjRy3U05nnKEHInR6PuVezX6Cn/ERPZVxdJpxXA9ug6ify56f?=
 =?us-ascii?Q?SGJyBAxCbufuNooTjKvqsNB4gCeydPBUOOJYyhSKjEJn3DAfd2010vdJsXzg?=
 =?us-ascii?Q?MOD+6qjehH/5vhsMLZVxKybIhiI3ueNWAyiq3P/5xh68kFfvMnaipMsXHgOq?=
 =?us-ascii?Q?eGUaXl83LiCz3gEsVlOT+VtSLkA8wGRndEkjJXExfFinlFUmFrG+2RrqqQSl?=
 =?us-ascii?Q?g8wzD3W+vIhUlvYmwb4Myy657Hr8mkAyp7vIItqUO5dCoA+eRM74/RD4tRSZ?=
 =?us-ascii?Q?UdytCS5nK88IYu8/ISKcrGjIPkeos/x+JVQRECUpiAaIKt0jakBzjXM1nbdv?=
 =?us-ascii?Q?hHopo2ew/h+HCHgDCdxnH9VPnluPPZGOC45lp4SHZS/2Y1y9uhgi6MVynbQ7?=
 =?us-ascii?Q?R07cT2VY2qQGFgPlg1dc1e/1NmK7N+Pjj1jzj7HbJOI0yYLYr4ANPK1ryBC6?=
 =?us-ascii?Q?t7HqrQbqnHiCn0ezW4M39O1tnE78zhMkrfoAGXbTWa08btbdjApP6iUOvkIt?=
 =?us-ascii?Q?iFZeeCLBWuWLbgJbU11JyqJuPYBO41UP/YnYaRmB9vfvu9FL9nIxG3uI96mr?=
 =?us-ascii?Q?stKmbUMf6Cn9MbN8Kz2XTLcobkpi+NQTcvgYBBZPQSbYsGT4xuSGIuFeHku7?=
 =?us-ascii?Q?oK1sNwVsgrV3yb5yVwgI9zgkmIoYrGvNXN3drrxPJbRL6fweeoynKrfeiViY?=
 =?us-ascii?Q?0JnnvE5IokQnVgbAU/hJxZza3XRTqYCNa2vJTOQc5tetcd+yZuOQtaHq4IYg?=
 =?us-ascii?Q?tcejtajxMWVqvDPN++gTRhkdmStKkcu7wGAgbkQ01nJlSrw8Gm3zEKZLFcmB?=
 =?us-ascii?Q?ZSy4Af0YdugxYhDGB4m9MMBKxBbtF4Us9HdkEMmzRIU8xwbN4Sz7TkluPQYI?=
 =?us-ascii?Q?r5j+bJIDNx8o459km6y0Z+p1PlZ3SzEx5aTxWo5yJmaYDnhAFMg8Uw+fs0KX?=
 =?us-ascii?Q?EKBMzr0NkMbnRzFTnxq6XtLAoHVprf7dpXLBfzLSniDh+PJ/+cKjSz6MQvUx?=
 =?us-ascii?Q?u4td69mLoBOYD7lu4w9Y3L7e9ic+Tn/1wbc1LbjIurz34tQWdZyCmgpt96Kb?=
 =?us-ascii?Q?HgKV6K7M93/K8PFVAe437SaqAUShjJ9OmcSTX2vkHIts2yuWKYV6NS9pMa3h?=
 =?us-ascii?Q?1a5Up9qjj9c79q0Axxfx6+ZtJcGPaIDmKDlWXzlH+oQ1pSYgoZve7DmI3ovc?=
 =?us-ascii?Q?j6VUfc1tFm9xjhVOsMzETENAru/gDLRMe6LMGKBRn5Ybg9z1ZTF345phTrWG?=
 =?us-ascii?Q?16jHT1LffCN/yDBLmHtgcpWKgp/ia+m8zXylI9bJdXqFnqqX38d7lhxLmNhg?=
 =?us-ascii?Q?3Q55pJcbqDqjt9xlVPhR/CpPlGMoHS1y7ht9nFl4xhVTumzxsTEUVe8B1qFl?=
 =?us-ascii?Q?oJohikmvQcJlF9DN2ICT5MnwU34wgUUtDm+/Py6H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa11f38-1f17-4f47-5e88-08de0b97afd2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 03:05:25.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQN2yNoYqYnlHGChcGElyGHLkuotd/wHv5DCB+K13+oORa7rkadFC8IjWYdv1xplT9Gfl9TKIzdPVdOm+t6zDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006

According to PCIe r6.1, sec 5.5.1.

The following rules define how the L1.1 and L1.2 substates are entered:
Both the Upstream and Downstream Ports must monitor the logical state of
the CLKREQ# signal.

Typical implement is using open drain, which connect RC's clkreq# to
EP's clkreq# together and pull up clkreq#.

imx8mp-evk matches this requirement, so add supports-clkreq to allow
PCIe device enter ASPM L1 Sub-State.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 3730792daf501..523bf4aeff317 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -710,6 +710,7 @@ &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
+	supports-clkreq;
 	status = "okay";
 };
 
-- 
2.37.1


