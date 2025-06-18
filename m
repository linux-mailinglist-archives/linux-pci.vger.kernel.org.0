Return-Path: <linux-pci+bounces-29994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E7ADE13A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 04:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7E03A96D6
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 02:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4EC1D5150;
	Wed, 18 Jun 2025 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UzWxJM65"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B861D88A6;
	Wed, 18 Jun 2025 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214615; cv=fail; b=nvDaLK2yVZl+ToRg+Ye++dl8bn7u9qdJes+2ECureSVDFe26/W3Tom+qYTy3yXOBJ71znxyGUaII29QErU2frHJ/1v07+9Qg2kJGbFhtOpp3/jYGIBjmSPnYVSCqLuQoYYurWwG+Jif/Vqk+lqW8WUIxirGTCD/nJf2jt+AgzB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214615; c=relaxed/simple;
	bh=YqlVWezD3GMQPwEO70LHZn/M1g75KVwlmcBaVL118Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V41vKNpNuNewHmtDR9CaWmj4yFlupLl7fwjx2w9r5haumlfYUgnAVNMX/kIPeK+HydhQgPVqPB8+hoLswDyZP6yvCoKQnAchHqZn5c7/IP6LOxrTRIlkzpdIHNpTHMWdQu8w3OUT2zg2BNoA2bXWbRmesEQ9y2HK/IjfQbgolaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UzWxJM65; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD9XpZGscV1CrRGnDX3u3c2boqZCpMffAo5hx5bz/LCOp+iRky3bZUHfkHDEz6Lmm3XPue4c0dx2bT5ISWOxwWIa/l+o6GqiYG8zbrZeEA3bbAE2/FmtgHhid/D0LkwCqYIDyffwqGFLpE4mqtUzHee18FtBZALP7oQA7OLvF2gJvmC0K2+K9V9z48edo/y1bsRE7bZS6lZuOecDEKFwPvWP8yqwAGpS5deHTbT4A1tyMv/ZEDZDNIW1ajZMGUzHNCLQnuclRCldOqZB54y7sRMY0WAKOES/Lbs9i6d5gARrBPwYAVXUKHVjAGvbk5Os4ZIF5MtJYkc7BfqvnOFsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn8kxGSurSMSg0ZHH/uerOoNwhNuGqUx87oqoWJgnT4=;
 b=UrXQJ3z6F7j9NEeA0bvUYxkqBjmATgwB2+fsND8AVudomid6Im7d4JGXZZxOXEVRLK2qJfOwOCU35rvZyJ6RBLNGdwJGx+heayS14tis93HUHtlcwIvDSZB/zo9HoEF+OadZoGwXLHtD+TdxsX6KOVCUDbA1wpUNYPLcs28fPOw4sIIp19c6n54my54e2VgUTCCj0wXv9DfbTa47nGAODYi7PxSE7i02hxmiao8R0meTBtfQH7xZPb4gf6zeAP0PwRBjQX/y6Ca0qkrj5MdFMvVw+Qh4i81+xb1iNyeyhCzNY40wT/+j94dQ7CjfsckP68jRgGQXPjKqweJJUAM2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn8kxGSurSMSg0ZHH/uerOoNwhNuGqUx87oqoWJgnT4=;
 b=UzWxJM65G4zQfc+TGBOYxFtwMk5QmWHGq+kSjrvCAvXRq+z//q8yrtxXetMQsZ4SI2eQH/PdrI0Wv6AK/8IfSBuVv2Q84COSdV3XaKb4Xki3ouKwuR0yhnE7EAIIa/EJBD6BDoIPyk+KAdt9FXqrTcMkjn8jIbQBinqF59tSTIh28QetxqUWWww32cmoukzNjPrh/0TSca83OjFqUvsZqfejhJ9DYiaZzYD3Gc4mua6CCiH1AC0JqVWaHHV5LIgnFJvGGzzHgPG0XEak/0FuNgmgnHaSzgFAI653A56wPUdnug3VbSPKKKp31PgeE8xtsyFNXJBGcL448vSzYZGMkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU4PR04MB10960.eurprd04.prod.outlook.com (2603:10a6:10:585::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 02:43:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 02:43:30 +0000
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
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 3/5] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is existing in suspend
Date: Wed, 18 Jun 2025 10:41:14 +0800
Message-Id: <20250618024116.3704579-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
References: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DU4PR04MB10960:EE_
X-MS-Office365-Filtering-Correlation-Id: a13b19c5-879b-4f59-067e-08ddae11e8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWchlFP5DLIpbQCxgg7tikrM8JPNeSOhl9nfjazhuvYRGC3aR36ZgCg64RGv?=
 =?us-ascii?Q?hGYhqip6gYM7fTgnzLrL1Vk9UtfWXG7ivLg5XbHIAijAKFrqW6S5oTvoeE8t?=
 =?us-ascii?Q?Cpv5esHTVNMtr1vujnI9eZ7DaubL2A3BrlDID7kZ2/de/Ampy9bSRncgj+hQ?=
 =?us-ascii?Q?Mu9WGXf/AB5tL9BGA/1pQSLllMZ0KpLsRrSgckv/64nONAS1kyVpZndkoo70?=
 =?us-ascii?Q?dotsEBNFmoiLUaMyez7gyoo77ehfniDTk89+ZMLrvLPTiY8M3UUaHvL/RkIF?=
 =?us-ascii?Q?v8/ZDSj+7awnXW9yy/RUAKuafIEcw683zt3I5ZItKGMQig2hi9j5SjQyBTNV?=
 =?us-ascii?Q?zEq5QKnb0qsJrCT/KBPRYSDWJEm01ccXi7CJ2BfvGYBQM36qWJgC4LrQAgz4?=
 =?us-ascii?Q?eM5WQCXkLf7VytPFwmkn8RP09Q/ZQ9cbkLafv7/3kozbFh5qjN7XYg8sZ4OJ?=
 =?us-ascii?Q?lUYfGrwVBm0IHyfpV5Fq8NamAXcLmxAOIepTlvr5kPqhqsvVk8l+bEVgvRJp?=
 =?us-ascii?Q?+7MTcJlkFN1bR9IN42yD3SOvBOS1JYi+tQ83l3aquz9ZSKhd0SgLo6I8MaoX?=
 =?us-ascii?Q?/g2FwChmrZNTevSA6XtD1iinr5pdenj9ysg6KG4i+suCe2BgnlJ94n7n95Mn?=
 =?us-ascii?Q?fhcCG3vecZfp2csYhVXA5+MRcpuUW1Wtqr7PuKjc/iUto5Mfhbk4Olq1Gf5T?=
 =?us-ascii?Q?xF052ySHcJOJkPK6dy7SZ6v1PU5lY1pAr6Zr0lo6ZaGiWP/idxb1G0QRCAlK?=
 =?us-ascii?Q?HxoAm5dY5FLaqVJnQ83bp4Q56GzuEjYRVsrwe25E/nL3TEUFqRZW33GtF48s?=
 =?us-ascii?Q?N6R+s9N/dTHWJQaGEvohPnWnqRdusK8ZN6n9G+JT5/8gd8jb+xJflikGJRnO?=
 =?us-ascii?Q?2tr2Cpv+USDh/USce44RnHs5xhkLSL9JlV/Pgb9j7tK1fT3naNcfR5T8PCKY?=
 =?us-ascii?Q?rnho5cIw5Q6RLkCibqxWQiuvskx1nrpDiRMXSNup80E8CUYMkP5/yP4hgzMi?=
 =?us-ascii?Q?N+9DwBSGKMqs0AeZ8gll5RtL8daoHXHT5Agz3E8bRExfHrlvcFdEFu0ewchv?=
 =?us-ascii?Q?70SUGaqPgXDZr6f1O0xwA67KpyR27n/xb+gTjk+7DD3zTtgYc9pOxxTaoSL3?=
 =?us-ascii?Q?acwHGvWa77R6PzDso5z++7zXqX2ldqjGe3SilX6tkKAeiuSnw0Y+ZKpk92He?=
 =?us-ascii?Q?NmUOUySEMYxJgcu9h3/c1zFn8A1qIvCOnSiPhU7TdLJQndZBGNthEo0E1ICL?=
 =?us-ascii?Q?C69Gh9l1UDOEb5lseckghOza4jFm2zw+lwiYZY1vsJzz3BuomOu1ZQWDLLKe?=
 =?us-ascii?Q?nM7oHpNwEQWqEboDRUyBbY2/MQbhi4V+g5j/KZ14LEImpkvvZ837fyY4WZAQ?=
 =?us-ascii?Q?bvBhdfD99kHsvOEV7piQpHtsTvydBNFppuG/qiwdQPGAWxmod42rvN1LCUF9?=
 =?us-ascii?Q?fty3b+kZeFI1uiLFF1Op/lOpa//giioEa3t0m7R2cg7foaQhWGRQHKoGRcvn?=
 =?us-ascii?Q?PBDTL1oZJQLuWWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rv5MCyLLjZRLV9ibcdHah7em2El5n9SaA+8qsugwsOmZItD5T0kyX1uULZgm?=
 =?us-ascii?Q?+ajeP7kp9YRL16wMLen0gG//fC6PeI6351HWiLLMqnmEJliTU+4mawSdVu4w?=
 =?us-ascii?Q?9alLht7yEu2fbfUp20DH3sq27yhonqiLw5k5KlW4AhMUCECwNa7Dy3EimHmG?=
 =?us-ascii?Q?aEHhbO1sbz7hijSD9AEoqBB+nA3TyJdGRrSzasynDuN3dXqc+M8kGo6qNqYI?=
 =?us-ascii?Q?sCnlJBYuEbV54cfiDoEPekH9eh3h6JgsNvE0kgAsvkl2ikju2uETWU28nM4s?=
 =?us-ascii?Q?HIUAvgW/a94ycXhLQKIxiLgPFJMpRtCQQp2f0kqzYiDLV9UOFekYCklS1FhP?=
 =?us-ascii?Q?MPJW7qn2F/l6KppF9pswPT/39fznIqliTD4sKkzxljU6CD8LoOA/d6/KtjzC?=
 =?us-ascii?Q?vhz/MNdcc1vQypjA2wBwqoAVMFJJcUOybUrHteTighZerhS00Gqy2LSqQ2hj?=
 =?us-ascii?Q?spJyk8mUYz6wpJMh//PPQ1qVCLTZst3LcCSGa8DUXVeVpuOpYRU4UUXAhyNS?=
 =?us-ascii?Q?zsXviSukuPC0nOcWVWrf6m4WE2/BfewFEu/uDLYk9j2b7vLa3Fz8Z3VHGQPr?=
 =?us-ascii?Q?aMM8bXzRM8NALeVxACZu92jIbxSiV/ryivDOmn4NxH1j3a2OkDGC9hsSlWX7?=
 =?us-ascii?Q?Oeu6dXyeUimdF1GDIUiKkxM4TyB/kVtE2SXNy/n6R4PuDSXyzyd2LHuZf6Oj?=
 =?us-ascii?Q?xgIB+RPzBSJyFUB7WjfNOiEm1A9RT3x6q7i85Cbq825t3cz+pKaDvGs455u/?=
 =?us-ascii?Q?Z5D42YbkY75Ap7HM6f1UAZRne0UxWbkA/6YqKEowje1gZ9vrOxlG7K8kv5Vc?=
 =?us-ascii?Q?5f/OTbchqulqKlHeIn3o+kWGj+NX1bbmEqyN4PXEh/JhBrHkgHlCjEUUPFBw?=
 =?us-ascii?Q?VwHGj4uu6xTaVFShxX8vLGd6aHsjx1yzV7HQnYPGC0W33rjAty+GWjKBKWez?=
 =?us-ascii?Q?uglTUrvxaBmqQv/ohdcrd1z/Iaw7hCPjpct+qeHFH0WOiAQiOxSl5Ivr2OnL?=
 =?us-ascii?Q?8d8rMij3ysJT54X1gobHaG6RJhQMF4zoPS8p4Zf6l8PwgLxlyp22Jl3axqyJ?=
 =?us-ascii?Q?qcNIH7ZKQ8+geb6PkZCCdr+ZP/J0nF5bMZIr2OI/7Nh9vitkGRTRYOLIczOs?=
 =?us-ascii?Q?lSV6+TGsVUmOnYohkzv2bEJwEdVuoDk8ZBcwLC4qPjb5LR3UGiPKsZHTuVUv?=
 =?us-ascii?Q?pXJ1Rbh/DbofSjSg0M7pOIeQfo59gbfHJJul+4vPCo6vx17UPe13NgfvGtrE?=
 =?us-ascii?Q?gAfz3Oc0jEqjaJlkuR9liYNAY6j7Mq0h7FMNDBnwA4hSL9mVTVBqBkbgESrk?=
 =?us-ascii?Q?b516CKe370J0eALGVAPLzELtWVKnT+wW83AfycJvipplhJFGJaWFQqhEUGol?=
 =?us-ascii?Q?nd11BTGWjkRknMDk4cR5vPKpfCceHeHLloGfAL0rODn+HKUjt4VgMi8HvwSo?=
 =?us-ascii?Q?QbP1QBK8qy2duZlMRP5DCmHwb2M7PVaaww7/6D/SkpGGnCnyHeLvRL38eyyR?=
 =?us-ascii?Q?Lfjllx8u4rzMILQwVGt7hfkYqoALnxBO3x7wSDjljeJiyMc7Run3PXfE8Q3M?=
 =?us-ascii?Q?xw9Lf2+jIBoX1dkNqyLpi+rleKrhDgMtNR8wiFn0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13b19c5-879b-4f59-067e-08ddae11e8c3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 02:43:30.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/XVGJ61RInGe3tawJUSDRcMxl93Q9kR9hKw3iVAdVpUANLXAAGU+nrOVQsR/GZWHgJYID+F36VAZWNfyARcfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10960

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states are inaccessible on i.MX6QP, and i.MX7D after the
PME_Turn_Off is sent out.

