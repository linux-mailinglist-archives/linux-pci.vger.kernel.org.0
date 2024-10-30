Return-Path: <linux-pci+bounces-15571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE779B5F59
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907BB1C211AD
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310341E3DC6;
	Wed, 30 Oct 2024 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b8Q+eYiU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6871E231C;
	Wed, 30 Oct 2024 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282099; cv=fail; b=GBFy01K23ElYU4B78lQDiaBtTuP0n6n1jQ1xe9TjzsDxL2cXWOTQwvjF4InfGlqRBqMbGLDCrLPVqk3/W/Pzvm9uIns3VBYr7vEJTvCHXCmyHeuNFXZWbZi4og59tZOkcHZKDwSmaRnXPeRYmtTBceGUy07mf4mjnrGm/eLnBaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282099; c=relaxed/simple;
	bh=ljN9ZHauh4wygTQilaxfPPWuIIcZHUE1isT9KuEFctM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hNTo+gv63NhHQSnS/zQWiG951HG+CffMc7Qt9MunZB/rGoTLkjGqGLISuAg8M8Jc2wd4BmiYectp1zPLENDmeHATv0b5pYfJUyiEYPvLO3EM//qZrp60sDHLaXASd/KgjVS8Lpwrrh3wHRDfIjcaLYLwv8Blo/Cl3u6Cga0uCWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b8Q+eYiU; arc=fail smtp.client-ip=40.107.249.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtBR2F2YYVtDUH08ygQ3jg4Fl825wOoFn8BFpJcqtZNzjrr2jx2IShyewSMOXtxwi23dVMJFEm4Qa0PP8Hyhufjv96qYOUcFChW1JWet2kaYKRTl1jKEQ+UJuDvLSMHqKX4ZP2DuH9X4eDqsecplGWslh9EB5+gg1j+E6DJBAbDG/ZJWuAIrEKEBywDjYL5WJbqjYc/DltGwMlKsA8Yht2gD5VZZh/xAHVfHE+zNfPE0M5ipYvbfnmuj0NIGxB4vjnD6wXOFdDjIPYPRM1B1sZB9+b39cULTb6Vib1zZLO4kcMdM9lKSoXJTdWcHneN1wbxITNBLl/jCsSnHHZawHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPKZ5H/nfdjETseUZ6lGYMeiOrIqJfyaut+UoWtHqes=;
 b=sJHufIkCmlq/CLFzcgqFXI0R3iIwpUf0qh+MONHT0RV/0WG7XM29VWpxQy96eN+xAc6dF18yJJZFFk61RsdH1Eu3+lvU+xhSThjHm6Vl28SVRwEdrawDBabp9kgu1Y9hPS3ftiEsmKE0ErYzb91E1vTQfNDnhW2ANCM2Sjw9HUQ5YSLNDthNRr4s9UnMSyZ8i1q6npaUp910k7226nTgOQjUQU9vf/Yg7bsMafMYJHQSZJSHbMSs8c5SdWfMcUjZa5nW/1tZ7AIg/BbIOwoYO8nqD4AqPnSSr/Xizim05oqcQ/31HwzTWx20fLrOLGMG/rkKvwa+hJRdnhqgeJ6eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPKZ5H/nfdjETseUZ6lGYMeiOrIqJfyaut+UoWtHqes=;
 b=b8Q+eYiU0FSdNqcHqYrNcnrpRCC944f9HhiKdewaPbQfDzAMXBTsRjXlD7urz1uto+Z0MvGJBaqthU1b1zUmBZocZGoGVvwzW9xPhRYEI4GcNQH+1vMw2AFzKfjLffYX8DTe0Aio6EX8SKHJK6Jn95xUeEdInfngSAjYx6Yd+7JVXp65Tx0+jhSuP/zl3VTYs1aQqCxl2UIeH6hlEv9dIdtugqXgaHDLaB0nlBc9ekC5FU9D+E0xC1/JbvaGA1CCPsFtDe8msYLf79ApQAGLLQKsCZw1v5lreMthenjHb7xKaqjCHVAXmAk5s0SRx3kybYBHdecOgAEKDu7/ayCrjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10347.eurprd04.prod.outlook.com (2603:10a6:102:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 09:54:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:54:54 +0000
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
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v6 net-next 02/12] dt-bindings: net: add i.MX95 ENETC support
Date: Wed, 30 Oct 2024 17:39:13 +0800
Message-Id: <20241030093924.1251343-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030093924.1251343-1-wei.fang@nxp.com>
References: <20241030093924.1251343-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cff7dd-bd0e-47ad-371d-08dcf8c8e77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ZQMkH8BOYNxUnxZT9DvO+0I39QaNCKNpyPNpWEAS8l8qWVxIqEYSy8RZIFe?=
 =?us-ascii?Q?vOlXT+WqmSxgMDRrsyy+kI+5HGhcUUbFwKJ7suV1ohDAS82+ZpMa72+NDibr?=
 =?us-ascii?Q?BtE1c8iF86yhulFeu24d5RaUWS7ETI7VW+8q1M66JXhPKbZv2k+kalrrUq0f?=
 =?us-ascii?Q?fdlUvt+la02B6Lj2i0fmktsdXjMbJeMrLrR3lWvCOI2Qc053bC1ErvcfTWTz?=
 =?us-ascii?Q?fRa0mxdTS0Ui+hbIysrgQCsN4mvfge3llFfmzJpg9AIKQgW/Q64+4pz5EROn?=
 =?us-ascii?Q?qCIgBBhr5KMWi5OvdirkMi77s4lDdTrhBLVIqW9NEOlgUC2xMv1+Ya3Galsx?=
 =?us-ascii?Q?BviGDBq4/NFqb3EWhmry4S2BrNuBaZVZajIks9boVFYxLLfa8zBMPU9k8EwM?=
 =?us-ascii?Q?axb6z1tn0I4/snUxHPBvJ7CnQR0cKD5dW9P/kLnODCgq8m3a/yNDhofI7B/L?=
 =?us-ascii?Q?GkzWE8YIN7KCfsM/8KxuWOyWPAzXfwF2VfD/8xvBmS8Dq+AVK0SwNnEAJzLP?=
 =?us-ascii?Q?UFrdNPm0tdo/Lq0RURDwy0xzEaGgJahbJ+aC/n0yLV+TnByvcUNeOHOEs5S4?=
 =?us-ascii?Q?wPS1tduqL68GoeJb1Qydvj1iwfQ8CJXFt9mHiEsbKStgQjKPOlezj5SzK0yD?=
 =?us-ascii?Q?vT2rBhDcIJ2MSrkN6HM7m3k+6cGIfUF0/POweZRMEgmlKqStqZgzemjCgreP?=
 =?us-ascii?Q?sHsZUIfmoRr8GwxhZSOf4BUs/EZ0cac1DKfC0AWraVeAj2x+CtyRUNZA/BWu?=
 =?us-ascii?Q?Mz3xEpV+2bTMyTYpxMbyrzuvhxYs6ICJmc16BfVhj2qwYEwe10+8/qFUrfI8?=
 =?us-ascii?Q?8yIGhvHMU+F2naWfaLMsfZkwRixY9JCI1i2vKY3uAvhoIGmteG2fZsTcd4gb?=
 =?us-ascii?Q?ewLtu9MUjT2EkkfytUZMcXqprwTpI4NH1BUZBxoe83B3EAufSyZHUi6L4ALk?=
 =?us-ascii?Q?d7XQGGSwTZxd8ri7B7UL/cekqn+yXIzFbO5iZNzLrUMaNwvhYIJp3Vp7S+12?=
 =?us-ascii?Q?xEBtJAgr/Ho3XO8CBN+jsJB4dsMZUbP3LWpLbF4kuVhf2TxaemaE5dpJwQ7X?=
 =?us-ascii?Q?+R6rzOPJmGybxINKY2Lns1sjasOXGw0zkJ+WOc0Dv290w9XHr1UCj/ZeJ9hq?=
 =?us-ascii?Q?DLoP/JxMZDpPOl8W848cuk92g1JXH6w7u3qntvhIxqGZVbClfD3/OPztTCuA?=
 =?us-ascii?Q?YC1bPdA3af5i4sjVMQ7C4g3aNreFLyrkkfdk+aeEvQbIwbRak/JMmEHMiyli?=
 =?us-ascii?Q?Gfmy0PP9/5zVoBFVS9/6QL63lxQc9uWEGpIOm0bKTsWn1r6WC1g6Wx+iJ9bp?=
 =?us-ascii?Q?PJp9UwPN6k3gj/c1lDtLbpwKpntnf55jh8MdL/WhP9Yx8lwgpwvDbTqKaqu/?=
 =?us-ascii?Q?NfZR7agjf6I5TfLj5YAuEBI6bbix?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QozYOwyQu736+tENSPGnskOhvqSd17j8axrr0DSitpItVWxHsLpHjTpnW0O9?=
 =?us-ascii?Q?jZbplXeyaC2xYJLDXqnHyYvDQD6G5hhdGwp14Oe9Au8v4V9SGerQHlnhcT4H?=
 =?us-ascii?Q?1C9DNVCxkEtD2bee1TUyLyhiOA3rSAwYA53XVCC0iz+uHeX2dugIuCvFhFcE?=
 =?us-ascii?Q?3eBUFIvyJQVToGlstZabm61nglCC0x7QRBR3PMxKl+oZuzhAF1mdfNo3ETpU?=
 =?us-ascii?Q?XGVNvc9gfC+6VZo3WKY9dmJYrdEniqXg8CPzAsVbjgy97wm2I5+HJORQA6KS?=
 =?us-ascii?Q?3FevUKa/ptV/r8Ui8BeYUcYyCwJ0877eKfsWHXc3pLiRqPJc2qF946fDpX6s?=
 =?us-ascii?Q?mIyet18WXcyXYM2Z1rhrkslzfTHEnq2HhSWR9nkDT7TwAIh6RU7F6brnSzqD?=
 =?us-ascii?Q?lU+7+evu1P8fdS9/zlirY/FAMiOP3Z9+1bs3W3S88+h9aR1b7s/Sn4Hk9rG2?=
 =?us-ascii?Q?0SmGDgMVmWAx/ACZE+7DwiGc/PWOwVQFbmePsPpzZ1s5vOAwUhsyeAhT6K4X?=
 =?us-ascii?Q?wchmFz9kkYxi7cw4zYBjNxdFnVxlSdWIhTxuH3HE91A2S5wB4dx3hb+UakjF?=
 =?us-ascii?Q?T9Uw8tkALgQo0xfezOsKdAr4FQFdiGuRRr/CKlXN3AqAAJqPgzzKAEqiUbaC?=
 =?us-ascii?Q?8rGo7LWq2ebbppsKJ5TFeEvK7isGSb9DNacgp2hm6eDhD5TxOd98HdC3Iq/m?=
 =?us-ascii?Q?LlrHLhyz1dWlk+n1X22Oz/f0s+W+LvKGhSSUpG3//DOOpasdmSiOhJyzYay4?=
 =?us-ascii?Q?l+wj969WyPJAw+KmKOMAd+EGRw981tTWVC2OnJ55dDbPlBdJ5051u49UkrNX?=
 =?us-ascii?Q?kx0NrQD2NSuXSRuMczoTn5nf54CIjCgUn9h+dI++Mx5llyNZ8Lolare5ySnY?=
 =?us-ascii?Q?BBX7Vowng5uUxzwu8d16vbH/b2+XZK4NFlXHYlRJBi+DfV9WETQNF9kthUzD?=
 =?us-ascii?Q?bOQNky0x0ywp3u6mAwalYx4C3kniuMlo2R5BXPq7RajRa7Lo6O3tH+sXc7th?=
 =?us-ascii?Q?9RXcYfvaig7zMSEP2QY0jmFSbQ8J8YGEOCydWVTFgj4PwXB/wB5qC5BLUmaR?=
 =?us-ascii?Q?L6rfnE93TpkK51OqYJrOeliJEKSxvke0chNklq5VRryqtaGPj6fn1psDDH1y?=
 =?us-ascii?Q?l5wotKvqtoZQqVdp9Ta1OIwEeVh0fe7Mj2JKesE6am/HEgskDtMGqYeckvRQ?=
 =?us-ascii?Q?SspfAVHF9EtK4RNvUl9JEZtKbAv+XFLSmQ9NXnVecoN2bvmph4tlLij/BI4a?=
 =?us-ascii?Q?O4PsoDPKfghqW2nUK49Vg4DeTlKcF8BUc8j20Vqi208BfKQJotxvyJj11oGh?=
 =?us-ascii?Q?P2wHM4l1uO0VmuXq0eACaQOysPexEp8jm7qCzPltbAxH7yz5f+Ls2vfR9nhq?=
 =?us-ascii?Q?oQ/qrt1gXwZH82KV6L71DnCkS0UV6rrKysoeJ0qyMXteRuBvgw1L+CPqTlqF?=
 =?us-ascii?Q?OV8k2AkTVkLgP/57a58QPe5uAWEvymJPoDY8IomN7pIYXJHB7eC+3y8igzZY?=
 =?us-ascii?Q?w7F/C4fhk2blzBgGKWCttf9VoMQFsglpoTPPc8aFF/O4PfWaVq59jM4Yg3dh?=
 =?us-ascii?Q?nVDTXYDjKrirnBoYxd0PJl1PfQWh9h7rgWpID6bB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cff7dd-bd0e-47ad-371d-08dcf8c8e77c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:54:54.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTEZ2ctU+I8C4zWjGras2r2OZoir01suqvmC+1zszQVbFDAKsvr4naDeHhOGAr1dHNiiqo0/lKOg7tRoXvWaZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10347

