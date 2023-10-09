Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956E7BD486
	for <lists+linux-pci@lfdr.de>; Mon,  9 Oct 2023 09:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345439AbjJIHmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345405AbjJIHmB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 03:42:01 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F22FA2
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 00:41:58 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231009074156epoutp044c13134b51ea1eaa927fc3af1a687501~MYIyemi3U1254512545epoutp04v
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 07:41:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231009074156epoutp044c13134b51ea1eaa927fc3af1a687501~MYIyemi3U1254512545epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696837316;
        bh=Z1lE8fryZmkR3mmtV7AFUEPTESrVqtxc5YfCf5YoK9o=;
        h=From:To:Cc:Subject:Date:References:From;
        b=STNuPAucQPilSsy92OF8lQiSrOhLJVva0DDp8RjTahoWMA13FNnttfmgUwKjoWnFJ
         5QJyeF3OBK3lL8i0oH4WZZnF0IfZC9ckKK0MRlpQZY2dGPqsOCJXhdFHPrQiVissCh
         UzyW6qLUo+WeCZOgQWwt32eUkcntZFsaWXt/bOEg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231009074156epcas5p38645bf6a5c9b1b84de0c39a418eed7f0~MYIyLpLPw1878118781epcas5p3V;
        Mon,  9 Oct 2023 07:41:56 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4S3rZp4mtzz4x9Pt; Mon,  9 Oct
        2023 07:41:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.24.19094.2CEA3256; Mon,  9 Oct 2023 16:41:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231009062222epcas5p36768b75c13c7c79965b5863521361a64~MXDT-lojM2882228822epcas5p3D;
        Mon,  9 Oct 2023 06:22:22 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231009062222epsmtrp1cd58852a31e0c088ffd6b9575fd855dc~MXDT_umCA0557305573epsmtrp1o;
        Mon,  9 Oct 2023 06:22:22 +0000 (GMT)
X-AuditID: b6c32a50-39fff70000004a96-27-6523aec2d398
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.65.08649.E1C93256; Mon,  9 Oct 2023 15:22:22 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231009062219epsmtip248fdd10ff69b815f6d1da7ff34c70b6e~MXDRz_rJ30406904069epsmtip2-;
        Mon,  9 Oct 2023 06:22:19 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pankaj.dubey@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH] PCI: exynos: Adapt to clk_bulk_* APIs
Date:   Mon,  9 Oct 2023 11:52:16 +0530
Message-Id: <20231009062216.6729-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmpu6hdcqpBhM+y1s8mLeNzWJJU4bF
        ii8z2S32vt7KbtHQ85vVYtPja6wWl3fNYbM4O+84m8WM8/uYLFr+tLBYLNr6hd3i/54d7Ba9
        h2sdeD12zrrL7rFgU6nHplWdbB53ru1h83hyZTqTx+Yl9R59W1YxenzeJBfAEZVtk5GamJJa
        pJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0r5JCWWJOKVAoILG4
        WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2PN0xVsBb8k
        Kn58WsfcwLhPpIuRk0NCwETi/M9vLF2MXBxCAnsYJZa0/WeDcD4xSjz9+YYRwvnGKLHl8XMW
        mJZ1+yazQyT2MkrMPb4MqqWVSWL7gvVMIFVsAloSjV+7mEESIgILGCWW9R1gAnGYBU4wSrSe
        Xwg2S1jATOLHp81ANgcHi4CqxJP9PCBhXgFLiSvvF7BCrJOXWL3hANggCYGP7BIrV/1kh0i4
        SPyZ1sMIYQtLvDq+BSouJfGyvw3KTpdYuXkGM4SdI/Ft8xImCNte4sCVOWB7mQU0Jdbv0ocI
        y0pMPbUOrIRZgE+i9/cTqHJeiR3zYGxliS9/90CDQlJi3rHLUHd6SDyadQ/sHCGBWInV7Z+Z
        JjDKzkLYsICRcRWjVGpBcW56arJpgaFuXmo5PK6S83M3MYJTolbADsbVG/7qHWJk4mA8xCjB
        wawkwqtbqpAqxJuSWFmVWpQfX1Sak1p8iNEUGGYTmaVEk/OBSTmvJN7QxNLAxMzMzMTS2MxQ
        SZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQYmLsX9wmGZWatNRNwvGEyuzLhXI9Zkqfbt7Cfv
        Lv0GrjfFwv1v3n6Ua1lfpLJ3QztDVnZ8drPe2yItPbm7CibrL/iuuXWi9pgO14y2FbOlQg3j
        5fx5pnqnBD7el/f78EmVL4qHT4SsUBT/f0I2cefFXayLfp+IlbpRFhi+9j1PpGlh7NugVIup
        /Fc+9FR5nliwiFFJL/SOYLjonFqB5QKR00V/Wx39O11DduIHR7Xv/E+TvIuPxNxOXPnu2tlf
        LnaeO6y5zt63+m67y+fQRxfpC5mH1vzY1PbUfXnm3q/8SbYOFotlIp9vEK3lrrxeMW39XjZv
        f90f5U++zTwVJv7vS8/uXwGdzJZCmV9yeE2VWIozEg21mIuKEwFGRmtvEgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvK7cHOVUgwNzeS0ezNvGZrGkKcNi
        xZeZ7BZ7X29lt2jo+c1qsenxNVaLy7vmsFmcnXeczWLG+X1MFi1/WlgsFm39wm7xf88Odove
        w7UOvB47Z91l91iwqdRj06pONo871/aweTy5Mp3JY/OSeo++LasYPT5vkgvgiOKySUnNySxL
        LdK3S+DKWPN0BVvBL4mKH5/WMTcw7hPpYuTkkBAwkVi3bzJ7FyMXh5DAbkaJjs/X2SASkhKf
        L65jgrCFJVb+ew5V1Mwk8WzuNrAiNgEticavXcwgCRGBFYwSq47cAHOYBc4xSkz++50ZpEpY
        wEzix6fNLF2MHBwsAqoST/bzgIR5BSwlrrxfwAqxQV5i9YYDzBMYeRYwMqxilEwtKM5Nz002
        LDDMSy3XK07MLS7NS9dLzs/dxAgOTS2NHYz35v/TO8TIxMF4iFGCg1lJhFe3VCFViDclsbIq
        tSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalFMFkmDk6pBibdyVrVjY9SmFhDDx+b
        mCe6WSrsI3u0zYGbIvya2/mbxNwCgw5OuMG3UpTp1sd7lq63F614vqRbR7L1/+n5Rb2vL/tc
        7N5Rxj2hK8V039PUpYpPm12nemnwP7H1T7754XzemmP/J3st71zRXtgx2eNXqNjRKPmb7SGM
        CUcr57HdrWoJOltTeXPJi1+rTCffrqxNNGcSEjHplfd6yLHs+90v80rlhdpP3/pifO1tyLUD
        MdPMDk41YhWZlnxE3nfHk4eF/braTE+idGptq78lfbmdM1NjRfgSCcHCuZkXfn7wZn7Tljf3
        U5rzzEvuh83Ttdcdj08JD2NymsGtIqvXp2l/UJ97oVn2rnt/1K8pBSmxFGckGmoxFxUnAgAp
        P9fcvAIAAA==
X-CMS-MailID: 20231009062222epcas5p36768b75c13c7c79965b5863521361a64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231009062222epcas5p36768b75c13c7c79965b5863521361a64
References: <CGME20231009062222epcas5p36768b75c13c7c79965b5863521361a64@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pci/controller/dwc/pci-exynos.c | 46 ++++++-------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 9e42cfcd99cc..023cf41fccd7 100644
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

