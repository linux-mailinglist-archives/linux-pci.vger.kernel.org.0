Return-Path: <linux-pci+bounces-2376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0FE832DBC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30ED91C24CB0
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D02F55E71;
	Fri, 19 Jan 2024 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a6opdY4y"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6296155E68;
	Fri, 19 Jan 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684319; cv=fail; b=koiRBOFg4iU+ynxuSaIu2SxYggyWC776IzV8pjkBRJksQTzgidppEOpjTFfHzyMv5hJf4SQaxcIU6NlzSrbTuSjvCKoBzXQ4UWqhc1cxdF25M1p1++UbCB0IPXEpDKQOYkR9JyYFvCRVwTxckQTStBhdqd7jXa0rUzAFYVooamQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684319; c=relaxed/simple;
	bh=tfuLbcIgFcHc7j++FYuDUuiDZ3JpWIsbttnlS2OyvOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T95aKzAPgE2xZVx56iaek9p6SgVvnNHrhhvFrFjy3yZILajDbLSovnYZEXdfpLMqQtRzK0Su5x3qOy+wxoju02SP6KpwEX+IS7nGZqffmWeFFWBD7FKeQkIy0czuFeL41HnzdfGUIRgJYPGwk8J+Fxcgwxz7jIcRxBbqo8Q5ai8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=a6opdY4y; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6RnWYD/YeHCINQZW+n/ge9Ddz+ayzXALjJwLnqiM+hLTInXatXf6mBEIO9hWzZE1WD8j6l6ZcgzeA8AnFhgqzSIAsYN3KHV8o82Mtus4AuuxpQ9uKYdwlkdhFtMNxTyD7aOzTp1IEXOcC1ZkFXtrQuPBemts1m4N6eXOv5KS8V705sHsTy1tUTLlxp6Qwfuclb4XVEQjsUYVIPlk3SPSfxkyyBZL/iyiqTtbrepunnne5YFGHsd6s/Jh+KDlLGXHS+9iMAyOtZQK+HRBPK7+/vjrwWj3R+0NwOucT8tnRQdC3q3NdOBY9twIKMzig3f9awieqhnVrpJsqwIFDmTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHMPZXiMQDwhqebqwROEQxYmGUPya7OaqiGJ2sdPpc4=;
 b=W9vZKB+csy983DBQ6Oh8TAgbd9edU5H5leRKt54qCf8lXkl00GEByM2QNfYYDAOsjOi39+g1/C5XIfIskD8sthlAEfDj9LBK9BGQJz7qXsSxs2h1kBs3KpAY2U6T1hKPBoOxmZ8fJL9XbIA7pYvtWoiFrv33qi7YF/V9BxoZq6cA/kiKxrYVJhyszStcU4gL7x+UgDMzzcGp4wuWrGiHM+2z1v6q5MWTgI7Psn7pc6kRJSDltd2jepEACvxYclL2TQ1231aCxCJK6l+0OdGG3ztWxgMLo74JpVYh6K9Hjk/+juTNpyC3Bp7uuP8K6JJkVGSx8J7rNelqgT3ivQ7aTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHMPZXiMQDwhqebqwROEQxYmGUPya7OaqiGJ2sdPpc4=;
 b=a6opdY4yK0msxpc2ZmZaGNtNv5E+oWoD/aWDGcPTvzrmSbKYtoWifD1HsJvEfHYklSpK2zi5yMzKMlX8W4Cq2VuZgJJUSqzkyfOvwIpTWzLWiNYwkRm0AkkBVr7Gt8vVJTQBkGQrbvDU1NeuZs25loaU3ks2X3jPe2yynxWYPY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:11:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:11:54 +0000
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
Subject: [PATCH v9 02/16] PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
Date: Fri, 19 Jan 2024 12:11:08 -0500
Message-Id: <20240119171122.3057511-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20663744-fcbd-4ffe-059a-08dc1911bc1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/bJ/Gzpls1pG/P6aa29X+KkCDibWobaq1gXwkDdvvrujreHIotRjzm8osDwlNhHRsDP8E/3PZ4sAMsRGsMUjydJ/4FGFshJlQThYzACAAOv6pcAqHNu1c2hkh4SF5wso/lhlb/je4ojHIed1TSrTIeOMttj/cl2759Ji0vje/lFbuUh32UlBobv+h9f96kHXF23ZoqEOV/IEyOSpzc3nz96edIW3EHjLULJTjq4mPX5NkcfwIGw6kNu26i08lecnazaWiimRA1p0aQZO3PP0ea3KWeI+K5+4qtKQwQnFjmrey6sjawSuhYa3v1oI4AvlkESFJloX/N5kdrWD8SchWCNnoRqDv9g/OaD6MUIQUXUX3fJCXwrEztf/U05z6un3nh9EVWg2+UoFVT4hFCnyTwWtRgITyJkXgUAGvwsUTyqxrJGN0nPexd7TD/InGbzPfe9L2SoIBZ6uI8zNZlzVx2SlkDKg7OEknyOiOW+tRSQalJ2fQBzRsO25HlQumNiEZcXmn4KmHFdyY0A9HDy+mqjT8Pbl6jzbTR61Fh+K/n0cUelwiIwOLq+d1zm1OgAwA90tfI/eWR80qS6keowgMaN0AkycOXOaLuYKcJoZjxBFjJRWEWAW03ErCdJ0zeVK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kMKmIYZXpnauVVooWlZYWh3l5bkikUawcckoE0mgADfkK6VDanYK5w/i1Wuw?=
 =?us-ascii?Q?muDbNYiUOITbZAR65COKYOJL+wDrmvlRyo0+rBlqCsaffA6D7O131gAcPbUQ?=
 =?us-ascii?Q?sV/Ore1UmJfMYfIWU2gDvRY3JzBCCD2JWLRJS1kdkxXoxoREAVKoB+izU1U+?=
 =?us-ascii?Q?n3o47LsmrjpNV9jktLdetLKSwyzMzwESjjO9ArrB9AKi5IovdJ8FJKbSY4fS?=
 =?us-ascii?Q?dVDCx8BjssfgBOl1y+reu/8dzEtRsQbXo5fRX5F1wOZrVii2phwZaTz0Qetb?=
 =?us-ascii?Q?GGQs1BjgbDOgvCDZSTcolhuBiLtI7NP8c9jNbN1DelMoo+tT7P4S5mkjpsjA?=
 =?us-ascii?Q?IZjlgCFUmpQP7+6a6NhD67PFParA7P3Pz6c0ER6pe+fbOGpANQvvD/4Uzslu?=
 =?us-ascii?Q?EhP2u4JAkDXsrmzEHOWcqaSV3Bdkh9vsq3l+b0G7S+JwLlPhBJ+JkBd0I9XP?=
 =?us-ascii?Q?24SapUWkEfQVqT+bfeURfBWKdyTFsUhzul7NdwDF3LGvipYwWQUJandqqoMJ?=
 =?us-ascii?Q?uPE4NEJW7OMaT8wkXn6Zx6h/F8Iu803VDaKXo2Kzyk0xXku7JOZGAFYum6OB?=
 =?us-ascii?Q?wegwKwsAuGU27d9UFfDW0mqXdFAbMdjTyyG9hUOCWd2Jbos5nLZH0ubzSrRS?=
 =?us-ascii?Q?7A2t61+kGPLYA5ZBDO2O7lo8aI2UPIRcUGRAnsv9yNzpYQ3j5oUXI+Cd6Fi3?=
 =?us-ascii?Q?zU7fbg6IjF83qg9YLEG4YzANgGSA3yeilL/eax2+DEQtMFNHagQc9BRmkD+I?=
 =?us-ascii?Q?PsRp/VCbUk6+zkgQhKitbKzZFmebQs6EJCYhN34o+duKAhTT0jN3rrE5Ffeg?=
 =?us-ascii?Q?jKb/uMobm41ESDwYr3gVYk7uDBQOy7RLxwl3vvEi8jV16CCEAdoPKVPC416D?=
 =?us-ascii?Q?dJWoBstL8KlSiGaLnpwGm+dV3mDEwwj1BfFB/O8Mjt2A9/dw3unObEdXOdBx?=
 =?us-ascii?Q?d7Vb+ncjptbJAcTIGgzQmIY0+xW7JiKHdLis8nDoU7dMSNF8qNZ81z8FXhKA?=
 =?us-ascii?Q?HmtojSK0t+mxqldgYqElqKlmfeHAiNLSGCAkO2/n4ODAoZ4IvpsHC2M24Zfh?=
 =?us-ascii?Q?d7BY+r6zZ9a4NhJwD/SLDmPyUrm3kbvkEee33UVrbTXT2QJnv8Lb2tEKkaxv?=
 =?us-ascii?Q?0rsuUfy3YnUTk77xQXf7eKVKEA+c2giT/cQ6GYd6CT6rqrW35VybbCLO6bzv?=
 =?us-ascii?Q?mkvPK+PQ32C0XTDmOOn2XjSUKp84OggqWAKk4hhjkacBBSXpn66QPQnSXIMU?=
 =?us-ascii?Q?MuPyGz73UAc8GWJg4Zw76alDWl9HUEg3VC2IKDJ3HuD3mhyWMGqJArnsobiV?=
 =?us-ascii?Q?1ICrc+7S/NXQcnv9b9oKsoNYNY05fKC/uAi14TpuLPN2r3wcNpNMhG1BMpVB?=
 =?us-ascii?Q?ovRjOdg175e8pjfALW5e8rbQLqwQ5wHvnH8kIPG0gkFFdjC/wK0yp2jBStSD?=
 =?us-ascii?Q?ql1chrnkRhgu4wP1MlVCH8SIARlg48dzMvEMHAgzhjWI1R3v3queGPfCIZ/k?=
 =?us-ascii?Q?m5JtZ4sJNLr+ZTio37XmzjKS1ZGJBnuIRM1fHBqf9qw5+0BLwn2u5QHiTxub?=
 =?us-ascii?Q?vWOGsMGG+M/GaFcdeeA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20663744-fcbd-4ffe-059a-08dc1911bc1a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:11:54.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0RQtp2+AUuPUUQNyNlncGAFHNOz7Yr1tUNZTe674/Rta/dKS6B5EYoQGgFRvazpg/YxzzH/HyiFs0UdHnsMvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

