Return-Path: <linux-pci+bounces-43103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B578CC186C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 09:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF5373052B10
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85CC349B17;
	Tue, 16 Dec 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xQ9kcjGK"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A53491E1;
	Tue, 16 Dec 2025 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872803; cv=none; b=ayarx8aR/46F2I+LoALWO2sClqwef28DEMK89QAMiUOw7vn7RgtiUCosonnkfYP6EgxCp0JDn9kqPb0jxUiHhvLDOKac0jjpdowa6PNidqC+9ZkesTNSg2XjsI3knw56wQHwnvynYchjoQjnSFu9OEArpQ6iSm7PTqiaTIabhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872803; c=relaxed/simple;
	bh=xl3Lvk6DsS/4aN4YNkfzslgnFtRwt/M8WdQ2kfOHli4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APL1eX45Nx7wvP31eKqDqKWva1vgBb6a15x+h2dI73Z5WqQ4dJph/df7aFWevqWuAZrbUsKXsvsW0VnkXsal14DCeqgym9Gnu0KeJZ/A30pwgnV9SvuT+JFESw6O4vjHDTqjnHS6Exm9c94hQVEi2N032isMK9C3SlyoXJZyKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xQ9kcjGK; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OeYwOcalkq3X/qIjdTsgXrAzZ7kaVzZIJdapxCDLH0c=;
	b=xQ9kcjGKMvWx2DdJMTh4U6pyUPKHTePf+WZoz4pZOR13QychGOQceFL9tv/NOJUk6pZUtd437
	1tm+qlFSsv1kud3i58UXvd1P/ZHv3f7GahETAJYcL4SNgoJkoCE6S5Kzx0MIwtf+W4lVphwMAyX
	hA34xV/yidzOwE5Rwp/xDaU=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dVqPz0YKqzLlWD;
	Tue, 16 Dec 2025 16:11:19 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id B9C071A016C;
	Tue, 16 Dec 2025 16:13:18 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Dec 2025 16:13:18 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chrisw@redhat.com>, <jbarnes@virtuousgeek.org>,
	<alex.williamson@redhat.com>, <liuyongqiang13@huawei.com>,
	<duziming2@huawei.com>
Subject: [PATCH 3/3] PCI: Prevent overflow in proc_bus_pci_write()
Date: Tue, 16 Dec 2025 16:39:12 +0800
Message-ID: <20251216083912.758219-4-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216083912.758219-1-duziming2@huawei.com>
References: <20251216083912.758219-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500012.china.huawei.com (7.202.195.23)

When the value of ppos over the INT_MAX, the pos will be
set a negtive value which will be pass to get_user() or
pci_user_write_config_dword(). And unexpected behavior
such as a softlock happens:

 watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
 Modules linked in:
 CPU: 0 PID: 3444 Comm: syz.3.109 Not tainted 6.6.0+ #33
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
 Code: cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 e8 52 12 00 00 90 fb 65 ff 0d b1 a1 86 6d <74> 05 e9 42 52 00 00 0f 1f 44 00 00 c3 cc cc cc cc 0f 1f 84 00 00
 RSP: 0018:ffff88816851fb50 EFLAGS: 00000246
 RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff927daf9b
 RDX: 0000000000000cfc RSI: 0000000000000046 RDI: ffffffff9a7c7400
 RBP: 00000000818bb9dc R08: 0000000000000001 R09: ffffed102d0a3f59
 R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
 R13: ffff888102220000 R14: ffffffff926d3b10 R15: 00000000210bbb5f
 FS:  00007ff2d4e56640(0000) GS:ffff8881f5c00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00000000210bbb5b CR3: 0000000147374002 CR4: 0000000000772ef0
 PKRU: 00000000
 Call Trace:
  <TASK>
  pci_user_write_config_dword+0x126/0x1f0
  ? __get_user_nocheck_8+0x20/0x20
  proc_bus_pci_write+0x273/0x470
  proc_reg_write+0x1b6/0x280
  do_iter_write+0x48e/0x790
  ? import_iovec+0x47/0x90
  vfs_writev+0x125/0x4a0
  ? futex_wake+0xed/0x500
  ? __pfx_vfs_writev+0x10/0x10
  ? userfaultfd_ioctl+0x131/0x1ae0
  ? userfaultfd_ioctl+0x131/0x1ae0
  ? do_futex+0x17e/0x220
  ? __pfx_do_futex+0x10/0x10
  ? __fget_files+0x193/0x2b0
  __x64_sys_pwritev+0x1e2/0x2a0
  ? __pfx___x64_sys_pwritev+0x10/0x10
  do_syscall_64+0x59/0x110
  entry_SYSCALL_64_after_hwframe+0x78/0xe2

Fix this by use unsigned int for the pos.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9348a0fb8084..dbec1d4209c9 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -113,7 +113,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 {
 	struct inode *ino = file_inode(file);
 	struct pci_dev *dev = pde_data(ino);
-	int pos = *ppos;
+	unsigned int pos = *ppos;
 	int size = dev->cfg_size;
 	int cnt, ret;
 
-- 
2.43.0


