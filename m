Return-Path: <linux-pci+bounces-25206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2BA79B75
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1761892405
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649B81A23B6;
	Thu,  3 Apr 2025 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JFjLW80E"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD301A239D;
	Thu,  3 Apr 2025 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658870; cv=fail; b=fryJfrSra9GnGsQtMb794AmANU3ZO6MoSDc8up1B6E2/57Lv4/8iYyBUHtfIxE5zedtkRO5CRLl7FiS0HTS09OIm8JXO8hZ9ocHTI9bJaWVI53l1dac1A/2uwrviT9ln3RbGQggcQqUL/26ktBj0iWFnLannqEO4qSHZfo5KvSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658870; c=relaxed/simple;
	bh=4d76CqxS5nntbbyV3tZBFl0IQgIlGYJEUsVFEZ6mYQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RpgdIzUtbu+yXpzzK7TzyKrfvYKC4DLUB2FKwuws8wtlDxVwOp+Yo+RwZudWkCsKWO9VeWADjswZvnN5lzEeptD0NMsVV3kjro3o7DBo14xUg8LwumaSwZNx+FpDNiqD04XgFxn+f//HvyOu8vBhCxUVqo9zwYxeh8EpIx4uMB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JFjLW80E; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0Ueuch28GC5qM42PC8I2gDF485Sle2Z/GOHPeWIAmpEle8SzjGv87wetQTkEBt/tfji9lirXS5W8tsyvrXANeNObRUMvqrdwhjMExbUBMrIlDLmVssENxTN9pma+5LsSYmteddrZV35pvQE4XglLuk16kB9mSmas1FJWWukcl4Hi3gVjJeMkByVo/ilU+EpucZSWly2/IRwxkBg0xWoUzCI7z1Fwmr2u9pnAJM9hIdEzMdNs74J+P/QQwB8EHk1VlVaXziRwycH3ms4anOT6OLoJQ8UYbMJoZSrpyNyRPGrNJBkEsifCucCXnddqQo4iv8hhlnGno9wVmwpOVSRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIKvW5Z7CCntlQ6t55uvbzUhSENfxtmYxFMVIi6OOAw=;
 b=mcMsymBvohI/9bam5hRV3W9iAas9C/1bKXafgh5F8JBLEv/y23M+AkGHEMeIaQ4h492neQdfixsb0QwlMyM00lwInts3CLXqljMBeYLkeBI/SiqjU37OYNJ0CNsqqIzVUMThG7Brdydn1ExEBcvRe1IQOS9UBiyWO5zM8atT+6dBkBZrgbbTDxstOYzC7vwTfXhMwM138z6wcKk15PP/wF/9JBYx7jIbnpfT7StWFjCtr6ZGNu5yFJLhNaPL73S4tr0XcnGf6VVRv4GJRpM/wZlbvGadtrvXx+1W19AKKvVFddNDoctzE8cdWF1CQqIYHWhlUUlqthIdR9QzWjC9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIKvW5Z7CCntlQ6t55uvbzUhSENfxtmYxFMVIi6OOAw=;
 b=JFjLW80E6zjN7jC6Lpji+1X9ssrSalfh2AKHvzFbzQK8rKj9uCtzq9ta9yztfYxfmw9IKq86T2VTd9TrCHZhyHuB1sWbGl9dNvmmagA/Wm1lQDfwapoKI4muPJ8PrNraZTmsXOB5A7kxm7+kqw9L9D1jptExTY7gs8Z3pPo3sO6Q/tF33vKmykcX7BEZgsCEU/w/SW5BSVtWRPCVxDg7wDuW73maENaPU91MurE4fM/aBkfHZBBdxSj3dBrDyrsL4jwsRqf7OoOaEkvbqO6VccWs/CNBylv9wXMgWgODaADZ9sqC4qG6U6aDz2g2pUVprwyPI+9SHZNaVeh3w1+BhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 3 Apr
 2025 05:41:06 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 05:41:06 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
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
Subject: [PATCH v4 2/7] PCI: imx6: Skip one dw_pcie_wait_for_link() in workaround link training
Date: Thu,  3 Apr 2025 13:39:32 +0800
Message-Id: <20250403053937.765849-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250403053937.765849-1-hongxing.zhu@nxp.com>
References: <20250403053937.765849-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::13) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0a638b-3b80-46f3-98e7-08dd727220c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qxLwaHmxx703ildiLPokbZ/SojRlZI5wGwqcXSkdc31rA+xCPSWkL/9Ideit?=
 =?us-ascii?Q?XyQt9Tr+HjQclgMfBVdJq+mM6VMWcCEw2e8nk9Fpd4f/qAixPibcSCoiMwWI?=
 =?us-ascii?Q?mFS1HU5gwJRi8mKoJrx9MFDaYOvUtw+kiGvdB+7epdZ3MTldXaODjAQ4e+0m?=
 =?us-ascii?Q?Cm/6f+/xbo3OivXr2d5bmPVf5V19UuOCPcPXCGPqpcyqYzrv68OxW3qbcxHS?=
 =?us-ascii?Q?smjfnWFroznLblR/qaPTKPZgGRKdRXH7GhQnbJt+Zc6YBbIgXbA1tWdzj+bc?=
 =?us-ascii?Q?kAzNJXezxs9aPufJOSqN1/0kkPCciZEQVjEcH8tIJLBZ+PfCsa1n4xeyS9Lk?=
 =?us-ascii?Q?z/hhWGPoAh6MbT1TW2vI5OauZjZ053/YdyreH0OOi09Kb7oOP3UwNqLjcCXH?=
 =?us-ascii?Q?rUa85uVfO9g0DGwASpHBGdktR8pAmxwbxVAJZku3Je1R+xh1J98maNYIfqPS?=
 =?us-ascii?Q?/wyE95PYSLbtsiizgdSqRVxQEDq2g4yFVb7YHE/x4Stn3e7ZXbEtwB1B4T1I?=
 =?us-ascii?Q?5ThL4xP7EfqqogzBfAfe7+OY8jGiUhAVFqi3XYgOze+041uLQNbxfWDCZmYs?=
 =?us-ascii?Q?PPT8E99354pc1KV4P/TSYwUEgYTiyUGwYMq5PHHGMTB9jqiDE/ytX0ytdYCP?=
 =?us-ascii?Q?KIhAboee37v17P5t3w74izydvVJVT4DTXw0HGLZaDkdpovsSfbPxV2/FnBlr?=
 =?us-ascii?Q?yQxrF9k0DFjO3hzlK/wHGWtv8/KWDnFrd/tzhMps733QHZdnk4/zjlxkwjrQ?=
 =?us-ascii?Q?ytzwumNakDp9dYv8+cjClv61F5rGet6ae06xfrRAR9tHAU+vsYab1pHaOtll?=
 =?us-ascii?Q?RhYth4WQkwybmSH+yTu9Yyq94QYXH+fotobOR8l3CUYCh2xwBQE3+IRAuRZL?=
 =?us-ascii?Q?PFmXwL8qEcieafNI6hwyu5rQRHSN7aBklOoovNqumudOqdYiNumv3x3JuDds?=
 =?us-ascii?Q?VQ9uyvv8MxWglhd+7zSezK5slp3Dxl6N8DqpvAQwyJ6AIhm/LqLofyDId2hG?=
 =?us-ascii?Q?qEGZa7LZ7xz6UZnBxRBkOkIEqyOI4mPK9fXR9oroIe6G3PqVk5I/zpL3fccI?=
 =?us-ascii?Q?IjB6NQMr+4cCURmGKppm2f9xTupydYo7/wJhz5Uno+rZ8xroNBx+V4hTbgil?=
 =?us-ascii?Q?SZS69+bphvpSwYe/WbLB2bv7LngUe4Xw9NjpXU51bVaLnB1mlNk2tYKq2Bsq?=
 =?us-ascii?Q?Caz3rIV8jiLwbSTpDKXnPI2PqxoRPLgCz0TovUeDIrhbypwUgw4JnleWgdUR?=
 =?us-ascii?Q?dZev6Mb6BguWcHZ2R9Ue+nk+vZxmcTexH2iI7gw2ylblLWm0Ga6rf9GKjxSK?=
 =?us-ascii?Q?VZE1uQsI+gMhsXeFWiGBXjAAvqhzvW6MJDy9s2C74k8RbeQvX5ZFGLOxrPuU?=
 =?us-ascii?Q?tf2TXLsB4LOsOXZDUkBp15u90jVpi0KRb8fx8B8PSsIOdNHVCo/+7cj3Cz4O?=
 =?us-ascii?Q?k3IIFpTOA3Hct7q3yv7L0XxkBQ7s6X+Toz04PZLAYa8RGGMcT3rwQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xlPSpl+PWccTcMmlxXLXJgnRdpQAkZ0gjDXQkrJpsZU2866j3ZVpgaVFXLKQ?=
 =?us-ascii?Q?Kf+cFb3RdIQMsKQK9Mf5pvYlYhKDvn6IU3UdveC+gjTn/YhFE72MGKA3AFks?=
 =?us-ascii?Q?Sk8i6KP9ipO9MJw/ivKg/QD48Cg7uS5DFKTsOtj5NTm5tylaIlt1o/mnKmXF?=
 =?us-ascii?Q?0rQq0l/B16qrd5AUtwjc05KZN6s2fv0W3C2Zg+vHWmciJGn2gs1g5Q6cZOmQ?=
 =?us-ascii?Q?Dnv6n3hsYLCvQj/E9vgOdb6KZ5WPzNyGOjB9Tc4gWEMr26nLyTjtg6o0LJVm?=
 =?us-ascii?Q?HR4+GcDf6eHwsqw4RMCm1GH+GFaXzJZkew7SC4zrCeZNO+1VaFA3zuNTp6eF?=
 =?us-ascii?Q?01R+R0a6imAP6cAPjf0gCCmOl4qGNRO7xKZAfruUZfurHMaDi8Wvj7ztbKYe?=
 =?us-ascii?Q?1BRZMcEgG8ynxnyuJO5e9bQTYZ/0zh28EQUoEsoVHJZEo6QZYLUK9ezJdgAM?=
 =?us-ascii?Q?e0vmWp/4YwG0PcGD7U2AHP0eT5fCLJaFCOJXYloo4tc+QZVMSktuOjNAlW3o?=
 =?us-ascii?Q?g3OO6Nc092BqIr9cENa1tGIxtWc/6yLTvNdEzUWt0pGbDa0iPmtzrBwKzArR?=
 =?us-ascii?Q?KUusEGqW0/M1lZ15lz/Bjp4w0QAT0SzesedIGVxcqbNIie+Oq0ftbZEo8WxC?=
 =?us-ascii?Q?DY7krUK/1xEtnP7QtjdH96cKcT5kebIgtgT5jHscNIIpAmiLO1cXbTj1x1H9?=
 =?us-ascii?Q?5FgeMBPgLl4E/Wtir1fBCLPEyIw1rXMKwII41n0XmkI6snKpNbmbdGsYiqzo?=
 =?us-ascii?Q?ecgNtibXDXO/R9ujDrNISSeIzj83ygAlfuLPhzxQZ4hp6/F2kuKiTP5Of6g6?=
 =?us-ascii?Q?dd+Nmg+PtXsBZiu5TVq7zcNAkX3WCUinU388fhhOLm7Hk1tjE2SOovBPVL7B?=
 =?us-ascii?Q?/iuq0eaM9mjlsLzn5/6hrfyiVA1XDF5+OmIU5kKPhKQe5A7rPGA/J7W8zutn?=
 =?us-ascii?Q?W236f16MaAwGftuU8/yRocySMphjX/uJwDndKYWakC/R+XUtamZEPwWZ8wPD?=
 =?us-ascii?Q?YQlbfn16KCNqu11f0ZumPd5GGf7xsfwBoUYSQ7OJfsg0aALchKIuzK7DrWbw?=
 =?us-ascii?Q?AUr4wNSu5aUVe+HBY3DwS6vsTKnykn9RIT90hZK4MWeOyAMYC1epp+jgxWFV?=
 =?us-ascii?Q?HtxRw+p1JX0khnBfOv8egQy818I2rotuYLGiBeCtyS1IecPZsaxs6HLfpg/n?=
 =?us-ascii?Q?nj3d3aDXTFaq8V5lnGFUMPEU8AbgQ8DWk5Z/g7cGa6aB+rtKnpQtlYpxx+jd?=
 =?us-ascii?Q?OmyYEIdUcyAEEdD/xt7V2T8vOJjZdVzyf4ftAAvIi4sJCWvj4vvYNpz0qJdm?=
 =?us-ascii?Q?n17N9jU5nSwcxWJ//w3IOm3b2pxjfsMTSjBwh9P+3K/lwqUJ6uX3X3yg6luM?=
 =?us-ascii?Q?n+ss33l30xe3xwZEEIuvB8Cr0vl+BNoWxPQ+aMHya3kEDnbprbCne4r2bPuG?=
 =?us-ascii?Q?lAAHT7ihLjscO5XGV7sC9iXKRCq/x47kDbPtx+n4QcavmOsJVet5ZjLtbxvm?=
 =?us-ascii?Q?raaWS3kEGQg+/BKLPdAD/3sBaHer8tLt8DzPgKzxyNORG2TGLdXBygjVyz8x?=
 =?us-ascii?Q?SA/5kin0sd42MbDOJqKAxXYxzO+HhqFy+GfEYJnP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0a638b-3b80-46f3-98e7-08dd727220c6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 05:41:06.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FK4ivIra+XcwMHsftitwT5j+YoeMwNuZ1++rl0nPiHGx0khArZxLuQ1EYT5+XwJLs7TbUjOagJ7FcAwh76RZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145

Skip one dw_pcie_wait_for_link() in workaround link training.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 57aa777231ae..84d2f94e3da0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -881,11 +881,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	/* Start LTSSM. */
 	imx_pcie_ltssm_enable(dev);
 
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		goto err_reset_phy;
-
 	if (pci->max_link_speed > 1) {
+		ret = dw_pcie_wait_for_link(pci);
+		if (ret)
+			goto err_reset_phy;
+
 		/* Allow faster modes after the link is up */
 		dw_pcie_dbi_ro_wr_en(pci);
 		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
@@ -907,17 +907,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 			dev_err(dev, "Failed to bring link up!\n");
 			goto err_reset_phy;
 		}
-
-		/* Make sure link training is finished as well! */
-		ret = dw_pcie_wait_for_link(pci);
-		if (ret)
-			goto err_reset_phy;
 	} else {
 		dev_info(dev, "Link: Only Gen1 is enabled\n");
 	}
 
-	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
-	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
 	return 0;
 
 err_reset_phy:
-- 
2.37.1


