Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D780D55F0D2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 00:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiF1WEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 18:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiF1WEs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 18:04:48 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CB43192B
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 15:04:45 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220628220444euoutp0262bbd054f9ae00075688a9f7accbccd4~86AgMrxhF0922209222euoutp02U
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 22:04:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220628220444euoutp0262bbd054f9ae00075688a9f7accbccd4~86AgMrxhF0922209222euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656453884;
        bh=exa0+7mGTbs6eL6QisdXi5zwNYCWE5dMg+qkLbCg7ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/Wh3aBoqZYQIpde4FiZBQQ9aiL82F9F5KsfQKXslkIoyp3n6OUakZY0HNnGcEi+H
         /VneCWBDAwo/sqtHWxsILpfkkRUfObziBPTYasJolwg1cWaWMY30I46QofQpXMekpj
         up68zbifkffFoJl0R+CdcG0eiZVty1ViQGct7SuQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220628220442eucas1p146d4860a82b5d33eedbb5dc6401cb592~86Ae41PQp0504705047eucas1p1C;
        Tue, 28 Jun 2022 22:04:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6E.2A.09580.AFA7BB26; Tue, 28
        Jun 2022 23:04:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220628220441eucas1p2098d46abc47ec1888781fdc5319dec67~86Ad97R-C2729927299eucas1p2E;
        Tue, 28 Jun 2022 22:04:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220628220441eusmtrp1f79a38c03c3ac7a26043569705fbde67~86Ad9FSi-3076730767eusmtrp1-;
        Tue, 28 Jun 2022 22:04:41 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-f7-62bb7afa9f39
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AB.51.09095.9FA7BB26; Tue, 28
        Jun 2022 23:04:41 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220628220441eusmtip24036728110aa13d074fa1dbc9f26e7e3~86AdXA3N31017610176eusmtip2U;
        Tue, 28 Jun 2022 22:04:41 +0000 (GMT)
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
Subject: [PATCH 2/2] PCI: dwc: exynos: Correct generic PHY usage
Date:   Wed, 29 Jun 2022 00:04:09 +0200
Message-Id: <20220628220409.26545-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220628220409.26545-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7q/qnYnGcyboWXxYN42NoslTRkW
        K77MZLe48LSHzWLv663sFg09v1ktzs47zmYxYdU3FosZ5/cxWbT8aWGxWHvkLrvF/z072C12
        3jnB7MDrsXPWXXaPBZtKPTat6mTzuHNtD5vHkyvTmTw2L6n36NuyitHj+I3tTB6fN8kFcEZx
        2aSk5mSWpRbp2yVwZTy/8Y69YA5nxeSr11kbGD+wdzFyckgImEgc+NLE2MXIxSEksIJRYl3f
        biYI5wujRM+iZVCZz4wSRyceZoJpObm8jQ0isZxRYsfPT+xwLRfa/4BVsQkYSnS97WIDsUUE
        EiU2L+piBiliFljOLLF47RRWkISwgIPE/zO7GEFsFgFViR1NZ8DivAK2Ej33njNCrJOXWL3h
        ADOIzSlgJ/FjzV2wQRICdzgk3q65wAxR5CKx++QlKFtY4tXxLVDvyUicntzD0sXIAWTnS/yd
        YQwRrpC49noNVLm1xJ1zv9hASpgFNCXW79KHCDtKbGxYzQjRySdx460gSJgZyJy0bTozRJhX
        oqNNCKJaTWLW8XVwOw9egLnFQ2JX7ztoiE5klFjydyX7BEb5WQjLFjAyrmIUTy0tzk1PLTbO
        Sy3XK07MLS7NS9dLzs/dxAhMQaf/Hf+6g3HFq496hxiZOBgPMUpwMCuJ8C48szNJiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA9NM8VfzC657ms5dKB39
        +tyU98eXPAg7eFI273nmySz37IWTex76pNqFzDrts8z31u0G/zy3lVcCWrLa5xXl/erT/6+c
        dmL7A081xlUlH/a4aG55+2jNxIuPf5tJ7i5MFshhmMPj9DR8rgnDggpV32fdH/pDN9/rvyw/
        Raj4YL2eWiFzf7Zfy87F366e5J77R/dKm8GvbvHkoIKbs9rD18i0P77orVASxDqHZ11Ia3WX
        MW/RjeKt07nvrBW5XjDL5e0GBg+2iyKdbYf2xQof+qGXN1nnZpqwn6/r6t3xOUJHfpqt2xKi
        4Puz4dW3/ZyVTJ+29EzMnDtb4qk7+92jey9eWn/p2WwD5hsHVut0XfinxFKckWioxVxUnAgA
        eQdKC7ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4Pd2fVbuTDPpnalk8mLeNzWJJU4bF
        ii8z2S0uPO1hs9j7eiu7RUPPb1aLs/OOs1lMWPWNxWLG+X1MFi1/Wlgs1h65y27xf88Odoud
        d04wO/B67Jx1l91jwaZSj02rOtk87lzbw+bx5Mp0Jo/NS+o9+rasYvQ4fmM7k8fnTXIBnFF6
        NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gc9vvGMv
        mMNZMfnqddYGxg/sXYycHBICJhInl7exdTFycQgJLGWUaDvbBJWQkTg5rYEVwhaW+HOtC6ro
        E6PElm0tYAk2AUOJrrcgCU4OEYFkic3nf4AVMQusZ5bYf/06E0hCWMBB4v+ZXYwgNouAqsSO
        pjNgzbwCthI9954zQmyQl1i94QAziM0pYCfxY81dMFsIqOb8i7esExj5FjAyrGIUSS0tzk3P
        LTbUK07MLS7NS9dLzs/dxAiMim3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeBee2ZkkxJuSWFmV
        WpQfX1Sak1p8iNEU6I6JzFKiyfnAuMwriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5N
        LUgtgulj4uCUamCyXHHjdynDrLmz5LYtL6iS3yhhrJO27sL+9gSjk7F+v77f7n+0t9OW3f+P
        zC3fI7dqV7MVTluQFHn9uWaI/Z+khnbOEie2+xIS5nYRzLc3ZCzeae6iX63Rtmnl0XyL04lP
        fs6ob5HP0Fhlo1B7miFp7fdFQcl+13J3ZE2Yd/SqmMZmH86f89/qmMx7sn5p/ic1ptaJW6Xr
        ck7GN+ZnveJetW7vHvPQQ9pO5zs18/oTpz+z3Zdcp6wfsqeQP6w8Iu+4wY1HK4str084mRkY
        4zrp6J0Qi3OnWN64b+iKWvDpFvOpj9uu2p6eeHlXmu8s8RP5XMZSGauTzJwLbthY6eazHPz/
        tlT83Pydbbl7tssqsRRnJBpqMRcVJwIAXDJ6rBMDAAA=
X-CMS-MailID: 20220628220441eucas1p2098d46abc47ec1888781fdc5319dec67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220628220441eucas1p2098d46abc47ec1888781fdc5319dec67
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220628220441eucas1p2098d46abc47ec1888781fdc5319dec67
References: <20220628220409.26545-1-m.szyprowski@samsung.com>
        <CGME20220628220441eucas1p2098d46abc47ec1888781fdc5319dec67@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
The exynos-pcie PHY driver has been adjusted for this change in the
previous patch.
---
 drivers/pci/controller/dwc/pci-exynos.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 467c8d1cd7e4..0d490ae52874 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -258,9 +258,8 @@ static int exynos_pcie_host_init(struct pcie_port *pp)
 
 	exynos_pcie_assert_core_reset(ep);
 
-	phy_reset(ep->phy);
-	phy_power_on(ep->phy);
 	phy_init(ep->phy);
+	phy_power_on(ep->phy);
 
 	exynos_pcie_deassert_core_reset(ep);
 	exynos_pcie_enable_irq_pulse(ep);
-- 
2.17.1

