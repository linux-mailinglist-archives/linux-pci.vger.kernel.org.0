Return-Path: <linux-pci+bounces-1845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F0827B74
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817812852AE
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB16456477;
	Mon,  8 Jan 2024 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H8VtN4HR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDBB57866;
	Mon,  8 Jan 2024 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNP/d6p7879IqpV8QaYx2G9Wb41XohcVFfn8gnrwbdXyxjtqLRQmhZubLh44Y50MFrfI69ITV+/Whc7F7s+DLmRfxdGEwh1yLWmprDQ+kG3QzU6qMeUdMaEzoGqzV07YNU2uAlV4WQbeDmryK7hBMl89+gPd4O8mtQqZlp50Mxw1BlkpYo9fGE14i0PNQ74Hr7uBtz/5Uah8lBj3dTpQg9JLir8M0Yif1VyRHkHnm2F87l84Ki/QR9FuWVNHgP0ynQz1+ngXESsQXBnK7EjXIcz97GcpphFiStQfxTYPZlszpXpDvOZ/bFn4I1SN/rZyQC8h05OTGVEbXp2UIwaL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=633neYQeEiHH2MLYF4kwNeJxAW1EPmyZ4Tt1x+5RYBo=;
 b=jIdh1zcfUlRjeF2LOSV3lSObEL6AjUE7Q4KLjHlcujQO2oKDCT3WZtDE6WznEF3DR/wu19j9sCphoUt2/PtOWRaWZ6zoUybzD1ffnzIiQkOC+amVN9lCbxbCfFqeZDhH02zn4I7JUwCZgA8+xJKroT0ePRbhaY2F8wyZijvNr3w6q9U5apOAShcwkYBKcbM7Txh2ZYoeR+KuiosUrgjIEp2I7mJvE6coQOmftDeRRyySv8+0Ro6oLiQhqr01qM9y+JhVoX+O24zB55F9kvz2qdE1ol8YrPMaRD+dBvDL2+aj90CcV02OQt7ML/NqsJsLxaE+4wJf8hk4XYlYwszgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=633neYQeEiHH2MLYF4kwNeJxAW1EPmyZ4Tt1x+5RYBo=;
 b=H8VtN4HRV3QnQsRLha3U8GzpVK28vEgQlzV31zEYcO76bbr8hNA8JwWE7aWTvPtx3OkBxpqnBs7H3uphWu4ukVnzhoxw9asbgRIwBTdvg1yWgdFG3yyWD7UxxEHR4nMueNPV00gFrFSfYO3ZXXtF2EVv7WME3KlKxHoJmO1xD4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:22:44 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:22:44 +0000
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
Subject: [PATCH v8 07/16] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
Date: Mon,  8 Jan 2024 18:21:36 -0500
Message-Id: <20240108232145.2116455-8-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6842a388-3675-40bc-592c-08dc10a0b799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fQtrd3WU61lfTPB47JtWOv1jrSROrRshPiW5zAcJd4KdZpD/lKK5/nURu4fBrgy6tXHrSSKaFp4EfFuMP5UHvxkyolGE2AM6bBZvoZzLO3C06kMA75gXQToT/3HevSSMm+OSTIBMhwoIMGE+WD7Ahu05Le/bLFvXh3ED6krFof1V0T85hU4s6TVoaJbugyANIS0s7eJ1m0jt6mZmBb2w+p/SDLFHU9QX0yUiGH3pU9j6ch1ldnmO+w8Gv35XJDVsW+duZDpGRue2BEck8Y7lMgkOyu9CdZUD5ahCG5bNMPxhb7m/ZwYEAee1sQRWY3COs3mUFDQE2Iswc2adnBvAFzV7LngUDREKQ3mu9tnGYgDC0SqqG3RvwZWzoM3mUUDWRQKabNxVn8eUa8kO4KJiFGCpi8jdigFw2xSbJmx3AOkMZ2X16VdlMHA1WeHFvbM87trQxu7ymoJHfN8xCrxGN6gwlKPN9oT3bTqKHlsE9dGvXaoKJ5beeGAbPx/Pw9GtoTEUoa85HntAQwSKLZ3qW0Lw0/sr3wV1jHJgdrjIj3bmvV+uMKWpVTunQMvxdB71cIGEGOolr7GhXjyyDdmiNTJPO25d8/fTBa2VnYEwmB4UKlh7imacDOfetVmjy7qL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8nYHrigekY3a+MQJspEYvNB4vq3QtomL1WvmGKoKkpizRGYTFmye+9CPgLbR?=
 =?us-ascii?Q?Bp3ikeBgcHKJjr2+XpJWNgY5HHwGkhE23HNqZHJAMLZ91su07pqQUPvG0oBQ?=
 =?us-ascii?Q?1TZNImiQKLZWHO/7vdCbjKeTt4fYPIxLF7T3uYuJCLMZJZJB1+Yn1n68K0tH?=
 =?us-ascii?Q?aSbwRFG5qspFVgSL1i305OE41xl2upurwCt7B3KocQP1NM0JHBe18vRB9fr3?=
 =?us-ascii?Q?Bos64IVs7+P3YJArSQXBP1Th3JgK26zeFpjOTwxDXoeb4KvRydujxfC3wIhn?=
 =?us-ascii?Q?rbreYnQSEYdirMR+9+Z2EsR017yPlleOfIqkUoD3xzLqtZ+txdsOhalWZVdI?=
 =?us-ascii?Q?z8d+zzOZZX4ciVLJ88dxaCOTwSPlDB9ZuCjRrCTR+yUgQiZmIUZNjDzU3yzQ?=
 =?us-ascii?Q?eGXburOpaK6abP6eqWZ1MJcXQjUo5gJI57bFtYov+ONWzYt85gvTJml7AHU5?=
 =?us-ascii?Q?vLqPA0ezHr+YraBLYQXFouPGbrn9XC8ZwT/MG+Sgw7d5v1vvNwDK9efobBiE?=
 =?us-ascii?Q?xG5dKrKlbanYJMlIn3nVlg2g991R8w01iZAlAiTt8NZmm5EpiEOl2j4TnRS7?=
 =?us-ascii?Q?1VuAsy19L+aqfZQoRUxROVq+rybfoTQzSW1Z9RZmzVgC/LfoLMg2QflMwghb?=
 =?us-ascii?Q?O3N2AWdnyMfL4NwujJ+aZHaVbtHqN4lEhb3+0k0Gc+ZRLiAJja+lM43XBxd0?=
 =?us-ascii?Q?LIPSbvHMJBac958u9EHJJPkvSNr/PT1q+oKS1OKdv/bMGZc8p9vIUy7V0sUu?=
 =?us-ascii?Q?mBg1uowvEPI3bOWs3E77wCTiwefk/Kf0h/IqL69JrWW5Zj85UuBCPkPU9qX4?=
 =?us-ascii?Q?gKNylsiLbmHIsLw0KRXzlHqON3r4IF7jSWheN4KLp6E19Wi6RpSSAd8bKSX/?=
 =?us-ascii?Q?T9Xfv8TOrkE+aEKsjBVR680CzOHACcu2VyDXF+YuR3lnwvlT+GKMvpAdCFjx?=
 =?us-ascii?Q?P1H3G2HK2zFLy4MVttkU2Cs24H/lwSN02Yizzm4fim3gxrLSjR1d7xzKCUil?=
 =?us-ascii?Q?vCGvVL5aghKJi5VSdWKdHIUGFQz+6Yb2edhCNRddGZXL+uWpy9V6lHkGxQhs?=
 =?us-ascii?Q?NovAG8z3oXUQC2rwE7i0pnumD/lhIy1HLCxJl7zgI1HIha/hyWTPiU+eEC1g?=
 =?us-ascii?Q?3mUHae2uaZ4yiQLxD5IWt47hBhdkAYbp7Np7ooVVhJHItojA/c8+PtL5+tdN?=
 =?us-ascii?Q?eWHzLqbD2JfM8fQzgIvUfhMgyQWEDwo4Jfb7ssEG5eUhmuS/rEYR9tot/mZR?=
 =?us-ascii?Q?PTTrrESvdE1jxE70AbHKTPZ0jh+x4IaK1FFSVp96IQTEgmPA5bSVu4hmvxdu?=
 =?us-ascii?Q?ERWFXnCHJRaJxB68YaL5rgzvZHes1e+EkIK+KFMMYAArpuNMUmRcnIMmoc+x?=
 =?us-ascii?Q?k0SXFBNZxXIcQzf3mcZi74M6wz3U+vGCIaokHBleKvDix9p7II/+aW/hqHK1?=
 =?us-ascii?Q?OCq+/5+SqGn3gusSebAiRARbPGX3tJ+NLxa50WjwVvRJ5veY/uxB6nrEPDlV?=
 =?us-ascii?Q?BrVJ5g9lOEHGknPVRvEUOqAXSTRz+g3iFvtxn3VJD/sybLAYWBXBIuQu1N61?=
 =?us-ascii?Q?y6X+iiGljnnrUm/Q2UL5r6HYl5KZyRWJ0ahqv69d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6842a388-3675-40bc-592c-08dc10a0b799
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:22:44.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QU2le6n28BgcbuR9hPUXdIghZjgU+WoX3C0NDx2ZYI7JRVaDpD2NUjy7QJHtrZYp2rM9kKqBt5Be9qQmHf1whQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

