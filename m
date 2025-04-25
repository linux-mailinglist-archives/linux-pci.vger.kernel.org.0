Return-Path: <linux-pci+bounces-26731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FFBA9C47E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 11:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B7C1BA2542
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 09:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEDC238176;
	Fri, 25 Apr 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BQHi4oT8"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022CB2367A7;
	Fri, 25 Apr 2025 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575098; cv=none; b=XP72e/H7INma8P6YR+KVwbV+lhr6HkHvh1HMCFpDRMkU3Ejr1tT+C/LO8dtiDMI7I+V6K3iH5/rAxck2NYeu34E4/Elz3jAGHAevbl81PO8b3S/KSvW79c9uU71Q8zPMOWX4TBZSAcAy4P7NIZh4LUphd+es5qkGCw8k1Uw02BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575098; c=relaxed/simple;
	bh=OhLGSBuQVLXaIk4wy2LU6O6nHuMtPkRCcZXq8EDJPHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tOvho+z4/p4DZbnDXUCbVy8YCJZhoqtmyJCSdLnOmqFDMErGXWrpkFKGPziDcGIexEkF6RHbkG+4+lqSv8qeKOZAShphW9vkmNa5Rr2U2lAKrRBY3R1x407QQYxn/ilJ+0P5Vrhomw58iXnKAgGmiBKxf0AjDhK0hPZRhZGXYBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BQHi4oT8; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9P6dx
	24LcPTLqnmztGQ81vANm+nUct9U80WqazHI54k=; b=BQHi4oT8vGRbvvroE56N0
	AyIgktZ1DIttAFQxJtXGIVB8Trkxgsa6kh6Wa8DIwPPKu0xxZt1HE5lCJrL0hYMv
	IngkQlKeaVuS67pE9u3zJJKIKQCD48Ne1OIhtZfTkTBscBgKlUcvVy8ejuSQ0U0f
	VZI0sp+ruS5VmlAlC+r/rw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnfJt2XAtowU4iAw--.17018S4;
	Fri, 25 Apr 2025 17:57:16 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	thomas.petazzoni@bootlin.com,
	manivannan.sadhasivam@linaro.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 2/2] PCI: Remove redundant MPS configuration
Date: Fri, 25 Apr 2025 17:57:08 +0800
Message-Id: <20250425095708.32662-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250425095708.32662-1-18255117159@163.com>
References: <20250425095708.32662-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnfJt2XAtowU4iAw--.17018S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWUWr43Zry8Gr13Kr1DGFg_yoW5Ww17pF
	W3XrsayF4rtr45ua1DAa1rCFW3JasIkry7J39xW34fZF9IyFW7JFyayFWSka4fJr40gF10
	yF15t3y8A3W5trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_EfYiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDw06o2gLWGyMnQAAsd

With the PCI core now centrally configuring root port MPS to
hardware-supported maximums (via 128 << pcie_mpss) during host probing,
platform-specific MPS adjustments are redundant. This patch removes the
custom the configuration of the max payload logic to align with the
standardized initialization flow.

By eliminating redundant code, this change prevents conflicts with global
PCIe hierarchy tuning policies and reduces maintenance overhead. The Meson
driver now fully relies on the core PCI framework for MPS configuration,
ensuring consistency across the PCIe topology while preserving
hardware-specific MRRS handling.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
 drivers/pci/controller/pci-aardvark.c  |  2 --
 2 files changed, 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index db9482a113e9..126f38ed453d 100644
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
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index a29796cce420..d8852892994a 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
 	reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
 	reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
-	reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
 	reg &= ~PCI_EXP_DEVCTL_READRQ;
-	reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
 	reg |= PCI_EXP_DEVCTL_READRQ_512B;
 	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
 
-- 
2.25.1


