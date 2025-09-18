Return-Path: <linux-pci+bounces-36401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39135B82C1A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 05:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CD5721E09
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 03:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170BC246335;
	Thu, 18 Sep 2025 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VOcvesfW"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B5242D70;
	Thu, 18 Sep 2025 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166028; cv=fail; b=fq+dnqN3LVKfYNptCvC/nmsLfvClvnKWbL9ZQhm0R+kkh4yGFrE1hZgoiiAdNL2b3Oe1borlz83VCR2OjlkfZb1VI9KmTDEBh1RcqNrYKlG4H0IB0GtqwRkL1Z/Xj+zemuhqW4naLAfTEcou0mXpCC3F2Oa7yekdQjBm0JNiPts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166028; c=relaxed/simple;
	bh=W14v1/ukkK8Uv/rmisUwQ1b6o5lWmil1plSNAuT8/7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOdX847XdFAkgKd4hTeJDwx9XDJvdiZ5wj8PViVaIckEm0glZMXUDlSEg2EM7m16eBtOKJ1J/g+MITcyMgy8ruVkRYqoG6ScGWk3mxxTsflmVgNlHMnNi1ySrDJzj8dSQaEFn99xQslBGls8N7/hI7ltT8P3CJqDA/Rl8WIV7Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VOcvesfW; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nop6udBTzVE0Iqg/TzhgntPvFMJPzr3bGW+kiSoOdODmYlsXQ/aWBRihjBNHyIMpi21VagU1Z1vGUO270ivsXKImPRhQsrhhx5dmKhdwxHfu19kRzzLhFIg7Ux5lNE+Vtvt+37fqqbfAlIwtoZPnOQ+kwm9uy3YEQ8wbcB4fWX4vfwr0HirA69loXDomQKr/zJa2xdVvscTWswmp0yoZ40n3m37xyXakEvC+asZefVqH3Kvxey6Q+iSn5UpF+ar1Cfb1iRYat5duMOrRnQA0Q8rREvs0XSCfqxv8xIGuoDHRNaYS4B0vSXi/ZD2QI01iup7M9JrUgiB1Ek5dn4en7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVnAftR3C0+s1NEQLgERq3QkJQ8SqbQnyrrWTVby2iw=;
 b=UD6/gQPm/OzTFB277G6Y99IZNV36YP1mT0dxyyGPnMIOYagRhe7zMyBrgVgI3o0GIK4LVL4WikofKRc2Hm7F4pPtefbnY6uPJW0FORI4gaDbhmLuUyaLlwiezVFO/kF5Y+aq97WnCqynWpnit5ADRFLLqGV3jsIjknM/kWusCNzXYLFvmP+wT4fuambWYE82Vrk636U6NUs7JBo9VHxP2CjClUMijfjvSq0ET891iGez3fMbZlXfPlr7Z2fgrcZoEuqXFVsMAl55VIzskNNbrtphwTKis01mG8LeSW6pewvooT9W4RgaQx4SsVIeTqSJxtNzWUtyn1yDvL9w6icnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVnAftR3C0+s1NEQLgERq3QkJQ8SqbQnyrrWTVby2iw=;
 b=VOcvesfWki96f2tsdGRObcROSC4QYRg4us7Tes+tc8f5itfOa8/6s5XMw2qBUU9Wh37clNU0jN7V0S208is4jSYnvJF3Et/hw77adeNJAJAyLhcG75ZAS0k/6dcnyDMVaqMEYgjwZlq6Rd5vutnkc+mqb48kek7pz6Ago5lNQtFQC2WGAUFslMzo8X0vwq+DMC9NBN/vygmtvI7uC1IRvDNSA/nspBkCjYJc2QSd8NNNIBI76fQSpq7aQmzgRuwfMFkyA0mWejDtpQrUvxJMYNfPzVFV6xDU4toBnpmGtyYaMMdTEL5+TClRjmsdkMzDExR+QcuiI0zySQLU6xC+bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DBAPR04MB7317.eurprd04.prod.outlook.com (2603:10a6:10:1b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 03:27:03 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 03:27:03 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 3/3] PCI: imx6: Add external reference clock input mode support
