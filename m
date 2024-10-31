Return-Path: <linux-pci+bounces-15676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986E9B75D9
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB96285A73
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A03155759;
	Thu, 31 Oct 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A8opTlpR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3B1552E7;
	Thu, 31 Oct 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361436; cv=fail; b=AYKIfinDgQImpYOKzHQNZkwSzPmK2MGyQ54fp80uuBn12htIWtAb/BUnKDDCr7sw5rwgNNcNZjLf98uc83dvcGR5Zi6prvuaSLLzmYEl//bQ3asrnSVbpj7lGyr87Jll/RNSOu1fMvMpZTLQ5LIUbqkQm7Fo9ieb2A7jQMm3Z5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361436; c=relaxed/simple;
	bh=4OK51XffZrd9YSPk9saIAMj8E+QQlTlRpzj5H2SyVyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJAVlw/3oLCdG0CQqUKLlNE753VEUIWD9qQ/6lUQmQT3eyV3IyQ3bSAEZV76+ndrXwqAhV40YQnEUZwrYYkbVB8UReYgmfixpu4JqQlC4knHkN7HR2zJsoCsO4Bua43rswWSqYC0lc9IPGYYgFmmqUNDstT6XdgiFTxUAVO/WhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A8opTlpR; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbIp7cPvNkd1p+y6O8AET669nGLujN9HQulKNyXddxoUvmx7fYkjcm1Ds884No99HzJOBh5an8jNVA6VsDDAi2SwFtom6KgHcw+Bn0RfQvGkkAi5nP2ImA76R3opNwzPNm+QTWBAI5gzst/WbpLILcBHLPjBxIhC3RlegdTlZXJONfzLBQqLDmZgWLVo8hA3Y1yhW43wfQdTrwYbUbzhK3OVsST3wyi1V15o3yraBP5XeMBVBgG9sBpsf8Ofla+xgfmde/GjzrJLNTsKQZnlWr6XuaRSztLTB41/xHUaNo+fn/0tNmlYXcOblgddzNQ6AP1gzDwuo7BhbDSG8oHmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz9UKRtTNRCDO2SlwBfibjbgb6pWyEkAXpbyXezHnpY=;
 b=pTA2WdGuCV/R+vKD/I77umzhGn1V5iT34TcK81ZMs71uBnq6DaJBTkxs4OatBVWb6nqtwTfidbJroWYriSGPIM1p0R0jFKlSh+88lCiyiSlf2DS3a2tK5pkYEeSFTbhlK4h/uwr/NgyQhMB04XHXEd+JCXm2QhN59foXfpgFTc4XljaMWGAyD1br6V/JxyZ+Wuc8oDk3toTX5uYhSUBYP4U3mc8W5Hfj+Yn7DOhCIe00TMZ67z5c9vKhOVx0uzF525db6wyF9P5/x3ODZ/68QajQsU8ev/7LPmV3UrdkU5WIjA6sjRXUrRAjiuqSTwa9g7waJKjOJwJz5aEEsJXc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz9UKRtTNRCDO2SlwBfibjbgb6pWyEkAXpbyXezHnpY=;
 b=A8opTlpRZyUcqPjgV0HC25K3hZanonMsfO/YiHy0kZjm5ikF1MjaTkhRh+79sdCwRLehLl6kbOD4RFAHDe4I8Ee4SPxdFP67Au56QJrv16wPDKFmntD2/H/O4YF3y/tRov/ZX8Of3jXeetgHMUQgaktdeYZiZCAiA4SHE15dp8GUoLeKQ7zbKRLkf2gVgDyL3UsbuesFzqd3kWeqifpKUg4YCM+hiCYlO/e8WENkdy7Kt4XivRRsr9mvSklphvt79NHbztF1AoUa5qj/fE+RpV7HlTiG2ZOtpoUuC1zNqhc2W/uDoZwB5lNZu1OTwJzjbe7qQqiZSnSvxklPhr2Fdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:57:12 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:57:11 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses from DT
