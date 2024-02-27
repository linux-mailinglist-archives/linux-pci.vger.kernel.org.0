Return-Path: <linux-pci+bounces-4103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEE0868DF3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430AB1C22D9E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D261386B3;
	Tue, 27 Feb 2024 10:50:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2128.outbound.protection.partner.outlook.cn [139.219.17.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E11386B2;
	Tue, 27 Feb 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031021; cv=fail; b=E+7xN5ISni3ijBI+uAHoZo6acMqdBIa9qhh2VUPNCYIKlxeBl9qB8rihvuZPsg0CiqHnEG4AyNAxWkSeZ9/n2vXfros39qRoKpThx5htOjj9Wra3RhrGNYyWZP9LmjPS06gg1udeVAFOjFbMHi1E1mtv/UwbYJdsTnthCjyeM3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031021; c=relaxed/simple;
	bh=153z9nphCTtjtmLY0yRQaHO9ivj+TovGeZp8rlL4AZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NawbfMz82GNuqHuy5ukjNoYbUzvtrmOQZldOiUwA87WvhJtJ1CWdMi7DvGWfx3ETakPPsv19pbQ0ZEJeKrQxRcu9O+MhMix3UU2iRJ2MvyRFPb9D++Q/LtiBuHCT+Opp5GZcWtC63qWW6c3lf07IQpaLetOzUwBdpxmUFhhJNrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+2aArqtsixf7CXhuvC597uy0nx9trPL4mIILkz4/DPRgTzUt7VtbSzTUWTI/OtbJoQIOYHOCqyLcJSbFh6orhNNy4SLVaVJ6l5AP/OAV41lkTVMO7AT+EcQT/wN4yYVMHL/i7bdf/MbcA2LUcQLQkmxrzDnY+WMiNjbCrBdp4JDme1gwXPi5RXRKrpMs7lg2MYcjPSZ9NuUS+2+5y3Mta331qHt0hV+Vl5yqr7k/NFKpvCW/DG2ugDQNoSUv0awn8tiDkTsStOAQecXkgMRf9haU+2qe1SvDS3kBr7JA5ru2K0VfjnmJfo35SYIUfBw6kf8ECI2G6+focfxVsCWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7UZdmdyYz24tezUgGACcYCmJKOSO6Q04qEPwmoKWvY=;
 b=O87UWnSpskxPx6Nc/5xkcGW1fHZ5+LpFk7QLm6VGB1B1PdyiK90MQyqq56ydNGC0iVkyuGVgggZwxlgdaacTD7QnctS/WEAGfkDdoAzhYlEOwpnz6zhP+NkV92bIUwuTJT6YMdIawPIQPf7ipcRw/PsYswsKpiKoGpZLhmg+17P8I/6KFodb66J097KzBOo1thjheyPxhXL80EzYLm/qmLHaaZz0Ku8DrMlWhC685buYkvRa/tIjE9EJEmKCRCZhiRfOw6ljnRPJeAjGMqVx/HydYYdmKkyhrOaN4AMCdHFxH9rlyFCaY4aETFeDKDZU/AJ1Sg9NLzxU8uu5jnRV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:31 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:31 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v15,RESEND 01/23] dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
