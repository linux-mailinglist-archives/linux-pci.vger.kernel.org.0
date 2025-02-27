Return-Path: <linux-pci+bounces-22579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB170A48540
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4B517D232
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23D1B982C;
	Thu, 27 Feb 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ViIgTwqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E461B0424;
	Thu, 27 Feb 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673794; cv=none; b=HAnKpwTr5a/r5fl4WNngiIy9EOozxMwl3oyyCes2ZcQNGYCehCpyz3VRpfICgdWpXll3o8uIaUPuj0Q71D9zMAATUq5Mi/x/RgO5CIzXV9RoKBOy7M30vncSAJ4BVkp9DhFg68MAYPFAwZNbHt1HV33jH0LnOabmoLoVKPStmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673794; c=relaxed/simple;
	bh=A4CTCMtqzteIMnkNZTip3GKEW+1+PgI9x/4aI8hqOM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K2PoxZTmIB0wc07MlnbS0g0XWMONUhv2MwjOCrlBxTIFzwb2fGm44nGln+njNs9OSxENCy6Qk6R2446mWgEFA8lZSWdmegLLIVTBh5mf5aT3XQCysqc+XC5vBBV8E1uVHERikLx4eO3FtAhOjf7uT3DLl4zMHlZBRMapKiXfaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ViIgTwqw; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8KKMS
	vcGBYzx/WXKXqtiTwnIOJ6axQoKyOMDp2Y1KoQ=; b=ViIgTwqwiY9YEpnHd/Mx/
	Ev+EpQW7nOalI2rlkw3uugm0w4SPZI6Ene9TsLJo6dTg2PTpwYBvjk9nS0CuWRKU
	kdzrpHN/B7ke2qtDdJ7+xy+elVHXse5+nRRJHYUpKotvJhIaEtQ4UqStkdqUhhJT
	4VCwDfAJ4y7hPstuh9nQbY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3d8SoksBnzyN4PA--.58111S2;
	Fri, 28 Feb 2025 00:28:24 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: tglx@linutronix.de
Cc: manivannan.sadhasivam@linaro.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] genirq/msi: Add the address and data that show MSI/MSIX
Date: Fri, 28 Feb 2025 00:28:21 +0800
Message-Id: <20250227162821.253020-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d8SoksBnzyN4PA--.58111S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWfWryftw4fCryUuFWrGrg_yoW8WFyrpr
	WDJF43Gr48Jw1jqw47uFnrur1UXF4vvayfGr45Xw1SkwnIgwnFyryDKayxG3W3tr4ru3WY
	y3Wqyw42krn8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEl1vDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxUBo2fAkBQ-OQAAsd

Add to view the addresses and data stored in the MSI capability or the
addresses and data stored in the MSIX vector table.

e.g.
root@root:/sys/bus/pci/devices/<dev>/msi_irqs# ls
86  87  88  89
root@root:/sys/bus/pci/devices/<dev>/msi_irqs# cat *
msix
 address_hi: 0x00000000
 address_lo: 0x0e060040
 msg_data: 0x00000000
msix
 address_hi: 0x00000000
 address_lo: 0x0e060040
 msg_data: 0x00000001
msix
 address_hi: 0x00000000
 address_lo: 0x0e060040
 msg_data: 0x00000002
msix
 address_hi: 0x00000000
 address_lo: 0x0e060040
 msg_data: 0x00000003

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 kernel/irq/msi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..a37a3e535fb8 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -503,8 +503,18 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 {
 	/* MSI vs. MSIX is per device not per interrupt */
 	bool is_msix = dev_is_pci(dev) ? to_pci_dev(dev)->msix_enabled : false;
+	struct msi_desc *desc;
+	u32 irq;
+
+	if (kstrtoint(attr->attr.name, 10, &irq) < 0)
+		return 0;
 
-	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
+	desc = irq_get_msi_desc(irq);
+	return sysfs_emit(
+		buf,
+		"%s\n address_hi: 0x%08x\n address_lo: 0x%08x\n msg_data: 0x%08x\n",
+		is_msix ? "msix" : "msi", desc->msg.address_hi,
+		desc->msg.address_lo, desc->msg.data);
 }
 
 static void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *desc)

base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
-- 
2.25.1


