Return-Path: <linux-pci+bounces-27925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A373ABB9B4
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F551892E74
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A50F267387;
	Mon, 19 May 2025 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tt9sQGyN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25526FD9A
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646959; cv=none; b=gf1O+m0sHFCxTo4rW4e2baxA7verVoKd+1GBv/jVqi1U0izQShr9KsecU5FZtkTMUlMvpsVdBgjDg4Y8eHd8utT2ECRLGHgXTwILRiXUMhAPUZjhj4xBA+FnKjCGzgGoU7yFkMhm8gFcBFJS6lFZrNppH9/YxXGNB8i/VMSFTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646959; c=relaxed/simple;
	bh=7ABxo1o+iuz7KS3oeJ+a4ETKImt3JwKUnmUjJWWurCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kI2V4514gTOLKIuaQxeomR5t8NPZeYPylH/sY1hgla3+ytCxTPP1/pFLOZMoW1/omJW3ImNEcZiOCgn+ayT6k2kzAspekDZChdCUhd4V88LkvRB9DJHfrFDdQBilVuXmDXaCIQrFkFvD2RjI6BLHvlzXfsC1mkc1sD7ugbZ/pAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Tt9sQGyN; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250519092907epoutp02bb2be178b62c9dc36858effccd2cbdd0~A46O7j36f0909109091epoutp02Q
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250519092907epoutp02bb2be178b62c9dc36858effccd2cbdd0~A46O7j36f0909109091epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747646947;
	bh=U4vYel9SC3RXLTELAk4xNUjVAeemDzAM0ckAtX/d39U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tt9sQGyNAWanO5Ka6ujmUULn+ixy7PN+WB0jSOl+MSc0idGBZZqs/dpAJ3y1IYGjR
	 +hNIwKnFiISBtRw91ifeuBAYOrELfVBuD9L0vJgYweBL+Hav0yqB68bRv5NoP3IUSU
	 D5NNO18fvPtxEo9zYpUkoTH4qVdkoIMkayYFc2cE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250519092906epcas5p2b51cee8b512ed58c44cb88bb885bb095~A46NvruTe0614106141epcas5p22;
	Mon, 19 May 2025 09:29:06 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.176]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4b1C752B2vz2SSKp; Mon, 19 May
	2025 09:29:05 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250518193221epcas5p3c648c773d901f18639dd32fa452fd688~AtfoxwtPt1682016820epcas5p33;
	Sun, 18 May 2025 19:32:21 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250518193221epsmtrp249aa1fd57cdeba1334d43b2f0dd71757~Atfow8VJD0348003480epsmtrp2a;
	Sun, 18 May 2025 19:32:21 +0000 (GMT)
X-AuditID: b6c32a52-41dfa70000004c16-56-682a35c5e846
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.39.19478.5C53A286; Mon, 19 May 2025 04:32:21 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250518193218epsmtip14b990810bf80067490cc48b266f28a35~AtfmC8r6v0974409744epsmtip1e;
	Sun, 18 May 2025 19:32:18 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH 01/10] PCI: exynos: Change macro names to exynos specific
Date: Mon, 19 May 2025 01:01:43 +0530
Message-ID: <20250518193152.63476-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518193152.63476-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnO5RU60Mg3nT5S0ezNvGZvF30jF2
	iyVNGRZr9p5jsph/5ByrxY1fbawWK77MZLc42vqf2eLlrHtsFg09v1ktNj2+xmpxedccNouz
	846zWUxY9Y3F4uz3BUwWLX9aWCzWHrnLbnG3pZPV4v+eHewWvYdrLXbeOcHsIOrx+9ckRo+d
	s+6yeyzYVOqxaVUnm8eda3vYPJ5cmc7ksXlJvUffllWMHke+Tmfx+LxJLoArissmJTUnsyy1
	SN8ugSvj44tZTAVrbCt2HF3N1MA427SLkZNDQsBEYsvVFYxdjFwcQgLbGSWubnvFDpGQlPh8
	cR0ThC0ssfLfc3aIok+MEp9WrmMESbAJaEk0fu1iBrFFBE4wSvTdsgQpYhZ4zyQxc8EvsG5h
	AU+Jx03vwIpYBFQlFu+8BWbzClhJbNoxla2LkQNog7xEf4cESJhTwFpi2/qpYK1CQCULn+xk
	hCgXlDg58wkLiM0MVN68dTbzBEaBWUhSs5CkFjAyrWIUTS0ozk3PTS4w1CtOzC0uzUvXS87P
	3cQIjkKtoB2My9b/1TvEyMTBeIhRgoNZSYR31WaNDCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
	yjmdKUIC6YklqdmpqQWpRTBZJg5OqQamGO4Lr65c2XL3yc0Vm4PcGVI4fDf+7LqfseLv5VXi
	lU9UO6V/LHnAur/67lp3kejFuU/F9WsXsP9ayP+qVPLAJwc1AfV3Z5lfLRTYdrnR6YauzO2j
	NX9N16eWOppn/5lxr5JRYdJc47xP9zz95VX7NvOK7H6h+tnz4ukHSUF7sr4Kxiam258+tdT7
	8bKNxw7OKdbgzw+78aN3ybya+UE3qgXu2dwNmX37h3GQ62pN65tTpd8ZdL7XEPobvnly24vM
	2i/53OGWUubNSj9uh3EfepD2op470eGLR9aNg/53bnKwJTl3/Au8rTDPPaGdy+mK4fTCqz1M
	2V/UrNdON9ln1evzRDT97FJ+PY2vgtO2K7EUZyQaajEXFScCAL7XumkxAwAA
X-CMS-MailID: 20250518193221epcas5p3c648c773d901f18639dd32fa452fd688
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193221epcas5p3c648c773d901f18639dd32fa452fd688
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193221epcas5p3c648c773d901f18639dd32fa452fd688@epcas5p3.samsung.com>

Prefix macro names in exynos file with the term "EXYNOS" as the current
macro names seem to be generic to PCIe.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 116 ++++++++++++------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index ace736b025b1..1c70b036376d 100644
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
@@ -73,49 +73,49 @@ static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
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
@@ -123,21 +123,21 @@ static int exynos_pcie_start_link(struct dw_pcie *pci)
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
@@ -150,12 +150,12 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 
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
@@ -212,9 +212,9 @@ static struct pci_ops exynos_pci_ops = {
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
2.49.0


