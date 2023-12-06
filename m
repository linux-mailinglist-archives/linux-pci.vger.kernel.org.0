Return-Path: <linux-pci+bounces-582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B38807454
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 17:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66135B20F9A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE5645C12;
	Wed,  6 Dec 2023 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WpfWbGJk"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960FA10CF;
	Wed,  6 Dec 2023 07:59:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lliqeUb6yjeniF2eEWJgTlIdLQxog5sOD36Jm6VievgrKcR7tDUFzh1YwsoizCi3GPePDhxcURvmF/Qh9eHBA8m2OCERjy/khDt989EZ/ifGwl8MORZu0gjdhA1bOEclWEa0LDQoK7EhwBa3BuhOQhQdfnqT2+uVRvp2w8BCJMcHszYUmIA0MR6JEkUC1H32/6ZL+Fyxj4LpkFoQl5GJKZnMZf1+xwrajFbwpda3PLd8IT9cU1EbNCC22D0wX2EGDFvnCzXkAz/PomwB+40wfQ4j+NSniPJL4nmv+jv1qZTraS8wijlXvUi6meXTUzKNPn7HfsRoyzXgdnKZP/RfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8rYheUsGopbKQ7uL9FoT659R29rMZ2PBDlBJhc4+8U=;
 b=Mtuw0d4whFrUeYvZpKGLHEfbTKL4n6SVw+YFCq2j70wyvQYu5N8en7z5TKU+B77wqhIId6p5RRsFjuzLxhZLMZIDZzK2h241eJBTElNgwxUZOxQaVOcG3oOo9Ya+CQdENrZ1FYT5/Oe+vKp2TKPEE8WtGoL0rOLCTlGofeOuasOy+hE3OBs1msvLP5aarN1i2PC4RDg5jei8OFeqM25GFeSrPSMM3BilPumPh7hQai8VgKq6cgwOx20A3yr2NcofkO4GXW97VjOoPQTTsZiqcwFgWBfZy+Ze/yGCGwmj1MR2Uucs6RAIT8MAPxIrByQ7FsjPoZSd/vBF3f9knHMptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8rYheUsGopbKQ7uL9FoT659R29rMZ2PBDlBJhc4+8U=;
 b=WpfWbGJk0cMioC+Scu5KvHboTFJkDmMagoera+KFoJj59aZf5pLvWx5eZZUueGUhkYOUAr4bKUdq74qsAZEtRsX/OVmKcsanBZ7DA6R+NocnfO2MFbk7DD0nYBQbXCgK0F0UM7bKfgP0nRkSdUVZs0ci+jWdBTTksd4MfJp+U5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 15:59:52 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 15:59:52 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR IMX6),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR IMX6),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/9] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
