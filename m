Return-Path: <linux-pci+bounces-30155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D8FADFD69
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 07:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BCF16F6D6
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 05:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B0244699;
	Thu, 19 Jun 2025 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dVaq69bz"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619CB244682;
	Thu, 19 Jun 2025 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312663; cv=fail; b=qMTxWoMBuqlRvSA8sYJHdKosoUR+85MO7N7uZ4XppTGDdj6thDcAkZpBMS+IUuBZbVNtevX2MwbC+3pSnyrEK5HWNePuf1NvfH700Pic/l/awSg9PB1yi9l+koNm1fPv88j9G8JQqjQvmiuA5G/Z0RdbgIrKg6HH+tv1ININdSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312663; c=relaxed/simple;
	bh=dwMYXC52XdpA8Gk+zD2yXPJol+bjMyN2fcaQUqm2w4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mu0UcCTzQTmE8Gk1y9qrn1m69Q8DSMRAbcX3nuDSJ21XGSEx2dRZ77l6Oz+xI5AELfCj2IlCJCxA9WAercrxOVi8rAg2Ep1CE9LYSe4c9+R8BWi+WKpSBucNlrSZgXLXIeo8P50sy72YeA6YKJCexSdI96o/aDZeBRqPiDQEiIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dVaq69bz; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxBPv+0tfcdWflJhSLE1qe44VZF5BcBh8uXJaSarE/jGkhLSgC80vraHmM8qQoNRb/Glp2PQt0HSgjqMWLFFKDzn0l0cE2vnUWjjKJ2OpeOytpRyUgYpvmt3QDQk6fcxzviteqABap9S0ARK6Swnyg1liJNGKdh+BTHwzeU2Urqhrrww6XC778dWt4Aj/T5E75LwbMzhWnf/ZD9Cm3kZIS2Qw5CIPgYWNKoik7xtCIG5V/uui1nQBXcb7ZhyE3jn8u2UCETpHZtkyHZeYxrWblUdIpOfDN9bFnF0/KKz+1Sq66qUt4WsqqDj8IOehswK+JwG8NGQSA2FxL8FYVD7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZS0tvudNEmwyCBSU6jLQjNGU7MlIiMDOIiK7hPlw58=;
 b=HaeJ+ZzMHB5ejddqZC7aFe9gGSA1V8wWM+836HON3VppRCIKGgL9fixU2NQHMpIef4Yd5wSwZWO3My1eOQnytIes0otCERMGFhnOpUSeW11g35aOHvJWrGkS1ZhijlcR+8YZ2N3F3rjBCvb3FJQ//pvo5VB9+1jS2OIvYKXM4TyHFor3HIFC8wQqnzX+7ETGhzxI6+8TAz7/AmCkp3ib2v1qGI2XUyNglny6go2fIfDLhCuIvR8PbqbiJoFNN5iU7dNVUjhCkF3F1afRr4PMCIEoT2Y4uiYVSnisYZQMJb8w72EatPSBUB0jq1HIWLblwAYKNKvrr1jYPqrHMLtqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZS0tvudNEmwyCBSU6jLQjNGU7MlIiMDOIiK7hPlw58=;
 b=dVaq69bzYDl1cWcFsedNaMUOP63HdJrzupQMdMMssjIXD19BSNFeaBRVln0Hf8jhJyqrjtYPAseBv2e4WhB6QoF30VUa3vOIvP+ZsHIoj7vIc1JtrjYYUdT+s6zjcsGEhilxmNmMMpQtW3RLoBiSU9KWJ3sgSSWJ8+5IxKdy2ZNyL+W9Sz+n2+f5ilE8xTzdAfb5Qk/Jp2QX/0ger9mv2KeFQZQccujfUkxg4exP36Gpuj11SEuiXncjhnLYGTtTqQ2lrTNvqO05S+h5OK0uXNC/Lb4zPogbWeQeYaWCmzixhUDkrc3EjrYwTEbQdBHDEpnCJym6+qB8ygJ7Lv9kFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB10151.eurprd04.prod.outlook.com (2603:10a6:150:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 05:57:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 05:57:38 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RESEND PATCH v1 2/2] PCI: imx6: Add external reference clock mode support
