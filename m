Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C25157492
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 13:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgBJMbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 07:31:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59288 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgBJMbv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2020 07:31:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01ACVhkg018887;
        Mon, 10 Feb 2020 06:31:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581337903;
        bh=HKeSEpQoO/SGc5nk+DUofK5aOsYsEWsIlq8ACd32sQw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iVdDqKNTQtqDKVIVhvpqGDMP8/NwBM8TZoCscGmRzgSbRPPRvWzrNPN2ZKtiByN52
         zb6JG/Y0hmEjhfX3Bkjn2MPPeq0PEPaDwwZpC1VZ2cjDT6sDGi1m3EgUfjemXIElhX
         nKsE57yzTCGOv5bEIdi6su08/asq3rie1CLqn0JA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01ACVh2l112308;
        Mon, 10 Feb 2020 06:31:43 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 06:31:43 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 06:31:43 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01ACVaEY129098;
        Mon, 10 Feb 2020 06:31:40 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     Mark Rutland <mark.rutland@arm.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/2] dt-bindings: PCI: cadence: Add PCIe RC/EP DT schema for Cadence PCIe
Date:   Mon, 10 Feb 2020 18:05:06 +0530
Message-ID: <20200210123507.9491-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210123507.9491-1-kishon@ti.com>
References: <20200210123507.9491-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe Host (RC) and Endpoint (EP) device tree schema for Cadence
PCIe core library. Platforms using Cadence PCIe core can include the
schemas added here in the platform specific schemas.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 19 ++++++++
 .../bindings/pci/cdns-pcie-host.yaml          | 27 +++++++++++
 .../devicetree/bindings/pci/cdns-pcie.yaml    | 45 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
new file mode 100644
index 000000000000..b9b0b0a5cd88
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence PCIe Endpoint
+
+maintainers:
+  - Tom Joseph <tjoseph@cadence.com>
+
+allOf:
+  - $ref: "cdns-pcie.yaml#"
+
+properties:
+  max-functions:
+    description: Maximum number of functions that can be configured (default 1)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint8
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
new file mode 100644
index 000000000000..e05c1497ddec
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/cdns-pcie-host.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence PCIe Host
+
+maintainers:
+  - Tom Joseph <tjoseph@cadence.com>
+
+allOf:
+  - $ref: "/schemas/pci/pci-bus.yaml#"
+  - $ref: "cdns-pcie.yaml#"
+
+properties:
+  cdns,no-bar-match-nbits:
+    description:
+      Set into the no BAR match register to configure the number of least
+      significant bits kept during inbound (PCIe -> AXI) address translations
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 32
+    default: 32
+
+  msi-parent: true
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
new file mode 100644
index 000000000000..25c49d43f5cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/cdns-pcie.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence PCIe Core
+
+maintainers:
+  - Tom Joseph <tjoseph@cadence.com>
+
+properties:
+  max-link-speed:
+    description: maximum link speed
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 4
+
+  num-lanes:
+    description: maximum number of lanes
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 2
+
+  cdns,max-outbound-regions:
+    description: maximum number of outbound regions
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+    default: 32
+
+  phys:
+    description:
+      One per lane if more than one in the list. If only one PHY listed it must
+      manage all lanes.
+    minItems: 1
+    maxItems: 16
+
+  phy-names:
+    items:
+      - const: pcie-phy
+    # FIXME: names when more than 1
-- 
2.17.1

