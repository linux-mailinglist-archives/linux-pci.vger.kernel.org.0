Return-Path: <linux-pci+bounces-4334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E586E58E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 17:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F241C20EDA
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98B72935;
	Fri,  1 Mar 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TxK7jDpU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD572915;
	Fri,  1 Mar 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310490; cv=fail; b=MP2SQyCS3BeFVHlAZiwgL6+FJFQivDFZbE0U0JPPJa4bcJNLUZETc3Hq0JFbZFvPy7XrJ9KVJb/1ebcAfnJpD2mtyf3S8l0CIMS22Lv5zqdYU2RRF3JE13GiJfkILZ0VzZIDMzfHnpQNu82IKB9B91XX2FgSuFYdRtINR9RBP8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310490; c=relaxed/simple;
	bh=qC6rHWKHqp4kInrRSipWm8nqADtjSmShcemA/AvdgcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lZFvomNWR23iWCK7G5o3HRhDCpRtRSnIVLnE92ISm++T4rPHiD67tcaA+sV5v4hObg386jAu4a2aVtDjLyJdkHGtaEfTfVRXMbjiq3zoez07xv5nBMT8Enn44xMLnmXEaWFiEV7jINYq6W4zoYjxDmxBzWMLjN7LgT9Pesw7+X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TxK7jDpU; arc=fail smtp.client-ip=40.107.241.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5ywFsr5GPAFtlwxkUWW32WnqSNhCnh2dEntQFzPtdc+SWCyoGiyS3NqGgn4vr2YCFD9rfxXG1eI51IzUt12dUkgkMdZtS+hVnCVwY/ee6iVif+xPBDNiZ3yJ6hDFYbJVimvp/Gth5raUHwUb25NQpKIFspqrXB62YJKKSF+/+ctOvIWdg7P+f08BfKFT3S13fREqPPGJIhri8C+EUE3liY1Ivel9d0581CiP8hpJ0twhBErvfaui+xpWSzuwDCXnGjr/dW3RQZ2zMI//ZrCHw6hn/zDVG71X41mHs54b/cIhh3zCHiKChYNghKyk3gdaExVsGJbAksrLKyKXPbV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/Ghd3C+4H+Fc6ngvZsNzVyDtcpPg/c+uzigABoo8HM=;
 b=Koo+p8gbjeKQ0Li0tHsgCMuHn3oUP+mlIkKo7hgCTT676GpcWcuXqeM54yqQ7bvtlv/UfKS3rn7nJQw/xVIvUB0DIlBd+nDc2nISAp5oSEfsttj219E4VjAx0z6zO2o12wvoLeo117Z69dY4m6f3Hd4DYs3HSTLCNw28xyPU3vkBdnybl2PeF6uq74oJkbE1QVrrULogNJqZom94DqomL9iC4bhITHt+ISZ6IGPhCGYYC1ZOzTODnVtxoLV8zrTFSULOaQ/GNRYt2OPFiDwbxI4ZL0vZ1mmgEGa9H7GkXCRLB7agbkckY9SAxou4OfSxkUpYlpyRgjbEYZcZg1u91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Ghd3C+4H+Fc6ngvZsNzVyDtcpPg/c+uzigABoo8HM=;
 b=TxK7jDpU2Jf5DSb+gkSSE3PgyTXa6VW7uUKhOQV0cVGZMQKS2lcOtW/IJWIVP2T3m4Dt70Ru5upsaOuBFOVOuw8/QPhzfbbtGttY5+37pcsw++tTsrhOSVrArysaMYWmPPVoYIXt/+803X5aMyUBRnFuswqUJI5FknLpYCq3woI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7865.eurprd04.prod.outlook.com (2603:10a6:10:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 16:28:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 16:28:04 +0000
From: Frank Li <Frank.Li@nxp.com>
To: conor@kernel.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	helgaas@kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v6 2/3] dt-bindings: pci: layerscape-pci: Add snps,dw-pcie.yaml reference
Date: Fri,  1 Mar 2024 11:27:40 -0500
Message-Id: <20240301162741.765524-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301162741.765524-1-Frank.Li@nxp.com>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7081b4-ebfb-457e-d4a6-08dc3a0c922b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+DJzelNx4Wzw+C+L/iANrAY97vSChfEqeskVY1ENL8f+6uPVOAj1mb+Csf+c8J/0cHXCsq9yh3R2xKqKMqwahnl0hj2f9HqD+sxdGSjm77b3GTNJB/aY+rZmgKkHD3J5BT4I/wdBvaojCea7fKDUlrPJ5q2lYZo4sO842fVa1Fio9yUVRLlmBuQvw3r9y0nEI1f/vxtFBpbuNIgEsCbUvTU0heryzn1DMPZ5LVq2LKVk0fb9L0T4Sb4Tb8s4FKdu29FkNFjMUd7XU6yyAApt6RvWKTGbKkhzdVXB8sedzucEpmAu53s5vmE9C+LH5ksPVnu9YMy75tZtDLGWR+4+CXVxQ1TbgEy0IehjZKKwo7zUvGHSsCYohw2dgXMUM6W2lBfXL6xLrvneQ+XCVdovz/Kc6Ge8tKbvsdoQPcgEfhIBySs7KnnHXIfbaj4whCB6L6XVm2tCnKRvm/SVFWJ5Ec+D6oEuqz90d8bwjD1F7VW10JOW3YhZ9uL02PffzASUKvRooO5WYNL81bOUb0Re6d7ekeG2CuL9qrZR19mhtgirTt8qq7H7s7wsuqyDVjghb+I6Ua8vIyJTOfbMSUZj2W+zMYYusXd8EHK5BIe3SGemdo/CAanqev3P2Vd0luwzE7z6lVLUqrWJTTTxNPMAbIGVBdQYRNUGMX5mVazSEMpk9WJKLL+CO6DLIUyuEJljLvy96OfsHIL/oddTF5E3Hg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a7pBLgs0qFPLmImM6c7ItZgtLBY4tWnBugePUB9GFyww8I8tDU05BGIisA78?=
 =?us-ascii?Q?4fz0+WcuaIy/+y+OzTNtdXHEIk9ANb5aOQyDU9NSz62VI6/b7gvqc5/1i0Ty?=
 =?us-ascii?Q?9KA7FqtjOwdCZ6lOOWOAbKCY0Wkba34VBqGQQYE8FU6wD9PeYxd892ZSQJDy?=
 =?us-ascii?Q?aMNHeXaRrkVrRfxhsNDwfGJw3ukbRdXnvk9c6d0GHy6+Q0O7mlFZgPCHzUub?=
 =?us-ascii?Q?NzR4TUegyHPZVTyiHR/QDbAyK6jgAcgJyLF0ZLt8ccF9/JJ26jZ0ZLr35Kg3?=
 =?us-ascii?Q?Xf8ysMZ/JaYR0PbeekySn6NRp0i5pZjoXbnA3n6FvPaTlnkeBl/PTPgjmuZ5?=
 =?us-ascii?Q?VJ2KIYUj1yMDxnifBXfAOe6Zd6LrQWIiiG+N+Teuyz+qlsUuYsQnF6YqN/+g?=
 =?us-ascii?Q?f/bHJrgEq8gRjwq/2Ojgv07dTeYCm3OHQXFlA7PxYfSfEUzok4L1Rll5lWns?=
 =?us-ascii?Q?FFF8HOAaoseyIfNbgkXvQjYTSKG4U9C0wsj4YpFnhQJawhmh1/KMCFYCRQZ0?=
 =?us-ascii?Q?T66/NyMuczEdkgrKQ7npcEzXVNQpzsJObKgPW9J4FOOawze8+HKxwpKqV20i?=
 =?us-ascii?Q?uqlHv0IP/B9T1KUgVslfqHRXFx9z2fvQfAeCmXhbNQbwk4WI4s61MHNdgFZz?=
 =?us-ascii?Q?PjJgMY0rTSr9EGE+btbExaMu7MHjkaocz6hIosyoXpAZa/1vJp1oqh43wBHv?=
 =?us-ascii?Q?Ov5Em0SBpCxkLUTDpqxsOpnH/NpsqXusnZ5w1Bpzlarr+9n91omh/5TxU4oD?=
 =?us-ascii?Q?3n6bk7fmt8PRw1GwuGAbJvuzEuKrkkX9Ik7pgUZ+do9OV+16tVQ3DIMd6r7I?=
 =?us-ascii?Q?n6fNiErb0GqaRaBg3BIt1Q+IUyYh5IO6yzKw+MaI6+FTxRZ2fq6cT69Adqkw?=
 =?us-ascii?Q?Dl1c94WxStJlOk+noBUDH6jV6rKyl0ZwiI0nlBbxj63068OG4odNx1KIqBzQ?=
 =?us-ascii?Q?rXnu7wDobDj5qzuJ0PqhR0JSPkqSJ9kLwHvoVRsWd/rFeRbSucc8yWnR3er4?=
 =?us-ascii?Q?72MtfSFX2LDbPWdMJD1sJZ1iikapjLXez/mMFJ6Orn1ST60Lbv/6WXM0/0RW?=
 =?us-ascii?Q?HHJf+Vkib80Q/ub2iLhCybTFV1WNovQ/UjA6oN8u7zBa/AoQj+sFeoaOCVZ7?=
 =?us-ascii?Q?ugR2TiXEA2WQFCjXqlnw7vwxRXI/82AsSQ3jFKtq7jPXWI8rkW244WkLYs0j?=
 =?us-ascii?Q?RRpRYV43WqYsWzAoLUd74z4VZJK18HtXkgQIFt1l2gxY0GWvOhMUS+ZDQmk9?=
 =?us-ascii?Q?BexlXE7x4sowIQRHbXLRmTt8FBFLOs8ssWphJmW8cxeIb/lUrOiK/wtbhoh7?=
 =?us-ascii?Q?saXeG93/5OLn81HYYrgtqY9LYb2+iD/DYfRxlyIA5c34+6WgUO/gtbIirlcf?=
 =?us-ascii?Q?HVldo7ND2ODQgOtEoecxvxJowyIpK42AbHr71sWC0QYijx0ZDABegnFy/qCC?=
 =?us-ascii?Q?IuckbVhFt++mV29naMAejSvS8rc3zFyFh13QpEsUyZa/6cGqRni09HSJOnB6?=
 =?us-ascii?Q?lKid8oXavkDPYnxZCMCERVSaMyWN8FXDV5B2ofbNMCjVZSnt+DW0m91PHrMB?=
 =?us-ascii?Q?yIXn4gwqcYL9pYPVdrISs0I56PXtnl3QgJsFQ4Q/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7081b4-ebfb-457e-d4a6-08dc3a0c922b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:28:04.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpjpnFXIKOYuHmX7XaJZS3xUnu5Y6EyMlHcuq95WgHsEfe1XkgBkQYmfWKvP07CxD/kpD6yonSowRRdVGBrkdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7865

Add snps,dw-pcie.yaml reference. Clean up all context that already exist in
snps,dw-pcie.yaml. Update interrupt-names requirement for difference
compatible string.

Set 'unevaluatedProperties' back to 'false'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,layerscape-pcie.yaml     | 104 +++++++++++++-----
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
index 3f2d058701d22..137cc17933a4b 100644
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
@@ -69,23 +55,88 @@ properties:
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
     description: If the PEX_LUT and PF register block is in big-endian, specify
       this property.
 
-unevaluatedProperties: true
+unevaluatedProperties: false
 
 required:
   - compatible
   - reg
   - interrupt-names
 
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
@@ -98,7 +149,7 @@ examples:
         compatible = "fsl,ls1088a-pcie";
         reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
             <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
-        reg-names = "regs", "config";
+        reg-names = "dbi", "config";
         interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
         interrupt-names = "aer";
         #address-cells = <3>;
@@ -116,6 +167,7 @@ examples:
                         <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
                         <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
         iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
+        msi-map = <0 &its 0 1>; /* Fixed-up by bootloader */
       };
     };
 ...
-- 
2.34.1


