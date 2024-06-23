Return-Path: <linux-pci+bounces-9138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BFB913C15
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A67B21EA3
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32018307B;
	Sun, 23 Jun 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pZzYjnwC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JigPkwZl"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644101DFD8;
	Sun, 23 Jun 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155921; cv=none; b=SXy4Myzgzq8fh7Uk1m2A6VfWwCAtTSGL/gi7Ij5qPNyLJifZMWkwGRhFCGp52FAdh/s+UNdJ6f4V6jkkZBZehyxRlXGesf0Qe7sxwwKHjCgqaKivjbWvb0Eyqhc1+uyPO5GDWD2ZX08hgZcAfWYnh8nD/fwjK/CUB5t9Jg9M5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155921; c=relaxed/simple;
	bh=/dpIxo4Ld6z7TK5DNq9xMJAiCkSBZPlo2D/vwuosV/s=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=d3kkyORx0gkm6bvQkxarJKf02RDmq552iE/xT2+q295/BwuvO1l+Z9w6iZRZcPy2U6wKGQ4qKdyYPDyJOZL+Ksk2qAljVKwNZ8Xnh/ZijXQi2zhJ91n/LS3Sy2pnYXczVMXiXSabcCQ92ISTqN8HekyWrFNT+NBA2YtCtn9yGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pZzYjnwC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JigPkwZl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142234.964056815@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=59dcuDVkCT5Chz9zL5I9sLuOHXcs5MQeEAa79Mp3gLM=;
	b=pZzYjnwCri+KShtZdmEhjKFruhxMqQ1wW0Jm3bYWHF/6BafvSmSc7CEivG1OP7+ZrjHnXS
	tIRueA3Fb2CAS0oTABkZpGiMZcw27l7OrmAsVRCzXXbskMPZqcIq4wqNUO/ShniAO0Tdi7
	7PuEK2msEkbbKUzdEtkBJJ2mjRLCvKBvfuh/YiB9TjCpWfOO0/891Jjr2TAIbKO+h3NV0A
	FJcvAWNW+dxYHHzXByrK7bCx09e3T+a5VnxojxIsZy5/v5DNeZwcsDJBrI4DxoqHAxzCtV
	0l7yV5K31D2Cf7Fmrr2Wk9vzIaFA88m3Rb13x4m8Uo6HA0jUfOHo2ygRBRKB6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=59dcuDVkCT5Chz9zL5I9sLuOHXcs5MQeEAa79Mp3gLM=;
	b=JigPkwZlluaO8jGNdKy3BRMcXC22rwWZufmZ+LsgrnmVo/FuWvc914anaBxzk5yiyI85Ka
	EQaWrVziOc0lTnDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 maz@kernel.org,
 tglx@linutronix.de,
 anna-maria@linutronix.de,
 shawnguo@kernel.org,
 s.hauer@pengutronix.de,
 festevam@gmail.com,
 bhelgaas@google.com,
 rdunlap@infradead.org,
 vidyas@nvidia.com,
 ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com,
 kevin.tian@intel.com,
 nipun.gupta@amd.com,
 den@valinux.co.jp,
 andrew@lunn.ch,
 gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 alex.williamson@redhat.com,
 will@kernel.org,
 lorenzo.pieralisi@arm.com,
 jgg@mellanox.com,
 ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com,
 lpieralisi@kernel.org,
 nm@ti.com,
 kristo@kernel.org,
 vkoul@kernel.org,
 okaya@kernel.org,
 agross@kernel.org,
 andersson@kernel.org,
 mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com,
 yuzenghui@huawei.com,
 shivamurthy.shastri@linutronix.de
Subject: [patch V4 04/21] irqchip/irq-msi-lib: Prepare for PCI MSI/MSIX
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:38 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Add the bus tokens for DOMAIN_BUS_PCI_DEVICE_MSI and
DOMAIN_BUS_PCI_DEVICE_MSIX to the common child init
function.

Provide the match mask which can be used by parent domain
implementation so the bitmask based child bus token match
works.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
v3: removed pci_device_msi_mask_unmask_parent_enable call as there is no
more global static key.
---
 drivers/irqchip/irq-msi-lib.c | 6 ++++++
 drivers/irqchip/irq-msi-lib.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index acbccf8f7f5b..0b359c5d8c6c 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -48,6 +48,12 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 
 	/* Is the target domain bus token supported? */
 	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_MSI)))
+			return false;
+
+		break;
 	default:
 		/*
 		 * This should never be reached. See
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
index f0706cc28264..525aa5284a99 100644
--- a/drivers/irqchip/irq-msi-lib.h
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -9,6 +9,12 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 
+#ifdef CONFIG_PCI_MSI
+#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
+#else
+#define MATCH_PCI_MSI		(0)
+#endif
+
 int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 			      enum irq_domain_bus_token bus_token);
 
-- 
2.34.1