Date: Thu, 18 Sep 2025 11:25:55 +0800
Message-Id: <20250918032555.3987157-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250918032555.3987157-1-hongxing.zhu@nxp.com>
References: <20250918032555.3987157-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DBAPR04MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0079ac-0ce3-406d-e6de-08ddf6633c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dpCgJ951haRJ1txrdIYoo90QMNIUKEK66kKcafZmc22+JdDiYC7t6G2Ng1EN?=
 =?us-ascii?Q?HuQUEVVQvy2IIcB9yNlyBpsIlzcZWHzpr7p4Ql2T/8rngPdqpcHRWSao6kr7?=
 =?us-ascii?Q?81YFSE7dMrd+IzrsT1nBm9GIoobAvAE9yChmiCxgWO02r3SoZ9JOSh0lUwzM?=
 =?us-ascii?Q?dk+esh+LNluGzuI0eqBwMPHY4o6gwuH1apBFOrJ38zgPugqoEphlVdh8r5Z9?=
 =?us-ascii?Q?ij3oZHrkG0t/WYqI37KQbjQtUn4bCnSirdtB8u9TQeowXYUiab3ve3gEgmu3?=
 =?us-ascii?Q?I0KAenSldeIZnAS5GMOSoCCjWmLOyh9wBd3sJVkJJiwAaD3rTqNb96PLVeyR?=
 =?us-ascii?Q?RXGFzRCfW7P9ksZM74VXEk4agsLZsluKUUQU2Nukp2O7EcX8UPsaw6O3fFaD?=
 =?us-ascii?Q?S4rK9c/J0UgbExGQEjng6VtaRN4QBzqvVOJ+1x6tKVcJ8d56XqvBQscIUUsG?=
 =?us-ascii?Q?4otncKKbNn5FtJDi/FsGfOL7Riw5dEWgajn9yRsI+xGBCDbb+pYMBLniB9m4?=
 =?us-ascii?Q?BsujIa1x7ZmHFcxZIKmO0LD/SX7YYKJ8bk6gN2mKtJNTJmt6L+gSjAOUoG9z?=
 =?us-ascii?Q?UexWb33pfOcMgCuCi6DZx7iV7dFE2pb6JlGn6Diagb6QtjAVPldhpPaF4I4Y?=
 =?us-ascii?Q?FRb6CHerjkTCizkXwfES/8xhLkkUH+tKlxKtjSuVqgxd/x4klUs7Gshsytw2?=
 =?us-ascii?Q?o/FQuFsWagNUIApCwPX7mfzSIZexoDP5rJTxMGoGEmu8fbEUTlBKhANHk9E8?=
 =?us-ascii?Q?3wdQNA9CXJW0HpnHWRz3fsUS4jHfzmY2SBnpR6dH1ZyIDAqmQexH/8uIF4fy?=
 =?us-ascii?Q?pJtGIKRMrk8WwFN5bMGIcOhAezHy+IPMKsjC7VxXf9UBCKunKKPsPw8cGx9E?=
 =?us-ascii?Q?WXPnCTsJ1n+hBHhluSatJ2D/F8JedYMw+r3hpvwSJ6U82oHIGX/iJInhcqDs?=
 =?us-ascii?Q?R+vgFJ8r2jAwU5dVq1kzKJ84bA5gd8MJ73X18nzLQnHXNIdlOwJLLEwrmAOm?=
 =?us-ascii?Q?VO4d9bcauBeUr2Qc91cpViAZV5DWco/mt1TI61UXbKYrEq8KX4qVerqTseAD?=
 =?us-ascii?Q?vbRj0X1o1ClHm7ctpBl7LRkWucLQTpzZe0/4rfLNTlgZ/DFUyRB21zkb+HTN?=
 =?us-ascii?Q?gQ9/OJDIf/+RIOs658gbbJ4MKUiBP+S+rZjxK+GRxutrsDAGwe4fCbJnFMjI?=
 =?us-ascii?Q?ACGUQ0W4h1+YHBgUpYK1at8WCYDmQRPpz+dk9KRx203BAGs7/YHExfLskjhq?=
 =?us-ascii?Q?v2sJ/J0AqVfpPW2J4k5Mkurrrm56rnxWPkFjQBeZz3X8F1ATxRastX8pGNMZ?=
 =?us-ascii?Q?ZvAHrAnJw7sLVd2emQzpuPytdi2S+0z3orifyW49kZNOdyRo6IVmocesk2H1?=
 =?us-ascii?Q?PoNNLUybIDIndq/5hX8POqDkHEzKUFTrAx8bfJcvoOxVhjhNCSqWN/6KSUbU?=
 =?us-ascii?Q?75Bz8Va2f5u+fqMj/CE5VtDMIOiR+eSuYUcrn3AI+SIVQHS4i8l1fY21FnVh?=
 =?us-ascii?Q?FA9+trdZ0+9kXXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6kokcqMidflR/QZeENA+dgPStxceZ2gxPqwPGK5s4GS4lnLKsCST/xknvrI2?=
 =?us-ascii?Q?t8ODj/HhsMJFK0YbnPpMwm65/VxwX9DjY1Culz4HvWFdvj19Efb1hM996fm8?=
 =?us-ascii?Q?PPR4OkS36si9LwMjICibGLG6RqSypmriFIWnh9wcvu83Ki61ItUyTvmT4gzx?=
 =?us-ascii?Q?zov9BSIXNH0EbYF8ggGh8KQ62Guf0JC9wxVmRd7q+IsnmMr3uKI6Ffzv54tx?=
 =?us-ascii?Q?2HiUTYC+d/vpR7sLbSvLE+tNWOuXEIj/l3VFc/ltW2nssfkh2VSFkYW1Cgw5?=
 =?us-ascii?Q?ZiFAJwar282HCzFkyzgG2XraspHEJNvbpUBYs0pSq2eU3Z20rKG+j9/FSRSZ?=
 =?us-ascii?Q?GZVdU62OgD4GK0uP7Airopvh7D9SBlkzcCSslpqx3W5L+YWmDMNLby1BlGs+?=
 =?us-ascii?Q?h0IE2IOJ4QDjyF3RqLSZSRAJEahSO5/FBWNSsq+ujmJD/C8X+2A/+x6FA7aK?=
 =?us-ascii?Q?vCrXx5suY/oa2/dXPP9kSAMFXGcO9zUyVEHofPNBRZqbblmmexHrSRjE8UU3?=
 =?us-ascii?Q?0gkPslvFfnyFWbgTaUVcdv4Nq6mvXa9fIURT48Ec4yiqzDAG/3gqmH+aTtAG?=
 =?us-ascii?Q?cP2MTXBpMXRHd4j7hioZShyrEgVMz2YFpLjiRfOwPVTn15PkupAfVb9aZWlx?=
 =?us-ascii?Q?lm/QlAYOzlbFQwtHIDPn+8/Lpg4oCw/ZdBllrZ4a/EqhAF8OIhG4Xp1JgDcv?=
 =?us-ascii?Q?WXGfJhaPzxNgMNrQLhP+RL5EBL6hzIE7/8YwWJTVdnSc8r3JTUcWVE0E3kZ8?=
 =?us-ascii?Q?+PAo4kYnZJrPxDqaqttApqAqaIYIM26wzuWe+4Xi4dfmeIWL+cTjRS2G4r21?=
 =?us-ascii?Q?P/C+P5dQCbjEgNBQk0xoUfTmVy6JiXINc53sm1dwsFUuU0fgO/ETEhgMna6O?=
 =?us-ascii?Q?Ke9e0GoOBnJFNRL0dZfo++qbitPpqRyj8zXA8bk7E0UU33sBJQkXL90kIEFY?=
 =?us-ascii?Q?n6pDn5WkMWN5pnCLOjARDjzmRvgCAL91KHLL0nRmuJjNfhpopgJfYte+K30C?=
 =?us-ascii?Q?7XG3ubhIhNdmKDetPcPrikcPcJUtmQipBJncP3Z/5/ikrfah556bm69RnxkZ?=
 =?us-ascii?Q?1wq+heJ9jrfPofJ0Kw7gsRPjSV2BJBBHcophHHxVHUGQDz0Qmf0iyGLolm53?=
 =?us-ascii?Q?UBAzHWCkYm4fOIGQD/SZ58KpikhqR94/W4ZAGc03CoS64GqKkHRdKAI/4I9m?=
 =?us-ascii?Q?pypfwUctzdeSoMIAayfcdJtOpDgF6SFIOWusx5v8f9PqqewHzZqTdU63koAm?=
 =?us-ascii?Q?Udd5CXEfHCgZLBqKQvm0qspDFNuwc/B4fxH5DViVxXi+RtNTa82HfD30GL+1?=
 =?us-ascii?Q?inHlpyc7vTBBTs2n6jiHS4tAMoi8aVAXJoasfocn0bMklu4nJZshm2r3EXfo?=
 =?us-ascii?Q?hG9jOzgJ8468gLYmoqhsUIIfvhFQ/YEwJirSq8tQBY1tlzvnKLXs7BRMWqkR?=
 =?us-ascii?Q?fLhA2EjnAhV22HNVRO0iyt615hy1yjOwdx3AvCRign+cpvn6gAjn1HjH2/XR?=
 =?us-ascii?Q?Joc4ip69xUXRICBM7RVD87vjhh8egcsAxFUWnmeFje/F+CRzGc2NXX/1AcCF?=
 =?us-ascii?Q?lir95APWHi/1SeXcnCA+4fFSTkJwIv4t46KqrBjV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0079ac-0ce3-406d-e6de-08ddf6633c49
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 03:27:03.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyUHFglbi9RMZfRIg/MfU6TS8pXSYk6ql3p+jGr6O5Ad78eMMBDKhzJc+i73QbAf5YIQsuyCgU/G45E0dc9syw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7317

i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
other from off chip crystal oscillator. The "extref" clock refers to a
reference clock from an external crystal oscillator.

Add external reference clock input mode support for i.MX95 PCIes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf..e2ca8b036253 100644
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
@@ -1606,7 +1608,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct imx_pcie *imx_pcie;
 	struct device_node *np;
 	struct device_node *node = dev->of_node;
-	int ret, domain;
+	int i, ret, domain;
 	u16 val;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
@@ -1657,6 +1659,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (imx_pcie->num_clks < 0)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
+	imx_pcie->enable_ext_refclk = false;
+	for (i = 0; i < imx_pcie->num_clks; i++)
+		if (strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
+			imx_pcie->enable_ext_refclk = true;
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
 		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
-- 
2.37.1


