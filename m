Return-Path: <linux-pci+bounces-3773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B28985C100
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4991F21A4E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6FF768EF;
	Tue, 20 Feb 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eFdCFa3n"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF777641E;
	Tue, 20 Feb 2024 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445995; cv=fail; b=D5M72N5Z3G9LFWP0zgU8PSgNIGVrlsgGzF6rOLgBcDUlOW1m8XiAeF5GlHSLNRULHbFGpbJqWVbAQWB6QQwb8c8AZ7TSJrPGTV8Tyr0mshhh+cOwFr4F/ktH8wugbXdcQkNfAO0LbzwYfl8/HLerPnXOwRZV7JfpzG2Ael9iMyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445995; c=relaxed/simple;
	bh=3GFHlXph8FZLwOjpya4yMbsCQDSwXsg8pGdsQumdV94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q8kwbg71qAP6jjZEpS8es1aRu90n6ds8DHex+gKfTtGoae0R9HaEPVTxe5Q+5w+t5OYPtbgWLW1vO+gA8OLNXhmMCS3RCVrXKy1agdfQFa1hjiFrkbF/a8zvCe/Ke870ZX9/xalHkYCoIt83B6sxi9m57Sz8Rp5swWU2gNQ2GB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eFdCFa3n; arc=fail smtp.client-ip=40.107.8.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jv5TNu8LKuX5v6663nJwY3Rx9mghkaWNekLbnT4tJLmfQphMGnse1VxjC32Q+biw0Waak9e1KeNjz+2HSPyx4FqP0Wvu8ly7F2311MUt+v4CfJ9B8tWcpFQU7Sai8hN/rGuxLbqHH7RcMDI8GuiegNbZEOYnpG42C1UehRhmZVnku1i25Hi51yVhNm5zgjJ/7UdsWRkGvf+s9+j5dqG9esrO7NFa56PKWJRFMbIapZXaCtqo4dtssUAjcOUy9aLS7iE5Ei69egLiWEJ/NHUAjeTHTf1rw7/FEWzz+rpA6Sd8gp5GomkSDc52J9j590s8KgOQyQDx2IYeUrSdmij8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emkIj8/DEUOMtq7zbxG+dxJfT7ccEYuS15XPT+OqsDQ=;
 b=hI3RHaZTpGQCjUnOpKNH41gU4sgpO8eHZc6rZxUc/dxAeHZzaBzPf2RACpZJDtYAcTvegNAISFbkeAy3cYI18EAzHNTIhsA2xJLs26cmf3egF8s2LyeiM12fzFLSMaa1R2TjNiYUE0WRB3rZhcKuNDLytE/csdObHHn47TsVIFtwEaOaNj4wh+abLQiYd88s62t4TVhfKmFtM4dA+RJLZ/jEJbfJwIJ9h926DLQSRaLwktp69QGuTqGeWuFhklajo/IkwuOxsw/TI+oDoD9a+I/jzNRVUu5YJuNIssgUjA+eSekP2kdVl9XVHyWm3ycE7/7n+Gd4fOvlrynD2IRobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emkIj8/DEUOMtq7zbxG+dxJfT7ccEYuS15XPT+OqsDQ=;
 b=eFdCFa3njhzgTCoWO6x/j1fYMsTfX5672qVnasscrBVEXXn2H2B7ifeBkNRuAS4vQYWNWofx9/e6DmIR3/BNtOCzxp1Jw3z+XM9l7sLPp24es/FMuY6jNXAHPsGlOt9pXu13Vz+PIAOibimVIq99dork74XI1bu3azRV7Q825LU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 16:19:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:19:49 +0000
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
Subject: [PATCH v11 01/14] PCI: imx6: Simplify clock handling by using clk_bulk*() function
Date: Tue, 20 Feb 2024 11:19:11 -0500
Message-Id: <20240220161924.3871774-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7b629b2-8cd0-4a60-be2d-08dc322fc2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bXc5jUhxXDcIPhVCuDbTynJNcRbgYgYKP6wh8gIaf8KmicIyXhUYtcj70m4de3Cux+FQUeRrhEoD97diCwCfPnfxsyvEZY2X49kdnCcDDhGFavULFLJbPQrXdfTNu8tqdZ8c8w/hD7X6upOscFsOauaEboo2hHU79rKp2HYoWfKJ4SbQl+OtenkLLaBnNPAahDkOUXklWZyeiI55l5uSKDpvW5foyEYU4wF4DiuyVS+99YxE7phDpziwUDVYZblW9x6mAugkDYuP7+1RCkSzBX1Jx+TvXg8U31H3WckXMLBTlUDoDloeSp1BPOkKP/lMuMc2pDCNiC5yKd4ubNATo7bEABrxPZJSc90oxBnJbZ7OAJjSmFx4OV4qYFKvpFnwUzjMn0ZBesziivS+TBE5t+J9NhpnPYUMrSMIbuW/2avkqBy3HAwKnUOvJ747JNdA1KoGuLaOiAy3sa5JwN+qPRVJ1CjxYpzvSA1Gw62sLLgtG7ZRoI8dXgeQmJ4qy1YmjEtut+Smw1zs7fpfY/Bhw1lcjXK7wdFk1hdcmml1CoS5O3A5GEiMOeg8EL+0oEh3SyYt7UfXUwro78IBRAX+radkShg4kzQz99/6FAuWc1z9xbD3TubF5i1tzu0ZHH16
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8OzPfvjLFSVeNLCvp3C6J8vKsXbL69vazlE/y1KdHo+McJ0/70KugGGbBzi?=
 =?us-ascii?Q?KCUROv1Tf9ITFH2lwkAWD14U968TKPicH9mKVUi9zHXOrrW5fQ5d2t5OyzAH?=
 =?us-ascii?Q?1WqtkcePxXBTAVFTlxNlnbWvEkpOHZOmly3yC+Buka7yih7SJRzNh62xLGjJ?=
 =?us-ascii?Q?ZNo6prrAjrdjoIEfWgyTA+Syt4IhDY5lpAP3bj/xlCEUpDVseAtv24BojS7i?=
 =?us-ascii?Q?ScNyFG5zqa2/GyRDGMG6ZAY9FmEHK59H3h5R6UXxEWNvtctb6K1pgtgKRLGl?=
 =?us-ascii?Q?qf0clVIsuhLe3WCAtbWEk+DK/i9xLazcMfwKq5T4fQ0LwRpofRqiyiJBzHql?=
 =?us-ascii?Q?eZiYcIZKN9n1LLDwfI7D68dyxspXgFxsbhqq6RAzpud0TQ1e2h60to/oAD3i?=
 =?us-ascii?Q?c+6pWRbxg2p/HEUwfBZkzgpQk77GYF8FPcWByFWnI75ICFHFSJXsyHe2YBpH?=
 =?us-ascii?Q?MZU09vRJfN3E1V7nvXQN0K1hjzl0v0vjiXg0nlM2qCTgplYYTsVBANbxlMtl?=
 =?us-ascii?Q?cS/eM/jlXHNlbG5B6k7DZDfYu+K6tTPdHPqVQbPjX9kLH2p6I5YTrTDh2Vgi?=
 =?us-ascii?Q?y4cjvn2ilQthMOUBz2ec9dQgvdWXO70A4xl0ZyobLQuuQeNl3aWzQEZYwPg2?=
 =?us-ascii?Q?p+g5AfJdW8+RDw36/yxWisCe27XRGRpYx6d8YieHfAyEELtPUYgMyVnCu+26?=
 =?us-ascii?Q?1jqiXYi0PKVsEdwwkUN3UHMBNiytFh4BWv3DkD+UWlWKOOIlPH53hpBH08bO?=
 =?us-ascii?Q?KBHr7EKegWnElZw5ysu8zAeWBcvakh+5Mn+oVXKWqN/qECyPeetc8WJ+juiw?=
 =?us-ascii?Q?TdIEMWljjL6gkUrkylDQwtKStdY8tLD9s217UKbAOmjLtTLMXgJ47aZWrlZ6?=
 =?us-ascii?Q?jMrYgjHJvPZFhDwttuqK5cRVryjCEdV91zoygVfgcWSE9/Can5TQg3rMg2hX?=
 =?us-ascii?Q?rmwJYkQJhuK5kkDqoralpCfVr25ZwaV3MvIFHNvvFRxqW+b732MtamSomJMz?=
 =?us-ascii?Q?MHlCJboP6n1mGwhMLIC/Y3NFxf6RyQ87cIgTJ4bisK3zAREmb/0akDpboXbN?=
 =?us-ascii?Q?O/twJUtfOFX3JrIfYEq0RNgNDTPp1mvQSHXaStTdrQdHq/+e9aW2j9zw/jsw?=
 =?us-ascii?Q?ugrTyq2fJttoKVCMmV69XQV4phFwWCTT30QFBWt7AOOBBn+bzzak5I/zNOIl?=
 =?us-ascii?Q?JuQeDeS1v7xKbVbF75x8uTuUjB4VCAeVLyGe/tmgx4pN/8jTSXY49o9gCz+M?=
 =?us-ascii?Q?5wPbM8sdNsvRhc09UPKHuTpO0q+fK483ydc1mc+PZfbGmRD0LDzU75+DKs37?=
 =?us-ascii?Q?ZO0zTNCIVqPpGi6Fha1KUD2hvvQXVVMlHVRv3fJeWbt0ifqI0OJDuao8i/wD?=
 =?us-ascii?Q?9nTxsBd0SqIRSeM+5Las9tpHeMvO6HXi6qvCjzsiq4jpEPLS9sKFMKMCyjaV?=
 =?us-ascii?Q?cnSPS6uj3p2zkF+PPen93FEbKumzPo0p79+mrdN5+0nr4fuTLAj0JlI/QWSY?=
 =?us-ascii?Q?wb2LvBJ2Fh0y2eRcAiYUqCNc9JCK/In1YAnPxGV07XA6/o+edmw6t/EyN9nq?=
 =?us-ascii?Q?q5TjWsK+15d/d7kotL9vuTBd8yy9MzZMGmrqhcKD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b629b2-8cd0-4a60-be2d-08dc322fc2af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:19:49.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hQ2TpvKV98wmyCm2mKHwRLjVCoGqh+9s1E3FPqouCHpXzyKcKPVOe5dwTx2+yjVGbFLnWWO69jrPR6CLo9wig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