Date: Tue, 27 Feb 2024 18:35:00 +0800
Message-Id: <20240227103522.80915-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227103522.80915-1-minda.chen@starfivetech.com>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c790bfb-294b-4208-39f0-08dc377fd23e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rovi3hNTH13hMtc3Te6Id6bqpzGyl5GbBMgdyij6odqYjO2WOijfKZ1QU0aDxdSrDtJF4F2zVAnYmec8nh4GkNLxWPM+/36eBjMjrYGBPBWGCkQ7WNOKAkisZIAehmKsBYTSThmkuLMHxV/BodUZyJqP1tgfg52lEcGTsr6GQleMDR/0RWk+tfyGoFqWsDajp8tyvRlJReVQjZRWlC0WnR9sLoKac75qQGFywmskDKyPNDBQ5FSMOGnBQwbphbPIlNCtosEFxQxuFwFXmD0d8Iqp7a3E83mc5d8uxyuP14HWRAMriem3lb0SWitfaG/dfwRG2OUjWgddXx5RA6ScxgJUXSkktT8nLDP605yR86XHEUnNDn2Gfs5v9uhklSLIAUwV3XEO0ktv/mxWDbY6V1ObKXJdWChTAk7se2/F0GS1wrAG3KfKIIXP2ZiZT8dA8ZVGhgAim285wdGv0hFPAHYtKwoyCO/KD3Uyw3NNYlTKpl3NPqM2liZCBaUhRJ8mHGGfSdq+lmBCdhxCUWDTmnEK8lAYoteeINkKrOUkIQRBCZc3HwEwoZdZIwgeNcRVadkL+kE3hgEoBrvCRXtXrwXmd/xmP06Z8glNamP8ZuWLcDCFvIzAjZj77SWY+Mps
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xcoMY1KqiL91ax3kGKHJJ1kqLgJdDEfiSN7zoYMbFcyG1Nz4DZo28O1vRovG?=
 =?us-ascii?Q?NF6Mn2/4l5Msbvmw7mFiVdzSXXUuhKnQoi2mFgwgNjqFuP/uZWaYmZYPcVNx?=
 =?us-ascii?Q?2tkwj2eMCvc/f/ZF8E1Iv7/AurNfbwla5qIsfM5SZ9pwyUkCk5sBa5tR/cf2?=
 =?us-ascii?Q?GGusZ4/b5ss6oxm3o6gVGOCOjDYuUMTSv4QfWvqYiLsac+3PlbRj0ela2jWJ?=
 =?us-ascii?Q?cTQFRMLuJLRSHEe45VNrjNtCGFBnNA6bsjU0nASml2hCqstN1BhpTaQyWSXj?=
 =?us-ascii?Q?UCywoYBM+cJKVIE2PZgUYb+wkDvETkQggXcjG2AazwN/Ea7wdy77ph4N7869?=
 =?us-ascii?Q?QrVIhhfId+qjKmE4lVcYYGyW85oeejrr+oMFSSVzlQIUs4TgbyujyD3k6m0L?=
 =?us-ascii?Q?t+AruyYaBnaC+24vALjlNoIJVUDl7FXb+OvNU39fId0WBXskiLzORMlJpArY?=
 =?us-ascii?Q?DlazuPjjcfgXbJjPtE7YoBeq4jWX+RE3u42WDNv5bsIhJKlTyVQSC2kghm9f?=
 =?us-ascii?Q?fuAhlw0Yw+7SpHaZojWwaVXFoslrJ3d30C7aaC0cXkJkfxwKScq7DQvkbHBI?=
 =?us-ascii?Q?L/dnOh/VM06stPTIjdgMiHbd2YQ+lu2jaRkVoH/5EJ0Z1AilrVIuHq1MXnG9?=
 =?us-ascii?Q?Ei0PhPxr+OsxiuuXmiDcwBdB1IMbJh1HnhG7S1JZjZzxVPj1pBLHGjkCNc+B?=
 =?us-ascii?Q?w3ujTqPrsvbv/DeJ23ry3cgC48q43tjzCRs5oNeIBmw6kd3gkoliqMdFJXVW?=
 =?us-ascii?Q?OLHQwVEaGmguLMwI2oKYENytgasBcE989bDIoqvveCfwlai4g+0UTlys8t/C?=
 =?us-ascii?Q?wSXD/d3bnLTBcB2fdzSWVd/5CW6suyNt7DABKb5jQUgxKILyNDkGyObFCUbw?=
 =?us-ascii?Q?ag8LjsCv/9JYo6uu3Sc6YbNAU/fNoUMItktoW6W5dXWx5pUCYLuXx0knZZLK?=
 =?us-ascii?Q?s0CesJFWTOYw+RJZl3tFtIvELZgn7ZSRAUsZ+xz8OAIdSMJZjzGt2ySUAmr2?=
 =?us-ascii?Q?g60Xw1LX7DwQNlk7rI9PlNahJ4gcb1bm1VDp5FM6FPlEWW8VJeSy384i8GbD?=
 =?us-ascii?Q?2QvZgeZNF+SqcLY/AcQFydZK/ipYbb9QxLUDcFYv4pWweEb+rJE2oFaJVlcI?=
 =?us-ascii?Q?C322owbgM+1hGOXM288aEZdDVXRq1xnqq+FJEz4f5ucG4WGwITZQtkBAHKIC?=
 =?us-ascii?Q?q/1wxBQyeLLcztEmX8DXRfttevs2q/RwQ5+ztjveM4e2FlB4OPaBmtAkEGCY?=
 =?us-ascii?Q?nIIrbb+yNtzbCttGjYZQ9q56EFc4kyYH3hDdcWRL9wvZ3WiWUDglu5QOhG4i?=
 =?us-ascii?Q?1Jo0MvaBqkmZdvOYGTBkLKFEv1LmFI2uDDDXFYecOOLlAEPTDfhPr1VqI31n?=
 =?us-ascii?Q?ERaqR8Y5Th0mNIh3IU9q1akXG0rRGP/uTKKWyAFrpLPmuHahDBKZV6GxosrP?=
 =?us-ascii?Q?AbLZxhy6P9jaocckYYpbWzB6563domBsJOI8Hhhe0osKw63s1b+tyM1TDucS?=
 =?us-ascii?Q?FbMfrtfOB3KtM9MkWmhwHUNNi5As3d17m6ILSuWr+PwnwwVa2W2efIMezeX4?=
 =?us-ascii?Q?l/Xk2mXs7+wFmSu6GR9Kgr2vg6f97Y/nh3NaXo/kYBYIv7SKKikoz+edFK/X?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c790bfb-294b-4208-39f0-08dc377fd23e
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:30.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMSsNfyBes5AsDh3gKn55KytL/y1vnLoi6FlMgr8A9E5ZGcahvZmjWcfSCloiXB61lbbXlZKffKWQ58SMgP0AhXyq5z0ZfJwt8go8lMqzQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0863

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
 2 files changed, 76 insertions(+), 54 deletions(-)
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
-- 
2.17.1


