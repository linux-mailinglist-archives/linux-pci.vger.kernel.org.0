Return-Path: <linux-pci+bounces-2390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11243832DEB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362E11C216AD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608D55E5D;
	Fri, 19 Jan 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d1AJ1HiC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475575B1FD;
	Fri, 19 Jan 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684389; cv=fail; b=u9Pq3h8ydZ0oK+ht9p8uQqdzfzSgZz+l/AMjKdYZRUfu0aD5tKL/bHjdoTYNa8kr6GsSvCDeazpJYJ4wqFAFoFpWyeLGfVVbITVrIrJ7+hMDQziiumFvNG6W2D+7jqzXQvrDg3dfmTKZ7GwbSlsisr3AugDghRW5g56raUlw6/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684389; c=relaxed/simple;
	bh=+Q0IICt2ch3dBBw5kHVrr2Xz+fYGpsYBd5PjME2De+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MNIQzCvovTfubISlkNAZBudRc/XEhCMZIs/zAbUFPfW5MNfFP6sNiMgk5WZjlJCbxneOMLMT4xaU7PzR3mp00U0e7BijOurIlACL2owXXsLT6FddU8wiU92NbthvdEzz19uaejlfrILjzBX/XNHonana2/PA0daXxO1yzbQ+R+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d1AJ1HiC; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjigyip6ITVSPHtF4AkucJskwC5n1g7vrKxQku2M1i3MudemzL3nZM3hj02QlaUG5xctVsY5Ek4kAXHCXaIKVDCZYgRnCM091LtEgH1BNwc7jo/kCz/2NRkL+1s/lFoAgdNfiZGSLPP1oTfMFfXPstCuE3rAbTqwKfjC247ghI/xy848cxdYSm+BIfeBchr9rWykdCWDEBsXullQyfZVhm31pSAyxr+VsDRTVc4u5DeY4cjwSfCfpjBcsaAxVqkhnkX5Ly1pIKKGvEJi7gR1BxXzYOicaJ+oXfxGxApi8sw2jN59j088ybsWFL5fqu1lBheVk2eAtI9rfiBO91MEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDH7EfSahdgK3CnXM2YfNj0k4QQDERe30PCml4CE5Qg=;
 b=DO+LVgbusSG/fO/TnY+KDr+B8z+kbhqVL1RXUTtyBSppoCZGuZmrIzL60kkIuChWtOguU/Sm3BheznOz7LpWqgxWM7nT/c0WpiTV0QPXLjBXlePni6p2pUb/CZZl4lL0wFR8gQhFN0vHVbyh0Mz/v0O0F+wERcyCB+iHeu22hZhhZxs66IydykIRNm06h6R+TQaGNdTNki8P7XHdz1B4D4ePshQYuw9e9WpQdYYaZ95H1tfEJGUB490ox9I58FpDttVjyoLIOQhO79DYk+/wWbWLJcBJUECO32a0QBkPrqjmoqbB6+vYk3Twce6DXsH8JFEMvpA4W1nh/SYgQhgc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDH7EfSahdgK3CnXM2YfNj0k4QQDERe30PCml4CE5Qg=;
 b=d1AJ1HiCkYyhNC2LweaCjoMgFWrY+zAskHC0xD68/bfSE+Top7q9gDHwXiYNADohYXEIRRdee/9DtDwC8V4OC4tbkXcgY3zngczRPqsmlc1x9YTs/9CaCI+0OQM0ZHQpfS3ERNSUfJSgPKXdePBwB8JLZNE2XE0jO5/EyUXHfKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:13:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:13:04 +0000
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
Subject: [PATCH v9 16/16] PCI: imx6: Add iMX95 Endpoint (EP) support
Date: Fri, 19 Jan 2024 12:11:22 -0500
Message-Id: <20240119171122.3057511-17-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: aa727cac-0a72-483e-69fe-08dc1911e5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bMLAXfGunQuVLQWJ0GVsnNEzk6Fwr+hmMJZ07b9FbP/r3NsUqfgrPohCLo6qiU1KoKlrGkhkBNBFFgAA88zSdhlLgtXkv8nGKjFVZFYZrR/fdferojpA9M5zqtArRBP2oxlYxnspkeQjnuLroj1fWl3SdWqE5opAC/ysU82yP3OAVqfIR2iotWgDFt6yGclH5rAt9Mud4OvBYOMaxctOmnB35OLSJ0CVQwNG4CWATLk2Cg3hPsq3r91OIBr9up4GzkbZyFq6dyVRe32Fa6iAUcxizuiEzj46H3FF8fXCqKz5b0ovzeid9CEicgm2DnmCbRGqF5UPmuXBL0DMZv6RNvQG0bzz7gTBkKJUQpPcPSY6zEB01orKVMLGl/RUIhzPNyplr/yQoeyHdNzCiRk7innVBzJsi3hd/kkHW6BLHObgRW1wIOIRdCij0jOzQRIZD0i87ef+uXf1zDaMvV+yEKWp8Mg/LhPD968IKKJYw30enWkBqGBFOdHwMPCxK554bKFmaCZnsrtYEhbQ5+s9Hh2ZFWVV2EHCL1JMVprOj/YeWlRmVJKbKbw70wtmINOFsmYIQX3/hNenX5XspLjfd+hDjmsYr7rEFZQJRhfpaV77R/w/o1uh76JsXQC0PmAS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(66899024)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yymx+sZ6VJQU4KT6BHFE3fjklr0kHnfcgOpicW0FPs/iLQAqaHPBnyq6K7QQ?=
 =?us-ascii?Q?zNRA3HMVv67pTX5sLeFkq3eyPMtYKt48cLqb17HidHHp6AWZhmV1J5eYMulH?=
 =?us-ascii?Q?CHFpIT5pvRvbNRD0R3N975KPxlC8fjOWjC+2BiylrNhVNUjpwbege4yot7YC?=
 =?us-ascii?Q?C2JnO3Cu1uocSwZhfHkGkJxXzL8IcSxr62jwONHDP2s7XzWGF+PfcUSmtqqR?=
 =?us-ascii?Q?XQO1ziDqX85QalVqe2XHF8FdBZwY7RCcrOzZKukISpxbvZf7uGtMLM4DxNtS?=
 =?us-ascii?Q?HXlnHYyBaymUAtZ+N85Dv7+AKJkI+13Y9ANAukXqQjR65oKM8AGynAzLP/Jl?=
 =?us-ascii?Q?uLY8LcTSWneQ6YQ2W4D6AA2w2zENV76I7SzNuNyyQNChpvyol/kzyhaOpnKh?=
 =?us-ascii?Q?t/GBiW0OUHumEW0FKuneOKbxWLblNDnsJE4TVI2h4Qrmcs5dO3kl59D9S7pS?=
 =?us-ascii?Q?ucCMnBZ0LENjtChkNCSyf93xxYc4/XTXEJWBHxNlSVmovDmr4Brh/z8vBy+k?=
 =?us-ascii?Q?xpcUJ0cZ0h9QJTDuMIXA4Cv9RnDR0b6nTFC+QpjkkRyqAqesrgwKBEAGzGBy?=
 =?us-ascii?Q?VtLGJxF2yC0mBsxKWJOCkrou/Y816+yzYRfQLWS+OEuLh0tJYUXAlf2Aty5b?=
 =?us-ascii?Q?0MKLQJMUU6DzTJ5T43GMhqUyIaYhYMin2SnnA+az31JtZC3KSoyWw937PEUm?=
 =?us-ascii?Q?GFPSjHgzb3bnnf7lkLmEJmbhnsiemR4DQDmfGVm2uzAQzdtjc5A7050qCXbv?=
 =?us-ascii?Q?EnGp8J81ROpgdwEzl8pr70MXgptx63diZ/wB7zfB5LQOJHZXUVgllyGBnXaG?=
 =?us-ascii?Q?ZniF9J93OTN5ldlJ6icfJyfFIB4RswvjL8QCms31tWq1A3vZAcFkvxbtVfcu?=
 =?us-ascii?Q?uf6Er83lZExL23PxaK/aGSYAJTQjaox9d4RiJ4QDXSnkqrg7+A1K75DEzAhj?=
 =?us-ascii?Q?27WlS+X6a+J+QaS4Kdv1ec7Ex2SKDAIDd7iSbuO7yFGnrES7OuTHCjUDGoqE?=
 =?us-ascii?Q?rFx+1fyo/NAm+uCXzdk5xBTud+GWhS12aXTzw5udb9LIw3zxg+pEauA6HSTk?=
 =?us-ascii?Q?fcimXCFTb13gC5UBQzZbti3O2Sa66AF/5KznLDGmeXxYuSeMQBN4gKpYM3B0?=
 =?us-ascii?Q?JT3yL0htsvHgJCF2EEXAjv40fmCeHUomi4Jn48Zb9KMnfn4UFjkxjYzWkG46?=
 =?us-ascii?Q?hG/FKl0Pl0N8GuHqfNG2LByz9+atdxQGbwNe+/j26MjkpU2dMJHcyD7PdbXt?=
 =?us-ascii?Q?DxMrYESlXHY0mG5psaKmNPgVdn2EvSNYxpSXh01S8xNcek0VlwNdIXW+SfOh?=
 =?us-ascii?Q?iabkZdONg7qIRc5EanRYQ4ymyW+sB+hi0ZlrUjZ+9PUzemvajrqoJ05vbBd5?=
 =?us-ascii?Q?oqRaRVY2Ql/FfsEwKv9lTRF0VixLYRi0vf7SjknQeb7EOMkQe5jU+EpImYuk?=
 =?us-ascii?Q?90zxr1QbOHnP2YvE/0jNSxv9PRoMtUZ3YnCFVnha5YmnOvujSuM1Jjk8pDcK?=
 =?us-ascii?Q?6+OB8Lkd9X0lvF+oRp5yXFHo6Jg1mFbF5Dg8sLiY0sy3a55SemH7WXLb//YY?=
 =?us-ascii?Q?VpA9JyQ7Oa3w+zc4EUQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa727cac-0a72-483e-69fe-08dc1911e5e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:13:04.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANFjF++TxNxBvSYoVvfUQbtSTUEXW51ifedSFunoqfU6ksG6K86VjLVU0U41PA6DJ9BAk4zllnDfgNRhAzwYpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

Add iMX95 EP support and add 64bit address support. Internal bus bridge for
PCI support 64bit dma address in iMX95. Hence, call
dma_set_mask_and_coherent() to set 64 bit DMA mask.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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
index bbaa45c08323b..7889318f6555a 100644
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
+	if (imx6_pcie->drvdata->variant == IMX95_EP)
+		pci->dbi_base2 = NULL;
+
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");
@@ -1345,6 +1374,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "unable to find iomuxc registers\n");
 	}
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
 	/* Grab PCIe PHY Tx Settings */
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
 				 &imx6_pcie->tx_deemph_gen1))
@@ -1563,6 +1595,20 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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
@@ -1577,6 +1623,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };
 
-- 
2.34.1


