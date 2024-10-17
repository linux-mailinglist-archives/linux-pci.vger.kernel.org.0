Return-Path: <linux-pci+bounces-14741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA79A1C5B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53041F26CB1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9850C1D61B7;
	Thu, 17 Oct 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lF85+CB1"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E11D6199;
	Thu, 17 Oct 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152135; cv=fail; b=hfVf185bw/cONhe+M/NWLUGhY8Gj5rfd/H0H38XJ0RA9KStK0XG/WkQRXTGc/r09Q+sSGrhI/3ZTJOK9deililrxHfH4HuqDIKhNvS708QoMH0fZ79KbKM5TPHdSEIoV2Q5VzK/NRDXZaoRQr2Rfq6HXaiCLy6ceCGTz5cs3mdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152135; c=relaxed/simple;
	bh=8Z1eu4j6DOwvTJ+fFC7iuBLpLkLa72jg0kchNnqsi9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bcoayJONSnQ1qVsJE23qL/56MulvdZ3uHWc16KHiYz6QPi2sEufsO8PuQXuVKzwec2qRPLHiPt4Ap+ND+wMlqk6grN0nQSoAADzD5YEENmNXOdkDjiHB6iWAL/AyCkYumlRvCaN6S+kqRNaTT0pZDJ2QzVGI2nBcqdtk1KeXc8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lF85+CB1; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtuZprxyszTf6hlshnCxmEIHiZuIHOUYb+1DhbdU6fqYr+EtpcMH/37Ag4DDUs1zyQsAJLUFWIxW+1XWPFZNyGSHV2orsO1YNA6OG993S+S+XUzz3N6+VYjSbf6kICGEVupiI8Wf+jhOPG/LQQb/+ZVC3cMEp1ZNZFucKdKU+l4+mjknq9beH8zKh62KQ9oJ9Ayng0LWhz+XX9VLB0Kg/b08NY5hZZZkxD6A8yk/7KQIlCoXPmX16VBZRyWDNdx9Z9c4GHzqRD13gTDOPU9kbwiv4wQ+ZUJlIsXYFlFXnEgfnn0K2GVWJCD3je3x+R6xWkZNAU/UKiALvHZcB4D8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5wid+DqQr9XmaC6awFr6Q3F+OJPYDBTWWwyNrSGhmA=;
 b=uIRogjxA8XEvKYucqOA2SAwjULHk0t7xsajxd/8cULfcrJhX+jR6zKMh0prEVVGeBYB5l604Lfis/gaSXy16e0t+WVdE4MHR0JIGyd8pT4+UPJBi1KsuETZfqBqE0I4NzwkjT5i3YBf8/LT0LP2wLW1K8SmodKKHPBThRQjwNwJRM0Zj3JSmj//wTaW0LmVhVFD/NkmnZ5rfBYdBVCgRP5ZTZWmNGEZ3bEiaLWLsXleuuhN5CTs0MFUXuDl4xkHg8Oxo0fLXI42RnODq7tIPJXc3s/jxiTjEjIEoQ1A8P+lYXeLBcI7oxby89LsnbCu9RfXUyux81AUZa5XKZYSWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5wid+DqQr9XmaC6awFr6Q3F+OJPYDBTWWwyNrSGhmA=;
 b=lF85+CB1/2HifUIMdMa9hmmu472su50baAYbrwBO9VjniNaQHWG7g8+PP7fD0CLzwwt4ilbuCFz8A57K7lmfMVjfkS2dz8U+2rE9dT3pZweTPLCuBOPOmJZjAqwODk03+VzimmhyHBxMwrWqmFYb3UxqvEDJcVc+uBacOiM4u2+zyFRfgTR5/XWq4tzM/PwnNgfSGatDJJaPbnLCTMFbLFkJWS4yUYWrTRmrdH3bc/PRBXVDotk7ukKNO0SFFFWkyUbHsO/NVoeho0W3/lvW72wKwPVXNGEFD9F7m7KvKeak+CZKfcLmweoSEe2yJD2xxGb6m0/6sPXgjho54zrnyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:02:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:02:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 net-next 04/13] net: enetc: add initial netc-blk-ctrl driver support
