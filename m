Return-Path: <linux-pci+bounces-35304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B73B3F771
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1882D16963C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646572E7F27;
	Tue,  2 Sep 2025 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ejP6wgHt"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013051.outbound.protection.outlook.com [40.107.162.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067232E5415;
	Tue,  2 Sep 2025 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800163; cv=fail; b=mb3v7U++o10pMhE3+nMotfnwC2BU5HfxhLX4wTOO8tArpMfG5kZnekplovYc8UDUWTm8+1bIHa/G1zpJ0fRjH/AgtdKN7e+RDlZ6+Q97oaHmcMNzwjxU6Q6jlQIKXRZmgYXHQc6r7i1a3/5VZyvke52ayZRgeziuz3gnH+asGjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800163; c=relaxed/simple;
	bh=ik8ODp0ukHNF5dIliZ32R5T7/fYysw8q+R+6FNNYG7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5D1Ex7LKzc/qf9OsGeimWCziCZhI1G5kWJ9vu27SpicRfdbokHwgsQiXyZgwZbeW9awRxL38ax4Njtto3Yq44q4rMzyyGjNEAiTDZt4b7SDvEiyEVsWQRZdDerEebHO00HVUg8XjCyvbC8jp+red90VbAH+5pxQZEp7YTErSiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ejP6wgHt; arc=fail smtp.client-ip=40.107.162.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iI4cF9eP0xw/JhWNVbfDGBbY7RAxOpSUZWju00ms0dja9OWtGfcMvOmNpKzHJFnY/7XPZNW1Ok2MSbxK+d8QBjbldVQaXNYAORu+tKblZ60j7UgEbLEBnYKubmmQAyNLn+auuECpAN5Xo/SPlBVAGb9yvJpmauVbx2URICwWdAVn/h/oXNbIX9rnI4f4MZ20NQJLjeUanw5RpM4l2twuSD5WEcasIJp+M39J+r30c9VgXAr5e8oARkRtIyJT56GaDNxD4RxDzazZxQJVnmOQs4sGNOiKxYp6jj9gInrePwWZPvLTDxpsoTczuuGpldMbVft15L5ZloIQZSoSeKd5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvna23U5EPjbSGxv65hfsAGbVVnJHNLpBOLlF7ASCpE=;
 b=vbRWoZsgKDSeK7E4D9GolUYVw47kuXdY2NIp3ABeHoXDuuwKLH6yzXqPcXLGbl5CN/6hykDdHiN3KMlXyI6FHyZqF/cxH/XzOGl1YYmQo32g2fIgT/lIbhN414ftp5+f1lXpSlNxhajW6dsTC3nreLKyfxFKNmaMIMIR2EerakcZdVM3LUYCigmXdm66yQI23+XazB3o+XDzXboAYvHWsaLNZDDeQdWxrYhjrPZq2ELzQWe5XPZT+kjN56yCZxdzNroKbqahwyH1f8rdPfqJ9rXi2l2MWpqS9AVHk24Bn9DSBmdANWDTIK0wLStfzPcW1bQMCwgNZrZQ2IfETDwRwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvna23U5EPjbSGxv65hfsAGbVVnJHNLpBOLlF7ASCpE=;
 b=ejP6wgHtvwRkR/8Siv9ICnAMmL82wXu1yP0aTyFrP9ftTveWJHcgI2EcXzoGnTC6QZ7f4rDExXuW1hSfxFjc2zC/zUNCZwIfMOmHsc2SM35zzQRJyY1i+6yHP781JoIayTRRiKJCyIu/UZizafwEQ5pS0YR8FaJBl8FSKYGJ0b+9vPSrEmMV2sl4vZwgWy+MBJQuQlLro8H58OGr4ZMZrxGuMLc2xm8436NqRHysgE3gE+X51sgbVriHJWkWKhJqCEi+QRM1QFBe2hmyIzXkzmJ/BBK4DsGOfPW/akSJiC+mPVESlGVt6w0+2E+rYeGmf64L+BW4CsCLzQ2cAxmxgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DB9PR04MB8265.eurprd04.prod.outlook.com (2603:10a6:10:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Tue, 2 Sep
 2025 08:02:37 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 08:02:37 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5 1/6] PCI: dwc: Remove the L1SS check before putting the link into L2
