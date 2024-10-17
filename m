Return-Path: <linux-pci+bounces-14739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72589A1C51
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF531C250E3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093411C1AB1;
	Thu, 17 Oct 2024 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VGucD1tx"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF11D1724;
	Thu, 17 Oct 2024 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152118; cv=fail; b=l7sEdV/0kp/WHbjG7BCrqQ0GIW/NgrceKkhlEqAh2hPBpF7EMlOlFb6cdcvDs4nHzzdIVQOiKtaUb+mDk62oOmZkZzQJyh5gnhcszoQiyx6isScZqM+jUPm2kuwOoUdz5zqDVRTfq1zQSB+3CnQOkUdkPDgd9K44Qiy4SeqMXVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152118; c=relaxed/simple;
	bh=qsod1kug6OGGYSuTGxDa9kOCfPlnmc/olL6EWCCkrFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tAvUOPB/BnCWZOQABYBeLUBIvkWbvCmUE1qMruQKlmwwWfmjV5cdAt5PsyuPPQBULcTVJTuAXjXuBYRj3MxJ3fuTKZ9J3PWNyuSUunYlM9LTTxbG6gaIrYflPTwRWbmc9RDv/76z/c99oE9O46fqM0niT63Wd9Nbpmb06zei1eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VGucD1tx; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcKMKtjHutStGcN91V9j2S6DhCo31ne4ie7SSZ0XtwHzATTmB2HAM7hIwHysOJQjW4Z2N8t83RS4le7nV/z62lN77LxaCQkntAtv2psLRtim0IZquMdhbIfq14yukHLOi+NM70qoALscK0AZtpcwsG17PrvzzLa7vCGKeu+UdUNDXGl85cUmzAZ+mVQwhJzBmLoPIykYijcASVyM9McjdTeo8DdD3vUartuScguk2yMWXgzIRZzlHMGticExDX5Zj9EtLgStzp4OKgVikdWD0xjq1k/6nCRwjCeUfZP2gOAeOXFX+EetKOomGVtwu5nCgcfc2HkCgP1X8/lmsUxlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76i7fxjCIN8lO3vJ2mVqWMJQwIzP21vKAQXeUi2Lwzo=;
 b=PHCxje1jTQDJCbWros26IE2TAORYy+qDxY7Wy/t2rqz9MmOHFfvBC1VvDAhfdq2nYAXKWYmJf3w/r2PEflaf3Q4WNbtYy2Ue6muDPnAuaZ/9Hiupm30WPQStE5GwPMqbNsdMcMK43BRkEhro2slja8E6kapC34Lk/c36yjqFQDgYNJP2VXi7NdwMNSZeRTkJZDDsGGbO/KLW4d2mAtGFDxbhI4TIajDAlSqr77MKV6jNVoYuNSzOx6LiK3s3ge4z8OLMvHYSThipPTD9JTAtxunxkTn2+QseU5E244GwVkZbRSoucDlE6ER1sZhzDsJ/qYcpAQ04p8RZ+h0jFPxrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76i7fxjCIN8lO3vJ2mVqWMJQwIzP21vKAQXeUi2Lwzo=;
 b=VGucD1txhldyqCEFSq2i4E1gTaMsBHYdrc2MtTGqoguahdw7Q4wWNbv8Zfi6I15zQUS43+GwzXWUzreIgjogFFISsETk5QBejqGR+Z/8sDZeyuP4yIfQH5UehsUKgKFyyNZNnVEVH3d03V2kxS1BZNJksvyv3n6lsgazjgcAVb0Mf1KNb1OMxUktYl2k2Ipb6z8ZkKJ22m1I+QKOt/PlXq8SKzebr+aWn0f/ok5EXv5aQ5rPL4s+f+FnyvEn1FfnedaTPbBYlNhe87IZrhlfby7mEZmJWFEXduCgPWbWmChpTnHyrQh207TDqQl9ZiyStS0kDhh75dDqAqjWxsAWwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:01:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:01:52 +0000
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
Subject: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENETC support
Date: Thu, 17 Oct 2024 15:46:26 +0800
Message-Id: <20241017074637.1265584-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b48634e-b171-4cd5-4953-08dcee81f5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VsdTE6cGKfzzIz65GVYHdsf5TyAUfUwnTAE6QL2kjllsy6TlXevqWqF3uQ2S?=
 =?us-ascii?Q?Wo2iBqA4g2Mr5TKV48BZb541rRsI0y2Lau0CFGHlQDi3jGwYiZ3himBd7k3w?=
 =?us-ascii?Q?2iJWxTz3GgSPvnNJdwshZ73068XeRdKtj5Mr9fq+HvYftiP7HYfMJebcQOJq?=
 =?us-ascii?Q?ZIeUDFGxUOW1U67uRLE8XJEq+O4Sz23eTyKuIir8ZElhXVxmVGdhxBHiPvp+?=
 =?us-ascii?Q?ZRzFRTuawQWb1vG9T6om9CkYIC9PmxjP0bSyB/NE4gTuyNNKd+8dzC+dIKq3?=
 =?us-ascii?Q?IGtbS2w8E1nnYVPh2sTlchvFJyt8Al89OrX6kMXuEOKqOcMDDTB9JImC1ELH?=
 =?us-ascii?Q?MrM69ukwtCIcoEvGbEJgh4HnGERt3kAoXH9YRdcwffytPGm3INC139V7dodG?=
 =?us-ascii?Q?qKwtROwtq1rbnBHLzZXWMa26vYKfylClJkTsXvX94bmLk/HXjICqLn5T4wSI?=
 =?us-ascii?Q?1lmxclaynIbSPMDCQgRYoRuqwXCN1a026BnRsNzHT8S4c2CUIQKPK570V0wR?=
 =?us-ascii?Q?VzAYlR3oH4gYcvkYb+wGm17uBGvdJVHK8Ae02GuukpxjVxwcccCzUxHJix8e?=
 =?us-ascii?Q?cwEHolkj2xcpt+BWn0IhvUzXH6c7aCfa/JI51BnLgLta7c0PGEnanwvvHKDN?=
 =?us-ascii?Q?OhHoEyupMJsaI/NI+ra+x3eVIn0LKw0p29dhxMIaINcts0LTefmtfCHHTXl7?=
 =?us-ascii?Q?k+U3yxxCkOqj1pAgS2tUtylrpkGR+JJpVZoMMmoB97Vhosw/HlDD38HaqAPP?=
 =?us-ascii?Q?jiyT8sxHeIfn7aBsY/kKJYnF9wH9G6FHGFGdDi6TWI6zqIvC7gq4K+mI5t4X?=
 =?us-ascii?Q?EC4kbZlxUcemUq6KD7e114DTZXc59WdiI0/+zyjm2TCZfY9MlHWmdsqUYjT5?=
 =?us-ascii?Q?17y/Y1dq3JRxyiajFeSiyW4oCM35TKy0n/RkWY+wnZj2/YM2F3Yv7l6dQ+0v?=
 =?us-ascii?Q?6BvzS1eC9wwxZ8gOQZU5GWWmmzFHQrIUMwZYuFPtnZiWGGlkLHpscR7/JFaW?=
 =?us-ascii?Q?kmDEfAZG7tReMJT5KHyokN2/wHDnEFZiZm+vaaso9uiBhWQIFM5fltH7vr6G?=
 =?us-ascii?Q?8X53tWhcf33oEph+kXxPkPG8IP8/dS7CqSRih4zL0fea5SHoYcJczKKHC/Xj?=
 =?us-ascii?Q?jMV6pIazou3P6Wc/8sfB1fAZZyIKrqrrWMPBnegD9+T/ABjb0GIz3twHmQqi?=
 =?us-ascii?Q?oF3y+ncq5Lp2KAJUTlhZ9J/BvKvvNC5uTF7HEvDfNC6MniZ6Ison3LEQf83c?=
 =?us-ascii?Q?B7MhaiZB5tu7CBCo8MSbidFbxWZdXUnZo9vE1U44xn+0z3mP+nnXw1EhzaTh?=
 =?us-ascii?Q?/xEsGNos7WVXq1rW+Na8WnJBectwL8S0Ag+nci1FA/pHZegDjIcb1xD+mDy3?=
 =?us-ascii?Q?7tGbX3CtEVzWWvVEWKpueK3p49yp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBKq167KLshfHYsJJS4A7p5b525Uv3m3nvFblkKgLyBVNQ8Rb6dUOe6AU4WC?=
 =?us-ascii?Q?ZbTekqENugV+YAw07+Jsg4QFYO9LwYljSTkHaJve4dfisozIjdgMv0Lk6KWl?=
 =?us-ascii?Q?9i1/NY1S4AFK5P4emm+ygMetV3+I0KBGQLD/VwSma0qZUrojwxujaSoJZmsz?=
 =?us-ascii?Q?QAptLBItjk2HeRbJ3evY9cBCtYRJYSqZ0miox6F/HPzPtGXCQFV6nc7FartW?=
 =?us-ascii?Q?6eSx+oJmuZCq05/YVsvnanWvsOAwtlWqhVWZSGJT7xcjtfGGuM5+y3czC0y1?=
 =?us-ascii?Q?KmROsbQRIW7QEy4pc6rdNoUMnxTHg3gKJGf6d0JZ7e51TGieUPlGAsrjoMQ5?=
 =?us-ascii?Q?OabF0we+yq4ACux3ykpCwze/hMg1OpW2Vn1jLS/93IWfS2pYTtv7V8pmAx7v?=
 =?us-ascii?Q?1af7EEjN6JASQHMXoMcjs6be7iXa9XeWfEtYCkCqD0djj+Lp5k4Ng7Ve1Xo1?=
 =?us-ascii?Q?sWIqQ8gO49NW1DDQa5EHNCY7tR5ZTlcr70MPMtp/bm/Sc0dzo2pEGmFx/Hyz?=
 =?us-ascii?Q?l7S/jRcSnuMq1PInYyAzjFRn3hNxU3sKlsH4dDbRW2LG3uvqnXqpyOsmlo75?=
 =?us-ascii?Q?9YUJz6TypNfsVIkxmOK2Zx52pf/qS/mlxaZ5YnlMq/avZQvry4i4pg90pBDf?=
 =?us-ascii?Q?0L6gUxEANm1YHtIkIrTm4d0LPunyjXma7r2IJoKPmp1YizQFFuV4vZplfAdA?=
 =?us-ascii?Q?S7OE96AjNQ1VdFMheOG6SXbrL4R3NaVjCAv1IEiihhDX13n3qyctTZI+Xpuo?=
 =?us-ascii?Q?WESOfeYjzvgHHenPPPw8fhCvKEUjdNz/g06oY33feaBJVlS3y5aeWkv1q2Mw?=
 =?us-ascii?Q?5NfmR1bFwi2VJHw62PzWgSIggpTYqDf7ELdSWteKBMD7Oy83X96BMHhP8I6K?=
 =?us-ascii?Q?OwnhNPaM1vWSdxrD5JQkiIv4z+0qU4W4s5GCjotNtfEiy/s8fLtzUWH2+wOU?=
 =?us-ascii?Q?H+qwtInn6oKyB0RaFxLsC+7aPd/mzyYarRbJp5a1NH9RdKhXIjl6vxPUFq3k?=
 =?us-ascii?Q?KF7jTACZvi0dyqpPQDgPzwh3scMeSxXa445rtE1tabddiXOoCgobkPU7Gcs/?=
 =?us-ascii?Q?YcfaSvwuKJlnXzXeKmP9TnzSZuTIH2iDvaHtvSjDuGsXyzrK4enVv4oTUD/K?=
 =?us-ascii?Q?s5NQzLs056jjd4AiXoQQvnU/2fOg/HeGVvLUFWqpZcByvY03VIVsViRUihFV?=
 =?us-ascii?Q?wASqWQfJm7umUGb6YN89rIBGb3U/T9ON78oN/g2NGP8+K0XAAKTQj2cjUBKu?=
 =?us-ascii?Q?mAkwyQ7fOaN4Mrxe9xBr8g94e9jrHSH+tUaNNAjydiIT0SAIyt9+V9sTABS+?=
 =?us-ascii?Q?Jkfq5z1piqjd0Pu8XfuH+GjV9Ozmt+JrWKUCx85dR8NUamPZQcYbQlw776ic?=
 =?us-ascii?Q?lZbYHl2JXpPcjxN3puraZZr0seJwRnvUS+iW4hk6uo2SYeJ8lgQ6s3VU0FeV?=
 =?us-ascii?Q?nAZeEwEfE+B0oK/ZEVti+gKd5fFLWv3+bHySPzmqPuaAQC/kMLNa6Jy+RnvX?=
 =?us-ascii?Q?ZUwREep2LJx1uaYXMb9BJHYA3FeCIr1K7WMB4OO/c2NSUF/FlOcHfyqzepvy?=
 =?us-ascii?Q?2vb0vPeXngbr0fFVHM9ItnvxSUBzL7qJRxzVe2oT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b48634e-b171-4cd5-4953-08dcee81f5f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:01:52.7685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0j441ZQHUEHBVpiaIUSGi3+pV19OZ9wKkGovfu1fTHY9qZz5wkdoumbTfwInxzlYs4swJYcuPQjy95GT2ukVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

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
---
 .../devicetree/bindings/net/fsl,enetc.yaml    | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index e152c93998fe..e418c3e6e6b1 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -20,10 +20,13 @@ maintainers:
 
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
@@ -40,6 +43,19 @@ required:
 allOf:
   - $ref: /schemas/pci/pci-device.yaml
   - $ref: ethernet-controller.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - pci1131,e101
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+          description: MAC transmit/receiver reference clock
+        clock-names:
+          const: ref
 
 unevaluatedProperties: false
 
-- 
2.34.1


