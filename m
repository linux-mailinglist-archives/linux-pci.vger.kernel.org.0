Return-Path: <linux-pci+bounces-14538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257CC99EC0F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8621F26DC6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F0D1EABD2;
	Tue, 15 Oct 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jmtWQ5io"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E01D5AC9;
	Tue, 15 Oct 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998024; cv=fail; b=YP5Q+DVkif9WzFAI7PMs1nRyi4YHbPQMgG9Swy6D/uY+Li4GgdJtGeqm71wlOoBIIss7jl/fRAB8zg/6wdd/YjjXGrPlb+89Sv32Ej3VQ3BAfIxBTkxpF66O2JKr9kKsRoEQF63+ZS/CirkZIwPuJ0Ba/ZB36u4/iJrpp2Hsr80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998024; c=relaxed/simple;
	bh=rWZH3otLH2Vgc/nQPhpcxfZVCaj+0vmIA3Y7E9O0VYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HHLPO9ASeb3NWpF2wkW4FK/Vu7wBkO2x27X1OkgPdv/vV6LyFPK1J8N8du03acABCYi6idK6uc0yJyUb4GSiJ77NgfKhmBi18OrLJUUOD4a/7lk8/4EmNjih6MSQoUNxnBBs57WqOrzP1NPs98WClYw2KR3yZEJPrRg8gkyU64o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jmtWQ5io; arc=fail smtp.client-ip=40.107.241.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLURmgdrXXRq1zxQeI790G8GODvi5Mh0ytJ7iMD/dpvqpL9fjGLSKKc8AiKqgaNnBOlBYtARSkZN41RrsNmHH9n4JDmdYZefsRdeOuNyrim2UzSdYF60SSPKBwmsAa7zA+y/wlFjp51ZUzjrwLr/VrCt8GMpfGsZu2w1GuhaE4/+VYTk7xWcdH2brCghVy9GQBkS9D4mFmgDuR+MbkH++dz28wW6oebnBX87N9Grkefa6bS0WnUF7VgBLpMXRcckClPfvRLqRT6Gzgj2S4+lMllDtKTnjmiN8cFcXxsc/uuz1Z2rGgGpX3iqCAEXpmQ/1dh+14M7j7ahbWMaIuD5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rWZjqMHjcsrEjEiwT4YROTt6gdb4/Ommk1YHIWm5wE=;
 b=opqi5pC1aULhl2+YBk1DZLEjE7i9S4hBSR0P8UM83vsRQ4V0vkgS6JF+qrEpfrZaUQLHE4l8znXyNysyhiidzExSXs0Ln75DAKb3c6LQ9R8iaaWM/LTQ4uTYsjTddCC8IlpLPFArScYZdajiD4FU72iqoE1X7OrUGnUnhJI+rMHkxNtbhFq+stqJC8NawdSMsA+7zDvbF0Aaj0h7zys8mUCeFfZtcmUDyn4RoqJhKOPUPl+JuJkwfnfGYlR+TPAVzxolV7VZEdPXpNYRQClPKCuuhxSqI1eI/wpwKJmOMYnGMpvdGqaLYwldOG3L7pXwKnxiHGII+hfN3WYeSSjdTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rWZjqMHjcsrEjEiwT4YROTt6gdb4/Ommk1YHIWm5wE=;
 b=jmtWQ5iok+6QjavBpnWF4BYc6C7NlGN7EYLHD76XCmAOrlSiLiCEES9RdtOCkHkCwzQASokP5lPt7mSLqYl6nqVAdHMovvk+KmcgEp/XiaLKYX8Fg3gG2F/oyAtjOSOWuZrKzhI6JHxxZPZN/2cAmvO9wMCRLNWURbMbRTgAPgIial+qizBMTCkwryrSHj0lg2GrPHnNUc6Yrgmssvnc0jtv2PNXufcQU1z/y7sHc3jAnEQxoXnm8xELv2gMNFANQ5FPsfWVD5LHgLAVSerORqUbleAYNPOmKIydP55RSo/QQ+N8RuzcHmlVAOFo76clMrvzYjxWXDo0SCS1rr5CBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11041.eurprd04.prod.outlook.com (2603:10a6:150:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:13:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:13:38 +0000
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
Subject: [PATCH v2 net-next 01/13] dt-bindings: net: add compatible string for i.MX95 EMDIO
Date: Tue, 15 Oct 2024 20:58:29 +0800
Message-Id: <20241015125841.1075560-2-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 29994ffc-9c59-46e9-38c6-08dced1b2e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YzI/gDiREx1GNPE38PnFhAYkeuQwnUJbR01Q+FKaehBHOcwz27g9iOEN7r1y?=
 =?us-ascii?Q?LHJCV6X6glppBkG0unn0luRBjc+82N5D6DDSoxqqJiWz5fdlFWuXm8rY9D+j?=
 =?us-ascii?Q?KemLzqkOe41chNllInzlrYb89W+HeVe+etmTJ3KvRDYUBPT3Or5w+ESWO2fY?=
 =?us-ascii?Q?aBA/MXGrGXZoiDTTRCsI3IdLRwJ6x9YWTqPdNyJW0kJkvVYdUZAjCDNHA4Rt?=
 =?us-ascii?Q?gtuFAJlOwW6cMXMk5odU/i1shis+tX4U7nKxTqOPSL1DK55z4TSygbjDUJqI?=
 =?us-ascii?Q?uAs0krFPD8YiCJBwmQ1OyJqeF8TKJFDrVptR7OuI20yXOfbnKtSS54737wAD?=
 =?us-ascii?Q?MCqvHsW7Vgf8K77b8M+kvav4a/NohbkvG5iLhiOWwRqkqL3bvVxqZEgAJAEY?=
 =?us-ascii?Q?6I86JaDgrFHNHsuUUI+PxXZ2ZwA+LWPtahfUST8v6XCSHo3JeVyqvYYU1wOE?=
 =?us-ascii?Q?Zy+nhQoUY0tgKxXkmKRoD/V6rF5WFztCUF6wjSEOgLsb2RGoA74XixI3P3v3?=
 =?us-ascii?Q?dA+EvqqqK/zXWZGZjv3qkkSkvyh5i9O+sfNfNFFwlU/2BSiRMuhJjtXU6IRa?=
 =?us-ascii?Q?Wz3d/GGO4X0e4EWXdKB1Ufha2ZE/SYwUOEW4B8Ptqqjsrq/gqjz2xZoro9b+?=
 =?us-ascii?Q?K3fpjpkpL6ewD2078mo1w3Jnz5Wv8ydgEKBmtjlj5hiFy70HtwYI4hPwUaFy?=
 =?us-ascii?Q?FC/0iPAik85ziq1ilUcdRBh/7Sdv4t5XglGwr0LRK4pMLAiFIuE0ZYOYCh+Q?=
 =?us-ascii?Q?M5iXociJ5kjEuqW1VgqNrmPkkzlG8zgy0D3ckUpTYCyQr9s0eV1vUhvas011?=
 =?us-ascii?Q?PDQFeLU+HpezNlzSmdQC13QflocvMFz9CHCgl+N29stX2OGIOcf0ofDXW3dA?=
 =?us-ascii?Q?kf4kpPGUC31l1XbxHIEyw+zmdx+0ukYZuBC+A6jnjfd3xa939AyqQnEvINqB?=
 =?us-ascii?Q?IoF/U18dKb4x1JrZbwO8ch45EBHbtAMUefc7lt/bbljXj8cX6GZ37dbXsvTv?=
 =?us-ascii?Q?1fan4/gHEbUzsxGYQSCTb/aCWM74JGFfFx2iKNgLlD/oB3POyagvmpYwZXsv?=
 =?us-ascii?Q?040ZV559j0dmOrPQ5AEU6+jmeUqKfCG/fQQsa6jMW3jq2wkToab9mskYv+sC?=
 =?us-ascii?Q?UakUQgyXWuadHIJav+Sj6bhxSpMvMvSK32OX70aSAjrdbwON/AcZTv+DlPIL?=
 =?us-ascii?Q?dHEbAv2ZK+AMo25+0aoZEhPj5mASCdL/ELmO1jkFDIMVHMTy8sGfJKCfOk3M?=
 =?us-ascii?Q?Wyk8+xs3+vMTxfqezc1IKT3uJ443e6o3DzfFB9a62PikpXNU4o9hIeki07EF?=
 =?us-ascii?Q?RAYP+HK5JkJyqCLPGzV1/n7LRQ0hDqMORj+NM9Gd6Ar7+bTMmtASwWVvshMb?=
 =?us-ascii?Q?llgis5k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zot/0HA+Pn4kon2S19YYTimKtwqWwvAOmtrLbwEElmkKHy1H3byzjx4y56zS?=
 =?us-ascii?Q?IYI7Sl+cV++xAsVufEkfwUbwDcxg2598QRhRFVmwV1BV68HvamLIvYZNQL2M?=
 =?us-ascii?Q?2N4QRnkQ13UzcF2q1kEG7GDltleihBGJWiZYywvFKTIqBYyeebSB9cgl2HYv?=
 =?us-ascii?Q?nEqVyU3HxUDy0IigBCSK8d4/JyuR+a4hXtnfvL1pKkZ3B9mwRd/p0D7NpFtJ?=
 =?us-ascii?Q?2yGdBTTTNSiAsXGG0pyisAM8o0pavQgd2NZ5OGW62nK8NMtx6/TEjs6UYpXv?=
 =?us-ascii?Q?SVdAqLLQoUfYue2orTvM72zJz9RFtPgyeaak2Svmp0dcjpqEiL9fALdlr+U5?=
 =?us-ascii?Q?Tzmd9Um1XzP2av1Rl29ZEE3rxpQRBrwfHd2uPJUpkTeztA33xSRiMo1+Xczo?=
 =?us-ascii?Q?Gnl+2FeT+1cppVtWKrMGTvD10wmq5dwuQO7jVkQWg8T96jOVTXXVtBOyKebD?=
 =?us-ascii?Q?51zrLudZEuORAXXY+GldJz9ao7/suPXzsSAHzblCRgCzLQWzvpxQ3azq8ifQ?=
 =?us-ascii?Q?34ZkrKJLRDevawt77p+LYk76BwVl8ODd7UkB/paZNKIaUKvV2jRpmx/G0UyQ?=
 =?us-ascii?Q?RqDRn+lNPu+0RxqJd9FETZKphXZQmNfS/+Qas6/xU7o8T+joRiApzNfVO2/3?=
 =?us-ascii?Q?MpBW5h2+/L2KX3RKiBNfhXHruCb7NCKG+0eq0UbM/LVfYJgG966JWtpoJhQR?=
 =?us-ascii?Q?xK0PoiAUSuQVlujnekZZckGYccaiLJ+wxjRpkxxuRc5CfV418WZNybZy2Z3S?=
 =?us-ascii?Q?JzDTfEuGhGXS1cFv+aPSFOiRgW4B90ZwjT+tutqIFLUWCb/fuCjq6vqo/n+o?=
 =?us-ascii?Q?myZIZ9DahAxkVHVC412XUG4bM5fPnVzBoG6lZNaqrrKr4RhNUt62C/YJPp2j?=
 =?us-ascii?Q?58zSMbk1JQxiydtZgQ/gRoLtlR7SXnobGY4obb+hXzWd3U5ZQt/hP9ZVUad0?=
 =?us-ascii?Q?vkWM78UE1OYxf2TaWF5gyf7nzjgwmoxNfOLGZsaC2ogA6PycfzAUNTOA0Us4?=
 =?us-ascii?Q?6AXglX0hf4DwNivalFPGqOxzK/V2/8ijP01QqJIvs4TLOCW2a4ljO7VBV6TN?=
 =?us-ascii?Q?24z6yO1DH5vQw+TNsNd1t7d16D+zvkFnreoT+pK/xFMJSzei/cghkySNHliK?=
 =?us-ascii?Q?5eY44oOzNO7JLf4AMlt4Qv8DLZ5Aq/Lv5+WzsfZuS/wgX6qHwEVOMs0lftKD?=
 =?us-ascii?Q?rTSK3mM1hipTWJmqACEgZG2P5ylhR4J+HOzthOD0bjl6Ct7HYNyHGegd5Srp?=
 =?us-ascii?Q?PTk0aFuebPRsiBUZRqwEK1WlA044UL3pA2qKJ+Etgd2EEVObX7OXhimZO55k?=
 =?us-ascii?Q?gABnLq2kXB1GpR52v2snklnGX+9dRInCvxK40NyuvykiIzjoUlWdM0HKJ5LF?=
 =?us-ascii?Q?gixolrB89phg3g2PnzHrIbfskrZ8I/9LaCsumVmLJ+252MG4jMCUOtoHgRWs?=
 =?us-ascii?Q?t+lGMcQv+qzmRh+PTMQBJEE3NmKx+pYGw/ZJkOqw+rG0Y9fCAgPRm6rBd0Pm?=
 =?us-ascii?Q?NSZmTUN9B/M1vBIEswD6oKkmRcCoyOkXCSa3LCqmPwx5FnUYO1iN7H+pXxZ/?=
 =?us-ascii?Q?NU/x2LFsWUZfSrrncnkjb6zDq71dSVzvxwMwX7i0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29994ffc-9c59-46e9-38c6-08dced1b2e9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:13:38.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+ls5dBgpx516mKfGSbgFO56seci3avXeJiUYfChxRzZWfGXhsW/UiUPEzGiqctrZguecA/S9r4m5HetmhmHsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11041

The EMDIO of i.MX95 has been upgraded to revision 4.1, and the vendor
ID and device ID have also changed, so add the new compatible strings
for i.MX95 EMDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes: remove "nxp,netc-emdio" compatible string.
---
 .../devicetree/bindings/net/fsl,enetc-mdio.yaml       | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
index c1dd6aa04321..71c43ece8295 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
@@ -20,10 +20,13 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - pci1957,ee01
-      - const: fsl,enetc-mdio
+    oneOf:
+      - items:
+          - enum:
+              - pci1957,ee01
+          - const: fsl,enetc-mdio
+      - items:
+          - const: pci1131,ee00
 
   reg:
     maxItems: 1
-- 
2.34.1


