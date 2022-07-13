Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F34572EFB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 09:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiGMHVX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 03:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiGMHVV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 03:21:21 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70ACB7D79
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 00:21:19 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220713072118euoutp0137104de4b51306732afe5f08a56aaa88~BUocpBKh60069000690euoutp01p
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 07:21:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220713072118euoutp0137104de4b51306732afe5f08a56aaa88~BUocpBKh60069000690euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657696878;
        bh=4jNX0/yddyFVvQxFkzzI7CauiT51RvLrIq2J6TvPY98=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aPvjlQaS3kUjkzC0GTmQ5tfwoAbRo13kIY+IxiPqUpCKNl9EN9hoGQI6caqjN64g4
         m3zI7IeltRA3/z0VUxZZoWiLjAwuA23VcTjShMtzQ4IVwXxlxtOEbWtrZlr7ScMw+Z
         M/gc54vweNmOybE5rnUQXdTs4TednbAn0mIU6gl4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220713072117eucas1p29eb373ae9098a8a60a37deb1b9daa535~BUocUQuMe2030220302eucas1p2P;
        Wed, 13 Jul 2022 07:21:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5F.D2.10067.D627EC26; Wed, 13
        Jul 2022 08:21:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220713072117eucas1p23fb25c2e8bba73200690d289f1b3e91a~BUob3xu_A1709117091eucas1p2M;
        Wed, 13 Jul 2022 07:21:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220713072117eusmtrp1100884715ea86a5599e26c49f557fc22~BUob2PgWB1724517245eusmtrp17;
        Wed, 13 Jul 2022 07:21:17 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-be-62ce726da2e9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.99.09038.D627EC26; Wed, 13
        Jul 2022 08:21:17 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220713072116eusmtip25f4dd7ce1fdc7f22c429782418585635~BUobTRrlA0202902029eusmtip2_;
        Wed, 13 Jul 2022 07:21:16 +0000 (GMT)
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
Subject: [PATCH v2 1/2] phy: samsung: phy-exynos-pcie: sanitize
 init/power_on callbacks
Date:   Wed, 13 Jul 2022 09:21:01 +0200
Message-Id: <20220713072102.2432-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned3conNJBkv+mVk8mLeNzWJJU4bF
        ii8z2S0uPO1hs9j7eiu7RUPPb1aLs/OOs1lMWPWNxWLG+X1MFi1/Wlgs1h65y27xf88Odoud
        d04wO/B67Jx1l91jwaZSj02rOtk87lzbw+bx5Mp0Jo/NS+o9+rasYvQ4fmM7k8fnTXIBnFFc
        NimpOZllqUX6dglcGa/vvGMseCdY8fLzJLYGxh7+LkZODgkBE4mfB1tZQWwhgRWMEm93BXUx
        cgHZXxglvp/8wwLhfGaUuDPpIjNMx9kDF1ghEssZJa7t/cEG13LlwX4mkCo2AUOJrrddbCC2
        iECixOZFXcwgRcwCy5klFq+dArZQWCBSYvbTnUANHBwsAqoSE+/Wg5i8AjYSm/usIJbJS6ze
        cACsVULgBIfE5W8rmEFqJARcJI7edYOoEZZ4dXwLO4QtI3F6cg8LREm+xN8ZxhDhColrr9dA
        3W8tcefcLzaQEmYBTYn1u/Qhwo4STZu3Qw3nk7jxVhAkzAxkTto2HSrMK9HRJgRRrSYx6/g6
        uJ0HL1yCKvGQ+NgqBwnNWInnp9uZJjDKzUJYtYCRcRWjeGppcW56arFRXmq5XnFibnFpXrpe
        cn7uJkZgejn97/iXHYzLX33UO8TIxMF4iFGCg1lJhPfP2VNJQrwpiZVVqUX58UWlOanFhxil
        OViUxHmTMzckCgmkJ5akZqemFqQWwWSZODilGpjSfZ73fWtj07t4u/w6r+ez+IuKaRs7DWxX
        btum8GDDt6of03luyorLBC05cOda+ga1ZSz/VNxcmFN18qdvW/mJUY/XymqfqzbHUYcczo5T
        k18ctr5TvGzGhVWXpjP+V9Nd/6PvZoiszsmI23HpgotD52rOVI6tuCkpuG9CidGbaReeL7KW
        9mf0nm/U/OZ9QsssM26nPc36T7IDV3+VPTsnVHfhtzX3pfbkVVtoLXuiOevOsaZC8foTrP/3
        OEq6r56Ze27OrP70dXx7VV9davu2YoJr0YzuShmLX4cCbM7OPnLy37mSo/uNZyfN7jXb89LS
        eN7KTvcXchKHxJ1nHNJtWGP8MV7YPj1FyCgm2CtSiaU4I9FQi7moOBEAAqKFYZ4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xe7q5ReeSDJqui1s8mLeNzWJJU4bF
        ii8z2S0uPO1hs9j7eiu7RUPPb1aLs/OOs1lMWPWNxWLG+X1MFi1/Wlgs1h65y27xf88Odoud
        d04wO/B67Jx1l91jwaZSj02rOtk87lzbw+bx5Mp0Jo/NS+o9+rasYvQ4fmM7k8fnTXIBnFF6
        NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Ga/vvGMs
        eCdY8fLzJLYGxh7+LkZODgkBE4mzBy6wgthCAksZJb6u9ISIy0icnNbACmELS/y51sXWxcgF
        VPOJUeJd10tGkASbgKFE11uQBCeHiECyxObzP8CKmAXWM0vsv36dCSQhLBAucfD1Y6BJHBws
        AqoSE+/Wg5i8AjYSm/usIObLS6zecIB5AiPPAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmb
        GIHhve3Yzy07GFe++qh3iJGJg/EQowQHs5II75+zp5KEeFMSK6tSi/Lji0pzUosPMZoCbZvI
        LCWanA+MsLySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqbs+bte
        H9vZceG66tWlLDp3Lk9b2Hkvozvk865NuYEZS5z3rlH9uEd6hQvrryPrDjKqzeiv967NuJWc
        Nr9rklVwp6Hlm/OMR1nVsjYen2v498EV9gXbCz1mrQ67Y8Vmost+7No23pxlWx7tb+BQXXV/
        fw7bOld/x6kfjwTozn/oMeE895dTMtd8pcs+POOY6DHT8tPfy6JWHP81JDynHdxcocTz4lt/
        fnXa6nOHTXfeOy+9QORF8kGz6hObI5eZ1CV0hT09uM4u+KLixdJEhykhXgZTdx79fOLrP5M3
        ktMz9F6anZ76hjfv/YMPWY55mvUik+ctir3pdk3zUm3Ryv83Pn/lOCTVlzwhNYHzg9H1a0os
        xRmJhlrMRcWJAEH29aT4AgAA
