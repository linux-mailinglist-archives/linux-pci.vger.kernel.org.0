Return-Path: <linux-pci+bounces-1239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7AE81A834
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D152C286C34
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F064A995;
	Wed, 20 Dec 2023 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rl7PPvpR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51144BAA3;
	Wed, 20 Dec 2023 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG5hJIgl63UvKP9e6UufW5EHQWQBzMuwcPPIUqLNrjCaBzn11DnW+5FdCjD130nptTDXr6grN2qa410ixObIwrnpU0FVQhEvKr1OHcprZWU4JjSgEZqYWWU/AfMtEwz9RR56rO+j9xDIbNZ3npSJ6GyKtiezyMisdLerHpDrGnec+5ySUKEC2M6tFtLuJk1/kf9jC2DgwvnSI41KocaF31ax8bz88A75beDZb0U1nhzH+zbhe7jPGz7vjm+p9iudq7rJVDtaogsuT5JkOxfogumijEoAycDj+1UOrP8R3zHI1/p7YgKQRE3jvA2Frtgd/YhcoHI2d7O4HFgBKe8zQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVST7tU/jdCw6hjOhyZAUn8Z1JeHyuDnhtEpQSTZNgw=;
 b=bMZOW0fwhDJ0xCBDM4ippwdf4h3S0mYRJGuimXK3/IljCZcFMnUyeX7xjgqFM0IUqu8c1hLTbvzs2x4WskkEcWgaMGdTeQGG7jMWt5MLmb8pkpZyg9hwobix+X2esA7d76p1ncyCt4KWvt7hsor4hxs/gRYhYnIDOx8gg7A4nhhS5i3Emk3lSoizpq0Bk3AHYTmTLsgzQeaNTGDP/QL0By1YZ1jfKHKHTqoz0JkHLPvqvUWeH7PPrFBqD8QlkJ7EEU3k2t4/eFP3+dFO5nipxBBkqMieuqV8SlJIwVuZln+IgommH6gya+87LlkDd4fW+k42T3zYE0aPbmD43aLg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVST7tU/jdCw6hjOhyZAUn8Z1JeHyuDnhtEpQSTZNgw=;
 b=rl7PPvpR9BObcC0TUsdF23/75M3A0Ur+BXtAmUlsPB/1LHkIlPL0UZiW8ipqp4WEXgo3Sx1UvoEe6tpyN0HyVM1LAjhS37WokNdobWgqH45IbyP2csivDlmW/oKcZadHsJMxKIrUdRp4N2wQDaTGNAKZpgzGRigFMqJYPWMVaS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:18 +0000
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
Subject: [PATCH v5 07/16] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
Date: Wed, 20 Dec 2023 16:36:06 -0500
Message-Id: <20231220213615.1561528-8-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 321a3b38-7b1a-45e7-1606-08dc01a3d6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/9Qtgr89wreIhV+AsBjcfm13OCFTeC/SmSdK9aSpG5X26XnAOTBNlcxqfPPaoikXDytqw0yayOuSk3bJMjfrq2ClkecItWLbxY3NV0mghMT/QMwqql784z6XF6Kp/mgHhsnOrtmviB4llLanHiUTkAN+umWjE2HbdJrgFUgIWupS9ly9oBrQEqmWA1QAJLidmhq6TreJXuF/lnsNlK8cLlQUlK6wQoK5h9fDPYXzE53YMULq912rbq+KjoEOvQBaNm2ajgKW/hoAXSaB/kGfrHuu3Bq6GCrMnHvuZdqZqKMct6D8NDss6dzDM11+P0DdAGE1ThqDEZCPP7Xjb4U240IO0tzsmHhShOtwQIajSWUAyR43YHmnmXs1kWWGiF6Pw+gWxL+sXQ6rQAoMSUW+Gb+y63AYxjecc4IxpFliFI5zpep35qFQ67a5/LSgmVg9rDluRd+SHVQizB2KgroamFeacyUjZVexTqrX0tbrJ7MeFsT+4JIZ73BttzQ16oTBvwtEGqxZaMQcNtHB+9qoHBmEpAirPhnIOLIw1e8Z9QjWM4+8tkHfAxOcuUa9BiovjFFM+3T4kmlXbZcg83w4uXsjFSx4RXa8Toc8v1qDFCOeJE5DLU224oSsEPStsbTx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B5rPE0FTQioSwaZXSmi99pi0swC+VQLw2WCKF17D2+okAHgNW3gqpyALDmfS?=
 =?us-ascii?Q?EoExrRxgaXgM0A7MmeKar8c8l8xFJz2fQ1WNDY4+yKBUzURGYVCjagB9pCdT?=
 =?us-ascii?Q?q/zlku79xbkda5fylNXfIy55C4ayHrbIf1i6BV8Lge8QbYBF7yA3EDS/KweM?=
 =?us-ascii?Q?kh14KPcpevWO0q6BjwqP0vZnWZHgygX+OSP6rOQzbT9tbwEIlGahVnQwGTLx?=
 =?us-ascii?Q?Ft94HYIy3BgG6M6r+MD/5BBaev3bf8PBkhAJW5OU1NUAf1Qd8ARjkQaWaV53?=
 =?us-ascii?Q?pK+jp8hp/Aul/V55d/1/POJuEL5a/Kv4K9C3IPrLvv+nFiBzZm44gInMThs3?=
 =?us-ascii?Q?dEOO/EfbTApPj0OU9lZ6PHu5D5cPU8VQAvC7Z851H11bF442z99thix2k53Z?=
 =?us-ascii?Q?BFw2gsFVoRD4y9E1n7YfEv4mxoR+29AQZbMa+080P3pUELGy90r5DsyyufrN?=
 =?us-ascii?Q?F0rLUZePYUZovwCXFpOkv+kqGlG88CrxDgQ8L9BB5n5tRSVcTInvvxRpc6Az?=
 =?us-ascii?Q?1CfaEKIK4Q8ZCKCclFPc72hUqVIIJTMqINeIavaKkS4Ci6d7KWZefastkEvM?=
 =?us-ascii?Q?Es6ELEclsL+9tKGWojd9EmNm8QitvSSZ0a1eiXVjABlyMFrZaf3H3NCesRIi?=
 =?us-ascii?Q?hWexr76jLiFYtxULAb2vLz9o0TVWyBbDCHRx2HMftp0oHZ0DsQO6MlDKDNYy?=
 =?us-ascii?Q?+XNSgB6DqRbB9q8tWRNTEgDqeKIeu2tiSrW/wp4nLzO4uVnQ2H97N3AP/aW6?=
 =?us-ascii?Q?yrEwoGt3SJttEh8IP0phP3NNPDQiq4ShDdOYWKYZiH7E4kmrxOi5opZJGruj?=
 =?us-ascii?Q?6tjQzSd6rfNzK7vGQEorGRDHYbJdpopQFmouAVTNtXNWscZhoN31jlYQcQGP?=
 =?us-ascii?Q?tK7CeltFnJeNS7TmcseclxdvRe7Zend/t+hnSiFQRHeSkhZhyAUJh4meGY7K?=
 =?us-ascii?Q?abzN0ZE/FrdLlrBvCie9vvMUvu2a0i/Hiue43bo5hYsRJ31FP2Z4A53YldMB?=
 =?us-ascii?Q?KWZN2D/KuFvG9Rf2zf4UNk3VUiHqcaXohyXCUkXH4M/ayjcX0qk6h1f6Zk/2?=
 =?us-ascii?Q?yVoYRcMt4EfUHwmCb5qqvlk0KBnujDHbw62/3c9xJ/jsonUUH+Tj+mzfF0qP?=
 =?us-ascii?Q?Gc0yQuN6ol2RV6MuKjhW5N/ce9bnYhyN4gHYow8vYgl5qKfM+OYg5r3NADGu?=
 =?us-ascii?Q?V9hKYidKFnxZNg0DvfLmcO8GjiTUsbRQ3bK0FxzdnY9olw6AXE6hqMCLWEGH?=
 =?us-ascii?Q?LujV6co7T+RyhJSAmvJYXjLJEXsGn/XErCn8+P442PjFpeUJsD/3Vd+enAgT?=
 =?us-ascii?Q?aaDgySNuLuJdSfaVIS5xv+A8AIosMP3gVCc/irOwoq+L1+243UmNUf59J9k9?=
 =?us-ascii?Q?TlXGbXTg/9TS0OVkqOn9biV2xhEIDJdFSkGfoA7jL7mo+cq3WEACmJiMDApS?=
 =?us-ascii?Q?4aArqktzeumZvW+hiErWRL7MxMxssG39txPe5fn1WyjOvKtpuJ8hqeRHSNjF?=
 =?us-ascii?Q?+MBZ9Auw43yt1yNq4ukoIybOjQC5iKhE5jB5sjk9peM51DIGVUU6BrzqCQFs?=
 =?us-ascii?Q?0LGGtjbMEFJBJJuBWHs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321a3b38-7b1a-45e7-1606-08dc01a3d6fe
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:18.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXNrA7AYSfqhXPbgDxwdeG4XPx+uZLEDBrhAaw/eoZQnns+hE8SHKPM7n5LcbE8+9OVewx36ZN6OjjGPxA9Wxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

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


