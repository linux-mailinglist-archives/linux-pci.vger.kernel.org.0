Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF77BD485
	for <lists+linux-pci@lfdr.de>; Mon,  9 Oct 2023 09:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345433AbjJIHmB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjJIHmA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 03:42:00 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D830FB6
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 00:41:55 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231009074151epoutp04adfbf2641b36f949736cebefcd426095~MYIuBilUU1220712207epoutp044
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 07:41:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231009074151epoutp04adfbf2641b36f949736cebefcd426095~MYIuBilUU1220712207epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696837311;
        bh=XmObJIzD9Lt8nPGtTzTK9vhVCGY5IyKpZEinmv8bYkM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hYxxaw2KxAzZWBPxG/WeZA0fO8t0LL0M6zV6rWNe4y42mjUt7hiLartAdrMq5zE5X
         vvWJf734o3lHVpOtqxaQEik83MZn/7BeIqKNzW4fM30pC8A5SkkhMh7zCNhc/bWKdU
         al1HtbCkEK8uqlR2f4hq32AOYVIKT++d/pYdqb9Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231009074151epcas5p241b8b117fc21d25da7f825452861dc39~MYItj38eO1609616096epcas5p20;
        Mon,  9 Oct 2023 07:41:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4S3rZk2Jyxz4x9Pp; Mon,  9 Oct
        2023 07:41:50 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.D8.09635.EBEA3256; Mon,  9 Oct 2023 16:41:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231009062058epcas5p4dc1fb50210c920137ac906b0bdf99e1b~MXCGIVq_r1984419844epcas5p4F;
        Mon,  9 Oct 2023 06:20:58 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231009062058epsmtrp191995e55d1a8e06d3ed464479eeded0b~MXCGHf0WT0451604516epsmtrp1A;
        Mon,  9 Oct 2023 06:20:58 +0000 (GMT)
X-AuditID: b6c32a4b-2f5ff700000025a3-5b-6523aebe5b16
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.55.08649.ACB93256; Mon,  9 Oct 2023 15:20:58 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231009062056epsmtip122312ff2d5fa6c15409a4eb6a370e6e8~MXCD6DbBE0717507175epsmtip1D;
        Mon,  9 Oct 2023 06:20:56 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pankaj.dubey@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH] PCI: exynos: Change macro names to exynos specific
