Return-Path: <linux-pci+bounces-14540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A95799EC20
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C05E1F21A44
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84D1D6DB1;
	Tue, 15 Oct 2024 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C5/ns6uD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5FD227B84;
	Tue, 15 Oct 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998035; cv=fail; b=bYevlS0kT/OXZdP7b/qpHeLhhuWmvvCZWoYf0VBMy+/mh5QmNecJj9gwqaJI26WJkB7XlfzPB4mL+VpOmdHI4xxeBCJkHB87nC/U21cZVnM5gx1NmIqCck7Xe7eRHznrlD64tyQkaSZeyagBHExysEAHcSLIpvTOFE/yCHP9Zfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998035; c=relaxed/simple;
	bh=m6QZd2W+FGDZ7/+DLRV6ptbnvayiFlpyLJ1PRo89eNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HVbUL/gDQYN3b3r/UwaHL8YAfUPj6fxPXLqlgXc/vLzj9r5zMO3Jif4gfTZ5tQyb6JYam9rChVPStZBwzPefr/UTKeq5Rz+6LvrrciFq4lnAIyHkYLD1Ri5nN/215mKYY/YiPhIFVNpuGgV2RsfwzfXR+5MFR76L+WVNNVF2rbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C5/ns6uD; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbgKDHMYgZuiGEoezfQP0pAJeZBGe8waLNsjhwh6QfZ95RETDSbANgzA+Nca2evYz2TwNGcdyhUq7DTmj0C+dAg9v06lN0CU7jSePUvAw8WjzHOR0HvgS5SBviz9GEohwG7qodG3PW1CZKeeex+ZXTOVSf1tNrKWsRTJMh+r/8mZXUlLcV+VswZaFAOTjfV/9UgwDfQrPZ5d9UFpQIwv7/Qiv51AgGRM46Tfu18js0Is/RHbaMcNJIXuVFbFdL+c2k6kCl6Aimq5k9u7I3bDZcxiWuliXBg5B8HxQGxFt/Efa3mDCmH2B2a0BOIx+OYnAZRrho8nc2oTufWQyanOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q33dEmPWNRXmhcrUMfWZDC19xxfRYpOcCFacPXnIzis=;
 b=Xc1K+hjM/KHdoqV8XxDESgP9c3XsKZrj7DxFVpTE5kkzIZ2dz4+gY5keKqCXjF0UbLEI69zrDTixob/PRolsqwwpcMM9UAmz09rtfzNHCPBQvzd7ViCxuzOYWP6wAVS13w3Y+LQkq8evticWlaMPtfD2a/4ns+q5jRRlEaPnZT/S3OGupQOcZZ98f6qnWavg4z7my+21+QYEfkqBcMwshJIMuKr+kCqwrbLjhlgzpX4TUTidwCEuJ8H7NqfODBS6KR95FqsRLdYvu+ECFcf14smZUaxrFYsQR9K4OVO0/2pPO3SmXoZ8Xk6DwlDZUDwCPoDJfTow6AMAtXurMixBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q33dEmPWNRXmhcrUMfWZDC19xxfRYpOcCFacPXnIzis=;
 b=C5/ns6uDelIJMc2JNxrJNxJ1MsEDJZzB5pP9EsloS2S4fL3D2WD3QXT98nlvKANFJLbv8poEnVjfrSJSMtCF8GfaR0sKs1W2G/8y120H04fvCPVAA6i887auucT5avYh8G+tlVrGNSWdP7xm8cp1ZTVAP6NlC7/P7JgSJi/lrI1JVlWUnmHs8hUvbwgrq7Q77mK/k5QokK9jryrICITs7iDOnrafeVbGBelAU0OSFk1lJFFSngbXnRwKtQpdkn5RhAbiGxCkYF9luq3RYCSqGJOyKimAzQjlvLTq+V42p8/F7HWNWnV0/Lo5Jx4p7KUGPjhgT41uwiay47wFifmrug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11041.eurprd04.prod.outlook.com (2603:10a6:150:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:13:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:13:50 +0000
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
Subject: [PATCH v2 net-next 03/13] dt-bindings: net: add bindings for NETC blocks control
Date: Tue, 15 Oct 2024 20:58:31 +0800
Message-Id: <20241015125841.1075560-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015125841.1075560-1-wei.fang@nxp.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB11041:EE_
X-MS-Office365-Filtering-Correlation-Id: b5be645e-a9f1-4b4b-bc2a-08dced1b35c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L+QESobnR3vTY8E1603I5SuIGCApsYZGDIeB3MrNR+NaL5xKuBmAMgldRMW5?=
 =?us-ascii?Q?GvuzvDwdvBGuF+SVRs4vZux6lYoM2Dj6QiApBcK5+N7T/iGK6P1a9nuwhUUg?=
 =?us-ascii?Q?TwDA1QMdOPy+MmAYdYJF9w0UQ/0pEXOoBwNnaGf3D9bTMDdrQEYLYaMGEXhR?=
 =?us-ascii?Q?xKxOBuccxNP0+fUdAnF96+bD5LKYrYtyYghfHWy56D+nAAoHm3sfKsebMSmP?=
 =?us-ascii?Q?VaCnup4j3J95ibYAeMQK6XNCqXIgVeueKU9hwr9wJJgax8YwbYuyLJYuMJn8?=
 =?us-ascii?Q?f90ZURMifCDmVifvbivb/i/zWhBNsSEmlgCnvb6sBulTmB8dL+54oGqpJtk4?=
 =?us-ascii?Q?cCvsNFynb8Zh+FGl2mf3OxKyC5OrsncdM19kOE3EA6chsIzG5rQsrPA+Hk2l?=
 =?us-ascii?Q?FRsUGQs552mRqpxIvRpCbpLWQ3CvtTYplrfX6KjT9VIGjHdmKEj03F1rkg1+?=
 =?us-ascii?Q?shrX245ffOCkdrh2QYmpbWQ8QPu/EamCDjMCe+c6MZcFwHgKWPfw0HgmkhAc?=
 =?us-ascii?Q?9iioYKiigE+mPRQm+GvNVdcKsZhIxS8ayX+C8yC6N+INvUjYPwJ2qbjIrsn2?=
 =?us-ascii?Q?7yaaROY/UQeYz+W3kksjjJHwDyjYOKYnvX+g6EP459CztfLpnyv599hJfIjb?=
 =?us-ascii?Q?48+Pa1uAZ911DizQng3P9fYD6NglBLoYoLW9syD2YtT5wg3U8e8KwIESZWgI?=
 =?us-ascii?Q?z5sGtLu5VHuPQMY3xZx5h+5xlnWzOYVd7m3A4rYv37kovR1ZekUjMZDp2gIF?=
 =?us-ascii?Q?ptvBiYBVXOcvgi+Iy4qnoQF8L9ZJ/miKDLQB94nX8pw4xdN9ovPuuWY1E5Wz?=
 =?us-ascii?Q?hk3nYkXT2h52VK1MUT5f9jS6DThu/KoTv+DGBFezYUogPpMXQ7M1ZpmmX+C1?=
 =?us-ascii?Q?E+PgFIAS4+gFeo7lnI19r3SpwCfM8skan00gpNOSutQDnOJcQraQWhrHG6ws?=
 =?us-ascii?Q?o8A51x3lF0DgTfYdTFyV8hFEACAqkhjCuOTcGpMPYw+0td6Nfakm0yzB3AS0?=
 =?us-ascii?Q?NKmtDR8W89CBnhN3RkX+TxA4mL/Y4qniWMSbXKUkFmXD+3J9oeJ7oMYWXZ6f?=
 =?us-ascii?Q?iYtuWTaX6MwkKj54Uqs5QxOMRMmzbv4Tq2eC9RkxVqAwm++UO83cP5aXIJx7?=
 =?us-ascii?Q?uUpW1i8pmVbtpqak9egcikHW6zamOFBXzJNEIaeAayniSi8QbHMKGy9kTULk?=
 =?us-ascii?Q?rT3jgaNw7cI9MP5MPuD4AmgtItdjcMyAp+qLbanh+yKPbXsGeg3sQWJUqMs2?=
 =?us-ascii?Q?UqYoFQsiuuQwERVEHVrSkMaQcnCGyhakjZjlOgFMyK2nI3+JRUpyEWe5utz8?=
 =?us-ascii?Q?jPg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vH9E/RymwlDeMLpsNSJLKpHaHIeNPhqZBDIz7PTgLoYmMlpdZrV5t61vINf9?=
 =?us-ascii?Q?UrRguhjCZFBmObYxpMPKZanNzJDA6BRq/7LuzPX1N4tG34mKXzvP1Cv914+K?=
 =?us-ascii?Q?fflCJwtAIb+hdUzg8XjxmNcWOgvolxNgvMZl7AhAqhOCGHTSzqhgawhSAcIq?=
 =?us-ascii?Q?ILUenQ4x20H0VHnswEFuv6ySkOwOMD3kbqeOXtE2+wqipo3I0OtisMXPaKt1?=
 =?us-ascii?Q?emTrjgQGS/stfU12DYKoPsGDX4UMs8EnKjljiO1gL5nNI1FsV5JCS5j1+M64?=
 =?us-ascii?Q?9Q4PcDhdui8rRROfjle0LBZ/c+fi0g/8fTtyv2isQezWxw5WrlEOt5uHgqs9?=
 =?us-ascii?Q?R7gnZK1mMtFb8xhVApwGvZGc/Ec/0QGTNMLVliMY5YR/FgJ9R/MpDxYK/RQR?=
 =?us-ascii?Q?1qHgC2buVHa1ZPsMKdFzO8GYwByezITouVSKn0pBHMKiYuoW9eTB8hoCydZt?=
 =?us-ascii?Q?xz0G8w5LC/IbY0dgGdDaDavYOJmWZCWplceMQDK+nfBOM3y/LIYAO1e+XhFV?=
 =?us-ascii?Q?9LcHtr/qvj3VpyxXAsIokeqZj5NqW05PdDiRsC3nd2J7PsHE3LIN6Fs+cra0?=
 =?us-ascii?Q?7ih0hHqqwfwLcowcM9Wu4HqNG46k4qS8FojBobD+9MFYoHCRmCbdkYLjpVrD?=
 =?us-ascii?Q?msAaU9MxJQG2dJ/LqrITuJszrsP9hCNeLieSIEsP3zZN+DMs6EdClF6Q/uL+?=
 =?us-ascii?Q?e6LMTA8sD8bID+BwAacShs+JnpsBGPvpMpsvQlu1Ixwjgn7riQwd9HeKHRmr?=
 =?us-ascii?Q?r1leFk/zDbDU3+2NoT3AnDHmxlZp6cYEdaCwNsEr3izZFdo8/e5AXH16JLnD?=
 =?us-ascii?Q?mqpKok+LD7X9lal+Ih9DrxbqANRx0XG8B6fjGmieplopY2epvxSifRhxc03k?=
 =?us-ascii?Q?KHJDtp8AG+0fozuuWIwJOMU6ueBublAzjuRa/IvSZjfNYkATWqO+rS7MM/Wc?=
 =?us-ascii?Q?/7PAqckNSvQxs8mnEFYf8b0Er2FvxBSYQtCyO2T5c9+yuQo3Q6PJdKnqgcdF?=
 =?us-ascii?Q?C/mW+tN77FRbL0vnBd8Cx8LrmuNShlpsNSI8COkqRuiU/j5DGPRMS9yPTHvy?=
 =?us-ascii?Q?tj2+OGwiiu/XgeWqA7EMcf7QocTQQgm071jqtT7cSPMIQZNmQ4KfBA/d/3d0?=
 =?us-ascii?Q?F4ULshL85D3pGTXKJXhlpAhgsUHXb18aelUvd6e3xvJD8VXOlsOkX4o6n276?=
 =?us-ascii?Q?5ZcgMzx0SnoMyiyU3owR8TsZHea3OUUZlSgtv2kvWJciifXBK9uV00wwkwwx?=
 =?us-ascii?Q?1KdFnkribqh9RxbvffGtdkUfymXZ6z5+yv7nWl6zlZBMSGtBYKUYJc5MObRn?=
 =?us-ascii?Q?T6f6+GmXqWasK1ox1iCWS4MIe2mWt6xg9rP3uDCKAK8S0mZpZ95j1dY6nyij?=
 =?us-ascii?Q?pziNAHT9HUUU8cvK/9XN9ixUvzn+8W/mwqlXuLSqcdgqn6FNjh5YJVXwZdCH?=
 =?us-ascii?Q?dcrivvxGoyvIo9+8EdhE+ABWTrXJw3ElfvnK3Ea48+zPX1+vIwwxTTMriKuW?=
 =?us-ascii?Q?u14lDHEPxcjmz3J1JGJRYML7+9qX4kOCHFPxlLj6HdyY/ZaFuGLvDWcPYOSJ?=
 =?us-ascii?Q?MKgYRcieFExqcB0sLWanxxv4RfqtLtg8Gxdeqsb4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5be645e-a9f1-4b4b-bc2a-08dced1b35c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:13:50.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gptV7H4MWNuPCSoKoqnGIBuhh71DUfeOc2zUIvYZ48lMFePbDPNeiHwMkNNzjfBfp/eS4UMXxS4Hiff4uXrGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11041

Add bindings for NXP NETC blocks control. Usually, NETC has 2 blocks of
64KB registers, integrated endpoint register block (IERB) and privileged
register block (PRB). IERB is used for pre-boot initialization for all
NETC devices, such as ENETC, Timer, EMIDO and so on. And PRB controls
global reset and global error handling for NETC. Moreover, for the i.MX
platform, there is also a NETCMIX block for link configuration, such as
MII protocol, PCS protocol, etc.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
1. Rephrase the commit message.
2. Change unevaluatedProperties to additionalProperties.
3. Remove the useless lables from examples.
---
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
new file mode 100644
index 000000000000..18a6ccf6bc2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
@@ -0,0 +1,107 @@
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
+    items:
+      - description: NETC system clock
+
+  clock-names:
+    items:
+      - const: ipg_clk
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
+            clock-names = "ipg_clk";
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


