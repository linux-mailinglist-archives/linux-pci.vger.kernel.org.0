Return-Path: <linux-pci+bounces-30014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376A1ADE4D9
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 09:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C741D7A95FC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358FD27F004;
	Wed, 18 Jun 2025 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ehvwb1UZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5B27EFE7;
	Wed, 18 Jun 2025 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750233052; cv=fail; b=FIUQy6YTxvvLT2qb99yf2kG3+FcJkz7/RvIj3PhRcPtqUYNaaMfRyyv7QjMmguxgptzsjYYIPL8lJvPHW/J3AEQQoLa5Fogkmw15P7FpusXrwSNHDubP+eiJPzFYLf4OGOkcN7ogDT3Ss8ck7JADi4b23CGqLIhO4xFndyRouBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750233052; c=relaxed/simple;
	bh=dwMYXC52XdpA8Gk+zD2yXPJol+bjMyN2fcaQUqm2w4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dxdl8111YYcRQQWlR9VppUmnJh3z16MMdUKeNbpTw7uvCb8Aw9UpKaTKe5s9v0WQwfLXUpYIz9Zwjbna2taFcc1O9zmF8xBPuxpKPgPzXADtPFy/bNma2xHQwn9ceE6Lyn2gvKGdt6HwayezLnjHdDAq0PgowsU5yKf+4RcMg9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ehvwb1UZ; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3qDa8oHzm4TGNyJVBEfla04OMsapK7fa5gjJmNeU/6Yhh+crgz8iuKByOx6A+EUU+hhLGnCOcqhh45zXHtLKkX3aoLXVTkRsXekNWoKa9HTl1dKWXXeQDmNkM1JnQfJzDtMJuu4ZXkHt2fD6XwMrhUpqkKbxanv7XPb20Z5VQX85w2odglgB5BiPEq7w11juW+lYvBorSSuh7g8iomBsqJ0O2ID4fMSGe2Imxm0GRzZJAf0YKWeXcamEdTEg1u6ivqPYFwnrag5Fs1iUDIbhquD8n1jr/giw2+UCdFYz3inZaDrVE72L1E9mxQDZgRKYnfJNPAZ8LDj9lfHIJhZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZS0tvudNEmwyCBSU6jLQjNGU7MlIiMDOIiK7hPlw58=;
 b=BAzdDgN2ILArOUa4sChh21EVBnfchbfClpZWv/Zvp4pH35AcAee0wIheNKbsIFGr+lxf6KNeq4JhPwpPhoNTEx7gty7meZmfrQseMgrpc8eJAiW5STjKIUuu/uNgT7CEGLZNnkprZDh3DI2G0iEDEFk0zjjL0tDNZWhfG4e5bhdcQCWNqrcaHaZTR1vFpRfw6uSTibKDsm4BkELXb7pKwwHiuQA9DCcV6GS51ip2dYw5Qkfr8C1d1b3YWeLjB6QEMMZjbDQ5m+1gL4ueTcyFG4n3rFdlAOjdDQlmYXhuZFShbCRI3wFljk4zykTcuyAgCFqzDjSnILSGvT6MPDfy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZS0tvudNEmwyCBSU6jLQjNGU7MlIiMDOIiK7hPlw58=;
 b=ehvwb1UZW/rXEOBybfCM8QyChlIzbL9H9pWObKyvZ5OV3awjzmsYLaI3UDqhxglA8K3jxxUR6MeShcge8tRcsJw1so5+WOQCzrsb/PT2nEdPCOMo6UK6XAEkCD6JskUKGtKSEnLg/n1+rZACoVYkahJxeIVR/NBNpkfYxIEh3SvOs+3MQ6xqCd9jsD/b5+Ddf2a1rxjeNWWQQajq1n+4pNSnDZlkFaPQp2SsPBqaQ1ZngTTm0caAiUxnmufNolxIBwiFPb4RE4ZApcFzHySJNphTpHEsnOWQVigHZ76T1erGjGD5hXewFsQqYHyfzXV04pC/w4TArp1amY8+sISx/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI2PR04MB10980.eurprd04.prod.outlook.com (2603:10a6:800:274::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 07:50:47 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:50:47 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 2/2] PCI: imx6: Add external reference clock mode support
