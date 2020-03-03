Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1247B17733F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 10:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgCCJ7L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 04:59:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45866 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgCCJ7K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 04:59:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0239x2K6127170;
        Tue, 3 Mar 2020 03:59:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583229542;
        bh=heQYIx0Y4amXDf+G8q2EDpMoKTZGzevA7KM6NjQZS5E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bMTRY4L7JN8ftbsCm33Dwx/l6Oau9t4fLhdkqRYMSU2oEb3PdFIuMGY2hJcFnbm/S
         ZH2Q1hC69TuMO5bGUVuTqsyOHiy9eudZzVwqY4z92iRRwiYo8u8JsvW4vvVWqiElzr
         jWldwnaXfLsTGDYRWYDJnR695HFE5K973O43ijxY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0239x2su119359;
        Tue, 3 Mar 2020 03:59:02 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 03:59:01 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 03:59:01 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 0239wtHl052895;
        Tue, 3 Mar 2020 03:58:58 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 1/4] dt-bindings: PCI: Add PCI Endpoint Controller Schema
Date:   Tue, 3 Mar 2020 15:33:24 +0530
Message-ID: <20200303100327.3603-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303100327.3603-1-kishon@ti.com>
References: <20200303100327.3603-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define a common schema for PCI Endpoint Controllers.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/pci-ep.yaml       | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
new file mode 100644
index 000000000000..b3df100705b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/pci-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCI Endpoint Controller Schema
+
+description: |
+  Common properties for PCI Endpoint Controller Nodes.
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+properties:
+  $nodename:
+    pattern: "^pcie-ep@"
+
+  max-functions:
+    description: Maximum number of functions that can be configured
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint8
+    minimum: 1
+    default: 1
+    maximum: 255
+
+  max-link-speed:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 3, 4 ]
+
+  num-lanes:
+    description: maximum number of lanes
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    default: 1
+    maximum: 16
+
+required:
+  - compatible
-- 
2.17.1

