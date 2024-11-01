Return-Path: <linux-pci+bounces-15775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E59B8B89
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05724B22CA2
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 06:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB21531DB;
	Fri,  1 Nov 2024 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cwhxMTLE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE914F9E2;
	Fri,  1 Nov 2024 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444178; cv=fail; b=if24pf0QEKw3l/0EU6G9H3+s1nXUleSw7pZBfzGGpy+QWDUBKtyqxDzOg30dSp/ph28mwG/n6iVMkiKw48c+IflW+KttqZQCrkEQFlB8inFGlUXtsj9OuckopgktySvlnx8ggQznGxiyWwZlHIXekUQaoMQoi4T07lk00kWJRG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444178; c=relaxed/simple;
	bh=Mmo1xscLTlVQkjVIAV9EfjQZxTeKpeEgRQ6ZOQA/96Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/S1+9OrFfbX8dGDLmbCc4eOGHzgLD3cpmqXbqrVgpBw+PT1A0p5RBUfkvmJ72IkDUxqlpH4Gxzv5tPicl7BHSPNrtbWnzuDIMVU+XJjwbK+PXbi2frqea+FTWGFt5khFGCkGCfJ45Grw8WsCEWebpmQtabiJe4s/DxZKjx85EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cwhxMTLE; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTC3qGrlvRPG+fjQcXqp1GoO9qHydp+dkl6FQPRXKceKRIxdedmhpsC9hoVFpXJurdQMbmX/OEJQcZlIUddBtEa1PdFwkp+S+A1AkfSDYyJXEAyE2Fjw7QBKghcSyhnVgatxqEVf6BGaVTgrLzkz+aHvn7HOcRSj2zk4ybhEchJwTCnSXKa2lw17B1lDdvNZjzM3urGMcz59VmF797/9R9QMkI2k4xQFrNOYJOQF1MSbe/iGtZ95mlbIOwgAiDbkLVHqHhCniUMv38MgCcpRmNdGuAjOsUEyS2jMOipWZ0ZUIXL8kB+5HxCkv0p1NjW58KWTryMwd6f/n5FzUOzbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6bJ8ZdNq0jbMIzriN3qMBzZw9hotPrRliUnnqNdEcc=;
 b=RmGSTbMh278bLNBSUzI2Qr9+/deEFD9JUWehzeXW008EvBVk7HPn/j8AqeNYbhtZZLT3V2oCn7KPsXTkKlN1Z24l6FNXAjVTB/3r+79txxuTXbDaUk76pJdZEMn/w7744PzWaMMyqyCKP1y4J8iHEXLabgYBw7qlojr/jArNuef8ru+2J3Gxr9Otvqx+RSGepHRK+w5nEeaVeSn8yZjxaxNZwWRCsO94y2/hizwHBHTag3WqaK8vTMB9Fte0SqYBw2DRjaX9or5t4zeOCzK+zTfMR49xrRJnQ2dQuUacYHS/+AGh5LvXiRtFKI9+nlSf2YCLpwBSZNkSu2L/BaWqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6bJ8ZdNq0jbMIzriN3qMBzZw9hotPrRliUnnqNdEcc=;
 b=cwhxMTLEJo+BTy+5fvVISL5rQgd0XRsuJU8tn4PSoK4k7GQd9Tk1FGbPzOrE4xLCHu/aGKvEr/M6e+JozDh7ah7Ym13gj7aoD2g6EFxbKjegK4E2upR5En2y++vAdbsHiaON/8Jy7vl1Rlz2lMGgDPsSSmZ2+1ik3nzqplP+4vTNOfMdwTsT5+QzGyv6NXXdQd/9yygDTHKE75Kl6LttBpggapBL7gLKVThulpAVA5CwsLy93ZbqLCEQXPnASpzjIDgCUb8bggplwUx18a37KhFmP8ZLXUYUzQwflqymONBv08fmKoQ57aRzPD/56JcDHd/HxZetFW+B2hf9z2YvIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA2PR04MB10445.eurprd04.prod.outlook.com (2603:10a6:102:41f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Fri, 1 Nov
 2024 06:56:14 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 06:56:14 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 01/10] dt-bindings: imx6q-pcie: Add ref clock for i.MX95 PCIe RC
