Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE266966BA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjBNO00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjBNO0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:26:15 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE592A98E
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:26:10 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230214140805epoutp02597d73aa10b2f86d7b289937622aded6~DthRqvCPz1101811018epoutp02X
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:08:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230214140805epoutp02597d73aa10b2f86d7b289937622aded6~DthRqvCPz1101811018epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383685;
        bh=ioxxE2VMA3x/A6W1QH3U2KDW+tzmDt8bOgi0sTzKxc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gN9lO+NLrJKU7rTknLKZxqsbbGo/EXYnTPMNf+aOnASKXvldfAtToR3xTbHIyVKTe
         BdgjwD24le0C/xZ+kzeB9fXYCcKGH0jCapqMysof+OnmJT+IEL0kTIrGxvXAXtXmWr
         ZH05CPx0Q8KdgswEWbFNpEImg3pdOF8bpIRqcl2M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230214140804epcas5p30ff8e85dcfbdbc952799e15edf18b41c~DthQus8hM1511815118epcas5p3A;
        Tue, 14 Feb 2023 14:08:04 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PGNMk6qZ0z4x9Pp; Tue, 14 Feb
        2023 14:08:02 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.48.06765.2C59BE36; Tue, 14 Feb 2023 23:08:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230214121420epcas5p3a4419059969adfb45b379f7e7741968c~Dr99u__hD2330023300epcas5p3D;
        Tue, 14 Feb 2023 12:14:20 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230214121420epsmtrp13d02d0e29655688e26ac6ba69407ec66~Dr99t3azt1788717887epsmtrp11;
        Tue, 14 Feb 2023 12:14:20 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-3f-63eb95c2e239
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.FA.17995.C1B7BE36; Tue, 14 Feb 2023 21:14:20 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121417epsmtip10da7614a02844143b442ca0c139b0737~Dr968m25i2493724937epsmtip1R;
        Tue, 14 Feb 2023 12:14:17 +0000 (GMT)
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
Subject: [PATCH 04/16] PCI: samsung: Use clock bulk API to get clocks
Date:   Tue, 14 Feb 2023 17:43:21 +0530
Message-Id: <20230214121333.1837-5-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmpu6hqa+TDVb9MLF4MG8bm8WSpgyL
        +UfOsVrM2jaX0eLj73MsFiu+zGS36HvxkNmioec3q8Wmx9dYLS7vmsNmcXbecTaLGef3MVm0
        /GlhsWg52s5isfbIXXaLRVu/sFv837OD3eLP9A8sFr2Hay02b5rK7CDi8WbTd3aPnbPusnss
        2FTqsWlVJ5vHnWt72DzenTvH7vHkynQmj81L6j02vtvB5LGo4SObR9+WVYwenzfJBfBEZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAL2ppFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO+DBl
        FlvBRrGKzTf2MDUwbhLqYuTkkBAwkfg34wN7FyMXh5DAbkaJnq7lzBDOJ0aJq68fskA4nxkl
        Nuy+ywzTMuXbOqiqXYwSd86cZ4NwWpkkGh7/YgWpYhPQkmj82gVWJSJwi0ni5eeHYFuYBU4x
        Shx4sZcdpEpYwFViwtqnYDaLgKrEy/MTwGxeAUuJxVemQe2Tl1i94QCYzSlgJdHSugkqfoVD
        4v5HAQjbRaK/AeY+YYlXx7ewQ9hSEi/726DsdImVm2dA1eRIfNu8hAnCtpc4cGUO0KMcQMdp
        SqzfpQ8RlpWYemodWAmzAJ9E7+8nUOW8EjvmwdjKEl/+7mGBsCUl5h27zAphe0i8Pd3EBAmV
        XkaJU5seM01glJuFsGIBI+MqRsnUguLc9NRi0wLjvNRyeLwl5+duYgQnZi3vHYyPHnzQO8TI
        xMF4iFGCg1lJhFf46YtkId6UxMqq1KL8+KLSnNTiQ4ymwPCbyCwlmpwPzA15JfGGJpYGJmZm
        ZiaWxmaGSuK86rYnk4UE0hNLUrNTUwtSi2D6mDg4pRqYil2/z2JndFrdmpfpYhTjcbDnT9rt
        1VkG5zZu3ZzTJF0hHT6f7QlfbqnrF4fGxH86fHcZNOO0d89i8Hsbpx3Tefu4/JyDLIJGQduU
        V+z+K/BgS/SXS/zxibd/HJr3bGbB7pTN/9fMm3PFNcPv9emn4rNPRMzx+Tj1U+9UsU3RK89f
        OhgwdyPLjjCFCWlGE1y4VLcZpr9lLTjW6sl5VedyoEM/i2KLaPdztQ01bRtr5+1dvs8kyE3l
        dBy7b+GJX24r/6tse7Tsb/sDvcP+qmlV9dudO+LsnKM4mIRnFfAWbPxwVTDDd9I+3r2Ht7N3
        LpXXajDN3+C6ZkLZOad0uRs5EzlnyZZI7j5Xx+i1wvyIEktxRqKhFnNRcSIAedylllUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnK5M9etkg542EYsH87axWSxpyrCY
        f+Qcq8WsbXMZLT7+PsdiseLLTHaLvhcPmS0aen6zWmx6fI3V4vKuOWwWZ+cdZ7OYcX4fk0XL
        nxYWi5aj7SwWa4/cZbdYtPULu8X/PTvYLf5M/8Bi0Xu41mLzpqnMDiIebzZ9Z/fYOesuu8eC
        TaUem1Z1snncubaHzePduXPsHk+uTGfy2Lyk3mPjux1MHosaPrJ59G1ZxejxeZNcAE8Ul01K
        ak5mWWqRvl0CV8aHKbPYCjaKVWy+sYepgXGTUBcjJ4eEgInElG/rmLsYuTiEBHYwSmy40MII
        kZCU+HxxHROELSyx8t9zdoiiZiaJax1/wYrYBLQkGr92gXWLCLxikji8ZwaYwyxwgVHi1sFu
        dpAqYQFXiQlrn4LZLAKqEi/PTwCzeQUsJRZfmcYMsUJeYvWGA2A2p4CVREvrJjBbCKhm1q9V
        jBMY+RYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOHS2tHYx7Vn3QO8TIxMF4
        iFGCg1lJhFf46YtkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZ
        ODilGpjaeE+9Nt/ZtZOhhVU37mza/y+1MaI6J/9YSE3l/vzep5frkS4bj9CLCKe6BhG5XDeV
        iOW9uaUiNavWfLcx+3Z6Y5Zn24HYG4ERbBL3n83SS05zfbaroyH72cnJ/Hxz1wpVnk19l9/C
        serDy20lu3J7Dsx/slvLuyfzu7A1h8PChm9Hyw66HXjz6WrOkb375k1k6sy6v+3qns4Xe75c
        z3bLv8g1rTbQ/P7Z/zZvKsXP/VzQvSUn/8ACF76OZXe8uxbq69lvY9n4IGnZzRs5k0x1HOQT
        A++s2vB4+wnW0h0LHB9d6LC8EutyMzfq/flD257dU/nn6lCpbbWVIfOUQq/HtSMbI9ZyBbye
        6pqX2aGlxFKckWioxVxUnAgAgak7egwDAAA=
