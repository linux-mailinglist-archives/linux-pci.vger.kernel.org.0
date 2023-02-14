Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D1769668E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjBNOVp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjBNOVm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:21:42 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3EB298D7
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:21:15 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230214140735epoutp04c55f4c633b70f305aa4e44444e6ee50e~Dtg2c4nN62320223202epoutp04B
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:07:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230214140735epoutp04c55f4c633b70f305aa4e44444e6ee50e~Dtg2c4nN62320223202epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383655;
        bh=RWBmjFAwipURTdEjBQt0TPuT+ojNakaSjKcHTBJXkBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=flkcQ8aBiwH5fI6ogkIJOiyucVrCJe6cvO3DS/r/X7w0O76qCp0gmr1nbO/dJF86g
         zSeU+FfppgqHeBTa1PII3sc9xvn/YaRi5eySGxu/Uh7Z1TXFwhlH1myz3384kC3sAN
         7d1Vo/zOxx+nLslqVR2NYWuhv38n1f1ltZmV6a7I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230214140735epcas5p315479286ae9c7f9145628af0b24b28ae~Dtg1xrAsn1511815118epcas5p3w;
        Tue, 14 Feb 2023 14:07:35 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PGNMB03PYz4x9Pq; Tue, 14 Feb
        2023 14:07:34 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.00.55678.5A59BE36; Tue, 14 Feb 2023 23:07:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230214121416epcas5p4de066199144cba18858e68f6d0ccb1c0~Dr959w0Rh0536905369epcas5p4G;
        Tue, 14 Feb 2023 12:14:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230214121416epsmtrp2e21356409ec312791e8d8bb7d6d43f7d~Dr9585lPw1888418884epsmtrp2P;
        Tue, 14 Feb 2023 12:14:16 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-5b-63eb95a5b1ff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.8E.05839.81B7BE36; Tue, 14 Feb 2023 21:14:16 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121412epsmtip16b2056a766c6d8bfdb919dd9855aabcb~Dr92tqndW2484124841epsmtip1M;
        Tue, 14 Feb 2023 12:14:12 +0000 (GMT)
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
Subject: [PATCH 03/16] PCI: samsung: Change macro names to exynos specific
Date:   Tue, 14 Feb 2023 17:43:20 +0530
Message-Id: <20230214121333.1837-4-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmhu7Sqa+TDV48M7V4MG8bm8WSpgyL
        +UfOsVrM2jaX0eLj73MsFiu+zGS36HvxkNmioec3q8Wmx9dYLS7vmsNmcXbecTaLGef3MVm0
        /GlhsWg52s5isfbIXXaLRVu/sFv837OD3eLP9A8sFr2Hay02b5rK7CDi8WbTd3aPnbPusnss
        2FTqsWlVJ5vHnWt72DzenTvH7vHkynQmj81L6j02vtvB5LGo4SObR9+WVYwenzfJBfBEZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAL2ppFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO6H4z
        k63gtm3FpCmz2RsYT5h2MXJySAiYSPQ3bmbqYuTiEBLYzSgx4cEDZgjnE6PE8qknoTLfGCWa
        G24zw7T0zXrNCpHYyyixf/9iqJZWJolNG6exglSxCWhJNH7tAkuICNxiknj5+SE7iMMscIpR
        4sCLvewgVcICXhKd9z4zgtgsAqoSD58sAYvzClhKPJ6+lg1in7zE6g0HwHZzClhJtLRuApsq
        IXCDQ+L0vVksEEUuEkdvTWKEsIUlXh3fwg5hS0l8frcXalC6xMrNM6CeyJH4tnkJE4RtL3Hg
        yhygORxA12lKrN+lDxGWlZh6ah1YCbMAn0Tv7ydQ5bwSO+bB2MoSX/7ugTpBUmLescusELaH
        xK5/KxghwdLLKPF72jGWCYxysxBWLGBkXMUomVpQnJueWmxaYJSXWg6PuOT83E2M4NSs5bWD
        8eGDD3qHGJk4GA8xSnAwK4nwCj99kSzEm5JYWZValB9fVJqTWnyI0RQYgBOZpUST84HZIa8k
        3tDE0sDEzMzMxNLYzFBJnFfd9mSykEB6YklqdmpqQWoRTB8TB6dUA9OsVfqhtsKSoWIvVy/b
        4HP7y6JAplNT7N00ogXXtH5Q1fFXO7ZLNcQwIWmG8isNBcZHXw/xXv5z5lLtv5+SxowRqxQO
        v+79Nivn3OauwkuHZWWOxjcs/ekgf3yvoP0epwnrJacqND8+6b/V8WvG1UZm5uVuymvLLXcs
        /twd7rfs2EK++UsevtWaE/Cn/cmlzd3/6qvmqrc+NlGTbjAsUG+WvsSStak6cVfI+QMets3h
        3GvCztyf8EnpccCD/YpR72I5T/5/7Fu2ztPoiZ5CRNhEd9Ef9udfqM5N63w07cX5vV5NZfOk
        GFqzjSbkntZ+vrjo2NO6lTdnTv5rW7779BehMp3YWx9Ov5Kq6shMq/yoxFKckWioxVxUnAgA
        zbP9MFYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnK5E9etkgw9zxSwezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBndb2ayFdy2rZg0ZTZ7A+MJ0y5GTg4JAROJvlmvWbsYuTiEBHYzStyefpoJ
        IiEp8fniOihbWGLlv+fsEEXNTBKn1x5mBEmwCWhJNH7tYgZJiAi8YpI4vGcGmMMscIFR4tbB
        bnaQKmEBL4nOe5/BOlgEVCUePlkCFucVsJR4PH0tG8QKeYnVGw4wg9icAlYSLa2bwGwhoJpZ
        v1YxTmDkW8DIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzh2tDR3MG5f9UHvECMT
        B+MhRgkOZiURXuGnL5KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoE
        k2Xi4JRqYOqYNVus/x3vzRdCm6bF3/szT++G6MmJB1+f+l+yOmTC9I6X9var2Oy6b6c4e2f3
        Hd+1to4nZlGC586Fkx9tncsivr1EIylU3t/rsEXQdQ6LF+tzk79OX7Trq2pI/e+T/z9/m6Ph
        v5B/lYb173/xJ7s9M5YGpa7aHKt95/Kz5JeNr0udtsxZtMa6Uc3g4tYu11n/lIU4+X/27SpJ
        sp4ee/gN+4wSy2CLlt8KLzb2nzVZqqrOJ2O6ZS7jmSOHjHJ+WPozzvp1ec32mt8C7CGRR2+H
        XddeqDRT8Jfrt9vSdn++rTwWmy6da8TP8I7LsFLpaNW3GXZHVI79LKq2+Jhlnnhedm4/43+F
        r6t/NIl805JVYinOSDTUYi4qTgQAqey39AwDAAA=