Since some i.MX platforms make use of the separate PHY driver, use
IMX6_PCIE_FLAG_HAS_PHYDRV flag to identify them and get the reference to
PHY from DT. This simplifies the code.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9:
    - change commit message according Manivannan's suggestion
    - Add Manivannan's review tag
    Change from v7 to v8:
    - renmae IMX6_PCIE_FLAG_HAS_PHY to IMX6_PCIE_FLAG_HAS_PHYDRV
    Change from v6 to v7:
    - none
    Change from v4 to v5:
    - none, Keep IMX6_PCIE_FLAG_HAS_PHY to indicate dts mismatch when platform
    require phy suppport.
    
    Change from v1 to v3:
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 0997dd7d901a4..a33ec006660c8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -60,6 +60,9 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
+#define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
+
+#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
 #define IMX6_PCIE_MAX_CLKS       6
 
@@ -1277,6 +1280,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHYDRV)) {
+		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
+		if (IS_ERR(imx6_pcie->phy))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
+					     "failed to get pcie phy\n");
+	}
+
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
@@ -1306,11 +1316,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
 					     "failed to get pcie apps reset control\n");
 
-		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
-		if (IS_ERR(imx6_pcie->phy))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
-					     "failed to get pcie phy\n");
-
 		break;
 	default:
 		break;
@@ -1454,14 +1459,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
@@ -1475,6 +1483,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1482,6 +1491,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
-- 
2.34.1


