Return-Path: <linux-pci+bounces-1103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F6A815D76
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1F21F22376
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CF91863;
	Sun, 17 Dec 2023 05:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NIOa12n7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901A139C;
	Sun, 17 Dec 2023 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPdXdxyg93NWmP8RfVevCk2WIsN0KD8GhWNuIw05tFOkwDeI3XNK73KivHTkjybo78+nPEqthzue+TBftN5w3pa+ZWtPlifucMpMsGcvMjB/PD5oM67BEcjM62++CxW//AxvoyXctwRTG0/sYEsbQs1S4QTTU13GlLlumKxrMgf2/jIaCbtk/fiz+CsDIXdTVhucAOalldXeXgLX9iJB0sjTexfXK1O+259ndwfvOGIKQRYvEPJmCQcvtbTZoypTx9DemuglGm+jlA5OYDh8oB1G4LP3AG+rP8dycCbXFveYHp39dIz0WRsxFf7xziBcXqsbMFwMWChVSCwQw9zPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYgkWGTzhe8+TRNsiCpu3kyIeAmjvzoNn4lspQELU5E=;
 b=GDxmtPJtdQF6soz+yQVo7MiH5Ec6bIsiHFzSkrxM1LG5Mt7lb5OrVEeKSFFPi0/A1Pb/Vooyklq5V0LmcZwvH1+0X2GvoZMZaOBvZocyW5Xeyg7etKrl1gO6CeTrd9UZ9Rt1JlS95OqP9t18mf004KJow7nrC7rASmQn/VxwS2j6clWMOZlZ18WVa6r0DE6ubvW4rOlQCWcNEyswviI1jERDp+QMUL5T5ljJ0EIu0dc0UegPfcfiMuLl4V0Q2rnDXRpyMtk75vkLjjybmNnJ0GvMQ+cAIA8NELpYunk6i97UKwa5Egj9vCHLZiAJpvH92RneXXVzlfQ90EoljFa9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYgkWGTzhe8+TRNsiCpu3kyIeAmjvzoNn4lspQELU5E=;
 b=NIOa12n7f/NcgJefzOwtqUDTTvgvAIAHDl4h83il28x1WXbJZynyF5JR7kPFcCl7uGbxWFdqygXFGrDQFl6LObnU4M+08CZRvPwdGpz6rvdyVOFv5eJyciwy6Xwv58TsiDSpSqXmiKWFOhBrRRqcwIYDD1G5ZN/l0E3NGixuIsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:12:40 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:12:40 +0000
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
Subject: [PATCH v4 01/15] PCI: imx6: Simplify clock handling by using bulk_clk_*() function
Date: Sun, 17 Dec 2023 00:11:56 -0500
Message-Id: <20231217051210.754832-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7428790-92c9-4d9a-b92f-08dbfebecaf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yk0nyvj5Fe+dAQv7WJbMQjEo6S0wgjPMM9nJTD1xWzUhTS6c/hTC9NZNXfod5K1SHDcPni09tsaApeJPYyTNOW1FGHGwNin9IXPcOPMDXOQQmSfDt8pbxBHSkqIv1LOkLc5L0QzYSLtGaaMl9phZchMlo1VPj/M/8kxb4Gs1hXpc7y9M9oKdUkkzWfn/f1j+ZPMWg25wTgD0Z/bXE/DdIaMX2lgYrryrkCp4goj/QrDl+QL2FGPkLkTxryaesWmY0UowCBZLzZZrtV2VGyzXklROFoUWiw2UFQFTdWJNG+HLbMDpgNYKSK+1cIKqmKN/aWvMxMvKuK6IfBZdLfOSMjbYAeOJWtEr7DaOXK9DZ0JiFaEd1Y1EUl5QDiOpER+rxHCaqX5jU741UIBfcJkRBnfDN4npyiae34oMiJx7PCCN5smBgTXY/IETiiv1H7DceTsfEH9x3lg6DOhJrr3vFL/xbU3h8OuXvIG/XCst+w+Y+b2jxPFHfxMqpTSyi76MfWHfRH2txK7mvzgjfNu/4Au+ky7bd4/aE/Y8smgY2VfT7zf3ORMB0uiikvq4D4/OfD1yPNwvwyoGvsm2nPlHHcBeIz7WarKMilgXO0RM5U5R+lrUVveuhfW90MnM1GXz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B857CR2NBQKsHkQ8KDW9Cq3Jo3WWVwfHwbv1AYffEiH+MHxhvcmoteUnWlAK?=
 =?us-ascii?Q?1RMbzihDDZtRzHRCCxKF06HYyBDd5awV0fxNolsFVxL8hbQYLIDlfDWCt3Vn?=
 =?us-ascii?Q?d9wMrFfQ2/KUsTdR5XhWbeF5TsFQtEybCVkPGKojhKgLkyQnKND8nOSC0vVF?=
 =?us-ascii?Q?Q0hsKWNezKWDIYOxWBhw/B+xmLiSD6Z82Qrcn2H46LrSxXxmLebkxcziFN1L?=
 =?us-ascii?Q?myR0O8k/b926Y2ey9Ie2vdaAixs3dzFOn+HXQJHVqDzMBxAWRUZN0ElZerDd?=
 =?us-ascii?Q?sbcahj/pOI6kKRTfPUU6r1eRGuCldYMtaulSEjvdhIZrP9Xass0rxKuK48nn?=
 =?us-ascii?Q?A5bfgH4/WsggP/xfy1LGA3ogtCupaNYwZGC3aNMjjb1KRpqnJcQno/YO3pRA?=
 =?us-ascii?Q?JyrL5I6g4EMb36pVRV/jOBgnD+W3qVG3kxPyjhJB+CqhJx2EEjxS7xyLK1mi?=
 =?us-ascii?Q?fKohvGlkp+ecMbylnNg1/0waEusmDtIADFlNJQwzWsi7lwFIu5hGO3OjI/6b?=
 =?us-ascii?Q?p5mumo4BLvozFgITSHuC6zLHeKMdjfmHuBb//ULacANpskF2BM5vE/GdmRLc?=
 =?us-ascii?Q?eDlTKjkeWzWdpzCFJObdvn784BwoLVCOu2iPIPrCls4IlQ9xUmi5cDPeJ7I8?=
 =?us-ascii?Q?kG/U9d/NdPadNtDQNq77+JlvL0ttR0nOx4aoNLILX0fG+DgdA2MQwDS0JLdU?=
 =?us-ascii?Q?1aYRml7m7621fgH66Ycc8jLjp6I0QQ2vW9Bi+RhbysFyaml3I//n6y709Cof?=
 =?us-ascii?Q?i6HxjmxxkH1Q/8u9cinOSUkCDWsSTe/+zJLKZmdVrrACXWzYt8OtwnV2NsII?=
 =?us-ascii?Q?dWWjiRm98jLfg/hUh9d3jy3SozlJ6Qxw+wY5cPDgUCkuyOgMQxIvgcey6VqU?=
 =?us-ascii?Q?npgwcPYsvcX9wn/Igx4YN4A5bsmuxznzmDfkbR6S6Mhy3WAssGBZpsbOeWbN?=
 =?us-ascii?Q?luNbWOuH8IRhJqQ2HCAFlg21oTS+g12bx7zitfrdfzPb5W+wScm4o66Ld/nj?=
 =?us-ascii?Q?94QJkZi90q9ULAK3SVwAEcfTNMqBeN733KJ65WblGymFw8cYML9BYsRXkODS?=
 =?us-ascii?Q?PtiS9UmbkWdYOsNCRvoLspiSrIpdlqeXTpG4F4/OsPLoz4p7TmTkV4tHoPww?=
 =?us-ascii?Q?qacg5xKwwTjZoPhEH6Du8taNp3Xvxqq5p+ritN1OumBlHXpVHuWk96hgpngx?=
 =?us-ascii?Q?danQLWbKrCB2pVtIApapBlWbMGxXQtBaTOA9V9QmKCBtDLQnIqrwBwkgGBwO?=
 =?us-ascii?Q?7vO2lC+Y6Ujkl6HPEXLHtLKP6NGjAVNscUhjlCWy2f7Zg6hGE77Ns0nqcl7+?=
 =?us-ascii?Q?CC2P2p0Ucw8d6/td3Li7s7JptM2yPXNgfWv9q5eLrij+htGzO7ApVi7+qbT8?=
 =?us-ascii?Q?Fkt0yJms6avqrNkBgekmSX8hMjELqNHki0RYw13jOTKi1kA9MIdFpNt8VlDy?=
 =?us-ascii?Q?t++tanPeNQr0bGwFrEiIZD2F21QuljyLClHFZxiVgASylrhv28lGIa3U6z9X?=
 =?us-ascii?Q?cf5C2SEnXc8cy/0pwRMvOpv4j98vf9lIJXxacPSLKDnh7hPxiGjJkm58TpMR?=
 =?us-ascii?Q?gni4a1XQOmcRN/LYgl8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7428790-92c9-4d9a-b92f-08dbfebecaf5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:12:40.8523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNStehkinXDRkKe7bHU2lVFvP40aLcvBpD3z6S5qMl0fdR58RKT27LsIQbDlXJwUhpThsSBKfJ6MmHdOqfsAsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

