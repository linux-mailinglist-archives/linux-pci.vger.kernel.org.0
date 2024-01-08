Return-Path: <linux-pci+bounces-1784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C2826C18
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F882826E5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F9814012;
	Mon,  8 Jan 2024 11:06:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2042.outbound.protection.partner.outlook.cn [139.219.17.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68514266;
	Mon,  8 Jan 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVIllv0uHg1yPsLMdvPgrwi6NhaGbxQp6f4rguV//IvKVC1zBEuBey+Y8/WpgVHMMLcc7xakiOn4kLAbVlgKrovrPMFTixx2MP7W3+5kGYoOb94oNYPEJ6vDBD8SgQ/tHwoIXJ4Gsd7GhdsY4yKE7Tdu4i3s6nk0glYF7uQWYqeNfPTXssEqe1XhDqDvc6BdTw57SS0kO7hHwrZjbaFPUupHZrjTzV9tv2r5GIRFHzZqgbiw/HgEaGhqWGtZA+bqjvZtic933MGqhPMifL3K5/Lgptwl2+5oCQM717TEwO/m3ruDZHcMNhSUN1YLs6HkMuNNlxHvbqubFv/agxZ01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7UZdmdyYz24tezUgGACcYCmJKOSO6Q04qEPwmoKWvY=;
 b=TSpt9sEs4JZmbW846TH0AOusfDwJqaGA1Y35sFzLO3jBauJ8BG/5K4mEYSC0os4avu7dPUPSUujZOb2/5NVSLyztYiGQPzIIeH/rP99qLSsWZCvUvvjsA80F3nxHde9tPHYTusA6XMlnOnu5oCrhNQFiZW3KoRMUuhz0i2GP3sO0WBMfVuAFobNF+lk5pkGRywaQWbMDpmdaK5w+T587ImOaU7/1iVnLofdt+32a5IMfVTjooD/qu8vcELqHy+9wr6P0tt6qsUIDY1/+yBdmPTvLS6/YCbZYGvSqiJaqB38UNfNcoz23ftxHBt3u0jZSnLPpPV+PBB//ke4kQY3URg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn (10.43.107.79) by
 SHXPR01MB0701.CHNPR01.prod.partner.outlook.cn (10.43.107.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.32; Mon, 8 Jan 2024 11:06:24 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:24 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v14 01/22] dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
Date: Mon,  8 Jan 2024 19:05:51 +0800
Message-Id: <20240108110612.19048-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240108110612.19048-1-minda.chen@starfivetech.com>
References: <20240108110612.19048-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0701:EE_
X-MS-Office365-Filtering-Correlation-Id: d82fac8b-26e2-48dc-f819-08dc1039da3f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lmmJ6j/R2JrGo5u7RcSTbgWLcb0xouOAWX+xfSv5qBe4t+kNx9RKNV8aYSrVTZIE24FoUNX6wagI1ZT0jA3nPtlOSTu39N+1cpixaBUKNuE6CuicJs1qG9tUYbL1Rk/Ltxkh0R7MgQjk+MIWJpOGvi5tKFyGj/TlS8Hhf+nBOZSWawz56GmgJvjrLrBwlRBGKJODnQcjBCon+oAh2k0edUdUTVsywmOaEx+KeVs6lcPsIm/0QGZlzZBZY0WrlanAU5FYvap1+Lhe3G6HCfGIbGDrtgQwny9WNXrraLIHp7t2ExbWQtWlcsweQ5YO2A/SleDLYJ+/CC2Z80O5hfCP692jd+Oh1KkJy0tW7W/hyJMnqapYI+QjD1IqRZAwWwtBEFAilsGSJcUHiyN6dDEqSvY4uU9HyAX4bExy3s9Ty4/77zEmkSoz3IXSL2TZxNgh4t/dX1j4K4b7UK8A4ET3H1HRBsy8N/10Cn21TF3IabyDr2FqGgYzy91qW/3ayyxiGzB7jKkQyUZV/slBeCPpmOz9p1U+3JIfOX3l1HWTjzqPj8gTtGnJLR1KwfjZbkvf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(5660300002)(4326008)(2906002)(44832011)(8676002)(8936002)(54906003)(110136005)(66946007)(66556008)(66476007)(966005)(41320700001)(508600001)(38350700005)(6666004)(52116002)(2616005)(36756003)(107886003)(26005)(1076003)(41300700001)(40180700001)(83380400001)(38100700002)(40160700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7purYD93x77653IspJrBERTgyJ0x+nx07e7yLbMfILBSflAuOZA5HU2S/ms5?=
 =?us-ascii?Q?BvRV08wJ0RMFkqkkXeb1lQqduqcoY4VSDqHZwjjQOC3wROYoO76gGq9goj3E?=
 =?us-ascii?Q?3J9i/Ar+b9m9CCGQlNmNAzD1K+jk0KaXI9+tzGihGCb1OFj7edhsDkvNjERZ?=
 =?us-ascii?Q?YNvqgNF/KfztA7MEMMERABIY9ZJNwZ6+hmN01o2iVK925ykbMxdKyH2fF3oB?=
 =?us-ascii?Q?ZR+ps5Fl6DJYGa9jmOrENtlbf4twQunM5vuJxSRpKJphiNgd5GlxpvpY5ifh?=
 =?us-ascii?Q?uWdiTq8KpDCZsp4B7iFkaeNhgXWrcx2zzvvi9SrNfBI3zg0Nov9ax4S37YAY?=
 =?us-ascii?Q?AbisuW5CEGqCTazv6wtwk/01JY1P+SoxpY16ZfwCcazscPlyxzYclDc1olGJ?=
 =?us-ascii?Q?qjXSNayt46n1xM0gcCLcBBoOaHXbiXsWLQiLZRuJgDMecEa3sHuHVHWqcKRx?=
 =?us-ascii?Q?ZKfTR6VCddtlRq90AIRXCNcl5TTr4fWf9J0tWme+b7HElv+Aj8vRKUmwLhDW?=
 =?us-ascii?Q?hFGG3xXp07HaDVBjtZrTnzhg+cQdXPxNK9PtrtjFhrZsR+cmdXuVdVdSMkgB?=
 =?us-ascii?Q?nd2fflG6Xp35oYRjGdiaPmqY7glr8QJs95Up4o22q76P/Iz2l4IxMlXJTNjV?=
 =?us-ascii?Q?xhVZZqIPzNZMqmOoUSCi/OJEey7MI+qBJ3x75Eh1s/lGbVPT8t1n+eb4G71M?=
 =?us-ascii?Q?09yg1GCn1KWJazSClqFDAFJWNXhzpQa3+ZT8Ll+Dyg24Tp20w+3XoXdh2SQd?=
 =?us-ascii?Q?hfB3UgGxUeghrEOSHCNpQtJSNJfXbRFalolDPEpx2PaFlVxVQit+Lust75Ih?=
 =?us-ascii?Q?zxMH/LEyFQ1pxneXF0RYyl47JhM9drOxdR1b/RTLV7Kz2uCxO8AW46DjSyaM?=
 =?us-ascii?Q?f8g5AC8fOCxkQf5KH3RtbOl8/790yMTP8tvzVU52O4McZYyrqa7uO4KgHgJh?=
 =?us-ascii?Q?SS15nPBvFjDAT+/mv0kravE3ibMU1x2i8dwiXf2GhUVo9Kl4VtmZf/Rf0nl3?=
 =?us-ascii?Q?buV0Rty2lcWIQOvhSrxXOSUejjshk8buPeRb15CgoT46hputK5b2FGseJatQ?=
 =?us-ascii?Q?WRfK+3vRGMmPaI1IUR5Cpis+7IFCyWYbKVHkapwpNvpyKMo1W0Z2gj1yvjU1?=
 =?us-ascii?Q?ERnuxxoNDcAP2CQdrXs7kziyJDNjbm5QxZl1xrXdkht/DuXfs0yJ8xPrB7Ja?=
 =?us-ascii?Q?r1gnL+0wqRyQAjbp+3i5TDVFElFLU/tIYoKAU0Uz3oyrhiL6vhk06hVlaonH?=
 =?us-ascii?Q?uSnSE+EWe7n7SRbJxoVUHajjfOD/XGUupXs0ZDwOUcE1QmD+zvOQIgMa6CkD?=
 =?us-ascii?Q?ufgCMO2fBYNua5orkWnsEXr5LUKmbm/xHjMqaKpZr/z+U7Gsgg1k5j4iD+hs?=
 =?us-ascii?Q?TOR5eNyKaee39PaalLZytdp67HwpvssP0ULr5dMzepSRpomDxRZ9DoAP7VFf?=
 =?us-ascii?Q?EfWv+JTi3pxEdvvDDC/cSlUP2FWj1tnTFtUlkN0DtSqyuJigbQrlCcuy+1QB?=
 =?us-ascii?Q?4TOAJMA21023uh8Shp9p/ICUDQ52f/ltGGWePDYpEM5t93oZhZXBgFgknXRE?=
 =?us-ascii?Q?Rt0pr5J9F7YxkMdaYXQ63EIKjWI0+0K74wIyWpC5oikgnBYTFc4EbVYkmcJj?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82fac8b-26e2-48dc-f819-08dc1039da3f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:24.2095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5nnYOdzh2gYmQwjpePYctWvdQyS3l1eSv2osTM3h6gGkx6ArfiEPY/OCZoavuIFPmsFUtYKzT2I/9PCXyizjz66sEpBmYQgDcgIu3cSYo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0701

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


