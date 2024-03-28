Return-Path: <linux-pci+bounces-5317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AF788FAF9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E5DB26980
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33EE4DA0D;
	Thu, 28 Mar 2024 09:18:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2114.outbound.protection.partner.outlook.cn [139.219.146.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E556041C62;
	Thu, 28 Mar 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617538; cv=fail; b=idFV1/xcDvMw6FQPy+zuwcIHHRPyFFijtpPsYTiWqh5MCYHM2UIXSOWuxOVZh/Tcn51V061IDRI8dneVHgussbnILIx2FjgV7Ky/fWZ3z/BsJYLwY7Ar2x7S05prBZWh5gVJRew9knGBqXTpOYhyXIoNuUgWCK5nDNLL3WQDZl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617538; c=relaxed/simple;
	bh=HbCVSTAjM8a3PXKEy1PZmv0HG2ZFUW/Wt0Tct0VQj44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igxiO2UraUCdYkagdExFH5EQujlVtw7YWEiacI0a4XFXQw0HcmWGO8DZr38AfBqAoBLfOhG4AOVSR0oSlbTm7Dfc1sseazDSMs+vSvgHh5PMRExMMnoZvapc9on36ejTf5lDTPE7YZ/A2JsrB45tq+T7uSSD5ZzdlZUVzNZ2X40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX2HxbF4wcxZAGRWQvRanOBFhaWLdOxn4JqvYbO+25pz5V4EESjO7QC+uJWf+rZs16g3/D+4OkC5uSvr5GXY4kiFaWdSpkjGVF2p+lv0+rNTD9KIwGsnbn4l7MvMuoisGo7GswVhET0mMX7Rf9d99bfA5cO3LOsroNwt3ZyvXBvrm0920m4Q8B1QkLOjTT+CKKBg78+Fs1dh4DEPaCNTAw6SM34qzNdOZ5drqcjOyQefLLmp0J7B4tomTd/yhGJPwvX3jrrYtapardNX3YKjpAcXO3uDAMP6wrj40reorFEwIENXZcHkJXIB2n+gHo9bTczJy1RIGA3XG5TPKw4kTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzDoPxR3Yw9qsHSucTZgXrB+6r4PYRhPc+CkYV1T8oc=;
 b=TtZcYkuEWBj1x2TvyGRqIXIbv9j05G8Ix0qnK6hgB2+K7wRAtVP+SBgws0i6qzBI3V9Iw/fu6tDUVC7no0EYBOoFs0e3eDCGHZDypdajEhp2QnE5PGYxamh7yyfLgBksLPR42V7ZBWAwt33H2FEoE1XIemz88sUo9ZGSWa6wwnsZqRYwfTbxGxxNjLwL3kftOuqBzwEB/uMQRgDgdIFiwQej6MKeSiscxTy52IkOMwYI8x+IXu0zqRqavUvu2LjzsR8t982ngX6nUQ3xuUwf6JlEBHApSxu0mshQH84xHCHrC0T+vbg2elEvtffg/kHQEgKecPWOx/2GFLZ5hGcOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:45 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:45 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v16 01/22] dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
