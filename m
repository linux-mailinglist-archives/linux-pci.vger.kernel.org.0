Return-Path: <linux-pci+bounces-1453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD92081F136
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521271F2116C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827EC4776F;
	Wed, 27 Dec 2023 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GPLuXs/p"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83647A4E;
	Wed, 27 Dec 2023 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuOmKwuU7jQ0kQ3Ynu6Lw0IzyOCgL7j8MOmfuIA9oNYQrP9RNGwjAobVlRUGjIKi9zZR0yBpfW2vk6AV85fxHXeSPz5F642RWbPr1DlzP9jEcOefFx2nnyqpFNlVGZQSWeeIG+GCUzAszOq532fhDE3SyOEX+LjZtLaFKIViQ7fXgnN9o4K/9Tc+/8YAngN9tjTDh5JAlRAdCDLCMPDdx1Zbhy3LnYqOkNGLuMuz9EQgkiZ6s3YWuA8XRjUABcD00pFeamko5iH9kVYFDf8FmWkvEwi2ATKfr4ezSTOJYso6IGUxWJDt3dSOLngDCaC/A1/TEZC8nywb17FO89zFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LAXOsM+n+ieruYA80YmPJNWaLohdzjp04MJ2htd6vM=;
 b=X4KkaZLQuQiwrU5lb/57ZGEergFzle9h7/Ft6/ys3tSg331+obLljd7Bik4XOICFifo9svqgGJSKsv2mmApK9bKKMoPR4//aPXgyczEDgZxL9exjxvnJmyLa+RrWoXDUyYmrftCTvlpphIwoq+rbaXxO2W1D2lWn+myy7cmvzz7SixoaCQSm4DOcilCCTdYfa7YzEXgFm0hszSqUNf2bAuhMoXqmOf6DRywtRb8neyKWSzbhdCoW9oeysIBZvFwQkLxeKOTJ5OWMsaHLD1ESAXc+FlJ8NzqPADTRgGvMmNvfqpXlOftYDQDIsQOkKTUwvw43Z4/zfKtWGZm63FdKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LAXOsM+n+ieruYA80YmPJNWaLohdzjp04MJ2htd6vM=;
 b=GPLuXs/ppBoIrTy14dlWJCVKrPWZWgKtB5KFhf34K/bhpLxw1piZ1K1IY9zPoUgjPIjx2S893IAy8XAqMMI92vq8itxei7VADqCxAkhXR5ShXbt1HNa1GfNfJr0C0J0g5d6gaQ63dVTtuIMitwDR5GtpISTRZlBEWx8uYK4I5uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:27:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:27:54 +0000
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
Subject: [PATCH v7 01/16] PCI: imx6: Simplify clock handling by using bulk_clk_*() function
Date: Wed, 27 Dec 2023 13:27:12 -0500
Message-Id: <20231227182727.1747435-2-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: ca149d39-283f-4b11-3868-08dc07098ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8IrBct6uyGR4g04ZZpbPNAquLOXP3avVbwZxRMmuZOkhzn2Tq0XP2m2mXlCHyMSXcVgRXGp4elLbr4h0SE+Wfm/HTIkteuP8AeVNhPA1Gy3oY42wPrqctlg6IyIGGJO1UQRxayAbO9s24g6in1gU0knALwa3ID1gMD1w/7SPdBY6EvtpqT51MQvSoHsqjzMvHxTMp+YMrgO7WofdW/BKI/dQKrdfBHnamOY/Od1g9jN3vuXudAVpIe4exYN5tIoGPdao1ZsiUEyJ6uE374Hlzhqc/3FAZyJ7EAqF3usZV2k6Pc6NHVkdi/cz9nO9f3bAMqpNBMs2IEu/B67v23bbkqwo7tTxRz3tRy8UAh2sO2z4yMyilE2yI6uZwlQ3VvtmKJC10VKZbqAB+4aFKzuNXidHii2jtQAza0f1ocBRuQA63AuIwp2rr1EHS9YKRFszrLDu+gamMMoHWw6FdCM666A9cbHWHP+8ver/rC4sQL5Vf/47CdCukbCiOIJ2cEGcgpFHTitjVtKBY9JWD5soYMVja78721YENws9qcDEOmbhkcZPBJhEbLRyfaZesQQIIUbvn3r8Pcvd2Q0GwGU1vBrs56xrFc9/1EmB71UxRudbqiQmVbMVGNWW2FUbVIZM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/X89HBIY44INsZco7sK8ltLxC2iSOhex2EtIjPEl+CXFj0Qdwszqi4lnxwC+?=
 =?us-ascii?Q?sZlx7ojAoHBysbkxw6sIrrt88n7uvlV5qCxY7mvGCKj8zF55lJpbosWvCV9/?=
 =?us-ascii?Q?UgbYU7qP4Z1NAtSsgjf8pPy0aVupQNFwovsBpgp/DKtdFLnDnSNSVMgyONn4?=
 =?us-ascii?Q?uzaNUxzCuu1Ona5LQdhnq+O5WkYuYPoaodkJA7GbjCH7PC1AuWmYLVSz+8bs?=
 =?us-ascii?Q?dtr76xK1/Qds4++1W0d9SyVmbm/A0HlNYJPRqOUuigsiqFcejrfxb3cPpF+3?=
 =?us-ascii?Q?l01ChqNTUApbSRvo32wQ529tNDV6+WCZyLZ4pHSO+85HSWkeUGxaInNwUOzX?=
 =?us-ascii?Q?942RrRJ0cK2NFYimX6mM/126H/XDyn1HfC67Oytc0SHgjR8jpmahafnZxt3V?=
 =?us-ascii?Q?087DhCmo+B/beOtFiF+Qw8zVj/TqIAzq+UH77h6eZ0LDwdB09OxPdf2QAYnJ?=
 =?us-ascii?Q?VaLqUPA7GL7Johzqk8CVWOKsZyQ7V9t7bXHrXgzQfK5dDtxBGhyTmmLG0oPX?=
 =?us-ascii?Q?eAISokrvtNcOc2q0l0LdBcY8474naBYnkYmQUKZD0emPN96l9PwU5NDCKCKp?=
 =?us-ascii?Q?bbjs5Sfo2yIPcLEnzixcZpjifkReapjTAKWBXqWQEWRRSG50XeHi4xTAcXkz?=
 =?us-ascii?Q?BGyQ/EDVyNEjP8iekINbbxVSxrj9q5jaWjhOEXS02J5aPLabrrfaN0zuwX0i?=
 =?us-ascii?Q?xnHrHKIUSevioD9hIV7VTM0yJQE8dTa9wj9OosZYBR453RQIyAXylcy9Q82E?=
 =?us-ascii?Q?weIQ/c7DngTXSmexTHKCkjzKOD1fM6lxUZ9XoLfT7+p3tk3SxaoO78YegB7i?=
 =?us-ascii?Q?+Bg73x/tiaOZZ56aXDTeHdyVKjkh6+nzFrqoeNMRtY/gzxelzrO5Is1ZZaet?=
 =?us-ascii?Q?K75oh2v+YPOXsXRDrkiY/qcap5+Ehb8rVS26bTyIrbEXgCatIvW/G9Fq4TP2?=
 =?us-ascii?Q?irIdabBtjCiqfHQk/i6KT4HphLSS+v0OmPunrlqI2LBX4+tv+603RLHV+ueb?=
 =?us-ascii?Q?6yq6STuhxyaSoOaWMq7nVMBVW25ok3oS2eXRTpy0bWmzxP91CY+0WvRkgCFU?=
 =?us-ascii?Q?9bRenSBrjgBVvmemw+zO7bWKh1aQvZd92S1+dHblefcLbuzmRZvB9ZlI1dLT?=
 =?us-ascii?Q?EDzGU4drbV3pNVr/SMX52huv7981ekgUU8lT1ZajhbghPYBmH6OveLSjgRDJ?=
 =?us-ascii?Q?Dzo4tBNy6bELukrPCGP+fcVk/aXJNb7MpITvCz386YxoiBDQe71iYyt28p51?=
 =?us-ascii?Q?/DWBwJ+aHiEVA/e6vZcqW9XRirb/GGgrNk+oETRzKBzGtVrW43SW8V58UwKc?=
 =?us-ascii?Q?uIiYBsAV7bWI5J0eLHnBd4U9AXg1X56u5KBRyf2TMR/T3n8td2uZUu42Gekj?=
 =?us-ascii?Q?dmbOWLdXG/Hf/+KP+9O+ABsVZYSTs/JWrneW/nLPA6OJXmOmLSQ28WdBiipI?=
 =?us-ascii?Q?QmNIHegjHWX7FwJ9BciLbLZf3MASY+3IGJkzMo/RR2+DiXjXWimCxpPp18P0?=
 =?us-ascii?Q?XhK5KBbLPCmm3ZZxJDIWt3PnXPZ5kKNAChwYc4MMCpzBfwEikSXCzfhZty0L?=
 =?us-ascii?Q?fVxr+m2e/6j1ew8KA+s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca149d39-283f-4b11-3868-08dc07098ad4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:27:54.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnydRHcGo+LBgVDn6q4ln91Dr8PZReiutZvWJUWGoKcBsWfcKkPOvZ9JcDV3Q46nzax+Kap7ebecFrNgsAAwjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

