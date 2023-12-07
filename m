Return-Path: <linux-pci+bounces-630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97815809180
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 20:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1498B20BE0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 19:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464CB4F88D;
	Thu,  7 Dec 2023 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kFEptx5g"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3211710E3;
	Thu,  7 Dec 2023 11:35:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5aMTzic88ux6gzj21Ac3bxKGPr4q+ZlMZLa80MudEcwTkGhQJ8ExnoLCB+f5g1RarlIcm6YEP1lW381p2MGp2+xl+749WHsBmhhfLuibnPk3jh4okugZRziP+Rm+97q+0e4ogGvqTCygr7v6Lmhovw2pkN6Qx9nJMJkNudwL7anIp3jP5WAS+mmtvQgEGxlHSLx7/ns+8jctsXSXkAvO0L7/A7+hS7/gWRF85qGg8byXlUPkAVuEVJmECJeExqmmu5/9Df7lVc8wfAmImtbV9bqLG/mGqT7MWGEBxsGzTKGlUoiRwg0xIMF04BkOSncscpl0bTRrOnN2oNrZcJkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH/6zAS11kQqbmCKblM3aWi63sdAWsoeLepIjHxsGqA=;
 b=cNFGZtkjeAPJk+BQk1tjJUR+p+xkM3GsPgHG3+bKqdHe2VAl0EJPs3IP7dSLDqQd/auyYyAGExC5a3pFU7mLrb/QUFe8vjD6wijGEHDlJdygN6TH4zs0kEwm2cCzNOyPzxpC0bNh4cXMY/46hbP1cn1vz6ADHZ6QRID0ldKjSsLkxqaG9S/q7n0r9Zq6wZnajctVM+dfqEvv6myPS5QaMR5mnOuNizuZmKINOLupGN3NVefTKt+PlSEXoRcqnq1THtu3Yb8KnbFexyJue2GE/5CshZNvzVSEffQJCLWbPUYSWrFljH0ZNqv/80BrgcPLw2hIQt2p4Ydx66LE3/y68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH/6zAS11kQqbmCKblM3aWi63sdAWsoeLepIjHxsGqA=;
 b=kFEptx5gUu/GTCyAJxusZlVICc/Az9PcvFPWEl86stl2ctUK0UHxUcEtTqqCSejgup45tkq6atm43Nb8Oui5nMpcZC9n6321R1CJdZBpz0/Y6cbC3ABzZU2xsdI8+qbe6QXovZlYiQnK90S/gRYt/nTojeOiFzGTg4faZooRcXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:35:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 19:35:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
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
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v2 6/9] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
Date: Thu,  7 Dec 2023 14:34:27 -0500
Message-Id: <20231207193430.431994-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207193430.431994-1-Frank.Li@nxp.com>
References: <20231207193430.431994-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c17876a-7e4d-48f9-c5c6-08dbf75ba6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M2Lu/00cSJqZ+Ec3aOvWhYldQHSm8ALaJmqX6vMuZLVcPwUCRJ9LRtTLdYP5JR3vpPQPZ3mM0vygdUAIpigxXJOaNiEdeOxUI1XXAUNQBgqXFYe64X2Eciqo0hwkz7jeVKjeCADKWUDnmv+kzWxds5h4H5pzWQjcg60z9nrNhxHoe9Ixs+2c3gYWnWqI6fFFaJ8dIf1a1tMBT4cZqIKgQC3ntj+txXEdLCGncMVlz9rCnrdl8ScTIpyl30bjkMqEGGiBlDzHbMC6pG0DR9I+j8iDHb0kF3WWw7nRZ9n8g25jB54KOC/FPwjm+G3OmVlYjgoeqKh6YFKIQHOeMd+5Y2DeN7Cx8vh9oJXnd4a1YMq6jwS53WeUP5OJIICNOSZy6VM5iID1+nBw0GM3pa7qAyky96EKRW62KqwTz/SqyvyeaUCGUg4bpR86pVoW8qJFm3gHKEQLFBsJwP//5sRZDRddrA2MIbvivZH9WokUWoyL6rANGjIhQ1f7n0DHoUXv2+b2hN8Ro5jvC3kGec34FVVj3YRE12jQhcM5FQViO/pD+/z+DYVtF4Z8wElhKeZKP/mIe8ztpbclTHMMxOh64fMRU6qRpXbwWCUGB2QZPNt2sHRaSz/orLzvEjbwJP0X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(52116002)(6512007)(38100700002)(66556008)(66476007)(66946007)(316002)(6486002)(1076003)(2616005)(26005)(6506007)(83380400001)(478600001)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(86362001)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NqNHcYKalIinhXkbXwKtDT54J8E021QQr6KOQ2Gcn1rB/DXPEXlxQ0p2URH?=
 =?us-ascii?Q?qvFLjwH9ZIX7rgHyAKqIHsFkoW6FYE/fofxl5/b4Qd6tTkxTC+Bmp6TummVg?=
 =?us-ascii?Q?Iy2Zn9bl/iBf6qlZpsyjwz8qQrHmpPV0iAOjYJeJ6DyQ7FY9S8e1U0kFLH2k?=
 =?us-ascii?Q?tyQbu5GWf0jpM0PSGmViYSA+ItrpmoSg2yHyznS0NnXSHv5LoGDQxM9H+oyb?=
 =?us-ascii?Q?FjlXSH9OpQQW/vipS4RuQ4mN5jvo3eNM4/aVFzAIzxlzz20w+jGM7SR6Kw7C?=
 =?us-ascii?Q?KAMK5vSxFFKyPwutsbRQikYXKUVpb+HyoPoML8rotHlXUzgKmkny6/ZAFxsH?=
 =?us-ascii?Q?3qOFjpg5dvM7tZbiBrbxQGC3qD+kgbXCZoiBCF1V7r0FFfyvJIG4RyMRD6K0?=
 =?us-ascii?Q?84eXYrhhj13L+68yphFKRks+n7z7CWGqkdce9IggwsVomCdVOTk4A7qrE9Z6?=
 =?us-ascii?Q?GwpE+N8W7FuP3hGVrsQER3gnaNAnDcGuoz1fnLqpv13HU7/+xHiDlob5pxmd?=
 =?us-ascii?Q?QjomtiOjgA91PgdpxPuZGgcxwJoTELHF2yc7ksR6C3mU3LFmA4xTbeZi+Wzs?=
 =?us-ascii?Q?wpeElBuAKUFtij9ideGnmHhFFE0Zu7+/FmKI8Jiily27oPS52hy2gIxjRwzA?=
 =?us-ascii?Q?ZDvurIb8ynXf2JhLmivn8vXSQyn1SJWD1poUBhGKI75B0hC+E3hcNc3TlUzj?=
 =?us-ascii?Q?ixfmCJFus0TJ35onj9KSnF/MrNM6oGqS0zXSx4MDxkwd8448+hw31h8xuuOa?=
 =?us-ascii?Q?J11OIQpMWDjEmsnPjQc+oW9XTAi3jPeotnKehbDe6qtiIzYw0lNpNa47nffn?=
 =?us-ascii?Q?cF5iaT/bfZVpk/AsuuHAImqEjkQPLDOab+75XydqtB0G+q9bHw/wjYQryUi5?=
 =?us-ascii?Q?caIIyyreS+GwX0+LMpzziobtFNUFVU/o9bz8UVbBN42dukyGblOkEM/q07u8?=
 =?us-ascii?Q?FUb2nuR3Zn14I9Ms0b7PXzUunhG0TlKE7JeCQ7HYKk/PYl4jiEYhVAexuecY?=
 =?us-ascii?Q?KFLnZEoGhoruyyqDJ1fmcKQPPSmHPNEw70UBOPZaloOwqxBe4KdpQah4PWdM?=
 =?us-ascii?Q?FJvXv6MKKykfhFF3mYcdYjmhhXuWWerWB39Y7AjeGAI2AZNKGuFf9O6Ln2gk?=
 =?us-ascii?Q?bR7EKotUhAeKXFhvWp6Lax+t9Px16sYjZD1BkqCv+C8JF798yTNMWCM7UhM2?=
 =?us-ascii?Q?K2hAucgEwwXrZ0IEFHk7agr3h3m5ZNMG5rX1CKPgfdbfSZgiM776Y/Pbeibo?=
 =?us-ascii?Q?srULU28QMn9Wy7LWL/4nEIKvL7P+PyPIHrFJ/qqv1KZ88TypSbPRB9KypLiU?=
 =?us-ascii?Q?1R8seMh2/moIW0UXrUrQElJuFuiS0VAdk0G658UQrpXaMGqvtD6+3L4lfWZX?=
 =?us-ascii?Q?iobDGUYuSstlHC8lXisMbd+VoN47mAAgJUQGXbHb1xAD0O9tu9t4OYHDYfra?=
 =?us-ascii?Q?8clRgKDIbDbcXiucllL84IRwRtukZuQmeaN9Zic4F9xa3orCvG2gKLJ1uPGp?=
 =?us-ascii?Q?n2qz1XakykcUkUUbUx9Wh3ruwzbAHfTZWa5lkPsa4OIZfZS62HzqOh982NMB?=
 =?us-ascii?Q?q6ekCqfKJMwpB0fnk4w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c17876a-7e4d-48f9-c5c6-08dbf75ba6d3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:35:21.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UM4+HVgzmFuCL3f5MMuLRVOgt+K3bxCArCXdSJ0AOtEaDiMBhAwBQgJAtqeVCzwPBaqHv6ot95uUhcdYWdZNSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

Add drvdata::mode_off and drvdata::mode_mask to simple
imx6_pcie_configure_type() logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - use ffs() to fixe build error.
    
    powerpc-linux-ld: drivers/pci/controller/dwc/pci-imx6.o: in function `imx6_pcie_host_init':
    >> pci-imx6.c:(.text.imx6_pcie_host_init+0x120): undefined reference to `__ffsdi2'

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


