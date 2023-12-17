Return-Path: <linux-pci+bounces-1108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2266A815D84
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FC21C21A5E
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93833186A;
	Sun, 17 Dec 2023 05:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rBP3h62c"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C163C6;
	Sun, 17 Dec 2023 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCCLyWVBfBPlS9OOBM157IbaO71acVFzkBwUkEvIDsYo3hauWyn3hGe18s0mgxYH2u7AVHuEjIOEX3eOHgAJ7XY7uluXAAeqFJckNEJTBF5WRaxu4BXeQda1OcDx7TYNqlm4bBBMQyJF2+4/gDyRRd5FmEGKeD5wajo0Gm1pR9cXgCSpF+3y1e+G3D8YD39rgBrM23VIBU+Ig0rtUPhx7xC9nb4lBTNS+7UrC/ct6wqcG9wvAXwhcoZCk2/9+9vvf4jdDanemsGTAzWHN6EuQmxKV8MwTWxazkTUvbzj+A5+Ce+0JfLgoqUq9t87fUZw9vEtfNh3i3wfXdNIzJTsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eB11NI1qXqqPhHBqs/kCSIO7/DMqbjZIrUyJuD4IQlw=;
 b=U1BnHJ4omNq+7wXEe114WnKdJNOXggLfkSTvD+V0mAQo+blr1lC4foFA+CeTqUKugI0CRVzM34EXMUVNLrOeDd66WMDxhFU+v7zEjMTzkfwfQG5MISvKNUMhsPy87MzAzUQIFrQ1pCkbFY9xmkoZh6FGkX10ul5/xSBLsqmj6Ze9eiKRHzEaVxrGDhAY0Z5GAFSgy5m1iASuHNqlH9KnDMyEvH34lAl0u895DmjTErt2yi0L93zL5AhR/3Gi1AoKCo4A5tXNB2TKOHXvJQwXARl7KJ4J5hIkRtKj4jbpelzHJUyJcPyB7t9GaITQ8+c1otYK8k9gUTP7rN+34czQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eB11NI1qXqqPhHBqs/kCSIO7/DMqbjZIrUyJuD4IQlw=;
 b=rBP3h62cOarlVBu414trgzAtTZ47FHUpULANnNlylEjgp5uoj7qTVSmM0JK8PUeWB1vFnMlSb2NJNUIbsf9XHwdxfzBX1P9m3akxN22mwM+/8r3sEnRL2W6lt/ij/neR1As+vInzGEWvECP8C20JQ6Sm5EWyXcjl0DYITjN568E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:13:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:13:06 +0000
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
Subject: [PATCH v4 06/15] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
Date: Sun, 17 Dec 2023 00:12:01 -0500
Message-Id: <20231217051210.754832-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b3cff2f-d75c-4b5e-5122-08dbfebeda07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zy0avh1Hpr+SXbxOt5OcR8hhM8pl1H3aPwYF3P3Got20XCHEVgneQWqgL9jbwZQ4PYeAxA/F6R6yMiWwPL4Au86GVf2wbpAmQLq7+gej6nQUuqLLj90fjE49Ks83tWp1r9eZBb3QpJ51QACyiwgBVeo61w5ekUQiC6/yt6Q6Dq8nuivpBy+GxRsq8yLY2GRc3TlzHxEbII52uztdzGG62DNMGyH5kCP3m4Jcjee4butFaLAwqSsr6RpW9KoOXnVQa+PQVjFQlp4Wr7FxUwzhx1t/zmiRwLquPOhX5zdJsgnxYVeEbjoXOqXLWMCY5kfYhbaHCaWqDrpSRSkqMcU8iPsqMiHa0Ibi7UnEWznY2mB69iSaAnjwPuOktfOukua6+XOPRrALXvAPVuYqJjh91eHMOzSkqaxLgf3JvfuKwBZ3Ly/wsdjASy+REZdhMoQdHys5NXT7Ya+2zS9Z81stzJzKDtN9ZYXgZDkTrWwPU4tZg133mZxKZ/mS/ibS2oBhke1Hpt4sCy6037mqjnuo11i6NG7zPxLQfi7vaWo14pMRuhhlGLAtDIT9gEAfVyNiDsu7V/auR+dIcRFDtGUrIWN0MYWyv9LAtQ5E+gZuN2mIcFN8gUySmJH1cZy2xKkI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWkuCUWKtf/GWsLZxHH40RN1IOY5T1nOLmaIauTPa5PhbsWvBEIBizrpuHpV?=
 =?us-ascii?Q?lU03g/xAO5YLK7q/yOtc88jZro+BqKS36aNRLXTWfORY6BuBOLD+n+402pd3?=
 =?us-ascii?Q?OakPPp+uK+wLrMPjQCmux4hqVDDa4vgGQbc7aSvHCAgUmOl8q7uCTAAe75pi?=
 =?us-ascii?Q?kSwOaMpFy8XZAG72MHDUM0cbkswzLd+AE+NWkMONH6W8BY2/Gtg8Sn5nR/li?=
 =?us-ascii?Q?sUK2n5RMgg11wRUcZYxDWqYeE1NMRIHfxs0MQzuC2uefjNg7MgGfkU6NC6VY?=
 =?us-ascii?Q?uHIk5jXKoDWYTp1/goA8v9uuw5uzu6GHRtdi0wfiQ9mXQxz7WtEjM/xp2lSx?=
 =?us-ascii?Q?Pfj5m9HLRhmaHUHnmDm6p5ag0hqVmWG94HHgakw0HrrjOWhVfR74jMQa8Heq?=
 =?us-ascii?Q?CKGR9OEKM6lb2p+qhK0i6pSGMxmX+wpcewh3s4ikEjwthFE3a2hJRaVc0vs7?=
 =?us-ascii?Q?JckjBiumDTNcRIpuhinnJse//nciAw7LV7/xbxTqoPZjfLrABsQrlZ+j2/XX?=
 =?us-ascii?Q?1i00LdEATawEloHDZFcYeDbtonNEVXgTWR/13o7PVYmcIx83QpZU7KxBChdz?=
 =?us-ascii?Q?XG1pq+K9bFQKu7o59P97NAg6SbA155TW0J9KAgTW3dd39tW+6b/lar8Tx7ig?=
 =?us-ascii?Q?sPV62hRYtSCTRnwd6ToekA7B2FTiL1qduBe+83t1gdYTAhQcviSbv2yMUjor?=
 =?us-ascii?Q?Igptl2aI6OCNNt5v+yWPDcE+DYa9r2TNCtQlCjqy1sSGGkWbkhO4tJ+vd37I?=
 =?us-ascii?Q?sxQ0soIekwA8hv6ww3XCWbsCy89C1Or3H1yrd+5E2GiQlh7SFBURY9lVs7G9?=
 =?us-ascii?Q?0cfRc18zyavT2gK4OW4EtGV67VM0nXutKB4HO+xHjKWWZmzihh/LhEvqWl2a?=
 =?us-ascii?Q?KF7rpr3o9EzBLxjSyVMhN2iE7CLpYu60xielWQ5o7kLkyFIzME6B3n6uVAxO?=
 =?us-ascii?Q?0fvl/i2P4TZ7mz6Lf7fpRdjpGZ+MacTXZxELXh6XekybFWGRtMFlNBj6Payx?=
 =?us-ascii?Q?gPZSeOYX7wkpfjpG8HPIEdSOYjszY99utmgHazkg4/nYdnAnjyfeQwyuq/QZ?=
 =?us-ascii?Q?o4byPD4YJ07/Uly2N0scEPsX6NvNH0ItCT2YZePOW0U+GYSHBwlqDNiSxgYu?=
 =?us-ascii?Q?hodLjPkNkjUwe36L80dzjTrGBuDkf8i5nat7PRvmxr5F2aIvxIYZ0HysbLqK?=
 =?us-ascii?Q?fXLgz4yp/dmj/NB0OnFChTEBA0cfzLRLrsTayZ7wdvgGn1CZpiYCDT/PZJg4?=
 =?us-ascii?Q?yzWneVHNcfGMGUwznh//8TCCWJXDDxrpxUEHEHPy5BuFCupF0fL3NOLkv7wa?=
 =?us-ascii?Q?is5XIFO7MPQGT5dSKHvSi9v/bbRYUtOBJC21PGN+GEi3JajQ+j5n2pB/CHk/?=
 =?us-ascii?Q?Bl3COHrpLVXVbVRkd3Z0xvXOBjLgikxHAoydkbV+/zJjzERQxoNjSIjFOpQ8?=
 =?us-ascii?Q?HOe8XbvhW3ynFPMw3/eWNBal5vKLpJcCZyIQ65VmmQBMT7aDb+6VF136n16f?=
 =?us-ascii?Q?b5m8RfNnQTNOhwloRGhofC1jZctTINDwEZIrAoSjCPwfFUBFJSc4MNiYyxN1?=
 =?us-ascii?Q?HLfsuZgMFpi0efuu/TM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3cff2f-d75c-4b5e-5122-08dbfebeda07
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:13:05.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhP0o7eswezm3obNtrP9xjIZQA5TOdcbGgBBnTKhyJqhyvcaPLqXo8D7ZJIeVO0eVGGkuExn+rwu/QGbOZhNHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

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
index 79d892836a24d..49b98593326f9 100644
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
 		.clk_names = {IMX6_CLKS_NO_PHYDRV},
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1386,6 +1384,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {IMX6_CLKS_NO_PHYDRV, "pcie_inbound_axi"},
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1397,6 +1397,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {IMX6_CLKS_NO_PHYDRV},
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
 		.clk_names = {IMX6_CLKS_NO_PHYDRV},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1412,6 +1416,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_NO_PHYDRV, "pcie_aux"},
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
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1428,6 +1438,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1436,6 +1448,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_NO_PHYDRV, "pcie_aux"},
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
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1450,6 +1468,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 };
 
-- 
2.34.1