Date: Thu, 17 Oct 2024 15:46:28 +0800
Message-Id: <20241017074637.1265584-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017074637.1265584-1-wei.fang@nxp.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: ab113eb0-cb57-4bee-f99a-08dcee81ff41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OZcYHifVzhdi91v4pUf3yAVG663gqr6K3oMk5efgK1gICrFcUmbcd1h3Q86q?=
 =?us-ascii?Q?ZC1X+M2rPtw1kTXiAaFrvT93ufDOQnqpAb9RUOY8Tj90o5VixbEqwzlPXtKE?=
 =?us-ascii?Q?Vz+/0XSbomsrrrl1JH/48Ouei7cBb95obpBcql8LLhvof0EexC/HVkzvMeil?=
 =?us-ascii?Q?PLHGP5ECWABxQjHtmB3YAphACoA+/9gMGdar2vNDdiZzm7br/45cxUxnMKzb?=
 =?us-ascii?Q?jw4R5ehjL7hiVFe7dKPz2tS1L+hPOVBmKMmEPjduIrsXd5DlCE1UKNlQhp9Y?=
 =?us-ascii?Q?kyJ/sw24QjNOwRrfxakwOG0rhK+N7Iz6ZY1ZL1lM36DPGBDAA60J1AIQPyLJ?=
 =?us-ascii?Q?hS47ij+co+VOryO7bJA5gW4vElqVwhCdFWFYau1O4moqPlE4h3AOQSMdYZwa?=
 =?us-ascii?Q?D4tsUGcemRW0nClbrJ9NTJrONpZyaaM8Y91tZrT20R184GmAzHvKGpwIzfSN?=
 =?us-ascii?Q?f07ihoSbME5nIHBQ1As2nUDFZtxEbQjiiIRdm1h3o+p3+j+Xs6OW0pHQw2dw?=
 =?us-ascii?Q?HwgllfmATG7x8z/RhP0V0hdaWxHqMreB5w1Nup9e+KQTut6C4rcDU0+76uNo?=
 =?us-ascii?Q?PLmUvJSYgd7cjx0CfEVUrnYGJj960RJwZQ6a00t9RhYhK2gEncWyPUkbUagY?=
 =?us-ascii?Q?cilAuc2ckGPfg/UzrodaRL5UAn3Vqv9ahaUdids3qxnX2HvJTHstDZgCLwkb?=
 =?us-ascii?Q?F6iQx/yykHovkaetu8uBiZ14AClFwygR6UcpSP3nuEe6e3JwUBwHcOGkkiW8?=
 =?us-ascii?Q?U9kZKwC9mSJM4qF+Op+l87X5+vPm3uOw24TXHxHS4OsnvdahufOJBYylBc89?=
 =?us-ascii?Q?Pw4n9/DSrFWmL7wCSeM8BKRlXIH2ZyBkMrD0BN1qqXAUuE549Q/gTO7e2q5g?=
 =?us-ascii?Q?hyOwsUEfKDmNY9Jm6hb5InpFKyH80XrCsP8hmhd2Sygr8XTtc8qgGZ/dZD3k?=
 =?us-ascii?Q?EJy0UQ7OnHKOXaXnsMbvzgkwpHhtxpcxfTIvU3xnnCEVMRQMx2ang9uhQrkO?=
 =?us-ascii?Q?7eByB/eMHo8oCL7+tkFGTWAFs9rH/heAKqwcE+Ki8OkQJRLxjr/G/P1cEnbA?=
 =?us-ascii?Q?DjR1x6DeX9b8UKLHXjudj4yyfgk32FINJNS83JrOr82kA65wOOd8BeKQ0yCg?=
 =?us-ascii?Q?ZKNbBZsfMgZuwh5Z6aC3I57L8fdrDG61Csf/5nwO7XISLzFEOPidopXgpOAC?=
 =?us-ascii?Q?suHNEYzFqHKpRosaRKkwa3VRXNTU+okarSCeLIc1sFW8fAZAWehlTl7rHvxB?=
 =?us-ascii?Q?+CuPXoWCLNn8lz0QDeOS1ZH5xi9Ax09+1IblNTflQuZ9n2dhJyXj4EqWgGcB?=
 =?us-ascii?Q?D+F7BAuLknsIqFVZbZa2j/dO9jP6FdK3/8Yz0UqCOFcdcDemLRkvgnTjnrM9?=
 =?us-ascii?Q?L0Bc7sOMgVeR82TP490voVF61zIw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cbu9TBeumjxiVpQd57TmIuZfm1WItnPWZKLBwBLaDev5NezgegZcYVGdQr0m?=
 =?us-ascii?Q?RGsEUSMK7qX2hmL1ByVC7B8BpWbmwDSwHlbmZ31nVHECqMDC0KQwY3ACv1Nd?=
 =?us-ascii?Q?VJyjXBlOvpS7mrRq0GCFZs6F+zSopU4RHyBRGo/En450PodMZ8I4IrGj85tn?=
 =?us-ascii?Q?vs/OKRfxkaE1QFy87v62ZfrkEJWS5Vb2RlsozJ6wsZNV83TLnuMrr7tmy32x?=
 =?us-ascii?Q?vwt4KTmzApcnppog+VVaSWXat8bjq499Wkvu9v52iGWIC1r1gCuEJIdt4aIz?=
 =?us-ascii?Q?5s/CRovi/ZDyHHNGkhuo308CE/69X+UAI8BZHz7C+m5iGvd3XXi1dVShylBH?=
 =?us-ascii?Q?71WWC9Oo8ahOxxy18x5z+ardjMxBnDoz9H+J06WkVhS/Y/MLcKx9+9KTrEBW?=
 =?us-ascii?Q?k3aESxjP1g1M5h/7Zks4WNGlm3aa+n69E38s4RbX4+ErnQIXjZjpDndr+tM0?=
 =?us-ascii?Q?w6DxFq1BMQGMGhJYrmTz2Dd+6ebFi60M6rKJ7RkL3e/Lxcs9dT68JRbZlJ8a?=
 =?us-ascii?Q?6oQ8Ok1FFWp52jqO1IttOCtA55cLCUBB/+4vzfQroRoik7oGP7MuXIY0+74B?=
 =?us-ascii?Q?Ub6DnoXSUkdBbpWvRRQhKBpHi52kDagrp0QrFXW4RXNHzaUIRu+O76R441sL?=
 =?us-ascii?Q?F4QkHM2X5YdvCQQ3za7WLpBArnO2OJaeTcReDQiud46ZQxg6LVKNGmj4sXUC?=
 =?us-ascii?Q?QGzsFQJOnCwiAktJDl+MKAD3/Sc+oIKzZMiR7v6nY1yVwflHHoO+djxtkrZY?=
 =?us-ascii?Q?HAB1WjGo8oRviG/3L9440TOcgZSwdU90+zKxCmV89yo5Pj/P9oFbEusOccDC?=
 =?us-ascii?Q?f4+h2T+U7yemMeYpArCPb1+061Llig8POKx9tS0gWTB0Lbfb0BLUnhWeLiTD?=
 =?us-ascii?Q?caS/ulCtCPYaUyCAixDOQVy2YlIqnPxxKACrWG2/tFMZxw0DH7WwX4168e3q?=
 =?us-ascii?Q?hsjE6TD2Doqjw6l7MxOslBIkzMHclXGFs/I1NTZWHdOwlYbktSCwdNABiP8U?=
 =?us-ascii?Q?hLlY1cTGkOZ9PXWEakOy7XdaBYLc+mjfBtV4fetLg7zvBtt5k2w60kxHlPm7?=
 =?us-ascii?Q?DUHgjRKHIxLn2LCibS1KEB7mVOgxPJ1d6jZvBiuQXtyAlQMnTmoLoGXpmbkY?=
 =?us-ascii?Q?nS1MqcVF28uFK3bd0aBlqR+EGmb0+YNmZv4TBBOUGNYPtJ5cjkAyVWBSOLkE?=
 =?us-ascii?Q?KJsePabkmAuMwB485ikmN609VuQcd7Nbsw+yub2B5pn/1m9zLPgPFilDQTr7?=
 =?us-ascii?Q?twjsBE7CiQOhmil959obNxQ8szt6AgznCk/afRSlOTiZdOuYNzJF4Tuup7Yy?=
 =?us-ascii?Q?bIAXCNOb3bt6Y2PuSd+SMZk8P9SiQTzGixf/DG8RSut8BhTvY+uZNddeVYPB?=
 =?us-ascii?Q?29tRjRhnVnmUIDlHZJX+Z5+WNH1PLHZ2GgAEqQKHzbtjPgjSlStPV6AYC7pQ?=
 =?us-ascii?Q?xG4z0xRTRmOoGEhzj3cFjLbBv6UExYcZR6ASmj+4QQmxil4n3bqI8e5A9YPv?=
 =?us-ascii?Q?kEB4Wce6Ed/2CqOzcGCCy6d6AxdZo2/BYN9ymGu2vbNqOWHrW59jLLKc9Dyr?=
 =?us-ascii?Q?Nn0U+Cefdb3X/ALIQ5nwtp2SN5CZeGcgsiVmHbcz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab113eb0-cb57-4bee-f99a-08dcee81ff41
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:02:08.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TT9juRvyVjH9gaKd653hnB0eUaoTFxRN+qleCSNANRSJz/JeHjqqMNIYmznJT06Gzc9MulRs041KknY+QmXa8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

