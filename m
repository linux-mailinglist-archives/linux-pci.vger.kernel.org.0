Return-Path: <linux-pci+bounces-3776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0E585C10D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F7DB24962
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E18876C98;
	Tue, 20 Feb 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XdMLPxiy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2071.outbound.protection.outlook.com [40.107.14.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042187641D;
	Tue, 20 Feb 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446009; cv=fail; b=VyraizLRjL/+37sNmS3ouStGcCW9fjgos9U5ed+HqET7VJi89jtEi9oAqCfwoJtLQuYZwg8U7Bn3aKzoZYzyB72EhluCsYKmdx2sCFqNLaRdIM5LH9nfLwn3hzCTHmdts21D2BctTZYIx7hblO+G1ZctM4rH5fz5D2o4Xlp797k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446009; c=relaxed/simple;
	bh=9p+ivJq+lu5tTKqgv5gee2VgRPij3bQqMZ6BGQQYt70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WtktQtCLC8Oe4mgmH1/fS7JKQ8UJH36vuf4usn4jbCE+g+Engf0AJfnu9XXXcoKaAyUAS/rmtZaIrWySBXEsUoxKnQkFmLqKZZec6Zs4jAXu+rFPpefk4QmNDvBulrb6S0649brBJM016lj/nZxlq8BQbf/wtaEZY1SD9EKAquU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XdMLPxiy; arc=fail smtp.client-ip=40.107.14.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNT37Jw3EDI0BbtN3YAgyLk+wJro7W06zG7kHQYio4RwuqIhg4t1HWjzCTqloeC+KZy8+TFGcPglemi2SRH9ZOtA207HSeZoNBgo0adPEmzzZ/ycX0FMN/R9+gismIN52N5/yxsxEz1s6SF4N14pwS4qJTgoZ1wus3sOhR3g1xaLkSIaCcYFEFTfh2fAt08t+5ChtqRWC/JXVYEbWpz1jBVAv/xMC+UnpuhbowICyPww0akjqauztk/5XIxln+gjRdBg79NLmqrT7uMeltNI02vToKMCa44Toucn4yG7WZw7wiI33oHNwT3qFCQq6G6Qh/Wv99SjROqMFL0xIuO8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XeJx8UYItE1uv1JNy/igeoEqWYxTZP2ZiqB49qZlyo=;
 b=gEJw3GYlzw/f8C/eZWvVDgy3enQyU4mZMNiqnCY/n46vELe91hzz1a4uHB1QdrXe1AlIOZeSNrC27b4E7vAjWU4P18GBWDTdEQKqsus8se1er7cTpPeSzwhDqHZOef5vC9+AV6wR2TpjG8ICRoZgO+oqwERqxXN/ZSzNAbFp12CEo2QM3Lyv+9P9XCqn88nmFWDLNGpVRZj7n+RG9zajROi7x7Nr43j3r6Ds0I4aaskVQtcoAlnAiqjnTjqirNLiSB3fcv/VKhzSscND3U04DjO0GXupqAGQFCYWLTGgL2iRiGrVDeH8VmZ7G9UkjyKHX38LvFlL4+LvnqD+ZbQj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XeJx8UYItE1uv1JNy/igeoEqWYxTZP2ZiqB49qZlyo=;
 b=XdMLPxiyD/R+clsdomwlBtPpC8007qR4XUVGOFyFHcoT/bJTY0saWvb8RmMntWi31aSkmpb9+pH6CcWI3o1dFo2zas8cHI6schHsheW6IKgeLj0VB/UWFDQ2voRma9HUlPc4bV6DQYeExC+TQxvfj1iBF18Lff5vISAn1NvSPKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 16:20:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:20:05 +0000
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
Subject: [PATCH v11 04/14] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
Date: Tue, 20 Feb 2024 11:19:14 -0500
Message-Id: <20240220161924.3871774-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 534b0445-0edd-4f16-4e2a-08dc322fcc28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dH5sqKlOTZ9+SAPcJREoKOgDJhioxKz6bEC6mGPfOYeAW+iR8QxfDY89dkAW3t9X4DK1IsrdGCzDtPgowHMmbs0ijKVZjZRwXTPRsC5Rmydkl99K3jlP3XPBcVYhwZwGocl80OUaZWgnzLzNHIRHEZ0Hq3iM/nGQe3AExLEp++S4eWl8rqaoqQdEPK8KrZuX7C1eLbjaat31OCgt6lpVL2JuGB/Kblog6CU8DB7n1oxeTOYm0DNscELF6EJOTRgS8TR93FZNgZ9qVBfUBVeJa8MyqaIYcS3fGHlntHA+mtaGtJNa/mbLqp5fOk47AFSpuIRgVq3TRDbYVqRCtABn2HfcjGSMj4WioFfvQw5dbvdR6TEcS0pNP7NUYVq7kbzh58QpIAjVjWGoU+sHo23TrJ73l2IQ0BAifVspE0eLEXL+WaTWM33fnj1ByPho+hRb/kgjsLT9Ze5tDIW73Co7w2oz3/BOoaWZjNCYk4AvyTT3ukGUPSuWnw96gsaTFzw5YfTSbrSzZUEUpuB6eqVGn84kjNM7es1ZNe+gfpNCv9YGeXb7O/shalI9Es0x0xphod+3fKAODME47nyQOmxe3bgCQzIXFfqNQ5kAFwa7AySPklcuzmhLWeypJRh3y8tP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1gyF4f5PeiOuKTd96JY7xwefE2ckqBWGMgRbC6omZq03KohQ12vBETLj47AB?=
 =?us-ascii?Q?4f0o6nWEckPe6kBrInq+g6ozQxBTqpoIx3IbDn3c5Pwj63ai0Uld1dWqMX5P?=
 =?us-ascii?Q?zBrNm9/uh3nCenYCTeKcILNXLFT75lJOF78uFb1ITPF8UM6flQR+BTwdEmob?=
 =?us-ascii?Q?IlvX+go3WEuFf9ATiyr+CT1VQ1GQFe4ok690+UjGwKbH897VnIKwwN4YGgPJ?=
 =?us-ascii?Q?5Ay0hFO86JbiFZEGv/lIh3Ch5HHr/spVpg7OgzsHyz5T6OyafW7a0szQMVZt?=
 =?us-ascii?Q?khjjSFP6tLWDjvbwH7Zz4Awv1TbPaig1BjWxgNMW/pbKEPQle+YGwEGe6IxD?=
 =?us-ascii?Q?0mkjOZTO9RU11yhB6J9F9pyWttg3tyWzYf5WkVyMhfuS4E7owQCMRzaWLV3Q?=
 =?us-ascii?Q?duFAHfAzrk3prR4UIrMCOUrs5a2KN8524EOZfBWWcs22NAOQF8ej3lLMLvhM?=
 =?us-ascii?Q?Q8QDpaLzZ2EtbALqnoqFQMLY2jjsVzoCRjWOf69XstLIQelqXsZjhNZ9m23M?=
 =?us-ascii?Q?GJh+Itr9qSA10yO0SjtiO/T0cmp9+4Z7bxg+KCO2Hx28RuFi1zbOjwJhQzuO?=
 =?us-ascii?Q?beu/wwJPxgB592WjaJ4X6rob/ND9Z31mEd0zmqNwjcvzzqCi6T0HdyqbH+ET?=
 =?us-ascii?Q?0OMqdVo5apwkPjloxccR2Mze7Jsm1Avln6ljCFHA4IddUeFKpgTS9EM/IAl5?=
 =?us-ascii?Q?rQfmRzutdzu33kmRy+ww1fg9My3geVdYuOKklC5tApQo0F7zNbjvIaopn2do?=
 =?us-ascii?Q?8FQ9Ol+u6FhubtCRx75U1iGKNxNJRMX1I1d86TJDrhyqvEXrjo9BuQsBLRMd?=
 =?us-ascii?Q?9729VjpRbPLiQ9MEp4WXG7764uctA52b+ssZ0p6FffaWYECrA1YEAECgURbW?=
 =?us-ascii?Q?G/5IECYkmbzmVxEeFH2lv58+DSuSTjS/5DQ6x9RiYo0JQAEjckD4tJrn4YKR?=
 =?us-ascii?Q?lIWg0rLYopVoz3gyYtukAqUo6fF4yVynRP3NITeJldX08CT/zFoMt3tnJk54?=
 =?us-ascii?Q?+tKyvZwY4Vyog0ubd8VQuJSyTiEM/zbICj9p6v3I849i49D4dCntHQH1Q55E?=
 =?us-ascii?Q?JRtYfk866uAnT6MtD8/UWJf9qV6OZYrEut00wH0siwv64nZufCK3b4y0I4c7?=
 =?us-ascii?Q?H5jWZ5Wpw0bNHSc/N64f+PcOmlsj+/1uQN+aHYD+JuBffyQoPVgqtHbVCwtM?=
 =?us-ascii?Q?2aSjKyKqSno34QiVmUWGlJ2TeX0Uvmvt3IVovg0mj2J7yxWt6OYwCifa4eLJ?=
 =?us-ascii?Q?H7JMP0T+G/YzaUgg0XIHcMHtcZJhztuBJwsgXNh/H2YZtL/zYTJpx+Da8hwX?=
 =?us-ascii?Q?nkc72DaBs+pylFshhXEynDoniyHLqQgVE3KI4MzpiPGE0acjgz8IhKtnSbRL?=
 =?us-ascii?Q?a8ZgwRFi+OJ9V7V1wbF40aAHAPZQh+9KGKODT5QeGjR/owT/WO6WWoWuiJ/b?=
 =?us-ascii?Q?KNaiM2CFdQPTYuzJ1tftBXS2nk5ENaa23SUOu1LCsiYlSQD/oItXBfxR5sha?=
 =?us-ascii?Q?QM5OezYOFUVc+Ynjut/dRwVhdvYGuvb1JazumYXMDoDnjiG+gAZ1s8hHP2jR?=
 =?us-ascii?Q?vdpJihAeBpRbI8Ls0KJESvbEtyrSGy6I1xOeYrvA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534b0445-0edd-4f16-4e2a-08dc322fcc28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:20:05.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaF6EhEgqFv5LlCZhpLqLVZ9caFaERkXoWCKM50coRV68US1FFX5mRhrOwxGv0ozG1IKI2k5+NOcQpHkBPDm0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

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
index 072601591fb4e..982aa982efd66 100644
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
@@ -1393,6 +1382,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1402,6 +1393,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6sx_clks,
 		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1412,6 +1405,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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


