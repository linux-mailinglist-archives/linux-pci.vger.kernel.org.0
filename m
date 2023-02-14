Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C599696688
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBNOVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjBNOV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:21:26 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF12B082
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:21:09 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230214141025epoutp02c8bc51999a8417ea5ba94a8f71758dab~DtjUrZt0L1102511025epoutp02L
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:10:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230214141025epoutp02c8bc51999a8417ea5ba94a8f71758dab~DtjUrZt0L1102511025epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383825;
        bh=MOcrJcXHly7wo4D9UZYY9r2SCH3BsrRfo+jz2eSLh0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mke6+YTv1minzkSgcQPjMbnvsZ6UtqgZK8HRLKoo//vndtrOsvJw+NGl3GsGNoxDK
         EE5MPjWoSdqWWkzcg9UwPEX2PsaRIDkskC5UMsXsudcg7MNnc6H5yBgxE7yrpTr939
         ucB5BU4AVZBhf3BP05BlL/+Z5UwS1p8TGzFIgvA8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230214141025epcas5p34a819401fc05238b71370c6a057fc7aa~DtjUFutOG2787227872epcas5p3b;
        Tue, 14 Feb 2023 14:10:25 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PGNQR73F0z4x9Pv; Tue, 14 Feb
        2023 14:10:23 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.88.06765.F469BE36; Tue, 14 Feb 2023 23:10:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121436epcas5p1641de02220bea5edb23bc875b6311270~Dr_Mddck31714317143epcas5p1R;
        Tue, 14 Feb 2023 12:14:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230214121436epsmtrp12d6ddddf7dc275adc40b127820b53838~Dr_Mca57B1788717887epsmtrp1B;
        Tue, 14 Feb 2023 12:14:36 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-4d-63eb964f1ee7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.8E.05839.C2B7BE36; Tue, 14 Feb 2023 21:14:36 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121433epsmtip1a3fddefe573546349aa6f900e47fff4f~Dr_Jq6lkH2436024360epsmtip1m;
        Tue, 14 Feb 2023 12:14:33 +0000 (GMT)
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
Subject: [PATCH 08/16] PCI: samsung: Rename exynos_pcie to samsung_pcie
Date:   Tue, 14 Feb 2023 17:43:25 +0530
Message-Id: <20230214121333.1837-9-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTfUxTVxTf7evHQ4G9AcYLyZC8ZU6aAK223aUDWTLiXgbbSDQuMxv1pX0D
        QmlrW3RuEAurMsmo+IkwqIQ1m7AhUDpE5KOCWMeEuYE4P3B8yVAIou0gWIQVWrb/fud3fuf+
        zjn3XhwLsnPD8AyVntGqaCXJXcdu6orcEvXhmSm5IM8uQcPmJi6y5Kejc1f7OKisqQKgp+4+
        NjrvKuUh0+QIhgzfuDnIOjbIQf0t5VzUa3Zw0dnf2lnIuGhkI2N3ARvVXh3ioaqfXTy03NrM
        Q4sls2xU1JWLGq2nsbdDqGnrPI+6VDbEoyqt2ZS15iiXuj/YyqVm+vp41PhACYtqtByiGmaa
        WVSV4SmXMtlqAOW0hqf478mMS2doBaONYFRytSJDlRZPJu2UvSMTSwTCKGEsepOMUNFZTDyZ
        mJwStSND6RmTjNhPK7M9VAqt05Ex2+O06mw9E5Gu1unjSUajUGpEmmgdnaXLVqVFqxi9VCgQ
        bBV7hHsz0wsu8zX5qs8dPQoDGP20EPjhkBBBm62FVwjW4UHEZQAvWixcb/AMQOu3JzjeYA5A
        04051lpJfd0g25toA7Due7ev5DALdtyo462ouAQf5v1TiK0kQoi7LPjIObLqghE9ANon21ZV
        wcS78Ot6O2cFs4nX4cm8Xg+P4wFELDxuUXrtNsEf6+3YCvYjpNB42Lp6KCQGcOhwFfG8okR4
        9PE8x4uD4WOHzceHwUfHjvhwGqxuPIt5sRLONVp88yRA+0A5e8UXIyJhXUuMl34Vnu65sCrB
        iEBY5B73yQNgs3kNvwZdL1rZXhwKzdf6fS1QcOHOHeDdShGA5qFedjEIL/vfohKAGhDKaHRZ
        aYxOrNmmYg78d2tydZYVrD5lflIzGB2eje4ELBx0AohjZEhA8MNJeVCAgj74BaNVy7TZSkbX
        CcSe/R3HwjbI1Z6/oNLLhKJYgUgikYhit0mE5MaAN+J/kQcRabSeyWQYDaNdq2PhfmEGFrdq
        +Pz77zEHzvyQJN1oqEW7t1SeanApRxTtL2o3AeNNjDW79In5ks5/FzlvLP4jdPmK7S16STRy
        K1IquF9+qME54ZzMR8dSd128ltuKby9zSHMPJvjrTXtHp45ML37l5iM/k5q348vul3IW/rQU
        yJKef/f8r3sfdD1L/lskdsrqQlPHE/y33qyOw3/avGdC5hZWapbtbdIhJ/nx9Xv221Ef5Twp
        urL86+8D7WMlgdP96n3zO5MnInpfSQ27ndtXbQt8uKE/8eWBjowc1W6zGD4pvZVT6oiSZXw2
        lTS0Hm9ZGovprji3z8V/sHy32HRi/Sn9A1uHoeL6Qu2F8PjNIfu1MyRbl04L+ZhWR/8Lh3s+
        jlMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnK5O9etkg++fWSwezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBntu7UKmvIqjp9KaWB8FNvFyMkhIWAisWH9NZYuRi4OIYHdjBK3bh5hhEhI
        Sny+uI4JwhaWWPnvOTuILSTQzCRx+KEuiM0moCXR+LWLGaRZROAVUHzPDDCHWeAC0KSD3WAd
        wgLuEh0bDrCC2CwCqhKTG88CxTk4eAUsJSYuyYFYIC+xesMBZhCbU8BKoqV1EzPEMkuJWb9W
        MU5g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4ZrQ0dzBuX/VB7xAjEwfj
        IUYJDmYlEV7hpy+ShXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl
        4uCUamAq1jPdqbN0yrOnfO86nazZu6dm7WKMNw4SWjPLnn/GiTO87/liPXN/3JxrvWLBhkW2
        C3Z+27mx/d/e1xNizZ8u92yfmLL5ScvteY1qD42XmzfvEw5w/XMpLtnUyG3PdfFT8y+JHD74
        +4vdlDq+nbzXjp3zMHq3dZVpRtR/n9ylnx455ax4N+XP/6rbGk6Bb7892NmpwCfz/+AE30km
        odVfGg6VBBX15OslGx9YZ/t7yYen1q/OijxL8b6ULbGjU/fyGYnOFQcPKVpsjvNY29gdzpS1
        SPJmwL/YZfcOnPmz2tpey1/XYLn7Hy5W1atXbjJwflvx/FSUtdqj7v4t4retWDc6Wpo4CF04
        VxfN4XJHTomlOCPRUIu5qDgRAHhZzFAIAwAA
