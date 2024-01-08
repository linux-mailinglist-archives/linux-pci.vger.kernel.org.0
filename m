Return-Path: <linux-pci+bounces-1854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52781827B91
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC700B23456
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FCC5647B;
	Mon,  8 Jan 2024 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U/YYGQFL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE459148;
	Mon,  8 Jan 2024 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLXtFdx+M2btqOrMR67fDRHhGG2z5U6iLNDr3e71C1wEeq8TDi93zfipGPFMMDZcfXtJFyvn5qJMZ8O+XWakIgFsjE5I5/a1xJRoT3F1WqYNUoMDN05hRn5XWzk9UUNzLXaReW5MXu/eAOxTnVjtqmwgGKPLYSX3K0+yHTvvLD8OfERnHOqHLDoTIGUGuWwue3GV3x8sQQ03rzBFsJrMKjbGOJRQ1/H8zI3SS92qklwJHZ/edDi+dwSmdVSfuH1BNu0iG6Aa1w3pH+iJzIzSALk+XqPpyvnHTCmpIM9FOC8V3TYqpB6FK9bhnjgnHzSmpj7uT92cVlV6mKrf8Ndobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex0NRJz1s3XkmopQ66EFlSMsjJr6NnBSpyJnaz+J2ec=;
 b=l2afhn7K/Wg4Ug3dWAMsCyXVM6z0UCsIeRXOWL2wNGI+eoOJqIeWeMpop4o1BPsm3EfBn7cpiEv3F/fPiPPswnVm4rMK++zifUjEHqNk/WQ7Pze0U2rbHfkoFyultE8TBBEPzUWfA+t6BmWHf/GAShhsrrvUsoYetPqUbcKMCUwGqfDuzoAlMDbX75kZ2V2NzhzslXpg8smDiG6rfdyYP1Lz+RIGwti+Wl6QarmM4zrjR7yrovQ8WTIdbkl14pknY/w6zaILXwpZ/Y9oJAayyJjqnUOcMVhYC1mo2OkjD09cEUonD9JH5oZZWiD48n1FIaud6i5cn8vKHqqbLoANEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex0NRJz1s3XkmopQ66EFlSMsjJr6NnBSpyJnaz+J2ec=;
 b=U/YYGQFLfJczEPCzbS+uinm/VFkqR4lIxATV3GialI9NN+/c1h7YT67zl69fF60N3KoNpDVTOKyPJE3z1p7mdK542Us8dzM83nRRsaG4GoNxJEFWzhxwO6c7yQxucBDbCnSMY5iPjJYnbywvlI+D9IOJ+hOcLo1XoHD//f/HkLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:23:30 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:23:30 +0000
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
Subject: [PATCH v8 16/16] PCI: imx6: Add iMX95 Endpoint (EP) support
Date: Mon,  8 Jan 2024 18:21:45 -0500
Message-Id: <20240108232145.2116455-17-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108232145.2116455-1-Frank.Li@nxp.com>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bfa3e0-ae2e-480c-d7cb-08dc10a0d312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2CcwRfqxkBDtGiBVU/9cWsaW2HqdL1e1i3Rx4BivEheTeH02klpL3Bwrkv3gdTNt6P87J6fqv5JBFHwZOawSbpg9gpak2TVUf9/yYzXpA/WJxCzMHKLs/hHP8WkUHgfO/XVLr6o5ePznEyJgMYz5ZquHPKAFmUYJfEq758J2hLlndPZXsyuav6Gmcpm2+oRHvqmE2tblTScQE7HnzKvpAP6M/ruJs2Tkqxza4DJHholXKJI3ohcd302D7oQh+zHgWfbUMqYWvNERRqbgZmEzOPAfwVLXuJcxw0Bf9usJcixOUuevsFZNuryYIjD2vcxiioyGvC8nLfJjmkj49/dUU+sTRDuePH6cJ9XG+fvoXi63yorNnxgjQZF9NKJqvHdOXHm4/ITh1YR1zqy8NzJi6vKY2Cg0mj2JRvOCdooEaQQE+H3VUThy4930CKMQJeKIif/fwrDqFo/rGxsoBoZAfRSI+bhVC0E+EV4APppPWdQ6mvGvxtYhZ2prCysA3jG2RT9uBvLdheTeX3T5FoNR4TbhqFIIgypxFZwWtRN6CxmAYdPHuXjkowMJStnkXsHf5UpOcmVDFN+RS/QmpCIqS8aQJg2alXvIVgJOVUHRIDj2qBhlQ2HLf3tuh0bDsSf2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z4qUdLbxxC6M850aU7g/Kp2pR44GQr+R9JidUyBjPCa2T4GcS+8NNl7O2bdu?=
 =?us-ascii?Q?2++KN35ZmiIxjeme6B5hQUakLv4ltfsRRVIbrvJXSQHTKit+R/JAbo38OeOd?=
 =?us-ascii?Q?ZLe9M0aaLXwLIxmmNXy98LBNAkmmWQPZm2fdKv9rQJva8wAHPzYDVGfHj4lW?=
 =?us-ascii?Q?NOmXYCBcPyeNSUpqUVYQULx2W4wTeZUeDvy+89JBYbU9lddlt5PlFCuCvkU4?=
 =?us-ascii?Q?YJ/6OPfX4PRrfHBevD2Nb7GBcr/pObfEsRmdj8BfUvAXzXlpDVhUDJ0CcGgM?=
 =?us-ascii?Q?Rkzll4M5n42MkvpfeINJT43LycOD2WctH0e9DB29jeaiZT8XdBd6qVyNgeQq?=
 =?us-ascii?Q?4wOmhkI9J50kiypyGyqxW0DgjgeN1ormL+5mTShV+1ZN0wOYamJH7SaQRvU0?=
 =?us-ascii?Q?PmqyIr0iMvOB5f1daJZFDt/rGokukmUTywpeaiyaBAo/E4N9yqAunkzb2ipl?=
 =?us-ascii?Q?TNrUayPDKQ8tjHLW6ELWMUWtDQit9p33N/71DqEntACqN1zNKfTwnSEz0PnL?=
 =?us-ascii?Q?3KGbUjK4c9wxtaTswb0dCiTL21qLx8zC7+AjnlZ4CyUWN/tjPs38K4BB4+8y?=
 =?us-ascii?Q?4dfTsl6rdKe6OsOoeBL0TIISjznqzXI2Wl2Hzs8kqjn+WIDI1BpTeCaO92YX?=
 =?us-ascii?Q?B7F2k0hqHHUafQHJ/9jzQ9qUtX7RpEuYZAGQ94zTddaKwMM8edlbu1OiS4x8?=
 =?us-ascii?Q?Mj8IX6pa39McQjEmGulEnsVifWvbx1qQ8zvh+/9OkqrlzZ3WZmKfWDnJs+AN?=
 =?us-ascii?Q?O2PXRL/ZNVhHLfcpLJtA1maZVtfb/PVIdFGx6TJi9yNaQIIktuCJmrd/A5k0?=
 =?us-ascii?Q?Ny0wId7i4fE15pIEWlHIwOgnBH9ZhbrtDSDjjPl9GTD4WloHOYD04JGq1goU?=
 =?us-ascii?Q?hzKBSdkyrdCXXGKAWP/TMD6hsjRGxOwxJOcNynTV/oj9tsWVxJBmCzMgtN2i?=
 =?us-ascii?Q?pcOvEkCmyTdUf5iFZDfEGsyadx6b41wLQaQzmQxEOtRLaWrfF/Yz8NQlxjZI?=
 =?us-ascii?Q?2fns6NcIfqqNQHLV+UKYlhkcyF0Ds63CXwH/WeoxFEMATG47emijco9dKDKb?=
 =?us-ascii?Q?slH2DcTK3hS6sT4To8Edb9XxzGyCG2YR8GYwGF7KUCjgEpK65BZJtgygoFpg?=
 =?us-ascii?Q?OSYpstIDxUu1YInGAsai+AtwmemYltue7UPOANgwYmalOdRnAEAnr48+ynyo?=
 =?us-ascii?Q?L4WLnStlbZr3wh1WwzJFfaGdelc8heW22pRcK/u4IJsqYo7cVuu/KF//5ouI?=
 =?us-ascii?Q?+KChq13nbqHbwipS5jCbijaNCP0uL+LnXf/R+cQ8K+2ViZYuox4ke80At2Ri?=
 =?us-ascii?Q?xpAOqgdAGdhNf8Ma2nN9zjZOqZx8ZJbCpUxZI0XUeh2yvTvDzF82ZIvyTCDv?=
 =?us-ascii?Q?QmhUgw6jIJ8coX87o5oLT9TLuMq8iiowYmcUV13/txFWx2a3Xg0xtYPGA29t?=
 =?us-ascii?Q?nrv+fi3Q9SdNIOyUre1QIfL/DYSRqqDYcSa6HZCk6mnqn0wwR0wCk3szrSrW?=
 =?us-ascii?Q?Qoa44vKZCZ8aQPDSe99QKqsV1X+m8o/1LIdZ/AtatsJvbXTrMuYDhul2p+ab?=
 =?us-ascii?Q?bh1UnyxSwYzo1/+mZE3YTHrZHouz52sXjPKqPs8P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bfa3e0-ae2e-480c-d7cb-08dc10a0d312
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:23:30.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: domPJ/hD2jfiG2bOMNnYKFQXoda/XHnN+gkYFNi8lhC9JQR2eb/qKCE1EejU69vPRYRvjVuduiAjeJj7kneDDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

