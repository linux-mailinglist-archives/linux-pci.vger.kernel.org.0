Return-Path: <linux-pci+bounces-18459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEFD9F2452
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 15:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50C6165085
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733418E373;
	Sun, 15 Dec 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEjbkjJi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692D189905;
	Sun, 15 Dec 2024 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734272054; cv=none; b=M8MI+/yhy6rT7nua3gcmw/j3wjF17KsBnhJjTIezG7kAhFUPFBzQMujsMTNf8z+lq8atUjsG/BDrf7a6IgdhZ1OuWADUyoppQI6qK2p1A7PYdvABffZnvUpSsKH1A5VgZ7aeKVGnjlGzsxDTkNNtZIfcJsxMXDwN1zFhXL6sVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734272054; c=relaxed/simple;
	bh=8/npkK++v8XD3GPktkDpm6YIitVKsIUTk8iGph1pvfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QkS2Ic2UcLEMcgLNnq70pvBmSx4KdvJlrP3n+vRfSbU9aZEJf19dm5mJ2wrFm2lx06C/cSyuMbdKM8xM+YY5B11a1apNAM5Vh2VPT+jsqsQNkJ0lisC5ZvjmpoJeRNlOzJPblxfBTcYcfIJKAmkOK3vx+WE+OywrjkofH2zsft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEjbkjJi; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso2100378a91.0;
        Sun, 15 Dec 2024 06:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734272052; x=1734876852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9LsvqKWOporQY61apVbKBTly+yYgOeAnVkx2Qbcnreg=;
        b=OEjbkjJitz/NtTLLGFlDU0I7yYiZXKjpUJXh7+SgjANBydDgqgLb5Le+NtvyL9XxVq
         /xS39k9PIm96RRiWvJy8jGJjoLuC9w7h0Ox2FRmhz6kf330iZnn2CPGKy0PhCmeqfpK+
         CBy9KP336LEXwcJ1PrF0zeqq87lZQcHITzxtkdnln/0SyGW7agLA5yDZuICfPI73B3UA
         JeMzkZyG+cpVHZrELv7Kb803Mll8wuEvf34zFaBRH3H810VToXE6sXII6hlksBKtzCLA
         id3iV8dzryneDwjnC5nkQj0vvj1PpTtkURsXQm3FYyO+6eXAcfIiLN4uj4heNZ4oePFV
         TJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734272052; x=1734876852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LsvqKWOporQY61apVbKBTly+yYgOeAnVkx2Qbcnreg=;
        b=TmTGu2aZVVwWldyR3UQmWil6XkqXJVjc+zJLXd5+A691NQmheDXfBYsfe5inyAf90F
         +5g2U1KLCfrkbpOSii0e1xI8j232K7Qa6fbNoJ/iGkqG+FS/Fkc6tHa21N9bnyTbspRP
         R62x6PKKZyVBbcrdRAq2btUZjTX42Y+ir7XXoYucG5dTbWgFAYQug9AMQ/XD5e2DbMHe
         09AwHn9G/AvL3CL/se3Dnl7rlRsXcFlm+pxWVTNFZNJ/0OzYeDYvegafJqW0X0ytCX5O
         /hAU4InMeSL3cq/Ib+iO55N0bbzfi3o9ivsVWl2p9TbzLSshHpkU6L1gDzjqgwI3Pej7
         kpLA==
X-Forwarded-Encrypted: i=1; AJvYcCXjOjhY5W1GKcnuaPV+xQm9gCa+P28XwlytCVHkwpTBNHWrFvtkB6OO/+1soop0XFSMxHOax71miPLFTmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqY0QO6vdSivhQN4brBI9Efgjt61lIj90MCt8gfDtFRF8Kouj
	i5hujnuTvsd5p5usE9vq4A8dj4Ej6/6auXLF8C3jc/t1N+PXJHxG
X-Gm-Gg: ASbGncuki0IpsxxGtYzTVH7rw0pZ15SE8w13Rgw8VkQLkxeUcDsr/buDaaHC7Wo6ePq
	eUxnQoEx7b8sYwFQCIEKrUBkX1/k4Ixr/KM3hEzBte7oPUhFsP66oPCBy/Jg120zOPEmqtBVFF3
	5LyDSON4+w25tElT31HisCzgZ6yXvL9oK+k/jBnRvXPsy/WXHfyRr040qGMvJyQ4sBhK2Q4Dufz
	h8wq82yISNWT+cbKvzIHmtknRqOTFsxLbtb3EnfrZr+piM6o2qNoF+Txt0RCJMvPRjI80JnR5GN
	1az4dHAIEkt9E3uymfK692ZziZBiqQg4qUXXjSnOOMlVWIUf
X-Google-Smtp-Source: AGHT+IF0q+IRcOZ9CtJYH09ox5ZR3xLRy7+T7K2ySdfdihcsK4iWEgQ3Fy0GUjpfJMuf4KaMqao0tw==
X-Received: by 2002:a17:90b:5345:b0:2ee:fdf3:38dd with SMTP id 98e67ed59e1d1-2f28ffa7ea5mr11685579a91.23.1734272052017;
        Sun, 15 Dec 2024 06:14:12 -0800 (PST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp. [153.220.101.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e193sm6314823a91.32.2024.12.15.06.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 06:14:11 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH] PCI: vmd: Fix spinlock usage on config access for RT kernel
Date: Sun, 15 Dec 2024 23:13:21 +0900
Message-Id: <20241215141321.383144-1-ryotkkr98@gmail.com>
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


