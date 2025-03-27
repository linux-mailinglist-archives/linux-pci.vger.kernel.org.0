Return-Path: <linux-pci+bounces-24854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C9AA7357F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2111B17B020
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF60918787F;
	Thu, 27 Mar 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N2nOGfgS"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012007.outbound.protection.outlook.com [52.101.71.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2C154423;
	Thu, 27 Mar 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743088824; cv=fail; b=KRgr6z/GPt9eBkZd7CIGhrfsAZLnD+91B3YW854YFZ2yiw85awTQdHkXLq+BPveftzLSF95jdZzq3EeHVmD1ggQsuIGs5i8xKv0adQGVdri0FzMWtfknQyqILik2DbxQamF8LwRVzbVaU40O8Yhq2BH/Q4HExweSnxu0JWAq49A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743088824; c=relaxed/simple;
	bh=oMvQ9otym+TS1i9e/nyymwV/ZGSezTlffxWDB9J2uJU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nIH9jnB/iSyI7NHhjYEejdwcIxt5/Pt4C0pkb4dV8PJ5FI8q//8d5COn6MYOI2fEnWYoMWUaUT5zMEb4zTpPFqW1XsZWBLGKit0xpXUgPaiDMb33mFOgzhW7DUM9Dp1/y5ObJdFm+CdjANgwcsUDDc+7HNsqnDWVZxsEtRs+VKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N2nOGfgS; arc=fail smtp.client-ip=52.101.71.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXy1WDIghXbnVFeJYziroav25eWPD4P6eqhefQOzRP8bb2oX7+s/klASlNWRgnHUUKtpZD9AmSlnT4M7Jz+SyanBSKQz7h1BNk9BXUiWkMt6kPx+PCnnN+bK1JiaE96RGNzGXAI5GmzLu9zfDsMPPXO4JiVI6vVE/jBN6csYLCg69uutxf4+BnDS3MI46QnJBV2GoOjwGg9NoXhcT8j6CSKRnyPRw4JC5Dkx39o2xkhHBuX23qax8QTOgx/I3k941Y7HPSVRL+rqc2GCZ7bn7ajkd54iEG8uTrjNHPQalJWoz8ptftJOPDqYdXDdqfSavMYph60xHcUshiCpuGDAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOVa/c5APqWBJKyIkOgH/5op46fqMIwfZwq6pznkyT0=;
 b=h/B9Q4BM9s7WqXvaUyMto6XRYH0n7FXjdOZxqmY4IVMz+5ecEYcK0k89zVuaoJiDJxghn3ZPp3n3mcHKvJNjY1fRds9YYsDC2Cz70/mqOZq8bcYsbXQqyN0MoYQs110zD4IuGw0GK4Jv7HT49mhxjdsd9by1x5LY3GsbtI8HAdGKKqp0+gQOSSTlWdxcGUjJ3olgyYK4dogFzlGYBrOog9BwcMSyjXC8/7Omhd8MQbWjw/xXAwQ0O0X40Ryzift7x4IqiCvQs8mrH54fkmG6QJOANhNtjnaSjgarl2T70W1Wf1raNredb7z6rJTwV7ygHTlHKFkRgPDY9RxBnufkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOVa/c5APqWBJKyIkOgH/5op46fqMIwfZwq6pznkyT0=;
 b=N2nOGfgSquLNf2uOTATHHOp2GZrlrOVXuBfWcf3uV+GbUpLT0pQnGyWB5AKQ4dosZTY3y2EUW5qp6n4kcGWOpB7dIHgNh2d+9XI6EM9gjv+vPhuODzG0Z3CBKlfjTYZe16Spm8jjve4W+1NRkocMVvlokIkyY2OX/ws/MJ/AevJGfjNTzlIfuSA77JqYLx+urLKlvgEeo1L8QtHWJ+wpCSBeJtD9ip3rmICvJehXTRHB/udCOtsxzIFcM3BlIUj7c72CNJ2lf3QOW/my2j7ciQOjPFlI6h06BzyJuoDILtP2B6s+swgG2aXn0a9ooOsf16TI+o0B9801x2G9qRpJTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 15:20:20 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 15:20:20 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Roy Zang <roy.zang@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: layerscape: fix index passed to syscon_regmap_lookup_by_phandle_args
