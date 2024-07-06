Return-Path: <linux-pci+bounces-9875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A72A9293C3
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 15:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9434E1C20E6D
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913B961FCE;
	Sat,  6 Jul 2024 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UfvdYXaH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SgR4mwPu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F86482D3;
	Sat,  6 Jul 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720272505; cv=none; b=KHGvH7Hrt9INzxw3CSmxGnVF0faMxqVxov5OsCJqXvpcotpSIo0zLkmocp4fz7es7IuC6IvaAkUqss2wZ3+/NJ/a+Eub5oSy/40DBn8wrN0XndWMrISGvry5zzG455f+7O9SKF/ZXL41S5llPDJwl6eClL5/1cuHAHkOFNT94nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720272505; c=relaxed/simple;
	bh=+YOserGKjpmqK1DcdX+zb0jn/RQAHpubIlZ0wMr/FuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sCOeHbjPb6SOuZg1ucX2GywJ4ulWMp9q/itYIlbcUiU0Rf98xV0E5UH7JHwOHSoUGFtcKHXQ+A50l8NqvqGlnlgfbGtLzNsEB38+63K9VlMkEk6PVdb4Abd+rl962X5kr7XHcMociRxmqW+GIEA1/dku68lcOROkLyGCpZqYSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UfvdYXaH; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SgR4mwPu; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WGWRM2kz2z9sWp;
	Sat,  6 Jul 2024 15:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1720272495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZHVRL15PnSrx71qs8MKdRnPeHyG2B0QZU0YiU4awXBw=;
	b=UfvdYXaHY2epDVfv14vStlUtGyuJfuavf+e8MTeO8cFJbjeHlEIWaUZvqZ6uV0aGjPLg+m
	YvsIQVMXQDQhSCARH7LmMO/cBuv5M1ytNB9xqNDa8kwT5I5DkvNDO3KuDVc9wKSoyeIdp5
	rSje2fpv0KSAZF24E5ekNH9PkBfOSerRtNdJ8aQZHY1iS0XD1lEliG3AiOq5ggNM9I0F4R
	LO6H6BVLIpzzHBsfEWM/7HDyBjHbN8pacWoF3znVj7RhfPVBfOevnqHyJXhLvr3nZaO0wH
	DnWvvpZfsN/4j6ETPsvPbjCdLYmTyjG15q1pNwWX/q+SAyZsWMdJMKnQtJDfCA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1720272493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZHVRL15PnSrx71qs8MKdRnPeHyG2B0QZU0YiU4awXBw=;
	b=SgR4mwPusxQDIqQmEiUmCbflZEiXB24ablBX3D7fp+7TCBhyuZ4JwzX3Ht/JoODctuEZbo
	uE4NWqtCSsruCb43w5AYa/zUSCsicmLeRS4uutjFnAPa0gCDKZTfpPyqujY44Q8HE65bYL
	EFiz/t7KtVqCAy64I3HxyfMXtwLdyWEDnTu8wFcd10RGytzl/5mhE3MTzZAYmSO52TWO4x
	lCivAiSjaLPag+TZ97u6mTmY3Q8w96Hc6VBHihsVxAM/QSJu+TU3Lp7xvDjWqKcMAmAyWm
	YVXh7loF2TOv/hOw3h/eg/gT55QcyA6wftIkOoaZv/22FSoMMi7ksyd+XzP7Hg==
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
Subject: [PATCH] [RFC] genirq/cpuhotplug, PCI/rcar-host: Silence set affinity failed warning
Date: Sat,  6 Jul 2024 15:27:55 +0200
Message-ID: <20240706132758.53298-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 07b05804bee78fc8a55
X-MBO-RS-META: srdmci7tm17pehydis9zuaepjse7i1sx
X-Rspamd-Queue-Id: 4WGWRM2kz2z9sWp

This is an RFC patch, I am looking for input on the approach taken here.
If the approach is sound, this patch would be split into proper patchset.

Various PCIe controllers that mux MSIs onto single IRQ line produce these
"IRQ%d: set affinity failed" warnings when entering suspend. This has been
discussed before [1] [2] and an example test case is included at the end
of this commit message.

Attempt to silence the warning by returning specific error code -EOPNOTSUPP
from the irqchip .irq_set_affinity callback, which skips printing the warning
in cpuhotplug.c . The -EOPNOTSUPP was chosen because it indicates exactly what
the problem is, it is not possible to set affinity of each MSI IRQ line to a
specific CPU due to hardware limitation.

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
 drivers/pci/controller/pcie-rcar-host.c | 2 +-
 kernel/irq/cpuhotplug.c                 | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index c01efc6ea64f6..2314b2b30df8a 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -660,7 +660,7 @@ static void rcar_msi_irq_unmask(struct irq_data *d)
 
 static int rcar_msi_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
 {
-	return -EINVAL;
+	return -EOPNOTSUPP;
 }
 
 static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index eb86283901565..822bd6ca40bf9 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -147,8 +147,10 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	}
 
 	if (err) {
-		pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
-				    d->irq, err);
+		if (err != -EOPNOTSUPP) {
+			pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
+					    d->irq, err);
+		}
 		brokeaff = false;
 	}
 
-- 
2.43.0


