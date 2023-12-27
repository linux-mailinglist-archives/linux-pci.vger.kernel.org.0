Return-Path: <linux-pci+bounces-1464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B6381F157
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0D01C22536
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED30C49F76;
	Wed, 27 Dec 2023 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XbsupIrF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4547F73;
	Wed, 27 Dec 2023 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrF6R8QM3laeYPT1RB8eGiVUXiUASH7d7Xuhi+P0ip5TwCqu94v9h4ZnDlCTLWIney3Vs8HzxAQVyokaBVm9stI4LPfZqoQyx80cWQnPrRNw1Hw+WjktkY4QEtrAmH8uU75H0w6/sb7McnY1Yv9srOCue2AqXbrwqOCjY57JA3+ZHGweykGiHWNmqPtJYpzf8fUqWFlGhjKHsWfkGE9VIDtBTawSmruI1lHeGc7baq1qHfTcZeqG6PW60UX9dKIA20ZN4Ne9UnxrWrroYmvvapdGtJpQfPaCO1Zth98Z9wYLcihCMZC2yNlCrBEKjlLFX8CdfmUNGptSJlUZCPKoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4dgn8M+Jk4NmcR2dQdTU9AyWvLkmV12/ZAFatSQuWg=;
 b=Zl//eFJX8KncF7srzpA547VFCN6+nEsS/ObtOxEq+66f6zbCKiNtxA6xbefBdB/eRh6BFDGGZy36gh9uiTBNkX+9TMj2oW3v0WlEjXldh8eBUgXPBnAR9mB21jV3jlhzLvLuE/fJ/tHt6fFNTAqmbeXrIv3NAkU5FCS4L8NOm3AtshhpnBj1Kl9SFypD2Q5SCHWIK7/I1PLkUWvpTUZOm2wKZqVdG9l6LgmaPhU2VCg9tQRTPcL42oxIrzYrYqO870Ov4b2WITi50uoCj9r0tZ62JqI626oABwWbVLCk7RDNyhe11FNGlUw0942rzXm46nDbepBW3W/7xIFLw1GGyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4dgn8M+Jk4NmcR2dQdTU9AyWvLkmV12/ZAFatSQuWg=;
 b=XbsupIrFvDKzvAd5+co88prEJ2nQA2TQA2F15CuukUdNlyLk+ToFWk1ta8RbiJp9h+tvrXX8zdyqp2wTuNDoptZvabcUnvJVcwE334ZlPiVZ7rh3OLSz0qMg6cda9S+TzH6XZirwi60ZCCmHRsoeTVCTcM6bdosd9OiPWva76vA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:53 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:53 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
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
Subject: [PATCH v7 12/16] PCI: imx6: Add iMX95 PCIe support
Date: Wed, 27 Dec 2023 13:27:23 -0500
Message-Id: <20231227182727.1747435-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227182727.1747435-1-Frank.Li@nxp.com>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f1a733-7a25-423f-816c-08dc0709ad9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	78A6wyKaEfUydDIPGsiaizZVnVWBVlR87Rhm1AtXFTX9udUp0hiX6/4qRq8KmRq7Ix/IQwFtTeOk7SFa9wOEBcsKiXvvVD36kddRbnYtE+ht/EMUW9huDezXlgDDxb6CvdPkxA5ToBn0n1W84BW4UqjfxatrsTHsuDay+wAyW9kYkT3V7SSy+KWxzKD/TFk5x2RYLU0dGcK4GKALB6+ysDnSzmckFd8CS+T/ByWC/y1cilCk0GM0eYF+D12bAY0036yqncDof/skUTxp6B68OhGOT1iivV9G9RYc2dXkjLIn88P14+QktvzWHVD5hzneYFF+VR09NPyG+L//n9cFzdpGpEZWrriaEapon51cUmNgjlHHOHSf193c5HmkjlLXj/XxS/JCQ3XCtNZrd2pIOxT5aYgbaf9n4bVzpIJZ4gJnbNj8AFQV/tnajOdmkd1MKZyQe521rOqiaF/3ZdNRvyT6KUkbJmEzguxwPPTwbBTA859ui/xumY9nwZ/MYMkJg909sI44kEYdDoGwl+GUlEneDJpEAowNQPhmrGPeKKYGpjtgRV/drKFGFW2UPO6LwVw0jRUcJegHVxMENGsTm34rf97zUKEte/4EKz81T2fDXR5xkIxIqB7AK2KRMRsz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XAZRxNuLdas/AagOutqy4xrGUGTFYC3uGJAI8S1xLPkqhWACJuyXP8TWnESt?=
 =?us-ascii?Q?y8c0hzbjg3tP/dzFLyIfvSO+kkR3847m0xTBChMwNCssI0o3GHKKivWl7nq/?=
 =?us-ascii?Q?EQMDt414SxSQ1layqfoPytwEFHZh7kSQ+bBVA0Wfnq9OpljTv1E81J1k0Dbe?=
 =?us-ascii?Q?Bfv3KWL9jh4RT3RU+N/M9zhBI7ERXoEAIVT/+tsEek0JXDvtla61q1IikBlB?=
 =?us-ascii?Q?MQ0pD8FqzmEXDEtJ+Ow5hkNdRqrQ+6ykh1m+MOljn53HhtuTd8gNAR5UufZT?=
 =?us-ascii?Q?9zCz+9Q4hlGJpK1ItxT6C6XcptiSGGNBz0S+GywHNGFeSmdNytCtNpwSjBZs?=
 =?us-ascii?Q?o8bhIYxwqvAu0TRm4N8WgH6IFjDfnUAxT0bwjHQqauZbOhfD+uZ1G9Z+LKDs?=
 =?us-ascii?Q?cEtA8M81K+kiKteC7+oLBEsXsZwrJBxlEhoqgr4dxU08/7Cg7sciB1qKnmF7?=
 =?us-ascii?Q?mXb+n2eivt7O3GnaPRI9ejxy9oe5vlcabEVdw9n7CmQiJEdNmLNd/ShguS2N?=
 =?us-ascii?Q?gJ8TRp26UoHIX/3iz3pMmwdayfmugfFhTRnmMLShfj4iabdk3YsQAoV4V1vp?=
 =?us-ascii?Q?hyouXauuLlfqabc5qX7nnvrSNsu77QKRCDg6ox4RX/Nnere1IE1qKU61UDHi?=
 =?us-ascii?Q?kLKXWFMdv3TOM9A2qRg+V86SSOYFT1fvjM85bhSr36VOtFCgbwyqDEnSwudv?=
 =?us-ascii?Q?CYELaUivyaL3IVwBDfmPDB9kJ5BxI0aGzCkmZou66tlLGwSOcaW3XiR/08y1?=
 =?us-ascii?Q?OwIouovomr9THPWV8hklxp+SypqeMulOpz9PiFg/U7b/4WG41nPG7E8c7gYv?=
 =?us-ascii?Q?mdCuBOigUdFguqm8lFN2eXhLhUxcyi7dv11jn7xKQ4vvVHf+8CJp9Z9MYu/I?=
 =?us-ascii?Q?uFKtnQWawyMifXGDRJoAjIWmtrLH7UZDfDmowhbfEjNMAdF9DKmqJ/IrI/M1?=
 =?us-ascii?Q?V79+1u/Wv5hw/9rRQh2arJH7mx4KKkvCOioKSf6omJ9fdi9UTD7n6gM0j9Ip?=
 =?us-ascii?Q?hRs+YZarFd7LYRRz8lcQEwUDG+vvGicRLWSHgZoUOLIP0wZVjeTLCNBf92Zb?=
 =?us-ascii?Q?RTQutzoQ9//C9CaBoy0eQTa4SUXdPRI1CMc/LAjbOcN3cSSbikKZFwAqcNsH?=
 =?us-ascii?Q?1uTnn3dn3Vs3drYBXijmjsSo3ZAhM1qZa6oTpYorAWQeAY3STGUb8kLdgpdn?=
 =?us-ascii?Q?pq2dBYeu4DqodPsnnarVtMUvlgM2o8lKdvKuzJ5gqgqiXdiv/8+Ruh/wsReT?=
 =?us-ascii?Q?6C5zAIdEbJpW+jPZ641rPlGoAXhUZeaayci9LcTY6xHnXIGDhotM/Sq2V51k?=
 =?us-ascii?Q?DBlm4pux6RlYMxXveN0/dJEjLqxlh1nQlLLRHWBQVmjyah8Cv/bY17ilZkvk?=
 =?us-ascii?Q?t31FcRa3Jsg+Gg+rhFuD1lvGsmbZOEy5Y1QdvXJj0tVDaOUIPNHviUMvpVkO?=
 =?us-ascii?Q?9yy7KXqBhb3P2wyMRUSTiUvc7BdweSlrrC7LD2O9G4GwDZvakh9iVBKndrhU?=
 =?us-ascii?Q?XsY4VvoZsxF07m3W5OfYxvw/V2RtQiGjX4ehGX9A+WgNe7Ikacs+slVKjUJ2?=
 =?us-ascii?Q?C0jQk6azBSptNrN78Yc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f1a733-7a25-423f-816c-08dc0709ad9f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:53.0454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7pofAS9Amwgekcu5CjhX/Y0mthWNDBEHGxnwMEaYgBvbh/PX24yFddzR1SRC8JDfvXUEogL1nAYZEc6YvPsiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

Add iMX95 PCIe basic root complex function support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 90 +++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d66a2db53bdb7..9e60ab6f1885a 100644
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
 #define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
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
@@ -579,6 +618,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
 	case IMX7D:
+	case IMX95:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -696,10 +736,19 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
+	u32 val;
 
 	reset_control_deassert(imx6_pcie->pciephy_reset);
 
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX95:
+		/* Polling the MPLL_STATE */
+		if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
+					IMX95_PCIE_PHY_MPLLA_CTRL, val,
+					val & IMX95_PCIE_PHY_MPLL_STATE,
+					10, 10000))
+			dev_err(dev, "PCIe PLL lock timeout\n");
+		break;
 	case IMX7D:
 		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
 		 * oscillate, especially when cold.  This turns off "Duty-cycle
@@ -1281,12 +1330,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
+		static struct regmap_config regmap_config = {
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
@@ -1447,6 +1516,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
+	[IMX95] = {
+		.variant = IMX95,
+		.flags = IMX6_PCIE_FLAG_HAS_SERDES,
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
+		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_phy = imx95_pcie_init_phy,
+	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
@@ -1488,6 +1567,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
-- 
2.34.1