Date: Thu, 28 Mar 2024 17:18:14 +0800
Message-Id: <20240328091835.14797-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc79af4-ca3e-4708-7233-08dc4f081152
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	04BPEbGE03+HvxLxpa6quZIoABmU2R4MIkSWUr/IE6hQOgTNVRPh+76BBGfD8ifLDMQ7yoIecSV3rY5mrXOjuQ+V6VBwix30zEWwwVi6ojsATn5IBFC909xPy0bbyAGSffc5jL2XkPHu11Dt2wkyGUmbNeUQGJa5Sc+Zlxkd/1XvbJ+PX+O9Gh7Ckmvg7jhkjC+ggIoJRCT701t11MiM4KE9+u6D/piGbJIhu33vEDc0g3Y+3KM1EIYAS1ZhkuQa7IUE7+oVIoQdhHI1OrPeJGpLs9UsFtMU5OVYf4Lj0VKCRS8+xzaWRkE5exr6EVtng0DTKW2XtMUuwWFj0b8FsXaBEG0+j6aJOnByQ3yTFL0jUMZW1nm3YdjVsEXrcG+Ye+CnZ52rpn1vtcnwqY+ZUsmH6nn58iiuiJXQ4QT2o2r9hCw+RpAZysXJMBFVnjgct19lCqt1RYuDBTmqg9TTNEi2K7dLz/a3wnBqr0jEmNdf3FZwX0keeJ5Os3ePLsbUmyi62828jxCpiALQotr8yk8Zo92Ukvd6wWG3KJQTUiST2E5nhQob+lx3Tqmljia8JoUQ/NSyRBnOxbHynlCEeb0wJ2W87eFv/9ovbISLqPOFiq9jMF46FFF9B99xYge7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jC536hJMBur1kIOvj595WrMpNx+VYlS9KAsu4h9pInvr2vAKSoupyh/ndNTt?=
 =?us-ascii?Q?y9Zn2hQoY8fG9XyomUxBSJRNh7Ern7Mqj4lXnxc9Z/nSj75AKOxcLIoZ9obm?=
 =?us-ascii?Q?BCQP/ufeEnU2P0DU2oShAEHQNCwpkAy7C9dwxnHx9l2zEoflbBU54BKjbutE?=
 =?us-ascii?Q?FhggicmCp2iz9TOsZohE7PuER8DDvRFT4C9FtmBLDy2q7+lgMNpXsEzVKTeQ?=
 =?us-ascii?Q?rvIvG3E20tIdEdBzJwzJ0FUVp41GDhMmg1xgHZAwLXreLG/GxBBjxWryn9HN?=
 =?us-ascii?Q?Ic10+v0QyhNNTurIYssyZ2ZLz4EynL68U21+JmbaedChdVGnDW2fsGRDr0aR?=
 =?us-ascii?Q?37Ning8tjOn9Yd6rROuWxhR9DkWKKVkERQZe2h4e+caMbbyNiaJ0xd9YUViq?=
 =?us-ascii?Q?Is08QLHaAgN+4c5M7WJlM5JiQVDXwXIJ6650EJqoAefhqwLBF83ZVhe4iTTt?=
 =?us-ascii?Q?HXxovbCJ1FeNmTc/ENIHMgD84J0o4KdOOdG0LoipzByrADOQQ36oixs6D4q3?=
 =?us-ascii?Q?Gv3KqXc6WAoF93iQ5t1xH6Q61YSZE7+BNZ3AA7MyyXnCySDGe4TF1NIYSCcm?=
 =?us-ascii?Q?AXBcb2BNEYhSH6mZOirLvb2WASUQi23MNqrM9nVy7xnV0bneGQZk97M5BKxU?=
 =?us-ascii?Q?2ButvR5IUX8sbuhR/bZ1I1RSWAkl1v8JhVmxNr9Cj5PSatvUDgWBu6U+Ukb6?=
 =?us-ascii?Q?BJ9dIAnWp3FxN4KiObDXBvEMUf97g/Vjlg2P1ZgDlujzOHcGC7cbdRe5uyIT?=
 =?us-ascii?Q?dECcDtMHIH9VuliPpvgPRzNhTExI4t3A1M1RAFGzK0C/TKqogNCtgYZ5wcsJ?=
 =?us-ascii?Q?GpYUdtpYZpJHGbkmnK2jy+58mjg5kL761GFAankPPG/s3lTbGaT88kp3IoSq?=
 =?us-ascii?Q?hU1jjup3Ikv7tQWxS0lQ5PX9QGxGbjVSg9DkTvX7wPO6UoKEutCZdxjFH2AV?=
 =?us-ascii?Q?YubbeG3Rr2nOl0s3PQnDY+nA22+y7jfT3Rm7/7qxzrPul3g48KQUAXJVr3ip?=
 =?us-ascii?Q?K6TXKGHtNfYoRcpEaSNBYlXNK0SgtWhYbPZ0Eh8VWFNNKzF7WH4IAuY7SpAJ?=
 =?us-ascii?Q?UJU2FhLF7BXMTLmMPW3PTrq1Cr/1terEjshGoCC9TpsCJkn3/ELYpWOD+pVH?=
 =?us-ascii?Q?ptFMwDvLFK9UnJoWIp9Os29d2aG2IlykrmdZlwegcJ5Ne4bVoQoRkgZ+FfOG?=
 =?us-ascii?Q?orsHTi2ucen7yWuxjkEMRiETPhR3aWyxd2qSwQTQhwjI3/aNAwFLskMiDKSo?=
 =?us-ascii?Q?yC/OtA3VOEykNfzrXdsOTWakeQwbjD7ggQFmE35ywQ46bT4bvu8ybUAkE/B2?=
 =?us-ascii?Q?nBu4PY5GIbFM9z2N/FG2TvYBlzwgxS+mOB2oosT6HS8dfnwfT/rBy7hHEVWB?=
 =?us-ascii?Q?yTwQFxkjf5z8JFm89FusofFp+UPox8HH0h0dBChRuIUuP8LQUJOk7IMpSzdT?=
 =?us-ascii?Q?ONdkvD8YoYWUK0PIWlbjV3w7tlWfsj8u/lV5ootFvTOwaJS4oNhVUOSCxeY7?=
 =?us-ascii?Q?Zo4rzhO7djvlb6ifRglK/DWECv5STnUTaOj6bOeQrEb6MG77MR8oUhakPwTn?=
 =?us-ascii?Q?YygzUW1SX9I4/yLueNwGFCifv9lKnfPEKmCCaFT1JQMpqCzqDQ03V6DBK2Y0?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc79af4-ca3e-4708-7233-08dc4f081152
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:44.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpVczu0QHOn5pV2f8B+naM/HZXehpWcgNJpmmGbFb7SzhldRoQGSdpAf1bFoHdA47TUslqXcps6Phmc+fZUOgiIWFX9OSnuG4cEN5dgqdCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

