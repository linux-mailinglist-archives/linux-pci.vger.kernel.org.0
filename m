Return-Path: <linux-pci+bounces-10241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075B59309E9
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2024 14:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B351F21524
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2024 12:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1AA433CD;
	Sun, 14 Jul 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ClYOFjL0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="b7K8mk+3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660D28DD5;
	Sun, 14 Jul 2024 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720959872; cv=none; b=c9ohWWpM0doN6NitB8TwwYGtPS3p9fF4J0SG/fvqNHkTQBQOm4WDld+pcq6jvVchos0Na3UjLGR1QRNJ7CjnoCJzYhQFALhJikflCR+p6waCFqEI2zAalUzfzq0u5Su8UT3LzofhKyCCd9bc96ZYLa2X25KiuxoLWC68jyd5VWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720959872; c=relaxed/simple;
	bh=p03WVwLKpyGKSbsX7Emyj7o532hKphMlaaRyiIwhuoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XR4FrqpUWElBKcK7iI7gP6nMXUc4TprGQoGrLf6cNHQGmj//2dQSa8yH/3A7va2PPpwDJSompLqW1P1O0jz7HzM8UYRbNByDSCfc25HJPUglfzsCaey5+96wlXoVKL8hPKNoFJ+nc02pDyqsk3kjnmFmWM7ClxuhK6SNXbIGY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ClYOFjL0; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=b7K8mk+3; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WMPf24Qmqz9snn;
	Sun, 14 Jul 2024 14:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1720959866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vWxGM8K0oTATNzWCeNTcs8hzchJzMmpDfzrc0PIpPas=;
	b=ClYOFjL0yI9FruHTSbbhr5e3XSxY4cWUJm52WgJqpkTsx9CRcdmxmys7MMmgWI3MeD1Q/4
	rniXbxQKlt6OaYj+PDF1MeHkz5ooXKpeUTgqUvr+FEztW9hwiTQyEBUv4VDaegmp3KC/xh
	pmwblxjW0Eia160lUjA2HnYyL44FvWcmRUucHTf7x77VnnuXCW7+VDwp+4CH7/62GqT63m
	OZ6rQr9TSwabVOhQFdp7Ytdx93XQldSntwRegNuGUbdS0RKq7Nl9jrRTM+ISrygVYP8Lzv
	+4wLH8ADfrGmnquj6BntXjbRmK+siHQJibUL6Lxe9FVSJ5xDr7ulg4DJD0Qy4w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1720959864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vWxGM8K0oTATNzWCeNTcs8hzchJzMmpDfzrc0PIpPas=;
	b=b7K8mk+3ySHYj+6iUtC03+HrT2Cd3WENeIcQmKStMX/z4FzLg+f9RT3AJ8aUOrw95jDqgW
	hPH4FTeQ96AMpthaCqp55KfYVuo0clarCYUQ3rJAMa7BePSWUCxBH60rFVdOTdiR2MIz6K
	oAnhzEIOPseOEB5FBt3/d1V+Ca/F/N+bx9FFebyCdpT9d7z09vOTrloDiuBb4RklkcPl3F
	303FDaXBLX9NArFjpuTtM8gg8fel5ddl2nGnQfZ4LY42mN0wwMkn0KIzSAFrlDGvfYVXuV
	/+duI5BnybMZ4+LBUv07Lkp0dLdWDlKZLP4klN/Pmdwzq8ySlwXBPGdRpPt0sQ==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] [RFC] genirq/cpuhotplug, PCI/rcar-host: Silence set affinity failed warning
Date: Sun, 14 Jul 2024 14:23:53 +0200
Message-ID: <20240714122405.27548-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1ec446ac394f3aa4007
X-MBO-RS-META: s47xf1mder1rn4dqayssegsc3agk66xo
X-Rspamd-Queue-Id: 4WMPf24Qmqz9snn

This is an RFC patch, I am looking for input on the approach taken here.
If the approach is sound, this patch would be split into proper patchset.

Various PCIe controllers that mux MSIs onto single IRQ line produce these
"IRQ%d: set affinity failed" warnings when entering suspend. This has been
discussed before [1] [2] and an example test case is included at the end
of this commit message.

Controller drivers which create MSI IRQ domain with MSI_FLAG_USE_DEF_CHIP_OPS
flag set and which do not override the .irq_set_affinity irqchip callback get
assigned default .irq_set_affinity = msi_domain_set_affinity() callback. That
is not desired on controllers where it is not possible to set affinity of each
MSI IRQ line to a specific CPU core due to hardware limitation.

Introduce flag MSI_FLAG_USE_DEF_CHIP_OPS_NOAFF, which keeps .irq_set_affinity
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
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Introduce MSI_FLAG_USE_DEF_CHIP_OPS_NOAFF to inhibit assignment
      of msi_domain_set_affinity()
---
 drivers/base/platform-msi.c             | 2 +-
 drivers/pci/controller/pcie-rcar-host.c | 8 +-------
 include/linux/msi.h                     | 2 ++
 kernel/irq/msi.c                        | 2 +-
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 11f5fdf65b9ef..91e8a9e3d9610 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -100,7 +100,7 @@ static void platform_msi_update_chip_ops(struct msi_domain_info *info)
 		chip->irq_unmask = irq_chip_unmask_parent;
 	if (!chip->irq_eoi)
 		chip->irq_eoi = irq_chip_eoi_parent;
-	if (!chip->irq_set_affinity)
+	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_USE_DEF_CHIP_OPS_NOAFF))
 		chip->irq_set_affinity = msi_domain_set_affinity;
 	if (!chip->irq_write_msi_msg)
 		chip->irq_write_msi_msg = platform_msi_write_msg;
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index c01efc6ea64f6..e898732159c04 100644
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
 
@@ -725,7 +719,7 @@ static const struct irq_domain_ops rcar_msi_domain_ops = {
 };
 
 static struct msi_domain_info rcar_msi_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS_NOAFF |
 		   MSI_FLAG_MULTI_PCI_MSI),
 	.chip	= &rcar_msi_top_chip,
 };
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 26588da88bdd8..ab79d772fd43d 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -573,6 +573,8 @@ enum {
 	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
 	/* PCI/MSI-X vectors can be dynamically allocated/freed post MSI-X enable */
 	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
+	/* Same as MSI_FLAG_USE_DEF_CHIP_OPS , but does not set .irq_set_affinity */
+	MSI_FLAG_USE_DEF_CHIP_OPS_NOAFF	= ((1 << 21) | MSI_FLAG_USE_DEF_CHIP_OPS),
 };
 
 /**
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2024f89baea4b..877365eeab262 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -816,7 +816,7 @@ static void msi_domain_update_chip_ops(struct msi_domain_info *info)
 	struct irq_chip *chip = info->chip;
 
 	BUG_ON(!chip || !chip->irq_mask || !chip->irq_unmask);
-	if (!chip->irq_set_affinity)
+	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_USE_DEF_CHIP_OPS_NOAFF))
 		chip->irq_set_affinity = msi_domain_set_affinity;
 }
 
-- 
2.43.0


