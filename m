Return-Path: <linux-pci+bounces-1117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DF4815DA0
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE62F283E95
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4701D3C2D;
	Sun, 17 Dec 2023 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nPZQtDVJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18911711;
	Sun, 17 Dec 2023 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMOdLqcSpJSkDHTXqXvyrlDcbQ1cUcjNT0z21s9OLicaHVzbm+Lf4JpA+xiMNYXZyVfC9frANjYz1dPcN6c4LlIwiDq7mNI7FFWjrcQD5G+ZCv29WiLJaTVtq4G+n3L7HdiKagnxg7DybG3iQ/vO5Cr0lTmIIeGAIC41WcFbCefbKVG/IwSthwmlSr8IlCEH41OPi2556r2K8x59YONQIkdpbKbAbRapcZHTLTu7VQsyhIKHOgWZNgWQdRxBvN5SbaBnuAkXqK2L4G0WSlaMk5/htuPXguChLOt7nC8hxRrdCbCJTjUFMi9ixIsYzJ9ChcSY3Lx8lvnOV1408nNhKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+PVnIpfl/eWyOmIFEMJ7rJLgECVqXFQT4MO169xwno=;
 b=KPQyCjfq2Gu8L9DSwHlO118D5EcpC7LobDtl5bpMtS27HAZD3nopAe9/0f66oju//8c3nKlpZ1Z0u+V9++8dekRbliNtYvx1vPZ4Q85NeKjE+AILKY++EMLIMHA22EnHo3jAdnRbDVfYdpch8B1K2fWDoUSL+GP1KfC8ntvPD5ciB56y8jqLZAIAvwYADr9xQWoRHBudpTn9yUuZQqutn/hwYBW2IZt4oR9QlQnysTN2kivLz10iVWMxStq/M6e5B2oi4aHN2r3kd7B+04YelrpMswMfDNacaxyM/mpPLGANjRizGdrGuRmLh48SdzmWY3Yv6OEAsv0LepJcCj6Hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+PVnIpfl/eWyOmIFEMJ7rJLgECVqXFQT4MO169xwno=;
 b=nPZQtDVJSdBOxbnCqv5uiYUxDlxbVqaAF8cNvG8B9wpm2t/CayDQMN/RLbqOcjARIG2iT7jlXKZs+UV79HUCztEFOLV48ETfE0i+3OkHppywLZvxgwqlfnZpMe9P3sEwHlSXa1kiJZd6u0YVjJjQU4UUAjjLncPS/xqB5F0yS84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8415.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:13:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:13:51 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.li@nxp.com,
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
Subject: [PATCH v4 15/15] PCI: imx6: Add iMX95 Endpoint (EP) function support
Date: Sun, 17 Dec 2023 00:12:10 -0500
Message-Id: <20231217051210.754832-16-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217051210.754832-1-Frank.Li@nxp.com>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 6157824a-03da-421c-e0c0-08dbfebef51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oTGW6ENgUAF8M0VNsEY8Z8rnDeW/vkg9v2R/SyXqVDziru+QvhgiVcLKcLgbvobv0DCYYxE3RCwbzeHNUUci135IEW9ppMrxG61im8Y+DOlCWPjAUfk/iaqO15O4xNN/Au2Q65l+w2rxGDjY/4YwIm4ZUrKMq3LwXWXRKwUWGpWApt1NstfdQyzOcCp5UcKHfJIQmmncm9R+8vP5dv1kAcmeTQ5jvC9YLQmdzf9WHdE4h/YQTEQKeRV58Rmh7r3WLg14kGxWUlBqHa1HzFw7xn1iazikPtKKHGlF3kO3innE8oA1fWtKpAYRqP26v6IUa/lNgupC3I+J+vCL8tXVSNbUEMv8ZZ+2x0usCsD0CeLD/ukEaAVEbyX/hgW1tUlEo92EZxCrxu9I3eraDiiAjmz/kCcAG48Ruof+Bp5R2CiBL3oXuDfexxozDTExs6rrgyfBs9b/YB8/Y6TJaKXIeTjbrkhNADowmQ9ijutsHtmeRCikqGuuzUgQ7L1JVy8CAZLUZLyyeWVTwH4jrWbMAq6MWJ55VSmRnPghGwyPU0bFf414316agDu/PKJXkC6tzKSgRuCpKERzosMZ3Ns0TZFuETUpqJEAuLladka2GcPvdorAiG/x5RwQ3pwXCx2B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(66556008)(66476007)(6916009)(6666004)(6512007)(6506007)(2906002)(8936002)(8676002)(4326008)(66946007)(316002)(5660300002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PmuLbqTbO/tLw5ild+I67jAo6lcTVw6Lj2EKbK5jT1bJtJXtIQ7blGHeMl9B?=
 =?us-ascii?Q?wCC1NabzeXQKieCCQ/TCCxzvSeL0o5ZOsTjtv2vWImE25IIU8IizOTdnJkFD?=
 =?us-ascii?Q?oQVBHvpuTIsqhwSX59H6g1A1/WekdPP8P1YIJSxgrOSPvKKSgC3X8EldBE/w?=
 =?us-ascii?Q?4+17OMnFVWQGXUdXSsJShhPnubWL1vEIqtgwg+IDEfrO+x8kG3Ln5v4pcAmB?=
 =?us-ascii?Q?b3KBIjCV1QBn4tlprgIlIM+IrGLD32nyZW2O1PEKtMGObGa0G4wONZk1jb3W?=
 =?us-ascii?Q?YylV8AY0nHwnQJnRbFuzSfQAu1jzcwpxOBAviFEy+0d/+XVVa0rW7i4IbVMv?=
 =?us-ascii?Q?Qprch/UYU8JRoTlnRC/e3+mNYuYYyX3Ahm2rPlQOmJJJZ7Bt4biwbCUrZuys?=
 =?us-ascii?Q?I5iLVWYUsdNiVrioWRFqhNnwsDmKBh4FCxuer/yEsCSE5uuZ06mNlBwBP3ss?=
 =?us-ascii?Q?vW89CWNRD39gP8BsHepy4jw7Y1RJUPeNhEPz6nuKr03JqvZtp4jwucJeOgVo?=
 =?us-ascii?Q?W8CSKV0yxZb0lJzKtNWGCSIBdem4aJB97i3l3k1OLed1V7ZXGqf46KjdlsAB?=
 =?us-ascii?Q?gD4Zae+y9q4E7VfeKRVoBxBH9fyyPqgKZP9yA5paY8zI117VajDqFh1diQdQ?=
 =?us-ascii?Q?Z3DxZbpZhOsW6Q6lNxHk8z5WUq0Kjxvj9IympIypC5HZBTxRHhs100qYOe7s?=
 =?us-ascii?Q?52OHHLumraNEPb/0/4O6DtXnJIbJplcKiDiTht9bHXLd/oki/LC3S3JzZAMz?=
 =?us-ascii?Q?EvwlASdxgsA0VDj+Ras3flJmA2QF+4e77jDDCwN7eJwWqbrGwfMKyfGc29up?=
 =?us-ascii?Q?tu6IPuADZgCd6v7EA1VoUpA0bW3T8ZXXtZg0MbibRl/VHTbWbne5L+0lXrJd?=
 =?us-ascii?Q?hpGPYopahFObeZY2pNaMzS16ri0uEtfuJAnsiIVz40Ve+SyAYEweTAZtuWY5?=
 =?us-ascii?Q?2o3WVw8GKTHJ/QaD7M5wcFoK1/dWWTyylJNUIZ5qY4EVI+sifvG2q4XWuV1I?=
 =?us-ascii?Q?kDR9MS9/hr5na+uGfcoBWJchCR96F046KI+4ZEAB3ZU1737A+VkLH3bcfwRQ?=
 =?us-ascii?Q?PXGSvqKN9KYi+Qwy8G4PbLVpxO5uHG1ngtM6ThnD1EXLdOKJEFMbbGtUKKOY?=
 =?us-ascii?Q?AdFLhOispBxWPGhm/Cu+RVe4GDnPXHw/IwsCCgQpq2PnFqx1+3+WeQHTbKFq?=
 =?us-ascii?Q?yKM5j7kf/qfuu6WuCFEuYAdjm4kO2VxJy9PfIzQlozrYCheakkm6gYbpg23O?=
 =?us-ascii?Q?ppzKzUjZj2VCR6urLCXYKD7L6k4Sr8EtiAVhl+kr7UGhKp8FxwL4x0Sp1bB4?=
 =?us-ascii?Q?WtVNZynaz25IYglL6NvC+wHmxRVf5KeffJIbLKTojOCsaSL7xPWGdrn4oSj/?=
 =?us-ascii?Q?iQWiqr9ReKdtZsLebPQGeihnOasJNt3bY36yTMHFL9ShOwDGlAYbpP2cjK0A?=
 =?us-ascii?Q?Eah61PIvshOrxfW9YQj6qM6aV5IpT/ZoFv33Wk9SBHOS8VVtkYDHdIDqCz2N?=
 =?us-ascii?Q?xTErmbboeDxCcjA4z9XW3GkY56cqPKVsRBkEEhTw2qUhz/17JM2Ejxyjont2?=
 =?us-ascii?Q?Q6h80J/jcWER0ysFJk4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6157824a-03da-421c-e0c0-08dbfebef51e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:13:51.4345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qX6K7oHs0JcuTweJhAKs5f1BVotjeRJObmZD2DEqE80dQk4hsbGUJtZPDth+AkWV3+JX49DRUQ1n1KDmgysnRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8415

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
index 8f7b1533e2869..5518c1b0d4fc1 100644
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
@@ -1352,6 +1380,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
+		.clk_names = {IMX6_CLKS_NO_PHYDRV, "pcie_aux"},
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


