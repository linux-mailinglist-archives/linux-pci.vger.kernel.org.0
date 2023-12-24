Return-Path: <linux-pci+bounces-1357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1102581DBFA
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B471C213CF
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E1D507;
	Sun, 24 Dec 2023 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fMXAw/AW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0131A19455;
	Sun, 24 Dec 2023 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5vWTRlEd9Qfzj1WH7h6eZ/eqaieK2GjhVgcZ04llBZ43aLb3lplmxKZ7lPuBkauIBVTZKbI5yyMkgoCTwpj4wpiSQP1p6rX+uiIyHBoRSLxAFzZKn7VE2UV1Wqxy3DOh/VaFdAIOp7lZADd7FtdkmcZizQq1EUrhXc2pu4u7z1lVVHimWqRxrYdUqfAIrpr0asGvJcrm6Jqgrbrdm98+sEyx/i70ghsDromX/2kU2wXtrFpXrmSBE78B3B61nA08VOA5+qV7UJMgwljjfRe0mF1OPDcUGbHzV1BKQ8SIwNcHhUB9cGYi1vcUW0Kt2ZCzXKF/5xOBVdlKU4XQxsWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8vo+UQ9KtGvOP++Or5qDRIkrFEKvxts5Qo6V24QQ9o=;
 b=TQ+KFXKNH0lX+/zOhAUD1YXfoU6PVsaLeIkIUb+qKKG0mC4EVywtrRFIAdSvlhI3bwivfMy3E5Lz3Ciz9h4xMLWPTHbqwtr/xnPmwx+qBsm7sjHY0t+XKxUwbH/kvCwebNEVYEWjPixw0eYz86aVgzDv1H00aVodDTUdVm8wNkngtrOykMB/stLrOeYc6pBlXXIUN4VXuacbXhic1ubgs5p/cO9XCO0uLMDXtqxt1VpeOGff28gs94f4sjwzO3NkFBjrVpl9PaGf9Kfbq8il2W1tZ5Zb1qQCyHAPgAHcQeu2+jqdMz5clFrLwfXYFaCxaEDGgASIo4vvXThyJ0YJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8vo+UQ9KtGvOP++Or5qDRIkrFEKvxts5Qo6V24QQ9o=;
 b=fMXAw/AWQXq++Uce/TRRfjqrYfvj4XC6QTNQMTWugLxVzWcKzn11r770a6R0pUoQA4tyWd6eHmBND8gzLe/z5choBW/CdtaLgIsBWL65Vxr9hFHJicDAib5HHjWI4SxOhuCQ90a39C3o5AE26iSX7IKKeR6DveKj28LxLpZmbAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:34:27 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:34:27 +0000
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
Subject: [PATCH v6 16/16] PCI: imx6: Add iMX95 Endpoint (EP) function support
Date: Sun, 24 Dec 2023 13:32:42 -0500
Message-Id: <20231224183242.1675372-17-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224183242.1675372-1-Frank.Li@nxp.com>
References: <20231224183242.1675372-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4eeb5f-4453-4424-c400-08dc04aef5be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WoRnJtGYAWZ4hBQ4pteBgytphDi4j3YROP58YwZW1gzE2tcAktjevdHswshpLW8PHm67zFuZ4Bmopfaol2dUEj07jqPSco7WDVo85zwblZyhW1xFGsugCny2D3aESOU8wgZMGF1ThOXJlX1xxefpIwvzXkinTreuCaYSms8SukxDOzFazyOegZv1ZPLunrBrayjF7RtsPUpQb+egLl1tJLY4Zg7/nuH3xxI9IhDFnbU5AsA/2gWC3vKro1Flt5yX5PAQjKKUB0SBQs7O4boAXJE/Vl0OIhRtm+vPm9Vm3e0TsZ16GWCm2n1rc6VFp71IJHBUzlqBTd//zEeLS9FixvY07aXkd0d+6aVUtiXBa0XSuADCeT6FzRsRrn3ykkqM4LdqpcFy7c4m+ekMEvUuk4FW6Pu+sKGMe2m922rR4fLVYlyck+JDv+qis5SZRc8GtAKLeodN4mGsh0xmXBDHqTPtki0d+OyJcznuSZ64F+FET+vo0QJweBLTQZDviusz0UvPhttnEnPe7/IU+XGaXu/hCuGjQof1C/Ps9C2W6GIMG5FDOQ4gBR9lagyb3jp087/mCVQZ6K8kxPAy3DuFslg6vKz9RRhKmrXc/0yYWc+Aq4ddMbdE7R2S9ZhO7oCe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4h3S7iykv+eelqByzXHz5B4XL6ExPmnhpL6/h1uwXLY9CMYnFcjtxrSL0onL?=
 =?us-ascii?Q?6j4hNCLpyVGYjQTc3zL1GyHK0aVOOwd1QozIxLZO8cFgAqsnrPA9zqU2TS2b?=
 =?us-ascii?Q?ck/iAPvj4G/4OYzsgfPKqf9IVq4bRxoZLXhpDp5CxYwVcoSh7Hj0DmKodJxZ?=
 =?us-ascii?Q?YTE6bnaxnsnez6Le22niMRwdXdAJMbpUMmmVDyy719Y2+kTy3jSGGOWm6+FA?=
 =?us-ascii?Q?arLQHLKt70rh0vhsySWZB8H5wdVHSPZ78/znl+qifj84RPPMqgOctVsomLvy?=
 =?us-ascii?Q?Xd5dR3IxQIr9ofHn4SQ4kWmZfgPt3wOvDoqiCifXYR4LG7mgF5w0LaReUGdu?=
 =?us-ascii?Q?iceeRWKykDFgtZbUIC87dUzWzqz5f5Gp5eEZlgYVDgbtYOxmnWYfqk4zer+k?=
 =?us-ascii?Q?LOQypm+2QMhCo1sGP0a+FYvOU0Y1y8deTB8r6KJEsnDiCp5ujBR4kLJHbx55?=
 =?us-ascii?Q?T7jYcWYG5vAkOc6xtAIAQRBxeH9NC5WC+rBIr9ReiXEliov6OqE/lYNn9WOP?=
 =?us-ascii?Q?Zbr9sx/+BUSEkYyC5D2BCyCm3sbWBEi9qMg32fPCBVAIgFZPi//8pjq/An0E?=
 =?us-ascii?Q?wpvep2iJHvmujxGiJjs3SNHhMRzml9NnxDMMLp3rPy9jWFHwyv540Xl2flY0?=
 =?us-ascii?Q?TrHKPXn42hivHbkuMVd+TaaCyF0WLnqYvQgzMZ+BuzqOhPJisY2F3el8dpU9?=
 =?us-ascii?Q?p1KEv6g1NLQ5C2PxwIwSI5oxYRhIG85uyld/LtWf9YPPvZZ5gQLt7CUTxEcd?=
 =?us-ascii?Q?A/CEjQwTFsC5mGjshZUP2Vc02DXiG2iYr13nuHDXBjFOuzPAMe9MXAzqJ/u1?=
 =?us-ascii?Q?0Jzt4oWNBdLPd5cTtz/S7iDiC3RdIyhPmZEQ7hkBAhH//cERnU/WsgKbsnB4?=
 =?us-ascii?Q?lH/jItWEi6aawas9ux343bH7EuSQtirYs0HeD86jA7orRlx2xaURDwaaZQwh?=
 =?us-ascii?Q?viy88PG3RcCuK6hqIKLkaguysVTaFg1vHEtEKfNGQvuVBpwL2V5Agf3DEoja?=
 =?us-ascii?Q?QIxrQkUqhp+lf/SX9ehCkxytkDWQ7gsSj1YRpOJz88nbutI3XJFVM2sXLsB+?=
 =?us-ascii?Q?P1E5vDFWpHD8LMpSTfMp1IQekcDibuDZPEo3FgCEY7clEDMe9uxPFFcRt0ol?=
 =?us-ascii?Q?7FjTnkwk4NEaLYC9jP/lALBo/2Q1cJZB/al18jknEwyiBi+sEvxyy6ZvagL6?=
 =?us-ascii?Q?xNPWHSdcg1EOPUPDa6dmQUkjBBVr2czADEvzg/TYPt8kBa3ISzktp9jjM++r?=
 =?us-ascii?Q?RJxqU3WCZeXZbT0aDUwM3hrhNIng5aDyvdrB0BEIixMw+0ouJhyQAHI7HRfH?=
 =?us-ascii?Q?WCb9WRs69d5C7VSdbl0eloOaz8P2J4wCl7pg8cdv/eWTC+UnGNWz+5X2w2F4?=
 =?us-ascii?Q?FSU9hw9EiM0WUrKY9Z8ThiySumXcRQd5i8OhA5nu4CB0Ae6ige96qHQu9HsY?=
 =?us-ascii?Q?6YfFzHorxQcBv5zA0ztlFpj578NlRRfl+nQ7y8KKj7cKge7y5ivLb9Xo2HGs?=
 =?us-ascii?Q?CJxiCZDsT7NIXdRtRPs2qYO403tnJaMZeU6TOG3kATBgNcq/0CnwycyY7gmQ?=
 =?us-ascii?Q?yzQ7divTYJBNgpBmdJM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4eeb5f-4453-4424-c400-08dc04aef5be
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:34:27.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QkVbHuHej0zRXxns8n9BRiyUHPEu7WRq+0wElsdAZ9uOyAcUq+z89odmAEqV0lCtYHZc8RaUlxvjPSYXzcWww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

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


