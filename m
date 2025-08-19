Return-Path: <linux-pci+bounces-34253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAEFB2BA72
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358523B82EF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5412848B4;
	Tue, 19 Aug 2025 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BYGTUgY7"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6122223D7D3;
	Tue, 19 Aug 2025 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587827; cv=fail; b=KQ+YVeEFXd+0iMOcdonGMABdlOrdhxz0PzLRJovvrcwaO8wgj8hs/i4V8E0WGB+CdGoJxugg9JAQeTHZtetP6x5rNHJ25HGX6egY4bWsv2V/x+nbZb27Y7Kgr3eKC4+tMKC8rfRqFPOJQphlWiq3Cu+GiO/qYsew4jt+NXWnW5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587827; c=relaxed/simple;
	bh=X9S9gdyEICtaid3bTSTjutVM+e4ceYqpD7xAwKTQ2g0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DhoQ25UTjBtvbw9hM3M7tCAoeZPmJdToweaeHLkGoXolW9JDYendgnAiX79Cn73EWWj25/0dT7wLd8g1BesrSrHXuV4vCSq69CVB9UZUZkzrZmNEsQG9CAfBOVrVFrbQXBTnDgGVKVPAQU7y9I+CWiUZSn36V0quwFGywNrLX/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BYGTUgY7; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZpm5v1J64YWojdAymnNLvaQlDVjiMyKB8aS4Uu0n5WhTbAQt36bK/3DAtqbRVf9U3E8S6STJJib07OvlOtSqkde9Fi9lztgZ78+0x+ToGEQk4J6yycMLqZ9BeT0ilwRJjltFO84+OC25CBBYQxRNd/iXI1rUp+CxhrdPNQhlfppUnar3doWIz8TDOBnVqe3SQDQ1QXSUU1axHaIhIvFbUwIXbceQT10omKtLjtWOpdKKsLiIRsQjfcbLwZEa83Sf3/ux7dL5q5oerAK7Kwcxux3h3jcuTKhiHmcVjbsyJfMdDnUNqUVwboPyPgAm2ohz9mhcY1kYoduNxiLC4/VhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/iTDUFUhY0PqyGeOV/E79QsspMAqoC3L+nUDb1i/Kg=;
 b=kmkUmfYnP8QxWFWK0+K4fC2o8Yyz4QU+VIIHptOiew2SSa+v86OSaKrSfXU6aZN3iqLjRNksfRE3kvgWahO+UTk8RhRkdF9nSMUz4MYxWBM+PcyZccRoypRIAgOnf4aMAD0i2GwZw/kP+Tr35aR/aI4eYbtu6v6bldHnSBfVD7snO/hf0w7/zs7DPs7Ld06ydiWI0my5UXQzLZW0JcO+TC8w/zudIa2++87zFtTI1bpAv/rS930/kLwQG2aImCge67Rb0z9BzFMsMyYnrL2/4eRbPRHfKpuNUqjYlPOvako8mZnndSmlti8CsDlJ2+s9lmpluHhcB5OmsNhrUF3zHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/iTDUFUhY0PqyGeOV/E79QsspMAqoC3L+nUDb1i/Kg=;
 b=BYGTUgY7MGMUssbbD4pUlQMAPd96Wx2W3vYadsA4lZsf2WXWgeKTLHspawhFqKGeQ2a45Q9Wpc0LJMS5DxLqxxS9pETGoLhdHuPth+ESrQKg32a4KP5+HETK6Xc1IduWY2huxerezDkewl7wKqhwrSrm+efLIdv+fqY1j4TaRoma/fPQNrOFJAG+5JEMKvfW8toMczrgQY9R3Yg9oDbHNperKQ1Wc10TlYcyBAjr91GsQY04C20NgAPrBkl7Fiu3oBFccu1rQ55D/+0M9qvu0B6UMcIuUAZbiYPewicM/5RCMU9B18jUDO4adBB5IeALeDW1i1L0/Q1+YwfTw+BZcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB11527.eurprd04.prod.outlook.com (2603:10a6:150:280::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 07:17:02 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 07:17:02 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] PCI: imx6: Enable the vaux regulator when fetch it
