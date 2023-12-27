Return-Path: <linux-pci+bounces-1459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC10181F148
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772471F21408
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515A846BAD;
	Wed, 27 Dec 2023 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E0rxngrk"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506F48CC2;
	Wed, 27 Dec 2023 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZmtmSr1r8qGHtDy8F5XS6GVjof7ls+p4vhAeyR0KZxr7z1eCnlkZMrjDLfkK8jB+5KhuaojCF2DF5jK1uVoy1FucwaPvl3QHCvwNcJG0fklD1XmI6WHfb4WuajhaHsjUIh6l2NcOcaWBK/z8f+dWXwV4lJenfxsuTRX4Gd7Ikq/REXXTw9lkWJdi98k19VbLfIY7xA7JgeIyoeCfwalNwA9FQ9Yj1HFmbg8S7Fo675D0gbi+QjjRa4fBeaGIE+w+mWz2Jn1JqLpNk4j+jnwN8ilTRb9sHF9mIHXhvX+5k3hG4WnTTHCRXHZWQeUBChI+MDczGyobcVaPXoCxFTakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVST7tU/jdCw6hjOhyZAUn8Z1JeHyuDnhtEpQSTZNgw=;
 b=Fap+7N/RSJ/XURwu21o7owwBAtOy99SS3Pkcziitwd7PZQWK0/Fj+0EP9lguvWL0AoVml+8Wp8NUuwIN0Tmb43IlXPdv51G01f3/r11WTZEIPw61L/hrStqGbB6BI1pBFvof0kOP/a42O+sT3kxreX/BKEDh0yXVrmRhdY+iW6aomF8c+zKa7mqkHcST+8avhWuaKk//q9zAlkhUrW6HBO5heEssQLwJhMTHeuMO0Tve5kVRoNvzRxV4gJakfI5zrd00W6RYMEgbngpLEEbRToFZ7a9GT+JP9JOtWdlmOHbO+XdNuHalWzs363cF4Wya3hz9DXmtoZq+64UqPXFzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVST7tU/jdCw6hjOhyZAUn8Z1JeHyuDnhtEpQSTZNgw=;
 b=E0rxngrkuTxOs272ubqlVHHz13F13LfsDOeRgmgB/fQZdTwSO+D99lsM95pY3uI0lhHGEXyV/a1PIRxx73NSFTRxxQNpB91+VAOsmsyB1KuenlevU/6rx6CKs011bv4dj3ChSUx1X9bJS/FAFwG5OWiLyV5Eh8M+lnQqA9F2VrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:26 +0000
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
Subject: [PATCH v7 07/16] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
Date: Wed, 27 Dec 2023 13:27:18 -0500
Message-Id: <20231227182727.1747435-8-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a9706ab-457c-4b87-a1b5-08dc07099de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HIhCqb1rZKYb/0ednvXZTsn95tJklk0mNxaMC8tLRLMwLaPNu2csiZ3XokOrJmtGyeo+Ihim6eOP2rdMDgVvnCPHHvA3VMghNhdNmXYnFogmKLmfzTy8bK8OIf+/w6ae1r9fRQXBo8wvKXJ6Uy9ex7UxNFZl0WAbI2nOluC8vaTV0pZnWjJyP2T/l/3CfdV8+qTpP+9LlfZySVSYi0tTkIT8P590LZ+QrezGuT3Ll7eefgKyjaUbie3R65i6o+cO5ErMJmyQseV8Jre2vC/LHmcFeAUG6klAzTRZ2vHa7jEWTqNc36LBHP0d58cpJV+F/kFYDu3+/sdm0mctikx68zdWX5kbRcvFydlMJf3ZWFYRRWTafmlfy2YC3NOlftjhpVbGqA7jfGt32Ae+sxqXoMuoijYbs3kOTmSHyZ02iEO522BNw7LPR0diU8D/QdDUrfdF1bujgebw8pmTmi25jDv/qx8rhhQzaNEB0AadlD3j7LyFJdxitB8hfvGF9BOwByzvCSzUgU9/CAnM4ductYWqQGYwpsgudB2/IwmzSVuYgSy8+LJK3rdGCSJYwOn8jlD3KXSdLewepSIh7rO5+PsZYQQLZCC6ilgPAvgmntUDYDd7oOo+F2S0VIfZt7Jc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SOv8KpG3Zr6PuouDNMZRt/HlWbbjJ5P4+ngw2po6VMRZtfCDrSC8rc+Xa0UZ?=
 =?us-ascii?Q?H5mK+Eda/bOFSyk3uKpn4mO7u4L5E2amOhLWZMYnY7J09/vS0exO/bZuRd8U?=
 =?us-ascii?Q?GobzmxdNnCUI5f1Pqwo/KPL3r6eME0UHLEaMmLcUPpr5vfKfuLo02yvBMOtN?=
 =?us-ascii?Q?3Oa/I/W+fUENMGmk1eEygwRUoJ6NHyk0SYwmGr7GalP0iGd8Gdnu89b0vj9c?=
 =?us-ascii?Q?n8l3ZeiUgDx2b7xEgzcuXjFYezvg61JIb14DMY6I1Qh99pz33f3FK6QHySOi?=
 =?us-ascii?Q?PHk31F5bqtOWtO7Qgh+8xx8elgYlY97EN3jBOQol+ajlTRC7nz7cyNI/jSPt?=
 =?us-ascii?Q?/WeRjwrHUWdHjNkPwJnYrqN1aEOOrvXN9HDZOdv4zR1UQ/Mx21fAnvLXvsz3?=
 =?us-ascii?Q?kf/no1tG4bl1rampvaa4a93L/yMfZ1hJBvuuRbGKIk+S7zXlgJaiknssIcFf?=
 =?us-ascii?Q?H0F1coij+XdhugpSodZNWhxIY0VYIMF1zZEnYLumj0xSggsjThY2EOlliT7Y?=
 =?us-ascii?Q?FjOO95CsyKZ710b5tQCFuQCQPK7p8/gVnLWS7ATNHFpySC9rA0XknORBdZO7?=
 =?us-ascii?Q?CLYEk7NhMpZpsdt8CPLgPFC/XyGV7CXzSLddXNhnW02p5lJGiHeLKvqOB9QB?=
 =?us-ascii?Q?3CIcpZxukSHXdehJs3Q6yfHVwvGh5te4BM/8pi/EYPr1ryPJVUX1HLsaJz2t?=
 =?us-ascii?Q?aphWXgTMdVoBkpqvXO9KlSgmVLVp1HFQM5EKFmorxLNchxua+pyZYE95m2VO?=
 =?us-ascii?Q?rLQ066X2YqcU4g+nLqtwqL/Rfr7wMNaqRYA5PUQl896MbKrgJuKSoBQMtM9T?=
 =?us-ascii?Q?OBhL+G4E/1DrtNIos17I3p5wDa/AFClE+neJnOkftetUufX+02niPh9c23ea?=
 =?us-ascii?Q?PcflxgmfQaVG1fqH4bFad7vhmB7fqDN3qMOTcZ5ZF8s1l7kjfFTHrOy2zMlN?=
 =?us-ascii?Q?2dCHSrjGNVicbj8opSuYT8P5PUayctQ4t9ie0Nlh/K2VpDMN07EGmpb7eArj?=
 =?us-ascii?Q?T/ItbdGIeU/52G8lG15F+PGIvnZAjBHx41Pegk3bsWY812GdWnmOhXm4r6Pq?=
 =?us-ascii?Q?7ENul/4kUXIgvrnFeQHvTyM+J5I216fAxyv/vLTDOjz0/Aw/ekqQtWsADFEX?=
 =?us-ascii?Q?83VX8+jka9JhdQhTeWX31ocGnifnaoLQUJ1mi90HBVNWCCNI4LgQlxdHl7Ge?=
 =?us-ascii?Q?EmJEF4ebmwcz4syt1PGBX71xH7EUhrv+BiBM9YIUH2EVriMbvLy5fKvrgnSS?=
 =?us-ascii?Q?zMWv/OfmiB3HLcDAqV+7JHz1D/ensjjC5AjBRPArYdTd4yOz6HR7xxop9w9/?=
 =?us-ascii?Q?d6/ZBjgK8SZG+XFasI/5tnEyOTpyTKs6qZY+reuxuQrNzDmFY/f8q2RddcSc?=
 =?us-ascii?Q?68b6uHVIi3CmMmwCb1iheOji8I6Jqr7R4XwIK+lq3/QpmsOqXIOIYd2a88XB?=
 =?us-ascii?Q?8o81fX2hFTbeAuB64iz6aSfKOPB9Bernl2/bQ50FZ7UbXjbO/pjsg1jONRzn?=
 =?us-ascii?Q?Q1y+t1VCblQqgkZ9PQIrBdM5iKj+8worboRz3yiD7nrMN+vYRtKUMLw9Kdr4?=
 =?us-ascii?Q?3Sg9CoAgHzU+++mvpBg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9706ab-457c-4b87-a1b5-08dc07099de4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:26.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XeHYQJFX4iGO8o8+FI9EFFPSI60f1TDUhGzWqvhrhagZvOjRkWUyBk8l1oOHS26xWuS95+uNKzkHMor6gNc9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

