Return-Path: <linux-pci+bounces-2382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAF5832DD0
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02364B21151
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505C85788C;
	Fri, 19 Jan 2024 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZS1HULRb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFAB58120;
	Fri, 19 Jan 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684349; cv=fail; b=jnWgAUbCn/pSvxfoChrmNBXfxuPRnRXyJY0PQxT2OU/B2MK8O2/s5wQqodzhT22XxG0IeDXkn/A3+aYxmQRIwEFs9sERTk3BnXwR7/HX9sgGQ6TQIl6MeHmGIZCgZSKdsIrf+7V0F5ibSuhtyrAZ6ZlZ33UyklAlhzdHNoGMkqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684349; c=relaxed/simple;
	bh=XuJIizYV7C/PxO687u+1PgoMsekAR3XtwdptKJQrlkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iExO7bL6i2UrVnkdpcJ0d94BGL40+6/qUaQuoM5p+4ybG8x0vblWILxzBCTEuAhQh7/7NG0OsU5dS0Wl+N/2/7FiwFIYaxSg+iep3292ddI5+ibloHENMO5UbkOCaZvwA1IGy6HnGdpV7357icO9XbbCSA0fHOf3u5y1BVDotzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZS1HULRb; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIF9ZGtZPkGXcefrXCBVvTn/6msdI3v0w2+PGy4nc7ahc+7Yfh3PtIYRDoJZ9QslS6RB+E90rfc9njo02jeyUuTTdDB3w2mADgIHC+n/ISP0weryGqKaXG5Ff1Lh1PihGstznfjzlTmBRJ7KeKuhw4ELVxxUg696zRvZv6T9noi81Zw/XTVaToDz6ZyPeNCtTYspDz+KsSBrumXy8F2wbIoHqQijCCMSnRv7g6AjZnHBHjdXqw8QPl63UzU5xRKUr0asNsAqArSW+J7zEGkzaMLbwno+fPH+CBXV+SJ86kG9C4dtaSAVmm/54mVArYfiuavdq74hYWgO0e2TxVoWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPowD1fZYAo3g+e95PVHjzwdyYKOPoze8EZg60txha0=;
 b=T9OHLeXQ8x8JiwY3iqv0baCV3HGeB6IfL9jAiIHujhNjUM0JGOd/ebBkaJzmLMfTNnFSAt7V5HRGM4rWlV4GyDaCjn6PqAc7UJyPwjtNpngutSLdbPg4N3feginsKxKnfkL7Zf96uwd4XIFzuhFMTpm7zJk1Vv8c0Py25YtIvtz0YsGru3+MQbvqW3k/MudTNzNJivBtSttLWMRyzc4R9X17uqvEfeh2IPt6pkvlPtYB5JVgRF5tyDUzVMr6uArliEQOFRT3u6LfLfkKRX7Dbhn1cTWqeJ9QWBOThLakPRA4K/mtyxt4Zk09SkvrDUBy+7CoEBoV3iwq5nI6khVshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPowD1fZYAo3g+e95PVHjzwdyYKOPoze8EZg60txha0=;
 b=ZS1HULRb5SXi1hfoEZXWUfIE9YfTpEVAv53ZjhFdgJqmYKmmv6qLtISotGb9UUGu1XKIIByNiTy1aNzKxkDzysAGDUnANdCniM4gYl7PJVbRc1ahu8tv6yc32DPT9EGiVFcB0uW7LUq9lfWdLDkAffdWXB82gufHbLLsVYLU8+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:24 +0000
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
Subject: [PATCH v9 08/16] PCI: imx6: Simplify switch-case logic by involve init_phy callback
Date: Fri, 19 Jan 2024 12:11:14 -0500
Message-Id: <20240119171122.3057511-9-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7b6ece5-f347-438a-8105-08dc1911cde1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D/bT2waEiIdZRNGa8ykTE4/YMKraX9wQl89B5pnsPxh9l/0bi/+C7DKAYseCJxe+FQodzeOejSxrTBeSIBwqm/UVcsJlL9yPsNL6YxPMsR6fcvFrEOlWMl7CYoqPtfiLZc5P2aKf62R3KYCwJOS8NXrNUiSTxoXTkg0WKHct2sArR+QYM/T5ILOBcXf6CpvwcpP1gflSQGYamSMoZeZAWrTg8Ch6AKIt9wxH81VDiKwXFC+QUvGYXHTGIKplhtyHnDVOz4zKkrG+KoLJaer4PjQAVMRvgRsj9vdLSt7pDbvRNAjP0rqc+xL0fjBdEqJgYbdp+IGj+hCQLxKuH1uQvWjpRGFQdBmS+bxV0J8VLgxi7aV6K3WhCb8svS2EevxLKDcEKOOTy2rdxL9yyf+tV7aqF3LyoC8fLRCtFOgQ6KHxSFCt1NNQNkHXM0Jzgzh0nWRXuSbNVsnSElb+gBfhMI5hsHfcK2nGl8end52kWjIJ9uyazMZvKvb/W4zZE3/2wzk/YwnnPHf14szbK8lzlFQnWakLaegQSngw8Q6fknRp+QCzIlmDsKKf9iPVIkjsNQsux98R5rT3uiTGR7KNU+6uiTnp+ji+ABZ7fqbdPNgyrGMv3vv2I7PXRtxw1ggphDT+hlIt937Q80b3LoRwvEtPeLfUY/ORvQGj98EhT6s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zTm6e+YWQRizjrU7LDQxQh9J4fWHAf8k0yCsRPPvM1+y0ppV3alKe/CHy3g/?=
 =?us-ascii?Q?JOi+Gmaz0TyO+Da9+mV2s+SOChdfZh9TBIJkrTCON+hXA3RPSGVbDMzFyScp?=
 =?us-ascii?Q?F5/lHy0VGa3PzXOc/kGd2BNUO4WUYviPP05+O/DFzhJQJMb13c83ohoacazg?=
 =?us-ascii?Q?x01/lUoffVVUlDM4HWHO9iecjR8hYkxk66+RJPAZFRmzYTSXVrm8KQEjiuAz?=
 =?us-ascii?Q?OMmn54CzSO4jZwdT03vMw9HdXjx+z/GTvJ0f2a0KuvqlTJuiXGJbS7o/hEq/?=
 =?us-ascii?Q?twfpuMUAXpOCvERfVJH0xmelUVkFzfRhLYLn1i+hBZWBed/8k+RUfQ2UZyaX?=
 =?us-ascii?Q?RRYSm2Dx6e6QeA+OcvFmB23mOiok70DlJ4RruUxCHUOPPgnt3060I/rjHbh/?=
 =?us-ascii?Q?//sF8MKMoxOt7v4HiHddWaXm6zkSuhzWMfry8eMG6LhLksgVNmLFZvemo1nO?=
 =?us-ascii?Q?v84gnhbJ4qmoCVFoy5O3fLD0Arhoauc95dbZVl8Dnc9VP5Y3NJFr52hrdaYw?=
 =?us-ascii?Q?10l16BDb9zhtim1Tv0023wtHGlcgTm3CyUPMj/0FEsXt3XYYQ3EAKhxD4ZCa?=
 =?us-ascii?Q?4l/HamDe3rlGUTNR8lLwANsp95qwVDnb3KTAVBkR1di5FWpoF9yLveXwaDcT?=
 =?us-ascii?Q?xBWuGBpzusaZPx5ccathlXl1v/BMWf3YeJy5CJsZb5FMJqdMjOmKg3o7vF4H?=
 =?us-ascii?Q?PNRVkps+TG6Sl5xkuEDkLfs/Wt9K0Jmvu4NYmxJCwrgJ9YvZp1mr1e4C0Ahb?=
 =?us-ascii?Q?nXP+3inbxMyXHHhjU6AEk3gh1kV/TMR3gcGIlLUE+7DM82a/7T/Hg2A06Iju?=
 =?us-ascii?Q?XIOIdUuKG/WcxuUYwxHtmj2QPNMnQF6HpeQ0c6a39dlupW0POb/+9u6fNe5l?=
 =?us-ascii?Q?7OLzy7BTWQz3oIs9AwFteGW9qlqxKiShCSDs+tJMnNsHNnss6Nwhgn+1HJ6U?=
 =?us-ascii?Q?PTFV8Y8koZ5xqBlA9i++q+WQqbolNA8t7gYrJU15KlOEPYIsORNZ+Yosw6Ew?=
 =?us-ascii?Q?ChppFFJhbkkJlkFLgeHuANNp5+9c5f83WhpHEExCvus2wbIdqU6FI+w0GFjK?=
 =?us-ascii?Q?GRT2pgmFfIawUj3QIctTfTbs77bEdC2dhlTvk22ihD1Vy514/s++n8y6LC5i?=
 =?us-ascii?Q?qQWPG6pSkslMjWd+77yK4IKyVrP/oz4DlzhzabdpAWmT0usErXMidnabNM89?=
 =?us-ascii?Q?9gOId6/q9TbPmN1Mj2DJGsATjZbvrpVC94a4Oue8ky9aCMkFvNu86egv//7N?=
 =?us-ascii?Q?Uz7+CEPkr2CpIc3Kmb5nFxmom7rSpWH/vGyYrLMvRE3whXGgP9Inc/zY3oXm?=
 =?us-ascii?Q?4obdgISibrSAfjL01HT89pWNj99qe9+ZqR7tDLNW4R4WWw5fxMPD5QPY3Irv?=
 =?us-ascii?Q?HBgfDibP8qpj/EjZT1OWfEaYm0lumlt47JxB93Y46sLBuvU7wa4gXI8blUMg?=
 =?us-ascii?Q?06y1kb8vy2IwL55SstwYmQDeLKvyp6ijD2c7Nu9nUoQItET5gnYZkqx70fyL?=
 =?us-ascii?Q?RwnqiHndwHA0niM3kumc0tWNfi9KTCy17IkEdCBozBGRFTbf/jAeuDjsfzDV?=
 =?us-ascii?Q?lDEez/w/9HL7e2QkTS4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b6ece5-f347-438a-8105-08dc1911cde1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:24.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q94hOM4BfZauj2/sQgdLcPx84a/N62llm9i9ylgR+j6crSO3BOULCnA/oXPz+nR8W7Lj+DYfB0dbJusHxhb8TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

