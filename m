Return-Path: <linux-pci+bounces-17321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227199D92E6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 08:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CBE2858BC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746541B0F22;
	Tue, 26 Nov 2024 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JsgvSODt"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CAB1A0BEE;
	Tue, 26 Nov 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607889; cv=fail; b=dHMFKraZjHjbMbf//4dEAvc0SaM9CUwXvTvpAl/QIP+dMikY+J9NKsy22LhJez6gN8/vA9NACdLdLY1qXwLl4yrqIHl5gy1WRzen6HRonaG0YtHGs6pSZE6YcuHeHQt0YKK/nFYoGI3hrUOHHv+WgJxLYVZ+PMtH9PvezdmZRlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607889; c=relaxed/simple;
	bh=l8tipxD7st+Zs0loZ7tdbLnKwoAyA6ufTH6p6kLta1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMOmtpdlub9z3gHvzmxYheckFS1wus916oldVd8PfFUY1YDJ6VC3MIraW2NgWCLCD2TPoFyK7HraYFx/ZzbZHQbEQAc2fVKdNVdshzPztS9ABDwVpdpOFn1tkF+8LL6rb9IeYO07G3ZEyQoYDh0ow3cHud1HK3ttZpgnJVsgU9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JsgvSODt; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBh1mMwcBqxUKGkXHBLqN670O0KPK9+EUSjpO5xNlVaug1HFoJL3vWVuYE8WiO6fkYUicWcAhwf9ZIVHaQODvC0WGIghguozXIjRxOnGM9HBk17XtqPrVMEBvMGlm3ioegjFto1modXVwiwvJJorA+5qIBP1W+0RFFMra8l3PMEZ0+g9ISsGkBAzkeZKd3DbJqp/EHnPTXMPtFYHkBhhLZHpXDlZAYcQhqGx3Scvi/Ej2j3+Ps12PC8HPVJiOhO53K0SKtCi4zGq46O5496lD+HCOx42p3G/y6UorIltGa22G94FU4OHsQ5lf3TfDuRPkuB9CYCc3TDFWvnTkEggNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XGWJCWBN0jVvyzb9wrLpOIdgdDkrMn1+Do6+UNoBvU=;
 b=dimtL0Bi8i5Yoy4i6ayft9Fv7x+w4uWfC1d0JjSj+CEWZIXpMNhjDgJ1usoZ6jU4qTFfDj+eRn92eDg+ZMJ9uF+b94dtXEss6Sn/BrRDnrEW0/nkx0qynsL19BjNhfk8oh5yZyXqqh5m2y8oFCGl06+LeqMcO15uD/FuJQKmxfKQw0G+8lQM8GMBt8sJLneKsE+wNdNVDsYmXIxoyY3wDGVCOIAxaKTWbFU3FmBt/iX9qUmWyayVLTR/T5UGQSyhZkwnDEaUbcXHQnR5ZyJSLc+OTkZS61aXw+R9f1B9Ox/QwZHBZumvaXncQ6YQfZKEC6q7snE18lxbbl3pixG2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XGWJCWBN0jVvyzb9wrLpOIdgdDkrMn1+Do6+UNoBvU=;
 b=JsgvSODtgKi9fZtxZSVxVEzmLlr4hR48rndqSH7F/1pVLxMXtKiHTUf1lCUBR935xBGckNd5tB8a+Y8A5Hmr3z9XRk8EbnekgGEFTKiq0Ai9h2NVyovlPvk1NgaG0lar2JwB6OoSapQax4lbivmD/Uw1eFW7GrvkMSOcXhE3mHkab/K2QrtsTarDLZDq000UB2gibYCmQczrVD07L0A5bOPQoeIPMx4DtBm9ilcBHbmq3BUSZDm9dVdRchcTrgCbKd9JF8E1Ao5w6W64S5Pqa+G3zu2rXrrDwpeqjsgw65iLUVYnHXoSUoK+gJzexdidytH29SMZcrvOVAq4R/4kHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 07:58:04 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:58:03 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 04/10] PCI: imx6: Correct controller_id generation logic for i.MX7D