Date: Wed,  6 Dec 2023 10:59:00 -0500
Message-Id: <20231206155903.566194-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206155903.566194-1-Frank.Li@nxp.com>
References: <20231206155903.566194-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f302f4a-eab9-4437-5dd5-08dbf67461f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aUNlH8qH+PsW4e3b/NHG7FIxjF6Nid0VdGkoAtKX2hDVLmp/ESz+nk0lfFFnP6CKFm20iLb8zNgKO2jJps29yOxybcVe8oL9H0vaTXbduLaWdjRPLrpjfuaREtX/Bzot88GYwuPOj4BDN9VYwEgEuRD57GspGO+Dkmd99RHVyPEviI+Rq+WCkpJXydfsIVu5JqJWkXFe9CpzLcm/zTqt9APfwLa/ixA5VKdFoEZqzEgeSo2T4xxKkfFxxSKWI62rrOf3MQr+DQiItTT1eT7GFlIakbzaoUvrS0vfKkxPF9IPcXVRiO2BcwoTTg8DaOoR1sh5ZB0uxg40vyRs01rVu402RS+aoKPWqmPZ0F38nFz1SOsQwzRmsheB+UTrccKOOygvfJ3zzutmC/UuogsL2VavPGrdBYPpwDaubQ2XJP218afgBh9rhIZxd+JtmWFKGLGxC9v9ZFZmDOpXIG8AMZnq8I9c4MjVGn58GAJ9ovWzIX971Sr0vtuov0PMt2o+6rIpmUOKgMjP/9w5MHahdflMwRufOtruRPYAoHmlca6louVy7r0jDDzu/oj4RNrhC59Xkh9VvssSajwu9PiOwr377KVedLGc30Rc0sjUSuRlM7wM5ciA7424mUXMz1g7lNRZ/BEEvfregc1qr5bPXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(41300700001)(83380400001)(36756003)(6666004)(52116002)(6506007)(2616005)(26005)(6512007)(478600001)(921008)(38350700005)(6486002)(7416002)(316002)(66946007)(66556008)(66476007)(86362001)(38100700002)(110136005)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2K4FPWzFb8me9ccBNVKOAnVqa7+8rRQ02FywY8bTprAbfhX3r78A3Kpa6w1K?=
 =?us-ascii?Q?TwdWmJKqD1POfGTHrZGBvH7m+Uiy6+cMDrKjS+Rb72i0tiwH/1dfr9RPPm0t?=
 =?us-ascii?Q?77bsk5pWSoMfXdJXWSEmcRqYIzZg9zX2RBJYNztZedJ/WMIUUD6O31YqhWQQ?=
 =?us-ascii?Q?C2yZKD3kTTQzHsvSc9x7PBj8jGwl7C6tZGNrG8q5Yg2RvYyGQS4dwcyw21wA?=
 =?us-ascii?Q?3r/RqMHeumWore70BcJxKfjOOh02s9NlZtuIcDAGxozIz+LmK/Rrhmn+6xdY?=
 =?us-ascii?Q?XXqyGkXxc+duapfZjomZSWTFewIXF+M0TAJ1f3LpNnxN3wwZ/tZtXp/LqClI?=
 =?us-ascii?Q?KFYOaNCdK6mWRkbqY1lIlAFnbF1yRjA5vbQK4AgZGi5cLz5518hAreDQSe/u?=
 =?us-ascii?Q?+LhGGfU8RxZtUBGg0B4ANfDx/CYj5lLZ1bI0c7n2KnoVanEu1zbY0ngO++N1?=
 =?us-ascii?Q?6eTesDSso6l9Hi8dbaQUmK1HOjy/wrwxwOj3qzdZeaDFyfSdpJPT1ACe+CfX?=
 =?us-ascii?Q?3ZLoQIc8bq1/6a+TQobmWz07PJdhkC6iRx+kCFe2a97bTok/PdpfRVh32Kec?=
 =?us-ascii?Q?p23AruI0lGXRkrrxZ1a6xlcYH0frfHfhc5CeaeIzqADQfOncsYdp7owBnZw1?=
 =?us-ascii?Q?clVPNhFYNx52zegi41QHruZJ2Sb2yDO6toKDWCnqpEW+HLwFxh5w3lynMqpp?=
 =?us-ascii?Q?+f1PZ0vnnBFAtCJYmMgk5svhgGzBzrJ3AkWoNxW8/5H0XrSBqve5ZJy9NIto?=
 =?us-ascii?Q?r+mpWfx3tfmyT+ztjkTXljYDTzY29QkpO0pY7DFyHmh2R4uOkQdmbCb6KllM?=
 =?us-ascii?Q?JzU2QDik4kr/CAJKhC9xvsbCHwHiQf4J66+4frkBL+TsELQ8K4hO46UZcvBH?=
 =?us-ascii?Q?pJsxhj2J6Kt+ckwYjwE59F6F8hNSYkJ4G4Tpo6g2zEihS5IbGfQvE5kFWbUZ?=
 =?us-ascii?Q?1D02jJB9ak/9WYMQYMHQwAL1zgfgk1oorXvdrMILKH2U/e7kCic1B6kA5gbm?=
 =?us-ascii?Q?aqR5NkC+EgqZsTUSzGvUeF4lgdKEXkxV/ABVUW603GuFvN2F6SCX904R5Kbi?=
 =?us-ascii?Q?yhNxsoLJJ1lvZ0F0sxfAJ8XehGQKqahSI0fwolkvPLRU/IFwz2qM3f5YbT9F?=
 =?us-ascii?Q?q+SubMmxteokff4bORDXgYIQbEqDtAqcRWyHlDh3GlNG+IKIGFh1GJG1tagE?=
 =?us-ascii?Q?eNMN527eK27L/7d2Eewc2oGef0KkjfuX2zOZLQYaJBFjYoRkUEiRQk/BlXt4?=
 =?us-ascii?Q?rToAoRl+I6AcAQaZbrDZVZubYalSuIQAWCJQihWTRXzc0gpviZfpSDAsJV1R?=
 =?us-ascii?Q?ldbFW9vzH3pBDvBta3MwGU6brvH2mmROHYxET4Elo++7b7zskTQEmHexuvJF?=
 =?us-ascii?Q?ldOuyqg5ghOKaq67J12QqrD/dYL8Mz0aXrHZddxOIsDHEeZp13MhKJMkL8ul?=
 =?us-ascii?Q?W5HaYBkhPnPdlDt1ohi22SSiUi93TgGSdlKlmagUN5nwKIZbvOOfnTk+85If?=
 =?us-ascii?Q?qR/U+qkI3nMmDxhD62Nug7/qvUZDlO9YKtEXjmSxLTL8kRnAJ4BzyDhp+V7d?=
 =?us-ascii?Q?YPnzQdSJKyXxIxbTGJs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f302f4a-eab9-4437-5dd5-08dbf67461f6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:59:52.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyAR0vprO3EvpcimcNHSRymSGz9nQJycqTbU0Cix+9d2RNYoX9hLDR5TAUzPoKBONEQFalwDQQDD6Dlda/e4Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123

Add drvdata::mode_off and drvdata::mode_mask to simple
imx6_pcie_configure_type() logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 60 ++++++++++++++++++---------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 334e714a7e96..a2a3496fe8a0 100644
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
+	val = mode << __bf_shf(mask);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
 }
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
@@ -1442,6 +1438,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1452,6 +1450,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1462,6 +1462,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1469,6 +1471,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_APP_RESET |
 			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1476,6 +1480,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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
@@ -1484,6 +1492,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_PHY |
 			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1492,6 +1502,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_HAS_PHY |
 			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1500,6 +1512,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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
@@ -1507,12 +1523,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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


