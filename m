Return-Path: <linux-pci+bounces-2388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8F832DE5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8841228785B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32F55A111;
	Fri, 19 Jan 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TMlt01eN"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234A5A0F3;
	Fri, 19 Jan 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684380; cv=fail; b=lHZDlNHedQz47VmpBRcCMH4ZpRjmbX+2CWKmxBSpnm1QRJFNmgCnEgcG5kXTPAMt5O3ItcK2I/gupmaeho83W5RQc3BiLuoNLNbSPM3/qbAWPpGFmNZ1JSUprv1dLoAz/7K9BifaWgNQKaCeUSFXzmAVAIb/acinzWSTjTeYlv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684380; c=relaxed/simple;
	bh=aX2kTfFTJOTjQdaIHXjavecSGExg6HdmtZPNEUTxQbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WdwpjOxf5tdIyTceR5/XuTMyqrgz2b/3T9zoio5x2yMFouWUP8MhD3c4v4LRykCToWnawiEkw0DNLwXTHpiGKp8e7zuFRv2OuX16KlMcEZT8SWTpoVMQwqksGQ0S0C7yZB6DzJsxvDdpLupZbonpDilhx2j2YTul6yuDByJ0nAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TMlt01eN; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io7KPmd5upo/kz9lnbAQjxqdfPlz2xjp9LPMmz0rRfe1cXv7KCxh9g+TXrEuUtpsyTCzZ6ZzsQUvata0wB5VWK3zADjHBQ8VWgJzMnek4kvi0UKzhmWiANG+lKSNbtcuYPtE1ALeXUsxxbsU5xEqEwp39ijxBuX9MPv25HuZDSkhdP24KG9TtMq78WP9oNOOYcgt5SN5eqU6ZJUP3GMleEAPgs+b67sqOSL3Pj91GTFcnW0bBy8Mv+PNto/ij7qrLaRcxbZqAjvFS8CyhlHHk+eSf0jdPQ1vafN0xDj/rUX34AB0J1GWNPCKiiF6L/Bkbc9KNAEi/afHh9QhRBAI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mORbb/XK4m6oYgU5P0b5hJ5Fygw88yyPr9Eg3vUULhc=;
 b=GGSq8fdjLEEWSI2dp0irYnRv3pIfUH3SGPN3AyEY/gicbTLFCENh/BLQa1fMXUMJkSH7P3fShqo+XYdQ/BsiQlKdh9rQHNY2Mr8jImKvbWCiQc1GL81RZ4k/74UoQKSc3Qj4wwliJjlRfHM8nrNAc9J3qK0tHVZ6Lti2697unLbCzEJ3W8xM2qLXcDWiwZktxzxyhZUS6ebeonvw+Q1H2YNoW4xLf4arwsdgGaLV79e+65FqISa6YgQT+0AcO7ztetOhD+HtI8e3cdwq/Q8oL5+fmHhGR7kl3jyOuWAFHSsnXKtmdjO71EjpNb9o8GukjFEZDx6+dtrablmefwLFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mORbb/XK4m6oYgU5P0b5hJ5Fygw88yyPr9Eg3vUULhc=;
 b=TMlt01eNoQ1/BwWnhZumY5D8/5olICETlS1gDAVlxDTLTSuj7Fama9nw8W82GuflDQeoHmRw0Twc1QFi3S+0kpTKS0q3G68sKNsubm4z2ioa/t3vAx+2rIj18/Mb2ehNGf3v+Qe8sPClx7jIG6SGXjlzQusGrV9RseYBQDUEUfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:54 +0000
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
Subject: [PATCH v9 14/16] PCI: imx6: Add epc_features in imx6_pcie_drvdata
Date: Fri, 19 Jan 2024 12:11:20 -0500
Message-Id: <20240119171122.3057511-15-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea694171-f8e7-4a23-aa0e-08dc1911dff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sYlVnyu5XdowAaHmVN9ji5aVleTdhhsKk7ajYvXJsxohWlMuLFM8iHOmnbx6M0xpr4zizcV8NqPRtYWEzgMrBa+ULTKPQoZj1DvR1z4OmoOAFJO8dmDDeWCgBb8b9i2Nk/2SjCo27qq2V1HJCRvkgUo+NluVohCzYs7vphSt6wDm9kaLOqgjfShUcyDAGpEaPkDFdzqSyWUa2VbuC+LxE5HGlddWIuCrYasomhN/Td3eheJuMgqqdEVPiFMHrfASY852nGS1Z94JU0WMqrLfq+YtSEazJ5QvZceq7HmPK4VSJxQf6v+wRiUzyzQAagQNdgaVzQcBvM8j1fT4JfJbjasVbCA4RhIULy7Eh0RbHF5REFISqQQYm7OqxdOTCgmhIH5dVfqcK3GxLHzBA+kCuiHhMM2u/TfJMrfvioRQrv7oStAcVJcFwb3gE+JMK8l4Pi0LkY5zOdJaRK6L7UkO+KafSqdIuxez1u5FFLc7edyJ5diM1WbzrXjELBI7uYkbRtJJ36l8+qXWavUy03b8qSGPLAuIddwy3vYnfTWTfYrekzx2Tll5rO5bFEmw+FzYMuErSwo5wOKLRUE6I2NmRNLo+97JAXLwIslW7BcvHDUWCJLkJz3Sui+4X9rQsU+u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u20wEspbUnU59aHyUVLqIo7SFojg7RlE2Yg/6o807aL1bKXriNoI/CAYMAi+?=
 =?us-ascii?Q?B5XnC/rquZV5lAXbAaYqJ+Ko0oEGxiU9Rmy7xMNDmLwGhrnVZnGxg/5LbWBj?=
 =?us-ascii?Q?DqPYI7ISkuuYFXVkqBeg1tc5KYIR2S4ejLDA3WIM8lYy4DJ+2hYbtzen+0q+?=
 =?us-ascii?Q?TFeIyTHqjKIJ2zxYPWHVQd81xYT2rLbcggb1JpCmsysLVlQiyEVaYieRIgC3?=
 =?us-ascii?Q?TALZLywLFXwyLIUQHz6ba/ADsFZlJKpV2tvsMg1BJqds5aRlN9Hb8+usy5L2?=
 =?us-ascii?Q?RFeOKJEdzbacwQRK5o5IYHV+1KTeVZG5oZ6rjGXvR+1rzR3GBQeotXZfPPdi?=
 =?us-ascii?Q?zneZwGSgF6i4qdJyBVmD8j4j+tnb+FIwl+5hQsutVjA1+y53ToM5T5FTIdio?=
 =?us-ascii?Q?M3Fj2DYCEvy0V764Q2sHd5Nyd3rZHv8WVm6dtYCXa8JykJg9+3msb1/ch51+?=
 =?us-ascii?Q?GL4VELyxI1CKBySglz752tr0e/wjivWnQWjIRbUtnjd9C3Jz44L4yVs5QH6K?=
 =?us-ascii?Q?42uqbFgvaqHBXv0t0jeABELmiad9NMUrziqAoTl6FGVvRHoFLXNpS+WLcbtG?=
 =?us-ascii?Q?rH98Ef4ybqXCjSuxVkbT9LWG1FD9gPVvbSbgcaPvuOF2tmZSKGgFp0TlmYh3?=
 =?us-ascii?Q?J+c8bCZuGpDhazzxEanUJ12HxJoyWxqqXAOrbwKzCGWD0qt0BMEFj4k3xeFE?=
 =?us-ascii?Q?gFntn7D9WXCg2lLGF62O2x0isFPPwaWgqX6zYGRDNtMYdoi9CreOiaC4drVE?=
 =?us-ascii?Q?9r3KM3U2m8/sWrVb1TKe2k98fFcOPkkdY0AfpyHu/e+Z7B+Wo14CUwMllQ0+?=
 =?us-ascii?Q?8Et7q9CxyXYOoll4g24SIpWQBjIEdMe5vnzVhyOIKPkeQNxI050AJXrgV/3E?=
 =?us-ascii?Q?r8BqVUQ944f1pqTMJ0HgOZ7kq691QfV79seWK0mmjuT7p+mv0+G7VZu48Jfp?=
 =?us-ascii?Q?CZUj7fW0vGbWQ2FQ8vr2rwd4+KGnsMiBXgEirMT1vrey7n9fyZHd61Ce27d7?=
 =?us-ascii?Q?PIFGQKXhmnaKgwF02NSJP4sx0h0HBJVyo1Hc5tBNiS21XgN346DaixvnkZxX?=
 =?us-ascii?Q?lHiahL6ZoVuGAPQihgIFYPQh9lzAhPTYpehUtY7HoJdAJkHftlm7w4yK9okN?=
 =?us-ascii?Q?8QYbJUOWOdKsSY01DZdXhshlPtnoMi8Zw/cRitn5SLgyKhz5phQVW922yivt?=
 =?us-ascii?Q?5HEhQH3h/oN1jvwhtSuaeZNMmm+ucDCq5gTkaOWXhqXZonDru8ZWKq7+PiCM?=
 =?us-ascii?Q?DiiHlBF/wWeOOFYg8FfOjMNVNXZDddqkv2v1IC4J3037vdd3+eI0nvDt0i2B?=
 =?us-ascii?Q?R1H+E5baoJkKvZrNrFfwvrjiHar03lW+sB9WEn/UACCD2QhOZS8l0JwuIXIO?=
 =?us-ascii?Q?kpU5TAhVkfprp/1/1Vc70NkJdlrdtJni/ty8VJi6yHPUT03INDv5sj1W/eRF?=
 =?us-ascii?Q?d+g9MCv9HNaiNEskC1VgN4BUXwSBD5tMYLWJrOHuwLlv/METFbITnhT0yrcQ?=
 =?us-ascii?Q?psKkURfO3nU7FeAZspxs4D30r+8sCU8QvsM16eMgSWaS26b8TKCDeVMNWdA4?=
 =?us-ascii?Q?5OTIKNYivTiokfLFK0U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea694171-f8e7-4a23-aa0e-08dc1911dff7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:54.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6BtqW11dPEzN+VoyFLGIKrnfTLP4ECBKlMtWeMuIJCs0J1d2YFD1cCllMNDpQDu3pz1Y6u1GCTmpLAN2P7bvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

The i.MX EP exhibits variations in epc_features among different EP
configurations. This introduces the addition of epc_features in
imx6_pcie_drvdata to accommodate these differences. It's important to note
that there are no functional changes in this commit; instead, it lays the
groundwork for supporting i.MX95 EP functions.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - Added  Manivannan Sadhasivam's review tag
    Change from v6 to v7
    - none
    Change from v5 to v6
    - add missed maxitems.
    - add comments about reuse linux,pci-domain as controller id.
    linux,pci-domain have not defined at PCI endpoint side.
    
    Change from v1 to v3
    - new patch at v3

 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 139ed618bfccc..bbaa45c08323b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -105,6 +105,7 @@ struct imx6_pcie_drvdata {
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx6_pcie *pcie);
 };
 
@@ -1052,7 +1053,10 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 static const struct pci_epc_features*
 imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
-	return &imx8m_pcie_epc_features;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+	return imx6_pcie->drvdata->epc_features;
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
@@ -1534,6 +1538,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
@@ -1545,6 +1550,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1555,6 +1561,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 };
 
-- 
2.34.1


