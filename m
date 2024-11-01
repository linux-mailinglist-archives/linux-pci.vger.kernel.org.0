Return-Path: <linux-pci+bounces-15774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D38CF9B8B85
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5772B1F20FD6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 06:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B6E14F10F;
	Fri,  1 Nov 2024 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aC/bjp9y"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DF14E2E6;
	Fri,  1 Nov 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444175; cv=fail; b=aoBFnwgggBh9AWU7KOsw5gFOXFdE/i3NIObD6cwUc5wZ6k8DHDa8RoGwnMTExyWevXx1pmjZDenLpbm2rMMAIJ4OHdJmn1DhAWPv+9P79+w22ZtkjqDFoLEBGP+r45tJbeHy488BI8H1h3gmiX5AJfe4SC8Ewl4KIU1vAUB43zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444175; c=relaxed/simple;
	bh=VKRS8BLtOYXECVwX0hPqY6vdLt0s/HoQ3eiH99sQ55A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IwMaqnxncai7hnOd3XBX5yJKmNqheW1g6G2klsn8mMnaNgvXPPWxyUjJFYckMlhfnjhqlidmLpX2dTrG8o+NqEvL6XORGUmdYf7p7wrXv6KHMEgAWut6oo3b5NKBf5DRcWKW3UwPR/DeSA6ruHmV1rt4VZX0apB09P5aKxeL5jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aC/bjp9y; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swwkd9ccXbio/FuN4e+WVTguF7cB1GT3TpCI3Rx9WXNI//5h+Dqbhj4IQr7Qo485q9AV8C/oXDkXbzRqo9UXVRyTMqLEC6JfL53kvbDy11qPfXrZZgBDYpw46BgFYbeHF5dWfCRIBS4EzO/+aaUOwiag7ydlBtx2QTuPvtfZyzzcn4E+rqXe7ngVYlJUHOSJkTDiwpxWQZmdki8icgekHLtZjfYcD/NRzmOBv7CpdmfW9M53RfJprMtdwzU83Th1w7IEPEbNcW4LYDifDQBaCbE5RgyFAXtMXdaRxrcv3U+5a2zjPGXX2+BfF472dNgY+4qADQuT8i/not5OBJpDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e6B8Z3yI+ef2PB8C2B+/7Y/jwr2fkrRGUH1Fc7HrhE=;
 b=Rqw/JObTuSLlEoU7u9MRNVo3lBHr49EpofMWckJ8pN/+ZoAh2ldhQ8Nsd9Ml/IJtKX/UxcS7+HuY08E+P0MRoOnLRAbHjPEPcMGJ3JQqXn6kRJf3X4OmWkQj+Innv7TB+F2pLzKGZCddhJhdlGD05tbJjAd4QydSj1+GeTjO2CrpFBfT/kjlPdIZbZg+MzkH0VT8l6/ilrIc8Rp92W82uP76x05IzLkC8yQRxyfsoQAOMzQ22TqrdhJtDjXdGdr7oA4k1eW4taT6Fe2dGyosYB3CN+auNHJIkmSKz+mz/bnMDi04dr3ThailB+ISZRygqocZM1oeNBjS6DkoZuedag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e6B8Z3yI+ef2PB8C2B+/7Y/jwr2fkrRGUH1Fc7HrhE=;
 b=aC/bjp9yI65uAL/1xj90af3PGdTrXTgac6zNz9Ox9qm5fyVEEsz5mXWVXE0Ytu2iY6g0XLq6ll/3KWta/jznNWg2Wa0UMzo08YsJE2Pct8gUFevalqGHmozsLbPXKz+5DhCurv8/CIdT9fh9Q3tey1tFu48e/2KfAn+KGR+PS/Ztt7WYzRXPVo5RMFV0y/ErdV/XQvUdwuWxAzt4TiYpd/1khP2ONX31M7tFSbKdx7RnuKcnQpjezrhgDZXa7SRrIe40xnw4bIyypxMQ5fI5azXZvYc5pmnnaE6KCXz46MRTITYR44kEg8r4fIMVZAqaGi1W3FynDlxMqlMZ4wD5Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA2PR04MB10445.eurprd04.prod.outlook.com (2603:10a6:102:41f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Fri, 1 Nov
 2024 06:56:09 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 06:56:09 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/10] A bunch of changes to refine i.MX PCIe driver
