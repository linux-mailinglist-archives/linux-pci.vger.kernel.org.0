Return-Path: <linux-pci+bounces-25471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722BFA7F2F8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 05:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A06174A8F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 03:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CC125F990;
	Tue,  8 Apr 2025 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XvVbpTE0"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DF25F998;
	Tue,  8 Apr 2025 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081291; cv=fail; b=C34dLFTTQAvPo3+xZVMIWd55+CDy2xYa1V6GmWIJ7ZVc1sH/luffy3dr8psZBnx9sX9CFU/1l7h6X7yF4S4yxv0cVn2BujYV4NkLWTyKETzJcsl6TC6VGhWArveetM/KqnQ3smQJ9jKo7RAVkKy2ri9NqIDI2N7+efbf7QHssqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081291; c=relaxed/simple;
	bh=T+n/SEcb+7Bl1Mr3ygHz022uR467SMcqqHl2ogIk4rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZiAJ69/PSZnwmTW0j5FsrpAlAqZEnoADCdny1b5VvhwFcCe4UTObtzCTjE2OUVHOuqd6V6tquQgdqx4kfRLOjlpTL/LueJsau6CLAkpDZB1YIqWui5kA8QDW42SDLAu8QkU97zpsTJFCtvwgrWeZTxIAtLe0ec4240Y2YHB7G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XvVbpTE0; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txvU7OJjqpzbTNMp0K+MC3WKQQKvlaqDpJoSgWQxyElghlZGj3IymcLbqhnVbikjmqcnYlTQR95WbeY20YmUkBhmqRopPilGC5tNsVK4pk7+fmM3jWZOqWTJVCeFnUOYCxThTUCzhNSXyQgo0vNKAK09JAPVIyQxjuUpA2kAUm5wDS38qLh/Im8ZZUmi+6kfiDpNMNQbJJOkFiIsdnwhiTfjA+Y7+4s+ZMYG1T10WgUt315QwWMFZxEyeH/uTtlvjlRnvebJdTZ0XAk42P+FQBQsJObri/SDVnkr14/otPjrAPET/gXSKOJS68scQQS5k+qOshBITfuWePuWrn8rnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtIoim1NT4shaG+Gqi1UcPk3ddWkehNUGAtFBt+ptbs=;
 b=U/ARsJsl30VJ3WbmqqCWIcpcBmtQUYdseDhIiCEzlLPzJoOBkfHtxhoQk0nF5uBLBlEIu3jUDdgXrvWvrXgBIxbTUNBp+Az7ytrQgRNcGSzVIIcFErbWxKpA/AutAratYVKS84tlyFz5t/3ts50PgQ/L9OvyCryN0j5u5GR/69ro5C7AZPITcp1iiBeM/JcXfO0j7axZTtsdv6vgEjJOa3m5PyT3I01JLrL74TmZUQqBoDQinBi1zroIuR+KZ/4P4h5jPhRNr3lOly+J9teJnBXHc/4hWyfAj/uwMqzIr1IeVM3hXaXpmBGXDJtPlIb/oa565jIXIb2CMxjoSYydEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtIoim1NT4shaG+Gqi1UcPk3ddWkehNUGAtFBt+ptbs=;
 b=XvVbpTE0TUMYxJzlmGKYM7yIEaqyoK2iAAO5xK1SWEpbCWPR7oq2B2+K7XVrn4++9i5hREvW9+8Snm83WMJN9ymKrNJ3ylA/XTzEG3vlSrRfIlcxOYt3joJoZuZyV0BYFePMNwGe8pWaUi/qHCigcpomKdj+ljw1psnfi+LAKtJXz2gyC66DWo0MNG7hjy+44JNKSkNwVWVxPYrYM8MzPQRAGgA+QpYTwiikRhI/Ss3TIGJjcwP0/FG2QNG6aTdbGYbkzidkiHKPiSk/OLNulpfjV3crseQfML53Njdf/yEJXTXlLK0vDkox62XcXrVAI5ll1YNGIlmrnXHk9Kz1Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 03:01:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 03:01:25 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 7/7] PCI: imx6: Save and restore the LUT setting for i.MX95 PCIe
