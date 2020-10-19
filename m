Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADD62924E6
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 11:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgJSJsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 05:48:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36083 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgJSJr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 05:47:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201019094740euoutp02ad14e8b7800a87fb55e62c9fe17ab19c~-W70Y2zR-2477424774euoutp02G
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 09:47:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201019094740euoutp02ad14e8b7800a87fb55e62c9fe17ab19c~-W70Y2zR-2477424774euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603100860;
        bh=NUD/kMhorY2ZU/vFtCFhNjU72GF4jb7DGDHi736Y7VI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8kSAZPtau0adqW/IKBxtQocB2aVBaQzorbzI9ErIKwx8jrACJyR1TvXcpdImRp2e
         FDzn0aWqXHlxYvIBXf0DP9TDvmRGLc7QzYKSFsWtmZuHGI+S+d32dzrFoFbFsHrokf
         B8lL2d0okW8ATvdJD9cg+Qms2loxD+3M0WHqwUpI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201019094739eucas1p21edb842767ce710580770cd14ae6d82b~-W70Ly78A1637916379eucas1p2k;
        Mon, 19 Oct 2020 09:47:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C7.F2.05997.BB06D8F5; Mon, 19
        Oct 2020 10:47:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201019094739eucas1p17424b1224bf2a1a5b16c33deb4209166~-W7z1h6hu1119011190eucas1p1z;
        Mon, 19 Oct 2020 09:47:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201019094739eusmtrp2c846c6038a0212e1146b40b7d71d2622~-W7z0xCmZ2609626096eusmtrp2M;
        Mon, 19 Oct 2020 09:47:39 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-46-5f8d60bb2632
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6C.CB.06017.BB06D8F5; Mon, 19
        Oct 2020 10:47:39 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201019094738eusmtip1e96bfe74092fba0cf6337e518f7c6b67~-W7zSoZiN1561015610eusmtip1g;
        Mon, 19 Oct 2020 09:47:38 +0000 (GMT)
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
Subject: [PATCH 3/6] Documetation: dt-bindings: add the
 samsung,exynos-pcie-phy binding
Date:   Mon, 19 Oct 2020 11:47:12 +0200
Message-Id: <20201019094715.15343-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019094715.15343-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7q7E3rjDTZ+MLRY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdYu2Ru+wWrXuPsFvs
        vHOC2YHXY828NYweO2fdZfdYsKnUY9OqTjaPvi2rGD2O39jO5PF5k1wAexSXTUpqTmZZapG+
        XQJXRtM3oYLzghXTzvYzNzAu4eti5OSQEDCRuL72DmsXIxeHkMAKRom7i+YyQzhfGCX6L92D
        ynxmlNjy7x0rTMvRp/OZQGwhgeWMEg9WW8J1zO3fxwaSYBMwlOh62wVkc3CICDhI/PhqAVLD
        LLCIWaKh/wgjSFxYIFLiz1JdEJNFQFVi3bc0EJNXwFZi8RwmiE3yEqs3HGAGsTkF7CS6Fi4D
        u01CYBm7xKr+m4wQRS4SW1+sYIGwhSVeHd/CDmHLSPzfCXImSEMzo8TDc2vZIZweRonLTTOg
        uq0l7pz7BXYns4CmxPpd+hBhR4mWF+vBzpQQ4JO48VYQJMwMZE7aNp0ZIswr0dEmBFGtJjHr
        +Dq4tQcvXIIq8ZDouykHCZyJjBJ9bzqYJjDKz0LYtYCRcRWjeGppcW56arFRXmq5XnFibnFp
        Xrpecn7uJkZgojn97/iXHYy7/iQdYhTgYFTi4X2Q3xMvxJpYVlyZe4hRgoNZSYTX6ezpOCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYeUt6Z/BqPLrg
        eNVn5TvtFWezeeuqvGsDVloZR+pX2Bz58Pqu5OcZE/Zk+01/qM++82XY4qQXPx/NeHb+W+WV
        DSkmXiJzDe39H9tvZHeLlRWaH/xnuUBzeM+MzWaPVt445F9vH9/B89ZeVav4LKv5kUzJfK1S
        49Sqgpv5c+M6NlYsP/vNMVlPiaU4I9FQi7moOBEAslznTTADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e/4Xd3dCb3xBjv/SFssacqwmH/kHKvF
        jV9trBYrvsxkt7jwtIfN4vz5DewWl3fNYbM4O+84m8WM8/uYLN78fsFusfbIXXaL1r1H2C12
        3jnB7MDrsWbeGkaPnbPusnss2FTqsWlVJ5tH35ZVjB7Hb2xn8vi8SS6APUrPpii/tCRVISO/
        uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo+mbUMF5wYppZ/uZGxiX
        8HUxcnJICJhIHH06n6mLkYtDSGApo8TGP5tZIRIyEienNUDZwhJ/rnWxQRR9YpT4e2E/WIJN
        wFCi6y1IgpNDRMBJ4v3ki8wgRcwCa5glGtu6mUASwgLhEjO+XgOyOThYBFQl1n1LAzF5BWwl
        Fs9hgpgvL7F6wwFmEJtTwE6ia+EyMFsIqKRr5TSWCYx8CxgZVjGKpJYW56bnFhvpFSfmFpfm
        pesl5+duYgQG/7ZjP7fsYOx6F3yIUYCDUYmH90F+T7wQa2JZcWXuIUYJDmYlEV6ns6fjhHhT
        EiurUovy44tKc1KLDzGaAp00kVlKNDkfGJl5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNL
        UrNTUwtSi2D6mDg4pRoYBbz0Hi16ZvK/68EzxbPuh/4U/J/decL6kUmzNNN2tyeSOct3nnh5
        tnfWxg/yV+xSdpyyPdLg9GdP9apmuVOsDl8rtk8p25QiHLgq8Wdw6PWPF263zVgmK+nfFfxH
        vtYh8voTz8zbW8VTXno2HNu9t39hi17ptvc8iw5tjnzWvHi5Xqdrc9w/HSWW4oxEQy3mouJE
        ALv+BHuUAgAA
X-CMS-MailID: 20201019094739eucas1p17424b1224bf2a1a5b16c33deb4209166
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201019094739eucas1p17424b1224bf2a1a5b16c33deb4209166
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201019094739eucas1p17424b1224bf2a1a5b16c33deb4209166
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
        <CGME20201019094739eucas1p17424b1224bf2a1a5b16c33deb4209166@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jaehoon Chung <jh80.chung@samsung.com>

Add dt-bindings for the Samsung Exynos PCIe PHY controller (Exynos5433
variant).

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
[mszyprow: updated the binding to latest driver changes, rewrote it in yaml,
	   rewrote commit message]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../bindings/phy/samsung,exynos-pcie-phy.yaml | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
new file mode 100644
index 000000000000..ce92d1e687e7
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
+  - Jaehoon Chung <jh80.chung@samsung.com>
+
+properties:
+  "#phy-cells":
+    const: 0
+
+  compatible:
+    enum:
+      - samsung,exynos5433-pcie-phy
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
\ No newline at end of file
-- 
2.17.1

