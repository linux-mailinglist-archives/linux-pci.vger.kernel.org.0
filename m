Return-Path: <linux-pci+bounces-1113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DACE815D93
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927081C20BC2
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A61E1863;
	Sun, 17 Dec 2023 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BJLMBd6o"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED8F9D7;
	Sun, 17 Dec 2023 05:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb44rV/e/LSoWmqMEvN7cFMEf7KgAdwB0peH+gL4DqG5EgN8SUWkSxf/HiU+e/XQsjvw9b3Xe1BR5OBXVtMsAIXzaYb7yQt6OOLhyG8oC4Zzm5wuInAR6pTzj3Kfv5uRysBKdOL2c8oS2w9PnSbY6JBncTkPnoy64jxqDV9za5znyXQGRw7H3GeVpO+Rqhs1UYaOpuZq+gHlYSbcmxR/a6Msr6enRtteltyQ2IuIIoZO52l2KPEHnuvYGZ2ioq8qfhrbaXEDgpY03Tu7TJp5+X6mWexij81XHkCCQeAo1xRRiuT1g4+VABzBoowdmoN60Kkx1to42QRz5JzdVj/m6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lH9XKua1yFSuVuY1tilgXJFmUjpUWTKlp3s728XLZ8=;
 b=jrwDfho2VLGzgyjKb2gV1sc1Ane9raFtyrD4xquWzYJ0BWZ+f+UZBZxiwXK9nHTjnqg3KNfrBS6sF2mg0EfldJRrQTwYmrmJf+CJpB1+htAXcEO0adt5V2k6qab8D8E0bw1WhhKMzyN0bGr5VvcCLowwVGRQHam5uGaASc5Fo39252REE2PB/iGbH4uLcIdkyWErla4hRvRYLLQh5RZ/pzVc1rnpqV5edaelN/v6+JFfYkOjQT7wKy5EsBQFfAFRC791cshGqDf2BB3+CQOsY4Zrfg/TpKPypKIizJy2+IXx9r2kBSg8GDpO2TCCUIaEGaj6yQwAzDet/RWGq+wQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lH9XKua1yFSuVuY1tilgXJFmUjpUWTKlp3s728XLZ8=;
 b=BJLMBd6obO58Qk1E62Wxm8r1/GvC8FskQWRNs4VDqGXbg1w21hO/XBYfPMv3J0JnSgTDIVoXfC6SWOOseIGR8dv2MC1XjRdQ0YNOtz5Uuq1FjKiAFwSHnxy12W+xZWwVSLMl/IW5PyTuQlxj+MLn5bkCG3uS3MmFc/JSWk4qGHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:13:31 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:13:31 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.li@nxp.com,
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
Subject: [PATCH v4 11/15] PCI: imx6: Add iMX95 PCIe support
Date: Sun, 17 Dec 2023 00:12:06 -0500
Message-Id: <20231217051210.754832-12-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217051210.754832-1-Frank.Li@nxp.com>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: e27b8bd7-9378-4d30-8669-08dbfebee916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HiUCUDYZUzh1mpMpitgrjmgvBNY8dh2HkJsVPS60KilNVxFIIQleyZwE29hX/nnv/n+tHKEzaNgOj4seUkyLQcauP46lzKTtEPddSplkOVHde+DUGdC92ds2igShcfGvbQXaX4UbdSFoWnilM+g6fowrhhgtpaIpIwCs22O+3OatNQpLoaMJpkJh3iOU5vdBxVhOA1C7GFp45xSW762MyUIi9aJP3E7shO12stryXqcQoMkOzw8ekSWHX3THN5Y4qJvo5mAuzFLs1xtgrUqrScxgVDyWga0dCQgwg6+ecBzuVbt9czVA7RtihxHmicCM4Osv58zn3LV+9ISX0NlahZJHpBgva/XmL6lTH82GtgS4yjq4S+3fW/94ZKQPNqQfzvMGxxE+1Z40BIQRb+iTOaXSGBGhLxt2IoBxTo0oXFOZvObHDYzyViGo5eyJIzDezkT9GVW8PfgAbg+jn2cq8PgTRdDrQwxC6jnzQVPlk13FuFCwAw5b8ddKlmKYChxAwbkZIGalh8XxGYjOzsUpN39vZogacRwwRrv9nIFIUKmHH+54EznuKlmN0t3tzHnJjxFpyDqkEu0rd/W7whSA7AbWrxUZx4LfntNf4Rn7EhZrKrWqhDsgcUNYHtWsaeCr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PxKNWCxINofeN2JhK6usfgxq3+9viMOGG/teCrOkQAUkujs2NHcbRjJ8OfKt?=
 =?us-ascii?Q?n0Q1Tzsfn4rDuY0I1Hu7dzxNjd6XsqGJV34yFDM6JDxDgDL+w3sy149xPvin?=
 =?us-ascii?Q?k7yTStrJ+LagktrZ+ahBzAvXunibKTKR+2dRJMS/YqeaxsO9us1bDUWe3xTU?=
 =?us-ascii?Q?oHpNdNFaTljfa1mH1Wq479AK4wADWh41oDw+gOhcTmZCKGzTtTBZAkBDNWJD?=
 =?us-ascii?Q?C17E66IFw91oTBMwSdyvPU/NNZGnrdrVzTmjq3IcOUbeHD+eWWRelARh13RD?=
 =?us-ascii?Q?2HgKXWxNo9XuvZL6HnSs237PvyEwiPRBUlrG3piYVHclEE2ernAEdg1wYjLc?=
 =?us-ascii?Q?OLrcI7Z9E/W0VFYh709Hl/GzrXQfJwfpBkJZkNCf7CjwN/E29OSCVqDQR4Hc?=
 =?us-ascii?Q?nM2zMHnTE4OA/oUhRUBEOx2FYqlkxeAdFPVlA1oNLxIpD4XiTIUUfnTJLTFJ?=
 =?us-ascii?Q?M6ZM0WqNqB+nPsHuN5EqMprTrYRxp5o9YerY/8sQ2blr0CgRpqTGAfaYdUWf?=
 =?us-ascii?Q?ew45QrkXJTGWkjl48yz4W3la8OS1Q8dSsWxH6ZP1dTvl3EZ99OT4YNpY1J6C?=
 =?us-ascii?Q?YIR8OXJzRWejkfGsxv/Q9RUCvtniHvZi26SxpVtVlfcI3Fng2VCMde/NQLRf?=
 =?us-ascii?Q?OCy16+qoM0QAJfDhLxP2NJmqU1BLk2wMCc6nP8zbsiYJfyk+Ub3mjOGdKdzI?=
 =?us-ascii?Q?m2pWyb81pzRrg5diA+KPusWflvy2Tx6y0xGRBbGwGYrfh+xXlkVfEX6JZ0kT?=
 =?us-ascii?Q?X8Uu2FZikRVvmiJqptq8StQ4sjaOsKDGzMRELHZ38bJPqehSHAR5bgyRoBxj?=
 =?us-ascii?Q?KNDJQTKXzZpgUNzQDZpt8n6Vj3gSynkd/LwfYfD0136dFIbC2qxXaUsf1sJW?=
 =?us-ascii?Q?EypFaXgczbn/h95Y4n0CtSEGvkcgeOATkIW7uM9MVL2MzECYteEI5t2F/uyx?=
 =?us-ascii?Q?XkJgbnCqpUJVVYYNL17WLKe/fsq2UqZ3I7KpDY6mnfbls+cBURk25xw9lZ2p?=
 =?us-ascii?Q?E4DRutL1Smw0I7FG4xBs12nK5CydpV405pKfsm3e/w8wQuzMT58G2FONA/tJ?=
 =?us-ascii?Q?VekgZloA8z9KeQXL6D08TztrRyW7hneNNKCsVnqgvr9SUQK4k/cbSbweXD1z?=
 =?us-ascii?Q?wAELGqxuPJHLi5shf9yG9c/v11D8Yw0IUS2ZNEzTvD0i3b9oT3KLcIFcSQt1?=
 =?us-ascii?Q?u7kpOObC/6w49wlfrTNLzmbVVVo77RoVbrr248TspE/lTrYAOWVCBZ9N/5LI?=
 =?us-ascii?Q?5exl/WvBCU7ji0qfPSkt/08crFIq0+qM26lEi4nwefTZqHTKwSTvhNGYsd9w?=
 =?us-ascii?Q?hLp/HY1+GxnGT294Ae/aDl6dHQWqZSl8/ZTLvPnBUTpnScM3sD6esSqd7T2h?=
 =?us-ascii?Q?RwrxKwkwPQieidvRi/b7U5zw1BtMRczJj4hotg1Db+2V3m0MBvEF2+o9RUnF?=
 =?us-ascii?Q?YqpmF8nZ1785JXwFgUe1Nhhb4VHCTOo1BYFccDJQSwWWueUjnrST5H9kcsJu?=
 =?us-ascii?Q?I+/m/H9EdENS24ju3vKigR3M1iEmrzQlGQ9OL9kyTHjWZIaWiTHL8rVwjr2L?=
 =?us-ascii?Q?Lnp4cvzvl43o210MGYM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27b8bd7-9378-4d30-8669-08dbfebee916
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:13:31.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM29cS29gHlT7z5Ca5lebTsfUSnrPn8T3y3bKDsdgmsvfrj6p0PLdKT1J93L6nOES+JIK+kmTGgqiXU9u62fGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

