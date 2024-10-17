Return-Path: <linux-pci+bounces-14740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2D9A1C58
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01BA5B22FBF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3035B1D5CCD;
	Thu, 17 Oct 2024 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MV4U086z"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB11D1724;
	Thu, 17 Oct 2024 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152130; cv=fail; b=e3L5un63YBzmRX95cfh2e9A2ZOf9I2iCnAtyjXDMZKRlffB5YH3W2u6NeWRxKceNALBMf/c7eVxPXzo5hWua6qCBlRfRE7qL69m+m0VZS7u5UvqwnPI8HHHhGdlg0rvX6Q4JEaQW21kZoVqkUof0ZXFxw69IFrl5vEyFUDh6/dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152130; c=relaxed/simple;
	bh=7Eorn7VvnKKESj4BCBad4gEkRykE+GcIZ3Bnm2uqisQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKdPcXyTig7UFmoStvY3XSMqx5lsR3LpY8PAsMQieSR6VrDPGcgdk4OcUvdBeFo5Gm1Z1z4Sa+orWB9WXB0eG7yfOjSnbcgI/eH7GRDkphAbmzzr71Nji1uhZBRWZXNVHeAW50o3CpRUI95GTRI2tiK871PJ5A/f0aG+KLmxmpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MV4U086z; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/PlVWUkMIKfrpHzs/28XEZUVvdmQ4XmpyBsWNfIGrkaxbdKvAwxw86zl/ELde3lJZq96Ou6khtBE/LpFuefbXGrQun9q7fnwq9Ejv4piH1jk6AW7UW5W3Q12FFqHxls4A7YutoJHZl563LlHMCVzceLOoGO3zjIE+89c8E5ITrlQ/ndmeHZZfqkDY2Gdoid6RBzXcIzj1k1U3WpNLtsI0sHkO/lAUD1aksh7bqBOhIesBRq0q71snjGju9uQRcVs6vz3exGHjhFaIpSEC+B3jIigaSCDn897WSigl4G8f33vc0Zb08LjOEn2qnsl/V55Yy6ZobyCZu+FTmP+rGWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGIDOw5tcdN2+r5WU4QJiImwBE7+wtjAqm2/kczwxxk=;
 b=Bx2WgPJCYR1j7gL59XTxqAloY1z5O1ub3uV21052vkPnRxmMAEwR/HoISROpca3JzcXBNmMhWnnJ2rFeQOcLIt/7rUBjlzU6NDkkCsNDeajJJqJSqqsC8EIHKtNWC2h9qzNsfMzRsdOHPklznkfk2FT5akKfuzVeurxxoqeUdWiJdgNAvZ6nBbNiozP1Ecrs6ApfJxUoOWxwImPc4z5IDFTFcPDoCqfbQlm8s/udRHafQv41LYe/EY6Yk5aG3jL+walZG64Uo3WioOkLXA1qT1dm2qPJvooshvicPoX9JwnTg810lgz65MoH3NAGPj3+JsAOQLcR9565lhJPJGsJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGIDOw5tcdN2+r5WU4QJiImwBE7+wtjAqm2/kczwxxk=;
 b=MV4U086z83vmU5xGWPbY5GS1tbOcaFIsT9z1FvL1U04Y7GAD6TAPUpP67zRiuf8prG+xA6SImF+nIC20HINd1fTwA4svEXdXQKU/YhPb0zK/NJihYLGBPqHUtx9kuht+imfcmdCwCK2k/T2x8zJSgTF2S5U2x/yhI7BfQR+KfhzFWzMlwqEpCPP6PTCiOvrXck5/eQ23abaxh4fgkZydOOSn9B01xPgC+kc0YhdviClDENdPY1rubFXs/ycNfHOAk85mR6lwVUDjpPyNNq3uQsjXVrhACTgC1oholCOYJ12eSqZl5vjssVViqRoq2Tf5FmyOLEbLgtfCwg9xWmOAjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:02:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:02:01 +0000
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
Subject: [PATCH v3 net-next 03/13] dt-bindings: net: add bindings for NETC blocks control
Date: Thu, 17 Oct 2024 15:46:27 +0800
Message-Id: <20241017074637.1265584-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d7d1152-9c83-4e72-3a70-08dcee81faf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xCStAqoq8AJPDgufDetFbDM19cjVwNEZ0+wNpLvUE7BJF5g4CTrFAvtpIMe1?=
 =?us-ascii?Q?nTti+6R2b8JWgf+VxK8vxReVpa10cEO6jKLWM4RdyGc00TeE+ul03lqxQ7Hs?=
 =?us-ascii?Q?JTik0Fr37p/eyAWYYLd/VqHxv3VnGkAg8fudUMVQ3c2dnoFXbJeiquebsNWE?=
 =?us-ascii?Q?+h1x3IhEdgWXxHMcJgW7LKcoXLbiBKmo1iEaLzNKPHFEtFCVkOW9vg5RMTeE?=
 =?us-ascii?Q?EW6XIhLqG9bSb/aytSTDJ7EtOsbIJ6o0l9e2Uk9ozak5uASlcZAQPHDnREEQ?=
 =?us-ascii?Q?nHHM6CGww5XnmbboTU4KvQMckVfIDqP5OYMYSRLR7dcXHbQM7XnuVd9kGaLL?=
 =?us-ascii?Q?uvpncQ1ElLF3WfcV6RQgquIZ6w1ooVJFf4ONox1zgk/S9/QS85y7rLuv9KH5?=
 =?us-ascii?Q?m5R4SPRRruOt9EZpbORHaB8AWhJSQGmZA2UT3p2vHAZSe0VK/V2bjz95bu8T?=
 =?us-ascii?Q?8+IXM0iDfa/JKoFmJ0KjtZJOxq+t1kYJHWYW90w51J+M3E3rJ9TaDg/Ma3OI?=
 =?us-ascii?Q?XZb5s/ouOucdMmyOrwyw3wqIH+YIx36J4IDpEgYdHlUMxx02bOKVyyolP2Rb?=
 =?us-ascii?Q?R/lq2VnR78xGTY6BkR02UBiaoAyhgpkFRQcrZvy/UTRCTbwJhZgwdrJu/ERW?=
 =?us-ascii?Q?5W643EX2ORx2wa77uWY/L0IiajfnEvE/+um1E9OYwgg6GgE4GbIYNXIHXirc?=
 =?us-ascii?Q?6VhfTE/BYk8F05gsiv2b7rExhbbR17aqpB97DoI/SyJtIWHa0G8Q6iXTcJ0L?=
 =?us-ascii?Q?xItSNGDXeWpjCNxK3y166uRMFazvbEn4sP2+gTTqcs6IhwGZO77/Yz+fhGvh?=
 =?us-ascii?Q?lC5PiY1KBaF99+APkt9AjYtfuMIDxY5UPN/i+9K9BWrq9aN3Wx+qVesL6IfD?=
 =?us-ascii?Q?l1rBoGN4F4bO5hg+6fUOC8NXgueg//dakROD4qWB1Nv9sFEZ+g2oUs+V4KI/?=
 =?us-ascii?Q?ukX5ROn8Z1K3PyRz/mx8s6LbfiLAiMriTEWmP7bbVhF2wpihEy+Y0qDz5HUz?=
 =?us-ascii?Q?YbTx+9GPPF25Bc4YPqcDuzdXY3wyNZg4oTrFtf4rcjKrx4pP53sgSRAjH+7m?=
 =?us-ascii?Q?YrhWjbaDeqId4SBCrWDpLhj3wNrddpvEkDcx3Qkyq7PRTTQIGIU1EhHAqNn1?=
 =?us-ascii?Q?GL84bMB4envlFmDWF9oruss8n7ph94vXQSH5hxtw5LB+XUE8TzU7tRpzaO9+?=
 =?us-ascii?Q?sQk1hch30qGXQVHeVnheeOePmjz3bnuFSv8dvLLqaThM0gm1y2MUMQ2B5IUe?=
 =?us-ascii?Q?0VYcTbJJm1YKww7KEBNvd2bOrs4ECTNrg4G9xuOR9d8Op1fhvupa7cufk5M3?=
 =?us-ascii?Q?m4VPnGDSPHiZuaRMCUVn8eUeyWVBXWQ6ltJeAXSQSMDhcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5cbf0u/NSvSFLKdq+GzKjrNV6QYEcCTADhxLZZPnPVIgcH9wjy9kCU/A5/SD?=
 =?us-ascii?Q?2wmc3qZNZ5U7UT5MZ7lhv37oDxw1Niw9cQmXfDhGXhC9F1r2J7zsjv70CnUd?=
 =?us-ascii?Q?BTcs5MSK1NIWnNxCvsKaRZ892EIjkpOjFkUdJOIKFaLCpidGpZoJI+XfA1rI?=
 =?us-ascii?Q?OJdE5qLiwG5kUaVt0XouXjM+bp+Kz5p5aBa8EKCYxTlbdEcqds48dSma93fS?=
 =?us-ascii?Q?YW4wl5YZYbI50paetU91nTR7jaG412IyPWJKDOYeaQMq5AMcH69IHn+36+ZW?=
 =?us-ascii?Q?GghyxC7Vf8cO+Qv+C6rqzbw9Yj8Lb+6TLp7yvrom1d6H2haT5tGw+bu319kH?=
 =?us-ascii?Q?VgZRSxIXGpwPYyeDtr66q9GQD7j3Y1uXTdF5gZlCDbZJbTBZLUrVWu800/eP?=
 =?us-ascii?Q?C926eOqvimho4I3nxFoxXlY640WVRdD1+L8ck9lhRoTIcxsScrhAEwdcn00V?=
 =?us-ascii?Q?3Vnz/M04jiyxbqSWTZ23KS/b5m9/QagIz6C9XSlF7+hIOx05igwKCaN2WVwQ?=
 =?us-ascii?Q?wILYXcXPpQO0AGucI8vKiv7yFmwbBcIppRi3+E+Bqv1K/qEMdGEyCYRed39I?=
 =?us-ascii?Q?6aLXYY+jiLWEdjn3642krBw86tb9gQ0u4NOQHv9WihDA7nymYKJvfnrRqj0K?=
 =?us-ascii?Q?0NmSEQFB/iJNoT7Trk+UIrBbjJa4XizxE1k6O70TgIg1qV7dIXM/PC5SypRX?=
 =?us-ascii?Q?KfVH+lRvIKMfzA4FBIO8mpvjvy/ZjB814Gv9waJYWrOSckF/S4Gk3Dx6hr+E?=
 =?us-ascii?Q?5Py/ZTgbwsUxcKK+FFYp8z8Rzzt0CNZWuJUx+fjgxzFv21tPagOgY7p30Pv6?=
 =?us-ascii?Q?gvuwgS2BOcwmj73Dj2jCVrKzaIiGtt4VI3329VDCVo/jAqwWIMfcjQ/ClZSA?=
 =?us-ascii?Q?ee6EzJJ8JbI1BLfzClLlLbTj7bJHsJLjbtXddVRR7ROnst9Cn5RcjQ3ZbmAT?=
 =?us-ascii?Q?v5dzzrXthtHsS9QwGTfCApWA8KXLSbB2q/IIBfIQg/r/aWQ2tUc/CyYvR104?=
 =?us-ascii?Q?UhqjPws2jlbzGNBm/VMQV/94mOk4B83lHCd9jDe5sp8U4vK656zmhyDjKNrg?=
 =?us-ascii?Q?Y25EbzEPJEz7GBik+ZnM23ghPNLtQWMxUkH1WwfBwHPwOHSyFvH6V/Ku83XN?=
 =?us-ascii?Q?yOwUXZ5lCvZx8cpEFJBFHkdmg+ddBG4HV6q2bA06Seu/js3OwT8+DavASaJp?=
 =?us-ascii?Q?bR0W8N4nBZvUBHSO/QfsdG9RXoKQ17T9Lj7jI5UUM4Y83eecP12yR20nftXT?=
 =?us-ascii?Q?lZ/v4ocYqnavShvddlXRpC+d76Etasfea1fe7IUHx8U2+dJMUtFUxIWmc3mI?=
 =?us-ascii?Q?11s74guJffrhRc2SDgY+jDOdCOgFWJ3wtCoFT7ZJsEMAPcvmJjs1STtGy8tM?=
 =?us-ascii?Q?35GmNftDgYlJYfT6s3+MrmjLSfmAqoZOfSD4EIIIrpn74FjjaTLq9B625WH1?=
 =?us-ascii?Q?WQJTeAauWxJMQiENzNJ+6soHfI3XuHwRjQITe0XSRLcP79VMxCABzcjkbjl2?=
 =?us-ascii?Q?YJW4gjroEWwmw3l1Bbg+OLk206Zw7oDWkkMA1Akhzi3ZH/vPM2GDFzTijan5?=
 =?us-ascii?Q?wWvq4czQ+uTcG7w/t2ghanJgLBZoYO+Qxv8Dh5U9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7d1152-9c83-4e72-3a70-08dcee81faf1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:02:01.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qmkpP6hSbCntNshGCkwjMG07QDM/iVh5jij227zJPpfY+VSeqD8vx2B24/1BljpZm6/2lFQ5gtRY6DzeBNYlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

