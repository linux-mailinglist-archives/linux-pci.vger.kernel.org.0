Return-Path: <linux-pci+bounces-2661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85083FB7E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 497E7B21239
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 00:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F529DDB3;
	Mon, 29 Jan 2024 00:59:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2074.outbound.protection.partner.outlook.cn [139.219.146.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F0F944F;
	Mon, 29 Jan 2024 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706489963; cv=fail; b=MTPhtwJ3K9bdbj/E8XAQsC5pVTQDdGYAm7n28ulQS4aI4dOxET9+8zkOCoohU0u1gmuMXatzeOgNJRaq9+2jNKvBVjHN85u9hraw2lUz0oMyW3E/VQ2a3HUwDASRb4QMJoYRBjBhBmUBWRcee1Sh9ycC8yx6WhUIh5pek+anj+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706489963; c=relaxed/simple;
	bh=153z9nphCTtjtmLY0yRQaHO9ivj+TovGeZp8rlL4AZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T51SsKKbOwua7pVS5K0FcR5zv4Ge5OLNxFTJ/wl0AF52dXa49JWVZ0WR42Tx4AxxpeuS6nRd3BgN2Pa1bpNH4rrZnSLAoo2oerYO4ub9h9fFocZOrp4y4Pg6LabBdfv5EQjdMLkZRp5hScF6ttJbGxzJait4KPXORIWZmp3rsDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXT9Yy5JeM7kuE32uNBanMBy2aPgWBfuzZWMVeqAy0Rps8L8CpvmQVE2fj3o6TxkPgPoa2HdNIX3JKBIBhCxB05SKDMa8g0WazjBpnuqPvjQeACeVIvXaae5NN97X9TrqVQoeKWsHZdaDTAsPFRZHhn9uU/Tquosmx1Ydz12XrnlnECkcpE1qdFjqK2RbcLTD6ZBRkl2ygPH5FtuX/aa3wxZmqSJQLCXcHVNO6ZAn9KXOTcirpnuF7C1aGNWENQklOcycpGHCq6ec9Ia4CKw2EOSBgWsRa4ztbOjxEBBr/zn/mzvLLBWVu4Ij6dWYlJSNkXe2p7ltkXf0b9k2fesiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7UZdmdyYz24tezUgGACcYCmJKOSO6Q04qEPwmoKWvY=;
 b=MBsYGoRO9KX0ebyIZ+Au6AvXvEvnzFKjFusZlTVoxYb61itBLpQsZLTuDLvoHwU2+tMCmckXyL77jk0zO67qLf020SEDp7qwf3UZc7aADfCMhwHUgeRwg5EBs748cbKPS9gP6/nH/buYnIVMPAe+vbltDYkd3xWurEhfgon9BK5UNBC9biUjVKsuc09kcVVAo0aMMGiphtrRDLafvMXBYYAQVJpczNaLOHqD/0opbdDH7sqaVpzoYEUZNyg78fpKqfLX4INGPUwcnDrVb+ndXOe7ea7R1w1ASPWZsg/c5oA/rq0z4UAv/5pm+qNw9Z/sv6pGtm40B/0jtttdYcIDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0630.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 00:59:05 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 00:59:05 +0000
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
Subject: [PATCH v14,RESEND 01/22] dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
Date: Mon, 29 Jan 2024 08:58:54 +0800
Message-Id: <20240129005854.3554-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129005854.3554-1-minda.chen@starfivetech.com>
References: <20240129005854.3554-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0630:EE_
X-MS-Office365-Filtering-Correlation-Id: e44324e6-6ae8-45c3-d1b6-08dc20657dd7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NXU8MG2yF1afcvI7R+rHgU33tw2+zHVRt4qSnBrHqaSOBV2i1og2/rO6nHgFb6mnMHgKLz3af9jzWpBdyT2BDuUQZlD4fRAVhUlfnioVzvgOHjJ73MmDUrp57e6Yuj5seqMv1ljU8dT4/+9V5VVqPcX9e1Hab0UgqjtV6bDHj8xkvRsdPm+yE/o2zIJAbvUGGfO0Z4jHWzmWsGVhQsr5p6DLrHvpiSthFd0GpMCcbb65MI99Wc9IAHgT0m7wyw6LHoNHzJOW3Bv/h88AGj8rT8rkJhZ3NuF5XQGxO4fi+Ztz4U/eTylLxiPGSlHAuvNs7onP6o4JwSQBZxvi3g1JtzLq1WnmYKXxxKe2JY587H0C8ReBChxWO5m6tjzRr84pBCHn2mC0RD1DWyFPlu7G0AJIsvnxb9PyG0GzyMzQLD2Awqk+bnQPBfLUKJgDm0T62lU6hBfuDirkLKexgDb1ieenPjbEOHMDiycSyPgvbWOgzCmaKWCZ9YKqyNbulUk0FQHbhatS7y9LTtTOdOmP1ptQkQvmUZSYCaseYvXQhUOn3hcL3fwHX5mOEWZrnlUV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(41320700001)(40180700001)(86362001)(40160700002)(36756003)(38350700005)(1076003)(38100700002)(2616005)(26005)(107886003)(966005)(2906002)(52116002)(508600001)(6666004)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(8936002)(4326008)(44832011)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FWBkwTFh5av1f7b2+Vc0Jp9kVM0TM61XGOg/4co21CdnVO+qugd9WJPwm/Lh?=
 =?us-ascii?Q?bcb33fnEtaEI+FHHl/VJ0b+5/iqDMT2rEbzctxH/MFgWGuMT8IAlPJT0+LH0?=
 =?us-ascii?Q?J0a+gxPdVmxtnXCg/xOOryPw0tfW16OmFisiXncNnpVXy99vgsRh28yRmmMo?=
 =?us-ascii?Q?T+R5zf9rcYqaJ3M15UD62bX8YEJksuT7k6knlvi9TT7e6Cc4srTgBZiET+tl?=
 =?us-ascii?Q?M7HY1gkK4Vf3UE636HbrO8/oKwNXgpx2xTWruLyE1tqk0o5Djk0yxmIHhS9x?=
 =?us-ascii?Q?XNfiLLPulQbOzbEXkMC0DWNSqaqaqStY8P6TpAxxMljjpn0XfCdsxEZ5bPrM?=
 =?us-ascii?Q?4+BqVt6cnneNsw8am9yw2VpLfatKiZliaYOLYYl+j5jFA5AwnwX804JQanq2?=
 =?us-ascii?Q?HZ/WFLjKzCW3O0j957k6arKXUk5Q9JPR9nj71gOz18Af+mBNQ5AOiK/htgnq?=
 =?us-ascii?Q?HxFNyltP6mAYTKreVhoLc/KmKnbbHz5SdtuxF43fsOWcRDoyIu7SPZnQPfEf?=
 =?us-ascii?Q?Rkp5RjT0SucSwWCJZYJVe/3qjLdCfvIaiIzhdnn4U6Dla8Ceqo0cR4uncO5V?=
 =?us-ascii?Q?CTQGyRsBhqy4MJrmE8iFFYt7D9YXGf8/YwCzl4p6A81Ob6RuBq8THYNg5uew?=
 =?us-ascii?Q?Oy/Z2qcU/Mn520ZiiLs4ymwbL8d8aodELKqLpdCPp2N+X+cKXfB4rAm3JvC5?=
 =?us-ascii?Q?l2jWVIHTzvjevCCAOKl4GXfqHE6VELxhM8couS2Y4ohHDvEMcW91EeiZj5wn?=
 =?us-ascii?Q?QpYI2XPFzX0gWaYM0MntrsHNWBkDS9WILHOqNAXdT4QJc/JdsOdb+zZyEocD?=
 =?us-ascii?Q?cfV9Bbwyiz5lIIvwCoS9zm1PBByKhYEhU69aVX7xtw2GgE5ZT3rvltpLsvCD?=
 =?us-ascii?Q?nUgQJVdro9wZBgmViQ/z0J52w9kQbJmrzb1vCb6fqhMU3ynbata6gs3X8Vyj?=
 =?us-ascii?Q?ZVgM9mhIIyxfgKmXFkSOwgaLANATuKJX7QApf9zl7jVJJ9YmwT+afuN1nwRF?=
 =?us-ascii?Q?7mdYpIGSedn5qADxidmmv8hmQ3RbZXE4hIWf3b1azBxMrJlep6CzY2zUKRQ0?=
 =?us-ascii?Q?wbbTGNPHje5pJ7+94Mw92cSfbKJIfvHK8j1MHJmcQwPFjNdVJFYuwyBfJvkL?=
 =?us-ascii?Q?2Ef5LU5M5RbfbmqMa+rp7domfDoJnM98FcGBVkLtf645X9VH2C88Bz86i4PC?=
 =?us-ascii?Q?MgfMwtBQyL15mEQSXUZ3zoHjcthxkYkdWeJ+sACoy5zudmBtboH9zE9Uta+I?=
 =?us-ascii?Q?waEWeNYWoqIysvD5QOZFNnQNTaxOJAFWkT8dB3PMbJWf7eOgBLhUEhlEEl1E?=
 =?us-ascii?Q?3ejl5xPKGd13hqscQ+zuw8nzDWMmk7LaZuixPRNNUF5eeAGbSDmfBXVLmd/W?=
 =?us-ascii?Q?ZI9ZzKXTmJ9TV/Atya/C6mPvrKA1nSN67KTK9u9489Va/y85F7p+oJTW9TmM?=
 =?us-ascii?Q?5HkvTZY6O7xu9TQ4GhoxpCs5wCHYpoFBQzXJ5gE1j79HhgmgG+L5R758oOwP?=
 =?us-ascii?Q?RtiDU5Iozoc1bQTV7Z3G4lv5hTMlYaFFyu1xEv7dGRD8WOZBXMZ4X1bryJuU?=
 =?us-ascii?Q?HcjyLlbgURBg396N2LaWmdDwjR+j/WIMeUHm7/+eO+yNwboSR9ysfKP7HJkj?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44324e6-6ae8-45c3-d1b6-08dc20657dd7
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 00:59:05.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6gGZOPBWmMhHQ+bJPbLya7wl9Ip9IHXhKBZDm+2RzorWWBfVCFXEMT+yJ3ueaYbbGz5RkvmszM68ozAoOny06vlOMNj38N1aUNfCldlI30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0630

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