Add iMX95 PCIe basic root complex function support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 90 +++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 02da650aa55ee..324c62cecfa5f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -42,6 +42,25 @@
 #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
 
+#define IMX95_PCIE_PHY_GEN_CTRL			0x0
+#define IMX95_PCIE_REF_USE_PAD			BIT(17)
+
+#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
+#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
+
+#define IMX95_PCIE_SS_RW_REG_0			0xf0
+#define IMX95_PCIE_REF_CLKEN			BIT(23)
+#define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+
+#define IMX95_PE0_GEN_CTRL_1			0x1050
+#define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
+
+#define IMX95_PE0_GEN_CTRL_3			0x1058
+#define IMX95_PCIE_LTSSM_EN			BIT(0)
+
+#define IMX95_PE0_PM_STS			0x1064
+#define IMX95_PCIE_PM_LINKST_IN_L2		BIT(14)
+
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx6_pcie_variants {
@@ -52,6 +71,7 @@ enum imx6_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX95,
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
@@ -63,6 +83,7 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
 #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
 #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
+#define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
 
 #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -179,6 +200,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
+static int imx95_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			IMX95_PCIE_SS_RW_REG_0,
+			IMX95_PCIE_PHY_CR_PARA_SEL,
+			IMX95_PCIE_PHY_CR_PARA_SEL);
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			   IMX95_PCIE_PHY_GEN_CTRL,
+			   IMX95_PCIE_REF_USE_PAD, 0);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			   IMX95_PCIE_SS_RW_REG_0,
+			   IMX95_PCIE_REF_CLKEN,
+			   IMX95_PCIE_REF_CLKEN);
+
+	return 0;
+}
+
 static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 {
 	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
@@ -579,6 +618,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
 	case IMX7D:
+	case IMX95:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -696,10 +736,19 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
+	u32 val;
 
 	reset_control_deassert(imx6_pcie->pciephy_reset);
 
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX95:
+		/* Polling the MPLL_STATE */
+		if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
+					IMX95_PCIE_PHY_MPLLA_CTRL, val,
+					val & IMX95_PCIE_PHY_MPLL_STATE,
+					10, 10000))
+			dev_err(dev, "PCIe PLL lock timeout\n");
+		break;
 	case IMX7D:
 		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
 		 * oscillate, especially when cold.  This turns off "Duty-cycle
