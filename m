Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E15C15B956
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 07:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgBMGKJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 01:10:09 -0500
Received: from lucky1.263xmail.com ([211.157.147.130]:50792 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgBMGKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 01:10:08 -0500
Received: from localhost (unknown [192.168.167.8])
        by lucky1.263xmail.com (Postfix) with ESMTP id 7D4497F9EF;
        Thu, 13 Feb 2020 14:10:05 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P16450T140624477026048S1581574189162340_;
        Thu, 13 Feb 2020 14:10:05 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <512f38819e25d0463c2182f980fa4335>
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
Subject: [PATCH v2 1/6] dt-bindings: add binding for Rockchip combo phy using an Innosilicon IP
Date:   Thu, 13 Feb 2020 14:08:06 +0800
Message-Id: <1581574091-240890-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581574091-240890-1-git-send-email-shawn.lin@rock-chips.com>
References: <1581574091-240890-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This IP could supports USB3.0 and PCIe.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- fix yaml format

 .../bindings/phy/rockchip,inno-combophy.yaml       | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml
new file mode 100644
index 0000000..841f88a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,inno-combophy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip USB3.0/PCI-e combo phy
+
+maintainers:
+        - Shawn Lin <shawn.lin@rock-chips.com>
+        - William Wu <william.wu@rock-chips.com>
+
+properties:
+  "#phy-cells":
+    const: 1
+
+  compatible:
+    enum:
+      - rockchip,rk1808-combphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PLL reference clock
+
+  clock-names:
+    items:
+      - const: refclk
+
+  resets:
+    items:
+      - description: OTG unit reset line
+      - description: POR unit reset line
+      - description: APB interface reset line
+      - description: PIPE unit reset line
+
+  reset-names:
+    items:
+      - const: otg-rst
+      - const: combphy-por
+      - const: combphy-apb
+      - const: combphy-pipe
+
+  rockchip,combphygrf:
+    enum:
+      - rockchip,combphygrf
+    description: The grf for COMBPHY configuration and state registers.
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - rockchip,combphygrf
+
+additionalProperties: false
+
+examples:
+  - |
+    combphy: phy@ff380000 {
+        compatible = "rockchip,rk1808-combphy";
+        reg = <0x0 0xff380000 0x0 0x10000>;
+        #phy-cells = <1>;
+        clocks = <&cru SCLK_PCIEPHY_REF>;
+        clock-names = "refclk";
+        assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
+        assigned-clock-rates = <25000000>;
+        resets = <&cru SRST_USB3_OTG_A>, <&cru SRST_PCIEPHY_POR>,
+                 <&cru SRST_PCIEPHY_P>, <&cru SRST_PCIEPHY_PIPE>;
+        reset-names = "otg-rst", "combphy-por",
+                      "combphy-apb", "combphy-pipe";
+        rockchip,combphygrf = <&combphy_grf>;
+    };
+
+...
-- 
1.9.1



