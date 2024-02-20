Return-Path: <linux-pci+bounces-3777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D8B85C110
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3941D1C2105F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D52D7763F;
	Tue, 20 Feb 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ES/GISDR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057777634;
	Tue, 20 Feb 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446016; cv=fail; b=gaUb9Ac/aK34CgN/KjurqKn7z8CfOKIA8Oo9t+O3cREmAxTzslAt+grVFSyz9Uqei+kSxbE0lLiUIIL+OI/cKT4Jp1YFLJWyXmwVzBNJIpdrnR1BtSqCt9GTEhjHUgruRUVjDB+ClQ8mt2OdVGjN/V+JvPhgbMgnD0o1jeatt/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446016; c=relaxed/simple;
	bh=DnhUGrgW55SFHrB4MfhIx0/E+bGSDFhXsZ5jLdy9yNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=siyxYu9p2/7m9QX7zSLlbyRaZOwJ1K2cWTGtSwKNtET3oUMPwXqae3vKBaDbl4AyYBYYr0Tx/KxR6wzTiUsQeXKs35lVKhkZNeIdsoYifuBh2xyydilylfrrhi3aZUvzYrsTshDfv8GvrSIEj5m6hypwzeJVY95pilHgFnVDN20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ES/GISDR; arc=fail smtp.client-ip=40.107.14.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7+5ZhGJe2I5z8ouZ6q1GPe+gCRg0GX+7TvMMgenN85uPoNbRxxs5JeUFF2d6jKN0WCRDXIGYG3EHXipCCzPgqT0Emsj7sV5kqWtSNsSXJdn52ZPYw/JHAIn4vhV7KZPFVFG3fHqipCxdOhkxZRSnHQy2dQk9erd22anTmtpdpy3IdpEwfoIkw3TVdkTyCf0hwmJGQmpl2zacFb4BqwW1Q+xRph1QglrI63e8rSKhRAimX83PccDyN2v7hgB4FvqjmP1EDc1XlhDMoP9FIO9yC7FFs1rjYlrtEuV3YtYlt6nDRq8gaDjUxMilaoHS7ZhqlI7rZFTdQC6Jkfsk/A1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubG4mKIFKbwh0O7BFeiS1Zl8HBUE3AYfeAX7MbKuFV0=;
 b=ETC4a4JNAyg2wHz3SKNgZCMi/W1XOu2n4t6OvCPrNjd2fNAtC3xu/AY1/DTdqhOVPl48fH6LutDdoh29dAbayFeiH9bLjsOgOw0erlm29q3VNLyd1ixkuvg2rVtWb7f2Em3Kl0HG5Fde0uRhH7LS/i6WGLrvt7B1256fw7+9lvePToEq0Iu0KXN9N6ODOlv3aW2B+jgE1j5Wghwb0Iy+mkCbRa7mZzZV/+06C05Lu1CjxjKZfN8RegN189r7s2UD0FnqXdhTT9fZqbPO6yP5MHQ4ilE3wQCA6YXFYpYhLr2bLTzSx9wUQQMd035VXZyfvxw0r+/p2i8KKMDQxweFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubG4mKIFKbwh0O7BFeiS1Zl8HBUE3AYfeAX7MbKuFV0=;
 b=ES/GISDRjQkt1ib85/7kERsuRZbRMBJlpp0bkPbOayJgWN6LlOXeWgHH2vHuoZV3DXDF/hc/sSzRvAMrB187MYeXiy8wEofCCZvqcWC56oLO8K2nQ4S5+twfsudG8Pk0Z6TCw3HPBLFPu6A+gC5+nktQOSkAUjhmAp5/jklDoxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 16:20:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:20:10 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	cassel@kernel.org,
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
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v11 05/14] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
Date: Tue, 20 Feb 2024 11:19:15 -0500
Message-Id: <20240220161924.3871774-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220161924.3871774-1-Frank.Li@nxp.com>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 22dc7787-db6f-4173-6645-08dc322fcf45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WcwkMV1Bq6f09QTWVuYkU1cnY9mfXoXWjuH/9Bq4CY7ljh8OJR6ia8cxM6Vhq51ugH9Zh4mrCc2g0hkp0Hz5z7JS/x7o7198kVcNJTHwnPLEZeI1aSVw2FbOTEUU5A1dvtEVLlmO0u+lTdycZBockFOmP6zHHp9X+NT+E+QIijE3B8uzKFAsdta7gNUvoI8p/1BIvWUEcyQ8QAtj7G/b4+avg4zvZiIpAHXA5QzuHQQi5cMSgkxNKEwZW5tGkU9a+RU3XikGn8qDSdJhEMnuuy7TboopSKq9Ai99P5/dQupWdZva5ebbDhjRJ5gTzGoSzLozgglZyMr9f5CBiHpOy2t19eM8ghuxfFUqCGKWlmtD/AYnRLykQ24fUhTzv8w1+GrKqaNUduq8GdJ7Cs1LYLkB6LoxiAcYPO+jjZ0FBp/AHYmcFFby76m8p3gsoCTAkbLNECJcgGPHSzeQ2Ta7+irJuu04PJWT/ebKK3lOu5QexNC4FLM2pFkGXKqXkW9G6kmDXm4a8LP0yJuDNliL4aavY4vNdzqIEoFRHPDKl7BHvL8j21Wd2L7jrKghVgdDHBYlnlJikl9HUWRjdPAbaPqqz2oC2ctUXsyYlVqB2PCGyROw5bUJUCZPfnPxQHvP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uBqYywoY2pGyrXugJVj/JNLKjf6anbZtd5II/6raP6Jo0iXYMcctTqmXvD1l?=
 =?us-ascii?Q?ifB6+THDXagfrDCcKlYiaimucOqsKwKkw/OD3ZTj0rqYWveZ+rUtzEq0CAsN?=
 =?us-ascii?Q?rlLn4+irtP7utcyy4k61lC3dE8PtS4WBDuE6uBjQRj65xclt2H4UES2TDbY2?=
 =?us-ascii?Q?LjavwQQD4HA4sfaJ7EOHMphsD43QxXSvbIamOuAgXB2zBQ1dhe4ikND5XRXJ?=
 =?us-ascii?Q?8PGmAHcvSX9CB24nOtnukT+XAoaekzDVPVXfniL0y3mh0T88HEKIzRaaWkor?=
 =?us-ascii?Q?oxGG6NAX2TXW8vuqMvx1BWF6UZR/aohwfaGLkgOfOQL14Or2+fOiWM9aCQOh?=
 =?us-ascii?Q?rgwCeoi7o+M9f7ABHD07JviRrmwgzS8lDXAtZNV5DVkyU8wS8KmTk51DsA4b?=
 =?us-ascii?Q?AqJWUKDQvJ20on3y12Lw/MEKa37TAmAzKQ3DRbc179239Z9w93WHKaM+PIm+?=
 =?us-ascii?Q?om+GVjmlrISUXpzd+gTvoBB/Qes5ZSnkdN5imMVwwdPMcaAsdQUT8iuT6Iyc?=
 =?us-ascii?Q?9eYntd5LaDSpa5MFC81wPELwFi8pFW46NP6HrL8KalwZTOaopXj2MXykgJMw?=
 =?us-ascii?Q?M14jOJG38M+62IS26kIyPWnTBskWfyRaub1mQWwSGuADKVI/1NOxbLraZ6B1?=
 =?us-ascii?Q?ofWCT4MmMNk1rvnwu89En/symyJxVwNb+jpevGNJThsbuowc9HIoBO905Z0k?=
 =?us-ascii?Q?eMSc8T4C1emlelv/+NBA9OcTqyJbsQsyV2eZfhF2WKuEJzEkyxZiVPNg5RA4?=
 =?us-ascii?Q?x6wdnpdcpS6YUa/7sMdv/gNDkzc71PkVkmi5uTdA5DXoifH+xP/A+tkU/Hoq?=
 =?us-ascii?Q?zwlqgas5jsPuME/fQSixggliICvdEd+lRIl8p0KEtWLG/wa7UyWDNPFtrE8+?=
 =?us-ascii?Q?etZY+JWZZP1pVELFdHrsbXfNqnOj02ePfWMot46z6TNkwSiwp27OcGu/GIhD?=
 =?us-ascii?Q?8pj5hAWRiVAQQhRg71HOd7WTZivXnf2UB73uXCFElf2mjy7NLn2DuXwbjWus?=
 =?us-ascii?Q?zT4T26JGo0GgzAg5VIRuUkaCC2uJ24Ks/i336sF3FVNqAN4X9L9rJLXEf8f9?=
 =?us-ascii?Q?urrMDxeT1HzsFKgZmuM43V7WZKKBt+Q+28+9h+dmgQ1Ss6u8OTgFlLD/BztJ?=
 =?us-ascii?Q?KOnQTAojiQQNbfIp8qbAQQKobFXOhr6sU3r3n5x/FUx5OzS7+hNGMJ3Rj/Fw?=
 =?us-ascii?Q?kn0DLRKQ0amzFStqFNncLSLn3Ob3wLgPiU0gmmzgRMnxqyE+pZqoY3rXMBdO?=
 =?us-ascii?Q?TVvK9degssEBFRM6j7yxRmrh5hjcCy5xPp49YMkVMhfVHF1UbXTT4Mlai/vF?=
 =?us-ascii?Q?aEl5v71VbXcMujEpV0UACFEeJJyQimE9pNPaS4n8B5KV+mlZMb2ogEw+EvfP?=
 =?us-ascii?Q?NYv5TIdzDVPIbsCQv7Eu9uFElAkWzjnwMSHHa+Hv/rcRQQsyDB57w3tbYkzQ?=
 =?us-ascii?Q?UEtQkMNPiz2aozblRIql0OqPz4TbPs1t4gj6YNUh96rXMdkF33ZzAcEQphef?=
 =?us-ascii?Q?L16IGce4pU5RV5btMldmI+iYQNXY08yHeRB/fuKnEHESZI9tGEWLXJet6Ztd?=
 =?us-ascii?Q?IPif+S+OPKBH3ZRmqJFwXJDL6wWn6T5DX+YwVkDu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dc7787-db6f-4173-6645-08dc322fcf45
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:20:10.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsTWZ/HjQ9hWKJPM9fGHOAfdXKlvl684e3qIVyazG4odI0AuaHJXENfQSGdXHZQkiU4rahUZfaNGA/ZmKn6zlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

