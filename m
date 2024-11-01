Return-Path: <linux-pci+bounces-15780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4295A9B8B97
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C524C1F20FB4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 06:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B774156C5F;
	Fri,  1 Nov 2024 06:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ch9jeA1E"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F62153BEE;
	Fri,  1 Nov 2024 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444208; cv=fail; b=pFapUHQTEHw8T65hIsDGG0tU5I0+36lxZExCBox/i+PUSanRrYoaLvdAYyAS6N9WFrP+u+7p19jaw71w8VdXu6v7CxNgos4lVvv7pZKDCNt4bITvK5VXURSAShTnHsEPN/tni3RVEBPj359O4A251fxohZkNFnnJkWS0OkMZAWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444208; c=relaxed/simple;
	bh=WxEkmKWQmTLxP/44FBjzl1PrQsA+Y+0sEOw3pBdzXhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJqf2arUIVzy271acnOVZu3N3U5rEbFBKoRNbqO5zOGb6Rm66YM6IhbLrctmwUu8KTi6QSNCsyNgyfoOZWsQUiJpR0X7PQypDxeZLW7d8edjN/h2pxE3CPfCu+h016GcYpslObiP5nO4Q2Zz/zFeOLmx9rpCOHAKupMJ7yl/Xbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ch9jeA1E; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5oYdfmE9DztpdFSNxMQ3ro2egByYpIAAii23fnD42eYaRdGyKGvruWCn7iz844yO4ReYXxClU2nGW7j0v4kipshUZFcOGVV+Ok6+YMIqy+dvNnL7YYunCAXVyrnOYDaI8oLb50X36ncDR4ogsZvFGEHDDvqtOWvcSnxaZZ5HePPCYN6LUt3nS/LCBx1+85ruqIGZ4sjaGT8Gj4+qY3LNWHUKNLylTSA6xEN+kbLfIfDN8tmbafI0xYpsBtMUkiBGXjPsLw9NKGeqfBZTHU1j0e041kJ4JrifJhkK8a3OnlDT2j1ortwrJqBi3+i7dbMaXel5GHWff8lvf77P7njOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhB8QtG2tC+Dal6ySXWZu5Q1GF8YJK8C0Vn2syd+1h0=;
 b=no1tIWqCuSoRycEuOQRuS/blvrr8rt8WpRQa3BEZtaVhzyTaEVWGsdG02YioXUxStei9nKIGy4a8glKJZJc2DFqdTYUys6CiBm41JAz3N1+1FlmuOvcgOB52XRVy9FBInTOfZUsRwrIT+JUIV40dXISj6hEjkHF5/KCsoHwC/9wRuVmpo9XDrZ15gh7mwVgF/oViAk/1jWFgCoxpfjruKMcn6R0Fknc0H5cUK4TW+nTFqPCIskCo4UVrJLmva1kpAq6WZlkPbZMlD8Wvnvnsanzb2L3HqdFEFHDjJD3r4RcXKoytd3Zhbf102wLdZwG+dkOARv7mrzgBhTL5b+JuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhB8QtG2tC+Dal6ySXWZu5Q1GF8YJK8C0Vn2syd+1h0=;
 b=ch9jeA1E7gn+viTvGvEdtrcpV/KVNCYiqhi5XMInzu/N8epZqwyvSTiUjN4vyhDjrYWyCTS6u0B56Z1OB5KTqkkXutjUKZgVNF5kBE7MFXCpNJ1nHDixMZyqTdtys6kqsCyg7SRk5VDnQaif/ih+8ZizC/lXhyYYIbynPH7ixLifhsr8htR9Cjj0ZhTZ3GQnn3L1853ID+rxvr3uZ0xr3PNeQnMNj0zi//TSPNmCcfbbPGgQ1yN8mkuNtml4oo29arqSeftjcJQMjD+CJGMqJVac/6OhYWWfBWeFFteGj4upsa6J7Rlm/3YWsU9LZSzWQCbY8tmh5f+fbeYT82vwSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 06:56:43 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 06:56:43 +0000
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
Subject: [PATCH v6 06/10] PCI: imx6: Fix the missing reference clock disable logic
Date: Fri,  1 Nov 2024 15:06:06 +0800
Message-Id: <20241101070610.1267391-7-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3dbca084-b88b-40e0-8c38-08dcfa425846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5TjQjVcHRadEFNxw6zcCehTWnexrtub7wvXhLqkUS9ND/D3ViDhz/F16d9Ls?=
 =?us-ascii?Q?U0bWaA6dSpwEEI4ggEvdha9RglGA6xwlXJm8PjT3MUjTer+m7zaFUBEbF16R?=
 =?us-ascii?Q?iYmy/r037kGaiFuTrKWH72uIRZ+EUMVJMccvvCdKEmXTOV82uVxBZCW2NUO3?=
 =?us-ascii?Q?JF5pBeVMBXjtZ/SZwnlGfoAkrdwkbU9Pgk6mEODZDu2CNBSxVlE+OVQoYlim?=
 =?us-ascii?Q?dSGbPQRTwuS2+xU2v2TN1hEi8a0r/V28wan22/MKS78bnj+FZEec/ckmFj52?=
 =?us-ascii?Q?+GHCWHvYjD79ZMXH38vhtZhyIooGSTdgGN8Dx/+nYdMushuqr1OxtP0vgXeE?=
 =?us-ascii?Q?NRkeVfHR8V+/gO2k8+j4MqWUnXHa2T0TWLg+DK56bHR1WpOsHQYYPcCnn410?=
 =?us-ascii?Q?O4b/0qZScKQvNek+jcKWui6spylMkqNw5iSImKsaukPEy8GBC+l3IRJa2e/D?=
 =?us-ascii?Q?LGgUWLeNcgnvMA+OICdTPNKnuGC4cmAtLm+E8OBC3eqghDslf5Loq+WgaJEs?=
 =?us-ascii?Q?0cZCIbqi0vvx7kOHvEJGNvjz5caPY8hLryH71VwujeHGaTvIs+/ZYvcSpBXR?=
 =?us-ascii?Q?Owa14tQyIG8rgWVyk5zq6zqP8FTj7m+IpFBL4jsa6/+b5eK2MXjze/d9iQT8?=
 =?us-ascii?Q?CCKzORGBG/h0JeU3SlzSD47BKSSGeqtdo2cKyDY3KzR1S5Z7piblh+wSu72Z?=
 =?us-ascii?Q?cdl415sbJVrugyJbF1TDwy8TjNEAnbGunLJ9v9FC9/53Y42lgmn8FwkxvZHI?=
 =?us-ascii?Q?5Bt4nveMAljQkIAhW6Wbepuou9GK568m8Fp3Td5xlp6qnLHEvqW/lAtyDI36?=
 =?us-ascii?Q?OO5E3wy0sxzZQMysDk8RS8iqnswBDabmeF/rLcLI+BuaFbppyrJv+toe1fKc?=
 =?us-ascii?Q?J74yPR4axRaWw+x2BMSAK3w/jv5CnWIwk7nQ3jBkSKhInN1SaAmQErNUypY7?=
 =?us-ascii?Q?05hgeCHWkrbQXUqPoIo9Rg3cJIpwMAjSSiG/7vcquMcRVoG2+cZvcupDm7tt?=
 =?us-ascii?Q?HZ3OI9mxnYDvxvyZ5/80TwWNmNn8qV3FS4UKdlcJk5DRp/JPzs978LM5F8hV?=
 =?us-ascii?Q?MoGiagNgDl2Z+YG7Zhp74owVZJPbF9rNxZgy5ky0j0weRAviHa7BpxFSTT4Z?=
 =?us-ascii?Q?b4yMVgmQwWvFnNsyuKSKU0wdSyyjqDoapWeyLAgCjNhIVLy2DL/b4Hy+iPPs?=
 =?us-ascii?Q?dD221m+QJ3gPHmEzH/u0zVnQikNPlGXReJIV7vF7I6ORdATOylhU2jU4ClqO?=
 =?us-ascii?Q?Mk1WHvBA/mXUtbIW1xISKRK3SkfW5NFVwY7NV6l/jytGq2ZQqvdcLpaT8kan?=
 =?us-ascii?Q?VS8QfZJxrB1vRWggv+pkkIFsZ8KjMY7nkLvz/dm2ofVtkyFpfCdg/fPfh5n8?=
 =?us-ascii?Q?0gXyuKyU/tMoRmSnu/1Dk8W+IXiv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?li46s/iRnrx+Fb+vOb7ZKUiUbBWekt9jkoovAcPGt2f96OoO8YnbwNHmSW4A?=
 =?us-ascii?Q?gqav3QS7f/7mJPtevbxD4RvDFjY4j/fIq4IZW7aXsHIWN/icAWu/lcNC5T16?=
 =?us-ascii?Q?6Ktf/8MfiqvEP6d7DmGb9hwu+dn/4L6Yfo6WNCub00kGwaR8enR1TO8Z5RXv?=
 =?us-ascii?Q?tWZIwsNRKdKHYuqw6qAlsp66CmvQjsc06kXIGYJgQoZUOnjXl67lU5x9ISW/?=
 =?us-ascii?Q?VT/d5mjl59wAWqwpaWoBm9itMeZY9xwRP1bH1zPL0tsmtR+yQRcw7K7sf0Lx?=
 =?us-ascii?Q?zgKDmXFZ3OzYegMAuzCC8Iu7BJtCZBvE0DhRc2kYiifIhqk6uFXfibSEhXb6?=
 =?us-ascii?Q?fOBvzCiRwKm2H7y0QFdOaC0lkVez4L8sYBQNixnpktjWbGSirtJthoAGpGwk?=
 =?us-ascii?Q?TAIm0ltVNXXZkP6G8tQbfyQnkiH/X/qGiPZuHBmZ+C5gCHFPhOJ4jAz/FfGw?=
 =?us-ascii?Q?ADoQLBsZw2r48E95DRK0Kw8N/za6YregsK24jq/m8Y/+NC8FKtBK2XSAfWBM?=
 =?us-ascii?Q?fAk9YB0AJdN4e51cW1Wq4i4g/+0n5HGYE/hVdNLgKKBiChuhrJsPP3EnaPBb?=
 =?us-ascii?Q?3crlJChjJCAtI+HODSO3u0JMolofgMWcVq/0IIlPMq6fJFbJ9zG9IwCGWRzM?=
 =?us-ascii?Q?0gYE84oFapHqbbGUPpxHta1qZpde+YX0rusjZ2gLD0jfj7xITLU4CTSIeYLU?=
 =?us-ascii?Q?AXtcn55wtR6r2i17r2+UnASIjZzk4S6bQrNlcAXdUubCjPj/jUBKM0z5hte6?=
 =?us-ascii?Q?ON0bf95LeFbdGtKnmGZR+BnoApDPnnU5zD9WqMyIts3vS7gYAPAzH5ZhSB5q?=
 =?us-ascii?Q?Hul5c0eUX3GQ9Drz6Beqgltk+pR7DK9xA4tmBr3mcfEQlSa4QH1zQcTp3vaB?=
 =?us-ascii?Q?1ky+BtE0iR6ZFbvM89fa7KCYP8/Y5LG4jiye3XDqVPZUz9/c0A5T/VHO9VWO?=
 =?us-ascii?Q?U36xzU6CjlMdWPA9rOx8Pqa1GW/Fgc5/mSoJrocbqQ85h0oPiQXi8fqOJ/IP?=
 =?us-ascii?Q?rX6eU3ehk7Q6GTSRsdJpwWmzmDvukQYw12E1gHHrkfYU2Mj/XxrmoZeJymw7?=
 =?us-ascii?Q?OtpBdP7KGDY43q+bFWIym+7hgZVYai8QOCBSsrxAcRopp5KwxIcK0cVgRS91?=
 =?us-ascii?Q?hMQRDZiq8SumBRbpS7jcJ/vkeBk5U/SzoBHVr1UiERtiH4+dZHS4Jl7sfVaa?=
 =?us-ascii?Q?ywi+LRVljNZmJ+/h/W2+PcyWxkoQzGbaZm7w/SyZhGFPLIRFR5LaIP2AcTsA?=
 =?us-ascii?Q?31MGus8p07eDc+ws8S0XFoq1EPQZPfSR+jwXcVrKmYLco8bwSX8nvZ49NYkG?=
 =?us-ascii?Q?hHqBbNIWmyNfUWFf3LGfPBK2PfepzAP/2igisZxyM4XVDq0Ie1bFrJYalObX?=
 =?us-ascii?Q?bO1N/IyFXWShK9tovQTYbdnqVT0YepTyOffBirHGjn1dASBzReSqT2mFCcma?=
 =?us-ascii?Q?x4OTYGHhJb95/YTUjW7TnI+slLMvvQYTOkRGZoZBVOCrQwHiOHXrZzm2LLSY?=
 =?us-ascii?Q?ZNuVNqOCPu7PKxstRBmgGz8TczBXx5/TnU5n7+nALnkFSCrUAdXVIdIUfRWA?=
 =?us-ascii?Q?3zPB5L+7Ejg3KtwmvOcXXSXX1AYuHZeO3iLGDmTL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbca084-b88b-40e0-8c38-08dcfa425846
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:56:43.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ5DZ3ERRQ0kYePRfY3KxpH3RLmMbLWzFIkb3ay/JvY+Bzct9DzZHWjuocCjnjiPaPSXD1851vLU7aNTMcKvnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

Ensure the *_enable_ref_clk() function is symmetric by addressing missing
disable parts on some platforms.

Fixes: d0a75c791f98 ("PCI: imx6: Factor out ref clock disable to match enable")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 54039d2760d5..bb130c84c016 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -595,10 +595,9 @@ static int imx_pcie_attach_pd(struct device *dev)
 
 static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (enable)
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 	return 0;
 }
 
@@ -627,19 +626,20 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
 	int offset = imx_pcie_grp_offset(imx_pcie);
 
-	if (enable) {
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
-		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
-	}
-
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
+			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
+			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
 	return 0;
 }
 
 static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (!enable)
-		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+			   enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 	return 0;
 }
 
-- 
2.37.1


