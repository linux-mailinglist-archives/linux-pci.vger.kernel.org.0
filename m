Return-Path: <linux-pci+bounces-22700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C43AA4AAFA
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 13:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102B3170AAB
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F21DE890;
	Sat,  1 Mar 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TuayS3Q0"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172051DC9B8;
	Sat,  1 Mar 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740832882; cv=none; b=OLncte9vXqpsgjKMishGWOJxc9V6rcxJPiP+wPUQkskrGoWTrVKK4pI1mJ3wts7dPcX3398EvV14HhVscGSHFlW1cHhw1cP4B878N5jFlFUrBQBvgISHMIBIUzpUpm5Fj6AFJLiP2tZxbnfKBxT087MzWmbdsgB6rf1e4rVxXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740832882; c=relaxed/simple;
	bh=fH8zFdJMTFhGVX0V/1Yw10rbmIh+sDhnt/L2hdG9Swk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AoV14r/3iyYlUkwn/0cTQOMtGhx7gR4VT0p/pW+aX2CLs1dTHrW8yUUMZ5dCmy3/9tEDqjqd1zNJOGFkK/2RuT5rGiF2M/xNL6Wt3I7plz/ZVwUgHcFL37TFsPUnvwMelPGhryPCiGPpsTYqWflUbZ/g2g50mxkGb2seceA81Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TuayS3Q0; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+qSBU
	FwKZK//BSLhdYUxhoKJBzrOrxn+r2oFPLui4bw=; b=TuayS3Q07Z/s/yQ5jxuXQ
	jE1uu5qTf2xi82VAmCftDIQcjMelsYSOmlmwT7FqtNai7ZmNPY90023WRwRqTqdc
	VtlEvSDrLDLJQq3mHE9/Y5rPmKPYEli6Hq6iSkBFc0hjPnlA67VKKLenvLCNwxhY
	xVrEXUqf049pzFFJO8MNGk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD379A7AMNnbQlkOw--.37453S2;
	Sat, 01 Mar 2025 20:40:28 +0800 (CST)
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
Subject: [v2] genirq/msi: Add the address and data that show MSI/MSIX
Date: Sat,  1 Mar 2025 20:39:53 +0800
Message-Id: <20250301123953.291675-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD379A7AMNnbQlkOw--.37453S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF45Ww4rAFyfKw47Ar43ZFb_yoWrJw4rpF
	yUKF47Gr4xJr1Utw47G3WUW34Yya4qyF17t3sFqr1fArZ5Ww1kKFyjgay2gF13tF1jqr1F
	y3W8Xa4FgrZ8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_NtxDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiugMDo2fC92OKywAAsp

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

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v1:
https://lore.kernel.org/linux-pci/20250227162821.253020-1-18255117159@163.com/

- According to Thomas(tglx), the debug_show() callback should be added
  to the MSI core code.
---
 kernel/irq/msi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..7dc786360172 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -756,12 +756,30 @@ static int msi_domain_translate(struct irq_domain *domain, struct irq_fwspec *fw
 	return info->ops->msi_translate(domain, fwspec, hwirq, type);
 }
 
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
+
 static const struct irq_domain_ops msi_domain_ops = {
 	.alloc		= msi_domain_alloc,
 	.free		= msi_domain_free,
 	.activate	= msi_domain_activate,
 	.deactivate	= msi_domain_deactivate,
 	.translate	= msi_domain_translate,
+	.debug_show     = msi_domain_debug_show,
 };
 
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,

base-commit: 76544811c850a1f4c055aa182b513b7a843868ea
-- 
2.25.1