X-CMS-MailID: 20230214121436epcas5p1641de02220bea5edb23bc875b6311270
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121436epcas5p1641de02220bea5edb23bc875b6311270
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121436epcas5p1641de02220bea5edb23bc875b6311270@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The platform specific structure being used is named
exynos_pcie. Changing it to samsung_pcie for making it
generic.

Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-samsung.c | 190 +++++++++++------------
 1 file changed, 95 insertions(+), 95 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
index d5adf1017a05..be0177fcd763 100644
--- a/drivers/pci/controller/dwc/pci-samsung.c
+++ b/drivers/pci/controller/dwc/pci-samsung.c
@@ -23,7 +23,7 @@
 
 #include "pcie-designware.h"
 
-#define to_exynos_pcie(x)	dev_get_drvdata((x)->dev)
+#define to_samsung_pcie(x)	dev_get_drvdata((x)->dev)
 
 /* PCIe APPL registers */
 #define EXYNOS_PCIE_IRQ_PULSE			0x000
@@ -51,7 +51,7 @@
 #define EXYNOS_PCIE_APPL_SLV_ARMISC		0x120
 #define EXYNOS_PCIE_APPL_SLV_DBI_ENABLE	BIT(21)
 
-struct exynos_pcie {
+struct samsung_pcie {
 	struct dw_pcie			pci;
 	void __iomem			*appl_base;
 	struct clk_bulk_data		*clks;
@@ -60,23 +60,23 @@ struct exynos_pcie {
 	struct regulator_bulk_data	supplies[2];
 };
 
-static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep)
+static int exynos_pcie_init_clk_resources(struct samsung_pcie *sp)
 {
-	struct device *dev = ep->pci.dev;
+	struct device *dev = sp->pci.dev;
 	int ret;
 
-	ret = devm_clk_bulk_get_all(dev, &ep->clks);
+	ret = devm_clk_bulk_get_all(dev, &sp->clks);
 	if (ret < 0)
 		return ret;
 
-	ep->clk_cnt = ret;
+	sp->clk_cnt = ret;
 
-	return clk_bulk_prepare_enable(ep->clk_cnt, ep->clks);
+	return clk_bulk_prepare_enable(sp->clk_cnt, sp->clks);
 }
 
-static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)
+static void exynos_pcie_deinit_clk_resources(struct samsung_pcie *sp)
 {
-	clk_bulk_disable_unprepare(ep->clk_cnt, ep->clks);
+	clk_bulk_disable_unprepare(sp->clk_cnt, sp->clks);
 }
 
 static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
