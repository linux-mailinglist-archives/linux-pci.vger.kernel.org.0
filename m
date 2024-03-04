Return-Path: <linux-pci+bounces-4480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC43870B8D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 21:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC561F21C10
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CD67C0A9;
	Mon,  4 Mar 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n5Tl/qB8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887B27AE5F;
	Mon,  4 Mar 2024 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583953; cv=fail; b=J9BN61aZgu2biqzT4M2iLeZKn7fIeupoUzk36WjA1dIuP1/lvLuKQK8TnACYio3E0HaDV59Ft77zG5MOECrYKL7aAE1LUaSlqObebWEorSL8XAuhBRmZAUSc4qatnJFgvF6NuNcEJ9P6N1NEsLFjDyLGL6nuXPxvxvcwYxpRelg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583953; c=relaxed/simple;
	bh=/5c2VQCQcdB8et6O4zhPC3Aakqqkv58KXa7+2gRtnao=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KnKDsdadi0zMylKuKVLzMcA/Rr75iUw9aG6t1f9l7ECWXRKsik9NarahCHZ2lHWfXtXdNKnjuubq2eOmCVxDmL3dpMs62MdMn26X2KgAMtaRYyIf70sH9Z+5H93Y6+YocefdoZSeEOulWAlUBA2kfRn6b3ygdlMc1+o1sB1Rxic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=n5Tl/qB8; arc=fail smtp.client-ip=40.107.6.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwP/IztcOGJVMKBVU4ai97IqQaCs5pnWS/WA74JoxhbmvRxOuc4puM41TrTOwKN+X2Lue1QMfSyGkUL1tccbv/GmWhIlOcKqreAiYoFNOJACz9EeKPJPOu0OzF1SaYecR8nn1C9B+NSIhjzIfm1PyA/dJJ+3OoXL/WhQx84qYUQoJ3p3mdjYniVipkeeHPue5sEnlQwKNRIFGZtP5T/fcqSEskSwkcqVHehpvjwFEB6DC65KnS3HExUMVctU1f9RD50TtMfElHJOsl4P8jUTvewHYtqXapNAbanYdC9e1I8yIm7j42KrU9WucIsirjpReEO2mb12SE8Rk2VqK+w32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJBOqXkoXm13e6CnPKvx4fKUG1nCA27kudK6IL/V1SM=;
 b=lxSh2fmdmsJ3Dm5Lp/9SNc+0/sOOHVklOV57uw5KPKBGGXUNO40dUFHrDXyj412Ud/eZHFE/TQop03SzbrzSBGKyMQTU1VXbOL9Mly1fPs+VMp0ptNeuszVoo3hv0zstwxpyIcRutcRYq1iSh2DfYPeafHnyf++ltYdT53HFuwy9K5za3unpLz52eeYOU4brUUuMBL1ELoJ+ovWQ5qCLNJFaUhjOlwnNsvM4uWTP7rg+QSh/RDQ1bdI7Hdq3o2ZZEkGlwy7gBCDo0Zz1lZXDQaQphyTAbbDDoHlFtJAsnjyFRokeMJ5A85S9xuMFjPjq0GwVNPqB2/6lHhKfw/pvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJBOqXkoXm13e6CnPKvx4fKUG1nCA27kudK6IL/V1SM=;
 b=n5Tl/qB8sMCzbSsIDPI7bnVDW1apxnKErYC7A/C34rkJM1dt9iVrrijZ6xGLTAdNIdVTHZp/dOYufm9JpAewncnU2A9qd22a2bRdvSLyv4nCEYTscpNg4B5ESignp9OTFwesln67V8QeCTiudskMfS2Od463K1sjoOWSjtjuXhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9083.eurprd04.prod.outlook.com (2603:10a6:10:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 20:25:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 20:25:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 04 Mar 2024 15:25:09 -0500
Subject: [PATCH v2 4/6] PCI: imx: Simplify switch-case logic by involve
 set_ref_clk callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pci2_upstream-v2-4-ad07c5eb6d67@nxp.com>
References: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
In-Reply-To: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709583933; l=8518;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/5c2VQCQcdB8et6O4zhPC3Aakqqkv58KXa7+2gRtnao=;
 b=zvcFMjJigUHrSsI6TyzDEHHuBsh16AncOohY95viCD66ijVzClHvmuegMoyTKmr4VlT6FF7Ln
 MMnc/j/2TLiCf6h3NATZXq7ux1rCSmkQr9y8nFar7TuqFwQUF/pONg6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:806:122::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ac895f-95d4-4979-932b-08dc3c89474c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hgBMVMnNQd26L9CQKgXqK0RqUI8SkalS36VwY41ik1Daef13No3s1/lCStqxxO+bIT3iHjSNwyxtsS0nSqBR7LMs4CyQJ90y8/EuwLRIiA2i23CeCCTS7+ymPM6Yt53cCggAlDkrgAE8UU0WmlzHgcVVs0eOJckjH9aNvEMxzoNZ8tUHRqYBN4MggtyNzkGpY180rl3vzEd4/7W1QX3QE1HO/KIA7Bq+cgW/p/eyvr3ZPDIh6S5Thp5ki+vxBWvLDZ2bxYNKTzACIFLQAU+vJglioP5eVv82XfqSJYVaXVGXDzBHaz8nMdwR/M1pmUpGIVRbRTzLUNhyTuJqhcUkyjTVG3dxgP7f5pD1wvnpR6I9nmwFHADTMkvAkMBAoJNgyn5caFNkFTiCncxmxeOLN6LatnVyZJoBw3LiiOZiGLWOgjI4PkK7BhDep8DW81pzzOgR7a9sUNNeFszImSoxfcBQ7bruPl7PSwru6XWYafhXqf3ji1k5v796B8J8lUNEFei+2I90iJdjW18/jXK01RVWnyVo10hi1Ca6K/BgcBACAxv/FTgtTw2y0CtCSUXxATdCfCdWe6Tx8Sj1jm38REGTpJKeLG7TmO4rYlAbbM+mVLuzRpgE4xtJlV87HaYcXnW2VG3L6jYE+g9QSTkuKT2DVPFOaNEUKOZdfya/O0rV0282M68Y1In8l53O6Ovhi3kWet3AVhUpW0EwKxVsVgsH5hBXrYXFpYCLnKI0M+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzcwU001OUVUUnBNZzJHRDVWR3RKWExtUW5xV3hBdjgwS2pPZmdWbjg4RzVK?=
 =?utf-8?B?cVRnQmtTSzVaNk1UWmI1NVNmcjIvM3Z1cXpTb0NsSUVNRzhaUnVwVWJTSlk0?=
 =?utf-8?B?aXFhbWZPekNZOXI1czVBT0c5azVnLzBMQUtZQUJROTFhSFZka01OYk96ajd3?=
 =?utf-8?B?RUF5TXpQbWs1VUJmeUJvS1FxR2g2Z01Pa0ZZUjUzTVNpRkNDSEo1cWZBNlpu?=
 =?utf-8?B?T0lMNmhKWjR0QmQ5ZWFEcUlidXZuc1VJWjhLRFVDRVpaaW1LN3Z5VFFHV0lh?=
 =?utf-8?B?NWZtdkFsNHVsNFlvakxzOGhxVGRWVExmRXpVOEVocVcxMVA2YUVpeXN0M0dP?=
 =?utf-8?B?dzBjSVloZWVIVWVxNE1qUTUzWkhqcHkzUnJ3YlR6UzhKdTBJMkZuS2R0M0NT?=
 =?utf-8?B?dHJybGhZU1kySXhlV3BSSWlSdzJkbEd0RUNqaUtRT1h3MjNlRXllT0lQSlNs?=
 =?utf-8?B?Sy9TcktwWDg1OGRTbWU2aUpVMzZmOXNrUlJUVHo3VHVDaERiNWlVWFNMT0w3?=
 =?utf-8?B?cnlnWWFGT3l2WklSOHdvMlB2ZUNFN1dIOEZZYU8ybFZuZjhxTnlZQWhteEl2?=
 =?utf-8?B?R21odEp6dmhqUWY0WkJSMXNJLzFaNkxYdU9LL254Q1NSYzZ5SmtjZXhnRkEx?=
 =?utf-8?B?eVdXTXI3ZjhxMVVjbndydGxRdUIzODd6Z2tGMGJVMTd1Tll0dGpvek1YUXB2?=
 =?utf-8?B?SjJJcTZleHc3aFBrRnlPem80UDVIQlBNa0lnYmVMWDJrWTE2QzVYenNoMWF3?=
 =?utf-8?B?KzFncnBEMGk4Ry9LL0ZyNFh2ZVg4dVBQUUNRWWtjczV5dlp4VWYvL2tqSExG?=
 =?utf-8?B?a1dpNkRmMVlTOFJaWTVYTHMrdEhlVElHMVBPbEtrWEJsV2o2VzdUbjJsR1B2?=
 =?utf-8?B?SmpGZTN6SC85dUF1MDN6SHc2ZXBITjg1NmJSN3pWNExUWm9hVVpCakV3c3h3?=
 =?utf-8?B?QUd1endUMjZMeG9CTnRnS2hmZGlldWhLR081M2hnTDJucjFHQzlqQmtFd2JJ?=
 =?utf-8?B?NjVDanNDK2ZtZlJxNzNUaGE2N3RubURDbWFoaThHWlppZHZuQ0JVdU9jL0F6?=
 =?utf-8?B?SUgwdElDV2JIbzRnNkFmTHJ4VnZ4Q2hqdTA3ODVSZnNLd2xSejBzcit1WFU0?=
 =?utf-8?B?VTZQL203WHdnRVRvVDFXbEhGMERNSjdhNWRkV0V6ZlA3SWwyMWlQTnVTUmtV?=
 =?utf-8?B?WkJIVk9yZUhhQTdodWY1YnZQOXFFM2tUOHdVcEFvc2x0aGdZOXRuMTUyVWtx?=
 =?utf-8?B?ZGs1QWg5dlY3SDRUQzUrNTBnVCtydHlXeFlyZ082Q1cwdWZWZVowR3NONFE2?=
 =?utf-8?B?S0ZBREZEODV1NHI1a1dhVnRMRnNaNlVIMmdiNWN5Vk13YTRzSmoyL2lpMndx?=
 =?utf-8?B?dnlXU0tJSDVHTmgwaERGcmVkUWgvTnlEcjJ0UUN4b2t1UlZBOTVKcUErWTdX?=
 =?utf-8?B?K0FQanp3YmlIZkdWa2h6bU1maEw5SHFNY1hvYzBta3Y0a0dMNzZlZHFXVFlH?=
 =?utf-8?B?WmtWN2lWcWo5QkpUL2pPZkRwUWZzTStQSGYxKzJqOXRFTytidTZUTjdZSWxu?=
 =?utf-8?B?bXV1c3RHTmJBdm5tak1SSzBSRWMvaWJ2bW5NQUNHK3I5Mlg0eEVCTGpNZ1Az?=
 =?utf-8?B?dzg0VVhEbDZsQkZiTnNORFQ0SGVGN3ViVnh6NFl4U0FsU0hxU2hWbnlWSkFB?=
 =?utf-8?B?RXJROE5LOERmUlhrcFpsZk9vb2NmendRblVRKzVrWkdqS25nMVplQkx5dlU1?=
 =?utf-8?B?cUpSdlVISEowZWdteUk5anFrTnNZQzJ3MVJOdjg5bjcrMjB3OXh5RWJZdFZQ?=
 =?utf-8?B?MDZVR3Bad3R4Y1NKRHVIK0Z0MnA4Mkg4YzdmanYvRFJhNzUyMVZHdXBCUnJT?=
 =?utf-8?B?dkNtWmxiVVpab2JMRzdMZVhtV3JrSkVFQVVua3l6V0xyWlQ5bjhXc1BmYWIw?=
 =?utf-8?B?TGovMW52anBxUkVQZlltVk9VKy8yYU5TRmtrY0NHekN4WHhzaEp0UUh6amZJ?=
 =?utf-8?B?VnFjUmtGSEk2VG5PbkR2YkNwc25Zd1hVU1ZWVmZtWmx3bWdkcS9TWU5kVXpU?=
 =?utf-8?B?Q3lFKzlHWGw4T21CWjRIK2R3dG9MbjZweDFjZFIzV1VTSnJKMC9HSEdYZ2p6?=
 =?utf-8?Q?vXAjAA6ZK0+3o67+VRwzDUOCn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ac895f-95d4-4979-932b-08dc3c89474c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:25:48.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lw53+BLpO8tBROvtUoaZxsW3Gb5cUrWKzAYYAvBpCGvrZpyEUW2C/9+LAepmLNNwjj3JEW9/UjtOguL+6K8RVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9083

Instead of using the switch case statement to enable/disable the reference
clock handled by this driver itself, let's introduce a new callback
set_ref_clk() and define it for platforms that require it. This simplifies
the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-imx.c | 119 ++++++++++++++++------------------
 1 file changed, 55 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
index 4aa5f054d91c8..bff6212c617b7 100644
--- a/drivers/pci/controller/dwc/pcie-imx.c
+++ b/drivers/pci/controller/dwc/pcie-imx.c
@@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
+	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
 };
 
 struct imx_pcie {
@@ -585,77 +586,54 @@ static int imx_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx6sx_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	unsigned int offset;
-	int ret = 0;
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
-		break;
-	case IMX6QP:
-	case IMX6Q:
+	return 0;
+}
+
+static int imx6q_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	if (enable) {
 		/* power up core phy and enable ref clock */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD, 0);
 		/*
-		 * the async reset input need ref clock to sync internally,
-		 * when the ref clock comes after reset, internal synced
-		 * reset time is too short, cannot meet the requirement.
-		 * add one ~10us delay here.
+		 * the async reset input need ref clock to sync internally, when the ref clock comes
+		 * after reset, internal synced reset time is too short, cannot meet the
+		 * requirement.add one ~10us delay here.
 		 */
 		usleep_range(10, 100);
 		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
