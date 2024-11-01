Return-Path: <linux-pci+bounces-15779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC29B8B95
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443231F20FB4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 06:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5002F153824;
	Fri,  1 Nov 2024 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HmWYbhlV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361815624B;
	Fri,  1 Nov 2024 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444203; cv=fail; b=s2b0nU0HAQ6QzqbFCsoZ1rghHUwrqzeozOoahnFOlrazGbZd8YufbpYQe6XFf6IBcnNjELfbKWSYrIUatB9R0QgguDEd7tSk9Lti1uUjex7BtxLMy4RntTzV+TNMAcwemMyuvkmOT8NhJaCtkM0hheYWg+u9JwWXklYKAVXCZQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444203; c=relaxed/simple;
	bh=ZtUVqLDq/hYYldX/NNrL4wrXEZm19BVqHvtzGmBcYSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUrzsg8NLb87b4yJ7q4DFbgwqwVwYBbkGAXTruerLSyKPPbXNiUVls3uINFgbbwHsoGNICTd3e01BffqTif2srBzFlb1z7VBhNvpTX+KBVd4pob8DN1uJX5hmxdFbLkvtPalcXdYi4ZM8s0f/Yth8NNZcBCMObk/8f3tMXBoFvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HmWYbhlV; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8hCi/Z39s/USqlMxqMHWeIWGkSws1InpqDtVsPv91H2cDQgPLY97UShVkIGQLgM+7B6+u8TAr39FQerke22zHC+bTK1T9PNbVpO4eU0Zcr8vviye9QR8/hoivFI/BShMMyLTZSNwMWMO2DS6Ei1A0pKgtNCIofWXono6ZrKM86CeJqdNsfoSMrnS1gJOKBI62f0+O29Ih5chy10o+o5UH3MqfICQzslw1TQchGiceQAzdAP/BH7gv7741sSR8xYXYnShGJZ6ZVJTqJgkzvtdVG8GFjYrFf+T5GAAwGiYHWGBq/yaDDJ/s4MBPngICQUWkmd/ieR/0xqFsX7WhsDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ4AWKJQYx6MGwApq35FxOo1vwUb6XN2S7Q81H6cK+Q=;
 b=OgPHvXtCUM2ncfU7WQT5kiFCqyGQ46YKm9NIcbNMDw7dJmyycIIZbeh3R6sj0w5ugBWrgKju8iD/exsUO0fZz2BUEJ7l6/Bl0CyaF1rHazFIggKhMgMc26OWSwDAd1M5RdivhUeJeYJO5pD4GkFC6q9Nri7i7XXsOSrgVUqf8WCNqrPC7suFoda1RwzMnlO4/h18TQCAjzW/Vj6f7OzhN8us+8Hb4xJsJhdAiqX2/jr7gKzF1JHgyE/nXoW86Ip2jhviKy0MdlrX0Zv1hvJ0nHXkhRkqgCtUGOq+NdCyeoFtTdC3yqaJr0L2QxNt9GnoCm9EfyIk0N2IcNXuJ4WY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ4AWKJQYx6MGwApq35FxOo1vwUb6XN2S7Q81H6cK+Q=;
 b=HmWYbhlV1NPq6Qslq+xPq77BYKvMPygR3m01vXnL/56ZsQvYpJrg59+8H4P18FkU0S0k0ga8BobHa6q/EROTbyRFAvQgKqS95oTK10F3eCCcxhVpZryruchqxGEQY3E0d/XgQRo3UlTm0YQr4V0xNUH/7Rvy94NLg9avtSmtoP/va6x0/xjQo+qDCd0q9gWLZsRIFVc5oJWaCuA+rF0AJYf/NIFkhUPykpo41Z00Y2nxOFMt2daRH5HuwEojkjm5vAFiuGRLhDKuT2kvxdN9xeoWN/HXVRe5cdE/dDyNq35MsdBrLLxkievDP4G+1gv7F6cRdebuFJIXrgQ9FxR5Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 06:56:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 06:56:38 +0000
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
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 05/10] PCI: imx6: Make core reset assertion deassertion symmetric
Date: Fri,  1 Nov 2024 15:06:05 +0800
Message-Id: <20241101070610.1267391-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 7726b88c-4082-4a9f-9596-08dcfa4254cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rs91054BNiSEKylmK83maj5rHjWiOU6/xHh1yyffuxu3bbWa5M9O2z7cCUpo?=
 =?us-ascii?Q?zOyk/aFIi1iBBxgEN/UY7U8d/OK321hzknwYg5WW4TCQ7WKw0HGlUY+cfXs5?=
 =?us-ascii?Q?cIcLZifLley/sQrJ7cIrlJC0oih3kkoTRWdIfBQnH2ggAdHfxfb2NRICh3Qx?=
 =?us-ascii?Q?AV100aiLJRrGXWtPb+hS6KKxaxrn1na7ONSGSqbIgxDd3f02JgPDTp9jsAld?=
 =?us-ascii?Q?Z8Y19vCNTJRCrQMrxshyrJCIwEvq78dYyGJ40cNrsD9fz4mkcqdjerKjiL1N?=
 =?us-ascii?Q?GRd/DW0gD9YsPjG0dNO4mAU9Gw/q2hiSjBe403KgJxCrzmcp/YD/IHdOJ5O+?=
 =?us-ascii?Q?O1dUpcKD0A0Lruj8Sqn4vWDxaBsFEBjMbSxmqeLSaCDXWLeeRp8UI4Eeyc4R?=
 =?us-ascii?Q?gHqFdyb6xKCWnw0qrcfxNGN2+KztV2WEiYBKkwnh69GFishbb7V6tk3MFHbf?=
 =?us-ascii?Q?TB4Sdsz3CaR7pl6owApopmXTgMAISrBgRwNL8/x3oMoWfSOy322VUjM0FNm+?=
 =?us-ascii?Q?OjmwLwWPAYn486IyDLskxcTnzQo2iwwQnESBWgGiZqsVa+bThaibw7wEE5Og?=
 =?us-ascii?Q?XuUhuX0gUX2Rin0HFnFstmN6yLVByZl7gv+f87Zl1sv3PNCO1mWlLhOLMILX?=
 =?us-ascii?Q?GmPHlFvYT4T3G4f7WJGMXF9G4i8ampwGc1f7XecwBf5l98Vy7Nfvz9Uh1xDT?=
 =?us-ascii?Q?iWzGdk5Z+GzAieu8+d1wbhxnaTtcN4xrfCNQ3fRMl5Cc6SMGLVD8V27PEF5D?=
 =?us-ascii?Q?krxPOvrmTKZjUqysp25KJpQgoBF/rxV8tlwk94bV06T7HbdkRQkcpG2mZL/R?=
 =?us-ascii?Q?3fMjUIdMZyc4Ysmn7AB8vT4S7IvjxKbKOv3m/Qdr/ALYQ2Vx9vox/ql6tEfr?=
 =?us-ascii?Q?Iwprd5VCMWG51uRd+L0FmKBF/8bSidP33tnkCtPwSHiCAwNfXI04KXihtclO?=
 =?us-ascii?Q?uS3dU9DzT53cdRLSOtvZ5feHLbSPyadVSgHoT4iS8mFexmIJDfqhiI7StxVK?=
 =?us-ascii?Q?yPMajAxXLRBY4I0z3CSlUwJiEAtH9HzhQm9C7r8JWWHoyiwcovIEDB0itsP1?=
 =?us-ascii?Q?jFmPuAYefgBfUQGfbRwpdQ/e8W58MR0G0r1XcCaYr/hXIfkQASq2B22Loams?=
 =?us-ascii?Q?ntRpAxBCjgcU184dxlMcUYC7uBKPjxV9SaHvpsSd+/FxyJG2w5qzOzyt/dlG?=
 =?us-ascii?Q?ixO1plkr9r4sdP/Y7ey0gM0Zd5Mmn0B3gj6NPU5EPBLjbodgNQ0MnICW3K/1?=
 =?us-ascii?Q?bR3koDcT4EQEyqR7po43wm4tNzAHVFIls8HBd8Lx2HUN/X6M/ThCiwOFX3RE?=
 =?us-ascii?Q?HsyNpxll6AArJ0/6NYjyBzWAhqprHySphow9JIQFFxtZuXDN5ZhNJZ9hwjmt?=
 =?us-ascii?Q?FLKC4LuOf3pnxXQzaFEYIF+VxtB2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aIELDEFEq3T7BnJArw8KS1DXbzemiX3Tb7s/FWffV0W4vXlYojcajyRA8MuJ?=
 =?us-ascii?Q?Z/sAf3CUkZhAUiVbXV8ADRQVl+AxcIcA0ri1aVthIixpv/5VfK4mraNOr6+R?=
 =?us-ascii?Q?q7+TxW7xU92Lz8QI6kwf0BFG+L4G5FL6h3pyoEnAKwmcn9QQ9Sa67zx0EoDM?=
 =?us-ascii?Q?Fb77O3Ki4Fj6ExZ8uwO4gheHu/n9MczacKxKCpb40Dikyezao3WBjZfiENf3?=
 =?us-ascii?Q?eZRsyer6/sTKYm253m+pF23xmXpIE32P+lToYT+3CetGCyNmRHsEsCaqjBqs?=
 =?us-ascii?Q?7/PUs2MQVak4vEOqUuI0jR6vFY6N/61P73GN7aHp8v8a1I17ywWapbwzul6i?=
 =?us-ascii?Q?uFcYBKZlS4mNHfww6CfsB3UaxHe/qx+FhP4Ca3BOWodY5xfWQydBvw8pR56p?=
 =?us-ascii?Q?iTmv1AZGOxBT6+c6LI9mYV8cUPSqSrkVUSZOC1ytA6qp9W/PVZFCiqPE52eI?=
 =?us-ascii?Q?bpWgllE58lizwCmrCsvgToQOt4R0D9i6IAP5D1n/tbRjtFvI+WN2pQT6NbFS?=
 =?us-ascii?Q?z4GV/m3XANRLLVS2g0PX161eZRExrkvKPhCUAB5XcqmeSxYgDsodGtK6UN5F?=
 =?us-ascii?Q?iYSG3ztb+4xb/2jjatAXBz3RdxKCeTlAyKQWr9bcL8h69x6HSEFU4ge/Z/2O?=
 =?us-ascii?Q?y54K2ki1fa06cwRhqSezO9NuO+3dpJ7ycVcTDIWZeKsVTBnoc9P0UZG86ffL?=
 =?us-ascii?Q?rao4vyTypBzHqBkX9ulUXnoEk+o4rvngZEZ2/xZpU9PFwg01t8n5wZvZS710?=
 =?us-ascii?Q?I55fPOYyVCl5fyCdjOGW7KgjQikEjiZbkb5VdDSHK0Ac2zX+lBhmQTzIGRei?=
 =?us-ascii?Q?fZg+tKreafDSV29AaSQnQw0PC26jUkSQg/osmnU8RYh+uSvUudtL3kDvhEru?=
 =?us-ascii?Q?UzUKDSyAo64Dev8Huz56meXoF1HnKrIcDfAIWa8P5JLUtH1/wxbgcCwzsyCd?=
 =?us-ascii?Q?9+Vjx4YAj1jnjcsTx4UNF9SKQdWd2cIgcdgu7jiBxWwHfSSijEfNimIw1Ohe?=
 =?us-ascii?Q?WDEBRqAZPsvVJX8xnhLEPJpX8HNteVACvVMuduUik+qrdvKSyiye+N51u7Bd?=
 =?us-ascii?Q?6ncICbZEjzpoJeiePIXRm+5XcRr4IJb1+RDyp3xXi3onQCowRXlWLnU2nH7c?=
 =?us-ascii?Q?vNX5hX3Ob9Ji7dKi311F0CRMmokqY1zBGDpiXwMvzeW9ksktlmrH2ltGd0of?=
 =?us-ascii?Q?/jjOhWlHQsxF9d5/GHi1ufVIcR5qkxFLzsmgiQD87UlEmI8DfYPOzwdOFzPT?=
 =?us-ascii?Q?jE5YbLpEWULuTcNydgmgabF+7jJhl7GjA8wuvzClx36sdpV3ewwclxbRau5C?=
 =?us-ascii?Q?rvebhAuEUIQ64jpuTVZULPaqyyJtTnRm0/WMJ62YJ18eIsPMDTjOl3JhCPMz?=
 =?us-ascii?Q?RzZ6qj+OyX17SN4pqtQec+7IaMuQFQO+aeAUPI68Ahn3OA7RfrFz6zZKKie3?=
 =?us-ascii?Q?p8qSQkWSdCuKJEvA10MTdy/WmyxMpkd3lgmv+Tmaa7oWsT2W9c7bKN0nrD5H?=
 =?us-ascii?Q?n1kW1DM9h/FjW9WDJicR1CnchthYX2rqvD3hyQ+dwMZTWU76953aKHXdc6qE?=
 =?us-ascii?Q?jXLSqKgdkvLY8Lvgy7mnAHpAjGwO4cklZLGsQrD+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7726b88c-4082-4a9f-9596-08dcfa4254cd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:56:38.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72ogwNrMVBlAgXt3Jrsdi7y5VnehakZ1OBQV6J1hIIzfiQUMZoYJ4Lrbj8YSY3RyN2XwhGp32kkiYlrQoJ+ZwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

Add apps_reset deassertion in the imx_pcie_deassert_core_reset(). Let it be
symmetric with imx_pcie_assert_core_reset().

In the commit first introduced apps_reset, apps_reset is asserted in
imx6_pcie_assert_core_reset(), but it is de-asserted in another place, in
stead of the according symmetric function imx6_pcie_deassert_core_reset().

Use this patch to fix it, and make core reset assertion deasertion
symmetric.

Fixes: 9b3fe6796d7c ("PCI: imx6: Add code to support i.MX7D")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 996333e9017d..54039d2760d5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -772,6 +772,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_deassert(imx_pcie->pciephy_reset);
+	reset_control_deassert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
-- 
2.37.1


