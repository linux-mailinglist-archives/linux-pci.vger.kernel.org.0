Return-Path: <linux-pci+bounces-3098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91184A0E2
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA161C21AB1
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7C34595A;
	Mon,  5 Feb 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pT2iCW1H"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7B48791;
	Mon,  5 Feb 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154464; cv=fail; b=XkhD0X2aOIC3hSyCGUike7VTNIhTV5+Ic9vS0WDwyXN/snw8z5U+6Zxib6dF5cx2sjJkN8IeFDSZQ8IqJuGntzxXIXbjgz428CD6ITX0VA48KhlJYnXxRgX/oEF9luszKWdIIPb5kVpkR2EB7QlCDU/Ybaol6AYpLjXAuZRBfpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154464; c=relaxed/simple;
	bh=mFWjYGEsVWW06KjjHp9evuTVY/pPPHypHt3fsr4Q9e4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hz6WP+uv5PjMjPzw/+Y2vMkw2i6KInEcHeo8LzRysa7CfZQvtDVxc8Epq34RkJI+89mOL1DHsXNzvQhlbBTuKb/coL1LHcnXJMpQCuACvdPN2qQzCTpnjSAYWUrMr6Z51S/Ra0Cp4vIzRyxx0e8Zbwe4IgCKsw6bAjqAhQns6pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pT2iCW1H; arc=fail smtp.client-ip=40.107.105.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPensYGCXZ+BtVNRvrW0O3zwiyxEgTzHcnY691PJo5rfzAVIEulPyTRRu68YxLmtZSBUFRIFao1z7f9Q6d8kFHKLVJeUmkHv9TxvWBQBtcGZRIhy5t1Rhn/lveJy4P+aCvVJI2VLNAnIFS48QCbDPLoG05MfSOmKRuFReuXjhlueDp5n1yOGACuMm3aGXYLgj5z4UZQJo+EuzJx3aiQJc1Z0pAV+l0xvlb5DzkyE0GU/ktUj66US+mlkw4H2Kp9rTTSSi1PWfpV4RlMjxdLy2AqRIKiAPfaqrt0KQNyq2ijsPNCduEXoruWRb4GiurPhzR0UdKAlWm3xZKG9vTOovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksEMMtlSpCUfx0Lr2dcNLSAC2dccfJGJFmcJv9tftVA=;
 b=OZ0mcHeD/+VGyIJcbEg9uQo6eLCpdNvzRKfNxMSHGJgYcYWXGweWMAzAfjAz3//TGzs97HROnxum06xvAxQp64KRqrq1czEyJXeViHl/7p4n1pUrZkzebA+wayNZuA9mRtqsUPYqy2vWPsjTioIjCtNfjWGWt8UYfvBFEUH37KGIYZo6DH5YBWjQM6KMooYztFaABBPhQAACN3a+M6gV+WP554lo1XeJnNQkq017PtOctEHMjUzaCbF8RXmbjCSxcnK5yovpLiN/xNxhUNL3nK9H6aZS5wBqDu1eHtznsShFWejiJMZdsvuIz2OiYWpnzauxpRmgszbRW5Yx1+lNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksEMMtlSpCUfx0Lr2dcNLSAC2dccfJGJFmcJv9tftVA=;
 b=pT2iCW1HT+oV4+fuiaYLwPkkdghWTxGCefG++q5gt9eBBYfDwAqO6QGahvP9ZpicbRKFrJxQ4U+4LCeVFsUzmVNkRwOJWV1lNXDpaQBhGxXwDwEfD/yHvWLj79RVXE8NBGjSBiYXn0imxBEobjlx0hXqaMb+fKIDl36n7rBTAQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:19 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
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
Subject: [PATCH v10 05/14] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
Date: Mon,  5 Feb 2024 12:33:26 -0500
Message-Id: <20240205173335.1120469-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205173335.1120469-1-Frank.Li@nxp.com>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f8aa86-cb50-4070-a4f0-08dc2670af23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CbK4JnfasPD/tawdLsLDwsytzSZvQIrotkw0Zfq6bb0lPDBkhngaoBeW5qNKk8hsug+FKJWa813GfruLLZBq+E+plaZ2r1Zwgzr+9X2rmdx6VMx/1atrilfst59WKWLV6umFuEdTXANgCyNyrJ+60Tja5WQclx4K3/nVhmSnJgY5Ubc2gZBsmmz3cwvbuetV2Q925XAJtDbKKI85djgDkKaRrZE/DUtE/8/QOImuwsQIWrhj2Tjpn4c4ncMCh1YWvQGiaXBe9dulmri+7NuzTe82yEjNdoncVzCcAkgNfXpjM+0Wrb3jfB+YxrX7WRuToyPrABVY9VHwOy7so1nMLA8oySgO4TxtOhlFR723lH312BdGDZsNGKE07u9ghoWpcEzcKpKLXwI8AG8I7aoNPr6J+G4Xcc7yJNEQlI6oYxAhpBM7SE1bMoRryM/1u3Kt10fDuQFL++E9+VliKjp5QoEdWpuj8wjN+wYCXkMxk/uJX2xtnBlbc2fJaw77swemNC75pK0F/n3JhKLlpU6YnwZk++QPxLTN1jmPJgCfs+es3Y/HqT0xIN+XWB5+ghCbnbOWrUYXB6w/rL7O3OtEaAf5fwEXEcBjQYPA6J5K44za6skjVmuD9lqfG7wLgkC9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(41300700001)(66556008)(66946007)(6666004)(1076003)(478600001)(6486002)(6512007)(52116002)(6506007)(2616005)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(7416002)(66476007)(5660300002)(83380400001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0XfYqQm1GZ0/zLsYqe9LNOE1Z1hs6rm8Y6hUef5Tv8eMq9Jj6g+XkXLSCDZh?=
 =?us-ascii?Q?26a1qWZVn8Mz6TbWj7HR27dOUkPsNcm6uwmCsC7ImAgAPMSkrJOvSWOeQZsy?=
 =?us-ascii?Q?KkJ56+kkjWwQPHvVc7okckBovlqVtci1TJyUjWqlb5orel+nS4HqI+D89FGD?=
 =?us-ascii?Q?ikGTK01N8Qg93JmthwPFxpl0DEpgUuN8StdLp+045DCy3Re5TP1cLrib0Cxg?=
 =?us-ascii?Q?OovZ5WtGe6qZ7wmu8vGS2EiHIPeLTzW5IkkhSblpKZFqihP06Dyk/p7w4pnd?=
 =?us-ascii?Q?gKOrX6T4f34KRTkzv/n7RPLqikC7Xtcr0SwqPO/S7i/pD1JFSW55Mn6PEN+6?=
 =?us-ascii?Q?OjoW5MjgAqTe/zUl23//Nco+JnM0wm3syIAIR9wkvdu7R7IEbuWS7NeENaye?=
 =?us-ascii?Q?G5DmBMK6vG2THFJzplwiWGGcaRYUCBOoipOmJRHeXFOAROwywR8kGPNJYfml?=
 =?us-ascii?Q?E8bwRecjZ6JM3Vq4GnU2ufzmosQdj9uw4+WukVmz413NAUvaY770VpKNcT/u?=
 =?us-ascii?Q?PlJztSJVIzFlImbjo2HsUF49zpTgaL9OtgNLUJFp5/XgP4YhQzd75fk3/fgl?=
 =?us-ascii?Q?k6OEWNhRg92kO2yzLAw0J/HQQzUQz6BicueBEIuP9+qMLXQeanEFproa9YoO?=
 =?us-ascii?Q?anP8U+Im+sm/8O4XdnxKlXx8BpNqVA3WMKcJ691SvKX9a6SUYpiU849Xa9hA?=
 =?us-ascii?Q?8BcuOeMb7NsMXqI7AQOxwIjkhIy89TO9M5GtFIRkPzHVjSZM+zRGTTnErkAu?=
 =?us-ascii?Q?ByU2CygW7wjcrcS55EycKc2xT3CJ4XgMKd7wW4GRay8zWk5KHoT5q22VRw3p?=
 =?us-ascii?Q?w+MSR6Rr0WNNXBbA1w9kbguDXVmX71eU5T8q5LW5tJursHMJgvi9pPSbDPjb?=
 =?us-ascii?Q?lLft+nk+JhdfS8Ee6vZ+BhhHrcIAUhaZgh2EAYaJwxYAbm2q/FiAKwr9CbfT?=
 =?us-ascii?Q?0DoNTpUDSweKUpIY5vIpwWOPXvtfcXsL0msXrDnWt/RyiZ7uEun2N0gF10nj?=
 =?us-ascii?Q?ZYzJygEAsxwJGfxGDjblnoPhHo9hxpdLnWfxSb7ufYBzlz6RGmrGE+o8uh9f?=
 =?us-ascii?Q?EC+lqEbuJDEvBnyrSHGXEzzxQZTrbaWSDPm9e5dYyNAEBKSxPo3+AagcCboX?=
 =?us-ascii?Q?BW+o9arnmEOsyzCSILLHbtLDNQh3hSWVq8BUA9dFG64wvl+dIDIaUoXQOzh2?=
 =?us-ascii?Q?xbZ1A0f9JuDuofANVblYQKRqHKaIbEvhfebw+Mxg6S2KjTLkFySspLs2z185?=
 =?us-ascii?Q?ZVwV958p9fd+OgML8J0TVqKR+VH+/iuMhkPnB9OYcZL+U+B1VwWTp1lnhhpT?=
 =?us-ascii?Q?AuTXAUVg0VFbxqjmTXOXqqgL4g3N+jJAWsOfrWXMi1N0VT7NFq14bre0YvAp?=
 =?us-ascii?Q?5ojgZRWqaLH54PGcn3uP3Xq2ZzR04zuV8LoqMPDRbSPm913zUYv2V5Rs/kLg?=
 =?us-ascii?Q?GkXtiBrqLn87upHS71NqPkVaPunPXWPfMTNor7O0byAxH5psstlq9fsw6pkd?=
 =?us-ascii?Q?CFieFEWB4bvT5d0uSQf15xwYO/mfwkPLdSPJbLgxwdAp/xURAokMGNETjPaJ?=
 =?us-ascii?Q?Yd1QYnaeli0DBpeeCt3Rm05k9JGPQvR0ppKU1aaf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f8aa86-cb50-4070-a4f0-08dc2670af23
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:19.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpzPLXdHri+s4JH9nScv5AE3Dbkqh4IPWXVqSzTBIIoSUsKbQXziO+D6ZUoisdCH/QxOhhbkjUbIbHNh4CHSzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

Add drvdata::mode_off and drvdata::mode_mask to simplify
imx6_pcie_configure_type() logic.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Chagne from v8 to v9
    - add Manivannan's review tag
    Change from v7 to v8
    - replace simple with simplify
    - remove reduntant comments about FILED_PREP
    Change from v3 to v7
    - none
    Change from v2 to v3
    - none
    Change from v1 to v2
    - use ffs() to fixe build error.
    
    Change from v2 to v3
    - none
    Change from v1 to v2
    - use ffs() to fixe build error.

 drivers/pci/controller/dwc/pci-imx6.c | 59 ++++++++++++++++++---------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8c816ff159115..4eeaf54709afd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -68,6 +68,7 @@ enum imx6_pcie_variants {
 
 #define IMX6_PCIE_MAX_CLKS       6
 
+#define IMX6_PCIE_MAX_INSTANCES			2
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
@@ -78,6 +79,8 @@ struct imx6_pcie_drvdata {
 	const u32 clks_cnt;
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
+	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
+	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
 };
 
 struct imx6_pcie {
@@ -174,32 +177,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 {
-	unsigned int mask, val, mode;
+	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
+	unsigned int mask, val, mode, id;
 
-	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
+	if (drvdata->mode == DW_PCIE_EP_TYPE)
 		mode = PCI_EXP_TYPE_ENDPOINT;
 	else
 		mode = PCI_EXP_TYPE_ROOT_PORT;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		if (imx6_pcie->controller_id == 1) {
-			mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
-			val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-					  mode);
-		} else {
-			mask = IMX6Q_GPR12_DEVICE_TYPE;
-			val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
-		}
-		break;
-	default:
-		mask = IMX6Q_GPR12_DEVICE_TYPE;
-		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
-		break;
-	}
+	id = imx6_pcie->controller_id;
+
+	/* If mode_mask[id] is zero, means each controller have its individual gpr */
+	if (!drvdata->mode_mask[id])
+		id = 0;
+
+	mask = drvdata->mode_mask[id];
+	val = mode << (ffs(mask) - 1);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
 }
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
@@ -1383,6 +1378,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1394,6 +1391,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1406,6 +1405,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1415,6 +1416,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1423,6 +1426,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1432,6 +1439,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1441,6 +1450,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1450,6 +1461,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1458,6 +1473,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1466,6 +1483,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 };
 
-- 
2.34.1


