Return-Path: <linux-pci+bounces-36636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B9B8F7D7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687DB2A0098
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3087E2FF656;
	Mon, 22 Sep 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E7JDtyPJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133022FFDD2;
	Mon, 22 Sep 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529530; cv=fail; b=giDY5owV7SPI1trPh7mq292EWn8uXhwUHaFg7ma+UM4O793gRaYqzJq+ye97up7PCfltA44q6VCHtYUiKbMOY4T6D9BkvMXpz6upbRaf0t8ta3Ath+P/FDjztmiqnjbqrgOyGpUL8VCSsNefzYEN8YTGWrw/A8i2EGc3H+vdY4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529530; c=relaxed/simple;
	bh=I1qTw34Q+mnekJr41c4sLRY1oBobnrGJdHSl31w1+Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LcLIRtdBrQM6tHoxV+SjSZR/86JYyOCM7p87K3GiLIK17FimWBSkwEsCi3Kj1eg6yg4+IDfabePexCX5i/5D7Duo6yI6VzIinot5xfwkbJSwQ2hNjb+8ghdp7AvhXQlbwslATQ2tw3n26mQqXMKCfEeYrfXD/QDG+ANQJLG4x2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E7JDtyPJ; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWDZIJeE5cF0D4d7yesy48Tt6vJmvbjfGxqDq2f/wP5Y/m6Z4SM53Gk4dGGUqk4J5OuP1qyaFAiqmR8uBvlnBkT8K+ZUCj4miPwVRZI/WTf+71VbNMuCJI52/ZoXQhL+esNfNf9mCXVRgbqk4NHUO0pWlseTJyW3J6O6jTLeJp+SfDwgEj/PgqhiUOF6o2UjuQZb/wgAKmQk8bxmBijpxavAVkBvpod0abGjyAL1YbAzyNrBJ/jbOrCVRuIel6pcvmVQSw6k3/LQ4agHebn3mkSYYzEpVhQ+TTQqIB2Gdz8ZIRjrxxlsyKJ1tcBkUEHj8297M3wmjRnWakNQBol4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GJpMYNOT9IOEm/SYaKqr927SdMWeHJr9WNnAD22u6E=;
 b=N7EMPe9iZErkJTmi6bLQmEE2FIoDBQ8gLYnwIqvePGMn6XCuTE0E5eTei6F7CAnnvl+J/82H+fMGmwqttUsxE5MlKMVrisvXDl4ubnSfZyKDMWqGHmAfDEo8Sfng6/PesuScR1YnXgkCbG7sskFXb2CiWb+QDykfRFcbqx1cCPnKpEiCAczXIJ6SWKmsvesoDdqWP3Zegi29ByYGsVNDfdXNkiJ6/SB1faTdOzxmF7gOB/omOb2YsgrN0DnMy4aZHZEr7L3fLk3JUn43kv9Y56qV3/p6jFkTBU3eYuLsEqfsmFsZNrsc7ZgClFQQDSyCFQurFVv2jEEMDT+PhDgMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GJpMYNOT9IOEm/SYaKqr927SdMWeHJr9WNnAD22u6E=;
 b=E7JDtyPJgMvSN8V2Enk45n0x8LSnPAd3JISfcrsL4sRG2/c7MTlS7ZQB/00TFrHTJ2dTFNdzPpuCDVrmIAsgH57dyplWw0UMYtYC00jFJwB+L0n1xLLQhH5QtG7fR6aHyR2rv7THdYM9S2xnkwOJR421HgorC0cnrFODbtCgyvAd2t8dtz4snjQSEI6+f4825oH0fvq5MdJbJtqrX744YROv944y0j4mFRMGnpqe/+3AbFjv0kLCO3/lZemzeqW1ETigkH+bKV8pkz608FMTi5LsivI1cB0DFdZJ1Z48tSRlEElKeh4tX/18mcVxGtKbP7LZSERI5AXbm/pnq7YJTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 08:25:24 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 08:25:24 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
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
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 3/3] PCI: imx6: Add a method to handle CLKREQ# override active low
Date: Mon, 22 Sep 2025 16:24:33 +0800
Message-Id: <20250922082433.1090066-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250922082433.1090066-1-hongxing.zhu@nxp.com>
References: <20250922082433.1090066-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a8f99e-5c2a-488f-0b5f-08ddf9b193ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3KJd7NeWZ7TWmota0As2RoZPtAa3Nt0BQYjcHpsORdTU1YJMnK8YZ2kT/2qA?=
 =?us-ascii?Q?FqGyW+ybyH7HbwAQNLaKzgts2mM+i2jtm1HW6ut5O6BWfSJDtO7/2j5DCDaP?=
 =?us-ascii?Q?k85OZ1GiKEAlXsdlkpmMF0SxzWBNatOLs6gtba8AYRAxab73EsKQOZsq1tt4?=
 =?us-ascii?Q?EX8n0yuc8DwJcKcwchVYH9voHnO/SCFEwv63mQz4lv+mlFiVDx9aUE4OMOQb?=
 =?us-ascii?Q?jiI1W/+qGecHKWOkQRvCIXMrbVU83k1SDIh8i/mWre2FgVPZLEQo0HkQ8x+j?=
 =?us-ascii?Q?6kmioLUf+QYNjOu4159wUJ/zJ9uUM+SgM14GHWo0ZviwarrJpzVp0U+lp2zz?=
 =?us-ascii?Q?/exdqr/1xwCr3RLoeLOnEJcqm99dpeYocmnLwM2kfG7K5CZmM0940dwzW2i6?=
 =?us-ascii?Q?SkaAh/qrEyhPODb7Tp1wuy5X1qDfZiuSR0lNq+VRNRjXtpTq8RuvGRtSNHON?=
 =?us-ascii?Q?1lINnyWzSO5RS7zHjB3NSxeLxYTt6duC82zKnI0iiA6tka4faH4sNJwZ1Tgi?=
 =?us-ascii?Q?oDPzwYr8pjp5+OSEWHM4Qqc0R1a2GViqecv4qLXJJDLg3KJjzkMUe1LppRme?=
 =?us-ascii?Q?PjCNHic0rSvYzYUcmEXl9E81x18xxxi96q8lWRed0RnqhqoFmpCW6jV9UtlZ?=
 =?us-ascii?Q?7AgWh7Jr3MdUoXCUZX5WSEffEf7dScx8mjuU8Ex/sMSzcfEGh1Xxr/wxiiyA?=
 =?us-ascii?Q?cUJeVWTq3oWWc9MMLUBLYyBWIofKQ7tzQHti0JJqNLb8NNH51JDrODkp+u08?=
 =?us-ascii?Q?VJ0yju7pfRGjW7N2duge5NABerbZEpLva7Jq4GY6LoZJPYwR/EAOIxp225fz?=
 =?us-ascii?Q?uWHbpq3BTic663jFTPS2mEG86YKO9Mubgv93CEkbt97gppvrglqp3hxt9EMp?=
 =?us-ascii?Q?h+YLkvVhRFbDb1Zt+jdQ1LZkNElHvxsBqLPMONr0CfDROL6AO61EMDD/lkKi?=
 =?us-ascii?Q?wxmuNfr6UVMKnKCgIi4+N2d4g69DPWS3/QOShP2KE6OqPhkXFSlpLbe7kjar?=
 =?us-ascii?Q?TObHflEsndG1LPZsDBIt7XSPivUGu3F3QzIflAtAT0xAoJpFynFx4170vujJ?=
 =?us-ascii?Q?AT4lxj7fXgIYMCvlj+mZTzTpzF9gz0XLIgjwkg0MnxSq8iii6qQ0IO1X5hrT?=
 =?us-ascii?Q?3dreltJL+efFK7Fn47tMOxq+RL0+ygZPyv1bBvvNkLQZmHt/uajEH6oKi8DR?=
 =?us-ascii?Q?ym2gKnCcW8tVAx9ZTAoUnAypdWNMV2WhL53F7swRa4ABWKHz7WT5vMFeKY/9?=
 =?us-ascii?Q?fhJvrMH6iHMqcHJHPjQK3l+pCbUPmm26QDX5uSHpeVHCMNh1kR3BAnq9bZOO?=
 =?us-ascii?Q?EqSksH4bQML6qGGLpcpXVi9HRFNqIyLKBWHsqC8vW/VeWtMAGRxTSY3DzJRn?=
 =?us-ascii?Q?V8dtUcLoBKqdI1dX0v1xGtYqmuloePC0Waogzukiygz/csmlcKV9SLEr0N0J?=
 =?us-ascii?Q?6X+0DkygnRoZiUEOmZepIe/gShHMWi+QSk0kjdnDSCxj24VcxmLeqYaEVED+?=
 =?us-ascii?Q?iGfsR0+1zRhFg98=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a7DJ2dEkSEklpprqZqfGI7dMggjKnvDTgpbhMpO3RjUuB1uZ5BamUleqDRdh?=
 =?us-ascii?Q?1vBY5qATp9Jf2L9TmUQrUiuy7zPJeHLZ5batm/0K5xkRIaju3ZAh5lecSiUC?=
 =?us-ascii?Q?5iCFfFi9acwv50nYMZ2UpSFU6DlVMlZH3dAxIMtOoP+g0v+S7yZK3OMcrdSE?=
 =?us-ascii?Q?zWOsUe5q3pvvPuioF9lDrYs9iIHVHgN6aQrRbx01GpjTPyqh7LoftSKTdlCT?=
 =?us-ascii?Q?/0jgWK0pr7MdUrTVfzktaboB51+IiwelnCWE38lUBocMySeK2kQIcVjzmEMk?=
 =?us-ascii?Q?HAgGcBmURuznJ7mZ7x7BuYwHRu2KJqGkFcpTLzK1M0B9ndPs/S7/Ky72bTsD?=
 =?us-ascii?Q?29HGKRnyFqsR7pSl3EkT0TGqBQRVvEkIXmRvMJ8xUv6yUVOwnHO6o9K8v0eE?=
 =?us-ascii?Q?SI1HRTZOPf6m3DKgotzMEvx/it3z/OEAHYA1fGrA5gDQK5pdVXM6NmxMr07p?=
 =?us-ascii?Q?uP7ZJ6qrQ19bfcAbYqCyMw/OAooD/5bB5V0jEBDNJtle/iBHIZv+uI3yy8OE?=
 =?us-ascii?Q?hY40Wxbp50YusZXK4aT7qE8Whj8K6ODm5h0XywNvAAIQEJijT5nHNRetN6Uy?=
 =?us-ascii?Q?kWkC8ghgO/IHn7Y3ZoLLd/4FlJcS+mMlmNCRyKwqirzpfb45FPXiXOYEf3rv?=
 =?us-ascii?Q?xMZfsueR2ISk47UcLePEJ/xeZzpNF/jXtmDZ/bE5xu2cEGkPqkkvOob5H9T3?=
 =?us-ascii?Q?QQaZwqmHEHfM9Jv5Fi4MJRQWA5TgkrqRFWPfwZZ8FMbyQ7GXmDrRYxjXBHKI?=
 =?us-ascii?Q?ZcxiHfGWChQs9sl2yh6E0z4NWqH2bse/RPx0Dqz5tIcJi3rpzJLEhNHwjh57?=
 =?us-ascii?Q?oTxfODSqzWzLzP4tUmICO7/lboAiYyaaWBW2ztjwjm1Iye4NcjCdJL5n2Htu?=
 =?us-ascii?Q?9FOjh4DyZA7nHEwV7PTAAsu2a+nDzL5cXXvjh2Ja29BPn6x13b3Jh+6e8oop?=
 =?us-ascii?Q?ZZhtLsafZer6E+newQhgrS+IEofL60XnNogeDK62alA4vkcuV6MthkDeRjLd?=
 =?us-ascii?Q?WCtu8qwWAqOdH0MEVVzi6s4Sb6T8Fw4ecjRY+ss2cM4W52UBr5rs6a4sNgeM?=
 =?us-ascii?Q?0jyF4jEcxkW4bk74xC/f1T+uSn9swFZSEXickW7QUhOosWc7bvoZiIuPxMhw?=
 =?us-ascii?Q?pp0dHw7nnsIIPuL/TIToGHrcafDvYav8D0udnx46u1hQuCmrXH4AoJDCwCw1?=
 =?us-ascii?Q?Q/HPo8lowh3BT/YlpN8+chTk7pYHjPNeqrDeg/k+52WB6dfa0eDqprgrkVkG?=
 =?us-ascii?Q?zPC7kj7lneyeYcYpqJF2qnR+ZUTw4thx5VJpj5yksGAcn/XV5S6aGdchMDQ2?=
 =?us-ascii?Q?DW/5F7jB7Nmae6JmcWMU6WM2oy6tlS1It1qec6ctzrmScHx9cS+bFLoM5VO3?=
 =?us-ascii?Q?POVQjtYLaYNc39jTWM6S+vp+b5L0KcoPVcK2jZJyTf4BA7bNCOkGPNG7/QC/?=
 =?us-ascii?Q?PXCnLEAaLC074U2fj1aex/tU8gHm2Dt7U0LpglgMMT9Q6GVGKofIeSHL8kdN?=
 =?us-ascii?Q?+AtjCtQ10Xykw7LfiQb4Omf+8Zhx4l3qKBZkCSXMLtfZdkup43/eUP7xySbZ?=
 =?us-ascii?Q?emxrajV+LcwWwcswp+b61UPpQPzy2baXFSrqEARm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a8f99e-5c2a-488f-0b5f-08ddf9b193ff
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:25:24.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUFJ6QqN5kSzFQ4Q+PVtngDaKTkeGtxlO2i0L9JDf8G0gyjZ+JMXxbx+xRu1d2xOvHSg3nGUxHTRGbMDOM2W9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

