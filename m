Return-Path: <linux-pci+bounces-764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B225480DDB6
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602082825E0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 21:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E075576A;
	Mon, 11 Dec 2023 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qet+IkKp"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2045.outbound.protection.outlook.com [40.107.241.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24AC2;
	Mon, 11 Dec 2023 13:59:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3aP4biEmiocpwBECS6qLhw4oM0QYWvpFaQehcEtMubhbSTxy6SAEpdDALOk7zI3tA1IZtRPrAAYbiYxjAZCXWEGsS/hW7xZp1kj9s9xVofYSEnnqJ5udiRyyn5WsbnRHmQS1xyxbMF/1ZKLHiOy5fH/M6fPvKzS1sVbliEes0lCvUhNV26pXqDqY87adIwDLNQtUAk2r5ZOzDWA6/iFdfuDlLtSGmy9zuTAcntCN5LfzNAdnEZeH2rO+YUJO45AAEOZnYStyqEHonzAVt5dtpAv/5UKSdJbLUAmc5zFbkDOd3UDlxMETnNMuU5gGCcUP90KNAsJEfqfXFQo/eoSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0wXuwG17CvtxjA4Vranekpk03tGXICeznPAWJhaCsk=;
 b=fwN17qL2W07QiqMtBPgDhhZGo2MtsH5QumqwX/3CNYtBls3bUhS/cCo3gt9KdjI2oY/Hwu85pHLGTxiUXzlUGDa/gWQhkKLlwK8v0dLf8PbWGWIg8KFkCdkqkmgO4/RcFC8svJqgU8fC8s4EDea/9getf4oZjzPm/uyStfUZk0zxe63P/n+Wt2Upd1a36pUJscggohBsW9cTiSMDPRR0BrAswkcn6o4Y4+doyMn23eW015jV+WSgKdSiGVHGx0WgGDJbqP+vLhyjklkKnQEam7O329Z3QsClTj1Ij8zxZ5xF5xtEeY6TSRuBMVRsgmkDAerGeUCV7ogDpMTzp0ajGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0wXuwG17CvtxjA4Vranekpk03tGXICeznPAWJhaCsk=;
 b=qet+IkKpBd0cXFn7QlyFnO02MexIPw9cjeKzvPfyzHmEtZhiwrdQpvLh/f1R5DG3DoCNHZ8Bhq2mI9w76C/8rDlho/63pH+eYseI1siySPZ+r9cuG//LtTPMxnH8Ke77NDPO5+I68SqtYWYLsNEEqvOWuNhNp9Mp9oe9tbn2Om0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 21:59:35 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:59:35 +0000
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
Subject: [PATCH v3 03/13] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
Date: Mon, 11 Dec 2023 16:58:32 -0500
Message-Id: <20231211215842.134823-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b62b6877-19e6-4d67-d988-08dbfa947668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qtnxFHAu/GftuYIcY5Duh55WdIeeK7JtHY8sIeid5k6sXgtz8mHTR6dnR9iI4w7ErTtfIeiLXM9WAhbHo8DFV48Mf7Dbx6hrx/gRNwjgWLt0MnkMCW9BdfHk8pXm4BXG5H2IGGUlaqyEkS818Rnvn1euaNsLdd/VHPrl1Q4hkEGPT07tagKhbZiyw1i77Nt1Vq1XC9bQ34NCsKRTnxYhQOlJtKM6gxf1g2b5ellRA19JNk8nlDhgEOHSJqedPJ4uMHicbZdGaH4dnQW2bWOJjO8VxwhkLosfIGsSak7YowcU4YS6qvjudMRZ8DSeFZD95sSI0LdOFq84ZT5smXv2DCYZ5nc124nOcmGSAm1EQ7DkFMst76ZAFoBrsTAHhKvfsSQ8NEc3ns9Sj4UmxyfQBzeAQgMPzRgbyGrQDak0XV5D5v24t0cyyqBX8h5uPZeZUgmKRv0ITmoTUquYiG+1fjC9MxUQ5cuz6X0Pm4CanoE7lF6QamBGyz8NYw060M+baJWVBUm0OrWV/dCEUJjnluYZeZMHH2CS1Aa1ai3X5BlmwGNz6tkAQ2+eUKr7XwUBMQE3WhGfHgK7b5QzBklqR5t0md+z8gbpSw1QfX466nxePRBQPZVWZsC5NbhLXnAx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cJXVSoEg/q+BVN41fbGwotB1sS/79DadJAAqmC6puT8jMbpIq7Ql84WsuqLZ?=
 =?us-ascii?Q?tt4f42qD1Bo4L0HWFtujaci7cKDGhjvh3EAK2lRvdSaHAGw65v6Dqp2yZUyt?=
 =?us-ascii?Q?aPRAiFUn38wcU57NMkUILdtqebcJLM1XRlvYYFn76S2VCJCzHuLR+UcbbwVm?=
 =?us-ascii?Q?zChXqN+Dm9CZ91U+7pKoac5eHy1/dw9vj6YFJKteqNKEFLs82iWUt05CJ9cE?=
 =?us-ascii?Q?2leKwcHcXx9FYfITqdXfYUARexdvJYLOMeXhREfu9E8eyTAhRXR4TkQ8i3og?=
 =?us-ascii?Q?+1FFq+1/9Xz7nNEpE2bcGaqIwLEGHzYae7emOHbvBN04Xptb9zU0NVajRyAh?=
 =?us-ascii?Q?Lho5lu4sjkUgGFzvsBjTSELG7OB9WvelvdtRSwi1xkuIUJObQAiKusBXky9V?=
 =?us-ascii?Q?+qcJyCFtTzR+/sbOM4zTDl8UaHAxUffug9wXDoMN5bHAz5t8b16iSq3adTlD?=
 =?us-ascii?Q?HeMZCGlq+uekW/yvK8hIiw98KVDWxGRdf3cMZpLbDVChzKwEkK+SHDacYUkc?=
 =?us-ascii?Q?DD9iLZkympyxF3KFswSjwqXN+mo7SwjYhU2+BsEjPMoohlb15d6ZabynANol?=
 =?us-ascii?Q?xopGu6CWBmcfifX+h4IpiQP+rsV2hea5lQHpWrEqjkWihgPluljbrJsW4rdK?=
 =?us-ascii?Q?cFovtzjIxnNHgY0jgiXBFaiOdK3/Bp6JxjfoyzXuTT0y0zixfpoVhP05KO3X?=
 =?us-ascii?Q?uG6KFU4Msc0HhCtyOrShbvLJX6sStOBHzmPHB9Dt6vnIQ0720y0WWEfQ3pxi?=
 =?us-ascii?Q?zyQh5wB4h2SbcV9Sh7J0VUc9lBfIiNPN+O4WFRJvuIjv510LiBws1onrlhNb?=
 =?us-ascii?Q?O/C49U3GI6Z0E5uDfCn8oKNfCvDH4MdoobMGXiF3gyZCPVIVko/p3Df7Sz4A?=
 =?us-ascii?Q?VLw3ysdRpf7t1XOhd1o2DMnecrccmsBh88jwdRrq5hvJbXQS1GLKfzBMZJkq?=
 =?us-ascii?Q?Dhp8M2MbLqz6jLs/S1wSzhHLtJdlFJ7e2RZ0vpbll55fGPit7iF2GzvZcju8?=
 =?us-ascii?Q?70aYJ+Xy1SvM3a72DANe1s09mQAL4tfAsvPYu40dR8RClOJlvTBIW8/e++Sj?=
 =?us-ascii?Q?FvQW7XrmIkF7NAiyrxtuGXU8RuRhisY/INMdKyaWmGskKro6RKRM+U0MyXUe?=
 =?us-ascii?Q?tcO5BmHi8zBZsbF49/BLXDhudt0SS2Zgm+x4H6SMiEyDC7vd+bqovD/Jz2ES?=
 =?us-ascii?Q?oHfEmCXQzguDUmRNPk0RXBzfL0oKWVDrDzbEmwFdFGNH1kMimNvqwnNS8FgD?=
 =?us-ascii?Q?FzH6td1R+BIuRpmfIGbmvP96vrwHxLy0LrXQXWAsi4YnEbInqYThCKhlmF9p?=
 =?us-ascii?Q?4Ny4UGsdOefbjlEJx+Rkja9SX1EFZX8xQ7IJC/7i8dKl5nHrttPHvDDjyNd9?=
 =?us-ascii?Q?58C7gOMd9PxP5jDycs+F3e/rSSJ1W7q0Nd5BJM1i284VzdjIHOgXXfDN+mHk?=
 =?us-ascii?Q?3gN4PbF0JBvnXUpCokaQvPSkXTeG2f299gHxCI5UuxLTtq2CecAvL/0hAANL?=
 =?us-ascii?Q?C0XxqZx1PKzMi00PtlHuj942bgLoUolSsOV6abTGlCgH/3geoIXDyaQymdPM?=
 =?us-ascii?Q?s917AxDxXWi9U5iA2jQ+aPfUsYL58WmDA+0TN97x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62b6877-19e6-4d67-d988-08dbfa947668
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:59:35.6468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajd3eW5t6mLiqBEyojxZ6F7dXduCgaIawh97hOj1jdsEPmNBHSD/cFIq5EDd5kpQMJ+26SJaJOKLA8A56eqWEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

Refactors the reset handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling reset.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3:
    - add Philipp's Reviewed-by tag
    Change from v1 to v2:
    - remove condition check before reset_control_(de)assert() because it is
      none ops if a NULL pointer pass down.
    - still keep condition check at probe to help identify dts file mismatch
      problem.
    
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


