Return-Path: <linux-pci+bounces-36684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE17BB91DA6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C917A2DC6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B9C2DE1FE;
	Mon, 22 Sep 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q0eZveY3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I1uIievU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838624DCE2;
	Mon, 22 Sep 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553732; cv=none; b=Ma7s/6EBUSgrGV7zGLjQFf5NFjWnRDKnT1oTrLg0VEWhoEBFTW/EyZgbLh2X8p8lTtqFBtNBAd7DNFO3Qhg8BTfFBgsFhppxm3DGOZD2YACguf37nHjEmlcnPeHJ1Ku5a9cEvlknvJH/7HhrY1J96YGocK3nEc5pAt0g3HsLeuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553732; c=relaxed/simple;
	bh=Zbs78Nc1dg8s/oapblfN+yFQqJ1eep5DVjpPreRzEY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WuRoM7BGF7CNi8rk53rAkBXu4UtSP4Lz+xuA2xgwRiKBFZkfnRJ3oMwJi8BXre6c4wsiei4oAUF0FJcMMLPeZTRhUCtSbL4Y7QlJGfgEr4VqdhJucnUUAMhJVX/QPU/EYUOgXG14uFBDf13KdUi0JzydKqADqw7icrkfqcjLAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=q0eZveY3; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=I1uIievU; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cVmhp1t38z9tfK;
	Mon, 22 Sep 2025 17:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758553722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ZMASazH2tqE9wH24FtNKE/H5QmQBrIjyM7uFPibD+k=;
	b=q0eZveY3sj2xA1anv2vds2ex+MgpP2WyGgrGyqlHLbeqF6p/NiPwGP8PgFctEyZhNB96a9
	LfpGD25L2XBxusql168syZPtIjoMPIXWNKTeS4GxyefPyTa5qdl1AA3eGQKnMvbCPxmMVF
	aL54RecCJiawIHTsiIK6dVUykJ6RJHMFZHvMVFNs9vGyEiAL6zQhUK2gLy3vV4y6HVuH9U
	MpDd5yxUo3Nu/ze/o/gV/KPbc6AO+y1ZoVXxsYp3n5pYNGqw9+nKPCYg5V+D3YHpZ2bTHF
	LknDQp7JOwg/dX3VzsVcIzghrS6lIIqQabftaUs3NfM4JAXOk0pknxuqOPyX/Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=I1uIievU;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758553719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ZMASazH2tqE9wH24FtNKE/H5QmQBrIjyM7uFPibD+k=;
	b=I1uIievUjGylN+Zyk+3v84KBYNIbG+ktUB11DnxOBuxk5AOxv5v4xEkp7cAwRSpzYQBqMr
	hATfRqE1rjp5GLR7Nq9+uwzB3CG6ssZb5ZF6QzRixMri6mZ4OlyL1qLdTH3NUoLWnNCg1E
	KKbN5A2PQtfy8QPaIR/MKiPv0M079KtMhzEAnz58PVdB3d9GzIqlH9/SC/3axiq9OaYDJv
	nTMCxoS+U7crQ26bkShW3R4aO5fZUEeNXN4DmnxjB7UI6EMNxnVWXYldMu45+k2OFfKKwf
	P9kw+z5T5Q1Ith/WLn1ss5KhlBkHc1jua+9rJMB3/q9r893iVeFOLF0MwPvpzg==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] PCI: tegra: Convert struct tegra_msi mask_lock into raw spinlock
Date: Mon, 22 Sep 2025 17:07:48 +0200
Message-ID: <20250922150811.88450-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e023a2e4296406a9770
X-MBO-RS-META: g99nkdyejwjh34us8r1hnna15cgyjkxf
X-Rspamd-Queue-Id: 4cVmhp1t38z9tfK

The tegra_msi_irq_unmask() function may be called from a PCI driver
request_threaded_irq() function. This triggers kernel/irq/manage.c
__setup_irq() which locks raw spinlock &desc->lock descriptor lock
and with that descriptor lock held, calls tegra_msi_irq_unmask().

Since the &desc->lock descriptor lock is a raw spinlock , and the
tegra_msi .mask_lock is not a raw spinlock, this setup triggers
'BUG: Invalid wait context' with CONFIG_PROVE_RAW_LOCK_NESTING=y .

Use scoped_guard() to simplify the locking.

Fixes: 2c99e55f7955 ("PCI: tegra: Convert to MSI domains")
Cc: stable@vger.kernel.org
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
---
NOTE: I don't have tegra hardware to test, this is based on input from Geert
      https://patchwork.kernel.org/project/linux-pci/patch/20250909162707.13927-2-marek.vasut+renesas@mailbox.org/#26574451
---
 drivers/pci/controller/pci-tegra.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index bb88767a37979..942ddfca3bf6b 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/export.h>
@@ -270,7 +271,7 @@ struct tegra_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
 	struct mutex map_lock;
-	spinlock_t mask_lock;
+	raw_spinlock_t mask_lock;
 	void *virt;
 	dma_addr_t phys;
 	int irq;
@@ -1581,14 +1582,13 @@ static void tegra_msi_irq_mask(struct irq_data *d)
 	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
 	struct tegra_pcie *pcie = msi_to_pcie(msi);
 	unsigned int index = d->hwirq / 32;
-	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
-	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
-	value &= ~BIT(d->hwirq % 32);
-	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
+		value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
+		value &= ~BIT(d->hwirq % 32);
+		afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
+	}
 }
 
 static void tegra_msi_irq_unmask(struct irq_data *d)
@@ -1596,14 +1596,13 @@ static void tegra_msi_irq_unmask(struct irq_data *d)
 	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
 	struct tegra_pcie *pcie = msi_to_pcie(msi);
 	unsigned int index = d->hwirq / 32;
-	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
-	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
-	value |= BIT(d->hwirq % 32);
-	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
+		value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
+		value |= BIT(d->hwirq % 32);
+		afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
+	}
 }
 
 static void tegra_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
@@ -1711,7 +1710,7 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 	int err;
 
 	mutex_init(&msi->map_lock);
-	spin_lock_init(&msi->mask_lock);
+	raw_spin_lock_init(&msi->mask_lock);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = tegra_allocate_domains(msi);
-- 
2.51.0


