Return-Path: <linux-pci+bounces-3786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46785C138
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A7F1C22EDC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87A87BB0C;
	Tue, 20 Feb 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cbpYMjK5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4047BAFC;
	Tue, 20 Feb 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446060; cv=fail; b=Eoo9aIyM2SFCHgdWOZLrJO8UuW5vbI7Rng0tRpSuHvco9kxFWPzDXVJK19miQuZ24Ek1uV1Xv+oYjoMyutkadoH8QDhil9+S7XQw9x9q/qJ2ojBdkTsx2fM39+NdDz+Fw4vITExuQXIFhDNFzYiOKA1KH5c8x5L0xr8BWp4rLnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446060; c=relaxed/simple;
	bh=ytffS0tPC/4Y51iqw008hH9UdLpjjRhL18XmfZUUj1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tvUHLD+FLDJmN/FsRYKGqeX6lBjuxHHYUCFAuvUUZ2sr7wToYvGat2uOxqAsHBu7X/g7LgYqw2a62NtmF+7J0MCXeoeYuDa5LriLgPKYLvjJEXECVc9MlTrBEW78DkPjQaevyPhdSLvZ4i5q8SMDbqYlS3C1qFU75dHZqSgmpEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cbpYMjK5; arc=fail smtp.client-ip=40.107.249.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8B0J04s6svDBsY74L2UDhdpb3USWxeQYJOLhSsBqVNX44JJTt773env3+MKmTVpoxRcPQbPUUV/mUpL3NfHqiP4wthcvWQooo32zf46ryflXBh156FvdxvwwRvdl3W2/mwdtw6AB5KK6OtR2mWigNtw6hVkujNqluDEql3t9uTfX7FjNLIgSAosz/OSyU+aOoP51cn9OK5mm418jbWLRMTmqaCtj0NMNchzx9gzYjcqT992VCDTKHasRTi7LHG0FPLoKZeXG+kyaYgftimlMUlYZRFpwMeCtHpi4eJS5Vpmuip8q8vEfH/6sndsita7wSyhI8H4QMljcULSlhWQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeVKN92ghJ2swGK/lD4v8KOUX3YGM9sbkTM4Dort/oc=;
 b=VXpsTe4haXXS8h7V8KsHIu0jFe5QpVMdG3KgXYuNiBY9YC000IizQVdnq9/8msQ7hFDLQLN6XZx+4uJJRBoXXl+84HUMXVw4dhDjTEROPZEBC32V8XbVuopyKVwV2Siryg1oEFD6aPQOStHtuntbGOVB52KI9ZsP1z6x5TfQ3UaDWeMf53UmMXYmKNVtKzt6Hl2ARdrgerNFvhZh4IYVg8zut5cfDq3LxrfJpx4hVnwkKOK31XJYeMjuEUBUYV/M6ZIXR9MgU9Hn+spD/YnCB+IkRBjc6RM0hSaV7Stv8B2ZnZocO75aPmgubG9dFG6xqTGeWo2CY3Q0F6XEfX6ClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeVKN92ghJ2swGK/lD4v8KOUX3YGM9sbkTM4Dort/oc=;
 b=cbpYMjK5ok4PTv/yKY6BqWHAH8VsHC7JK1XUWi5ubWXU9diJbbxpTZcZTsPadc9+ztEsaSwluEbgN97qVrpyfjPu06ispK29vgu8nfwRK1RhWcp86xk45HpGwg1/xQm1AU8P/7S5WEG6/5cjUpem5CHE/Oxfmc/+O/Nik2ww01E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7295.eurprd04.prod.outlook.com (2603:10a6:800:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 16:20:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:20:57 +0000
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
Subject: [PATCH v11 14/14] PCI: imx6: Add iMX95 Endpoint (EP) support
Date: Tue, 20 Feb 2024 11:19:24 -0500
Message-Id: <20240220161924.3871774-15-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: d83fcdb1-2934-4032-39c3-08dc322feb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BqJy8xfoqkXvZ+5E/AaQF/KClkWC0nl/t0V+6HOnsE8dNf0J+pR5/X0eI/MJJvM8od4M6EkE7yznugcaE3PKVBh4cKBcZVS1xYlUsRx3Lzu3nYVbx+MfEwRqMBPqnAfLVX0btaQCgmG8GARCSb2PN5cRlvtIzAgJXTOxO9ebbcO36ImIjSV6SAM4M+9RMzpTFjlykHvJ0oRAdI9ivBX/ZFFRHB4Wbq0UemHECwqckOdKEq5ibteEEvYGD35c2JppKLodE/NVGk7Vhgk9nhs1dh0BypxLwJ1oIpxIcjyYRNZZVcqiiEto/sEVEgsSxUqs4qVpPhnAPJ4ykeRLHXx9qsBozjYvmDFUZ/oEOgHKnjSrMdavVsn0fOOKabiGKu9rVLr0CdSjqHEJ9maoyNit0xukNSmOTCOGE9XIzCXzENwwgeZtRrdYkRnyx1YGGqG0IgHS2+bRMRvoq4FI8XSSMMI+7BjHdxGoF5VjNfUNlNfkBkD4IvRpKs06GFnT950AadNKjeSuY6A5KE3KjNFf/OBRMSTZxG/wPWzQ9f3rwXnzfXIJ5PhG4FZ737ocWyX6Zmiq1shd2WxuzHGsItGkbj5dWqhAUQ+/A6xx0/hydzUlzGSP9Ao52bUmDafeJ5P8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?00Z2fA1316RyS33bAiCTRYhKKUitY5hkckWvW8s3UFCWwrcsCXM4sTrxjlju?=
 =?us-ascii?Q?S0asVOtAsVbCuNbc7winPJPwD1IbijHVZVkaDZMdbAci9s0D3x5fAVgkOMVr?=
 =?us-ascii?Q?NblF1NH87dX38VfLXK80aKrl4L26eRIe6u5vxs/ld69/PbRAr4SsxaEbis1J?=
 =?us-ascii?Q?DM45GHSJ81gsd6zBamGa4ZauHz16aVaqA/Htzqaaipj3IdZON51eZWsi/S9L?=
 =?us-ascii?Q?hPdV+hkrex2E1vj3MA+hbh2tgnlgHIcxQImAfY6TB8LRD45lvGud9Qz3cdcC?=
 =?us-ascii?Q?PaqCo23zqkKkEZ9xZuhkHuWILFWeQcFO1gcRccLdUsDkY5kGgn2WbffSAiHu?=
 =?us-ascii?Q?TOYsLQriKEMKebZDOeME0gekel93L1hR6ZfY32szdhh35Kcd8zzDkXuatRaz?=
 =?us-ascii?Q?gU+4et2h3Cza4093lwj+FYMZnIAdVr9HfDfGw1Od0MtX0FopK5KKYy0ESFpf?=
 =?us-ascii?Q?fQvGA42HRE/2obf338/EMKRNf2W8FucYQjXbofvp93jgwj7GFGGGMMF3+Lru?=
 =?us-ascii?Q?HpaQ8WNfUomB9QJs3YVyDF4DdTGAbvq2BNWwJVAGLJchvE/WGbvjpp4CNUS5?=
 =?us-ascii?Q?dxLIA1ngphwKpIioOvHCXriiZJncvarsb2hF9JW8+TyMTGorWa+L37fwdlHI?=
 =?us-ascii?Q?aQaRNMebkyofIaTZ/ta/a1VeZTPw3wSob/3AyBo6J35/BwUy8MOO6o062+RC?=
 =?us-ascii?Q?3kzXElh/3tl6sl/iPu2JbNP8WkxrVXl/MraEWuodYizywi3A4IeNwvfqHcPj?=
 =?us-ascii?Q?0mPS+7RqX77aDZEq1UOWc2vdUy6s7w4aIbP0/Z0DqesWVcNr21ovBCInfWnP?=
 =?us-ascii?Q?pU86AEXhCS/pCKgqc/fbqfnNwT1rtd2pL1Q9JO8kBiHqAY1VH/7M71hSUuo+?=
 =?us-ascii?Q?2vD0CUooSXPQWOalDObxLIHNDtzCW4mm4jQnNzKAY2dHu0TTqDobTAhA57X6?=
 =?us-ascii?Q?baDv9JOGeRZaJZ1+X2UfT74IObi1SPwMj7rxFaqyRJgb5Il/fTSi/9dJFbeU?=
 =?us-ascii?Q?etjS7ZVbDfUh+Sc+5riuFWNWMqCoGSUPoZjZsSXU2aVj++iqBUZIvLBm2a1b?=
 =?us-ascii?Q?CZ1mqfMJWl96KfNWGsqIKzbcMydD5h9SfPinlZjh2dSvSAY2WDVKNG28+4VO?=
 =?us-ascii?Q?JZRolgVw3s9AmWYPJAOIhxOYY1XrAPeSiAtCRQSCmG0A7BL7XgDmx2PjOmJw?=
 =?us-ascii?Q?HxuFlcb8u3nac8wMq2EbKvCB+KZDoQsUA+lAVgbAvOiXP18nE6uGZaG7w9IM?=
 =?us-ascii?Q?ujv1oKJRF5K4TLErrasbP9250qPx8dARYT4AEr2Tv7tlIgUdbmzOAfbR+5Ly?=
 =?us-ascii?Q?Ktt3gjJeXp+PeVPDPYqRopvVHdauWe7FSPaqCwNzmEiC/AEQRF72pR6Jppvq?=
 =?us-ascii?Q?392zSDOn9JL0A2wQt+BoSaWJG/zYvpPM8hQHJKkwKXRIc8tELXPoKh/n/P8b?=
 =?us-ascii?Q?W6MHmZAPP6A7Gqfi1MmtIXYXBmpNQZbrSzlbGhn6coP3/TuLK7Rj3TacDq6m?=
 =?us-ascii?Q?VjESykIIG7/X1cMMrd3XbCytEO5Sz2gMmcjShzcx/SOkJKhk1NTxulbjHPbM?=
 =?us-ascii?Q?QFsyrG+/S78832mxBaLiJVQrLgHkI0Tzw4hasgIk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83fcdb1-2934-4032-39c3-08dc322feb6c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:20:57.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWnJ1et+KoqQ7osfECCyomEs/q0p37HZjde3FJZzeDazsMm+O909hykSWdteuVTPiaQ7HS+KK1TV0lBkGPqAdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7295

Add iMX95 EP support and add 64bit address support. Internal bus bridge for
PCI support 64bit dma address in iMX95. Hence, call
dma_set_mask_and_coherent() to set 64 bit DMA mask.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v10 to v11
    - rebase to linux-pci/endpoint.
    - move dma_set_mask_and_coherent() to imx6_add_pcie_ep() according to Robin
    Murphy's suggestion.
    
    Change from v9 to v10
    - using if (device_property_match_string(dev, "reg-names", "dbi2")) instead of
    	if (imx6_pcie->drvdata->variant == IMX95_EP)
    - so other platform can stat use "dbi2" in dts.
    
    @Mani: I change to check device_property_match_string(), so I can update
    other platform dts file, It should be better than
    	imx6_pcie->drvdata->variant == IMX95_EP
    
    Change from v8 to v9
    - update fixme comments
    - update BAR1 comments
    - Add mani's review tag
    Change from v7 to v8
    - Update commit message
    - Using Fixme
    - Update clks_cnts by ARRAY_SIZE
    
    Change from v4 to v7
    - none
    Change from v3 to v4
    - change align to 4k for imx95
    Change from v1 to v3
    - new patches at v3

 drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index b714edac6d566..9c2ad803e1dbd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -75,6 +75,7 @@ enum imx6_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX95_EP,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -84,6 +85,7 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
 #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
+#define IMX6_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
 
 #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -616,6 +618,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX7D:
 	case IMX95:
+	case IMX95_EP:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -1051,6 +1054,23 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.align = SZ_64K,
 };
 
