Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF26966A2
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjBNOWr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjBNOWY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:22:24 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A23425BB7
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:21:55 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230214141324epoutp048c39d774ffc6e520b996bad70a79e7b4~Dtl7DUdfi2733827338epoutp04G
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:13:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230214141324epoutp048c39d774ffc6e520b996bad70a79e7b4~Dtl7DUdfi2733827338epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676384004;
        bh=w6/lQyH1riSnz4KIsiIukyvKM2g4H0wS9IalebzqTIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPbuoe/4supWXXdpo9Nk2he5qZSt8yamhJWLXP90EUnLDRvptl9Ah8eUKs1aS03yo
         0rKYRXr08BS4NwcyCf1/tWb+p30UqNEwQIl5WsQAe2X83VVFZ0Y7oknI3RcXsHgSCb
         p19uNwdi7WDlgc9GqTNn2Se+D0LJDsCMvLX0NoI0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230214141322epcas5p13ea90f4b1263742a2a17cae6d28a6a18~Dtl5k3Wnt1812318123epcas5p1i;
        Tue, 14 Feb 2023 14:13:22 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PGNTs4fwLz4x9Pv; Tue, 14 Feb
        2023 14:13:21 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.80.55678.1079BE36; Tue, 14 Feb 2023 23:13:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121507epcas5p1590024fc32dfcf562efce93cf5f07221~Dr_pcnVvC1679116791epcas5p1E;
        Tue, 14 Feb 2023 12:15:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230214121507epsmtrp2fb579a6b53f403af3992c4ac7054a4fa~Dr_pbzxoG1865118651epsmtrp2R;
        Tue, 14 Feb 2023 12:15:07 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-cd-63eb97019e9e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.9E.05839.B4B7BE36; Tue, 14 Feb 2023 21:15:07 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121504epsmtip1bb62400f5fae28e9e805f82dd632a8ef~Dr_mvjZl72484124841epsmtip1V;
        Tue, 14 Feb 2023 12:15:04 +0000 (GMT)
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
Subject: [PATCH 16/16] PCI: samsung: Make handling of regulators generic
Date:   Tue, 14 Feb 2023 17:43:33 +0530
Message-Id: <20230214121333.1837-17-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0wTZxjH896114OsywW67QUGNqcbQgK0QOvBYE7nzG3zD5I595PBpZyU
        UK61105cooIrIzBAWUb4IWOIzSgs/LBlhCIgAhVHZvkDx48NFaZmgBuxFCURZSs92P77Ps/z
        ed7nx/u+OBo0jIXiOZyJNXKMjsQCRd3DUbtjQPUDjcLdGkHNNXRjlPWMlvp+xC2m6rq/A5Rn
        3S2ibKu1EqpiYR6lCsrWxZT97qSYmuitx6gbDaMYVTM+gFCWpxYRZXEVi6i2kVsSqumnVQn1
        T1+PhHpa/VBElQ+fpBz2KvQNGf2XfU1CO+tuSehGu5m2t5Zg9OxkH0Yvu90S+t7NaoR2WE/T
        l5Z7ELqpwIPRFV2tgPbaI9Ke+zg3RcsyWaxRznIafVYOl51KvvtexpsZKrVCGaNMovaQco7J
        Y1PJA4fSYg7m6HxjkvLPGZ3Z50pjeJ6Mez3FqDebWLlWz5tSSdaQpTMkGmJ5Jo83c9mxHGtK
        VioU8SofmJmrXXz0LWLoi8y3jQ+hBeCqvBQE4JBIhFNXasSlIBAPIi4D6J0p3TJWADzfVYUI
        xmMAp6+fQbZTVi43i4RAP4DtHUsSwShC4MSGBWxSGBENCx+VopsBGfEbAhe9834KJcYAHFzo
        l2xSwQQN/3QW+jNExCvw178voptaSiTDot9HRUK9HfDHzkG/P8DntxTZ/adCYhqHzvUpIEAH
        YFPjGiroYLg02iURdCj0Lvdjgs6GLY6aLUYHHzusWwPthYM3633FcF93UbCjN05wh8OqsXY/
        ghLPw/L1e1u4FPY0bOudcPVZ31afIbDh2oRY0DT0VJWgwlrKAVybuwbOgYi6/0s0AtAKQlgD
        n5fN8ipDPMce/+/iNPo8O/C/5uh3esD83MPYIYDgYAhAHCVl0uD7C5ogaRZz4gvWqM8wmnUs
        PwRUvgVWoqEvaPS+78CZMpSJSYpEtVqdmJSgVpIvSSNTf9YEEdmMic1lWQNr3M5D8IDQAoT8
        NOCOFW1fTb6zPzdzp1XRVlER3rJyQnz0gIkPXC7OlwVaE2pk9PxibebYPufUjZHP4NGwFtY2
        mdz8jW1X1bHK3pYxd+EwN3E27KMOc+DV20caap+EiXY/m83PW3+S3rpwNtXF5s8knHMXvZZs
        CLvgOnzofnNU84Zn/ynxUkj88dvSF2Vzr/7yVrEqIOZK5ctaUwq+UejkLuwKMv4xvvd85MXO
        8KRO1ycpZcUfGlSUOt1RT5yeOXLpYNiefR9cD/EOeE3pypE2U/P7rsMlCZayFWfkg5P5Eeld
        A6eaIgbxWduKDRDyu19N4xlfH9vh6Xa9/YMDIys9zJfEZH3coCGeFPFaRhmNGnnmXyz/hfFW
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnK539etkg5+fBCwezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBkvv05hKtijXrHi/CHmBsaDCl2MnBwSAiYSn3YvZ+li5OIQEtjNKLFlw042
        iISkxOeL65ggbGGJlf+es4PYQgLNTBLHrluB2GwCWhKNX7uYQZpFBF4xSRzeMwPMYRa4wChx
        62A3WIewgIfE852NjCA2i4CqxNW3i5lBbF4BK4nW28dZIDbIS6zecAAszgkUb2ndxAyxzVJi
        1q9VjBMY+RYwMqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOHC3NHYzbV33QO8TI
        xMF4iFGCg1lJhFf46YtkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQW
        wWSZODilGpiY9YRf268QehjiveeSz+udJ+V7TRcxbLRdtoZtX3/0ugP77vCXHs87xigg6/32
        nj7LBO07gkbfCmXmslkev/VNxfXoDC/nHq87ehn6N2YKbtS4oBkeufTejYef7F3W+fy9w/0v
        dOKyZ0zSyV3KC8/bSG7Jnn2j9/1GVzN75oYnLP3XOCat4T186aHJ7Y+T3j3nCuQvvNAe2/fg
        d8+EE2GrY5m49CVjJmeE+U536uP4oXPRacXnFWsZAyJ4PSvPenPIv93IzThl4rfbLkdt1Eol
        fSecMvbcZ3C8+Hfh1FmXbrpHTbfif756Rmus+HMvN4VHfPtkXpvVF1+ccer4beNCwdiWX+pf
        ouJ+LI73mrlSiaU4I9FQi7moOBEAjZev5QsDAAA=