@@ -89,115 +89,115 @@ static u32 exynos_pcie_readl(void __iomem *base, u32 reg)
 	return readl(base + reg);
 }
 
-static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
+static void exynos_pcie_sideband_dbi_w_mode(struct samsung_pcie *sp, bool on)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_APPL_SLV_AWMISC);
+	val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_APPL_SLV_AWMISC);
 	if (on)
 		val |= EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
 	else
 		val &= ~EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
-	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_APPL_SLV_AWMISC);
+	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_APPL_SLV_AWMISC);
 }
 
-static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *ep, bool on)
+static void exynos_pcie_sideband_dbi_r_mode(struct samsung_pcie *sp, bool on)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_APPL_SLV_ARMISC);
+	val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_APPL_SLV_ARMISC);
 	if (on)
 		val |= EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
 	else
 		val &= ~EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
-	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_APPL_SLV_ARMISC);
+	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_APPL_SLV_ARMISC);
 }
 
-static void exynos_pcie_assert_core_reset(struct exynos_pcie *ep)
+static void exynos_pcie_assert_core_reset(struct samsung_pcie *sp)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_CORE_RESET);
+	val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_CORE_RESET);
 	val &= ~EXYNOS_PCIE_CORE_RESET_ENABLE;
-	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_CORE_RESET);
-	exynos_pcie_writel(ep->appl_base, 0, EXYNOS_PCIE_STICKY_RESET);
-	exynos_pcie_writel(ep->appl_base, 0, EXYNOS_PCIE_NONSTICKY_RESET);
+	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_CORE_RESET);
+	exynos_pcie_writel(sp->appl_base, 0, EXYNOS_PCIE_STICKY_RESET);
+	exynos_pcie_writel(sp->appl_base, 0, EXYNOS_PCIE_NONSTICKY_RESET);
 }
 
-static void exynos_pcie_deassert_core_reset(struct exynos_pcie *ep)
+static void exynos_pcie_deassert_core_reset(struct samsung_pcie *sp)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_CORE_RESET);
+	val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_CORE_RESET);
 	val |= EXYNOS_PCIE_CORE_RESET_ENABLE;
 
-	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_CORE_RESET);
-	exynos_pcie_writel(ep->appl_base, 1, EXYNOS_PCIE_STICKY_RESET);
-	exynos_pcie_writel(ep->appl_base, 1, EXYNOS_PCIE_NONSTICKY_RESET);
-	exynos_pcie_writel(ep->appl_base, 1, EXYNOS_PCIE_APP_INIT_RESET);
-	exynos_pcie_writel(ep->appl_base, 0, EXYNOS_PCIE_APP_INIT_RESET);
+	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_CORE_RESET);
+	exynos_pcie_writel(sp->appl_base, 1, EXYNOS_PCIE_STICKY_RESET);
+	exynos_pcie_writel(sp->appl_base, 1, EXYNOS_PCIE_NONSTICKY_RESET);
+	exynos_pcie_writel(sp->appl_base, 1, EXYNOS_PCIE_APP_INIT_RESET);
+	exynos_pcie_writel(sp->appl_base, 0, EXYNOS_PCIE_APP_INIT_RESET);
 }
 
 static int exynos_pcie_start_link(struct dw_pcie *pci)
 {
-	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	struct samsung_pcie *sp = to_samsung_pcie(pci);
 	u32 val;
 
-	val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_SW_WAKE);
+	val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_SW_WAKE);
 	val &= ~EXYNOS_PCIE_BUS_EN;
-	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_SW_WAKE);
+	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_SW_WAKE);
 
 	/* assert LTSSM enable */
-	exynos_pcie_writel(ep->appl_base, EXYNOS_PCIE_APPL_LTSSM_ENABLE,
+	exynos_pcie_writel(sp->appl_base, EXYNOS_PCIE_APPL_LTSSM_ENABLE,
 			  EXYNOS_PCIE_APP_LTSSM_ENABLE);
 	return 0;
 }
 
-static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
+static void exynos_pcie_clear_irq_pulse(struct samsung_pcie *sp)
 {
-	u32 val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_IRQ_PULSE);
+	u32 val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_IRQ_PULSE);
 