Refector the clock handling logic. Add 'clk_names' define in drvdata. Use
clk_bulk*() api simplify the code.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v9 to v10
    - fixed missed delete a case, which need failthrough to next one.
    Change from v8 to v9
    - change clks names
    - Add Manivannan's review tag
    
    Change from v7 to v8
    - update comment message
    - using ARRAY_SIZE to count clk_names.
    Change from v6 to v7
    - none
    Change from v4 to v5
    - update commit message
    - direct using clk name list, instead of macro
    - still keep caculate clk list count because sizeof return pre allocated
    array size.
    
    Change from v3 to v4
    - using clk_bulk_*() API
    Change from v1 to v3
    - none
    
    Change from v4 to v5
    - update commit message
    - direct using clk name list, instead of macro
    - still keep caculate clk list count because sizeof return pre allocated
    array size.
    
    Change from v3 to v4
    - using clk_bulk_*() API
    Change from v1 to v3
    - none
    
    Change from v8 to v9
    - change clks names
    - Add Manivannan's review tag
    
    Change from v7 to v8
    - update comment message
    - using ARRAY_SIZE to count clk_names.
    Change from v6 to v7
    - none
    Change from v4 to v5
    - update commit message
    - direct using clk name list, instead of macro
    - still keep caculate clk list count because sizeof return pre allocated
    array size.
    
    Change from v3 to v4
    - using clk_bulk_*() API
    Change from v1 to v3
    - none
    
    Change from v4 to v5
    - update commit message
    - direct using clk name list, instead of macro
    - still keep caculate clk list count because sizeof return pre allocated
    array size.
    
    Change from v3 to v4
    - using clk_bulk_*() API
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 138 ++++++++++----------------
 1 file changed, 50 insertions(+), 88 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1975ab74a5ec9..93c304899bd6c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -61,12 +61,16 @@ enum imx6_pcie_variants {
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
+	const char * const *clk_names;
+	const u32 clks_cnt;
 };
 
 struct imx6_pcie {
@@ -74,11 +78,7 @@ struct imx6_pcie {
 	int			reset_gpio;
 	bool			gpio_active_high;
 	bool			link_is_up;
-	struct clk		*pcie_bus;
-	struct clk		*pcie_phy;
-	struct clk		*pcie_inbound_axi;
-	struct clk		*pcie;
-	struct clk		*pcie_aux;
+	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
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
 
+	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
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
+	ret = clk_bulk_prepare_enable(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
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
+	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
 
 	return ret;
 }
@@ -691,9 +653,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
 	imx6_pcie_disable_ref_clk(imx6_pcie);
-	clk_disable_unprepare(imx6_pcie->pcie);
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
 }
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
@@ -1253,6 +1213,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	int ret;
 	u16 val;
+	int i;
 
 	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
 	if (!imx6_pcie)
@@ -1306,32 +1267,20 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return imx6_pcie->reset_gpio;
 	}
 
