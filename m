Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE513A229
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 08:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgANHcE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 02:32:04 -0500
Received: from lucky1.263xmail.com ([211.157.147.130]:32798 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgANHcE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 02:32:04 -0500
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 124AC7CF0C;
        Tue, 14 Jan 2020 15:24:42 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5437T140292994864896S1578986620990337_;
        Tue, 14 Jan 2020 15:24:42 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f25456ee66a8a74a07826691950c75a3>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, William Wu <william.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/6] dt-bindings: rockchip: Add DesignWare based PCIe controller
Date:   Tue, 14 Jan 2020 15:22:58 +0800
Message-Id: <1578986580-71974-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
References: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Simon Xue <xxm@rock-chips.com>

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  | 132 +++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
new file mode 100644
index 0000000..c5205f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DesignWare based PCIe RC controller on Rockchip SoCs
+
+maintainers:
+        - Shawn Lin <shawn.lin@rock-chips.com>
+        - Simon Xue <xxm@rock-chips.com>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk1808-pcie
+      - snps,dw-pcie
+
+  reg:
+    maxItems: 2
+
+  clocks:
+    items:
+      - description: High speed clock for PCIe
+      - description: Low speed clock for PCIe
+      - description: AHB clock for PCIe
+      - description: APB clock for PCIe
+      - description: Auxiliary clock for PCIe
+
+  clock-names:
+    items:
+      - const: hsclk
+      - const: lsclk
+      - const: aclk
+      - const: pclk
+      - const: sclk-aux
+
+  resets:
+    items:
+      - description: PCIe niu high reset line
+      - description: PCIe niu low reset line
+      - description: PCIe grf reset line
+      - description: PCIe control reset line
+      - description: PCIe control powerup reset line
+      - description: PCIe control master reset line
+      - description: PCIe control slave reset line
+      - description: PCIe control dbi reset line
+      - description: PCIe control button reset line
+      - description: PCIe control power engine reset line
+      - description: PCIe control core reset line
+      - description: PCIe control non-sticky reset line
+      - description: PCIe control sticky reset line
+      - description: PCIe control power reset line
+      - description: PCIe niu ahb reset line
+      - description: PCIe niu apb reset line
+
+  reset-names:
+    items:
+      - const: niu-h
+      - const: niu-l
+      - const: grf-p
+      - const: ctl-p
+      - const: ctl-powerup
+      - const: ctl-mst-a
+      - const: ctl-slv-a
+      - const: ctl-dbi-a
+      - const: ctl-button
+      - const: ctl-pe
+      - const: ctl-core
+      - const: ctl-nsticky
+      - const: ctl-sticky
+      - const: ctl-pwr
+      - const: ctl-niu-a
+      - const: ctl-niu-p
+
+  rockchip,usbpciegrf:
+    items:
+      - description: The grf for COMBPHY configuration and state registers.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - msi-map
+  - num-lanes
+  - phys
+  - phy-names
+  - resets
+  - reset-names
+  - rockchip,usbpciegrf
+
+additionalProperties: false
+
+examples:
+  - |
+    usb_pcie_grf: syscon@fe040000 {
+        compatible = "rockchip,usb-pcie-grf", "syscon";
+        reg = <0x0 0xfe040000 0x0 0x1000>;
+    };
+
+    pcie0: pcie@fc400000 {
+        compatible = "rockchip,rk1808-pcie", "snps,dw-pcie";
+        reg = <0x0 0xfc000000 0x0 0x400000>,
+              <0x0 0xfc400000 0x0 0x10000>;
+        clocks = <&cru HSCLK_PCIE>, <&cru LSCLK_PCIE>,
+                 <&cru ACLK_PCIE>, <&cru PCLK_PCIE>,
+                 <&cru SCLK_PCIE_AUX>;
+        clock-names = "hsclk", "lsclk",
+                      "aclk", "pclk",
+                      "sclk-aux";
+        msi-map = <0x0 &its 0x0 0x1000>;
+        num-lanes = <2>;
+        phys = <&combphy PHY_TYPE_PCIE>;
+        phy-names = "pcie-phy";
+        resets = <&cru SRST_PCIE_NIU_H>, <&cru SRST_PCIE_NIU_L>,
+                 <&cru SRST_PCIEGRF_P>, <&cru SRST_PCIECTL_P>,
+                 <&cru SRST_PCIECTL_POWERUP>, <&cru SRST_PCIECTL_MST_A>,
+                 <&cru SRST_PCIECTL_SLV_A>, <&cru SRST_PCIECTL_DBI_A>,
+                 <&cru SRST_PCIECTL_BUTTON>, <&cru SRST_PCIECTL_PE>,
+                 <&cru SRST_PCIECTL_CORE>, <&cru SRST_PCIECTL_NSTICKY>,
+                 <&cru SRST_PCIECTL_STICKY>, <&cru SRST_PCIECTL_PWR>,
+                 <&cru SRST_PCIE_NIU_A>, <&cru SRST_PCIE_NIU_P>;
+        reset-names = "niu-h", "niu-l", "grf-p", "ctl-p",
+                      "ctl-powerup", "ctl-mst-a", "ctl-slv-a",
+                      "ctl-dbi-a", "ctl-button", "ctl-pe",
+                      "ctl-core", "ctl-nsticky", "ctl-sticky",
+                      "ctl-pwr", "ctl-niu-a", "ctl-niu-p";
+        rockchip,usbpciegrf = <&usb_pcie_grf>;
+    };
+
+...
-- 
1.9.1



