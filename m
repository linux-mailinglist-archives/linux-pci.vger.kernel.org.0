Return-Path: <linux-pci+bounces-770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E92480DDC3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 23:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AEA8B2148E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF085576F;
	Mon, 11 Dec 2023 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bMliLSw3"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79655113;
	Mon, 11 Dec 2023 14:00:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXwX3o4bvyhaJz7eTKGuK4EhT+hyDKB0GcyPFv+QngOdJ+xylaj/f3vxJjJ83asn1a4/Ggs5eoVHxRB79ATKNZzlD8AhkqaE2GUAxBxP2wwn73ZcHfPw6ny7xDCpDY3MACRywX0Dl1nAj+bsJLVh8AJRXdVPclb9EsE7ZO+Umh2DhDCMQvbBVzrYiKZeBL8NDT+psUTu8hkb8KhXGKrP3oQum4pSzoGnOkCjsdKROgwpC5XR5mN2i3W3h5bRNz3z70cYAAlGj9MFgoweEACdLXh2tASrvnp3eJLDacu+QmS5MP2wC/LFn7fRBRNTaQ69sEbdBiFqb/Ls7RwV+5s5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLpS2V7K1OZ7WBb/0qCh+MtUGmX0ebHK2c8bjaDFPKk=;
 b=iLkOZgk50P1325zBnkpr7DNMB/x1BtVrlWKhu5sK3PCgMHjpqm+aTBpoansru05TjASyKuEdhl3W59jrCHJvy0pyizsjnHhbjVT2EQwSxhaDqgo57xggE9IWLmTYezvhtJeDHP/qzxpYXiTozyQ/qxMIoQWI4UvTYRKw+dyijHRxMcMdWVyNdS7waryWbvDClPQ9b3Wljb11gV++6EXM5SXqTKjmOZyb/mJNqoAz0Lk8zeZNDI+sKRN3ZPGQaurgh0FQu5oZFm2Uzq//6x+V7/0TjrrqVl9W4Gwzeq8WywAVkD4YaYfp2G4QDZU2UcD0rvuFI+C9SHRLv+s2f5J9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLpS2V7K1OZ7WBb/0qCh+MtUGmX0ebHK2c8bjaDFPKk=;
 b=bMliLSw33gPT34MY6pBHP+KxleL9TpDc7PVYiS9J6uKEEkpcMNe+qHQ/t+Z4DBhNGXzGMFEOmrsuayuWaWBa9DYyzLfCBz+9kLUpOT3YzKK9EJ0hC1IE+bmFFUNuCnJKmMGIx6t1TMP2o1b01eUVDv5WHZkUVaGB0a1NINM/ukU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 22:00:08 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 22:00:08 +0000
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
Subject: [PATCH v3 09/13] PCI: imx6: Add iMX95 PCIe support
Date: Mon, 11 Dec 2023 16:58:38 -0500
Message-Id: <20231211215842.134823-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c32d5818-c808-4533-83d8-08dbfa948a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cQ8qijOHJ8AokE1czITLw9uJtstCAECP27DbCL2aLyRRJ63M5AYwNrT7mN9UrypkVduUEQoAGRBETd5q6hi/X3K1yV2E1RoHVvxuRdf1R1cyDk9YRXbAC9QvY+CGyJx0SbeVpGnECnkI+3NLegf/JtaFwN+hbqmp1ixJDkeoBRckHF35fwh8q9q2+gPrAMNiFnKoXPiU1HOjFCMFu0zSkQDSDwhldZcR56at3BZsPmyuC+8S73vJ0Jf+TUVLWLBqE/roS6vhCL0Q26YItb8Q+xiTFmJRHIZXugEijY1ue7MWxVn4/+CI/Sb/Rbd/IF08sr/wuEM14NYZARleucdi7i1NfTKPFXTlWamSEDMHPCoRKHPTS2Y3xb382eJdKKh2oA9RC5C7PyvQGpsaW1xyVrljei5ZspIcCPlUQSkYfWwyksG0ekLuWAiaoAyK21TOkxeOl1399hTyXdAdLsSNHGxs+171zBJpK4B/IqxXagBi6+Hq9OrdmuPU52Vvm/nr+63VMtdtXQGAcck7uGEci6Kn+uNCntX+/fa3irSn+Jlg39mB62+ACRXr1Go6jekwnQvzeJmyT7QHcATpUYNQB+WDhdoRWDbKogbk+Xz7EiTb0Aeu96cQkGzF1rUokxOE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6wjHYmTirznmj0i5Qo8uaYz4cAZRwaw4z5i5FlYFg78Ld9VleYSDfN0+gZAP?=
 =?us-ascii?Q?vCZWF4sUccjJZ3Iz4WVA+mfDsIIonCDh3WgRj8s4CR4v1YcCha9sizhK3a36?=
 =?us-ascii?Q?RFVPsDBcsJsX8um/hxzg9e8sD4LGZrndEdE+Glwwz/zo/Gnr/7WaTLdX8BPV?=
 =?us-ascii?Q?PFMMqQhMGPMQhpltv4JCiNyPv7an2f1FJVIuWXF3yMfm80x4nbDDKHbpyeKS?=
 =?us-ascii?Q?gpmJxbmdcdeSRj8wKqkdUvJO6Y21ABTLYlQWo0v1tVXtIcIVkFiplh1Yn1km?=
 =?us-ascii?Q?NZz50/y4F4qZxe2BsF7z6uJhR/ImPhJCEzDhFSeFzExjADjydH3Eoa1pl17P?=
 =?us-ascii?Q?/uB3uQnLAltQVCpsADYDqvi8lorjK2OF2RkesICd+1YUiDGuc+gs/GjE2K5r?=
 =?us-ascii?Q?Aym9NKzc3A92Y7DrMyq8Tt/RLiba0JYhjQcL+srZpqGwTi4lDcIF27xdvSaX?=
 =?us-ascii?Q?SDi8qD5MMWI3zkbu9lYTYDHIYbZs2Hwe9WKB6emHcDkZ9F0Hk+CLqNGVUlrj?=
 =?us-ascii?Q?oEMQQrI9kBrtwBM2382uyRbsUdC1fpk3xJeBSfnxCvvo2N0aGsdU7/6IZYBT?=
 =?us-ascii?Q?uAPqDdCroRIn8zsbvIs8RmG2FsLBvXgzEMn+4BTCxeA7nQqYECgi3+K9/kS7?=
 =?us-ascii?Q?1jB/TQhlU2uuWrGoKY+BdaMU6sTG8T6A4rQ/xV5ZCyy3msFMhvStt+5NSCtK?=
 =?us-ascii?Q?frY7HHrcJ3wfk9brpHTWbjYWhcingzXvLHrAAP282te6aFxYzForI8sBJkkw?=
 =?us-ascii?Q?1MUZDahalC1Bmul0142op6exG8xLnbtIwcEnkxiUC3YxNUlr10wpGZ1gDVXZ?=
 =?us-ascii?Q?2/+KQW7Yuvfbq1AuoyGSAMA21T6dUh2lVAmtz2fa1VSbJoLdw+eiac5qoNQB?=
 =?us-ascii?Q?UO+LTyhXKab35cU8I55L6Ehcf1MBe3NaTBk2rzO44j+ZQk+GcYcDxoSzNHas?=
 =?us-ascii?Q?UgA21nORM6K/sKcZpMilQm6NGsFis0D+5T0VXyVcatJGFgvRNgiWHaNo1RUZ?=
 =?us-ascii?Q?2OMpmsdQ4M6L8wXI9+tntAd9X2vNCViZ2mb4XNz+rjOxRLL0opWkoi3hcRDG?=
 =?us-ascii?Q?vs7xk+09aVd5Dpyb63XWHQ06LR3xVD9de/+Fc9tD+Rqa66i8Lha4+w66Gurg?=
 =?us-ascii?Q?1pTnWCdLONEs+WWemW/yqlAbVivUawGKt2NGXunhfYNhNqp12iDfMCYL2kY3?=
 =?us-ascii?Q?Hm4WNR7nVP4SqAZVzO/PiA8jKAbHxKN8oFNtv4+T6o0yf5Xt6kmpTIPfa831?=
 =?us-ascii?Q?C9tn5XkbhyvV7WgeQ/C+Nmv+YT9T1j3VD3Ag0ZuuI7IdrDnJp+AyGLZ4D/z5?=
 =?us-ascii?Q?oOux8jZaRflDMJ0in34YMAjvO5Ko1Q/yQUmh5rgvbwZYa4tNGDf/LQ7UB/XX?=
 =?us-ascii?Q?FeMwgjjyRoX843/D2dJloXNA9HNDU9vDxabWXrv6BgQ5oV6dsoFj58HGOglM?=
 =?us-ascii?Q?x5FDhK50XKjZZO6aU+/NlYNTS6GQM0x8UA5zxyYoCeG1uuxlCPp+SRG06TNq?=
 =?us-ascii?Q?tMLCYIhTp30G6eVy0ZGcFNebFTKIkwTw/995q46mc+oGInCF+xh9DTlg0GdB?=
 =?us-ascii?Q?a4au8tPRPz5fOWecSu08W0I+QAS7gE7tmXr42Z0Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32d5818-c808-4533-83d8-08dbfa948a60
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 22:00:08.8048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKQ/chZLjVUWndkcxzuW2XBo1XSbjk8z+HyjwM8ajvSeZWmgts7DDh7B6rMgxcMs6xzydKCMLJxq/HY5hJitXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

Add iMX95 PCIe basic root complex function support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 89 +++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4e55b629d4efb..99022efe27334 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -43,6 +43,25 @@
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
 #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
 
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
@@ -53,6 +72,7 @@ enum imx6_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX95,
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
@@ -66,6 +86,7 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_HAS_PHY			BIT(5)
 #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(6)
 #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(7)
+#define IMX6_PCIE_FLAG_HAS_SERDES		BIT(8)
 
 #define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -182,6 +203,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
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
@@ -589,6 +628,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
 	case IMX7D:
+	case IMX95:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -732,10 +772,19 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
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
@@ -1343,12 +1392,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
+		void __iomem *off = devm_platform_ioremap_resource_byname(pdev, "serdes");
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
@@ -1506,6 +1575,15 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
+	[IMX95] = {
+		.variant = IMX95,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX | IMX6_PCIE_FLAG_HAS_SERDES,
+		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_phy = imx95_pcie_init_phy,
+	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
@@ -1546,6 +1624,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
-- 
2.34.1


