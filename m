Return-Path: <linux-pci+bounces-763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F6080DDB3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA94D1C20921
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04EB54FB6;
	Mon, 11 Dec 2023 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PoRouyGY"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B627AF;
	Mon, 11 Dec 2023 13:59:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aioDyDY1MjhoaX7jvAACOzIpbZU8X/1pMqAQmxOzcmhIvrIb3aHHIYRnVwd4+1sz9V+hBqjoXzPjXQd5xsx0EFMywUYn1Iz6RiUQ7yMksYbBP/+RzSzmbhHSx4Lm8eBvmpLOAou3bR44HiVxbWL8JF0PzNWoi8zZhtBRHiKJb7Z0r09sPEHPZGmStixD32+ShVYkiPPwirmNIszLWdsxkjd5MdT1ftDEIJLJQToPRt3EO88vLc5mnaXaQs/9JSOOtdNHDgAzXMRcqjNOZgxSbfd9b/diYQ8uzdVMWrNPFVrfO308Wdkiy0rplQCQ1N9G1e95E6E4/3o6asnZ2kUOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJthTGUboJbSpiFhEZMkccKhQfW1YQa9dYwxCm20R+E=;
 b=lE/SRTJUi8ECAuXuMg8qALkG5tN3Nhimgo7wnv2FBTwKPpPwQ87S6zcdawuYwcnZeVHLeJikCquod6cC01ld6aj9416g7bf5h6/B6zKFpBLiJnOHK41rHrCMMC8zqlbWywkIn448m60HpdEIBzI3mgaS+vxsAWdTwei6hrk4huCrg7Mxu8ZEhCG8EAu9/prwfPu8VlcrLnRqK11E0AIyX50av1PPGR/Ymr/k2iCenWwRqNHGocXUySWVMK55ZM8UjaGmTTyx8Nl/A3tpxIeAwB1Ifx04mCghLMbJDHBJPrMBypXdF2pMZqDh+odjmWi3djgI0axXbQ2W+NjuqRGCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJthTGUboJbSpiFhEZMkccKhQfW1YQa9dYwxCm20R+E=;
 b=PoRouyGYOIpocxPrNTQHpUxkDzAtfMZmGEAL7NI4I4wTA78lBUZy8GnlyPd98oil2mxI8Rd2wyp/bTWSS6pgU3/FVDmDNpdl/Rl9R8+grFuqgGtiXKYVtFX/HlAps3U9+gKnuOMqM3lhD+FM/uAC44+3/W+TFov0AdOPZvxOu0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 21:59:30 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:59:30 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v3 02/13] PCI: imx6: Simplify phy handling by using by using IMX6_PCIE_FLAG_HAS_PHY
