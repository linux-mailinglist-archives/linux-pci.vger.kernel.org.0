Return-Path: <linux-pci+bounces-10263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18951931409
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F331F220B0
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A4B18C326;
	Mon, 15 Jul 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FD1sZ2KJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GvJLStJ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01D518C170;
	Mon, 15 Jul 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046048; cv=none; b=MTYkrsnK3hAFJBpskzfX1Ron/BzgKaFHh1TkQP3u4KFBhwzY8Ozb8KdHPb7HV3DE3tQ4chOd31mu0KCba6+adbQjB5+7Bbq6QHMJ/8c2ErOjiWnETJtdKNsK4QBcTp27Wpp1/5D1n63jCf9+oNi6hedxASteAQCOMUr2eUrJdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046048; c=relaxed/simple;
	bh=DmUnzz7NWMRUBhVdsvhXisqW/f88mWV4Qx2UxuBzzb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFGpalTzFYitd2y7E4MPKLtQsojM4AtZ4ehW4P/9rsqP9B2Ha24AMQUjHkamupidrN0XRi712Uv2bQmsHUb0rxk1p+vYSo8wkEDlbrrTTQpYuySNVYaA6MnzZfs4KcgduikfrkpnsrLFArLIDeZhnlNifwfuh2BtNeZerF0Beow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FD1sZ2KJ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GvJLStJ0; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WN1WJ13D5z9slg;
	Mon, 15 Jul 2024 14:20:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721046044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unnL5I7d5jwqGcATBu9+KiMley5zwh8pHHnERosyJX0=;
	b=FD1sZ2KJWKvbikfo0CFFnUXMcjvpeXxPrWTeKtyVK80YnDTfmpiX4sN3ogrdVtxJVJnEo4
	R6N80Z5IpFPUc1Gtonl7HJWkCAXASjL/ns9FgLZAxjDRlPYMstOqIHY+yOwGZNKJYf1PGi
	elaQO0Y69K3dwrDEpBTyKaiz6EhHGLXbHX4xB9xoYaCYQ61oo4AIiz/F/FfjLPraX/UIjY
	GwsqPJJbePf2jPvLm0/EbJhkpTOeeUDg45TLvKVstZuPOCjLs4y/p72kf2Uq9W47fCWfKL
	acpb4N2uHjMwTDbekWSUBwXc3S2VrYughEHUYxfZ9tu+iy7PfLbi3Y1GeJESjg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721046042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unnL5I7d5jwqGcATBu9+KiMley5zwh8pHHnERosyJX0=;
	b=GvJLStJ0kCwyDcLcB85cZ1u+Pr7On6yeqKVP8shWvkvwE/UAj5lvU6HXH4qYliKYqxXxGE
	tumjk4uOks5kd62kAJ9FkzE9VBbdsRSRxQ0w8NwmH7evO1T6PpGrctd3I1jePNBmXCurq9
	81AWvVOLMvKMNx6or/dj3Ly/1A+M1oHLfG/JCnkGMULguufluWO/XWMnhn1LibmDB7twTL
	REGLKdBPh2B3EiImNB+uh4m6xfIKvlN8ysXGIPfbNkTLfX+Mo+L30uxcDYzNkFZn/A+C36
	da/ahDXcUj1LOFEsNKty8B2KhPRH/20dNBje/hXXr35iWxOiDHrxjCBr0cqxbw==
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
Subject: [PATCH v3 3/3] PCI: tegra: Silence set affinity failed warning
Date: Mon, 15 Jul 2024 14:19:28 +0200
Message-ID: <20240715122012.35222-3-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-ID: c9fbb42232487850b10
X-MBO-RS-META: wk8zixksezs68dzd8b88ci6y5fu1jciy

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
 drivers/pci/controller/pci-tegra.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 038d974a318ea..d7517c3976e7f 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1629,11 +1629,6 @@ static void tegra_msi_irq_unmask(struct irq_data *d)
 	spin_unlock_irqrestore(&msi->mask_lock, flags);
 }
 
-static int tegra_msi_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
 static void tegra_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct tegra_msi *msi = irq_data_get_irq_chip_data(data);
@@ -1648,7 +1643,6 @@ static struct irq_chip tegra_msi_bottom_chip = {
 	.irq_ack		= tegra_msi_irq_ack,
 	.irq_mask		= tegra_msi_irq_mask,
 	.irq_unmask		= tegra_msi_irq_unmask,
-	.irq_set_affinity 	= tegra_msi_set_affinity,
 	.irq_compose_msi_msg	= tegra_compose_msi_msg,
 };
 
@@ -1697,8 +1691,8 @@ static const struct irq_domain_ops tegra_msi_domain_ops = {
 };
 
 static struct msi_domain_info tegra_msi_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX),
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX,
 	.chip	= &tegra_msi_top_chip,
 };
 
-- 
2.43.0


