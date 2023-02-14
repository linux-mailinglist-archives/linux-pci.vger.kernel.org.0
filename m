Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E66F69662D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjBNOMU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjBNOMC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:12:02 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14092A98E
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:11:22 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230214140947epoutp02319cbee2490f4064032e201d9bdaddc4~DtixODuVF0915809158epoutp02d
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:09:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230214140947epoutp02319cbee2490f4064032e201d9bdaddc4~DtixODuVF0915809158epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383787;
        bh=4fhan0Tw+cznyXrr7NgUEAhifEgTnLcEgNjy+Wty2Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olDVb81Nst6/wevqa91KPXlhz4A76c3IZfQBCHbOFp8hVqEF3sqoo1bL/JL+/qnjy
         UmcOb6ahKWhIKJIUYuB8zHM0EXJ0WCYhIwOi6WYIw41VaL5urM+hH+/rWGvX/g0iFw
         7K3G1wvf7d5svqTbgv3MrxmvRjJ6x5qjxBxxloX4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230214140946epcas5p486c00e47e91f42ab64c5e4790e25c773~DtiwDhMJF0632406324epcas5p4S;
        Tue, 14 Feb 2023 14:09:46 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PGNPj28DXz4x9Pr; Tue, 14 Feb
        2023 14:09:45 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.78.06765.9269BE36; Tue, 14 Feb 2023 23:09:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230214121432epcas5p27248b4dafdec64b0172c69f7909d7a64~Dr_Iz7q-k0795707957epcas5p2u;
        Tue, 14 Feb 2023 12:14:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230214121432epsmtrp2aaeff2e6d8ba1fd91cf68af8eee5f102~Dr_Iy7bEK1888418884epsmtrp2h;
        Tue, 14 Feb 2023 12:14:32 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-fa-63eb96296114
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.FA.17995.82B7BE36; Tue, 14 Feb 2023 21:14:32 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121429epsmtip1b719ca6d898005b96417aba8e73dc392~Dr_GIkwkM2553425534epsmtip1D;
        Tue, 14 Feb 2023 12:14:29 +0000 (GMT)
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
Subject: [PATCH 07/16] PCI: samsung: Rename the term elbi to appl
Date:   Tue, 14 Feb 2023 17:43:24 +0530
Message-Id: <20230214121333.1837-8-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmpq7mtNfJBpPf81g8mLeNzWJJU4bF
        /CPnWC1mbZvLaPHx9zkWixVfZrJb9L14yGzR0POb1WLT42usFpd3zWGzODvvOJvFjPP7mCxa
        /rSwWLQcbWexWHvkLrvFoq1f2C3+79nBbvFn+gcWi97DtRabN01ldhDxeLPpO7vHzll32T0W
        bCr12LSqk83jzrU9bB7vzp1j93hyZTqTx+Yl9R4b3+1g8ljU8JHNo2/LKkaPz5vkAniism0y
        UhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgN5UUihLzCkF
        CgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnTHq9
        iLVguXXF1tlnmBoY9xp3MXJySAiYSMxZ0cHcxcjFISSwm1HibutMdgjnE6PEvllboTKfGSVO
        zHrGCNOyuW8qVNUuRon/DftZIJxWJoknc+ewgFSxCWhJNH7tAmsXEbjFJPHy80OwFmaBU4wS
        B17sZQepEhZwlNj76TwbiM0ioCox5e9+VhCbV8BSYt3ux1D75CVWbzjADGJzClhJtLRuApsq
        IXCHQ+La3TvMEEUuEtfev2SHsIUlXh3fAmVLSXx+t5cNwk6XWLl5BlR9jsS3zUuYIGx7iQNX
        QM7mALpOU2L9Ln2IsKzE1FPrwEqYBfgken8/gSrnldgxD8ZWlvjydw8LhC0pMe/YZVYI20Ni
        Zvd5aBj1Mkp8PfaaeQKj3CyEFQsYGVcxSqYWFOempxabFhjnpZbDIy45P3cTIzg1a3nvYHz0
        4IPeIUYmDsZDjBIczEoivMJPXyQL8aYkVlalFuXHF5XmpBYfYjQFBuBEZinR5HxgdsgriTc0
        sTQwMTMzM7E0NjNUEudVtz2ZLCSQnliSmp2aWpBaBNPHxMEp1cB0aM6tsshr7BxnHs3tMGCO
        Lar32/CLr/rh27/f1s2ZMm+FUZVl6JJzy0xas1uO3D3zIHlrQdoVj6jlnEVbqtj3G4lMsMjj
        cHsRdCCA4013pOv0212JEX///FxWmhHtLuJz8ORWHhOrf6fi+603d1ZHLvig6LQ3uqt86aZd
        qq4SOeWc6S1TRJV0Ine1pataSfUoVV6om3mh5vA1PxeOj5k57zlTX3x4fCBP6GtzGUOfcsKf
        Fpsr3x502002kpOcY50ldiE68nkhs/bZu/+5tp7dnPb+zpM1PIqSoZu6rz/5uIP7Q5sZb42C
        ueSj3b92ei624t1mImPhZalltmdmlZxvjzu/xywH676QY009m5RYijMSDbWYi4oTARGVKHxW
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnK5G9etkg9NTBS0ezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBmTXi9iLVhuXbF19hmmBsa9xl2MnBwSAiYSm/umsncxcnEICexglJjYcIYV
        IiEp8fniOiYIW1hi5b/n7CC2kEAzk8SyM7UgNpuAlkTj1y5mkGYRgVdMEof3zABzmAUuMErc
        OtgN1iEs4Cix99N5NhCbRUBVYsrf/WAbeAUsJdbtfswIsUFeYvWGA8wgNqeAlURL6yZmiG2W
        ErN+rWKcwMi3gJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcORoae1g3LPqg94h
        RiYOxkOMEhzMSiK8wk9fJAvxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUg
        tQgmy8TBKdXAxHht/wWJ1fuuKN98u/bG7rrqyr2/vr340nB9/oGm/1fit9SlLgpXU2CZ66l2
        cueE8CCt9Sy6ks9YqkRZdmf0frV7MyHz7+7YdqePEx0Dbu428d33YeWdByf2Cs2ebG0Wb+g/
        WUrM+GaXSOeTQun0494XWcze/Q1cGD31lubTxwcVM7e+OT/1plWN+PqzP25v0W45+HDJqc3n
        77vFXTz+aaWI7DHJ26e03f6GHJtV1RJbJSszS+iE2/93bofnP7vy9MilnVzNHFXpB7WXix/s
        q78XKv8tPP3xMaGGPHuO9ryJymvk3n8XvhYTkrexJPPcT50PJjrSTAavru6NqT98wY29/fuH
        sGmdH1e03C5zOmGpxFKckWioxVxUnAgAhP21vAsDAAA=
