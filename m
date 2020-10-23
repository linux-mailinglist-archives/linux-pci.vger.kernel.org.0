Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97184296ACC
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S376084AbgJWH6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 03:58:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50089 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S376063AbgJWH6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 03:58:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201023075817euoutp01ae23f4bb604e19c9a37d3e681232be3a~AkBdh04qY2398623986euoutp014
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 07:58:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201023075817euoutp01ae23f4bb604e19c9a37d3e681232be3a~AkBdh04qY2398623986euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603439897;
        bh=yu3ycVamq1eQK2nU6FZh26OnGRNfltw70/A5VOyDFUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FzD0TPhsccVMH4yh7/tSPf6i1qFIxK9acGI9XoXzv0dHaXdwMR/+HLwo1haEPylR+
         YaAOMeOTJ54yuoMqK9vVZR3fKxBKmy5i7b1snFKwJ/lZsyCvG/lZb6upy/T/m6aXPG
         OOmlwruMfMwhoF//mO8LqsH/sxVfI47ZczBY8oNc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201023075755eucas1p10832ab6e304bdce6aaf6ab94f689b424~AkBJI0mia1157211572eucas1p1D;
        Fri, 23 Oct 2020 07:57:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A1.06.06318.30D829F5; Fri, 23
        Oct 2020 08:57:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201023075755eucas1p290b7bc020e46b86fe5e7591877f87117~AkBI0rf2G1362513625eucas1p2e;
        Fri, 23 Oct 2020 07:57:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201023075755eusmtrp1415790d2f125d52663c873b10e7965b1~AkBIz31eu0904209042eusmtrp1V;
        Fri, 23 Oct 2020 07:57:55 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-ae-5f928d036518
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.66.06314.30D829F5; Fri, 23
        Oct 2020 08:57:55 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201023075754eusmtip129d93281d53d67b165c9f767301e6758~AkBIQ-5nm2168021680eusmtip1O;
        Fri, 23 Oct 2020 07:57:54 +0000 (GMT)
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
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/6] dt-bindings: pci: add the samsung,exynos-pcie
 binding
Date:   Fri, 23 Oct 2020 09:57:40 +0200
Message-Id: <20201023075744.26200-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023075744.26200-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7rMvZPiDb4tkrVY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdYu2Ru+wWrXuPsFvs
        vHOC2YHXY828NYweO2fdZfdYsKnUY9OqTjaPvi2rGD2O39jO5PF5k1wAexSXTUpqTmZZapG+
        XQJXxutPk5gKrshWzO94xdjAeFGsi5GTQ0LAROL5wW6WLkYuDiGBFYwS/R8PsEE4XxglTjXP
        YYRwPjNKXL++HijDAdby/pI+RHw5o8SVPzDtQB0LdhxnApnLJmAo0fW2C6xBRMBB4sdXC5Aa
        ZoFFzBIN/UcYQWqEBfwlvh/fCmazCKhKPNvTCNbLK2Ar8eDmHTaI++QlVm84wAxicwrYSbxr
        uAd2kYTAOnaJW48/MUIUuUjseL+fCcIWlnh1fAs7hC0jcXpyDwtEQzOjxMNza9khnB5GictN
        M6C6rSXunPsFdiqzgKbE+l36EGFHiZ3N05kgXuaTuPFWECTMDGRO2jadGSLMK9HRJgRRrSYx
        6/g6uLUHL1xihrA9JC5snscCYgsJTGSUuH/QZAKj/CyEXQsYGVcxiqeWFuempxYb56WW6xUn
        5haX5qXrJefnbmIEJpzT/45/3cG470/SIUYBDkYlHt6ECRPjhVgTy4orcw8xSnAwK4nwOp09
        HSfEm5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QD4/ZXV5Yu
        /bK2spbrilbD1yceKocMJqv0/ZtcLOZ0zVP1woyrvCFh0WuCH8lFPzk2KdYm8hxHwVLZ6FXd
        tspWHyoZA1eaG3zO7VVzec9jWFKd3bb5oWkJX27NhHCTY5s8S37vWq3vf148ds2Cbw4vDqdM
        DHnocGbGuQv1x1xZvL6cW5W4s9L7qBJLcUaioRZzUXEiAHmOEOA0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4XV3m3knxBo3POC2WNGVYzD9yjtXi
        xq82VosVX2ayW1x42sNmcf78BnaLy7vmsFmcnXeczWLG+X1MFm9+v2C3WHvkLrtF694j7BY7
        75xgduD1WDNvDaPHzll32T0WbCr12LSqk82jb8sqRo/jN7YzeXzeJBfAHqVnU5RfWpKqkJFf
        XGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8frTJKaCK7IV8zteMTYw
        XhTrYuTgkBAwkXh/Sb+LkZNDSGApo8TOdzwgtoSAjMTJaQ2sELawxJ9rXWxdjFxANZ8YJXZ8
        m8cIkmATMJToeguS4OQQEXCSeD/5IjNIEbPAGmaJxrZuJpCEsICvxNkOiEksAqoSz/Y0gsV5
        BWwlHty8wwaxQV5i9YYDzCA2p4CdxLuGe4wQF9lKHD50lXkCI98CRoZVjCKppcW56bnFhnrF
        ibnFpXnpesn5uZsYgeG/7djPzTsYL20MPsQowMGoxMObMGFivBBrYllxZe4hRgkOZiURXqez
        p+OEeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0OR8Ym3kl8YamhuYWlobmxubGZhZK4rwdAgdj
        hATSE0tSs1NTC1KLYPqYODilGhgFqj+Y7brm9DBf59/0rDX9fx3MEksWq7Ct3bhhXWrDa8WO
        b88ORzplFgoVpr24tuPP+WVTHKo/f9+30PDykzrdzOkLnWs2NKb9rfnPG3qO6YBbNm9MP9OB
        +6viTp3oMtuVWe+asVOnQ9LlhvxJq2vGly6rZTV93LwlcvlJrY0rHs97fU7qhPk6JZbijERD
        Leai4kQAlwoljZUCAAA=
X-CMS-MailID: 20201023075755eucas1p290b7bc020e46b86fe5e7591877f87117
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201023075755eucas1p290b7bc020e46b86fe5e7591877f87117
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201023075755eucas1p290b7bc020e46b86fe5e7591877f87117
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
        <CGME20201023075755eucas1p290b7bc020e46b86fe5e7591877f87117@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
variant). Based on the text dt-binding posted by Jaehoon Chung.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../bindings/pci/samsung,exynos-pcie.yaml     | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
new file mode 100644
index 000000000000..6ddba0cb400e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
@@ -0,0 +1,114 @@
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

