Return-Path: <linux-pci+bounces-35712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E5B49F5B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 04:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEDA17CB1F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 02:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4062248880;
	Tue,  9 Sep 2025 02:46:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BC1F790F;
	Tue,  9 Sep 2025 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386016; cv=none; b=aCK3LE3IrZPKtnIxreBpCwCoYBLYHZcwUb3WD+0yFMQjkbUPAhTXy5hUNibiaSu/zlv8HdnvwhaNy99BiCBK+cnVw+wu684969MOJQCvnlELyQ2uAjDPYcVvRQKhQDbO+rDO84XQM3s9dGbDTgUmhleoLhy3TRik2chhVYE1b4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386016; c=relaxed/simple;
	bh=GwLTDI9kp0MLkEOAPbnNI+ASeR21lSfwdNUGaRNVNqY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WS66bY+YeePTl+sCByx5LlxdfIW3WARK5xAFQy8+2WVazO0nxBTX+B2wJLl9tQn1oPr5f4d+nSLOiobUdcHM5JHjlP/i9iXvxAjkDw7REFFilcRAfHNbGE/H3IXuKEp2mo4d+j2grAYTocA6+fEw6rkr6KesobGkMio+y40+Xe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cLSqd5Mg4ztTdb;
	Tue,  9 Sep 2025 10:45:49 +0800 (CST)
Received: from kwepemh100012.china.huawei.com (unknown [7.202.181.97])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D9E8140147;
	Tue,  9 Sep 2025 10:46:45 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemh100012.china.huawei.com
 (7.202.181.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Sep
 2025 10:46:44 +0800
From: Wang ShaoBo <bobo.shaobowang@huawei.com>
To: <bhelgaas@google.com>, <helgaas@kernel.org>
CC: <leijitang@huawei.com>, <linux-hardening@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <christian.brauner@ubuntu.com>
Subject: [PATCH v2] PCI: Fix the int overflow in proc_bus_pci_write()
Date: Tue, 9 Sep 2025 10:46:43 +0800
Message-ID: <20250909024643.1017710-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemh100012.china.huawei.com (7.202.181.97)

Following testcase can trigger a softlockup BUG.
syscall(__NR_pwritev, /*fd=*/..., /*vec=*/..., /*vlen=*/...,
        /*pos_l=*/0x80010000, /*pos_h=*/0x100);

watchdog: BUG: soft lockup - CPU#19 stuck for 26s! [test:470]
Modules linked in:
CPU: 19 UID: 0 PID: 470 Comm: test Not tainted 6.17.0-rc4-00201-gd69eb204c255 #159 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:_raw_spin_unlock_irq+0xf/0x20
Code: 0f 1f 44 00 00 e9 51 18 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa c6 07 00 fb 65 ff 0d c1 78 35 010
RSP: 0018:ffffc900016b7d70 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000818d3878
RDX: 0000000000000cfc RSI: 0000000000000046 RDI: ffffffff835d76e8
RBP: ffff8880606c6000 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 00000000818d3878 R14: 0000000080010000 R15: ffff888020898d68
FS:  000000002472d880(0000) GS:ffff8880bbd9c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000218c3878 CR3: 00000000206ae000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 pci_user_write_config_dword+0x66/0xc0
 proc_bus_pci_write+0x135/0x240
 proc_reg_write+0x50/0x90
 vfs_writev+0x1d9/0x340
 ? getname_flags.part.0+0x20/0x1d0
 ? do_sys_openat2+0x88/0xd0
 do_pwritev+0x85/0xc0
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The pos_l parameter for pwritev syscall may be an integer negative value,
which will make the variable pos in proc_bus_pci_write() negative and
variable cnt a very large number.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/pci/proc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9348a0fb8084..2fc3340ff79e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -113,9 +113,9 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 {
 	struct inode *ino = file_inode(file);
 	struct pci_dev *dev = pde_data(ino);
-	int pos = *ppos;
-	int size = dev->cfg_size;
-	int cnt, ret;
+	unsigned int pos = *ppos;
+	unsigned int cnt, size = dev->cfg_size;
+	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
-- 
2.25.1


