Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6247E29ED4B
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 14:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgJ2NnA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 09:43:00 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38058 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgJ2Nme (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 09:42:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201029134041euoutp025ade940b29e90200cc5420f39dc7bc33~CekITwAke1391313913euoutp029
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 13:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201029134041euoutp025ade940b29e90200cc5420f39dc7bc33~CekITwAke1391313913euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603978841;
        bh=5LWk+rJhbViO9l0AuP2OfsCbsmcQL6wtHWsnyEYFN8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUoA1PaIgM8ut7ybKGlQ6OnAXZUIheMtBRQyapnXPk0WokZybHxAcnOzsyForiAS2
         TEB9Xjt7Q/sjq9VcnaSHKC23RpGAIHcjk3Qx+Rj+os1yUSBd/FJ4lf/ofH2o3JwPCk
         hSolcEXegF7VSYoeCAkVEocKC5tHyJBk4oH5fMwk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201029134039eucas1p1a717cfe00759ba1c2cf67d17f9feb5a7~CekGRenc83127831278eucas1p1G;
        Thu, 29 Oct 2020 13:40:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3F.D1.06456.756CA9F5; Thu, 29
        Oct 2020 13:40:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201029134038eucas1p2d550a45ff3222ccb72d15d5c89d4f938~CekF4bxxM0841008410eucas1p2Y;
        Thu, 29 Oct 2020 13:40:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201029134038eusmtrp1a3d9d615288a64e6127794c76b238423~CekF3gOA51072510725eusmtrp1e;
        Thu, 29 Oct 2020 13:40:38 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-2e-5f9ac6572a19
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7B.90.06314.656CA9F5; Thu, 29
        Oct 2020 13:40:38 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201029134038eusmtip15a5b0613dfd3b26193055bc341ac57df~CekFSABis1565515655eusmtip1u;
        Thu, 29 Oct 2020 13:40:38 +0000 (GMT)
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
Subject: [PATCH v3 3/6] dt-bindings: phy: add the samsung,exynos-pcie-phy
 binding
Date:   Thu, 29 Oct 2020 14:40:14 +0100
Message-Id: <20201029134017.27400-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029134017.27400-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSbUhTYRjl9W733kmT1yn4YpKxSChKXYVdysRC4hYUgj+iItfSi442lc1Z
        SpApaS4TP7B02pyfE5tf8yNnoTXFGeIHWmg4JSHLylk4LVuQeb1q/845z3nec3h4SUxk4PuS
        8oRkRpUgU4hxd17nwO/Rw5cGdNLg7CUPqiYjnqroH+FTU64sPlW/UkpQY/O5ODU62kJQE93l
        ODWst+FUyWiPG7X4Z4GgGvtnCGr9ZRdBWeyDWLiQNulNgLboZgjaYNbQ5oYcnM5rbwC0beq5
        G+0074kkrriHxjIKeQqjCgq77h5fPesgkpzwtv2TnpcOPgq1QEAieAxZWnU8LXAnRbAeoHtl
        NQRHVgBa6i3kc8QJkH3dQGyv1L+o2sQiaAQos+PqzkZB9U8+O8ChBGkdWlwLSNIbhqO1VYr1
        YLACQwWz026sxwtGoYd9FTiLeXA/Guzr5bF+ITyFKuelXJY/etbyCmNlAQxDAxli9hkE6wj0
        a9yEcZ4I1Fjn2MJe6KutfaunHxoqyuVxC5kAzY00EhzJBWgiowRwrpPIPuLaLIrBA6i5O4iT
        T6PhGiPBygh6oCmHJytjG7Cw8wnGyUL0IEvEuQOQzta0E/t6bHyrDo16lt9j3HkKADKnN+L5
        wF/3P8wAQAPwYTRqZRyjliQwtwLVMqVakxAXGJOoNIONfzP017bcBVbHb1gBJIF4l3BsulQq
        4stS1KlKK0AkJvYWnhkeihYJY2WpaYwqUarSKBi1FewmeWIf4dGqL9dEME6WzNxkmCRGtT11
        IwW+6aDNc7iptsMQMmesfFcU01RutTqy+9/mTOwtrnWSeeLPi1l6uf3Ij7T5p/vou6sxydXR
        +ZczSyeDv0fpH9Wdqw23AL8lPFRz3lH8wWVqs1wIbi0LiPhW2mWE99dSL06GKMQpEkP+WV3z
        Y8EdWefCm4Xj44em8k5EVk1WN7uKyuRinjpeJjmIqdSyf4UEwzQzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4Xd2wY7PiDZa/NbJY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdYu2Ru+wW//fsYLfY
        eecEswOvx5p5axg9ds66y+6xYFOpx6ZVnWwefVtWMXocv7GdyePzJrkA9ig9m6L80pJUhYz8
        4hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jMX33rIXfBaouPNsHksD
        4xPeLkZODgkBE4kVuxexdzFycQgJLGWUeLvpPytEQkbi5LQGKFtY4s+1LjYQW0jgE6PEu2NC
        IDabgKFE11uIuIiAk8T7yReZQWxmgZXMEge35YHYwgKBEnM/LGIBsVkEVCVOHN4PZHNw8ArY
        Six8Gg8xXl5i9YYDzCBhTgE7iWNNShCbbCX2nXrFPIGRbwEjwypGkdTS4tz03GJDveLE3OLS
        vHS95PzcTYzA0N927OfmHYyXNgYfYhTgYFTi4b1we2a8EGtiWXFl7iFGCQ5mJRFep7On44R4
        UxIrq1KL8uOLSnNSiw8xmgKdNJFZSjQ5HxiXeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNIT
        S1KzU1MLUotg+pg4OKUaGIv63vgpLeSKvZt+xPau61q5XZE6n+cv22fpd+BV8PGi1VEv/dyv
        O+k/Mg6+4ZVnkWIjdJKluob/U1V3s+7P7m8q5mnz7vJ/euLw1uWf1qQnTTV7/2/KcHxnEmHd
        3f/b8YTOobTKFy9N17LuLZRT8ds15dLWmncMDCbntSJuVN9amPov6eLHKiWW4oxEQy3mouJE
        AOhvhbeTAgAA
X-CMS-MailID: 20201029134038eucas1p2d550a45ff3222ccb72d15d5c89d4f938
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201029134038eucas1p2d550a45ff3222ccb72d15d5c89d4f938
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201029134038eucas1p2d550a45ff3222ccb72d15d5c89d4f938
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
        <CGME20201029134038eucas1p2d550a45ff3222ccb72d15d5c89d4f938@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dt-bindings for the Samsung Exynos PCIe PHY controller (Exynos5433
variant). Based on the text dt-binding posted by Jaehoon Chung.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/phy/samsung,exynos-pcie-phy.yaml | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
new file mode 100644
index 000000000000..ac0af40be52d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/samsung,exynos-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC series PCIe PHY Device Tree Bindings
+
+maintainers:
+  - Marek Szyprowski <m.szyprowski@samsung.com>
+  - Jaehoon Chung <jh80.chung@samsung.com>
+
+properties:
+  "#phy-cells":
+    const: 0
+
+  compatible:
+    const: samsung,exynos5433-pcie-phy
+
+  reg:
+    maxItems: 1
+
+  samsung,pmu-syscon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: phandle for PMU system controller interface, used to
+                 control PMU registers bits for PCIe PHY
+
+  samsung,fsys-sysreg:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: phandle for FSYS sysreg interface, used to control
+                 sysreg registers bits for PCIe PHY
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - samsung,pmu-syscon
+  - samsung,fsys-sysreg
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie_phy: pcie-phy@15680000 {
+        compatible = "samsung,exynos5433-pcie-phy";
+        reg = <0x15680000 0x1000>;
+        samsung,pmu-syscon = <&pmu_system_controller>;
+        samsung,fsys-sysreg = <&syscon_fsys>;
+        #phy-cells = <0>;
+    };
+...
-- 
2.17.1

