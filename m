Return-Path: <linux-pci+bounces-25980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF85AA8B014
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1B97ADFD6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 06:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9873022D4E6;
	Wed, 16 Apr 2025 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YNpONHx9"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2822FF30;
	Wed, 16 Apr 2025 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783789; cv=fail; b=C+kuIcR++/HIcm0ia6/kjpOvcoh0rl45G5w0/TSu70ABmvm7XgBb1NCYWUuadcVQ+I2LNm/quIvGp/lL8WNehiprjRnldSfFTWpcnl+uq3ha37FMW2e3RlvfWpAmK1UkMjcbrmFbYiWBRcMWuQU2tBUNnNPcN7vJ/cfsEYecG/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783789; c=relaxed/simple;
	bh=4CIjgItRseUrafBnGXNZaQegYkLZQBw6fsBMX1uKC2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kKXTBu2RO3e4HDiaDUnCG+6pHonw7Ven3tgPa4KFT/q+bMwyLlGKZs2PHU1uYZHeVQgk/Muc2eMr0gU1n9DkwJ3EvjdXw0Fq/sRCN1Ck7P2nxc0t6MvEO8Z464X9V4BMzdGVcZwFKrjUwHrb1ubBPvnROyJxWVuiOSkjpSQrsDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YNpONHx9; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRvZMwd1Ss/CWtmF6OShp2J8ONReOFVKEIyEFbHdKuPuxe7BKe2f8hLccBrzIZXvWYOrnmoBInXc8H4xD1YUL6ZmDoq3hUTyzhWwHfwET+JA7GHS1CYH6Mc8+rgYlqWxns5DvfELtfjq1Y3iL6Ueym/Es84BC3HAHAAQnVaafZTSRz3Bgxd2maMs9Oyi8cYArWQE5Lu9yA+EVjaLVle5k9gyYz/vpkn/YS1uZcib36xkxm4uzSkZ1+uJ+9MCFZbMmXBHRk1oNez8CB68g5VEbSTpVwVyHp34IrBsMg72bNVECE9vm3seMCLbj8A//IS0LBc6ZipCrLylsynI7RfDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mi6mKBl9wSEkHCFGJZSabU9nI902sgwAi74QsJHvFMQ=;
 b=HInzjtFOocruBPdeH1rXD/rjTHjEi5OBoCGqlWTtAw4JW/pB0svbO8v90Pn75jU2UxlmcPp3C5rA0pQRspqIdIOCbz5KSlIQhuhtH7Fhp6T/bcIvj7jfH7geyyhsxJ/pnvhJZhVd9YMYiO+bAJ4FkSHg7+UHi/2F4elN2ZQ9vFx9YI2k9/bhtBqw/qPi+EjZ47l9TN6apjMRbtW2eNGtCuP4oC83hk/XTm6cGCgiqMjWb56JX4796UzlstDlWx4UjvQ9MM+YQPmXSCtgmo4lrHCCEgWeLcveRA9vJnA/okBgkV7AAUms/OkKM1AoOTQ/lj538Jw4xfMEG8u58xYuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi6mKBl9wSEkHCFGJZSabU9nI902sgwAi74QsJHvFMQ=;
 b=YNpONHx9IEAveINxTge+GG4diuUWPjY41EsE+nEOrHVLMtjLnaws2vxyrnOl2sPAZhsz6aw0x4WyID9ROCrP71mpAxI2rvWibppQWoby/03WKm3/sVERZXeXuh8xtkBx3Be8nM+CeEXWtT0ur6XcLzAqTBKhH2dc9rZcFcLRcZdpj8SA4r8zxBWmp2y8LLoTD8A9kkMQ/7Dy/XGYGgmu240S6NTR8ZB5vec1lTr+Gh0gzcjfsE3vmFg5JfcyHs06pbYNrbWt/UkIZKlF2jR+8vpZCLr3z38GJqR7elUxYKtEAbBRUD2HYnp0ouf86Wh372CXRC78zOXj6pO/Ck+Q5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 06:09:45 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 06:09:45 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 7/7] PCI: imx6: Save and restore the LUT setting for i.MX95 PCIe
