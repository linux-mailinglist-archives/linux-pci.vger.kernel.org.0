Return-Path: <linux-pci+bounces-14066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B8A996677
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1384288669
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928B18FC8F;
	Wed,  9 Oct 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/PA3AtK"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8B18F2FD;
	Wed,  9 Oct 2024 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468394; cv=fail; b=iF6WinOUNlxkuM8zjKuNuw3E0r0XkYdp1/1lY74wgOP3Hx4aJyvlc9ImSpGRXgLQqtMTmY4wZziEC44E5cbyfuIPQr5k5ug9nyOoth7kWTJ7PshI9AO6AFMwpVAP4dEd9KAKYXsbFSLPwUdV3uK6RvMVQGTU+R50mc3hHUIJvGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468394; c=relaxed/simple;
	bh=fp/DKnvgckUKE3mwPVlywelYf5XtyKidRbcMLQAt2lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KavEePZ+TF8dvV5WQiB9s4sikZ3E2wxzK30H1GKpj7ievDsuQt6Ah7tMV4ECUp3zwbSji/QjCXQivKy/y6c9pgIv5G6GEMr0A70ufloJta5ByLUTjPN5wJwLbGSj9rYXaixo2ArHdd23PnOMLDcZ3xzV7YVCYwifiQI++KogoDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W/PA3AtK; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mimbkIEA4a6HFYhHilN3BHVD7wlB816ecNjCOs4Yeu3D4pjZ5+i0F/sLj6pAK4t7bCzOjlZFk9cygj4yOATeN/Y/7x87Th0jESDBj3KIOXzribY+eIUImaI2VmQqUHvdwc3ctXdbv0MM5DZ5B1jBaXsst3X9jMCcHaNfgX4Z3+uRi4/LTb+LVZPt8B93Gagw9rUl5nxqc2GC4/mqjYJSkX1+rRmXXg6exNufBR0lVzIXBtzpJSKGE/lpDo8QH3khB69DtVGphnurVQ0V0jW6SICtAYBOPspdIICY5JRKdkh8nVwaUevcdZG2iSqggZV01qFNOcebWd3K3ZgWETsw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Gh8xImuw0v68N5GeWbLFNz5b1/PMJEJmTFzwGvIy1I=;
 b=QLrGZ+RecDxPeaqXcugRFHgPmyyajso9xPI7a8ceOXrKN+en8ai+4fF14q9vpnvHXDlEoOKSkPCHWHXCe1eEQHFMVlP05dBWjr2fdglMrgNvLKBFITmf/lsVxDhDJiE0SC/ticO1becC/B1kmR1NDcQJ/DJzPgxWLomRUkNTxEgZ5V9d2LtT6BpKH7Fj4t3rAR850XOLrgwTxGfpmmgTCasnLSVJVh2GB7E948u4ZGru4wwOLbKNviQ8L7uaRSBlbf6aAeafvrR5hSFiFhfGDX6rPZrs7gY8F9IgiWBsy1OfU7xQkv4MEK+ejwikhy+4kKCYwTcDz12xpau/hbHk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Gh8xImuw0v68N5GeWbLFNz5b1/PMJEJmTFzwGvIy1I=;
 b=W/PA3AtKo0cjCSSE3S0zXs9Ag2qAGlO5pJ1ufsRVHBYPkw8BtMKHfrsFPu6jJvrBu/RrUTJvUKQsVku7fvD1reL4PRzDWtGZcEMJtDfCUyhLuApPReejZpR4ZJMdmxRhXciIgGksv8vbaVwWZdwqqR/rltsvo/uX7AOMDfSa7IE9uWxE1KOJ0GQl2N2fx+Wg6CpD31e715TCCYtxPjfcMSv4wj285xTlPG7IRhEyXF8vlyy6IrE+jNDMj9NbytAQbzeQsz5RgPupCmUXCJ4/4EeRClAzMKifcoT37/FJtXw0lCNGchWl33GPiKxNVzga+ZO8PBhHdkEAcvTpThvZ7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 10:06:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 10:06:30 +0000
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
	bhelgaas@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 02/11] dt-bindings: net: add i.MX95 ENETC support
