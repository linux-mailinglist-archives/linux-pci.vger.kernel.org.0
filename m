Return-Path: <linux-pci+bounces-33821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59A6B21C76
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879FE3B2C61
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD1247299;
	Tue, 12 Aug 2025 05:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UNYFGLHS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A4C13B
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974928; cv=none; b=l7h/2iHy6BGayjZzx8DvWqGEEgK5M3gl0kWVttmG5g2F9X63BJaT9c9SbO3uSgT079XQibRf1THoPWsVYYIh5wrwGzVqhy5Vl5o4npwELEe7+lWMUAEJSgcGSN2xpztPQEuSOu3KkXEof8SiJNRd+CZO+hGS4enCtnChQozcTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974928; c=relaxed/simple;
	bh=wjjg7SJLEPBbQK2Tv7ARwQeoj+DFGdvzSzjAKKngXOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JcesKdXYdSl01k1FK0gDnv/tnbqo+bYOrPUXr/1Kp7GXbVVmBLk6U4f9I3vsCWTzSWPeSm7cI/TPUmjfVN733F/wXj7m8rXN8tzj5ATXFB85pfw86WjqDu7TT39PcRL4wDwyeWrm8ZgPjJurKH1OOoZMilHd0amNdaHNib/6Bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UNYFGLHS; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250812050203epoutp012c300c469eaef09422e6416591f224fd~a7GUNmqw71032210322epoutp01v
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250812050203epoutp012c300c469eaef09422e6416591f224fd~a7GUNmqw71032210322epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754974923;
	bh=2IA86F4zckPMij9e7yGYro0kXu5bh8Py7lV8n/0sesc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNYFGLHSBeDvYC1mRmZqxpKZrLEDeqMMD2zqXQqSTdgS6alssz6eAyb7tJxgh/hkM
	 bd/vYlTl5Wwx93crmmvfrAK4JAjJuhTgeK3NYgQOhRGq+RSiFIuhQWobJ3FuYgXZxF
	 d1qp3Ee0TRl25xSYTCT2hrmxvVwL0G/M5bvchOa8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250812050202epcas5p31f271fb43f33f8ab6f0f022b0231d2eb~a7GTkYNaO3131631316epcas5p3r;
	Tue, 12 Aug 2025 05:02:02 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.95]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4c1K9j5t1yz6B9mF; Tue, 12 Aug
	2025 05:02:01 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250811154655epcas5p211bd14152fa48635fc5c1daceb963e71~awQERWW4V0377703777epcas5p2f;
	Mon, 11 Aug 2025 15:46:55 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154652epsmtip112e87d107f6556973ea2463d4c2cb28a~awQBic9oH2101521015epsmtip1C;
	Mon, 11 Aug 2025 15:46:52 +0000 (GMT)
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
Subject: [PATCH v3 01/12] PCI: exynos: Remove unused MACROs in exynos PCIe
 file
Date: Mon, 11 Aug 2025 21:16:27 +0530
Message-ID: <20250811154638.95732-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811154638.95732-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250811154655epcas5p211bd14152fa48635fc5c1daceb963e71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154655epcas5p211bd14152fa48635fc5c1daceb963e71
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154655epcas5p211bd14152fa48635fc5c1daceb963e71@epcas5p2.samsung.com>

Some MACROs are defined in the exynos PCIe file but are
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


