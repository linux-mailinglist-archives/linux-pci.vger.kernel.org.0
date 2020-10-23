Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42823296AC8
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 09:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S376068AbgJWH6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 03:58:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46477 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S376064AbgJWH6b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 03:58:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201023075809euoutp0217fd1e327df52393e95774194b504d0a~AkBWQQ4731606416064euoutp026
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 07:58:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201023075809euoutp0217fd1e327df52393e95774194b504d0a~AkBWQQ4731606416064euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603439889;
        bh=ywnsJCTIgQsooUdOL5+DzQM6hP7ctxtIDMiGsiCyz4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9QbKjCgh5/oHcaZfJsoD7UziIRvoK4BWkvR54+9l2TtMVJwQSp2ozlpsfA/hHAIP
         W5BaS+O0TKPmIxCWb967rlBlydcsj6yd4CkMSyT/7OzBThMQjV3jrwE6AcreHW6uY2
         W3MH4tPSu4HGff8qSC8sHsBqYW0tu3O1IYStOqKQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201023075756eucas1p2adce0548be0a91f408d255f34714b81e~AkBJrZee61770417704eucas1p2D;
        Fri, 23 Oct 2020 07:57:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 44.88.05997.40D829F5; Fri, 23
        Oct 2020 08:57:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201023075755eucas1p165641c7528ea987a2e1d9d28198c0e9e~AkBJXeysg2493724937eucas1p1E;
        Fri, 23 Oct 2020 07:57:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201023075755eusmtrp271dc8ab8af570782ff4b1f05b0f022a4~AkBJW08GS2108721087eusmtrp2f;
        Fri, 23 Oct 2020 07:57:55 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-1b-5f928d04c2f9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 43.27.06017.30D829F5; Fri, 23
        Oct 2020 08:57:55 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201023075755eusmtip14bde6ebd65775f99333160d77c84fa45~AkBIzHAbg2378223782eusmtip1F;
        Fri, 23 Oct 2020 07:57:55 +0000 (GMT)
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
Subject: [PATCH v2 3/6] dt-bindings: phy: add the samsung,exynos-pcie-phy
 binding
Date:   Fri, 23 Oct 2020 09:57:41 +0200
Message-Id: <20201023075744.26200-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023075744.26200-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTUQDu7N7tXqer27Q8mCQtCtLSrH5cqNSerB9BZfVD8jHzokM3ZddZ
        FtS0khyaOqNMaj7KB8uVrTnfVjpaJjrTciNU8IWP0gg3SU3L7Wb++77zvTiHgyP8ErYXLpYm
        UzKpKEHA4aKG9/PmPWi2KnLvAzVKPkuPI4uMXWzSupDBJittjzCyeyyLQ5rN1RjZ2/CYQ3aq
        TRyywNzCIr8vTmCk1jiAkXeajRhZ3/8BCeEJq9RVQFhfOIAJi3VyoU6TyRHe02uA0GStZQln
        dVvPYGHcQzFUgjiFkgUERXHj9PYvWNIb4qr69Q+WAtTwlMAFh8QBuNA7hyoBF+cTlQA2vprk
        MMQGYNtPK4shswCm3R4Fq5GB1o8II1QAONdoWIssL4+iDheHCITKaeWKgOMeRAj8ZScdHoQo
        RaAix+hscidCocXa5MQosQOWjdc7szziMMyfX+Awaz7wefVbxIFdiCA4oxgEjiJIaDDY8sno
        HIDEcTikOs343eGUSY8x2Bv+qS9iMf5bAA51aTGGZAHYm17w7z4HYX/XgrMIIXbBlw0BTOcR
        aNd7M3A9tE5vdJiRFagyPESYYx68m8FnOnbCQtOL/6vvunsQBguhbrwHMM+TB6ChaQTNBT6F
        a1vFAGiAJyWnJbEUvU9KXfGnRRJaLo31v5wo0YGVj9OxbLLVgYbf0a2AwIHAjReVmxfJZ4tS
        6FRJK4A4IvDgHe3siODzYkSp1yhZYqRMnkDRrWALjgo8eftLJ8P5RKwomYqnqCRKtqqycBcv
        BVAnXNzNrki1XdI9XjecHPztSfpN7bbOUH5aZ7n9a9iNWo2uOSapa1O0JfhCfqDW9awt2ntw
        qazthN5IGzfUPI0fnhLnRihLTgr0Y4V9aYPbP6P39RPlqeV150/5XVeojvW1h4vPYdXZ4zle
        fiO2icrNFt/ZZHxmqT0o0+LqtmgQoHScKNAXkdGivxzbt2Y0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e/4XV3m3knxBr+P6FgsacqwmH/kHKvF
        jV9trBYrvsxkt7jwtIfN4vz5DewWl3fNYbM4O+84m8WM8/uYLN78fsFusfbIXXaL1r1H2C12
        3jnB7MDrsWbeGkaPnbPusnss2FTqsWlVJ5tH35ZVjB7Hb2xn8vi8SS6APUrPpii/tCRVISO/
        uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY8vXq+wF+wUq5m1+z9TA
        uJW3i5GTQ0LAROLuoVPMILaQwFJGiYNz7CHiMhInpzWwQtjCEn+udbF1MXIB1XxilOjd8pMd
        JMEmYCjR9RYkwckhIuAk8X7yRWaQImaBNcwSjW3dTCAJYYFAia5NE8EmsQioSix9vpMFxOYV
        sJWY/PMXG8QGeYnVGw6AXcEpYCfxruEeI8RFthKHD11lnsDIt4CRYRWjSGppcW56brGRXnFi
        bnFpXrpecn7uJkZgBGw79nPLDsaud8GHGAU4GJV4eBMmTIwXYk0sK67MPcQowcGsJMLrdPZ0
        nBBvSmJlVWpRfnxRaU5q8SFGU6CjJjJLiSbnA6MzryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQ
        QHpiSWp2ampBahFMHxMHp1QDI9tlX41f3ZPPH1yWUtoprPSwQ/ufyRbHpiTHOy+7t/jlbUsV
        EFZW/RZsFsm0wLIggl9MfH/Ib0s9W0O3+Te2HBP80q+zdOF3oYT2620rFsWVmVz4cXZJj8x9
        8/K6yy57PzoKyCR9DWfkvZv++pDusbMW15IFOI9JulYdNeLV+WTw9vxBhc9NSizFGYmGWsxF
        xYkAg8uLEZYCAAA=
X-CMS-MailID: 20201023075755eucas1p165641c7528ea987a2e1d9d28198c0e9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201023075755eucas1p165641c7528ea987a2e1d9d28198c0e9e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201023075755eucas1p165641c7528ea987a2e1d9d28198c0e9e
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
        <CGME20201023075755eucas1p165641c7528ea987a2e1d9d28198c0e9e@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dt-bindings for the Samsung Exynos PCIe PHY controller (Exynos5433
variant). Based on the text dt-binding posted by Jaehoon Chung.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
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