Date: Tue, 26 Nov 2024 15:56:56 +0800
Message-Id: <20241126075702.4099164-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc5ddcc-e95e-409d-9a75-08dd0df00dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kua0A8k0kUhuoZH5eEan7w8F/m+6WSIjnHWWZRIzE0kgMFude8AWGv5NFKSq?=
 =?us-ascii?Q?fcmenlYS5heqVGbaJEiQTRvUkk4p8fOhOIVhgEZAT7qZ1Gj/QJ9QoKTA1BeY?=
 =?us-ascii?Q?hBjeWK0kT+zB6M1W233miZRKj6YT3d/ys+1fQCTevyE40HDZdMy5PriYzIDs?=
 =?us-ascii?Q?T+Kc3SeOoxlx3TFvVFLUFO/v0quSG72BxAtnA4iLLrj89mKCTkjBW0mUSQuD?=
 =?us-ascii?Q?IvlK8VM9RSx01A5MhiMXo7oeZtadzbPvvLMOd2Enp9M83P3OmYqpImXDfwPc?=
 =?us-ascii?Q?QP2Yq4i7nNyPYuptli+swZyNKgO8/yHHknpgVEJYlb7uDMj43u9QfI/10X7V?=
 =?us-ascii?Q?HCvB2Cl61VKRXRm21qYRlFE2j2oNfP1TUgGbNPOqRaR42NzfReHjSu2TLKhn?=
 =?us-ascii?Q?TiKA3cyyw+ANqgyRRFED3wKDF162UEDZBgOB2OEZdjFeXyFyd0z7w7VGeTIa?=
 =?us-ascii?Q?Xyir4lsEr8BNKU2RG6AhXI+t9eFtOSWsB9eB3TXVTz2XEIqHVU8+bJzLbOjh?=
 =?us-ascii?Q?tzbednFDVkPnc152EgHb8xga36PbCzgt9vxgmjmZtpKE81e3+nSjKElozyZH?=
 =?us-ascii?Q?8E+3eeSON/kpjU138bDBJ6929xRhRlpXXfydvkyKmna0UmBir4Hfxl2SV0aA?=
 =?us-ascii?Q?thxFccQsoyrecFvz4GeCdsJk+C325zMPjIzmFRQ7HOpVFLtJPubghI41lufV?=
 =?us-ascii?Q?VUv98fOv7I1fwKWvp3vFy+zSt2FT/FeNEhslemvaoipMmwuoZemV89GNK44U?=
 =?us-ascii?Q?aAMehPrWkhdyzr1RRMPSSvxFss55fdJ5x0tBmxZRDjLFxU7avRyU3wVi9qQ5?=
 =?us-ascii?Q?UWgdqjhkK1HpVkmDNnT4ShV4VSQnL1H5z4tteHpy87TWt97ALEYp/Qsd3NPA?=
 =?us-ascii?Q?LVk2mkYgha50e3Tp9FebGI8q2ssALhxN+55lAkTCZ1gNB+Yjwglq7cU8lu4w?=
 =?us-ascii?Q?X3T0tel42StrwCELVj9ZXS7l9p9wVGG572t2iMONOMouRe+DwO49wQuaOey0?=
 =?us-ascii?Q?L9MFRY1wV2v0nMrz8CiwI5+i9lawyvPlwPDkG5I2NFJqiGMFx5S8bp48nlZn?=
 =?us-ascii?Q?bVf5c8Oe22RO4si70Tq3nH6b5lNAx6B5hE+TecR62Xk+a+BcwZ4aI5gSF3kM?=
 =?us-ascii?Q?Psq6UzAlhRJ5ISejxdFUC+NKMzEDcb6mibMyYkzP7+GXaXzC7/fEH8/XysZ5?=
 =?us-ascii?Q?zamahqk8oO5m/uyCHTyu35kdTpDc9Y6l9shKTE6W8cCCzQgO/cFHBHdoyMoy?=
 =?us-ascii?Q?1odxRjb6grDFIYj71dnbY72jPzid5H2NpmyHGuM9fl3a8e1XuEoDS07NTd2/?=
 =?us-ascii?Q?KyYf1cd9YTFUwYMgIM9hKzAyEIPTNBuCkS1+8otJdJNAWdKMBEdVaklVDQyu?=
 =?us-ascii?Q?lo84IqMZU7ZvmKbth1re4oVgBLxaKoezMhO+OQw+0Arr4YvRANObHbhMyt4N?=
 =?us-ascii?Q?MiJczlaCOGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vwhzQgn9O44x3TrSKzgR/qMWa+chiM3U7ez4UzSe43+MLrbSOqsMbVX3iKxp?=
 =?us-ascii?Q?mAjYvPsFQ/84WLbV/FYh7G6HAfUr2iCu7A18nwyFCLq4FiIklMI43ZcqbABU?=
 =?us-ascii?Q?Ax7eq0QPVYUJuDkjTK1o/YBN5zjRT0nplVkZ+KY43Y4EnYFUsRWqz/TM2YYg?=
 =?us-ascii?Q?f7fXojZpMtLVkESOviEeAXAbt5QL0Hdv83PY6Nrkh3CMtL7jratTQ+S4CRr3?=
 =?us-ascii?Q?7cEOghc+cdFCEtJWn2qBkbJQyq/0vi3+bjkRmohYxyTrhtroHio5iqrouV9R?=
 =?us-ascii?Q?kJ68HQbK3/XTwqeNc1ehtyLwR36jjSYXhststJaYLLf7W7L4wOaxFzVu4D6E?=
 =?us-ascii?Q?enrPO2t5jYXuUC0yLgyVQnRy0qhh5SiZ6yEyBHHFoQ+mNnbHiDKkHC6I7zvJ?=
 =?us-ascii?Q?MlIlQQQZ1lIyHDnIqFABUf5e4/U9Q3ytcRL1GJyR4nFBmLz6nhJLVfRlcNgo?=
 =?us-ascii?Q?TUbZOVX1OLPn8wd30gLA+Jz/sq1RtA8a1PBE/TzoJn1udHeJc4nqZj4am4Uk?=
 =?us-ascii?Q?pnn7p0myk81L6kJGBV/0d3A/QhRA2Dxr7WISSUW/t84oZdHKHuzuaBMg3Cmd?=
 =?us-ascii?Q?HNK5XE23vW4v+WrY7H2+jcSsDgRoUo4aJdpTmDZCB/KvN0TOH7B3JQ2vBPUG?=
 =?us-ascii?Q?6+VWB/rlfnRanpIUo7XUGkyXEpakDKJFgHTys/Yeemvgu4fp7Z126FnmFxdm?=
 =?us-ascii?Q?r+hcCMOxQX2GR7i2IDQO/vQlrvTGMiiVEmR56IuryevcFzgqil/vGty8GmSK?=
 =?us-ascii?Q?rLEqaymk1O9zrqujwE9zj0noyBeXmaQcqHU9d8hQ97TYW+/TCWTyFqR+rvnk?=
 =?us-ascii?Q?IQiL0aFT93hu3XTt5ohm8F4UhTccX12L0u8eW2vqNPtMFaH16kPVPcpIt+wF?=
 =?us-ascii?Q?efi8FWhxRoz6hyYnPedpcRq0tbOCMENm0f+KAWocXqJKNyaJPr8nZnqD026U?=
 =?us-ascii?Q?InTgRLm9qL6tO1M8Rz5PnBUG8Q6VmaasJ1LPc4+64fwI6Q/f8e7rZvJeUcLE?=
 =?us-ascii?Q?BPI1KQxzSB/DVLu3+4qPW/vP8cEdz4AAXlbu4jbTeXoo9LVt4L5vegPE60eD?=
 =?us-ascii?Q?Q3SaLqSFzrZs+gA/3uV1dVXEnXDQVo5yp7EVuJmOUeFVJTp7fHOhdTFMwnoM?=
 =?us-ascii?Q?WqbyH1pz+TDjfTn85rFAJzqfsLqhJDCO825kgUPf0smcAjbzoH3plhV/b3Z4?=
 =?us-ascii?Q?ufRjyKFUCyt7JgF8Dwy/+5irWKz5CQqNDW9j6CEzS0SCeRH+YIpcULNXCjWp?=
 =?us-ascii?Q?NknX+wILeMkKdl5abaxBM2SWE4F364Q1rcg3+e90LZl9+Dq5eufxRW0QTGZF?=
 =?us-ascii?Q?jLZikUrNZNQUy8iQfasHDYPd/Whx3BGKTp58XS886nhFyxrVp78K/tZEYHDu?=
 =?us-ascii?Q?n09kOa3c9PVR/YOErh22n46rbMTfcNHUqAiP2Nxfal7t6N53Qi8LWZjU9McE?=
 =?us-ascii?Q?yekA6WHS9gA9HJXHfpIbMZCmklVVAXwYPX9jXsA6t9KZ7gaJpYm7X9V1oOvu?=
 =?us-ascii?Q?0/UffyFJfDd0k2BG+3gNhUJE3lsp5L4kW0RW4bpyqN/W7cLDUNnH51rC79tO?=
 =?us-ascii?Q?DQNmYWM4NGUNifi/yhLFFZzufQ5h0N8V5Nyu7eXu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc5ddcc-e95e-409d-9a75-08dd0df00dc9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:58:03.5035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1q7rC6o37J6RpUM8uCIgkymZzZDc4xn2ENNRh73Aoke2xhPIMx+SNeHEFAzB8HRBvnLq9wUWV/QjLDcAQzzfYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

i.MX7D only has one PCIe controller, so controller_id should always be 0.
The previous code is incorrect although yielding the correct result. Fix by
removing IMX7D from the switch case branch.

Fixes: 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 81f1f68ccc14..3538440601a7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1367,7 +1367,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
-	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx_pcie->controller_id = 1;
 		break;
-- 
2.37.1


