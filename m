Return-Path: <linux-pci+bounces-1347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A9E81DBDC
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA492815FF
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D72DDA8;
	Sun, 24 Dec 2023 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LzmcCgGt"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493B1118D;
	Sun, 24 Dec 2023 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwNXCvLqmGDy/R9EG/V1ghLBg+PDunQ+nKrSWeMhEXza774ZK2PYbiBn+nKDq5tmSprLfbL/LHuVE42imuoYPfUeq7B2MiUuGhnvwvgPOvIaMk4dSu5/Df/i0OZeXEcgp+qU73tcqzDtZDoP4Xkgw03azy1lq2sxo+V6H5DcIIXjHWHUcRD6xMJL4z+HLMfTfT4+V/huzv6loZGCSmMkHKFy4JhDzfWBnSPX5sMQjWu7j1I6AbGzJaKiyRvqLExrSUSecyRZ4ivghpEjGV91ipjHywAHFVEdMje6CelL96XtLlW8HNB12og9jCYokLvsWzrJw+sqY5BbpV9MlYbMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0z9pcHLjdXiH6wD7qmDtLqSR+u24DFRcxKpgzuOjSs=;
 b=lDJPtG36j7u4tMg/3lhub2lTayVb1YuEiqgUJgPK8V3G+6pfnlRYBrR9xJu1vYTumMMiBTJYW38ds5325eivO8GNuYRIc2XM+HaKfC9MSwG0Kta1Af+CPhbPsLdS9/OFq+QnJ29tCYqnDEVNns6xAeVIlWJT06XtQXMoXAx8uIk1JJFPlxEKPDLJOF52r44t+d8DWCsEmd94LPOvq476vog2Vng+YOPEvTmPMg5RWv3Cb00rJ6L8hQb8xBgkWhRf2kppVAyUFKMP9g4+lKrptTC0jcDQxAaTO/5QgXqVlpZxYEgpc9oPpCKQPsKYQfskl2J08qgzK7RrdcOTz7++uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0z9pcHLjdXiH6wD7qmDtLqSR+u24DFRcxKpgzuOjSs=;
 b=LzmcCgGtgKTPX45oE+ZDVt/nkq77Gl0WOhQWXJy9mz/uL5noAwwUrhEkywJY6cSWAmXoinOK0O1IUm8J3tBEmq280bVXutdbsfEzseJdljFE9yyyWvjmeAF7jbNJMTvRtiyWqwuiutPExlBHWH9vKVMb02C4IH9LaMdPla9JOn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:33:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:33:33 +0000
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
Subject: [PATCH v6 06/16] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
Date: Sun, 24 Dec 2023 13:32:32 -0500
Message-Id: <20231224183242.1675372-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b30e8385-6e9f-4bfa-f9fb-08dc04aed55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UWApu2/u/OeTPuVLnQ+kM50gA2IIzIbrZ5nCoGtTqydlV+c3ibHoGhfNKO7PTmLnAiEjyqejyXDBiMORCJb31fF9M+PWRr/KBxCm+5s/JNcaXrq1ellecOMEY5bayKP0hswKmzUBBpRjaP/vCe3bMoONNeFjyY9KkYuMiRWJXMfvEkHghUWmlJqkaFl7G6xp1AsvWJTFdeKV/kIPwbw0lasPnqHRjo2hYVBMMtlmFOCf4xlGtNM8sZLRgijbKzj/1Pcbht1P9uv3hckku3+Y5uOLden76OO4An3aDdWMxbxxnfuEfXnK7WF4HEAai7Y6VOvxv974uLsFc8LX9WWhkTccmaWNuB865BMxBwRPYMXR00qLy7h3Mi4kxf4VEWxeTZlntdoT5IHXEjWKJJiNRXbVTFxNoC/8OWpTLnULiAHwApeuNZ4o2Q5pM43PnSJsbRP8j0QNjQ7rnu8ZmgO6/BTYvmY59nf0YD5OZMUmHNrioP/feEMvO77XhTKnMKQhUVDzoY8ItJrl2G176Nrd9Hfk5etwKohYfoXAlTH6esu+nT5lDppepQvUwiyXZ8VRFCWBPCCwcAyrBldTipNuvYG7RzPnliCGGtED04IDEYopRS0WT1vQjhUjkxYy3dJ+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4vo67IKrMIMFEAArx+mWze+8I7VOku0IxjQGb5uRoNxY9kUgG8JOuIcNlVBc?=
 =?us-ascii?Q?/XZFn9yGuTkMdSNcPnDxgUG2iBC5XVezOUkDjsrvv84ETEGBuSJgZHAL0WQ3?=
 =?us-ascii?Q?i+Ykw7bitDOxk25DLy2TVRgv169k8ti5oZmakmBvwrHsWzTFdVwutHzTrk9S?=
 =?us-ascii?Q?6GHLJxxOmpsql603Jyzf5wkz9F2qjejjP3dmnGpWcGWa0bXUVJ4ZQe7BiW15?=
 =?us-ascii?Q?8zvY+tRNtTyhRqiLPpykkjwkw5SJXgQE2Jy+L9UfMUTTPYplIzAKb4Am/o4W?=
 =?us-ascii?Q?3s3fCv4uyytlD+32VnIkFxQI6yPmP1AoksADtRi6T2FBdH+43oIHn6Rm/7mL?=
 =?us-ascii?Q?jBtsPzzNWDzl8zf0ctBg1byvyO49qPbtO9EPobAU95j3oVmfzgaWM9/IZuFx?=
 =?us-ascii?Q?NdjHQmSnDvod96E05F0je02Uemn+rE/8JDSVvv4dK6TkpK4WKBgMlPSJ9bHW?=
 =?us-ascii?Q?N+0edRWTEOWCyhFgZ2WoEq2BkOBDQVsE7F/A+s4o6VLzgYF2I3N3GMBc6AKt?=
 =?us-ascii?Q?GGWu2MnFpaFc39QZ0dpoZ44Gq7QJHFpdvAmKFAiPjLlDbh6kVJdXTgYEBrv4?=
 =?us-ascii?Q?4CkiIDOnmrBbO0ZCPoZgTn8gc01WPh34y0Trt4jbFhNBX7Zhc8gXVDjfFxv3?=
 =?us-ascii?Q?dZVVknPe2S5kbyLMnPn4tiGFn4sFYzNjuw2tBE3TATgE6F0Dosv38dnZl8io?=
 =?us-ascii?Q?uUE/RZgtcOaMLmhRmqR40X1rqVSqzvDXZK/mDWMsUd96vsa4IZWeXxJRIpsv?=
 =?us-ascii?Q?j3L9m9PmzVWm3P0OSbP6M6tB3GAL1k63oJlYIckxssjrKnY/Hf9fic2KcpAb?=
 =?us-ascii?Q?bu/LE0t0z8ScEvWV7ujYdHfJCW0mzy7tXM4Om7FZPKH0pt90UrNARHSwXK3M?=
 =?us-ascii?Q?myONYs6QQHLen+8O4cmyrOfNBKAC3gdTcue7Y5LdDBGtYNbJWCb1CK8cNaoE?=
 =?us-ascii?Q?A6NNdgkU1ZK6aR+QjRj3ick//VvYudB1aFOp8vtqXNuRFMmZaamVLTzeQ7yq?=
 =?us-ascii?Q?bqe7CVd7PabdZcUwz7XKMMl8/N4bQa3C6E4vZ9KKBxyCHZ+U7BS52yjmi6gz?=
 =?us-ascii?Q?wWUwkTInQ02MIw0Seslj8/O2awyN/QLyaVX0OieLde7PFBbtI1Csb3zxnwwN?=
 =?us-ascii?Q?t1V4g3L4DfutplIrMXvDFHJpwS4oCPxqqpp3z8mJqSJ6UX1itacB9qk6ei8W?=
 =?us-ascii?Q?HmaFqTcYz3c/i7Yj2UYLMOMNrxS57ViVP4F7b77X0pQzgZiiPQsDoaHe9YO6?=
 =?us-ascii?Q?AsPHP8mzOvUQR5SfLWO/D02Lg8LxP2KUq2m2pb8wE4XpIFXSVsXk5ac1YvDZ?=
 =?us-ascii?Q?hw2Vs5rbJmbc5uFJ58s2SxW+TinNpNnScyCnHaCNoDvqeNnTAVJJFZDvsx7I?=
 =?us-ascii?Q?+53dMSWjW0kEQhS8CN9h35RgtmEKxX5mh5P3HEDzVFS0PHVc7plwg7wrXVv4?=
 =?us-ascii?Q?8VdXzjylcZf412SvYcyn43rmjF6pBRWRDudrmpsaChyIbSYhrihc8BErw1Xc?=
 =?us-ascii?Q?qsclBQoo/KDCcmDFgv4cGdSVoNYpPb7WVSBqn9ALWOU6XsRfF0LhJiK5AGq5?=
 =?us-ascii?Q?pz5abUe514DsZ9X3YMA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30e8385-6e9f-4bfa-f9fb-08dc04aed55c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:33:33.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMn5Gdwgvxr5v4QtJ988/bbUe7APsODypX3Qqc75ly0S2Vr4lS6PJhqHcXgtJuVVilP/lkcwlapnZEqtKFl42w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