Date: Fri,  1 Nov 2024 15:06:00 +0800
Message-Id: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA2PR04MB10445:EE_
X-MS-Office365-Filtering-Correlation-Id: d09131be-8c61-4000-55f9-08dcfa424386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0S1vjILUQ1TiPktIoX4c3FZGDFaz50GiU2mKFb7c5J2cxolloO1uAxGE58T2?=
 =?us-ascii?Q?bfl8NqWdCzqvIo1pmXINfhKTw/qmjctnvplTp5pKAWcO/fLCrXFWaB9cIeM3?=
 =?us-ascii?Q?iHC3HJ+tXBvESDGzAYLMAK7IKDCHxvGHyq2ebjVEUzD3nGNO902m0qjQFjFe?=
 =?us-ascii?Q?kg3G75lZFgeK6OSCC953XGf1nLuXCqvcVBY+MBg7Jc/T92vjCwMHeEZz8JSU?=
 =?us-ascii?Q?uoZ0n6J3eVUgdNfwGXRTDJMN76QksmdPoxCWtJ8vbsvVfG3KiysRXDhEI5lq?=
 =?us-ascii?Q?DpvRgJoXOqFylbc18/F5GserfTfIgUmya4Thx8YKu1VGGqJfmaL//2FXMk0K?=
 =?us-ascii?Q?ZYDcQ63sDEn56cmAF9gZ7RZJiXGhwgYeGnEMYtaOCYY46OwpAq8PC28Omtdm?=
 =?us-ascii?Q?uoCCpyMZXNekp4fmw0eJ9npiM5QE0BBJGvNeF2CWsIGV6aAGUTDm2E0tlkeM?=
 =?us-ascii?Q?NX9wO4q3gy6CCvhJKs4bqeAreuk07+a2/hNKagtR6X3iDuSfPaTsKKBRot8p?=
 =?us-ascii?Q?fO33BasrggxlFb8TzuIwlckvaKfgG1HJWICb7YMArM3fL4eFr91P1ZXx44uM?=
 =?us-ascii?Q?2IhW6Qrh+AS+QuaXi2zT7xEt6k/OwnAYjL+NniD8zcV1kUJAbJsvyV88mtY0?=
 =?us-ascii?Q?t9BhfEQixG62Do83Vwmkb+8mPy64JzWVKah8vxaKcUL9Vlz9pwjodq9IRYEQ?=
 =?us-ascii?Q?+hqjNfarERKI4fKZWP7lXeT1jJvlL13Dqdlz4zkzbAgigb88mu022mVgvzkg?=
 =?us-ascii?Q?kOkJJnmVvkI5JsiRaVU/+3bAikzc424Bc+/L4lsjJfZiLi3Ug+yf0PFORj0l?=
 =?us-ascii?Q?UkJCVlCsv8dpwwsZ5OMtyWNIjG1PHyFswjtl7LxtvlrjQyZVwY54Va0fwIpI?=
 =?us-ascii?Q?trnpqV9hk0SynpiD1xeZJ7vCXuFyK2hOR/CbY02cswbyM/y+mkPSNFZUfbmL?=
 =?us-ascii?Q?I+MYRsh94sXj4Fpg7a/A7PMrKlZJ5PZ/lznycIsSg7ZKIzy0n7OJEC1Ozn9I?=
 =?us-ascii?Q?K/ew0gu/RCH7ncoG51L4COAHmwfVMPxqWIlQCe5dVtHodXyXybfcmZtwuE1R?=
 =?us-ascii?Q?i1hbueVMPJqVi21NOaAMESa5W0jp7hoOx64NBDycabiPXlNNph/df6wABBeF?=
 =?us-ascii?Q?fYXVVLGwxSgiULTPZZPXFl/u0aOHUyKKKr5sGo0fj+nMfhNSXFwNg2n/2Fh4?=
 =?us-ascii?Q?PztAN/x3Jlvo6t4nGLhWFWj9N87JNnTyLskkA1QupOlhuPmq94aaWbmMLrsx?=
 =?us-ascii?Q?unxY2RogBVYe/tyITpjtuuaguHgKJNT+6ht+0W4PzWdS6qmZMOdSmixbfQJF?=
 =?us-ascii?Q?5Z+ltJecTIpdEoztFgES3I8Hgj+4wyXT2EL3BFqkCZqmobPQzbT9zbxLcMoH?=
 =?us-ascii?Q?0IQucZXeggidpMur1K41KL4UKUWB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/g9EWgMmWDJlj5InxTtMgF1LSWnaKosogGCoEsr9pQkDoqpqVfxRMEPQj/Bn?=
 =?us-ascii?Q?RABZsPmHLM3z5i4mk+XctVi444u+awzEzcf7Np86NQwLh2PWicJ/EOiFC9mP?=
 =?us-ascii?Q?1GvTmkcp82vbi5ANUQUVgLeh83tBsqigojkfERsTpNMRilzoxVe40q2W8xd9?=
 =?us-ascii?Q?v8w78EqADflQjWXm4nqQwm0muy9+P3c3se0dzw7Gz44RdROA5IaJhkg8I3Pj?=
 =?us-ascii?Q?Xaj7xPhLA0+F1QKfXAAQ1HrAxFnhgd6/kMNJq+YfmkgH1LWKeUmAloTCJ/GB?=
 =?us-ascii?Q?x1yhtLct5/QNfK3dgrHoWKJwwDoCqe+kVKF17g1YDCGTQxZChljd8IyyOBgu?=
 =?us-ascii?Q?gyvW6ZhjTekaEVCmCI61foBZbHnKtUnOOTMsLTNtwJBokPEa+GlmssUjNHcF?=
 =?us-ascii?Q?/MoERRbIKOApCDVn3s++WzTgWOwpBRWR87wD9GhRIduSesaeea1glJ4cO1z6?=
 =?us-ascii?Q?sgSwQICRtO4hB7szlVryRm0KdpIoT06yvdGeG4MHcDy3rNi5/zC8gSaS2MWx?=
 =?us-ascii?Q?cEkzUsWrBmU3aAs8es96OnF9m7KrQJUbCAieFY2DhKJ8PAb8bv5/gFieq5th?=
 =?us-ascii?Q?ECHU5YskyCr3dWxZ16kCIlPKcqCuhXUPjJzU1rFmXngR2JZstKjyoxcqxLlj?=
 =?us-ascii?Q?nSH1xMvlY22OwZRhN9mighW7SZ/dMq2VIAD/WSlv9BCZG8aMx6TkTJZwUpPX?=
 =?us-ascii?Q?DOvEKdTI+Tq3OSXNza3r5PUebc5UEGsZZIsx0hgLr8H90DiO3c5fTmtCiFEM?=
 =?us-ascii?Q?z4+ZoAsIztp0XAvkdFcA0l/RbZI+zsBm8OeqwYEMedwBPEz4dwHiWXEIrlPA?=
 =?us-ascii?Q?NNLiiaKIUClEyYzzos+2MwAo0Msj+kLzHbA/QbSM4KUwV6h1/kSV3KE/fa51?=
 =?us-ascii?Q?fp0Z2i4kBcEwSUGDQrVXGaZEe5ZR7Wn9CwnGqWrZ4oBSenOzl+CHOEYO2ppo?=
 =?us-ascii?Q?v3xcnWjBXGYZghT43/3bbAhdaujS7BUjOhT1k2POa5XIDMP12fgMgHZFiIxh?=
 =?us-ascii?Q?SbuwQmTETD0puGI0dYnvQxlg6YLvxaTZQ1WOywhyH4Q+KFsxHJjfV/b5dJ92?=
 =?us-ascii?Q?5mESyt+IrQbU/Bt6bCXnKndeXPVLvBxE4c2X6nbYMmP6S9MT+PdlgRcoD1Qh?=
 =?us-ascii?Q?ZaTJgUVfcSzXmmnODlGfuuu9ldMijvaOe0virZk7xn8vltv17FiJehZlWacB?=
 =?us-ascii?Q?TxvQCuDnCYNDVnNoEHwoJe3BS6gs8Na3CLwob3pN+1oAytO5ic6KQ6yC2mxH?=
 =?us-ascii?Q?D65HrAMcbIvPJeHC8Ax3xynoBdTqMjW1ajP7foCw5cif2tYihF+3t7aMOXWA?=
 =?us-ascii?Q?hJCImestsbxXvgnounyruh0XqqC5mCsBlaFLz9sFQCTVZMuf4gA2o2UTACLM?=
 =?us-ascii?Q?qbxv7I/FeXEKh8MMjH0OwWTUbr4MueC3lofIWWU/SgBN+amZDSqTZxjyxtqh?=
 =?us-ascii?Q?VgLoMjbNOTDf8TOt9Pkd5aCSMa9sa9vvsjYlLYtnFMtpYB7Z0TXxbHYUkX6E?=
 =?us-ascii?Q?XyDRJEBAYpfwfA8RvO0I6isTJW2oksuE3SJgFBjM421V7S09OFawayAtt5o/?=
 =?us-ascii?Q?ikLkxIiAeUVqYIfyjJDTeL+KjEinxascLYz4P0ta?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09131be-8c61-4000-55f9-08dcfa424386
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:56:09.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBL0irE8sA26K9/QK5+ttvzWCRoQoYWZoJ1b8DzRTJGktbdctvwgzP7kG3eM/sEShw809/3wx4q1CqNZrC99RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10445

