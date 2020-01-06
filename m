Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76301131062
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 11:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgAFKTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 05:19:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46448 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAFKTM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 05:19:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006AIxOs108404;
        Mon, 6 Jan 2020 04:18:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578305939;
        bh=tdMkbn3osxZCAoJDuuw76Xdz9TI9EVK5gZFc5dtx1VY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tnCKUMjzgPOEiC0Ge0PITCE9W6TvLWDPdwljkuY2n9oLWaq598WscEAbLLKxv6Qjz
         PGsuX0ti/z1n/r8oMSPt2IOO6K9BmQUbjOdemDPqYswpD6KYAeaTiyJz1wx37CZ0PM
         f246xNW8R1MdeZfYRGvpAoCDDNL4kZMZzx1NAZSM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 006AIxU2130685
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 04:18:59 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 04:18:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 04:18:59 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006AIqXr118652;
        Mon, 6 Jan 2020 04:18:56 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 01/14] dt-bindings: PCI: cadence: Add PCIe RC/EP DT schema for Cadence PCIe
Date:   Mon, 6 Jan 2020 15:50:45 +0530
Message-ID: <20200106102058.19183-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106102058.19183-1-kishon@ti.com>
References: <20200106102058.19183-1-kishon@ti.com>
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
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 20 ++++++++++++
 .../bindings/pci/cdns-pcie-host.yaml          | 30 +++++++++++++++++
 .../devicetree/bindings/pci/cdns-pcie.yaml    | 32 +++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
new file mode 100644
index 000000000000..36aaae5931c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+--
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
index 000000000000..78261bc4f0c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
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
+  vendor-id:
+    description: The PCI vendor ID (16 bits, default is design dependent)
+
+  device-id:
+    description: The PCI device ID (16 bits, default is design dependent)
+
+  cdns,no-bar-match-nbits:
+    description: Set into the no BAR match register to configure the number
+      of least significant bits kept during inbound (PCIe -> AXI) address
+      translations (default 32)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
new file mode 100644
index 000000000000..497d3dc2e6f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
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
+    minimum: 1
+    maximum: 3
+
+  num-lanes:
+    minimum: 1
+    maximum: 2
+
+  cdns,max-outbound-regions:
+    description: Set to maximum number of outbound regions.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  phys:
+    description: List of Generic PHY phandles. One per lane if more than one in
+      the list. If only one PHY listed it must manage all lanes.
+
+  phy-names:
+    description: List of names to identify the PHY.
-- 
2.17.1

