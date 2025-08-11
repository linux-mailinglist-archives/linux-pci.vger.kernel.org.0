Return-Path: <linux-pci+bounces-33823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD0AB21C79
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DE0460A15
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736E2D3A86;
	Tue, 12 Aug 2025 05:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WwFcECIc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ADD254B19
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974931; cv=none; b=YAo2+UI8daqk36KttcJBFWy7bglQ4+71bbA7pesk0RW6Gzbm6w6iS9RpwRGdxKYGpp+2s1l3ysN83QWGKqsyxjpk8Mt8wj6l3XdxDhiAIXJKbcNKp8cqnKDWm0eJFFDQZHMfsqRqj+pM495UsY9E8WuhKKZJxyEoPSuUlAdru58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974931; c=relaxed/simple;
	bh=6GNeoJ86xp9/K5fVFW+3oK5Y3XHOLyG/PGdbDUgut3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=mCdKtxFXE3jSyvsARlKT2WB1HnTYpXt72CNbnit9AkjOLkRo6fuXxGvAN0YtepMJ5/a88zJRgdL1eptVmNQ36s0LUEpUIFWxszf0aoW+exSEvcrSioDti1jPNtagLSk7+q8XTl0OtvnvGE+0NwRiH21ldziPNJI7w5NNY2QWi18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WwFcECIc; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250812050207epoutp04bec17dfbc7ba01583b08cbd374ff6967~a7GXcANdg1763917639epoutp04e
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250812050207epoutp04bec17dfbc7ba01583b08cbd374ff6967~a7GXcANdg1763917639epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754974927;
	bh=g+OIPYfZeep00nAL2s8vJenk/L6kOEW7w/EsYvIr9eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WwFcECIcdheeUxpBWxjjNUmJEO1xi56yGg2a/8lub6aL4LGUjv2ddQvDXHqq8LtOv
	 g1QEN3JTlxeRdvVsrutkIUlO3cDABhT0MoUsxdOnTApMIVWrBFm0dJhXWufix1ctwR
	 9yY74ZQBq7msWCwNDSTaRDwxYZmxpCq76Jrkf/PY=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250812050205epcas5p3ec1d0180b5df6900b1fee304310b01cc~a7GWSXLMn2902829028epcas5p3A;
	Tue, 12 Aug 2025 05:02:05 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c1K9m5Y4Dz2SSKd; Tue, 12 Aug
	2025 05:02:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154659epcas5p1874791c7ce4e26a2bd36e24a7be55f51~awQIcaq_x2692426924epcas5p10;
	Mon, 11 Aug 2025 15:46:59 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154656epsmtip1d9d756f77820130ac933dbc336675fc2~awQF0WLN42450724507epsmtip1v;
	Mon, 11 Aug 2025 15:46:56 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3 02/12] PCI: exynos: Change macro names to exynos specific
Date: Mon, 11 Aug 2025 21:16:28 +0530
Message-ID: <20250811154638.95732-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811154638.95732-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250811154659epcas5p1874791c7ce4e26a2bd36e24a7be55f51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154659epcas5p1874791c7ce4e26a2bd36e24a7be55f51
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154659epcas5p1874791c7ce4e26a2bd36e24a7be55f51@epcas5p1.samsung.com>

Prefix macro names in exynos file with the term "EXYNOS" as the current
macro names seem to be generic to PCIe.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 112 ++++++++++++------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index f9140d1f1d19..30d12ff9b0c6 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -26,28 +26,28 @@
 #define to_exynos_pcie(x)	dev_get_drvdata((x)->dev)
 
 /* PCIe ELBI registers */
-#define PCIE_IRQ_PULSE			0x000
-#define IRQ_INTA_ASSERT			BIT(0)
-#define IRQ_INTB_ASSERT			BIT(2)
-#define IRQ_INTC_ASSERT			BIT(4)
-#define IRQ_INTD_ASSERT			BIT(6)
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
+#define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE		BIT(21)
 
 struct exynos_pcie {
 	struct dw_pcie			pci;
@@ -71,49 +71,49 @@ static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
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
@@ -121,21 +121,21 @@ static int exynos_pcie_start_link(struct dw_pcie *pci)
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
@@ -148,12 +148,12 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 
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
@@ -210,9 +210,9 @@ static struct pci_ops exynos_pci_ops = {
 static bool exynos_pcie_link_up(struct dw_pcie *pci)
 {
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
-	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_RDLH_LINKUP);
+	u32 val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_ELBI_RDLH_LINKUP);
 
-	return val & PCIE_ELBI_XMLH_LINKUP;
+	return val & EXYNOS_PCIE_ELBI_XMLH_LINKUP;
 }
 
 static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
-- 
2.49.0