Date: Thu, 31 Oct 2024 16:06:48 +0800
Message-Id: <20241031080655.3879139-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
References: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DB9PR04MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: e560d1e8-bd83-4cf1-fcf0-08dcf981a05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IwhnpRSLKOACGygO6QkpNBW/GDPW/QGXfsJF0+qtoLPcmzvAO1I+0wR6y0CM?=
 =?us-ascii?Q?wbOFP5tPuHi8gdN6KMkFtTCGDFofYbjWjB7fJzaTqKHSWatn+oovCYY3M7w5?=
 =?us-ascii?Q?+lGn5GQI92lbE02xwlI0y7KsvhGo99Ns/Ew6v7hhvliMrKO18GuNuOiIFpVJ?=
 =?us-ascii?Q?uSlDJA6cZeWdUF/TunIN5sHRofgIt/rGeOOijXHd+YycWYr6nUFaEgqQBQ0G?=
 =?us-ascii?Q?sT2+5wDyKEsrsR0pQP7IlnbimJXeyd2qnDK7zaLYDIMj04/IzPXb6z3SRt0e?=
 =?us-ascii?Q?G/1/TojJdDlP25wEDXUalJ/vqT7xY3Vd9rESJyE/S1IQGafihzKcslnYlqoq?=
 =?us-ascii?Q?Jn7n5kKJVeAvIidFydgQZU2hQH0gtJbofjT62ovfE2EhsQ9vMfrQB6nnZSEI?=
 =?us-ascii?Q?XIXhEORArT3eg+vFoYRsIb8sH/ZhiMGsDFzaTVRPyPuNgIIragbKWaIosr5B?=
 =?us-ascii?Q?brFZwOelc+sCd895bYF3NgPe2+CNmair7t6RFNp6PsqGNNuIcwlt9AI8VF/h?=
 =?us-ascii?Q?YhkBPC9afSmSKI/1uO5HLW+tgkrCDEI0S+SOZ5oQPb9GO7I0vEloZopghkOg?=
 =?us-ascii?Q?rMfruEu0cMMgYhDzGS/OWDxljcenkygmUi/VcKm4kDwE/Jlj6f1j3sjo9WpH?=
 =?us-ascii?Q?PT7LkWFAJSbURa2GEzsBjLVam0dDRxLle3ECMokYb5wy/rUz7klatFcnbjsr?=
 =?us-ascii?Q?tp97VZAjCRd5MeKKjXVBsEbNbB2+yUcUcLLw7+fytCozAtMbXkVXoKlpoYBy?=
 =?us-ascii?Q?b9lk6bcXzPwIMPD9o/5hlFifijD+1iVsr6wS8KeLuQYNy6ZvB+eV4NvVws2z?=
 =?us-ascii?Q?78i6RPRPAr22LSOrXGLEHXjIWBOVCGBkE3L+CudAatjUQku4Qxhj/yYl0kbX?=
 =?us-ascii?Q?pDxxDH0OcETSjrHSPUqG9kSVO5WQhh3j21eVwYgDutan/4382BWcDe3U731E?=
 =?us-ascii?Q?ozmOujOA+VJi6ZzGQ1vkPHzl/yN3QNf+yBUj6kqa2EExCrghgLwQoNXoWMgq?=
 =?us-ascii?Q?B9mXTyqDHal/RdK5PJTy+kVvu3pzMJd2oDC4c5aCpq4V7Qyfwi7VnxdjA/6X?=
 =?us-ascii?Q?+Dziu6iqCtbFwHgk2lvgAW6QKswWZz6HtgCRW85Ix6z29JH3Io177+LGV0om?=
 =?us-ascii?Q?6DtE047qJaGK6/ca4FEI/4nWVT9iRUbbmCuLofH0JYBxihdU3RoW660Tvwn5?=
 =?us-ascii?Q?9VmnJMkE460vsqkLZ4l5n5qcECnJUBbI98CCRnRyB69Ojd75op0t6dc/siff?=
 =?us-ascii?Q?ZUYUZwPM2/pqt7wcJjmW6mcPvfh9bXz9SAtv6comR9Wtjui0EG+15eau5FC+?=
 =?us-ascii?Q?LpP3lkv0mGyfVDuc4BqJGx2Gq3gBsA6f8X2Ljr9rINj7UwA1407ABJDnwJO7?=
 =?us-ascii?Q?g6a5ZvQeP/UK3TrtazAb0NCWeOGv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TNk1FuE1eqexW2/UDFYU+qHSLKdkr86fXlu4Ct39MoEsju41HTW0deRviqx1?=
 =?us-ascii?Q?/EWEYQ0KZoDlD9RA+gWG6+HCNY7vQgTPCCyTLSbIMcTlRbGRW4Jc6U9j/8QX?=
 =?us-ascii?Q?Z86LPXd9fFn2TkFbvKYeklmD6BqwP6TjhD46mJY46R2TDK7mHpeWbIMcVuv+?=
 =?us-ascii?Q?N+d1TqQ70oRlvLYSaDLosaQCuZoXcWTW6gsMoWD/cirtggmidDVNQF2tQOto?=
 =?us-ascii?Q?Lj7nDJIpHCx21t9xXM43aYXmpoGOynfnDg7f/yNtBAdNkD4SDQGKvdEduYpi?=
 =?us-ascii?Q?EPuwXiR2YZk2i6Jb0ODLGdrUVrGqz/lGI/tokDZwW6bzEiskhnWTHaWLnYJG?=
 =?us-ascii?Q?5gp+Zcj+WqJPQD4kL14/p0JYxbjP4nmMMAKAgGJAgPGO+3lFpghq8D+OSGRD?=
 =?us-ascii?Q?94r9TdeWdevlvrs2006+flDWXAlkczEFnTJwBdMxG0rZu9oAKHyGmiLJzm+5?=
 =?us-ascii?Q?dy1g0vFyfBT5dFghQT/yxieyhsRbH7CeZg9tjaaVubLz+x9jDQESQtCA3SZi?=
 =?us-ascii?Q?44iSBy66H0PzHFBfJuKb8JX2S8U+qCp6gnprHuJbr0yCg51GrozPNbXhnGJx?=
 =?us-ascii?Q?i7JS1LjZrp0aR7xs2Z1fI038M/JsrnZJB9+UM3NCiFntnHtVr0D+s426/K36?=
 =?us-ascii?Q?s1GQ9J3dj7UtObtKE5XocZPhgaH000r3PNp7XrEcVaaMsJ6HG1hcet1hu2zT?=
 =?us-ascii?Q?DqJvQMTLzz/Ll7amolcWdQCAmofL3FBahqd56Ivf95hPAQQRxVLY1FdcF9gW?=
 =?us-ascii?Q?diOwKzGNB/gWe8/RnMYv8Syn0pfPbqrmdO7TaZSEJumMRNmk3doHdu2iEnvF?=
 =?us-ascii?Q?PXeqzqkDrnhzrgeN5fpzWyGk2rd0N1cFY0wFRV/WTSj6SpjDDWUwt96MACIn?=
 =?us-ascii?Q?3Kb+kpXnScXmCp7POiPcJmO03FKgEnZ+O73BDRbtJQ2tbcSnu3BpX+3OhKpi?=
 =?us-ascii?Q?euy2X34dYeiseHpg66nbRf//V5oAZ+YbZ87y9fUDBUUarDaD4et8g2ZGBEM2?=
 =?us-ascii?Q?bxYh588vE0U40nkQDNFiAW28NFt8m8vRjvEkAouFuWj6r752gQ6jYPGNOUKl?=
 =?us-ascii?Q?RvHxP0Mj7/ZzqODHDffYH9OKgJhT/hCawrqwXWxSAdq7iw96Ir0xvWj7fbcx?=
 =?us-ascii?Q?I4MNkGVqqHnhe9Ndgj4khNQietxWEiAebk2nOxUWwGfPNEJKhhidh3OfUjCj?=
 =?us-ascii?Q?363T13ZEkwOMNTe9A8TXU3FNZ7c+2OPGY0GxY6K1hNsHqd5RYhyD3dEQsYi+?=
 =?us-ascii?Q?KwY64uAmjL3Y4Vfa2rIcA0IAoHyXl0u0Le83iNCl9EkX5c8gC5FI3ztcuhl1?=
 =?us-ascii?Q?/+PTXft3lmT7iZRCDXW13gY+iRO4wfCN0/WS9SBoetcizIaHh6lhYWsm6I3F?=
 =?us-ascii?Q?7F+QpaK9ERk7QT6yhBczKehcpwf039c5NFDG50DxWUNLEo0O+1mPAxPZHzSu?=
 =?us-ascii?Q?yZ0TjmMZu7P0IEUApuY1f9clBZpcKjt+KhmrcxwVWp8iv/ni7exfm8BhffqN?=
 =?us-ascii?Q?5R+Fhdg4T+AZ0sS7Ddi+cbQJjVbn1EBSAhFFYyzZHXVrLDqVLeef8nLU+eHZ?=
 =?us-ascii?Q?SDckMKKI/nw0w1ksOKLtB4m81Um2qXHsxe+XT9sR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e560d1e8-bd83-4cf1-fcf0-08dcf981a05f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:57:11.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5G6FG1752Ciutz78HW4C5OphHcF0/oukxNT6b9JzSYQI8xmBtQpkSB5LW7Y8znoyENijjeI5xNNTd6qgultZ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139

Since dbi2 and atu regs are added for i.MX8M PCIes. Fetch the dbi2 and iATU
base addresses from DT directly, and remove the useless codes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 73cb69ba8933..d21f7d2e79dc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1114,7 +1114,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 			   struct platform_device *pdev)
 {
 	int ret;
-	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
 	struct dw_pcie *pci = imx_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
@@ -1124,25 +1123,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX8MQ_EP:
-	case IMX8MM_EP:
-	case IMX8MP_EP:
-		pcie_dbi2_offset = SZ_1M;
-		break;
-	default:
-		pcie_dbi2_offset = SZ_4K;
-		break;
-	}
-
-	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
-
-	/*
-	 * FIXME: Ideally, dbi2 base address should come from DT. But since only IMX95 is defining
-	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone so that the DWC
-	 * core code can fetch that from DT. But once all platform DTs were fixed, this and the
-	 * above "dbi_base2" setting should be removed.
-	 */
 	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
 		pci->dbi_base2 = NULL;
 
-- 
2.37.1


