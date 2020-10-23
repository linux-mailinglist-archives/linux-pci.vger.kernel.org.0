Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B4D296AB8
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 09:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375288AbgJWH6N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 03:58:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46354 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374947AbgJWH6N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 03:58:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201023075755euoutp02b726d3f0c2317029fbd73c49b1ad81ff~AkBJDwm4T1643316433euoutp02l
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 07:57:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201023075755euoutp02b726d3f0c2317029fbd73c49b1ad81ff~AkBJDwm4T1643316433euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603439875;
        bh=Q9mtaEriLpO8ZfFYC6o2WC/Wtw/EDrFIhbVLQAASD/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BlUScG0rVVgbH15XK1PrEpzuBixWuixkEH2o65TGtzCKC++YHBkBVTvCU/lxuHz+x
         t0OOG6slBm/czpuHKwdNZg2vgDMbRrlrhCP+2gQhZj63/pLY82orpl/2W/na++zRvC
         6HUGh30AaTlCuQ23E0X9gXJprt6TtDjda9HKzHYY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201023075755eucas1p1eb1cc8e7151296bc693acca47a1fb161~AkBIplAM_2403524035eucas1p1D;
        Fri, 23 Oct 2020 07:57:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CA.A8.06456.20D829F5; Fri, 23
        Oct 2020 08:57:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201023075754eucas1p2a4c9c5467f25a575bec34984fe6bb43b~AkBIV1PpN1771117711eucas1p2C;
        Fri, 23 Oct 2020 07:57:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201023075754eusmtrp2e37f6760398f596b04e1323993a48338~AkBIVJsDS2108721087eusmtrp2d;
        Fri, 23 Oct 2020 07:57:54 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-04-5f928d02506c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.27.06017.20D829F5; Fri, 23
        Oct 2020 08:57:54 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201023075754eusmtip1c629c6ad053a54636302e97f4b075f86~AkBHukSg22319023190eusmtip1b;
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
Subject: [PATCH v2 1/6] dt-bindings: pci: drop samsung,exynos5440-pcie
 binding
Date:   Fri, 23 Oct 2020 09:57:39 +0200
Message-Id: <20201023075744.26200-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023075744.26200-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87pMvZPiDR6strBY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdYu2Ru+wWrXuPsFvs
        vHOC2YHXY828NYweO2fdZfdYsKnUY9OqTjaPvi2rGD2O39jO5PF5k1wAexSXTUpqTmZZapG+
        XQJXxpxDu5kKPopUzFjRwtzAuFawi5GTQ0LARKKjcw9zFyMXh5DACkaJJW8vQTlfGCX2bfnN
        CuF8ZpR4+vItG0xL46dzbBCJ5YwSv67tZ4Nr2fZwJyNIFZuAoUTX2y6gBAeHiICDxI+vFiA1
        zAKLmCUa+o+A1QgLBEjsv74bzGYRUJX4tXcfmM0rYCvRtHICO8Q2eYnVGw4wg9icAnYS7xru
        MYIMkhBYxS4xZe4nZpAFEgIuEtPOmEDUC0u8Or4FqldG4v/O+UwQ9c2MEg/PrWWHcHoYJS43
        zWCEqLKWuHPuF9ilzAKaEut36UOEHSVuzVwKNZ9P4sZbcIAxA5mTtk2HCvNKdLQJQVSrScw6
        vg5u7cELl5ghbA+JWYdesUDCZyKjxJfrX5kmMMrPQli2gJFxFaN4amlxbnpqsWFearlecWJu
        cWleul5yfu4mRmDKOf3v+KcdjF8vJR1iFOBgVOLhTZgwMV6INbGsuDL3EKMEB7OSCK/T2dNx
        QrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTD2pReLLrd4
        0LXrv1Vz7N7fXc6rWapXfVRfpHe7cL3YtllbJ76c/+ZjtPVumxS20AeyVvWK32dtm3VdTW72
        W98azrC3VRu6wrJWf4702XXLlk+6U1bj3nSdrprsgJ0PuKZV/TZMTVx6heFe+hlDrfdLdC9d
        MZkRYn1mc4wp04od34NWsXzrErFUYinOSDTUYi4qTgQAQHI+SjUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4XV2m3knxBu87VCyWNGVYzD9yjtXi
        xq82VosVX2ayW1x42sNmcf78BnaLy7vmsFmcnXeczWLG+X1MFm9+v2C3WHvkLrtF694j7BY7
        75xgduD1WDNvDaPHzll32T0WbCr12LSqk82jb8sqRo/jN7YzeXzeJBfAHqVnU5RfWpKqkJFf
        XGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMefQbqaCjyIVM1a0MDcw
        rhXsYuTkkBAwkWj8dI6ti5GLQ0hgKaPEra4dLBAJGYmT0xpYIWxhiT/XuqCKPjFKLPx2gR0k
        wSZgKNH1FiTBySEi4CTxfvJFZpAiZoE1zBKNbd1MIAlhAT+JC6s+gTWwCKhK/Nq7jxHE5hWw
        lWhaOYEdYoO8xOoNB5hBbE4BO4l3DffAaoSAag4fuso8gZFvASPDKkaR1NLi3PTcYiO94sTc
        4tK8dL3k/NxNjMAY2Hbs55YdjF3vgg8xCnAwKvHwJkyYGC/EmlhWXJl7iFGCg1lJhNfp7Ok4
        Id6UxMqq1KL8+KLSnNTiQ4ymQEdNZJYSTc4HxmdeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB
        9MSS1OzU1ILUIpg+Jg5OqQbGI5Pupp53cTxwcsfnX/nJYfVGPjG591bWOOasZdt41FvcVv7q
        2anFcy+nL7gb0KCn1/LZVWlq//qfsh35yh+vSzM8LZj9K9m4+vV/rkspLByHLjhvKN7cpyd7
        +1LY7SWdGuf0nRa7H3XWErh8QrD3XXSiJUvOyjKDF9lzGBM/rxbJttge3b1diaU4I9FQi7mo
        OBEAoJb67ZcCAAA=
X-CMS-MailID: 20201023075754eucas1p2a4c9c5467f25a575bec34984fe6bb43b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201023075754eucas1p2a4c9c5467f25a575bec34984fe6bb43b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201023075754eucas1p2a4c9c5467f25a575bec34984fe6bb43b
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
        <CGME20201023075754eucas1p2a4c9c5467f25a575bec34984fe6bb43b@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
dts: exynos: Remove Exynos5440"). Drop the obsolete bindings for
exynos5440-pcie.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
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