The netc-blk-ctrl driver is used to configure Integrated Endpoint
Register Block (IERB) and Privileged Register Block (PRB) of NETC.
For i.MX platforms, it is also used to configure the NETCMIX block.

The IERB contains registers that are used for pre-boot initialization,
debug, and non-customer configuration. The PRB controls global reset
and global error handling for NETC. The NETCMIX block is mainly used
to set MII protocol and PCS protocol of the links, it also contains
settings for some other functions.

Note the IERB configuration registers can only be written after being
unlocked by PRB, otherwise, all write operations are inhibited. A warm
reset is performed when the IERB is unlocked, and it results in an FLR
to all NETC devices. Therefore, all NETC device drivers must be probed
or initialized after the warm reset is finished.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
1. Add linux/bits.h
2. Remove the useless check at the beginning of netc_blk_ctrl_probe().
3. Use dev_err_probe() in netc_blk_ctrl_probe().
v3 changes:
1. Change the compatible string to "pci1131,e101".
2. Add devm_clk_get_optional_enabled() instead of devm_clk_get_optional()
3. Directly return dev_err_probe().
4. Remove unused netc_read64().
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  14 +
 drivers/net/ethernet/freescale/enetc/Makefile |   3 +
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 440 ++++++++++++++++++
 include/linux/fsl/netc_global.h               |  19 +
 4 files changed, 476 insertions(+)
 create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
 create mode 100644 include/linux/fsl/netc_global.h

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 4d75e6807e92..51d80ea959d4 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -75,3 +75,17 @@ config FSL_ENETC_QOS
 	  enable/disable from user space via Qos commands(tc). In the kernel
 	  side, it can be loaded by Qos driver. Currently, it is only support
 	  taprio(802.1Qbv) and Credit Based Shaper(802.1Qbu).
