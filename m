Return-Path: <linux-pci+bounces-22759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB390A4BFE8
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 13:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF8B87A37AF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB43204092;
	Mon,  3 Mar 2025 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BiUE35rv"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C041F542A;
	Mon,  3 Mar 2025 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003863; cv=none; b=jJNJECSQlKAsksUGVSpbKByD61CC+0fV0Y3K3YACwoVuPJkDu9sqlYlIAdmfdQ9e9eai37yp1DUvk43VQZZn6/DB+DZ7UBbhOYjYBJrSD4U6UEhgN75mKzvJRyhEIFCTZa2AsH7NL1eUU05RCQu/pDSg0Crd8f5SrTyGrFe9am0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003863; c=relaxed/simple;
	bh=b7aImQFO+vv4AEKqKZKWMgzQwLwslHy4AIvR8oe7et8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oGROunNhUDgVHUXnHm1GpMJvMlweXNxzweyTB/iMTjlY0A5IT7FV5yhZooSXZ1oXqN65iFt5bRsnA9lDlUu+lJKuBclt2PQxBsazahNzIOsYvRCrumMEmhopXV9Cy5t9dvdCCQjYhsbiSkoKKJdlWBnmowEg+8/fGoOrVyQ2d0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BiUE35rv; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xGRwi
	//d5mFSgNiOHp/4i7d4yZJCrVYLvCULn3+cKsg=; b=BiUE35rvVON2Dk1gnLPCS
	Kfr3GJYbaGs4bh4Hk2QuuSdzwq7QOt8kwhzX1x9G1TfK5utYuyo5DRcoeGb+iJrA
	Ox/4SjEK6woFve2fGRhNkzUS62ypj1aqoWaYWe+044LS4Kc6Q1mQZI+t8NYj2VoJ
	Gwdh+kt+aUVORXHDAOlSrc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAH3eEinMVni5QpPQ--.16783S2;
	Mon, 03 Mar 2025 20:10:12 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: tglx@linutronix.de
Cc: manivannan.sadhasivam@linaro.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	Frank.Li@nxp.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v4] genirq/msi: Add the address and data that show MSI/MSIX
Date: Mon,  3 Mar 2025 20:10:08 +0800
Message-Id: <20250303121008.309265-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH3eEinMVni5QpPQ--.16783S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF45Ww1fKrWDtryDZF43ZFb_yoW5KrWkpF
	Z0kF47Wr43Jr1UWa1xC3W7u345Ka95tF4Uu3s3uw1fArWDKryvyF1vgFW29FyayFyUKw1U
	A3ZFgF1DuFyDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE1CJDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwwFo2fFm0wbuQAAsy

The debug_show() callback function is implemented in the MSI core code.
And assign it to the domain ops::debug_show() creation.

When debugging MSI-related hardware issues (e.g., interrupt delivery
failures), developers currently need to either:
1. Recompile kernel with dynamic debug for tracing msi_desc.
2. Manually read device registers through low-level tools.

Both approaches become challenging in production environments where
dynamic debugging is often disabled.

This patch proposes to expose MSI address_hi/address_lo and msg_data in
`/sys/kernel/debug/irq/irqs/<msi_irq_num>`. These fields are critical to:
- Verify if MSI configuration matches hardware programming
- Diagnose interrupt routing errors (e.g., mismatched destination ID)
- Validate remapping behavior in virtualized environments

The information is already maintained in msi_desc and irq_data structures.
By surfacing it through debugfs:
- We create a unified place for runtime IRQ diagnostics
- Enable debugging without kernel rebuilds or special tools
- Align with existing exposure of IRQ chip/type/affinity data

Sample output:
  address_hi: 0x00000000
  address_lo: 0xfe670040
  msg_data:   0x00000001

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v2-v3:
https://lore.kernel.org/linux-pci/20250301123953.291675-1-18255117159@163.com/
https://lore.kernel.org/linux-pci/20250302020328.296523-1-18255117159@163.com/

- Fix implicit declaration of function 'seq_printf'.
- Fix 'const struct irq_domain_ops' has no member named 'debug_show'.
- The patch commit message were modified.
- Removes the display that is not currently an MSI/MSIX interrupt.

Changes since v1:
https://lore.kernel.org/linux-pci/20250227162821.253020-1-18255117159@163.com/

- According to Thomas(tglx), the debug_show() callback should be added
  to the MSI core code.
---
 kernel/irq/msi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..adcc7c638295 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -756,12 +757,30 @@ static int msi_domain_translate(struct irq_domain *domain, struct irq_fwspec *fw
 	return info->ops->msi_translate(domain, fwspec, hwirq, type);
 }
 
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+static void msi_domain_debug_show(struct seq_file *m, struct irq_domain *d,
+				  struct irq_data *irqd, int ind)
+{
+	struct msi_desc *desc = irq_get_msi_desc(irqd->irq);
+
+	if (!desc)
+		return;
+
+	seq_printf(m, "\n%*saddress_hi: 0x%08x", ind + 1, "", desc->msg.address_hi);
+	seq_printf(m, "\n%*saddress_lo: 0x%08x", ind + 1, "", desc->msg.address_lo);
+	seq_printf(m, "\n%*smsg_data:   0x%08x\n", ind + 1, "", desc->msg.data);
+}
+#endif
+
 static const struct irq_domain_ops msi_domain_ops = {
 	.alloc		= msi_domain_alloc,
 	.free		= msi_domain_free,
 	.activate	= msi_domain_activate,
 	.deactivate	= msi_domain_deactivate,
 	.translate	= msi_domain_translate,
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+	.debug_show     = msi_domain_debug_show,
+#endif
 };
 
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,

base-commit: 76544811c850a1f4c055aa182b513b7a843868ea
-- 
2.25.1


