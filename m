Return-Path: <linux-pci+bounces-31666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD616AFC6C5
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 11:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BB44A544D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E82C08AB;
	Tue,  8 Jul 2025 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W5mrRUai"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012059.outbound.protection.outlook.com [52.101.71.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36F2C032C;
	Tue,  8 Jul 2025 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965960; cv=fail; b=IssfAS01yblQHEmzvKI/nHpH7zHapizCjx5I3iLAUx3KFPjsTKcDhe/oTqafw2PRRNwWYDt3+dDGDV61f4SVoGf3WhQo2SXCT52Ll1TywPdVVqrv3QJN3w7KUkRJQcAEDX3YrUIzaL9o3GIZyriemI9puILn6DwhmTw4KxTj8go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965960; c=relaxed/simple;
	bh=ZlUN3r5f+krC+1Ls2J76WAtJu94aKhjk+nEPIKXhtSU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TdGfGHkVeWUM639mz+xMMhXXrIZHh7CXcE3hl1BRcACic+rdAxg7pa1/YRQqo3JjVXGh7nyzMjaJbjb07po0UBEDpRF5RWTbWqBmjJjtn54PjdJhXiFQtvWaNaka0B39sqa1T82WBb3XjM6Q3lqFZ/rLNrz4Txl9lXtQm7DpZYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W5mrRUai; arc=fail smtp.client-ip=52.101.71.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+XXO//hTwUEqS+pbTujLzcwUFBriLPpw5yTeijlT0+iGfYXTFZIhvmlmbBOVKPLsEuoCiXrTkv8hdTFd2DwgAf9+UFIstfE8Lty098U5OgL2zpQTe9ST5d49GatGapQd1HcVwu8mZqA7WeEyNyy8SBEfvGYF2bUPwtY1mwLhW7QvLH/xiOuPAlnHEX8tNWL/OMgkDwQVv/nVUDd2DHU93FcW+MZ4QFT+MrXnXvTEiqxyV6J8/J9vF0WlQ4W/QBGCRQUA0c2DN04jtA2a6E7skafWl45UhGkjzVdwo53PaXzkkKTP93181qgk2zF2yxdAeiPJtfZFZt580A8W7NWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlUN3r5f+krC+1Ls2J76WAtJu94aKhjk+nEPIKXhtSU=;
 b=oPjl+Xd9beALvIBPPZWl0YL1BtgahuRtQXM4oipG3GZ1zb3o/0dHIKD+AagyNeEjPiom2nbDVyd5DBqwKRPacIjSbjjmoAHmEpg0cmWTkpf5PsWCPc8ECSfi39c8ZL7YYKOCEAlGWhgGCIaqfmJrQpG8jxqeCWWf76nnDnRh7R71FT0nbNhFljQdJNL2cTtvv+aDl0ITp/R08Omi1kPI4lGTwl8E1+Zy4mqQLnZZ9wztlnNg+j+qGrRru8ShntLtRKYEL8dEt/cx8lUEu7iYPjFDSEvBPhB2YcgOZ5cJmLBZW+tZccbTOyAgqLxDz/g91xsv/t6kFlcMj5vbCF3QUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlUN3r5f+krC+1Ls2J76WAtJu94aKhjk+nEPIKXhtSU=;
 b=W5mrRUaizQ3JA8C1xJcCx23Ad4MJ4LbCqU7uf94+I2b3GigFbAyg3fk93+baQMHFf5R+cjsbtpA6vaQyOINh1nLvbkXaoF+NLuls2hX/mfxow7i5zhGIQKcV7TB1F2y/Uco5j0uXEFBSK/O/5vQlGQVN4d9OE20M+PAqxhQWVtu5xfJFOa3Wa+oGhfmvKnG7uxpe9Q9GSKv4/C5IwHmFLqjjnNgwrRFsiJ+d+GhHyIYWqxq00D2IHTIoxgyCtGLz6IIB5NPQidqL0LNEGeZpk/N900tJAD8iF/9NF/zbwcZjLQiNELYguo9xnky9Fk1vg45i+cKZvjZTRiEzpUYRUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 09:12:32 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 09:12:32 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] PCI: imx6: Correct the epc_features of i.MX8M EPs
