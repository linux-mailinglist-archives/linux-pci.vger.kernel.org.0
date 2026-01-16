Return-Path: <linux-pci+bounces-45020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04145D2D815
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 08:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B0E33009231
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B677285CAD;
	Fri, 16 Jan 2026 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2hBsRfUj"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743B1C84B8;
	Fri, 16 Jan 2026 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549948; cv=none; b=kCui+eL78hz6ot2mby6L4dYx0+t604gHdbrdj8c+RXmn+REDzyYOWv/MyaZK8fwjb/yhtt8ky0HhbC3rcn/a1a7FhjlxSp/VzPPkRe0+WuXvcgRH4rCITORuHRyiusfJgOT+lKOOc/k7BNFgYJVHseYCZEms0Q2LUEt3rEDfpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549948; c=relaxed/simple;
	bh=nm0eA/yDztL9ix7zhcM5v7OQgf1tHidKRps0ydXnkLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlGdHj9HiYCXtkg8We73aPn58YWRt6Fq4TjOfOcyXHoHO003XXguSTeSbSbePomDMduPA+KEyMv2ew3beircEUUillnuWCZb9svti+shw45+9mZ6mhn22h+6MRE6hvN80gtGxwTR+Em7+qaYXdML+Qc5R9JuaaQrQQ55gP19RF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2hBsRfUj; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Xdx1CNYDh2ae1MTXHIUWs+/1UyQlOBpJoTdTAzXNXzY=;
	b=2hBsRfUj4YVCi0IoVG9f60uhEKZg4gCKaBMtZz3lhUUOtKuB5LtvLqs8guMXtBaR3zxxXGU/7
	7WcSb8xhiA9fNl+eG8b9dOzYKjC3oHHiRDaFzAlVeM/TVIs+RrANWKdjgu5IwiUg9G4RTD2vjLi
	ZIiV73sb3Q76fKBd7XX7dPM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dssSN3bnnz12LJH;
	Fri, 16 Jan 2026 15:49:24 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 96ACE404AD;
	Fri, 16 Jan 2026 15:52:23 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Jan 2026 15:52:23 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <alex@shazbot.org>, <chrisw@redhat.com>,
	<jbarnes@virtuousgeek.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>
Subject: [PATCH v4 3/4] PCI: Prevent overflow in proc_bus_pci_write()
Date: Fri, 16 Jan 2026 16:17:20 +0800
Message-ID: <20260116081723.1603603-4-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116081723.1603603-1-duziming2@huawei.com>
References: <20260116081723.1603603-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500012.china.huawei.com (7.202.195.23)

From: Yongqiang Liu <liuyongqiang13@huawei.com>

When the value of *ppos over the INT_MAX, the pos is over set to a
negative value which will be passed to get_user() or
pci_user_write_config_dword(). Unexpected behavior such as a soft lockup
will happen as follows:

 watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
 RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
 Call Trace:
  <TASK>
  pci_user_write_config_dword+0x126/0x1f0
  proc_bus_pci_write+0x273/0x470
  proc_reg_write+0x1b6/0x280
  do_iter_write+0x48e/0x790
  vfs_writev+0x125/0x4a0
  __x64_sys_pwritev+0x1e2/0x2a0
  do_syscall_64+0x59/0x110
  entry_SYSCALL_64_after_hwframe+0x78/0xe2

Fix this by adding a non-negative check before assign *ppos to pos.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Signed-off-by: Ziming Du <duziming2@huawei.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/proc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9348a0fb80847..2d51b26edbe74 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -113,10 +113,14 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 {
 	struct inode *ino = file_inode(file);
 	struct pci_dev *dev = pde_data(ino);
-	int pos = *ppos;
+	int pos;
 	int size = dev->cfg_size;
 	int cnt, ret;
 
+	if (*ppos > INT_MAX)
+		return -EINVAL;
+	pos = *ppos;
+
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
 		return ret;
-- 
2.43.0


