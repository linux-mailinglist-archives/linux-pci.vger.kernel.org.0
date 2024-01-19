Return-Path: <linux-pci+bounces-2386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38217832DDE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96BE1F25A39
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF559B7F;
	Fri, 19 Jan 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cJhl1Ube"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E9C59173;
	Fri, 19 Jan 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684371; cv=fail; b=vEnmbkuiRTj9kEvfhsefvTKJ+LDU9CitCg6/WZ2ReWVHp1T1Qt6F2eCyLK4Z3Mu2e1c7XCUr2kYGZQrpIuxSOp4ojPJvUIhBoSKfPd4ZRT45Z7ClgfqQi/AKoNfp1VRnGexkTSaDMojS0YpeP1Gr4nJmjCxsxpTBSodd0j3aIKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684371; c=relaxed/simple;
	bh=PwdigawNSwFXittETsKY2xda25UFmd1MpTjyJmDvHLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N9IcrIlUNJgonQxrzme/NiugyMHsRkOMkHyX1N8+C9cy4S3hxin6F8JTcOZqEjn+gAuF9drlC4KdL1PvLDDqey3B70rJY+KCE3FV20oRAgXnWEIwLoH8D19me2m0GD7xxitdtWU296Rb3KIhQ7QmYaNw0aCNJuiUwGZWDDpcAUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cJhl1Ube; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnqsuF9EM8eSSYaok2z8vs+sYcIA3BjHcZRbHl6vZ0206t5CmlnK07WB+vzfN6/nfXxzU4eF0GrVzYaoffpr8/OAq6mt6zmWmytNbpVgAh9Mwikwac1HFCNKsVqvAcOjIVKnEBVzJ1/km0b/xvIpK2ZC9Nw/amPDr/4Sod8Xgmfc0psVI6QMn+6Aei43ud4NPZHdqWkcqUMRvswKl88wcYYh2pIOJ4WiYfSnMY7j18r1xlGzQNBu8+kCUxOtU4kXBwYBF6cKjtxDmQPw/z7HQJlhxTBuPaKNO8hXGldEvqP5zIaLkjaA0soREzKW1KIONtzDF6PvY5PIK1ha5t/yRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef71eOmd1xG8RvGS0xJSuk4oSPBKqwIriymDxPvaRZs=;
 b=dF+9Urp7UjRvLMOERylsP+3SUB90LR8cafsY1KPNfCHVRLekSRzwmznuFNBmwljitxr+tCi8O8jkOQC3sgiq4gnupRmJc5Ecg0TFZTv4PZt9gll4l8CTeZPVkIZAXcSW1onEEIW2iXuwG2p50dgittbnAQUMkWNK7D91FBIjM2D8215omot8ka4PMq3ADbemYWHDrvFA38FNROZdImKhjBSvM82s8fwqosig14y8h1CIPcJD2xAa2uhrmm3Tg2jZHadZ019lTmzD/eeXsM11SjIGjf9IaQ9XtMmAKewxohnbm0zc4GBkstbsFOBp+4aNa9bpPaEC/ik6JRJh3Sj5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef71eOmd1xG8RvGS0xJSuk4oSPBKqwIriymDxPvaRZs=;
 b=cJhl1UbeBVs2xaBaaTU9O3w6VXZkdvKrVToGyADrNMr/iEfW8v4FhI1lV8HMeztYQMrh1GXSmKWvcgQLOZJkT0l1LxRylVc6AqCPsvzVK91VmHZBkp/hCubVYY7WUvoP14LXVLC4JMeY/AuueSnPgRmtKDG1yyTY0AoACuzi8ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:44 +0000
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
Subject: [PATCH v9 12/16] PCI: imx6: Add iMX95 PCIe Root Complex support
Date: Fri, 19 Jan 2024 12:11:18 -0500
Message-Id: <20240119171122.3057511-13-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 31df8c08-684b-4160-4c91-08dc1911da0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6lkD7y4kVeltio6KjLrMNoa5Z40GcXkwxqe1C6jwNrlWMEgLZV4drc5KMax4wvRe75bjPgtCuD050FRiwAUkgTeQXUFZnU9Klmtt4d4Z9IQtXjurHTkInM+CEgZVQ/3VZrnkQiZVsus1DUjNd4kziXmHVn36zcg/+RNP+LPQXKr9fPVOwZ6XqhIbaGTw7RUac2g2aGFahXoTrjle3EJrGR/KQFExu/0H0Dxid7V6zHOFiKsgoqFhIK4fCjtRoDSlLgPjzP9EFIL8gTcvgG2sFEuVtAiazJ3LY9ikSo3ImfRETcfpmfeanPQvsdWSmI7AmZQNSQYWC6maKk/j0rKFvLSZyrNxfnC+CWoRUo9WLrWvXaZ53elyhizcWHLftkbN/dVKKB43TdgyHvWgKTWFIAZF9mxL5pq/igVG9AlpRVIwHWMH64/iqXjmVN22al/RkwErLwMw7WyW1Fce6JmR8qdfVOCpanVEFtT6nT/mFnVcG3FJY+AGaylwOD2eiUOHqGGdoa1tnvGvMSJug8cOlFdBWTn0S9FxYwkLuEDfiuUMLImCM0YEFSMFEcJ5mjrpxWyB0R+Dom/M5t33MjZo4cHcSxF+tsixJ5IZ1nEtHMvYhctPx1ZGxC+Kwe0LwAoV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNFSTFmMWlCA8K3yrHx8ZZbYtpuaOh65mxgfd98+MHXCwnk+sUdR1roq0h1e?=
 =?us-ascii?Q?5x9koIxQPuhcjb1EPsJ24XbegA3p8SIRvA9GqQ0g8QNd86qilGv+P6JVxly+?=
 =?us-ascii?Q?8Ktq9pCAkVCetTeMQDThh85ISK6VCY607V3fHVISout7KZZTTFwHkho2Gk0K?=
 =?us-ascii?Q?NYDyJ9jHnLl97YwURqH8OZGddviWVRMNylKiaRkw/Il2+MS3xEbR+vzh+7Lp?=
 =?us-ascii?Q?gRX3GThB/2a0pEnQHRl/nd+ekhbHiXC/crUGrBPsMRGn9lNHMLjMFOyzsnV1?=
 =?us-ascii?Q?cITftXkoUYL2qGtMG2d+lYmrz0sMIDo5kF5Kg/0/rmkfJ86VzNNJ479Kywq+?=
 =?us-ascii?Q?MT0lWUfcaych1D3EBgtZSDXd7WN/7d/itKnEVdvD27eroXUtQ/mUotcu6AWx?=
 =?us-ascii?Q?pOCUMkM7oGqbiiMK/TwDXc9ynWri+dRq3+ppMKbrUwufTA2xWY6F3sMvlVhV?=
 =?us-ascii?Q?obDvpm1w6q8qyTjBhaxplRFxv5BVI+zhXDsCuRbVmvC7+0hetsIH6JnBaurH?=
 =?us-ascii?Q?Tj3SNGjft2J+3xagPuMKBZelHKBIKYlaXrKxpCqdIOWyCIhlhTieT2ydabwD?=
 =?us-ascii?Q?hsiEDXHpnQFMdBYk/t8ArUt+vHziK38DNjr7ssfXB8KZJ8I1ohLIi/CR4gH/?=
 =?us-ascii?Q?+qbhHjv+RnrJ+RIK9UIjT0bQImgg3YXEoFHX26GDaBmPlortRiU3lIFS0Pap?=
 =?us-ascii?Q?WeTZwgu5snAm33iFLwOLmL96njs/Hejf6qH+yHa4GSMFY4c6OMSMGd3Jd7CN?=
 =?us-ascii?Q?2aM30vEWoHDUfrpJHLFas17g5oQrsa88a+cd4ypO54AQkP3UHxK4cEIJjpnF?=
 =?us-ascii?Q?Gi0/bcB1xoIwRNAYFyV44G6S1RuMwnElmoPDEdducxnWuCZ3YWcW0Lm8T660?=
 =?us-ascii?Q?oRg6ggFmJBpXmDcLnh1f9rDkBeAdPHARX6f8sBv1QApcIgZyfy77JGSzQ79g?=
 =?us-ascii?Q?gc6Do4Noa/IbOj4R3pPo/FHTPlB0zVglWPwR4wl4CBgk7zR+QZAeeaW9AhZa?=
 =?us-ascii?Q?bA3eEfAoDQr9h+Fan6/0BprTI8+drwGwBwrZ27IcaNwmV7b9ImwGgJ+WlUdP?=
 =?us-ascii?Q?ESV/I//pCC5JYkRjKbgsyOS6+JnUHsKyQ4kyIooYbICmQfACTW9RV6vB6CA5?=
 =?us-ascii?Q?jKcqQUs496VEKwbZmaDSySCv5epeRcLln4SaRCpWv1s6jTH3r/KA+c2eWJT1?=
 =?us-ascii?Q?I/iJYwm9Peah1mj72zqAggnBztKWT9n6XDaniKYWS4lxY2heQ4/n+lhckICO?=
 =?us-ascii?Q?oAMOloSJFHvfcRl4DU40XpyFGfmuUUJShCTKqPSPaIJX9ISCz//e5hBD2KnU?=
 =?us-ascii?Q?1X6hjklejg4pRBAgjJpn29SZBSnJ7GScLQsVniDPttPZznJpI06/AKY2XL2j?=
 =?us-ascii?Q?wZE1ledbqEXcT+5HW7yl5P5p0+4d8snMlcb4VOD1MeS6JsWSaj/ZjWo/LbWi?=
 =?us-ascii?Q?N7LuuXEetwPh8I6RKi11ZLzWn7ynMHXEGsagzNmv6+gaav8wWpKSfVpx2Vn1?=
 =?us-ascii?Q?RWDNy4h7nNNhnPQy0c9MiQa3O/zLNCyjI+LyZA8Tb1AgE+BdjoQ6LIhTo5hb?=
 =?us-ascii?Q?SapH1Mgg4UV7eCyVE9k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31df8c08-684b-4160-4c91-08dc1911da0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:44.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LATBRmNFEwXiX3Sbd5D2PyNfuJ9yuxzG0An5silopGiXg8Cqtsj6xqJrc5U7k2aE1ieijxDXQvJWyEenJP5Ntw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

Add iMX95 PCIe Root Complex support.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9
    - Add mani's review tag
    
    Change from v7 to v8
    - Update commit subject
    - add const from regmap
    - remove unnessary logic in imx6_pcie_deassert_core_reset()
    
    Change from v4 to v7
    - none
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 82 +++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index dad192f38e702..1cfa5f14f18f3 100644
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
 #define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
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
@@ -575,6 +614,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
 	case IMX7D:
+	case IMX95:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -1280,12 +1320,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
+		static const struct regmap_config regmap_config = {
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
@@ -1458,6 +1518,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
+	[IMX95] = {
+		.variant = IMX95,
+		.flags = IMX6_PCIE_FLAG_HAS_SERDES,
+		.clk_names = imx8mq_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_phy = imx95_pcie_init_phy,
+	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
@@ -1502,6 +1573,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
-- 
2.34.1