X-CMS-MailID: 20230214121416epcas5p4de066199144cba18858e68f6d0ccb1c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121416epcas5p4de066199144cba18858e68f6d0ccb1c0
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121416epcas5p4de066199144cba18858e68f6d0ccb1c0@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since the macros being used in samsung file are for exynos
only, renaming it to be more specific.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/pci/controller/dwc/pci-samsung.c | 116 +++++++++++------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
index cc562a8694fb..cfe384aee754 100644
--- a/drivers/pci/controller/dwc/pci-samsung.c
+++ b/drivers/pci/controller/dwc/pci-samsung.c
@@ -26,30 +26,30 @@
 #define to_exynos_pcie(x)	dev_get_drvdata((x)->dev)
 
 /* PCIe ELBI registers */
-#define PCIE_IRQ_PULSE			0x000
-#define IRQ_INTA_ASSERT			BIT(0)
-#define IRQ_INTB_ASSERT			BIT(2)
-#define IRQ_INTC_ASSERT			BIT(4)
-#define IRQ_INTD_ASSERT			BIT(6)
-#define PCIE_IRQ_LEVEL			0x004
-#define PCIE_IRQ_SPECIAL		0x008
-#define PCIE_IRQ_EN_PULSE		0x00c
-#define PCIE_IRQ_EN_LEVEL		0x010
-#define PCIE_IRQ_EN_SPECIAL		0x014
-#define PCIE_SW_WAKE			0x018
-#define PCIE_BUS_EN			BIT(1)
-#define PCIE_CORE_RESET			0x01c
-#define PCIE_CORE_RESET_ENABLE		BIT(0)
-#define PCIE_STICKY_RESET		0x020
-#define PCIE_NONSTICKY_RESET		0x024
-#define PCIE_APP_INIT_RESET		0x028
-#define PCIE_APP_LTSSM_ENABLE		0x02c
-#define PCIE_ELBI_RDLH_LINKUP		0x074
-#define PCIE_ELBI_XMLH_LINKUP		BIT(4)
-#define PCIE_ELBI_LTSSM_ENABLE		0x1
-#define PCIE_ELBI_SLV_AWMISC		0x11c
-#define PCIE_ELBI_SLV_ARMISC		0x120
-#define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
+#define EXYNOS_PCIE_IRQ_PULSE			0x000
+#define EXYNOS_IRQ_INTA_ASSERT			BIT(0)
+#define EXYNOS_IRQ_INTB_ASSERT			BIT(2)
+#define EXYNOS_IRQ_INTC_ASSERT			BIT(4)
+#define EXYNOS_IRQ_INTD_ASSERT			BIT(6)
+#define EXYNOS_PCIE_IRQ_LEVEL			0x004
+#define EXYNOS_PCIE_IRQ_SPECIAL		0x008
+#define EXYNOS_PCIE_IRQ_EN_PULSE		0x00c
+#define EXYNOS_PCIE_IRQ_EN_LEVEL		0x010
+#define EXYNOS_PCIE_IRQ_EN_SPECIAL		0x014
+#define EXYNOS_PCIE_SW_WAKE			0x018
+#define EXYNOS_PCIE_BUS_EN			BIT(1)
+#define EXYNOS_PCIE_CORE_RESET			0x01c
+#define EXYNOS_PCIE_CORE_RESET_ENABLE		BIT(0)
+#define EXYNOS_PCIE_STICKY_RESET		0x020
+#define EXYNOS_PCIE_NONSTICKY_RESET		0x024
+#define EXYNOS_PCIE_APP_INIT_RESET		0x028
+#define EXYNOS_PCIE_APP_LTSSM_ENABLE		0x02c
+#define EXYNOS_PCIE_ELBI_RDLH_LINKUP		0x074
+#define EXYNOS_PCIE_ELBI_XMLH_LINKUP		BIT(4)
+#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
+#define EXYNOS_PCIE_ELBI_SLV_AWMISC		0x11c
+#define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
+#define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
 
 struct exynos_pcie {
 	struct dw_pcie			pci;
@@ -105,49 +105,49 @@ static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
+	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_ELBI_SLV_AWMISC);
 	if (on)