Date:   Mon,  9 Oct 2023 11:50:52 +0530
Message-Id: <20231009062052.5407-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmlu6+dcqpBvv+cVs8mLeNzWJJU4bF
        ii8z2S32vt7KbtHQ85vVYtPja6wWl3fNYbM4O+84m8WM8/uYLFr+tLBYLNr6hd3i/54d7Ba9
        h2sdeD12zrrL7rFgU6nHplWdbB53ru1h83hyZTqTx+Yl9R59W1YxenzeJBfAEZVtk5GamJJa
        pJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0r5JCWWJOKVAoILG4
        WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+Py/+NMBets
        K2ZsZG9gnGvaxcjBISFgIvH2sVEXIxeHkMBuRokTJ94xQjifGCWefF8L5XxjlHjQ0MjaxcgJ
        1tF3bRIbRGIvo8TbmdOgnFYmiV/zp7CBVLEJaEk0fu1iBkmICCxglFjWd4AJxGEWOMEo0Xp+
        IQtIlbCAs0T7q/vMIDaLgKpE04unYDavgKXE+SsrWCD2yUus3nAAbJKEwFt2iTez/jFCnO4i
        sW1CLUSNsMSr41vYIWwpiZf9bVB2usTKzTOYIewciW+blzBB2PYSB67MYQEZwyygKbF+lz5E
        WFZi6ql1YCXMAnwSvb+fQJXzSuyYB2MrS3z5uwfqNEmJeccus0Jc4yFx9hUPSFhIIFbi/rul
        LBMYZWchLFjAyLiKUTK1oDg3PbXYtMA4L7UcHk/J+bmbGMGpUMt7B+OjBx/0DjEycTAeYpTg
        YFYS4dUtVUgV4k1JrKxKLcqPLyrNSS0+xGgKDLGJzFKiyfnAZJxXEm9oYmlgYmZmZmJpbGao
        JM77unVuipBAemJJanZqakFqEUwfEwenVANTUdvO/Z51lbf7n5UzFs88d7p16/UrzzfXm079
        ovn4Xte9bL88f//nc9R/7NN2jo6PS52y8b9gjuLMnIolVUKyxnO2fbg//6XqxYkHVhtOc14W
        nX0/8Wca25TA+2/eWbn0XN+fznzr5gwnYw+OSTL+7QVi31IPnfD4f+LarVoeq9c9TInmGjN0
        JumU5ZtoL5Zn6fv2NUf49r3186c6Com5HdFiPpO3w03hyOzLOw5feh2ibZXg91DKruH6uule
        TWXGl5Z9mPVBqVrBX1jTvUS2RPl2R7/P9DCvI8Kzju+p11w3aQq/5NHYKC2WtmtrVnHz6Xmw
        LD8953jPbQsJ4ZTErZfet6YUzlZQ29opLJirxFKckWioxVxUnAgA7tqNxw4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnO6p2cqpBksPKFk8mLeNzWJJU4bF
        ii8z2S32vt7KbtHQ85vVYtPja6wWl3fNYbM4O+84m8WM8/uYLFr+tLBYLNr6hd3i/54d7Ba9
        h2sdeD12zrrL7rFgU6nHplWdbB53ru1h83hyZTqTx+Yl9R59W1YxenzeJBfAEcVlk5Kak1mW
        WqRvl8CVcfn/caaCdbYVMzayNzDONe1i5OSQEDCR6Ls2ia2LkYtDSGA3o8SfhTPYIRKSEp8v
        rmOCsIUlVv57zg5R1Mwk0fLsNxtIgk1AS6LxaxczSEJEYAWjxKojN8AcZoFzjBKT/35nBqkS
        FnCWaH91H8xmEVCVaHrxFMzmFbCUOH9lBQvECnmJ1RsOME9g5FnAyLCKUTK1oDg3PTfZsMAw
        L7Vcrzgxt7g0L10vOT93EyM4NLU0djDem/9P7xAjEwfjIUYJDmYlEV7dUoVUId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4ryGM2anCAmkJ5akZqemFqQWwWSZODilGpg07E6XLJy/qKZ/2p6vpqzv
        b99ad3EWt/pXDQk7CaWFCp/XeN41eDpXQO5+KXfcc9adQftfPfCbelt7bqCo4vdyR/WILak2
        7U8W7W8XNI3hqov/qu26Y5JlU9CkJaUiUs7M7sETT/387fD7yQ3OJeeMtHbJWD7/LzAjhSva
        LCHK4t8G4RNvsnm7Dm/57TJffUZIRJrEA8HicDGdv4+S3CZ1V4jI2T7nSBfYLyheK7Uxy2hO
        g6rta1nlDTfUsti3fj0YeP/Vrs5562w2Gp21envpeve1BC2F6Oam4J1rV7ZH54gKZT3n6KrX
        X5yzvXYV56aWpd9SmPceTFgRIe4dGGOrN23ZMYH4H4kvk7Re+CqxFGckGmoxFxUnAgAO/XZB
        vAIAAA==
X-CMS-MailID: 20231009062058epcas5p4dc1fb50210c920137ac906b0bdf99e1b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231009062058epcas5p4dc1fb50210c920137ac906b0bdf99e1b
References: <CGME20231009062058epcas5p4dc1fb50210c920137ac906b0bdf99e1b@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Prefix macro names in exynos file with the term "EXYNOS" as the current
macro names seem to be generic to PCIe.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 116 ++++++++++++------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 6319082301d6..9e42cfcd99cc 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
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

