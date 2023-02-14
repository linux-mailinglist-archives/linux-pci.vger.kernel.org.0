Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894976966C4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjBNO0m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjBNO0V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:26:21 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF2922A16
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:26:13 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230214141036epoutp03d44adba7eb0690ced2e02ea97218a7a9~DtjePH37i1722517225epoutp03e
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:10:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230214141036epoutp03d44adba7eb0690ced2e02ea97218a7a9~DtjePH37i1722517225epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383836;
        bh=yPfAt9ZEYFCzh/HAJPtibMGnwe48kdLxqS78BSOGynE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDl6OmAYjIvxY4kClHI5UVLFh75JI6Ug8ZLAnYr5Xx9gAZgvniM3E/wGgl0xWONCK
         81kr6IOexDXwpK1ScqE+qzUy+d5A+G6kf5Sv/EDn5cm3k55BwaRzbBovYkxLv/XO00
         JBZb7tiWsABhGAuKxLQqNeNEFpz0xBHVqkLqhqzs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230214141034epcas5p236a6e9a4b55a69ad122ef81d96e46c84~DtjdIl8NZ0163401634epcas5p2b;
        Tue, 14 Feb 2023 14:10:34 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PGNQd4zqSz4x9Pp; Tue, 14 Feb
        2023 14:10:33 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.98.06765.9569BE36; Tue, 14 Feb 2023 23:10:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230214121440epcas5p46db82a141c3e2664cff4b290b49c3938~Dr_P-dY5w1007810078epcas5p4e;
        Tue, 14 Feb 2023 12:14:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230214121440epsmtrp173e65dc5c147190ee7241b11956b2c93~Dr_P_TDNQ1788717887epsmtrp1F;
        Tue, 14 Feb 2023 12:14:40 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-61-63eb96596475
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.0B.17995.F2B7BE36; Tue, 14 Feb 2023 21:14:39 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121437epsmtip1f825737ce144318188ec9e3afb312c2b~Dr_NKqQiS2493824938epsmtip1S;
        Tue, 14 Feb 2023 12:14:36 +0000 (GMT)
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
Subject: [PATCH 09/16] PCI: samsung: Make common appl readl/writel functions
Date:   Tue, 14 Feb 2023 17:43:26 +0530
Message-Id: <20230214121333.1837-10-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmhm7ktNfJBiduqVg8mLeNzWJJU4bF
        /CPnWC1mbZvLaPHx9zkWixVfZrJb9L14yGzR0POb1WLT42usFpd3zWGzODvvOJvFjPP7mCxa
        /rSwWLQcbWexWHvkLrvFoq1f2C3+79nBbvFn+gcWi97DtRabN01ldhDxeLPpO7vHzll32T0W
        bCr12LSqk83jzrU9bB7vzp1j93hyZTqTx+Yl9R4b3+1g8ljU8JHNo2/LKkaPz5vkAniism0y
        UhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgN5UUihLzCkF
        CgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnTFvR
        wFLwUrfiwoGIBsZv6l2MnBwSAiYSv35NYu9i5OIQEtjNKLHu0iFWkISQwCdGialf5SESnxkl
        7q/8w9LFyAHW8eRdBkR8F1B82wdmCKeVSaJl/S1GkG42AS2Jxq9dYAkRgVtMEi8/PwTbwSxw
        ilHiwIu97CBVwgI+Ej+fXADrYBFQlei+sZkZxOYVsJLY0/OQGeJAeYnVGw6A2ZxA8ZbWTWBT
        JQRucEgcnrSEBaLIRaLnyFwoW1ji1fEt7BC2lMTL/jYoO11i5eYZUENzJL5tXsIEYdtLHLgy
        B+w3ZgFNifW79CHCshJTT60DK2EW4JPo/f0EqpxXYsc8GFtZ4svfPVBrJSXmHbvMCmF7SFz6
        v4UREiy9jBITuv4wT2CUm4WwYgEj4ypGydSC4tz01GLTAuO81HJ4rCXn525iBCdlLe8djI8e
        fNA7xMjEwXiIUYKDWUmEV/jpi2Qh3pTEyqrUovz4otKc1OJDjKbAAJzILCWanA/MC3kl8YYm
        lgYmZmZmJpbGZoZK4rzqtieThQTSE0tSs1NTC1KLYPqYODilGpgm9KsEeZ/d+eVJ50/zzH6H
        c79jX/w1Ko86Z9IgaR/VxP3E+ZVL/Lzn1+IU/+m7G2RMZ2B588Gw75hzxBNVe8vPcuLb1l0z
        sw+Lzzh6NnbPtaNZpVM2eP2SU1prb/nnQEPWlGMZa780z3q497+x88qqt6v8vvTycP4PT73K
        22kS+OVKSdmrVWwyjk+dJka5aonEb/3hKDdhVUDA79dLzitJ54mf8TEJ/vHEe58b61KFYgOV
        ywl33v+4EXX9dJnOo802ipKiMtcONE18xS+d9/f9R27/qbfbw3t7V9TGfc/3eqXBsnZxfCaH
        sL9y+bGid7JTqsXuzxZ91mhvPfmb+r/fi2aHut++eEhdMsH5fJ0SS3FGoqEWc1FxIgBX67SJ
        UwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnK5+9etkg5d/bCwezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBnTVjSwFLzUrbhwIKKB8Zt6FyMHh4SAicSTdxldjFwcQgI7GCW+vr7A2MXI
        CRSXlPh8cR0ThC0ssfLfc3aIomYmib5T91hBEmwCWhKNX7uYQRIiAq+YJA7vmQHmMAtcYJS4
        dbCbHaRKWMBH4ucTiLEsAqoS3Tc2M4PYvAJWEnt6HjJDrJCXWL3hAJjNCRRvad0EZgsJWErM
        +rWKcQIj3wJGhlWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMFxo6W1g3HPqg96hxiZ
        OBgPMUpwMCuJ8Ao/fZEsxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQi
        mCwTB6dUA5OJtb7Ysjm/zzTo+u8Xed9g++L+z4nbi3buKT/4Ibts+/tAtiKGf6zb9yqE/H0l
        HKNjsMGH9abR3CW8VwW/dl0pnJbsuvzpp4XRHIWrtuueXCTdtGTyovNrWdnqY3VVTzO5blR7
        tOq1fnFFvEJcMGcP18XNfgfs00/KWGTXNbMcijzbdXDLz+P6N3/0HdIuiYn8fZPlVXtM6eTy
        6+mi9Yt+5K2q/VizrUNnrqUoY8amhby3LH30Jp6SeCXTyPm/28z4cvnFcuPjG+/dfmeel1zQ
        yeXHHmjGUM3qvP/p3TyRHcuCfnHYhYkGPfWYpcF0+o3y7jUyht7/HyZPzUiYcnb2m8f5SR2T
        Dpkqfk3Xl1ViKc5INNRiLipOBACL4r2/CgMAAA==