-	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_IRQ_PULSE);
+	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_IRQ_PULSE);
 }
 
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 {
-	struct exynos_pcie *ep = arg;
+	struct samsung_pcie *sp = arg;
 
-	exynos_pcie_clear_irq_pulse(ep);
+	exynos_pcie_clear_irq_pulse(sp);
 	return IRQ_HANDLED;
 }
 
-static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
+static void exynos_pcie_enable_irq_pulse(struct samsung_pcie *sp)
 {
 	u32 val = EXYNOS_IRQ_INTA_ASSERT | EXYNOS_IRQ_INTB_ASSERT |
 		  EXYNOS_IRQ_INTC_ASSERT | EXYNOS_IRQ_INTD_ASSERT;
 
-	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_IRQ_EN_PULSE);
-	exynos_pcie_writel(ep->appl_base, 0, EXYNOS_PCIE_IRQ_EN_LEVEL);
-	exynos_pcie_writel(ep->appl_base, 0, EXYNOS_PCIE_IRQ_EN_SPECIAL);
+	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_IRQ_EN_PULSE);
+	exynos_pcie_writel(sp->appl_base, 0, EXYNOS_PCIE_IRQ_EN_LEVEL);
+	exynos_pcie_writel(sp->appl_base, 0, EXYNOS_PCIE_IRQ_EN_SPECIAL);
 }
 
 static u32 exynos_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
 				u32 reg, size_t size)
 {
-	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	struct samsung_pcie *sp = to_samsung_pcie(pci);
 	u32 val;
 
-	exynos_pcie_sideband_dbi_r_mode(ep, true);
+	exynos_pcie_sideband_dbi_r_mode(sp, true);
 	dw_pcie_read(base + reg, size, &val);
-	exynos_pcie_sideband_dbi_r_mode(ep, false);
+	exynos_pcie_sideband_dbi_r_mode(sp, false);
 	return val;
 }
 
 static void exynos_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 				  u32 reg, size_t size, u32 val)
 {
-	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	struct samsung_pcie *sp = to_samsung_pcie(pci);
 
-	exynos_pcie_sideband_dbi_w_mode(ep, true);
+	exynos_pcie_sideband_dbi_w_mode(sp, true);
 	dw_pcie_write(base + reg, size, val);
-	exynos_pcie_sideband_dbi_w_mode(ep, false);
+	exynos_pcie_sideband_dbi_w_mode(sp, false);
 }
 
 static int exynos_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
@@ -231,8 +231,8 @@ static struct pci_ops exynos_pci_ops = {
 
 static int exynos_pcie_link_up(struct dw_pcie *pci)
 {
-	struct exynos_pcie *ep = to_exynos_pcie(pci);
-	u32 val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_APPL_RDLH_LINKUP);
+	struct samsung_pcie *sp = to_samsung_pcie(pci);
+	u32 val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_APPL_RDLH_LINKUP);
 
 	return (val & EXYNOS_PCIE_APPL_XMLH_LINKUP);
 }
@@ -240,17 +240,17 @@ static int exynos_pcie_link_up(struct dw_pcie *pci)
 static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	struct samsung_pcie *sp = to_samsung_pcie(pci);
 
 	pp->bridge->ops = &exynos_pci_ops;
 
-	exynos_pcie_assert_core_reset(ep);
+	exynos_pcie_assert_core_reset(sp);
 
-	phy_init(ep->phy);
-	phy_power_on(ep->phy);
+	phy_init(sp->phy);
+	phy_power_on(sp->phy);
 
-	exynos_pcie_deassert_core_reset(ep);
-	exynos_pcie_enable_irq_pulse(ep);
+	exynos_pcie_deassert_core_reset(sp);
+	exynos_pcie_enable_irq_pulse(sp);
 
 	return 0;
 }
@@ -259,10 +259,10 @@ static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
 	.host_init = exynos_pcie_host_init,
 };
 
