Return-Path: <linux-pci+bounces-627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F18A809179
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 20:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0511C20A3A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE604F8A0;
	Thu,  7 Dec 2023 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nx1uejXo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2071.outbound.protection.outlook.com [40.107.104.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A110F7;
	Thu,  7 Dec 2023 11:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2LQ562mCGJuIwgquqxgqR4FdPTYnim1YPKdpt3Dflb7DBO7cPO0hgq5okUpWLwTN8WcsIRQq5pX54/KTQQX1UEGVaSh+AQaqE4UAKxchsQcR3VnmEWlp5f6Nk6bxZkCwFT717DOTnh+/Z5KzOQpvd6w8HpdXAsupziRVmH+cjPzYOjlqiCoyMa5xVjZ8dw+0hV+R+FrjmGAuIKJLWZYhEByzrsUK0sxP7ie8xlJZuyjblS4N61QSTxFTN+gZYLLC4nAWUZtA9lWIMyrXTw1Uhm8/7xgqMcQGwJHgOJ+P3RxXpP8IMdUoCJjeGTJsMDpaxqwkQXcGXOOYKbm3j/GLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzoJNgxx7XeWgJ9B1JpqNzJ9NuYU/ZTE4t87VxOogg0=;
 b=YD8JnXjZLCCaXEkeFWPoKaspnaTYy1pjuw1W2xx+XLYAz/0lzebaHYBbte3UU/p7Mw/p38y0y7AzKDdmq/QUOO1ojqZRTVMWSUFod9wcWIstfB4LEhDhW+YTSMPAZjwBkjdIrEseLZJF8FuhOQQyNnc0jrYO7cpf9FfFQqLEKBH67wArosYJQPUY1cgIii/OOAaqLTK1CWIU83ZKHNTU+4niqYMKVWffdO2hnb62ATG9L6UR2H3CG/+cg6LjzPfGXj0SVRS/2oMdQHu7UX7Qzmk5YSb7h2055cws2Titc4oFaFt03KH74HoUnCAgFlbyLnq6bbcloMCVfMv24SdwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzoJNgxx7XeWgJ9B1JpqNzJ9NuYU/ZTE4t87VxOogg0=;
 b=nx1uejXoFoL25O1ZwfrjkoTEEToo9wTKbBa8GdWupvsY29pqG1Ykm9PlXilqM1jIMHyjuvJHVpg1m6YawEf4nkSOO9nbBQ6sEVr8U9t7ZyD2Ham3b9/Ime3yQac3mRKE47AfflxLrpyIEOypcRLPoRe+Xdx5kO5CwhGqT+qX5Q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:35:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 19:35:06 +0000
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
Subject: [PATCH v2 3/9] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
Date: Thu,  7 Dec 2023 14:34:24 -0500
Message-Id: <20231207193430.431994-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b29a52a-781d-43b6-98bf-08dbf75b9d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ExuauAAVS1odlbALWtLN70UXRkX4OrbMinTkrwTPCEARFcmVw51ni9nhI5DAMyxUx0Rvm7jB3cuceyeKD6F97bnWLz0baTMfa/JKhYT98lI+V+eDBBP7n9O5BtQWwqTDChe5tiaZXtlDssVWaehjsaG6kjv28ntzxPGG+xK2Bla/xypu+6CgIEE8z7/ztDD0m5jCBXE7t6dZz6QfyMeXv4g8VgqDM/8WFTjcZxtJJJEOZPPRtfWdKZsw/Qzl+E94m/p2skZikXIZfjGvBNrRxF39mO6NcJfNedkGnz3rI3a2wwgIRi0eDOiYYjHPybXgC1SQVVgG5FE7HL1nrjMmtqnTdIw++pD0Hy2mcTg4Vq7kEH1ps+tOSmbsknGksNVqXgaRPzL4+z5GBDNrNUbqmDsIYh4yFsCJlXQBKDYf+r1pBCBtc62BzfLyGax6LRSDBO6SnksY6jtGH/gXAXIMeTFzUoxoEYw5fJik6Qiaj5Y8rzmtU39+65N3AygdrsDMZ3+Pg5ocRMRbkz1fCQYiHxIsNcNf9viN/C88/R4TsildTu3SskERLb7yz5ihchMGtkWKqUDfr6bjT8OGN+acSm8iagTD6dN8Xav+TdSx996+fORMx5GXgJ7ohQr8jWdG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(52116002)(6512007)(38100700002)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(1076003)(2616005)(26005)(6506007)(83380400001)(478600001)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(86362001)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?be+g8GiJo6EEzHZZCIcFZnkLzTyEu08U1net5fEqf8gtoHzJ+8M558FbpQG6?=
 =?us-ascii?Q?uammXcNw+TWauM8MP7m9D0wgK0YTnruI7C75R/XBGPSWdlvikG794Y0WWVSJ?=
 =?us-ascii?Q?6kRiohOJm+IFF2PAqA/aaFvptlSmfoIH0KMRtrv53xvzjrLQXCuqOKhbQdcy?=
 =?us-ascii?Q?Tezmv3SYV+Li9b6z1koHWuyIpeU7zQrYr1gN/gqeWsT1JMVoUbtxDZsvZCXm?=
 =?us-ascii?Q?0n8vi8UiM6y0bzZlGJfPqfFdngBQhfTdONcC4IAegvbCSaQyDNpbySQ9KOUb?=
 =?us-ascii?Q?xKPquAhtd1jg/W+eB6Q5kFHvbpgXYB3D5F5ffkN4Arc5O3iacXOMupVnHsSY?=
 =?us-ascii?Q?8GThSlabe7BGwmSNDZ31jTufdwuXdEa9YRGZc9UZxtECQsEYtZAr8iOm79U9?=
 =?us-ascii?Q?81N4v67NykUVg/IreStZW2xzZxjwh7pV/f/hvQ8kpmhJ0gcBQF3TWK5hOu1+?=
 =?us-ascii?Q?w/0dC3WAgjCdcmPqZxFoLM2VF+D2mkH5tebPs3k5QdtVU9nd08tQnvcSw5Pa?=
 =?us-ascii?Q?J/RNExgmZSreRyb/qdqn1cQNmMyfSHmZUoUtg6b8DZHu0Hzv9rvHlNUSqMyJ?=
 =?us-ascii?Q?6f3zK62RkdsBRJ0N0W8EltDo2+uprkt8TGHMkDUkraJGNNBjsJwwr8FZvyo3?=
 =?us-ascii?Q?HxvV2xFr8xgwQWNwVKSJpCsDcSTkCFqtADg7nfNwt6i+A83M+Rjr8x+8EST0?=
 =?us-ascii?Q?syqh+LuJUmHDBxL/Mqg01heMVY1Cz+xxxmcb6GJU1Old0Cg6iYELbrdD5Jl9?=
 =?us-ascii?Q?/oQNLkgm1534g7azPBqADwuDhRSQXa/sVOoDAw32a/g/Ig/R6Jiv5IRzCyG5?=
 =?us-ascii?Q?ZvuiGCx01iG1P4OL3FtdLhGC5/Hk97tLJxdYsWfeCf7zdIKOvdIJFHqBpWIY?=
 =?us-ascii?Q?Kw8wIctwXPaXT9O5iIWM8ySpeuwbaC4o6lSr52lmqNDAbGyr6b9+0+RYX67C?=
 =?us-ascii?Q?OOwMVQKR4GqKHZh2Bi+ZIWxK95OCE+XCRcmQJkq05EwNvJtfto0Q6VrtyY8S?=
 =?us-ascii?Q?/vVw+ikpQF7NiUzHEBeTNTAdR4nl4xQHeb802Kh5V5RR6GRf2A8sGglTNPes?=
 =?us-ascii?Q?XQI9GnEY1/cgWtZA1ITwFMBVNXSatx1knsF2ytsbEphR4WVQvKKrdD7EYhqz?=
 =?us-ascii?Q?mcurNyfulyBSNMWzCN2758hV8/DOL78kSm7jUVlqmUrDbsRTpxGsnMjU3rnS?=
 =?us-ascii?Q?+TCinVhF5i7xp1gJmoyYQuI45ivQO0aLUfyrdLj2Rk18PDFLvYyBcVNGGxSE?=
 =?us-ascii?Q?anVyetLyYtmcCuRVPAajoEzcMKMVKZYRYYBr9rCS8VpCnl0TquHuOzEDkvCr?=
 =?us-ascii?Q?aEsYqk6M3m3RWlOVqCwF/hgxYIN6iRjIfQYxZmGf7RA+VPyubTZFU7+rVY8z?=
 =?us-ascii?Q?Z5cmMtp3gKSUfCup5XfV99/jxAOGVdJHDM6xpFADBVmlmYeREVD9DvR4wSUM?=
 =?us-ascii?Q?gEKeO329zrUwmueXlyOX2plB+vaJ4CwQOsBTHveJDy8GmdDAhFNv3Z/HHN2b?=
 =?us-ascii?Q?dngzKNVXU4k6U9DTo06rGp3Qz1PsYllaF6+WADzr1bXykX8Ch4YGLEnYrHOr?=
 =?us-ascii?Q?e21JVHxy7o1KpZlzMnM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b29a52a-781d-43b6-98bf-08dbf75b9d83
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:35:06.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DLuLx4+/kN35e/KWRWvcTInKfHrcwkqsg8Xx9IDTdBF/GhTRpXaAzIvsd5ry4FvmJ8A06HkexOqqPKaQLkf2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

Refactors the reset handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling reset.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2:
    - remove condition check before reset_control_(de)assert() because it is
    none ops if a NULL pointer pass down.
    - still keep condition check at probe to help identify dts file mismatch
    problem.

 drivers/pci/controller/dwc/pci-imx6.c | 111 ++++++++++----------------
 1 file changed, 42 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bcf52aa86462e..509d459bdc5a1 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -63,6 +63,8 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI	BIT(3)
 #define IMX6_PCIE_FLAG_HAS_CLK_AUX		BIT(4)
 #define IMX6_PCIE_FLAG_HAS_PHY			BIT(5)
+#define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(6)
+#define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(7)
 
 #define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -696,18 +698,10 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
+	reset_control_assert(imx6_pcie->pciephy_reset);
+	reset_control_assert(imx6_pcie->apps_reset);
+
 	switch (imx6_pcie->drvdata->variant) {
-	case IMX7D:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		reset_control_assert(imx6_pcie->pciephy_reset);
-		fallthrough;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		reset_control_assert(imx6_pcie->apps_reset);
-		break;
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
@@ -728,6 +722,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
 		break;
+	default:
+		break;
 	}
 
 	/* Some boards don't have PCIe reset GPIO. */
@@ -741,14 +737,10 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
 
+	reset_control_deassert(imx6_pcie->pciephy_reset);
+
 	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		reset_control_deassert(imx6_pcie->pciephy_reset);
-		break;
 	case IMX7D:
-		reset_control_deassert(imx6_pcie->pciephy_reset);
-
 		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
 		 * oscillate, especially when cold.  This turns off "Duty-cycle
 		 * Corrector" and other mysterious undocumented things.
@@ -780,11 +772,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 		usleep_range(200, 500);
 		break;
-	case IMX6Q:		/* Nothing to do */
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
+	default:
 		break;
 	}
 