X-CMS-MailID: 20230214121440epcas5p46db82a141c3e2664cff4b290b49c3938
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121440epcas5p46db82a141c3e2664cff4b290b49c3938
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121440epcas5p46db82a141c3e2664cff4b290b49c3938@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Common application logic register read and write functions
used for better readability.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-samsung.c | 54 ++++++++++++------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
index be0177fcd763..e6e2a8ab4403 100644
--- a/drivers/pci/controller/dwc/pci-samsung.c
+++ b/drivers/pci/controller/dwc/pci-samsung.c
@@ -79,63 +79,63 @@ static void exynos_pcie_deinit_clk_resources(struct samsung_pcie *sp)
 	clk_bulk_disable_unprepare(sp->clk_cnt, sp->clks);
 }
 
-static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
+static void samsung_pcie_appl_writel(struct samsung_pcie *sp, u32 val, u32 reg)
 {
-	writel(val, base + reg);
+	writel(val, sp->appl_base + reg);
 }
 
-static u32 exynos_pcie_readl(void __iomem *base, u32 reg)
+static unsigned int samsung_pcie_appl_readl(struct samsung_pcie *sp, u32 reg)
 {
-	return readl(base + reg);
+	return readl(sp->appl_base + reg);
 }
 
 static void exynos_pcie_sideband_dbi_w_mode(struct samsung_pcie *sp, bool on)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_APPL_SLV_AWMISC);
+	val = samsung_pcie_appl_readl(sp, EXYNOS_PCIE_APPL_SLV_AWMISC);
 	if (on)
 		val |= EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
 	else
 		val &= ~EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
-	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_APPL_SLV_AWMISC);
+	samsung_pcie_appl_writel(sp, val, EXYNOS_PCIE_APPL_SLV_AWMISC);
 }
 
 static void exynos_pcie_sideband_dbi_r_mode(struct samsung_pcie *sp, bool on)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_APPL_SLV_ARMISC);
+	val = samsung_pcie_appl_readl(sp, EXYNOS_PCIE_APPL_SLV_ARMISC);
 	if (on)
 		val |= EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
 	else
 		val &= ~EXYNOS_PCIE_APPL_SLV_DBI_ENABLE;
-	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_APPL_SLV_ARMISC);
+	samsung_pcie_appl_writel(sp, val, EXYNOS_PCIE_APPL_SLV_ARMISC);
 }
 
 static void exynos_pcie_assert_core_reset(struct samsung_pcie *sp)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_CORE_RESET);
+	val = samsung_pcie_appl_readl(sp, EXYNOS_PCIE_CORE_RESET);
 	val &= ~EXYNOS_PCIE_CORE_RESET_ENABLE;