Date: Thu, 19 Jun 2025 13:55:15 +0800
Message-Id: <20250619055515.74675-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250619055515.74675-1-hongxing.zhu@nxp.com>
References: <20250619055515.74675-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GVXPR04MB10151:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d1894f-0b76-4980-5c6c-08ddaef631e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CmfLNCv1WhX7PfwawGFYFgVSKs2uE2JM+97wS+9OeQ+c4bBs2Kq6ZC0cuWct?=
 =?us-ascii?Q?amFL+GBJQumLLGbKIdp/4CKbLT3RqdQHSrtjoq/i7pivbVYzFaOFYbnbotIv?=
 =?us-ascii?Q?NvbM9jPwP3b//AJmrgMThTOvuUYdkGTZrx3wcpwjaqjYmqtmCFuUEJJIkbWL?=
 =?us-ascii?Q?LhBEdY24hcUJpwobonvnKhqZ6040Bm+SPgEaStPcM/Vx7foVck2hnwBb6UdC?=
 =?us-ascii?Q?WsCGKRy3IV/Zne8oVWtf8sfUxq/P7gTmTnI07QUhyc42UUEsQi3LSZiHl6cQ?=
 =?us-ascii?Q?nDc/PBnisxv1KKgFWOkdSkH2o3MOoGbpU95k/fEC9FU0cAHHNYUMQlDxVEcB?=
 =?us-ascii?Q?FwhKcA8IScFo6YlRfmnPdoHeJvlWMfmt8wQpZo9P3w+I2Hn0GQNY10FEOMnC?=
 =?us-ascii?Q?G8qo3F5f8CUJDSk3Uitfd6SVf5wha2txgT3GCYZPPsWw09da50wEfpsKHjFP?=
 =?us-ascii?Q?WNlil2V2tgbkrLrJFldMDPaBEqiLapos1F9Yts3htuUGDH+c7LTIjGWR3ItC?=
 =?us-ascii?Q?w60fORdZOqCJnPlt3rRVUl7jUG4FBD+8U2rl8RD5RX27HWgd+t6Q4xz6tjv/?=
 =?us-ascii?Q?6HCsPfeXbiseMNli41hE78dBGnVj29fxbyh4Ws9zgZBXqv8olVwUSlSNCw3C?=
 =?us-ascii?Q?paW+KdkQ0fMms9XIMkUWyb36viEwYof3lWCeABw3zre/t30PBsngv00A7tep?=
 =?us-ascii?Q?uuyVw2eiadX/60Vh3pYo7EzrLRajzO6mXyICighl5kWNjvB3XzdaH8BfhDUY?=
 =?us-ascii?Q?loEmv2w0gUH/PuWTlflPlrneOC2gZN463nUuoR+dwWi/z/FDg8Kp7XGh0KN9?=
 =?us-ascii?Q?QDIzaeXe0WPiM7YYBG30IqggL9f6NspAtq4GDa0W3/r5kpo85IDfwpp+eY4s?=
 =?us-ascii?Q?/YaJqPuyuGw/XmAWmb+dfBN4aY+C0gCr943HRwjJoA1d4OPpM1qs44hbxjKE?=
 =?us-ascii?Q?0+Iv5h0uX3DKiEDT2LIYM8JkPAIf512ZyDMNxd7IRnIrhtfetx4EAebGYb1n?=
 =?us-ascii?Q?uZozQHaVEoNDiBJbv5jFumfc6DsaDqHV+kYtpExshNhq+dgheNnIoEjW0Sn6?=
 =?us-ascii?Q?Ps153GZXCEd3a0mQTfO9UB4+W8EDRRJgNi3ffr3qlSs92rNMHVuF/XEqf9iU?=
 =?us-ascii?Q?Ln0tGy+RkVpKKQeDVVQBHpplAsBTQq4FRRWiO0SAgVCurzuY+qIe7V6fTcFQ?=
 =?us-ascii?Q?+u5gklVnOBZ4v5GYmKOM5wSRFaqNeT2Jad7bUebslhE42r5y4HL7Yp3o+VWd?=
 =?us-ascii?Q?vWf6WXVwNmUK621KmPTbDPc6Zo8/mTU0NtacXx7Fo+BQWkD/M4dD8IrMJKbv?=
 =?us-ascii?Q?QjKyotGF5iUaukI4znq9GHDq7LrDnXtf6x+8DbtR2UX7GhPYpwcQRdW9+zAy?=
 =?us-ascii?Q?24hFJWGoWiHkFDsH39HOz8CO5cMW70t7avYL3JZ0DZSt9kX2+tlE1sjyl1CD?=
 =?us-ascii?Q?PmlkhWZ/Zy1PdW/z+zJnntyoHBhI+OjoC5tF3g2sfBA3ayUsb2tBDFRHcu1f?=
 =?us-ascii?Q?2GHkSm6YXClxgoU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+A5JI1CPLZjB8xUcjrggUFCV8aUK8DbIHeinJZ+FyFsSlJJfCeO8GExPucD4?=
 =?us-ascii?Q?t3IZPUnF0LMzFsUPPNFOnkU8yC8AVJVmLkIdoxf2CW1Z8AhkwjwEv/UzpTiH?=
 =?us-ascii?Q?Tz1Aioo5H4OoubZVNfeN/MzpGoxTEJMtaHUOYLq011DGDBRXDLnoitzuKpRy?=
 =?us-ascii?Q?0RvCULdvHa139nViz8QXiLA9AUkXFe0KODILEx5uDz62M6FGrHs/XbYwSbec?=
 =?us-ascii?Q?JtDkrDAPW4UkzdBpRimRY3Ul8uYvtLdV6xLLfijKhH9xESb5uyB0vSwM6qi1?=
 =?us-ascii?Q?CMQRVEUrwsaJ0T9oEynHgYy1vh6OSMXtpIN1/ztrzRojw/AMHagzWEZ1IAWF?=
 =?us-ascii?Q?eEBTtmWRIvlBWoMiXqjZjfFLpSx8axyrjZFCjCrF1TsWqNQAMLaK3Hz6yLef?=
 =?us-ascii?Q?a2AH88jghOo39vJGc4DIPl/807NKQ8EKJc3WQPszc0BxG87Ain20PdA2pWY/?=
 =?us-ascii?Q?Lts3B15sxxPt2MPage0aoumAbkH6G321LYtLahMw0/ZDLSoFCwQEkbNYktbF?=
 =?us-ascii?Q?vOJxXSjA0c9dCk0jh4fG+5WLM223uCUFFeQLffQrjuFXggI86tN+WG8kiHv5?=
 =?us-ascii?Q?3emULIBFqCYsgvauTqEn8CN6Ov1BDx4X/4H17I5rErg5DoAg8Sfl1J90OND3?=
 =?us-ascii?Q?SGSNay1+IGt1iSm+jrKVcn78w57UkKcRVHFvCl4xC3cPE6R8CLbjBzsH1cDY?=
 =?us-ascii?Q?o5b9zZoLAsj9VEKDiyD2voZ5VsAywYjH6r+VtjUE9Ub38B3hPjGc5fQhcBFL?=
 =?us-ascii?Q?YTYUjaFBo6+xDEAD1aGRto0Gl0/CKagkF3oYjGX1/bTHJWRa+32/WfNIsy0Z?=
 =?us-ascii?Q?sfO+ljorrD0rtAAXJQIXNqxFyZckY1RZHpsLmf5Dx4qgTe0xxjtcRECxXn63?=
 =?us-ascii?Q?w+qmwqtZp6KIC9jfFr8xCoAHx4Ktk0Nv5Qt+MW3+tbfLkMnHaILgA160xmNw?=
 =?us-ascii?Q?j/FG8f08Y1sK2euHQBQgLBfKBgqciYtaVaMsMflKO4vNkmkpPDbbHTUMk2Su?=
 =?us-ascii?Q?dpUJ3FOYWpwRO0dmDwswqDq3VNrl0MqXzFM56fM4S1nie2B0s+uC5c6IeOLA?=
 =?us-ascii?Q?Ui/zrwNXxFbFbDJDJyRGzoDDJMa17tU0maLctunzqFrRUh+CfK88qfPMotgW?=
 =?us-ascii?Q?zwXU4nhBVOCW8dfCFEaOnbUuZBdT/LnI4hn6yzyPdc795IGN/TCrB4de6JuA?=
 =?us-ascii?Q?u+v9wy1T+8WbffeXBdCfHM1ro0P/aWFxngJ8EdrGeGB14cONIm93xq9/ns/U?=
 =?us-ascii?Q?ALcgnUqi5gAKz1xK13JYGtui/QBP/h7GQdQuTgtMi4ppqu9UKjOCFMkZKjeo?=
 =?us-ascii?Q?yoGD4t8t9iie5/ucpc6cS6UqDcTaVEPd9ODpuZ/mnZQ9KBN0DyieBxZpQDhB?=
 =?us-ascii?Q?fHnD2DfkZqAoWEX53NaBmZk27IGuqQ3P7j8Lu5YWgzU+BgXxI6MLZCLIXEZf?=
 =?us-ascii?Q?Itp4lukq6nG5W1berCGVfvFRvDKBMprq0Qk75C5+1pa7zPlRTjiQjAUz9n7U?=
 =?us-ascii?Q?JMBIS/iqZhZr3VxizUtVhM4Vvsi6dCvgfm6YEs7CvftqbCBLPjxDNaFRzIRb?=
 =?us-ascii?Q?5du/mea3dJJyzbAvvLpWjW8RJPU09QSNIkhDDI6P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d1894f-0b76-4980-5c6c-08ddaef631e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:57:38.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9Jl4g1cb25OOpIlcyk/49cavvBMDH/HNR9to8Rr9ZGBitud9YYwHf0ccQHxUJR2T+lyvLieugYRtS+i5Pk5pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10151

