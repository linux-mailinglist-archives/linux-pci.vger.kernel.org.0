Return-Path: <linux-pci+bounces-12134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD1F95D5A6
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 20:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2083B1C211FC
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC231191F7E;
	Fri, 23 Aug 2024 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oK7ZVNsW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B254191499;
	Fri, 23 Aug 2024 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439565; cv=fail; b=numpH2WnzMTivmgaNhcYzhqy3llQWD4Nb85ZLuhvWR5yiQzmQ5/4PNaDT9KE5UknZn4+V1qUKkWoVxS6qDuSjvMUPNNmrZc9+/ixTAQSWbDy4w64+6QdrDBqGuhaFQzZQHFZK6n46cBV84z3sPOkTjXd3GWTzUpM/Wo1D8uNT5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439565; c=relaxed/simple;
	bh=dduFh6vi4JiMytp7+kfzKYlqowbmjsl2yaGq08TOS+g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HjjDwUbtw5zRoar7wHFTHV2K3L/jsuJwy3JZKDfRSSwzUlqiLy1t9E80wycF9WBJ5za1MwXx+OzvIsjdupJS3SELVHw049+GAHQu/Ie982k2uLJI8dKUefbhRRmBtkv2WrYkQFGMs0EAnkWgwoTMUqdBGcWHk8ufb4UnO9GU+N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oK7ZVNsW; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcoRXukbvbu4qAoCx2IsR3XFNSzt+DHjHGEbmUL3/nUYo2GHHtnwSzJagLNPRzdQEwKSUY1W3OROCY58Iz0631Br+gUqlhprrwiwi4//MhXXbqGeZQmXwif3WPggjUohQw8TyznKuuyqRnKuNWME53+ImEnvg6YuQPl416RZq5E8x2rVf2sRhUUXJowvkIDCEUEliiWz4eq0cpmdY6F014tQTXjngDMmD3TPD5lna54m+zqqaB9E1eTvq6f/VjApJf26cSEseT0TnS/owFAZNc+2Z+MzVWAOYKHFd9tzT2vTxYV2JkdwzRxvANfibzPv+OSuBizVqePvlEvghRsaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yao/OaFYngt2iMgvWy2pOVT34nmA2HLiSOJ4IP+fR44=;
 b=D8Dw16OKX7MLTgKMUYFjaEtYfX5A3AlwO38GXSMV6GHckya1ZMj+vdpvYkXVaXlk5BzG5U42IS1YnZj3M7mChneTiueVmif2bEWTIwJpRRvDnUn4j/P9sK47q170SZ2k8Qrtn7kLSIv69FnhASGU1Bj8Vmu7Ylv3icSZ66rtses0VjVB5/m0ZaS51otvFMN8941eA67e/xp6/Ngq8Ygxdrf/DFK6rUSZRPkyHt1pYNnj/YWokjdnpFRY6XA4EEMdsUXsAy3sDHrGcRIPg51m8fTobswadhuxFAhOZne2+cotyRUDER89CV+P6zYIAow9NkWyuOwh2rcxyz4x2ga7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yao/OaFYngt2iMgvWy2pOVT34nmA2HLiSOJ4IP+fR44=;
 b=oK7ZVNsWusALnh1KUqa3Y0+fFOEIRvEmfNlqR6L3ALWqpSrb7WCd5u9UPfntnG/YfFmyj1aegsh/NkktLrheIig05ShshaBvWd2e71u+Uov+ifdByaARWpX8L8Du5LWLCYXmaRaDxwvjXTJZtG+fxU0b4cO5Mx3Nh8KCvMPhuesTsDX4YWFrke73jCcmlbJvSv6dD+9p+rHHieDIRJWSPBkNuBOoAu/IX0Oa8ekJnyIXfJ6W1MBt7dVZmMIq/nuObfVtuSWxDjt2UfOA9XuNHTQHp/2Q2gjzdcTir5tqmuuhGLflL1l2T1gMsKL+d8PR2+5HDjquCiRSYrlujRvAdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7869.eurprd04.prod.outlook.com (2603:10a6:102:c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 18:59:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 18:59:12 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: PCI: layerscape-pci: Add deprecated property 'num-viewport'
Date: Fri, 23 Aug 2024 14:58:54 -0400
Message-Id: <20240823185855.776904-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:74::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c10818-8307-4547-b153-08dcc3a5acea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B7SdswzHPzpr+mY7rU4rTbrPd4F84vghVXvvJzWW7R//TLQ4G3Lm59uy9yVc?=
 =?us-ascii?Q?KgvQQvPu+PA8W1gxksMf0NdMTNRJzHmNG5Wi7EY1Q7ezhoZm6J7sXG55OaIi?=
 =?us-ascii?Q?kLr1iZy4MOWTC0zc+NFYPxjkp6j3WhN4ROfPDAn4EpNxF+t0zAxLzNQFElEt?=
 =?us-ascii?Q?0Jw+U7XUHS8AnxT8WBrUyH1jGcT+csY5+C6QVhyeruHLeRO6XIRSOWaK6FEm?=
 =?us-ascii?Q?UWOP+FSq/1/wgUB7OR8q5KhllpORwr9u77TDYdhMJJ/ilhvmKNOepwtTYUSF?=
 =?us-ascii?Q?9SiS7t2OktBfoAgNL4Xg4rVeEsZzOLvaD2i2OKrl7KWXEbspAYCjc/3l9SVG?=
 =?us-ascii?Q?fkI+8Vs4Po7gDgYt2z/UJWK7RiOgCDdgFUFdd2wl3gN6CZTqXLenHaY99NBD?=
 =?us-ascii?Q?ynVLN7fZL/UfTMe0umaquL2Ev1bw37Ur/RUHxmY63DneJ50k8BBqt1hmdIYT?=
 =?us-ascii?Q?Qh7ZPDFgVxet0vw+3dkGR4PHXXYfJLKy0RWpG8FZuqSE+TroVya6AHFWbyxP?=
 =?us-ascii?Q?TPPlVZnAGgPqBXoJiExy3VUoupOL3XJmu70fMYZHnMQJyakaLhUjeOy4ZHT/?=
 =?us-ascii?Q?BxmHNxcRR2pT1Za6KMv1M4knkZOkXpHRzqm7QyDascw7rMQRnAp/IGDx5dTN?=
 =?us-ascii?Q?IkJlslOceE77p4FxPgw6UppnkldvaeoYedXUrauyCaIlgGLANPZN4u0b6nWN?=
 =?us-ascii?Q?ZFdzwZTfmHUqccwWAG+TGAqNQOnJBixSxcSAjt8jkPjLDSXrc4NyjYnDbi/k?=
 =?us-ascii?Q?QEWJZuBPCyRX0O0LtHtB4hfbga60PD1joWIB9tmGRivkeIcXW8RdDxSV9PbW?=
 =?us-ascii?Q?enAG6E2dvSoTHMoPNXtsK/RX0/gO3sZHODnj7FUGBWDRLRr+iiLIKJOs8FCq?=
 =?us-ascii?Q?5SNsQUB87LJDyJ/wv2AfTGyuLFiPtn6f1W4pSmhyfRUBFA/3Gq84gxd+sXNG?=
 =?us-ascii?Q?x/TLfS63yrxVsZSePGgPswcuPJRhn7WaucMAiqyuvh60lWL3kOCcbOGobRfF?=
 =?us-ascii?Q?v0Hx9EHE1OcPWCNk6kiaw+i91ArB2kUZZ73ropF/3ok6PgdSa0gQyi5YxQQv?=
 =?us-ascii?Q?1hzyCWNEPi4FACEVGu5Kxn95Msd5Cjt2fb8Ad2xFBy3PxSvgK/ml0cAlcOjr?=
 =?us-ascii?Q?Q0VVMJdj0YEjaucRajVjhvUXyYs0YxeMdzGFN9oaz+oiNEXnA0FS5iu1nkUf?=
 =?us-ascii?Q?PiHr583vpnLNxl9nqIUIjedAfyiqiPGhjeuMqoIg4nKK6o0ejgt3bwXldk81?=
 =?us-ascii?Q?sB6ifwXxRoHcdy2jIIOXfOLZeEZs5/BNAqRju/ZaJun6qX2M+Kj2buS8jcCg?=
 =?us-ascii?Q?WdACVl+l3gU6P6D5xwe1NRV3OzYHPSEJ/IH21T3PRnPBKyz6ugNdEfYbXUFY?=
 =?us-ascii?Q?WzcT+g4A9ExyiS4EIXtv3sfiZIWd/QralnyNkz1GVGQPyfwZb6aRhpmG7EPF?=
 =?us-ascii?Q?wATWjvz0Zh4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1wgEBiXw0qr3kDA0TDE1ZBaFEbyItmrGlNPuTicNNRH4FBr6C0CdYcOtLXG6?=
 =?us-ascii?Q?b3HHCWMQSdbgOMPUPTjymRWdFc5M5UJGJQkfn1WAqOyN8xF8sshZ6pLJgKaM?=
 =?us-ascii?Q?8f5HiKBy16G33+Ebcc0Uh/QEHSwP9gHHbtqqAaVrrZe5ZEFzIUQa2EfN0ztu?=
 =?us-ascii?Q?J0n6/aA/Q8aEJCwpBHxKDUK3NnscRofZ7C+hQTKMQKcOK1LyoxSKrIWFbx4H?=
 =?us-ascii?Q?xp7B91VmFgCqk4fT1E0bI0U1/i9wWJlOHfbPQJuW3oPzeWVW2DHzb6oT4ash?=
 =?us-ascii?Q?2CiXAk+aJY52wjf/wfbWQt2VVIgZWSCaaOWLc37B5Qt58WM8rYKR9oDdyQCu?=
 =?us-ascii?Q?D2a3ZO5SV4WNfO8xMJvNqjMBg+5P6aWMyOt11ihR76k7HbR3xPjsch0aVvyG?=
 =?us-ascii?Q?J4fgitIwV5IhGlMRN/1XQsZw8YYYbp/Isdq+WRmVyNBMeXbXla3zSU/+KPi9?=
 =?us-ascii?Q?r4vojn1VLhgpXLFqDYR+flMqnC4wWLS8ZqXT2Ty0RHx/+cjQEF+6X8EuvmdG?=
 =?us-ascii?Q?ChsMOa3SbKVtndmw0/qS3jvpHG7ctlQHY3p4GxU58V14q1fNLLzHvYUWR1zS?=
 =?us-ascii?Q?Dst2EE77P2L+htBeRNW08JDBHsI/JryWm6+QFBcaA47uc8uruk74yU0eGQMt?=
 =?us-ascii?Q?yIUXcmxHKKgYc+AeGi8UdV9BoQgE705eC1RC2TWI29zmvWd77VMaQKcuxznb?=
 =?us-ascii?Q?/uhK+chdDnoBO4vwKwCiDwwhN0l+TnbkD7VaaLOE2vNTskwouE4+nJBgQ2ar?=
 =?us-ascii?Q?l0myj5plAtEtPrnfrmTDX6F46DnPHwUH+pSrHQJ2pFU55dlqNz2+bhFSIK97?=
 =?us-ascii?Q?57b4gGIg6tP+LBxp4BMquNs68cDwBcF25WMSfqtAB2e455OH8k/AFUAhQt/h?=
 =?us-ascii?Q?pPard9EH2O/zfT72Hucuxyc42oyhIP+vxPgut5I3GhELXA/K95qrR+AIGlKN?=
 =?us-ascii?Q?KjfhqiKb07/QpJ319jPjQ3lQ/5w8rEi/cEJgDBm8HsEPRwwJneowU6E1aqIQ?=
 =?us-ascii?Q?csMmMb8JVzOBauQu/Lv1vMqWutT9N7q8xFcujBa222x0viLuix+VRL0WMbFy?=
 =?us-ascii?Q?ugl8g4896whVQPOG1Vd2RFAp3f+t93kP0TaKUvV9iKpTsMz0iG1qnFPWiwuO?=
 =?us-ascii?Q?LmD70NlxIwoU92qF2q7WMQP7G41L46K5LSD8E/kWRd5mjd1mObhMk2DimzG6?=
 =?us-ascii?Q?hYtoDRFP91O1DhQhVtHqaQp0EfLLfrKqUrtjR7wQEfmZGH5aFutOkLb54ghU?=
 =?us-ascii?Q?xGJZzrpavt6RdCTE4D0nTkrJo/N100alVpCi8UI+k4smUgZkqE/qyNkqGhMY?=
 =?us-ascii?Q?ws/Pgb5geE73y+TNzjv4FXqMfARduWrNM6/NnrRbNq1B4LLBozXRb5Jgvm0z?=
 =?us-ascii?Q?p6Phoz7A2JtI6mnj4GUfpYkpJcjbNTDHOXTIvyFA92rPf6xgDq+Samel0Z6o?=
 =?us-ascii?Q?MVps/iXF3UP/whl5LZF+sW7qZDrfw7xAIdqjnwvfEvctjfng2WEQZ3b3wLQJ?=
 =?us-ascii?Q?WXnelSTwel79YiAjMtUKMkL/N0Ogam2+pjRH5z88dPZu85eYIREH5WsMKtyf?=
 =?us-ascii?Q?SyPWWYvmpW74RHMbbQc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c10818-8307-4547-b153-08dcc3a5acea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 18:59:12.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4c/ZdBFQMdURExluSzIlK5AnKeMc8DdMjFu3it5vEPllcwqTNbn+tdk/wo0U/jEa4UgwhiDij6T2oTgfCM/4Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7869

Copy the 'num-viewport' property from snps,dw-pcie-common.yaml to
fsl,layerscape-pcie.yaml to address the below warning. This is necessary
due to historical reasons where fsl,layerscape-pcie.yaml does not
directly reference snps,dw-pcie-common.yaml.

/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: pcie@3400000: Unevaluated properties are not allowed ('num-viewport' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/fsl,layerscape-pcie.yaml      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
index 2f79551f6083c..ea7aa8c83a553 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -71,6 +71,14 @@ properties:
     minItems: 1
     maxItems: 2

+  num-viewport:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Number of outbound view ports configured in hardware. It's the same as
+      the number of outbound AT windows.
+    maximum: 256
+
 required:
   - compatible
   - reg
--
2.34.1