The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
ID and device ID have also changed, so add the new compatible strings
for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
or RMII reference clock.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2: Remove "nxp,imx95-enetc" compatible string.
v3:
1. Add restriction to "clcoks" and "clock-names" properties and rename
the clock, also remove the items from these two properties.
2. Remove unnecessary items for "pci1131,e101" compatible string.
v4: Move clocks and clock-names to top level.
v5: Add items to clocks and clock-names
v6:
1. use negate the 'if' schema (not: contains: ...)
---
 .../devicetree/bindings/net/fsl,enetc.yaml    | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index e152c93998fe..ca70f0050171 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -20,14 +20,25 @@ maintainers:
 
 properties:
   compatible:
-    items:
+    oneOf:
+      - items:
+          - enum:
+              - pci1957,e100
+          - const: fsl,enetc
       - enum:
-          - pci1957,e100
-      - const: fsl,enetc
+          - pci1131,e101
 
   reg:
     maxItems: 1
 
+  clocks:
+    items:
+      - description: MAC transmit/receive reference clock
+
+  clock-names:
+    items:
+      - const: ref
+
   mdio:
     $ref: mdio.yaml
     unevaluatedProperties: false
@@ -40,6 +51,17 @@ required:
 allOf:
   - $ref: /schemas/pci/pci-device.yaml
   - $ref: ethernet-controller.yaml
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - pci1131,e101
+    then:
+      properties:
+        clocks: false
+        clock-names: false
 
 unevaluatedProperties: false
 
-- 
2.34.1


