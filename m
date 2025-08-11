Return-Path: <linux-pci+bounces-33690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 099D5B1FEB4
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 07:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3911118993C8
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 05:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F9E26B098;
	Mon, 11 Aug 2025 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b9iGjgcf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b6TAgw11"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390621DF98F;
	Mon, 11 Aug 2025 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890794; cv=none; b=LaZgVpVqd745mKJnn+APL9WcFGLYs3to+sO6iF2+yc5L+kK4bW0sIN9eKxiKaSdWWjZa075egOeGeP9Ebfx/Km6Yn/JH/6uzf/ssjcaBrK1xhycgmYAv8vfVeklMM5lYM9wYQDkdAdsZLJYS6A3o6VJV4fWVGM9vL8LQA+/xQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890794; c=relaxed/simple;
	bh=pnbyQwhaH5zwVvUKdyPprRrHHy4L1oKq2FZOE5FNDD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QXd0nB4bc4d6/cnSXyyxOAZZ4K+/1xaRoxLCqu01wVkSsRj2AaRHtNRwEeBORiBJLIe2A50gFPCu3YTbu14AEvqzaggL8fmw9iTBCJSCc3UfhgzctKfUq5Ch/IXDUxPjjAkVSykCYBWmG3UT/ad4znj6MS01ZlaonegqbgG7+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b9iGjgcf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b6TAgw11; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754890784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MJIhtkGvgAsmM0h4kM8I7PSa6klKjzmZORs6f49BmYA=;
	b=b9iGjgcfDGPemL2W21lMxlQ0pwOKRMzP6HOZtjtKaJGuj1P+bAZPwqaD8JLrFLcRGfqvE8
	QbBSWyeSTCO2dRw1E69MPv1amJ4gBapfzM+jXDNemNsiVvgpFVNxJS+6M44HwE92JTR7D5
	9MKdCgr73WGlqFeLXIYKQgRNqcee/EeWPiljIEaDfFi/IeZBq0rO4FVxgCKXw105z5d7xG
	7BJmeoMCZlc66ZtB5hXtM3ngtdsA0+jwr7Cq70cJBxsQP2660h6zSCfbOt7HKcK34qWuk3
	gcLsAIuO0hjzxQdsJUbRh/JDAmePvVN8z9C+KaRGAP2Xk+V2IXkTl4z1KWTbwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754890784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MJIhtkGvgAsmM0h4kM8I7PSa6klKjzmZORs6f49BmYA=;
	b=b6TAgw11vXrgWxBP584McGUlXhGR77xJbrjdfKRvFu/GWNKM7Ovmgh3pkvLZ3m0UHcSt7R
	jFkNqkyBjETbAaDA==
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH] PCI: vmd: Remove MSI-X check on child devices
Date: Mon, 11 Aug 2025 07:39:35 +0200
Message-Id: <20250811053935.4049211-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
added a WARN_ON sanity check that child devices support MSI-X, because VMD
document says [1]:

    "Intel VMD only supports MSIx Interrupts from child devices and
    therefore the BIOS must enable PCIe Hot Plug and MSIx interrups [sic]."

However, on Ammar's machine, a PCIe port below VMD does not support MSI-X,
triggering this WARN_ON.

This inconsistency between the document and reality should be investigated
further. For now, remove the MSI-X check.

Allowing child devices without MSI-X despite what the document says does
sound suspicious, but that's what the driver had been doing before the
WARN_ON is added.

Fixes: d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
Link: https://cdrdv2-public.intel.com/776857/VMD_White_Paper.pdf [1]
Reported-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Closes: https://lore.kernel.org/linux-pci/aJXYhfc%2F6DfcqfqF@linux.gnuweeb.=
org/
Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/pci/controller/vmd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index b679c7f28f51..1bd5bf4a6097 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -306,9 +306,6 @@ static bool vmd_init_dev_msi_info(struct device *dev, s=
truct irq_domain *domain,
 				  struct irq_domain *real_parent,
 				  struct msi_domain_info *info)
 {
-	if (WARN_ON_ONCE(info->bus_token !=3D DOMAIN_BUS_PCI_DEVICE_MSIX))
-		return false;
-
 	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
 		return false;
=20
--=20
2.39.5


