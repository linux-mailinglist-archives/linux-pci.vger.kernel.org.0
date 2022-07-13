Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867E8572EFE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 09:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiGMHVY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 03:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGMHVW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 03:21:22 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92CABA157
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 00:21:19 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220713072118euoutp02bd27b51d499c353f8e2234993b38c014~BUodDNiB11646316463euoutp02m
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 07:21:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220713072118euoutp02bd27b51d499c353f8e2234993b38c014~BUodDNiB11646316463euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657696878;
        bh=2Ta3TuKGXv0L3LTBVhBgRdKPCtOl8ZEL6TkDPEKZdKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8DONIDVg1bz6dplvApktSxCBim0vBcNPjq8ezqszXsVwuIIb1bJhl1N8ckf1QJHQ
         VvAU77QbZTkQH14Z+a3buvK6XujIJwKKettKfxFqRKbaOoAzPm1q6iEVeUxmlnSB88
         9z22V6ZVDcPI6AqUcr7mR1NFAKRzvZpkisbCle3U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220713072118eucas1p211eb0ed80a20187f92dcd49cd17ba124~BUocsHaZF0420804208eucas1p2A;
        Wed, 13 Jul 2022 07:21:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 30.E2.10067.E627EC26; Wed, 13
        Jul 2022 08:21:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220713072117eucas1p1a41eabf7c568cff1b02ea79bfa400b7b~BUocUpzjb1173411734eucas1p1Q;
        Wed, 13 Jul 2022 07:21:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220713072117eusmtrp1db1b162ed8808e49901a9f55147a58e0~BUocT05ce1722217222eusmtrp1C;
        Wed, 13 Jul 2022 07:21:17 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-bf-62ce726e95c8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 10.A9.09038.D627EC26; Wed, 13
        Jul 2022 08:21:17 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220713072117eusmtip2e317ba649f98c633f0d8159fd7a7cbc8~BUobyfbEt3224832248eusmtip2D;
        Wed, 13 Jul 2022 07:21:17 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 2/2] PCI: dwc: exynos: Correct generic PHY usage