-	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_CORE_RESET);
-	exynos_pcie_writel(sp->appl_base, 0, EXYNOS_PCIE_STICKY_RESET);
-	exynos_pcie_writel(sp->appl_base, 0, EXYNOS_PCIE_NONSTICKY_RESET);
+	samsung_pcie_appl_writel(sp, val, EXYNOS_PCIE_CORE_RESET);
+	samsung_pcie_appl_writel(sp, 0, EXYNOS_PCIE_STICKY_RESET);
+	samsung_pcie_appl_writel(sp, 0, EXYNOS_PCIE_NONSTICKY_RESET);
 }
 
 static void exynos_pcie_deassert_core_reset(struct samsung_pcie *sp)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_CORE_RESET);
+	val = samsung_pcie_appl_readl(sp, EXYNOS_PCIE_CORE_RESET);
 	val |= EXYNOS_PCIE_CORE_RESET_ENABLE;
 
-	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_CORE_RESET);
-	exynos_pcie_writel(sp->appl_base, 1, EXYNOS_PCIE_STICKY_RESET);
-	exynos_pcie_writel(sp->appl_base, 1, EXYNOS_PCIE_NONSTICKY_RESET);
-	exynos_pcie_writel(sp->appl_base, 1, EXYNOS_PCIE_APP_INIT_RESET);
-	exynos_pcie_writel(sp->appl_base, 0, EXYNOS_PCIE_APP_INIT_RESET);
+	samsung_pcie_appl_writel(sp, val, EXYNOS_PCIE_CORE_RESET);
+	samsung_pcie_appl_writel(sp, 1, EXYNOS_PCIE_STICKY_RESET);
+	samsung_pcie_appl_writel(sp, 1, EXYNOS_PCIE_NONSTICKY_RESET);
+	samsung_pcie_appl_writel(sp, 1, EXYNOS_PCIE_APP_INIT_RESET);
+	samsung_pcie_appl_writel(sp, 0, EXYNOS_PCIE_APP_INIT_RESET);
 }
 
 static int exynos_pcie_start_link(struct dw_pcie *pci)
@@ -143,21 +143,21 @@ static int exynos_pcie_start_link(struct dw_pcie *pci)
 	struct samsung_pcie *sp = to_samsung_pcie(pci);
 	u32 val;
 
-	val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_SW_WAKE);
+	val = samsung_pcie_appl_readl(sp, EXYNOS_PCIE_SW_WAKE);
 	val &= ~EXYNOS_PCIE_BUS_EN;
-	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_SW_WAKE);
+	samsung_pcie_appl_writel(sp, val, EXYNOS_PCIE_SW_WAKE);
 
 	/* assert LTSSM enable */
-	exynos_pcie_writel(sp->appl_base, EXYNOS_PCIE_APPL_LTSSM_ENABLE,
+	samsung_pcie_appl_writel(sp, EXYNOS_PCIE_APPL_LTSSM_ENABLE,
 			  EXYNOS_PCIE_APP_LTSSM_ENABLE);
 	return 0;
 }
 
 static void exynos_pcie_clear_irq_pulse(struct samsung_pcie *sp)
 {
-	u32 val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_IRQ_PULSE);
+	u32 val = samsung_pcie_appl_readl(sp, EXYNOS_PCIE_IRQ_PULSE);
 
-	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_IRQ_PULSE);
+	samsung_pcie_appl_writel(sp, val, EXYNOS_PCIE_IRQ_PULSE);
 }
 
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
@@ -173,9 +173,9 @@ static void exynos_pcie_enable_irq_pulse(struct samsung_pcie *sp)
 	u32 val = EXYNOS_IRQ_INTA_ASSERT | EXYNOS_IRQ_INTB_ASSERT |
 		  EXYNOS_IRQ_INTC_ASSERT | EXYNOS_IRQ_INTD_ASSERT;
 
-	exynos_pcie_writel(sp->appl_base, val, EXYNOS_PCIE_IRQ_EN_PULSE);
-	exynos_pcie_writel(sp->appl_base, 0, EXYNOS_PCIE_IRQ_EN_LEVEL);
-	exynos_pcie_writel(sp->appl_base, 0, EXYNOS_PCIE_IRQ_EN_SPECIAL);
+	samsung_pcie_appl_writel(sp, val, EXYNOS_PCIE_IRQ_EN_PULSE);
+	samsung_pcie_appl_writel(sp, 0, EXYNOS_PCIE_IRQ_EN_LEVEL);
+	samsung_pcie_appl_writel(sp, 0, EXYNOS_PCIE_IRQ_EN_SPECIAL);
 }
 
 static u32 exynos_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
@@ -232,7 +232,7 @@ static struct pci_ops exynos_pci_ops = {
 static int exynos_pcie_link_up(struct dw_pcie *pci)
 {
 	struct samsung_pcie *sp = to_samsung_pcie(pci);
-	u32 val = exynos_pcie_readl(sp->appl_base, EXYNOS_PCIE_APPL_RDLH_LINKUP);
+	u32 val = samsung_pcie_appl_readl(sp, EXYNOS_PCIE_APPL_RDLH_LINKUP);
 
 	return (val & EXYNOS_PCIE_APPL_XMLH_LINKUP);
 }
-- 
2.17.1

