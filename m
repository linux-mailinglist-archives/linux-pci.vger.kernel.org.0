Return-Path: <linux-pci+bounces-18748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3F19F723D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 02:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049DA16E83C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 01:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FCA74BED;
	Thu, 19 Dec 2024 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPCpJGQr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3443ACB;
	Thu, 19 Dec 2024 01:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572769; cv=none; b=jygak0eH0Cgdv0TI0IPrXgWVmNytjRGhDip3J8GPSBZJugnCcgJBFktT19Ul+iNnaokRuFAt6VKTGOdtWlb5HVnb+1BHtqVI6XgElGRCotRLnjWlHQ3S69fWkqRz87dZsF5jbEbIg3S/d8uncuV3Ez9rndbJIKUvVDAcGM60c+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572769; c=relaxed/simple;
	bh=oYOJjMIFg5BpCRg2I1jDh3pUiu15RQyTBfWflZJit3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bzbFORT0alWYO0rCb7GIkF8lPwmVnWadk6HZMJz9EvtI4d9x5VPhNVEMSEvPTk4fTSGzauD2BMMkHU0/Y/cyMYuDAtqxVuhUMfS41MOOYbz3boPml9T0T2faMOIHVG2Mm2iQKdzqQXguXCrLHZUQGWCS9GEmp72Op5JWjkHtK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPCpJGQr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso269009b3a.0;
        Wed, 18 Dec 2024 17:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734572767; x=1735177567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/V4emV4l6cudZlpyj3Y6hFQ96+b+ToXBuKhip6/MHhE=;
        b=iPCpJGQr1f0h4EmhQ+cSZ3QsHM/7lX2n/+RlDlndd4xeR93bYjfIP8SAeu/CQ/BhXO
         dN9AQW03JushPKcdESwjJ1y1hNRtcB8ZHnvLB1WmH5Zg6Schi4h3OXIhctXtHMg65vFs
         wfQGokS2vt+eDfUG05WdTvolEXIFzBgIaB41Ooxfyz3vCBeP6aaHqbDivHBzGik8KVFL
         MwuPRLQ/Vc8jRb3ya68FTYVGUO2wxZPKecOzsndru93EA4ALMi2AyiMCeqnoHss7Zc4Y
         SkI/3ZMwuhc5LJ/ykyF7rgzlyru4AV1uOdTxLaCrdHoAQ1WS/qtENgC8i66BXtQjFrag
         gH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572767; x=1735177567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/V4emV4l6cudZlpyj3Y6hFQ96+b+ToXBuKhip6/MHhE=;
        b=kBnNowHxrGpQr8/Popwn4o1ytLTbTlKojqtNzaBZISLZUATxMSFah6SBOvesICyNMV
         N+o8+2yDyfUANOPLIeZqFtPIyiqL2OvNfkKdahpPCp/jg5w23BtBT8LwW0mtiqFJJpdl
         PcgsFPVZSo/9lqElFkfA9gRbqMzAhZiBwQ0SAZV3ezyHBUV4qMV9ttwdpWvXhHDKqQKp
         txniH3MALI+ZHFZASL4o1fQfaUEJBmT8fMYiwOsUvwoHPt9C/FQxdGKXJkn9eR49S0rj
         GF8YjYT9l0LT7I/e/5byc7+qnl7dapgzWSxBaXX2zVdeKKEZY8KLJxc0aA9ouqJOAXuZ
         5DYw==
X-Forwarded-Encrypted: i=1; AJvYcCVhECYQlrSWNTvO+wI4Ke/hNHsEKzAWKQDtxkNmkDwceTPajMotl5dkhRg6GELzxI+O6Aafpp+dUKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKex+AlxcCEs8JN/8+Tn039K+CAttNP6qYQqw2KW0p3rXLK/fa
	ytHMqGYvxrCdJFiQJ8yQSGyLCtw2wwQqivZji9lQP5mfSqUnjt34