-static int exynos_add_pcie_port(struct exynos_pcie *ep,
+static int exynos_add_pcie_port(struct samsung_pcie *sp,
 				       struct platform_device *pdev)
 {
-	struct dw_pcie *pci = &ep->pci;
+	struct dw_pcie *pci = &sp->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -272,7 +272,7 @@ static int exynos_add_pcie_port(struct exynos_pcie *ep,
 		return pp->irq;
 
 	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
-			       IRQF_SHARED, "exynos-pcie", ep);
+			       IRQF_SHARED, "exynos-pcie", sp);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		return ret;
@@ -300,95 +300,95 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 static int exynos_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct exynos_pcie *ep;
+	struct samsung_pcie *sp;
 	struct device_node *np = dev->of_node;
 	int ret;
 
-	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
-	if (!ep)
+	sp = devm_kzalloc(dev, sizeof(*sp), GFP_KERNEL);
+	if (!sp)
 		return -ENOMEM;
 
-	ep->pci.dev = dev;
-	ep->pci.ops = &dw_pcie_ops;
+	sp->pci.dev = dev;
+	sp->pci.ops = &dw_pcie_ops;
 
-	ep->phy = devm_of_phy_get(dev, np, NULL);
-	if (IS_ERR(ep->phy))
-		return PTR_ERR(ep->phy);
+	sp->phy = devm_of_phy_get(dev, np, NULL);
+	if (IS_ERR(sp->phy))
+		return PTR_ERR(sp->phy);
 
 	/* Application logic registers */
-	ep->appl_base = devm_platform_ioremap_resource_byname(pdev, "appl");
-	if (IS_ERR(ep->appl_base))
-		return PTR_ERR(ep->appl_base);
+	sp->appl_base = devm_platform_ioremap_resource_byname(pdev, "appl");
+	if (IS_ERR(sp->appl_base))
+		return PTR_ERR(sp->appl_base);
 
-	ret = exynos_pcie_init_clk_resources(ep);
+	ret = exynos_pcie_init_clk_resources(sp);
 	if (ret < 0)
 		return ret;
 
-	ep->supplies[0].supply = "vdd18";
-	ep->supplies[1].supply = "vdd10";
-	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ep->supplies),
-				      ep->supplies);
+	sp->supplies[0].supply = "vdd18";
+	sp->supplies[1].supply = "vdd10";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(sp->supplies),
+				      sp->supplies);
 	if (ret)
 		return ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	ret = regulator_bulk_enable(ARRAY_SIZE(sp->supplies), sp->supplies);
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, ep);
+	platform_set_drvdata(pdev, sp);
 
-	ret = exynos_add_pcie_port(ep, pdev);
+	ret = exynos_add_pcie_port(sp, pdev);
 	if (ret < 0)
 		goto fail_probe;
 
 	return 0;
 
 fail_probe:
-	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
-	exynos_pcie_deinit_clk_resources(ep);
+	phy_exit(sp->phy);
+	regulator_bulk_disable(ARRAY_SIZE(sp->supplies), sp->supplies);
+	exynos_pcie_deinit_clk_resources(sp);
 
 	return ret;
 }
 
 static int __exit exynos_pcie_remove(struct platform_device *pdev)
 {
-	struct exynos_pcie *ep = platform_get_drvdata(pdev);
+	struct samsung_pcie *sp = platform_get_drvdata(pdev);
 
-	dw_pcie_host_deinit(&ep->pci.pp);
-	exynos_pcie_assert_core_reset(ep);
-	phy_power_off(ep->phy);
-	phy_exit(ep->phy);
-	exynos_pcie_deinit_clk_resources(ep);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	dw_pcie_host_deinit(&sp->pci.pp);
+	exynos_pcie_assert_core_reset(sp);
+	phy_power_off(sp->phy);
+	phy_exit(sp->phy);
+	exynos_pcie_deinit_clk_resources(sp);
+	regulator_bulk_disable(ARRAY_SIZE(sp->supplies), sp->supplies);
 
 	return 0;
 }
 
 static int exynos_pcie_suspend_noirq(struct device *dev)
 {
-	struct exynos_pcie *ep = dev_get_drvdata(dev);
+	struct samsung_pcie *sp = dev_get_drvdata(dev);
 
-	exynos_pcie_assert_core_reset(ep);
-	phy_power_off(ep->phy);
-	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	exynos_pcie_assert_core_reset(sp);
+	phy_power_off(sp->phy);
+	phy_exit(sp->phy);
+	regulator_bulk_disable(ARRAY_SIZE(sp->supplies), sp->supplies);
 
 	return 0;
 }
 
 static int exynos_pcie_resume_noirq(struct device *dev)
 {
-	struct exynos_pcie *ep = dev_get_drvdata(dev);
-	struct dw_pcie *pci = &ep->pci;
+	struct samsung_pcie *sp = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &sp->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	ret = regulator_bulk_enable(ARRAY_SIZE(sp->supplies), sp->supplies);
 	if (ret)
 		return ret;
 
-	/* exynos_pcie_host_init controls ep->phy */
+	/* exynos_pcie_host_init controls sp->phy */
 	exynos_pcie_host_init(pp);
 	dw_pcie_setup_rc(pp);
 	exynos_pcie_start_link(pci);
-- 
2.17.1

