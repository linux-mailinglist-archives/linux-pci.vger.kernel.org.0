Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C50BB17A310
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 11:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCEKZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Mar 2020 05:25:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38102 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCEKZ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2020 05:25:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 025APoSn079823;
        Thu, 5 Mar 2020 04:25:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583403950;
        bh=ZaLMbewo0jDd2UsQo+Q19S/MGyXATZ0zPdlLLmQCJxo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QTliI5PtRy5efKz9wzZ7B6nHlkFFUNK6VkPEhtLTZZdPZAk8hqWlkdqob5aA+wMaG
         aB/Lr+vkqvYjQuYiO23rEL2FCgnJdL2dqtDWmMF+2vIDJwXLJtq4rEjnowgVYmDnnp
         V4nd+u/rooc2+dRi5fhS/wRpLa48t381ke8XCYIc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 025APoI1116701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Mar 2020 04:25:50 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Mar
 2020 04:25:50 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Mar 2020 04:25:50 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 025APijE013418;
        Thu, 5 Mar 2020 04:25:47 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH v5 1/4] dt-bindings: PCI: Add PCI Endpoint Controller Schema
Date:   Thu, 5 Mar 2020 16:00:14 +0530
Message-ID: <20200305103017.16706-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200305103017.16706-1-kishon@ti.com>
References: <20200305103017.16706-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define a common schema for PCI Endpoint Controllers.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