-		break;
-	case IMX7D:
-	case IMX95:
-	case IMX95_EP:
-		break;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		offset = imx_pcie_grp_offset(imx_pcie);
-		/*
-		 * Set the over ride low and enabled
-		 * make sure that REF_CLK is turned on.
-		 */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
-				   0);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
-		break;
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	} else {
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_TEST_PD, IMX6Q_GPR1_PCIE_TEST_PD);
 	}
 
-	return ret;
+	return 0;
 }
 
-static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx8mm_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6QP:
-	case IMX6Q:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				IMX6Q_GPR1_PCIE_TEST_PD,
-				IMX6Q_GPR1_PCIE_TEST_PD);
-		break;
-	case IMX7D:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
-		break;
-	default:
-		break;
-	}
+	int offset = imx_pcie_grp_offset(imx_pcie);
+
+	/* Set the over ride low and enabled make sure that REF_CLK is turned on.*/
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN :  0);
+	return 0;
+}
+
+static int imx7d_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+			    enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	return 0;
 }
 
 static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
@@ -668,10 +646,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 	if (ret)
 		return ret;
 
-	ret = imx_pcie_enable_ref_clk(imx_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie ref clock\n");
-		goto err_ref_clk;
+	if (imx_pcie->drvdata->set_ref_clk) {
+		ret = imx_pcie->drvdata->set_ref_clk(imx_pcie, true);
+		if (ret) {
+			dev_err(dev, "unable to enable pcie ref clock\n");
+			goto err_ref_clk;
+		}
 	}
 
 	/* allow the clocks to stabilize */
@@ -686,7 +666,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 
 static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 {
-	imx_pcie_disable_ref_clk(imx_pcie);
+	if (imx_pcie->drvdata->set_ref_clk)
+		imx_pcie->drvdata->set_ref_clk(imx_pcie, false);
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
@@ -1463,6 +1444,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1477,6 +1459,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
+		.set_ref_clk = imx6sx_pcie_set_ref_clk,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1492,6 +1475,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1504,6 +1488,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
+		.set_ref_clk = imx7d_pcie_set_ref_clk,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1517,6 +1502,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1528,6 +1514,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1539,6 +1526,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95] = {
 		.variant = IMX95,
@@ -1565,6 +1553,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1576,6 +1565,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1587,6 +1577,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,

-- 
2.34.1