X-Gm-Gg: ASbGncvxdKmYMlcKjnKdrsqvS2SRaUaMJTaT0fjOR1B2Fx6cdN1zWbLxUlhN05tACLv
	vBLF948BhZmQR+5bboE9o1uxnWXXS13bCMDfd3CYpfywFmwrMReWfBlsHzPaXBEJsbxf5OcmYAR
	CS30cwGXAaGsuMY8ocKwtGCmT9/5pM3C5X1liDShu8HU9/3p2j8qNDKdLjnpKtSlXUIGPKfGh/W
	eRG2BkswhBmBBPRkyZMvbQKwhCmaZn3stxfOTG0Qu57MMR8jOxY+HoNbq+6+FI+xpVPklB+u3NL
	LEnfp8ytQ5bim0O4rHU1kZQjV00=
X-Google-Smtp-Source: AGHT+IFRMWufy3i+dmk6NjbcZlVTRLNYQkOXsjqD2911H9adqtY1RgcDA9k+ilfXh/wtINZaAuXqyg==
X-Received: by 2002:a05:6a00:8087:b0:725:1de3:1c4a with SMTP id d2e1a72fcca58-72aa8c9d93fmr2712074b3a.3.1734572766723;
        Wed, 18 Dec 2024 17:46:06 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90ba0asm127767b3a.172.2024.12.18.17.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:46:06 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: lgoncalv@redhat.com,
	bhelgaas@google.com,
	jonathan.derrick@linux.dev,
	kw@linux.com,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com,
	robh@kernel.org,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	kbusch@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v3] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Thu, 19 Dec 2024 10:45:49 +0900
Message-Id: <20241219014549.24427-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI config access is locked with pci_lock which is raw_spinlock.
Convert cfg_lock to raw_spinlock so that the lock usage is consistent
for RT kernel.

Reported as following:
[   18.756807] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[   18.756810] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1617, name: nodedev-init
[   18.756810] preempt_count: 1, expected: 0
[   18.756811] RCU nest depth: 0, expected: 0
[   18.756811] INFO: lockdep is turned off.
[   18.756812] irq event stamp: 0
[   18.756812] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   18.756815] hardirqs last disabled at (0): [<ffffffff864f1fe2>] copy_process+0xa62/0x2d90
[   18.756819] softirqs last  enabled at (0): [<ffffffff864f1fe2>] copy_process+0xa62/0x2d90
[   18.756820] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   18.756822] CPU: 3 UID: 0 PID: 1617 Comm: nodedev-init Tainted: G        W          6.12.1 #11
[   18.756823] Tainted: [W]=WARN
[   18.756824] Hardware name: Dell Inc. Vostro 3710/0K1D6X, BIOS 1.14.0 06/09/2023
[   18.756825] Call Trace:
[   18.756826]  <TASK>
[   18.756827]  dump_stack_lvl+0x9b/0xf0
[   18.756830]  dump_stack+0x10/0x20
[   18.756831]  __might_resched+0x158/0x230
[   18.756833]  rt_spin_lock+0x4e/0x130
[   18.756837]  ? vmd_pci_read+0x8d/0x100 [vmd]
[   18.756839]  vmd_pci_read+0x8d/0x100 [vmd]
[   18.756840]  pci_user_read_config_byte+0x6f/0xe0
[   18.756843]  pci_read_config+0xfe/0x290
[   18.756845]  sysfs_kf_bin_read+0x68/0x90
[   18.756847]  kernfs_fop_read_iter+0xd7/0x200
[   18.756850]  vfs_read+0x26d/0x360
[   18.756853]  ksys_read+0x70/0xf0
[   18.756855]  __x64_sys_read+0x1a/0x20
[   18.756857]  x64_sys_call+0x1715/0x20d0
[   18.756859]  do_syscall_64+0x8f/0x170
[   18.756861]  ? syscall_exit_to_user_mode+0xcd/0x2c0
[   18.756863]  ? do_syscall_64+0x9b/0x170
[   18.756865]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>

---

Hi!

This is same as the first version of the patch as discussed over v2.

v1:
https://lore.kernel.org/lkml/20241215141321.383144-1-ryotkkr98@gmail.com/T/

Changes since v2:
https://lore.kernel.org/lkml/20241218115951.83062-1-ryotkkr98@gmail.com/T/

- In case if CONFIG_PCI_LOCKLESS_CONFIG is set, vmd_pci_read/write()
  still neeed cfg_lock for their serialization. So instead of removing
  it, convert it to raw spinlock.

---
 drivers/pci/controller/vmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9d9596947..94ceec50a 100644
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
2.34.1