Date: Thu, 27 Mar 2025 17:19:49 +0200
Message-Id: <20250327151949.2765193-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0029.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::18) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AM0PR04MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 324c6d07-bd24-473c-2088-08dd6d42e2ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7D+fqpouWREg6WbFHPbau3wLNVyLMeC0gce0qS9D8ZY6ew2j9Y/eG+8dACvZ?=
 =?us-ascii?Q?QNdImDW76+x8W+pr9YugGf2s/uZZVzhppAe5VavQVu5LQbs7lLizv/6z6fTV?=
 =?us-ascii?Q?fVhk1s38OVXklh/+YM6VzpmL0ZEPE5jjttsJo+sh7SktwaCzbiSFwHiuPFHr?=
 =?us-ascii?Q?Ce1lnanPPPsnwuz0MuOy27zPa9LkIKBjAkHuLxNAChG4rXv4tAQv+5LR//xA?=
 =?us-ascii?Q?aDLWf+BB/R4KZQZm27qC/z+WvNSYzdu8BlVKBmTzPYNMSDLYfInFTo0KX9wL?=
 =?us-ascii?Q?27qdLtDxs0pv7Vf0vznRKteSzALlf90QMcCBInAS0BDKC7ZSCYixs9cQPIzc?=
 =?us-ascii?Q?Ee9J0Y1GThhkFGZvJt9gTTn7Ds9D0+spZ0Sfa3jFDHjHR1WEUgI01znP/Gbd?=
 =?us-ascii?Q?9KLu/NaUEPEEE4crbpsbMTdGcyPwi4tuycB8l39VZB9NhRwN3XiZtOyyB/Xk?=
 =?us-ascii?Q?6zHGCwK8CqDdZWTXmytltqFnJFZ2BvXgWGyu9B62IZf+MJOARVrOY1orRJ/H?=
 =?us-ascii?Q?oPSXntneUsk7Y6GpXv4UxADIoVJsMSKA8nR6xQykpyGb83lCFouJlbVAYLAg?=
 =?us-ascii?Q?kW/7GkMSnv+mKB7w5EVQBvnWd8swongccKsxyrJqxzmBDD4W//LhuOOSx3P+?=
 =?us-ascii?Q?6AlZeLCIkvBIU99lssipTk6T1HcjzdQAsxIiUKNmMzQQgEmR2RkAzx1D5UMB?=
 =?us-ascii?Q?B0dI/fd3pCiEKKKhU0oEkTFoOx+zwAUYs0Jg55IlUPM3gCHM7LsbDp8/cORc?=
 =?us-ascii?Q?5TfqG6C04EXMlamAL66Tetdpf6E9ThpWxiyyfcIWr1X+Fno36Ap6VAAJlmG0?=
 =?us-ascii?Q?PLYyaCH9sjW+7xHEkDwP6Y1T7owDi09+AItdUWeQHBl/hw807pPjUYwIP3dc?=
 =?us-ascii?Q?LOcqkqeeqUX7dHB0WJJhUP/+J/V765QfPhA0ZWd0HVCacPpXiKeZPkSoC1Np?=
 =?us-ascii?Q?1b93RLTQbKEYs32HjcSn4W3ArKezFbmoKO9PyUUgWvGzk0W5worJ9XklP//f?=
 =?us-ascii?Q?Qyk5GsF3VZRoyyq7MOPdFzYbP5XLtDyAJhCxe+La23nxfLCp/UV6foswggJC?=
 =?us-ascii?Q?JJRP2kzOll9G6+zQ1+QFpDjgXozwx5zFBpf+HC3juN3n5+NH99+fPSHwzKjS?=
 =?us-ascii?Q?cL1jpvk8P39GuM/Y7G4rJ+k+OCfWeKwmtcgaVNOtLWCD8xv5JUchkfpNMJNR?=
 =?us-ascii?Q?y9AMfVNvpWCFR6Hs7wPUCOxW2Uz75akQeLAoc9kquP4Z8J4CPiV5UIPqEVWN?=
 =?us-ascii?Q?LQ8GeM1T0MZw7CMApxEUmug3mUt5cAktDvmZ75ydMjnizejQfni/Au43EZb8?=
 =?us-ascii?Q?AiPQxdUeM/r6mz3iNb6a7cljiTlQnB6+R4bG0iAeHLoo/GpRGJv0SpEmorYM?=
 =?us-ascii?Q?NpF21mjbEWREelfBOU6sDBnxLphJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aLf+mTlM4KePEStOlmXPKAR+EvviOXNCzlyLJQwgTvKX39+89Gryjz+xE3yt?=
 =?us-ascii?Q?+7IGjGcl2mhqsZ3lN/EJUvb1gxccldJxss+6qetSbPKn1bvazap+/SvxzA97?=
 =?us-ascii?Q?CHR2sLF2HGpCCdAGFU0IQR29SQ6i+86XO0Ehebj6dog8sS8kk+GtyoJm2SqF?=
 =?us-ascii?Q?TS0WQ+XIAoqBLhpaqV/jeiPtFDN8AUuKjE253CWBfryHVQ6GDxe9z/B1W5Y5?=
 =?us-ascii?Q?5vNSx9eZ1gT+hxQJ/QTKQoBkdxNcNnvtuRkgKWhtir4friKIeOVCWMp+kh4F?=
 =?us-ascii?Q?+VkOEJbR+X23taBiN4JHoqheOd3qU9MiObA97zn6jrt+BIH1+xPCg90bNuYl?=
 =?us-ascii?Q?pWXARWxSMYFjpkV6EtCc/3rlJRyieCRorl6Em0U60WzC5DEGneCQsWqg0kYP?=
 =?us-ascii?Q?+SOPpCdzZwZ195wX6lBwGSPeNJ6qlFt5EZFgT8YYsov8tCFAMCAtRLEUOq1U?=
 =?us-ascii?Q?EA08cUkDKSKTrbcyCv5DWcnmTzL2LChOOWfOZFgj6Nl80zhuFRj4w3Hg3tJp?=
 =?us-ascii?Q?gA9rlu7Q6s9lSyLNg3H2LpZ6tDu2Hcrr03sXNRGRkDjMZgeq8a58a/h2MU0W?=
 =?us-ascii?Q?N56SKfs1NWGRw/L/1PUO5/ZZz0MNod4Oq/0xdzSiaX9F5krmWfOVpVQvuwTY?=
 =?us-ascii?Q?dCnPQzJDw3GGhbA8sfpglGWZeB0HOmofBDQQ/jijr7TX6vhHF5JjzfQMzJJG?=
 =?us-ascii?Q?tUsoTM7mXbHPO13bzoekBnDmp8fMM70j/ShUzIXpMM6ipFdtmj8lN4B0XIfN?=
 =?us-ascii?Q?13bfDsYx7+LHtj/EbgaB0+0yRn45aCyg8TPlMW6Xx7KkKw/HXJnBQmSgXDzc?=
 =?us-ascii?Q?JC6DVP/G3kgrfgRKKlDt+457QaRgFwIzetflJnTYhG5aVJg1sCyAZE7OhvJc?=
 =?us-ascii?Q?b7trX9nEMms/LAdN8dj2GVwQ23rs6+hHKWLGkPUlMXv4a8U2s3SQQdyK72zL?=
 =?us-ascii?Q?nmOSFeI+wtykrDjsjy0vSJq2569OeQZzM03YaaZwSE/QicEM6ntf377N26am?=
 =?us-ascii?Q?xHfVMO8esz7cqvg7LzD0qSNONRCQ2BuviYrFu8crCW+nPa7kfHK5XY98di4j?=
 =?us-ascii?Q?qRQsc4Okc2MbIE2lAkXYGg0ts8NXuugJ2Vc2yTH9ridLXeSF2xWuzDmNv1yx?=
 =?us-ascii?Q?xMlQHZpxCaz2llgjcQ3boJ/inZ8ldGQlz8Gt9tuRaV+4v0QfP1HvW5YLwunO?=
 =?us-ascii?Q?opTAtH8uuwhHZVBiESB7yHlG951gbyaFBJY2b12RIJa0dS5qaZRstF83FY9M?=
 =?us-ascii?Q?/my4fFKXNQTRY3UOXUKrI/HVZYXsiCfGeW2fCLCIbziBgK5Hj3eTk2N/QjRd?=
 =?us-ascii?Q?h+KEMhp+WOAIOBsfgAyqLosxNQmjqjrN8ciR0LOE7sDi10FLXpFQAk1/TD6e?=
 =?us-ascii?Q?j4hN//UxPYhvO92HuD51r/dDKPZlRtUzsbl9b3cTcEvN5waQ790xQ3geU4Kf?=
 =?us-ascii?Q?tTXx2Cc2C105ZvbOBRVz1sl8PZlASyB0+00Jelb4AeQIPxCRhXlvtwrJSMEo?=
 =?us-ascii?Q?1ychkWD9P2KxmYy1wmGqacGYv/waOQWIFX3LCqn7ir/TU5tEmEAPdRF93hDU?=
 =?us-ascii?Q?J33FnLikebjyhFW1F+vGeHclOoFay5+JmUMjSEPi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324c6d07-bd24-473c-2088-08dd6d42e2ff
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 15:20:20.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVBNNVhozNwOFZ2QmKmueJpUg2w7pahOdqua6wI4qmulXMH/eZ90VPdTMhB9PXX801MDNaSBWh/0iDCPBeuF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058

The arg_count variable passed to the
syscon_regmap_lookup_by_phandle_args() function represents the number of
argument cells following the phandle. In this case, the number of
arguments should be 1 instead of 2 since the dt property looks like
below.
	fsl,pcie-scfg = <&scfg 0>;

Without this fix, layerscape-pcie fails with the following message on
LS1043A:

[    0.157041] OF: /soc/pcie@3500000: phandle scfg@1570000 needs 2, found 1
[    0.157050] layerscape-pcie 3500000.pcie: No syscfg phandle specified
[    0.157053] layerscape-pcie 3500000.pcie: probe with driver layerscape-pcie failed with error -22

Fixes: 149fc35734e5 ("PCI: layerscape: Use syscon_regmap_lookup_by_phandle_args")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 239a05b36e8e..a44b5c256d6e 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -356,7 +356,7 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (pcie->drvdata->scfg_support) {
 		pcie->scfg =
 			syscon_regmap_lookup_by_phandle_args(dev->of_node,
-							     "fsl,pcie-scfg", 2,
+							     "fsl,pcie-scfg", 1,
 							     index);
 		if (IS_ERR(pcie->scfg)) {
 			dev_err(dev, "No syscfg phandle specified\n");
-- 
2.34.1


