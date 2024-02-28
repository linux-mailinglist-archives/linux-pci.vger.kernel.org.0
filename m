Return-Path: <linux-pci+bounces-4202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B586B7D4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 20:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5225B2897D9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 19:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D3159585;
	Wed, 28 Feb 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gweJZsZ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E27443A;
	Wed, 28 Feb 2024 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147029; cv=fail; b=Nf7/Vzm4J5B2x2R8hDrUSXEFPWPfOadZaCgXEZFoCG8yf9kfys7VYqt92uPhNWI/s6G/3rGCpqntLQwLRrmINxe4QYKEH3GhJhSdS/LVUFypDSxIoY6Hp3+Xpg5MYllB9+sdyusFPCWZBA2ZbEz1q0C1YzA6gHWmIJanDQNNMks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147029; c=relaxed/simple;
	bh=560c7EmdwTsO5bX3r/M2gbPPlRiCPg0io6f2217yXas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R1ntwptylHDbUbZoTqNjTkNYpE410PfDhA5L6Vj7OeftHgUjb9D7qRmwXQc02XMNhq211o+gnerUFUzo3ZC7fpPxh8Z/wMZyk7W53XxCaj4qgtRrqnfPxJXJIeHgs7nl7Dfbmjxy88ziqCxdx9g2CL+LwNyDir9v7yviVbP8LFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gweJZsZ/; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPiYkB9/HVe7SYiBg3mjoDNQ0aBTcICsSMuTGsbJVry34/G/LrWce5w4JBCGAeloZ0dnHIKxnOJEl1GGIJCORDFYicMKa8nI9LZ02WJED1MF561olA21cytCUqTIbZKWW4qVZLYSus8iMBQj8hyQHclg9hclnZt6mN6+csYSJW/f74pGYbuQVb0Yywf/Ag4H2weYp7JOuajHPRaat9Hy6GAiJBsSdtvWTNApYKwHdfxMAszjEa3jjfLFHKeH/lGL7W9AnW2xP59/XUV5ioqGubXhuHyBxueJg5Bdk8AAlPpegohUhwPXaMiC2t8EMzeDLIfSXfULeX2JgbxLvhwBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRNabK65TSJ2Du5ECQI5oK7i71xRlhciyet+BEc1aBc=;
 b=Q4WiTk5aloCoMC/iQObYmNLvVmBOWzblLB/IGP7c+2WzF36owFO2NIbeQr5hoNPfQjavAKGV03Xyo8t2wiZfVolzWTf9Wuek0dEucb+uckzq2tdUKrUZACWJUgamGCb1oGKRqBVCTtYrFmiKdVkSMDTWEFVLi6Ef545REYN5lXRHuq/cQcz3cBWdTbSEiiQG2miz2oUd/hn0k2+qKBn6oXBrHgFEu6fqyoN+LB9wZOaOk78/TCcWvQmH14/hi3DEewWqA7gNuJrKbWfldMs2tjwb3a1hBFvhlmcEK2gOUlcNo1IXJgX2TlJTr6kQQqeByPUNa1M3/Cr7wAc1jDONcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRNabK65TSJ2Du5ECQI5oK7i71xRlhciyet+BEc1aBc=;
 b=gweJZsZ//Npmd3pN83GXpDXTmj7fgm9YukOW1dSuGKkD7ncU3l4F8upYSLIeC7SNf9HFTvy7xnfQgk/+RkhuvIUQal5XizbFSm7x8Gb0y0a2iGzFIzLyvhRqzXZwWMrjbXOTjbU0VVJRLNRCWGJEVhm3ufm9j8mRLUUsC2JG+R8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 19:03:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:03:45 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v5 2/5] dt-bindings: pci: layerscape-pci: Add snps,dw-pcie.yaml reference