Date: Tue,  2 Sep 2025 16:01:46 +0800
Message-Id: <20250902080151.3748965-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:4:7c::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DB9PR04MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e2e413-2634-452d-2deb-08dde9f7147b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cGodmlZ8J4LvsGBWTiGlCM2U/wh3HcXoyp9io5sEJu3QeAeNrsOI3H/8xOm5?=
 =?us-ascii?Q?QD8BreiAZCyoSAjl3r3xZp5a0mhC5O4d2qxr7JRaXy/9eUIjM+jre5wAoQl2?=
 =?us-ascii?Q?77ECHSugnLwWq4SXlSVzj2gONYaPf/31DGsWqWig+qD5bMxXvrMfRaotI6L4?=
 =?us-ascii?Q?V8lHrqpDS7F5/qgv3xhfz+OIRoB1xrmEdiCGMH/XUflzq+2e6BcjQ6GGcRjq?=
 =?us-ascii?Q?P7+aa/3ASI2E8EZcxL3Qm3LVlOR0t2UMf07LKn9rVm3NCkJq16pe5EP1Vxtg?=
 =?us-ascii?Q?CevKJrE4FYc/X+9Am7lk1DJLSMc8xOBEL9WM2h95FEJmGelUyqSQQqgfGB9p?=
 =?us-ascii?Q?3R0yKxrq13gsc+gABzAthEGhAxOBEYwuaCNwFktjRlYWxd3Sh4IuxkjolqTH?=
 =?us-ascii?Q?7Bch9ip9M59fItbUqtNbZ8QcEJbliJJB8O5I5rSe7WRBXB73I/cr81/1tZxY?=
 =?us-ascii?Q?2a6+QJU+C2/vZNqQ/wjiNi0jh398U4IndYzufgF7tk71T1QVfPL7IWy3hKfI?=
 =?us-ascii?Q?AscqJYb6aUWAbza2IcnC/z2iI0L+d21zM7cJIcF6NqU1C92UGnNbrl5vkVBd?=
 =?us-ascii?Q?SW9hZwnnOrkRMy8uzVXReBPO4HQUXBuH57uTtpcnB9GvfCwQvWY2abz6RqSP?=
 =?us-ascii?Q?mliEcWQkL66sBEbuwQ95c3gC8vh0CLw8ikbhJjJQGWCNsNHeW9IrMhP7th50?=
 =?us-ascii?Q?Lma/4O0r3HksF8dFuKw1uqdv9mihJg6x8mdHtIKqDvlvuKQ9/eEA51s24xFE?=
 =?us-ascii?Q?YxbqOYTfKMZ9seq59NN2lrpUfSc+Ol0pzRH2tzK+a1+Ww5qXvumH3AskYa5T?=
 =?us-ascii?Q?9uipSPvqq/4vdsSNhz0wm1LdtNnkG2XRTCNTvCxz9C37cJ0nK5XWjK7jem+U?=
 =?us-ascii?Q?P5ULP5vO+RTFpgO21PrrOgGeF+SmIthB26T5HBb39CnNyZsIZnzrTI5SBHkk?=
 =?us-ascii?Q?2x7QYeJ/9zqpXUU4NARm4wlbT/1LZ8tjTnHi6M3y1dO2eaprYxR/pYZ+qZhT?=
 =?us-ascii?Q?wb0+l/FMlvCP4DWtn6p+4g9x+uNQuNeBmdzkfZVbPy9JYfrJkb5irVN48CVO?=
 =?us-ascii?Q?g8eFGdP9SO3gZDjtgEuInzH04NX5YLkWOAc0Pi3Blj5GUOJGqZ7B/RkZtW3O?=
 =?us-ascii?Q?uJVSY18g65WEXpd2Y/bmHO/f0zwojuUluwNPKH1KQiISeo24M6Z+WDHEjovh?=
 =?us-ascii?Q?83WI0PfEJdgs2bO1zONmnKC34xJJWRmpAueUnd5Vm3wjlACRMSNZgP89edfc?=
 =?us-ascii?Q?cv50PVOGNGFzAbazj9T4eU4OMWMp5bAWaa1Q1mXLi9jIogaiU+VNFeNxVX7O?=
 =?us-ascii?Q?ZFfSRN2QTbeUCi2TvTJ+Vwis83OFiP2qMTJTSpwrNrVjlOIca1iZpJZ2kd/H?=
 =?us-ascii?Q?2TWnedTRvxEXoWmg8VcPHVWfTADK5/50cDKJv/vbIgWigbuJoy3+oNxQLEAc?=
 =?us-ascii?Q?03rhRqUdnUUy8HZwCcDbRlgHNFZkW/jMDcN2CXNExwHxb/6aj497HQCWQbnd?=
 =?us-ascii?Q?qkeBuX2OHyP77jc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T9GZs8iz0PFTYN9YbonwcT95FeZuqXYzEbZhmwYYL5uKVXvigBnSxdZw8p1z?=
 =?us-ascii?Q?F3K2ntES88WhPtN5U0RYttXFALAjAUC383VNQXTVliayW1KmXf1FJrRl3iT+?=
 =?us-ascii?Q?0EsT0SFyzuM4MpdpQPeVck9bRQKqzCPUFJcENxgFz9vBPZkXpIEO0no2HUfC?=
 =?us-ascii?Q?YT/CWNE2dfxyVja0BUDDnRJdp0nBXwmZUEv9XOuxLRA2V0xhCAhQqY4AVZts?=
 =?us-ascii?Q?LpYx0UNOzSOuB9q6K/r2YoqT15+R+JYdys/VYH7P+l9FwrwAa89QNB60gJzm?=
 =?us-ascii?Q?PNBJBtlTaGICBA3IKumh8l5OuexzHDcyqKMEBahoj6LJi9P6bICgLtgzslCI?=
 =?us-ascii?Q?EmzCk6vFNKGWbHOXzUq9kyqIScvhsUjNLDEOEcZs5yIAzK+qtBm8afI3SO4k?=
 =?us-ascii?Q?RPqzNkp8SGk4z/6SKc2v6WkJFLlV+8h7k4nInsBVN/AZGBaw3yl0dJ7oqMhO?=
 =?us-ascii?Q?R0oiyRt/8p/EP04e8OHnc0taBm8OE3LtXIvqEcV7vWkvPklXU8SVh4O4qkFN?=
 =?us-ascii?Q?I5EfEe0a4rLfqIro0JiTIti6+Xd5tJ0TBRjhfhAPPPYPl6P85xjGc5bV2rJp?=
 =?us-ascii?Q?u/ZoeVEik2VfnwqxUlFJYY8SLr5ODSL5arky0BtG64yX3BKCcEuTg+p7aPe9?=
 =?us-ascii?Q?9P7gVjADdR4DorcdyWxiXeFhSQC4/XbQ3GMIUxArtA2Fg8ssVTLohSfjrcXB?=
 =?us-ascii?Q?bVAtZpk1jKwKHqNBZ76+2u7PJoSmZSefc/l7uXydIvW9tZlhCL1enhnzxYNU?=
 =?us-ascii?Q?dqw4NoU8wYkK2dM46babnvTZhP59BQGeLZu9TiQWsPyCbur7N+C7XabE9tKj?=
 =?us-ascii?Q?wT7wVNFU6VhWGiYlsP8OM7ITfWh24q3iEnpxFtUHEhk3o2t8UKb9xQGhZ1Sa?=
 =?us-ascii?Q?eY2j6GMLdIcpqXdnZ7D5GQ+rMowaISHYNvmh5FQEP7GJV408vdSI55bHafKF?=
 =?us-ascii?Q?wkxd4zqaOF/7EEaSqCt2jcv/lVJdBKrl1Wh4s8iNRwh6AHAayEdPdWQQMRXy?=
 =?us-ascii?Q?heT9xgeh2CO+geWFjywrUeddTeBbBuvn/5IFND80wEwxHZDdjiQUeMIjdDo0?=
 =?us-ascii?Q?47pZkImF0sl6N5rDxjpupboLdyPeZR/5Kcc1lXzOhnuN+DV0AsyoSrrlt1CJ?=
 =?us-ascii?Q?Pkcicc2bNP6ZxTIZV1idJHB43e3jzG39g2uGe+vk6tUaAAx2Q9ppZ0FYjUmx?=
 =?us-ascii?Q?dvvtoZd5BNCIUV0msq8iioSHj69jSka8U5S4yHO7K/EhM4kJmDNCOTQ3EFPU?=
 =?us-ascii?Q?7lVZBztIUJXyUFQEJq0tBdDywSfDTIOebec74L330rcbikmS7HydXWILr1cD?=
 =?us-ascii?Q?gnp5Bpl4B1umjBNy9KfHAWumQw+Gy8LaT9WbeWhHL06OTy6lVyLQsJSgG0sD?=
 =?us-ascii?Q?WyoDpD0DzqdE8nEr5lKFFAg8M0eP6JPZgF4Ep+6NVnuLD9O4YptFDejgrmql?=
 =?us-ascii?Q?QfmM6mpdgayzNsX0y+2INwIAxyCEx7cj/IMPNzgQTskDGs5nXMR2sd9gpnP8?=
 =?us-ascii?Q?ciYig4veKABa1rafMWPeG1WiRxKN4vjxfRQcCadLCZf/46BC4BbQKYSD6WbS?=
 =?us-ascii?Q?tb69WrT399L2CVNUX2MXs+KGuT6r3PoT5Da1DOx1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e2e413-2634-452d-2deb-08dde9f7147b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:02:37.0139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbK4BYqM5gCiUArBQ0GvMfVaNdWjVe0aeRA5j2AqGLmrODFy5pofYiXWP5GzyrTwkyeCFWVRBGy/A40ehh5j5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8265

Since this L1SS check is just an encapsulation problem, and the ASPM
shouldn't leak out here. Remove the L1SS check during L2 entry.

Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501..9d46d1f0334b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1005,17 +1005,9 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 	int ret;
 
-	/*
-	 * If L1SS is supported, then do not put the link into L2 as some
-	 * devices such as NVMe expect low resume latency.
-	 */
-	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
-		return 0;
-
 	if (pci->pp.ops->pme_turn_off) {
 		pci->pp.ops->pme_turn_off(&pci->pp);
 	} else {
-- 
2.37.1


