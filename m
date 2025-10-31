Return-Path: <linux-pci+bounces-39885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FE0C2328D
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 04:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 272D74F24C4
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 03:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FEC27EFFA;
	Fri, 31 Oct 2025 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aYyIjzlx"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9426CE25;
	Fri, 31 Oct 2025 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880796; cv=fail; b=XNTWKTnh/I5a2DqhELOEnoxYUVzboa5dt33Hp88JJTYNpjPvwblDTFmt/EK5KcxtwDv8sIBzAgwM1cT7uvROFvNkZHfHEW620JzI684/xGom4NPtRki+qwzL2DzTasN0lgvi3h2bc37NnK7b5kY5jfrfoUC0K3Dj23Gd1vUFlLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880796; c=relaxed/simple;
	bh=glvd3SaRhcGK3nwlxxHpfQtOyV7+yYIpOJHIjIw8y8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P7FanTQ58dLMK5SyIzGpekcyGDnucxIy8kTVePv6NE1IqsrFxCEe+LwZbnmC5FQimeEtwMdaq/ezxRDYXtknJhRrdccPHVZuQGpuknQw4k4giLavQwWL+uGl2L42eNzDOYJtS+zksHXFNfp0N/vRMQ35YZOeZiTSGHXoGovjdmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aYyIjzlx; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRBoOkPMu4IHVhrah7syUO3NwfgnJqxbmAoieXMfbkbVVosZssUZwR9wT+Y5F+TUnXtbO/O9kaOIJwOs5pQ2YtX+X57sxQFto3APBodAxZOD4vIwFdACwAMUMo072EJ3+tG1yuUv23prLMeLZo25HOLnuxf+1OK0qTZ1YBz7QXETe6ky+whbFbzL4uVInUJkrzj2mSFU8/z0GqT9C9lU9KUGnFb7IiBzaYevKFBTz0+iUtVELkYEMavPFhb22pH3AGsK/hGLvIHTM3mPhhixIdFVC2g9mI4eK4BkopGH7VBExI+wHNWOpaZxQphcv8pempsybQTRT/uC8sl3rdylXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRqLMO9/OC6R7NrB4C1+lkRQFIhahJitERHj8SGeXIU=;
 b=NM56Jw4xL96Qaij2rnExqsRTpIU3e0Cdxyev5pTHZrWJigNrRrB604KdiJh36cYotNjJvba/DeCHaqqLPh0eUfxIEx+HlLokz8kx5AGIidTMbZ11F5qMNUkBJWREmrg+fw6+n2072aJJVmT0C7HduCbjwU1izqxGMa5GgwnfTG198wXKl9GReUX2FRhm5Z4p+ptO3EsoBu68MOzyKt/SBdFZ7MIvMslFZoN8fjQH1JuILRDmuKTUieh0Qk+Do+vIxNs2v6BMgoxB74xD8UNStnEMA59LvhM/To89Hwy7bOAYWxfK0oTxDDcMsG91TDSNRBAx10n3LtD1jn//Cai1eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRqLMO9/OC6R7NrB4C1+lkRQFIhahJitERHj8SGeXIU=;
 b=aYyIjzlxksJEDuh90L3nsAI0EE74iLs/CF1h32ps0TGYdUyb4bG/4sXPQQo4Uu5kSV6zERsiAYEt8+4D7qafvzZwyRpiy/Cd15B3E874TKmvlVZ7C1LlUKoZtSvOPRNCD7JYlnwmq5hcQtdaiyQ62OxMouUQQ+jF4Hvp2x5F2pqBMWrpbwRH6sAMafjXdV60BXj3lG7xXM5rTONJu2eTi+fZDqDthB+vmjdoYmJJ+VqnoL3I4JD9RfIwnLGNaEMguu71PVin5up6FmlE1ehewJFh5tF4rIYAFgICKnZW19sAV3IzKds+D1HvGgJjcFomV/0DsSZovea+bdyeLl6NcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM0PR04MB6817.eurprd04.prod.outlook.com (2603:10a6:208:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:19:51 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 03:19:51 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v9 2/3] dt-bindings: PCI: pci-imx6: Add external reference clock input
