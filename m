Return-Path: <linux-pci+bounces-35524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7D8B45545
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 12:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB3AB61A6F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6209E3019D2;
	Fri,  5 Sep 2025 10:47:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED431A54D;
	Fri,  5 Sep 2025 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069261; cv=none; b=GJn99C2aNdPDqiAUdWmYnel17TdSon15e1rtXp91yXiozESwSqipVDGIGftmJrUkf1hky+mkJ6TDzZCi1i3XahvItsy8I997RyobvEM9A9uqSXZmxAduPB0GoEPBUkFU6axsD9J/mI+koA5mqY4cXmu/NlFGUX2zcWUyxouq6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069261; c=relaxed/simple;
	bh=6mVlPIMDxjfP6B5qNGIno+UPsZ4bnt+4cfTqfW4op/s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uu8Rl8LW0Rap53AIW1Zauf1VMDp0FjZIkhGPD/POrFTAwDc9+UC0cfbbpgON0qB7X3xtbHcCkNWTDRw7fMg0/E7f1thCK38lNlaIj9uI/i+mUURt4f92vRb9kObsCKzkLpwSkKrE60M74X86lNpWK0xenIEuIKbSsHoQXVJnjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cJCkc16G9z3tZWP;
	Fri,  5 Sep 2025 18:48:40 +0800 (CST)
Received: from kwepemh100012.china.huawei.com (unknown [7.202.181.97])
	by mail.maildlp.com (Postfix) with ESMTPS id E0AC01A0188;
	Fri,  5 Sep 2025 18:47:31 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemh100012.china.huawei.com
 (7.202.181.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 5 Sep
 2025 18:47:31 +0800
From: Wang ShaoBo <bobo.shaobowang@huawei.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <leijitang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <christian.brauner@ubuntu.com>
Subject: [PATCH] PCI: Fix the int overflow in proc_bus_pci_write()
Date: Fri, 5 Sep 2025 18:47:30 +0800
Message-ID: <20250905104730.2833673-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemh100012.china.huawei.com (7.202.181.97)

Following testcase can trigger a softlockup BUG.
syscall(__NR_pwritev, /*fd=*/..., /*vec=*/..., /*vlen=*/...,
        /*pos_l=*/0x80010000, /*pos_h=*/0x100);

watchdog: BUG: soft lockup - CPU#11 stuck for 22s! [test:537]
Modules linked in:
CPU: 11 PID: 537 Comm: test Not tainted 5.10.0+ #67
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:pci_user_write_config_dword+0x67/0xc0
Code: 00 00 44 89 e2 48 8b 87 e0 00 00 00 48 8b 40 20 e8 9e 54 7e 00 48 c7 c7 20 48 a2 83 41 89 c0 c6 07 00 0f 1f 40 00 fb 45 85 c0 <7e> 12 41 8d 80 7f ff ff ff 41 b8 de ff ff ff 83 f8 08 76 0c 5b 44
RSP: 0018:ffffc900016c3d30 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888042058000 RCX: 0000000000000005
RDX: ffff888004058a00 RSI: 0000000000000046 RDI: ffffffff83a24820
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffff888005c25900 R11: 0000000000000000 R12: 0000000080c48680
R13: 0000000020c38684 R14: 0000000080010000 R15: ffff888004702408
FS:  000000003ae91880(0000) GS:ffff88801f380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020c00000 CR3: 0000000006f2c000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 proc_bus_pci_write+0x22c/0x260
 proc_reg_write+0x40/0x90
 do_loop_readv_writev.part.0+0x97/0xc0
 do_iter_write+0xf6/0x150
 vfs_writev+0x97/0x130
 ? files_cgroup_alloc_fd+0x5c/0x70
 ? do_sys_openat2+0x1c9/0x320
 __x64_sys_pwritev+0xb1/0x100
 do_syscall_64+0x2b/0x40
 entry_SYSCALL_64_after_hwframe+0x6c/0xd6

The pos_l parameter for pwritev syscall may be an integer negative value,
which will make the variable pos in proc_bus_pci_write() negative and
variable cnt a very large number.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/pci/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9348a0fb8084..ef7a33affb3b 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -121,7 +121,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	if (ret)
 		return ret;
 
-	if (pos >= size)
+	if (pos < 0 || pos >= size)
 		return 0;
 	if (nbytes >= size)
 		nbytes = size;
-- 
2.25.1


