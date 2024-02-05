Return-Path: <linux-pci+bounces-3107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF9E84A102
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2951C21A66
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274644F89F;
	Mon,  5 Feb 2024 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KdC8zZts"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C294F88F;
	Mon,  5 Feb 2024 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154510; cv=fail; b=hwlDYf6cSxpbxf6zFqNd4tj6EnaFzfwNGGy3XVrzBjkmWgaBeMb/xLIX1Fh2lbulpf1DbOlekmnvoUyCI+mLzu7lGS71289YyImsNszDb7zSy8FLxrZTg9Jh32TbJsTzoUJbEQvg8l+A/1NUeeSbEirM8Z8NMpJPjWcYTg0/9GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154510; c=relaxed/simple;
	bh=txoUgltVuwyUlxb1zpN33wKzXZqRhrUJNo4h1FVYB4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avTw4ss3v6fR3kyVg+gyZ2JwHrBq9nSOtz/SiqfVIDTqLvK4lv+joD7N/yh5/IsrA3BWCFaBgBEGJAhqJ1HbxSdJ2JO8U7t8AcCkoXUyN72PfiO2f1njerVGNPnPfSOPrJH9xkdhtxNMmnA9PWKVHyDtDGGHW3ddFYKOEXNVqjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KdC8zZts; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUwS10QPLJmol6YOEytv9IJjgHGyAzB48sUkfz2R1JGBo1ICVMvAgDkR9zVnOzdoPhb4eGxwbcqXAFvV3qmNaYB0h0uDYvMPkmKgcyAye9JsG1WvrRXDnsdZv2JbB1usSPqhtDxIxvAD0mBuxeJpyHRoXqc5pzppt6dNssJmU25AH2tTGt/EUI0Gra5KCMmdB4gubGsFROI39aJLrvResZ9FbDyLn2JUfsqSm2S3sYwZdrP4GknwqOfvbu75j6jDTMGRsdjDd+bLIiyxBvG8A3/04jWN2oS+Gn2mvnCwRpMnHH6cKWWbKKhx6jynusxPmpEZWTnl+CpYb5dLZS1g9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAG34oN6A027qb51av/W2AfXMhXjk2rwEFsF0FWAX4g=;
 b=akrXOWxRUKfuEeOwPcv9UHpO/OsFbIHedhKYC/daNkVePB0zVtDRETIcBHAfysr1R1xKzq0cxvEVtUeJVIZpxbqo6PF0OSF4XmaNnySZYcxYNSgpp/qnBrQUi8nLtndDfljNIHsfkdKIqJfiLcjMHPRWmJKeY7WugIZ9scZZJJUmWq/F4uutVO4A/Vu5BWmYnib4cB9kgDk2upLBx+xuGokSfevDHlTzC6dxxYj5MUr9svB6eTCDB11muDOPw4R1vhrKFGHxUNZgG6WhISdyvIPwnXXwuumane+aohxTA+hSwv6v+2Co1wjGFou2Lyzm7z9BrVeUtmN01YsYsjy7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAG34oN6A027qb51av/W2AfXMhXjk2rwEFsF0FWAX4g=;
 b=KdC8zZtsC5i8ywIaQ6RycAwY47ILB7fCCLTCjWZ9tj0BTAVIgtqUoyUR/hwDBF8hbiORqBvWLC3YY1Jkyz8/ocLnVb4r1lP4PXwLQZGLcoJcRpDMA7WmcDSNLtq47345RMf1nKkC9op6XnaiJ3flLH5tfL9/9MDxrOmtmpqG7fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:35:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:35:04 +0000
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
Subject: [PATCH v10 14/14] PCI: imx6: Add iMX95 Endpoint (EP) support
Date: Mon,  5 Feb 2024 12:33:35 -0500
Message-Id: <20240205173335.1120469-15-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7c54d9-07bf-4524-3a32-08dc2670c98d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o7jQx+nkRLvAhfpVhG+REojufx3a3XbJ/kwgD2h4lXdhjmm/5ygU/XfiAUmGE5w3nwkk/Hoam56uMz02jaGgVJxM2/x6fm0cBCz6joDng1hrILtrhOJNi9H2wH/0G5P/wJwLGWP3WkW0P22dcfWu6wRdBoXZ8BUmLTW7v8jWakbw/M6I7OPAU7n0Kr16fkJmEH4RxJjU6+1uSKYhBY0hy/h1XYp1LHAMyxn/JT3J0kWT6SbWeXsp0pKMPjrA524E1iF9nCvjCkeBKJSSCZ+OT0Vh+shxRu8sLYItd7KyrfnyxHzvtlLfR9WKKu7WqBDFldiftXUWewRY61zpDiovzkycCFJQkgE3aRxlCuWWFui+NuZIKt99As7WywdTuREEL2ugVWWHeQcvH74we3gqwW7O61XuFk+J9oWN5MTWR7MT0Bt1ozbGVuWcrs9O4V1FiHNojT4TmVAInpzBegmsXIIUWKaW/gu1Y4Un2Jq+U+TYgCPJyooxlh18276w7+6vI6ZbqbTHo+pexEXUzH6bA0/ymru60qBhfCNgJ+1QhorGnd0wN5vA5w4+BJD9K807mvMGKnbc3reVFQfkt5GAophrsz4n8xrEieoc1qHpJzX7b6NnCIIIa4hKS+/3QZir
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8676002)(38100700002)(41300700001)(66899024)(1076003)(2616005)(66946007)(478600001)(6666004)(6512007)(52116002)(6506007)(66476007)(2906002)(6486002)(4326008)(8936002)(6916009)(316002)(26005)(66556008)(7416002)(86362001)(5660300002)(83380400001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ykQ/v4WvwNN2yWtMb4W6On1GI+wtqJ7KoRs+pSojf4tO7UUMtjTMvyT5yBAi?=
 =?us-ascii?Q?fRZKnIXoKvtjtHTvaZArpO797QHDRLhGZyz+a9DJ5/I9GxLFLHMDclz9QHSf?=
 =?us-ascii?Q?CCCMQ+/lUKHqM9+dVvhM5NHFrRsPf1l4Os2a6149H0797Poy4ujY4iontVBY?=
 =?us-ascii?Q?ah7/DDGMnOGAwyF5dvbySEsFmNLA9x+ESftmh0g60j8ZwBiP9c6kGBgwflaf?=
 =?us-ascii?Q?yMEAZBKL0hQrGaAWmCQs+1R029MonYXDpmgpKJuuoV2i15i/pSe/572VuiEv?=
 =?us-ascii?Q?nlqPJKhHAuj0nXNzo2f164yFqvNWg7Av6CNbL+5ffiqoPaTibZg1ZKay0Iay?=
 =?us-ascii?Q?ALa0svrepNNXQXU+8qN13fke6oaW/Xjd450bFj+U1v2LqfnAqsDQTRPsr5TT?=
 =?us-ascii?Q?GxxRf7Ecjwd6CDWSFpZ0Ea7HPH1wFbn0Rp9qlUgE6Xi9TQbDbWcPTK1sVWUH?=
 =?us-ascii?Q?M1T4CkIEY1z9fdPU/YyUeyE0wUJ2x7Gz6dyF/oC/TR0eX14lTdtpm9vb7HJE?=
 =?us-ascii?Q?/fVqjHTICl28en+8CrY3S9HPSOfejY+GiGPQ1FLoqU099IN81Sz90c0RwWbB?=
 =?us-ascii?Q?3MvX0oSNZxac5esbBIHrkIK4hzKMPzQ5v+OBa4yUzQ1iQSIxg9gtq72kap69?=
 =?us-ascii?Q?hTvaqhgwQESfEj8ZYWNW+qdpUqr4moG2IwGy/Mb+ZCOQQ5fQB6rV8mXb5WSB?=
 =?us-ascii?Q?rYNUKia+6sgwp01UIN1nEDY7MG+0i4E8LkzEdbEzuIcRNwm/Vr6k8MYDjkWK?=
 =?us-ascii?Q?pAequUnA3PygugO5WCL3kTHv1IJ22w/fAmqlZ09kLQXN6f4mhi+atSHTHY2k?=
 =?us-ascii?Q?jwAm0LgIBwzyBdUdz3icWF5nJezSzYKhT/4QUt6SuYFV74d0ZymoxTEFcd4U?=
 =?us-ascii?Q?2VSw//XdjKkV2+cyX6ind4GYdDqzbYiH647nZ7c17STuFb7Ohx0eQwKnRi9u?=
 =?us-ascii?Q?NGTYzUWShmWl33w1akuXYb3EcrF6yIKPiETLAEV1WAMEgGlmg39meNe6WSU6?=
 =?us-ascii?Q?t2Nmnc1WBedpc9WIbr5Z+Rt+V0hkAATYSL+ubCPD/ZaC3f9DeWn/ls61IyVO?=
 =?us-ascii?Q?4wq4VVmiyvmrhI3ws0y/zV/kZnu4sG6SpXTTloLGYuJtIB5+OewJPCFKeYS3?=
 =?us-ascii?Q?ZLGMl2vgZJJ/rrxTsVd7UA2KRX2QNntxE3AydhiNl/kI8Ueg/ZqX25WT+sDD?=
 =?us-ascii?Q?MCDBXJGn/EC+8TmfXzQ8cvx30m6cc9j0cHhewciRff+POj2OQhOn0fQhhRaI?=
 =?us-ascii?Q?9qah0JU9RlUp7XDOPWz2Zhl1lm2ybaPsVJBddGx2Wgw9zPgeI1ozbGchFw8x?=
 =?us-ascii?Q?Zqp6vRCYid9XCUMF/IKDSlIo3ygE0VyJD3E8YIUaan6Rw9BylwqOXme5QTf0?=
 =?us-ascii?Q?fAOW0+LryMXSNAK2Va1mqffay/fodLPDdMwDkPyk7v6xN9lLfjEcWNHmWD6W?=
 =?us-ascii?Q?HvDJEoOsCILx7i5FhA6op9d22IhOxw1uD2rMKK0MouJZo9i15dyMtLqqI34d?=
 =?us-ascii?Q?MskRvaQE5C1uwZnP+01/hi7/GIYPy+bJBohCIDo9MOADuGLzv72CyIlBooKC?=
 =?us-ascii?Q?IQlO8wurZXvQz7TY6RF83Gr/y+ComIbs4lbq6Rk3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7c54d9-07bf-4524-3a32-08dc2670c98d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:35:04.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rwC4rkRTUqkyTYgWTOyVQpVSyq8P9X3KwwvGJjTLeKRHSCSAYU1ZDfM8SON25NALPbaneUtvoMKHfODQ63rJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080

Add iMX95 EP support and add 64bit address support. Internal bus bridge for
PCI support 64bit dma address in iMX95. Hence, call
dma_set_mask_and_coherent() to set 64 bit DMA mask.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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
index c2098e59fde1e..472ff1cc17d2f 100644
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
@@ -1050,6 +1053,23 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
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
+	.bar_fixed_size[1] = SZ_64K,
+	.align = SZ_4K,
+};
+
 static const struct pci_epc_features*
 imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
@@ -1092,6 +1112,15 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 
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
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");
@@ -1343,6 +1372,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "unable to find iomuxc registers\n");
 	}
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
 	/* Grab PCIe PHY Tx Settings */
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
 				 &imx6_pcie->tx_deemph_gen1))
@@ -1561,6 +1593,20 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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
@@ -1575,6 +1621,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };
 
-- 
2.34.1