X-CMS-MailID: 20230214121420epcas5p3a4419059969adfb45b379f7e7741968c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121420epcas5p3a4419059969adfb45b379f7e7741968c
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121420epcas5p3a4419059969adfb45b379f7e7741968c@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adopt to clock bulk API to handle clocks.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-samsung.c | 46 ++++++------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
index cfe384aee754..6c07d3f151be 100644
--- a/drivers/pci/controller/dwc/pci-samsung.c
+++ b/drivers/pci/controller/dwc/pci-samsung.c
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
@@ -65,30 +65,18 @@ static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep)
 	struct device *dev = ep->pci.dev;
 	int ret;
 
-	ret = clk_prepare_enable(ep->clk);
-	if (ret) {
-		dev_err(dev, "cannot enable pcie rc clock");
+	ret = devm_clk_bulk_get_all(dev, &ep->clks);
+	if (ret < 0)
 		return ret;
-	}
 
-	ret = clk_prepare_enable(ep->bus_clk);
-	if (ret) {
-		dev_err(dev, "cannot enable pcie bus clock");
-		goto err_bus_clk;
-	}
+	ep->clk_cnt = ret;
 
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
@@ -332,17 +320,9 @@ static int exynos_pcie_probe(struct platform_device *pdev)
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
+	if (ret < 0)
+		return ret;
 
 	ep->supplies[0].supply = "vdd18";
 	ep->supplies[1].supply = "vdd10";
@@ -351,10 +331,6 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = exynos_pcie_init_clk_resources(ep);
-	if (ret)
-		return ret;
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
 	if (ret)
 		return ret;
@@ -369,8 +345,8 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 
 fail_probe:
 	phy_exit(ep->phy);
-	exynos_pcie_deinit_clk_resources(ep);
 	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	exynos_pcie_deinit_clk_resources(ep);
 
 	return ret;
 }
-- 
2.17.1

