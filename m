Return-Path: <linux-pci+bounces-10254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE72931369
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 13:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE531F23D88
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56252188CD9;
	Mon, 15 Jul 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc5dQVNh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32908143878
	for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2024 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044143; cv=none; b=jlI/x35al6J+tQcea25gBx5bTG8nMrp4t2ktDEWzEqsHIxQeHlqY1zZJwJWoPB3T7yndelm2q/VyFcXqrJs7fbVBjYU69DsYiYw7NEqAjvXWi0ouNlJUgaQoIGx9u40AIVlAa+RTBLSE2hZLjl4UVczIo0ATNijMINbLRZjS1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044143; c=relaxed/simple;
	bh=r2ieMZY0t9B54SYvvKjLt4MeM8xUd6cfPZGUgzxbNn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ka5nf89u43yfIe14rgWHP/xatHggBA2lGsXW70jsTawJCkcnuv7D+ljIdJKhKU/5/QA0SG5V6o/EJtcc6eF3VQzvq6rqRylbXfu4Pum9VcAJ5O02zusIh0utNzBo2JEFYlYRXZk9YEfj6oke5PHLYON4ors4+89VDks4CBeF2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc5dQVNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A51C4AF0E;
	Mon, 15 Jul 2024 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721044142;
	bh=r2ieMZY0t9B54SYvvKjLt4MeM8xUd6cfPZGUgzxbNn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bc5dQVNhD3YtuJRdD+xaqpyW8lWRStRcA/oL0c9wYaFW3LP2R3/VwS85r9TV7yy0L
	 Bwi2DBGZ1N5ZaE0gCOy3EmHlNxJuZbrr3Gvbr1PctkJhTgEQHL5502j0UmJOdHpwFm
	 FtLdHR8YvgKMZzFtKvokGod1erK+Acmxf7rgUDFa0qrhv/bzKkxiJjvWfiIgegVU3C
	 z1slCbIMS3jp3miSPg5l9o3MGvdd8azxOFcP/FHvQ85nvHJwp57hUZg9ImDTkF80Z2
	 8QWhR7TyvPLcG9Xi82nGOTk+vAMxFAk73ZXrknAyDrYvyVgvZI8KgrrYvzeN7ltE03
	 YKDKesuVhNEAw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 1/2] PCI: Add pci_remove_irq_domain() helper
Date: Mon, 15 Jul 2024 13:48:53 +0200
Message-ID: <20240715114854.4792-2-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240715114854.4792-1-kabel@kernel.org>
References: <20240715114854.4792-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a helper function pci_remove_irq_domain() for disposing all
interrupt mappings of an IRQ domain and then removing said IRQ domain.

As explained in the attached link, the PCI INTX interrupt may be shared,
and so the PCI device drivers do not dispose mapped interrupts when they
are unbound from a device, since other devices may be still using those
mapped interrupts. Thus the interrupts must be disposed by the PCI
controller driver when the IRQ domain is being removed.

This function may be used by PCI controller drivers that wish to be
removable / modular.

Link: https://lore.kernel.org/linux-pci/878qy5rrq7.ffs@tglx/
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/irq.c | 21 +++++++++++++++++++++
 drivers/pci/pci.h |  7 +++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
index 4555630be9ec..30c8d930016a 100644
--- a/drivers/pci/irq.c
+++ b/drivers/pci/irq.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/pci.h>
 
 #include "pci.h"
@@ -259,6 +260,26 @@ bool pci_check_and_unmask_intx(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
 
+#ifdef CONFIG_IRQ_DOMAIN
+/**
+ * pci_remove_irq_domain - dispose all IRQ mappings and remove IRQ domain
+ * @domain: the IRQ domain to be removed
+ *
+ * Disposes all IRQ mappings of a given IRQ domain before removing the domain.
+ */
+void pci_remove_irq_domain(struct irq_domain *domain)
+{
+	for (irq_hw_number_t i = 0; i < domain->hwirq_max; i++) {
+		unsigned int virq = irq_find_mapping(domain, i);
+
+		if (virq)
+			irq_dispose_mapping(virq);
+	}
+
+	irq_domain_remove(domain);
+}
+#endif
+
 /**
  * pcibios_penalize_isa_irq - penalize an ISA IRQ
  * @irq: ISA IRQ to penalize
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd44565c4756..1ba6a6f418ac 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -170,6 +170,13 @@ void pci_no_msi(void);
 static inline void pci_no_msi(void) { }
 #endif
 
+struct irq_domain;
+#ifdef CONFIG_IRQ_DOMAIN
+void pci_remove_irq_domain(struct irq_domain *domain);
+#else
+static inline void pci_remove_irq_domain(struct irq_domain *domain) { }
+#endif
+
 void pci_realloc_get_opt(char *);
 
 static inline int pci_no_d1d2(struct pci_dev *dev)
-- 
2.44.2


