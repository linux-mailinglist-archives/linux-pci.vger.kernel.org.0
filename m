Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643482B2146
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKMRCK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 12:02:10 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58252 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgKMRCK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 12:02:10 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201113170158euoutp0115263f4e8ccd70559dfba6dda2f59cea~HH-JpWyw32367823678euoutp01B
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2020 17:01:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201113170158euoutp0115263f4e8ccd70559dfba6dda2f59cea~HH-JpWyw32367823678euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605286918;
        bh=pRFZhFqgtFl1/Cq48v7yrSkPYsoeH1ETLwDtqC+UIqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYwdwfpPo9Uvww0X/avYqbTphO9T3KgUxaudvpC8Vtehlaiw80Aw2p5ClgXpirPk0
         RspE7RtN9W8RnHnfrL4U366lQuKLWDhedFpKAQoWStG9thLuDvdLsa0i7tcaZGWbdn
         1SlXbA4a2RBoUxsU3lzBdEqhslwBeDh0LyeMfNmo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201113170157eucas1p19ae0eb9a84c95457b41a347a9b193625~HH-Jaa7lw0160401604eucas1p1Z;
        Fri, 13 Nov 2020 17:01:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DC.9F.45488.50CBEAF5; Fri, 13
        Nov 2020 17:01:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201113170157eucas1p1586185df931144982527eb3aa988a127~HH-JGLl1Y2485424854eucas1p1O;
        Fri, 13 Nov 2020 17:01:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201113170157eusmtrp1ce707387f8a366127015249fc16998ff~HH-JFjfvx1302013020eusmtrp1k;
        Fri, 13 Nov 2020 17:01:57 +0000 (GMT)
X-AuditID: cbfec7f5-c77ff7000000b1b0-d9-5faebc05e341
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3F.71.21957.50CBEAF5; Fri, 13
        Nov 2020 17:01:57 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201113170156eusmtip228601b7bb55ac44e00a87d42ddbb6804~HH-IcVlYa1944119441eusmtip2b;
        Fri, 13 Nov 2020 17:01:56 +0000 (GMT)
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
Subject: [PATCH v4 2/5] dt-bindings: PCI: exynos: add the
 samsung,exynos-pcie binding