+
+config NXP_NETC_BLK_CTRL
+	tristate "NETC blocks control driver"
+	help
+	  This driver configures Integrated Endpoint Register Block (IERB) and
+	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
+	  includes the configuration of NETCMIX block.
+	  The IERB contains registers that are used for pre-boot initialization,
+	  debug, and non-customer configuration. The PRB controls global reset
+	  and global error handling for NETC. The NETCMIX block is mainly used
+	  to set MII protocol and PCS protocol of the links, it also contains
+	  settings for some other functions.
+
+	  If compiled as module (M), the module name is nxp-netc-blk-ctrl.
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index b13cbbabb2ea..5c277910d538 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -19,3 +19,6 @@ fsl-enetc-mdio-y := enetc_pci_mdio.o enetc_mdio.o
 
 obj-$(CONFIG_FSL_ENETC_PTP_CLOCK) += fsl-enetc-ptp.o
 fsl-enetc-ptp-y := enetc_ptp.o
+
+obj-$(CONFIG_NXP_NETC_BLK_CTRL) += nxp-netc-blk-ctrl.o
+nxp-netc-blk-ctrl-y := netc_blk_ctrl.o
\ No newline at end of file
diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
new file mode 100644
index 000000000000..d720bb613b5b
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -0,0 +1,440 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC Blocks Control Driver
+ *
+ * Copyright 2024 NXP
+ */
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+
+/* NETCMIX registers */
+#define IMX95_CFG_LINK_IO_VAR		0x0
+#define  IO_VAR_16FF_16G_SERDES		0x1
+#define  IO_VAR(port, var)		(((var) & 0xf) << ((port) << 2))
+
+#define IMX95_CFG_LINK_MII_PROT		0x4
+#define CFG_LINK_MII_PORT_0		GENMASK(3, 0)
+#define CFG_LINK_MII_PORT_1		GENMASK(7, 4)
+#define  MII_PROT_MII			0x0
+#define  MII_PROT_RMII			0x1
+#define  MII_PROT_RGMII			0x2
+#define  MII_PROT_SERIAL		0x3
+#define  MII_PROT(port, prot)		(((prot) & 0xf) << ((port) << 2))
+
+#define IMX95_CFG_LINK_PCS_PROT(a)	(0x8 + (a) * 4)
+#define PCS_PROT_1G_SGMII		BIT(0)
+#define PCS_PROT_2500M_SGMII		BIT(1)
+#define PCS_PROT_XFI			BIT(3)
+#define PCS_PROT_SFI			BIT(4)
+#define PCS_PROT_10G_SXGMII		BIT(6)
+
+/* NETC privileged register block register */
+#define PRB_NETCRR			0x100
+#define  NETCRR_SR			BIT(0)
+#define  NETCRR_LOCK			BIT(1)
+
+#define PRB_NETCSR			0x104
+#define  NETCSR_ERROR			BIT(0)
+#define  NETCSR_STATE			BIT(1)
+
+/* NETC integrated endpoint register block register */
+#define IERB_EMDIOFAUXR			0x344
+#define IERB_T0FAUXR			0x444
+#define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
+#define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
+#define FAUXR_LDID			GENMASK(3, 0)
+
+/* Platform information */
+#define IMX95_ENETC0_BUS_DEVFN		0x0
+#define IMX95_ENETC1_BUS_DEVFN		0x40
+#define IMX95_ENETC2_BUS_DEVFN		0x80
+
+/* Flags for different platforms */
+#define NETC_HAS_NETCMIX		BIT(0)
+
+struct netc_devinfo {
+	u32 flags;
+	int (*netcmix_init)(struct platform_device *pdev);
+	int (*ierb_init)(struct platform_device *pdev);
+};
+
+struct netc_blk_ctrl {
+	void __iomem *prb;
+	void __iomem *ierb;
+	void __iomem *netcmix;
+
+	const struct netc_devinfo *devinfo;
+	struct platform_device *pdev;
+	struct dentry *debugfs_root;
+};
+
+static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
+{
+	netc_write(base + offset, val);
+}
+
+static u32 netc_reg_read(void __iomem *base, u32 offset)
+{
+	return netc_read(base + offset);
+}
+
+static int netc_of_pci_get_bus_devfn(struct device_node *np)
+{
+	u32 reg[5];
+	int error;
+
+	error = of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
+	if (error)
+		return error;
+
+	return (reg[0] >> 8) & 0xffff;
+}
+
+static int netc_get_link_mii_protocol(phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_MII:
+		return MII_PROT_MII;
+	case PHY_INTERFACE_MODE_RMII:
+		return MII_PROT_RMII;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		return MII_PROT_RGMII;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return MII_PROT_SERIAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx95_netcmix_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	phy_interface_t interface;
+	int bus_devfn, mii_proto;
+	u32 val;
+	int err;
+
+	/* Default setting of MII protocol */
+	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII) |
+	      MII_PROT(2, MII_PROT_SERIAL);
+
+	/* Update the link MII protocol through parsing phy-mode */
+	for_each_available_child_of_node_scoped(np, child) {
+		for_each_available_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0)
+				return -EINVAL;
+
+			if (bus_devfn == IMX95_ENETC2_BUS_DEVFN)
+				continue;
+
+			err = of_get_phy_mode(gchild, &interface);
+			if (err)
+				continue;
+
+			mii_proto = netc_get_link_mii_protocol(interface);
+			if (mii_proto < 0)
+				return -EINVAL;
+
+			switch (bus_devfn) {
+			case IMX95_ENETC0_BUS_DEVFN:
+				val = u32_replace_bits(val, mii_proto,
+						       CFG_LINK_MII_PORT_0);
+				break;
+			case IMX95_ENETC1_BUS_DEVFN:
+				val = u32_replace_bits(val, mii_proto,
+						       CFG_LINK_MII_PORT_1);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+
+	/* Configure Link I/O variant */
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_IO_VAR,
+		       IO_VAR(2, IO_VAR_16FF_16G_SERDES));
+	/* Configure Link 2 PCS protocol */
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_PCS_PROT(2),
+		       PCS_PROT_10G_SXGMII);
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
+
+	return 0;
+}
+
+static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
+{
+	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
+}
+
+static int netc_lock_ierb(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	netc_reg_write(priv->prb, PRB_NETCRR, NETCRR_LOCK);
+
+	return read_poll_timeout(netc_reg_read, val, !(val & NETCSR_STATE),
+				 100, 2000, false, priv->prb, PRB_NETCSR);
+}
+
+static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	netc_reg_write(priv->prb, PRB_NETCRR, 0);
+
+	return read_poll_timeout(netc_reg_read, val, !(val & NETCRR_LOCK),
+				 1000, 100000, true, priv->prb, PRB_NETCRR);
+}
+
+static int imx95_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+
+	/* EMDIO : No MSI-X intterupt */
+	netc_reg_write(priv->ierb, IERB_EMDIOFAUXR, 0);
+	/* ENETC0 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(0), 0);
+	/* ENETC0 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(0), 1);
+	/* ENETC0 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(1), 2);
+	/* ENETC1 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(1), 3);
+	/* ENETC1 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(2), 5);
+	/* ENETC1 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(3), 6);
+	/* ENETC2 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(2), 4);
+	/* ENETC2 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(4), 5);
+	/* ENETC2 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(5), 6);
+	/* NETC TIMER */
+	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
+
+	return 0;
+}
+
+static int netc_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	const struct netc_devinfo *devinfo = priv->devinfo;
+	int err;
+
+	if (netc_ierb_is_locked(priv)) {
+		err = netc_unlock_ierb_with_warm_reset(priv);
+		if (err) {
+			dev_err(&pdev->dev, "Unlock IERB failed.\n");
+			return err;
+		}
+	}
+
+	if (devinfo->ierb_init) {
+		err = devinfo->ierb_init(pdev);
+		if (err)
+			return err;
+	}
+
+	err = netc_lock_ierb(priv);
+	if (err) {
+		dev_err(&pdev->dev, "Lock IERB failed.\n");
+		return err;
+	}
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static int netc_prb_show(struct seq_file *s, void *data)
+{
+	struct netc_blk_ctrl *priv = s->private;
+	u32 val;
+
+	val = netc_reg_read(priv->prb, PRB_NETCRR);
+	seq_printf(s, "[PRB NETCRR] Lock:%d SR:%d\n",
+		   (val & NETCRR_LOCK) ? 1 : 0,
+		   (val & NETCRR_SR) ? 1 : 0);
+
+	val = netc_reg_read(priv->prb, PRB_NETCSR);
+	seq_printf(s, "[PRB NETCSR] State:%d Error:%d\n",
+		   (val & NETCSR_STATE) ? 1 : 0,
+		   (val & NETCSR_ERROR) ? 1 : 0);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(netc_prb);
+
+static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir("netc_blk_ctrl", NULL);
+	if (IS_ERR(root))
+		return;
+
+	priv->debugfs_root = root;
+
+	debugfs_create_file("prb", 0444, root, priv, &netc_prb_fops);
+}
+
+static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
+{
+	debugfs_remove_recursive(priv->debugfs_root);
+	priv->debugfs_root = NULL;
+}
+
+#else
+
+static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
+{
+}
+
+static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
+{
+}
+#endif
+
+static int netc_prb_check_error(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	val = netc_reg_read(priv->prb, PRB_NETCSR);
+	if (val & NETCSR_ERROR)
+		return -1;
+
+	return 0;
+}
+
+static const struct netc_devinfo imx95_devinfo = {
+	.flags = NETC_HAS_NETCMIX,
+	.netcmix_init = imx95_netcmix_init,
+	.ierb_init = imx95_ierb_init,
+};
+
+static const struct of_device_id netc_blk_ctrl_match[] = {
+	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
+	{},
+};
+MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
+
+static int netc_blk_ctrl_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	const struct netc_devinfo *devinfo;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *id;
+	struct netc_blk_ctrl *priv;
+	struct clk *ipg_clk;
+	void __iomem *regs;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev = pdev;
+	ipg_clk = devm_clk_get_optional_enabled(dev, "ipg");
+	if (IS_ERR(ipg_clk))
+		return dev_err_probe(dev, PTR_ERR(ipg_clk),
+				     "Set ipg clock failed\n");
+
+	id = of_match_device(netc_blk_ctrl_match, dev);
+	if (!id)
+		return dev_err_probe(dev, -EINVAL, "Cannot match device\n");
+
+	devinfo = (struct netc_devinfo *)id->data;
+	if (!devinfo)
+		return dev_err_probe(dev, -EINVAL, "No device information\n");
+
+	priv->devinfo = devinfo;
+	regs = devm_platform_ioremap_resource_byname(pdev, "ierb");
+	if (IS_ERR(regs))
+		return dev_err_probe(dev, PTR_ERR(regs),
+				     "Missing IERB resource\n");
+
+	priv->ierb = regs;
+	regs = devm_platform_ioremap_resource_byname(pdev, "prb");
+	if (IS_ERR(regs))
+		return dev_err_probe(dev, PTR_ERR(regs),
+				     "Missing PRB resource\n");
+
+	priv->prb = regs;
+	if (devinfo->flags & NETC_HAS_NETCMIX) {
+		regs = devm_platform_ioremap_resource_byname(pdev, "netcmix");
+		if (IS_ERR(regs))
+			return dev_err_probe(dev, PTR_ERR(regs),
+					     "Missing NETCMIX resource\n");
+		priv->netcmix = regs;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	if (devinfo->netcmix_init) {
+		err = devinfo->netcmix_init(pdev);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "Initializing NETCMIX failed\n");
+	}
+
+	err = netc_ierb_init(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Initializing IERB failed\n");
+
+	if (netc_prb_check_error(priv) < 0)
+		dev_warn(dev, "The current IERB configuration is invalid\n");
+
+	netc_blk_ctrl_create_debugfs(priv);
+
+	err = of_platform_populate(node, NULL, NULL, dev);
+	if (err) {
+		netc_blk_ctrl_remove_debugfs(priv);
+		return dev_err_probe(dev, err, "of_platform_populate failed\n");
+	}
+
+	return 0;
+}
+
+static void netc_blk_ctrl_remove(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+
+	of_platform_depopulate(&pdev->dev);
+	netc_blk_ctrl_remove_debugfs(priv);
+}
+
+static struct platform_driver netc_blk_ctrl_driver = {
+	.driver = {
+		.name = "nxp-netc-blk-ctrl",
+		.of_match_table = netc_blk_ctrl_match,
+	},
+	.probe = netc_blk_ctrl_probe,
+	.remove = netc_blk_ctrl_remove,
+};
+
+module_platform_driver(netc_blk_ctrl_driver);
+
+MODULE_DESCRIPTION("NXP NETC Blocks Control Driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
new file mode 100644
index 000000000000..fdecca8c90f0
--- /dev/null
+++ b/include/linux/fsl/netc_global.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright 2024 NXP
+ */
+#ifndef __NETC_GLOBAL_H
+#define __NETC_GLOBAL_H
+
+#include <linux/io.h>
+
+static inline u32 netc_read(void __iomem *reg)
+{
+	return ioread32(reg);
+}
+
+static inline void netc_write(void __iomem *reg, u32 val)
+{
+	iowrite32(val, reg);
+}
+
+#endif
-- 
2.34.1


