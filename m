Return-Path: <linux-pci+bounces-22712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC94A4AEAF
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 03:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E40216C910
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 02:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC1817591;
	Sun,  2 Mar 2025 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NAMSCCGL"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487255258;
	Sun,  2 Mar 2025 02:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740881059; cv=none; b=WGs+omir1v1StK075utBG4mzi65aMzDGlT3A7MoF49y2ccDvPUKqvGqE6ndRuVGn6wqD0xgHuAMROeUVohnvKzCi4+/4exqzmX0lPY2OeGsBny7OWpP0EckaAGzZtU4zE5cplIBYv2kyhSdjHjtt0lYVR4VxE43Kpp3/XxpfOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740881059; c=relaxed/simple;
	bh=0yXndCNsH9f8oLn41DENZOR0XdWB4ODrrFcC83BClxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sPBFUbVIGQ9VbFK934ZSPjSLZq5bZzUTj3MwbKNqe1SQrbJG4gM9wJHWlfU6WcRBpA7rEi7M6YAsd10JxYEfGkLWbwC2ivJ4P/R7ROlZl/C1YPeB0yric9RU7QQauMp9bs4wogFGJJDr/FKtGiYVFSLCUSnTYAxJaQ46561O+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NAMSCCGL; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qGexB
	0WEdkqPFWppHBpKIuAC5rAO6YhYQJoJifpTg3M=; b=NAMSCCGLBS+iQS0h/L5p8
	yh31KYj9CNVFM8Pg6GvlKt75Vhe9tszmWiANKkhNAGgvlyME8zDq7SR8wkpkBOtT
	nM/wSUI4k5HaGO1Xq3f9hyC5zgFPvATyikPkUX1IOh/0Rn5PrJVUOL5ZrqXBq2VQ
	ctHPE7k7sVYrmnSLhbGd4s=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBnAhRyvMNnh3tBPw--.17630S2;
	Sun, 02 Mar 2025 10:03:31 +0800 (CST)
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
	Hans Zhang <18255117159@163.com>,
	kernel test robot <lkp@intel.com>
Subject: [v3] genirq/msi: Add the address and data that show MSI/MSIX
Date: Sun,  2 Mar 2025 10:03:28 +0800
Message-Id: <20250302020328.296523-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnAhRyvMNnh3tBPw--.17630S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF45Ww4rAFyfKw47Ar43ZFb_yoWruF4DpF
	WjkF47Gr4xJr17tw47G3W7u345ta4qvF12y3srtw1fArZ0qw1kKFyvga12gr1ayF1jgw1F
	ya4UXa4kKrW5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_0eHDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiugEEo2fDtxFlRwAAs8

The debug_show() callback function is implemented in the MSI core code.
And assign it to the domain ops::debug_show() creation.

cat /sys/kernel/debug/irq/irqs/msi_irq_num, the address and data stored
in the MSI capability or the address and data stored in the MSIX vector
table will be displayed.

e.g.
root@root:/sys/kernel/debug/irq/irqs# cat /proc/interrupts | grep ITS
 85:          0          0          0          0          0          0          0          0          0          0          0          0   ITS-MSI 75497472 Edge      PCIe PME, aerdrv
 86:          0         30          0          0          0          0          0          0          0          0          0          0   ITS-MSI 76021760 Edge      nvme0q0
 87:        287          0          0          0          0          0          0          0          0          0          0          0   ITS-MSI 76021761 Edge      nvme0q1
 88:          0        265          0          0          0          0          0          0          0          0          0          0   ITS-MSI 76021762 Edge      nvme0q2
 89:          0          0        177          0          0          0          0          0          0          0          0          0   ITS-MSI 76021763 Edge      nvme0q3
 90:          0          0          0         76          0          0          0          0          0          0          0          0   ITS-MSI 76021764 Edge      nvme0q4
 91:          0          0          0          0        161          0          0          0          0          0          0          0   ITS-MSI 76021765 Edge      nvme0q5
 92:          0          0          0          0          0        991          0          0          0          0          0          0   ITS-MSI 76021766 Edge      nvme0q6
 93:          0          0          0          0          0          0        194          0          0          0          0          0   ITS-MSI 76021767 Edge      nvme0q7
 94:          0          0          0          0          0          0          0         94          0          0          0          0   ITS-MSI 76021768 Edge      nvme0q8
 95:          0          0          0          0          0          0          0          0        148          0          0          0   ITS-MSI 76021769 Edge      nvme0q9
 96:          0          0          0          0          0          0          0          0          0        261          0          0   ITS-MSI 76021770 Edge      nvme0q10
 97:          0          0          0          0          0          0          0          0          0          0        127          0   ITS-MSI 76021771 Edge      nvme0q11
 98:          0          0          0          0          0          0          0          0          0          0          0        317   ITS-MSI 76021772 Edge      nvme0q12
root@root:/sys/kernel/debug/irq/irqs#
root@root:/sys/kernel/debug/irq/irqs# cat 87
handler:  handle_fasteoi_irq
device:   0000:91:00.0
status:   0x00000000
istate:   0x00004000
ddepth:   0
wdepth:   0
dstate:   0x31600200
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_SINGLE_TARGET
            IRQD_AFFINITY_MANAGED
            IRQD_AFFINITY_ON_ACTIVATE
            IRQD_HANDLE_ENFORCE_IRQCTX
node:     0
affinity: 0
effectiv: 0
domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-3
 hwirq:   0x4880001
 chip:    ITS-MSI
  flags:   0x20
             IRQCHIP_ONESHOT_SAFE
 msix:
  address_hi: 0x00000000
  address_lo: 0x0e060040
  msg_data:   0x00000001
 parent:
    domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-5
     hwirq:   0x2002
     chip:    ITS
      flags:   0x0
     parent:
        domain:  :soc@0:interrupt-controller@0e001000-1
         hwirq:   0x2002
         chip:    GICv3
          flags:   0x15
                     IRQCHIP_SET_TYPE_MASKED
                     IRQCHIP_MASK_ON_SUSPEND
                     IRQCHIP_SKIP_SET_WAKE

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503020812.PKZf7JBa-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202503020807.c3MhmbJh-lkp@intel.com/
Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v2:
https://lore.kernel.org/linux-pci/20250301123953.291675-1-18255117159@163.com/

- Fix implicit declaration of function 'seq_printf'.
- Fix 'const struct irq_domain_ops' has no member named 'debug_show'.

Changes since v1:
https://lore.kernel.org/linux-pci/20250227162821.253020-1-18255117159@163.com/

- According to Thomas(tglx), the debug_show() callback should be added
  to the MSI core code.
---
 kernel/irq/msi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..b1c7fd3b8243 100644
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
@@ -756,12 +757,34 @@ static int msi_domain_translate(struct irq_domain *domain, struct irq_fwspec *fw
 	return info->ops->msi_translate(domain, fwspec, hwirq, type);
 }
 
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+static void msi_domain_debug_show(struct seq_file *m, struct irq_domain *d,
+				  struct irq_data *irqd, int ind)
+{
+	struct msi_desc *desc;
+	bool is_msix;
+
+	desc = irq_get_msi_desc(irqd->irq);
+	if (!desc)
+		return;
+
+	is_msix = desc->pci.msi_attrib.is_msix;
+	seq_printf(m, "%*s%s:", ind, "", is_msix ? "msix" : "msi");
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