Date: Tue,  8 Apr 2025 10:59:30 +0800
Message-Id: <20250408025930.1863551-8-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA4PR04MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c20b40-2236-4e58-af4a-08dd7649a6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pTX99bzTZPaPO6fNAbf4aY28YYGwVOKHRQtncxiLuJZduqL6p4JsKgfA7qlu?=
 =?us-ascii?Q?qBQ/Jxdxqxt7UdiEk2gDNyQrBNBf8z48yJbcnwdMdVacxyM8E/5OY7jNsubC?=
 =?us-ascii?Q?/C8rt/EfVS0GeHWq7YRdQ+pvPtBugRdfuEglwQFq6tAg7+DZ1deSGm6HMIN6?=
 =?us-ascii?Q?gBtphOIFlE4DffDA7cUIsv6UR4ZSlJhtcLF+os+nEq7/JhsMIlJyCQaH9vt+?=
 =?us-ascii?Q?6vQEM/RFe+up5XLMQIiWIPOcrRU/NkjrM14Nlx3doFBVCpCKpdAPDGFOiz1M?=
 =?us-ascii?Q?v3B37d6yoCy1Yyp2R8wtrZE35zo/sF3wFgvbOBLWqqFBYEzV915clo/SS9MC?=
 =?us-ascii?Q?SoEEm5Et/Dv/TaYpHMh5ZQrJCWbMkM1ckIHsT0c5svOGFjJS8iXdrzZ8Fmg3?=
 =?us-ascii?Q?KW459Irt+hvbCbnWWY97FCkdTFlKteRXhaPShAxyP5Ddp4Nz7+nDqGGJRyc+?=
 =?us-ascii?Q?8KXBP+pxvjC9E0UTROecHrnzsoRm3rcePdLbcELPcLyCmOVJUb1MQctW97Li?=
 =?us-ascii?Q?WcL1rgIq3XxXjR3xFr/gB0NbCTgSiRLT0BzBn4YVODVuyZKjaL2Zo7LbMnEn?=
 =?us-ascii?Q?7MejuxuE5jor9tJBGbwl5Crztz4B6jf6b8eZfHwlrc/KqYKKyTsRQ4N9FMNy?=
 =?us-ascii?Q?99JR7ZQtkeuERx3ASQx4AJv2QIEFmltgT1fTqAjlAaAw4stckBJq11JJAiBZ?=
 =?us-ascii?Q?tmNaM2X5nrKB/Z1che7Q9uRf0z4iIl9g58QVwTruBglrpgWqR05GMSbovX3h?=
 =?us-ascii?Q?aFJRfebFnvUcKORzd76kXBB0ojWigyJTRcNJfNp9l6k8woh6nYS0EBlGaVbm?=
 =?us-ascii?Q?ZHQGH2Lia/WiwRYiRa0lJzNzQC5dIIDiK6ubQga7LzwnST126IUYnIye7D9E?=
 =?us-ascii?Q?NWTHPL0ZP6S5RgdTPo21oM8x/GevEu47njtIA/rpsDO6mmOoEJM9QTRzhJlq?=
 =?us-ascii?Q?GJlk78TpeYqZOmFFFsKs7wHRZJ7oxbnO0iZzpY6miqK4PAWof0ct32zYiP1A?=
 =?us-ascii?Q?oKRh8aDPa0rlFpoU3EHwI7wHb94cBwW5pkb/67ABUarPydB2dy4zReh9MRC8?=
 =?us-ascii?Q?//7Bgphqio6YGPxc1yxqyQZKntj62iXwp+ErnGdFANCtdSa/LSA+uP4PIFqI?=
 =?us-ascii?Q?PbU0T9PBDFv7I8rWDKf/HT9ig+yI8MoTQuUknMgUG0VjfKFIxtYdZKpuq+Vi?=
 =?us-ascii?Q?ui5swf1U6bGGyd0glSfLSVsadbtpHEzRIhV334eYDy5uxy/y+QNGeNwRctVo?=
 =?us-ascii?Q?iFPamZ/+V3X5FV0h1vID02Epi2MYryC45cNBb3809CKDK3A2Mk4SdJZNAP5v?=
 =?us-ascii?Q?fPRnRsaPrFJLqiVSsfPQL4nU9l3K6SNDfMNULQh+uQ/48rt6iVOT6bAv3XiB?=
 =?us-ascii?Q?V2ZKH1RyykdMdlr+Z92gQQwD903ByIas4FpC2bfywiuuVRGnymJiNEPkOj1w?=
 =?us-ascii?Q?u5NAVS6FH4P0dEXtJiCV++uD5s47WH85qfABVQFcum2wNEEGxiiD3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FdR3gjRPoD0AUgV43FKAC0PLKR7wOB4BFxM9XDIHS79V9IPa/ZeeWy0L0fU7?=
 =?us-ascii?Q?Rayn57esGedQjxtz9xlmPxGBksywmAb23v3NXEgm230zMCyQU3HKs3ghfqFh?=
 =?us-ascii?Q?hEiaHNtT+ay9owdV2Qot9RPdtsMkZ8uvxYIyPsYpFnnbFRPEf/16BRjV5TXz?=
 =?us-ascii?Q?Ey1zdub64lclKKynaP/CGpCoUd6zkr0JxwHxuR6dabuAzJz2Fs//uezeU6m0?=
 =?us-ascii?Q?3lsRfQOCmbeuRi+yhGYfsi33Y/+E3bMwmvLBnC628cRqw985fTMM9ggrnVqk?=
 =?us-ascii?Q?0fbF2FqyNnl+A0pnSJ8SIU6baqA7pLvzMD1+Fhckat7FM56CRrhmXav81MVG?=
 =?us-ascii?Q?3x+WIEVhEiBwu5mPUzrFrTRNfWeQvmEvPg5cHr/tbVHwy2Du6EnPrjhmy7LZ?=
 =?us-ascii?Q?HcwKh8J3VuOs1zTdO0pLcj5aPeip6EmbXKEStejMCoMw4/vS5Fhc6Kz66+DO?=
 =?us-ascii?Q?P0HN/G70CQpuIZfqG8iELNom0g9AfAeR8+VCyldPUn/H4UDtjg9ZLVigaE9V?=
 =?us-ascii?Q?thuBKKtC9BpP06KUAf1CN82sEoP9rC35faEp/lJl+JrhMKxNzvKZUsQCUDPJ?=
 =?us-ascii?Q?g0xSPR41w96MfNov0ADcNixQdYMXZnACUeHRWBkpkN0JJeb5z6vcyqiE5JGZ?=
 =?us-ascii?Q?NDZAbl6H+CNKnaFm58ZczXBby065Z94fE/SvSBs9sWhO4c9aWK4vP6tOAnBW?=
 =?us-ascii?Q?xvFztYpoEehize2S6xT3PQ2aWH8KDFDRJZdKIvUAJz9NMKQsrLOaBgYWJiB+?=
 =?us-ascii?Q?rcJHTffpjts/nIxG1nvQTCuHsCl9EWq0+NT+SavS/KgA5vxiTqFS7ZuSSHMJ?=
 =?us-ascii?Q?+ZR39IgSS95hyhjQwA6gly7PXU4qha1F2NeDri4NrFH3fKmqaRtx11SY4rz9?=
 =?us-ascii?Q?v6yXOnJt4R4uhTM09g3c9Pw46AoLzLrbKtPAGTbEZAY+yDZKpoR7Jo6LXDvC?=
 =?us-ascii?Q?FNNmbpf7G7XmE/OOB2UyLyBjpX/ABMfzjxnGjJAJVKmjODXiaAv6afu8YKNg?=
 =?us-ascii?Q?kb9DUzr0ZXC9OIHnXX/mOsUAALreBkdYLGjKBve2+KLcflLDjKYVOSSI0Pm8?=
 =?us-ascii?Q?brXGScQHfMnXwGI5B0hqTJAKoJuUxiGRD/R/T2c7+8Dl4MO3LWLB0E6kgye4?=
 =?us-ascii?Q?BhbV2c17+9/thEMKdJc5SSumejTVB1TZzS5DxyNcEAn6JHCb8EFWOzlW/yuZ?=
 =?us-ascii?Q?Y8e2YXaK+ImSBvKWum7TUxxPcwfrMxP1WxyiPuaYlnnzb4DW2ZYSaYzng2yz?=
 =?us-ascii?Q?d0PmjxCC3EbFBrILVl5TNHCv81R1V9Q12Zz5gNCDNrNkZ0sa+/WqOA8/upJ9?=
 =?us-ascii?Q?5MSd9xmP8jyNd4H49TH8BKiTIYFyx8zyMUtQXFW1RKgb49a/tc0Y1Xjw7NWU?=
 =?us-ascii?Q?JCulz93OLBU75+auIrXRnkaf4v0S15Ulv0+pM7YQEwCHu54kLxoNqHIaZFkx?=
 =?us-ascii?Q?BPMVmX5Q18YoJ+ydUfbTB8GrgqU2RzcfFIkvm0NkYgpzvX0JrRIzqbgdLvRo?=
 =?us-ascii?Q?tKd5Ee9PauJbelqudN4/1QPbXrZwmCKBuIheeHpNjvmVQf6ajwL/o+SEdwXM?=
 =?us-ascii?Q?KyCCZDOrhL/PRJuEr093XY3Nf4PpwGmB475OnkIA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c20b40-2236-4e58-af4a-08dd7649a6a1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:01:25.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCVQWpjRrGssgMYvxTaKiAuFmJPzvIyiyS4v9fKLXdyP+jlcbBD7d8bHZDXoylQiTOM9qnljMRVhx54Ctg5EEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536

