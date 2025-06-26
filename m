Return-Path: <linux-pci+bounces-30790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4B3AEA1F6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9724C4E7625
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603B22FEE39;
	Thu, 26 Jun 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OkWGD2FD"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7FC2FE393;
	Thu, 26 Jun 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949554; cv=none; b=M5EPaAOdCRs5BJzNB60TDknCRoyYDkahDZfJnR58eIJKoXXrbWDMCNMlhPNjANZ8f8Ww6nOFlE/Vx5+GyLQJBQDnWcKsAEOHAfrHxJ/p3voDMHq7uVenJ7u065XduA81U6VCaStBa8Kfxx9QyA177MD/tHUFeUNpKthWnzOK7EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949554; c=relaxed/simple;
	bh=nE6bKO5dP5cXC6LWtFFk7yFnzldnKqo5QJozk1Lv45Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2B0fD4J+qTOpaAthdCfN4PbiN5TEolN1hMDaXqitKrqEILZtZqJxQCnLiT7zM5E1l4ilB2MPyZ/qi7VWk/cOKLAgVclZQaFgzYiITv1OzmBGd0NxR6ePUT/Fs/3ZNkwJyOB2dRm4STYahsFQg2Nuxd+hNYKwlx5ZjMacnZjI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OkWGD2FD; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ae
	9kCteaIREimUk/syr6kEJ201xf2z63OTJWk7zi+T4=; b=OkWGD2FDLhSx0NwLKw
	5oqE27dvvnEXS8MPd/eJIAKKceRgGod7ouw2BHvdCJmh8wFp/npuOZOJxlslYKNC
	kD0zkFhwmioVj/Ho4+ftUBDDNDFg5ck4bGynb/O2aRIrg10lnJaHywBqei+MdxZ+
	LlibFdyX5VFqY/KnhEO13nEEE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnboqkXl1oRfOTAA--.15779S4;
	Thu, 26 Jun 2025 22:52:21 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 12/13] PCI: rcar-gen4: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Thu, 26 Jun 2025 22:50:39 +0800
Message-Id: <20250626145040.14180-13-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250626145040.14180-1-18255117159@163.com>
References: <20250626145040.14180-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnboqkXl1oRfOTAA--.15779S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFy3GF4Dtw48tF4DXr17GFg_yoW5Cry5pa
	y7CFySkF1jyws09F4UXaykur15uan3Ca1jg3Z7Gw1I9ay7ArZxWay0y3y7tFWxGFZ2qr45
	Cw1UtFWUWF15ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_F4ifUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxR4o2hdWY1zdQAAsz

R-Car Gen4 PCIe driver contains multiple read-modify-write sequences for
speed change control and lane configuration. The driver manually handles
speed change initiation through bit set/clear operations and configures
lane skew with explicit bit masking.

Refactor speed change handling and lane skew configuration using
dw_pcie_clear_and_set_dword(). For speed change operations, replace
manual bit toggling with clear-and-set sequences. For lane skew, use
the helper to conditionally set bits based on lane count.

Adopting the standard interface simplifies link training logic and
reduces code complexity. The change also ensures consistent handling
of control register bits and provides better documentation of intent
through declarative bit masks.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 23 ++++++++-------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 18055807a4f5..20a6c88252d6 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -107,13 +107,11 @@ static int rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
 	u32 val;
 	int i;
 
-	val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &= ~PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_clear_and_set_dword(dw, PCIE_LINK_WIDTH_SPEED_CONTROL,
+				    PORT_LOGIC_SPEED_CHANGE, 0);
 
-	val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_clear_and_set_dword(dw, PCIE_LINK_WIDTH_SPEED_CONTROL,
+				    0, PORT_LOGIC_SPEED_CHANGE);
 
 	for (i = 0; i < RCAR_NUM_SPEED_CHANGE_RETRIES; i++) {
 		val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
@@ -565,11 +563,9 @@ static void rcar_gen4_pcie_additional_common_init(struct rcar_gen4_pcie *rcar)
 	struct dw_pcie *dw = &rcar->dw;
 	u32 val;
 
-	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
-	val &= ~PORT_LANE_SKEW_INSERT_MASK;
-	if (dw->num_lanes < 4)
-		val |= BIT(6);
-	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
+	dw_pcie_clear_and_set_dword(dw, PCIE_PORT_LANE_SKEW,
+				    PORT_LANE_SKEW_INSERT_MASK,
+				    (dw->num_lanes < 4) ? BIT(6) : 0);
 
 	val = readl(rcar->base + PCIEPWRMNGCTRL);
 	val |= APP_CLK_REQ_N | APP_CLK_PM_EN;
@@ -680,9 +676,8 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 		return 0;
 	}
 
-	val = dw_pcie_readl_dbi(dw, PCIE_PORT_FORCE);
-	val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
-	dw_pcie_writel_dbi(dw, PCIE_PORT_FORCE, val);
+	dw_pcie_clear_and_set_dword(dw, PCIE_PORT_FORCE,
+				    0, PORT_FORCE_DO_DESKEW_FOR_SRIS);
 
 	val = readl(rcar->base + PCIEMSR0);
 	val |= APP_SRIS_MODE;
-- 
2.25.1


