Return-Path: <linux-pci+bounces-17319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A339D92DD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 08:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA86B246FF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED5B1A3042;
	Tue, 26 Nov 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N8q77mWz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515D19DF95;
	Tue, 26 Nov 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607871; cv=fail; b=HULrJOq+w84iAhUJqGKpAiSH6pN2E3l6NN7BfYBGjyfj9gEiaFUyjwQ+R+lxi9RK3jit3vqDji5IDe+3Y5/DZ8o9LeuLbdCJniRPSvTRALUddsBcj0Xqp+bvLnZs2R5s1pR2ZER1RjqmgATVDKCzNyG3t9UeIo9+ooMr3nnvjEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607871; c=relaxed/simple;
	bh=QWGQzqK7NOzR0Nrc1WfxNbWVQWUdxXuDPSTDpWIbQnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sRjUgbF0ZHJ5Ci8Ir9J63l2pUy6ZewRDPMdg6Tmg68H6i2HCJnizRYzGyxr+15Yd3+p56JtCtD29gud15dJXq2B0rduYWVDZOKVk6YNT79edGQ7YqkcZjJC0WKvOMnerZ3klzhkqgNscmru4OVA55M6gSVRUFuoIFL/m7tbsavk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N8q77mWz; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmNSPEBzS2Ki2du0e/F4U/UoZtipE+p3KJdWMlJNX2900j1ejYjRZDv+2GDW8VRQC+ZyXGuoxas6OlKLFZ0iI7WzcumfrcNVjCtOj0RWqYCPrNoERz3GSKSes6apHUWSIU051G4iczs0+ezAPE0e42E6tYgRlPTfdY/6Yy3QlyL1BsDhum/RdBdOCCFqar/ZPQUWGOMpnO0JjeaeX3tc/N3h6SRm/Ty1yExxz4u5BoAQUmQ7u1a1I0NTE5Olnmo2/dtqL9HmnmmYuhKkHX6E6IkofYVLw6Me36aLHTyGCgqlx1K3psppwNw7sWm2Rak5o67a26LKMNXVoXCTmO2rDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RtplwTf1bFd33pQHVpt1klLT2D1dRyQersGj/Z9EQ0=;
 b=lPW4YCMj6HnaVQLRAxL7lVqucUPMeSdunedcy983lLk8FsgC7Ou+P1mwmTsszkGZNhJv5G+zYSqWrnxfRx/biH6uOr2C8LPTDmnwXkOGtb7dV5WfpW6EVQAFy753W3wGT/I2rGAOUE6IcctMkkbSBZrKaswmvQAXhQoM0FtXqQzpTEzbOmB0DHTOPCvC+mKvTPzmZDiSC0BmRxXU3lrcTaCb5BSyUkYUpQpiUytn6V5Rw+P8FTNaebue8swQgTZ8/VzDem+ror/aiVWb2gt6cgYWXznExeWD8agwdjoQQ7V+BWPJieCIjyLewrTtiwcTS+xoB+Qt8WcSiowUbonnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RtplwTf1bFd33pQHVpt1klLT2D1dRyQersGj/Z9EQ0=;
 b=N8q77mWzAfz7VRIoQ/PwGRf/+CBgN9+0xhwChVmrO2GGVbQaf1IK6PKqB1BTTCOyO8c0P9C50iUBKQPzPgtiSwg9ehZkF034BvwD8wwgLGTASIIN2swqNRFkBzOrWIswS2nyWOwYfssDM/f13WVVlCGlipMrqqNOEFbUXOcw2neaee9crpv9Qi8fIZiLXQ4Zs7Nyu1KOBIbmn2+BGPCvaK61QiflFU3vUaATl3uR8Gcs28Bsop0K+utSBf62v7pzgbWwTa7vfCzOFJIk2lC8M0VvtLRT0BoSlxkZMMtTKZiV7zH4KPHy0oLtT0v834zK6foW2gkczhCfpgKtxD0EyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB9401.eurprd04.prod.outlook.com (2603:10a6:10:36b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 07:57:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:57:46 +0000
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
Subject: [PATCH v7 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
Date: Tue, 26 Nov 2024 15:56:54 +0800
Message-Id: <20241126075702.4099164-3-hongxing.zhu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DB9PR04MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5f351c-bd11-4320-e658-08dd0df003e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DG71YhlVEv5yX+XQbkobx/7URF9uiDke0x1JUXUsXaCzSSOR0os/KZwM4zS+?=
 =?us-ascii?Q?9vaGmfcsG71DOoD+gtDkoeB6dXdUI3IjV2zYO6G7GdFOF+UsSboLVBBYETQx?=
 =?us-ascii?Q?evWZ4jk56PJMpHrKoVSBCUHv1vuTdOIZvoNUchCUl36WXIHuaAMHNTetgR5Y?=
 =?us-ascii?Q?VYaEuAo6eAGWwMWAxsvkbjAtBxm29tOUa3XMMQ7wwFuHzsKPgE6nSe9MECqX?=
 =?us-ascii?Q?+557F27rhoG1+qxHRmoqrePpba7IaG+bls+LtKSWtUN0iiC7uQGTlrrrnVwl?=
 =?us-ascii?Q?Q6KqE1GjtpgMnuvEJinTapYrYpso3bEAaKJ86TMGkSf+juvZPPjKOUIxv8wG?=
 =?us-ascii?Q?bXc1MkVFTSEGTlWdY9kZ85+nbWD07lss4H52lTfpBWd2vwWucD19q1HqSj1p?=
 =?us-ascii?Q?pyxieYo8HrmJcHTvN23gxRx0mM2C00lPcZq+7g2E6VVYYxC8gS9Fe5gqK0Z3?=
 =?us-ascii?Q?OwZDc2HOoc0uJQJXjhLqFsEu4rmzRe+cHXbIpD3MElkgJmW6voaDH5jwVDbP?=
 =?us-ascii?Q?uRBML8C3PH+VGy4N9qkpcp/oHfb58yPk1tY+EQ8Sdpb+tfM8JDQBkT8pGumK?=
 =?us-ascii?Q?yBqp+8LfzyU4ALKnbbeEECf+4ZfHtNNJqQLSCtwzys7xS/zMoo98w2cv8/Zt?=
 =?us-ascii?Q?TJbGtOSyNqf4u5ObbjpvV5rwnhnXAaD/f2eAIjKFfOyUCBMT/DVsVaaWTvJZ?=
 =?us-ascii?Q?uE+KObX4qBCBZNnAf853LAGZCuvfmpMh96IZcYmellOkJ+iG7vOafV73mXEn?=
 =?us-ascii?Q?4dejXqfIwDbl88kRvc91LO2gyUfpIUd+9PiwFg84M9LHiG9f/l9fKxtwwyxx?=
 =?us-ascii?Q?jH8Yo262JWTg1uovYVjaIPjCxMLHUKS1XZ1kVeaMxKDexA5caht0ad6/xIHJ?=
 =?us-ascii?Q?Zoz3sl4ElT+rQANZz5cs7tyMnDqiqcDC76D+NNOBIboOwraSKzPPBHjKbXet?=
 =?us-ascii?Q?3iDqTphzvdryGiZ+PMjZw1FdzYl7lbcN8q26vmcM0lR3pjkAUEEKyIqEO/Ci?=
 =?us-ascii?Q?eUNDToY8rpXEUDe74HU+fMFE2z0uSRLQwNL+XU1DslNBnd6IOnoCT8Q0EI4B?=
 =?us-ascii?Q?mVoUhlJy0v3MuRJ3ddp1uxCJOPRjynqy9Q+2gYOb4nQ11bliE6hLW/h/7+2Y?=
 =?us-ascii?Q?Vr9XyqewXsBUUl6oE/p4nzM7/7Eo4YAwZaOheqINg87v75KVtmkkCiOr172e?=
 =?us-ascii?Q?jSvPPPyiy7hKCizSzatLPDl6eE2IH/sWL/N8E0DMHLofFjNSJ0C2izpICPWJ?=
 =?us-ascii?Q?FoBl1VyphqtxiuJDONyZZx770SFW0Gknc24O/6Pv35t5MZ9psKTnUj1nd3Co?=
 =?us-ascii?Q?AggjWzhgHzT1c53lSv2K5BeeJIqVHXDwXLF0t8UBTRZKdXb2q2J+/1Eq1NMX?=
 =?us-ascii?Q?7oWMirOzgbC3r4rkFd9oEjb+6OUvsw0reXL1I+r5N8Fec8hPZRoO+9+LAZQt?=
 =?us-ascii?Q?ehY7J7HpB5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3nybBDwzCO7JhkoDtOYNDVVH4m2FQ+yrzdOFaWdik/Z6VXV/lQCT5slB5nEs?=
 =?us-ascii?Q?3jrzFnfcrakzrsepx4+gzexPAdJMtnI204ivKNFnx7U3c/Sa2L6k5SbXuQSa?=
 =?us-ascii?Q?zoNTtVEAQl246xp03/lfyVjvCChVZrzSoA0FfPm7zhaHjz1S7Dr4eoo7GFXw?=
 =?us-ascii?Q?4BVzIRE3ha+TNqztSpXudf58A0qd+5fuu2AJLa6EeoWnJ4XlefH8KSVATtoG?=
 =?us-ascii?Q?l3Tv+9gcJh6TVvl9LVFFLpvP8DHPQg73DWMZXW08FttIljcvVj/uE1RQzXaW?=
 =?us-ascii?Q?OplGAZrcElZ+QVDHj/STUd5pwkVOHu1DXhx/k/KheuFn7R1qQpuJplN4ZI/f?=
 =?us-ascii?Q?PQFgvxeCxBwn9e29xq+YxwOrMfgTp796AQexEzz4cPLV9OE4RSP3zPnP6qiw?=
 =?us-ascii?Q?GspVq6j6QoWTteai/6pcGo5X5qXwJXWY/ljBXEFutt+SBz09XSCbMTxAd7ay?=
 =?us-ascii?Q?R7WNRf+GB3bfmNywDRCykwURyaIyN9k0pk5P1PXtwJ2T5THWUgOQjQK++Q6B?=
 =?us-ascii?Q?PELztFW27hvLBDa13OtERgqyij9Kvf72Lrx9HFYIxMLTAlc0dWYYmg/G0/P6?=
 =?us-ascii?Q?35Em5RPDvu+e4BRh3ucrDTQO+upV7Q/mwQws6clOHIuhvRHOB92dXO2x+hdu?=
 =?us-ascii?Q?62oGmIjuKD3hc1i8S3x2ze0Ee1IxB2cMH+38t0Tgu5shhNZidbJxkAgri6bm?=
 =?us-ascii?Q?iJ4WUiy4cKY08SKh/16kaMEXymI+6cknHGsglVQIGVFSuuB0iSVJiE2xoKL1?=
 =?us-ascii?Q?0EDy0WLJhp1VyhSkTlMWP9qwWSGDWO78+NrhVWAcZV7jeN+Rwlkmx2/Sgt7D?=
 =?us-ascii?Q?eyEGSzYeYuUNCBfpQnRxb7jRVX+DORp0X7XQu64W4HKrocH/5+/lJeE4OPkg?=
 =?us-ascii?Q?X4EUKvXf3sN7HuPRX2ELvrtnq3wzLQP99Q83FmWS7w73GNUhwqFwZUr8vgpo?=
 =?us-ascii?Q?HMEYLvPTj6FVNv/I6JwzOgHCBO1XOS6faxhEI62TcV/Dktfits/cFY16NwjC?=
 =?us-ascii?Q?riCm/OTKes1NlDmD9iTjh04ARHim7bJcXHq92V29cgCwB8hh0FeN+FGXiljz?=
 =?us-ascii?Q?ekQO9ePbZ6+R/zUnjb60MIj860Ne+bwaH32nNNjg7QEoO/THD7rqHiiATlCf?=
 =?us-ascii?Q?FveNJ8RO/Ss4Mo7TF6ISL4a3sd5zXEMbWoenNKEILsAtAyUHUhAnmI/BapE0?=
 =?us-ascii?Q?rwihtGAmLRa/d05PmhVyLxIe6cDA4AZ5ovsl98vwYbV4ylvOUyW6iHlPZOta?=
 =?us-ascii?Q?j3CoUnKpS45Y7ln0R17DvUBoLWzD1i3EcfLOnvx9H3g/K/9OtD1eT+FAWO7D?=
 =?us-ascii?Q?SEjuvyUlGIBVFWSbiR5Ro8q4IMol1dKsFazHp7VIUQCNPl7no8yPU2RoXD3j?=
 =?us-ascii?Q?wrgdG0QQnzVCCY+ce1RAnfCiAirGZkzqBk5dAfLo+x2bpEp0ff+yMvXBCJOd?=
 =?us-ascii?Q?vHU2afqElkEir8XuxMzoEwKPIpzthz5dzOwc3Q+di0rJPO2BdpbLVXoqDUlK?=
 =?us-ascii?Q?kmhhQyp7dts1s2Ub4g4pIMQsigTtXDHZdSnighc/MY9QfOwv2CHlqE+q564d?=
 =?us-ascii?Q?o0bPA1M3eZHQ+/e4N11sUw9WvkPtP7k0X0WRRoVb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5f351c-bd11-4320-e658-08dd0df003e2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:57:46.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qfTOnJpxBnoxku4IrSgdK4nFJwbo9XWeLBha4Hv++bgQx128MxBBkRK8Lg6EDobYzAHhOmFUBFjK9YZGiAY9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9401

Add "ref" clock to enable reference clock. To avoid breaking DT
backwards compatibility, i.MX95 REF clock might be optional. Use
devm_clk_get_optional() to fetch i.MX95 PCIe optional clocks in driver.

If use external clock, ref clock should point to external reference.

If use internal clock, CREF_EN in LAST_TO_REG controls reference output,
which implement in drivers/clk/imx/clk-imx95-blk-ctl.c.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 385f6323e3ca..f7e928e0a018 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
 	const char *gpr;
 	const char * const *clk_names;
 	const u32 clks_cnt;
+	const u32 clks_optional_cnt;
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
@@ -1306,9 +1307,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct device_node *np;
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
-	int ret;
+	int i, ret, req_cnt;
 	u16 val;
-	int i;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
 	if (!imx_pcie)
@@ -1358,9 +1358,13 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		imx_pcie->clks[i].id = imx_pcie->drvdata->clk_names[i];
 
 	/* Fetch clocks */
-	ret = devm_clk_bulk_get(dev, imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
+	req_cnt = imx_pcie->drvdata->clks_cnt - imx_pcie->drvdata->clks_optional_cnt;
+	ret = devm_clk_bulk_get(dev, req_cnt, imx_pcie->clks);
 	if (ret)
 		return ret;
+	imx_pcie->clks[req_cnt].clk = devm_clk_get_optional(dev, "ref");
+	if (IS_ERR(imx_pcie->clks[req_cnt].clk))
+		return PTR_ERR(imx_pcie->clks[req_cnt].clk);
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
 		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
@@ -1509,6 +1513,7 @@ static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
 static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
 static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
 static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
+static const char * const imx95_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux", "ref"};
 
 static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
@@ -1623,8 +1628,9 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX95] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES,
-		.clk_names = imx8mq_clks,
-		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.clk_names = imx95_clks,
+		.clks_cnt = ARRAY_SIZE(imx95_clks),
+		.clks_optional_cnt = 1,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
-- 
2.37.1