Instead of using the switch case statement to initialize the PHY handled by
this driver itself, let's introduce a new callback init_phy() and define it
for platforms that require it. This simplifies the code.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8:
    - rework commit message
    - wrap comments to 100 chars
    - return 0 at imx7d_pcie_init_phy()
    
    change from v1 to v4:
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 134 +++++++++++++-------------
 1 file changed, 69 insertions(+), 65 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8df07b71c93e5..dad192f38e702 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -69,6 +69,9 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_MAX_CLKS       6
 
 #define IMX6_PCIE_MAX_INSTANCES			2
+
+struct imx6_pcie;
+
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
@@ -81,6 +84,7 @@ struct imx6_pcie_drvdata {
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	int (*init_phy)(struct imx6_pcie *pcie);
 };
 
 struct imx6_pcie {
@@ -322,76 +326,66 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	return 0;
 }
 
-static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx8mq_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		/*
-		 * The PHY initialization had been done in the PHY
-		 * driver, break here directly.
-		 */
-		break;
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		/*
-		 * TODO: Currently this code assumes external
-		 * oscillator is being used
-		 */
+	/* TODO: Currently this code assumes external oscillator is being used */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			   imx6_pcie_grp_offset(imx6_pcie),
+			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
+			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+	/*
+	 * Regarding the datasheet, the PCIE_VPH is suggested to be 1.8V. If the PCIE_VPH is
+	 * supplied by 3.3V, the VREG_BYPASS should be cleared to zero.
+	 */
+	if (imx6_pcie->vph && regulator_get_voltage(imx6_pcie->vph) > 3000000)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr,
 				   imx6_pcie_grp_offset(imx6_pcie),