Date: Wed, 28 Feb 2024 14:03:18 -0500
Message-Id: <20240228190321.580846-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228190321.580846-1-Frank.Li@nxp.com>
References: <20240228190321.580846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb4b4ad-faed-4ea1-302f-08dc388ffc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0u5ObX0JsTV1xT50sc593CS58xdJ/OIWN9Pt5T3MeRFsMyDVwqIcBOr7FTQ5WMckgFo9LUHf6GIL4/RwW4Djr5tfFMeq/4hltP5NKDJYiMNSfJZZ/c2YfMeFsysIZTQzS4CHjuk3/e37nFgz9VW/EYykpp0clMdLlb4s/LMxDgG5h8BoAuMSoTIeLIkQ55H5QRLt4UJyYkOP1UxJPi3yH+iuW6MyJ7RSMlzzBdU7n8c+4/FjW7+KQfhX3/vCV71zKKU+Yx/HOlnUYLcrrKYejL2dYM0I5XOfFULnNu6bv5/Kj5gM4M/tnbdUKsk9G2DRxWJkKtj6V1W8O+cXbUWHNK+QB7ASxnIFHJLkAp5ZeXURVqrv0sKk6TPLrJmytw+fFjisAviw14EGExkjZ5c6GKtXGGrRR5UksV0h5Lj/AhUFSu9TGlkx3cRxFi7obkzqVqsaazJtI9QkeQaEOqkkd4pXaQ69HwVOheWxdtT06rrWuYvdflr1zryWcuUr6ww/dN2Je0kMeuyV3ALdKmqoV6YRtgQgUX5dYpjjY5cADVwLcaZtDeaJeZ3G9WnIWgRcxoFWhjt/peJfRzLqRLs8O1RxJleBHUH90Urgn2kR+RmhW6c+UdoTFHZRNhbuNrD+0DodMrhqV8kyKektXpU+Mg9ftPQIgrhMl5qfCYIEXOWql/hBkdy375nganHpUmT4p//RoXGB5/tTbFyu9wXMNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mWrYT8KgwV8RI4A3ZDRxXdmGhd4eOWPohVk4Pp4qbRAK0Gmrv8yxyZ9SJHxm?=
 =?us-ascii?Q?Y4d2vHLsc/a6zEuUB9gs8oqpthBPQQWbi9l4Gwb16CEIUZjacNnLnt9fVXHz?=
 =?us-ascii?Q?C/Xa+NtP1E9NEDsaxZUF0nGzTMVXj9oATQkx/zpflZXIiRFS8L24XgBNWEXh?=
 =?us-ascii?Q?8bUBGsoLZagHM1ClmopmNgMA7+PaiB4x5wI8ArdsSVnz4/rwtbjz0sUGu+UK?=
 =?us-ascii?Q?4XKSDVACldADFzbSzRLMXkKyibMgToyJPIMktPwR+iQBQoQUY3hb23Qk7OMc?=
 =?us-ascii?Q?DaglAErK5kOJwxdFrWhxkPWhiHBADHgBK5z49H/tsTVsemru9FQSph+tVFy6?=
 =?us-ascii?Q?nHce2dqotj4w3VJgEx002YhA+S1CUbWM9sE0hUmD7cJWS9T/9TUEcBNRK0+7?=
 =?us-ascii?Q?j4BI1DaH/Vwkxyl4oAdiOr1MBs4lCQikpVtYBD4XP/VUzW16MF5G6Szgi1NN?=
 =?us-ascii?Q?u1YYdhjdsZGO0v8HHbEwFHaVo2b10j8Nbf6CzQ1spPQbcONXAms2WM4dpCyt?=
 =?us-ascii?Q?2U+BwbvwgK/HrS0jgkSlLD1M9iOZasKziKlJs4kc6SB/LNPnIbfTunZg+KTK?=
 =?us-ascii?Q?dzj6E2QBFcwR5mDHc56IMQOcjRE5miW9JmWsIZkm+nOAltPhMH/e/zLWNJy5?=
 =?us-ascii?Q?UvXTrZR6ZXAZocgww6dAgiXPZ31LtYtCcZLsJmMAXncuciM59/aP5b3swkRv?=
 =?us-ascii?Q?1etYXTOjP0ZgsENVKDHOyee0tZ0lQtFxJgpO0eeL28IUGsppgBle4KwZzSou?=
 =?us-ascii?Q?qldNyHYBtywhVSqM1vV4KJTk6Z1IZjcX38RGwFNu4AVtMvo1lUOkOgDoS5kH?=
 =?us-ascii?Q?cdLhUbFF5GSXThqgoxOhjBFqeyXGDo/+1Vid3hVlHVB5cFAP61o9HAhAR8Se?=
 =?us-ascii?Q?DUV1fKTxSYBdh/pOUG0e/aBYNBgjDd9Afp5dd3T9rvTdSpKkrcTBJxk26hVV?=
 =?us-ascii?Q?hOREJ68+6MulSszisLHBAekt6nlRVI3fj5Cz8/3d9A2lzccSJ1Ws1cjyCDMb?=
 =?us-ascii?Q?zZP9duKErCahFcoPv1exsz1LXTbjlw4Ehriar7qqaWjX22wlr3TO1nAh9OC9?=
 =?us-ascii?Q?wY23jWT7c+mXSjn4XaJDPiz9ipIO3zRZMQ2BBJSMEP40yGD9NU8iFF67qC4o?=
 =?us-ascii?Q?T08nntOS0q87Xrq5AYONU2lnRT+eQMwW0o0zTiXDVP5INOFxEDBE29IkCmRn?=
 =?us-ascii?Q?lTwVM7GMfr6a8vP0PvRTamo4YcxgAdKoM+Rk94a+2PVHCl9QLaimWxvGXkaH?=
 =?us-ascii?Q?FlppcZzBHQdttPksyt2WCw6lOcFPLx0bGcq5x/y8W+UcspU34oAgO3YGXD0i?=
 =?us-ascii?Q?cE8yY8+lJxbiKQnmeoEiiJ1WPHbggBdb+1yAF+4zmKUqY6eQ/u7KuOb+sMCg?=
 =?us-ascii?Q?zpkaQXkd8GjOKIS0q8O3FxiJ9WY3wxYhYPzI89Fe5x3u0IODhp2qDqNY0mvx?=
 =?us-ascii?Q?IzsWPK6dDFHmJTEDliN7OK8zmjxGwWiJWPKdIQiNKUXlTE+s7PBCqKZc7BRA?=
 =?us-ascii?Q?KN+iICNHGkVGpOelALDB6FLhiJb90m7H48ksOjWfhGY/NcEcfOPhiE/tjWpd?=
 =?us-ascii?Q?i9y0zN/gMf9uQn0IvrFlKCYwEvEq/ZCKfJLCreHD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb4b4ad-faed-4ea1-302f-08dc388ffc91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:03:45.0076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YbaUhZDbU4V2PuUGHAFiO/dnPqLl0HNb+Pq8zK6WGB1EC29kC+EWdvI2wcWlZSqxrgFyQBi0JezYgEmkc66jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370