Date:   Wed, 13 Jul 2022 09:21:02 +0200
Message-Id: <20220713072102.2432-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713072102.2432-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djP87p5ReeSDD4/E7B4MG8bm8WSpgyL
        FV9msltceNrDZrH39VZ2i4ae36wWZ+cdZ7OYsOobi8WM8/uYLFr+tLBYrD1yl93i/54d7BY7
        75xgduD12DnrLrvHgk2lHptWdbJ53Lm2h83jyZXpTB6bl9R79G1Zxehx/MZ2Jo/Pm+QCOKO4
        bFJSczLLUov07RK4Mi79XMlWsIOzomXTO6YGxikcXYycHBICJhIzznUzdjFycQgJrGCUmPqt
        nQnC+cIo8bdzITOE85lR4s/zs6wwLS+2zIZqWc4oMWfSeWa4lqXHljGCVLEJGEp0ve1iA7FF
        BBIlNi/qAitiFljOLLF47RSwUcICzhI3fp0CK2IRUJVoPLubBcTmFbCR2LrrChPEOnmJ1RsO
        MIPYnAK2EhdnPWEDGSQh8IBD4vqey1BFLhJX30+Guk9Y4tXxLewQtozE6ck9QEM5gOx8ib8z
        jCHCFRLXXq9hhrCtJe6c+8UGUsIsoCmxfpc+RNhRYukNkJtBOvkkbrwVBAkzA5mTtk2HCvNK
        dLQJQVSrScw6vg5u58ELl6BKPCRe3CyChM4ERokl6zayT2CUn4WwawEj4ypG8dTS4tz01GKj
        vNRyveLE3OLSvHS95PzcTYzABHT63/EvOxiXv/qod4iRiYPxEKMEB7OSCO+fs6eShHhTEiur
        Uovy44tKc1KLDzFKc7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTDVlH97fuOEyxM/ToUd
        Rzx5Yp6usbk942NRd2nY/dMdD/x+hT50mN5W+N0wZDnfuQnKHjnNocJvLlxK3BIRlNPRuGJR
        yO9p5mvVT9+YW8Y6sfgss++tS4pP3+k+fHorstXa+eH7qzE7v3Wf8X/WcvDC7wdF176H39YX
        Klh3c+OUpMUlnWlieo+dr6+QSuO4NP9tQEg7x7SNX1dkdZ70uXqieILPBptbS6qEPkirihjv
        coj8GNi/w431Qk3iU8/fDU6eu3ziN3fG/zIIdjl0R+28RtMMzY1RfuzcM2x/u8n6slhlxew5
        w9DBkT778Aet1S7b+EXmfJB/176aVd6vuHFrYmiVav7MiDNZD0WLPDcosRRnJBpqMRcVJwIA
        RLUQY68DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4Pd3conNJBid/mFk8mLeNzWJJU4bF
        ii8z2S0uPO1hs9j7eiu7RUPPb1aLs/OOs1lMWPWNxWLG+X1MFi1/Wlgs1h65y27xf88Odoud
        d04wO/B67Jx1l91jwaZSj02rOtk87lzbw+bx5Mp0Jo/NS+o9+rasYvQ4fmM7k8fnTXIBnFF6
        NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GZd+rmQr
        2MFZ0bLpHVMD4xSOLkZODgkBE4kXW2YzdjFycQgJLGWU6Lp+lxEiISNxcloDK4QtLPHnWhcb
        RNEnRomGyUdZQBJsAoYSXW9BEpwcIgLJEpvP/wArYhZYzyyx//p1JpCEsICzxI1fp8CKWARU
        JRrP7gZr5hWwkdi66woTxAZ5idUbDjCD2JwCthIXZz0BqxcCquma9ZF5AiPfAkaGVYwiqaXF
        uem5xUZ6xYm5xaV56XrJ+bmbGIFRse3Yzy07GFe++qh3iJGJg/EQowQHs5II75+zp5KEeFMS
        K6tSi/Lji0pzUosPMZoC3TGRWUo0OR8Yl3kl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp
        2ampBalFMH1MHJxSDUwlZw5mp1Q57VQKKBDeVrXDRfV0rvY133Nnt8nH75u77N+u1QHCu34V
        O1Q0Lj34/M/m+tPvj855tdResvFj/4H23OLzGv++zJojLnC4+8SriNOXwncXCS7Oz7nl+2DZ
        YguGne+39Cy7fvpBopv3EtZtwt62xk1V/h7l87tenHz3RHj/9MdB5Wu3XDNcUXzJw+2LdQiT
        kst37v+VHWZzBDn+Cx2/e+cQh46VzE6nRXf8J72zyeA7/Orffx3mNSs25vw98/x0TPM2idul
        lu4i7TEfjD9om4uFr897/S2m9t/KY2tyrU2+eRXvUWZRyErkW72oxHzBLye/1XMWZlm+6J70
        bU3BlcjV7cJFizZUnz1jrcRSnJFoqMVcVJwIAF3FiEATAwAA
X-CMS-MailID: 20220713072117eucas1p1a41eabf7c568cff1b02ea79bfa400b7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220713072117eucas1p1a41eabf7c568cff1b02ea79bfa400b7b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220713072117eucas1p1a41eabf7c568cff1b02ea79bfa400b7b
References: <20220713072102.2432-1-m.szyprowski@samsung.com>
        <CGME20220713072117eucas1p1a41eabf7c568cff1b02ea79bfa400b7b@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The proper initialization for generic PHYs is to call first phy_init(),
then phy_power_on().

While touching this, lets remove the phy_reset() call. It is just a
left-over from the obsoleted Exynos5440 support and current exynos-pcie
PHY driver doesn't even support this function. It is also rarely used by
other drivers.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pci/controller/dwc/pci-exynos.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 2044d191fba6..6d0742207f43 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -258,9 +258,8 @@ static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
 
 	exynos_pcie_assert_core_reset(ep);
 
-	phy_reset(ep->phy);
-	phy_power_on(ep->phy);
 	phy_init(ep->phy);
+	phy_power_on(ep->phy);
 
 	exynos_pcie_deassert_core_reset(ep);
 	exynos_pcie_enable_irq_pulse(ep);
-- 
2.17.1

