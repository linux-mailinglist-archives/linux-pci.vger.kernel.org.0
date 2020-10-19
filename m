Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9806E2924E9
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 11:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgJSJsP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 05:48:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36239 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgJSJsP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 05:48:15 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201019094747euoutp02ebbc9d3a0ca7f58a4f79abefd9a7c596~-W77pEMx_2477424774euoutp02P
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 09:47:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201019094747euoutp02ebbc9d3a0ca7f58a4f79abefd9a7c596~-W77pEMx_2477424774euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603100867;
        bh=aZ+SDBoO/yi+eMijcv2S4atLZClikEFwNWDWnjlTODA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mTNDlfZ17NeJkUAgW2kNwYNu9Y5DkZ7+H+C92vOnnYIZZwOtqXgSS0/6fKB8UseoE
         /P2IA3RO5bYKlpbi50KsoKdRGmgdxRXCpLvPfERia4wsXtycBPJ5bpDhy1HfWhervt
         wnGzpYhZMaG8g5YZl6Y+vkKwr2h6ZsL4lQmq3hRU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201019094739eucas1p1eb8ef01e9a159c9eef858674b9bc0a8a~-W7z6jIrO0216302163eucas1p10;
        Mon, 19 Oct 2020 09:47:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 80.19.06456.BB06D8F5; Mon, 19
        Oct 2020 10:47:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d~-W7zX6uX01333413334eucas1p1X;
        Mon, 19 Oct 2020 09:47:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201019094738eusmtrp2df949d4a7d4a9a60c297b83b9298b218~-W7zXN1OJ2609626096eusmtrp2L;
        Mon, 19 Oct 2020 09:47:38 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-31-5f8d60bbb1f6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6B.CB.06017.AB06D8F5; Mon, 19
        Oct 2020 10:47:38 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201019094738eusmtip13c4a5a349e0a656bbd25ba56161d6ca5~-W7ywps621180211802eusmtip1u;
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
Subject: [PATCH 2/6] Documetation: dt-bindings: add the samsung,exynos-pcie
 binding
Date:   Mon, 19 Oct 2020 11:47:11 +0200
Message-Id: <20201019094715.15343-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019094715.15343-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTYRiGec/Zdo7SidMUfbFUWBkq5AdJHdLMwuD0w+hPEMGcxzyp5dQ2
        Z+mfzKXlstSQnBJ+JSrLz2XmNCVtudLchkIM0nREZToRnOZXam5H7d9938918zy8vDgqfMH3
        wpNTM1hZKpMiErjyOgdXjcd64h5LQvL6fam63CSqSm/kU5a1fD7VuFiOUeYfhQLKZGrDqLHu
        5wJqpNIgoNSmPoSyrU9jVLN+AqPyevUYpRv/iEYRdFNlE6B1FRMYXa1V0FpNgYB+0qEBtMHy
        BqHtWp9L2FXXiAQ2JTmTlQVHxrkmmX/1I+ka7zuTyhokB7R7qIALDskwuKJ7haqAKy4kGwHs
        W3jL58wigNX3rQLO2AF89qWYv1tZ6+rlcYMGALv/zvL2Ku0Nj1AHJSBDoWpOtV3HcXcyCq4s
        UQ4GJWtRmFOkBw7GjbwMP20MO3ke6Qd/FnzlOTRBnoYtdtvONl/4su2dk3EhI6Gqpt55LCTr
        Mdh6rxfjoGiYO7kMOO0GZwwdO/khuKWrQriCEkCrsRnjTCGAY7nqnUY4HDeuOU9FyQDY2h3M
        xWdh04NFxBFDcj+0zB1wxOi2fNpZhnIxAR/mCzn6KKwwtOyt7TePopymYctmKcI9UAmAU1Nq
        pBj4VvxfVg2ABniyCrk0kZWHprK3g+SMVK5ITQy6libVgu2vM7xpWOgCS6PxA4DEgWgfMZVW
        KBHymUx5lnQAQBwVuRPnRoZjhUQCk5XNytIkMkUKKx8AB3GeyJM4XvtbLCQTmQz2Jsums7Ld
        KYK7eOWAwJMbXUZkiln4Psooz5fdmD/iLjWX2saX+8R675jw1/78M8nGP1bboITuHLrr17M8
        XfJNXUKJhtY+exT5GNpOlcdviZmYC9leswlu/rGHr3d4mGoDo9ctYbUhdYR1PsAwY3+/GmC+
        dWVY5DJ38cSMtrk3zhQSIVbWZ8t0H3xEPHkSExqIyuTMPy6QyDU2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4Xd1dCb3xBl8nmVksacqwmH/kHKvF
        jV9trBYrvsxkt7jwtIfN4vz5DewWl3fNYbM4O+84m8WM8/uYLN78fsFusfbIXXaL1r1H2C12
        3jnB7MDrsWbeGkaPnbPusnss2FTqsWlVJ5tH35ZVjB7Hb2xn8vi8SS6APUrPpii/tCRVISO/
        uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv48Lzg0wFq2Qr7jcvZGpg
        3CjWxcjJISFgIvFrx16WLkYuDiGBpYwS2/evY4NIyEicnNbACmELS/y51sUGUfSJUeLU8T9g
        RWwChhJdb7vAbBEBJ4n3ky8ygxQxC6xhlmhs62YCSQgLBEtcPDQRbBKLgKrEs87bLCA2r4Ct
        xLrPb6A2yEus3nCAGcTmFLCT6Fq4DMwWAqrpWjmNZQIj3wJGhlWMIqmlxbnpucVGesWJucWl
        eel6yfm5mxiBMbDt2M8tOxi73gUfYhTgYFTi4X2Q3xMvxJpYVlyZe4hRgoNZSYTX6ezpOCHe
        lMTKqtSi/Pii0pzU4kOMpkBHTWSWEk3OB8ZnXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTE
        ktTs1NSC1CKYPiYOTqkGxo7dFndLyqeLvedlD1rY/HTWCfOWo+r79D2ZL233mpNonh2nsEJj
        1/N5ff/CZx6Mn5/HVfsmsMTy7K2K9SFn2ORqnVf9elPXGzLpx7ZJ+2Ol5odu5z4tZXplE1/c
        G48fgez/2LcFHFHcvKM+7vWmBdNnR25my9RzXWx1o6k4V1T9JZvVQ6mf25VYijMSDbWYi4oT
        Aez6wzeXAgAA
