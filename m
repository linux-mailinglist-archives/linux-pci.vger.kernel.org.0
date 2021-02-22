Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3568E32114E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 08:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhBVHUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 02:20:15 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:53510 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBVHUO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Feb 2021 02:20:14 -0500
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 1D734F1028;
        Mon, 22 Feb 2021 15:17:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P19727T140184712640256S1613978252812915_;
        Mon, 22 Feb 2021 15:17:39 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5d5bcd03c53fb4ad8b8c23ba5f330cab>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: bhelgaas@google.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Simon Xue <xxm@rock-chips.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Simon Xue <xxm@rock-chips.com>
Subject: [PATCH v5 1/2] dt-bindings: rockchip: Add DesignWare based PCIe controller
Date:   Mon, 22 Feb 2021 15:17:21 +0800
Message-Id: <20210222071721.30062-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document DT bindings for PCIe controller found on Rockchip SoC.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
 .../bindings/pci/rockchip-dw-pcie.yaml        | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
new file mode 100644
index 000000000000..142bbe577763
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DesignWare based PCIe controller on Rockchip SoCs
+
+maintainers:
+  - Shawn Lin <shawn.lin@rock-chips.com>
+  - Simon Xue <xxm@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |+
+  RK3568 SoC PCIe host controller is based on the Synopsys DesignWare
+  PCIe IP and thus inherits all the common properties defined in
+  designware-pcie.txt.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+# We need a select here so we don't match all nodes with 'snps,dw-pcie'
+select:
+  properties:
+    compatible:
+      contains:
+        const: rockchip,rk3568-pcie
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: rockchip,rk3568-pcie
+      - const: snps,dw-pcie
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers
+      - description: Rockchip designed configuration registers
+      - description: Config registers
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: apb
+      - const: config
+
+  clocks:
+    items:
+      - description: AHB clock for PCIe master
+      - description: AHB clock for PCIe slave
+      - description: AHB clock for PCIe dbi
+      - description: APB clock for PCIe
+      - description: Auxiliary clock for PCIe
+
+  clock-names:
+    items:
+      - const: aclk_mst
+      - const: aclk_slv
+      - const: aclk_dbi
+      - const: pclk
+      - const: aux
+
+  msi-map: true
+
+  num-lanes: true
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie-phy
+
+  power-domains:
+    maxItems: 1
+
+  ranges:
+    maxItems: 2
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: pipe
+
+  vpcie3v3-supply: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - msi-map
+  - num-lanes
+  - phys
+  - phy-names
+  - power-domains
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie3x2: pcie@fe280000 {
+            compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
+            reg = <0x3 0xc0800000 0x0 0x390000>,
+                  <0x0 0xfe280000 0x0 0x10000>,
+                  <0x3 0x80000000 0x0 0x100000>;
+            reg-names = "dbi", "apb", "config";
+            bus-range = <0x20 0x2f>;
+            clocks = <&cru 143>, <&cru 144>,
+                     <&cru 145>, <&cru 146>,
+                     <&cru 147>;
+            clock-names = "aclk_mst", "aclk_slv",
+                          "aclk_dbi", "pclk",
+                          "aux";
+            device_type = "pci";
+            linux,pci-domain = <2>;
+            max-link-speed = <2>;
+            msi-map = <0x2000 &its 0x2000 0x1000>;
+            num-lanes = <2>;
+            phys = <&pcie30phy>;
+            phy-names = "pcie-phy";
+            power-domains = <&power 15>;
+            ranges = <0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000>,
+                     <0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;
+            resets = <&cru 193>;
+            reset-names = "pipe";
+            #address-cells = <3>;
+            #size-cells = <2>;
+        };
+    };
+...
-- 
2.25.1



