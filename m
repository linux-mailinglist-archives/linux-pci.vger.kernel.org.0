Return-Path: <linux-pci+bounces-10261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EDB931402
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA1E1F21E94
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04E518A957;
	Mon, 15 Jul 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xuYuvoDK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="crqNVKYh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E56175A6;
	Mon, 15 Jul 2024 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046044; cv=none; b=oN0/RLr7EgqNXZRtOeiXgW7j+Sd1u0zq2lWrkGx1IRWL7oTDgJbB3yT0bN9H9Xb+32cpw+X422+ZNoVOORrtSiLfsdsZk3sKtCmrI6/8NH21uZsMhZG0L0SVOE5qchEz/Rmcf13vxB4pY3CnktEK+T1sbgKDeHcFFEpBqBvv2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046044; c=relaxed/simple;
	bh=fZCTvImvlbUbtY8RaEfq01G/C8Xbe35DoKLCdRoa/zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bSwOMPQS4JaXRNFc0yl2ZBLmPMMwfv0DaTjmP3yZQViwSyWHxTkAlAHVAIfkpcU+dHgn6ou1ZzNAeyYsyGgu7hsDbqC7z/mTde8tnYP2hpMuEG97gig5+NvOWnXzUrddnp6+/Qj77cLFtma0/U1vOwLEfgq11ywSETd9RXW+NdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xuYuvoDK; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=crqNVKYh; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WN1W92KYVz9sc6;
	Mon, 15 Jul 2024 14:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721046037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FL4eb5mH+GbNCEmlKqjoVaar4JHSCtGhxjB+oJ3+EWI=;
	b=xuYuvoDKJH8jzqzbd4GToZ2j2cy9F/nczr/r/CmtEJICfvv+472zI76TBvIV3nDnaV7FbK
	PDp2PSDsRTGKMSKl58jrQILvNDBEqftf7PpJumTw7yh8cZP89Tv/O3X3wJm7JG0ExX06/P
	cfhX13vIYHHUgyQ4bIGQBANgCPXgKH7gTUFzA9XfvmT+SAZDQLgXyDaB7mwjW43xX/XwBx
	0AQ1Yw1OHkBph/sfW5uGJWCVwVAFLt+8LPPDPyZ3Unf/4kApgl4qM3ZhddAyQp4fKXC26f
	ep0qKtQXSAGaLGlaHQPyCsFZKVpzPdxiZMsalBtqBP/SVrFav434v0OnfnxRlg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721046035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FL4eb5mH+GbNCEmlKqjoVaar4JHSCtGhxjB+oJ3+EWI=;
	b=crqNVKYhpKd5MqWX2oQH1x3MTn3aEx9LyR8W41JEv+/LwVRCtHVwcJkQAX3rVQxvJuzJMq
	a4TLzXNVi9N5bZ5UpWbgEony/GBzT0tv9i2CcyGe8w5E5UrT1/TpPSfbF58oosnFgBoB8I
	Uh76nqO+bYX8fiXBTh/JRjFjcNgrxcQYUCS+Y8XPxX9AXKWpQ04I76nw6Ywry/4dIvNQ4l
	rmprqQPielbpXIQU2kbTDyqv+aCxv2NJa+TREz78YYlR+unULH56YP3t4WIRnp61Mkck72
	Dzy1+wA8wquYtbIlmQRliTvfs2ThxFdP7RAlhS7TG/G5a1XtyfqzB+n52n8/lQ==
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
Subject: [PATCH v3 1/3] genirq/msi: Silence set affinity failed warning
Date: Mon, 15 Jul 2024 14:19:26 +0200
Message-ID: <20240715122012.35222-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5304ea1013472d8aac6
X-MBO-RS-META: i65y8kgmushz3ue6hhx41xtiggio3qan

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
V2: - Introduce MSI_FLAG_NO_AFFINITY to inhibit assignment
      of msi_domain_set_affinity()
V3: - Replace MSI_FLAG_USE_DEF_CHIP_OPS_NOAFF with MSI_FLAG_NO_AFFINITY
      and make MSI_FLAG_NO_AFFINITY into separate flag
    - Update commit message
    - Rebase on current linux-next
    - Use genirq/msi: subject prefix which is likely better fit now
    - Split off R-Car part of the patch
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