Add PLDA XpressRICH PCIe host common properties dt-binding doc.
PolarFire PCIe host using PLDA IP. Move common properties from Microchip
PolarFire PCIe host to PLDA files.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: John Clark <inindev@gmail.com>
---
 .../bindings/pci/microchip,pcie-host.yaml     | 55 +-------------
 .../pci/plda,xpressrich3-axi-common.yaml      | 75 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 3 files changed, 82 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index f7a3c2636355..7c2d51221f65 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -10,21 +10,13 @@ maintainers:
   - Daire McNamara <daire.mcnamara@microchip.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: plda,xpressrich3-axi-common.yaml#
   - $ref: /schemas/interrupt-controller/msi-controller.yaml#
 
 properties:
   compatible:
     const: microchip,pcie-host-1.0 # PolarFire
 
-  reg:
-    maxItems: 2
-
-  reg-names:
-    items:
-      - const: cfg
-      - const: apb
-
   clocks:
     description:
       Fabric Interface Controllers, FICs, are the interface between the FPGA
@@ -52,18 +44,6 @@ properties:
     items:
       pattern: '^fic[0-3]$'
 
-  interrupts:
-    minItems: 1
-    items:
-      - description: PCIe host controller
-      - description: builtin MSI controller
-
-  interrupt-names:
-    minItems: 1
-    items:
-      - const: pcie
-      - const: msi
-
   ranges:
     maxItems: 1
 
@@ -71,39 +51,6 @@ properties:
     minItems: 1
     maxItems: 6
 
-  msi-controller:
-    description: Identifies the node as an MSI controller.
-
-  msi-parent:
-    description: MSI controller the device is capable of using.
-
-  interrupt-controller:
-    type: object
-    properties:
-      '#address-cells':
-        const: 0
-
-      '#interrupt-cells':
-        const: 1
-
-      interrupt-controller: true
-
-    required:
-      - '#address-cells'
-      - '#interrupt-cells'
-      - interrupt-controller
-
-    additionalProperties: false
-
-required:
-  - reg
-  - reg-names
-  - "#interrupt-cells"
-  - interrupts
-  - interrupt-map-mask
-  - interrupt-map
-  - msi-controller
-
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
new file mode 100644
index 000000000000..31bb17b11e58
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/plda,xpressrich3-axi-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PLDA XpressRICH PCIe host common properties
+
+maintainers:
+  - Daire McNamara <daire.mcnamara@microchip.com>
+  - Kevin Xie <kevin.xie@starfivetech.com>
+
+description:
+  Generic PLDA XpressRICH PCIe host common properties.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: apb
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: PCIe host controller
+      - description: builtin MSI controller
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: pcie
+      - const: msi
+
+  msi-controller:
+    description: Identifies the node as an MSI controller.
+
+  msi-parent:
+    description: MSI controller the device is capable of using.
+
+  interrupt-controller:
+    type: object
+    properties:
+      '#address-cells':
+        const: 0
+
+      '#interrupt-cells':
+        const: 1
+
+      interrupt-controller: true
+
+    required:
+      - '#address-cells'
+      - '#interrupt-cells'
+      - interrupt-controller
+
+    additionalProperties: false
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - msi-controller
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..06278f1db13f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16946,6 +16946,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
 
+PCI DRIVER FOR PLDA PCIE IP
+M:	Daire McNamara <daire.mcnamara@microchip.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
+
 PCI DRIVER FOR RENESAS R-CAR
 M:	Marek Vasut <marek.vasut+renesas@gmail.com>
 M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
-- 
2.17.1