The PCI Express reference clock of i.MX9 PCIes might come from external
clock source. Add the external reference clock mode support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 34 ++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b..04c720377546 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -149,6 +149,7 @@ struct imx_pcie {
 	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
+	bool			enable_ext_refclk;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -259,13 +260,24 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD, 0);
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_SS_RW_REG_0,
-			   IMX95_PCIE_REF_CLKEN,
-			   IMX95_PCIE_REF_CLKEN);
+	if (imx_pcie->enable_ext_refclk) {
+		/* External clock is used as reference clock */
+		regmap_update_bits(imx_pcie->iomuxc_gpr,
+				   IMX95_PCIE_PHY_GEN_CTRL,
+				   IMX95_PCIE_REF_USE_PAD,
+				   IMX95_PCIE_REF_USE_PAD);
+		regmap_update_bits(imx_pcie->iomuxc_gpr,
+				   IMX95_PCIE_SS_RW_REG_0,
+				   IMX95_PCIE_REF_CLKEN, 0);
+	} else {
+		regmap_update_bits(imx_pcie->iomuxc_gpr,
+				   IMX95_PCIE_PHY_GEN_CTRL,
+				   IMX95_PCIE_REF_USE_PAD, 0);
+		regmap_update_bits(imx_pcie->iomuxc_gpr,
+				   IMX95_PCIE_SS_RW_REG_0,
+				   IMX95_PCIE_REF_CLKEN,
+				   IMX95_PCIE_REF_CLKEN);
+	}
 
 	return 0;
 }
@@ -1600,7 +1612,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct imx_pcie *imx_pcie;
 	struct device_node *np;
 	struct device_node *node = dev->of_node;
-	int ret, domain;
+	int i, ret, domain;
 	u16 val;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
@@ -1651,6 +1663,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (imx_pcie->num_clks < 0)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
+	for (i = 0; i < imx_pcie->num_clks; i++) {
+		if (strncmp(imx_pcie->clks[i].id, "ref", 3) == 0)
+			imx_pcie->enable_ext_refclk = false;
+		else
+			imx_pcie->enable_ext_refclk = true;
+	}
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
 		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
-- 
2.37.1


