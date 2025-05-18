Return-Path: <linux-pci+bounces-27928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDBBABB9AF
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD9A171E83
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA9C2701DF;
	Mon, 19 May 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AcAPtkbV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7C3270576
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646979; cv=none; b=KiVPWKJC1grccIGwLQASkn4bNdZn5Zn33891rGfWmjUsAOmCZND1Zv8hnk79m+JkK2NJ26QC5TmB4a1F5WKg5xxmQfw3loqAGspENyfrVtx+owq9m4wlmmEm/Vq2GjJztQ80Qw8vlPdll8dGw3Mzt+Fn21eneTaf6txTTBeT3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646979; c=relaxed/simple;
	bh=z56woakeQWmEguUN8M9JLPjizkUMjCSa+ygM7ouEQcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=sn7O1Un9cTA/jDrCdBUUpu4Y44LVkLfrMPRZ0WhFi1ZasNT3SlmOurD5JMzNJhz8oCQ6DEFUfnNn2D6ESDJpP32zjLYQYG4LISgpHF4TtOhqvOjxtI8ecw1nbiLBXTc0LsDEJUpfQGyq+BsnMcOszhynTQ00yHRK2M0zN7/KvVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AcAPtkbV; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250519092935epoutp01382b42eec547f744aa64119d7669a970~A46oj1HPN2778827788epoutp01X
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250519092935epoutp01382b42eec547f744aa64119d7669a970~A46oj1HPN2778827788epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747646975;
	bh=l0gwyC5KI+Ug/i3m/cr/xGdP9J34hXTp0M7gsxc71JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AcAPtkbVqi7jW/uiBCmnf0zRY4qOnaJ0qOdbeFadctiawjNs8GcW/ukuw9jshS/h/
	 5aIHg2n8CQyaIwyUd8vAzk4oAvz7Qzt9b79ggomhkWLaJcC7A2rso/ZmYIPVenGeIt
	 bIGzzXFFrV5XRGDqATpchhB+Jrp81WSXoRGFqvTU=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250519092934epcas5p341c3cb1babdd45de3c1a3699bae31c20~A46oEMhQl0672806728epcas5p3E;
	Mon, 19 May 2025 09:29:34 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.183]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b1C7d38GGz6B9mL; Mon, 19 May
	2025 09:29:33 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250518193235epcas5p4f0bcf581b583a3acf493a20191ad2b00~Atf1u8wx31869918699epcas5p45;
	Sun, 18 May 2025 19:32:35 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250518193235epsmtrp196053957f0114c70e0099601128bb08b~Atf1t79n72445124451epsmtrp1c;
	Sun, 18 May 2025 19:32:35 +0000 (GMT)
X-AuditID: b6c32a52-40bff70000004c16-67-682a35d3922b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	6F.39.19478.3D53A286; Mon, 19 May 2025 04:32:35 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250518193232epsmtip16453319fe08b323256750a6a7cafd674~Atfy3TlTS1247812478epsmtip1D;
	Sun, 18 May 2025 19:32:32 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, Shradha Todi
	<shradha.t@samsung.com>, Hrishikesh Dileep <hrishikesh.d@samsung.com>
