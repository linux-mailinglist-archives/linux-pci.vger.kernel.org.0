Return-Path: <linux-pci+bounces-1468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E5781F164
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8051F230D9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212D47A4B;
	Wed, 27 Dec 2023 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dik2c5+l"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915C4CB52;
	Wed, 27 Dec 2023 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5tahfWqbujAFfY9r4pxAesioXDpe6bS+NDprALCZ6TSnQ89oG/d0WImnd0egeDcfMti53WPRzj/l/797FG9g7yWmYbYv8pzZqNg1yWYMMD9NJAXAIwR7tKYz4ZyTV4auW+Bu+R+aJbQrtVt6bv+JtZ83P36Qu4Vgmo5jC/GpiSYudlALvlEnNyCOlfN2L28PEC2RvUjm0Nt0bjzwtNqth87uD04gOoByTeX7cl6e2pITET0w2jn6NHYzMniTeOuPJZvuArGmnQPuvcDrpQf7wHPfAfGwgYkefbLS8gZHNufEHcN5kJlwZtcctH4+hFY78hHZoGwBfkFoPGHBf2QKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8vo+UQ9KtGvOP++Or5qDRIkrFEKvxts5Qo6V24QQ9o=;
 b=lyPxgh9XgJ8yP5T9FNNh5l8kHcTTJj1/VNF2OK/m1k/k83RVAONBxthvlCSZb4Vi/UY7OHgfufD9ILuqmzvWWi2M13wVxYX0WHy0PMzmcIbHijmdpmFDFgkh6M6y5Vi6WpbMUFw8y3ekSGafwfWYm0KWD4x6j+N8/Xv1K1t56RpSimzpA8Up/l0OFHUD8kQTZt3GFQ0gt5wjGI0oIWygH/CCS2WBcsRtpz0KSkW+MGpggDVth3CyXomgsmNy8XEMKasDfydXRyKAIf/njgqW5GbX81TwqxdF+BmoMFoQTmkd4Calw0TOnI8Xh8N73FyN2RM0TgnYacVc9Yrr3cIMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8vo+UQ9KtGvOP++Or5qDRIkrFEKvxts5Qo6V24QQ9o=;
 b=dik2c5+lvc7D/sNIx/LbnKs5mJxhTZv7QGyAVZrPHVx2AcNaai5u9EIqokWqBBppiGPxs9w/GuSnsulp9HQIBIWhQ5X8Th3T0naT+pDRh4V1tupPLPt0enja+mFOKkvafHfxECCJ6LWOpFJMxo/qodIw5sjI5ltfwWpqeGWcvLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:29:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:29:14 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
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
Subject: [PATCH v7 16/16] PCI: imx6: Add iMX95 Endpoint (EP) function support
Date: Wed, 27 Dec 2023 13:27:27 -0500
Message-Id: <20231227182727.1747435-17-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227182727.1747435-1-Frank.Li@nxp.com>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c2cc65-335d-421b-fc67-08dc0709ba49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vCt3+gXVP18Qy50gV9C9icewQCdaLpjt7Cie4XYDQKAKqsGCac8YCkzuujJb2ZxjR+Be8E853oIkGIaXQsm+2ZJochgSuMhG8/ySnf+emYpwvbtB1+s+1Poy8R4I6ItR6KPexwHMJehJ6TV146dPWj3xC1MXGVIZEJGA0QPDNX8bW/i1GxJ4xO34x3Huk7zgUugWBz08HG7mGmyWaq9HnURwQ0OdBKk/T9fnHlggBIHcJ6Xd8u4NTsRAr9oFULOtciCvJRaSiN12xBmRF4onHrLOLbnM8k/VOk3Y4/g8jPJQ4oRaIf30djd4aBaOxv5yoQWN3pqXee1sf/a6qnwiClni4Lny+nTqZDH9RJekjk4+jODpD8EHrK879MBnEx+81lNglnP2wfdRUHmajopKLqfuhwXxND0MKmMfBQRIs0qjdOiJh3g4c2+hIQWWUdiYOKwbW6taxsQFHGQf0HahkF6eqFBoQWFZbicBozG5COoily7qs+Ysj8JrnIUI2TXl8mvGeLFEMAdx5KSp5BIPGVfUOQqh4HWklCCXZfoIFeGpCDbfEtGyCSKIEOnrqqXwztkOxaZF7tgJDVRwM1nFZWm05v3AMYSKK6dUpcT0W9uWNhfhCIf939jUvx2R6OvR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(36756003)(52116002)(6666004)(6512007)(6916009)(6506007)(6486002)(66946007)(66556008)(66476007)(86362001)(38350700005)(26005)(38100700002)(1076003)(41300700001)(2616005)(2906002)(5660300002)(7416002)(478600001)(4326008)(316002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BGDhlxISj9Qg/Mi2OHKaySCVE+5YTKOjxQlH3g6Z83YoeqzUTxAdtrFiwjqW?=
 =?us-ascii?Q?hzYfhf9Jati2A7vU+h65ccqzeXE094qVsdrOr5trHyU6fV9w79BDN29b8rx6?=
 =?us-ascii?Q?29sL3WYKpGkAbjYc+rpd0olV+5NEI1UhTxBJrzbf4XlmsGxK92rsqJ2pgLfM?=
 =?us-ascii?Q?FIgz24p7RhjrNQTJ/v/0JekNOFU4ejJ2Av0ZlqUOX4H3tpJrmWxjgmchDiP7?=
 =?us-ascii?Q?htNq43O81ywO6F8JsMq5rM6gynEedGgsgRF5LMyIZ9XqTrlMMtGaMAUHorcW?=
 =?us-ascii?Q?FkNEEma6Z07ZuQwdNEZlsXWL4IxlEBbmfvOU6KW9ynd+el8LI+4hxwfcLlDF?=
 =?us-ascii?Q?gQ/ChWNV1tdC6AthvhquRLrJgp0QsoWiSKB7dLku5eS/0gChJI32/JT5Ph/Q?=
 =?us-ascii?Q?l4OuGwEQZ3lcI0qt1516r5W5q/6C09TpfCmE/ciOqEbuy7KkRK9kubXyigeu?=
 =?us-ascii?Q?cNxO/AZwR2RQx0LbA1YCuJTl+dIUs8dpGDByT7Aeu78Xvk/bVJVlNkBcoMif?=
 =?us-ascii?Q?WXlqVMKnYiabRPPzGM6a384nYaN/n0/aCtG9aig0GkiPu7fFxr2uZxvSxShx?=
 =?us-ascii?Q?mZbyzbT6ZKeycFkUnw8K/JmWEg4wi6xHhgMtzJAtuEYGTW8eLfbr/cdaMq0G?=
 =?us-ascii?Q?haHW8CD7ViuMcrdeRE0SLNCmxF+IOXFeUyFi5r4B1+jZUk8g9h9kCMXwX0Rr?=
 =?us-ascii?Q?dVDMqZ3visPqbjXBDaFbCGUiJyv3CLdf9P/UjU22PbwHnar1g/HXvXV70vn0?=
 =?us-ascii?Q?9t6F+QHLVSRS+t83BShhJIJZIilYd5708HzB6iw5F1xYmUWIHNFAFiMTuPuV?=
 =?us-ascii?Q?JXaTKUpmHye1xYV1yQtu+pSA/9Udcb/6j5WKOOBkrd8DehKBhGseo/3+5IQ5?=
 =?us-ascii?Q?fmm1l+Sgj0pYJ6C0updBU2lvByotCgiGHkZwzDlAPeBwFaQ/SaWTsWmLXIDf?=
 =?us-ascii?Q?jbR4wiomjiUWyKHQwlJN7SDWkoI7og2Acf+xrDviXHaL6LCoYEp9r49mreJX?=
 =?us-ascii?Q?6+k7c4hJJj8/e/Dp/JkUYWlcxSZHunvvDFUIfGHTquHfH5zkW+YpOKcFJHyW?=
 =?us-ascii?Q?75B+9qV1A1qVGYtKhyRCOrcShmoQGZPswq8FsOwpJnkSzKFtPvyzptQcvlgK?=
 =?us-ascii?Q?okXmufQ+m3NMIyfZjbMfOzX2N3gw2nIJr8YZK6X/f/Cx4gLcuomC2BSoLvHG?=
 =?us-ascii?Q?x+yW65XYXd8R4chFmfp8ayGQmc1cEqCEp7r3ysOUbthXAn+aEBtUOcwFnOgH?=
 =?us-ascii?Q?Er00z+s8wiKQkmp9mAHdbo+/8oUyXHFQmCDpYJ7zjUJkaEV56LVVYenh0uRg?=
 =?us-ascii?Q?qm6EGUkArM1/8hBAYZXSKea6P4tvuNBjkb3ry6q+0MnwvERYmS8IvC39Z362?=
 =?us-ascii?Q?RGAxEHZ/gJMP0lPH/pA/D/0J1X7UBo3cPAVlVi0bD3V5nJA4kufO2iIJw0Vj?=
 =?us-ascii?Q?9npw1kbDVWw+Uq4FWiuZ4TaChaASghvsvVSyZoTl5kwCgYJMHTfLtmErqX1+?=
 =?us-ascii?Q?wARO/is/6y6G4z0ZNcKYswUEUPuVKhBZxghWAoAacIdiJJqLDIcFAynBL++R?=
 =?us-ascii?Q?AOqwuOptmiAhjJM7Wvw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c2cc65-335d-421b-fc67-08dc0709ba49
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:29:14.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBzqDje0MZ7S9t+ou6A/REfesmugsM5eLq7YJntk1dFAd5uuZJbb/MsX0r5Vi5GsGeFUzyFoF20l/pBX8YxDng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271

Add iMX95 EP function support and add 64bit address support. Internal bus
bridge for PCI support 64bit dma address in iMX95. So set call
dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - change align to 4k for imx95
    Change from v1 to v3
    - new patches at v3

 drivers/pci/controller/dwc/pci-imx6.c | 45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6a58fd63a9dd2..00ec59867c17b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -75,6 +75,7 @@ enum imx6_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX95_EP,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -84,6 +85,7 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
 #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
+#define IMX6_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
 
 #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -620,6 +622,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX7D:
 	case IMX95:
+	case IMX95_EP:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -1063,6 +1066,23 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.align = SZ_64K,
 };
 
