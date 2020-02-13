Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6988215B963
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 07:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgBMGLW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 01:11:22 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:39570 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgBMGLV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 01:11:21 -0500
Received: from localhost (unknown [192.168.167.8])
        by lucky1.263xmail.com (Postfix) with ESMTP id 58B3090639;
        Thu, 13 Feb 2020 14:11:03 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P16450T140624477026048S1581574189162340_;
        Thu, 13 Feb 2020 14:11:03 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <81ed3ea2d6edf4cc9ecba7013919ad5e>
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
Subject: [PATCH v2 4/6] dt-bindings: rockchip: Add DesignWare based PCIe controller
Date:   Thu, 13 Feb 2020 14:08:09 +0800
Message-Id: <1581574091-240890-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581574091-240890-1-git-send-email-shawn.lin@rock-chips.com>
References: <1581574091-240890-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Simon Xue <xxm@rock-chips.com>

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- fix yaml format

 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  | 148 +++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
new file mode 100644
index 0000000..527c770
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DesignWare based PCIe RC controller on Rockchip SoCs
+
+maintainers:
+  - Shawn Lin <shawn.lin@rock-chips.com>
+  - Simon Xue <xxm@rock-chips.com>
+
+# We need a select here so we don't match all nodes with 'snps,dw-pcie'
+select:
+  properties:
+    compatible:
+      contains:
+        const: rockchip,rk1808-pcie
+  required:
+    - compatible
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk1808-pcie
+      - snps,dw-pcie
+
+  reg:
+    maxItems: 1
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
+    enum:
+      - rockchip,usbpciegrf
+    description: The grf for COMBPHY configuration and state registers.
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - reg
+  - clocks
+  - clock-names
+  - msi-map
+  - num-lanes
+  - phys
+  - phy-names
+  - ranges
+  - resets
+  - reset-names
+  - rockchip,usbpciegrf
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie0: pcie@fc400000 {
+      compatible = "rockchip,rk1808-pcie", "snps,dw-pcie";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      bus-range = <0x0 0x1f>;
+      reg = <0x0 0xfc000000 0x0 0x400000>,
+            <0x0 0xfc400000 0x0 0x10000>;
+      clocks = <&cru HSCLK_PCIE>, <&cru LSCLK_PCIE>,
+               <&cru ACLK_PCIE>, <&cru PCLK_PCIE>,
+               <&cru SCLK_PCIE_AUX>;
+      clock-names = "hsclk", "lsclk",
+                    "aclk", "pclk",
+                    "sclk-aux";
+      msi-map = <0x0 &its 0x0 0x1000>;
+      num-lanes = <2>;
+      phys = <&combphy PHY_TYPE_PCIE>;
+      phy-names = "pcie-phy";
+      ranges = <0x00000800 0x0 0xf8000000 0x0 0xf8000000 0x0 0x800000
+                0x83000000 0x0 0xf8800000 0x0 0xf8800000 0x0 0x3700000
+                0x81000000 0x0 0xfbf00000 0x0 0xfbf00000 0x0 0x100000>;
+      resets = <&cru SRST_PCIE_NIU_H>, <&cru SRST_PCIE_NIU_L>,
+               <&cru SRST_PCIEGRF_P>, <&cru SRST_PCIECTL_P>,
+               <&cru SRST_PCIECTL_POWERUP>, <&cru SRST_PCIECTL_MST_A>,
+               <&cru SRST_PCIECTL_SLV_A>, <&cru SRST_PCIECTL_DBI_A>,
+               <&cru SRST_PCIECTL_BUTTON>, <&cru SRST_PCIECTL_PE>,
+               <&cru SRST_PCIECTL_CORE>, <&cru SRST_PCIECTL_NSTICKY>,
+               <&cru SRST_PCIECTL_STICKY>, <&cru SRST_PCIECTL_PWR>,
+               <&cru SRST_PCIE_NIU_A>, <&cru SRST_PCIE_NIU_P>;
+      reset-names = "niu-h", "niu-l", "grf-p", "ctl-p",
+                    "ctl-powerup", "ctl-mst-a", "ctl-slv-a",
+                    "ctl-dbi-a", "ctl-button", "ctl-pe",
+                    "ctl-core", "ctl-nsticky", "ctl-sticky",
+                    "ctl-pwr", "ctl-niu-a", "ctl-niu-p";
+      rockchip,usbpciegrf = <&usb_pcie_grf>;
+      reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
+    };
+
+...
-- 
1.9.1



