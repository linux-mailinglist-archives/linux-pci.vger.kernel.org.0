Return-Path: <linux-pci+bounces-3672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CBA85963F
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490E91C219F2
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389C738389;
	Sun, 18 Feb 2024 10:30:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2129.outbound.protection.partner.outlook.cn [139.219.17.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53910374DD;
	Sun, 18 Feb 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252210; cv=fail; b=aLceJrSzR0iCHVDO/RjZjvj6aZhyJ+fYiZsZCaU3YqDGfC0iOvOtPB31kWlyWZVyWZdWaMatf2ZUqKAxyIZue8zH6HoQMI1ggZuHCHhSUADnqWVXjEX0mougltFTVdWoDvOyOeloCzyArT0WbgdzULYQYk4NQaGBq6DFM10+1+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252210; c=relaxed/simple;
	bh=153z9nphCTtjtmLY0yRQaHO9ivj+TovGeZp8rlL4AZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nT+5uyl0h2xNbhO/QWn4hgaVqfxYweoozhdxSHgDHFjqJvUKG82VGJ482cRw/aytdhsn2tFN7SGp2nUxfmqnl10qmc9k7MovxOnG5vCfH7clzzAlHLbxpuKc0zFQyAqEMeNWf58Unsb/6csONVCN2jxwpF8KIgjO5lzvjdWRLz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej7pjPbsqzuqTwj8XbekSN3ETlX4O/GNFg54N+JL+pgbCGHXxYLRT5dj8zFmB1f6ooQASwzNKgnG0oaqRD94Ba64EAzst4WHYHUrZVfAKDz+n+Qv5w1D2naDX/dMg/J9EeCcHRzbb6C6mXG8axIIEK1+HSzDrYcm4VQBTkxZlnXW9Q6Q01PMRuA/8adhqZ3Xio8GqHHh23izbkq/YxyA4NdeC+cSa/nBQnh1Gi3iy4Q2/6Lp9L3057ieepmkTbcN5mw3ph3UriVZ/FOjhltS1NhSha2jKxUmibxzCu85GcjsmQgKfuXnV7QBqFMY0+sx4x+8/Ft9aAWnIIOpq2Cc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7UZdmdyYz24tezUgGACcYCmJKOSO6Q04qEPwmoKWvY=;
 b=Ctyf8IdVWlTz4QXO21WPLuub6f1TJbAJm7ECo9RHHR2HCCFnwCvq7ZrUsvPDfrtZtWeZbiNQ7wn/uK8J8PCZe24OpQRvaACMX6fpm6pYopYB3Yj3nIrp+EmRDkgCTQrkO4PayuS+L9LSsU8z4vlOeeAhUVambw143vQ+DVPal/0tXkAg/jGxARjmv7BdFFbB7ZUj4DbnIbQl7bTjmzxX1sF0s2oEGANYIwDP5bXRRjOosrcnJVWtv5716hHP86leVDJ/g2bocWMAmM1VdQdiblYOjcotvkHHjQ2aMZJ72nX3/pnN/ckuZO86YXDNjq1S+YWZVOT2qcIN/ImNBUyZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:15:39 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:15:39 +0000
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
Subject: [PATCH v15 01/23] dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
Date: Sun, 18 Feb 2024 18:15:30 +0800
Message-Id: <20240218101530.113306-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240218101530.113306-1-minda.chen@starfivetech.com>
References: <20240218101530.113306-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::28) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: 256dc340-5454-488e-9396-08dc306a8e3c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m07vXg0GA6d+0RHOn43g1WrmmDmvUoSVwCPsw3J/rbCLu5gpSpbBiiOBLihaN3sJJxct8aPEeaDaUHLsny0km4kMQqkCgGbrA2ve7XnElB+yagCq1fnN+PJqpQDtLl4hcdExRdNi5gTC/iJ8kvzwu09iMyOxkrFsdxWXEzCP6tFOS/4KceUa0nM4hbkUCrCm9QvrJq7Y/xvbCOQyz3f0sB317zMV9kvaQshw7d6PgLKsQZLC6ssUOpQZb6PX/C3pmCNtk7uYevSMIlhxfOuyXl75m3Ns3pjtXCIgsRMMLVn6LDJxRnCr0simk/jpec8saXnwngPxjXi0MO0Qd1WZLiwc7dak/y2KLL7B7feTGQlcSTcL0I0nWg5o9CK6ull0gqH4G7D5j3LlkNKcf0aKA7Ixap9vED92AOlBG7rcs07iwRZebCxorL3YDsluu7ViYMibEqhOTdbtSr1aLLwBhzA3eVxgxW2F7oV+urroI+7HpKKQ4pc1LRScBtthJh0bJfnGd4pLifZsersaAny64vPV1O4pyKpmncKAEWO8zL2m+H2cf8MP+rvbDMj5EiKO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(966005)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qy25mHapg9j+crG0IE7fOG/0wFKiqF5ePEfK6saGu+Gz7dA5eTQT9pk+MFIf?=
 =?us-ascii?Q?A5AwGWs74XQI9EGjrgcWksF6Xjt5BgT+Ht7CTCLdxtSkyhgIPzs7B3CJEg2t?=
 =?us-ascii?Q?xRCMe7vbNdAUfsF8nsGRqam4IIWkwPC95vA9FzlYOc77tHl7V9PAWJou1d7f?=
 =?us-ascii?Q?CHErHqqCYj/znCrxONOwAkQye1JO0z6NiCi91zonDr+EsjM+i6gq4JbNl16O?=
 =?us-ascii?Q?H7ZZoPYZOCCf5bm8wCyR2+/kr15jSxYGiOPDzVz2bHh20u1zdoFvINYzt/In?=
 =?us-ascii?Q?I7RDLax4LV7G30/EH1EHryLE+VU+VBJLED/mZu7hvjs9P+JRpRcCPDKiGdI+?=
 =?us-ascii?Q?UKwgwTYw3Oun3xKggxFVEhC2amEFG1liGOgOAzkcT3Q5lXTNmNQgZce85tkr?=
 =?us-ascii?Q?yYEYIU/16VgsdTZ9Idbb5oto+awemyapU/cFGhStmQ8HunhppoakpucVpHd1?=
 =?us-ascii?Q?1NzozLAScN6qxZr0dyRviKwTqzcx2ZHkpKczG8OXfkpbvWQxrMR7izPYeb2M?=
 =?us-ascii?Q?TXi4lGcdXmQnY45KN9Phv5BG+WfuD4Z1Qx3J//Fg9/23hQuNz3eoLo/Dy1rh?=
 =?us-ascii?Q?foA7DqEPYJ3/rBvbh9+AURoQZziMzsgR0kOa5UltZPhNP/ZDu34/KcIcwiW7?=
 =?us-ascii?Q?fSsMnxrPv3QJ8yL/FBMujg+/KZXsfCmFlJ0GFrgK4AtIz85T52EpG7zt6bcU?=
 =?us-ascii?Q?FNxIgKQU5NYHOXNTV48mVsPrHFDtuXYqr/KETyF75cohXoKo7KtqJS22t/3w?=
 =?us-ascii?Q?ST9qQrMLEC/mouocS2dVE1WTVhMxGW/LHm5zwKSdpCXWtDCU7FTGkGVrn89X?=
 =?us-ascii?Q?QYpHDYqGE+cl6KbogGAEsyCWBwRHABazbpltqlLDfgqX1VPdfdakwkM+NBpE?=
 =?us-ascii?Q?N0V9lp2vi4zMfYQAFyIwu8r5zyVCxFlkkzZWz4k81fNqDXru/CNeJm2D2dLq?=
 =?us-ascii?Q?hfQN9pbWOi6rwWFBIu45oxMYX+CQvOCHj145GKLT2uTd6XYseSFPfDy15WGY?=
 =?us-ascii?Q?gSrEU8uREH8rFGJ2rNRTotJ3CoTY0nCZLzX9SpFsuCD6drwKNkwtAWKJv3pI?=
 =?us-ascii?Q?ohDvV+OYFvOYfXGVV5WIIPkoq19FnhZwuI0veinLB0kmQHWRuZ6VhQZJklGF?=
 =?us-ascii?Q?Nr+Fg+el13daDWDDmP4Ql0g2nxEL7QdutufKHgII6nfgtl1Q5DamZ+fq0b01?=
 =?us-ascii?Q?/V7lurM4NkNy5upP0/dQGGuG93l0uGWDv3yQ6TgqB2rzmReEvJys7E97EcRl?=
 =?us-ascii?Q?CgsBkY705l80ESkkH/1rXqi20qRPFjco8cYLi/TxCEz05gwcIftVAJWlSl8c?=
 =?us-ascii?Q?6A0F7IG5edEoJbyMsLJh3uy6vr+xwVjfBTLlsTgvBVIlResmc4kwm8xXnTEp?=
 =?us-ascii?Q?aPNb0+oyv15WO1G6+fd448CjISH/HuSyW0K3oAmsU3XdTvp8Bosz6VKkdsRD?=
 =?us-ascii?Q?TDHjqO6Ii0XeWQ6p1C4blEbaof0bE1EMF1HuhvS6neAApRwEcmnYlznuTVsB?=
 =?us-ascii?Q?M/q/efWxVVGY+e4ftzXq9qlilu+13BcOlgNLraA0tZKvKOy0GYuQtn1Zsnp6?=
 =?us-ascii?Q?EYv9iH1B1kZsiYqUJbI6j8w1xuQ4Smsprqts5P+6QtXtguz5TQThkr2mFpz8?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256dc340-5454-488e-9396-08dc306a8e3c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:15:39.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqeNtsqDqa5RzEhc9JWwKVhFGq23WfFGrEIqqUYK5ZrntCzPusWfiqdHpc/rO7zeBJhdmgQsKTaWlKbtRKUggWSU/bezLZJRwJb7y8WKMKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

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