@@ -1278,12 +1327,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->turnoff_reset);
 	}
 
+	if (imx6_pcie->drvdata->gpr) {
 	/* Grab GPR config register range */
-	imx6_pcie->iomuxc_gpr =
-		 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
-	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
-		dev_err(dev, "unable to find iomuxc registers\n");
-		return PTR_ERR(imx6_pcie->iomuxc_gpr);
+		imx6_pcie->iomuxc_gpr =
+			 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
+		if (IS_ERR(imx6_pcie->iomuxc_gpr))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
+					     "unable to find iomuxc registers\n");
+	}
+
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_SERDES)) {
+		void __iomem *off = devm_platform_ioremap_resource_byname(pdev, "app");
+
+		if (IS_ERR(off))
+			return dev_err_probe(dev, PTR_ERR(off),
+					     "unable to find serdes registers\n");
+
+		static struct regmap_config regmap_config = {
+			.reg_bits = 32,
+			.val_bits = 32,
+			.reg_stride = 4,
+		};
+
+		imx6_pcie->iomuxc_gpr = devm_regmap_init_mmio(dev, off, &regmap_config);
+		if (IS_ERR(imx6_pcie->iomuxc_gpr))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
+					     "unable to find iomuxc registers\n");
 	}
 
 	/* Grab PCIe PHY Tx Settings */
@@ -1447,6 +1516,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
+	[IMX95] = {
+		.variant = IMX95,
+		.flags = IMX6_PCIE_FLAG_HAS_SERDES,
+		.clk_names = {IMX6_CLKS_NO_PHYDRV, "pcie_aux"},
+		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_phy = imx95_pcie_init_phy,
+	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_PHY |
@@ -1488,6 +1567,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
-- 
2.34.1


