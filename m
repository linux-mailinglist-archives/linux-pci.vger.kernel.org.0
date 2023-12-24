Return-Path: <linux-pci+bounces-1343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458D81DBCF
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BCC1F216FF
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FB93C05;
	Sun, 24 Dec 2023 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J+y+xypk"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF5E554;
	Sun, 24 Dec 2023 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCfShrJ3QxefQ8NTNSYgfK+sNbj+QRRoyZLJdfYrt4v+GN3v9vSzUf5+8OPZql7FeDmcE6SfiJzT3hmFJoFZNQ3S0/JYkcvqLqSVq/hwYiAjyaxHNqRq1Njjr3riUIYkyFUh5AG8QAh3ee8OuIqQRq1/ljqXXA5VKaVNyEQtpmZUbjx43tBzSQMyalfVA2PKImY91w7/HT1bV5hw5oawsFRR+YbSxEiFAncLu+TEtE72w1WYhuoi0UjUGaf7c5pstL07oLDim+nSBLtaIS00ohyR9UY8xb++t5MgjHrkGRhYSUfH7coZTfzg+5YbzzyAnt8cPHDBRSaeRmnC7oycbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mwdd+DiAZ3s7dB+tmBXPZ8hiA83HBFxwkXxyNbl3QHM=;
 b=cNnM7hmuSWEaJkAR6MvlltPIzfXV6ouSrwq72HWznkAlqJ3EMokAP4M9TpIf9xAqz9OGUSglevFsXbJ8OEFrUsTehMr+C8zSYZyEWhslDY9qOai1yo9uqaWYInp4Nnl3E4GSmdybEG6VqbvnfO3fyBWyVaxczNJGmbisGni8PpMdyNvvlNJZK61uTns3GvPaSiZ7E1ffELQoxZJDPOVzBaF0fA9jP7+C7xyTQQSKsafc9lqKWP88wOZ6NypreJYR71+mG2iEtFdoEphaA0k/tlouue1p0d6pZmz+undsoYM3xapm8T2jfq09pT9HoNRSLpmYaQh7LbBLjFrDPfpxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mwdd+DiAZ3s7dB+tmBXPZ8hiA83HBFxwkXxyNbl3QHM=;
 b=J+y+xypkB7EBiNNh4gZBqS5Xbf3/rG5K3W1m93/6gXQSCwV27oYpT36Lg4EmeMAzkhtAhIH07BZBIhhHPB3wzkRos20I6qY4oGBdhB7uKxlh8405MIU5H84qtEa42+KJiEQbilwHuoK9H1Y3d/N4KHSFP11LDKSCrO2+D4Fs6Gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:33:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:33:11 +0000
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
Subject: [PATCH v6 02/16] PCI: imx6: Simplify phy handling by using by using IMX6_PCIE_FLAG_HAS_PHY
Date: Sun, 24 Dec 2023 13:32:28 -0500
Message-Id: <20231224183242.1675372-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f19479b4-e8f4-4ca1-95b7-08dc04aec868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E/JJR0ZlKqqOqRtxrLFepZcaSHC5dCPYlyU8P89+PY4PxSwFoV9ghzhLe2xemPIyahe7GUYAT19JzKNuDeGnzn2FcEjpaOhtd0tpjZjwKbgAoh5Ye92IeGgjkjZwrNqmTW3b2+XsG/BE49Z3YALT8LrzTmcS06hsQaNugy3IsZhz3/DFeSm9gabKJYqhQsJvaqqk8eDDCCYeiLjNG+BxHmiSJK6h5tXwIBMq5IQbzL1GsGhlrvQtz4cY+tIPf65xI2DWTxOA7tngq/y9S856z+pZ8KQcvcDRZEvJgHyKyhIY+HQV5hXX8MJV0uI9HGaeQLFIz0m/LeTCJw2CnOTJWEBSAXK2h1UeGFJVE3hb4y4rsQyOWhy2swbU3GJ40Qn6fdtE1HEU6ewZns1oeboef4i/v23RwXsOEgZmG4J2bI1f9gzWYtFW/RidITzlKK1UJmUpN4qK8wwLFjPGcHW37/oz4hGiJckC+uCKpILC3V+pT+q+3/TnA7XNRy94R0B96EPgUNguukgGP3zZASaqh2kbPG3e/RFLdA5HksE47oaVyUJU67grkYG32vjRdjtghA/h00l/A0eRZuXGUzb0ybAJGGqn+ddxuYT8N+FHogaaN5q8zT1HLCht1PDwlMx9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BdiT5AxciPfciKbBJl3FaoytZh6KFjy9DwjH+yiRyV/Nz/qaMhk939I3MXJh?=
 =?us-ascii?Q?NzokyVtpROCWve1FZ8spFu+gDPgNbMSXH+tySY9yyOFcndTAJFxSWYSuNeT+?=
 =?us-ascii?Q?exZraiViLttg0dTTOBBSKimuakrqedDiCDM7ONNEGimBrXxWKW4yLo4jWRlI?=
 =?us-ascii?Q?3L85Ss5pDHs7MoBdGrgc765necERVTyzvk8cjcj1xl8iQAtJHOzPAWjCY9wQ?=
 =?us-ascii?Q?EM5mTKjhA3ggDSX7X3l8piRe/Kv/qfjFThuYPynsTBCSRRJRxnvtZZNPKa3P?=
 =?us-ascii?Q?8Sv1AGdGk04QPdmj+V03DOK33v1FIVJ0HGiI+6OpRFXVDJUyU9zeJQQzuTuf?=
 =?us-ascii?Q?1eC98PQky0XkZ4YWD6D+mej7NSQkx4/Rh9tEZu4zw2rOjfxXNP5OFZ3PgSoV?=
 =?us-ascii?Q?hENAsYJ7MtQLJc3J+HL6cdf5YId+0Ksx7IPp8KhtgXMnUAyWDlgAFryHuJXe?=
 =?us-ascii?Q?LP11+Sa3Gd2MC+WL8TUKO2upvBPDqgbzkR30Yn17DxB1kymQcV/tbqPOhw2J?=
 =?us-ascii?Q?00j5gxzRp/q5rrUhBCE42tEH++yLBo5MJ7hCXMGO3tOEoR5l6z2Xd5aXvBFK?=
 =?us-ascii?Q?/JzGJQNm1jBdxyT7R7ZRubRVGNsLO5xwBxiAaIwGqxIabO9saKfGeWCWI1Wl?=
 =?us-ascii?Q?FNlSvBcZgqiZQyfP/mtQFPllMXuksdiiTTQ/+NVk5XkqtItVr+GUZ1JV+NSA?=
 =?us-ascii?Q?DyThv3LNyZw7eprmfg9aYqpT68gzAETAJDE3m27xOr3omMCQU6ExJA5Ly0ou?=
 =?us-ascii?Q?KYf/gw0boLonxSfuA4sY0oQSES6XFXJAXMHs1Na9QyEGgRIauPndgbmiMx79?=
 =?us-ascii?Q?9ztpNdjhQScl+zoPkTlSyFdGypuawgTGmtAFg+/zG+1xnmS8kowzT9b8XAK9?=
 =?us-ascii?Q?HPJ6ETD7jyFKZOk+py2a6bhwLA+qVbGNrdw75IattBCzcacJvZmm/yCHdxh7?=
 =?us-ascii?Q?HjcYoQGuhDaXBF3BJ7xsC+VlIHyREZ7JpLG+Ab6ST9kyy8W6vvuPhkzD2NbQ?=
 =?us-ascii?Q?LHwKC08+4LidLfcQHkiXxWdbh6wxDRu6CzxSNiRwFLonTtDOmzyNX6uEzxF8?=
 =?us-ascii?Q?yP4QAXkBLBFF09riMRf7IzBpKxn6SVuTrxqWSkkLfFRTxXA8q8l2dB+TuhGo?=
 =?us-ascii?Q?yWYemWoS6YpLQ3ilaLoxPKG9xZALKymY7K0/m4/imtKICzBgaPJblgDqMezJ?=
 =?us-ascii?Q?pPdou40hV4lxY0/i0UEUEv5mXO9aYsBA/JPYA6Osln8qkoAILbFwkdkyf+IG?=
 =?us-ascii?Q?zIH+e92i2EMB8r8+b/WDqEqByBJ5ZDJbr4cSENVblhe6DdS4CPyRcv/LSr+Q?=
 =?us-ascii?Q?aYxE+Xiquga7IgyHxQPVPVZb9KFwE0Yc0nUxT80kmQUGcIowTRfukRO3Gpep?=
 =?us-ascii?Q?vludHDgDxNu9Pvft6XCCeM+yHgPk5V0ekau9UGIAUi0UaaoDaUeOLXgeeX25?=
 =?us-ascii?Q?eyX1b8LyKXiKzGzhT/1NgFmRtRp0fNnV6C1JSzlx8j/lc1kWyO2esGoGHB09?=
 =?us-ascii?Q?5EP9HN4IoCPoRLClmr8TPgVMbC+IJxEpR+m4TugxfgUgq4nXco2Z+TicLgTd?=
 =?us-ascii?Q?zDAC8ju3nPV0n6FADbg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19479b4-e8f4-4ca1-95b7-08dc04aec868
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:33:11.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iY4yq561IsgttOs1jhJl6hn7Erewncnn4KGoQog8T0YfzAzqYKvGTKqma5jyrg8MOioc+l2CaJFlufZ/k7llNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

Refactors the phy handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_PHY bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling phy.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5:
    - none, Keep IMX6_PCIE_FLAG_HAS_PHY to indicate dts mismatch when platform
    require phy suppport.
    
    Change from v1 to v3:
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 50d9faaa17f71..4d620249f3d52 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -60,6 +60,9 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
+#define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
+
+#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
 #define IMX6_PCIE_MAX_CLKS       6
 
@@ -1277,6 +1280,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY)) {
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
@@ -1444,13 +1449,15 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
@@ -1462,12 +1469,14 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
-- 
2.34.1