X-CMS-MailID: 20230214121432epcas5p27248b4dafdec64b0172c69f7909d7a64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121432epcas5p27248b4dafdec64b0172c69f7909d7a64
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121432epcas5p27248b4dafdec64b0172c69f7909d7a64@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver uses the name elbi for application logic
registers which is a wrong nomenclature. This patch fixes
the same.

This commit shouldn't be applied without changes
"arm64: dts: exynos: Rename the term elbi to appl" and
"dt-bindings: PCI: Rename the term elbi to appl"

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-samsung.c | 80 ++++++++++++------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
index 6c07d3f151be..d5adf1017a05 100644
--- a/drivers/pci/controller/dwc/pci-samsung.c
+++ b/drivers/pci/controller/dwc/pci-samsung.c
@@ -25,7 +25,7 @@
 
 #define to_exynos_pcie(x)	dev_get_drvdata((x)->dev)
 
-/* PCIe ELBI registers */
+/* PCIe APPL registers */
 #define EXYNOS_PCIE_IRQ_PULSE			0x000
 #define EXYNOS_IRQ_INTA_ASSERT			BIT(0)
 #define EXYNOS_IRQ_INTB_ASSERT			BIT(2)
@@ -44,16 +44,16 @@
 #define EXYNOS_PCIE_NONSTICKY_RESET		0x024
 #define EXYNOS_PCIE_APP_INIT_RESET		0x028
 #define EXYNOS_PCIE_APP_LTSSM_ENABLE		0x02c
-#define EXYNOS_PCIE_ELBI_RDLH_LINKUP		0x074
-#define EXYNOS_PCIE_ELBI_XMLH_LINKUP		BIT(4)
-#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
-#define EXYNOS_PCIE_ELBI_SLV_AWMISC		0x11c
-#define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
-#define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
+#define EXYNOS_PCIE_APPL_RDLH_LINKUP		0x074
+#define EXYNOS_PCIE_APPL_XMLH_LINKUP		BIT(4)
+#define EXYNOS_PCIE_APPL_LTSSM_ENABLE		0x1
+#define EXYNOS_PCIE_APPL_SLV_AWMISC		0x11c
+#define EXYNOS_PCIE_APPL_SLV_ARMISC		0x120
+#define EXYNOS_PCIE_APPL_SLV_DBI_ENABLE	BIT(21)
 
 struct exynos_pcie {
 	struct dw_pcie			pci;
-	void __iomem			*elbi_base;
+	void __iomem			*appl_base;
 	struct clk_bulk_data		*clks;
 	int				clk_cnt;
 	struct phy			*phy;
@@ -93,49 +93,49 @@ static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_ELBI_SLV_AWMISC);
+	val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_APPL_SLV_AWMISC);
 	if (on)
-		val |= EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
+		val |= EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
 	else
-		val &= ~EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
-	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_ELBI_SLV_AWMISC);
+		val &= ~EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
+	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_APPL_SLV_AWMISC);
 }
 
 static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *ep, bool on)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_ELBI_SLV_ARMISC);
+	val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_APPL_SLV_ARMISC);
 	if (on)
-		val |= EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
+		val |= EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
 	else
