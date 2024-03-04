Return-Path: <linux-pci+bounces-4482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C84870B93
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 21:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522911F24701
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2A7D09C;
	Mon,  4 Mar 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="djbE8XSy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5727CF37;
	Mon,  4 Mar 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583959; cv=fail; b=coY26wFtwCjQLyY2nMCuW0oeKgfp50iG6ZPDtCDQbMIznKRJ4eRETGcMh4BphjJ5X+Mor8s37RySZdJGFKdD6Hgqyb1aXPHfOBrtmN+CLDo78sWetwtZ4dceOI1mcay57C+R3TFLW+xIN19QuxixW5YWnk35Gpuwrf4WiXRYRlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583959; c=relaxed/simple;
	bh=GXfso8sA5qp7WQ2bfpwfigNswIhAFh8mC0bwdOHPDh0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pLI9y6BL35iwk67Wz/1Y3FyxbgL/3WELblOKknmX+WcZdZCJcNz2c2H0TX7FKLKra9Yl2SctGFUCrUEcQqdO6SjHf2dRgasE9yxY841j76pIc9CZafRsrc7ghJtN4CzFot7+CEdswIx2nOwE2Ovc3sXrZScFDzQkvdDiNq5A7f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=djbE8XSy; arc=fail smtp.client-ip=40.107.6.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBtnZ94t3VtfSfmPb+/a9s+oNEKYbd5tevxaJkKp13kBWUcIjepgXAjLtj+A26DzXFOasurICv1BKtuh8QkGQ51O+JbvGHFJVU5QCf4KkRRSNLaNInWfOGzZsTIoVw39CiZkxU1aK/nF1Lqg5HB8L7YteZw6LGXiWz68tsaahTixhV5vnjDBK1YC0n+BeFwYvbztJDw3g5jQt4BbKcEvM4yxWa6Dv8Nu2+pCJRA12nIXL4Xo6uRwrk5hZzz2MOls0Q7on9a1uvFywfNJjSOSqr6/TgIn5nGzlQAlgUJiS9h47lhU6QMxKYL0mX5FGdMXVHEYJYlCUc2phw/4MTo4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFC612DWNogn7Jxn6vEo/HiXWDydVNWP/fr24H5+PKs=;
 b=aVPnqQ9i893UAqJEyIZLL40c5XnF53DODScXlDQGvb85XqaNsyTEh5okQjATt5voPFXZiEuidaoctMhWCGruSKVOOb7JXfSTvEDIlQD3MCjnTL2u7Xi2DuWI7noDW7ru3wjCynqjS6lmi/fOqjVtFG6fbN9gl4XyioV0heV4gqKJg0GR4znTD5X9iIio5v5YE5z91n6oVPuUSu0jWsps6zYSOPDAX8llJK5cHdPx4T2RWllV+DPpRurSZnU1mtfV9MYMRJsAC/PLUsf+g+Xl/ntncKNRnY8nNzqRz5i2TqJtrsJKNL5rUG7gMTDg6/kPbEcaxT8kZIa4PHUqFzDXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFC612DWNogn7Jxn6vEo/HiXWDydVNWP/fr24H5+PKs=;
 b=djbE8XSy40VuDlSqSACS39+KynmI5BNEI1RmckrXa8Wh8yBuoG1qjlY9yeR6VoHQ6n2qWw3GqN4iSGm0lW6owBXX+mUChkkz96XxvbpmdEOHbF9bre2zWHP5mszRgBQdMwCUlQT2K6mLeI1opM46wnOBrcIvK+TboV2RwKGh+5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9083.eurprd04.prod.outlook.com (2603:10a6:10:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 20:25:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 20:25:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 04 Mar 2024 15:25:11 -0500
Subject: [PATCH v2 6/6] PCI: imx: Config look up table(LUT) to support MSI
 ITS and IOMMU for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pci2_upstream-v2-6-ad07c5eb6d67@nxp.com>
References: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
In-Reply-To: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709583933; l=5959;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GXfso8sA5qp7WQ2bfpwfigNswIhAFh8mC0bwdOHPDh0=;
 b=/BODBiAWSltekFpoApfBqVCVfOyvMVODknBBkZE2LfnIoq2XL4uc3x4pvCOMXWd2Qg4zNNBg8
 RltNGi77heTBZf/D3HxaTODEZauteSs1LOoLUKAbXe7UhHWFjrZsZom
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:806:122::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d08db6-f48f-42ce-ca71-08dc3c894af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Sve3JJI8SmnqG8wtlA4FrcwX8CTBGKIUSRL3uW+gBhvw19k5Gt9+1MW3UoIMsz7e8QTELyLqRYg2osl5OrjGHZHM1YGFCZ3AvwoCLy/VW7oqQcuNJ0+es4sjeqbrEMmXBlcOrdjYR1/g2JysH//q/xYUq+F1M9noE3Ny6TmI67o+nr0TdDYkZSRFP0iZ3Ra08rvebCX04gfYKAEv/R0fZy0D/N0cNW54edOf/IuVieIyrvl6w4dLC1qxpq3Vv2Bkgmmw1XWfRc8QCo/1v99rknGJmDW35ipxa8rCoWepctKBWhndR0QRgJH0JTSed/4f2Tl/B8lx/XlD63nWacnyf1aaR9DEByf7cWtCt7NCPjF0yByCr4xCWoaGo8uZtj9t10GOnbWtF0ATi4NAs4ScfYgsEZwA2QP+zC4rR7M1M2HtSTdkDKOWsbrOM6Lx1qZpY/4q22KceGU2GSSdvyQbbi50GNEXuHneUFzTnDZgujsLxyCA4jBgZxPlGPauOjZRIGIkUsGBzRB5Q2Nmz+Gr2GgPzviwYAiNt2UTM+7odLuNAVz6xH/MtYkEEH9wkjBQq8pgBRm+UUg1qEL9dXyKSoS0X80a0PZWubefivSxGGJgp7r8aiStPyeS50exEj+HcOyqq/aog4o4cmc6oiNYTvWDZezXJBq+0YunNoBbbCt5YjVXDqQVLdOBlvwyiQOPEGYN2uTkRleF1ZBHu1IOKvKhF9udl/AOJBiL/uJfslw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXBUa3NwTnU5bGdDenFvM1hVTkNGb0RrdDdOblFTcU5NYXJzdXdGK1U2MDkr?=
 =?utf-8?B?ZzVBdXYxbGJRTXplTzhtSXJneDZQY0I5T0hLNGM1dHl5OE5sYlYrY2NDc1po?=
 =?utf-8?B?MXhUbm1DaGRyRmZWWGlrNUtUTmdNWGtoU0MwNHgxbVRKaExid1drbzNKSTJn?=
 =?utf-8?B?NHVJNmlDUGFnZE5XcGlObUpFMGFxNEtpcnExc2ZyMGdQRm9ocnRyRzJ6QmpP?=
 =?utf-8?B?SFJQZFQ5blU1RzNrSDhBOVVTRHhocCs1ZGVlRDBBbS9CcEl0eFFOMXpnNEtQ?=
 =?utf-8?B?dUdaU3BsRGljSHdSeml6Sk9VNzBjS25peWIwOW44Z2hQUkN5NlBnQWE2WFoy?=
 =?utf-8?B?M3V0VzU3N21DZUYxMXB0WHVUa25YT2ZDbjZrWWFDQktMcjQxL3BwRExGaUYx?=
 =?utf-8?B?KytHdktQZEhRRDU2STJ1YlNnNW1RcGFXb0xaOVBNY2tvWVlKaWg1b1BqTko5?=
 =?utf-8?B?Wm5yWW9XMkNma09oSUFCc3QwamdtdkdNeGJyKzFRdDk1dXduM21mQjlRZ20r?=
 =?utf-8?B?VVBldnQxQjFNcVZCM0pHUm1KOUJJc3cyUHN1Wko4VnZBUTBJcU9GNENVZDBm?=
 =?utf-8?B?ZEJodDkrVmZoRDdSQVAwUmU0VXFocC95UnJOaHNsSDdWRnVObUkxNU9MOVRx?=
 =?utf-8?B?NUlpNnNFT1JaUmhJVHl5YjZ6OUtGQ2ltSmEwYkwzalhCM0g5ZmJDbnJmR05v?=
 =?utf-8?B?R2Q3dTFTbVN2Zzk0TXh5UTRvbW42QkZ3SnVwZUZRZUdmRm1TMHgwZERVRkha?=
 =?utf-8?B?SEZ2MTZQdXlkVE5FM2hITlZ5ZGdSOHU5ZTNtb1FxaUZDRFY2YXNuc20zS0Js?=
 =?utf-8?B?VE9kSDhXeHg3cFk1TXdxTTdKREgwaHlvVHFzbVlUVkRVYkNqalN6aXZiT2hx?=
 =?utf-8?B?S2UzcEJNUTA3bGN0R2loaDgvWnk0YUJyR1BPbkhha3A0MTJOVXRHSHg1OG44?=
 =?utf-8?B?TllxUGd1bVM0alJ2Uzk4OVZEdkozS253K2xBS1JUN2s0UjFpVktoT3dzdFhU?=
 =?utf-8?B?OHJ6U0hzc05tZXZzRjcrMUJzeVc0M1Q5NTdzM1VTWGFrOHVsTGd0ZS9nQzc0?=
 =?utf-8?B?aTVpVHlRNWZiUU1TRWJ1UTNrdnhJNzdERG1mQmFXRGkvak0yNjdnbW1tQkZT?=
 =?utf-8?B?cXlYL0hodWlLcDFocTJid3NtZFBpbUlab1U3VytscitXQVlpVStwNzZpVStF?=
 =?utf-8?B?ckU1bEJQT29Fa0lLcUFCSFB5SFd2YzFPRWY2WDNHbVFHaGJkSXFtY1llY2hK?=
 =?utf-8?B?UnRRL2ZDMFFBeTFMdExDazllOTdnRGpCTHR5TFlpSGgvaGxUK05lZGx5RnpG?=
 =?utf-8?B?OStzOEgzTjZtNjdPRFBPT2U2S2dab1B2c3Jha0xPd0Y5QkRsUU9vOWlkZlVJ?=
 =?utf-8?B?VUV6c09MeC93TjZFZHFTemErVFp3M3FaMU1tbWx4dzIza2wzWFhEUDNtUndv?=
 =?utf-8?B?VUJVYnd0RjVqdkJUWUhKcmQ0OHNoWVY1ZnNWcC9Ub0tLMS91VnFkbWpwYyty?=
 =?utf-8?B?MHhUdUM4Sml2dmpTQWRDTmxoK2Nma3JFVW5odkpuU0ovMGZvbDl5WU1ZZU1p?=
 =?utf-8?B?VkQ1TDdrNXJXTkRGN0Vra256Rys0dlVWSDl0Y0pmVllveTJlbEowakpDNkNH?=
 =?utf-8?B?enBNRkVyemF1K1lTQ2xYWGdhUkpJb1kwMGFsMnUvOHlzRExWMnFac2d6dW9B?=
 =?utf-8?B?dkpWdk5GcjhHMWhIbTRseGZxQjFsOGIwVSsxUHM5YURJTXg1Rm9CUlNqczht?=
 =?utf-8?B?YUwxWjYvY0dwaU5MTnI2dVBhOU42SVlsb25sMmJDNDNpNVBPZEh5MWVzSDdT?=
 =?utf-8?B?aVVRcUFzMkZvVzFlb2RDOUZ2S3pxaFptUW5UeXdQNjVYTWdPR1dzTHczQkRw?=
 =?utf-8?B?bFQvT0Zwd3ZmYUxYb2ZselJjVnIrcFV6UUFkRktkY1duVDhBQkFXYitWQksx?=
 =?utf-8?B?cHZ6K0JXTzI5aGptZmxNYjdpZ240UDdQWGVtYmZIMGptaXJ2cy9KM0pGQlln?=
 =?utf-8?B?T1BPL0c4OU85K2d3TVYycnplR2h0QjNuYjg1a1NJRENHMmRSMi9UYVZlWmhC?=
 =?utf-8?B?NDc2YUpBZzZadEkyYjYrVElyY0RrWEpGbDVhbVdvZEoxS056NFVwVXJiQllh?=
 =?utf-8?Q?MXQc7OkIyiuz5zHFkIRORKAv2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d08db6-f48f-42ce-ca71-08dc3c894af8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:25:54.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYTqjvqi3PiTgQ2qcZ6P93PGaAGAGRPiClz7bGKcNRyziTxKI3GsAYduOUlOxGT4zpXHJh2tLgEjJ7H8oznNvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9083

i.MX95 need config LUT to convert bpf to stream id. IOMMU and ITS use the
same stream id. Check msi-map and smmu-map and make sure the same PCI bpf
map to the same stream id. Then config LUT related registers.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-imx.c | 175 ++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
index 922bbc0bc1bcd..8b698e1ec3c9e 100644
--- a/drivers/pci/controller/dwc/pcie-imx.c
+++ b/drivers/pci/controller/dwc/pcie-imx.c
@@ -55,6 +55,22 @@
 #define IMX95_PE0_GEN_CTRL_3			0x1058
 #define IMX95_PCIE_LTSSM_EN			BIT(0)
 
+#define IMX95_PE0_LUT_ACSCTRL			0x1008
+#define IMX95_PEO_LUT_RWA			BIT(16)
+#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
+
+#define IMX95_PE0_LUT_DATA1			0x100c
+#define IMX95_PE0_LUT_VLD			BIT(31)
+#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
+#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
+
+#define IMX95_PE0_LUT_DATA2			0x1010
+#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
+#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
+
+#define IMX95_SID_MASK				GENMASK(5, 0)
+#define IMX95_MAX_LUT				32
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -217,6 +233,159 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 	return 0;
 }
 
