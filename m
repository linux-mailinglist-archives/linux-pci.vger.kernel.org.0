Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADD77EBE29
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 08:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjKOHdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 02:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjKOHdt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 02:33:49 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F97D112
        for <linux-pci@vger.kernel.org>; Tue, 14 Nov 2023 23:33:38 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231115073336epoutp02a0e67d117502fcf34a7b2ebc5c9e7400~Xu5ETwaYb3037230372epoutp02X
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 07:33:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231115073336epoutp02a0e67d117502fcf34a7b2ebc5c9e7400~Xu5ETwaYb3037230372epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700033616;
        bh=Ot6XbuGN6lt84Ly2hIjmWxtX0IZaFtitereS1H+e7eo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Iagev1axznxAxbgCNHjJ34IPOQwY8WzHydwiqdXM9UYEEgKfatyX4cye5ZRA+k5za
         +o8RFtjfroSGtvNfS9KUxOxrR5jTxa6Eye1KbsY3jT5qwXjaQR1p3w5P8PxK0f2qlI
         2PdELMplNlnqZiQRLjR8dC2ObLTcujO48O6OmONs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231115073335epcas5p4f13663a20b7421ae108e2a07e58a86c1~Xu5D428Qp1769117691epcas5p4r;
        Wed, 15 Nov 2023 07:33:35 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SVZf56S3Mz4x9Q6; Wed, 15 Nov
        2023 07:33:33 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.86.08567.D4474556; Wed, 15 Nov 2023 16:33:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231115065633epcas5p12b5d49ea13598aaee9d37fd787a6333d~XuYuUWeZV1634716347epcas5p1Z;
        Wed, 15 Nov 2023 06:56:33 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231115065633epsmtrp2f634156ccd9406c74f48fbecc079cd11~XuYuSk4HC2001120011epsmtrp2V;
        Wed, 15 Nov 2023 06:56:33 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-61-6554744d9bbc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.D5.07368.1AB64556; Wed, 15 Nov 2023 15:56:33 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231115065631epsmtip15ec21edb22ce60ce803851732649f84d~XuYsf4aSZ3097530975epsmtip11;
        Wed, 15 Nov 2023 06:56:31 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        jingoohan1@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v2] PCI: exynos: Adapt to clk_bulk_* APIs
Date:   Wed, 15 Nov 2023 12:26:21 +0530
Message-Id: <20231115065621.27014-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmpq5vSUiqwcZ7+hYP5m1js1jSlGGx
        4stMdou9r7eyWzT0/Ga12PT4GqvF5V1z2CzOzjvOZjHj/D4mi5Y/LSwWd1s6WS3+79nBbtF7
        uNaB12PnrLvsHgs2lXpsWtXJ5nHn2h42jydXpjN5bF5S79G3ZRWjx+dNcgEcUdk2GamJKalF
        Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUD3KimUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMxY+WctUsES6
        oq33AEsD406xLkZODgkBE4n5Ex+xdjFycQgJ7GaUuDR3MROE84lRYsHXqYwQzjdGibVPb7J0
        MXKAtfR26UDE9zJKtO0+yQ7htDJJPF+7lQlkLpuAlkTj1y5mEFtE4BCjxO8HYEXMAusYJT5P
        62IDSQgLWErMbX7DDDKVRUBVYtnkTJAwr4CVxKfuH4wQ98lLrN5wgBmkV0LgI7tE3/RbrBAJ
        F4nzVxawQNjCEq+Ob2GHsKUkPr/bywZhp0us3DyDGcLOkfi2eQkThG0vceDKHLBvmAU0Jdbv
        0ocIy0pMPbUOrIRZgE+i9/cTqHJeiR3zYGxliS9/90CtlZSYd+wy1DkeEts+PmIEGSkkECtx
        7nDdBEbZWQgLFjAyrmKUTC0ozk1PTTYtMMxLLYfHU3J+7iZGcCrUctnBeGP+P71DjEwcjMBQ
        42BWEuE1lwtJFeJNSaysSi3Kjy8qzUktPsRoCgyxicxSosn5wGScVxJvaGJpYGJmZmZiaWxm
        qCTO+7p1boqQQHpiSWp2ampBahFMHxMHp1QDE8OKpXbKZ2d6zAmNbag9o1HC4/P14L+pcbu/
        OLQeu3llI4NR9YRozl/PPqUIJMy6ckbjwf1fWzZE/HrZx+x+kO/ulhTxkyGbsl+m3zT9vCJS
        fFpy/EG+yGbui4tTNsVO2RUQ3Xrxl7jnSaau7JSPM79ELJMIdffucQzUn567L1hokVNFcJvd
        C49XXwvmXS45Uz5DQzJ65TL2m8cu7S1Pi/v/O8xjPdND668N9yYtrg9V5P72tnJKUqlRG+v2
        NSZMBfcX1LSe3HB8K9+GwnVnepfNT/GuL3v56YWZieGdS+Kv6ltbg65cTJ3/dEJOfOTtNSzN
        MXoGMd02l0JrPq/s1dh6r0usUtJq68bgfZwTzimxFGckGmoxFxUnAgAXScpTDgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnO7C7JBUg8VvRS0ezNvGZrGkKcNi
        xZeZ7BZ7X29lt2jo+c1qsenxNVaLy7vmsFmcnXeczWLG+X1MFi1/Wlgs7rZ0slr837OD3aL3
        cK0Dr8fOWXfZPRZsKvXYtKqTzePOtT1sHk+uTGfy2Lyk3qNvyypGj8+b5AI4orhsUlJzMstS
        i/TtErgyFj5Zy1SwRLqirfcASwPjTrEuRg4OCQETid4unS5GLg4hgd2MErvuX2HvYuQEiktK
        fL64jgnCFpZY+e85O0RRM5NEy8NDzCAJNgEticavXcwgCRGBM4wSZzuWsII4zAKbGCWmnv/J
        ClIlLGApMbf5DTPIOhYBVYllkzNBwrwCVhKfun8wQmyQl1i94QDzBEaeBYwMqxglUwuKc9Nz
        kw0LDPNSy/WKE3OLS/PS9ZLzczcxggNTS2MH4735//QOMTJxMB5ilOBgVhLhNZcLSRXiTUms
        rEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qB6V5j29f0ycGWM94x
        1C/Z//yQgwXnGpM+HxmBwod9503CZwecXmP74cO7pBaPE3oh2jGWRr/udoeKedhHnP325lV8
        Zsg3wxe7f3smXSt7KsPj2HQoR/ZJ1BGWyKvP0+q5Tk7zdN7y4fVn5aLvG+tF1/3+EHN+6bZY
        pnMKdcaWggUyee1qH8zeP0xLcDP+8MGnpGFC2NYLu9hcJ+sXP/o7tTe8Ofl+9JLit+W/z3sy
        GJ08/dl2ociCgytyv3Sx24ZtUohfxi5YYrwgYdYE5qY9fRfipq47mnT8YfSrDykvK3pt2001
        ZypuW9PU7rsy1ITL/zNXeFTD0++JETJPlrPKeh9KObxh8rEtvN+ExI/OUmIpzkg01GIuKk4E
        AABqtcu7AgAA
