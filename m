Return-Path: <linux-pci+bounces-15682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D089B75EE
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25638B2120D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FEB1940A1;
	Thu, 31 Oct 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bee0TbN+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86F155A43;
	Thu, 31 Oct 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361471; cv=fail; b=YcPfCMliGGInPkgz1qeWCOix9RXtaorjveJRqpSef3Hapj4ZaDrKM7o8AVPX/5stUjBFFxVOFUDJuH9WS49osCa4wDCuIHqyTKWL62CfQUiphy1sfG2QC5pPK8eAdK2P1t6C03yYdQKhRUrh6gNyM+7BhmIy7AZTwnjXfTK7Qzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361471; c=relaxed/simple;
	bh=HeUvL151ZVz8jBw465yIQ+XeDOUcB1NhIr0mEuJQo7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETzLFSl7jYDQaCxqVJD2wrdEkek09j9pDNBtUcalNQAj6q8oBk1ipr1LBA1Ldj9jQNccOd8E2fDZQyx84n1UrCnQcmRQgAEX/5940NUObUAyMT63SzU8HCZdKkabzqOaSV7iCKQx2fXEMPiiNg5QCdbsyFtHAYXvFfCXdjUUGwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bee0TbN+; arc=fail smtp.client-ip=40.107.249.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNO/OZZz3YTWhe6e2D3OLTZefZVI0mZgN/VSFe6fxxSfEMmSIT4EjaiKJMppXUOSUKOx2QA2cFrPXj6dEWJFmpHrCKawo8oOdS1jNGx562KlS1KNAtPP7jTMAF5iH8hQnMbkNKcoqfZRQMHhPI2Iq710OC8ViieS4SVON9yHTPrY21wap0Qae0PWdFFARsdcOeFU9jafISGRw1QLaN50eTJ5U0E5k8SBAmyy5Gp99LY0NGa+cdP9BuyfF7nyHSD973QYmlKb5JnfFiLteZ9coqAwIaNvCcv6tsuZRv18OZ1pHHXPviUw46Tf706GCDxgm8KUI7JYm9aShj4j/bnbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4dbuamOPX2gdANO1GjTEOYffHw4Dwbo03rVE2EdQWo=;
 b=Ay+0/VnTFSYU83GP4eA1N3YedCOIaeR778AT7NdnuyrAEcAt2zGhUDbTKnKj3Pr2HRe9JW4RAaiiilL6Y/dMKoKwb9aHhfO/LJ/ggB61MD1PUpQQsu7OyHbae4/X+kMNlhWvqcwzzDajxHpbA7SeWbnk+1mQODfXbpSyzc26bac09mntyJHEBOjAr6orwCP2qNQmcPMmaRQCmC/pdHm9e7wKrfKwFqX6Nnu1vsgAYpeAXIjIQo15mjkINvYa0Z+w9Q25XfvREmDoXh7L9FHGF5liyrh5N9z53lyH4uTvH3rf79xk6TBIf8dkI+xehgmsTnCKGMaM3TAjFi9eFGQmcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4dbuamOPX2gdANO1GjTEOYffHw4Dwbo03rVE2EdQWo=;
 b=Bee0TbN+UhODqmYgAJ8FtQo9zrltlFOtvoEsX3itj8Tpgs0+aQ+SB55NVeKteLrl421ZDaqIVs1+FaBPdhz1dFPxxRN5UeOlXy75sahAHMXiloce+GChCG4s7o48k26okV/kIN/9lM57up7hdEHEpQJrjjYjiNIWJwSnc6r3ON/d9ZyVXBwLkylzsmgo3HXufZYTB8l7HTLvjo85V+NsbrtvjpnRbL1m+td3sJQX9g4DBJuZSy0iq0s5jZGLwESJV2C7kAoCUqkl6jFx+UO+b4cnBC2nDXFdz/l1cynnXj0pXCJZTZyXahOUmahMJRlplVcNWjBBoGZE7y0HH73nJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:57:47 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:57:47 +0000
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
Subject: [PATCH v5 09/10] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PCIe PM support
Date: Thu, 31 Oct 2024 16:06:54 +0800
Message-Id: <20241031080655.3879139-10-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0fc0c5b4-0548-4ec9-af55-08dcf981b56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0eSbVJUJT/QKkuI5ywkOVp2ILnTTPOGVOtUkKVTfAROrGoLliPNHWf9Heug1?=
 =?us-ascii?Q?VlxmJksTrib/fY66qIRc9WiIIraxbaUXkj3IJiIjb5fCoa7ELz/Wh7HIjwAb?=
 =?us-ascii?Q?mlGfUv64k1OXeJ9JYFEcOANaNVH2uXsDDWsLmhk4cAcp/WUOTI35Y9dN0clZ?=
 =?us-ascii?Q?i2qIulFEJIJV6DCApwQvNixMomKMDUmjJbjTmZmkWHXPvIw+X0kuXjQnoAoX?=
 =?us-ascii?Q?H1W0aL2U6Xx0de/C7iH6at8y3KpHkO+/9I4bRmu2PpmSoYzhgr5sVOV4kT8B?=
 =?us-ascii?Q?x/mFO8MfSJZFciynqTAInYAMF0wmWnVOjhqpSBPsyE6izURhoq1PDZCKttMi?=
 =?us-ascii?Q?Pa2mQcY1mU+U3qCm3Jc5IpdYPuD1Rt5LAhD0oJIQpsfwaW1lA1AQHrxN8TRk?=
 =?us-ascii?Q?RKJ4idYRJ8qRn06KicqhMnv0jMWls4cfJ5j5fzZ8e1BITj057MzJojK0vwoQ?=
 =?us-ascii?Q?8TxVtoWnc3Gbvv+ZXnhk0iU/5b+7pkn/z+V2VzrGcQJjR5H8ixp+foQxKk3e?=
 =?us-ascii?Q?7ADFbYhI8VcFezHdROGHqV7H8MKPdrmQLwnm7zu7ejzIsTv1EeAaKaRLUuuq?=
 =?us-ascii?Q?wVw97LRcqtY5GYR7ON9eA3LNbxRLg0ybDZabr/mqeWDiiApWFrVzrNYXZnQs?=
 =?us-ascii?Q?+F4fBTkwejjS0uuI1XokOFgC58ATT2bhs2BpWQIyOE8INjoRV4MeHPBiqQQY?=
 =?us-ascii?Q?NlIUN5/L/xI1Yhz6FocXxOnXRIlIpPIqF8aFeIf65ep44ZuXmdLqMqCIIbK6?=
 =?us-ascii?Q?qBb7ikNMJHkHU4supG7EyXIdyNjjHeaqLRbCryIIKFbA5H80Q3ZCSP5WPgTl?=
 =?us-ascii?Q?vmf4rKtTftCxcKM8Vjr+W9o9Z3Y5dGKGfdL7Wi10Jf/bZ9Gh3T4f4RQFVTa4?=
 =?us-ascii?Q?X1kCdrWqjwb7NWozdYmux2epUXdLT3rXGkdGH2VB7UE72eAX+NyJfy69icMw?=
 =?us-ascii?Q?E4sO4IIlM2cP2958S0t7GyCCu2USLdoMapuMm3thNER7qCi9xmutQK/ASUPP?=
 =?us-ascii?Q?ntUkHl2LZo0OVBp/ftON13oJTylTCrb997louPe4ph4AMecHQIz9mHXoUljI?=
 =?us-ascii?Q?8MSr4d/Bvs4NlvR+CR8qmt6r+QOM6zPVgYR2diARUFrY/iv7kirQedDmU9Xe?=
 =?us-ascii?Q?HyH1WyCE0RpsgFCgfGVv2SFxVLcmCJAYSnmxXwwR3eErFrJjVygj/rAwPCZW?=
 =?us-ascii?Q?Pn6NEdbjOC+Rkm1sBSrEWBI2o0t1FHFLt7Mvc7rVqkmDyy/BS53XiMkV5o5S?=
 =?us-ascii?Q?9mbR9lfTVZlbsOPKzev9XzuYhPVN8zNnZ8GoqyPw9MCt1BHMR+Q226tBcTsD?=
 =?us-ascii?Q?/W5tWwGhNE4pIfiqhY6TRw7mrCf8nw1b2TbqQ2p1jzeFLYFaf3h1gXdsbQPg?=
 =?us-ascii?Q?TEJq957R6ELWwYuDZTSvbLpT9Uqs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YpE05U9vaaetzbqDC9NG7I4I3iB7SH6x2DT5Q32uS7zbMsGIfVugj2xr5A50?=
 =?us-ascii?Q?Nh6YZkakAgkMoZR747kOd5U9qJmx/wCJX7AW8K69AokWp18unJ8NetajXe7v?=
 =?us-ascii?Q?JAt5ePZKrJJP2Kw94OhTB8vKAfQz1WZUO1kCw+6A/6v8cA89D7Rw0HsZ8yTC?=
 =?us-ascii?Q?1a21SKFu4EJJs4r8y4x+muL1huy0BbfTdsICVU0DRgCy7ZAhVOPciSXqeRiS?=
 =?us-ascii?Q?Q0tCVjb6zfycfuIikWfLFeeDSBo3BNZrMcC11Ap4ZjYjsCaO691JxDt6SM9q?=
 =?us-ascii?Q?FdcJNj68ifqupSVOAgDTfWfPDvK1RFfFwhJxHdXDFC0lSLqQTERfYSGDT3ug?=
 =?us-ascii?Q?bV/Hf7SGnPUM+7hm/zOoZoO6mWiMstSJcyG1k+U214ss82yeiaQubZruN4L8?=
 =?us-ascii?Q?ds4rDkGucioIhaxKz6nERmgTAKW9CNzYem3jKqOBSgpgUhy5Nf1UQWdz8Uwa?=
 =?us-ascii?Q?t42EsWIAwTGLTVN7OSIbDiFFygaEr4CPEe0QTqrl8+P6SCsDe5eFJcWWSAlT?=
 =?us-ascii?Q?ibkFBk+fiSiWfeN0TfJ73ACwoIXYtVcdUjp92zYAep9fWci+jMYWyzewJkTo?=
 =?us-ascii?Q?AB1nOcJljmqQXUqVnhygsLOzgQFhQunNF3fDSoeqYYRIuYvd6LL26gNlBwNg?=
 =?us-ascii?Q?C1ejLss4rP7pHCOXxwG4y237O7dqGdYjQb/L25/hMCxGkuHElKfY4tBjXxke?=
 =?us-ascii?Q?OQ5Hx+SnVCVn25sJNL8WmSRS85Bj3NOras+KoKacUyj36wCcpPpLC5ZjNDJJ?=
 =?us-ascii?Q?h8y2fhEQQwOnA1JuzPZlmuicXQ2L9yHcuQZa0nyiJu3KRyEQHRvAJRuT3Sgl?=
 =?us-ascii?Q?WElmXsAuZzUSHftAaoqL9YsxSMNEFfsYjISuJw5CeVTKEmwPO1U2nAy49b2H?=
 =?us-ascii?Q?W1t5GsUq7cSaA3Ne0UNJ5qFITFZ9iMxV2wAaQKUVCTDuc+QqqkSrP+YWF4IU?=
 =?us-ascii?Q?pS79bzXJ7M/rK1JkBheECzU+XR25X5GeDTXpQIa5f0NiXT5pWs3oSZ8+Iybg?=
 =?us-ascii?Q?eJt9Q7GdTgSoCBPdY3miFhmz3axGsrFSZDSwFIkiJCh1HA8o9w0aUIpY4szm?=
 =?us-ascii?Q?R4HLC9cHZ5MJIxwGuPytsyhHmQ65xZOgdbUrZxqGtQU5p+GraALvuZPA8fQp?=
 =?us-ascii?Q?aNYyAI5MOD9JHTS3wod4u7jaoAydxs0ejDv7RIuqKHkaul5MdeOtX4AW7nUk?=
 =?us-ascii?Q?L+9jH4O7jaCevzC9T4AL73mWe2xXKL0NQLVFu6N2Ay3nekpP6ETX1cRFXmgN?=
 =?us-ascii?Q?Ewac7Ps7W59czN4qp4773ebucoocjCeQ7z81dKQ2B5NwUFlIuh1+p2z6nV6k?=
 =?us-ascii?Q?oSukRBx3S39PKFEqXqtZ8ZjbNU+VxKU3H+jCLjJxBewyoveaC/cvt2JfWRWE?=
 =?us-ascii?Q?nJDUM2pLF9bLH0DjieQOIanMvTXKwRsuRrisliJMYR9YTr8SUHhChYmIsQ58?=
 =?us-ascii?Q?V2rAutP1FkSBlV4pACTg7LS/vTODiirGlG+zQ7JlVbSqjZd3OQoBRKiY6zML?=
 =?us-ascii?Q?TsaE4HmEYcAVmh1hRiVdI79kVjmr4eySVy7usmUOEW+WU1G3PtbQwpCVkgxe?=
 =?us-ascii?Q?8pvhcRfDA3PxRI/mKu+dVJeSV9yBUjUAb63Tz2vz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc0c5b4-0548-4ec9-af55-08dcf981b56d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:57:47.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfKhCrzAMzZsbW0m57dDECVEkF4kH1BJvD3xuPLNAjy7k/j0+fQ+Ie6MtYM4LnBN1i40cxHDNQ5mm8DR2tiYOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139

Add iMX8MQ i.MX8Q and i.MX95 PCIe suspend/resume support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 410a31e5f82a..f662fbb45626 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1502,7 +1502,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
-			 IMX_PCIE_FLAG_HAS_PHY_RESET,
+			 IMX_PCIE_FLAG_HAS_PHY_RESET |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
@@ -1540,14 +1541,16 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX8Q] = {
 		.variant = IMX8Q,
 		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
-			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.clk_names = imx8q_clks,
 		.clks_cnt = ARRAY_SIZE(imx8q_clks),
 	},
 	[IMX95] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
-			 IMX_PCIE_FLAG_CLOCKS_OPTIONAL,
+			 IMX_PCIE_FLAG_CLOCKS_OPTIONAL |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.clk_names = imx95_clks,
 		.clks_cnt = ARRAY_SIZE(imx95_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
-- 
2.37.1


