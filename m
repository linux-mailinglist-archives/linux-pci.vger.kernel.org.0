Return-Path: <linux-pci+bounces-10642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8CB93A167
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 15:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EF9283861
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0C2153582;
	Tue, 23 Jul 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bPCPRTl5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="v3+rl+/t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D21509AE;
	Tue, 23 Jul 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741457; cv=none; b=D5FH9gdxoePqKvc1lcoA3WsUY7WmseMWLATnZznc3393igAmhfTQ8iXV4l3ZlqR7lIuZi/cbgv3fQMPmtlUxJjspaclHYkcGmGJ3y1iAoP0CnuZ01wT1gsR0ojlngosdAv57RYTJnIxXbquisQKihhCW7t4flDtyxmqTqgozJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741457; c=relaxed/simple;
	bh=kRVvXvJl5CKTWBjJb4fTWk5GFMZnfd7gKZGcdcWiabE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGj59ZIr59NyfJMYjGy+I1sW4zrsVAQdgHN/utHWQ917leSV2v0IyfqWytHuV3Pht2te5H8DiQ66Hh91c32BvKoz8ODI2YEr/kGxs4Xa+CArJxs/L08QnkErBhgsGqD2fowZreY0VzOGmcRdu6/dt8rOMdSejnglAC3KzFGGSs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bPCPRTl5; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=v3+rl+/t; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WSyhR6nGHz9sjp;
	Tue, 23 Jul 2024 15:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRBABrPdji7cwLt+MY4iniYEY45uLFC7zidsokLoxR0=;
	b=bPCPRTl5n8+rPT5sbvr0owxSFbqpPpIbUZLL5k688BDrdD4i1u0MeHJmEZWOfxsAEnKgCC
	fslMxZJ8nvEkfzTt/prWe9FERygCWEgw/Rpgz1khITfhOvTUXLQqHm0uX1Um5dFBzLn7XS
	WpfwzthJqmR4Pl53OOmRW8jbFZ+Sdz6EvAGek6bjYP/Z56VrUW2JHIg+uUhTIlzVak+UqP
	vMp7QnhVlBSsnROUl3helBZoyfaLX0MWnh/PysjuWEGrcfSJICxWY6IBJeRmK48t6L4bpg
	LG/CYSSnnGcvUkv5ZP361Ydb6PlIiDn5apzWs1Hf9gmIWixqqT8O07wydS3L4g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRBABrPdji7cwLt+MY4iniYEY45uLFC7zidsokLoxR0=;
	b=v3+rl+/tBJLBksC730XOWBQO9O/xkkdDAVuTnmne/wcBXt+E6x8ohNp/zZS5inJ21iOIJy
	mnhVyp5iOSVfLOxKywDEW0AenpKRuDGJ7Kxbx3wMssCHByI337CY2AGF4d99agoRBbnexq
	jqPy0oQ3794BdY4I96WkE2bE/FtmdZXPuZSd/ALPHIyszesJrrMVcT4QFkVyuZMlhMuAvZ
	EvqYEbj6x2K//ynjz1IPrcbAvbcWLlTi762fBSrLRpq7GGYHUrpwU4u/kgRdkeQxNnse8r
	6Yys35OdbiS8dDCjLMi5mPSv2TrA8GIXoFNgT6qZd70KVCgnnVXo5qMKzSBzzg==
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
Subject: [PATCH v4 01/15] genirq/msi: Silence set affinity failed warning
Date: Tue, 23 Jul 2024 15:27:01 +0200
Message-ID: <20240723132958.41320-2-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-ID: 3256f6e60b26448e5c4
X-MBO-RS-META: xhso8pgoaxhy9km3jgp6dfeyzp65bye6
X-Rspamd-Queue-Id: 4WSyhR6nGHz9sjp

Various PCIe controllers that mux MSIs onto single IRQ line produce these
"IRQ%d: set affinity failed" warnings when entering suspend. This has been
discussed before [1] [2] and an example test case is included at the end
of this commit message.

Controller drivers which create MSI IRQ domain with MSI_FLAG_USE_DEF_CHIP_OPS
flag set and which do not override the .irq_set_affinity irqchip callback get
assigned default .irq_set_affinity = msi_domain_set_affinity() callback. That
is not desired on controllers where it is not possible to set affinity of each
MSI IRQ line to a specific CPU core due to hardware limitation.

Introduce dedicated flag MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity
unset in case the controller driver did not assign the callback. This way, the
migrate_one_irq() code in cpuhotplug.c can exit right away, without printing
the aforementioned warning. The .irq_set_affinity implementations which only
return -EINVAL can be removed from multiple controller drivers.

```
$ grep 25 /proc/interrupts
 25:   0 0 0 0 0 0 0 0   PCIe MSI   0   Edge   PCIe PME

$ echo core > /sys/power/pm_test ; echo mem > /sys/power/state
...
Disabling non-boot CPUs ...
IRQ25: set affinity failed(-22). <---------- This is being silenced here
psci: CPU7 killed (polled 4 ms)
...
```

[1] https://lore.kernel.org/all/d4a6eea3c5e33a3a4056885419df95a7@kernel.org/
[2] https://lore.kernel.org/all/5f4947b18bf381615a37aa81c2242477@kernel.org/

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
V2: - Introduce MSI_FLAG_NO_AFFINITY to inhibit assignment
      of msi_domain_set_affinity()
V3: - Replace MSI_FLAG_USE_DEF_CHIP_OPS_NOAFF with MSI_FLAG_NO_AFFINITY
      and make MSI_FLAG_NO_AFFINITY into separate flag
    - Update commit message
    - Rebase on current linux-next
    - Use genirq/msi: subject prefix which is likely better fit now
    - Split off R-Car part of the patch
V4: No change
---
 include/linux/msi.h | 2 ++
 kernel/irq/msi.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 9449797638255..b10093c4d00ea 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -554,6 +554,8 @@ enum {
 	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
 	/* PCI/MSI-X vectors can be dynamically allocated/freed post MSI-X enable */
 	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
+	/* PCI MSIs cannot be steered separately to CPU cores */
+	MSI_FLAG_NO_AFFINITY		= (1 << 21),
 };
 
 /**
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 5fa0547ece0c4..ca6e2ae6d6fc0 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -832,7 +832,7 @@ static void msi_domain_update_chip_ops(struct msi_domain_info *info)
 	struct irq_chip *chip = info->chip;
 
 	BUG_ON(!chip || !chip->irq_mask || !chip->irq_unmask);
-	if (!chip->irq_set_affinity)
+	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
 		chip->irq_set_affinity = msi_domain_set_affinity;
 }
 
-- 
2.43.0


