Return-Path: <linux-pci+bounces-34035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 357DFB2604B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8E61C867FD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C052ECD14;
	Thu, 14 Aug 2025 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kbPnguXT"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3CB1519A0;
	Thu, 14 Aug 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162010; cv=fail; b=bdI7sj7bfsIClmbodkmINfCBICTH1g+MFGMl3qkFh676lUoPJo3kVPrqI3fH3APRHqT3T+xnZmHL4kfZwuBuQjc5KovlvnlmwPrftdDUvEhSXmhDliBI9YH/YiOSb/vzKfTMBHrg1U7xH0sntncwUow1bZeuULNiyB/o5sDBsUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162010; c=relaxed/simple;
	bh=LanW+g/GgVb5pgUKMuoGlNFHRCklGIXqxBhuhwlxNRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CFSSymLyhvlfMO8Gu2N3OUHyTKybLkGNdrAaxzjQWq/8DFwtAYmT3GvH3CO2Eb4KURUo+s3Kg/XtTqBR4Pgr3/32dttfB8A5I72bAVhNcSjYoyzI+nEUtleUqm4D7QhOO8BRBHUL5qw3NlT6vJ0bRhZuliD/nbW7wCzyrU435lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kbPnguXT; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiofHUOY0eG7LfbOUcboVN9mCGUVcPT5MPQkYKpdiVAUtl1bRVxwxz4zc5wmaEB09t3P/sC9K1RSE2LkPdrLBwY37UVqqLutD02ZyL1JvCDeEytBOANtm/XNQjiNN0oZmmbGObWKlgzL8YqgX4iyBDER/oc84eK4mObTcDtXsXQVt60MXPbv6VCJCCvAMrf1yCwdc/AELtS0bOsd//aEGF81Hk+2w2Tleyvj86YhqxMkR1ApcS7qz2JvCBK+hhjLRPaayPyuRT2yPk4byuAremBMC7SJamATKokXiwP4UQcI+AZ+IqERlOdpQ1r/kBwtnM1GMHpHXpOdSnBSOJqP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+DkBZOJGTR4eQxNBnjhvVQqMcOWHQiwM1RVdj8FDj4=;
 b=L8VbNgARvz+aEvcC+9hYGoTtxyryPFL0lc1CZVf/3KVYRnt3XgfvMcMab4IOSo7jUArel9Y29OZxa/SGtS29FJUamNPl2lpUbCC3wSiUferxb2kZm3j/R44jNTGvnrxqxeiAT2KQ00YhHD3G/qWlFOTDC4+eOwqQVIE6tnBCi0DVDoxGBl5r45ANMw915rzdvnKqeeicoxXDTN+4bvqC9CQ/lAZrvxt/wANM6PMJ15kus7F1YdhOvdiTujsMgvhOLWulDrDgJjvxiJhdeXv0Veai86bRO7HFgZhLIC+edlj5tmcVAB4cEsCayU2LheVmqCX7I17mrDmNuhwGPKKJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+DkBZOJGTR4eQxNBnjhvVQqMcOWHQiwM1RVdj8FDj4=;
 b=kbPnguXTixOSf2vWDPAqOwEaoSJ55RmMbBfsFCq+M2R1oZH7i8fVHoUMZ6A5/WX/T3KSRXEOYCJQ/ldkKre/hJnldgboxQOAo781ieKbUJFsoFLraVnJmc56lWTwaYhN/XLKnAt/6ePNHF8DTAHTi4mQiXGe50Lnjp6tSBnu1HuTyyXnSN1w217EgY4X8zWOVvrvrzzIgpv055Kp1isOsWzf1QRP38/M+3IpMLs6FWZQfFMyi7j199w/VzUlwC4PYODqJQhzmyzMn/sHRTTE7xGpqUjIon8mztl4swItxJHaQsG2IxBfWU/Ux33mQqECrVbHihv+hprh10gm6goOqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PR3PR04MB7484.eurprd04.prod.outlook.com (2603:10a6:102:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 14 Aug
 2025 09:00:04 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:00:04 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Add vaux for i.MX PCIe
Date: Thu, 14 Aug 2025 16:59:19 +0800
Message-Id: <20250814085920.590101-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250814085920.590101-1-hongxing.zhu@nxp.com>
References: <20250814085920.590101-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PR3PR04MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2bcf68-a41a-48d7-028e-08dddb10f5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zOBhQR/z4EC08I28zg1L+9qTV3KcQ6JwqkIT4N6gbEXJAs63rG9zzn3E4v69?=
 =?us-ascii?Q?+Z927o4Km/OSWtP6TB6AeI93ditKbhFE+c9umFyq9kJvMIAOA2BTp45W/tT4?=
 =?us-ascii?Q?+z5cgWHaeRnr3E6/TVy0iJPUmeBgD2QVvFWUlGYZ2WrzqOnstw6Scr5cRkT6?=
 =?us-ascii?Q?JDyXX7L6Ws23xzhR2rrDlRpKftN7dFjM2JXxkkh9Nt90M9DnicWh9rTCT/Jg?=
 =?us-ascii?Q?ieT4/JihxXp9MWnnYRI32qWcv5FkF/z1YHpLlkb1ytF9bD1L0D16p3P990Mf?=
 =?us-ascii?Q?6me6b5ZYXwUtMbKVlB6vp5F7sBQ/mC5qjzDQqzs0GqmT1/xD/As/FzlJOVwV?=
 =?us-ascii?Q?rCwMMsKKqg3Wc7XkRJvWFacBj2Uq+G1MF+4kRxaRtDuHDgiX0XX7vX9hjKro?=
 =?us-ascii?Q?ohicRyVkZjEj1IScRRU3iDw84WBLU7R/tWhIbPwwrExbCd7l50HHUqu038DW?=
 =?us-ascii?Q?XglOCulgCVZbZ1aKPid2uccPGyaiwbwd5STkpRAIGlc42zXDYzsN29xBtfyc?=
 =?us-ascii?Q?wWEjjC2PjAULVGVe7S43C0XiMOny4P3Cw5RueznrJaq0FvJTK8cQyPgzVZtE?=
 =?us-ascii?Q?k9cV2Ezaw66513CyeTymCvi0B85nOwGXlhXHbg/E0T1Y9VnRlfIrh7QW+Syr?=
 =?us-ascii?Q?+/ZxAvoa4kXqJj9eC8e6V5pbZq4FarmrJBX04Pz/8Eja2IGIBg4WeiTtcC8x?=
 =?us-ascii?Q?bscJXKCN3q3fC8hf+RZ+6T/aK/5tvFhMeCQRG2Y8VnvUyoKvETVzCtNtBXIl?=
 =?us-ascii?Q?aTX9iCIOb9big7QM+M2sfF3Bl7NkAbhstTUtS+ICjx7XMvKt/6GY4alZYlDO?=
 =?us-ascii?Q?bzAra5hjTKbQ7V7cZsmoYNzod2Hkgwsn8zle/QxfZLmXhjys08ELp9P1RZYh?=
 =?us-ascii?Q?ye68RZWM7sAJ83X607/NyIkduDCMN79zsqmYZEztYrX2/EUmc3tUz8I9gnDU?=
 =?us-ascii?Q?uXXzscPTONzfDAiNbG+sSMKEzLiQQCXMvjG7EwDtB+BmzIQV2BcaF3I2S1gP?=
 =?us-ascii?Q?DdXO9AKNV+hbf3P/xdqn4AXLtcPe/h/CE07EI6vu7E7Ui7ntk8mIwSbBGaG5?=
 =?us-ascii?Q?opgUp/RSfMnhT+kfGRwG3jCJTYe0OibK5xjHeHYRaNf0grnTQOp86v3tZTT0?=
 =?us-ascii?Q?jk2xuH0GbJC8jEv26hTdmc8ee2hl0M05miFB45Hw+sMqKO+TqqknwX7alWe9?=
 =?us-ascii?Q?j5HzmpJolI5n5UTh/bSVMLJk7cjwWkZ0ZcIp+7ShTPfc21oTS39hag861UPl?=
 =?us-ascii?Q?907i1AYHDzUuZvOD//KHMSfHsMrWMvoXfn0xR1d1zFodzsZE3m+qnUo+Znhe?=
 =?us-ascii?Q?b5oy+vygIhyWD/Kmm1bF56syBwxAGjISSagU6S/yiQNX8BU8VmW2sjQHwMVk?=
 =?us-ascii?Q?fYjZZ+caGoTvkV2QpIKcB6srbaq7nh01RgSAoVK3w+jhNHZ+nRfhbuM/r147?=
 =?us-ascii?Q?ajwqV9BfFcjFyk+PYtf3R2GtBFIYF8V4tvzyYKRlFPuZQ37iydSizTZdaSP7?=
 =?us-ascii?Q?AaWrhgz2AVmwCuQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oL1srLOOSKZ1CxjAOOnnT7YZrHMITAdO684KMt9bhB8pxasSnkYX7EACKG96?=
 =?us-ascii?Q?vtGaQclIKpQS6RyxQUinbuX5mJ+Kuz1De67qA04jjXhBXnAqmPlrfOGi7Vdq?=
 =?us-ascii?Q?hHfwhpRZ5uumlu58FeylPZA+e0jI8DG/U5N0owNZOtXaTq8S0dGr0APwQCJL?=
 =?us-ascii?Q?zuuv6uVnGvXL6kCd+b5OLzv1YNv3aX1nvR+wjKxU34A5n6fubaTXaqjhySR3?=
 =?us-ascii?Q?ZJIldIa6766Bcuk5j0s9dqdaNTFi0Y7wFum83h/rGq1fxoKDDD863LkFH7OM?=
 =?us-ascii?Q?Ikm06YasC5GWF6oXiAcPEjeZBccGUw406kFLeuEWKJZ1WJaF94e1vRnNinU/?=
 =?us-ascii?Q?8W0aa5xI74EbgTr9YqvrA+i3PTnFXZ8Rt+1B/ERVHvqVUzaCw15KhG4o5cYX?=
 =?us-ascii?Q?7QH8Pc65s0KukqLfBlaILrlIKRhtOdtQ7XoCWW4sxfF1AdmsDQMPIgVt/i7t?=
 =?us-ascii?Q?4gxxK74f5ZLT+bGWh+Q08ft10zW0tkqSFEYFNSsbTVqgMwlH+HfvvycA/F4I?=
 =?us-ascii?Q?X9uVLARDFAFjuUP6X8Nf0DB9Q82VRJfxWNZYBVTAQcj/4JmRE7JVxHHElEu0?=
 =?us-ascii?Q?KV/zkfqp5XDPrv73P7JdCxmRaM+KnHJHZJXbKkf5TMez1KvPsmeqVG3ksHSC?=
 =?us-ascii?Q?eIIunE+3y5M/eAZq4zhSxioVSybelYvbhUYNXu0iJcf7+/KlRSc1c88n29qx?=
 =?us-ascii?Q?8PnUCg+iHhR0q8dj3UySCetM3r+9NPvRH+Ayf2hzr5Edg4gACGMKBJ3Yw2Py?=
 =?us-ascii?Q?2/F4grywWPTCQgUx4NDEd8sLbOtMe0rhZFMb4AqX2NDJwQastjvRcxU18SEC?=
 =?us-ascii?Q?yNBvKou08qpr3+IKEQlI/lzUZJ/fWAfAdhuKfA3XMQDKvfAVaELsY+wZbDhj?=
 =?us-ascii?Q?g8QPAeHRG4zrUeUvh2a/IwIF+rWET+U6WBA8S7PIcpC2WAvle0iYyFjWHtkp?=
 =?us-ascii?Q?lekEz9kmo+p2hR24aM5KtUtOjhCYYcNXl06KnvhuAz5WwfS4khrtufX9vSgb?=
 =?us-ascii?Q?MYAOMLvnyr6wLMqEC6rdza4CgnedtCH1FaQsZTXwUhHmekFPhAUj9NNL7Ozb?=
 =?us-ascii?Q?o/yPrV1rJbv6beuaZ10Qqi9iKtqvABHmbnwWAYhVtmKXVqsEuZ11NuJFnwhb?=
 =?us-ascii?Q?hsjsxTpHKuR1yrYA2RmtSMVNk80EwEr5TyG/HfPcWrzlfeeNe/bmdiui5QuX?=
 =?us-ascii?Q?e5ZgYA0zukC4Nl/ccwpM9B4PhebHhrMjHSZFPHFloiGkTSuBlmFknXSd7B9b?=
 =?us-ascii?Q?jyRwbrdZKg6e9geSAS/aI78ogMOzcdl+e4MnOfQcuZZZ8k6VnOaIFc+WaRyY?=
 =?us-ascii?Q?UXYI5DOgNyQjh7nFggL7aMeYbcub2JsHKUMz4+bZ1bgwCjFs0ewAA0LtlBJu?=
 =?us-ascii?Q?vpbfOxjZXOMoJ64X97EtIHlr1pJ1K7VL1u/P32Ao8OehLf49Mf+VYz3i+D4e?=
 =?us-ascii?Q?5JrAnKo/aUbr0xGCYXPvoN7ZAAFJ86x3peUzaCHQk3HacIyVOeetWOaqz+M9?=
 =?us-ascii?Q?+FfO5ZuQtghO1vFBTqqXHpdW8PqndIjKAiOAU8x3NHh32wKDYOUKWJEnQlWX?=
 =?us-ascii?Q?h1XHeROnagb0bZFGvZhYKRhHrWd1GucBJrPXl3n+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2bcf68-a41a-48d7-028e-08dddb10f5b2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:00:04.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTwuaILUGPLoAT9yBy7usRthYltvVZNMCmN5Mu8zQtXq1TypPoB0Wb0oZSKHIVyMvdch1Bwn6AKOF3QvtV/ZAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7484

Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
asserted by the Add-in Card when all its functions are in D3Cold state
and at least one of its functions is enabled for wakeup generation.

The 3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
process. Since the main power supply would be gated off to let Add-in
Card to be in D3Cold, add the vaux and keep it enabled to power up WAKE#
circuit for the entire PCIe controller lifecycle when WAKE# is supported.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index cddbe21f99f2b..13fddf731ab8c 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -98,6 +98,12 @@ properties:
   phy-names:
     const: pcie-phy
 
+  vaux-supply:
+    description: Should specify the regulator in charge of power source
+      of the WAKE# generation on the PCIe connector. When the WAKE# is
+      enabled, this regualor would be always on and used to power up
+      WAKE# circuit (optional required).
+
   vpcie-supply:
     description: Should specify the regulator in charge of PCIe port power.
       The regulator will be enabled when initializing the PCIe host and
-- 
2.37.1