+/*
+ * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
+ * ================================================================================================
+ * BAR0	| Enable		| 64-bit		| 1 MB			| Programmable Size
+ * BAR1	| Disable		| 32-bit		| 64 KB			| Fixed Size
+ *        BAR1 should be disabled if BAR0 is 64bit.
+ * BAR2	| Enable		| 32-bit		| 1 MB			| Programmable Size
+ * BAR3	| Enable		| 32-bit		| 64 KB			| Programmable Size
+ * BAR4	| Enable		| 32-bit		| 1M			| Programmable Size
+ * BAR5	| Enable		| 32-bit		| 64 KB			| Programmable Size
+ */
+static const struct pci_epc_features imx95_pcie_epc_features = {
+	.msi_capable = true,
+	.bar[BAR_1] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
+	.align = SZ_4K,
+};
+
 static const struct pci_epc_features*
 imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
@@ -1093,6 +1113,18 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 
 	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
 
+	/*
+	 * FIXME: Ideally, dbi2 base address should come from DT. But since only IMX95 is defining
+	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone so that the DWC
+	 * core code can fetch that from DT. But once all platform DTs were fixed, this and the
+	 * above "dbi_base2" setting should be removed.
+	 */
+	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
+		pci->dbi_base2 = NULL;
+
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");
@@ -1562,6 +1594,20 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 	},
+	[IMX95_EP] = {
+		.variant = IMX95_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_SERDES |
+			 IMX6_PCIE_FLAG_SUPPORT_64BIT,
+		.clk_names = imx8mq_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_phy = imx95_pcie_init_phy,
+		.epc_features = &imx95_pcie_epc_features,
+		.mode = DW_PCIE_EP_TYPE,
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1576,6 +1622,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };
 
-- 
2.34.1


