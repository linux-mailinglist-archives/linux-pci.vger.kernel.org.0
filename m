Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265452B214C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 18:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgKMRCO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 12:02:14 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36215 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgKMRCN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 12:02:13 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201113170201euoutp02e581e05cd2311497fe6b9b524b772ced~HH-NDf8CX0529105291euoutp02L
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2020 17:02:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201113170201euoutp02e581e05cd2311497fe6b9b524b772ced~HH-NDf8CX0529105291euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605286921;
        bh=ZUbtyjIrwhOaqSSJ6snJVhMgq4t2jtjQN1lZDh6U7qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vWWOkOfvW11CIoM0li+aa+x82XZC/tF6M64y5OidiXgGBx8oIPvv1eQEZWlN5DgLD
         +RzFHktXOwp0aC2wAuQ4bN8+ix8gvI9mKiVWLwwUTidXYpnqGiPQjj3w8XbZR9sSpk
         ghZLbgzXrebhbAkEyNE5vOwbHzEkmOwBTncA8DS0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201113170158eucas1p1c629a7958c25cbd934ef04d0dc431a76~HH-KLIOz70049600496eucas1p1c;
        Fri, 13 Nov 2020 17:01:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3E.51.44805.60CBEAF5; Fri, 13
        Nov 2020 17:01:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201113170158eucas1p1a1fa871bfc1513e3bb62b56c28454e68~HH-JrIdMN2435024350eucas1p1A;
        Fri, 13 Nov 2020 17:01:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201113170158eusmtrp17ca0c69126f606dcf6ee00a90ffad33d~HH-JqU4HJ1302013020eusmtrp1l;
        Fri, 13 Nov 2020 17:01:58 +0000 (GMT)
X-AuditID: cbfec7f4-b4fff7000000af05-e7-5faebc0644c8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 83.50.16282.60CBEAF5; Fri, 13
        Nov 2020 17:01:58 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201113170157eusmtip22eec70403326bd9a8f934b57623cafaa~HH-JCHet01428914289eusmtip2d;
        Fri, 13 Nov 2020 17:01:57 +0000 (GMT)
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
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 3/5] dt-bindings: phy: exynos: add the
 samsung,exynos-pcie-phy binding