Date: Wed, 16 Apr 2025 14:06:48 +0800
Message-Id: <20250416060648.3628972-8-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
References: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c79305-2be6-450d-4761-08dd7cad48b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l47+hq48nyqzixWCZYmbOUn4tFjYVJrzJD6EGwoCe+LpJpz9f9/TpZv2W61J?=
 =?us-ascii?Q?wAwQ5PNzEMQgAiQfSsFYGr4tj2qMHTWEEH43RwCGytWSmoMde/Z2qnZH9vUB?=
 =?us-ascii?Q?z0u+ACjoSnWjrANqJmFLGsl4QuZ5ZSzkiXSCLPBM0KtNzSvF5QOuMMbK5PEV?=
 =?us-ascii?Q?6OhU1VFccC35TvWDgj/HcgQSrboOwZD4V4grNx4mgai1tZ5T90PE5WRJKNB3?=
 =?us-ascii?Q?cLn4714bmhI7Mi29aH9bZKpjFSK3vmYH0ocDYklMVDYPVrYV55wxL47+i8Bf?=
 =?us-ascii?Q?+PJkIqjpjTP2sh5DvJ9I4kaMjrWykCdUCY8KzXeNRB3M9QBV8o7dfRje8bjO?=
 =?us-ascii?Q?HUzqLoaFnDqcatZfy9LY4h2q5kTh/OB7vJyjTX5aUFGj9ptU3Y/i+mppM8LI?=
 =?us-ascii?Q?f6sTYGmvQDHahJaIpMmI5ZhcUBrYo3RypFh5xXCy8jtd2rOC/rCVwPM3CgBl?=
 =?us-ascii?Q?qZ3kBKpP1LHxctpr2YhdUdvIwUt7OArCIsfvnbIG9xMlaNq7liGrJZrtD9jN?=
 =?us-ascii?Q?FTy2Bn5fRX/JFhZ0TafSBZNng+L3v3xDBd6gsUAj6x/WzYolcwK4RS4GitcJ?=
 =?us-ascii?Q?1fDgHy5l+DcYsImARYoKti+hgFPataTNAA//8c//EF+DPoP2h0V/e96XJjAJ?=
 =?us-ascii?Q?slXE+vqd7s0DfRM7yUPuMPK4VlwsmkKuinuyxjWnCnhakLFvDXX+h27vHBV6?=
 =?us-ascii?Q?/1ANQS+powt49I21mU+UNgNlFo3jfKTXRKn0z6sxCtunMsiaOUv0zdqhM6oH?=
 =?us-ascii?Q?/w5cg3PUw4/hw8azA5tTU0X2TuZ2MpFCZ1cSktlB9A8pb5BLQQaOuKXYpLoK?=
 =?us-ascii?Q?2/AvKQc0MBC4YxnTBeFfkbA/O+P7O5hkNQ+2l8AT6aCGYm8on++HI7we0XIt?=
 =?us-ascii?Q?SPOR2NKhoTwO/woRPd3oTGq+sOOtuMn5i+jQSNe3FSSCY97T3honN/L37pcR?=
 =?us-ascii?Q?abcXPYtngd/CWKQSeABlJMgGq6qNwBkEyKOcnP2/D026PzJFJ3cQ75IbQSj6?=
 =?us-ascii?Q?mrX2JUCVaz3ofgK+azwZBg9FQQfy6oWlLWYGwTeOWgw22WxKow9TDdq6l2uW?=
 =?us-ascii?Q?B7/zTtAsWAszJXRa0xNXXDbU+7I63wxVdVcLlE1syk8ovTBHh6wiwF9/ywC6?=
 =?us-ascii?Q?tBocriIrE1RwG5hNbf7RBu8ymXO/exZq9MVd7HKx36ZH9C+nx2rxCJGbxznx?=
 =?us-ascii?Q?K+VCqjnbzn5t5DOJrUHoiptS7hR1oVNJGaXq3qj7wyeDdOPAMMQN0vT4Udqs?=
 =?us-ascii?Q?6cN9AYP0Q71xV/p3FJAT0DEaH2nZ7AueVZqt8dN1cSz2U35cHiewGf+gfQ+a?=
 =?us-ascii?Q?LkhJdvqygciwkkRfcVU1bZuwplV7oCYOMIV1CIsj+u5ByguDH3QYqAYilB0i?=
 =?us-ascii?Q?YYG3f3h/5ogJXjnYKrYZXQdbvbVNYXZNYZHUisf8SwFF4W+wCDue4O97myeu?=
 =?us-ascii?Q?P4k5iEOZ1h/OTw+kfpxG6VlBHLzqavMbnbXTVRsa5+QG2LUrmfDUUD7WC318?=
 =?us-ascii?Q?uYLyOXuFXATCZSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZXLuLTvW1FMaVuuXynjvEyFr7khXwyBbsRAzwXQY6G0jHBAtP5MNYqY11Yw/?=
 =?us-ascii?Q?H8plbi7AhgWVvLbPk0HALLTrbA47FNgtpuzDZky7Q7HFUJxwGU4Qles/gLqO?=
 =?us-ascii?Q?5FjfltGvHXewo287+XiUEUmELmPOgn3oGkg+SnPHymXKipEF9lbohaRdwZ8X?=
 =?us-ascii?Q?FKCgTivcA7sr4l652mQuRX+1uM53HH5XW+NqWxZxzHWT7Y3gywkyIhoHl8qB?=
 =?us-ascii?Q?VdT++EIx6sk4O0oKk5ZVJCia7V1JVB2gEEbSs+Q72tZTDhLvP6GygC6BH9xN?=
 =?us-ascii?Q?K8vN0ukT2AAe/xjZnCe31jbCiUBycnweIIrNZwJkpO0udRrkH7MM0zV9wrhL?=
 =?us-ascii?Q?VNnh47umHWrqNtbANYuOwyS1TJTtyf3qOWien7AYB3LQYQANQjmDKVRuBBnX?=
 =?us-ascii?Q?SWgaJ/X+Is94aW9J19Rc1dHIb2sk4J9cuAZ0p5JAvEIpwV4BHLlLz0r+0+GW?=
 =?us-ascii?Q?lX7KmZ3mRD422MWC8Tik6vt7oMPp/HPMvdBhMqyXzV1gsVze01he/l6CdqE1?=
 =?us-ascii?Q?Kw9BNXUidYtJa+2srMOXr3+AZcKgFVIyD3TXmGr0XIpI3Dg9JKP4R8k3EAie?=
 =?us-ascii?Q?5h9m2JtysfA8QwRDpXwA7IPOwvB9Eg9Hqn3tEizlPRyht78C/C/UfdsrXtLI?=
 =?us-ascii?Q?bcADJNX80qusR29bI0ff/qlDD4pPq6jIGOJrPAk/86E1mvAqvesssjCdOlU7?=
 =?us-ascii?Q?nzsSo5bidFIJXX7jxJJNyBdaHXUusZGIEf5XIV2oPonLwmfiZ49wznEXMm8L?=
 =?us-ascii?Q?EwKmDFfAh5mjGY0hTXmjHaEkZZqlFgDzPF+XfkrFL2XPEPJq1vtYnLvQJGSn?=
 =?us-ascii?Q?pMJVe7z0OV9aL2aJXRaDfkk3hj4jkPP/mFjdLoSZtzQ33ndBtjKzfBdeJxuf?=
 =?us-ascii?Q?nUpR0B8Naqwx3y4uLboypUe9mPPnGIzgeYPYDc/o5Mu2il4Bm+ZW7zrnvRuq?=
 =?us-ascii?Q?yYLoDVGfT3Wmwx4l+KP5FRX3GbC7tRw1Ypa1ksj2pm/NudjIkg1ItA2U2r37?=
 =?us-ascii?Q?zrWWmIvvqg4YdRY/VyDB3d+NiunAgKU9syL6bVHqqr60jy92tT6f1sCt8Y3Z?=
 =?us-ascii?Q?e04mt4nyQjbh2h3NRhPy+DySRA1h7q8odEwREJ5Sle+u/X6GKY1L2lKhF8q+?=
 =?us-ascii?Q?yxD/sBTGO4gskoeB2gBrjEUoEwvkau+lE4LdvXA+H8s63mAzejt83JpV5XQr?=
 =?us-ascii?Q?ECdA4p9BKKg+cm33FrT8VSKiv4+zazlmbwaB5N2FYzsIp7pKRlQN+1idiXNR?=
 =?us-ascii?Q?Lbhudmjns9i8ir78pDx20W1PX0JqvmFDMozurZcOKceGda553vyvpJ7Njdrq?=
 =?us-ascii?Q?Wh2QD7PDs7u53FYAZ/AReO7uveu1iEvUOgSVvmW0q+/7YooplLwYVhYFttPn?=
 =?us-ascii?Q?I24lSilF75pVLOF2zITFp3sns5GwsPZUva7yOAK8k2iT6HiNDTUOJcK2Ex3c?=
 =?us-ascii?Q?fMp4Lo1sPiKa5Zv3m/pQ2WDrbWOiiG0ech4QYXnqnZ8IFc6mF6x6kpGza4Ae?=
 =?us-ascii?Q?Tkvt5DAjnHoVwIONtttruhugKlPL7HEgJiKHt0hloeOFusXxLhhiJs7VKx1y?=
 =?us-ascii?Q?8o+zzg9KPvzYMBz8Bz/Kir1/+lq40SLIQFpKOBJ1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c79305-2be6-450d-4761-08dd7cad48b6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 06:09:44.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZuOfZFnleAR6y1cUhUoZTo74Fh86w6ekWmoUVqr/cYvTJeDq9CIU8plZix+ga/ZQqJnPPGHysZ+TOa2WMFzng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