Add drvdata::mode_off and drvdata::mode_mask to simple
imx6_pcie_configure_type() logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - none
    Change from v1 to v2
    - use ffs() to fixe build error.

 drivers/pci/controller/dwc/pci-imx6.c | 60 ++++++++++++++++++---------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 588bfb616260e..717e8fa030deb 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -68,6 +68,7 @@ enum imx6_pcie_variants {
 
 #define IMX6_PCIE_MAX_CLKS       6
 
+#define IMX6_PCIE_MAX_INSTANCES			2
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
@@ -77,6 +78,8 @@ struct imx6_pcie_drvdata {
 	const char *clk_names[IMX6_PCIE_MAX_CLKS];
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
+	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
+	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
 };
 
 struct imx6_pcie {
@@ -174,32 +177,25 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 {
-	unsigned int mask, val, mode;
+	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
+	unsigned int mask, val, mode, id;
 
-	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
+	if (drvdata->mode == DW_PCIE_EP_TYPE)
 		mode = PCI_EXP_TYPE_ENDPOINT;
 	else
 		mode = PCI_EXP_TYPE_ROOT_PORT;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		if (imx6_pcie->controller_id == 1) {
-			mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
-			val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-					  mode);
-		} else {
-			mask = IMX6Q_GPR12_DEVICE_TYPE;
-			val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
-		}
-		break;
-	default:
-		mask = IMX6Q_GPR12_DEVICE_TYPE;
-		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
-		break;
-	}
+	id = imx6_pcie->controller_id;
+
+	/* If mode_mask[id] is zero, means each controller have its individual gpr */
+	if (!drvdata->mode_mask[id])
+		id = 0;
+
+	mask = drvdata->mode_mask[id];
+	/* FIELD_PREP mask have been constant */
+	val = mode << (ffs(mask) - 1);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
 }
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
@@ -1376,6 +1372,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1386,6 +1384,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"},
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1397,6 +1397,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1405,6 +1407,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1412,6 +1416,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1420,6 +1428,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1428,6 +1438,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1436,6 +1448,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1443,6 +1459,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1450,6 +1468,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 };
 
-- 
2.34.1