X-CMS-MailID: 20231115065633epcas5p12b5d49ea13598aaee9d37fd787a6333d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115065633epcas5p12b5d49ea13598aaee9d37fd787a6333d
References: <CGME20231115065633epcas5p12b5d49ea13598aaee9d37fd787a6333d@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no need to hardcode the clock info in the driver as driver can
rely on the devicetree to supply the clocks required for the functioning
of the peripheral. Get rid of the static clock info and obtain the
platform supplied clocks. The total number of clocks supplied is
obtained using the devm_clk_bulk_get_all() API and used for the rest of
the clk_bulk_* APIs.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
v1: https://lore.kernel.org/lkml/029a01da1334$dc1016c0$94304440$@samsung.com/T/
v2: Addressed Manivannan's comments to improve patch

 drivers/pci/controller/dwc/pci-exynos.c | 54 +++++++------------------
 1 file changed, 14 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 9e42cfcd99cc..520f744bb691 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -54,8 +54,8 @@
 struct exynos_pcie {
 	struct dw_pcie			pci;
 	void __iomem			*elbi_base;
-	struct clk			*clk;
-	struct clk			*bus_clk;
+	struct clk_bulk_data		*clks;
+	int				clk_cnt;
 	struct phy			*phy;
 	struct regulator_bulk_data	supplies[2];
 };
@@ -63,32 +63,17 @@ struct exynos_pcie {
 static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep)
 {
 	struct device *dev = ep->pci.dev;
-	int ret;
 
-	ret = clk_prepare_enable(ep->clk);
-	if (ret) {
-		dev_err(dev, "cannot enable pcie rc clock");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(ep->bus_clk);
-	if (ret) {
-		dev_err(dev, "cannot enable pcie bus clock");
-		goto err_bus_clk;
-	}
+	ep->clk_cnt = devm_clk_bulk_get_all(dev, &ep->clks);
+	if (ep->clk_cnt < 0)
+		return ep->clk_cnt;
 
-	return 0;
-
-err_bus_clk:
-	clk_disable_unprepare(ep->clk);
-
-	return ret;
+	return clk_bulk_prepare_enable(ep->clk_cnt, ep->clks);
 }
 
 static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)
 {
-	clk_disable_unprepare(ep->bus_clk);
-	clk_disable_unprepare(ep->clk);
+	clk_bulk_disable_unprepare(ep->clk_cnt, ep->clks);
 }
 
 static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
@@ -332,32 +317,20 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(ep->elbi_base))
 		return PTR_ERR(ep->elbi_base);
 
-	ep->clk = devm_clk_get(dev, "pcie");
-	if (IS_ERR(ep->clk)) {
-		dev_err(dev, "Failed to get pcie rc clock\n");
-		return PTR_ERR(ep->clk);
-	}
-
-	ep->bus_clk = devm_clk_get(dev, "pcie_bus");
-	if (IS_ERR(ep->bus_clk)) {
-		dev_err(dev, "Failed to get pcie bus clock\n");
-		return PTR_ERR(ep->bus_clk);
-	}
+	ret = exynos_pcie_init_clk_resources(ep);
+	if (ret)
+		return ret;
 
 	ep->supplies[0].supply = "vdd18";
 	ep->supplies[1].supply = "vdd10";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ep->supplies),
 				      ep->supplies);
 	if (ret)
-		return ret;
-
-	ret = exynos_pcie_init_clk_resources(ep);
-	if (ret)
-		return ret;
+		goto fail_regulator;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
 	if (ret)
-		return ret;
+		goto fail_regulator;
 
 	platform_set_drvdata(pdev, ep);
 
@@ -369,8 +342,9 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 
 fail_probe:
 	phy_exit(ep->phy);
-	exynos_pcie_deinit_clk_resources(ep);
 	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+fail_regulator:
+	exynos_pcie_deinit_clk_resources(ep);
 
 	return ret;
 }
-- 
2.17.1

