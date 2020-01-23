Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919F714749D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 00:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgAWXWS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 18:22:18 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50161 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgAWXWS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 18:22:18 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 49160C0002;
        Thu, 23 Jan 2020 23:22:13 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v6 1/7] dt-bindings: Add AXG PCIE PHY bindings
Date:   Fri, 24 Jan 2020 00:29:37 +0100
Message-Id: <20200123232943.10229-2-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123232943.10229-1-repk@triplefau.lt>
References: <20200123232943.10229-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add documentation for PCIE PHYs found in AXG SoCs.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 .../bindings/phy/amlogic,meson-axg-pcie.yaml  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
new file mode 100644
index 000000000000..086478aec946
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/amlogic,meson-axg-pcie.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic AXG PCIE PHY
+
+maintainers:
+  - Remi Pommarel <repk@triplefau.lt>
+
+properties:
+  compatible:
+    const: amlogic,axg-pcie-phy
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: analog
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - phys
+  - phy-names
+  - resets
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
+    #include <dt-bindings/phy/phy.h>
+    pcie_phy: pcie-phy@ff644000 {
+          compatible = "amlogic,axg-pcie-phy";
+          reg = <0x0 0xff644000 0x0 0x1c>;
+          resets = <&reset RESET_PCIE_PHY>;
+          phys = <&mipi_analog_phy PHY_TYPE_PCIE>;
+          phy-names = "analog";
+          #phy-cells = <0>;
+    };
-- 
2.24.1