Date: Wed, 18 Jun 2025 15:48:48 +0800
Message-Id: <20250618074848.3898532-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250618074848.3898532-1-hongxing.zhu@nxp.com>
References: <20250618074848.3898532-1-hongxing.zhu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI2PR04MB10980:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0c1a59-d0c4-4db9-2778-08ddae3cd615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mJ/xahf1WBNsKw2BUhcnN6AoCSCEnBkRUgb0wqy8sAuGBY4Pb3z00a3eJEsY?=
 =?us-ascii?Q?NYvr/4fn9P9EFaJL7/D/kqXZVvI4i9r9dN07jyWy5bqn16SnyRxZXhx3QCLl?=
 =?us-ascii?Q?PSZGbHKNMKcYG6o3V8U6/UtNIWVJN0LvgULxX7oMlAL1bWz8VLserY/USCc4?=
 =?us-ascii?Q?RaSTjpQQToOnyhCxW60GEC5WJ/MEv5mXYRegytaXeG4XZjdrbaazc5Di7KOb?=
 =?us-ascii?Q?kPwoIdZ2Ph0dF6bcGB/T1w/kcnlBu5+AqhpsvznDAyh3wTKxMC6nEEpbK55G?=
 =?us-ascii?Q?4zioOf2maW/fik8BFatAOIQUJ0XIe6vX8reDEOX/TOiFGv+aTTCF81aJl1Fp?=
 =?us-ascii?Q?k853HzHkS92kJQHPQo3aXuOQc3a3fgSCdRM4oXBLLa31z7p9jYXi9IfjPHGg?=
 =?us-ascii?Q?KdFMCcJ0f8f3qFkrNQmdoMI9s6wLp1NnG9BL0MOBe1fm3LIwQ1dXLGidn4Uk?=
 =?us-ascii?Q?7SNK0uaDLjJPSaAHmPk43sENjZmqbsWZKBlesMBFSBTqhVYTFOrT/YorLCyn?=
 =?us-ascii?Q?FOBO7q7q4RHfNzEOOMZSCynRnIn/M7mOi+8Mn3RWVEAZ6hROVUDQIKfHuF9T?=
 =?us-ascii?Q?6pMoOQvTRBulES2iUXcKwkg62cv6t7O95bl6kOy4evlOPfEzzeJMcClVZpGB?=
 =?us-ascii?Q?0cevRm+ch79xNEJF27/NaeuwevSeTwxXY7cf9N2gE1gsRZmxrjP6uW4vf2IM?=
 =?us-ascii?Q?XK9l/n6OdKeTbrh6Ukt5gYhI4MkzDi7iWNEL1gaARGCQRiQvntgFKY97cbU7?=
 =?us-ascii?Q?9rk89SYf//nSvGwqxiW9kLW/ePt074CQsS9tfET50HdYdrBteIP7B0R0vo1C?=
 =?us-ascii?Q?DVoSTE4FX3x/R0FXw+9r4ysCqsk5Di8UcIzAp4hbA0PDV7y9P1ZyFEiwyHyn?=
 =?us-ascii?Q?0o6dOBRmmnquzqz1OmkoAsn0RZm8o4sbDadFH6l5ALfLj+sU6AkLaqKfkxdX?=
 =?us-ascii?Q?QkBBII+whZKCgQeiLCHwGX8lZiKKvDHFFufdfJgI7fpFqgIlrc1T3HitYfKr?=
 =?us-ascii?Q?3fIXDyPOKiSDcFSWFkQE5/ZeelTsQT8C0H1BNOm1IUl1uoI1FczIWMeBw492?=
 =?us-ascii?Q?f+KWsiyfPW/mMwVCyFVakAVtO+AqpcNg3K6L43LiKwTy59eZQ6i9Bnx+0tPN?=
 =?us-ascii?Q?kkIQl/+a/aK7ywbstc4XyLM8np9eX8gYThtWyawrBQZn+bAvFoWhDFJA2Wbh?=
 =?us-ascii?Q?2RtNmJU3bNObcmWQoni+aX8qKkr8a/aaBPE35oUzXxY5jf94X+hk+U/wEMWe?=
 =?us-ascii?Q?ZhoEfNsEXjtgvPV3MAGbAtDXAIg7G5IOYye+rX1JoUXL2fjZsaXw+Cf1P2Pd?=
 =?us-ascii?Q?uW5m+OW4yM6u0Qoda2zFXJCzNeXuSWQWwf6b2BPSf49fF1rJl6FQ+jjeOMrn?=
 =?us-ascii?Q?/zpLoohSd9EvROFSNcNhTrqiN10kZFWUxyweQcgsvmos3abA8bH9ybBIVIna?=
 =?us-ascii?Q?Y3N4oZF4eXWURsN+KnfiXi+HYjMRE3HaeOsjMxbXqwNojIeF18Zf/ozy+04W?=
 =?us-ascii?Q?qd5VIVqrq5UCI9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/MS4SI9rBRDO0Cs/PqNtOVJCPvg6WrGuSlST7ZesSFgn+7fvQx7i8VmZT/Q9?=
 =?us-ascii?Q?k3W1yzfFYBrS6+j8o7ufYZL3KmwcmOptYAhH/0qaHKWf6J0Ntp05qDyLR3c/?=
 =?us-ascii?Q?mZwZMnMZhPT+kT6guG07dXstEq10UI/MBZnbw1VC/ZOWxAKruM57F7MXtpv5?=
 =?us-ascii?Q?ASf0Nvgw+PRe8MsdHgtSTh8P51dhoQR+a+Kky6ZSlIY2E1aouj7ttZEkKvbt?=
 =?us-ascii?Q?qxLmCCvDxNfgu8Ln76HurOZgMXT6aVpo5VJpZfqtImBh8hC/DgY3v+hQ78Tp?=
 =?us-ascii?Q?z+VjWQI9Jc1cC1QSO7gfmA8aHkIr/I1bxQzIp3Mmx61DgNi6QhkUU03FLfdR?=
 =?us-ascii?Q?InGaoqyxPtTweEFe9pyYFEZZV1tyvYn24t/H7FtKmqE/vyN6mPHugW8YBikT?=
 =?us-ascii?Q?dh43ycB8AUB8toKqtN5PhbriUH/Wb414Pt5zu85DRfr+Xpm5+LcSeL4kbCri?=
 =?us-ascii?Q?ojK1OYAlKSln6EPvsOIBGcFnwGtizaJZQJcPlYOTa9nYelXn9pIAX8PwIvI3?=
 =?us-ascii?Q?uqsUxAedzrcudWMhjjcjxFi3hA0MxxBtCW/EU50rb63hnPJH2fKp7QfgzevS?=
 =?us-ascii?Q?R/zWD/YVRcHg2ASJxlVKKGo+JayBk/fDGKG11q7Pn878jsYx/TOuJPgIZAYX?=
 =?us-ascii?Q?dALnQPOfBXNERkcriDGlh7HJD/6SGoJgQ3WylstYsk7CJ2FdW4biMeHkQL1J?=
 =?us-ascii?Q?QwzDXwGJkZi7M6s0fYfFqrNUWLSr5FXi/rANbJiM0KT+s6pcFgGBpw02oYxd?=
 =?us-ascii?Q?jtMXT/oXreZm9/nh338eel3tpywg9bpd+3MJH0fsGnyYZJ1/Go8fmw2Buvc3?=
 =?us-ascii?Q?gpImVlELXZqum87aFrpwZ9sbQUN+gZWMe/HyD6f98rHmunFIt5PAZvFYkRvZ?=
 =?us-ascii?Q?m0Z+JtB6guM3L0GXPg/s0SB8JsB8FI9p1966aP7NIstub0z9jbDZGrvT3dUq?=
 =?us-ascii?Q?2zl4Xhyb0rP6JkcKkFtMZY5Jtd0gBc2SqbQRz61Rmaeh94KymJL4gtnYEHWT?=
 =?us-ascii?Q?Lelw6rpNThYTM2+cRGGHpt7Fdys5jk94KwE9ATPnYlcyjv8Gf/BDrah6PswG?=
 =?us-ascii?Q?5glkJQdA8WyVcRvXslPUeBQ+pv4UK3FFKlVW3w9JTcU/4dtrcWzhZTGQrHjd?=
 =?us-ascii?Q?ekWcCx/v5wMowMCMieKgcquq0L2IPUg3aNzInZ0zGkK+StlzDZDDgSqYuEvb?=
 =?us-ascii?Q?Zd2fZX7iElFhAG85do76rOayp9gzGLRpAcnRbsva4yC22xF6BY1wp6gHhFkj?=
 =?us-ascii?Q?Mf/8WZ5b2VJZ5E45ucWr1CR/VZvdsk/fnZwdLvYHzPv0KmxxZMugpsw6bllO?=
 =?us-ascii?Q?yLUyM1NzrDDqAkAXd29+0liBh3fdTKb8DR6SqPJuxZFUhd6VYkoMPP6+y8n0?=
 =?us-ascii?Q?NwntlpXghHbmuTPTzQDF3PgmtF2yVcSWo7z4pY6JeSkoCcBm4T+5ymxH5tEG?=
 =?us-ascii?Q?jEecbx1jk/+y6gH9mHIhB+vXwKpvGl+RADdiN5COqSkcv5R7/kOh8hawvhTg?=
 =?us-ascii?Q?EJxzjRrFzcMEBZTN7n2SQeT1mvkA5QVoSZtgOpn5MBgH2x6s5S9AvXE545eu?=
 =?us-ascii?Q?Teb4hjvZtGJlJiN/0O2U0V/G79wwCbSOGqd/cN+m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0c1a59-d0c4-4db9-2778-08ddae3cd615
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:50:47.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkTvlCLGUNBjiojYjyI1sfm6FR5FaU3r2KSIVkH/YGo/a5wdkz3yHeiIQAP7iHvgRo4133qkebx2OfVCKd47UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10980

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


