Return-Path: <linux-pci+bounces-30226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978FFAE1199
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 05:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D13BFCBD
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 03:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E75433B1;
	Fri, 20 Jun 2025 03:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BT/xQCmN"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF0801;
	Fri, 20 Jun 2025 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750389350; cv=fail; b=VAcNALgWxN1f3fuoPH1jrHqrW8/2JWfUeVy6ZBVSpYYAEPA+mXgUQg3nECpsQ3hVws16cEwj0a22J4zUlZ4fPuNE7SXMAXPVRxTYov9TFAcPN4YKvxIFpvqmo1o49kmU6jupzqnrxIyTP6aizVEgSCeL7nh6wb8Uc/vtIZpNlMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750389350; c=relaxed/simple;
	bh=ckOmEssfbEmT0p27j+5bh9DDX2sWI5EKmBG9ky5/gQE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=B8m31BEGuXNJDkJWZZCIdwXyLfnPwnEZOZJQWZ1adL7JgNZyFGXO1+bmstL4xsdWLp1zh4IsKyOHDwbhUYc4i7tmbpS4IfmjkWUZDuw0BRzFX72fTSjhx9C+YSydW7Iyz/y+lMD4im0tZdIpZb4R7Q9Q7BbrkRr8BVvKi1ZPNUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BT/xQCmN; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsmSqUQ3omYzy6/zqkXwxuHQNznzTT3GW65isqc3XExaQL0rIZJMIt9BHBf4UEnjyMCiUlfJLNscQW8GIBXEgwBVXTrN5vMpbSLOvlrFJLPWtLG5htJBTjI+qF59rtVUnQbUOaH2SHutgMToj9tB5od/I4M4ABcDQNyoLsbbkV1YdGCXQ/knsXVMBqjx/UzvvMF3TjyK9Vobbc1oc8WIiAw+LbWHhBibNhM56jimdz3P114eixu+aI8YLjdRVVMqhUJU4tXRHfICEPVGeq8F2kofNNEk3P8j1oUjqh/adYRtkKR8uWPRCC+fXb8X7whgQEezkzkIEkCQ8S+9Hzh6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/DX3Q9EYi4KMa8NNWzr4ViYm4Mk+zZZmk7itgClLsQ=;
 b=yOV5e/hJ/w0WlNuGggpds2WOcY5ctoOOLqv0vu9Ehl27ntI/KVnVK71ib6iztKpCvwh1GKnOXq48ggXI1WqvWuThenqFcJqWZoDrImw1BpHqgEivROvVnL0qP4MD1KRyNMca3rRhJBfTk07f2Q/PS7tpVG3amZQrxugDFLwJhG9URtc3TF/z+lg+GQlyXj1DPSlXnI4QAUJIp0yWuomraWH0/iIgAFjn9nqNrQQfSkyTZ3YuwzdEbLxni5TpHLbeKFz6SjP56/I+I8ermK4r7IJQEYRp3fPXZ/xla3GiL6JElYUIXSeFckfyX71H5clIyEn/woeWiIf/g5xGaGxuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/DX3Q9EYi4KMa8NNWzr4ViYm4Mk+zZZmk7itgClLsQ=;
 b=BT/xQCmNJ/3F4Dfr0wmlVhhVph15+5sV1M47LkkkoJCWFNqCc8RrR+hXBdcdb5JOTs0ON+WqTohQS3iQ70f/XtSoOXHNFkHTNNcVT79ZYZbUtTZ1ORwmUkS54usL+T0EarXCc3ovEu9/D2ffPB9o2K7w2rNZ1Su25Rk8fwqbDFf0YzF6F1CB8527r3Pf/544AyQ1x9w1uJmznUq9Ebog1/YGLiA+EqM5tLaKteXd+dh1tr6de/jsdhMqTMZksGQH65u5EeD7iFkpMMgBVky99QQp73zLz1OpL2IYNbW8k1MQWqe/LNQA4Ufhx4+/c1S74NugZKY7BMktg1yCzRQf8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7875.eurprd04.prod.outlook.com (2603:10a6:20b:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Fri, 20 Jun
 2025 03:15:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 03:15:46 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] PCI: imx6: Add external reference clock mode support