Add drvdata::mode_off and drvdata::mode_mask to simplify
imx6_pcie_configure_type() logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - replace simple with simplify
    - remove reduntant comments about FILED_PREP
    Change from v3 to v7
    - none
    Change from v2 to v3
    - none
    Change from v1 to v2
    - use ffs() to fixe build error.
    
    Change from v2 to v3
    - none
    Change from v1 to v2
    - use ffs() to fixe build error.

 drivers/pci/controller/dwc/pci-imx6.c | 59 ++++++++++++++++++---------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 818e73157e724..fd83af238fa60 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -68,6 +68,7 @@ enum imx6_pcie_variants {
 
 #define IMX6_PCIE_MAX_CLKS       6
 
+#define IMX6_PCIE_MAX_INSTANCES			2
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
@@ -78,6 +79,8 @@ struct imx6_pcie_drvdata {
 	const u32 clks_cnt;
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
+	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
+	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
 };
 
 struct imx6_pcie {
@@ -174,32 +177,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 
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
+	val = mode << (ffs(mask) - 1);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
 }
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
@@ -1389,6 +1384,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1400,6 +1397,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_axi),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1412,6 +1411,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1421,6 +1422,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_phy,
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1429,6 +1432,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx6_4clks_bus_pcie_phy_aux,
 		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_aux),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1438,6 +1445,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_aux,
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1447,6 +1456,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_aux,
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1456,6 +1467,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx6_4clks_bus_pcie_phy_aux,
 		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_aux),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1464,6 +1479,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_aux,
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1472,6 +1489,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_aux,
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 };
 
-- 
2.34.1