Date: Fri,  1 Nov 2024 15:06:01 +0800
Message-Id: <20241101070610.1267391-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA2PR04MB10445:EE_
X-MS-Office365-Filtering-Correlation-Id: 610259a1-14d1-4ede-9d41-08dcfa424705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wpw0PMLyAl6hm2NDY82IxqVOnUst27uLy6P5G+Y1IwkqeIF9mR9Wwsqte1Ae?=
 =?us-ascii?Q?YWdYEjcx9s5HcixXdDRyRxxrhRGQ5/YVW5xHN04FHrkrdrZOGSh88OImD4WQ?=
 =?us-ascii?Q?eH7WlrczzjK3aL3k7Rrwt09gjus6F9lHJrvSe8kWMmcd+T49/wZr0i6u5CIH?=
 =?us-ascii?Q?nqiTmK1xf90/1rpco3rOxOy9wXGWPLewb5ZSESYkwAseRhUuNMKnynZ7CJq7?=
 =?us-ascii?Q?Gh4rScRm6Edxz21NY5dVITAZqLeIX/Aadpdd4coHutAd5522RcF8URoSez5K?=
 =?us-ascii?Q?4VTpT2NpyaOIdHXdlmBxkQ7HXhd6HhFqwBYySaZjyJspgbo20ev/sQticBY8?=
 =?us-ascii?Q?akI7IssH0SxvsGWe3fcyc3msw9SeTjKaikdmxse7CL0D+4vi1HD6QtvaW87j?=
 =?us-ascii?Q?F09eagGSQ0IrS3FaYse9G6/WfRVs67wTOYDQqgK/TmKGqWP0hjJ9EIdrSoBq?=
 =?us-ascii?Q?/9hJhjFDrtXE/woQjc1T5bBGwy1HGNcLOiNxHMbyVX1o5NSGZG1j6sc7VzJx?=
 =?us-ascii?Q?mJ+KpwGdEwnyXYhSUDQsdpgZe/iBlaFExzbF/FS1ASyi54Nf4xcNPUWMq8lJ?=
 =?us-ascii?Q?PqMtdu0lfx9kTpsvs1JMyOKOdF0WmeQDB/IOGDGN2jcqkrxrTfFi2h/7VEM6?=
 =?us-ascii?Q?BmAXTbcVve54ydPPkAXmRYZTvC80WChBDbSjC+LN+Vo1/wujmSTlyufKiNze?=
 =?us-ascii?Q?qOrtgbiqzyz38lz3vz+XHA4fN/jjFdpqrt8ls0xKLJxEUGWeJaPbfYaoRwvb?=
 =?us-ascii?Q?0oQuCWc0vknNbBJSE/DknmfJetypH6DuhdMjLZuuWgItPfE5w9g2vhvDiGP5?=
 =?us-ascii?Q?6kksgmZHIE4kFX/G0PSn37NeEQV+8xwQhd9OMdNJ5+/ACpxCLhsFx6iC2nXp?=
 =?us-ascii?Q?mee4Pwzf10amCrD6oPna1g9NwsZANtm2SS9pEoZJU18Gvf7QBNfr7+UtBvA+?=
 =?us-ascii?Q?tGW9UJsKlDQ9Optl6ilAT7ZvuCXMNRhpOPjQCUvC3IYsAgLLrkQJGnaZA3Qf?=
 =?us-ascii?Q?4+5TqL5AEDYZXFVpDQE2fS1F2gmpOU60DyHo+QFsgnvOeoFBKdQWS5zKgkJP?=
 =?us-ascii?Q?T/VzCq5BZD4jL8/gmRn+sLNdUTKgUKXEwtbtxRstZKfEzDwPnToHtpX8kvPl?=
 =?us-ascii?Q?YYc0FUkH5FfozPwi6UlsWFDcmv/wsIasOe/q/pgT0q3ATjyMnInmm6D27lcb?=
 =?us-ascii?Q?ztjcLw50tRM7OPmpRAAJS1mR7z6NW0dnLggkIlcKCZ5q4zieUUfcojET+sZh?=
 =?us-ascii?Q?ybOpqkof9y50p5Vj3DZ4KmwQiuRiQi8AKsod8eyWJsBLmrt589bngoqsqALM?=
 =?us-ascii?Q?LCye1bxp0PVo60LOzZIuVXHrEQymgM3tesxHrXpVsL4ue2YP3/eYranUGub5?=
 =?us-ascii?Q?hc5u/B7KVAGuwfRHtKFc/NCntmjb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bi+mgOUX2+TFtI4mJ0x+gAK7UEqgW7Vaz2EFrDj3OyNTKtYlz51yJ4uzrhe8?=
 =?us-ascii?Q?dfIjN2deEfkNF2fxhmQh8AbMcS+AjDgM78UDlxSOOEmGtyKnS5vChx2MYczt?=
 =?us-ascii?Q?LqddjkTgFY9rxGQhufgiVDHRNRlEiiR4iwlvUAncMDWlAgMvRTOcrZdHDKBD?=
 =?us-ascii?Q?1IaTzr8oUtRxv6NJQ/FVJ3vgpjysrjYbD/BJcjcj4+U0EljsRneNQJ3EZmSd?=
 =?us-ascii?Q?AzCzzn7Vi+3xjVGsqoiWDv62V47InGMo0pSSNT2j/ueBI3nx1PlefZ1f3SRe?=
 =?us-ascii?Q?sYw01xgYarHiLGGTN3ylVb2KZLwBZmG6eoFNAhSutvVRgTZxINg+YmfrKMa0?=
 =?us-ascii?Q?JtD3tysRHud2W5znu8//WTwb0RjneaFKyOSNH/2wtIkiteIrXnjDBVxD/mCi?=
 =?us-ascii?Q?c4NLAv0tXMtu9SrncOdiIPZJbnEVcpiXPLcDll75sTaUEe2MEoQ5dJbqhqhn?=
 =?us-ascii?Q?cUaSoQdGama71uakL9KDf+akQJqdLN/8cC9iWksUQavZ2xPTUXLk7rDA8WoI?=
 =?us-ascii?Q?lSq2lZfW7c+xdkTiUxyKrtP0HCytd1E0AH/MYa7oCLk+vuXdkDfFK9L8h/i/?=
 =?us-ascii?Q?MAdo1i1s6VsyEHFecgNoKMhFB0mV8UabNJUNTNR9Q+LRjHZIcUjcUxVPJ+2y?=
 =?us-ascii?Q?rhBVaYODnL6BuXMUcllIcMSULFeeOYA1dK95zRUvAVQBNT7JqCASJkgktdBH?=
 =?us-ascii?Q?7J4Jn4TFF8wWd62yAApIqIhzv6DNcmyPeW70DRY8D9KWxgBMwJTROAbkOszE?=
 =?us-ascii?Q?p2OpgaOpFdCah0AXMHjL1Sf224U5BlCXqPJf6xH3U4iM1FD6+AmNoqR9MbVx?=
 =?us-ascii?Q?E+Upvj4XVsFevyunTamQuN9fYc5oUFCSbqpE8TT6KfT88tbxXLPlHW2oEit5?=
 =?us-ascii?Q?jV9btXoTOQXtkrw7Xuw0J3+GAeFL59i80STA8JQ4TcWfqkM6lwcctR7vlWjU?=
 =?us-ascii?Q?Uq9xxlQfLBdVeiW9MTv/SWnelOaHCyJVI9i8IPzCjhTswZwVjF2T2XaxVIOJ?=
 =?us-ascii?Q?C5Cs8ZkzUiZUrPjd4Wxng/edgygNy3POfcg7y1OgWHlLPt9OaqtZnaYyHTZx?=
 =?us-ascii?Q?aOTa0lGwV5Scz1Moo3RKBxt/mEEQc3zMIec2stPv2PSHtw684xrXewC+Ms0Q?=
 =?us-ascii?Q?1JYpIM9+evlKRmk8fqfDdDRIilmldfC2Bt0315RQjOeQSc9kFArOkL3DGiV6?=
 =?us-ascii?Q?Rl2mIcHgCd2TLZoV8T7EGu+57NLyPW0Q2metXD9LQ89RkbQiqrpuMHQ66MVR?=
 =?us-ascii?Q?K4iPF7I8E7vLriRG1UO+u26KUB9Nkp84MITPFXmZTzSlWD4v+xeKuyRVURJy?=
 =?us-ascii?Q?xnh1Yep61eaUwTzyKG03mlPuiGkKPi/I7YsCrGY/2PlXzrmocZy/tWOmXTnK?=
 =?us-ascii?Q?EGK1KwERPJRVjojs699O5hKx5fvQYp6JcwSzWfCkdHCLueBOYbi9V0rknZPN?=
 =?us-ascii?Q?D9qRpcXK+Qgu1SayvqGT1hnf+GngMrq9Uyw6yEBZDm6LAZpUD8kI242Sdt8B?=
 =?us-ascii?Q?oq5cB9gi1jKg/Ynpi0g4WlkocmRXZ/lBh8ur9V+MlhNmdIKRX+H0/u6wbsVx?=
 =?us-ascii?Q?wGCM+/8zyYmMjtNIUsVpggvvWvsfiMDLQ5SemQ56?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610259a1-14d1-4ede-9d41-08dcfa424705
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:56:14.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ir3lbi4cd0vBsbKHE/+64M8qzMGNs6Jm8m54A0ZeWBglXtf7sS2FTv2t/hJj2QdaVftlLxJKIUMMfdRFpO4zLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10445

