Return-Path: <linux-pci+bounces-15570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71589B5F57
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283201F223E1
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2E1E32DE;
	Wed, 30 Oct 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RDpS0Wvo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE9A1E32BC;
	Wed, 30 Oct 2024 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282092; cv=fail; b=TYOv0/VYpRdhmnXXPu9CZHQ0JKveYkUAE5wHQdVO762H7Hi8VcIF0x2PvUg2NHyCC0IucIEnQB0v0dC9QGX/uSvoJvxXKnNFY07D+KhIH2yRAiBRsYRNXJGH5Z/NWOrSv4Giec8o7hrh8YYD6yVdnt8iGzyyhXKT+mm8p4Gy9gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282092; c=relaxed/simple;
	bh=rniyf7Yxw4BAxWUJO1iwBwhqrfYWWXkxrT34rzz4Pss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sC1oRDAo4XHTYt+3PdnvxPCa4yryXpJsYjUnTCk548erHGPomCcwe1YrJclM6rSqyLEYA8Aj7RjLWE25yfZ4HnXPgSJ1SMdONZDalJudwjK13sYjk682gGXpTDCohHd8qgRa8jtX1mMoNaPp8QXhAoGBU0bPPosu8zHEh4LnMgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RDpS0Wvo; arc=fail smtp.client-ip=40.107.249.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9BCAiCGR8gOIV5m78kZ6himyldx2RtlhIXJ8hjNCyocTQc0uXh0HHZXzq4BiLV5alGVlDHm3xMapoB9yOJkZgKxkrTz6dfxIAJcmsGOY3NGUwVLK2JuRV43vyUEk74hBgxx5TU1IsLWtEM67YBvMeEdqSrJqlbWgvDzOy7DhuZHH6f8xQksJRxx0L6Y87Y0avccdhQBuj8Q34cenRoKFTlEkYyNXFmxhhRMGemeFZH/hd1wRWTR5A7batVARUa47czBwvs/MGwHcWZyblB6aRQX6/wCXpfvekmulrsXBxoROb/k2OBd47C9d/3y+clZlVehSeTKeBaz0/3Zk3MH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUK0l6Utl+GYdHNvpbsSBEXzn6QKesyFiji3dKJO70U=;
 b=Q3qNqkX4Ti1l3D5/latyRGRcfbOW17H8Z2LNQ81UxUfcWORd4BmSV3JvYYD+URJA6muqGYJKhKKYOhJSPfrpoZWznx4RonSwOaN8c0VZxqUqgAhPEs0bc64aN+yPpCBqnwteXoeKdoiRE2hgLSLu7ZmCCQPlctTVziGifMzXLW6GFdvk5Nggqc9LR2VPplq6R63B2PX+f76c1yHPkvj9L1BTCoPNTAlXwVzzPHpVJr9ydIBbYP1NHv5Jh+GQehDf2Y1QBuMRBxX7ammPolE/jEnoNifyPulEstllcB1sYSSUrDvmdeQpyr7Ilp149/zGTAjH57u9mRzvuAuaCwUQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUK0l6Utl+GYdHNvpbsSBEXzn6QKesyFiji3dKJO70U=;
 b=RDpS0WvoNoTes/tU3+mjSnWU3MM2sM77GvvDQz3ajGgazSzVlcmoNWkIBCqs2kLwnuy+C08zAt9TpOIs7EtXwDgrTAbhBqxdICBAnOXAcOhfcb0FiyNKlNTTQOoUNclmut3HQp4xXcMVCF1fxdNYF5JaYJbxd0kwBDYHr4NJfMd91XmW6WdGhV97d1ECSiwdJBn1D9NyHE+DkLZL1gP5QbpbmpSwj2v3RgOiZzRpnWJCEgNK6qCFhPjvKTRLfvruvwDf7QWyNyTPQg2m9nnrM3WnPRLPnHlR/YqxxTu8go56nGeFB9SCe9Ek+WclevZZELQhiKNP4ahienQetc/zMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10347.eurprd04.prod.outlook.com (2603:10a6:102:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 09:54:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:54:47 +0000
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
Subject: [PATCH v6 net-next 01/12] dt-bindings: net: add compatible string for i.MX95 EMDIO
Date: Wed, 30 Oct 2024 17:39:12 +0800
Message-Id: <20241030093924.1251343-2-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 74f13a44-acd5-404d-b064-08dcf8c8e387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eh/mBw7axHg6+By1STQlyqkIL9djSGs28D6v7qzxMHz0oI4ttXhRxNCCmuSB?=
 =?us-ascii?Q?jVhIjMW5gUqs37Rdz6m1mjFKzNFmkiFHBMl6CWTvqHU6lT+RTTcJd1atZVX8?=
 =?us-ascii?Q?3qEGTpT1qsqrGJ8A5y4Dt6rRYFUU5uOmgJadGQrWRU5XmW+e3GY1Y4JGNuQi?=
 =?us-ascii?Q?ahkxzj8ujNlWvAV6xwl9fRrXQjQitmxU+Mp0ya1ouJYilVflfpE5wdkawTwJ?=
 =?us-ascii?Q?ff+Yjo+03kjTSqiu8sDiDYQxRhW+nyIgOSYEVNab8m8900LNFFw3O+CNqsiP?=
 =?us-ascii?Q?6g372g7e/QMpEUvxXMjdhtBCsASruz9UYP4wAkubHoe80GvyMS5uX5Xb0TdI?=
 =?us-ascii?Q?sQuQTyKESA6CYv30hnmDcElRDHhGZBbfL3HG1g4NGSp0YcFNuEYm0zMKAcb6?=
 =?us-ascii?Q?xvZ7ixPzqqZitu4XBlRix9OqBwqI920wzgg0Bd1aTkIsEqgUMF08IAaM7zsB?=
 =?us-ascii?Q?+OXvZXFD18V+x/JJwqCz+sSZXRZZsUTaWruwsxbobq+VAvXeGYbCeLo54m19?=
 =?us-ascii?Q?OOb9BDTkfVOAULlbym59e5m5w5s2rNYTw0qvt9k5cRKWIkPiweIKywJpxBmh?=
 =?us-ascii?Q?w7zjl/QAWcdOaPG8K+/TMufkWoTo5qeekEHWVSkc6DpjFMeXH4NL8u/LZhJq?=
 =?us-ascii?Q?1ERWLrJT5Ncg9oTIo8oQQ9a5JMSVPuFmHpsfTRqNwOsK/QLwffK0xM3/MmC6?=
 =?us-ascii?Q?4UZjSUzinS1boYInrpAPoZZe9uC4BmqXrcECbU4UQ61lWD/dxju2ui8Q4Qh4?=
 =?us-ascii?Q?hzJQRayD4vk7EzwcheWynohGEPM4lprm/MaQCKYSvDXHaOIE+2wzjQcFWUjK?=
 =?us-ascii?Q?Ft4I3hXYoaX4VwGn8nSRTPa6Uq2Qg4zPfUCL6YlyZ1LEBXFa+dnJhMh5MHx1?=
 =?us-ascii?Q?S5EILH/DPTbz0tt6QPCCEnJJX1X8g6DoUk4nNK0UIStdney0yHkvVm5i2LDg?=
 =?us-ascii?Q?WcXAqfyPtzDQl/sB9CDxHNujwofmiPcwJoBReb1djqfoYMZel4bexlGWyHjj?=
 =?us-ascii?Q?zCsYzrjHiK3Q31J6y42njRqZBCAcV9tGQbkPFxCGWaaiZcKTp2XOJLCYR8x5?=
 =?us-ascii?Q?PbcvWwB4OLoH37alHQh2SkR3e1B3SZLXjfcWzZOFg2rvRcTaPW4H7ovvdyzz?=
 =?us-ascii?Q?4vurlcFKgIirPAkkfZKMn4v6uTvsKftlWT9TCTXwfs66Exxs9a01G0HaP1Hg?=
 =?us-ascii?Q?PTCv4oLQGx472T9vrkMfcr0jrESlTQ8n04GoT+m16QtSGGH2Mbq8TiI4JqiZ?=
 =?us-ascii?Q?vMc8F6Xh3n8UVR6tIvIINhIV8MTwbkQsy0RbjM3FbImhNT2YM2zN6AAA8uzn?=
 =?us-ascii?Q?bSdBG52Z8gtDSkLBA4wz3089X+UsLjm5ah2pghjcoVKS/EbDXai0ple89xSC?=
 =?us-ascii?Q?6ClQJm8Voj/3C5CL/tpVvNkrFw9/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8zuPFWa+1PPk4DyO8Bb2gpTplazF7tcUZkaMANVCPk/3cEEWrak9IDwM3Fb5?=
 =?us-ascii?Q?ARPBDUCPohMlLPuAmIUAAe5Vfn73BK0kgzsEKR5qOlnVnJOfpBqV3rc2PTB0?=
 =?us-ascii?Q?9dEkQ38Mhv+FihEgYlex8Cgrkk/hmslRD8UYakabRLtTaKzTL51qmFHEmtBx?=
 =?us-ascii?Q?uDOWmwFAyso+9BElQ3+dBkuqXEj1UytVkSKtkf45u+dv5jSy87T03exoF/NC?=
 =?us-ascii?Q?Oac+jbyI6tueokD5ULThy3NPeDzTtAZ04hD64omC4e8sYU584fj0R4/3CrW4?=
 =?us-ascii?Q?0aBG1zusObw5NHJV8cs689jZl4X6b7bjjpO8JHCnOjmkmpUvdfs59WKsObTI?=
 =?us-ascii?Q?FAsvfGKEVzUfIj1WxvWgINCjDFUHrBnGvJac6BkfRFfZZ78KGZIrThhtEqJb?=
 =?us-ascii?Q?lfTHkkSeaqmm8sxso2rqxMm/xBWAXDAy/VUOF3XcTxFvX/C/Igd0U8XAQgpc?=
 =?us-ascii?Q?5/HBqLNnW0JJNZ+YmZZMO6q37Ux7AgZ/aDnbTQtcJ8NDps8a2T5Knq9qeLAq?=
 =?us-ascii?Q?Pg3CSZjwA7wePL5AmPWjR/j/KHUeRt4yw9/e8DGQnLs+CthlNfoOtXvuANDg?=
 =?us-ascii?Q?K4TV9BWtkpwf6k7W4WD93ozSE4LoopgKV9GeLgqG+Q0Pyamd0zZoBoMd+CEC?=
 =?us-ascii?Q?DIEKTLcRNeE4aGw2OUnYZhj1oPqnEmgVXycMQooWLCWsZaLvWyiGls1lb5BI?=
 =?us-ascii?Q?6REGSGuo+fGf3aiHxwcEONye67rzJ5/9CFrzdHfggKY429ulVik2SW27hKK4?=
 =?us-ascii?Q?8VrsYP2VQyM02KVeiDNq+2Tnk/4hDjtKkgobZ7sMTI4utBQMeOBEvGtMQKOD?=
 =?us-ascii?Q?6WtQDVoFoadmKhaJAP2r/UAioRBWeHf2tm10JnTKZD/BhBm7b8Mz6iZVdxEP?=
 =?us-ascii?Q?uTk7PbMCS+Z6OF9dgCcMhIPwDCrEFKNHl2ttgQoQCx+0ags1CWzrjSpCn0+6?=
 =?us-ascii?Q?vAC731lgy4QgcPSIEuAsMk4x45rj7Q9FHHJyejFSrOFVdBPyU7+FWU7AQdya?=
 =?us-ascii?Q?c42nLxB+AqhAsH4k5azFKc3Wn7qJKqU1BigFG2vEeF/eVIed6LtlOKuDgZje?=
 =?us-ascii?Q?wklxcStUxYtmUITtJmW2cA8DFqngg+BhcvdJ+1civYlYVqxPTMRkBIDbXQSt?=
 =?us-ascii?Q?h8c5yCVm0CQ6uk19fgmzoZK841ymp61mHn/BimO6m5fLZ7/mBsXjHiMUVmS9?=
 =?us-ascii?Q?lOPIFIqp+oxx6qztaMrn0pGJjkg7U58LljLiBJmCdVjmUQ+VEq+pOqIsq5qV?=
 =?us-ascii?Q?N/V/gq9Wb0lQq1yHibGneitbW2sAwDqCbg9tKvBXntce4mg/cN8Ir14cWzqa?=
 =?us-ascii?Q?nd/ffebtqMAQfKPHcPssCGZl3ApZ6m9rmFhNKNL/u21eo845cfC76KU2bc4n?=
 =?us-ascii?Q?eCi6AFe0WGynzzq2EJBIhYmthspK0q2V6cg+o/Zjxg0pGKS85iEJC8HF6Mo6?=
 =?us-ascii?Q?WeoGc5xLM0z2cMS5wS+x6+8RXypTgvp8lVU42MMu/V7icvpsCcj8aF+9ISBq?=
 =?us-ascii?Q?d+ASmYcaYUUEPK3tjGDLIwQbYp/SSyBfDIgKxlzvWzfxYsscTSRBw4q+NWPC?=
 =?us-ascii?Q?VWJh3ssz7LXrhzD6dkTgtrmFiT0apX72J9dKnUpc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f13a44-acd5-404d-b064-08dcf8c8e387
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:54:47.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FXoAQvW6v8nZmqzfbz+rJTEmCTYsElmFZr61LoxI7/MZSBlAxAuONj2U6UpVJ7cVQ+4AqLfR5h2tOUzXIIErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10347

The EMDIO of i.MX95 has been upgraded to revision 4.1, and the vendor
ID and device ID have also changed, so add the new compatible strings
for i.MX95 EMDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v6: no changes
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