-				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
-				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
-		/*
-		 * Regarding the datasheet, the PCIE_VPH is suggested
-		 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
-		 * VREG_BYPASS should be cleared to zero.
-		 */
-		if (imx6_pcie->vph &&
-		    regulator_get_voltage(imx6_pcie->vph) > 3000000)
-			regmap_update_bits(imx6_pcie->iomuxc_gpr,
-					   imx6_pcie_grp_offset(imx6_pcie),
-					   IMX8MQ_GPR_PCIE_VREG_BYPASS,
-					   0);
-		break;
-	case IMX7D:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
-		break;
-	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
-				   IMX6SX_GPR12_PCIE_RX_EQ_2);
-		fallthrough;
-	default:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX8MQ_GPR_PCIE_VREG_BYPASS,
+				   0);
+
+	return 0;
+}
+
+static int imx7d_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+
+	return 0;
+}
+
+static int imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 
-		/* configure constant input signal to the pcie ctrl and phy */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
-
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN1,
-				   imx6_pcie->tx_deemph_gen1 << 0);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
-				   imx6_pcie->tx_deemph_gen2_3p5db << 6);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
-				   imx6_pcie->tx_deemph_gen2_6db << 12);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_SWING_FULL,
-				   imx6_pcie->tx_swing_full << 18);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_SWING_LOW,
-				   imx6_pcie->tx_swing_low << 25);
-		break;
-	}
+	/* configure constant input signal to the pcie ctrl and phy */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_DEEMPH_GEN1,
+			   imx6_pcie->tx_deemph_gen1 << 0);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
+			   imx6_pcie->tx_deemph_gen2_3p5db << 6);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
+			   imx6_pcie->tx_deemph_gen2_6db << 12);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_SWING_FULL,
+			   imx6_pcie->tx_swing_full << 18);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_SWING_LOW,
+			   imx6_pcie->tx_swing_low << 25);
+	return 0;
+}
 
-	imx6_pcie_configure_type(imx6_pcie);
+static int imx6sx_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX6SX_GPR12_PCIE_RX_EQ_MASK, IMX6SX_GPR12_PCIE_RX_EQ_2);
+
+	return imx6_pcie_init_phy(imx6_pcie);
 }
 
 static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
@@ -902,7 +896,11 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 	}
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
-	imx6_pcie_init_phy(imx6_pcie);
+
+	if (imx6_pcie->drvdata->init_phy)
+		imx6_pcie->drvdata->init_phy(imx6_pcie);
+
+	imx6_pcie_configure_type(imx6_pcie);
 
 	ret = imx6_pcie_clk_enable(imx6_pcie);
 	if (ret) {
@@ -1382,6 +1380,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1395,6 +1394,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6sx_pcie_init_phy,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1409,6 +1409,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1420,6 +1421,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx7d_pcie_init_phy,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1432,6 +1434,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1467,6 +1470,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-- 
2.34.1