Refactors the clock handling logic. Adds clk_names[] define in drvdata.
Using clk_bulk*() api simplifies the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5
    - update commit message
    - direct using clk name list, instead of macro
    - still keep caculate clk list count because sizeof return pre allocated
    array size.
    
    Change from v3 to v4
    - using clk_bulk_*() API
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 125 ++++++++------------------
 1 file changed, 35 insertions(+), 90 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74703362aeec7..50d9faaa17f71 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -61,12 +61,15 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 
+#define IMX6_PCIE_MAX_CLKS       6
+
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
 	int dbi_length;
 	const char *gpr;
+	const char *clk_names[IMX6_PCIE_MAX_CLKS];
 };
 
 struct imx6_pcie {
@@ -74,11 +77,8 @@ struct imx6_pcie {
 	int			reset_gpio;
 	bool			gpio_active_high;
 	bool			link_is_up;
-	struct clk		*pcie_bus;
-	struct clk		*pcie_phy;
-	struct clk		*pcie_inbound_axi;
-	struct clk		*pcie;
-	struct clk		*pcie_aux;
+	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
+	u32			clks_cnt;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -407,13 +407,18 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 
 static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 {
-	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
+	unsigned long phy_rate = 0;
 	int mult, div;
 	u16 val;
+	int i;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return 0;
 
+	for (i = 0; i < imx6_pcie->clks_cnt; i++)
+		if (strncmp(imx6_pcie->clks[i].id, "pcie_phy", 8) == 0)
+			phy_rate = clk_get_rate(imx6_pcie->clks[i].clk);
+
 	switch (phy_rate) {
 	case 125000000:
 		/*
@@ -550,19 +555,11 @@ static int imx6_pcie_attach_pd(struct device *dev)
 
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
-	struct device *dev = pci->dev;
 	unsigned int offset;
 	int ret = 0;
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
-		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
-		if (ret) {
-			dev_err(dev, "unable to enable pcie_axi clock\n");
-			break;
-		}
-
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
@@ -589,12 +586,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ_EP:
 	case IMX8MP:
 	case IMX8MP_EP:
-		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
-		if (ret) {
-			dev_err(dev, "unable to enable pcie_aux clock\n");
-			break;
-		}
-
 		offset = imx6_pcie_grp_offset(imx6_pcie);
 		/*
 		 * Set the over ride low and enabled
@@ -615,9 +606,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
-	case IMX6SX:
-		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
-		break;
 	case IMX6QP:
 	case IMX6Q:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -631,14 +619,6 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		clk_disable_unprepare(imx6_pcie->pcie_aux);
-		break;
 	default:
 		break;
 	}
@@ -650,23 +630,9 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 	struct device *dev = pci->dev;
 	int ret;
 
-	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie_phy clock\n");
+	ret =  clk_bulk_prepare_enable(imx6_pcie->clks_cnt, imx6_pcie->clks);
+	if (ret)
 		return ret;
-	}
-
-	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie_bus clock\n");
-		goto err_pcie_bus;
-	}
-
-	ret = clk_prepare_enable(imx6_pcie->pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clock\n");
-		goto err_pcie;
-	}
 
 	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
 	if (ret) {
@@ -679,11 +645,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 	return 0;
 
 err_ref_clk:
-	clk_disable_unprepare(imx6_pcie->pcie);
-err_pcie:
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-err_pcie_bus:
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
 
 	return ret;
 }
@@ -691,9 +653,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
 	imx6_pcie_disable_ref_clk(imx6_pcie);
-	clk_disable_unprepare(imx6_pcie->pcie);
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
 }
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
@@ -1305,32 +1265,19 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return imx6_pcie->reset_gpio;
 	}
 
-	/* Fetch clocks */
-	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
-	if (IS_ERR(imx6_pcie->pcie_bus))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
-				     "pcie_bus clock source missing or invalid\n");
+	while (imx6_pcie->drvdata->clk_names[imx6_pcie->clks_cnt]) {
+		int i = imx6_pcie->clks_cnt;
+
+		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
+		imx6_pcie->clks_cnt++;
+	}
 
-	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
-	if (IS_ERR(imx6_pcie->pcie))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
-				     "pcie clock source missing or invalid\n");
+	/* Fetch clocks */
+	ret = devm_clk_bulk_get(dev, imx6_pcie->clks_cnt, imx6_pcie->clks);
+	if (ret)
+		return ret;
 
 	switch (imx6_pcie->drvdata->variant) {
-	case IMX6SX:
-		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
-							   "pcie_inbound_axi");
-		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
-					     "pcie_inbound_axi clock missing or invalid\n");
-		break;
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
-		if (IS_ERR(imx6_pcie->pcie_aux))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
-					     "pcie_aux clock source missing or invalid\n");
-		fallthrough;
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
@@ -1353,10 +1300,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	case IMX8MM_EP:
 	case IMX8MP:
 	case IMX8MP_EP:
-		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
-		if (IS_ERR(imx6_pcie->pcie_aux))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
-					     "pcie_aux clock source missing or invalid\n");
 		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
 									 "apps");
 		if (IS_ERR(imx6_pcie->apps_reset))
@@ -1372,14 +1315,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	default:
 		break;
 	}
-	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
-	if (imx6_pcie->phy == NULL) {
-		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
-		if (IS_ERR(imx6_pcie->pcie_phy))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
-					     "pcie_phy clock source missing or invalid\n");
-	}
-
 
 	/* Grab turnoff reset */
 	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
@@ -1477,6 +1412,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1484,6 +1420,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"},
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1492,40 +1429,48 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 };
 
-- 
2.34.1


