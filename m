Return-Path: <linux-pci+bounces-1238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBAB81A832
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74691F23EB1
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FA049F66;
	Wed, 20 Dec 2023 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OutS76Qy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7224BA96;
	Wed, 20 Dec 2023 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLOafKAELM3S2Hyz+0/C9kDykigIpquENv/S1wmWtJ0BL6DusE0SlMLCsCBG7dUOTqmqBrxJr72Pum7nH5YZPq69A4IAMHqUBZfUv367f5AWz0+GQ1+Qpmo7gnevck1SHQJy8kPkmDYzyn7+Eds6FlXBGJk8B/UHe8Gnxzr2AKe9QZAZE55Nh7FJz16lk3KgH3RbtJcXr/1r9zBhjyTGa9XmMP2VDAj03jfhb/ybsErzWs+I4TxxX48gK7F0nVZHlEGGdQIDzwwMMAjfJyfTJKitaaH5riurVEwj4k1hYOgyrC9HrOjOxJT1Jw8W2D1mxFLI3/WCnIuPEjWuYdw7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0z9pcHLjdXiH6wD7qmDtLqSR+u24DFRcxKpgzuOjSs=;
 b=hEkJEyhhI8d4hgocvL9gfPXwCYw5MsgsUt5VhNBsFJXX23i/m/9TtYz/82e90n64w1DFeN/ytubtU3yykJ31VQbjDbA9zzIDMLdrzqjbHkbomoZzBZoeY5DOVYct+JcMXnuZ7rz4u/1tlnY/ShwEQxLJF7j7WhK/XTWJam6uyqJ/F74TTt6yQfSTNtsGiR2PkS3YF/8aXhlyh0zJ4O3fye6VuPpj5H8Q1WmsUFL1BZC9oIXyHVxVe/Zb6jeZ8QBZKYDzVSOCw9x+XhAIXKUYKTCqqyj6rLBjo8QxY7c6YQDq1EwBGFSdwhnFmrBPuSpgjj+gmKEzvW2nc6DlprXriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0z9pcHLjdXiH6wD7qmDtLqSR+u24DFRcxKpgzuOjSs=;
 b=OutS76QyjVIbZxAdpZ7dlFH5kgHmktNGbG7NIhqREM1TQOdZbMtRH/G7oY3o3CNXHzTSPknTAca1jD1RNt5nsASlPt6EDu1LjLrUOZwIdINBFAKO2sueDuppKagAOODgaoQAtybeRImoSIhiCJBUtqOmvp1ShzEzFeMHO0s5tp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:13 +0000
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
Subject: [PATCH v5 06/16] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
Date: Wed, 20 Dec 2023 16:36:05 -0500
Message-Id: <20231220213615.1561528-7-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 103c397e-e6ba-4519-99b2-08dc01a3d437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qq/4XHrDuA9JvDGwZLS3kf37KBXuC8vqGzhqC2hXg1+qJecAr5DLVVYpYUUPDYfaCaOuucnugeeCK3mw+1YUWnEAFLKKfZnW8fL8fZHlFLwYhAlUySTkjHUG8dHksZAzeahoRBvdSEPY3XwbiZ9sTkXLenwiTWSqyqqFfKGfMkW4rdSbZunopdanApchTReoT60bsfh8XhBmaAEy2vlPuHQk8ZpPIe2phLXUe6vQimA/pRXQNg5I74EKNQ0qShlurY0dhTmNefMBi67Xc8JUr3YdCaQe38mSEUfzoQGUBpdFyuGVJmpbMfQ3XvzrnUf76YCEcel4tuhrVwqXuaPuSw2Dlo+fIM4gYJERWoUjJN8f/3IN6b+1tEqcS2jTbmkVrWdlO8RmcBXmsQjgwGIp/IOYr8uoMBpNDeWiZ8qmoMwq137+7tYRPej90Iyx4zSzy5ASc4mUBVm6eVfMaIjQ9AA70YDRISoQy03afVSg/lb/FaS/bdGeuxiWGLYNCSR2E8UooHxd7Za8q/6q/XajzL9pdN3nfL1iQUR84/asY8lhGvKw2FDs5SSxoz93jTdLULlMCTduA3kRrJO4p6Aiwd66qT2qM3d+p3R2ZFsDk30+mCnIKbwJYz25GBPCZWIu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rkns2CSZgmpIMwAl8SGhMCVK+lBgNcLyWVY4XRpl9Mv2Tl8VlTrhP6FmukZF?=
 =?us-ascii?Q?Gt6ZG4hpxEG1+R4kNc2gn3fUhZWa/hWYFVJzG7OUQ7vchWgoWVCIukRa1aLH?=
 =?us-ascii?Q?z1ddNB6XBySNwfFWuUKx8RSaJOpjc5/8aCBWjDPTQ1pk53mDrOFlMo54u0rI?=
 =?us-ascii?Q?hbJpa1yDkLb+VWEIQAXDexwP+De+eUMgc0wqLwOwDR66Efsaiv8LJustZHE4?=
 =?us-ascii?Q?KFssrGNvzyBuF5cFmqxS1zkkMABsRY3j9BVkGrlEFVzeResiLd6Pk54UrGV5?=
 =?us-ascii?Q?JUiv8vtLDOoIhWbZI9Xvwy/L1xGBZ9CdR33Nsybk0iK1dAm+RNWyDM5gIYaR?=
 =?us-ascii?Q?gsk3H6+oFodrlJWbqwl2EToF0oRfUg0xEBcjlXAOo8AgbA0y1ukuWIEd4osS?=
 =?us-ascii?Q?n8zhxng/NM2E1qIp/KQ1AdW00bUsiTlaeJ9/BNzdfGilnnKKoNzLutDG9d4T?=
 =?us-ascii?Q?BkhP7h/gVykkgRkGr06Ua8m0uswyFCvNbWdKFeV/asQZz2mSodNEWhF/Uepd?=
 =?us-ascii?Q?NnPxEWNtdNKi0AVSB45Tfur5uoce9KCYM0DIdadM/8MO4VGflkK3V5ibmCNE?=
 =?us-ascii?Q?+yqXVdnWBB/BmrGBp67s6TEsdWNTFSAcFroB6j7+TdS7PVktitj9Nm1yQLEw?=
 =?us-ascii?Q?pgEPBXVAGNW5MdHIHNYVtIlSlURGHve0ZaIpseQwlL7mRM/xcxr1f+ZL/snu?=
 =?us-ascii?Q?DB2ZABEqva/K8fCWixVJQQSbuhwPjRgUbsBICMd4N1sDjONJi4M8ivvrJSlQ?=
 =?us-ascii?Q?mYvLaCnB9VGJNAcxQDaut+Z3Q9pAUBPSi+e0+6dyxwJ07CEyeUNIWXnsh2be?=
 =?us-ascii?Q?YpHW9UoOL6aPdMmo9phXQIwPp9aP4xu6S7EEgcZO7gnYehuR04VaRD7UEfUz?=
 =?us-ascii?Q?kvHB5lPvXXO3wYmIUfFgaloisDt1OixGpkVnd/WYqxXpXzU4pnLrQYZ1He5j?=
 =?us-ascii?Q?nAIM3ZBHiRa+OKaPR2edR+4wIOljnjcaEDyW8cyNaOEk0HucEY9NGPFENaMg?=
 =?us-ascii?Q?cJynxOyNEHJK6IymJLyy+UBEvP5J6hgheLHgfxT28lKgKL7vvry5S+I+Px7+?=
 =?us-ascii?Q?qbVIj6He4PWJm+3wpr7b4pL4jbfAfND0lRB9j8HeSof+rsEwIyXDunfeLyaD?=
 =?us-ascii?Q?CNjxaGmIf84+Xk3Vzz9NJhlWeQ/XSwYPnmPrM2NTM0hGHBBZpTisrNT1LrTo?=
 =?us-ascii?Q?WN0fSsOCweNRwogFv3FpLUjCC+c1jNOkXM5fiw0VCB3nT/6+GTSv/iRrkKz0?=
 =?us-ascii?Q?vCGYkQWhzZXMxIHbHAYREwYa6OQQynq8YeIJ0HkDYffiaKqNWt/kElBC5U0d?=
 =?us-ascii?Q?a3owC7SnC8mgC/Pwf/F6AvzLjnT5qjZOmtqi1YiJwkkwbic7M9wyFP9Zw4Jh?=
 =?us-ascii?Q?UCSrznsMP1E0UnJ37YvbWTOSPFq+SxP7PxmoE29hborRwgu15RfTWy15uAaj?=
 =?us-ascii?Q?TWJcqj3wAebLDKQbjojO1edK2vPy2++ri2fJqbpN+djkveYuhBYAyxv6h1FL?=
 =?us-ascii?Q?/wSJ3uEs4Rwg5eopojj7zbHnQyG2e/BS+ue9oQASKuzuSKlpKnD2g8XGx3+D?=
 =?us-ascii?Q?mah6GV5DTYCX7W2Og5M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103c397e-e6ba-4519-99b2-08dc01a3d437
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:13.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOmhBEtNB0uz4IyOR71F9MQwwWyWYi5KGrw4SfqiJZqfJRs2EPYH8P2ghvPCjn7uCbjk+M1is/qYVPXEqs1rfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

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


