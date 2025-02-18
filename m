Return-Path: <linux-pci+bounces-21693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3790A39481
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 09:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96B9188E648
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 08:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8740A22ACDF;
	Tue, 18 Feb 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jMGJH8EO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f823kVnD"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE851FECAD;
	Tue, 18 Feb 2025 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866115; cv=none; b=qSx5LkUO8ottl/sUumM0wb/3AMP/2X6mzGCoX2zf3EmN6ttxx0a1MUNxaLXsRxKv4ZFo65vcX0+iT2op8PPD5oKtHptlcG+aysR3nUYOc6vxEyRbSLvQIBmbotf7FwJmPRr0zjbh7AXP1stacJQmh4TVUILAZ1uBDQwfLm+9I38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866115; c=relaxed/simple;
	bh=orDzLkwxxmZku6wVu6MWQ3PRke6ypVUHnZHrMOBzOLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lptMyCKoGiLL+QS7LYaMRXsD7RVK5eLngv0SO6i4MfhaUnM6p9blh/jUY/ssLL8GW/lghYOuB6HFzhCXS8qXJV8MZkTOtcXsdVR+VVN3WGjGIwtX4QuMB7X3eu9t0d69SslMw+XKoA5d8A1Vg86dq9aaW4uTqyAiNX3VvgmC/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jMGJH8EO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f823kVnD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:08:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739866112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dEKMkFQ226y7BsR107Y6b8ik0je808/giBqUAnajokg=;
	b=jMGJH8EOTwScyiUCIN7f1AHGSwMSZ0hXRdqOqr8+BPTbpB767BLktAnOg0F4DDVawkldOy
	qLVzm7gGgMQoyhfmeKPa/0Lh7FsK/LQenxJWpOvOCCpqZiUUTSsxiZNT/7VH1Q7jzamCK3
	K4eBn1Njdx1ZpB2OCNW3BH3mXupeVLgUhS3FX/8ix8KBTOol/ntQDKe9NqwepN0/XNb63C
	dhqqRmAPRNZ4HwrvGsPkvG9oHd4N6vt1NQRBhmPZDEPnQmCN5eMw2nqXOypoTNM0fs0VdG
	nQk5SG0e9ZF5oUbU91eeZNeVnpc+wJ4ejs0NAzbbWCpXS72uUnDaolp8wSP9hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739866112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dEKMkFQ226y7BsR107Y6b8ik0je808/giBqUAnajokg=;
	b=f823kVnD1vdU3RviK6D0LME4UW+0w0HIHKPVTIurwPL19QEFw5ao6uiatvTadc+ImMLHbk
	VydVOBb89hepIFCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-pci@vger.kernel.org
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ryo Takakura <ryotkkr98@gmail.com>, bhelgaas@google.com,
	jonathan.derrick@linux.dev, kw@linux.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, nirmal.patel@linux.intel.com,
	robh@kernel.org, rostedt@goodmis.org, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: [PATCH v4] PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t.
Message-ID: <20250218080830.ufw3IgyX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From: Ryo Takakura <ryotkkr98@gmail.com>

The access to the PCI config space via pci_ops::read and pci_ops::write
is a low-level hardware access. The functions can be accessed with
disabled interrupts even on PREEMPT_RT. The pci_lock has been made a
raw_spinlock_t for this purpose. A spinlock_t becomes a sleeping lock on
PREEMPT_RT can not be acquired with disabled interrupts.
The vmd_dev::cfg_lock is accessed in the same context as the pci_lock.

Make vmd_dev::cfg_lock a raw_spinlock_t.

[bigeasy: Reword commit message.]

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Acked-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Changes since v3 https://lore.kernel.org/all/20241219014549.24427-1-ryotkkr98@gmail.com/
- Repost with updated changelog.

Changes since v2 https://lore.kernel.org/lkml/20241218115951.83062-1-ryotkkr98@gmail.com/
- In case if CONFIG_PCI_LOCKLESS_CONFIG is set, vmd_pci_read/write()
  still neeed cfg_lock for their serialization. So instead of removing
  it, convert it to raw spinlock.

v1: https://lore.kernel.org/lkml/20241215141321.383144-1-ryotkkr98@gmail.com/

 drivers/pci/controller/vmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9d9596947350f..94ceec50a2b94 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -125,7 +125,7 @@ struct vmd_irq_list {
 struct vmd_dev {
 	struct pci_dev		*dev;
 
-	spinlock_t		cfg_lock;
+	raw_spinlock_t		cfg_lock;
 	void __iomem		*cfgbar;
 
 	int msix_count;
@@ -391,7 +391,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		*value = readb(addr);
@@ -406,7 +406,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -426,7 +426,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		writeb(value, addr);
@@ -444,7 +444,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -1009,7 +1009,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	spin_lock_init(&vmd->cfg_lock);
+	raw_spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
 	if (err)
-- 
2.47.2