Date: Fri, 31 Oct 2025 11:19:06 +0800
Message-Id: <20251031031907.1390870-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251031031907.1390870-1-hongxing.zhu@nxp.com>
References: <20251031031907.1390870-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM0PR04MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf10273-0436-4c5d-9531-08de182c5ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eFi2RxHv+UJuaM7IfoRsQX6gcAEnyXyFEm4zC3+z6UEiplDhx07H/825bfut?=
 =?us-ascii?Q?22W9ctVkT9VfttKEZDyf+bKjwxZWuQiL7ffx6pIcuFiGXeWqZKzk8m5rgIMw?=
 =?us-ascii?Q?ScqzHlR7h11w9lf1B88R2vRFw/ptmrvCC8I8wyZVxvsuUsDy53F44fSGqXo4?=
 =?us-ascii?Q?Rg7U8V4nr4SDA5XuC3yub2ifGk0YtzK/gtJBro5jKQtE4U0VAYczMbWTtQgh?=
 =?us-ascii?Q?vqx9fB0wKNlcjhiCJ65/fw5Cpx35QjFskxzNbn9+GS9RiwmDeYAFCMDW2Xtg?=
 =?us-ascii?Q?r0rutiWdP1lh1mq15+bHJxuq/jzbyANxZB7dO/lpGFFCHbjHNYawCGLO0rvf?=
 =?us-ascii?Q?apXronlbGOLWBW9Ju4I0NWERA5bWrZ11hVoLp8pnt9BM2F+r8sKSTTRizxsW?=
 =?us-ascii?Q?7IwdyTzTj0q9Wfr7WxtyKW1tv2E8ASMCZbp8J9nIHiEm3HuFSukgD6KYeUjo?=
 =?us-ascii?Q?hWkxUkTm8z6oMIVBxuCd+2R7FmRWznfv2nDTOFAMEvgj45ddNkWInFRKSliN?=
 =?us-ascii?Q?jpP70fpI2I6TyzHpNeTK3Q02yC/surJbhxFVpiLrHdaZPl/+oh55HyBoi1s9?=
 =?us-ascii?Q?xRQi4M0g0C/r9ZJ7llM21maYDLKGReCS1v0YMeIKtVggcBUJaTaq1s6DLXC+?=
 =?us-ascii?Q?ngukGjhMJ5hcerjTy5aG3R+leU5zqI2k+lvMhpSC6AYQL4YSNd5B2r1yyojx?=
 =?us-ascii?Q?RnLGIb/xrsgvwQ6VueHPu+TOwFBYsJqz8fc91m8FNurLQ8uIRJdpM+AeRZTu?=
 =?us-ascii?Q?N50lVqth2wXepI6rjWW8SrOGozHLdj49S8y2O+jAbSyJWAg6ZTPOKgaK8Eco?=
 =?us-ascii?Q?1edfVFPJtjxpFt9Z+9fnuzxIokREiJA0IOkun71EYAjhLl03FOAmPYdHRL0g?=
 =?us-ascii?Q?gZj8C4PYE+KOQ0axANLaqV+WrY1da/ivsgsUvlXi3luuy6AxiAF0wUej9x+R?=
 =?us-ascii?Q?jbMstF50siArTYf5L2qzVyo2JepYb6j7oxnf2W+3uVbvY6saG9ObJYMMCsSU?=
 =?us-ascii?Q?PynTwgw1tj3G4IVuglLB+3W1IPqfQvuWWZsHezdVKMYgYJdcebQN5EkUtfwo?=
 =?us-ascii?Q?Cv78/nSq1SgnEX+bRS9YjodzpTrYVWacDz4ETRUKFZKo8nUPZ8Bm5CIoymMo?=
 =?us-ascii?Q?kV+Z4wk26W4y1I/az74LRkcgw0y5mNqGTZMke1GMeHEm68XieCFybOByIUsk?=
 =?us-ascii?Q?8ewtyHs3NcCeMbB1H1u45pEoQ2I2rolmL7/5FMV+IKPNAmL4fw5cKmfC1hsK?=
 =?us-ascii?Q?B3nJEhry4mOotsRYqhdzqblRJtlcg8ZAe+Wb/ez+iKQppsfZst2BytpbYzga?=
 =?us-ascii?Q?ppR6VBFWeANA2muUyDA7Eny9js5p7Kb70uWZyIjqRtb7HsgeEn7kUaoS3Dhb?=
 =?us-ascii?Q?MNLwNVwrAincRQxTjaAlNiSetFe67cQp9j6GTRs0M63Z2XQd96a9DqzE+6gt?=
 =?us-ascii?Q?wJsk8aIVq7zGX32aGFkJREVXKEi/tRxOf0lIfa5QsW+EFV9ijgjV/mY2AJcT?=
 =?us-ascii?Q?o6f4v6fHIzwcUFd9bY/hT+Gabo/30sh9kcIL7upOeSdHIIDhnTEqpKOyJQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FIAOXB0qIJ5br0tuExntWCGPuYn7FlRzn0a/7Lu2fd6Z2l+LBdV6D9pnz672?=
 =?us-ascii?Q?qCfk0tk06OqjBp4rCUwRe5xnWJK4LY+c6TiSEEaLq+4U8/BTIwdCidS5gpqN?=
 =?us-ascii?Q?iQNM0wIOc6ssfS46zG5Sm7b8GfiTcYA6ZlrCgTyXYwiCoWevfpgTfZV+JDBr?=
 =?us-ascii?Q?fy79BTbQF8EbRvJEpeZR7ru2uF+87cyymsHb0o2j2ANIksljgaTfuNhPswAj?=
 =?us-ascii?Q?iGzaW60fm/ENNugwC3d07bexyYpG0hOG2Uem/mobeSMcvtO0oJgQXzzMuMwr?=
 =?us-ascii?Q?XRZNTIiF0PgSFnxLTxbw7n9nYyuxYbaehsE+0u/vXzvw5ilV62n7+96tZlAH?=
 =?us-ascii?Q?eHDJJlHqzpnBKCoplUofMaiok3ifOZJYogCqKRKcIXhJ9P0dJIyPLP1MxLi7?=
 =?us-ascii?Q?kW7hWpDJQYO6tolZzXp1SYMp3Q/6JNxxkLHNWUz1dj5ijHfjw/Fc3GuW2oAi?=
 =?us-ascii?Q?X8NdoI3SdnHJmt8As25bHmeIIDaFbxxk5gr5njT5eVJHpw/tOcRNDSicM3us?=
 =?us-ascii?Q?h4LYzC9vdq1TH3ipIERRT5OE4u8n/kWfKK2b0DdbO5LBRYon3eNv55tgiq6K?=
 =?us-ascii?Q?p9VFFI66hR1dq2kALt9Nk9pOgV+NebgW3tiKwHj9f31nWfAlyJWhDNmHMw+w?=
 =?us-ascii?Q?jr191gVXlDU8rwuwoyFCCFOH6dVc/S5wkXldHFhR8wARWwQTmKtFilFxJ2Qf?=
 =?us-ascii?Q?FpGnLaKQ7LtRp5YVOOy0oWZFwJ8WvUKH/Kzy78PoOvj4E6gM1+q/WJ6mxpVX?=
 =?us-ascii?Q?KJcAuDqq5SlyejklItyug2tmX+wE1rynNzwDP1dqDOzoJvSydSbl/O5c7/TI?=
 =?us-ascii?Q?SNdHbDcG0pNeGS3CUJ2wA2puV7lmBmMd8CTwOwwDFVPaCzS6WrN57yZo4qpT?=
 =?us-ascii?Q?aiuZK1vQZ290mq8Mm+AO9bIDkpcjei9Ihr6svgW34Tzp1LEjO18K59reyBzp?=
 =?us-ascii?Q?uokBH62WsrJjofVkl0j209AhScT9gVp8lGVVbKF9EOjm2quC7MsxFl5XJFWK?=
 =?us-ascii?Q?vNF4K6vy46keN3zCZ1m0t7OW6fABMbX1yv4N+dvLQsFezsT3d2l/BvbuNIvW?=
 =?us-ascii?Q?UiX8ZwxQxG59AdsC8aNAl6yANkeZYYIYk6bRxtBCcW4zogHBkeaQO89nLv76?=
 =?us-ascii?Q?p5YDWEwoyxk1qqrC5/dDiD6ZeJx4A4O6j/d+sdU0hIzmRFR3/p/+3AJlbHQk?=
 =?us-ascii?Q?qD5teeWXrXb2ImTb5lDAsLVs9rC7zuh+8ko7y6OkjTAxzAede1nwWGzIYhtv?=
 =?us-ascii?Q?/9OaR025Qgav3C3tHrbDZND2Mm9BvNsVBM/pLGRxu+lQolzUzdEPq40r3A3U?=
 =?us-ascii?Q?i646mpWTzmbzHoEOH+3E+/q2T2E2RxrJuRSFCkCApd5Ypdpo7fCCFDq3JiSR?=
 =?us-ascii?Q?jE97r/w3JqAfkrrO0hzT6y6oF0+WwR36GMBe1UIUkALrGBJTME6itUQX8EYA?=
 =?us-ascii?Q?lOBabvYMA7ZnmpRF6kgA6agPOwWEpPeDGluywVmPwEGm2o7v6hU3awAbGc5N?=
 =?us-ascii?Q?eujuHV0K47JDlkFQ3zvXqRRefigkdpuodNVhQCuPe/kahaKfSfq19jT1ghUS?=
 =?us-ascii?Q?3CibKX4mcHdhocBB+G7NQmpvRLLqE+1Bi7RZUREa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf10273-0436-4c5d-9531-08de182c5ad5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:19:51.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ra/z4m6sNZmG4iNNhDoo9Mu3z9QcP+KDeWuNvK5bXqqA/s9dS+SmI8i6/iTDjti3wKi9ydvVDY7K99Ex42EZMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6817

i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
other from off chip crystal oscillator. The "extref" clock refers to a
reference clock from an external crystal oscillator.

Add external reference clock input for i.MX95 PCIes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index ca5f2970f217c..703c776d28e6f 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -44,7 +44,7 @@ properties:
 
   clock-names:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
 
   interrupts:
     minItems: 1
@@ -212,14 +212,17 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 5
+          minItems: 4
+          maxItems: 6
         clock-names:
+          minItems: 4
           items:
             - const: pcie
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
             - const: ref
+            - const: extref  # Optional
 
 unevaluatedProperties: false
 
-- 
2.37.1


