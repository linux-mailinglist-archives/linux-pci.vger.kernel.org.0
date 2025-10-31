Return-Path: <linux-pci+bounces-39886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B52BC23284
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 04:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6983F3BDF1F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 03:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E82264AB;
	Fri, 31 Oct 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BD+eYmT1"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD66257820;
	Fri, 31 Oct 2025 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880802; cv=fail; b=aIQDHw9g9zTiHOb2vSh0TLuc3cUW15w8JUXFmLmn3dguiwU9eG06CT5d5wLs8boDzsqFCrVlhfL6CyAmJQl/qg1iFcGBQJa/nD5SjmT1eSYXcMBhFRNYoltATr7h4QuAgwIj7c3hdJPg5TcQFceH3OYkv4Bu1xDcaFuiHBYQLlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880802; c=relaxed/simple;
	bh=tH3Al9/IOLOBZtwdhFd422qIFvIRx6zzICWuPwP0jdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f2fne2b1Wptjf9QI7t6+o3xE4NDVJp49V5AyuWNLNA4zuAlIpH7V1S6O91yOEKJOmvHWrCleR3ndUuSQv7w1AnOW9DxdbUW8DuBEkx3IN23Td08h7tIRFvouoMHOgnZxNKD36jD3uUcQ2R8JnFRb6sDMTTRWpH4fL/veMHwkTz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BD+eYmT1; arc=fail smtp.client-ip=40.107.130.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUWln8okc3723BDD4keQ6vqOzgomiM9AnMYA2YATaV/yttpk8KnUAX2U7XgTcDkMbbdLdcBFFVcVsIlSaYh850xltpNpWZuvvIBMmx4SLnxl2lOTpJzb3PLOdJmw5mSEAMdqWF2EJtdd6aZorKyXTmoQfDXzAG6OU9Xp4AO2E45j+YgG0eSrUrg0QH5lBwBoUOloT6JgGGdnDcVtzhw8wmquO5QHl2FP83hXjjzdB9Xq/U4t0dgu4dJCZYhU1/GYA4Q2sH74pb4JiVHndSiXjrPzGc1PE8NwfYqynNoZ82sycS5JIS4zMMndBHwAjq4hGPkSdyqOFDIw5B9UGGYnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhY9UbUaPop72UIkfNE6Y0DQW2KPGAyjra9Snj9z5nU=;
 b=kcC/zwhPQEjzSjK/yYUE6RyW5j98ImLeR6EfD0KB6W62E7WOClOgODnhop7MH1YFzF3tA1WVdJ6ISxTKTActHTtR55VGXmIRkBYqQxRA/WF8MEnSjUlRYRBt/zIqO5sKMbsLPedc66TkGEFnmhK+SOtoCklJfv/TCu8VrMxObV/p+43IWzMdXPV63yAX6SpRzJdtYzgAqc4onNrS8jKY9aogWES2nB8YUNPv5EasgIVRDQD/RP/Dg6M6nm6ubjBGxBScsOSnWXUHqu99BmVI/70WHekLqlfxoviiChXcEAuu1uDXf+QYCrgYfDCFxpESIaIRledr5wVf8dogtrLZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhY9UbUaPop72UIkfNE6Y0DQW2KPGAyjra9Snj9z5nU=;
 b=BD+eYmT1ikQnS03OqKkJ5OWli0xflHYkrqE9NakImnakyLQvci4tUNoVjAc7JD3jU1oIESkufGrCl75xM039SjLUVklwpMmgJBYn0EirrmQaDEt1mEfVdScSC9u0Fs6BrcjwiXpek/934AlnQ+YC02yp8KXspessl4RPjDqeocwoV3ZPuqaeXFHdynI67bc/d49fKOwlBWJ8S1/s5k3NW1I9gce2CtzvMmJJcFQeEPjSrD9JXOdm+A8f7eJ4KezYiFN7M8ffxt/H0yHFn9lZavyGolq/NfW9ctU8u/nfgVBwYub0EqTsjDxDqcjviYBrtTq52ssgcYh0AFbyghcvCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM0PR04MB6817.eurprd04.prod.outlook.com (2603:10a6:208:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:19:57 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 03:19:57 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
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
Subject: [PATCH v9 3/3] PCI: imx6: Add external reference clock input mode support
Date: Fri, 31 Oct 2025 11:19:07 +0800
Message-Id: <20251031031907.1390870-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251031031907.1390870-1-hongxing.zhu@nxp.com>
References: <20251031031907.1390870-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM0PR04MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c500990-13b7-4bd2-efe3-08de182c5e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xsflp7j+ipvL/qcht4BRgKM9u7IFc4q4Tw0eiK3BGG+pZ1c+g++MjZ3Q1u6D?=
 =?us-ascii?Q?dz4D+YClBbFKv3RD6F7HSXY/fnjNgzMb/OXegcI67E+4gNWkw9DmRa+ZMgRi?=
 =?us-ascii?Q?KXryYR97iwvfY0txngDKIiT3cn1OPv7XMLAwkjCWvt4k6pGNIUCZoOwqWFCi?=
 =?us-ascii?Q?VnoD7i2wanIunrHV6zEV549VMRD26mlG3/1PHW2Hr6NaQLtaZRY1SgGopE+8?=
 =?us-ascii?Q?m7tke3PL5zLRwVFxgP3Dn/6G+62WMhklpnsM0vJpXNJqneHMvqe7TZKOiCE3?=
 =?us-ascii?Q?wZiB51UdWOIqSe/0B4l5gsRfm0TMMNDdqsysVk9C6FeWslk7dAO2g0i8M+6z?=
 =?us-ascii?Q?/PDF4PYsxFiAMHhGniUl05dCPmER7siA+Xx5u3KWj6q7CqbwOQpejyfUM512?=
 =?us-ascii?Q?NmSYGmOyCXffWN5GSI34snQE3a/l2soJc5KL0IRdWmO5psm4ry1Fr+DtPBGT?=
 =?us-ascii?Q?OvRzwhw5Nz4quA9/iTgA9Bn7uTSOzymVU3IHJJBPq8qsT8pMpn3A4bxiIW4/?=
 =?us-ascii?Q?uBnQOnv/S6lhwdOCZh+fGeSoP1MOhvrhVTx7B0elUjqqFkNeKwpCOwBXO/mz?=
 =?us-ascii?Q?AEB60+chftzn2dLOWwLaL44iLJdAPNlUyfIWMdmVV8RH35qxq7Pkvmgftc6i?=
 =?us-ascii?Q?NyS6g8a68pZ+cRVMXB9ulf65rbVMC8kiAGpBuZ8YbAU37zXwix1mbaj6Bzx/?=
 =?us-ascii?Q?khCUw1aDx31GbjRFO2bynkZkEir8pIc57QSVhAFDCWW39BHsKT7q/0dxFTUh?=
 =?us-ascii?Q?7Zf9tw0yNN4nPuyaHJhpE5ujr5SfllUf3jLg9RoFQXre6M2R/eFhxaiQM/7M?=
 =?us-ascii?Q?IJn4cqmGFE9sF/PFDkzUho2GYR5Tr44YaMoEBCsQeYopaj+vaIAx6J5MUjyL?=
 =?us-ascii?Q?uGqmFwKC5tKpT5tbqdU/Ep8ZVgpBrynl5QByNRoz0wNQmOQXloRRNm5jzj6F?=
 =?us-ascii?Q?amUMV5EC8AUBAu97VOnw3fOGNvY9InPpYmW5do89D+FbwLmAXQ9ZeUvOS506?=
 =?us-ascii?Q?bOiMzitc0F8/m7tSV5HERVz8MhvrkSOldhSMBEK6oZFuNJzkdpOM7KsEUNgg?=
 =?us-ascii?Q?3V6+xYm2Uvq0eAQWltcNyTldI7N8ds5wpdg0uf3Hxe73p80kZKko31buwqU9?=
 =?us-ascii?Q?QD+AbcVz6MD+gFfUNSrJOP+hhuWalWnX0hyi9o3R0Hym8HRamhLCLqGEA8tM?=
 =?us-ascii?Q?H0k4DFrKhmgVkB6IxoAMQJKQyH8D2NWsHangFwG65KF12RdgO51FZhxYikHd?=
 =?us-ascii?Q?DUjmpPfEn8oCVQCPDVTzOigD12klw4YuhlsoEg75GHKJFxx15TT47+QaERq8?=
 =?us-ascii?Q?xkTfOPDjUkYP6oTUc9tk0x5rGuZK7ORtUJ0eU2N+Iq64r/6yMXfv+QSvuWQp?=
 =?us-ascii?Q?H4n0mZJkVcsO/0OCkyBgyGqtLhMZ8aokDK+M8RIl2zyUteCxhztq1zSIpBob?=
 =?us-ascii?Q?TIwDQW2Mb+4MM5lYna/om2GJmCthv0HfaFFH+9QoTR5g2mdlM+F9asALbHv6?=
 =?us-ascii?Q?+6CN+gWQ1tLJOPBZvQgMoI4Fxsnf0SoSD1pay3gg3Vmb4cOFAQev5A8CXQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z9SfiJc1rOoPkrLHKV+GdvjGMbtFUTUbT3BVlWpj5zYUIQFqRWYmIryp+QjA?=
 =?us-ascii?Q?E6Fx4yW+X1Yas8ks2woJq9jes1aB0CMsP4moSZTdUA/lPIj4Bv8qti2140Ut?=
 =?us-ascii?Q?bBCCXBW3uPVT2n7FMlBgM9uYeAGCVfRMCalT/Y1MKxjKlIl8JQYSSCD5Kep9?=
 =?us-ascii?Q?nALty2JDVRweIYRaQavvKujLqem5ValWnzF6DyFQph4jz2UZFQqrEoRWIf0n?=
 =?us-ascii?Q?VTGDZaXVCDrKh8AZtqBW8HpDtkSJRvZJXhAb3a0JOIpHDy4+akrzt539RLU5?=
 =?us-ascii?Q?TkJgibXC/MQrt4uUcmQG8NwdmietKsfetfpkzoqcPv8NbsEfUJlgW+dPqRPi?=
 =?us-ascii?Q?ji+tQi9X2P79BPRhp4USewb1Zk44CPfB2p5GQl/XWs5LzqtQv/JGhAEqMdf8?=
 =?us-ascii?Q?aSwmLGx9HwQKInHJnl3Q0qyRwIFkRQQ/oHsOj3XkqzTxpFTrWVzy42G7PO6b?=
 =?us-ascii?Q?Uqz0U8e+LFEmh0hxoDtgMKfggavFKAsotpUvOTjxii0oZwxn5GDzE9SDsAge?=
 =?us-ascii?Q?A/NOe81WsFynnwZqGlv4439HGHpJGyMUU5UEhwdRgAgJWp0y0vLg2ReQnaGQ?=
 =?us-ascii?Q?0ZKXoeDhegQVR5BHY3svo+7QRa7UfM6lH2HBHdUtHueaVOWVdx8oKd+YsmfV?=
 =?us-ascii?Q?G93MOnv1Ys/PQzxHYzaZ61dBCNB7ZOVncEEXcxIv/z/HxBG03I4FHbGWtDTL?=
 =?us-ascii?Q?GxorAUJ6+AXq5Uad/kXQtxdXgRPNiqcHQKPXqCmpNI/bSoovCzVoxbSzUknf?=
 =?us-ascii?Q?buaoXZqslW4SsMuMP6d2AzfEX3+RTixhWia27zGhvAb7llMrczM/gSeD1qyE?=
 =?us-ascii?Q?kFyNEcuUo0iGFn3gqVRMSYna0kUI0+0Br8mAeXFaj/4H7++Co8XMfLI/w3Zp?=
 =?us-ascii?Q?nMjh/EDLLDbWW5sPg/P62Psr/DW5h93SDA/s82r1QFIMuIqe1NzdRVh/p0rN?=
 =?us-ascii?Q?pwXlbhbwSEpf5K3Plm/su1+4WVjffXLfZ88V0usNxC3aWIb5FCfkdWZrgBpS?=
 =?us-ascii?Q?XyIKkZRgIFQQPeYdCOPjkh6r3L0NLm9rfNqukpO2oX6FpZo6Ts0qWX1fXETu?=
 =?us-ascii?Q?c/I9Stzi4sIdxcFVAmJ9j+pTb1bleqIdi7wCO1AbzbGSxbUcu9VjnnYuiesa?=
 =?us-ascii?Q?ldC6y2lgQp0OusXTelivkSxhh3Uyt1K2kMh/t1TltfVOef/pE1aeg02rdlMU?=
 =?us-ascii?Q?7JfH8v6GgzRuAXLLt89cYeiIhAlj7Fy3RPglmbooywAS/5scKu/e7U/jL2Z8?=
 =?us-ascii?Q?PC/zjbZvX0L1kv/FlnZQhFtbPRJ8/fTY5h1JqeSVCQvQOqaCc/AYQ9EZvC/1?=
 =?us-ascii?Q?gBWqe3GST4q+5Nbc6WN3O/XaEZm/xoURzfvuKL0rM6D6rarYxoHxEh11F2Z/?=
 =?us-ascii?Q?Yxz/KvkppxJIsKnxYmK2TItul0kwJgZ4FHZckbiaiAOXMUKjlsc9QJPLCw2l?=
 =?us-ascii?Q?znHdEbgbe9w4U8kQ9kiZ9oRrimrJJOkJI3NN7/jTFDm+jg7ZQufLalrEVWSY?=
 =?us-ascii?Q?r2zqJqluSbSaovk+iqaaT8MdCeeQWedru9+Q5a1z58p5BY475aNYzcdIV4xI?=
 =?us-ascii?Q?Ki4YVo0fkiBjXGnsGnCk59SKw6Oji0prlg9jskRV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c500990-13b7-4bd2-efe3-08de182c5e72
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:19:57.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djBCLwAnJaAMGakhCkRYOdUR8oeFqciWxgSXNrmN6a2CDeswsYz1GJZ1JUVWWrRrL/f/Ni0uosYn6L919T+R+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6817

i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
other from off chip crystal oscillator. The "extref" clock refers to a
reference clock from an external crystal oscillator.

Add external reference clock input mode support for i.MX95 PCIes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4668fc9648bff..a6db1f0f73c36 100644
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
@@ -1602,7 +1604,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct imx_pcie *imx_pcie;
 	struct device_node *np;
 	struct device_node *node = dev->of_node;
-	int ret, domain;
+	int i, ret, domain;
 	u16 val;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
@@ -1653,6 +1655,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (imx_pcie->num_clks < 0)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
+	for (i = 0; i < imx_pcie->num_clks; i++)
+		if (strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
+			imx_pcie->enable_ext_refclk = true;
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
 		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
-- 
2.37.1