Refactors the clock handling logic in the imx6 PCI driver by adding
clk_names[] define in drvdata . Simplifies the code and makes it more
maintainable, as future additions of SOC support will only require
straightforward changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - using clk_bulk_*() API
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 128 ++++++++------------------
 1 file changed, 38 insertions(+), 90 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74703362aeec7..2086214345e9a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -61,12 +61,15 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 
+#define IMX6_PCIE_MAX_CLKS       6
+
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
 	int dbi_length;
 	const char *gpr;
+	const char *clk_names[IMX6_PCIE_MAX_CLKS];
 };
 
 struct imx6_pcie {
@@ -74,11 +77,8 @@ struct imx6_pcie {
 	int			reset_gpio;
 	bool			gpio_active_high;
 	bool			link_is_up;
-	struct clk		*pcie_bus;
-	struct clk		*pcie_phy;
-	struct clk		*pcie_inbound_axi;
-	struct clk		*pcie;
-	struct clk		*pcie_aux;
+	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
+	u32			clks_cnt;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -407,13 +407,18 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 
 static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 {
-	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
+	unsigned long phy_rate = 0;
 	int mult, div;
 	u16 val;
+	int i;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return 0;
 
+	for (i = 0; i < imx6_pcie->clks_cnt; i++)
+		if (strncmp(imx6_pcie->clks[i].id, "pcie_phy", 8) == 0)
+			phy_rate = clk_get_rate(imx6_pcie->clks[i].clk);
+
 	switch (phy_rate) {
 	case 125000000:
 		/*
@@ -550,19 +555,11 @@ static int imx6_pcie_attach_pd(struct device *dev)
 
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
-	struct device *dev = pci->dev;
 	unsigned int offset;
 	int ret = 0;
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
-		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
-		if (ret) {
-			dev_err(dev, "unable to enable pcie_axi clock\n");
-			break;
-		}
-
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
@@ -589,12 +586,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ_EP:
 	case IMX8MP:
 	case IMX8MP_EP:
-		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
-		if (ret) {
-			dev_err(dev, "unable to enable pcie_aux clock\n");
-			break;
-		}
-
 		offset = imx6_pcie_grp_offset(imx6_pcie);
 		/*
 		 * Set the over ride low and enabled
@@ -615,9 +606,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
-	case IMX6SX:
-		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
-		break;
 	case IMX6QP:
 	case IMX6Q:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -631,14 +619,6 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		clk_disable_unprepare(imx6_pcie->pcie_aux);
-		break;
 	default:
 		break;
 	}
@@ -650,23 +630,9 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 	struct device *dev = pci->dev;
 	int ret;
 
-	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie_phy clock\n");
+	ret =  clk_bulk_prepare_enable(imx6_pcie->clks_cnt, imx6_pcie->clks);
+	if (ret)
 		return ret;
-	}
-
-	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie_bus clock\n");
-		goto err_pcie_bus;
-	}
-
-	ret = clk_prepare_enable(imx6_pcie->pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clock\n");
-		goto err_pcie;
-	}
 
 	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
 	if (ret) {
@@ -679,11 +645,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 	return 0;
 
 err_ref_clk:
-	clk_disable_unprepare(imx6_pcie->pcie);
-err_pcie:
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-err_pcie_bus:
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
 
 	return ret;
 }
@@ -691,9 +653,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
 	imx6_pcie_disable_ref_clk(imx6_pcie);
-	clk_disable_unprepare(imx6_pcie->pcie);
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
 }
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
@@ -1305,32 +1265,19 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return imx6_pcie->reset_gpio;
 	}
 
-	/* Fetch clocks */
-	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
-	if (IS_ERR(imx6_pcie->pcie_bus))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
-				     "pcie_bus clock source missing or invalid\n");
+	while (imx6_pcie->drvdata->clk_names[imx6_pcie->clks_cnt]) {
+		int i = imx6_pcie->clks_cnt;
 
-	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
-	if (IS_ERR(imx6_pcie->pcie))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
-				     "pcie clock source missing or invalid\n");
+		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
+		imx6_pcie->clks_cnt++;
+	}
+
+	/* Fetch clocks */
+	ret = devm_clk_bulk_get(dev, imx6_pcie->clks_cnt, imx6_pcie->clks);
+	if (ret)
+		return ret;
 
 	switch (imx6_pcie->drvdata->variant) {
-	case IMX6SX:
-		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
-							   "pcie_inbound_axi");
-		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
-					     "pcie_inbound_axi clock missing or invalid\n");
-		break;
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
-		if (IS_ERR(imx6_pcie->pcie_aux))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
-					     "pcie_aux clock source missing or invalid\n");
-		fallthrough;
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
@@ -1353,10 +1300,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	case IMX8MM_EP:
 	case IMX8MP:
 	case IMX8MP_EP:
-		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
-		if (IS_ERR(imx6_pcie->pcie_aux))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
-					     "pcie_aux clock source missing or invalid\n");
 		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
 									 "apps");
 		if (IS_ERR(imx6_pcie->apps_reset))
@@ -1372,14 +1315,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	default:
 		break;
 	}
-	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
-	if (imx6_pcie->phy == NULL) {
-		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
-		if (IS_ERR(imx6_pcie->pcie_phy))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
-					     "pcie_phy clock source missing or invalid\n");
-	}
-
 
 	/* Grab turnoff reset */
 	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
@@ -1470,6 +1405,9 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	imx6_pcie_assert_core_reset(imx6_pcie);
 }
 
+#define IMX6_CLKS_COMMON "pcie_bus", "pcie"
+#define IMX6_CLKS_NO_PHYDRV IMX6_CLKS_COMMON, "pcie_phy"
+
 static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
@@ -1477,6 +1415,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = {IMX6_CLKS_NO_PHYDRV},
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1484,6 +1423,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = {IMX6_CLKS_NO_PHYDRV, "pcie_inbound_axi"},
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1492,40 +1432,48 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = {IMX6_CLKS_NO_PHYDRV},
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
+		.clk_names = {IMX6_CLKS_NO_PHYDRV},
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = {IMX6_CLKS_NO_PHYDRV, "pcie_aux"},
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = {IMX6_CLKS_NO_PHYDRV, "pcie_aux"},
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
 	},
 };
 
-- 
2.34.1