Date: Fri, 20 Jun 2025 11:13:48 +0800
Message-Id: <20250620031350.674442-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM8PR04MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd91d2b-b22f-4f12-0c40-08ddafa8bf76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VDXtv6cAN04pk/jnvUNEMPBs1dUGj2dkaA/jQ69c/yzXuQ8GcpuoblY3N5pm?=
 =?us-ascii?Q?iwFJuwRuFmZXS6CwxkSqHPu1HlqjknTfnp3BHklz87R5a+aQ3IDnmsL5FdGo?=
 =?us-ascii?Q?4TB3EvIwNivsCsvHuRBGbYzhyxCmC+fLArF0UmUX63j7sZhf3PSyUTHjgYGJ?=
 =?us-ascii?Q?B4kOZE9ZOXzVF09y0SC2nDkh5bS6SfPaWlzXscLgDG70iBjcziuJUQshgXXG?=
 =?us-ascii?Q?ajy1wFosOVzDPH+I8AHKUOgtFdK7tAMZJCnLQ14hMaOR/CRY9R4VMRLYVJ9P?=
 =?us-ascii?Q?JySXydiu7+VUguFlupw+Kvdjb9tgZ5FbkRxo1/klXz308fUclnyn9GoL9r7/?=
 =?us-ascii?Q?EUsN/SeOedXFjnKTEiPjny/nmtcFl0e1PeDsQXuzYYAC3KymRYm+aFEaGAXH?=
 =?us-ascii?Q?iCYTkUQNqIf0+Wm523ogQakKkQ2qXHSC4v5H3iphGQVV4GSy5XrtiBMZXkAb?=
 =?us-ascii?Q?Y/geS84ahLhY7Jns53Y+SQmdfN+UGcX/B5mEeBA/5ECp/3/pU/s4SQSlze+h?=
 =?us-ascii?Q?VXdE9SRjIZxTWUhZWZLvkpzQuf2TL+GnPG10EcZLjNdNQ5o78kHwYkiAeENl?=
 =?us-ascii?Q?6QU7BJSUNOCN+mzJEZkLDMEwXmQCr8CMST1Fw/AHXkPKAuZoPJ2FvGmrpc0Y?=
 =?us-ascii?Q?PI8VR7UIfc38LxKw7fz+6sT/1i9Eprp0deqwqAW41tc3/kiFGt27K5MnmyOl?=
 =?us-ascii?Q?M2lCNEw05b6iwLt56SSHCG6Lv1ENUGefo/7uHuEWgXgoVc6pzh4wYCOkGD12?=
 =?us-ascii?Q?RTxb+qRp+fu7+864fFPhf5f6txQwZwDdNYsUS9PtumnaHLKs4VtmAn+SWCun?=
 =?us-ascii?Q?CYQCeiQhc0uBdm+9u21kZXmFIn/7pU6Mspwk9aNrzIvpSbpEz6K1rrvRPGUV?=
 =?us-ascii?Q?yV/U+/iIDi0WcdK6rbSQIJq+ILUFadGXVa8PpVT2AVvtp5EoI+k99gVA0ZT1?=
 =?us-ascii?Q?2xFkOXQLCi01pJ9t0oD3QMVpkxLEwe5Wg76P0vW9KzllEMBZtgyIitfDHfZF?=
 =?us-ascii?Q?FHEwDTQ7oCEQ+AJoIhl+jfBEB6TpXZlmhTs8h1qPg8zMClND3jBy2fg0k65W?=
 =?us-ascii?Q?0qoDnJJRms8FjZLbgN4+rgQ3y3nWrZqjWnEp2u0t+uUhvj3Mcziu9JCi+CIH?=
 =?us-ascii?Q?0WGyyqXFLwJiUrcqNludGSB4A30G0r6D+d/oPoKtowg2e55HNsPocDcE6ZYY?=
 =?us-ascii?Q?5BmmxFUjpAR4+z0X3xu134IOSZEexsNBo+7oAgIaTjJXWRM+O7y5t4vByoWo?=
 =?us-ascii?Q?gFeR/eK+NLFSluC7B4iLiohNK0/fc+CYO13XamD4RvSOD97vBLuFdeYoesB2?=
 =?us-ascii?Q?hcoMPnUto6HxIbyY8im0YDo2I7hl3rfC7fd5FHJmNy9NWpHeluPVF9ist/rV?=
 =?us-ascii?Q?C5vl/Y9isOpdpa3AqU9fZtpyH/HCm3bzyA/Gx071TUzg/0FEmCe4HS4ZLjuz?=
 =?us-ascii?Q?lGhwowrFtCT6nxlHGEjrn+y/OC48RtyHiqGzOfprCsLopPmBS0I/+wB/aaO9?=
 =?us-ascii?Q?sZ+aWA+Ev6/kbrY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYkifc83sgiqgRe+Hpuk9HC3sCsnLmSmBZtOuLtR6p8KK9ggUM5yFbuvxtGI?=
 =?us-ascii?Q?XO7QMCs6GLqlNBZ8NllIQPTSGTDX8zs3q2YGuUmcJPiYlJ8lTNlhCvVb0cu5?=
 =?us-ascii?Q?QV4mOLbMNajvuL238AjJ9VdZoVbJNUgsIrSMUKoBgfdBI+0M4HJn0gI/0r/Y?=
 =?us-ascii?Q?ubs8ICasbV0AMqdVBRdlKx+BtpkNvwMLqJfb1zVfP9msypYF90ZM37+GVUCX?=
 =?us-ascii?Q?RB+Ofwwzn0+v3pimdVPQMd4jnf7zEzp6ZjVnlIrqLzXEIZ6xa7LowtKcZ0J1?=
 =?us-ascii?Q?lMfBt0eG/+UHqAjfaua9QE/PSzqv8f0aB78rILoI15ptXJuUT+J3h+kX/5eO?=
 =?us-ascii?Q?z1JT86g1bCyyoRZnnlpStJLWRBO9SJV+oqdaRTFHLN+pUm18a1Co2glD7TbT?=
 =?us-ascii?Q?0He6S/4a3WSW+xoWOcUmaP4GpyVOy6J02hmrioQx8oTwv4roUFKTWZYTFnJz?=
 =?us-ascii?Q?SYMmjEO3xPDAv4j1OUh28MB67N86B195Iu6PrQ9R5rxy21uOlVfqqdqYhCI+?=
 =?us-ascii?Q?Jgt8ly2+Vg3hMZJoIdHd3g4tbcppDkJiHZAdX3/PthGhKRrVO9oLHEF3af1j?=
 =?us-ascii?Q?+sEp4xsUxkRkHeknspaiOlM237TP2jpd/ObGCDHXk6J542j5vtaIWoVBq7Xd?=
 =?us-ascii?Q?yL5UFlksFqbKs/q9Fy4fHdP2OY4aLU4eeYYvNqFeTXYyzcIlv0JwM+iVfVJp?=
 =?us-ascii?Q?Yiwh2c1/c5EQKlatXQCvq5IUpk6hvpYFvXzeity747qIVSbFDEVYA1FizIUG?=
 =?us-ascii?Q?hc3KY4aomTx/pSopVPf3bkoJl/ACWpwYkTDMCReZYFqE+pstKH5wPssaCBe2?=
 =?us-ascii?Q?rhybtC7k7wzsKqv2JZ6KygGJIHUKtGGCDQzH9CW4Og/id/ZK/XiNqlwSsDxM?=
 =?us-ascii?Q?6Pz0bB494CSMo7xYb5HXJ+qPyZFDmBtck/UO9kzfF7dJ348em/g12mZzLVJs?=
 =?us-ascii?Q?FnAKsh+g85pTYCN33LpSVPw0ElEycezU21upuwbOziEzRK7Ivrrz83coIeLe?=
 =?us-ascii?Q?veUjdLeu5xTmxCoVDFwxZ9IQ66ExLFrxCMWn3SivsCvFIx6rHbNINJ1qgE/r?=
 =?us-ascii?Q?iiUEClqgL6JZs9xJheK46VQwDifQ3W3UhPNTd9Ij6FhMN/i03lL+5nZkSQxC?=
 =?us-ascii?Q?tuiJtQAW8CdSTVcngT00xbcvCjNiNjweheYaxoBChoU4v2FWD76jKlf45KRD?=
 =?us-ascii?Q?Uz0iTYNNFQ3LA4QPjixpLSsLSNJOA05wfAaBQpKPRKWcD410/iatouEEVRHC?=
 =?us-ascii?Q?KowP+EdfE5DhO8/LLtU2I20fvcGL/u3EdG3bGwPpdo91SNOJL0t9SV8oBXJm?=
 =?us-ascii?Q?5T8RCJYO1QCFccQeeBm7aUQHHi0IxLdzzzT6AqPKX3Sg5tjgwmbZyCCkFrN3?=
 =?us-ascii?Q?RgXu3PwibKXQ2ZSLWCZ5wf2iQZME3wEECkR+a8a943A1IefGSrOtTBkf6Twh?=
 =?us-ascii?Q?/KLnePai5YeftL+B2f/C2WDKY+EEvbDLgOkjkHzGmDdwetArFY2v2PYBbkzt?=
 =?us-ascii?Q?AhbkkgzhJJbcbp9WarKpCaIYLuxG8KLqHo0R4mAzcw0WDXBNdO02mHvVtJuj?=
 =?us-ascii?Q?FlJgyjQbWYUvgnKSoKU9aCYTITqhepAXLPlUBtA/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd91d2b-b22f-4f12-0c40-08ddafa8bf76
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 03:15:46.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rH9v+/NKKtri6RFeVofCzC/Ugnlv3fHjBLMR2J83LYk3vnUo6bj+euYSDxKc7c9bBY2Wh29fbDcuEtSL72M/Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7875

On i.MX, the PCIe reference clock might come from either internal system
PLL or external clock source. Add the external reference clock source
for reference clock.

Main change in v3:
- Update the logic check external reference clock mode is enabled or
  not in driver codes.

Main change in v2:
- Fix yamllint warning.
- Refine the driver codes.

[PATCH v3 1/2] dt-binding: pci-imx6: Add external reference clock
[PATCH v3 2/2] PCI: imx6: Add external reference clock mode support

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml |  7 ++++++-
drivers/pci/controller/dwc/pci-imx6.c                     | 20 +++++++++++++-------
2 files changed, 19 insertions(+), 8 deletions(-)



