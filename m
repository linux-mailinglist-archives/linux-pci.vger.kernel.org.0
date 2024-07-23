Return-Path: <linux-pci+bounces-10643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D909093A16B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 15:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5671F22E18
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D8615219E;
	Tue, 23 Jul 2024 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tfZO7v8e";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ppi8DBnP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12232481AB;
	Tue, 23 Jul 2024 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741472; cv=none; b=YIJJKp03AbUbIMnEfwwXHupl6R1m26kPWgwBG1QoAqaAZoh0whPYBXacy9oUlTt3PmJ+6anNTHx0rA3oSjBPGrn59AaWxiZwpiWIL+xa/R9bgiGWnSAHDEFyOX4LFX5dDapdFXE1j7W2PRATrZkQaMR806PKyOUOorLuzsfggYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741472; c=relaxed/simple;
	bh=X8OXNsOznZKfJqRleJyGMGUygd5lgTodqNXiv6Bjoj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJ4SqePAZuWBwCckwzNhRwGUsIkL6EWolvb3QhH3G6gMSzYks5bheSEcfdRlPnkc2/1MJUdpNKqD+XVFGSVOGwCPU23Mpul7v7jVS3R/1SMnrbr9zplwDyli3zCyiSurMWixJlUJ/UWv9dGt5dMVbC4CQqCPAlo0vY6KX7pEHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tfZO7v8e; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ppi8DBnP; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WSyhq6LBHz9sp5;
	Tue, 23 Jul 2024 15:31:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWMjNm/nU5DIb7kAzkcTKs8li33Qu7nlH6YpR7krqWA=;
	b=tfZO7v8evYgRtHCTpNUAAhPj4nuyBl1xgQXJGRL2ByKsB5/RN8LABaLZi1Sz+hJcLMTB+1
	QsPL+L3/8gfk2gFOT1EJHXxM9lH+33/uGNMD8J90JKoXr0ABGMUZK4mplMltD0MbhXtMCs
	vupeyTjjtxoy8EsjBGJlBE1qo4yCAqvTrI17ot2RM9pvUDPIx7UHKSIcWTAx4i4zl6rffH
	TDgdokMZiL5MmSv7mWLcil7CwjdhW290nxIMlneqFnmD80I0LX/e60EBsyYfVp4++Re19r
	tY2a3T8CiZO79tDdh7yxPbEdAD/B/UneK+VuvduyKs2Nigp5Ivr5Fkir8Vq05w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWMjNm/nU5DIb7kAzkcTKs8li33Qu7nlH6YpR7krqWA=;
	b=ppi8DBnPwXk5AX9ydq4fm42sZz4U5FbwBQW6Z3bf6tM/Qn7w65/4+Cv1rVv6mWfvlw9kej
	p3G3JxC0CPgyO0S0NgumfJz6CRDa3tEdPKug4Xk/bfS03f7XRW88ubncqzkjGYVJ3hMgwJ
	O9sZHq1RwBtRocZLo7f2BxzLiDZqZ2sgDAfWS6H3DgMzzZwbAKcf5ITEdCKL5P9dOGZ2Hj
	Pm/5TRCt0jUDm1kl92/DecdyJbz+fMu1x6DCvu6eMqFesUxxNj4tGXuxRB1pgEdbv5m2ng
	9sC5xPivJD6yBKv+cGF8uVorPTlkqs6wSaQBXrMw6zkMUeR5yUJ3P4htF+oalw==
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
Subject: [PATCH v4 04/15] PCI: brcmstb: Silence set affinity failed warning
Date: Tue, 23 Jul 2024 15:27:04 +0200
Message-ID: <20240723132958.41320-5-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-ID: c273d39a1d80222af6a
X-MBO-RS-META: myyuu3m7ze6oct9t5rutzgqaoje59518
X-Rspamd-Queue-Id: 4WSyhq6LBHz9sp5

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
V4: - New patch
---
 drivers/pci/controller/pcie-brcmstb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c08683febdd40..b9de3acec3753 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -445,8 +445,8 @@ static struct irq_chip brcm_msi_irq_chip = {
 };
 
 static struct msi_domain_info brcm_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI),
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_MULTI_PCI_MSI,
 	.chip	= &brcm_msi_irq_chip,
 };
 
@@ -484,12 +484,6 @@ static void brcm_msi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->data = (0xffff & PCIE_MISC_MSI_DATA_CONFIG_VAL_32) | data->hwirq;
 }
 
-static int brcm_msi_set_affinity(struct irq_data *irq_data,
-				 const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
 static void brcm_msi_ack_irq(struct irq_data *data)
 {
 	struct brcm_msi *msi = irq_data_get_irq_chip_data(data);
@@ -502,7 +496,6 @@ static void brcm_msi_ack_irq(struct irq_data *data)
 static struct irq_chip brcm_msi_bottom_irq_chip = {
 	.name			= "BRCM STB MSI",
 	.irq_compose_msi_msg	= brcm_msi_compose_msi_msg,
-	.irq_set_affinity	= brcm_msi_set_affinity,
 	.irq_ack                = brcm_msi_ack_irq,
 };
 
-- 
2.43.0