To handle this case, don't poll L2 state and add one max 10ms delay if
QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 31 +++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 906277f9ffaf..2d58a3eb94a1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1026,7 +1026,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
@@ -1043,15 +1043,26 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 			return ret;
 	}
 
-	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
-				val == DW_PCIE_LTSSM_L2_IDLE ||
-				val <= DW_PCIE_LTSSM_DETECT_WAIT,
-				PCIE_PME_TO_L2_TIMEOUT_US/10,
-				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-	if (ret) {
-		/* Only log message when LTSSM isn't in DETECT or POLL */
-		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-		return ret;
+	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
+		/*
+		 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
+		 * State Flow Diagram. Both L0 and L2/L3 Ready can be
+		 * transferred to LDn directly. On the LTSSM states poll broken
+		 * platforms, add a max 10ms delay refer to PCIe r6.0,
+		 * sec 5.3.3.2.1 PME Synchronization.
+		 */
+		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
+	} else {
+		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
+					val == DW_PCIE_LTSSM_L2_IDLE ||
+					val <= DW_PCIE_LTSSM_DETECT_WAIT,
+					PCIE_PME_TO_L2_TIMEOUT_US/10,
+					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+		if (ret) {
+			/* Only log message when LTSSM isn't in DETECT or POLL */
+			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+			return ret;
+		}
 	}
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ce9e18554e42..e35b19cbd8bf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -299,6 +299,9 @@
 /* Default eDMA LLP memory size */
 #define DMA_LLP_MEM_SIZE		PAGE_SIZE
 
+#define QUIRK_NOL2POLL_IN_PM		BIT(0)
+#define dwc_quirk(pci, val)		(pci->quirk_flag & val)
+
 struct dw_pcie;
 struct dw_pcie_rp;
 struct dw_pcie_ep;
@@ -509,6 +512,7 @@ struct dw_pcie {
 	const struct dw_pcie_ops *ops;
 	u32			version;
 	u32			type;
+	u32			quirk_flag;
 	unsigned long		caps;
 	int			num_lanes;
 	int			max_link_speed;
-- 
2.37.1