X-CMS-MailID: 20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
        <CGME20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jaehoon Chung <jh80.chung@samsung.com>

Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
variant).

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
[mszyprow: updated the binding to latest driver changes, rewrote it in yaml,
	   rewrote commit message]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../bindings/pci/samsung,exynos-pcie.yaml     | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
new file mode 100644
index 000000000000..48fb569c238c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/samsung,exynos-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC series PCIe Host Controller Device Tree Bindings
+
+maintainers:
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
+    enum:
+      - samsung,exynos5433-pcie
+
+  reg:
+    items:
+      - description: External Local Bus interface (ELBI) registers.
+      - description: Data Bus Interface (DBI) registers.
+      - description: PCIe configuration space region.
+
+  reg-names:
+    items:
+      - const: elbi
+      - const: bdi
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
+  phy-names:
+    const: pcie-phy
+
+  vdd10-supply:
+    description:
+      Phandle to a regulator that provides 1.0V power to the PCIe block.
+
+  vdd18-supply:
+    description:
+      Phandle to a regulator that provides 1.8V power to the PCIe block.
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+  - vdd10-supply
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/exynos5433.h>
+
+    pcie: pcie@15700000 {
+        compatible = "samsung,exynos5433-pcie";
+        reg = <0x156b0000 0x1000>, <0x15700000 0x1000>, <0x0c000000 0x1000>;
+        reg-names = "elbi", "dbi", "config";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        device_type = "pci";
+        interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cmu_fsys CLK_PCIE>, <&cmu_fsys CLK_PCLK_PCIE_PHY>;
+        clock-names = "pcie", "pcie_bus";
+        phys = <&pcie_phy>;
+        phy-names = "pcie-phy";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pcie_bus &pcie_wlanen>;
+        num-lanes = <1>;
+        bus-range = <0x00 0xff>;
+        ranges = <0x81000000 0 0	  0x0c001000 0 0x00010000>,
+                 <0x82000000 0 0x0c011000 0x0c011000 0 0x03feefff>;
+        vdd10-supply = <&ldo6_reg>;
+        vdd18-supply = <&ldo7_reg>;
+        iterrupt-map-mask = <0 0 0 0>;
+        interrupt-map = <0 0 0 0 &gic GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.17.1

