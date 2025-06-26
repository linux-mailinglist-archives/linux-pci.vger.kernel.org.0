Return-Path: <linux-pci+bounces-30693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C9CAE96FA
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 09:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96A3189B1F6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 07:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCB4255F49;
	Thu, 26 Jun 2025 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U3SVVEsN"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F82517A5;
	Thu, 26 Jun 2025 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923638; cv=fail; b=bycQV/Vgfe+sWLBl9iUyvXQsjJhJbilF7qSnLK8PudTYcXxTyA45IsbSOZ++zmQxRB0rKX8eluvkYGAjS3FwjQLqF00AEL/20BwJiGBL/aHh2zKMmPioV24PSW3UgVxFkj69pKHdS6AiQOaxF0SA3LlrHRrytmadtt0d7g/Ezy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923638; c=relaxed/simple;
	bh=5zxyQk8sBsHit1j+VFOjhWGiRO0vGHPG8DFw9Q61nQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nanm8GzzZKbDWyFyuOrBw0DawxbtPMEFYJAaJqgUtt4aV8+Qph9CCqCmt4xMCpfy5u9kHXz1FKTx8ypwERFBuokjx2BXZ9vQQMOMieR1IO+AHCdQi6X8iBFmwCa2Xf3erWSG+2Xq1OSRGSwMXiTZLzYxtBYlg/FuzHgmadseH4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U3SVVEsN; arc=fail smtp.client-ip=40.107.159.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVyOnjckZB6EJArSNn61rhkZY0HL9P9JJFm1KewBBOpy/Tzak3KDJO0mia6TEwutucwhkhV2qRgNVHIw/XNuSpC9yHbHHQf8qnZv97qNfe+gTvIB79oDrxHpD5HDQEf7yj0JFpROMinWqQ5nSE5FUPNd37lAyILYwym3hBeL8LKU4vmCgEVdGWPoPafmJq9z3CqbbocruVkwf560BOWUxq0JYs291J9m8e0CoUMkqwiLmHZU0XGU6oYRR7HMgptccCoG/ByrPmM1FnwD9jYShiAA5AWUYorJY2mlf2d/ubgjyaebc5382x+yGSetchwyVaPKKAUpHVL91Ft2zVg5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taXVF/P+T6UOGAxWwW2qLlDfpmZ0Syy5dXbz0TslR+4=;
 b=kVUDUGo9naKfWv3o8NtlaTOL4vwvR9jcrqBaNlJodG8enxURwwqHeh48nMHoZFKxb1rHUdbJGCq8ob+EQrE7l21+iZxAM/5rsS98rd60zcgxjU7l4PT9BL6rc5LZAwXZjAto5zE9Gc/+MfgrNFasy6+r/v8hFVrTLWBHTBCbMD6Sj+iCua+PIjbDZ2yXr3DsFMLXyToDXnTbo7Qa6m+6CyXfO9/FqQ0AIXLQDhlY/E6Iskxws83gzXRrEQX9EVP3PEzm6uf8qqqxwWAFwPW30og/V5Og63G81WgeI/OP90E6iaDzAPk3ZKXTSInvaKuKugbYI/tpbBAQ79ruihzkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taXVF/P+T6UOGAxWwW2qLlDfpmZ0Syy5dXbz0TslR+4=;
 b=U3SVVEsNnG5A+vGS324XGAycVbYxCqBQykXTnKBKYtw4EPKwIyQIPLFsPpvNDD+eleMfI2trcYJqlJI+uRJSQzklTyL/5Lg3AzBKGgHCg7ACDwnLUMLnJHZCSmmwgfr1CM0bR3WdNxyYasbQ7/fN97D9SU87meR4ALD56FQz9chInKwN6oBIL02O2JZuIXQF77tG6zg3q9XDTwRgBkf3jTBt6/lntaBXRF8La6Kiv9/k7xpvibwahKcAO1vaR8LQZtHu3l0CAgeeG4S9mt6HxwMOKS/SEdgCq45dIE2ffiE210Sg6lxkNnxOOfa7GemGlN3Yx7N5xJybjZYTRvpZ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Thu, 26 Jun
 2025 07:40:31 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 07:40:31 +0000
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
Subject: [PATCH v4 3/3] PCI: imx6: Add external reference clock mode support
Date: Thu, 26 Jun 2025 15:38:04 +0800
Message-Id: <20250626073804.3113757-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: b3801925-99c7-4d17-3d5e-08ddb484ba98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bjGqVyve2jF8PGZZb3HrvgGpoCjZjcBBbYhocFq7g7b74wtHd8Q5F5JxYO0G?=
 =?us-ascii?Q?dwAHmH9QRZNbtVdFs6yVmtIZ4GvtFHR73WhXWW4xfmBZJIClpSO3fyCKcDSc?=
 =?us-ascii?Q?Ngoh5kQADx9FaCQS6DFVV81X4m3Wq0GnEaf0RiT3HmB5dy10k5x57gl3D485?=
 =?us-ascii?Q?7VPzGSWvXHVNQYpHGbf649SnKM9D3XeGKydY3eG5uUpI71rlkGcO+zMqLGRT?=
 =?us-ascii?Q?LseuNbg6L+Nq4stGpiC6xESu2vIK56WbbHS5D/UqTZeARMSw0w+H0SBb6hOG?=
 =?us-ascii?Q?D9HqeOfsMvhNa4UhoDaOJb6oOgx92qBlvrXocydBeao7cHaPcywrxYJJNgw3?=
 =?us-ascii?Q?EjHw3EgyStSEX5DnF66MlkaygGb1dh95kOC+e/LooMlHmJ7dRsU8xyYO9StD?=
 =?us-ascii?Q?g2nqlly1DELgUNQM0CStXJGdmPmYiU2l8VTimDq2ZrGcKjwF6sUD6Y6lDvpp?=
 =?us-ascii?Q?a6WFahcp78+QLLi9hXkwUavxo88xSLolVf56HVSTbXHLJQdb7BcHGDjRJZbV?=
 =?us-ascii?Q?hyE5NcSWEKRWfD60wPC6Wh17pB8mqmiBmjjSjWYXm/ZMj153SKEUs/fRodAe?=
 =?us-ascii?Q?QneZnW/3TRXj6jPyBtfOH1KDgL1NK2Ohjp7cH8rClonP+rAR5uGQiUWADOej?=
 =?us-ascii?Q?4yDQxwlf+84sdTGYsanWNxRwg0nDkI0vOImlKOc7glK5k5WQM7duE/CVYHcp?=
 =?us-ascii?Q?R/el7YCZWBKzKKVw8aH+7TqULmW6oPWWDZj7iuMAleV18aYZyVbzrkHoYmrL?=
 =?us-ascii?Q?2JpzKGdk51z7EHwCceXqhIzuxq7az5iQoHdihHGIiu5Cr3I6g4cjO7DdBmuj?=
 =?us-ascii?Q?OwNH3fG6ftAfDiHL8TWa6TctbnJeQjiOm8xPWc+9ijbFXwpqfnF0GUDprr2P?=
 =?us-ascii?Q?KWexDoJ6UJ+hbCjrYt1g94x61K3llW7WpuYbwq/+YEdEiaJJuqIuSAgwA28r?=
 =?us-ascii?Q?0imVUrSHC79IOM1atOw+fneQVdE1DGpGhY3NgQqs52dGWWpwa3MDPmSnExEi?=
 =?us-ascii?Q?aFtcSludXJdaMplWtaEYaIs2pOKfY3/X+zViGxrwAdeXoGRHlNlR4VZlTGd1?=
 =?us-ascii?Q?IqzGWGDGmEePLYQ+KWO3dyKPnfuAa2kXY0ybiIrBPDybADDzUrVO2dxMKOwL?=
 =?us-ascii?Q?fyMJJ4sLQELvlWueiq9MMzChnQgEivX8qkgBmCa88F8tLRUw6fXLoYQV38hF?=
 =?us-ascii?Q?pGkLMveMEzvm/gtEm+d3WqAGiloOW8jz2ziyEIBTp9dzIzgIGPAEhyfeYW8N?=
 =?us-ascii?Q?DwTgGFuY4nfXwfr6dhec6460Pn7FVm6206oMSB4XDltS8Z4hL4aGRUrxiDM2?=
 =?us-ascii?Q?bwyGzU89MRlvv5uoPA0IXXiAoueIUO0KEV05IstANGR2o+Qj2B04gqYfvWU7?=
 =?us-ascii?Q?aTR+Kb0+1EP9H3MsaY9DF2Q//ComW7H3aqs3i0mP0vf4NYFmh2LnBq0vEUtN?=
 =?us-ascii?Q?SIpFnT/n940ghvNzpxV5raIAYtzbpK/OsJ9nO0QpPIT2+tvOinPwj4zEIwii?=
 =?us-ascii?Q?5MumccEszb+I1QI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oLrgjOczwRQN1AJwgll0N0fChODii0muJFCd8TeqDoLIYsErpSXxCRIRCRnr?=
 =?us-ascii?Q?fAgEg+cw0xiZO40F0SIf1GVcLMpkuaI/AN79/QPFKOk8L0aI6KQqU96jrl3I?=
 =?us-ascii?Q?SjjN0P4YmbVnPllqn9XNY0zzn/IowwydZ3P0p0vPIklPwHnsAG4xHDlizaR/?=
 =?us-ascii?Q?BytX8kLUbYvC7h/o1M8BPoytGZcy3kNdpS96ZEbeFuRdxol9fEKErMMcnwWd?=
 =?us-ascii?Q?Ma3SLSL0PAXlXk1wOOSS6RgQpZuoKWy9edsGs4Nog8KZU1CrFxLw4c+Z00NC?=
 =?us-ascii?Q?88tGS0haRbwZxSxrJrK+1lwBkjXWq+9OP8DD9v8nlpMCDOIzZA4MCxnLzTtT?=
 =?us-ascii?Q?DmzsDOeVGkKmBlE7FtHQQdjwsHuCwhBnD1b8M1l1hwvchXh2IJXL6bfM4fSY?=
 =?us-ascii?Q?xP7LfWQOwd7XbAYJKSA+v3ClsjlRyxm6IRet8C9qYpk6cZ5jFIyPyJFUnpev?=
 =?us-ascii?Q?MvLDKjhnICUvSOSS/YO9qaS3nzHIbKLbDVq7RRo5Al7mg+ZvvW82gCi8wOnq?=
 =?us-ascii?Q?ZG5ZOeaXT24OKzHggOODorqlc3Dgs3NQrBezEZ1t5zgUY8RuCDBz1qpRHaEh?=
 =?us-ascii?Q?Az69pKjYC02Ay0uX3GDym+Li7cNfoEQdbVSSmH21ZjlgVWnYWay105JKwoof?=
 =?us-ascii?Q?FavMBbAg/cwOSOrrzo+6XIGa7d09GsCiLBcxa3E25Cb659vEqgBwuFU1xBkc?=
 =?us-ascii?Q?lpIW7o/4HabGr7xkBXgTR0vjbCPcmeCCkpjbZQvNJImYa5JGBcID/zbgoJCQ?=
 =?us-ascii?Q?868/1x5gIBRMNSbLzkOGCRAXdjlkgJ7SvZzWdJhGjdun1cSnuHbbpEOkHK5r?=
 =?us-ascii?Q?K1deVe+8WR9SEf4wNNTZYmWLyo13peJqYa5NvOtfAGx3phUeHBL1VMTFPGhX?=
 =?us-ascii?Q?aJoceLUwJekjzzCRo0CMnRLVaklsOLLO2wFoViS4+AkndcWMS9HDaX28VG/U?=
 =?us-ascii?Q?VP9bCA+JvFY5I7jScQs8A3nURV+REshWBUD0ykdTkkyk5rlVDV/UQ0q15/nH?=
 =?us-ascii?Q?u7CEvNKejbkD1CwpeltVHvvhxtFytQmxU6KR8GMQqrAbGk/6A+DA7uSf37Z0?=
 =?us-ascii?Q?DGqAxELwJeiPbZabmr3Pf8WMYZIYaAwfEDih8daP8E1QTUqHQVoAgcBXLyaO?=
 =?us-ascii?Q?3PZo3g04snmcYRs5SA3odNoLOG1iH4+rzDUXL30pAC9qGq9jxkEnZLTNGy1Z?=
 =?us-ascii?Q?3ItIT2eodmKchu8JSUm57yjx7jEN+5PdVETdmWvFdPSVaZEgF2IfUQ/xDbK+?=
 =?us-ascii?Q?/NsY4noR80UzJ6bI/j6jLw97lDUfbr8ZzI1nj7qYHSt4J4Usg20rbLD8rIZc?=
 =?us-ascii?Q?3NBaZtmjDqL9oJeBkMdFx5XnooFhAWtmKgaj7kjAInngR2tbkqsZS1HerhOC?=
 =?us-ascii?Q?H9EHhREpqcSx2NzdhhnNEdnFbFzuhBjAopseB4AXMJ5fOSUH+FuwP8OzloJz?=
 =?us-ascii?Q?RnPKJWFpxGbT47LbG4uF6xOz2Rok8umnjUhRxAAI4ENii8hMUkKfBYwtHrgz?=
 =?us-ascii?Q?l79TOH2Zcao3nRdghOZUQjJvkt6oocREiSCl/RjvjUSdBFnavA+tb2i/Kcpi?=
 =?us-ascii?Q?eFzAKZO6eVQyettuAg8Tn/0iRIGyKhNWNPENCFzq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3801925-99c7-4d17-3d5e-08ddb484ba98
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 07:40:31.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+kjxozaXpgVHoKWsIlo2VbVbwdSEfyhtBYOFtJwCLVPv7kICTynDa1ZklXCyhH9Fcw/2AWzKcEOTW5FXzGZQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

The PCI Express reference clock of i.MX9 PCIes might come from external
clock source. Add the external reference clock mode support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b..9309959874c0 100644
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
@@ -241,6 +242,8 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	bool ext = imx_pcie->enable_ext_refclk;
+
 	/*
 	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
 	 * Through Beacon or PERST# De-assertion
@@ -259,13 +262,12 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD, 0);
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_SS_RW_REG_0,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0,
+			   IMX95_PCIE_REF_USE_PAD);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
-			   IMX95_PCIE_REF_CLKEN);
+			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
 
 	return 0;
 }
@@ -1600,7 +1602,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct imx_pcie *imx_pcie;
 	struct device_node *np;
 	struct device_node *node = dev->of_node;
-	int ret, domain;
+	int i, ret, domain;
 	u16 val;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
@@ -1651,6 +1653,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (imx_pcie->num_clks < 0)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
+	imx_pcie->enable_ext_refclk = true;
+	for (i = 0; i < imx_pcie->num_clks; i++)
+		if (strncmp(imx_pcie->clks[i].id, "ref", 3) == 0)
+			imx_pcie->enable_ext_refclk = false;
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
 		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
-- 
2.37.1


