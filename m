Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847EF2F9D0E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 11:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbhARKpV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 05:45:21 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:49874 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388871AbhARJc1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2021 04:32:27 -0500
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 3DD38EFBB8;
        Mon, 18 Jan 2021 17:17:58 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13518T140326291363584S1610961461018109_;
        Mon, 18 Jan 2021 17:17:57 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <537c15aae69a0918012960324760c77f>
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
        Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 2/3] dt-bindings: rockchip: Add DesignWare based PCIe controller
Date:   Mon, 18 Jan 2021 17:17:38 +0800
Message-Id: <20210118091739.247040-2-xxm@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118091739.247040-1-xxm@rock-chips.com>
References: <20210118091739.247040-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
 .../bindings/pci/rockchip-dw-pcie.yaml        | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
new file mode 100644
index 000000000000..fa664cfffb29
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -0,0 +1,101 @@
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
+        const: rockchip,rk3568-pcie
+  required:
+    - compatible
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-pcie
+      - snps,dw-pcie
+
+  reg:
+    maxItems: 1
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
+  resets:
+    items:
+      - description: PCIe pipe reset line
+
+  reset-names:
+    items:
+      - const: pipe
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - bus-range
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - msi-map
+  - num-lanes
+  - phys
+  - phy-names
+  - ranges
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie3x2: pcie@fe280000 {
+      compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      bus-range = <0x20 0x2f>;
+      reg = <0x3 0xc0800000 0x0 0x400000>,
+            <0x0 0xfe280000 0x0 0x10000>;
+      reg-names = "pcie-dbi", "pcie-apb";
+      clocks = <&cru ACLK_PCIE30X2_MST>, <&cru ACLK_PCIE30X2_SLV>,
+               <&cru ACLK_PCIE30X2_DBI>, <&cru PCLK_PCIE30X2>,
+               <&cru CLK_PCIE30X2_AUX_NDFT>;
+      clock-names = "aclk_mst", "aclk_slv",
+                    "aclk_dbi", "pclk",
+                    "aux";
+      msi-map = <0x2000 &its 0x2000 0x1000>;
+      num-lanes = <2>;
+      phys = <&pcie30phy>;
+      phy-names = "pcie-phy";
+      ranges = <0x00000800 0x0 0x80000000 0x3 0x80000000 0x0 0x800000
+                0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000
+                0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;
+      resets = <&cru SRST_PCIE30X2_POWERUP>;
+      reset-names = "pipe";
+    };
+
+...
-- 
2.25.1



