Return-Path: <linux-pci+bounces-33824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AE9B21C84
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0DC620555
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACB62E2DD4;
	Tue, 12 Aug 2025 05:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ewzRzfjd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F52DE709
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974934; cv=none; b=QnuwSa47FRG9c/z9m6FGYEgyaQxSkM+uR40cniD3ixGj85L7AsHKs3tMd8HWTuB06AP3XUY4zOlbmjEv8rEF29EKaQronahuAMCoHSPOgmLw4B97JlIRITBxufnS18zFYZLoHFoLborhvtXNL5nhQzzv82lMBYx03gRLP0mX7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974934; c=relaxed/simple;
	bh=yWtCCxpMNPD3uS3Bi7H/Hp18Cho/E9Z77Yln+Cm21OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=SV3YpD2FjzWT9lYUlXx7gsDAT9pyYFijubiZgdeNt5rPSN56ZDzrpyKoM8uTBR0d4XWO9e7tRUSFqZqdJ8J8/OHtMigtATESL8RBfmiSQPbEYmVT8einl+6qM5rYUmM9RAwbcRE468G+lxBXpVSBpT7gJrVW+nHvWIjDgn/+4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ewzRzfjd; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250812050210epoutp028de9d76056390ffdf429dde2cd0114ee~a7Gaofcay1104611046epoutp02Z
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250812050210epoutp028de9d76056390ffdf429dde2cd0114ee~a7Gaofcay1104611046epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754974930;
	bh=9jzUBK4rfaWiMXa828Ff+bfipS/KVj9eyi+oP2TMhHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewzRzfjdD+rGZQUrb53CHsSWxmdMv4pv2LzRl54Dn7cmG9h5VafW9DawSKw/+6ihf
	 Q+3mkxtgza6Y2a/Une+vi+uHGsvYlyfZqei9XRri/R9c7KORlHsMZyhT+o6OlyPIq0
	 f+Rau/ceCdxg4O031Yxte+i1IqKSHS2CM8hJBkxc=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250812050209epcas5p3a662df55d72938c3f5a0dec5e6319438~a7GZo9hgF3131631316epcas5p3A;
	Tue, 12 Aug 2025 05:02:09 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c1K9r2vyKz2SSKk; Tue, 12 Aug
	2025 05:02:08 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250811154707epcas5p20e96a10de3fffcaaf95861358811446c~awQPcuMVZ3176231762epcas5p2H;
	Mon, 11 Aug 2025 15:47:07 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154704epsmtip162c8233ab8832adbf5a91ec5952181e5~awQMuN8Ho2450424504epsmtip1J;
	Mon, 11 Aug 2025 15:47:04 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>, Hrishikesh Dileep
	<hrishikesh.d@samsung.com>
Subject: [PATCH v3 03/12] PCI: exynos: Reorder MACROs to maintain
 consistency
Date: Mon, 11 Aug 2025 21:16:29 +0530
Message-ID: <20250811154638.95732-4-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811154638.95732-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250811154707epcas5p20e96a10de3fffcaaf95861358811446c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154707epcas5p20e96a10de3fffcaaf95861358811446c
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154707epcas5p20e96a10de3fffcaaf95861358811446c@epcas5p2.samsung.com>

Exynos PCI file follows MACRO definition order where
register offset is defined in ascending order and each
bit field within the offset is defined right after offset
definition. Some MACROs are out of order and so reorder
those MACROs to maintain consistency.

Suggested-by: Hrishikesh Dileep <hrishikesh.d@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 30d12ff9b0c6..b4ec167b0583 100644
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
@@ -42,9 +42,9 @@
 #define EXYNOS_PCIE_NONSTICKY_RESET		0x024
 #define EXYNOS_PCIE_APP_INIT_RESET		0x028
 #define EXYNOS_PCIE_APP_LTSSM_ENABLE		0x02c
+#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
 #define EXYNOS_PCIE_ELBI_RDLH_LINKUP		0x074
 #define EXYNOS_PCIE_ELBI_XMLH_LINKUP		BIT(4)
-#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
 #define EXYNOS_PCIE_ELBI_SLV_AWMISC		0x11c
 #define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
 #define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE		BIT(21)
-- 
2.49.0