Add drvdata::ltssm_off and drvdata::ltssm_mask to simple
imx6_pcie_ltssm_enable(disable)() logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++---------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 332c392f8e5bc..588bfb616260e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -75,6 +75,8 @@ struct imx6_pcie_drvdata {
 	int dbi_length;
 	const char *gpr;
 	const char *clk_names[IMX6_PCIE_MAX_CLKS];
+	const u32 ltssm_off;
+	const u32 ltssm_mask;
 };
 
 struct imx6_pcie {
@@ -775,18 +777,11 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6Q:
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2,
-				   IMX6Q_GPR12_PCIE_CTL_2);
-		break;
-	default:
-		break;
-	}
+	if (drvdata->ltssm_mask)
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
+				   drvdata->ltssm_mask);
 
 	reset_control_deassert(imx6_pcie->apps_reset);
 }
@@ -794,17 +789,11 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 static void imx6_pcie_ltssm_disable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6Q:
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2, 0);
-		break;
-	default:
-		break;
-	}
+	if (drvdata->ltssm_mask)
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off,
+				   drvdata->ltssm_mask, 0);
 
 	reset_control_assert(imx6_pcie->apps_reset);
 }
@@ -1385,6 +1374,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1393,6 +1384,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"},
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1402,6 +1395,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.34.1


