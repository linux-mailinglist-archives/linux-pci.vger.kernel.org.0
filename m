Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7955F0D0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 00:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiF1WEq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 18:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiF1WEq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 18:04:46 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073943123F
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 15:04:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220628220438euoutp0203b7f119a130703eaccc52de1ad91f9d~86AbCkVLn0922209222euoutp02R
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 22:04:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220628220438euoutp0203b7f119a130703eaccc52de1ad91f9d~86AbCkVLn0922209222euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656453878;
        bh=XEuq3SoUCY32rfJJrgZxojZUmItQVq6RytvcYj0hSbs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Y+BJsk26H5ToRd6tJGulIcbbwZdtDuj6xhebV+W5pzpP/DHvBE6oyQ0RyeuN4PtyI
         o24SWBAtVq1KfE+DolHPDpwsNWuUygLnH4huMPKxlmY66y34v+ep2scyIFdHAXY5hD
         Wz5VVPzDRmjBM4UKGinUIgQB9LUvEVMJuR90VpsQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220628220437eucas1p1998d971649c75eed01ed6305cbd7dd8b~86AaKlB_l1022110221eucas1p13;
        Tue, 28 Jun 2022 22:04:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B3.DB.10067.5FA7BB26; Tue, 28
        Jun 2022 23:04:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220628220437eucas1p2c478751458323f93a71050c4a949f12e~86AZy9Opa2730027300eucas1p2A;
        Tue, 28 Jun 2022 22:04:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220628220437eusmtrp1b00e467e1f8bff9ce14904891ffe86d7~86AZx69k03076730767eusmtrp1_;
        Tue, 28 Jun 2022 22:04:37 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-db-62bb7af5cce6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 71.51.09038.5FA7BB26; Tue, 28
        Jun 2022 23:04:37 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220628220436eusmtip286b1356ea04d39555a4a5a75b064c1f1~86AZKJcH31092910929eusmtip2b;
        Tue, 28 Jun 2022 22:04:36 +0000 (GMT)
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
Subject: [PATCH 1/2] phy: samsung: phy-exynos-pcie: sanitize init/power_on
 callbacks
Date:   Wed, 29 Jun 2022 00:04:08 +0200
Message-Id: <20220628220409.26545-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa1BMcRjG53/O7jmn1XLajf5EWArNlJCZY1xzGWf4QI3xoYY6OF1oK3va
        LRkjNtJaizK23Sgq00XZbKm226hoMysSk1uNmBjTZSgJubadxbfnfZ7nN8+Xl0AlZ4UziKiY
        eFYRw0TLMJGgsuXbA5/PSbV7/DLavame7EqMyj8eSRWOGHCq/a0Wo+r7b+FUsva7kGrLtmLU
        ueJRAZX5sAGhUn6kCKjSO9049buuGqcsXa3oOjFtMXbj9BWzkjYXp2F0V2cdRvc+0SN0ef5R
        WldRDGjrsyqE/mT22O4ULFq1j42OUrGKxWvCRJEDneVoXNO0xKL3ZwTJ4KJUA5wISPrDosYc
        RANEhIQsBLDid5uQP0YArK0aBPzxCcCx0X78L3Jn+KkDKQCwsKUZ/4eUtJ0A9hZGLoGaQQ1m
        164kA8tzNai9hJIFKMwrvSC0B1JyJ+zIbJwoCUhPaOgbmoDF5Gr4MzvfMTcbXi+7PQFDspWA
        VTfTUD7YCGtHrYDXUthnrXAAM6EtQyvQAGJcx8Kfmct4OxF29pc40JWw68EYZq+g5CJoqlnM
        2wHw1bGrCE9Ohs8GXew2Oi7TK/Uob4vhqZMSvu0FjdYb/zYb2zscFRoa1IF2W0Lugr3G09g5
        4GH8P3UFgGLgxio5eQTLLY1hE3w5Rs4pYyJ898bKzWD8Z2y/rCPVoKBvyLcJIARoApBAZa7i
        q/cteyTifcyhJFYRG6pQRrNcE3AnBDI38d6oMkZCRjDx7AGWjWMVf1OEcJqRjJw/8eRxhcst
        2+t4n0kpN4ryJ1eH5MUe2X9wQPeyMy7B0JzrVZLUor8UINN7e69NCp4bOhUL37pDury8YV3g
        nJsLRf3C8PSX9VlBzpzJv1SdmrKhF4Z/HPbUpgadcskp29Qb3pFD01NCBi7BrOv1gUjg7vlP
        X0C/5VFaq/mNOjXxbrdyh236MnyO7YunXv38kXuEYb0uLEERaqIUhZXK9CGpSf7usO4yk9V1
        wBKfm5B291prtbP/i57H97xq5N9dfT4Me8jeWA+2q6bMcttY5ZylqvP7mqw2Bl2euwKXpwfU
        cJptphXu4iPZee8DNuvUqkyPLbJ5nxf0WOrDulWvzo7JBFwks8QbVXDMH/uuzXSiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t/xe7pfq3YnGfw5wmPxYN42NoslTRkW
        K77MZLe48LSHzWLv663sFg09v1ktzs47zmYxYdU3FosZ5/cxWbT8aWGxWHvkLrvF/z072C12
        3jnB7MDrsXPWXXaPBZtKPTat6mTzuHNtD5vHkyvTmTw2L6n36NuyitHj+I3tTB6fN8kFcEbp
        2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZby5tpm5
        4JBYxcoXvSwNjNOEuxg5OSQETCSOfLrO1MXIxSEksJRR4uSVg0wQCRmJk9MaWCFsYYk/17rY
        IIo+MUpc+7MVLMEmYCjR9RYkwckhIpAssfn8D7AiZoH1zBL7r18HmyQsECKxpKeLBcRmEVCV
        mPnqIyOIzStgK/F33hJ2iA3yEqs3HGCewMizgJFhFaNIamlxbnpusZFecWJucWleul5yfu4m
        RmCQbzv2c8sOxpWvPuodYmTiYDzEKMHBrCTCu/DMziQh3pTEyqrUovz4otKc1OJDjKZA+yYy
        S4km5wPjLK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSniwMNL
        jwPWT7jOI9d3Lm2XQ4LyvjvBXR0b5D277Pn/2/ytNli4Xf73tWM6N4MW38gPXvPkc65AbZxe
        c/hXCVelOxEW8xaV5D+pdbct3Pd8u9c0gS0dDqsPdu9klzR6XHBAPT3yQgaLwcSfMXEdnhcv
        cC0LM668/eCWrQ7/lOmGLBNSHBiCm+cpvCnVOPpt7587XTW/uGuFD8iuSb/o0Syo6hUbYfPi
        3MyDbi+mb5yxeep/no0PJuocKXfUNVeW9Whcdc5XZ8aJC6uS1t+deSp378x7zkZpm05w/9zr
        v/SrQZHsL7tLfoyeqYvcwkx2dbO03EuP8AyQXnco7VBMW2Mne2Ro1fwNjtx7OBLaVimxFGck
        GmoxFxUnAgCPG9qD+wIAAA==
