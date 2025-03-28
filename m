Return-Path: <linux-pci+bounces-24898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD4A742A9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 04:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039817A731B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 03:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0409D1C6FFC;
	Fri, 28 Mar 2025 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XRXYcETW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BAA13D89D;
	Fri, 28 Mar 2025 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743131015; cv=fail; b=IbXI3VsA1ruamRr5OWluE5Io0cq83HoPMyfE4EOK5j7KUYZzhK5Sb7mcAGpUksXiDoaIe3tKBPQ/IRye7hRBku/euT0ObqLEqRazek+UZPPPDOuIhnDDlTJgiozBNsrBgHjAoQzKqp0jBs/UYjesiV251tddBidv98UYiRMgxrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743131015; c=relaxed/simple;
	bh=35aw8NhG4WVpdXxYCXJJdHm5+jpgWci0NstKNs8Uccc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ne+i1XuvJcHhPsr0jxwblbJBZ3wZc2ttec6EXZe8z5N7x3FPOMJhDAqNYGChBkQavxjCqIv+y+pyXSjmUbzhRgfMsYQTkAktBT704w6ASgnqvUWIzXLnlqYb1WUrgOpArgE+iZvKTr6/8Olgg0kL1WdlEVBaLolryObUUsY0Fdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XRXYcETW; arc=fail smtp.client-ip=40.107.241.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4ZT2B6tBxjXwyfMAz6b+24C7qBhafSROM6npuhHLss0SMNzltjiO0wW+xc3SUFwUGbWFj1EEw+UKtyAp95jONZjO3TVzzADaVbL0PZ5pWowpuN2Zw8RCaRrVFrQE5Yf6ltVQHvbQkUPTQfgriGEv+0dPTyhl00kw+v96hQbX5Xirhr6Z0PI/7cqggc/MNmaXw9kU/NhrJgzorK/2xieX3k6hHrOOComlW0tWQmuoXN9y/To/3W1qLDa7uWVWvDE9mK+f62bG7MWL7t0Z3FML0EsVy3e/1Y7/Acy5rYEeFb6dH/Yj95MEmzbYq5QjWdMtCZrjhgQgKIUogHWbcraYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqcC11ht7Bl+L1O0I7ORJGy3e2Ydxb3OCmtDtUTFvR8=;
 b=xRo7ndc0qnOa3ebk3IcRuX1RadeH84LfE6BZoOnNcZRoEHqOuw6wmn+fDGNUnK23/fmRWGUYYJgTEAasTiz4JO4HPrVPUZuxQPjCucBERvnulq8G02btUKihCXAOvyaeycBWFFhHETy+55DKQvBzKXTsijIY1fEcc66UJgNFqwAaYwoucE21rbdH0ifejCGVUIfOgWYKdzBGIp6T/YFkYtJ9qpJe+hZruc/tTe8gutgS1JH1iZJZCP3lY5Ju5nkAWAQfpv2Sn0cCqLPeglENwq523yQ+E3LwJyWcX+SJ0nOr4kfmo84iUzAgM2joUywpZbBVsQJXQ/pawmlxZUolTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqcC11ht7Bl+L1O0I7ORJGy3e2Ydxb3OCmtDtUTFvR8=;
 b=XRXYcETWK5+4e7rq5YlL7NOo6EW80PcTEwxeyxGsxfE4a1MbJd1m5O3toSKYWiXal4X/gTTdhegS2yRgHnjQers7x7IMpiZSzIsY1uliMpyfi9PGCfE91GNhY7uY7IbCNosj/Y3WNuL7IjuXMqkM9o8kJbzYWGwwOKruASg90MZgT375peEhPwByOhNSojMj8ua1na+/n5uEWoM/HafJ7MSUM3kuvqVvnqrUei0/AGphY9Kz1hsyFN9UwNh8vkzxxiB6sTi2+qLeYXrdCYp+jMjow+0kh8x3lowCjMZlri+xOg8XkURs1GIOParWeVcc+9m1dne/xULP43bD77qegg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8961.eurprd04.prod.outlook.com (2603:10a6:20b:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 03:03:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 03:03:29 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Add some enhancements for i.MX95 PCIe
Date: Fri, 28 Mar 2025 11:02:07 +0800
Message-Id: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f751d2-53e5-4f3a-f86a-08dd6da51d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+P9kNwb/hlbyppZjyk5rdL6DM9GfoOyj+KUec/D/jTpi9elYVlW3RPp+DvA3?=
 =?us-ascii?Q?KA5ojiDOUIhxsxRF8XW47qLB4aPHJPsn0ZB1dyutzzegqEH3uTg3DYUjO+5R?=
 =?us-ascii?Q?2lsYN7o0e9r6HNVsU8Dkus9FgWf+QkJvL7qgE0UOI43VQnS+CYDkfliDKW63?=
 =?us-ascii?Q?r6VbWygndozPZGivbpna8HCS6D2JjjbxFEtu/sKgst/XCYHKs1/LeJ71Q+Z0?=
 =?us-ascii?Q?ZISAjR2gZ7F2UoQDpkfNKeYL5FdRBnjQEnYllAocpM92ueydk0utPqFLPiQG?=
 =?us-ascii?Q?Rv3xj1tqH4cLiJaHa29I/2BIzx/cEoJ9sqicuaWtityoQlas7uHjjFAoKeYN?=
 =?us-ascii?Q?18FVM3ShzRPSJFkIYRuCY7ti0cvze5QBFPQib8g8u0h8jZ/QW+VqNo0PZcPM?=
 =?us-ascii?Q?7Vm6IxdhZSkm1WJErcgDO4ZhDPaZoR/H17kaVp9KSHP0/nZY9itaEnWkqBNN?=
 =?us-ascii?Q?8754XEG1V27oE+JtkN4fBK+VJgHq/zgsXoN8GYo9PLoVdALqpgazHyJgjZkx?=
 =?us-ascii?Q?D/zEYhUMKJsJF/TR8lvY40+Hvtsm53fWSHgTYMHJaglvhTazQji2rLRjquj4?=
 =?us-ascii?Q?E9v0knLwIqMNEjrlrMU0R3MxMy4CUBu28Jt8qAky8vYxAut0tMic7zMeXFOJ?=
 =?us-ascii?Q?q4qHU7lzTeSAMnR2yKgkH13sO/FzJKBRdSUdkrhbGtb7t4D6JwJBgHzVOp13?=
 =?us-ascii?Q?5bZGT34JPrRjGS9ee977nxJN8kqSUExhbjmjF9NBnQ9HyI4ozODJdHv6hyrF?=
 =?us-ascii?Q?TG7LmMxK9O/azvGNDuC88FIkPFgle7YoOEQ/KSUQuCxAJBonFGJSHCo/wi5z?=
 =?us-ascii?Q?uVgPtyV6iu341c559GIDtx4Ew5LGV44aorAPGMGrauyCSrVKhPa760xn/NqR?=
 =?us-ascii?Q?IObRijSluSSa5hLrZffErpQIovgYAp/7grylrUgJhci6Izn773Gge6aXORUN?=
 =?us-ascii?Q?0kH3AY573+jBYL5aviojREj++j4ZUyBD5xz17ksnTK/RCfrWf6pruFFzw0L7?=
 =?us-ascii?Q?T04aSpT2jxOKQ6QJ4UMTFsieDor+K1xXTJI+/mMAQKQKbr7eHHDeWMqny5Po?=
 =?us-ascii?Q?cgvufI3ywyuhU9PBEe0AlNKNZvvAtH2ldWdoUuOof4euJiSsE7VaSorjvbrG?=
 =?us-ascii?Q?X2Dcggy9724Y4aNMSyF7rQg9zb8fdXeaPzEkQIIstoQYlxSMtFIQnfOKHnCl?=
 =?us-ascii?Q?yQsSdhBISbykImCcYwBYpDg2n7rG9q74enjMbdsOpN+BA+JPcuXGTVNuWvAw?=
 =?us-ascii?Q?BWJIOXrNa8HdBfo617UA/kDgKARIEdDNMTCE30JdTxWwg8usNHD4MMJrSgsv?=
 =?us-ascii?Q?UhDoyfUV1UDUFjKys3ScY0IYO45YgC8vxEPPDQSJmlcgieBwMTnZ7Qq3RaDJ?=
 =?us-ascii?Q?BVXGDkdXZSCw85ikryZa5D9dZOp0GelF/j7Zi+T+ezd/qib5BUhhuS/u0Ra4?=
 =?us-ascii?Q?I12Ga75gYhfx4+HHoKIKTrmWGBi6vEb6dsn+rwwIeCfB/voauXbIYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6E4u5XZPlA96Mm4Gr8PK5c99AFjYbjNEQyZL9CPnZp1S0wHtno8LKb4Zrr2j?=
 =?us-ascii?Q?wOzsoY2hzlQX+aiBuZW3/PSPe+AsNfF1VtCvqkY5vXKVNqjYTUNI2OETE2Ju?=
 =?us-ascii?Q?Xm9gDhWE3WL5Lhskh4yr4epG26tbN7f72o0kesFRGMpN0rwyd4z1KZMgfsT4?=
 =?us-ascii?Q?ORTaRjSIFj/38H7ZTsGyU80Ar4R+a9pHwV8YRcv5bpbbn5HbHY3dNx1NfVmk?=
 =?us-ascii?Q?Ec7NV8FvFpt8011ogvZrcGDd31Tn/lFyqxW4tjNEAflWVclgsWvxFcSPBNCB?=
 =?us-ascii?Q?BYGTjumIJLDJO+n2EEOON5dpFknk3Jsky5K/tzBPjsGMRXtKrI8s58uNfAGi?=
 =?us-ascii?Q?XbIBIiR23gSvhqBa9fHs5beHdrQRMX0Ksrrsqe1dtC0J7ag32dKpOwES4PG5?=
 =?us-ascii?Q?vbHTXM6zaYhaB2+EW05wZjEIUeNe+mC0m/5cw4lTsLchj9qEGhheS/z2K3/5?=
 =?us-ascii?Q?mPbbJr+HHRmC6jkAT2VuJeRTL6/BkPesCKXhUWA4o9BMUUDQ2FJNY4BC5OQy?=
 =?us-ascii?Q?HKWdsjTBKXECU5nL4exN9N62J72dhJk9HW20LVM85q10jJyT55Tj4IWJJtbe?=
 =?us-ascii?Q?7B8uOEWvaVXqcvyORD7Db1+NZsmTJvV7ecETcttuQSLhGaOMHct9/e/D779C?=
 =?us-ascii?Q?fCQQhV11OZgP8YnEfmfcWciY78P3Dqwsa76Md51GbpkUunwU860McE5GxJcA?=
 =?us-ascii?Q?SbtxIyQigtXYl4BfkFWirOUOmI9W2Qvq9j/05mnFKkNSah+dCF9ugGOs0XX1?=
 =?us-ascii?Q?4kj2IRFZBh4k6DYI841lAgrmXAgBIi66VCq6+kQxmx2ABbWFUuCuZVKVq1NT?=
 =?us-ascii?Q?Ne/EAcBA+Tf9qPrVwdBjCRvLGNrLBTvs/9fQcndYjPvDELxJQEqpciHXok88?=
 =?us-ascii?Q?6GMRWeKFqEfzeO8Ovvl7pL0sYQyDPt9fwo44IFInj3VXeiGoD+8t8Gmv1JbR?=
 =?us-ascii?Q?9s37zxHtmYoOMZwPbV9AsqsRLvdFa7PYDzUS1U5jjpnzPzWWIebYGjrDRMje?=
 =?us-ascii?Q?81DkuVV1Mnar3h9Bmu0pVzpozehY3E3CoOplfdErZpJfKjllKfIYtpLZZRj0?=
 =?us-ascii?Q?J+csNdE50raYCRt/XcMxfgkgsu/m98wW6bWy+Lar2pTFOynvKV9kc0rBacNT?=
 =?us-ascii?Q?iJBusn+v3fnnR9b1bKB0zMhxhDidbZyv/HqZiDlKi4oRJJ0XN0ZdPEsxgmw2?=
 =?us-ascii?Q?ib6L9aksR0m0WcPhvXoEXWt8B5ZfqHUHb5eKqokCikwPw0y8JGQoKL4G7gU/?=
 =?us-ascii?Q?iJgAe1F3eQahg+RCYJwjDPPc8tiCfsEfxCYawEdNdOHwLgWUVRbS8FWOWbAr?=
 =?us-ascii?Q?KLT7jKF75gxzZfZPqF+7mhESs9ixNfQmb2SJnn+lq8QHNizbOeX+uYyazfJb?=
 =?us-ascii?Q?ae5m+3j1ABYmR6retzurXMpf6LzvgqHoDrdB8On2/8Gm4Vyej2bI5+NLZoM+?=
 =?us-ascii?Q?GpbFfKag/RwxkER74sqXwXQPuAP6l1SRt8JLe4O6KXf3KA8i5h2tXodzDNLw?=
 =?us-ascii?Q?NgiDxhi9aTKzfe3kS8EfUBEz5BHOxWnBTAcUOsNSO2i4Li9pGjMDrD1ULNCg?=
 =?us-ascii?Q?57QUP6UR4cpolpd1+pwUvDLGS1qjM9GFzp+QOT1i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f751d2-53e5-4f3a-f86a-08dd6da51d5d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 03:03:28.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JonEal7/0ZvRjUh2mkaRgO8qK1//sso+hjNtktlz4McE9VJ2zpQGOaHRhtlHqXKh6iM5NOaFXZtHysy1OOa0Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8961

v3 changes:
- Correct the typo error in first patch, and update the commit message of
  #1 and #6 pathes.
- Use a quirk flag to specify the errata workaround contained in post_init.

v2 changes:
- Correct typo error, and update commit message.
- Replace regmap_update_bits() by regmap_set_bits/regmap_clear_bits.
- Use post_init callback of dw_pcie_host_ops.
- Add one more PLL lock check patch.
- Reformat LUT save and restore functions.

[PATCH v3 1/6] PCI: imx6: Start link directly when workaround is not
[PATCH v3 2/6] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
[PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
[PATCH v3 4/6] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s
[PATCH v3 5/6] PCI: imx6: Add PLL clock lock check for i.MX95 PCIe
[PATCH v3 6/6] PCI: imx6: Save and restore the LUT setting for i.MX95

drivers/pci/controller/dwc/pci-imx6.c | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
1 file changed, 175 insertions(+), 22 deletions(-)