Add bindings for NXP NETC blocks control. Usually, NETC has 2 blocks of
64KB registers, integrated endpoint register block (IERB) and privileged
register block (PRB). IERB is used for pre-boot initialization for all
NETC devices, such as ENETC, Timer, EMDIO and so on. And PRB controls
global reset and global error handling for NETC. Moreover, for the i.MX
platform, there is also a NETCMIX block for link configuration, such as
MII protocol, PCS protocol, etc.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
1. Rephrase the commit message.
2. Change unevaluatedProperties to additionalProperties.
3. Remove the useless lables from examples.
v3 changes:
1. Remove the items from clocks and clock-names, add maxItems to clocks
and rename the clock.
---
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
new file mode 100644
index 000000000000..5e67cc6ff0a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nxp,netc-blk-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NETC Blocks Control
+
+description:
+  Usually, NETC has 2 blocks of 64KB registers, integrated endpoint register
+  block (IERB) and privileged register block (PRB). IERB is used for pre-boot
+  initialization for all NETC devices, such as ENETC, Timer, EMIDO and so on.
+  And PRB controls global reset and global error handling for NETC. Moreover,
+  for the i.MX platform, there is also a NETCMIX block for link configuration,
+  such as MII protocol, PCS protocol, etc.
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+  - Clark Wang <xiaoning.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,imx95-netc-blk-ctrl
+
+  reg:
+    minItems: 2
+    maxItems: 3
+
+  reg-names:
+    minItems: 2
+    items:
+      - const: ierb
+      - const: prb
+      - const: netcmix
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ipg
+
+  power-domains:
+    maxItems: 1
+
+patternProperties:
+  "^pcie@[0-9a-f]+$":
+    $ref: /schemas/pci/host-generic-pci.yaml#
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - reg
+  - reg-names
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        netc-blk-ctrl@4cde0000 {
+            compatible = "nxp,imx95-netc-blk-ctrl";
+            reg = <0x0 0x4cde0000 0x0 0x10000>,
+                  <0x0 0x4cdf0000 0x0 0x10000>,
+                  <0x0 0x4c81000c 0x0 0x18>;
+            reg-names = "ierb", "prb", "netcmix";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+            clocks = <&scmi_clk 98>;
+            clock-names = "ipg";
+            power-domains = <&scmi_devpd 18>;
+
+            pcie@4cb00000 {
+                compatible = "pci-host-ecam-generic";
+                reg = <0x0 0x4cb00000 0x0 0x100000>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                device_type = "pci";
+                bus-range = <0x1 0x1>;
+                ranges = <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000  0x0 0x20000
+                          0xc2000000 0x0 0x4cd10000  0x0 0x4cd10000  0x0 0x10000>;
+
+                mdio@0,0 {
+                    compatible = "pci1131,ee00";
+                    reg = <0x010000 0 0 0 0>;
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                };
+            };
+        };
+    };
-- 
2.34.1


