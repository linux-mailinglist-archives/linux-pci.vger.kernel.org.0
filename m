Return-Path: <linux-pci+bounces-766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B7F80DDBB
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBD31F21C42
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 21:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B9A5576A;
	Mon, 11 Dec 2023 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PIVTUExg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6316210C;
	Mon, 11 Dec 2023 13:59:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIvYtjF9DtLl7U6ix0MVx80ojdqfrYcWsvOVYG7d6mkl2JpnNBMQ22xjvIgmjsH7KkYQkvcXhAz0qW8pxPZU0Q7odoY/DDvd9MLkZXdaFvdQh718MYT4QmI+Ftuv7tG7IRj02S+aidLdCh9HCppP0Elr4I7awSqA60k2Gm0dds4Vr33OIy4dcVmWwnHNDp/urj4Rf+g09en1/Z1ztNWMFiaHF1t3DIvj+Yaj5huS5t1jiOeVIRtBU/v7pg6FFpIzfeeu8WNJHi1n5eePlP5wSV9kTteMCjHd874QRw5X1DeK1SuASTxM/0goweoZjov8Gy0SBlN6iulqFsmUAAdsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAuYcnSxfUjuXCqJViD5s14jjKu2Y6OgCA8oY8DtnJA=;
 b=am5e4sJWaBRfmI2A6bZ1r9uqy5DSOeQjEkWx74lN8vFU/4z5irJBd0YV0o3I84/34av5TkSeSI7s40NiijS6WLyFSwCJOmSc1Hn4SijmKoLVKYLetTbTd8cTDI59i3h81buy4DP7pr+gQOJKZ9neDWNMU8ROW95yF0xW9Z6xJI6X7tapo8hmP2351fR89HwXrepy0MTLd3FVMUz5d5ATI2zYpYYt1Cg/E/vvn6RFW0qtrj9Sb9qL+WPIDeU2NbYujmnplWejKu9SM9V6/A2O+OQnfFx/PFHd0ZjDxd9JXgz8meIkwy7KDxzKMFzq4yfY+s7OzaEtZr+e16kytSab0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAuYcnSxfUjuXCqJViD5s14jjKu2Y6OgCA8oY8DtnJA=;
 b=PIVTUExgwA3CrJcO2lvV4XUotInU0L+SWpyFnksZXRJnyMRptHbQ0HgC3VEXUXmoQ/7OB/qN3B8COkJn4DxR2mEUF8bQRajP/KzhZUpmUREV9c7F1uh110yIyskkUjqWtCiDXdz1C5j8lRYnKFGI5UZcvjhj+ZLqJCX+4hj7IvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 21:59:47 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:59:47 +0000
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
Subject: [PATCH v3 05/13] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
Date: Mon, 11 Dec 2023 16:58:34 -0500
Message-Id: <20231211215842.134823-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb3afe69-0f7f-499a-35d8-08dbfa947d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GlqWOI43ncdGRwjp6YhmEvZD2PtlqwE5y9TCrCngl7D6w7cwvU6+8LXzeHbqWsHVFwn6EBDvs+g04ozXU72zQYA6Z4T6lDfhiQeqG/ou1FAoT8K3Ft7mPiBYLGsN3jXyQtycT7bzmdvDQryL8OXcBDH55e5OxTgy7ksDbkX0BvSWtuA5RIRVdxODKM5pSruSXSytUd7Yl43JJuhJjNvZnmJlW7qYx3yKKzzFiGr9wj1VFH9bS9qfYJXhieV5AUmfkwXWXyAEH1R47ZlmJ3/nCbpBbBefe9MPlRCIgMCYl5yktqTM9uoODkZ5N+6vYZKK7qy7FIoOUJ7lVaROsW1Ri19PwWu+dvxLwAEKDhSlvpN0egfLfeFSE+ey4VwXoFrMbctNHKYvSqtfuzCvmt80v8x4GuhXt0cEr0D3dO71ya6Vp8oZDTC/gPQCjdUAd+8F1qMCMGCw7PtkARYJ7ldhdKkAlJXRPAshcdp0/oCudsjAKNUuF1z+NF6dAPjg8yy8EKl8yN5eMo8uiSph8dv7nXxrgJ2E48yoa+A03Y5x1lxouQgyP/WYSD+I4ObKcD2tUtc2Bish4dwKzjmRCM7bczeOUuElh9OlyO0z10ziFFKwaZzorsCO6IFC1pXt3c2K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FDQ8oQQq2OnH1JBEcSp7jMFp1eXIpayvIoSKloo+faYzI+j/NQmVqRbhpYga?=
 =?us-ascii?Q?KIZZMlI0RW7xdNumHPxlu5JfK5+KYxHzJ+wCQoVU8xuczhgh5uIuLNFcI6M4?=
 =?us-ascii?Q?0SUlZFIx9OI68xd3VTLy4TvHoXY076ufh0RpeM1CoqNIn3nHjUgIbMEbYfiI?=
 =?us-ascii?Q?N18AOPE7B9DTunH5C7BhuwhB0wVmnAqtxjN15m2Chr80YAyoSaW1rJfp+bjt?=
 =?us-ascii?Q?Ks9e/r1eMb1s0X6SHqhAk7ZJLZAD3Adl7ZUSoWn8/Va821cRODg+I9TPYbjo?=
 =?us-ascii?Q?r+Mhgt9WWgFEp8Z69G8Ujs75maOXbUTiZBRrxs6Sls7kpuvbCgDIoyi6p+6R?=
 =?us-ascii?Q?YEv4H151ZW8qujM/VbbBSVL4nGlF1HEnj/BSwj/8eGcgKwmLGXe7mVGGsPW7?=
 =?us-ascii?Q?iZIB7U14bKGMirX/jSvy+P69C2LkFnDvO28n68EYWYls4kGtJ4PnjwDQwzIQ?=
 =?us-ascii?Q?TdHwCx0stQStavXJXCDE5DHi/N61LP83LAku3m6WB/tCR1txsBuDj9metbns?=
 =?us-ascii?Q?hvQKqe0iWksO6rjYhpk+voRXGXjAblhh8qnDRvyRyIAfBkN2xJTH17gSC+Nc?=
 =?us-ascii?Q?vyN5SirBAv/tu6F4h3/wj4HF3aOt4fWKdW/nX7eNpOmMDSbyrCsiTw51BncK?=
 =?us-ascii?Q?XWjuZiix4W8QuDC8bd+z7jfydKAttMftDMzWLqamn6hCbuBSU8W6WepHVXIU?=
 =?us-ascii?Q?jsIg6G/dl4C0PEVoWufE04jYtc+MQ/buaNrxJ2dfqzb2cPw/sQjeQ2Glli+W?=
 =?us-ascii?Q?7Qt18yTPIz//bZec0hcQw6TZTfnNYqDKsrh8BDi9/oDyF1swk9tfpiaN95vI?=
 =?us-ascii?Q?QJslutp0xip8iZKmFUgS+66fyZ4KzgTsOFL56eVdWWNKib0D2eH+hRr6FjIq?=
 =?us-ascii?Q?Yj1/6hhEMT+XsW8ujSXNy+o+i4ABViQNm6jXoSr76chPYWz1+mbCGf42bTcN?=
 =?us-ascii?Q?GYE4RRdKhWqaX79wUl9IoJPrk2CTxE4dYQdSm1IjBvRoWDETlkWLuxUxoL4o?=
 =?us-ascii?Q?zOZmWk2E3PSTFllAYRzxo4ifDegQZa7ihy4y+6wi65ocPseqUkDpzM4obyBv?=
 =?us-ascii?Q?cvp2/YcHCCp6qV/Q9ohGmmkRjryI2a1X/27myIjK+vuN0iSPxo0K/hYpVagw?=
 =?us-ascii?Q?ptnZOcf8sJEQJ0/bL+sjLrBGHvVqEsow6Bkhq1lnCnEugS30DXdx5TlIkh+U?=
 =?us-ascii?Q?nmtL59aVAXxbk3OwYq78BArXRuBnfacjJpkm+TZYOzvYYgLWnVsP25RHp8PG?=
 =?us-ascii?Q?ZKiypUMqaIUdif/zJ7yjr/sdA/FqmEZJIhhtdi5N7IRFkr8eO+10OklrHbDB?=
 =?us-ascii?Q?JeIhhmswUqf3Lbg5tusWKL/bycgtHbSjljVtbvrris1uCPp/u2I0TgpV2rub?=
 =?us-ascii?Q?fHrBpjKs3xeshVYyf0PZV86Ruxkv29xuYzoL6rIAn/7/976Nal4p1xPMa7Tv?=
 =?us-ascii?Q?TmhQAyYuqOdTDp3QJ6LW9mXe9sDhnpVA/7DT7boQGjOsBKnJGXhfFAhc7KzD?=
 =?us-ascii?Q?ROj4Rbj1mFW+Ruuo1zIPe5sRrFpwVjjAS1dQvMMR066jTuVwyk+GcGqeK+ZP?=
 =?us-ascii?Q?n85rFPb4KTqQ1BMUrtnmRm/IEs/OtmOsNdXt38nZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3afe69-0f7f-499a-35d8-08dbfa947d60
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:59:47.0603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sk0aondQGLKEyRQcCkvMB1U0BAUDC1JKBjYVS73qjgR+PHUb4tfFw4nl8hQSw13fBpu1qK0abcJkEIuWohGtAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

Add drvdata::ltssm_off and drvdata::ltssm_mask to simple
imx6_pcie_ltssm_enable(disable)() logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++---------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 548034151ee1a..5bfb780e441fd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -75,6 +75,8 @@ struct imx6_pcie_drvdata {
 	u32 flags;
 	int dbi_length;
 	const char *gpr;
+	const u32 ltssm_off;
+	const u32 ltssm_mask;
 };
 
 struct imx6_pcie {
@@ -811,18 +813,11 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
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
@@ -830,17 +825,11 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
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
@@ -1446,6 +1435,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1454,6 +1445,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
 			 IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1462,6 +1455,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.34.1


