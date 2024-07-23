Return-Path: <linux-pci+bounces-10649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A9993A17B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 15:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BEE1F22A75
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC701514D6;
	Tue, 23 Jul 2024 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R/BvekQA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jfytO0n8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A0208A0;
	Tue, 23 Jul 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741512; cv=none; b=CRyuhPdUdUw1cbtaxzaaoFHbOWk1MMHBFW4x63l0hpq/WE89uVnv2UUFSYHRxbjAuxQONKCM/WEznezmC/yIG7PTNlzolFv+Gj6c438HQyhc3qfjbFu7VUVasnWNwwwqoeYxiRqNXEOb3k2IXYvkHPrW8ziaUa99nvHH3sgg/Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741512; c=relaxed/simple;
	bh=C8Hz8TfJZheWg5Yk2RAbYesRbAbrTdr7wKySbTIPsgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzvLep4HaDi74wYRIADJ9+jW88vW/Tr/w7RkdgA0Np5skG+qREeZHaHAjCvpmAMfLcuMlkM/nneO1K4V9SpL6/0XY7VY2XytTWVIC9D0/OrWrGvfzqKv8IaDoBdvnlZDezF4liPfOj8u3iUNMxJWCukwB36rBDB1volgP8HUNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=R/BvekQA; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jfytO0n8; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WSyjd0Y1Nz9sRn;
	Tue, 23 Jul 2024 15:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQsLSdgAtKfoGwMEHaAZTOzrW2FekDkGx4i7qFpzRNk=;
	b=R/BvekQAftIvU2rbcc0RpB8AgkX1V5yLumjfqbX64k0muFpNg5PpJEh80fiuuL2RgnZKyC
	jvxaJzDK7w6eGGbxnXF57qmExHGomlNhHR9m9j09K2+az2AVjdPxKjq4UMYy52p1mmI3y1
	YWUTtL0rKJQfjcmp65Se/6Y76WqwJ+Um9i1iclTzSJ0x3PjmiNQ1MKCv7au3YbMZM47eMT
	1uEtCh3OAefA4VAE2/4dLg4UXskketTcOZZllQG2VJdpvcwyPdmzme1zWxvWu74xuAsPJB
	yCo/kmwz6XQbglcp0U8NSdVx+hh0ZXtPI3L7yz+olVnVbeVZC+Ld9zAHEmedtA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQsLSdgAtKfoGwMEHaAZTOzrW2FekDkGx4i7qFpzRNk=;
	b=jfytO0n8jZ1FWS5coJ7gF6dTSNLcjAYCmTPjgtTSMSHhU8S4RWg5r0ipfw1eR6tR2RFLhi
	yvgRZmA4NkJvgL0kEZhXpI9SeusFese1cvbtM/FE4HOqAyEalL34UUdAfLo5x5OGralgcW
	GAH4qIZG49tT2TqQKUpbp48dqlaHr+dGc+lGuFsyyYLEgFMy0ip77RsW0mk7hnd9j2aR/5
	z/PQFpX2wlCJLJNGODbdAPQBLzpklV2HC2OcmL7f8F/zXVyawqi0Hhrn2D0Sf2+uook9Hn
	M9Uwvce56tR5bQ1K9a4YVVr3zs7yIeMefj00w0EnQj2+ob8YTsofvNaPclvJ5Q==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v4 10/15] PCI: rcar-host: Silence set affinity failed warning
Date: Tue, 23 Jul 2024 15:27:10 +0200
Message-ID: <20240723132958.41320-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>
References: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5a4c2889652f8c2bd88
X-MBO-RS-META: angdmgdfm99ya5hetaddg46hpta3erju
X-Rspamd-Queue-Id: 4WSyjd0Y1Nz9sRn

Use newly introduced MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity unset
and allows migrate_one_irq() code in cpuhotplug.c to exit right away, without
printing "IRQ...: set affinity failed(-22)" warning.

Remove .irq_set_affinity implementation which only return -EINVAL from this
controller driver.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: "Pali Rohár" <pali@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Jim Quinlan <jim2101024@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Joyce Ooi <joyce.ooi@intel.com>
Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-tegra@vger.kernel.org
---
V3: - New patch
V4: - Update subject prefix
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