X-CMS-MailID: 20230214121507epcas5p1590024fc32dfcf562efce93cf5f07221
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121507epcas5p1590024fc32dfcf562efce93cf5f07221
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121507epcas5p1590024fc32dfcf562efce93cf5f07221@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pointers instead of fixed size array to store
regulator related information. Add common regulator
initialization and de-initialization functions.
For platform specific init, add a res_ops function
pointer.

Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-samsung.c | 79 +++++++++++++++++++-----
 1 file changed, 64 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
index 01882f2d06c7..bf18020c14da 100644
--- a/drivers/pci/controller/dwc/pci-samsung.c
+++ b/drivers/pci/controller/dwc/pci-samsung.c
@@ -66,7 +66,8 @@ struct samsung_pcie_pdata {
  * @clks: list of clocks required for the controller
  * @clk_cnt: count of clocks required for the controller
  * @phy: PHY device associated with the controller
- * @supplies: array of regulators required for the controller
+ * @supplies: list of regulators required for the controller
+ * @supplies_cnt: count of regulators required for the controller
  */
 struct samsung_pcie {
 	struct dw_pcie			pci;
@@ -75,10 +76,12 @@ struct samsung_pcie {
 	struct clk_bulk_data		*clks;
 	int				clk_cnt;
 	struct phy			*phy;
-	struct regulator_bulk_data	supplies[2];
+	struct regulator_bulk_data	*supplies;
+	int				supplies_cnt;
 };
 
 struct samsung_res_ops {
+	int (*init_regulator)(struct samsung_pcie *sp);
 	int (*irq_init)(struct samsung_pcie *sp, struct platform_device *pdev);
 };
 
@@ -111,6 +114,34 @@ static unsigned int samsung_pcie_appl_readl(struct samsung_pcie *sp, u32 reg)
 	return readl(sp->appl_base + reg);
 }
 
+static int samsung_regulator_enable(struct samsung_pcie *sp)
+{
+	struct device *dev = sp->pci.dev;
+	int ret;
+
+	if (sp->supplies_cnt == 0)
+		return 0;
+
+	ret = devm_regulator_bulk_get(dev, sp->supplies_cnt,
+				      sp->supplies);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(sp->supplies_cnt, sp->supplies);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void samsung_regulator_disable(struct samsung_pcie *sp)
+{
+	if (sp->supplies_cnt == 0)
+		return;
+
+	regulator_bulk_disable(sp->supplies_cnt, sp->supplies);
+}
+
 static void exynos_pcie_sideband_dbi_w_mode(struct samsung_pcie *sp, bool on)
 {
 	u32 val;
@@ -281,6 +312,24 @@ static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
 	.host_init = exynos_pcie_host_init,
 };
 
+static int exynos_init_regulator(struct samsung_pcie *sp)
+{
+	struct device *dev = sp->pci.dev;
+
+	sp->supplies_cnt = 2;
+
+	sp->supplies = devm_kcalloc(dev, sp->supplies_cnt,
+			sizeof(*sp->supplies),
+			GFP_KERNEL);
+	if (!sp->supplies)
+		return -ENOMEM;
+
+	sp->supplies[0].supply = "vdd18";
+	sp->supplies[1].supply = "vdd10";
+
+	return 0;
+}
+
 static int exynos_irq_init(struct samsung_pcie *sp,
 				       struct platform_device *pdev)
 {
@@ -313,6 +362,7 @@ static const struct dw_pcie_ops exynos_dw_pcie_ops = {
 };
 
 static const struct samsung_res_ops exynos_res_ops_data = {
+	.init_regulator		= exynos_init_regulator,
 	.irq_init		= exynos_irq_init,
 };
 
@@ -346,16 +396,15 @@ static int samsung_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	sp->supplies[0].supply = "vdd18";
-	sp->supplies[1].supply = "vdd10";
-	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(sp->supplies),
-				      sp->supplies);
-	if (ret)
-		return ret;
+	if (pdata->res_ops && pdata->res_ops->init_regulator) {
+		ret = sp->pdata->res_ops->init_regulator(sp);
+		if (ret)
+			goto fail_regulator;
+	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(sp->supplies), sp->supplies);
+	ret = samsung_regulator_enable(sp);
 	if (ret)
-		return ret;
+		goto fail_regulator;
 
 	platform_set_drvdata(pdev, sp);
 
@@ -372,7 +421,8 @@ static int samsung_pcie_probe(struct platform_device *pdev)
 
 fail_probe:
 	phy_exit(sp->phy);
-	regulator_bulk_disable(ARRAY_SIZE(sp->supplies), sp->supplies);
+	samsung_regulator_disable(sp);
+fail_regulator:
 	samsung_pcie_deinit_clk_resources(sp);
 
 	return ret;
@@ -387,8 +437,7 @@ static int __exit samsung_pcie_remove(struct platform_device *pdev)
 	phy_power_off(sp->phy);
 	phy_exit(sp->phy);
 	samsung_pcie_deinit_clk_resources(sp);
-	regulator_bulk_disable(ARRAY_SIZE(sp->supplies), sp->supplies);
-
+	samsung_regulator_disable(sp);
 	return 0;
 }
 
@@ -399,7 +448,7 @@ static int samsung_pcie_suspend_noirq(struct device *dev)
 	exynos_pcie_assert_core_reset(sp);
 	phy_power_off(sp->phy);
 	phy_exit(sp->phy);
-	regulator_bulk_disable(ARRAY_SIZE(sp->supplies), sp->supplies);
+	samsung_regulator_disable(sp);
 
 	return 0;
 }
@@ -411,7 +460,7 @@ static int samsung_pcie_resume_noirq(struct device *dev)
 	struct dw_pcie_rp *pp = &pci->pp;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(sp->supplies), sp->supplies);
+	ret = samsung_regulator_enable(sp);
 	if (ret)
 		return ret;
 
-- 
2.17.1

