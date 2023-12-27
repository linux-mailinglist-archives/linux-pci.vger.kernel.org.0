Return-Path: <linux-pci+bounces-1458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F181F145
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3A81F2181A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CC47F46;
	Wed, 27 Dec 2023 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CcjyTLLu"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C83487B2;
	Wed, 27 Dec 2023 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIbEh69gWqweV5G6+bEeZXk2ZgGevcDrQRNWvGaBZ6MtGdAYbDia+IiwgX9UXIDVw08p9m5ThlVd+diFqiWmiwrpEu8Gsy4p5UZvThyENuygi3wYj/ltWGUxiGof2WpF3H/qr8piD3BTICFfzlvT7J03dq2ZHn2mOXFP8D9hgT/GTHKRnLREzH8/A5sMJW1wm4HXFH3tkgC/BDfWaIiAnDO6qSyh1MFuEaSnZL04UFlj58shKvRvM9VagzGTosT0ma9Gw+NkVeRaE4+CAyYY2R3XnTvogu+HG4XWjllU8hQuKZPOlW+p1eB6sSzcSbSF1YDBGdKCb/Sd9j8dCWPCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0z9pcHLjdXiH6wD7qmDtLqSR+u24DFRcxKpgzuOjSs=;
 b=kkjvfnQihqENodYxdoKZOgKLXwc13Zdh/DvG7L5UcheQDCFYtlGdLFbsr4nWwXj4WsSs/OyKjcOjGLm39bPh67xAOj6MR6EbRPUbx4e2kaxCGxKO9dFLtKc5jbWciRhSGNK3ZRheVyHr1Fi9CaXNhQT97aXRdTNHrqmI4IUc9o2ftKi5MxB+AVAomIo2GQ5NAmlVW2bfzXsMnnaeIQr+F++PtsT3Y3MNAQiGopyKS2njgxRIVjkauFkfaIjBhW0OtStQFGuE6sXZt8sIlZ5nhDTzFRxlKoBhhvsuMCIYPaM3vJt6Va0AnghpXJjoj+oMkTbanowKDJWLyLlPA0xMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0z9pcHLjdXiH6wD7qmDtLqSR+u24DFRcxKpgzuOjSs=;
 b=CcjyTLLuSXTEDDmh2UF5SplDgPTPg3qv0RBnCk4w+/cipjnIsUyCF4jksFKG7Tq3OOr85NF14+qpTYG96ogS4d5GuFISU+rdT33YVfK+FGCM3cv1Ibl9tB7eMT47A7+UzE7xoUGSWy+GY8sJwpsYCHJlBqMXT2QB9K1DOUl7qx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:21 +0000
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
Subject: [PATCH v7 06/16] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
Date: Wed, 27 Dec 2023 13:27:17 -0500
Message-Id: <20231227182727.1747435-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25d55067-661c-4e20-c793-08dc07099abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zvIUMSX+RdycHrhZIghNCc1SVBHceTSGD3iDVND6bBiP9CG7M9sn7FdpsvExcFAyl0kW/FULTYDpUhTP3+vQbeCaKS+OpdtNspLqKbJjXx4MyJS1UL0SG8kgT3LFQ4KX+OqbSyhEew/IbsOzvhJ4BAmBicFPaBk7LFocD9rWjdx2R5NTaxAdHNLYESeGg8AVxJJbUUdFtoNJ8z7LHqAtQy85y7nL6VDsnNXyo39VDn9qE+YUPoW0sFFkxuKn6SHfmvbCXF7nccDGZjL8focdeFz5rA32QTQFKEFWAuLr6z5cLMe4ejWN7H/WN2ioYASbKrPwpr/Oi3efIENEz9WhWaRkzL1MOVYRHMqgMl6MUGRl0MIMG6TTmaWac/ZzQW35HDe6O5dsd8E+7eUI3iRMuvnwgR7foJxnxr7X4k1U9xGUd+pyrlNCL/Mi9JyB/ARD4LW/lgJXybEafwyZ23e9sUsnah+RECqya+CmZWUc/YDTbROZxbwte0w9kutYaPjzCpDEjvv1Ks8oygPyxhOAuE+kXtOppL6MhxdTP7d7KUCLRCZFqB7MwiHUfXXrqfoAp+dZdF+zv2GPWpArsqyMCe6AR04U9mWUi9QIOw2spWajlNY/aHG9TjwpFs4B81rL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TdCj42iROTYpVDoq+Hlt1mSW0vH2GoHk/lfSmG7zEE0FyOZLaefAHKsVvLeV?=
 =?us-ascii?Q?EylUhFkpkpKwIX/KJ3iwM3d0F7SOp8hPUMNaIob2MQfzw7PxSn+hq952qXMq?=
 =?us-ascii?Q?qOvvyfCUANqS3HJdgwHCJbJDNyVjUc0C7FDTcVjDeceHdov7dvopdtjMPxx1?=
 =?us-ascii?Q?aSyISc0jVpAxF8K8cSAGuVYZwATh96gYGrq+XHQkPZmhyEgT6u1GY0876RTr?=
 =?us-ascii?Q?WOyLX4CDZ2PdYlyYxtjy3WtvwDfzW2bmZAunphQwTqdeksXlSWitoJ/ogPvJ?=
 =?us-ascii?Q?2t1exq0LjhpsSWZuH6WY2czOyPk+10620uNqhLftTJuAbLvQk+rs/3yi0iFF?=
 =?us-ascii?Q?fHjiojGL1fJ0DmvDOwo53aAiHFzGMnfZrXlSi1/tulGBEDQ0kqWyN0nKhY6M?=
 =?us-ascii?Q?whA/7DsFWy0oSSNqm7OaMocF8KXgFvjGg81kUfM8cbwBOmY8bkfax+/aMiNy?=
 =?us-ascii?Q?cBhe5u3TGT+sqg4VYoyrLUmGvZgnt4T495L8j6ISxEjavXfzTcSRVp55YKil?=
 =?us-ascii?Q?TTcDKSqbdMtRiwAdrEttleeegNjli+gw2sCHpKh3/JEdQXjdt96uRYtllTBq?=
 =?us-ascii?Q?Dbf4lHYY9lnmp+y4RfkLmZonKiXlV88Y5Pa6/HYql3rX/NHwxA64uWldLUVj?=
 =?us-ascii?Q?xPrbJD+c1vplfLBGx6HuMLyTtnaHmY4xL8wpgES9OTDfuAMHRd5OSYeB0pse?=
 =?us-ascii?Q?jJ43D2+bqbbrbss73quWaABStXW3oHKcfpoodiCcOb6D/OdEP5tLrNHvQWuL?=
 =?us-ascii?Q?lRKw3zHLfxqWHc0QLEYloujpTcoGNEHnoQ8VDLafdNj/ac5k081YEpDhmEuN?=
 =?us-ascii?Q?twEx+kz3at7foeWKx3ikq1J3uBhT/sZYU05nfgrlFuojLbQoUKzV4gmnJYSq?=
 =?us-ascii?Q?Zvmlw9ucrqjZ82Gssn+R3m+TAQJyEouVfJO22JaF2N6ziv/LKsWJq5hGbGPc?=
 =?us-ascii?Q?7gYWxRDir2dUfz2D5kzMn7LeYSwunNLg1aTFTMPoHtwmwteGfUMxdCVMiYVl?=
 =?us-ascii?Q?rAwwFrMek/nbMs0iRV3M4n2Ww910SWgoElPaRoSLyIV3shiSYdRZfX+Dwf39?=
 =?us-ascii?Q?hQuGgG1SU8aoNtwj9VwvGhvoY6sgZrLRDwBw05mYkPfrGzhTgxiQFEgycCqr?=
 =?us-ascii?Q?dZ0RfQHdcw1E/K3xyIW0lOudXw/FA5kPiPSBt3cdTDmcdMm8fOfxmqBu8Mir?=
 =?us-ascii?Q?MPjAVg+n3Q9Q5KuQofmv/apQPDu1rl/ODoVevyvCP4EudBc8jcXBdvyitkFC?=
 =?us-ascii?Q?hQzPrC6kMbecgF0Tzo3N7yV6s+fS26tYqr8xa79pc5nCQCAYU/YlyUO6XNWn?=
 =?us-ascii?Q?1fyLPdDRRJY5XelTcPD6wmzcG/etudmRzPTtYhoZcozNnPpy1HnuVlGCcOOQ?=
 =?us-ascii?Q?0YsJc3yZzm2CjVCJKg65MZdkVkcF27Gtu45ZID6/dbMyRPg7Z9Yk63OCyKrV?=
 =?us-ascii?Q?SjFqe726LueJDdIx2Q8GxQVgM4xtLtpvxN1Ajj4dutTA+gxLApL6xY94pf7u?=
 =?us-ascii?Q?lI2eQuNCm7oG+NVEHIjZRBn4hpApsK4o0fB/gC1vEAa6F7CeoJuqZG40Fkfh?=
 =?us-ascii?Q?0YS3oPC4XOcTRjsPCnE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d55067-661c-4e20-c793-08dc07099abe
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:21.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0dc1HGVArmJRONNA+T5/w7vrVrrLtvXwQzJUjuvLQiPAwSDLOt4rQ0VZCrySe7qWg4OaTxMHISE+WMFIzgebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

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