X-CMS-MailID: 20220628220437eucas1p2c478751458323f93a71050c4a949f12e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220628220437eucas1p2c478751458323f93a71050c4a949f12e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220628220437eucas1p2c478751458323f93a71050c4a949f12e
References: <CGME20220628220437eucas1p2c478751458323f93a71050c4a949f12e@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

To match the generic PHY framework requirement, simply move all register
writes to the phy_init()/phy_exit() and drop power_on()/power_off()
callbacks. This way the driver will also work with the old (incorrect)
PHY initialization call sequence.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/phy/samsung/phy-exynos-pcie.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
index 578cfe07d07a..53c9230c2907 100644
--- a/drivers/phy/samsung/phy-exynos-pcie.c
+++ b/drivers/phy/samsung/phy-exynos-pcie.c
@@ -51,6 +51,13 @@ static int exynos5433_pcie_phy_init(struct phy *phy)
 {
 	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
 
+	regmap_update_bits(ep->pmureg, EXYNOS5433_PMU_PCIE_PHY_OFFSET,
+			   BIT(0), 1);
+	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_GLOBAL_RESET,
+			   PCIE_APP_REQ_EXIT_L1_MODE, 0);
+	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_L1SUB_CM_CON,
+			   PCIE_REFCLK_GATING_EN, 0);
+
 	regmap_update_bits(ep->fsysreg,	PCIE_EXYNOS5433_PHY_COMMON_RESET,
 			   PCIE_PHY_RESET, 1);
 	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_MAC_RESET,
@@ -109,20 +116,7 @@ static int exynos5433_pcie_phy_init(struct phy *phy)
 	return 0;
 }
 
-static int exynos5433_pcie_phy_power_on(struct phy *phy)
-{
-	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
-
-	regmap_update_bits(ep->pmureg, EXYNOS5433_PMU_PCIE_PHY_OFFSET,
-			   BIT(0), 1);
-	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_GLOBAL_RESET,
-			   PCIE_APP_REQ_EXIT_L1_MODE, 0);
-	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_L1SUB_CM_CON,
-			   PCIE_REFCLK_GATING_EN, 0);
-	return 0;
-}
-
-static int exynos5433_pcie_phy_power_off(struct phy *phy)
+static int exynos5433_pcie_phy_exit(struct phy *phy)
 {
 	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
 
@@ -135,8 +129,7 @@ static int exynos5433_pcie_phy_power_off(struct phy *phy)
 
 static const struct phy_ops exynos5433_phy_ops = {
 	.init		= exynos5433_pcie_phy_init,
-	.power_on	= exynos5433_pcie_phy_power_on,
-	.power_off	= exynos5433_pcie_phy_power_off,
+	.exit		= exynos5433_pcie_phy_exit,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.17.1

