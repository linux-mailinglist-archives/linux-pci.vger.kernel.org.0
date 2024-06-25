Return-Path: <linux-pci+bounces-9257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB5917335
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 23:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B01F286F81
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 21:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207F17F513;
	Tue, 25 Jun 2024 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kbpIMihd"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1017E8EC;
	Tue, 25 Jun 2024 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350294; cv=fail; b=jbwI9NFCtey0jOYjlmFvfDO4htrFxXyF68DDvWjGdZoGr849tktlbHPFkgS1jm5qtobf5A4NP7ljfj0yuln2gYwbED4OZB3IQ3HZlDaAt+nzgrZP94mvEW5tMxCDCis8gvKVl5XbmDaVeUCzHWPJ+YzyHLHvH6ERY6eaUW0rRkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350294; c=relaxed/simple;
	bh=HrZTEzYuMVekSAyxQZbHnRojJRZvvfuI3U1T8nC5Ivo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uIBGl3njlMX7Qs1hf82wMmoErQTb9TAQUyN/4JSeJwoQQjT9IhsLkSpeSXlfKOP4GvUJznW0ZoxJsOYvATPq7YJIVsAY8edCH9mNTRjfv4unU0fFl9J6ePXXur6yOxIHYrEqSMrdNiu3l4k1UR2hfWiyEtgdGK0oLZYbKPGxulU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kbpIMihd; arc=fail smtp.client-ip=40.107.104.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzVn3ipombia6NIr0q/1VRnGRXjN12y4MnNXGGh1ilb47iFkJpYBN5yOTSqaY5rSuRAkL6pIpZAyJDoqp1Qex+2t+iYDPdA3+QhPyIMeB+AnJOw/Wtr5DKPwAuPlZdCF4KyI6TwC7H2To4zoEYAZyhMsnn+Wyaa3cYb68ih7S6svuCiMUai/FGs6a/EWWTA9W0N+s8Bw2pWWNhtCNwtNifYnL9jAonu8MqohvNBiX54uV3Y3UlEfrg9vAsrqrWI2OZp8Awwy4s0nEkOXQfXYzYWMMpPAFEI2dCUJSh7VOlvIpRvcBEiWqKynyr0qvnbcr+rfVwknqrnBpPHWA7Ip1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Chwjj6VN0sBp9NVXoNwUk64/KJdJ06W2cRfzQHz3VQ=;
 b=ZkdpONNYL5GWQelfo2Bp+iIwjiuiHYEaW0tIWg8IxefW0/JGgvDb6u5j/9GM2RFqbIoMaVMQDEhzuRyfxmwIlANmtbZDy4gMwppG9s6iQOyBd6ejHhgL7Sgr8kqXOIwMOg23Rf9we2MY8XTYU7v26bdZN4zYo/gQLw3MwXRzCcX5J/Bnl2h4r3akZ9Ss+wHNv312Tn3t8c9bWjxJFOmOLD5E8LKTf+EAW9JRzNdHRB9lsjk7f37g/wBJep1p4m+k3WnJFRHB85ZsC2cZMpwFTxJLt9cZhCCI6FKYsbXKQO0J7CWQKyw5tOzm0iDNPjW420T227hnF9rJjZkXNMY1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Chwjj6VN0sBp9NVXoNwUk64/KJdJ06W2cRfzQHz3VQ=;
 b=kbpIMihdkuVzxs+rxLqnRb8owyf8sn6IHY+nrV3UUX7RyohQILruAVSGcolWswtaFhKi3suA9/QeQjL/sEq/ukX7oufXxIXcauqAU4+1rcwypXsCPlU487KzbwcV2GYHOEzuuCC3HdlvrQ6F+XzOthVRX2EmOuPDgXAXrR0mzJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7978.eurprd04.prod.outlook.com (2603:10a6:10:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 21:18:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 21:18:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 2/2] dt-bindings: PCI: layerscape-pci-ep: Allow fallback to fsl,ls-pcie-ep