Add iMX95 EP support and add 64bit address support. Internal bus bridge for
PCI support 64bit dma address in iMX95. Hence, call
dma_set_mask_and_coherent() to set 64 bit DMA mask.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - Update commit message
    - Using Fixme
    - Update clks_cnts by ARRAY_SIZE
    
    Change from v4 to v7
    - none
    Change from v3 to v4
    - change align to 4k for imx95
    Change from v1 to v3
    - new patches at v3

 drivers/pci/controller/dwc/pci-imx6.c | 46 +++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3f474d4749dce..69ba72c3a9c9c 100644
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
 
@@ -616,6 +618,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX7D:
 	case IMX95:
+	case IMX95_EP:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -1050,6 +1053,23 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.align = SZ_64K,
 };
 
+/*
+ * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
+ * ================================================================================================
+ * BAR0	| Enable		| 64-bit		| 1 MB			| Programmable Size
+ * BAR1	| Disable		| 32-bit		| 64 KB			| Fixed Size
+ *	| (If BAR0 is 64-bit)	| (if BAR0 is 32-bit)	| (if BAR0 is 32-bit)	| As Bar0 is 64bit
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
@@ -1092,6 +1112,14 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 
 	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
 
+	/*
+	 * FIXME: dbi2 information should fetch from dtb file. dw_pcie_ep_init() can get dbi_base2
+	 * from "dbi2" if pci->dbi_base2 is NULL. All code related pcie_dbi2_offset should be
+	 * removed after all dts added "dbi2" reg.
+	 */
+	if (imx6_pcie->drvdata->variant == IMX95_EP)
+		pci->dbi_base2 = NULL;
+
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");
@@ -1345,6 +1373,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "unable to find iomuxc registers\n");
 	}
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
 	/* Grab PCIe PHY Tx Settings */
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
 				 &imx6_pcie->tx_deemph_gen1))
@@ -1567,6 +1598,20 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 	},
+	[IMX95_EP] = {
+		.variant = IMX95_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_SERDES |
+			 IMX6_PCIE_FLAG_SUPPORT_64BIT,
+		.clk_names = imx6_4clks_bus_pcie_phy_aux,
+		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_aux),
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
@@ -1581,6 +1626,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };
 
-- 
2.34.1