Date:   Fri, 13 Nov 2020 18:01:36 +0100
Message-Id: <20201113170139.29956-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113170139.29956-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSf0yMcRjf9967931Ld14d65sQFaNNJOa70cnYnM1W+sPl2HLqdcVV3HUI
        S8uGrlBCd1fOj+j3HZLSD9FNrtx0qeUOl18bJWWsWr+QXu/hv8/zeT6f5/Ps2UNinjrebDI+
        MZlWJsoUfrg7t/rJWNtSXoMperkpfSW6o73FQzfS49CVx2085Bg/yUMlQzoCtX/MwpHNdptA
        nXUFOHpmsOBIa2vkoP6JXgIZH3cTaLLhPoFqnS1YmEBcYagA4lp9NyG+WqkWV5Zl4OKzVWVA
        bHHUcMSDlfMiCKn72lhaEX+QVi4T7XKPu2zPxvdn+B7+oikm0sAbLw0gSUithF0TQg1wJz2p
        EgD7Cl/ibDEEYM+LCY4GuE0VgwDWP0pmMGMYdth4rKgYQOM7O/efo1RXwGVUOBUMNQManImY
        SYXB0WHEaDDKjsHWm/l/pgopCXzydpTHYC61EP7Mu0gwmE+Fwv7JV4BN84Xltx9hDHajRHC8
        RUcwgyDlJGF5VwfBijbCi/njLoMQ9lmqXPwcaM3N4rKGEwC+bzO63FkAdqZrXY410Nk2/mdV
        jFoCb9UtY+n18Ed6PYc9kgA6BmYwNDYFz1fnYSzNh6dPerLqRVBvMf2LbWrvwFgshgZTteta
        OQD+HDFws4Gv/n/YVQDKgBetViXIaVVIIn0oSCVLUKkT5UExSQmVYOp7rL8sw/dBSd/3IDPg
        kMAMIIn5zeT7h1VEe/JjZSlHaGVStFKtoFVm4ENy/bz4dfemWpRclkzvo+n9tPJvl0O6zU7j
        nI52Askq2W7F8aq7hfM2Ga0Zpi0RR/UffJS8AxGZu6zhFcKvuY4VqdLIwokNG+urdhwRKLac
        017p8BFco941CLSBweUDL2IudatDttMBO+8UGUZfNz/MTu1Rouf+AXsWNEuLbU5ytWx46xdF
        Zqko1E24brpvWY7UHh47P6L/7g2qVCKPJFDAYuloS6+gptWcI8dDRy6Iooa8675LhIOOvZao
        U2miyTlDqU2BJnvysd7MyG2dISmiBU+9NTbp3NSxmkaJvzlvgzXmgSRcVVSb3be5iXp95pPH
        tOvrgUdX43TDGWKWTr3UK6PImBvW/Tn3m09seOvZkgNR/frt5Xo/ripOFhyIKVWy3/Mbc2Ss
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t/xe7qse9bFG3ycIW+xccZ6VoslTRkW
        84+cY7W48auN1WLFl5nsFhee9rBZnD+/gd3i8q45bBZn5x1ns5hxfh+TxZvfL9gt1h65y27x
        f88Odoudd04wO/B5rJm3htFj56y77B4LNpV6bFrVyebRt2UVo8fxG9uZPD5vkgtgj9KzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmHt9AltBp3zF
        667l7A2M98S7GDk5JARMJL7eOM/axcjFISSwlFHi149NrBAJGYmT0xqgbGGJP9e62CCKPjFK
        7O7fwgaSYBMwlOh62wVmiwg4SbyffJEZpIhZ4CGzxIQ5B8G6hQVCJY5ueMIEYrMIqEr8nT6V
        HcTmFbCVePP/FiPEBnmJ1RsOMIPYnAJ2Er9OzASq4QDaZiuxfEfoBEa+BYwMqxhFUkuLc9Nz
        iw31ihNzi0vz0vWS83M3MQJjYduxn5t3MM579VHvECMTB+MhRgkOZiURXmWHNfFCvCmJlVWp
        RfnxRaU5qcWHGE2BzpjILCWanA+MxrySeEMzA1NDEzNLA1NLM2Mlcd6tc4GaBNITS1KzU1ML
        Uotg+pg4OKUamCqrbiXM5Lq37I+QpNIp56QglbftztZrLjx3XjyxKVqGqyxHwfuBwDPbJVcX
        bFmrFuJTwSw0e26I471z50rtll3KWavU+Vx2i1jDh+vNpmWTfu56fHDJwr93rCfqeFvv8vvj
        upVVxWlnQKhxqewy3TLxuJ/K6wKmc61hso44E3yhJ+nJLKtzhwteXFgdmS5n8GLSenGrridv
        PW6uO161/IRnZgiPxL2XIk251xnVPxpp/PRwCOwTOafaUJ3Ldfkw/+4ff5TuzlKqe/Wj3UF9
        bgvDQeXuVZyd9lWMCzbv2Zafqz4xbVfijJKnG5qY1s/Z+47l6tRa5UsCeYX/2XdUTXm5KOlb
        yAmH4+r6ordncymxFGckGmoxFxUnAgDBwOqhDgMAAA==
X-CMS-MailID: 20201113170157eucas1p1586185df931144982527eb3aa988a127
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201113170157eucas1p1586185df931144982527eb3aa988a127
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201113170157eucas1p1586185df931144982527eb3aa988a127
References: <20201113170139.29956-1-m.szyprowski@samsung.com>
        <CGME20201113170157eucas1p1586185df931144982527eb3aa988a127@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
variant). Based on the text dt-binding posted by Jaehoon Chung.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

