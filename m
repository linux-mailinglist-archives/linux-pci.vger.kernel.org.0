Return-Path: <linux-pci+bounces-42220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D68C8F9C5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 18:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0965F349DD0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B552DF13E;
	Thu, 27 Nov 2025 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="naXGPXJT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3652DECDF;
	Thu, 27 Nov 2025 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764263444; cv=none; b=DhCqJn5A8P1XLTttSHz93i2rHhprXq8x/+Hv7tAlDn16G7aiffigELi9v0U9wLWaLAYjwSUMNsCrK3jtxrNCso6u4rF5cmGE50ssxacapPNOIan621Vv7Avy4+YwJ57vkZLXf3jCoXU6Y4+1WKGrLvu8jOOm2IuybQTnfb1/32U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764263444; c=relaxed/simple;
	bh=xY9EeZNG6327M7qafePF+MG8xDd3VZN9/Xn/tPbQxWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5G9DXuPjAR1szJ436H5uy7WBRm5hf3P+qOj06Pgm163G464EIH4CChKtadvwIFLpJBdj4oWv9N7sqkYB8OW8ALouYBk+nqmKT0cJP9FYW/OFBAKDUxR5azQMtIsLNxHC6vyUWOtAONd/AZthUkAi6hDZGmlGqIJgEDG04uvIOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=naXGPXJT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HV
	6aCZe858sfDxOrV63v3V1QYYmt0i4YMWexhlJ+tbA=; b=naXGPXJTlIK1unETm8
	75auW4gIbvDvDlitwThqx4P2ocxvvockkkT5bjipCrPuGjTEYpbwFqvrOWdvsqMR
	0QfNAC5HHfX0HfqXbMBuY8PGxYkGszrk7tQEVF+6KwshWG8XjWUpU7iLHiW70Mw8
	lffFtoGlbzjxW66amaFgr3Wgs=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDX71K2hShpkFjfDA--.43603S4;
	Fri, 28 Nov 2025 01:09:14 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	heiko@sntech.de,
	mani@kernel.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v7 2/2] PCI: dwc: Remove redundant MPS configuration
Date: Fri, 28 Nov 2025 01:09:08 +0800
Message-Id: <20251127170908.14850-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251127170908.14850-1-18255117159@163.com>
References: <20251127170908.14850-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX71K2hShpkFjfDA--.43603S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4xuw4xXFWDJw43WF4xtFb_yoW8Cr1fpF
	y3WrsakF18Ar45WF4qkan5Cay3tasxCry7JF9Ig34fZFyayFsrJa4ayFWFka4xWrW293WS
	kr98K3y8A3W5trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE1vVXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBrzl2kohboRnwAA3K

The Meson PCIe controller driver manually configures maximum payload
size (MPS) through meson_set_max_payload, duplicating functionality now
centralized in the PCI core.  Deprecating redundant code simplifies the
driver and aligns it with the consolidated MPS management strategy,
improving long-term maintainability.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 787469d1b396..3d12e1a9bb0c 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -261,22 +261,6 @@ static int meson_size_to_payload(struct meson_pcie *mp, int size)
 	return fls(size) - 8;
 }
 
-static void meson_set_max_payload(struct meson_pcie *mp, int size)
-{
-	struct dw_pcie *pci = &mp->pci;
-	u32 val;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	int max_payload_size = meson_size_to_payload(mp, size);
-
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
-
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
-}
-
 static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
 {
 	struct dw_pcie *pci = &mp->pci;
@@ -381,7 +365,6 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
 
 	pp->bridge->ops = &meson_pci_ops;
 
-	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);
 	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
 
 	return 0;
-- 
2.34.1