Add snps,dw-pcie.yaml reference. Clean up all context that already exist in
snps,dw-pcie.yaml. Update interrupt-names requirement for difference
compatible string.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,layerscape-pcie.yaml     | 102 +++++++++++++-----
 1 file changed, 77 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
index c37578fde8bb1..b57b627c18e95 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -11,7 +11,6 @@ maintainers:
 
 description:
   This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
-  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
 
   This controller derives its clocks from the Reset Configuration Word (RCW)
   which is used to describe the PLL settings at the time of chip-reset.
@@ -36,31 +35,18 @@ properties:
       - fsl,lx2160a-pcie
 
   reg:
-    description: base addresses and lengths of the PCIe controller register blocks.
+    maxItems: 2
+
+  reg-names:
+    maxItems: 2
 
   interrupts:
-    description: A list of interrupt outputs of the controller. Must contain an
-      entry for each entry in the interrupt-names property.
+    minItems: 1
+    maxItems: 3
 
   interrupt-names:
     minItems: 1
     maxItems: 3
-    description: It could include the following entries.
-    items:
-      oneOf:
-        - description:
-            Used for interrupt line which reports AER events when
-            non MSI/MSI-X/INTx mode is used.
-          const: aer
-        - description:
-            Used for interrupt line which reports PME events when
-            non MSI/MSI-X/INTx mode is used.
-          const: pme
-        - description:
-            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
-            which has a single interrupt line for miscellaneous controller
-            events(could include AER and PME events).
-          const: intr
 
   fsl,pcie-scfg:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -69,10 +55,11 @@ properties:
       The second entry is the physical PCIe controller index starting from '0'.
       This is used to get SCFG PEXN registers
 
-  dma-coherent:
-    description: Indicates that the hardware IP block can ensure the coherency
-      of the data transferred from/to the IP block. This can avoid the software
-      cache flush/invalid actions, and improve the performance significantly
+  dma-coherent: true
+
+  msi-parent: true
+
+  iommu-map: true
 
   big-endian:
     $ref: /schemas/types.yaml#/definitions/flag
@@ -88,6 +75,70 @@ required:
   - fsl,pcie-scfg
   - dma-coherence
 
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,lx2160a-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 3
+        interrupt-names:
+          items:
+            - const: pme
+            - const: aer
+            - const: intr
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,ls1028a-pcie
+            - fsl,ls1046a-pcie
+            - fsl,ls1043a-pcie
+            - fsl,ls1012a-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 2
+        interrupt-names:
+          items:
+            - const: pme
+            - const: aer
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,ls2080a-pcie
+            - fsl,ls2085a-pcie
+            - fsl,ls2088a-pcie
+            - fsl,ls1021a-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: intr
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,ls1088a-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: aer
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -100,7 +151,7 @@ examples:
         compatible = "fsl,ls1088a-pcie";
         reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
             <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
-        reg-names = "regs", "config";
+        reg-names = "dbi", "config";
         interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
         interrupt-names = "aer";
         #address-cells = <3>;
@@ -118,6 +169,7 @@ examples:
                         <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
                         <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
         iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
+        msi-map = <0 &its 0 1>; /* Fixed-up by bootloader */
       };
     };
 ...
-- 
2.34.1