The look up table(LUT) setting would be lost during PCIe suspend on i.MX95.

To ensure proper functionality after resume, save and restore the LUT
setting in suspend and resume operations.

Fixes: 9d6b1bd6b3c8 ("PCI: imx6: Add i.MX8MQ, i.MX8Q and i.MX95 PM support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4cff66794990..5a38cfaf989b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -139,6 +139,11 @@ struct imx_pcie_drvdata {
 	const struct dw_pcie_host_ops *ops;
 };
 
+struct imx_lut_data {
+	u32 data1;
+	u32 data2;
+};
+
 struct imx_pcie {
 	struct dw_pcie		*pci;
 	struct gpio_desc	*reset_gpiod;
@@ -158,6 +163,8 @@ struct imx_pcie {
 	struct regulator	*vph;
 	void __iomem		*phy_base;
 
+	/* LUT data for pcie */
+	struct imx_lut_data	luts[IMX95_MAX_LUT];
 	/* power domain for pcie */
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
@@ -1484,6 +1491,42 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 	}
 }
 
+static void imx_pcie_lut_save(struct imx_pcie *imx_pcie)
+{
+	u32 data1, data2;
+	int i;
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL,
+			     IMX95_PEO_LUT_RWA | i);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (data1 & IMX95_PE0_LUT_VLD) {
+			imx_pcie->luts[i].data1 = data1;
+			imx_pcie->luts[i].data2 = data2;
+		} else {
+			imx_pcie->luts[i].data1 = 0;
+			imx_pcie->luts[i].data2 = 0;
+		}
+	}
+}
+
+static void imx_pcie_lut_restore(struct imx_pcie *imx_pcie)
+{
+	int i;
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		if ((imx_pcie->luts[i].data1 & IMX95_PE0_LUT_VLD) == 0)
+			continue;
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1,
+			     imx_pcie->luts[i].data1);
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2,
+			     imx_pcie->luts[i].data2);
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+	}
+}
+
 static int imx_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
@@ -1492,6 +1535,8 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_save(imx_pcie);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
 		/*
 		 * The minimum for a workaround would be to set PERST# and to
@@ -1536,6 +1581,8 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		if (ret)
 			return ret;
 	}
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_restore(imx_pcie);
 	imx_pcie_msi_save_restore(imx_pcie, false);
 
 	return 0;
-- 
2.37.1