+/*
+ * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
+ * ================================================================================================
+ * BAR0	| Enable		| 64-bit		| 1 MB			| Programmable Size
+ * BAR1	| Disable		| 32-bit		| 64 KB			| Fixed Size
+ *	| (BAR0 is 64-bit)	| if BAR0 is 32-bit	|			| As Bar0 is 64bit
+ * BAR2	| Enable		| 32-bit		| 1 MB			| Programmable Size
+ * BAR3	| Enable		| 32-bit		| 64 KB			| Programmable Size
+ * BAR4	| Enable		| 32-bit		| 1M			| Programmable Size
+ * BAR5	| Enable		| 32-bit		| 64 KB			| Programmable Size
+ */
+static const struct pci_epc_features imx95_pcie_epc_features = {
+	.msi_capable = true,
+	.bar_fixed_size[1] = SZ_64K,
+	.align = SZ_4K,
+};
+
 static const struct pci_epc_features*
 imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
@@ -1105,6 +1125,14 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 
 	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
 
+	/*
+	 * db2 information should fetch from dtb file. dw_pcie_ep_init() can get dbi_base2 from
+	 * "dbi2" if pci->dbi_base2 is NULL. All code related pcie_dbi2_offset should be removed
+	 * after all dts added "dbi2" reg.
+	 */
+	if (imx6_pcie->drvdata->variant == IMX95_EP)
+		pci->dbi_base2 = NULL;
+
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");
@@ -1355,6 +1383,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "unable to find iomuxc registers\n");
 	}
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
 	/* Grab PCIe PHY Tx Settings */
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
 				 &imx6_pcie->tx_deemph_gen1))
@@ -1557,6 +1588,19 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 	},
+	[IMX95_EP] = {
+		.variant = IMX95_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_SERDES |
+			 IMX6_PCIE_FLAG_SUPPORT_64BIT,
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
+		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_phy = imx95_pcie_init_phy,
+		.epc_features = &imx95_pcie_epc_features,
+		.mode = DW_PCIE_EP_TYPE,
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1571,6 +1615,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };
 
-- 
2.34.1


