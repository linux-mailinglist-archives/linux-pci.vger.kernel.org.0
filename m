Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723D029ED47
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 14:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgJ2Nm5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 09:42:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38311 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgJ2Nmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 09:42:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201029134049euoutp029bf07d1581b7d43f7422fb82b3ed269e~CekPehMO71391413914euoutp02F
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 13:40:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201029134049euoutp029bf07d1581b7d43f7422fb82b3ed269e~CekPehMO71391413914euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603978849;
        bh=TW2zV34il+4ssikQflYGXlUkM7Maf+DpRyVZ9mOsGDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AtJM75WvonyDC5eZ1EggLTuOKm7EzoCBSW2X9wzqSW0dGSxQLnnssgngiH5VLTThR
         SaR84NxLqRSSitd94OJ+gRbcyI7pQs/aWcuihJK0MK4jEoYS4ob1hjQF8XZ8tJ/ieN
         V4Wy62o7jfWSM4lhG8jAKcGAYVYbJ1c3DwQ5jSbs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201029134038eucas1p11288c6202ab7061cdc7f18420f7bc450~CekF5gFNs0836708367eucas1p1h;
        Thu, 29 Oct 2020 13:40:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3E.D1.06456.656CA9F5; Thu, 29
        Oct 2020 13:40:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201029134038eucas1p28d9bd33bc9e36b960b021a40ef299b47~CekFUx-EN0341003410eucas1p25;
        Thu, 29 Oct 2020 13:40:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201029134038eusmtrp2dbfe6b3133008dc4801b9b7fe1c2e2d7~CekFUCXGb0454004540eusmtrp2Y;
        Thu, 29 Oct 2020 13:40:38 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-2c-5f9ac6566949
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8C.91.06017.656CA9F5; Thu, 29
        Oct 2020 13:40:38 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201029134037eusmtip1898222eae6be92848e98563a1d0ab958~CekEvleht2175221752eusmtip18;
        Thu, 29 Oct 2020 13:40:37 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/6] dt-bindings: pci: add the samsung,exynos-pcie
 binding
Date:   Thu, 29 Oct 2020 14:40:13 +0100
Message-Id: <20201029134017.27400-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029134017.27400-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87phx2bFG5xrMLVY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdYu2Ru+wW//fsYLfY
        eecEswOvx5p5axg9ds66y+6xYFOpx6ZVnWwefVtWMXocv7GdyePzJrkA9igum5TUnMyy1CJ9
        uwSujHU/N7EU3JWrOPzkIVMD43bxLkYODgkBE4nnN9K6GLk4hARWMEosvL2FGcL5wiixs+0k
        lPOZUeJk8zLGLkZOsI4X9/4wQSSWM0q0zf6B0LLy9U8WkCo2AUOJrrddbCA7RAQcJH58tQCp
        YRaYzywx8d5tJpAaYQF/if+vT4DVswioShze0Qi2gVfAVuL4++NsENvkJVZvOMAMModTwE7i
        WJMSyBwJgWXsEgtvHoG6yEXi9aw+JghbWOLV8S3sELaMxP+d85kgGpoZJR6eW8sO4fQwSlxu
        mgHVbS1x59wvsEuZBTQl1u/Shwg7SsxYsZ8JEkh8EjfeCoKEmYHMSdumM0OEeSU62oQgqtUk
        Zh1fB7f24IVLzBC2h0TvJZAzQeEzkVHi19IbLBMY5WchLFvAyLiKUTy1tDg3PbXYMC+1XK84
        Mbe4NC9dLzk/dxMjMOGc/nf80w7Gr5eSDjEKcDAq8fBeuD0zXog1say4MvcQowQHs5IIr9PZ
        03FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MHZ/vvLx
        bi+7U5HHTXa9oxeEjh3QXlrfu7Lmn+k8nt/iq/ZwBsgKL5lpX7uvpYPnQ2yfvsnPINvWj6s2
        TTBpKwmL+essXOa9dsK3RecUp99Tcr1+UURU3bS2tmS5jrBMsm35n6vqrTuU//3nSJO8GmQ8
        R9tsy0KljSof709deeRvs7WQ3sGnLUosxRmJhlrMRcWJAMcqWog0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4Xd2wY7PiDd4f4rNY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdYu2Ru+wW//fsYLfY
        eecEswOvx5p5axg9ds66y+6xYFOpx6ZVnWwefVtWMXocv7GdyePzJrkA9ig9m6L80pJUhYz8
        4hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jHU/N7EU3JWrOPzkIVMD
        43bxLkZODgkBE4kX9/4wdTFycQgJLGWUWHP+AhtEQkbi5LQGVghbWOLPtS42iKJPjBL3O96B
        FbEJGEp0ve0Cs0UEnCTeT77IDGIzC6xklji4LQ/EFhbwlVg5cx5YDYuAqsThHY2MIDavgK3E
        8ffHoZbJS6zecACol4ODU8BO4liTEkhYCKhk36lXzBMY+RYwMqxiFEktLc5Nzy020itOzC0u
        zUvXS87P3cQIDP9tx35u2cHY9S74EKMAB6MSD++F2zPjhVgTy4orcw8xSnAwK4nwOp09HSfE
        m5JYWZValB9fVJqTWnyI0RToponMUqLJ+cDYzCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCe
        WJKanZpakFoE08fEwSnVwKidKGla+/PvP76WPz2Z5ZxZljZcU06c7lN1zC+/9KYrcN0251yF
        2kK9I0KhoSafbyTwn0q6tj+ifQer6eESnU1OBn2WYkeKFqW/eTiXRVvI4lean/RN7WNVzos1
        rz86WFA54eW3zY1vDP/Nbv+5u0/52CcL1uvB915cNnLl+/wuhWFbTsiCOUosxRmJhlrMRcWJ
        AEGWV86VAgAA
