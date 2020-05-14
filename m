Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C881D2F0F
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 14:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgENMD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 08:03:26 -0400
Received: from mx.socionext.com ([202.248.49.38]:18124 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgENMD0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 08:03:26 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 14 May 2020 21:03:24 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 6DC58180082;
        Thu, 14 May 2020 21:03:24 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 14 May 2020 21:03:24 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 26FF61A12B9;
        Thu, 14 May 2020 21:03:24 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: Add UniPhier PCIe endpoint controller description
Date:   Thu, 14 May 2020 21:03:20 +0900
Message-Id: <1589457801-12796-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589457801-12796-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1589457801-12796-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add DT bindings for PCIe controller implemented in UniPhier SoCs
when configured in endpoint mode. This controller is based on
the DesignWare PCIe core.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   | 92 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 +-
 2 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
new file mode 100644
index 0000000..f0558b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/socionext,uniphier-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier PCIe endpoint controller
+
+description: |
+  UniPhier PCIe endpoint controller is based on the Synopsys DesignWare
+  PCI core. It shares common features with the PCIe DesignWare core and
+  inherits common properties defined in
+  Documentation/devicetree/bindings/pci/designware-pcie.txt.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+allOf:
+  - $ref: "pci-ep.yaml#"
+
+properties:
+  compatible:
+    const: socionext,uniphier-pro5-pcie-ep
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: link
+      - const: addr_space
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: gio
+      - const: link
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: gio
+      - const: link
+
+  num-ib-windows:
+    const: 16
+
+  num-ob-windows:
+    const: 16
+
+  num-lanes: true
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie-phy
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie_ep: pcie-ep@66000000 {
+        compatible = "socionext,uniphier-pro5-pcie-ep";
+        reg-names = "dbi", "dbi2", "link", "addr_space";
+        reg = <0x66000000 0x1000>, <0x66001000 0x1000>,
+              <0x66010000 0x10000>, <0x67000000 0x400000>;
+        clock-names = "gio", "link";
+        clocks = <&sys_clk 12>, <&sys_clk 24>;
+        reset-names = "gio", "link";
+        resets = <&sys_rst 12>, <&sys_rst 24>;
+        num-ib-windows = <16>;
+        num-ob-windows = <16>;
+        num-lanes = <4>;
+        phy-names = "pcie-phy";
+        phys = <&pcie_phy>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 92657a1..7f26748 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13211,7 +13211,7 @@ PCIE DRIVER FOR SOCIONEXT UNIPHIER
 M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/uniphier-pcie.txt
+F:	Documentation/devicetree/bindings/pci/uniphier-pcie*
 F:	drivers/pci/controller/dwc/pcie-uniphier.c
 
 PCIE DRIVER FOR ST SPEAR13XX
-- 
2.7.4

