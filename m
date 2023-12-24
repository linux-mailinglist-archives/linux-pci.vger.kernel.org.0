Return-Path: <linux-pci+bounces-1348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD881DBDF
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7006C1C20C08
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D2DF46;
	Sun, 24 Dec 2023 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cvmJhu1N"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4911CAE;
	Sun, 24 Dec 2023 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W34LDyMjf8lHtioonc6trvEMF1A7smhEuzniylLvcHIiTKuhHQKdYOMH4JC5N8Dly4KKIZGaK4X356hxQhlUCwg4RW8ok1mDPMlyzv1b0jTo1gFPFWkVM9GVrjFppnzBOamRlE76B0wxkBwzAQrxe8BJbXaiC30RE64JYlt3F8HM8cetnyndZ9QTM/ySMiap05hYH2QrbMU2C0JTl7RHOkayDAMsrZdSyNaC5q0r0oCP+SpeKMUy4ikgwBf+DAqOebfcIDlmYpiS2z7j2/VqIOtLxHaX+hOz6sGabaS6K1MKQsD4rgv68ukgdEP+zcWAYnUTRVUqxqRbAYhVHX1IiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVST7tU/jdCw6hjOhyZAUn8Z1JeHyuDnhtEpQSTZNgw=;
 b=U7U8SWCn8EZWtGLvL/hkv1meB2frkoaDC1++SsOVn7z+RnSThB2ZyhDKAkBxj4GbiCB7f0FCyH/aZ+LyCacZVHeEKmw+DNQY9h7/mKq39IwLmuDRk81U4qxxnCZnAwyLNyVoLEKqKnoyIU6gcP7WP7WyyWvvxMCmlUj6QWrsDJmA9tM9Vy+z1QgOESyfGZNe2SJDqdrQkC/Bl4xyPuZy5wYsC97LphBA2RPWxoA8hbqe0EgkXtPrzQPMQJSwYbIMuWJyRFT5s7vuktwLvWEP3nNMvV1wJHig9DRw5WZKXWi2bAjO8k+eMzxoXkABnFAz8x1BQLt5BTMcvcYg0b017w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVST7tU/jdCw6hjOhyZAUn8Z1JeHyuDnhtEpQSTZNgw=;
 b=cvmJhu1No99k8lZfAbWgPyPj6wVQ/IehEJ4fk0xmCCv75mDkIyKPi1IK5q3Q53uiIkUWjd8F9zeBcVyKraw8+gH7yY45a5i8Bj2sGInCDg8ZD4POXh8rQG95IfLdR1rUBMzyAFsFoHeEiJtLITxC2RrMvnVx/ZfUquNbt+UDmDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:33:38 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:33:38 +0000
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
Subject: [PATCH v6 07/16] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
Date: Sun, 24 Dec 2023 13:32:33 -0500
Message-Id: <20231224183242.1675372-8-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1d6823c6-03c4-4921-c015-08dc04aed88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C3R3AubczfXhxHx8A+KbEJ29VasoshynfKt1/0yl0B9/uX63/utqgduAZiDEbhDuY9VFP93BhpQ9UuaM9dwhWDvYxwyjsTsGD3Z3hULzlGNhsgYeP4QLOAZJT0sR5Bl8cd3nPseTILTEMLB3FPU2GFAgUf88J7RrC7Nbg7hpLChWfXWI4zodkbtj9IAUPtPXTNXLI9yd5NhTRLT+uikjozyMYMIa/ZkMpMfCt72AGXftik4xEDoLndhY3YmLTuZTam8nNvpFqj+2aN1IsDuZodLkDDHNMKJnTsNsmTZ2lPkvLlcX5nwk6qWqm7mXeKInW4J11MUSbt7enGk64L58wEo6W4P/vCypJO+++Y0AsnE7piRlQSgvJ8IBmai1tYR2AvhZd7wN3fVIZRIrOXAz8y8vzYQTHuAJU4oUsLQEYdtnjxbWL6WO3KGS58lDikIb6+GNma914sl8yWzY2udUyTmpfgNOWjXd/JBfeQ3padWmf2NjAsRtKjgOkwkA7g2VLXEdvw6wUjJq9JPqMA58F5Uzw/AMDK/r4TLkLTlElDZLR1i/pUk7FrshKUjmHApJh1dGoIYjNfWZVlXLr+wp6cJrtZzSKwjhFbkU8MsjERr5y3/YQ1Q6kNbEyMozsoZo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pIEAZMFCXhwEIBfvqtxHcuNPgat2poThkfcfdSvpuiF/mDw7E0y+DsRTnXJ5?=
 =?us-ascii?Q?Gr1UE8N9OxBzYsJNOuuhniUxXGE8GabSb5FTdBePjPR7/XooT/GF9XMU7CEY?=
 =?us-ascii?Q?YBkiVKaSYE0BLqyGM7t/t+OBCWJYsO/p1FEtky271Ihu4QFqnm630Pt/wX0d?=
 =?us-ascii?Q?u9OpUiHMogkkCyr2YQk4L1QPG1SEv85EkALX3HNFqKlZpvaHVCPwl/tS5I98?=
 =?us-ascii?Q?vjU0eOukhv8DdcFZSD41aaPKUO0DeLG2GiqPkHSVntc7T0frnFfAk+wc4iK1?=
 =?us-ascii?Q?wLdrMR0EwXkdvXSD960iIfKuqebIa4fnBrYvh5krTUfIJFOh96sMw+y/7ChS?=
 =?us-ascii?Q?wBMdafy3rB+VoWpxphSto2J7ikoCeXiZe9u6BvQag/OcPn6u8SUF7890J/ah?=
 =?us-ascii?Q?l9BjWsFZQbl/2HBkn8xMEHp8xEkZgFdEJBLaU+jFl5Yxob0Rxfa0KpHl2Z7b?=
 =?us-ascii?Q?5VQwNclORRlUl2PTaeO353N8yzWvVjYT942PI9VqyNENU4ZMbhvbmCz3cRoB?=
 =?us-ascii?Q?Ao2pUgG9KP8Gbls67mr1FBH2Fwa9ye97EzpEDKnghyq61xBe/6trjI31ni+k?=
 =?us-ascii?Q?0dE6insmnUdpcjrF7d591C6cHcIASM1UmNWQ9j6ColDN/XvxLp0mnkwT7J6E?=
 =?us-ascii?Q?IBTT+0SGDYj3VvjzTtgfp6iFnLPtHThxKl4ASORL922MIGdI0ja1kViOA78X?=
 =?us-ascii?Q?Ig2/3zKnZ4KkRIZazTpPftUntqGlP+03zlu5dbUx5vQifWyGQ57uJ0Uu3CxS?=
 =?us-ascii?Q?fMP0Ph7V26hZHvHwNw1S2O9Wm+rQywWkw89f668hibXxn1FZRBt+Cr2GSvHW?=
 =?us-ascii?Q?PSgfL7UrdCPZnEcEU/upIX1+AObfnHbCgtjeMYVjJU0uvscPYeHMsH07Z02g?=
 =?us-ascii?Q?8/SlBIHTyG9kzaVM/8kjmUN9QrwVQx094gTGlkFfmWPKFrGVN7A0+Qvw+Tf2?=
 =?us-ascii?Q?d8VUbJAYCB6sNpBmob47uoc2sAC1+qGU8fWIZLSqrP4CGqIZXAse7y/DI3p5?=
 =?us-ascii?Q?pXsEuvl/7EJ+xMqRd/uxDdC1531nQyfGFDM8D6ThpwcSy1xHBDRlHazgVk14?=
 =?us-ascii?Q?JMQVpsuAxKLd0p9/Ejr5/jtQKcvw3Z1QaIwSA01G5f+0/OX8nkZ0Kz8MHRwL?=
 =?us-ascii?Q?b+erhziNK/xqGmuPwNjKmINB3mr3JcjPbyLFnOI9NUVv0bUuECIQcSvWmM8J?=
 =?us-ascii?Q?+SmmcTxjEPImpWVLp0McqK6xJrvXBGQg7OcrHpn+KvtdKejtwwRNgcVauQxG?=
 =?us-ascii?Q?yixlmbh2XPpYKAI3t4N+doYwJ2GPf1iMoP4Rj8xInYN2NzrxDheLF3o5blBe?=
 =?us-ascii?Q?qj6+/EON30c8ovdYGCCrrwViGCvRlicjnbYyb7OWWu8j4QEWGkCIu/o2Vinr?=
 =?us-ascii?Q?jfPDxzih1teD1heqFbU8DTWAXRRUB0BM2GSd3gB7udOcIQG9WEagJwPmh+LB?=
 =?us-ascii?Q?uyWlNYuxx+ekfrT6kbiOZdiePZXEXX9RNS114gRcPN+XLh5m6PmMFt5Kq00i?=
 =?us-ascii?Q?+yyRzVPiTpJHo77HXfXvdzMrZdkSGVqYbgGMORwGGaDRkwIn2kr4EM8AXOUm?=
 =?us-ascii?Q?014ugT128KOJNp/l1dQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6823c6-03c4-4921-c015-08dc04aed88e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:33:38.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 976BeGMnTmsPW65JRbBU7G5eZHJ9pJ54813MmKMxa9AeBkvzA2ZSfd8bMLC1jyg6Y9Z6zea8Q/T8cqLVJ0AY7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

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


