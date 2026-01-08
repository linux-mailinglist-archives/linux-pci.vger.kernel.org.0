Return-Path: <linux-pci+bounces-44239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72391D008FB
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 02:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A4B7300EE5A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 01:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F77D1DDC37;
	Thu,  8 Jan 2026 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Vt+0NzpD"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275C4F881;
	Thu,  8 Jan 2026 01:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836075; cv=none; b=URpSfFHu6+MGOyLq5DtetcPKRqLqX7GPghbFb8pIyO4cbG8uVH+2eQEl3rMQFVUEiuCu2DqKSWQFh1mZuuy1x/zc9032upivkLWqN1up8nV3R4/m3ivt1xdNwi9P2OYaVp3FP5zb+SWdz3zLX7/B/kBUtB/FJ+8SegfWMwngp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836075; c=relaxed/simple;
	bh=WiQKRscTa3+3cW9ZmWM2gU4aRssj7qEoKyUkDxRRqr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZB0Kfqj/608fyKpMGOTirDwdn1swibJOV17qtmJAvK/pbp4hNPqmHEbQxQtYrSQx4/1viIgCvh+h4H5FxbSZOpnDHBcSqf10IbvNpcqh7ac+rTBax2O+DmbOJeC9p1nOfnNbTz0afEfrNWbRPiTp+wMPy2/4QzMIikDSKWI//oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Vt+0NzpD; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=N3npRfVhXRQF8DIOX87CwtMMwO0dhfCdVq9cgBpW9FE=;
	b=Vt+0NzpDL7Y/7N2epSYTxQpp/8zdFqf3Rr9DgvaI6vky8H71gt1HFRd9f2JS/86RIfhYy5dHT
	yF7K0fQUrnzlx5zgejbTmHbuVaQsHdB2BVLkDYeEDt42S7gdbIHFOiwpKp18G4AlPsslqlDzmG3
	51VCn08gwR7fHf4xz4n9RBs=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dmnRj6b5BzRhRS;
	Thu,  8 Jan 2026 09:31:13 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 0180040538;
	Thu,  8 Jan 2026 09:34:30 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 09:34:29 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v3 2/3] PCI: Prevent overflow in proc_bus_pci_write()
Date: Thu, 8 Jan 2026 09:59:43 +0800
Message-ID: <20260108015944.3520719-3-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108015944.3520719-1-duziming2@huawei.com>
References: <20260108015944.3520719-1-duziming2@huawei.com>
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

Fix this by using unsigned int for the pos.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/proc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9348a0fb8084..2d51b26edbe7 100644
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


