Return-Path: <linux-pci+bounces-10262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BD1931404
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E233281CF4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFEF18A95F;
	Mon, 15 Jul 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SWROWmWt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fTH6aGyt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715A172799;
	Mon, 15 Jul 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046045; cv=none; b=QQVsgmWbinHAGeNI/2/KEPPda3YFBR01pmG2A+/WN6TOK9RCl1xi71J9SwQwE7rI6CbG+FWI6ziEPFdpDU4ZSpo1xh/hpueHv2Izxz98zTJBHs9YNXY3UOz64pUtUkKsqHLHsG2em/RfOGq3kQIgN1RdUFUfIikIjztADQ/QVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046045; c=relaxed/simple;
	bh=wxyN2Soi5hPghwCDRcn/LU1vNmUmU0GEVLoxtPi3hBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZghMKfbJpisr+hlLnLoPCVuCxphhn2eSZMc6Z0erWxdpAEY0ic4JjWfHHbPD5lh/SaomlZZnCARYeowPOsStrv3kau7jHC5tK+IEerEIj3yeO4VxQUmGCl9pVMAIIdIA0o5UnrMtJWWPm9oh83tkNyvjouVRHA8hilmV4Me6P3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SWROWmWt; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fTH6aGyt; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WN1WD6P46z9scJ;
	Mon, 15 Jul 2024 14:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721046040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFZL+rC4L3YqzPlzyA7IEyfbTHEYRvoPw1Tzo0CDzio=;
	b=SWROWmWtcWfen2WQc3wdSYbLaKHYQvMrWjAE/bvewGk8FcAyR2/674CqboUpMFyeiByovT
	YgNf2zHZElue5xYhvpWv0p9ONKRmjtiGKV8ElEX81D6V2oT0J4stQYulgEc0jJdxeN5j7I
	2Ov2ozIPywNhvde46Fmdzd9gG2onHerD4mtJB4u8eGKASyxZ5wbxTT83b7mR9YGeIROUnL
	L8fvpEs/zF9Z9SjSpyDXySNRd53Od0zZMiHDO93YMVK0Nz+/JKeNu8874U89mo9RYRrGO/
	NKKXhILAOeYI4rNo33BZHj4aHE+o1aaefgjuyFDKdL1sekk67t61whcO7SSLDA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721046038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFZL+rC4L3YqzPlzyA7IEyfbTHEYRvoPw1Tzo0CDzio=;
	b=fTH6aGyt7T2zA7X4KU/fSw5tzEZNtXci//ndevnzDtlIKw3zhh/+gF7bTL7YyarFeAAvcu
	kEbXvS88+b8M0F1hix7ccRf8L3NUBxQJv157sKUZ8F9MM3Tzi4WV9U5scz4oouTy8z++50
	2aJb94tu6MsONPQgtDXZYhs0FHP+U1JDZoc3S5diMgZ7d7Winc/nzkUg29cgMceaZAogPO
	hN+8WytCjX2e1C+YhnlQJrGc4UhtwJfNVtM1158snoThM8OX2Q92t5rlbgTI8RC3/VU0rf
	bu2nMMx4pthJQ2WT/kl6mrlhpQayqrSjXq/nooeyi7XCWvEuntpUVoK0Bnpouw==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Rob Herring <robh@kernel.org>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 2/3] PCI/rcar-host: Silence set affinity failed warning
Date: Mon, 15 Jul 2024 14:19:27 +0200
Message-ID: <20240715122012.35222-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240715122012.35222-1-marek.vasut+renesas@mailbox.org>
References: <20240715122012.35222-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c913639756c68c1f3ce
X-MBO-RS-META: ki1suaerkm63p74dg7r3j9d34yshwn73
X-Rspamd-Queue-Id: 4WN1WD6P46z9scJ

Use newly introduced MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity unset
and allows migrate_one_irq() code in cpuhotplug.c to exit right away, without
printing "IRQ...: set affinity failed(-22)" warning.

Remove .irq_set_affinity implementation which only return -EINVAL from this
controller driver.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
---
V3: - New patch
---
 drivers/pci/controller/pcie-rcar-host.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index c01efc6ea64f6..3dd653f3d7841 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -658,11 +658,6 @@ static void rcar_msi_irq_unmask(struct irq_data *d)
 	spin_unlock_irqrestore(&msi->mask_lock, flags);
 }
 
-static int rcar_msi_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
 static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct rcar_msi *msi = irq_data_get_irq_chip_data(data);
@@ -678,7 +673,6 @@ static struct irq_chip rcar_msi_bottom_chip = {
 	.irq_ack		= rcar_msi_irq_ack,
 	.irq_mask		= rcar_msi_irq_mask,
 	.irq_unmask		= rcar_msi_irq_unmask,
-	.irq_set_affinity 	= rcar_msi_set_affinity,
 	.irq_compose_msi_msg	= rcar_compose_msi_msg,
 };
 
@@ -725,8 +719,8 @@ static const struct irq_domain_ops rcar_msi_domain_ops = {
 };
 
 static struct msi_domain_info rcar_msi_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI),
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_MULTI_PCI_MSI,
 	.chip	= &rcar_msi_top_chip,
 };
 
-- 
2.43.0