The look up table(LUT) setting would be lost during PCIe suspend on i.MX95.

To ensure proper functionality after resume, save and restore the LUT
setting in suspend and resume operations.

Fixes: 9d6b1bd6b3c8 ("PCI: imx6: Add i.MX8MQ, i.MX8Q and i.MX95 PM support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c1d128ec255d..523bd3e11ff4 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -138,6 +138,11 @@ struct imx_pcie_drvdata {
 	const struct dw_pcie_host_ops *ops;
 };
 
+struct imx_lut_data {
+	u32 data1;
+	u32 data2;
+};
+
 struct imx_pcie {
 	struct dw_pcie		*pci;
 	struct gpio_desc	*reset_gpiod;
@@ -157,6 +162,8 @@ struct imx_pcie {
 	struct regulator	*vph;
 	void __iomem		*phy_base;
 
+	/* LUT data for pcie */
+	struct imx_lut_data	luts[IMX95_MAX_LUT];
 	/* power domain for pcie */
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
@@ -1481,6 +1488,42 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 	}
 }
 
+static void imx_pcie_lut_save(struct imx_pcie *imx_pcie)
+{
+	u32 data1, data2;
+	int i;
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL,
+			     IMX95_PEO_LUT_RWA | i);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (data1 & IMX95_PE0_LUT_VLD) {
+			imx_pcie->luts[i].data1 = data1;
+			imx_pcie->luts[i].data2 = data2;
+		} else {
+			imx_pcie->luts[i].data1 = 0;
+			imx_pcie->luts[i].data2 = 0;
+		}
+	}
+}
+
+static void imx_pcie_lut_restore(struct imx_pcie *imx_pcie)
+{
+	int i;
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		if ((imx_pcie->luts[i].data1 & IMX95_PE0_LUT_VLD) == 0)
+			continue;
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1,
+			     imx_pcie->luts[i].data1);
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2,
+			     imx_pcie->luts[i].data2);
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+	}
+}
+
 static int imx_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
@@ -1489,6 +1532,8 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_save(imx_pcie);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
 		/*
 		 * The minimum for a workaround would be to set PERST# and to
@@ -1533,6 +1578,8 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		if (ret)
 			return ret;
 	}
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_restore(imx_pcie);
 	imx_pcie_msi_save_restore(imx_pcie, false);
 
 	return 0;
-- 
2.37.1


