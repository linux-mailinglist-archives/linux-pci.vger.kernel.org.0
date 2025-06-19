Return-Path: <linux-pci+bounces-30168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B7AE018F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BC919E4EAD
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8A2267B90;
	Thu, 19 Jun 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l0S3b0fx"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3401E2676EB;
	Thu, 19 Jun 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324331; cv=fail; b=QXpj8u2mFPcWBDSb0u14XJWUpWrfmCB45n5sUBkqFNSBpaFx37PemlgrNFdfCjIDd8h75Ogjnvqt1VKI+Lv2XZLmXb02VgIj4WyOTPlCZOIJD58uwzakhBgKLP0cQ3qGS7i+oGux3fGxlm/FMYvLB8XWUQ38YYVNkE0TwQ3weAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324331; c=relaxed/simple;
	bh=AkwokfXWhMKSgbtc8PEX5WsB+jZ2kd9VQP20c/h9qPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PP93K87Kh6TjBjGjmZcv0oKWz+UQBsoQqAXIiZBzLhnoTM0yInc07tYfUeB/4BrIx9EYDImqwCEd+7PCJGYJhSNwa5EYupuYVjaFuHEIn+W3UUCQKUMVQJ0zfpiXfwz2A0MBc01ntfwEIz9D3O4hEBwb7zOx+l7fK4wJC6/ar9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l0S3b0fx; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjchl0LZBVMXTWOowCb1KAnv595Ifd+P+mjTadbttEmau9SF39U86lBGvX+ERXtxY48JlS/WB/DtsZ2REfV1QmyzgJz1zUAf1dKrvDk4DuDA7ue0Vm3YcTw1exZ+DOXRj0DCfYFA8KOmKaTdugFPot/dIBtRBNYEj5lM8SnOPOMaxk3+Ka1jJDZZgJNvV5C+xamqSyJq6vKTW0nY2yKnd7fEcolmKqMZBY3mg4tdQvqKKLEZzTD52tSAl3NI0Gcoi3WU/qfqWI6FnFTspg2NxM2UZri04H48DRdgTe9BqMF5qcq1Keq3X0BCKr2sS3BOFkHRuGzWXBibGZSHLFRV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K59Q5T4spFyC7ZChrqSiJsmgm0+wgWy7FHsNuTzuTDk=;
 b=Tn/eh78ASWNLF6ollglOcahpVPPvnEtlUrpORllvDlD/D+pDXohRHp6tUkQqZ40MIdVM5WPBgwpihZpZXncKIb0YNPug/VjAmQChMVjowbqsLlitODquk2pFRrnJxYahquXHl9jmSdpCJPaGOtyYHzsW9di+zBjSmnIx3H6EVUZ0u64621+Ai63oicV4oVhyrZ5OKR0Zw7ECqP9tQ0BphiFGBJyJM7wlnU1zAg4oJMUSZc7FoQc2xQ9RNZosZBJqyvviyRAcHJWpbC4zsofxQWE46dIXu8wX2HWa4f6di8HKEy5i6D1Ug3I7S+A7RPUCdDdV3P9ltBCBVZQnX2hODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K59Q5T4spFyC7ZChrqSiJsmgm0+wgWy7FHsNuTzuTDk=;
 b=l0S3b0fxbEvSckaMECdDRHAQe32hdoAmCFKuiX8uzG3vpOE/x4B9l1NRaSJsZj5UD66qnAuJrWzrbNHReDbJIoHI7yoOFYHdoPKm4eZ+9hYvRwJwBaUv1WukiHefFaXoStfbbBXKrHfAeX3E4lhhwVxyntB+fDQJjXqx7B8oJHiQ/vY+JxDhXR77sH7cUNa+AJZELoHEaVK/yhWYFq6MLEIE4X0kuk55EecgSmmfDMZlJ/FhLkyLZFzwfGBqHqOyCsKgNUTLt1VaDybYpcjjcNwSmIgVraKJLGLHVbUQX3L1WaefCm7UPcwl55i4HUxDDtQ0CMylzxpbHfspNjMqtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB10084.eurprd04.prod.outlook.com (2603:10a6:150:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 09:12:06 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 09:12:06 +0000
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
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 2/2] PCI: imx6: Add external reference clock mode support
Date: Thu, 19 Jun 2025 17:10:04 +0800
Message-Id: <20250619091004.338419-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250619091004.338419-1-hongxing.zhu@nxp.com>
References: <20250619091004.338419-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GVXPR04MB10084:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c9ae29-ee42-43f1-83a4-08ddaf115cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ndxjafLfHuAPL0UaaDf4nVDLh9au6P7f4OHPnnQOXvGnUep5n7YqNBMFJqX?=
 =?us-ascii?Q?qfRTK4YuPiIKrSRkJH38MXE0Ro/n/RIfAey06ycgkasorAgS+h25oSYYMfXd?=
 =?us-ascii?Q?kYubk39esua5bbODtjeEcm/umVhXZkfmQauAMhC9xvUjTpmnddZTQABbdozW?=
 =?us-ascii?Q?B9kbzx8lHdKeuyflV3YJk76iuhdVeODODgV0bmxDktHvL02BbAc2MkeflEpP?=
 =?us-ascii?Q?caM1owzQBmiqNYbimD7o0VPXEWd6zWw6g+d31T7ZaAP5nY7g6frkpT7/902B?=
 =?us-ascii?Q?2T3zHdUasaKjz+XlyU7WPPdtW3dne2LKVTmyKUwWVcsJrk8gO1rmBPYoGQGg?=
 =?us-ascii?Q?8dekQSqo66ADTUtz5jC/saDp6oRyfQfgOhQ1+2fQzGE0OijEE2BF71gogqO0?=
 =?us-ascii?Q?s42AlSaILRSchvYWL4d5elOf1p+OtEpKs8JuKPxyYyM9dfw+79FthnqXnSOm?=
 =?us-ascii?Q?MEI38NlxORgsWXaIQzB7zUSJVgQDNpxAeAYIlhnMcc84Wc69GRwGUELqPK/T?=
 =?us-ascii?Q?bQWh4/oCb3i7/vyZt3A3CwOE/xbH61qHC4shViNT6yAPmvH6gjVVoVuXg1H4?=
 =?us-ascii?Q?5TrgELEN7K8+ayv3a6SEkmUuUdinhBG5+MszpMlHdeGy9mU9fxjxaopJ2QP8?=
 =?us-ascii?Q?/r0dqumg4y9XTEx3t/2vwHIxuVZxO//wp2UaTC+vus4xP4TeZMZEQaQDB2/d?=
 =?us-ascii?Q?DqyLa+Uq7FulpVA3L8lN/z2STW14oJ+t+ZRz2NtIwHeZ1YzaDJytdie+9GO4?=
 =?us-ascii?Q?+DfApuff1SBNkSJCkYUhxPLUSbod46P13ftqS00khHXMt+QbtehKVqqkRJjl?=
 =?us-ascii?Q?Q5njE3bMM+CYRU3XSCGE3Ws0ISx+ge1lgCkCtr3UcFLWz/2CyuR7fGUY7jgu?=
 =?us-ascii?Q?OodxbrMZWWFv/Ec66j3p69Twss1e6EUAY5ExjYnOh3loMQHAryhD6/rPSrfE?=
 =?us-ascii?Q?3ZvlUJiAEIke/cGDIj30ioERVaOl+Lxs0FEwggHmqv4roEWZH4TLtmHK2KUm?=
 =?us-ascii?Q?HnG5BvUyAj9jhpAFcZI0xFJLY1RKyi78a9Pb8BLLcZCiKM7bVdhyYEGeiz2I?=
 =?us-ascii?Q?FSBRqwkR61n+UVC7x2PgvcQlkqwfm+dmpJmvRq/FPHIo4bjoU0fWuQhNsztL?=
 =?us-ascii?Q?a8ys3aAh1nedInqBOjA16CVymhpr8Ez9uKvujC1ZbtuYKwj0UY/gfDTbVLIj?=
 =?us-ascii?Q?EgZi0m7ONwMxRU9VQFmu1mKU3Gy6avfzWjuH4rzGsXeZF6fPiSCXo/YNYyDq?=
 =?us-ascii?Q?Pl5hOyDiobaLcqgoxWA/UH6UrPrRNnQoBNszn6PTZIumEiAVqB8i7BfZ68O6?=
 =?us-ascii?Q?LwvTAUkW8J0lZeT/W/cHco3sarJu06gCbYNj/PGrccoWIvdXjaSb4ecISKuS?=
 =?us-ascii?Q?lqZ15GroS0S5ahKEleX655Rc2mINXV7ZXGoL8D8rIobg4chpB87GmudJQ1/a?=
 =?us-ascii?Q?2Txk3iMxOQ+yT/qSrqBkWIABhsxqrDd+qT6+8tVLanAUqfq6udD8qeZkDyUs?=
 =?us-ascii?Q?mGBDWVOoyC/mIXk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cfzPZlOj7EIolJDXa4Qs/T32bf8/YwrbvR+gDoSMEa1fwPz2WAMTTcVR6QVH?=
 =?us-ascii?Q?iszchi9dI+zyaEZhOnbkbos4jXihEC2VOKbCSpAha30k3/cY1/SjKDlvrcT3?=
 =?us-ascii?Q?6vmTgT+ADVFI4W3O5ofnhZadVFJc/RDd4FdBKo9MEs+GmqXJHZZ+dBJgP/LU?=
 =?us-ascii?Q?uE0YpDcNtzbP1S8TXpaJIQV7cIg/rd7ivY8ST8JYed4y0/Zai8uAHfcEAGbn?=
 =?us-ascii?Q?upKP/IFkNWx014Bx5WhEkFHdMTTGyN76qko7fPhkkCjQjXWVnhReg1rJIong?=
 =?us-ascii?Q?UBBE8a05Gp6knvwT6FOpnti9MzwQRbJ6ug944CJQodUzdCmJhD35qBBolZpl?=
 =?us-ascii?Q?NXHzI1eomVXY2LY7TeRokwvrC5By/8zmGVr72hy2Of3jX40GLzPhyPAEstjS?=
 =?us-ascii?Q?jrPjBL3yjuOTr+A89SRtiw/t6llznl2hK25dXKVz4i+xWTkAfFvts9WkTb3h?=
 =?us-ascii?Q?6a5iu+lBDgGcBK2HYwiLgJ4w46T7iXvu+9oThT6JrbxopqJY8Im2ZyU69Y2V?=
 =?us-ascii?Q?szWC/2t7LdmEzcWTV8yptuhURaTlKar6wcFRv/n2vfOH3lO5MGrZk+hTTOmj?=
 =?us-ascii?Q?GmPr2u0L9OSZfGVnVqQjkToPlqM2E08cbqdgV2ymzjwXka5rMfe5W/kAnGgb?=
 =?us-ascii?Q?OyIzvZmMm7grybDpBazABrvXFiOTKJ62ppnx7NCafgbffk0TCqpb8soqu4Av?=
 =?us-ascii?Q?psfNEjK0TEtCKINB4JOU+6488jSGImVG2boBoQCCGSZSw0tT4i0/CuhwNUc/?=
 =?us-ascii?Q?kJPKIY6VBkFI2f4RdaBM1zYp6JrE5rtwA8YNrRan07qZLUM5aQ81OlAE+gOR?=
 =?us-ascii?Q?WwQB+S6FbQHhIeCL9iZ+GsX9o6xgyqriuIS5selx+w9z1WMEu9SEguh5MStG?=
 =?us-ascii?Q?7rYXdm55nvZo4JdIFwlC7XqyCNYxnKdnmAIoSn8fOwBTetZdGFk5+VGhhtgN?=
 =?us-ascii?Q?amBjXsecoQ+mPdveGOsRY6MIsZVz8CAJ3U8OeahrLCJflARrYhicmNSlB5Zy?=
 =?us-ascii?Q?KjQ9ikCuLhxv1kAB8zFVuXvWFReRRowFNIfL4OS/0J5ckoCbq95OaKq61TEp?=
 =?us-ascii?Q?rkf7J3GEDQanYN2tJjGcroUv/tFSnzKCKb34OKT6JHnZyySZjRndR0YQ9uyK?=
 =?us-ascii?Q?76FwD9yz2jSKrYy3ATcJq1a5vuy1JJgW5YIQ/5SBo9RkSKrSeaBt5VgD8QOv?=
 =?us-ascii?Q?88YarbqOtZfQ6u8YwwddFBuU+lKh7JSp3bDpUolNKJ+lRW7deO4ymk6bbybm?=
 =?us-ascii?Q?/BgVIEVIQAJdy5s7bGiySAJ0OLcaOxx9V/P4rdkLM1XQfneldfEMDknxSEg5?=
 =?us-ascii?Q?tNCXFeul/HXvjEAEGlheXdD8x0iazSROpWanTy1MU2jYj5wg0hfaFQ78qoEk?=
 =?us-ascii?Q?j57WkFt8A/nYjHkTHlM7q9rFVXjFqy9WMpRxa3uE5SLO5VSY7hv0jBBf6h8B?=
 =?us-ascii?Q?92wJj3kLn5gVZ+4WVMcvmlgLG+u4urOjsGfbdjDNNW2L1PgdT/0fUD0bKuMj?=
 =?us-ascii?Q?IrSnzdbl9KCK2F4lVajtvtL2vOGNmLJuGQS9unktqQHOSuuh2xhsSD+Y7Htx?=
 =?us-ascii?Q?MtgGBHfStnl0VZ80atD/GyP24xEJklh3UsZxp62O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c9ae29-ee42-43f1-83a4-08ddaf115cc5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:12:06.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ew9PslJe3/ns05/3Fz/BtumIQrMky/GDTuvQgKd3rWbhby4uYW1picBiFvM/0QI2/Lj71KoXh/lIhMIDR45yjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10084

