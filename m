Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0795177343
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgCCJ7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 04:59:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34808 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgCCJ7N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 04:59:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0239x4aN006533;
        Tue, 3 Mar 2020 03:59:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583229544;
        bh=MxZ27lOgLNAm0+mFy5tBZ/tTAFiLY0RQufZRpnWgtfA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=d0FDxSTniB5bYOp+dhRVj1D9ONagHXiozz7kWdEdfzsn0wYaK3+mFh09rzYEVCRBH
         cdUcd9Um2XB0rI9D1dWlxZiikgb31sBwBt6qT7nFEoIRYOEcyqcgmt9UzKGIeERHQf
         j2Oz7CJDh1+m81FdeeLj74OCPB/BX+bZBpYV4G5w=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0239x43t053389
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Mar 2020 03:59:04 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 03:59:04 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 03:59:04 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 0239wtHm052895;
        Tue, 3 Mar 2020 03:59:01 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 2/4] dt-bindings: PCI: cadence: Add PCIe RC/EP DT schema for Cadence PCIe
Date:   Tue, 3 Mar 2020 15:33:25 +0530
Message-ID: <20200303100327.3603-3-kishon@ti.com>
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

Add PCIe Host (RC) and Endpoint (EP) device tree schema for Cadence
PCIe core library. Platforms using Cadence PCIe core can include the
schemas added here in the platform specific schemas.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/cdns-pcie-host.yaml          | 27 ++++++++++++++++
 .../devicetree/bindings/pci/cdns-pcie.yaml    | 31 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
new file mode 100644
index 000000000000..ab6e43b636ec
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
+    maximum: 64
+    default: 32
+
+  msi-parent: true
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
new file mode 100644
index 000000000000..6887ccc339cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
@@ -0,0 +1,31 @@
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