+static int imx_pcie_update_lut(struct imx_pcie *imx_pcie, int index, u16 reqid, u16 mask, u8 sid)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 data1, data2;
+
+	if (sid >= 64) {
+		dev_err(dev, "Too big stream id: %d\n", sid);
+		return -EINVAL;
+	}
+
+	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
+	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
+	data1 |= IMX95_PE0_LUT_VLD;
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
+
+	data2 = mask;
+	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, index);
+
+	return 0;
+}
+
+struct imx_of_map {
+	u32 bdf;
+	u32 phandle;
+	u32 sid;
+	u32 sid_len;
+};
+
+static int imx_check_msi_and_smmmu(struct imx_pcie *imx_pcie,
+				   struct imx_of_map *msi_map, u32 msi_size, u32 msi_map_mask,
+				   struct imx_of_map *smmu_map, u32 smmu_size, u32 smmu_map_mask)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	int i;
+
+	if (msi_map && smmu_map) {
+		if (msi_size != smmu_size)
+			return -EINVAL;
+		if (msi_map_mask != smmu_map_mask)
+			return -EINVAL;
+
+		for (i = 0; i < msi_size / sizeof(*msi_map); i++) {
+			if (msi_map->bdf != smmu_map->bdf) {
+				dev_err(dev, "bdf setting is not match\n");
+				return -EINVAL;
+			}
+			if ((msi_map->sid & IMX95_SID_MASK) != smmu_map->sid) {
+				dev_err(dev, "sid setting is not match\n");
+				return -EINVAL;
+			}
+			if ((msi_map->sid_len & IMX95_SID_MASK) != smmu_map->sid_len) {
+				dev_err(dev, "sid_len setting is not match\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Simple static config lut according to dts settings DAC index and stream ID used as a match result
+ * of LUT pre-allocated and used by PCIes.
+ *
+ * Currently stream ID from 32-64 for PCIe.
+ * 32-40: first PCI bus.
+ * 40-48: second PCI bus.
+ *
+ * DAC_ID is index of TRDC.DAC index, start from 2 at iMX95.
+ * ITS [pci(2bit): streamid(6bits)]
+ *	pci 0 is 0
+ *	pci 1 is 3
+ */
+static int imx_pcie_config_sid(struct imx_pcie *imx_pcie)
+{
+	struct imx_of_map *msi_map = NULL, *smmu_map = NULL, *cur;
+	int i, j, lut_index, nr_map, msi_size = 0, smmu_size = 0;
+	u32 msi_map_mask = 0xffff, smmu_map_mask = 0xffff;
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 mask;
+	int size;
+
+	of_get_property(dev->of_node, "msi-map", &msi_size);
+	if (msi_size) {
+		msi_map = devm_kzalloc(dev, msi_size, GFP_KERNEL);
+		if (!msi_map)
+			return -ENOMEM;
+
+		if (of_property_read_u32_array(dev->of_node, "msi-map", (u32 *)msi_map,
+					       msi_size / sizeof(u32)))
+			return -EINVAL;
+
+		of_property_read_u32(dev->of_node, "msi-map-mask", &msi_map_mask);
+	}
+
+	cur = msi_map;
+	size = msi_size;
+	mask = msi_map_mask;
+
+	of_get_property(dev->of_node, "iommu-map", &smmu_size);
+	if (smmu_size) {
+		smmu_map = devm_kzalloc(dev, smmu_size, GFP_KERNEL);
+		if (!smmu_map)
+			return -ENOMEM;
+
+		if (of_property_read_u32_array(dev->of_node, "iommu-map", (u32 *)smmu_map,
+					       smmu_size / sizeof(u32)))
+			return -EINVAL;
+
+		of_property_read_u32(dev->of_node, "smmu_map_mask", &smmu_map_mask);
+	}
+
+	if (imx_check_msi_and_smmmu(imx_pcie, msi_map, msi_size, msi_map_mask,
+				     smmu_map, smmu_size, smmu_map_mask))
+		return -EINVAL;
+
+	if (!cur) {
+		cur = smmu_map;
+		size = smmu_size;
+		mask = smmu_map_mask;
+	}
+
+	nr_map = size / (sizeof(*cur));
+
+	lut_index = 0;
+	for (i = 0; i < nr_map; i++) {
+		for (j = 0; j < cur->sid_len; j++) {
+			imx_pcie_update_lut(imx_pcie, lut_index, cur->bdf + j, mask,
+					    (cur->sid + j) & IMX95_SID_MASK);
+			lut_index++;
+		}
+		cur++;
+
+		if (lut_index >= IMX95_MAX_LUT) {
+			dev_err(dev, "its-map/iommu-map exceed HW limiation\n");
+			return -EINVAL;
+		}
+	}
+
+	devm_kfree(dev, smmu_map);
+	devm_kfree(dev, msi_map);
+
+	return 0;
+}
+
 static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 {
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
@@ -950,6 +1119,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		goto err_phy_off;
 	}
 
+	ret = imx_pcie_config_sid(imx_pcie);
+	if (ret < 0) {
+		dev_err(dev, "failed to config sid:%d\n", ret);
+		goto err_phy_off;
+	}
+
 	imx_setup_phy_mpll(imx_pcie);
 
 	return 0;

-- 
2.34.1


