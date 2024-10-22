Return-Path: <linux-pci+bounces-14975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C579A9943
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92BA1F23FBE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E6F140360;
	Tue, 22 Oct 2024 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lrYykvdF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819B1487E9;
	Tue, 22 Oct 2024 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577269; cv=fail; b=U7Q9uRfyAGtWnvjbSZJC97zeNTCKzDlJlOvX9wqlboLOSHEtQdJOAo/1P0Oj7PtMe5/UhCCzgBrSTKLFIhtP2g5Xn7pZZc9hbOQ0BwqEmFEy4sB2H5I3EsJqMy7Vh0n3fux0ACsXRN/nZGMw33eAut8ne9mfbxCCwCFDRHcAZV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577269; c=relaxed/simple;
	bh=rlthEl2BPnZ+tmIbGJne+j7S6Rtv03ym8Y/Lgk9SN3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXl1IEPb8en82Z6zA16DQBYoUVJxlXjseIqcVKtv+AWZjOtFDPCnKVIfyTqrMXOEE6C7m4WFzr6eH1GTGL38sih42tBSycTaWt4EQKhfoVJ32RxjhcH6FisXHl2vkF1XnlHq7cK7zABQ4ofssn5JEwMbVcoEakGeeMO0bSLn+xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lrYykvdF; arc=fail smtp.client-ip=40.107.22.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1K9Ly7TCQE2iw2JjkmWOW+l76QTIPWRm9rme0r/HU2aNC/TVWd57ulNszdeKDENKiBTOMj+Cn+9dr7kn3iBnXYtsiFHJnpkC/g+6+KzbJm7RR9yy3PiAd2PwCXUwDBMfLg81xO5+o34uXBYV/nFofgtue341zLiDrD6gZiQVQK/up0hPcxjX/t+Hpbkd7b4+3DLRrZ1B0jsfHwiGfDwdKA2RqM2WsUSaVWPBlkXBUnG89W4FcXguM1Lgs0eig3H2m0RlWoehXYTOSVowgRfmYWZWKKFu6N858ecZvpHYh5VtIvKLUsbaEwvEVL3kSfwotCXbRQbnDmuF8IohvbYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umGQCQ23cEYT8hgU/0fFIANUQHK3YQXwJQbtfW3iAqA=;
 b=YhnoY1E7E2ns7y7VeqTDC0+7OZoilDS6pJsO8/k1bEDtT1PZSilBluivU/pc5sNQadkwcGoEA+0lI/b8P1yBg3hoE4ZXDlArernFk8ZnfHmkV44fELtYgZb5DjF8wj07Te0uMKJFjUuTCsvMhiigzW9sxGR8rWmNYY0/98fpvTURayLKhYBk+l2jdSiP45UjCSxiE74dwrj/lh0MgE8qaTg8EoTDQ9gxd0KLZ7OrDYYrdpXOFg3mpiogf1iZGznz5junyB26L0cODvCVaPMWndxIrsDvNLTSvcZlbgPE9oO2/EHfZSe2/zLmgcR1q6F+lLWBxRmm+3ealVmDT8kW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umGQCQ23cEYT8hgU/0fFIANUQHK3YQXwJQbtfW3iAqA=;
 b=lrYykvdFi8JsFYxvHjqosvGkwR0yUtqORgFgWZYHrCTZTcy3oCRejAAFhK8mcuz8o4wdZj0g/8gq22Ay5loL1PQwbGKm5JsA9wCYXsKBwoeVBYm+j9VzzbQ+Tp3RTU9qhEUwFfjppXrCiuxSp2UlOh7U9phwJQumIEqsEPzDk/7AKCgwyHq/06SgFNXmedxZMusbuxxCg9ieDnmy56KHYPDlYbEnuEutcSalyFDT88XT5nFtXbzwkAgC4TNRwmyR/9wOo8YgZ59KVPwJ6STMFOGG1sBi3ajUdKWW29eDhrY2oD0rvu5uNB4QWDAEnH3C+at6D1AVgQdS1uQ7hpWaaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:07:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:07:44 +0000
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
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for NETC blocks control
Date: Tue, 22 Oct 2024 13:52:13 +0800
Message-Id: <20241022055223.382277-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022055223.382277-1-wei.fang@nxp.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 96335c5e-33c0-421b-793a-08dcf25fd833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ficl4Tz5KremWJriis4Zp/2rLTvLyhZkX8tTh+Q/osqqSits9ZOS7QmA20mK?=
 =?us-ascii?Q?CWEVInoYO8jCbLJtBYinKlMbVDHxXz6Q0Gw36eNY5wDSF3agSRv1jDbtDL4I?=
 =?us-ascii?Q?oZaNY7VT3RfQBPw3STniMfWd7HM7Dj1wkAvQhHqsYNKx/z+gsnvxIroEdVC7?=
 =?us-ascii?Q?Gz+BWF7ELka06f6Yp7c06xr618PgzlUbkcVT5MvB+dgOBQN966jRwGpATH+N?=
 =?us-ascii?Q?31EzijfnyeK28x/xgaaNNvK+FNujtuIycI5oHgdWNKuppCiXJWyJ0AHsKqtG?=
 =?us-ascii?Q?P1QEE8kCb66NhsM8RLA5tLswZJDRm4bytx2+NTdvoJ6CeNvcur/jy0dG5fGe?=
 =?us-ascii?Q?TYkjzyrZTXArKdoAaPSKP3W1iA1X7DYiDWG60NJIXqXasjQhwLjgUZ13h/uQ?=
 =?us-ascii?Q?KZKuwePYuyjzk4Tt0UiM+7q3XJX6Piv/0k+E6EFDVSnM9WknJkHyN75LOcEP?=
 =?us-ascii?Q?3pmsPuwgxxSIdU24gRB2ddRep18zn5R2SfxTxQJKCq6IOyG0iyB017+XzHUL?=
 =?us-ascii?Q?2SHd9v6xeJ8TSJFuYbyGFOgbMQRrZ7lJU/0+N8/yO4Me83Xuy1DPqwuFG/V7?=
 =?us-ascii?Q?HSKQW9SRr14xYYKH6DGHb/lyhsulOaDeiFDC7qXPXStIhAqFNDE4uZlbTdMU?=
 =?us-ascii?Q?CDhluA01qw41YmHKOJpIYTy27HH+ZdNBvVeuUb+ssDC2m+fDLLPr7ym0Mf+N?=
 =?us-ascii?Q?2CAJ9Rx5S5LKNDQlDZX5FMkyKwhQsZrptlu7XksB3lVfxKx2KN48JtXyXbME?=
 =?us-ascii?Q?6JJq28SaDNcbGFS77bjvUjvAiVg4kXHiRf1yWKyOTbqqnnRMWlbKkykluISm?=
 =?us-ascii?Q?/acvv2GUmfidDzc9WDzzeh7lIxNeYfuqKt8soVgAyElx+NOGqvShnjg0U9KK?=
 =?us-ascii?Q?y8xIfK9hKoLZbpUUAUtBpnkZNPLCkX5fkAUlaQzIth9pIwVyr4SeozgePGoe?=
 =?us-ascii?Q?mGKN7zIFq0uKJopq7QNWuB0gWo0pw4OlW3xRsfYs7o0iVD62Ru2IA97oE3fF?=
 =?us-ascii?Q?YrA5QZzjGIZ5NCsLA7vOfDzOIjijMWNQMt21/qFZ1pZo3aWDBxdSNAnx4LVq?=
 =?us-ascii?Q?M7TjaC21ixcTkhCRSmF6ilb3fVKF7ARGxtY6Nl0qKIML95C8jWw2snQzQOXZ?=
 =?us-ascii?Q?OlNtBWMf7fo6FiG3tjU2bnCB77WP8+4d1EEyWo8CxSDBqXxG38JqGiWnq7Pq?=
 =?us-ascii?Q?j5mGy/2O20y+urxyOoP0lI+/h1BL0WKCVtCBQnmlr3ysndvPsUNYmoQcJwmq?=
 =?us-ascii?Q?yOl611/sPieT12s9T0YGG+fxu2z2wam/6AClyMuB0GH9jqLteQMzfc9+HNCZ?=
 =?us-ascii?Q?dI7KeAPs4C7mh5B04rfZlek6T4kqIbH1KE+eNkB/O3+4sQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QtPWlcv5HOx14DxgPLLo7ZSDX8caxTWV6dX+fcyz9VRGiT8XpsLIBhoQRUpV?=
 =?us-ascii?Q?YXK1FZ0RQhpVXeLpvegIrijQdnUjvmlb/x5YE9QvujP2dlGbFiOlJ4HgG68I?=
 =?us-ascii?Q?eMr3qJWGxu6nzAVo3s+ryMnKZeg8QxMlvbNUBbIVjC3PU9K9fB/nKU7rHvwF?=
 =?us-ascii?Q?wW27G2Ume4rFQ6sLVi53RrX+BECU/DqD6zPX3A1cPmYhyEGMFuXT6pm93m5d?=
 =?us-ascii?Q?/A7C6hnY2unBGjKd9Ihw2xzHFAP8eCa81NGfcWjbVs+Eb7CYFNYpshuelaPX?=
 =?us-ascii?Q?ghTE2yVMtP0mktAexQr29lb8ewaG8prsA3gi6lXqp0jdOGZgJ+PWo5leoS7W?=
 =?us-ascii?Q?QW+9jAHkditAUVSnq8prM63biD3jUfdBzZVaUXKIvLppntfZMdQIVGHn6Ujl?=
 =?us-ascii?Q?XPXDstFwsdCaQN0CKIqGlwJu93c6+WNxrbhFp6tZqPP8VR8oeJfgkgNQcZ3H?=
 =?us-ascii?Q?bT+rv+WPZmP9RrtU1POlrsKG9RYq233aUW/VrWG+ViNKFFbgMhjze2q2x76L?=
 =?us-ascii?Q?N5cXpTVJOrZkBG3yXu7n55B+EzRdw2QJ5qoHSkek6cDJDkbjGp83uc4olyYr?=
 =?us-ascii?Q?PD5JKItueiA4+oIxqIXl4d5aBCj3pnsbbVuF2o6BCwL2CUyJR4crR+Z+pBPV?=
 =?us-ascii?Q?aJCqJ65/C5ecBaE7HAjeJ88sXruGfhS9TzdyZGC65TBiecOa87DMNzPR7H5f?=
 =?us-ascii?Q?xWDZHm/7QapsBK+JA42YqWQVTQF0E0NuLVodyqrlQCpd9FO2TuhUGE4nL0Tn?=
 =?us-ascii?Q?1+3tIFjErHkkknmAWSx/GazxABC/lbG4YW2QplC6RQlxd9quCtkrypCj9vsz?=
 =?us-ascii?Q?hs/83IxrlAcltIv640K8wtCg2V/P0/A53yl5k+AoLCfTr25UBKJl7ogku48+?=
 =?us-ascii?Q?vM1nXFvgLaaU+hoHrPRiZKGfU+LlUuB8aCHnDlsGEr2PiWpzFx9yC9fmp0SF?=
 =?us-ascii?Q?pi14VxLMxP+UqbL5pWC62IlvjhmgQk8t6sfvCSTZWW91RnFLHl9/y8Z/1nc4?=
 =?us-ascii?Q?U1Npr7/m4Yk7IVgi0AIUP8tRxQNWk4VGs5dF5alp8yL+dfuhaokAO4tTMAcd?=
 =?us-ascii?Q?w2kuXCueQIdZJ3CbDdNinMjgwkAPip6XwDrjIaMTmeZgkjXrHqU+jIOUwrOh?=
 =?us-ascii?Q?7qb3n65QRLeP4TWjCKmPC71/iOReIhySjfgfKEe/UFU5HjuANw4WLog8TGMQ?=
 =?us-ascii?Q?oZFILpXITjidEolb0XW+h4A1KYAc6rU4SOxXkUap9NH+ENoF15KCbf9ZwlfU?=
 =?us-ascii?Q?WNEVgj1wT9JgsTN10d+G6rIkl3QOXi9JJ+7zTugessjeEeppNFF5l33S8L3g?=
 =?us-ascii?Q?6PqaYTDdBWfmt+6mG8P2oUFtA48oMWwXmrHKkN4tUyUGdWeonrjII9qwU5nV?=
 =?us-ascii?Q?nGrlxSlSC5khYvbEVmhZNnzCVDusZxB2ljYF1s+R4sPJOhBUIpMv6SQSYPub?=
 =?us-ascii?Q?mCv0V64lED7mqquzXyiM4A1FTDEsKPn1YiUb9bt0/XlO0Y2gNcM0mXt47MEN?=
 =?us-ascii?Q?bgZc70xq7wFoAb7kr0bdoH8KVcaDANAp2fL6cbheMJmDGQAwXv7epKLS3rT3?=
 =?us-ascii?Q?pN2egv1QuOnq8ihW754/SvmFflfA1+e57KSOTTsH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96335c5e-33c0-421b-793a-08dcf25fd833
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:07:44.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m96xjBdG3SxxcfKyvxpIRGgb2hWdcBRfhSRO5g7Bn5X/S9tY/f2s5hHlrwFzkdVODJOVSUYlM7utL8v3Yniw0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

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
v4 changes:
1. Reorder the required properties.
2. Add assigned-clocks, assigned-clock-parents and assigned-clock-rates.
---
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
new file mode 100644
index 000000000000..0b7fd2c5e0d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
@@ -0,0 +1,111 @@
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
+  assigned-clocks: true
+  assigned-clock-parents: true
+  assigned-clock-rates: true
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
+  - reg
+  - reg-names
+  - "#address-cells"
+  - "#size-cells"
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
+            assigned-clocks = <&scmi_clk 98>, <&scmi_clk 102>;
+            assigned-clock-parents = <&scmi_clk 12>, <&scmi_clk 6>;
+            assigned-clock-rates = <666666666>, <250000000>;
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