Date:   Fri, 13 Nov 2020 18:01:37 +0100
Message-Id: <20201113170139.29956-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113170139.29956-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf1DLYRzH79l33x+L1bdvnZ4rRDGno+R0vi6ynLumcPzRdQoz66t1tcpW
        EockyXTOj06tutVRSlq1lR+lX6YsN5riCEtxYqica5L83Nrw3/t5f96v5/3c5x4CoYpQTyI+
        KZWRJYkSfTAn9vW734xLsZZa4bKz5YtpTWEdSpdnSejSzh6U7p/KQekqixKnHw7nYbTRWI/T
        j5pLMPqBSo/RhcY2Fj3y3YzT6s4BnP7dchOnm0zdCN9ZUKOqAYKmogFcUKZNE2irT2KC043V
        QKDvv8ESjGvnbsGjnVbHMonx+xhZQMguJ0l+uxpNKXXd/+3SGMgEp5wVgENAcgWcyDKhNk2R
        VQAqzd4K4GTVFgBzOzWY/TAOoGkgE/lL3GvVo/ZBJYD9b8fRf0h77gjLlsLIQKgYVVhxgnAn
        +XDyC23LIORTBN6rKJ7OuJExcCQvG7dpNrkQ3nmpAzbNJddA852fuL3NG16t75hu5pAhcKpb
        idsugqSJgH2jJZg9tB6O/fgC7NoNftA3OuDZ0HA+j20HjgH4qkftoPMAfJRV6CCCoalnavqp
        CLkY1jUH2O1Q2PA1H7HZkHSG/aOuNhuxynPXCxw2F+bmUPY0Dxbpa//V3n7Y59iWAJ6qHXKs
        8SyANX1m9hngXfS/rAyAauDBpMmlcYx8eRKT7i8XSeVpSXH+4mSpFli/j+GX3nITVH747K8D
        LALoACQQH3euL79GSHFjRRkHGFmyUJaWyMh1wItg+3hwdzdaR2ScKJVJYJgURvZ3yiI4npms
        2GhXSx8VHl28UeX+5MBPczOfiAcFvVWz1nI+HZ7Mv7Lj1+N1qeqJj8mqnN7g2E/HDWORYdS5
        GcI9HF5DtibsQnrBYGUG9Yxeti2wwqVUuyhy8ODeTFHYUReTl1TDafc78jqIpRm+yArVf2Yb
        Z4QqurQ7zyfvrWstX/m2dU7C/efzIq4xLusSVp/InugSLwhRhca8X2vYuUbcssrEs8wKyh9u
        eneVl3MwpQT3VVZuV+pILGp2xfBMdOu+liuHgm9FgQaPRd0aQ8aRxIkz+NEA8ZLLQknY5vpN
        agrt8pAETQ55ze35zm/mmV68SX/jOV+84VJ9GSVlhOyOtoiYBeG9Pmy5RBToh8jkoj/5PLbq
        rQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t/xe7pse9bFGzSeY7fYOGM9q8WSpgyL
        +UfOsVrc+NXGarHiy0x2iwtPe9gszp/fwG5xedccNouz846zWcw4v4/J4s3vF+wWa4/cZbf4
        v2cHu8XOOyeYHfg81sxbw+ixc9Zddo8Fm0o9Nq3qZPPo27KK0eP4je1MHp83yQWwR+nZFOWX
        lqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlTNm/lrVgvmDF
        z8XvGBsYu/m6GDk5JARMJE7uPc7axcjFISSwlFGitWcpC0RCRuLktAZWCFtY4s+1LjaIok+M
        EtNvHGUCSbAJGEp0vQVJcHKICDhJvJ98kRmkiFngIbPEhDkHwbqFBSIlbp6/A1bEIqAqcfje
        IUYQm1fAVuLF4b/sEBvkJVZvOMAMYnMK2En8OjETKM4BtM1WYvmO0AmMfAsYGVYxiqSWFuem
        5xYb6RUn5haX5qXrJefnbmIExsK2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrzKDmvihXhTEiur
        Uovy44tKc1KLDzGaAp0xkVlKNDkfGI15JfGGZgamhiZmlgamlmbGSuK8JkeAmgTSE0tSs1NT
        C1KLYPqYODilGpi83Wa3hyzQar+dYCP5wkklmENj6Z5omd6jGY4Lzn326q9t/Mxm9DGhLY9z
        t8y/a83b2KrmZF1kFvOx3sBe3le+KFnpsmGdzpucx5P+vnE2eSbO2dMtuvmlvOFfPePYrcl/
        NW9xZN1Y7rXRyOpcwuwZVgYvlNKjrydPLJtdnSj9//fc9i+9QSnvH5hMimWaKyj/2zh48sug
        sFiZ0z4VSWzXXh8ymvC6ZeWt7tO/pr2R+qCWfi8xzNFaqTIxqtvxw5LHcduuLnFSsm88knSS
        5Y6o556+fzOObT9wt8z1YWNWt93Re7Mn8S09Nv/Bcx7J9ZEZny6t0zE90XbVsWBd2oSU526b
        RcuOb99Rli/eMFuJpTgj0VCLuag4EQANunSUDgMAAA==
X-CMS-MailID: 20201113170158eucas1p1a1fa871bfc1513e3bb62b56c28454e68
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201113170158eucas1p1a1fa871bfc1513e3bb62b56c28454e68
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201113170158eucas1p1a1fa871bfc1513e3bb62b56c28454e68
References: <20201113170139.29956-1-m.szyprowski@samsung.com>
        <CGME20201113170158eucas1p1a1fa871bfc1513e3bb62b56c28454e68@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dt-bindings for the Samsung Exynos PCIe PHY controller (Exynos5433
variant). Based on the text dt-binding posted by Jaehoon Chung.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