Date: Mon, 11 Dec 2023 16:58:31 -0500
Message-Id: <20231211215842.134823-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211215842.134823-1-Frank.Li@nxp.com>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: c68c9b6a-2b42-4cc9-eecd-08dbfa947310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qcnDG+EZCkcz7TYGEnsAMFDcaCBSg3wxYbUfSqtkchipG6dzPUrSd0x8pPn75a9MY4PgyxX4Iy39SqoIjSRpRza8LJ4k0cmFgPFpQgeGL4EGkaJYYmcao0bHlLOaBSRub/9+qtXzbVcYUUizzrmkpyKs3ADLKB+/qTXP7Gc0tQT59XUXCIHqBAxulSgnCXULH0+cbk5nlaRRBpeMEdDVJ6FPZmgsbPY31sCsz9DGTz8goQRguy6HiZOZsbFCzd1JOgKMyj+aaJpJqGw8kR+6gsr3+G/7X5QVgVzPlK95bKACHoAC0vBTbonjPCMyUtEzoqCVtcuKE0V7xdh8lE/BYKr2cl+yDFKGdv9Amg1hBDUCIxsVnzmBT8iZK9n30i6plb8elaea9xLyGHuZSBrACiUSz77XhnXqfYZWM5u6WwIn4RRtJoi4nOIfaZJ36gsuRaN/NuNJaHBheftTt/F2WKVZ9W6Qz2UjRATt7YTzP6zdlWjXzbe/1pycsIGkFSOkanLCK9wNVxPDIN+oCdExDy2yWgjOGwXOH7wIlSOidY6tMOKrO0ZCqb5HQ0J+RTuIzieVVZCjbCmxubTZX4RwImGR5/vxpmUkjA+TcwMweZ7sVI2mR8WMydltBtrrrvfa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2rlerO0KAcT5Jqdy/jWviW7aWX614O8YBQvHrS1GfSroVhyE0sZqVbZCQOU?=
 =?us-ascii?Q?gdUoQz9ASyEp9pf5/TfllBy8sYIkchrD9HdHJNq5dIZjrt+ZTALEOYQFFIJr?=
 =?us-ascii?Q?yZjlLMLTzqRMz4zpHNeNhraiQihjGbcA81EIBQbHKThH1MfIhZ1/SnBPdTcO?=
 =?us-ascii?Q?6XS4lyp/Jf04ubReA+dgi6GVvQK4QAFcEkJCtrv33hMAaXPQf6NgWm4io2HG?=
 =?us-ascii?Q?ngd49aEEtHgac9a3lNLaChB8Mfke4Hsaqd+zwQehsHdkpmGV7ZR4Da3TvvC1?=
 =?us-ascii?Q?OqdBEgXStfA64052eh6R5RxcC9sxWSJya9fUfuJGR+VCYvjTrOKC08gLqs8g?=
 =?us-ascii?Q?ux5uk+WnIn1Pvcx30c/zcCZzbAHQi4hC9gRc3NyXqEmhwTFVu4Nbad/I22IG?=
 =?us-ascii?Q?L3TpyOXfyYnQOpx7AoI5Vl2NWb3FECEIyYNxWXKZOCNBpmFtpn26WrkbMT2L?=
 =?us-ascii?Q?OUB/CPIGcN8jGUj8TS85cg4x0tI1pqyZ0wp1BJtPM8xvTXnx+Jj4NniFBqoC?=
 =?us-ascii?Q?OPNBDKKHEJyBdXXYzEWeaBiBDoFNiWsjcRYjxakrXP6+/b9HIXLFJrAOvfr3?=
 =?us-ascii?Q?Q6f25JWK4IkEjHW1typHGAPVbS6n0m1n6Z7jBBOaCFMQtyFaieQfVR/u30s+?=
 =?us-ascii?Q?W4GHSJuoAlGXNIcSchxajQaGMTWuYQazx7zQDIZornUxyi7pq2v+F0ptpi49?=
 =?us-ascii?Q?njgbrNVQqVLiNMFNYiwbydRNpqj+6mNi1euuM5OusrxmK4hzIpt6alA3Tu1S?=
 =?us-ascii?Q?ngSk5loyasmMM92paNjfLh7JD5JOQwCsLyqPhHxuTPHSwKUR1rRzMV02RXpY?=
 =?us-ascii?Q?c8dVaSC6RRgCRv32269Y48xdoA9OQ3j6VH4RIHc2plS1EZix7gEOejSAFqCH?=
 =?us-ascii?Q?xlOSHJSmFXwt2aTeVme6KS8ZU0BGA+BBSWoiBw2k4Nd3oN/kDLVFCqUywqaL?=
 =?us-ascii?Q?tCtxFUqo0OYDLYrjshTQ6wrm/M/WnKnnA0Z09dJptQApFEq45K6XRGmAYzmU?=
 =?us-ascii?Q?+m40xIGDNQ7NvQFFCNW09NffvaFFuj8mvyY612IdNMu2RKulmeP0T3I+YEP/?=
 =?us-ascii?Q?vDVQcZTNBw4vGSJEDGmsBIuxSutKwDacCFL6Df3xX6NCjP7ODTES9e9VH/Ci?=
 =?us-ascii?Q?g4N9lj9J1R/A2ij1TaOZRCbUy7dm2oqPyQJRTEXAuV2CQeADH/VXqtciqtv4?=
 =?us-ascii?Q?a9gGF0vNOwp12fuJ9mNVg1roH5zSWOdUnllbsxi5INUKgxyVsH/UPwUWE6BR?=
 =?us-ascii?Q?BDq0Ue7RWhV2FL0z0wCHUYpL6NakUtDobP1JdQMjcoUdw2Zbw2WlNPOoBxFv?=
 =?us-ascii?Q?uKZCvIGic2ayuFA0v2suqyj3fSqpFm7YkHXPNqH0JsnATZA3QHwDFvI/COzj?=
 =?us-ascii?Q?rtCS+OFc2veosagEn4vL37wbRTcb/WW942zrpJoAb+wAmKI0y6y6F64GI/PJ?=
 =?us-ascii?Q?aFHMD1wb3/QvpM6YZ1fui4Olim4P7w2+qU75WsU3EW/KYsz0ZqOr9wxS1+0P?=
 =?us-ascii?Q?KdhJSZbjgWYLgYroWNPQumVALzoW/8nBFplfJh0U7Vyjqmxpw6eDvjJ8IcH2?=
 =?us-ascii?Q?PWs+XFlX8cEDxBim3L8zUy+5ve0cZ2esQT23Gns7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68c9b6a-2b42-4cc9-eecd-08dbfa947310
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:59:30.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHrMfRaACH7HqS3Zss6U9ehGPbFI1OzhWbuFExHmekz/Epv9AJxzAgu2XzMEbthSycb4sUMO+1XTv4dbUN9T1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

Refactors the phy handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_PHY bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling phy.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3:
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8a9b527934f80..bcf52aa86462e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -62,6 +62,7 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 #define IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI	BIT(3)
 #define IMX6_PCIE_FLAG_HAS_CLK_AUX		BIT(4)
+#define IMX6_PCIE_FLAG_HAS_PHY			BIT(5)
 
 #define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1327,6 +1328,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "pcie_aux clock source missing or invalid\n");
 	}
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY)) {
+		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
+		if (IS_ERR(imx6_pcie->phy))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
+					     "failed to get pcie phy\n");
+	}
+
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
@@ -1356,11 +1364,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
 					     "failed to get pcie apps reset control\n");
 
-		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
-		if (IS_ERR(imx6_pcie->phy))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
-					     "failed to get pcie phy\n");
-
 		break;
 	default:
 		break;
@@ -1500,24 +1503,28 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
+			 IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
+			 IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
-- 
2.34.1