-		val |= PCIE_ELBI_SLV_DBI_ENABLE;
+		val |= EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
 	else
-		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
+		val &= ~EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
+	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_ELBI_SLV_AWMISC);
 }
 
 static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *ep, bool on)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
+	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_ELBI_SLV_ARMISC);
 	if (on)
-		val |= PCIE_ELBI_SLV_DBI_ENABLE;
+		val |= EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
 	else
-		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
+		val &= ~EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
+	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_ELBI_SLV_ARMISC);
 }
 
 static void exynos_pcie_assert_core_reset(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
-	val &= ~PCIE_CORE_RESET_ENABLE;
-	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
-	exynos_pcie_writel(ep->elbi_base, 0, PCIE_STICKY_RESET);
-	exynos_pcie_writel(ep->elbi_base, 0, PCIE_NONSTICKY_RESET);
+	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_CORE_RESET);
+	val &= ~EXYNOS_PCIE_CORE_RESET_ENABLE;
+	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_CORE_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_STICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_NONSTICKY_RESET);
 }
 
 static void exynos_pcie_deassert_core_reset(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
-	val |= PCIE_CORE_RESET_ENABLE;
+	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_CORE_RESET);
+	val |= EXYNOS_PCIE_CORE_RESET_ENABLE;
 
-	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
-	exynos_pcie_writel(ep->elbi_base, 1, PCIE_STICKY_RESET);
-	exynos_pcie_writel(ep->elbi_base, 1, PCIE_NONSTICKY_RESET);
-	exynos_pcie_writel(ep->elbi_base, 1, PCIE_APP_INIT_RESET);
-	exynos_pcie_writel(ep->elbi_base, 0, PCIE_APP_INIT_RESET);
+	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_CORE_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, EXYNOS_PCIE_STICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, EXYNOS_PCIE_NONSTICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, EXYNOS_PCIE_APP_INIT_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_APP_INIT_RESET);
 }
 
 static int exynos_pcie_start_link(struct dw_pcie *pci)
@@ -155,21 +155,21 @@ static int exynos_pcie_start_link(struct dw_pcie *pci)
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
 	u32 val;
 
-	val = exynos_pcie_readl(ep->elbi_base, PCIE_SW_WAKE);
-	val &= ~PCIE_BUS_EN;
-	exynos_pcie_writel(ep->elbi_base, val, PCIE_SW_WAKE);
+	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_SW_WAKE);
+	val &= ~EXYNOS_PCIE_BUS_EN;
+	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_SW_WAKE);
 
 	/* assert LTSSM enable */
-	exynos_pcie_writel(ep->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
-			  PCIE_APP_LTSSM_ENABLE);
+	exynos_pcie_writel(ep->elbi_base, EXYNOS_PCIE_ELBI_LTSSM_ENABLE,
+			  EXYNOS_PCIE_APP_LTSSM_ENABLE);
 	return 0;
 }
 
 static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
 {
-	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_IRQ_PULSE);
+	u32 val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_IRQ_PULSE);
 
-	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_PULSE);
+	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_IRQ_PULSE);
 }
 
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
@@ -182,12 +182,12 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 
 static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
 {
-	u32 val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
-		  IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
+	u32 val = EXYNOS_IRQ_INTA_ASSERT | EXYNOS_IRQ_INTB_ASSERT |
+		  EXYNOS_IRQ_INTC_ASSERT | EXYNOS_IRQ_INTD_ASSERT;
 
-	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_EN_PULSE);
-	exynos_pcie_writel(ep->elbi_base, 0, PCIE_IRQ_EN_LEVEL);
-	exynos_pcie_writel(ep->elbi_base, 0, PCIE_IRQ_EN_SPECIAL);
+	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_IRQ_EN_PULSE);
+	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_IRQ_EN_LEVEL);
+	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_IRQ_EN_SPECIAL);
 }
 
 static u32 exynos_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
@@ -244,9 +244,9 @@ static struct pci_ops exynos_pci_ops = {
 static int exynos_pcie_link_up(struct dw_pcie *pci)
 {
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
-	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_RDLH_LINKUP);
+	u32 val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_ELBI_RDLH_LINKUP);
 
-	return (val & PCIE_ELBI_XMLH_LINKUP);
+	return (val & EXYNOS_PCIE_ELBI_XMLH_LINKUP);
 }
 
 static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
-- 
2.17.1

