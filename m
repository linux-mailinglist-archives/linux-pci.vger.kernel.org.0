Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4EC13A22A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 08:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgANHcE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 02:32:04 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:43698 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANHcE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 02:32:04 -0500
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 8D27B4FFD1;
        Tue, 14 Jan 2020 15:23:49 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5437T140292994864896S1578986620990337_;
        Tue, 14 Jan 2020 15:23:49 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <1d751e9ebff3152f419725f97733107b>
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
Subject: [PATCH 1/6] dt-bindings: add binding for Rockchip combo phy using an Innosilicon IP
Date:   Tue, 14 Jan 2020 15:22:55 +0800
Message-Id: <1578986580-71974-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
References: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This IP could supports USB3.0 and PCIe.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 .../bindings/phy/rockchip,inno-combophy.yaml       | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml
new file mode 100644
index 0000000..d647ab3
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml
@@ -0,0 +1,84 @@
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
+    items:
+      - description: The grf for COMBPHY configuration and state registers.
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
+    combphy_grf: syscon@fe018000 {
+        compatible = "rockchip,usb3phy-grf", "syscon";
+        reg = <0x0 0xfe018000 0x0 0x8000>;
+    };
+
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



