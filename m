Return-Path: <linux-pci+bounces-2380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDAD832DCA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9346E283891
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F565786B;
	Fri, 19 Jan 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i8z4gw04"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554755E69;
	Fri, 19 Jan 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684339; cv=fail; b=gS/KR2X40u9zp6Xkn5GSYiHYRUoMccgZFgzUTRGj/VuCXLBoEmAOCveZd1mCPj+7Rvu1HKfJR0Obla5sje9z8nRwlU2gWIYIPPi7lanbSTYhDwFxkNFxg3XVo5QOdYlz7z9B87jh+sTjAK4H3S9zQ+A3HG1TYtNfmrzSw2ac7Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684339; c=relaxed/simple;
	bh=h1orblFhLYQ8RQAO2+kcsj/uiCebOJfuN5yDnsv7hX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOmfew7JbbMCktV1KEB0o0pTzOcC8UvEeoZQGw01LXQ50YqpGdW19cDzlXAH9h4ruedobR5x3Luwpgq0z5M9MGJaxVCeV+t75UEhZkrmYSYMJh5i+nNnMI8IEksD9C0mMzYLvdf2rEi0lM6Ncs3158HSYKchafAIoS2hc9zPWPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=i8z4gw04; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmlIWKN8cQnNZK61pZfrJDm/6kiYvTdPjnypcxnMBNJ6ncpR0a3Di/OKGlKgpXxXtW3LLALAHlTRrsXpcncUkQ0ntukuL4Cw1eAQhpInIaYI691tJ2m5g58z4bJBvoNCJbdPBj9d5fDaPxL88wM2fFbUUqTA57QR72C0qKWADx0+ONicIVfsBPhNbfwCut342sPcJa8Hp5t9x7numbxxEnKcQt8WtK3C4ifvTZ0GgnCcmOBbMdn013eFF36q+KXf+mUMICFalPm1nMG8s0OEXPw/sICLEqoRqfjme2q0lmhaHjp+O4E+kUa0jkaVood4bWpP0cfm0ihShWJDlrErLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1ml1SU3yyGgsAgBwKUHD3HTVAcSOfWRmvEJtlf/ZfE=;
 b=NrPID1Xdi8MRMfKGaUjaX+uV/Y1GTwzO1xEo8E6YIUZ+bXEL+qwtmU3YnK1eqd1HXZn7h/Ig2wBZMdWVO6rgktkYi2aikumkRpboAcXZiUTzHo8KVFns5FAnSbLbfblQ2iru6TAtJB8qRQVlA6UMvh7pApE5Ynt6/5yHQJhkLKpICWljlAHLxhIuPjhrdXIjeg1wEqWP3c9UFa+Pb3URtgQMkKv0CHuTkRJhGhr4AcrQssl85ToJqHrB5cXBBYVAcrBubH+fbbxya66ME2fgfP/EHGd4XlXpHmcS34h8oo+qNqPQ+rg62NO5Bg0d6VpqmSdAhjPi6dUG9as2/OGdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1ml1SU3yyGgsAgBwKUHD3HTVAcSOfWRmvEJtlf/ZfE=;
 b=i8z4gw04RY1QQsDMCAPNsmYAmkMclRxuRtMUDR3ezGAnF+lnhhvcF/7UrAjzMcZD6rPGUrpoOk94pq/R4KOU/A5mLD6491WEyjnH2Q8FjR35H6/eS5cq0dcn6TpqVK3LAHfKOH4bmr8KqDyCVeVVi2Wznv+IPy/vYBvo5rMV5m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:14 +0000
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
Subject: [PATCH v9 06/16] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
Date: Fri, 19 Jan 2024 12:11:12 -0500
Message-Id: <20240119171122.3057511-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119171122.3057511-1-Frank.Li@nxp.com>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: c61c5fb4-d65a-4d08-c0d6-08dc1911c7f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RUnUxF9l4ozSDpWjGWbCBC9QcvTBLRgNUfoH8FlGRiw7wo0kqMroFQQvqb1EpYptP3ysindBTK8YpLoTbDQguc045q/vNU8kBHF2kt66Atcvf5Q3Du6nlZ5aaWkweIfKBYxkXyRen64yy34luszX6Y6AAy2k8D46gvclodNZ9R1tmWau5kPqjl0l3S95AfoOXZHnRGfkCcprHM2TUuhqRh0+/ErEwNqdjM5lmgmWNHi3dKDqkGxdCPov4T+5xS3KyEnUnxU3YAM13RYL8jyxXFznFYOPJ+SF5L6gE/GZOAvvuyv8UO0TiKvchaKTTtfNapPI+j2FcQeF0ybZYi8RoYTA3fpE3FYl0uvWB1qtGrp0X81JSn5x1wr6rJxNNB7sRmr1fUmAuGLJaZLDoQwjxaXlSZtSM1XvDZn4gl7ieVIyy/q5s3Mtt2GvDyT6qTGFb2TrvTohsCBeJYPwKUvwO2V4N7VPC6Nn4jbFJsx8d5wLovdfUSzHj6jX20uQvKmq9R99QoBIRNkRfwFm12nGfo2Y4gue383KEU8v/0HeshXqrbAecWEaBar59wFIFjeDVaaMX+or312vFPwlRyG21Mh6HjKW5mQvyDVH2pmcWCed1lCfGv6UjUEHjPR3JHl7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hKqC+9Bc+D2dvBbAym8XKcWc9FPwVaXiY6WUnYNPrp6kEvp6TVJk+S5RLEZp?=
 =?us-ascii?Q?TNpFfhmEHGUBWlpo79rBtWDy1hmoIXPWybBGuhmgw29pQlr0bnm4HfbFxcZd?=
 =?us-ascii?Q?dnNvtkDYMlCs3NQgnUvrl8MuFQAWRubeKXAOkY3m8YJXRIi2BenAZYmywV3V?=
 =?us-ascii?Q?4WU4evQU7PFOTkTbTSmbe65cN7a8yuSXukokir7v7j+q++e7f9Ck5ihBcy2C?=
 =?us-ascii?Q?W1jWUe3ibZehOqeOagZSaAsTnW2jGB2PpBaSJyK+momnPxUjVQR7oxZf7RMX?=
 =?us-ascii?Q?xFTNYgnrAlWrhUXA8oetsJQg1dV2nQzLczH8m65EdmZO4m83vTXOKHQys6Ko?=
 =?us-ascii?Q?RLGYQ6bi4oAqjh5pzUQlw9vWQ3tRIykBglhNczh6VeRWjxZLQMhlKBnJRZ7b?=
 =?us-ascii?Q?Lw0vHjovjFsJJQcPCaWXeqzKSB44MF1Qebs5yw9RMpRlQ2wjrRsGMl2GiDgs?=
 =?us-ascii?Q?IS9jRYgR4hEn6qfzsKQww1yGyC8lejlFUpi2OszfZa7FbT7Os0Gcm3oab1pp?=
 =?us-ascii?Q?bSlB7iDefPCGYdmFJW6XkovEtJ/Q+CScv3D5XCWfQpYOUqVoVVcvuwTfPZHH?=
 =?us-ascii?Q?GvN+BL/7b5mr+9KRZvlkbHz1YLGFIdO8T91RwhbB+Hty7/hghrUzXPzwcOjs?=
 =?us-ascii?Q?Y63ZXgUPpHllGDQa2u8O/WLbiwllnHqcHLqxfQ2Y+10Obz/oV0C1zgjN5vat?=
 =?us-ascii?Q?R6Ews9S3Gjfsb8JQcBbgG20Yy/tFc31ePoTfoOfzYiRCyyrtFMG0v1UexwaR?=
 =?us-ascii?Q?KrzwYaBPLCFmQRfsMaapFccrhkWMq+wJo8QONXdH2ut9/aPcgcOBiSJqFVJE?=
 =?us-ascii?Q?ZNnhEtkVgLMjPcoImPxcXtwtgtWU7v32RHYhtSTPQMzqmkhrQdZ7A1dFRbxd?=
 =?us-ascii?Q?jRFvb+kiSfGbWLHoEf4e99b2uhlPTIvgIfRr/BhPSW4yCNajaXdeDXwpzMyS?=
 =?us-ascii?Q?Y5ozr0Gbqwp1zCwU2tKKQFnJHijTeD9tqHHRnpxfs1CLMorBZBWx6oWCaZN2?=
 =?us-ascii?Q?NSqUqKXcRM0+N3zVFFbHjOAZF1c5xv0S2TQrfoaBB9XIgcMh41faiAiDoNvM?=
 =?us-ascii?Q?S8xVXOe4b/K8Yk/m9TVAyKmBQ0wELcaoTSPfvykbTeQ27XjGvf+IVGxzge1g?=
 =?us-ascii?Q?J37W0xvjbAUtmLCbgu+9FhiRPepf7+iAi7W3JiErZPSMm3aElbeZFqSyJSue?=
 =?us-ascii?Q?hkj9SdyQhqPpDxt7hpgDzXZ/Z6LUotqvdJolc3/UtvcwTSUnuwaCrwttWLyY?=
 =?us-ascii?Q?b9Epdf/MMiZrB2gacjo1ZaRPCx1p1pCU5SHkjxoYAsRY28mDP+/kAcF4WNy9?=
 =?us-ascii?Q?mZySfZ6/otavx3jGvlmnIZchrvdsKJInrYTy5wuW0+SWhP6RUlCC3EI2jvQN?=
 =?us-ascii?Q?iLN7TdiNGg0EPYl03D4jIUi89D3llGVjPY2+b+fNs6ZdQyDQykaasO/nXkj4?=
 =?us-ascii?Q?7wn64VuOLazYWo9hEVLhdykuRPrXUActG3pg1ZGtSsW9724iQhWkQ94+RXJF?=
 =?us-ascii?Q?psrVHWlOTqfPU5j8ZuSnjyyMsf+FDJTmNAzzg7KMQh3hTBLFr1EhQFndlY34?=
 =?us-ascii?Q?SaNwajKcbiz+lazIf78=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61c5fb4-d65a-4d08-c0d6-08dc1911c7f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:14.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcSeyhrAt5B56xPfgbQ0wZVmJB9+HiI53bNcBurNpe+4HAeN3ytq12Jle8S+m3LDYdrIEOlbCwXNUnptoCbjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

Add drvdata::ltssm_off and drvdata::ltssm_mask to simple
imx6_pcie_ltssm_enable(disable)() logic.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - Add Manivannan Sadhasivam's review tag
    Change from v1 to v7
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++---------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 773411d20329f..d19fcb54fde0d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -76,6 +76,8 @@ struct imx6_pcie_drvdata {
 	const char *gpr;
 	const char * const *clk_names;
 	const u32 clks_cnt;
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
@@ -1394,6 +1383,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1403,6 +1394,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6sx_clks,
 		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1413,6 +1406,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.34.1