-	/* Fetch clocks */
-	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
-	if (IS_ERR(imx6_pcie->pcie_bus))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
-				     "pcie_bus clock source missing or invalid\n");
+	if (imx6_pcie->drvdata->clks_cnt >= IMX6_PCIE_MAX_CLKS)
+		return dev_err_probe(dev, -ENOMEM, "clks_cnt is too big\n");
 
-	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
-	if (IS_ERR(imx6_pcie->pcie))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
-				     "pcie clock source missing or invalid\n");
+	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
+		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
+
+	/* Fetch clocks */
+	ret = devm_clk_bulk_get(dev, imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
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
 	case IMX8MQ:
 	case IMX8MQ_EP:
-		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
-		if (IS_ERR(imx6_pcie->pcie_aux))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
-					     "pcie_aux clock source missing or invalid\n");
-		fallthrough;
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
@@ -1354,10 +1303,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1373,14 +1318,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1471,6 +1408,11 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	imx6_pcie_assert_core_reset(imx6_pcie);
 }
 
+static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
+static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
+static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
+static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
+
 static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
@@ -1478,6 +1420,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = imx6q_clks,
+		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1485,6 +1429,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = imx6sx_clks,
+		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1493,40 +1439,56 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = imx6q_clks,
+		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
+		.clk_names = imx6q_clks,
+		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = imx8mq_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = imx8mm_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = imx8mm_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = imx8mq_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = imx8mm_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = imx8mm_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 };
 
-- 
2.34.1