X-CMS-MailID: 20201029134038eucas1p28d9bd33bc9e36b960b021a40ef299b47
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201029134038eucas1p28d9bd33bc9e36b960b021a40ef299b47
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201029134038eucas1p28d9bd33bc9e36b960b021a40ef299b47
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
        <CGME20201029134038eucas1p28d9bd33bc9e36b960b021a40ef299b47@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
variant). Based on the text dt-binding posted by Jaehoon Chung.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/pci/samsung,exynos-pcie.yaml     | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
new file mode 100644
index 000000000000..1810bf722350
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/samsung,exynos-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC series PCIe Host Controller Device Tree Bindings
+
+maintainers:
+  - Marek Szyprowski <m.szyprowski@samsung.com>
+  - Jaehoon Chung <jh80.chung@samsung.com>
+
+description: |+
+  Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
+  PCIe IP and thus inherits all the common properties defined in
+  designware-pcie.txt.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: samsung,exynos5433-pcie
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers.
+      - description: External Local Bus interface (ELBI) registers.
+      - description: PCIe configuration space region.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: elbi
+      - const: config
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PCIe bridge clock
+      - description: PCIe bus clock
+
+  clock-names:
+    items:
+      - const: pcie
+      - const: pcie_bus
+
+  phys:
+    maxItems: 1
+
+  vdd10-supply:
+    description:
+      Phandle to a regulator that provides 1.0V power to the PCIe block.
+
+  vdd18-supply:
+    description:
+      Phandle to a regulator that provides 1.8V power to the PCIe block.
+
+  num-lanes:
+    const: 1
+
+  num-viewport:
+    const: 3
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - "#address-cells"
+  - "#size-cells"
+  - "#interrupt-cells"
+  - interrupt-map
+  - interrupt-map-mask
+  - ranges
+  - bus-range
+  - device_type
+  - num-lanes
+  - num-viewport
+  - clocks
+  - clock-names
+  - phys
+  - vdd10-supply
+  - vdd18-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/exynos5433.h>
+
+    pcie: pcie@15700000 {
+        compatible = "samsung,exynos5433-pcie";
+        reg = <0x15700000 0x1000>, <0x156b0000 0x1000>, <0x0c000000 0x1000>;
+        reg-names = "dbi", "elbi", "config";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        device_type = "pci";
+        interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cmu_fsys CLK_PCIE>, <&cmu_fsys CLK_PCLK_PCIE_PHY>;
+        clock-names = "pcie", "pcie_bus";
+        phys = <&pcie_phy>;
+        pinctrl-0 = <&pcie_bus &pcie_wlanen>;
+        pinctrl-names = "default";
+        num-lanes = <1>;
+        num-viewport = <3>;
+        bus-range = <0x00 0xff>;
+        ranges = <0x81000000 0 0	  0x0c001000 0 0x00010000>,
+                 <0x82000000 0 0x0c011000 0x0c011000 0 0x03feefff>;
+        vdd10-supply = <&ldo6_reg>;
+        vdd18-supply = <&ldo7_reg>;
+        interrupt-map-mask = <0 0 0 0>;
+        interrupt-map = <0 0 0 0 &gic GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
-- 
2.17.1

