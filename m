Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9665C696680
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBNOVT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBNOVQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:21:16 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41BD2A6C7
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:21:04 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230214141109epoutp01233443b4ae1500ef6426755441b5e1e5~Dtj9nGLPl1584215842epoutp013
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:11:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230214141109epoutp01233443b4ae1500ef6426755441b5e1e5~Dtj9nGLPl1584215842epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383869;
        bh=dTB+VjEDyzvL76nvipyJ2ztjpE2s8jZhOfCcodwAcqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stIN6kxNFTAzKgrhclE60uhUiD/b/JSGD0HYxmZwGAi4UrjlyUbuBkxNlr6F2h6SI
         ydOd38z8Fmq7xIZjWkcvzpqx1DfIvdUgF0GU6PiDXf24k+nw8tKy2NN/5Aaref/fvu
         qCNLdOhyEvzcTf8eTEnyITjzKXzUMXke5Mxms5TA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230214141108epcas5p15735fbd8fa1477f87d6e9c6826b65812~Dtj8QZkLf0389203892epcas5p1H;
        Tue, 14 Feb 2023 14:11:08 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PGNRG3yx3z4x9Pv; Tue, 14 Feb
        2023 14:11:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.98.06765.A769BE36; Tue, 14 Feb 2023 23:11:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230214121448epcas5p48e626bd21819a37308b6277f7b29286c~Dr_Xkovfc2156221562epcas5p4i;
        Tue, 14 Feb 2023 12:14:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230214121448epsmtrp151d94608bf3005cbfd04a79e241ac2e5~Dr_Xj2I8m1788717887epsmtrp1J;
        Tue, 14 Feb 2023 12:14:48 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-9b-63eb967a7380
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.8E.05839.73B7BE36; Tue, 14 Feb 2023 21:14:48 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121445epsmtip103668dd51043511c3e8ad7ecc141e026~Dr_UyTDLR2380623806epsmtip1x;
        Tue, 14 Feb 2023 12:14:45 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, jingoohan1@gmail.com,
        Sergey.Semin@baikalelectronics.ru, lukas.bulwahn@gmail.com,
        hongxing.zhu@nxp.com, tglx@linutronix.de, m.szyprowski@samsung.com,
        jh80.chung@samsung.co, pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 11/16] arm64: dts: exynos: Add phy-names as DT property
