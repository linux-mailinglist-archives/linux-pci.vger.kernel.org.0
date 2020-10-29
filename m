Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB929ED95
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgJ2Nuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 09:50:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42266 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgJ2Nue (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 09:50:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201029134041euoutp019a65cfb50d65482da0c2db5b9893fa32~CekIEILSg0714907149euoutp015
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 13:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201029134041euoutp019a65cfb50d65482da0c2db5b9893fa32~CekIEILSg0714907149euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603978841;
        bh=Xy+FsHgST2UjrlJrA5Urtuej2IuCVrFsZHKkLfZioK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZLvAwyXq1eYqGKcForsVWfNOTskEBdDflqatjvlaZixfoUGNnCjGBaBllsVmcLDug
         BkBjgzC3bqeMab0RTNnyloNQZTda2SkOyBV2wKRz98mLnhyYB5gf+8jJsXiyWDMmuQ
         S5uDceHXb4r1pWccSJoQrkzPg2bnvulTYkpLdinU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201029134038eucas1p2ed790bc82b33747988e71958b91d9612~CekFMEnem0279102791eucas1p2o;
        Thu, 29 Oct 2020 13:40:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 09.99.05997.656CA9F5; Thu, 29
        Oct 2020 13:40:38 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201029134037eucas1p275bad9fe08eff145711cc36ac8c685f7~CekE1Iu9o1017310173eucas1p2Y;
        Thu, 29 Oct 2020 13:40:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201029134037eusmtrp13766ec9d9c582572612133ce74632ea8~CekE0W6SR1072610726eusmtrp1G;
        Thu, 29 Oct 2020 13:40:37 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-36-5f9ac65692dd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8B.91.06017.556CA9F5; Thu, 29
        Oct 2020 13:40:37 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201029134037eusmtip1fe195cc094475eafe10889cb8b339f80~CekENPGdX1812718127eusmtip1t;
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
Subject: [PATCH v3 1/6] dt-bindings: pci: drop samsung,exynos5440-pcie
 binding
Date:   Thu, 29 Oct 2020 14:40:12 +0100
Message-Id: <20201029134017.27400-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029134017.27400-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+Xa2nePwxGkqfsxKGGQW5KUiDnjBImp/WEh28YKXUx5U2qZt
        zkt/eJliOkSaBuoaU7uomJou8bI0cslW2dxQqZFTihJMHVhqqZnlPGn/Pc/z/l6ej5cPQ/g6
        jgBLl2bRMiklFnJ57B7TmvXoFZMmKWjhNZt8qEwj64dHOaR9vZRDtizXoaRtpoJLWq2dKDlu
        0HJJi87MJWutz1nkwq9ZlGwfnkLJPwN9KNnveIVE4KI2XRsQ9WumUFGDXiHSt5ZzRZXdrUBk
        tveyREv6A1FoHC80hRanZ9OywPBkXtqj3i6Q2eiVW1MyDwqBfa8KuGGQOAHrTGagAjyMT7QA
        +HT5LcqYZQCn3zSxGLME4O1KFXdn5dmGnsMMmgF8/8HO3V2Zu6dluyguEQxVTtcGhnkSEXB1
        hXQxCFGPQPX0JMvFeBBRsHjl2zbDJg7Ciapcl8SJMPhx7SrT5Qsfd75AXLEbEQ5NSiETt6Lw
        nfoCo8/A/s/9LEZ7wDlzN8rofXCkuoLtaoVEMYCfRttRxlQAOK6sBQwVAh2j69tPQIjD8Ikh
        kIlPQVunYzuGxB5od25fC9mSVT01CBPjsKyUz9B+UGPu2K0dso39Q0TwblMkcxs1gCOr88gd
        4Kv539UAQCvwphVySSotPyalcwLklESukKYGXM+Q6MHWrxnZNC/3AcPGNSMgMCB0x22TdUl8
        DpUtz5MYAcQQoSd+2jKSyMdTqLxbtCwjSaYQ03Ij8MHYQm/8+P2vCXwilcqib9B0Ji3bmbIw
        N0EhQOvFuHagpOiH5KZOrYzdLA9VW/KN+2OS02YiJ0yLftGbXrb46OpBf/+ZnyeNjrPC2eaL
        ho6XEZW1Y3rp6vkeVrygYA4/NxUfsnio4/KlxAfq3u+LzkkkP8xSrSqSumeW5fTFNySgsblx
        MRpn0BfB4G8fqss4M7yADGmpxgIhW55GBR9BZHLqL+BLzy0xAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4Xd3QY7PiDf5u07ZY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdYu2Ru+wW//fsYLfY
        eecEswOvx5p5axg9ds66y+6xYFOpx6ZVnWwefVtWMXocv7GdyePzJrkA9ig9m6L80pJUhYz8
        4hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jKXbNzIWLBStmN7ymrGB
        8YZgFyMnh4SAicTuP5tYuxi5OIQEljJK9O24yQqRkJE4Oa0ByhaW+HOtiw2i6BOjxPzDJxhB
        EmwChhJdb0ESnBwiAk4S7ydfZAaxmQVWMksc3JYHYgsL+Em8WvWNpYuRg4NFQFXiyqQKEJNX
        wFbiwc9wiPHyEqs3HGAGCXMK2Ekca1ICCQsBVew79Yp5AiPfAkaGVYwiqaXFuem5xUZ6xYm5
        xaV56XrJ+bmbGIGhv+3Yzy07GLveBR9iFOBgVOLhvXB7ZrwQa2JZcWXuIUYJDmYlEV6ns6fj
        hHhTEiurUovy44tKc1KLDzGaAl00kVlKNDkfGJd5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE
        0hNLUrNTUwtSi2D6mDg4pRoY+x19bSQVNswP/xXdOvd+rdrM58udjWLWnzp+yDo/vV1ZpmPh
        OgWZzb/OMBZcfab86ryIMPfKja1dqiYT+w9xFYvJveFt7PW7GqtmIxE6yfR+WU9J4bNrTeq9
        5+UElq4pfT7FZqb7mRMOnWt5p7T9in0vOptt/bwJprttjyc/ixXmLFzvMSFDiaU4I9FQi7mo
        OBEAqUh1gJMCAAA=
X-CMS-MailID: 20201029134037eucas1p275bad9fe08eff145711cc36ac8c685f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201029134037eucas1p275bad9fe08eff145711cc36ac8c685f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201029134037eucas1p275bad9fe08eff145711cc36ac8c685f7
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
        <CGME20201029134037eucas1p275bad9fe08eff145711cc36ac8c685f7@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
dts: exynos: Remove Exynos5440"). Drop the obsolete bindings for
exynos5440-pcie.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
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