Subject: [PATCH 03/10] PCI: exynos: Reorder MACROs to maintain consistency
Date: Mon, 19 May 2025 01:01:45 +0530
Message-ID: <20250518193152.63476-4-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518193152.63476-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSnO5lU60Mg59zJS0ezNvGZvF30jF2
	iyVNGRZr9p5jsph/5Byrxc2zu9ktbvxqY7VY8WUmu8XR1v/MFi9n3WOzaOj5zWqx6fE1VovL
	u+awWZydd5zNYsKqbywWZ78vYLJo+dPCYrH2yF12i7stnawW//fsYLfoPVxrsfPOCWYHMY/f
	vyYxeuycdZfdY8GmUo9NqzrZPO5c28Pm8eTKdCaPzUvqPfq2rGL0OPJ1OovH501yAVxRXDYp
	qTmZZalF+nYJXBl3PixnLPjJW3FrwVr2BsYv3F2MHBwSAiYS7x7XdTFycQgJbGeU2P9oHXMX
	IydQXFLi88V1TBC2sMTKf8/ZIYo+MUr8m9HIDpJgE9CSaPzaBdYgInCCUaLvliVIEbPAfGaJ
	huZvYN3CAl4Se97tBGtgEVCV6Ptxhg3E5hWwkmh/sZ0d4gp5if4OCZAwp4C1xLb1U8FahYBK
	Fj7ZyQhRLihxcuYTFhCbGai8eets5gmMArOQpGYhSS1gZFrFKJpaUJybnptcYKhXnJhbXJqX
	rpecn7uJERyNWkE7GJet/6t3iJGJg/EQowQHs5II76rNGhlCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTBNZ9h9Nbb5wzGNKe8fJe3r+6kkPjbz39lxv
	1jXK/Ffj81xExcM3Vfdw4ALW6XNnxH5/+3Frl8XReV5z1ja2rlgfs7j7QVhSkDK75s1VU8Oc
	TRjW+8Uxyb0S6BU9sMVp37YJr9R28G2SmHRpWU3JnNXv7W2O3lm90D7CqS4vNdchMSCwo7Ut
	9aTGFF5Wrp6QPP05aa+y9DoTnznmvb9x/s66vXOa8kUOKny3dDxUvq84ffUf3uVeXjYOJhzr
	N7mUdSy9XXpg0vZ1G26cUP9ickhj8nm2ZdNffujdGNG5qOdo1ymhbL8P5uWtmR6+DtrM5elm
	7GJT/u/tWumnyWMS8f6YAJPaBM9FgmsMzc/vVGIpzkg01GIuKk4EAOeqv5I1AwAA
X-CMS-MailID: 20250518193235epcas5p4f0bcf581b583a3acf493a20191ad2b00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193235epcas5p4f0bcf581b583a3acf493a20191ad2b00
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193235epcas5p4f0bcf581b583a3acf493a20191ad2b00@epcas5p4.samsung.com>

Exynos PCI file follows MACRO definition order where
register offset is defined in ascending order and each
bit field within the offset is defined right after offset
definition. Some MACROs are out of order and so reorder
those MACROs to maintain consistency.

Suggested-by: Hrishikesh Dileep <hrishikesh.d@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 990aaa16b132..286f4987d56f 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -27,11 +27,11 @@
 
 /* PCIe ELBI registers */
 #define EXYNOS_PCIE_IRQ_PULSE			0x000
+#define EXYNOS_PCIE_IRQ_EN_PULSE		0x00c
 #define EXYNOS_IRQ_INTA_ASSERT			BIT(0)
 #define EXYNOS_IRQ_INTB_ASSERT			BIT(2)
 #define EXYNOS_IRQ_INTC_ASSERT			BIT(4)
 #define EXYNOS_IRQ_INTD_ASSERT			BIT(6)
-#define EXYNOS_PCIE_IRQ_EN_PULSE		0x00c
 #define EXYNOS_PCIE_IRQ_EN_LEVEL		0x010
 #define EXYNOS_PCIE_IRQ_EN_SPECIAL		0x014
 #define EXYNOS_PCIE_SW_WAKE			0x018
@@ -42,12 +42,12 @@
 #define EXYNOS_PCIE_NONSTICKY_RESET		0x024
 #define EXYNOS_PCIE_APP_INIT_RESET		0x028
 #define EXYNOS_PCIE_APP_LTSSM_ENABLE		0x02c
+#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
 #define EXYNOS_PCIE_ELBI_RDLH_LINKUP		0x074
 #define EXYNOS_PCIE_ELBI_XMLH_LINKUP		BIT(4)
-#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
 #define EXYNOS_PCIE_ELBI_SLV_AWMISC		0x11c
 #define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
-#define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
+#define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE		BIT(21)
 
 struct exynos_pcie {
 	struct dw_pcie			pci;
-- 
2.49.0