Date:   Tue, 14 Feb 2023 17:43:28 +0530
Message-Id: <20230214121333.1837-12-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbVRzHPb3tvbdo2Q0wd1YBoc5NmEC7ATsQUJYteBNMhjNoFBS7cm2R
        vuwDhcTIqxNxMMjCw44VZCiIqHCLjFXGKoMRi1QIZC4MIiiE4uYyHBtBGNoH0/8+v9/v+zu/
        xzmHxAIGcCGZqzYwOrVUKcL9uL1XIiKiCutuysQNC8FoztKLo9YSBWoacvKQufccQCsbTi5q
        X/2UQFWueQwVndrgIfb3azw0aWvE0ZhlBEcNPw9wUNlmGReVDX/ERV8PzRKo5btVAv3T30eg
        zfo7XFR55QNkZWuxlCD6FrtG0BfNswTdzBpptuNjnJ651o/Tt51Ogl6YqufQ1tYP6e7bfRy6
        pWgFp6t6OgB9lw1Nf+z1vCQFI81hdGGMWqbJyVXLk0VpL2cfyY6LF0uiJAnokChMLVUxyaKj
        L6ZHpeYq3WOKwvKlSqPblS7V60UxzyXpNEYDE6bQ6A3JIkabo9TGaqP1UpXeqJZHqxlDokQs
        PhDnFr6Vp3DdMxPaTvz9xYsvFYFGXgUgSUjFwrafMiuAHxlAfQ/gwlw1XgH4buMvAJd6jvsC
        9wH83NHsDXgSTnUuYb7AJQDb66uBzzBx4K26cq8KpyJh8b0KryqImubA5bvzhMfAKAeAdtcl
        wlM8kHoBTlcVeBK41NOwqoslPCygEmFJUet2uSfhV112zMN8t7/MxHoPhdQUCUtvfIL5REfh
        1Y46no8D4R8jPYSPhXD59MltlsMvrQ3beiW8b23l+Ph5aJ9q5Hr6wagI+K0txucOgbWOb7wS
        jPKHlRsL23IB7LM85Kfg6oN+ro93Q8vVye0WaLjSs8bx7bESwJnLWdUg1Px/hWYAOsBuRqtX
        yRl9nPagmnnvvzuTaVQs8D7kyLQ+8NvcnehBwCHBIIAkJgoSBC66ZAGCHGlBIaPTZOuMSkY/
        COLc+6vBhDtlGvdPUBuyJbEJ4tj4+PjYhIPxEtEuwb7kH2UBlFxqYPIYRsvoHuZxSL6wiGMb
        F45dMIUW2/ddp0b9dOczh8+bJzrDa+SliTmrmyeCD+vKIhxtjvXFZ2+4+IF5UcWlM93zo5r9
        kh3lWYk7V45YcrcyFELBinA9fzHlhxn/Vw7sHbAtfWYjjRMBda+1Me+eJEfSOi8MNRW/PXL2
        ma3wJvkbg8o3l3kZW5NfJIU6T4/i6WPZISa7OUZlrP+7OuuJ1GhD4XF770SXYDK8ZNC0Z3zm
        z+nrHXIt3za1t3Cc26YxpvJ/bd7z4JhJHG3uHra+uv+E9VCouDb/8PR8cZ0r5Jcz7Njjs9rJ
        8u7gTN6jgSrL5Yyb7S3rzh31NYqCcf9ayy7HOw55SsMjIX1szdoxEVevkEoiMZ1e+i9Lh4rM
        UQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnK5F9etkg/VTmS0ezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBkvvs5iL1jDVvF0Z2AD4xzWLkZODgkBE4meNc+Zuxi5OIQEdjNKTFtxjxki
        ISnx+eI6JghbWGLlv+fsEEXNTBJNfw+CFbEJaEk0fu0C6xYReMUkcXjPDDCHWeACo8Stg91A
        LRwcwgLuErf6KkEaWARUJfo2bGIHsXkFrCSaGpawQWyQl1i94QDYUE6geEvrJjBbSMBSYtav
        VYwTGPkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjhstzR2M21d90DvEyMTB
        eIhRgoNZSYRX+OmLZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFk
        mTg4pRqYlujLp56e++n61Db+6BxzEytdE5kp+acfG3D/OX1lvuLxYvcyX7+TDlcEa9O78pse
        r2UzquY6xHft4QWbZxv9cxa3SXXXXV/qsMvq14yEL/lhXXLy2VPXzG2W+KVy+sz3axJPL3vP
        uai06JE+g6bWe933v5cblH/Wyb3BpsMrZ2f453klzxqNbbtvdWh1vDsX6hG+7f7t+axZD+eY
        pN93ftPJkh08/f8WS1sW6R+dPN/93z0xv+5vynZK7lJ13KYf/xM3OvGtE1xkfWrFv1JFQQXn
        0Grh6M1NuZ6hdv0vYzlelJj9YWsLzzFIP7v1trjY/kqDA/L8sheevVukJMhRZMlTuog/+a/O
        zcwj5uJKLMUZiYZazEXFiQDESOSDCgMAAA==
X-CMS-MailID: 20230214121448epcas5p48e626bd21819a37308b6277f7b29286c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121448epcas5p48e626bd21819a37308b6277f7b29286c
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121448epcas5p48e626bd21819a37308b6277f7b29286c@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To replace devm_of_phy_get with devm_phy_get to get the
PHY pointer using non DT version, we need to add phy-names
property in DT.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 96b216099594..f50167923fd8 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1957,6 +1957,7 @@
 			num-viewport = <3>;
 			bus-range = <0x00 0xff>;
 			phys = <&pcie_phy>;
+			phy-names = "pcie_phy";
 			ranges = <0x81000000 0 0	  0x0c001000 0 0x00010000>,
 				 <0x82000000 0 0x0c011000 0x0c011000 0 0x03feefff>;
 			status = "disabled";
-- 
2.17.1