Add drvdata::mode_off and drvdata::mode_mask to simplify
imx6_pcie_configure_type() logic.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Chagne from v8 to v9
    - add Manivannan's review tag
    Change from v7 to v8
    - replace simple with simplify
    - remove reduntant comments about FILED_PREP
    Change from v3 to v7
    - none
    Change from v2 to v3
    - none
    Change from v1 to v2
    - use ffs() to fixe build error.
    
    Change from v2 to v3
    - none
    Change from v1 to v2
    - use ffs() to fixe build error.

 drivers/pci/controller/dwc/pci-imx6.c | 59 ++++++++++++++++++---------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 982aa982efd66..6dcff345939e9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -68,6 +68,7 @@ enum imx6_pcie_variants {
 
 #define IMX6_PCIE_MAX_CLKS       6
 
+#define IMX6_PCIE_MAX_INSTANCES			2
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
@@ -78,6 +79,8 @@ struct imx6_pcie_drvdata {
 	const u32 clks_cnt;
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
+	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
+	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
 };
 
 struct imx6_pcie {
@@ -174,32 +177,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 
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
+	val = mode << (ffs(mask) - 1);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
 }
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
@@ -1384,6 +1379,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1395,6 +1392,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1407,6 +1406,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1416,6 +1417,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1424,6 +1427,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1433,6 +1440,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1442,6 +1451,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1451,6 +1462,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1459,6 +1474,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1467,6 +1484,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 };
 
-- 
2.34.1


