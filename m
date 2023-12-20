Return-Path: <linux-pci+bounces-1248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 484DF81A850
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3831C222EA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E73849F8F;
	Wed, 20 Dec 2023 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k6mJvtje"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8244D116;
	Wed, 20 Dec 2023 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpmOAK4gEVZdJlkH/NytBT+xqreGVMAYVjhYRW0T6qtwQ+OTGVPpGosdovwQNxh8Wlgoa0McbOlN3aO/vAUs8+GT39aA/0Il4pegCJ2RO+FCW+S4kaihRfFFi4oAifIn0JwpplYVLSCUJJEnFu4xcA2na9Sv4T3xONJxr4+QdNi7PsrLhZh9zl2+Svv8Axtv/GlBMdQM80STl0PjBrE7Povw+g/7G5yCT2TefhhJDYa9mYlKtUsnz2Rio0YsjqkyasIIJJN7yOQaEUwElZcROoOSoyxt6NAlM4ip9ZXRytks0Hy0wSkek1IbyUrgSisGbtWyRXyvEKQM1ySsGYRRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8vo+UQ9KtGvOP++Or5qDRIkrFEKvxts5Qo6V24QQ9o=;
 b=ltSUDjDVlr/xQ+xqzB6A+nvDNLuvn4h1Pa3TxQBfRbatOic7po+biYE7cp8c9QsdR3nc3kPsOC0d8IAd8TPb1hnQxzoQca7x14qHhHw3UEUXvZa8k1M4iBsE747nupWxCB52PmvFCHZe/hZ0ujAbWbBwXZ9KXdvt0GiixBf+1x37ukZqXgPZjVcbD5cHnzsNawbnjYvXh/z+6NbsCObtN07AP2PMSZe7Pm4wXtUDD9zYCNCzoJXHs+t8URkPAIFhx1RU5rKl32kj2Q9c9QyylhkTQqy31yD5xSdB5dHel4dHvJVLYu5rSDCAqy/DRfuKJRJS4JR8VVY6dsTL3fczoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8vo+UQ9KtGvOP++Or5qDRIkrFEKvxts5Qo6V24QQ9o=;
 b=k6mJvtjeGR3h7OxDa2lVU83K6FnPjwE44jURTg2AspGqqDPUTr+/k9q8JtlBtOlsFaYfHWVSAy0F9hiTdtvedSwArqISkQC5tNNM2ggaaxbRYLiZ/N+KZG9h04GKZcu1pE32fQ7HdZLD7/aR1AxBsqgYGEzlt0PcAKNnQMApG64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8313.eurprd04.prod.outlook.com (2603:10a6:10:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:38:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:38:03 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
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
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v5 16/16] PCI: imx6: Add iMX95 Endpoint (EP) function support
Date: Wed, 20 Dec 2023 16:36:15 -0500
Message-Id: <20231220213615.1561528-17-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220213615.1561528-1-Frank.Li@nxp.com>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:510:4::25) To AM0PR04MB4834.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 2399c815-7062-4c10-3166-08dc01a3f23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YwNbq7zIDm4otmkU7kAl5Fgfl2wuqwi2EpWqbH0a7+j2RmFjbUKESChiQNooUlAl2jOEUtnwWvjQ3yQToDmAnGKKcCwQT/6C/luhQQXU3mT3rD3grw595UonhQMcZT5ZFXiu6qy+ENZSi14OlmhHtRtorxC8mXZZJXob5oSCW2ifeixSxQvxp0xzTOjrE3LOS+kMzXUC4UZLuJ1ZKiGX9sGrtnk+YVmKiLGSUe736Jv3jp5QYUznnGDiwxLlc0Dz/MyRqt1S0ZeS9yeMlezxPoJQIFQnVjcw7hprC7oAlXKwbTn0Y7/UPJmo/lvOV8wYtLtfIx201DqihVvpVcV1rkd9sYu+5P1LParoNEbXFsK83bklMtoeQWWhGFwAdwIwQ19sW1oPNqsvn8cVVMHC55Q5NCdbSy2CLHolHfgMMvBVGyG9v1I+0eZHT7LVIK1YKgOs7qEBfslDw7M/yW8toPGINKcrCdIPixxsMRxVTb4Zjqz7Ou1n7P2OyXKPZm0Yb8p78v1JXkQPkOzULsxGHbyiDkgcy/0jKIEpemMJ3XBj7nQlGyrligU1NiAxr13SA1+Opbt68T7VatCt34tDT4FmZTYr9vptWVPfg2FV8q94S5zT1yNn9Zn2sBeapIdQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(6512007)(6506007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2FYcTDBMUvy0pqP7hLVXH5m48wUFmfck6tXGAC3ibyDdMi/PR5DEzPhDIGzY?=
 =?us-ascii?Q?0HNZ7DKFG9socdhNBnzXCGA2ThAHlobPsq6friS+HNP+mdP4fG45sUug51ud?=
 =?us-ascii?Q?VwQIWhBmrXwbEN7aDDXpXmnzm9MMc7GU4YVELVwVLJ9h6r/DXmUtbCoNcWmo?=
 =?us-ascii?Q?Z34cpeIPGmvjhdxUp0mOUOKwFuaOUBN4VizhMX/aFTpaQDCeiZxC3Ni9s2ct?=
 =?us-ascii?Q?HWCHMZoiu6MM06OfHNnq60nvJxDapwf5DuvpsKdeFhydW14V67f0uM/fOv3b?=
 =?us-ascii?Q?ihvLqPc/hA32HBDuIZbC4yYfwsnlaM22NYmWLEdYSk7HDOXRLyNcwBuKxOtA?=
 =?us-ascii?Q?rcx3twv2laqUtO+HLYfHoJFzlxPE07RJj/AXmaNfEJXBT8DAqVdv80Wk99Rl?=
 =?us-ascii?Q?OeVx7Jgdr5IfE0t/X0JemNxgCYYVTvXWq9Xh1RmQ9CRZIznDQ7fuC7DLn0c4?=
 =?us-ascii?Q?lKfCEZ5+3RGJU8ekMzARRC1wSsYb9+ykXmPIOwkGuEd5MTZ2VTgMUfQIMy9h?=
 =?us-ascii?Q?0T3lxbWYLczmAHYKw1iaFc5hTgloWBNvXYkyuod7UE2IDC2lXBnAJ5Tab6LI?=
 =?us-ascii?Q?sKluCk0kuUozw1NqkmZXVBofxnqkeZYGcYU8J7n2VEUpMncU6CwtcJmgG8+5?=
 =?us-ascii?Q?LClQDYDNiDh5Bwa+7mYg2fYrVpHBowTT9/sJ0HF8VDvdx7fH9vCwhNaxLj8I?=
 =?us-ascii?Q?0htdWFIpZP/6qeg40vZiV/b91csYsKN0mkOXUMEjy8SRysUdt4QfXJF/pVak?=
 =?us-ascii?Q?+u5Uaf20WznYImiOKB1yXf8SsiyLmB9Fw8Whdc7gNhxESJe/EJyt0wL/HF9m?=
 =?us-ascii?Q?237nPhPDoTySkvSa2GJ7FvpEVKpUxFkIT1mwDgYh6hcc8u+FAZSJmhqWSdoV?=
 =?us-ascii?Q?LSpS2gjStX9CCvev9z/v7N4uNUyLbyjb4b8SKoph2v4QmJcRrrWMaFbAQL/N?=
 =?us-ascii?Q?CzmCVwfaAEL2sug7Q2nFj+JSDjewyq+KkTArZaLJvsqK8crKjrudkXSSzqtR?=
 =?us-ascii?Q?zz3rwa/jWVjhse0IhsZgqcjYjo2NhA7b+q08XEvQiu6U9CztXro5K0kD1u2o?=
 =?us-ascii?Q?PRHqSBGLh4+L/0BeO5KWWkx6M1/MABSvatwnq3Zrgepf7PmfW4aX8KyHKP/g?=
 =?us-ascii?Q?lxj/K5qFP/i+XxOa8AO9/Uzv03vhM1PVzVy2ZfHXO0KXp9di5wHjzWZaKSi8?=
 =?us-ascii?Q?9NEEnvVFZAyUhgVB0C6bK42ZjKUy8xyarnfxK5PfbmQ/2iaRaZko8llJ0f60?=
 =?us-ascii?Q?7cEbj9ApE3YFgQJMPmo1gMHWkiV0qIViC+E/YuA2Q2Czsp5LzLX+Bktw69wp?=
 =?us-ascii?Q?5alDooNjtJ2UVDS/ABhgw3DTRyMbzbhjwEZ4ruiAxl8U1dPXXlHGN4DYrjBH?=
 =?us-ascii?Q?bSvaxsYZlSyzH4THLlu7rzBQOeJMI1LTwaqaEbt/YpOs15dqFRgVVG+urYNp?=
 =?us-ascii?Q?BNYdfSI9cr17TBttkfksbORCCap9U+f3nsMEiudvrlWCQban5IOXDO+7wYql?=
 =?us-ascii?Q?hzZVlcZojglamNwkKa5dlioXDGY1ehoiEH6XKNVQ9wRg8MwUBm3BWrZFlCsm?=
 =?us-ascii?Q?A5/EQjka7KyO04uaJhY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2399c815-7062-4c10-3166-08dc01a3f23e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:38:03.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFfTxle0vJun0/cpaFdnBowXQjXAm859O/8mRQjBF6sfgGCJwLlJGML/kSmZ7Dfn316Q65Bhjb+VUoehLF6ykA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8313

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


