Return-Path: <linux-pci+bounces-771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E8080DDC5
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 23:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF801C214D6
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F95576D;
	Mon, 11 Dec 2023 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uyx+Pydm"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E187FAF;
	Mon, 11 Dec 2023 14:00:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL7iaDeH1wh6bHmdHVnXBkUjzywulcFHPt/eob+glaVirvagRzV6Kz95kYu/ama0ykfL41fNadoY1Qgqx1KBrRHtUwyuZtACCfsFwDsyJeXPLzilP9ROj365j+WROi3XdBsNFM6rZ/zH2E59Mktzjia7jgaSrP2+7Z3UKwogstaqk2GVk6Ski9To/hqD6MbchiuUmQb0hnoDtaaBLRVicyXv8X75EfHNgeSEXY+hH4WW6+Di57T2fdnIiqmBgV/MDR08FDOQX7fnErCNojsNko+TF/peFnueDa9lGGPGYOEBNmx5juNoIHNnCmviaql5ZvrWm1tPQg6R9zVVg1LB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDsMDJjPLgKGyfutpDbYr5Dtxeplfku8pilICDnyv5c=;
 b=ivLjLa48IDgfNXXkzBnAtIB474bgHjauEAQEHjj3xe9Ugzy4MGkAZNK8wQj8YGBj9YKLr5YZ5oVdFfepL8wF35ychvoOwuFROvmke9OV2H7QIKfhcPE+oLIW/NoAUjpM5PbTF+nKMku39P6UDCKh6SVzLC9NIH3bSFfUwj1obapYO5q6vLlslG9+aNPoXaU+51zYJbVFcWkmuM1q6bg3f2s+NUxV+CeA58TinmMfh/Yu4545GOIb2GHsRR6jjwRS1sut4r2pmGY5lwaLKa8RC6l6s87cQ5mAowkPK5Gu70OTTYd+JyqK4HTDJQy5EZBH3O2v3NF2IORbehslDqkx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDsMDJjPLgKGyfutpDbYr5Dtxeplfku8pilICDnyv5c=;
 b=Uyx+PydmLk3omO6PZ3PQ5Y1jgxxvV8TM18u2dcUNhA1/sFngNJFtIeK+VZFleoFHnIRnFyqxkWBeEP9sItLHQ9zCsULtQdtl/9AgbIUDDQKgRkKxQKO3EHPKkBd9ufS+wMjeZjiaC6kf9FZ+gBNY1LjzZyEwGl0sAom7ub1BBRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by PAWPR04MB9717.eurprd04.prod.outlook.com (2603:10a6:102:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Mon, 11 Dec
 2023 22:00:30 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 22:00:30 +0000
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
Subject: [PATCH v3 13/13] PCI: imx6: Add iMX95 Endpoint (EP) function support
Date: Mon, 11 Dec 2023 16:58:42 -0500
Message-Id: <20231211215842.134823-14-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|PAWPR04MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3dea97-6807-4ed4-5e18-08dbfa94972c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dp+P0XzFMITKLIJ7Wf/KsBJH9cC0JHUMZkBf/RkIdQ56zyYlyPpTnyvg3UEYq2JyuPwGqio307DArGQOOz8lxMI58cxtdlgyHSGiziTAXjtPaW1Qqys4xNb8Gy1IXUICvBo7fB6YuORHpXnb7YeWDASwd+gC6k1DnM+dVBubCCp7LL/pcDQsZGhbCkDINJopXbKu8iQ6BdSmV0HMe6zvmR+OlGG3vzKUY2zSJMnNO04gr/Lg9rHMhvBDIG64zNOqA/Ea8vMsBhAK4QaVxsdFr8+qWW98eX+s30rX4nD9Kxv5U+YCt6OPpKkADUKJmroa0rPvIdU66jpYimFrD/ZyH4q7sM0/kqD/DS6k6i/eEzoMRFSJzvr1ljUQmPU4YUkaYQSqLxhLCB2S5QP9k0CrIFglBMykiDkk/FHjLQ5dLTuU7nu46xFCrbahiP0qHm67sk3bZWiPukmHbK51l7w42G72U/J3l68V8sdf098UAo/EJWB56xhSD/5KjDVmRsmS7ACaMKz9QnDwsiXkzYl68Z0+NRRmXJejsdDR1bQqDlLdG0796qlE4QjISTgAPF99QGWNtqh8fwyM0R2eAWYvuh6BgzDQGSI+On4V+06ifcb32GauViccMffxAEgWx58D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(478600001)(6512007)(1076003)(2616005)(6506007)(52116002)(6666004)(26005)(38350700005)(38100700002)(86362001)(36756003)(5660300002)(66556008)(66946007)(7416002)(41300700001)(2906002)(6486002)(66476007)(8936002)(8676002)(316002)(4326008)(34206002)(37006003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?syv46mRJQ3XpRPPB5UZ1EOtzmxa2pWkcz6EWveqDWQ/Zubne2ODMxjPIqtmr?=
 =?us-ascii?Q?uKeAvaALR4n04GFWKcKIrm0/NJcoe42p8mdsHPQ7RnMX2Sm1rdpuxMNr2Pto?=
 =?us-ascii?Q?R26Hto4FLxLjLou3sj6WzLUkcR/biDJeNZ5a4lP5N5hWKukn9RhhFhDKag2g?=
 =?us-ascii?Q?liOotzJxwVjBHonpVCGSYyYDtXwQDXf8dOdjx8O3EmnUQSpzPT98oI4ft2Is?=
 =?us-ascii?Q?ZQ7ouCL+nhDkLUkDijR3oMX6Q74Ag54IwQ0T6qQ9f9mSJzeEGA8q/ZcxKMnc?=
 =?us-ascii?Q?m8cia8jaiTKK9lqnHlxWyIrhmRzJ5pxo1nlsUVWaOlBwoTshzWZ1S39Fyw3m?=
 =?us-ascii?Q?k2MPlATe9OulycfPI4XwTcHhUNDaqRziqp3iqUAJPRD/1iQtCr1ayjYevaVL?=
 =?us-ascii?Q?7ips1Uqr5WHkaK8fQDoILe0A0aqildnknOew19C6HTEH4tyBU6h505t3D1dQ?=
 =?us-ascii?Q?Z7+Di2O3/96PJevJBSuzpHLRk/yGuE+oU2YpYaUkrFgsCO8bnd78pr+aX7SV?=
 =?us-ascii?Q?6Ubt0xQBLbPDfReqYeYTpPt9No3bcbpYSOMrxcn6k8TRYGXCaVpR6qITkfid?=
 =?us-ascii?Q?N2RtSfTL/ozYYP3SL1n25h6orzcmK+Z6jPjSkI+9dcob7VdmztWgdTLXnDvM?=
 =?us-ascii?Q?njh7Cotmoocn9llj0TDU247Tccnf5YGpAmSfO1TpuowRtEHXT3ivkQyjTTee?=
 =?us-ascii?Q?yv1NQdxZ6OhrbWzyJiXrOO3tuwb1yyfD6L8wq7jgIyj2qR6hW7qvBBlJn7Oo?=
 =?us-ascii?Q?09FqVkmTRLQqWOf6IDMadK5yE4pvm+zlwL+li0TZirQ7FUG8oxUjKGPDTZX1?=
 =?us-ascii?Q?wry6BDM4GGu5KrzstbKoeVPHOKWhoUwplfFTLFudJ4VQI0gCq5QrPapPtWPm?=
 =?us-ascii?Q?5l7dnMcIXecADdn9kKs8JliPDh9ylUCsS5AForv4wa+xwbdae1Iv1ElpLFKd?=
 =?us-ascii?Q?vsVUq0gq2Q0887vKe3f0OHwwL0nGgSPHTUNwbkQqCH4QyVYJRTPlc7y2IyH0?=
 =?us-ascii?Q?lvartHSFIKtXAjQgLVTxFbBU6lVNPsebIKDyKrXwBYJJ+HlhZCC8W9+0B8hx?=
 =?us-ascii?Q?pO2N00YtF61mjm8ciyLVRzlVN4x+cZW21e27xkbMkCVoNLP8Po7I0E5XjhY+?=
 =?us-ascii?Q?Y+EdWWUswrYTQqWxhv2WNzgoOJYbO5/aclf1hIGv5wwTiCjrsgqbx3R64iol?=
 =?us-ascii?Q?HGIrzYaEURUkXb+Cmp0P4uMHh9oEm9s+P+QCqP6BoZjgbSGg82I33ePgnOkx?=
 =?us-ascii?Q?HSd0iMA3uUqJHPOOqQLpz1uLjyzXyY1GWKYGv9LUsk3/WrsmKfKbT8yj2aDZ?=
 =?us-ascii?Q?+CNnpVYeWAbjM3ydRDlFZm2P/l0fMoHUldU/ue8rNQktT8XKlVnlf2IaWO6L?=
 =?us-ascii?Q?JzJ2Wz4QzHtHgFSK12Pu2MDUKsF/a7FH+7A+s7O0q0FNNFKVhYCKbhMVkAdq?=
 =?us-ascii?Q?HdXgiHG66bZMyX3wAyutNBLaH5gwKuyw0VZWirJ5fT9ZCyM4IlVxsq0DdSKy?=
 =?us-ascii?Q?E7dwfPO6cN5q6HsXEEpwOzVw5lBHTadZJknVWDdYcnvV+Hxxn5AntxoyIMjy?=
 =?us-ascii?Q?KhiNN9dR9dBrRkSY28xekuwk+asIbjbDntgbglqL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3dea97-6807-4ed4-5e18-08dbfa94972c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 22:00:30.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrTVNfV54qIgVmQxTDg1xJayqvSp3dKE8ij1TA1sdFXF/BM+fZqh+em7Hp4mqxchKGdrkX6otuoYpc15VnvD8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9717

Add iMX95 EP function support and add 64bit address support. Internal bus
bridge for PCI support 64bit dma address in iMX95. So set call
dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - new patches at v3

 drivers/pci/controller/dwc/pci-imx6.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8fe66d3e947a6..31df682432e24 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -76,6 +76,7 @@ enum imx6_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX95_EP,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -87,6 +88,7 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(6)
 #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(7)
 #define IMX6_PCIE_FLAG_HAS_SERDES		BIT(8)
+#define IMX6_PCIE_FLAG_SUPPORT_64BIT		BIT(9)
 
 #define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -630,6 +632,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX7D:
 	case IMX95:
+	case IMX95_EP:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -1099,6 +1102,23 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
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
+	.msi_capable = false,
+	.bar_fixed_size[1] = SZ_64K,
+	.align = SZ_64K,
+};
+
 static const struct pci_epc_features*
 imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
@@ -1141,6 +1161,14 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 
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
@@ -1417,6 +1445,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "unable to find iomuxc registers\n");
 	}
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
 	/* Grab PCIe PHY Tx Settings */
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
 				 &imx6_pcie->tx_deemph_gen1))
@@ -1614,6 +1645,18 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 	},
+	[IMX95_EP] = {
+		.variant = IMX95_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX | IMX6_PCIE_FLAG_HAS_SERDES |
+			 IMX6_PCIE_FLAG_SUPPORT_64BIT,
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
@@ -1628,6 +1671,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };
 
-- 
2.34.1