Date: Tue,  8 Jul 2025 17:10:01 +0800
Message-Id: <20250708091003.2582846-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::16) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af86dcd-9187-48c6-1143-08ddbdff9220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/W2U0t64izplRtEgFfL0npSE79XRjQhJo1c3z3yKakUaSYs7itVoEZ92cH4Z?=
 =?us-ascii?Q?uR7/mFIZpGYqCYyJQqzQkGRsGFEsniG0o6JCxtR8H2TpuvrO2KbD4E0M/dBC?=
 =?us-ascii?Q?uwo/ZPNoT1tDfkzEdMVly8mo1FyRaokoCUO7mb+zIA48CJDZ1qx9O/QUAW9W?=
 =?us-ascii?Q?DGC0sevI8BEyKOBkxU1lr4ozlIAbkDY9Ac0bi1RGCdZ2jslPrV5b483heOA5?=
 =?us-ascii?Q?biYCKjjhMAt//DNVvee1FTOtKlbChKGuZ77tauN8zvpp3Kd35YQPSEWKcVNs?=
 =?us-ascii?Q?kBW3lb7wGOxBRRRTH0ONSuUvvU2+YQPO1GRE6b/DlSC09JRW8oyGxs9fQrBa?=
 =?us-ascii?Q?00reY1NrRPqbB/74swA/CY9xkhr9zHuNfXSFqnuobMeb8i9uSIm3t1RMDyGC?=
 =?us-ascii?Q?qW6rr2BrKeSiuyRZT7Of4hufabI3t2Bs/dQ5SLwsMchegruIeEhwSA8gcea+?=
 =?us-ascii?Q?d7iiRPPJSvNWKhrDeDdFNQJ+HVwNHrJGVsoSryXxPFIM8DJm7B/IfbstTGgt?=
 =?us-ascii?Q?HmYqYzMlHtaauvTNCiWZBWWMEZhvyRiMDkVmHmGuPiIZYQqxI/FNOxFVFTWl?=
 =?us-ascii?Q?4+6/2RUhJ6VqJdjDBfnhmcEtLPJ6yEOKrW2zt6Fzk/Ur4Ui2ic29yhYN368a?=
 =?us-ascii?Q?QV6ybaYe3Jz93ACuQ7dyaqq5D8DOfIfwL+WNATvZucBBPdnurrHbYiMcqOy6?=
 =?us-ascii?Q?WY/dL49roVvUbt7amXKw2xKCR0jKjzrhUFdAdi+y2V9l9LXbkaqRhktrhIM1?=
 =?us-ascii?Q?qyVuEbWxdjpMp/amtODatMuV1shSGJS0c+2hvjw6U39N2sdkDJDRMPTjqpfP?=
 =?us-ascii?Q?fGLoPnJtuZpBmEXelcfti5sRtGG0oAEbj8NJj9DCvoRJ9oz8UXeaqJH0MeC2?=
 =?us-ascii?Q?kjMWSM0+gkoYvcs6MlTwpLEAcW4o7aJUFnswBf/7wWX6BIhahFg6V/+m9OjU?=
 =?us-ascii?Q?vs8fToGiJK0DqIPJ2lvTymc8SqEsF6pANwDxJGn3YMbj/u/7cwh//lJ5vay+?=
 =?us-ascii?Q?rfo4uncxO1Keg93K/Ckbx4l4pYvTBoMDhvitVKUq20j7ONkJDpCQ80vDVMsN?=
 =?us-ascii?Q?KTFS2bzhuViTSSmznlRb5TXFgodVsGbbhXzjzgqcfZQQjOkCf+IBSAdcktfJ?=
 =?us-ascii?Q?75+dlMBxcWHlmqTZuO25nWRJsW0Uot2qVtvJ1YrA0CCzOI7UidYqs2xYRS2J?=
 =?us-ascii?Q?hzZqCocZiWW3WPOLkT7wD225DDSpOOp/GuO3sAMp1zU4UC4RhbxguSc5GdyR?=
 =?us-ascii?Q?uejKIGAEfX3BECjrzKBTy10FtjSPYWigHjGVAqMx/+NjRcOVwG5UjzaL6s7Q?=
 =?us-ascii?Q?AUc5bw13kMtIUgiGjPamBIzzEFpnf54sHe0Mn3AcO/0SRjD4sh8AyaTJ0Vb8?=
 =?us-ascii?Q?LhvMh4bjRpVTpAKvE0zvqSmwDmqQ6+Cb3VnjH3IFmQ7dXA+ZHK0+TQpbGhN5?=
 =?us-ascii?Q?eO/6WNUtvjxLH6dLiF99lo42GdOZDfJa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wX3PF5EkQpYZ3dhFIYmivPl9KuGDCUgoj1S8t4B0XQUgMyrsFhe8wTLPUisP?=
 =?us-ascii?Q?cGPoZCLCTuiPLD6Ei0JtHlzCVe71oNdeN7DHh+2Bi5fGZOV5S+UWeL42Ti5X?=
 =?us-ascii?Q?NY6u5hEOXsAJO8qD3YjKho5X+5kgcwVw5/7paorqE3UE5/DumIfxZPICEv8T?=
 =?us-ascii?Q?UXe0nyNFd39t2gePFebKWUIs7tBXhsYE99TqmzLs+zD1M2drlbBWQ0zq9r8v?=
 =?us-ascii?Q?wyIFAnEKUzGrvGejXalV+kZuITgI7jAhhHCwoe8gSa6k1nAJElL5dn8KaocJ?=
 =?us-ascii?Q?fNENj70cDAgXtqNunLfunRJ9BC5bH5+gLWWkDggQ0WqIzuE9gF1IcqeeWj0o?=
 =?us-ascii?Q?kFhXgLlR22GZx4YrMvATC43GqofI4zyfIgRMUi4lh+8/Bs9S/tYbi8Qu3vGy?=
 =?us-ascii?Q?HGdG7IIFgTdR7WtOIUYdMLsjDgA6mqtdRRGB4MFwyiKRmvu2sVBkVYDuUap6?=
 =?us-ascii?Q?dc+4soS84UyAyffEb63E+0vAC+8Ec9yeecSfZVOY0Z7KLC563KLp4NH7lQbJ?=
 =?us-ascii?Q?U3QBYjkdMorHldmWD1wWIkgSQavm9tbuPmlc8Y9h1dpfB6hGP58Kgjf9TIKc?=
 =?us-ascii?Q?zGzMtja7PyU7Qm2AeoyHRUwx0XPBeJxBqbE8hZoUphxk4tRrd8zl8XrkuuqY?=
 =?us-ascii?Q?TJ8bK/BOG0SVEKV14D/7QaC3EJd4Tl8s+VveLAXDmaD/9193wgjmhoVCWpWR?=
 =?us-ascii?Q?24LYaLEMVa9WB4N+Hn9RlJIeDJKi39SvQv5gLD39l/g5haOW9YYGrlMV4zBw?=
 =?us-ascii?Q?K5BLtBRgqHugMbNRmx91I4iMDndL3Ulf4N1V3t8I6o9+9ruD1KsZ8PCCyVYT?=
 =?us-ascii?Q?ZR48/ayJcdbMg+GJsYi7v1OKDD1DWymIPzM3VWtuUtuSBJ2iDW2lDgsHVAvN?=
 =?us-ascii?Q?sv0GmY3a3aRMrH2RHRgCSg1zl9Kngq4fXlTKkUmTcE+2NW4BnP1IDCyetRz4?=
 =?us-ascii?Q?wUM0lBXGKwR5onYnEEw33xNyM8qnIeKrD3Tptig816HYc7viKJLTb+NGDl+M?=
 =?us-ascii?Q?ori0W7l1uRT7FLE4DchlCY6fur/3P75wrryK3uvHI+B9X+kkFmAsz/Lauy+V?=
 =?us-ascii?Q?dneAzUDBhnq1Xv0wllEgJxmujn+jvZJKUC1SpfHPWSZTwVfJ/t+vb/21THH1?=
 =?us-ascii?Q?VDChKIQw2ClbcDeeOY7d98ermS5rTvubH3/vZyuA00YdI/8Td8miK1z/CyCx?=
 =?us-ascii?Q?MRssBC7kcP97Qbesgd9LuGNn5YzZAwh1TYnfiu2AEmIArkWx3oUDGKDB4em+?=
 =?us-ascii?Q?BDbsKqjdya2PbC+Dv37ydcdmPwqtRfVlneQ7qa9kB3xPeP/cvfAfs7Qb+Zu4?=
 =?us-ascii?Q?8hxSw7Q0thJX80GjyT0XqT9oXsLfp/taE47AgvmDeELNZwwkRj3JjG0uDTG3?=
 =?us-ascii?Q?Th/nWywRwXd3ysjVvARYpyqbXtW7579WuubR0fZhtOy9bHFDAwqSdabuyvX0?=
 =?us-ascii?Q?iwoJO30yoTHJSuXGvSss1XwsHYcbQIPcgU+csjtSP1ZTYEW/xuljg/+8wPQ3?=
 =?us-ascii?Q?S+zQ3PC73XAhMZUYknPTHNlcRLS5kVn2HZw353L10oARmxvGTiI4p3P2vJW5?=
 =?us-ascii?Q?L6Q5zyMYLlB6hlu+ByqjIY3oO3IhPHrKBAgJvqf6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af86dcd-9187-48c6-1143-08ddbdff9220
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:12:32.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmYIYiZSjxep9SD6LqeSCFybihTj3zElPaQ9eZf3gbGtzMtmvEuLnRdlLF9KBs+HAFGzB3DlgqqpXPZbCAJvCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

IMX8MQ_EP has three 64-bit BAR0/2/4 capable and programmable BARs. For
IMX8MQ_EP, use imx8q_pcie_epc_features (64-bit BARs 0, 2, 4) instead
of imx8m_pcie_epc_features (64-bit BARs 0, 2).

For IMX8MM_EP and IMX8MP_EP, add fixed 256-byte BAR 4 and reserved BAR 5
in imx8m_pcie_epc_features.

Main changes in v3:
Seperate the patch into two commits and update the commit logs refer to
Bjorn's suggestions.
v2: https://lkml.org/lkml/2025/6/17/267

[PATCH v3 1/2] PCI: imx6: Correct the epc_features of IMX8MQ_EP
[PATCH v3 2/2] PCI: imx6: Correct the epc_features of IMX8MM_EP and

drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
1 file changed, 3 insertions(+), 1 deletion(-)