Date: Tue, 19 Aug 2025 15:16:28 +0800
Message-Id: <20250819071630.1813134-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV1PR04MB11527:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f91b5f-562b-466c-fa5c-08dddef064d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IXBEgqZL6sdud2+I2kvMgUI8DWl2GtNW7sFwJdHgcLRPC2zhoh2jA7ncOiGl?=
 =?us-ascii?Q?15Vn0/U4Dfwh47+qeUEaws7up1AMy5043jOKd5KxRVmyYFC/jUMyj6PdqXfr?=
 =?us-ascii?Q?i/FZoXOTFA8ilM3k3G08wc5JHY9X77jprjFiKnqBtQN6inea7HBsFBeCMUaq?=
 =?us-ascii?Q?rsTMpgf6Qxv2q2XLQi+yN6nVjrbeenad5fpnogzS/+AC5tMbwpzVYtQJYo07?=
 =?us-ascii?Q?ZpCD+pKbM9/RdIbk20gji1P06oSXBxxkP3YFykzGeOi7SPeMdEjoJEEkpplv?=
 =?us-ascii?Q?CJ2dSHFGTouu5i0auXg/FZMt4lVm/hEs50oSbbWb5Q8kD5Sx3+CexzOTBS/4?=
 =?us-ascii?Q?rEdv3PyjlbShU5ijwtBL97jgna5BaZLjc7GnyoSjHppatPLV7ydfrTHBJEEq?=
 =?us-ascii?Q?VALDvESTtuxzL3ah+wGoBXMdDhiFqs6rlq8WQVMGI68DHM+ruXsbuLVHT2q3?=
 =?us-ascii?Q?P7Lw5HiouD4DOVGihkptLPYsB141FJAUCUtiXtRryCbFBKWVCdaIiqR8BjSC?=
 =?us-ascii?Q?EQ8KAg3DSYgqd9Krgo3Vp8XF3eUBL+Di2A/8KS2k86x8wvqyh8KH6XEfYGMa?=
 =?us-ascii?Q?XjYiUuc0dapooRYGDVifEYEa8sjB22C5kNLZ1n+z52cfi2oD5pbti1UUpP4q?=
 =?us-ascii?Q?edpXzql3QOWkCc1V13bChOlUJY/oOyGpqizSMABlliX83/7ymbrzeVkIRtqu?=
 =?us-ascii?Q?TzCDLl8uBmwAkaeBSooSZGZZ+BD6PuunNvXAcg1ck6joxCsq/iBQIWEzWX6r?=
 =?us-ascii?Q?Z3GT5Nt0Dcvb8/m9WHZYLBhJ0bJZO3oB7P3V3cfka3Ltrt+q85ram2mrToIi?=
 =?us-ascii?Q?GXolbWcnp/HULT5+GSfhiDiXy6rSr4GbO0BFO26qucxaZIIUZRmDayLWWMXn?=
 =?us-ascii?Q?VH9Kvfp29c+gUzGlsSNCFycApWwoJT2d3mkMfHOo6mxr7v8XL1PNmyrSmBm9?=
 =?us-ascii?Q?8Bakibfe5/jqocGhQwVMTfMY3I56SsK4HhlnMQE3spnnF2t8IEGjKeqhoyeh?=
 =?us-ascii?Q?+gFxwvan9bbhvH4qDkpnGiElnO/G8bYfjPmJi+sZoiBtVXtAuX77mV0fkXmw?=
 =?us-ascii?Q?n++ljEDAmUylFRSEYIcQ5TiDEzmzZGD6dAfft7y35IeDqAskwY20Pqe6R5ZF?=
 =?us-ascii?Q?mwvWWBEpJxwK6x/0o2zWI6WIPteKjiyyw1/Lpfvg4TiekJQ1GQZdn5BXfa7Z?=
 =?us-ascii?Q?mLanaeveq6rSCWhneiVpMHMpLbFnQu1NgzoVLQCMVNWEy4iwl29+/3R6bru/?=
 =?us-ascii?Q?WDCCbto+jtshQz1wBtwGQ7S+E8fsCdlFiyccNzfEvrVsJcoF4p/AeSchWNo0?=
 =?us-ascii?Q?fwcCg/RllHGWZWiwXILF18fk7QjSkZzdEyeV281ZD5c+tI4DXEmUhaSpN3g1?=
 =?us-ascii?Q?zZzxqzf2yqnVNCgg7P0EOniVbulHxxrXse5MbRPdnjzZJJ817XUXnZOwApT5?=
 =?us-ascii?Q?FX9QtPMcB+pAUQSr03skMk0w5mxl5+yVvmpl0/dQbLKMBVNBGHEffUYvof7X?=
 =?us-ascii?Q?RNeG2HyFEL+5bNw3nGFjAtHlu9hZxvWTjs7T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MkZOjPuSQtV1bvlgkcLmXJx8DsJCZ/FZigg+Dsn9NOwxZd9+Vu6CK+kfABot?=
 =?us-ascii?Q?FrZwXcXYLdsf08UgPMTmqEcm06FnQmCgMHaFjR/qaneSD7/UeKR0TOlYmteC?=
 =?us-ascii?Q?bOZrrWlPEsGbkjfE8xRlT2WyQZL/3d1jjeTI15K1CTkl36wkkWkAh0evtWjs?=
 =?us-ascii?Q?DZ02/ud3Ws9gJhy6tLd0dydCPwaBBW6sR/XFiw9zUuGEYVt+1hhi1kn7+3dk?=
 =?us-ascii?Q?9zkipvVKhdS88WZkR+lHM6qHfgeHXNhsC6LeZDpD080K6d6EQmTjzhgh0HGA?=
 =?us-ascii?Q?3ZeYzjOVqrCf6FCD4h6SBG3x9Cd9IQniERnOZsoWkrrkhJVY00MhNyrbFCUF?=
 =?us-ascii?Q?ILjN3d2XGwIMO4o6ntIVyO3WMeclYSUTz5VO+RoH/3ZRPUgLz75SCISKzGXm?=
 =?us-ascii?Q?25y2cS7wGs+7PHh88NxUthg9p4t1Sp0DevR5+TkpBb6bNgGqmSXNfhAD5aXL?=
 =?us-ascii?Q?jKOaCLj0TzEXnzMlhnxzgBWEzomupCl0OlHnVcA4DaH2OTge3Gjh7H4PVWTy?=
 =?us-ascii?Q?n7uo/9T1GBfiqZMPfiifs6K1PHL1sc0NmgWTf9VO39hvR1TSiuKOjvc2HEDE?=
 =?us-ascii?Q?xJN3cRmavh2bqJAbgJosddfOCr6ugr9PPgkXUulXOLjEX/3B8lH6Mrp4U8d/?=
 =?us-ascii?Q?pv9WWNgOaQBThxmxf/XDDVfxQnWGO8EazacwXBNxk2shY4UfcOtP0rvro5wK?=
 =?us-ascii?Q?VvDjFEIYDteDEYxQQyab55pUsmC73GObRDvbs084+5ent5FG1vbmZeFxcU83?=
 =?us-ascii?Q?pN7ih+VhyrlEnRKd0FfsrqO2A+yishfiK74Bv9UnZtM1y9oI5+wnoGJmMtm5?=
 =?us-ascii?Q?7nsO8LR6pt7wW2KkS0LQXHcU32U2YoJHBk0qGxUm+T8ivL8THxPiMx1McbUJ?=
 =?us-ascii?Q?zfDQTiZx9tGKjH0nKgxV3hIaMBE6/Twi+ptcKZztZFc0Y6d7K/HkZ4B/3UXb?=
 =?us-ascii?Q?9z7nCZ5L06eZHHUyzpQmVPmj7P+B6tKC/xUaGMSXBwZe8bdV6X0jVbr/rAJ1?=
 =?us-ascii?Q?KkdPf/NORscCwU/96fz9Kq29yDufDbQMY+Ex/DuhoRoKmRqfmDI7vjDlw6hE?=
 =?us-ascii?Q?VRvQDNWWm0FPiBGMpQbK2hdSOxn3VfsIMTAFr3zTrPeurs5uwD6lzsgKkDCl?=
 =?us-ascii?Q?HVpC+PJP28FOBQqt1rG1ipGD6USMRDec35jFb84G6wWo6kT+BXE5kVivaIAd?=
 =?us-ascii?Q?J3brohUPo8EOI0e19jmkr2JULRfwO82YvnIVMWmLIV9Hf2HqRnqEY0g5Qyi5?=
 =?us-ascii?Q?ZEIpQqOLfqndWCYbVjdeLK+1/nIvyt9FtxQLVXMAERLrChnAC8BwVjlzVEO+?=
 =?us-ascii?Q?5Rh7fCSzQeKCpN+yvi93ckCs8Xs2k42tyytFwcS83xt7jQzUHmZ62eEKBAOO?=
 =?us-ascii?Q?S8aRXXEzXNmB0ynpCq02qMGvljqe3GFIFlPnlJY3aunneU6kBIcSGJwIVFdM?=
 =?us-ascii?Q?Lcf4a/jWLX06BG2zJap16YgqDPoZcKvfOtFRRXEkY8tiXgS/266Cvh4acOE5?=
 =?us-ascii?Q?yJUbYn7srMhxtF/ajl1LBnG6tIY/PXcGEalr4/c4gfwbRNLgPDAxBVauFMop?=
 =?us-ascii?Q?isFUh4sKlzc7YwYLg20H+q8rUW2GJsXF3FOqlQVz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f91b5f-562b-466c-fa5c-08dddef064d8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:17:02.5209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnM14VZbHd4DCa6w1UHQHcuq2pv8JD/5DjZ5THAmlNtsYWltesoeYsI5WfCAG3gSfq2tLBdBAZxwBRX42w/KRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11527

Refer to PCIe CEM r6.0, sec 2.3 WAKE# Singal, WAKE# signal is only
asserted by the Add-in Card when all its functions are in D3Cold state
and at least one of its functions is enabled for wakeup generation. The
3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
process. Since the main power supply would be gated off to let Add-in
Card to be in D3Cold, get the vaux and keep it enabled to power up WAKE#
circuit for the entire PCIe controller lifecycle when it's present.

v4 changes:
Move the dt-binding to snps,dw-pcie-common.yaml.

v3 changes:
Add a new vaux power supply used to specify the regulator powered up the
WAKE# circuit on the connector when WAKE# is supported.

v2 changes:
Update the commit message, and add reviewed-by from Frank.
https://patchwork.kernel.org/project/linux-pci/patch/20250619072438.125921-1-hongxing.zhu@nxp.com/

[PATCH v4 1/2] dt-bindings: PCI: dwc: Add vaux regulator
[PATCH v4 2/2] PCI: imx6: Enable the vaux regulator when fetch it

Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml |  6 ++++++
drivers/pci/controller/dwc/pci-imx6.c                          | 15 +++++++++++++++
2 files changed, 21 insertions(+)