A bunch of changes to refine i.MX PCIe driver.
- Add ref clock gate for i.MX95 PCIe.
  The changes of clock part are here [1], and had been applied by Abel.
  [1] https://lkml.org/lkml/2024/10/15/390
- Clean i.MX PCIe driver by removing useless codes.
  Patch #3 depends on dts changes. And the dts changes had been applied
  by Shawn, there is no dependecy now.
- Make core reset and enable_ref_clk symmetric for i.MX PCIe driver.
- Use dwc common suspend resume method, and enable i.MX8MQ, i.MX8Q and
  i.MX95 PCIe PM supports.

v6 changes:
Thanks for Frank's comments.
- Add optional clk fetch, without losting safty check.
- Update commit message in #3 and #8 patch of v6
- Add previous discussion as annotation into #4 patch.

v5 changes:
Thanks for Manivannan's review.
- To avoid the DT compatibility on i.MX95, let to fetch i.MX95 PCIe clocks be
  optinal in driver.
- Add Fixes tags into #5 and #6 patches.
- Split the clean up codes into #7 in v5.
- Update the commit message in #10, and #8
  "PCI: imx6: Use dwc common suspend resume method" patches.

v4 changes:
It's my fault that I missing Manivanna in the reviewer list.
I'm sorry about that.
- Rebase to v6.12-rc3, and resolve the dtsi conflictions.
  Add Manivanna into reviewer list.