The CLKREQ# is an open drain, active low signal that is driven low by
the card to request reference clock. It's an optional signal added in
PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
reserved.

Since the reference clock controlled by CLKREQ# may be required by i.MX
PCIe host too. To make sure this clock is ready even when the CLKREQ#
isn't driven low by the card(e.x the scenario described above), force
CLKREQ# override active low for i.MX PCIe host during initialization.

The CLKREQ# override can be cleared safely when supports-clkreq is
present and PCIe link is up later. Because the CLKREQ# would be driven
low by the card at this time.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 41f971693697..6309e2e40593 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -52,6 +52,8 @@
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
 #define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
+#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
 #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
@@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 	int (*wait_pll_lock)(struct imx_pcie *pcie);
+	void (*clr_clkreq_override)(struct imx_pcie *pcie);
 	const struct dw_pcie_host_ops *ops;
 };
 
@@ -149,6 +152,7 @@ struct imx_pcie {
 	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
+	bool			supports_clkreq;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -239,6 +243,16 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 	return imx_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
+static void  imx95_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN,
+			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_EN : 0);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
+			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_VAL : 0);
+}
+
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	/*
@@ -1298,6 +1312,16 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	imx8mm_pcie_clkreq_override(imx_pcie, false);
+}
+
+static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	imx95_pcie_clkreq_override(imx_pcie, false);
+}
+
 static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1322,6 +1346,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
+
+	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
+	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
+		if (imx_pcie->drvdata->clr_clkreq_override)
+			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
+	}
 }
 
 /*
@@ -1745,6 +1775,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	pci->max_link_speed = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 
+	imx_pcie->supports_clkreq =
+		of_property_read_bool(node, "supports-clkreq");
 	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx_pcie->vpcie)) {
 		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
@@ -1873,6 +1905,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
 		.enable_ref_clk = imx8mm_pcie_clkreq_override,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1883,6 +1916,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_clkreq_override,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1893,6 +1927,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_clkreq_override,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
@@ -1913,6 +1948,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
+		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
-- 
2.37.1


