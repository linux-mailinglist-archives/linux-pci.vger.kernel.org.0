Return-Path: <linux-pci+bounces-15781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488539B8B9A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBC31C215B9
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 06:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376481547EF;
	Fri,  1 Nov 2024 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A31lf1BW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE40153BEE;
	Fri,  1 Nov 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444216; cv=fail; b=CtVyC3c2afwp/5Q1HdNy2O8DR6Ts40lLakyzzw88udjTuRxGfvjHCGieeX8re26SluNv13mf9MiRLztLHFC0XLTmm1Pxno2+h1tDOg8mjGZDtUjw0i/BDiB+pcRTEBcPYppHUHedSYvStDOlCLC9H4EJ//tO16Pntg5mbukjOnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444216; c=relaxed/simple;
	bh=aizUm8BBxbxzDGQX4YYQ64tefL+iJzXnjbwL3Bj+4Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RHBzC+8UsVM5oiYUajSrRjNCoAJ5dVGO+KgBuHzRlnG++pQvnLpoyRr5zRQlI3GpwGfAv0FlLxoFYYgd8FFBy+8e4hxEiIRSoUEpFcLlFQPPU1veaq8xnlNQoydElqjHfqUdpPd38jab9tK+q7zHP/RzT7o2ezNrVP8ARx0sb7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A31lf1BW; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpbgjnhMbkl92/DSzv3Hgj+LU5ufFDDIOFbFKmsO9R868V0rABftHguyFbw6pBVsR+FI0UVSd8hYBl0juCHRqi4m/ensB4Mt0vAz9UXCNHhB23Jdg/efI6hQ/IRz8WzUGBZpbbjsWGY/k0BlQTewmYo68FKdQ0CGu9Ya1ONapUMHbkQoeRnXSIIZquQMv0Fz225CoZzwPjTmuIziqT8FKFKtMIqq9TTiQ9TA92KVHE/LfcJQ5c61Q8ulxTfIPEQEbw6sOCxX9zi3eWnW0WjlHStfzr0yWDrn3DYu+Tll19nOlVJkTJBXLjZeRJiH3dVaFFm3MjxurG0Ii+gTdX0aKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOQB8+lxpRTrRQGURLleiexkZvVL/ygVuQk9OtCL3Fw=;
 b=CKx57XQvYKeOWXtrdKofmRv8otuP/ULYcEu4/IA4rvxCBunRnSIw3P6x46qILB9nw93HuLJdPakuFbbUOm091Sz+YFGAunA0oqJ1MNyKH2YATf/FP2T24K2MczHtyC64KihQxkCjZghjcwVJSps3hWhF++wMeMNzbJH1jixgF8EjL0kx+wBpzOkEbTB7XGumPP+q8PGQk9MdocDYganEU0haqkTNpB+4C1wNL6R96pfqD1iPMab7HH3PfP/6SaNEB6Gu3yM1qnzgHLvwiOzvB4dUfoE6oGIUIltUN83QRU5V7iadshQb79sR4BLKj2MkJbPfZRdggbDpikOU34Zjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOQB8+lxpRTrRQGURLleiexkZvVL/ygVuQk9OtCL3Fw=;
 b=A31lf1BWd/OnYthtCz17OShE8HaQiFKSIl2m4XkBgL3XWGcZ3Rpg5Q8zqPQAsmI5yPLzYN/l0O3qh8EduY7s51NZuOLW/BDiAp4dri8nwHS8n0t9bnelDoakZQZ/goPfjrlir4xdM2xDR/EUeX3xVd2o89EiFJmXPuE+SLUAIAuXUQipa8CnngcPnDmPFOyvHcvfT5rtZljUsDinZjnztaJQnCQJtmx0QMXMbpw2UnbzOttbe1uggdhtXQ7AFkPAZORmuGKuVQgAE6svnhywK1Iy5DnDwSJEOLEklTq/afh9B/I6iglG5+5ke0MdJkFiLAaT+w/pCGlma21dVBwOSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 06:56:49 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 06:56:49 +0000
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
Subject: [PATCH v6 07/10] PCI: imx6: Clean up codes by removing imx7d_pcie_init_phy()
Date: Fri,  1 Nov 2024 15:06:07 +0800
Message-Id: <20241101070610.1267391-8-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ceddce-c3e6-4a91-830b-08dcfa425bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qHEJRSD/qN8SUA2XXG1ePM7MMDc0U8q9IzVNpP+ZtdERzOFRsmTSKkx4NzWv?=
 =?us-ascii?Q?nRtu7NjVEaoCutuIamX6DbmoP1cTvOFAb2Z0U/e6O8o8ScO1bSDmMV8dX7pL?=
 =?us-ascii?Q?0T6/SMin+5R61vWZeiplgKItCYOo+3hzS0J/YNlwNFAolsdMArNLXWjWgx89?=
 =?us-ascii?Q?D9oJ6PJtOHZLq6vNv2Q/+jI7Q8DoDtjcOyFZokghYgzOvbljYfWiC9tWSz71?=
 =?us-ascii?Q?+qAx2LFfSArpjsjrJ31srCUH/foK8qd/erPp5x8Imo1+HQPR7FSmolQpOssw?=
 =?us-ascii?Q?RWxoktEJD2JgA7v04jKAxHd2KDBq6TkB3ySl78Jl4xumgf9jLphnYfxhlktn?=
 =?us-ascii?Q?t488e7VzUBWvsy4gUQV5XfWFRMAam/ECZo2oHpAjLTuePb4r1W4VYSmgzvYT?=
 =?us-ascii?Q?sUimFIL9IgCf85PkXcJmaOEsjODrPay2ePN1LVR30vd0jG5kpC+SdCrBEa0U?=
 =?us-ascii?Q?j+coe9S0zbdjYNC2WxZ2YVvTVq7C0Bk6al8Yl4f2GGdK9p+ZDogA1925JCj2?=
 =?us-ascii?Q?GQJqj9CrPGOvDoKcJZ5hvxODvuJpZaHmlZpInPN9KANZWy5T2Dnf0/RncV24?=
 =?us-ascii?Q?ToeHXE3U5+Q6Ip78KmifhQZZmJgaGdEdf7EvOntekYP3n3N+7jieHnYg50GY?=
 =?us-ascii?Q?TJ57rm0+84RrxVTi0ML+0i93RvzDPUuq0jGMfbPBxGJSMcYQR8ywTDnuYKcb?=
 =?us-ascii?Q?xDGeFZIHpPjYXYWlSgBEl6M4sde1eZCeeUTa4SSppDpBx8Y8NRFKy3cPaD0f?=
 =?us-ascii?Q?Z6AI4yovi4mN52sKAdKAt78efcbKctUNpkwXL+edE2fqlg7Fs4IOhfQClO0J?=
 =?us-ascii?Q?n9H+mVtcy54w8jd8mJO/6YvNRDjUeg9+7JPzyMYir7F/teHsT8ivNubo+EkM?=
 =?us-ascii?Q?3ptx52M53d977ykN8V+oKYff+NFP55pNQQ60oq5ZlTweru2E3g6oDs73CD3F?=
 =?us-ascii?Q?TxCuhDTQpkNrXy3O/54Q7FAVMXU2PVjc5XJzgr5RBvN5VB5Am2z29hSHt+fo?=
 =?us-ascii?Q?V8q1svM2q28sISJBwQlXEDCRNlgS/QqVndXjvL0KgCQVeBFPhSa69jTyiCIz?=
 =?us-ascii?Q?SpX3QcgyW3R5Mohj2b/FrhjFCGsGJ67xkzFUcK74XoTftHSUVSZiWOx5lWiZ?=
 =?us-ascii?Q?kZAu1ncSXI8tlbFOi4dr5OIh8jFkbIcNhEPBAmiLO8Ag0DjHpLOURDNt3nwV?=
 =?us-ascii?Q?zzF8zZNQwsgpib97ni+ImFKXr/XjaJfNNHRjGZox56vcropbsJlnJix/zT9z?=
 =?us-ascii?Q?PgiidxeM+SSmFiTDxp6iGtH4hmrkyPwjgiI2tqmjXJCIWWKofAY97zw6Ouax?=
 =?us-ascii?Q?WYk83WfXJmAEB67EkoiBI141T4f953+b5N0ahF2aNh8XhG2JYomMAGQMFeb8?=
 =?us-ascii?Q?dqBcGXUOIjB5Qqq6fPzX4L4M7LS0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7KdAejRPsMlA/AAAcpa/fSMznB7rdlc+9PnW/Z42sz7IMvoqg0HbALpHKjPe?=
 =?us-ascii?Q?bDpWODqCR3KZ2PiqJadIN3mYkfN23ymfno4O/gFXUvrrN+GauREEkSNcTsEf?=
 =?us-ascii?Q?o91Ze7hNIl3gRQLbjp8XYRCy30+BHmSIAejhWhnDYZbzc2y2qlJ9JEwfvm5N?=
 =?us-ascii?Q?sjk6KEA9z0yricMW2OS4XZPkgK68vFHkDNDo5FTupHY08ayRZA39Iw2DCws2?=
 =?us-ascii?Q?HDIJICOfT2oz4ks113awvdeHN2VGtJVBh9LFgJKXJFfP0aRTsBW+Px4Tbuve?=
 =?us-ascii?Q?xy17uG88EQqacWUufoeaTPwTfdZKeN5DR4UjP08A9j0XjqTN9VaXikM7n4nz?=
 =?us-ascii?Q?ynhRGOSTifa10QL5RTmmty79N4xPU1DaD8X5+lB2ACjNfHYfpeBFSPkLoVSM?=
 =?us-ascii?Q?YiolFlaIAizRtMHjFzshZvO1BpGpli3QbF/ROoXICV8A0UKduxzLieFBef67?=
 =?us-ascii?Q?xQ5d5nVBAsTiZDmujXUNQNi+5GSG1ubdPjpoBGPcR3BvxleFSy/z1kk5VUZY?=
 =?us-ascii?Q?9zBXwldc4q1kRaZUuSLwevRSVQkoq0QTP2cWH00DL7HAEM/AAgC2Jc7aDa6n?=
 =?us-ascii?Q?7rXM3J3bfn1pzMg4fCnF9gN9sXJAE3EKKTSztBpxuXmUgyhu7JWIDELQENoI?=
 =?us-ascii?Q?D5fHdWpgZp7eqj+Toafpx1JE13Q/rsBv+V7I6uRUsNA3kH2ZZQ/EOB4NaMuh?=
 =?us-ascii?Q?jO2u4kLnbzb972X6JgGn0N8CB2wAB6IUj9MOpj96BVfDmwXb6rAsT/M+UZKD?=
 =?us-ascii?Q?c4EB+noiS5n4LhewPKNtWW2o4/Vb1Tu9oIVS+fQcEa0lY7cuHr4Pw1wKAvCa?=
 =?us-ascii?Q?wRPhHtJD6EtPcuz2dEzEbh831za40gvuwij6YO7swcO4IaqKlfR8TeZ5MEz+?=
 =?us-ascii?Q?4OQ4jsCF7XNUcuAPi+QPrI40VR/Sj/LhzjL5lTdeN7DSCpFCtL99QozXQYDm?=
 =?us-ascii?Q?MhsoQaNEmpzRUWNuXznutOa3f77mlujVaQyQ54azg2BRd9TDuJbdLEmp5gPh?=
 =?us-ascii?Q?kg9VS1FsAGjUHLa7bcuQVGjeDci+/V7StEPPfXe+wCYvHEuIRO2XfduwPk69?=
 =?us-ascii?Q?6GFevLP2HWzBv97laO1Xl2IcXiXYU2+vJpzyjCZvSAuIRfo31iHXRdQsQFni?=
 =?us-ascii?Q?VTW0WSlUPgMcfYOOTVuvVE57yXOuleoR+olDn3HBs3qwhXOJ8rPR2RuSZJWV?=
 =?us-ascii?Q?/njOOacL8VESCPgeL7tRCLVMmoKXD5DXickEEMdzTiSdihpqE3ww17dSodCb?=
 =?us-ascii?Q?NWfWBAvQb/KHXXFd1CTyBa04HsBV5WzKlFkroIfDm4nB6XBje92XqVAla3C0?=
 =?us-ascii?Q?CVmogboE61tptC2OXdixv9tAaEdv0DCu8A+XH9FYiIRoHAG0L2oiuZD5TmNm?=
 =?us-ascii?Q?2Se0tU3ZgD5sx34JMmYBxfRNsx1Wsv74qA6zVWHi43xiIPNCy7/cMq/jepSf?=
 =?us-ascii?Q?KAOoI2HaGoM9g4kLJq09ktrFKpIjItEqca1HPdBm2YolOufdku8tv/I2p84E?=
 =?us-ascii?Q?fRum9grRsQVZ1P8lnUMdLO8qDuvwrolANCqPLWhUgt3J2cvYReva7nGf7dZ0?=
 =?us-ascii?Q?8Vy28odwYHwyv7EIl394GjF8a9gZUaCydzlrAHBs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ceddce-c3e6-4a91-830b-08dcfa425bb1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:56:49.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVyBOwNdkaMZ1IvEiDC4OLJfelrBvMP04MElKlBQQhMvix0CsXaiMmAUzJpz4k/Nm1W9cEx1pwLP00FKUvc7nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

Remove the duplicate imx7d_pcie_init_phy() function as it is the same as
imx7d_pcie_enable_ref_clk().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bb130c84c016..fde2f4eaf804 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -390,13 +390,6 @@ static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
 	return 0;
 }
 
-static int imx7d_pcie_init_phy(struct imx_pcie *imx_pcie)
-{
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
-
-	return 0;
-}
-
 static int imx_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -1526,7 +1519,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
-		.init_phy = imx7d_pcie_init_phy,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 		.core_reset = imx7d_pcie_core_reset,
 	},
-- 
2.37.1