Previous reference clock of i.MX95 PCIe RC is on when system boot to
kernel. But boot firmware change the behavor, it is off when boot. So it
needs be turn on when it is used. Also it needs be turn off/on when suspend
and resume.

Add one ref clock for i.MX95 PCIe RC. Increase clocks' maxItems to 5 and
keep the same restriction with other compatible string.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  4 +--
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  1 +
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 25 ++++++++++++++++---
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index a8b34f58f8f4..cddbe21f99f2 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -17,11 +17,11 @@ description:
 properties:
   clocks:
     minItems: 3
-    maxItems: 4
+    maxItems: 5
 
   clock-names:
     minItems: 3
-    maxItems: 4
+    maxItems: 5
 
   num-lanes:
     const: 1
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 84ca12e8b25b..f41f704c6729 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -103,6 +103,7 @@ allOf:
       properties:
         clocks:
           minItems: 4
+          maxItems: 4
         clock-names:
           items:
             - const: pcie
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 1e05c560d797..4c76cd3f98a9 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -40,10 +40,11 @@ properties:
       - description: PCIe PHY clock.
       - description: Additional required clock entry for imx6sx-pcie,
            imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
+      - description: PCIe reference clock.
 
   clock-names:
     minItems: 3
-    maxItems: 4
+    maxItems: 5
 
   interrupts:
     items:
@@ -127,7 +128,7 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 4
+          maxItems: 4
         clock-names:
           items:
             - const: pcie
@@ -140,11 +141,10 @@ allOf:
         compatible:
           enum:
             - fsl,imx8mq-pcie
-            - fsl,imx95-pcie
     then:
       properties:
         clocks:
-          minItems: 4
+          maxItems: 4
         clock-names:
           items:
             - const: pcie
@@ -200,6 +200,23 @@ allOf:
             - const: mstr
             - const: slv
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          items:
+            - const: pcie
+            - const: pcie_bus
+            - const: pcie_phy
+            - const: pcie_aux
+            - const: ref
+
 unevaluatedProperties: false
 
 examples:
-- 
2.37.1