Date: Tue, 25 Jun 2024 17:17:47 -0400
Message-Id: <20240625211748.4041882-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625211748.4041882-1-Frank.Li@nxp.com>
References: <20240625211748.4041882-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:332::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ea020e-fbcf-4e8a-bba4-08dc955c4ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|366014|7416012|376012|52116012|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8yvuZaHfWE7fl9ZU7SJZ8mnSV/zHfph528cXXlsh0f5GWkWxDmNap2ycG4DH?=
 =?us-ascii?Q?ATGRgGuO/G8o4pRc7jV0mmQPdbWeNicyrj4Vn2K3kwSsLJTK2QPYGA/Ucu7y?=
 =?us-ascii?Q?lO8Xgn6dYuTi1CApQAcgPYrVCP4P2L7jj/lVmidkcUdNwoCyBq3HiAUa23p1?=
 =?us-ascii?Q?PT6jRNqCnvdUWDBAeXi3RFk2b4a2Y5iB5G01XPvlOZ8gtNLZWuFcNtH5hMV3?=
 =?us-ascii?Q?y0CBrNzvHCkTl6S1/fbQwXqoscM7+i/Tfmdb2YFUXuDzgB76FVrgH5LCaIhP?=
 =?us-ascii?Q?lMBF2S/237CqvNgtyESLvA6ieG6six5HX9okt32ZgeIeIoiZ+5+tFxQ60xcX?=
 =?us-ascii?Q?IE7hjJKGioVcnIoOPIQNWlpDe6VpAUZ9eur6KaE2I5sitvhgSXZROHD3rS6k?=
 =?us-ascii?Q?MjAPUHSj9WGaxPlvt8vsDeUaM/JZZYWhDV/nRBx5DTAD5ww4sL8KEMKJjr21?=
 =?us-ascii?Q?qpdeByCMvh/bedzlW7Tz7OMpzJpoZywYEf52IZ4rtZofbC0az4Hn2ICaYr+p?=
 =?us-ascii?Q?bKj1FiGbR0caUe0meESYJMnVCVeH96jARJSuT99aKINm0isuYAXADizoPETv?=
 =?us-ascii?Q?/XInVRkNgMPUQS9Jnla7FxbpIdzkgyHt8Ue0hT8yRK+GhEwCrQln3ucDXNmd?=
 =?us-ascii?Q?Ax0MlMBdB6lhoIWWag7CbEJo1xOiKzpUBAOymt6Jj9u7EpHnV95quF/w03Sq?=
 =?us-ascii?Q?fnYII6AhHjYpMezWCutX1O0dqkw6T0PL50H0tAjB+WEiGUEguWsSipwSKjmn?=
 =?us-ascii?Q?gm9fpjJUBs5hJM/Noedvj4NZDExp/z3YYH+N2u4dCrQH9c11Nn7GuUEo6lDI?=
 =?us-ascii?Q?C6eBatYJhbNIRanJEGBTvgmxBgFm8mxchPziMRfLrUutm2+cFlfSYCMSKigs?=
 =?us-ascii?Q?oNVZSq20fP8RuLhFUFqu8ua3DfLzD56UWOCtaHyLbUn6LuF4YLL/pZLDyOUx?=
 =?us-ascii?Q?eXxF2JFSwnQPXDQfizwfkRJ3AlI1c9l7HywvUwGaKzIwo7YDs6XBnxlKkxX2?=
 =?us-ascii?Q?wFuwO6sotBtE87tIYxOS2+JoYk5ahqomItsUpC9CShINLkPjn7VOFLQlnDOW?=
 =?us-ascii?Q?d1r79NnjxY48we4FSmVYJq7J9SpS+i+og0u6SttOB9QJGUUkmK9b7RPRgMq6?=
 =?us-ascii?Q?t5mZeV0oMznWjxDug6Eubx6HdVBLDqFZA+YUFlhL48fMvidvyMv9teE0Mvi6?=
 =?us-ascii?Q?KcS/vHwt8qggSOLFau8gTjEQHCUucSzB4oLlibm65UNaySY8DNEvXiRGnvfi?=
 =?us-ascii?Q?NIFy8Pg4qvCVaCaygkUDsT0fFBHa9VZA0toqTskzkZPMxFuaHI8KWjgi7ADw?=
 =?us-ascii?Q?izsvfhqVVNcXUHUO3MtCefjWGx2j5aLNo/wPB3zbJg3eus15sum14P1A5mzJ?=
 =?us-ascii?Q?tIiyrrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(52116012)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V6E9xVRNmE87gSx3lguWD5eKiofcgI44y4xAmtPYKjVTxCvuUBxruCD1pig6?=
 =?us-ascii?Q?FOi0LGm14y7P7a3cayIACyTKdTxc19n19xrWQIFpU0CxzrmgFS4bptBKpT9G?=
 =?us-ascii?Q?AOXv6oYFF8tnv7239e8xPyCPTXzy1+NFLvea5Uet/McpdKb2tktpmEfenOEQ?=
 =?us-ascii?Q?DjHRTc4nZ9Z9uJ1ad2PKeC2iyWSHyrs82UJyY8fleilTohDhWQUS7YJ2A+rc?=
 =?us-ascii?Q?JYOs1S9e4YTNivpsjajts2B0LNifvly5Sazu7el4/a7s7AyZO94bwH06TR+3?=
 =?us-ascii?Q?DgfTM2JRtJxX199deD0i8hPuY4DyxxVNHfKn6QHaCXzDbkKYUif3x3a8KiG9?=
 =?us-ascii?Q?3uFGlMrU6AIwjyZbqAbYDhlXM88ve/D30w80EeT9kzlxvdPfamLfg5v1MZfy?=
 =?us-ascii?Q?Au3ajyGxxgNSZXPT4nHesyXkH8h+8L2eQUZYaxphBwTITFdh9P2gunfzAT4t?=
 =?us-ascii?Q?jC9GTYTFaeXKpW8JdB0lVMcRjQHAWX4yl9iOuqd9M+hVLtGoxLa023dvtBxN?=
 =?us-ascii?Q?5V5RKF1YMS0l7vOb0ST4keV4GHRMaSpGMlAfbCBcMVqCq1UBQGpCqMft340V?=
 =?us-ascii?Q?WoYUPA3bYTHJSZcqYplaKxf2jJoVuMG6cWfClxO6WK0KrQTPbho9NqGHd3Ok?=
 =?us-ascii?Q?U7xG42RMHXizpNR+LrVqSXC4i5o5gAkyHoqLxg8vFDod3z+l5nucrunK4/K2?=
 =?us-ascii?Q?ZX+c/uwNFwyeAq/wu9jb3RgIuG5CHQN9gSkHw5t4VcMb/d745+1NH+BfDVIB?=
 =?us-ascii?Q?3ExBd2bTd5r+rwo2ylRJdm6Ca/qQLWVflwk7LZsl95bmbGh+3j/LsROjkf9P?=
 =?us-ascii?Q?hdfF2GWpkGhveDemOnfGKK0ILvZSi++vnxTgMuOZyYRUA2iGGr+1CvnMtZC0?=
 =?us-ascii?Q?YMS9BAHLL7gNuFvSOEbDEGHCztvGImveTV+DeJ59vxc64mcztpTIJpX1bKCS?=
 =?us-ascii?Q?TVCy6CzPg+7lZCs77ZKyW/FBwlSef8S4VA/UeMZIHSrFg5FLTreOO/fB7cap?=
 =?us-ascii?Q?JwnHuLGgNFeV6fQcxtVYzVaC9UPX5gnvB8zaSPLSF44VQk+yX+VZViMM4hDB?=
 =?us-ascii?Q?7teCxR04g59vkpkokPpXGUOMvoY1QU6QAPScuIBpxUrD2a12/7BS5/ctgchF?=
 =?us-ascii?Q?f4dGxf9WRqReBD3s2VdlkysX4rAVvXQZOwWux2YWZorhbYzjSmD2kzbfgwhT?=
 =?us-ascii?Q?xbbZdkz/UV5avOLZhevlopffgGlP/osPE4H2XT9nfF7dqD/lDum2F9yJgBrs?=
 =?us-ascii?Q?89iVnmvTq5CeFcGNi2uprM83ZRYj3YJW1rUbofTTeZ68ispsPPhp+6NISuco?=
 =?us-ascii?Q?roHZ94iV8XmO0utOU5qqh/zodrNTxXNM2nzi4m1hWYbU2YghZ+3e/+MUvu4x?=
 =?us-ascii?Q?oHZx0SSFZRXrIKDZtFIUFHoOcnXXOuShzADYSqbB0vVwPSU3gQLnyzDW7Ke3?=
 =?us-ascii?Q?+MWjyVgrD47g7B+b9rU5dEsG5YaytWQ84w770l912aTPhIPhuk0g65WqhevC?=
 =?us-ascii?Q?763sKUETay/bb9U1UxtSw+xF8IDbBfxqBdtanG90FsdfIrIy7GYX7JJVMYCH?=
 =?us-ascii?Q?SGwQstj/rbVttsKl/AQ5cJBgORaKhLkO7aOmVhaa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ea020e-fbcf-4e8a-bba4-08dc955c4ea7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 21:18:07.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amPNaQypO6b9KRo/0tfySxZfzqqK4si+nNmwTzX3PjCDHk9kwtJbFoY4c/FCcV4qpcywAiLyXOIvX3uOgASFEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7978

Allow compatible string fallback to general fsl,ls-pcie-ep.
Fix below warning:

arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: pcie_ep@3400000: compatible: ['fsl,ls1046a-pcie-ep', 'fsl,ls-pcie-ep'] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,layerscape-pcie-ep.yaml      | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
index 399efa7364c93..21f1edfe814d4 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -22,12 +22,15 @@ description:
 
 properties:
   compatible:
-    enum:
-      - fsl,ls2088a-pcie-ep
-      - fsl,ls1088a-pcie-ep
-      - fsl,ls1046a-pcie-ep
-      - fsl,ls1028a-pcie-ep
-      - fsl,lx2160ar2-pcie-ep
+    items:
+      - enum:
+          - fsl,ls2088a-pcie-ep
+          - fsl,ls1088a-pcie-ep
+          - fsl,ls1046a-pcie-ep
+          - fsl,ls1028a-pcie-ep
+          - fsl,lx2160ar2-pcie-ep
+      - const: fsl,ls-pcie-ep
+    minItems: 1
 
   reg:
     maxItems: 2
-- 
2.34.1