The PCI Express reference clock of i.MX9 PCIes might come from external
clock source. Add the external reference clock mode support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b..71f318bbc254 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -149,6 +149,7 @@ struct imx_pcie {
 	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
+	bool			enable_ext_refclk;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -241,6 +242,8 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	bool ext = imx_pcie->enable_ext_refclk;
+
 	/*
 	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
 	 * Through Beacon or PERST# De-assertion
@@ -259,13 +262,12 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD, 0);
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_SS_RW_REG_0,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0,
+			   IMX95_PCIE_REF_USE_PAD);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
-			   IMX95_PCIE_REF_CLKEN);
+			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
 
 	return 0;
 }
@@ -1600,7 +1602,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct imx_pcie *imx_pcie;
 	struct device_node *np;
 	struct device_node *node = dev->of_node;
-	int ret, domain;
+	int i, ret, domain;
 	u16 val;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
@@ -1651,6 +1653,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (imx_pcie->num_clks < 0)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
+	for (i = 0; i < imx_pcie->num_clks; i++) {
+		if (strncmp(imx_pcie->clks[i].id, "ref", 3) == 0)
+			imx_pcie->enable_ext_refclk = false;
+		else
+			imx_pcie->enable_ext_refclk = true;
+	}
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
 		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
-- 
2.37.1


