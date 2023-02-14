Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52755696692
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjBNOWB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjBNOVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:21:47 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C61F244B3
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:21:25 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230214141132epoutp021103a7e48838680b0204057f449d6c17~DtkTCG9oI1102511025epoutp02k
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:11:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230214141132epoutp021103a7e48838680b0204057f449d6c17~DtkTCG9oI1102511025epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383892;
        bh=auUVRqKrczwr8dxcJj9iJlHqVS46IWR7h5f9bDyL/9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTG6IKLtVtvhnts0T73rG075LCpqsA+Gzc05aCz+pBrHlOZzwttk9baOsHwDqG+VF
         HPgpX/n51K+mGvW1icT+AbdJFo30T4vH8joB/PvUCkUS7iBbSkCkF+pwFCtu8OI17R
         Vn36HCBxO0xTeHVQNe5VIv3AkY7E5fzHDo0brqiE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230214141132epcas5p1b3b6a2f3148f5350fa0f0b6b928c3fd4~DtkSaTmol1928819288epcas5p13;
        Tue, 14 Feb 2023 14:11:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PGNRk2nzHz4x9Py; Tue, 14 Feb
        2023 14:11:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.A9.10528.2969BE36; Tue, 14 Feb 2023 23:11:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121451epcas5p148118502c76299b2a6f389881fa296cc~Dr_a7gRUk1679116791epcas5p1y;
        Tue, 14 Feb 2023 12:14:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230214121451epsmtrp1c9dcc1ace98f1c0abbdda39d4d22fc5c~Dr_a6oYg01843918439epsmtrp1Y;
        Tue, 14 Feb 2023 12:14:51 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-71-63eb969239f3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.9E.05839.B3B7BE36; Tue, 14 Feb 2023 21:14:51 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121448epsmtip1e40e9843a96cbd637c69ac1b6b33fb8a~Dr_YP1vvE2380623806epsmtip1y;
        Tue, 14 Feb 2023 12:14:48 +0000 (GMT)
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
Subject: [PATCH 12/16] PCI: samsung: Get PHY using non-DT version
Date:   Tue, 14 Feb 2023 17:43:29 +0530
Message-Id: <20230214121333.1837-13-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmlu6kaa+TDWa94Ld4MG8bm8WSpgyL
        +UfOsVrM2jaX0eLj73MsFiu+zGS36HvxkNmioec3q8Wmx9dYLS7vmsNmcXbecTaLGef3MVm0
        /GlhsWg52s5isfbIXXaLRVu/sFv837OD3eLP9A8sFr2Hay02b5rK7CDi8WbTd3aPnbPusnss
        2FTqsWlVJ5vHnWt72DzenTvH7vHkynQmj81L6j02vtvB5LGo4SObR9+WVYwenzfJBfBEZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAL2ppFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO2PP9
        J3PBL/aK89M/MDUw3mTrYuTkkBAwkdg76yZTFyMXh5DAbkaJ97Pes0E4nxgl+r48gXK+MUrM
        bT7ACNNy+cE0qMReRok5rz+wQjitTBJru8+BVbEJaEk0fu1iBkmICNxiknj5+SE7iMMscIpR
        4sCLvewgVcICjhKPuq8ygdgsAqoS92bMAOvmFbCSePFnBTvEPnmJ1RsOMIPYnEDxltZNYFMl
        BK5wSKz6uYIVoshF4vOGbmYIW1ji1fEtUM1SEi/726DsdImVm2dA1eRIfNu8hAnCtpc4cGUO
        SxcjB9B1mhLrd+lDhGUlpp5aB1bCLMAn0fv7CVQ5r8SOeTC2ssSXv3tYIGxJiXnHLkOd4yHR
        vvs52C9CAr2MEv0z6yYwys1C2LCAkXEVo2RqQXFuemqxaYFhXmo5PN6S83M3MYITs5bnDsa7
        Dz7oHWJk4mA8xCjBwawkwiv89EWyEG9KYmVValF+fFFpTmrxIUZTYPhNZJYSTc4H5oa8knhD
        E0sDEzMzMxNLYzNDJXFedduTyUIC6YklqdmpqQWpRTB9TBycUg1MORUp03gaf91rPHauJ0z+
        W4rgRYGlTe02jbndm6KqDYL8fvRcZLnDvZtlim3M5Z2PWBN+XtIXkTCpSj/c1u6rPOWKxPOl
        3FNmsr0umlCkYiynEDt7t+TK/RG+vmGHglfdiuOS6F3+zKWD7fe3Hwpy0sriwifXZCbO4Nwq
        IWGuvXftqrj3bkatU5SjYh+/VjvDd3XbnywnAU7rr6EP2aKX9ultE785L00pUe3V5K9Wmf53
        3njxea7YlcRiL+tokLDqo+tKrpNH70dmHr2dFnezf+ucHdPTRfmM+lmM1r430P8UqaHyZ2fw
        ztD7T7ZtyHbbX2LnI/vB6unls+G/s+LnyPx51rjUtJwrkts9ZpUSS3FGoqEWc1FxIgDG2C4y
        VQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnK519etkgx1TtCwezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBl7vv9kLvjFXnF++gemBsabbF2MnBwSAiYSlx9MA7K5OIQEdjNKfJt8kAUi
        ISnx+eI6JghbWGLlv+fsEEXNTBKbn+9gBEmwCWhJNH7tYgZJiAi8YpI4vGcGmMMscIFR4tbB
        bnaQKmEBR4lH3VfBRrEIqErcmzEDrJtXwErixZ8V7BAr5CVWbzjADGJzAsVbWjeB2UIClhKz
        fq1inMDIt4CRYRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnDsaGnuYNy+6oPeIUYm
        DsZDjBIczEoivMJPXyQL8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUI
        JsvEwSnVwNQpsXmt1c8bRct+ZZs6GjuyrHT57WlY/GnW6dfVF1+/rqyckZXH9WZnn5ipr9wl
        uUNXv3Rc8jMP/a372WZNSq6Yz9yUnkMBvM67fvb9sT8RaFAbUTpv22LdK40L954TNb/Glqcr
        fqufVWrfQqHjczVOVHnumf8vSv7kxifF9/nyLdhfnrLU2r7SpnT2wuAg6ZJQeW22fYayX9Ln
        TtWIm2b0W/xB+PWvG05uyaopPMDfyxP1fbLm1vqAeRr9kxL9H7XOqvbwzFp6UMSP0XmXQSwb
        50JB5ZPy/t47DH3Z+d1Epi7c8Uih5YV95T7LRUpp/uz3k23tOrUbnY50nytglbC6fU9dUOCZ
        2cGM2mYBJZbijERDLeai4kQAjgOM/AwDAAA=
X-CMS-MailID: 20230214121451epcas5p148118502c76299b2a6f389881fa296cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121451epcas5p148118502c76299b2a6f389881fa296cc
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121451epcas5p148118502c76299b2a6f389881fa296cc@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace devm_of_phy_get with devm_phy_get to get the
PHY pointer.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-samsung.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
index e6e2a8ab4403..719d284e1552 100644
--- a/drivers/pci/controller/dwc/pci-samsung.c
+++ b/drivers/pci/controller/dwc/pci-samsung.c
@@ -301,7 +301,6 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct samsung_pcie *sp;
-	struct device_node *np = dev->of_node;
 	int ret;
 
 	sp = devm_kzalloc(dev, sizeof(*sp), GFP_KERNEL);
@@ -311,7 +310,7 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	sp->pci.dev = dev;
 	sp->pci.ops = &dw_pcie_ops;
 
-	sp->phy = devm_of_phy_get(dev, np, NULL);
+	sp->phy = devm_phy_get(dev, "pcie_phy");
 	if (IS_ERR(sp->phy))
 		return PTR_ERR(sp->phy);
 
-- 
2.17.1

