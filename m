Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21616A6C4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 14:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBXNFh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 08:05:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37154 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgBXNFg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 08:05:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01OD5TlU028516;
        Mon, 24 Feb 2020 07:05:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582549529;
        bh=xlTj5Eoo+dnxuDQBH/Zzbst/1LhqXOBfjtdjvvUVBYg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SlVAJ44aJX4zGX6jNruCSeKIVSOji/pgCY+WaRqBjRka7udmrsiLHlyrco8tuTNUH
         hYJey/fOFIzFxQn3muqugDyspcYpP3rCpxNdyP2WbCakKMXSgOa5oo1v53n8sQGGVM
         gpZDorHBCgOpAXEOVWBfz4RmRFaDC8K4CzMbm+JU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01OD5TJc109434;
        Mon, 24 Feb 2020 07:05:29 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 07:05:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 07:05:28 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01OD5M7O017839;
        Mon, 24 Feb 2020 07:05:26 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 1/4] dt-bindings: PCI: Add PCI Endpoint Controller Schema
Date:   Mon, 24 Feb 2020 18:39:02 +0530
Message-ID: <20200224130905.952-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224130905.952-1-kishon@ti.com>
References: <20200224130905.952-1-kishon@ti.com>
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
index 000000000000..2287771a066a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL2.0-only OR BSD-2-Clause)
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
+    pattern: "^pcie-ep?@"
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

