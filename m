Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92BC2924E4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgJSJsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 05:48:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36078 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgJSJr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 05:47:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201019094739euoutp0257020bc6d43c0c3ccd4c29b0011f86f3~-W7zmNLUp2545725457euoutp021
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 09:47:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201019094739euoutp0257020bc6d43c0c3ccd4c29b0011f86f3~-W7zmNLUp2545725457euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603100859;
        bh=taS3Lv3c7Mbp29+bInZXuGxSD3nT47aAFihQv2Xm60M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+CAdIP1HpaxJaOHLjzGRBlgkkPIHoXyMo+P2FNlrxNoKmfBRmZ22keGKp5AjFJ3v
         z7uqECM5YwmxfIchBVgFLOKF8k6EfeXrGb9O6mCw8O1Y2QySscZpK0aQcT9aNGZ/5p
         k28T9/VYHO9MZUJ/DMVL/w18bF4JMBOdkAorA8qo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201019094738eucas1p16c636e50b392bbc49e8e8cbaef31a2c2~-W7zONjuI1548115481eucas1p1Z;
        Mon, 19 Oct 2020 09:47:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F7.35.06318.AB06D8F5; Mon, 19
        Oct 2020 10:47:38 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201019094738eucas1p29b377b561089cfc3eba1755d475125b9~-W7y0DcvW2087320873eucas1p2C;
        Mon, 19 Oct 2020 09:47:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201019094738eusmtrp25c75cf6270307e6cbcbb4b34250e1d9b~-W7yzWLDz2609626096eusmtrp2K;
        Mon, 19 Oct 2020 09:47:38 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-6c-5f8d60ba6144
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6A.CB.06017.AB06D8F5; Mon, 19
        Oct 2020 10:47:38 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201019094737eusmtip134fa600b1f5793c1201208bc651bd67d~-W7yOlCOw1597115971eusmtip1S;
        Mon, 19 Oct 2020 09:47:37 +0000 (GMT)
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
Subject: [PATCH 1/6] Documetation: dt-bindings: drop samsung,exynos5440-pcie
 binding
Date:   Mon, 19 Oct 2020 11:47:10 +0200
Message-Id: <20201019094715.15343-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019094715.15343-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjm29nOOZMWX1Pyw0xhoHT1koGnMlEJOtCfCgkyai49baO5yeZM
        7Y+amq5p6h/N6zTRsWauJeaWl5LhlOEUhTTUKLCbZlReSLt6Omr/nud5n4fn5eUlMbFJEEAq
        1RmMVi1TSXAfftfgmvewM7lUGlH4OYJqyVdQjS6vgJpaLxJQ5uV7BDX21ohTo6M2gppw1uHU
        SIMbp6pH+3jUpx8fCKrdNUtQhb0ugnLMDGFxItraYAW0o2aWoE12PW23lOB0WacF0O6pJzx6
        yR50lkjyiUllVMpMRhsem+yjmK+MSK/wy3Kv9fBywSQ0ACGJ4FH0a+mrwAB8SDE0A/Te49gk
        yxtk0oNzZAmgjm99+FbkjtFFcIM2gCrb+rHtiLW0RMC6cBiJDIuGjQRJ+sE49H2FYj0YbMZQ
        7l0XYD2+8AKy1T/ms5gPQ1Bj8QyP9YvgSbTeeYwrC0YPbM8wFgthLDI0tWKcbiHQeM8+Dp9C
        4/3NgMO+aN7dSXA4EP1xNPLYXgRvAfTG205wxAjQRH71ZuIEmvGu/1sUg/tRhzOck+ORe9rE
        Z2UEd6KpxV2sjG3Ayq4qjJNFqLhIzLlDUY374Xbt87HxzTVpVL5atHnRCoBW8wfxchBc87/M
        BIAF+DN6XZqc0UWpmRthOlmaTq+Wh6Vo0uxg4288v90r3aDv59UBAEkg2SF6rTFKxQJZpi47
        bQAgEpP4iRJGPFfEolRZdg6j1Ui1ehWjGwB7SL7EXxTV/PGyGMplGcx1hklntFtTHikMyAXO
        QMlNJxGdw/Dva/zsNtUrMnGo+FBom21N9UXhDJKbzMMFT1ukQ5NzWcu9dLcgZvfC+fi956SX
        UuzGVgNsCDSS3qS5hXcFylr/+RePjoRAp2Iq9GBT4svV4fSLMnP9cWuT0WqNFtaeIfoTrt3O
        m43yiOIm8qbL6qq0lPK0hK9TyCIPYFqd7C8PXM6AMwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4Xd1dCb3xBp1LhS2WNGVYzD9yjtXi
        xq82VosVX2ayW1x42sNmcf78BnaLy7vmsFmcnXeczWLG+X1MFm9+v2C3WHvkLrtF694j7BY7
        75xgduD1WDNvDaPHzll32T0WbCr12LSqk82jb8sqRo/jN7YzeXzeJBfAHqVnU5RfWpKqkJFf
        XGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8WqSQcFEkYrjP/cwNTBe
        F+hi5OSQEDCR6O45wt7FyMUhJLCUUeLVjx2sEAkZiZPTGqBsYYk/17rYIIo+MUrsfn2GESTB
        JmAo0fUWJMHJISLgJPF+8kVmkCJmgTXMEo1t3UwgCWGBEIkpjV3sIDaLgKrE/I47QHEODl4B
        W4lfWywhFshLrN5wgBnE5hSwk+hauAzMFgIq6Vo5jWUCI98CRoZVjCKppcW56bnFRnrFibnF
        pXnpesn5uZsYgeG/7djPLTsYu94FH2IU4GBU4uF9kN8TL8SaWFZcmXuIUYKDWUmE1+ns6Tgh
        3pTEyqrUovz4otKc1OJDjKZAN01klhJNzgfGZl5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0
        xJLU7NTUgtQimD4mDk6pBsaDIXPWzL59Iypw876dNTN6VOfttTPeZaXg2VS0+P7dUw1vS71S
        a18eP/vUqqiQ61BFSuMm4ZVOtjKtyQqKlV+OM2T3JMamZiddf2/9Zq4U666HMtOcTEOflwq6
        HCrhlD/IL7t9w9f/XNWJ7i/3K5e0ivMUPzyxs/9GV8c/Zfbg7tLPv/yOX1FiKc5INNRiLipO
        BADx0pM6lQIAAA==