X-CMS-MailID: 20220713072117eucas1p23fb25c2e8bba73200690d289f1b3e91a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220713072117eucas1p23fb25c2e8bba73200690d289f1b3e91a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220713072117eucas1p23fb25c2e8bba73200690d289f1b3e91a
References: <CGME20220713072117eucas1p23fb25c2e8bba73200690d289f1b3e91a@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The exynos-pcie driver called phy_power_on() and then phy_init() for some
historical reasons. However the generic PHY framework assumes that the
proper sequence is to call phy_init() first, then phy_power_on(). The
operations done by both functions should be considered as one action and
as such they are called by the exynos-pcie driver (without doing anything
between them). The initialization is just a sequence of register writes,
which cannot be altered, without breaking the hardware operation.

To match the generic PHY framework requirement, simply call the
power_on() code directly from the init() callback and drop it from the
phy ops.  This way the driver will also work with the old (incorrect) PHY
initialization call sequence.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Suggested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- keep exynos5433_pcie_phy_power_on() function and call it directly from
  exynos5433_pcie_phy_init() as suggested by Vinod Koul
---
 drivers/phy/samsung/phy-exynos-pcie.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
index 578cfe07d07a..152f99762093 100644
--- a/drivers/phy/samsung/phy-exynos-pcie.c
+++ b/drivers/phy/samsung/phy-exynos-pcie.c
@@ -47,10 +47,15 @@ static void exynos_pcie_phy_writel(void __iomem *base, u32 val, u32 offset)
 }
 
 /* Exynos5433 specific functions */
+static int exynos5433_pcie_phy_power_on(struct phy *phy);
+
 static int exynos5433_pcie_phy_init(struct phy *phy)
 {
 	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
 
+	/* Power must be enabled in PMU before any other register write */
+	exynos5433_pcie_phy_power_on(phy);
+
 	regmap_update_bits(ep->fsysreg,	PCIE_EXYNOS5433_PHY_COMMON_RESET,
 			   PCIE_PHY_RESET, 1);
 	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_MAC_RESET,
@@ -135,7 +140,6 @@ static int exynos5433_pcie_phy_power_off(struct phy *phy)
 
 static const struct phy_ops exynos5433_phy_ops = {
 	.init		= exynos5433_pcie_phy_init,
-	.power_on	= exynos5433_pcie_phy_power_on,
 	.power_off	= exynos5433_pcie_phy_power_off,
 	.owner		= THIS_MODULE,
 };
-- 
2.17.1