Date: Wed,  9 Oct 2024 17:51:07 +0800
Message-Id: <20241009095116.147412-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009095116.147412-1-wei.fang@nxp.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB9933:EE_
X-MS-Office365-Filtering-Correlation-Id: 448df2a5-1095-4ef5-8f69-08dce84a0b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AQyrVPkjGJGPvBuSXaL25UCMACUmxgrwSNwgcvEBKZeTy3d/gGBxAHIbjrjt?=
 =?us-ascii?Q?B0Ml2YCi7ihqp4Y6VA56sUmBnpPVU5z8ys8dBs0FWFylcgwoycCY6BWfpIzQ?=
 =?us-ascii?Q?6sJ+A1RT9SRzGvQy6cdpo6WoXVqEp9k0erTslqSvRFIxw9WiC+1InjLR6HqA?=
 =?us-ascii?Q?HZ/hQBOFajYa4U+ZwtQlbv+1cEChlOzxhRc1TrWHURQJcUAI3Y8GZSuGsjLs?=
 =?us-ascii?Q?Y2zh0NRge18VIqxknr6ZNo1G0hqUsJCZI16aZleXru2OaH6JlvHxxYs52I8p?=
 =?us-ascii?Q?Z62IzHAygeg8Bs7JYyMT4IiasIdDY1m5Hih5FEjyf2RIzbRASKrmMIht2u6J?=
 =?us-ascii?Q?pskqSRS5SvRqx5HtCI4UfuEDCJtTDBuox2VcrRus8uit8IBh50A+NUMArRbo?=
 =?us-ascii?Q?76BgIwZaONaGzJPJ3GYmvasgNGhE4wVk58seCj8Iu3B73wG1naON28dXjPQ9?=
 =?us-ascii?Q?UdUSP5PQgPRTJxePFdHbGz+jlQDizmSZItJg4/RIYzXYIzQ/lPGFxS6XIuO6?=
 =?us-ascii?Q?OZwGi/DeH7VKS5BStuMCkeSYz7cSCOwsVmpnjCuxmyefIjmf9aB/Bf9lWQCA?=
 =?us-ascii?Q?FvTsdTANJhQbtVwKr/7jS3lCamc7XBCcsakIQ1Mmt9C2UQ46kjXg/AzSm3Qg?=
 =?us-ascii?Q?vs8Q/1WGqMnJpVO8u+3y3Cm/vQP131X0IYaSzgaVcCTKHgzW6CVXRRqRrCV+?=
 =?us-ascii?Q?2kGHX34doI+Y7lY0gkCmBS9tGc36YU884bXxmaSM2JSxowreL+opgiP5NRfC?=
 =?us-ascii?Q?ZxppuDKqqiaVwWvKx8+srnznq7NRqmMIuDgJxq3NxImaUZBwAnGAUYYUVsov?=
 =?us-ascii?Q?tvphJjinUeQdd3IXbSlV5MGnm1NRKypLJyNWL7TRQZRgbOKrCq317qihA1A2?=
 =?us-ascii?Q?bEIq2vxPZeEqPBZ+l4IUuUrrbusY6cAzia7NplTe96XbhuYmDV3caVZu9jQx?=
 =?us-ascii?Q?2x4zm0kO+PRLfWZ+0YZkz0rUzYxh1MVbruK7TGJZioy85S2VUm9Ks4N1VPP1?=
 =?us-ascii?Q?3uJYfTSpDbT0tVgYyU8vr7MlG2prwCSYOE3Ovcw2kCJGyHl/zAIE7dmZbZ1k?=
 =?us-ascii?Q?rcae7Y0XvZjGbwwX6+xfurrxd7YCXPZXTKWbOW8tJueutlP7XwGcQzmVDkwg?=
 =?us-ascii?Q?BYEpIn00cZYUCU6KoNaPDx/Atb2ac+3JiPK9IrkdUhoj9S+IcrGASkCwdqpJ?=
 =?us-ascii?Q?W+DVizTX+mcpz06r/hvlE5xLMYKFEuMhAhJBZnD9Q3MT7xIqE5LFPgQwmBgy?=
 =?us-ascii?Q?guazjx7yNjNkfCHlGVTt3Q4UfzXf9NtGOH+IR4DfWxtzk4XgS39sX8LemUnm?=
 =?us-ascii?Q?NBsntSIlDd22l5TUIPdE5JSj0vPjPTnKgDFsBlMQUH681D48plTlXUiyzeF/?=
 =?us-ascii?Q?Eg1vkAo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J0idqEBwZ6511As5N6Ae3G5D6coOoOnD+5+QLKRSUo6HpDS5Zk3DqxRQTJeG?=
 =?us-ascii?Q?BJfCTVete5c3M8dzl6+HE+hndIi20Vi7OMt3uyjp4Rx5axQ8adMnerAwZY5A?=
 =?us-ascii?Q?61wFfRme2s+zTNTT0CQUs/4j96XXtSmYLUbc4NKe5jOckKMv81B1H1Ln18S2?=
 =?us-ascii?Q?6/8XxR9suzB65DWme00kW3z+FD+6qnK3F/wPmJlzjuoIUG6lWUaH1qtQQ03i?=
 =?us-ascii?Q?BxqyyEpUhWZzpIjayLUMO8g09Je99ttEXqAx1x/zCYG/pttZbyR8oUHshCcA?=
 =?us-ascii?Q?lS2dwWYwMihZXvrRC2CgAZbUo3IdXP1zRabgVLB93GSkxOvZ+g4mBuGpxnWI?=
 =?us-ascii?Q?Dg6bDrraThkowxOwa7Puo9nPLjV+amgHF1wwyId54cFkpPOcO1ncMo/XmPaT?=
 =?us-ascii?Q?oO3Yfr3gqb2qfo2lCzM3pI9UF05jZjwbVG1WZBpsWSRARJwZ6wz0BTVKqTrA?=
 =?us-ascii?Q?vABPmyZF+jbSXuCeELiuVnes4eTql4et4qM8ZEw4vT+RO78u3fLvhzWZXUeY?=
 =?us-ascii?Q?WhC+VGGLnoi5wDCMTlBReAPjZ4935wwIN7jh+HM/Ey93KoqXBKKe3MR/Wlcz?=
 =?us-ascii?Q?5tmC12CKZRjMrLxpE7Hspok85gVOPm68qe4cenLXJD4137y5ArJ7w9zX4vpG?=
 =?us-ascii?Q?g6jmI3RIt9FYdAH8UwzqL4MyLGZcrdcN3M5fscimRVWOpRJju9INxmS/3Zxy?=
 =?us-ascii?Q?u1MkKUcNKJJI1kUVrQH+63J0vCMby8FUfpdxinnzkaTdRexBpAc0sK8UTquw?=
 =?us-ascii?Q?kDpnRbSeYJsrTqSnEpp/tpEknZIR6rgmLcSnDGU1ir8ZEH7YwNFi4PcJE4DR?=
 =?us-ascii?Q?+vW3tA/T9R1ks3azkDkVp/KysPp6dOkgFvDaYqeUwQIuf6abRQVCPVvEG5Jx?=
 =?us-ascii?Q?NTsw01tfFFaPnzC4Ymr/gpgrO9uqKLNbHDZOHpkMr11J1UE09E5u7lEZEdeq?=
 =?us-ascii?Q?WZySrXV7dHsW0rrndsDxH3N2lvvOe6rQTp6NUD/TtFDt9FzxQ7Q0+KHk1Zik?=
 =?us-ascii?Q?53F7nNrgS0NgryILcj4m8wCIyIS3PUN3BbSyNkfzZ0baKTo/lK55HINRfpOw?=
 =?us-ascii?Q?Uh+ZmqX7oh7ui4naBVZNicrEI7xyv4GwX4fWBGirT0iXM4pzleiSwCuzbEMQ?=
 =?us-ascii?Q?iJr3YkFby+5ZVqA6NdxyMEiquzq4VMjYbXRn0ELJ5aDAx2YdFuQK85/NOvgP?=
 =?us-ascii?Q?ocB8sYj0QABa6JhroVMTzVYpkUdOZsb58p6z3YMwDkbSG6nzqDIMPkIGWv8W?=
 =?us-ascii?Q?sfos6NnSlODM+5ZErxfQ1TkNbx18FK5+xaR9drN1fu5wisXtx3/iZl1A9ME1?=
 =?us-ascii?Q?zCWFcXMBSoNkQ23LeXAr6oZkRNaWMMmLjIaiplwOQWcRjOB8bzb8D/fPZ04a?=
 =?us-ascii?Q?VLpSQpdZKlYxmagfvd4st8kAH8yCNDVWQMGXDVvh82qDfqUqZVGSIIgH+gnQ?=
 =?us-ascii?Q?X5Z/pJ4t3ls3/Iavld8WMH8O+T++/ScaTLHPeYdlDVoqOdi8u8QapNO6RGWH?=
 =?us-ascii?Q?YKLQy3h9jiIs+Q2/kZIlCrjvO/wDSHyzy55EzIifuDvrfgQCkIywUZPCOyNj?=
 =?us-ascii?Q?z4mwO9fRfVuanMfHtYNQbs7E783n5v/7Wo4+k3YX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448df2a5-1095-4ef5-8f69-08dce84a0b71
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:06:30.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwvlaqfrNRsrPeQoDAnd7E2WZi0FT8AD1rwqi72N0WOeIuPgFkfO9ywx9MdP3O1Fn146Q6GWZy6nXz5DcqHwuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933

The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
ID and device ID have also changed, so add the new compatible strings
for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
or RMII reference clock.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../devicetree/bindings/net/fsl,enetc.yaml    | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index e152c93998fe..1a6685bb7230 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -20,14 +20,29 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - pci1957,e100
-      - const: fsl,enetc
+    oneOf:
+      - items:
+          - enum:
+              - pci1957,e100
+          - const: fsl,enetc
+      - items:
+          - const: pci1131,e101
+      - items:
+          - enum:
+              - nxp,imx95-enetc
+          - const: pci1131,e101
 
   reg:
     maxItems: 1
 
+  clocks:
+    items:
+      - description: MAC transmit/receiver reference clock
+
+  clock-names:
+    items:
+      - const: enet_ref_clk
+
   mdio:
     $ref: mdio.yaml
     unevaluatedProperties: false
-- 
2.34.1


