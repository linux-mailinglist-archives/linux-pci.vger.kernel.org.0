Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0AD812A36C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2019 18:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfLXRcd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Dec 2019 12:32:33 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:35039 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfLXRcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Dec 2019 12:32:33 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 650CA240003;
        Tue, 24 Dec 2019 17:32:29 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 5/5] dt-bindings: Add AXG PCIE PHY bindings
Date:   Tue, 24 Dec 2019 18:39:42 +0100
Message-Id: <20191224173942.18160-6-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191224173942.18160-1-repk@triplefau.lt>
References: <20191224173942.18160-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add documentation for PCIE PHYs found in AXG SoCs.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 .../bindings/phy/amlogic,meson-axg-pcie.yaml  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
new file mode 100644
index 000000000000..c622a1b38ffc
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
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
+    enum:
+      - amlogic,axg-pcie-phy
+
+  reg:
+    maxItems: 1
+
+  aml,hhi-gpr:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: phy
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - aml,hhi-gpr
+  - resets
+  - reset-names
+  - "#phy-cells"
+
+examples:
+  - |
+    pcie_phy: pcie-phy@ff644000 {
+          compatible = "amlogic,axg-pcie-phy";
+          reg = <0x0 0xff644000 0x0 0x2000>;
+          aml,hhi-gpr = <&sysctrl>;
+          resets = <&reset RESET_PCIE_PHY>;
+          reset-names = "phy";
+          #phy-cells = <0>;
+    };
-- 
2.24.0