-		val &= ~EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
-	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_ELBI_SLV_ARMISC);
+		val &= ~EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
+	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_APPL_SLV_ARMISC);
 }
 
 static void exynos_pcie_assert_core_reset(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_CORE_RESET);
+	val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_CORE_RESET);
 	val &= ~EXYNOS_PCIE_CORE_RESET_ENABLE;
-	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_CORE_RESET);
-	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_STICKY_RESET);
-	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_NONSTICKY_RESET);
+	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_CORE_RESET);
+	exynos_pcie_writel(ep->appl_base, 0, EXYNOS_PCIE_STICKY_RESET);
+	exynos_pcie_writel(ep->appl_base, 0, EXYNOS_PCIE_NONSTICKY_RESET);
 }
 
 static void exynos_pcie_deassert_core_reset(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_CORE_RESET);
+	val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_CORE_RESET);
 	val |= EXYNOS_PCIE_CORE_RESET_ENABLE;
 
-	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_CORE_RESET);
-	exynos_pcie_writel(ep->elbi_base, 1, EXYNOS_PCIE_STICKY_RESET);
-	exynos_pcie_writel(ep->elbi_base, 1, EXYNOS_PCIE_NONSTICKY_RESET);
-	exynos_pcie_writel(ep->elbi_base, 1, EXYNOS_PCIE_APP_INIT_RESET);
-	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_APP_INIT_RESET);
+	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_CORE_RESET);
+	exynos_pcie_writel(ep->appl_base, 1, EXYNOS_PCIE_STICKY_RESET);
+	exynos_pcie_writel(ep->appl_base, 1, EXYNOS_PCIE_NONSTICKY_RESET);
+	exynos_pcie_writel(ep->appl_base, 1, EXYNOS_PCIE_APP_INIT_RESET);
+	exynos_pcie_writel(ep->appl_base, 0, EXYNOS_PCIE_APP_INIT_RESET);
 }
 
 static int exynos_pcie_start_link(struct dw_pcie *pci)
@@ -143,21 +143,21 @@ static int exynos_pcie_start_link(struct dw_pcie *pci)
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
 	u32 val;
 
-	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_SW_WAKE);
+	val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_SW_WAKE);
 	val &= ~EXYNOS_PCIE_BUS_EN;
-	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_SW_WAKE);
+	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_SW_WAKE);
 
 	/* assert LTSSM enable */
-	exynos_pcie_writel(ep->elbi_base, EXYNOS_PCIE_ELBI_LTSSM_ENABLE,
+	exynos_pcie_writel(ep->appl_base, EXYNOS_PCIE_APPL_LTSSM_ENABLE,
 			  EXYNOS_PCIE_APP_LTSSM_ENABLE);
 	return 0;
 }
 
 static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
 {
-	u32 val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_IRQ_PULSE);
+	u32 val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_IRQ_PULSE);
 
-	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_IRQ_PULSE);
+	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_IRQ_PULSE);
 }
 
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
@@ -173,9 +173,9 @@ static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
 	u32 val = EXYNOS_IRQ_INTA_ASSERT | EXYNOS_IRQ_INTB_ASSERT |
 		  EXYNOS_IRQ_INTC_ASSERT | EXYNOS_IRQ_INTD_ASSERT;
 
-	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_IRQ_EN_PULSE);
-	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_IRQ_EN_LEVEL);
-	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_IRQ_EN_SPECIAL);
+	exynos_pcie_writel(ep->appl_base, val, EXYNOS_PCIE_IRQ_EN_PULSE);
+	exynos_pcie_writel(ep->appl_base, 0, EXYNOS_PCIE_IRQ_EN_LEVEL);
+	exynos_pcie_writel(ep->appl_base, 0, EXYNOS_PCIE_IRQ_EN_SPECIAL);
 }
 
 static u32 exynos_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
@@ -232,9 +232,9 @@ static struct pci_ops exynos_pci_ops = {
 static int exynos_pcie_link_up(struct dw_pcie *pci)
 {
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
-	u32 val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_ELBI_RDLH_LINKUP);
+	u32 val = exynos_pcie_readl(ep->appl_base, EXYNOS_PCIE_APPL_RDLH_LINKUP);
 
-	return (val & EXYNOS_PCIE_ELBI_XMLH_LINKUP);
+	return (val & EXYNOS_PCIE_APPL_XMLH_LINKUP);
 }
 
 static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
@@ -315,10 +315,10 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(ep->phy))
 		return PTR_ERR(ep->phy);
 
-	/* External Local Bus interface (ELBI) registers */
-	ep->elbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
-	if (IS_ERR(ep->elbi_base))
-		return PTR_ERR(ep->elbi_base);
+	/* Application logic registers */
+	ep->appl_base = devm_platform_ioremap_resource_byname(pdev, "appl");
+	if (IS_ERR(ep->appl_base))
+		return PTR_ERR(ep->appl_base);
 
 	ret = exynos_pcie_init_clk_resources(ep);
 	if (ret < 0)
-- 
2.17.1