X-CMS-MailID: 20201019094738eucas1p29b377b561089cfc3eba1755d475125b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201019094738eucas1p29b377b561089cfc3eba1755d475125b9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201019094738eucas1p29b377b561089cfc3eba1755d475125b9
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
        <CGME20201019094738eucas1p29b377b561089cfc3eba1755d475125b9@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
dts: exynos: Remove Exynos5440"). Drop the obsolete bindings for
exynos5440-pcie.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../bindings/pci/samsung,exynos5440-pcie.txt  | 58 -------------------
 1 file changed, 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt b/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
deleted file mode 100644
index 651d957d1051..000000000000
--- a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Samsung Exynos 5440 PCIe interface
-
-This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
-
-Required properties:
-- compatible: "samsung,exynos5440-pcie"
-- reg: base addresses and lengths of the PCIe controller,
-- reg-names : First name should be set to "elbi".
-	And use the "config" instead of getting the configuration address space
-	from "ranges".
-	NOTE: When using the "config" property, reg-names must be set.
-- interrupts: A list of interrupt outputs for level interrupt,
-	pulse interrupt, special interrupt.
-- phys: From PHY binding. Phandle for the generic PHY.
-	Refer to Documentation/devicetree/bindings/phy/samsung-phy.txt
-
-For other common properties, refer to
-	Documentation/devicetree/bindings/pci/designware-pcie.txt
-
-Example:
-
-SoC-specific DT Entry (with using PHY framework):
-
-	pcie_phy0: pcie-phy@270000 {
-		...
-		reg = <0x270000 0x1000>, <0x271000 0x40>;
-		reg-names = "phy", "block";
-		...
-	};
-
-	pcie@290000 {
-		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
-		reg = <0x290000 0x1000>, <0x40000000 0x1000>;
-		reg-names = "elbi", "config";
-		clocks = <&clock 28>, <&clock 27>;
-		clock-names = "pcie", "pcie_bus";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		phys = <&pcie_phy0>;
-		ranges = <0x81000000 0 0	  0x60001000 0 0x00010000
-			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>;
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-		num-lanes = <4>;
-	};
-
-Board-specific DT Entry:
-
-	pcie@290000 {
-		reset-gpio = <&pin_ctrl 5 0>;
-	};
-
-	pcie@2a0000 {
-		reset-gpio = <&pin_ctrl 22 0>;
-	};
-- 
2.17.1

