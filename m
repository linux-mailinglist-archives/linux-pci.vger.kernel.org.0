Return-Path: <linux-pci+bounces-30671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC21AE941C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 04:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038723BA80C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 02:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E871D5CD7;
	Thu, 26 Jun 2025 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T/Suh72r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E584918C332
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905434; cv=none; b=VrVvC75OXNaOrzgSLHkrradfnnHRymmtMF9J1De2INu2L07R5K/tHrI2xZJ2D/a2cSKWM1hyHFpYRYLRgpDimJ4jWa/1iguZSXcKTj8lRUju8ryGfJEoFwDDqwjpMK3CZa33Y3qt0nK7Wu75Fekr0eGTlgGH23RLsKuM/4Km2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905434; c=relaxed/simple;
	bh=z2sOcS2GEXQg3M6WCfaMtB/l8eYFe3q4w1BRHq+Az2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bucDUC1QwGR65PcK14N+96GTrGkCdH6L4XE6X9mYfHjDDAUYyS6pX+GuSuhMzSUnnMWVojsVnz9xWzDDzXREB8/HESzHv1g0Gez6ZexzCUU3Gos6/4EAti0HiFUx5WS3k9Vf4M95DFngDUT8mRxP9GdibwZJ3/MBc5TfDh3ue1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=T/Suh72r; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250626023711epoutp03d02feca73a0f34a346634d4ff85aadf0~MdzaMQevE1784617846epoutp038
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:37:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250626023711epoutp03d02feca73a0f34a346634d4ff85aadf0~MdzaMQevE1784617846epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750905431;
	bh=3KKeY/NRtUPjv7gxdOOKLkL/mtVywZDtNKn8DXvJJT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/Suh72rNRMdN/m7/Trdq4p0hqwoQegpnlJVMlU9P3w6ocmuPbi2ts9YCZLcPw1tg
	 6t/biCSwhfmgm1+B4fxeZljwctkaEL7DDDrO03J6fIsrv1dhHawWqAJMkBpQdyFGfA
	 TtHuozUenW56VIXojOSU3u9MY40V0+pxhHY9Oihk=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250626023710epcas5p39d882046df964a98f0d8b617fd5ee19b~MdzZVCw8l0375103751epcas5p3P;
	Thu, 26 Jun 2025 02:37:10 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.174]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bSNBD4NG5z2SSKp; Thu, 26 Jun
	2025 02:37:08 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250625165248epcas5p10eefe9e1f1a89806793c86decc63f232~MV1LrOioV0885408854epcas5p1q;
	Wed, 25 Jun 2025 16:52:48 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250625165245epsmtip2600318736a6844f4c5dc7f7cecffc09a~MV1I11UW71750817508epsmtip2G;
	Wed, 25 Jun 2025 16:52:45 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-fsd@tesla.com
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>, Hrishikesh Dileep
	<hrishikesh.d@samsung.com>
Subject: [PATCH v2 01/10] PCI: exynos: Remove unused MACROs in exynos PCI
 file
Date: Wed, 25 Jun 2025 22:22:20 +0530
Message-ID: <20250625165229.3458-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625165229.3458-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250625165248epcas5p10eefe9e1f1a89806793c86decc63f232
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250625165248epcas5p10eefe9e1f1a89806793c86decc63f232
References: <20250625165229.3458-1-shradha.t@samsung.com>
	<CGME20250625165248epcas5p10eefe9e1f1a89806793c86decc63f232@epcas5p1.samsung.com>

Some MACROs are defined in the exynos PCI file but are
not used anywhere within the file. Remove such unused
MACROs.

Suggested-by: Hrishikesh Dileep <hrishikesh.d@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 1f0e98d07109..f9140d1f1d19 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -31,8 +31,6 @@
 #define IRQ_INTB_ASSERT			BIT(2)
 #define IRQ_INTC_ASSERT			BIT(4)
 #define IRQ_INTD_ASSERT			BIT(6)
-#define PCIE_IRQ_LEVEL			0x004
-#define PCIE_IRQ_SPECIAL		0x008
 #define PCIE_IRQ_EN_PULSE		0x00c
 #define PCIE_IRQ_EN_LEVEL		0x010
 #define PCIE_IRQ_EN_SPECIAL		0x014
-- 
2.49.0


