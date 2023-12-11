Return-Path: <linux-pci+bounces-767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB980DDBC
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 23:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79701F21BAD
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB554FB6;
	Mon, 11 Dec 2023 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ULsyrswS"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A44101;
	Mon, 11 Dec 2023 13:59:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJFLEeX3sxpClFb3KX5KvQp4DzpAxuEME3c5PP6KVpMXMJUWqFRC0YdlPUtBGSlawBGlA45IQdSJ80xYvXVEB35UCS9AnzuTRjf0NecgVOKWW+J+rF8gVfZxJAoU6iy2adPeYPma3U1SdRTjVNajOsZKrS0UKMH6Y3yUKWJcLuXuf8Kl3NURbcc3L/NRGhYD/G7RBEpNWXAwmf0YqtZKoJ/4ZX1JDzay4uPVM9cRqFiNNFw7rIwK9JQS69liVl70YOntsa/6SLwzmgj/I35loP4Nk80g9+IUKZc/NoscffFfXoKp5RSkCkpDPWZ2rbh3jMD65oHSU1UTI9mnLVQNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iQUXM8nMtRGGGccNHmvZn9i9sDv/N8BHO3DuQJGXPM=;
 b=OQkcE585R7TWsD7f4Vh9DqhyhTBE6RJLNNZWHoGMEqMaXcLJ5YXeIbgPwwSdLfvRYjpfcqX5KXKltatBhYNWTagmKwwTI4u1eHd6da7nYovKYAOuvs7Leian8SuUfU1ybcUPNc8X0BR02bRJ/qMVJaj0qsrAosM0+q8BjdmOJYMKUdNV3MyEj+GAeyQQXUWGtGZLHgPzkuelU+i5pRVn1dGoTppcY4oVrH1eXquhuGz1uSYoao6ZCddJdopx07lOjXY8NVDsS4t8mnwlviBQB9ERu0SxQoaHFz2hV3U3ElpUrKl2WD8fIkxTyvNG/FQHF4j+Pga+FtkJIKtOgChoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iQUXM8nMtRGGGccNHmvZn9i9sDv/N8BHO3DuQJGXPM=;
 b=ULsyrswSUSDJzM0uUZLpR0jTC7MKPovsI5l78sf0STHXDB4M86doOXqrZwms3colHV/KtrxXa69aNpF52/5M73valEROpA+V7tNCYXMwJRnQAYDuQzruSCcng/UOYCxASNjTRyzoWnvszllZ3b2ZFQuk/M7CRwkyZvPORo5dWLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 21:59:52 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:59:52 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: bhelgaas@google.com,
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
Subject: [PATCH v3 06/13] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
Date: Mon, 11 Dec 2023 16:58:35 -0500
Message-Id: <20231211215842.134823-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211215842.134823-1-Frank.Li@nxp.com>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 01df5308-c1aa-40d4-498e-08dbfa9480a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qFHwhZMsmRR2nnW1d9upUCIvqzndxDZ7txthh3s8GWwLbiQEj8fhLTFJ1k/7E+OyMtHitvGvoTpgm6JdU5fUC3Q2BzJMm/EDvDyIfLUB1bnJabYVNHWqeWLiywr97qid5NG05lMnVTT5qv9EPL01AqAE4Pz5otEv7LXbP49AQS0IXJ1nIsrDXeTGknGUAt5MnCoa7+KafvRrgaa0eCtWUpo+z6vqb4iO9pvTO3Ehk8ZZu9HFNn9uKslKcJdXnFdRp0dk78bk/QoYdVBqAqP+DvQ3gN6B2snEJqlYLRDZvazT0cOPtqidE3clDrlhh4vXdiXm4XHMFB3XobFhVZGw4xeLsRCftXZGrxJDJXOj1ZQDwj5FBWhGhKXGAJoG28shF7KZZRUUfSivik8uEJqAA/9A9/Xo4Zby24IJlvbUj738bEutopIkwz14qyFMqoRtybRKFi8e91q3rzUmjHgxd9TFFPixgB4jGPbAXJevvNmf/FNaZPjN/06FGMod4U64xnZnh6nAIq3iKJMIboQueHmasEUcz6dhYCiJKLAoLzUYBFnPlio4lWiCmdIxaTZMGldofYQmwQlmpn++nm1FhSl8qc4kvGcLT3ipqQfSU2Msz6P5asgJgeRyFsq50GDx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ai9Gnzuh2YKc843dQxy8CBGNWMbwZX2wl3g/tnbg0Z/zoAqtOc60VPGdUA3j?=
 =?us-ascii?Q?bbJUNygnrf7PyVaw/w5cF7McdxvYbK1Oeaf3G0ZgUFNBB2938TinfANn/EGG?=
 =?us-ascii?Q?8TycSixhk1O9B57toj/2dBIpv/jh3C8/JB7tJUKquYsLxBauyzqOl6GfAOQb?=
 =?us-ascii?Q?aDCEvyq5InjT/S000AeJOrLweRgSd+2mkxB/FUSAn3i4TiRV2fg9DPVyJlf4?=
 =?us-ascii?Q?dugItFhDYWBMALPvf1RqyK6v5b69OTFlul//coavEnreUYKyu/W0TS33AdN6?=
 =?us-ascii?Q?0oTDd8H9TMKa/KyV6PHm7bmMPejHERaKPT9TgeOJMDhHRY/6YGox3lJRm5KP?=
 =?us-ascii?Q?r86c8rBF/T+/Zgkr2bvWZBSmc9GNHrj6PDt8AtKUTzHu9jUTzaye0tXe++G6?=
 =?us-ascii?Q?/wBa3JT8sPPIay1O3H1m4iyJMzE9M+GL/xhh4WS1XxSrEF/7Aopmg92p9nMn?=
 =?us-ascii?Q?+pnhW/SZv2gRlFmP16s8UKDTqUS1ZSliuHl+DoZfFdvFUrFW1CPlVmmSMtAe?=
 =?us-ascii?Q?7RW+mlrsR9ArNeBb5XV7+UNU8ntpJYX9IUp+60cziqftvLN/oHXBeFOAMdiB?=
 =?us-ascii?Q?XJGWwZgwRmNVlN3p3OjeXtcL4kYvsoeq/l9sZNOfE/E6b+z7tl+JQ4Kbxf5O?=
 =?us-ascii?Q?P4Nln4wRsE3J99/KCeGS25q9lEYbEjjZ53LGZPrwmJa7AM6rEVpBqVjKg+Be?=
 =?us-ascii?Q?IFS2TZ08gjxSEB/YmiW+J/0PfTN9oQr2DpcyJ/YcTU43ipOQeMIZ5Si9BU5/?=
 =?us-ascii?Q?c9N2y0Tn1NBqYLvD/p+tFyNfDsdE8JGTMiiywfkTX3Cu2Al3Yjej4d7GRJQj?=
 =?us-ascii?Q?e09x30YF8OsQccRnxnveDDzhzo7lG28aiSSFCTbdN1MrXdxMiSoVej+A9YNH?=
 =?us-ascii?Q?vbkohDGmSjh8BKMdyay1ZvQg6+4D7IEBBHbMkSuhm8pi2fiBjPAkKVLW2Xfo?=
 =?us-ascii?Q?+d0EwIjjjwo2PwCjD+wb0Y4Xzmo+wnv4DGXyjEqqykzpEb5mO//RNo3KPuOo?=
 =?us-ascii?Q?7B2WRmc6l3JmYLy/a66T07/l3F0xcbpWHc53Kkdl97tm1OLl+J28bXkwFB7H?=
 =?us-ascii?Q?IpRY30tb0pbAhkqFn62KmfGlzlpoxQUQoscVnSxvsvWmTgep2ffIACo7L7fY?=
 =?us-ascii?Q?NXirG1YuI8TUi4LRcxx3XCI8t84YGyD9mjZUd0fY8hG2CGr3to/f1KVTgq3u?=
 =?us-ascii?Q?XSG4ZMVDFyUSucw0DAfOIq+ySkujla2l9hskd7vbIDpxY4Dr9lqXu5N8WSn0?=
 =?us-ascii?Q?jb5f/65/mxDajEx+OwAZf6qeqk/cz7oBgWPtUiXtjH3MHZ+qxts5ZXcmUt81?=
 =?us-ascii?Q?oBYPffr5SpuH7Cd484F02MyAYHD9ARHK0NY7d+NT7wh+vCb3egNUw3RuW3gd?=
 =?us-ascii?Q?Ntefc5mP+HZ4GiwywMmSG6v9Y0TA2VUEQl7CGwjUf1D3mA9PHGUivrXtfoKa?=
 =?us-ascii?Q?i7HySO+iODJrOM4lWT14hOcwXhzUKtXAKpILPpw+o0pjJCAgHJGqfMaImaLY?=
 =?us-ascii?Q?aSAO34yg58YB/kyHCS90hOm3iYJVDmqzyVUYL/DM1/lgCyo2iFUMdek1ZswI?=
 =?us-ascii?Q?dIUwmm6iWFPIkvcWySAGvHx3HpoGMAZon6I6lqUc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01df5308-c1aa-40d4-498e-08dbfa9480a0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:59:52.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7cXGTlQpPUrGcYPXo8rJgj+UcaNNdTM3FZrJNisYE/18fodt9bd5qFe8g4i0vd4WJqY+tptgksKZlw/2ApOWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

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
index 5bfb780e441fd..1fac6129eeb5f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -69,6 +69,7 @@ enum imx6_pcie_variants {
 
 #define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
 
+#define IMX6_PCIE_MAX_INSTANCES			2
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
@@ -77,6 +78,8 @@ struct imx6_pcie_drvdata {
 	const char *gpr;
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
+	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
+	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
 };
 
 struct imx6_pcie {
@@ -177,32 +180,25 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 
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
@@ -1437,6 +1433,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1447,6 +1445,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1457,6 +1457,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1464,6 +1466,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_APP_RESET |
 			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1471,6 +1475,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_APP_RESET |
 			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1479,6 +1487,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_PHY |
 			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1487,6 +1497,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_PHY |
 			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1495,6 +1507,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1502,12 +1518,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 };
 
-- 
2.34.1