@@ -831,16 +819,11 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2,
 				   IMX6Q_GPR12_PCIE_CTL_2);
 		break;
-	case IMX7D:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		reset_control_deassert(imx6_pcie->apps_reset);
+	default:
 		break;
 	}
+
+	reset_control_deassert(imx6_pcie->apps_reset);
 }
 
 static void imx6_pcie_ltssm_disable(struct device *dev)
@@ -854,16 +837,11 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0);
 		break;
-	case IMX7D:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		reset_control_assert(imx6_pcie->apps_reset);
+	default:
 		break;
 	}
+
+	reset_control_assert(imx6_pcie->apps_reset);
 }
 
 static int imx6_pcie_start_link(struct dw_pcie *pci)
@@ -1335,36 +1313,24 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "failed to get pcie phy\n");
 	}
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX7D:
-		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
-			imx6_pcie->controller_id = 1;
-
-		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
-									    "pciephy");
-		if (IS_ERR(imx6_pcie->pciephy_reset)) {
-			dev_err(dev, "Failed to get PCIEPHY reset control\n");
-			return PTR_ERR(imx6_pcie->pciephy_reset);
-		}
-
-		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
-									 "apps");
-		if (IS_ERR(imx6_pcie->apps_reset)) {
-			dev_err(dev, "Failed to get PCIE APPS reset control\n");
-			return PTR_ERR(imx6_pcie->apps_reset);
-		}
-		break;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
-									 "apps");
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET)) {
+		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
 		if (IS_ERR(imx6_pcie->apps_reset))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
 					     "failed to get pcie apps reset control\n");
+	}
 
-		break;
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET)) {
+		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev, "pciephy");
+		if (IS_ERR(imx6_pcie->pciephy_reset))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pciephy_reset),
+					     "Failed to get PCIEPHY reset control\n");
+	}
+
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX7D:
+		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
+			imx6_pcie->controller_id = 1;
 	default:
 		break;
 	}
@@ -1492,32 +1458,39 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
-		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
 			 IMX6_PCIE_FLAG_HAS_CLK_AUX |
-			 IMX6_PCIE_FLAG_HAS_PHY,
+			 IMX6_PCIE_FLAG_HAS_PHY |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
 			 IMX6_PCIE_FLAG_HAS_CLK_AUX |
-			 IMX6_PCIE_FLAG_HAS_PHY,
+			 IMX6_PCIE_FLAG_HAS_PHY |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
-			 IMX6_PCIE_FLAG_HAS_PHY,
+			 IMX6_PCIE_FLAG_HAS_PHY |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 	},
-- 
2.34.1


