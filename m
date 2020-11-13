Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA372B2145
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKMRCK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 12:02:10 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58247 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMRCJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 12:02:09 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201113170157euoutp01e102fdd05725766d296c7e1913999294~HH-JB8Rna2337923379euoutp01Z
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2020 17:01:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201113170157euoutp01e102fdd05725766d296c7e1913999294~HH-JB8Rna2337923379euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605286917;
        bh=Xy+FsHgST2UjrlJrA5Urtuej2IuCVrFsZHKkLfZioK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=idYWg3zeTSrYDJDNsc3ISFi2WcMC2wn2Ma0lxNuglw0iOow4bv+FA9n2+hNB5q6u2
         s1mxoYDXAXsRSEv1LcwxXpuCZvWNRd9aPXVDXBbVYS0UxIHLoPsihwHiwLryp7jnRz
         cOdK+kdu9iq2RjyKO3VpPslJw2iAJy6GmbcNiVL0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201113170157eucas1p1d45a12b1768294c9fd84f2ccffae7cbf~HH-I3YqGx2494724947eucas1p1C;
        Fri, 13 Nov 2020 17:01:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AC.51.44805.50CBEAF5; Fri, 13
        Nov 2020 17:01:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201113170156eucas1p27318509e20996cd7b774a991bbd729c6~HH-IiS5YK1209312093eucas1p23;
        Fri, 13 Nov 2020 17:01:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201113170156eusmtrp12d26cb041f7342aeeb39008b70dd15b8~HH-Iho1Xg1294812948eusmtrp1s;
        Fri, 13 Nov 2020 17:01:56 +0000 (GMT)
X-AuditID: cbfec7f4-b4fff7000000af05-e3-5faebc055c46
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.71.21957.40CBEAF5; Fri, 13
        Nov 2020 17:01:56 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201113170156eusmtip2450b6916cc3b2b7af9e35ad84d3e1b4d~HH-H3m6U-1428914289eusmtip2c;
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
Subject: [PATCH v4 1/5] dt-bindings: PCI: exynos: drop
 samsung,exynos5440-pcie binding
Date:   Fri, 13 Nov 2020 18:01:35 +0100
Message-Id: <20201113170139.29956-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113170139.29956-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0xScRTuxwXuVcNuZPnLTDealmXa037NHrYeu1vlnK6s/jHKG1iiBoKl
        tTkrDUZmuRI0zUyykYYxMzLXw1lYplhu6Ra0iZXvlUnlo1XItfzvO9/3nfOdnR0C42s5PkRC
        UiotTRImCrju7NoXY63LOfV341Zcr+OhexoDB5VnidH1xlYO6hzP5qDbDi2O2j6puchiqcZR
        e901LmopMXORxvKYhQYnenFU1WjD0Z96E44eWpuwCE+qsqQSUA8LbThVapRTRr2SS+XW6AFl
        7nzAokaMflH4AfcN8XRigoKWhm466C7WPbgHUm7MPVFwdgBkgs7ZKuBGQHINdBhbuCrgTvDJ
        2wB2dP+YKhwA6uw2nClGALTpuln/Wuzl/WAS88kKZ0tL5HRHqcUlcMmVUDWkco4iCC8yAo5+
        R5MejOzA4EtdkWvQHHIf1FsvujCbDIBdl5kAHrkROooKMSbMH96pfurCbuQmON6kxRneSsDe
        orkM3gZLirI4DJ4D+801Ux5f2JyvZk8GQ/IMgF2tVThTqAFsz9IAxhUOra3jrk0xMgga6kIZ
        egv8auvAJ2lIesLOIde9MCe8XFuAMTQPns/mM+5AWGi++z/2WdvbqfUp2GXJYTP3uQRg90s9
        yAP+hdNhpQDogTctl0lEtGxVEp0WIhNKZPIkUcjhZIkROL+n+bfZYQIV/cMhDYBFgAYACUzg
        xVsUURnH58ULT6bT0uQ4qTyRljWABQRb4M07VOOUSJEwlT5G0ym09J/KItx8MlmBsbbxqOji
        PLdfrx09Cw96oKD0+096Ps7v/RmcVlugMh21WQOu5huu+ccKgsO9duUmnwkc827A3pfdKomV
        9i3aM+tw+ObmFC3SaULt1rZs5TJttXpmBps4IgpAO79sDfJXNqVuHpFRvn6+6xXBwr7ZH5cp
        ej7vOF7cfsVrP3vnwHNdleHQhQ8gMriridBlRoaNKnuG9zaGxZ9Srjonyr8jNvWSMQsl+6Iq
        t4syJtI0z2LM0YK8D2t14Yq9fvMS5IPfYlRlfxYXm+wez1+NVNSzSgeTR2cs2W3rX/qu/GiF
        KkNR+0SiLj65Ouf+YvvyHMm3mwGGdm+xx41H6wbenM6lBWyZWLhyKSaVCf8CvW+qXawDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7ose9bFG7zcZWqxccZ6VoslTRkW
        84+cY7W48auN1WLFl5nsFhee9rBZnD+/gd3i8q45bBZn5x1ns5hxfh+TxZvfL9gt1h65y27x
        f88Odoudd04wO/B5rJm3htFj56y77B4LNpV6bFrVyebRt2UVo8fxG9uZPD5vkgtgj9KzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLWLp9I2PBQtGK
        6S2vGRsYbwh2MXJySAiYSDxa8oqxi5GLQ0hgKaPEyk0n2CESMhInpzWwQtjCEn+udbFBFH1i
        lFj+4QcjSIJNwFCi6y1IgpNDRMBJ4v3ki8wgRcwCD5klJsw5CNTNwSEsECYx8S4HSA2LgKrE
        w0mPmUBsXgFbiS+zZzFDLJCXWL3hAJjNKWAn8evETHaQViGgmuU7Qicw8i1gZFjFKJJaWpyb
        nltsqFecmFtcmpeul5yfu4kRGAnbjv3cvINx3quPeocYmTgYDzFKcDArifAqO6yJF+JNSays
        Si3Kjy8qzUktPsRoCnTGRGYp0eR8YCzmlcQbmhmYGpqYWRqYWpoZK4nzbp0L1CSQnliSmp2a
        WpBaBNPHxMEp1cB0Ik1clSF7Y8+09QWyxnYT9krb1KoVt70xstAoTjpUxD7vpxLHylXNibIf
        HfLiS3bVsJzUbNzGreC7tSGxaENa8c5797tPJLg8NP31ycjoTLZ6/8QVbat++P9by16w8WzM
        vB08nA8W9+XdTo9zVFviYvfGiH/jhZXv1nkrHGxeGOk4I+RmsvwfkW9Jff9YdhzQf5H5Lftd
        7ewbIWF9t8Ucpi0x/Lbx3tYCDl+OGw+dIiVT/E31VkzoW9jYxZ9//Pihz6Eh7vc/pD3TEFn4
        xWim0sOlaaGa8Xvb/zzuOJa4/alne2RHnsxn55NmBxfuYpQWsTrYzJ5Qb/LQv2t64tLWS5s3
        5/8pqZQJ8BNgWabEUpyRaKjFXFScCAAWT47/DQMAAA==
X-CMS-MailID: 20201113170156eucas1p27318509e20996cd7b774a991bbd729c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201113170156eucas1p27318509e20996cd7b774a991bbd729c6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201113170156eucas1p27318509e20996cd7b774a991bbd729c6
References: <20201113170139.29956-1-m.szyprowski@samsung.com>
        <CGME20201113170156eucas1p27318509e20996cd7b774a991bbd729c6@eucas1p2.samsung.com>
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