v3 changes:
- Update EP binding refer to comments provided by Krzysztof Kozlowski.
  Thanks.

v2 changes:
- Add the reasons why one more clock is added for i.MX95 PCIe in patch #1.
- Add the "Reviewed-by: Frank Li <Frank.Li@nxp.com>" into patch #2, #4, #5,
  #6, #8 and #9.

[PATCH v6 01/10] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
[PATCH v6 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
[PATCH v6 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses from DT
[PATCH v6 04/10] PCI: imx6: Correct controller_id generation logic
[PATCH v6 05/10] PCI: imx6: Make core reset assertion deassertion
[PATCH v6 06/10] PCI: imx6: Fix the missing reference clock disable
[PATCH v6 07/10] PCI: imx6: Clean up codes by removing
[PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
[PATCH v6 09/10] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PCIe PM
[PATCH v6 10/10] arm64: dts: imx95: Add ref clock for i.MX95 PCIe

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |   4 +-
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml     |   1 +
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        |  25 +++++++++--
arch/arm64/boot/dts/freescale/imx95.dtsi                         |  18 ++++++--
drivers/pci/controller/dwc/pci-imx6.c                            | 174 ++++++++++++++++++++++++++++------------------------------------------------
5 files changed, 102 insertions(+), 120 deletions(-)


