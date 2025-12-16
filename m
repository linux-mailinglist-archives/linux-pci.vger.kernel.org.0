Return-Path: <linux-pci+bounces-43104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1B0CC18BE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 09:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06B46307D457
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 08:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8C34A3CD;
	Tue, 16 Dec 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dSZ4pUwR"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005253396E6;
	Tue, 16 Dec 2025 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872804; cv=none; b=Ux/wBPge2v8UwFKsJ89l2CTbf4Hnbe5vRY1r61M2QtE1cOPFjWEiZcp5D3c7YF3F47IrRUvMzo9hRiiHHznI4ekHomkwnO3pwC7JqUtf4H+FMFxZP5sLhGZtC9RtT96sTK71VwnM+PyB+OF0nl7I82YSh51iM0HfRubKFacPF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872804; c=relaxed/simple;
	bh=wzNfrMznYfIxFRzv7t8rOb83igwXFEhzsVvHJ6bhp/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsUT2VXrJ5QQqijBcv+lx9BnLPhvplFaxS39fJlzkhRd9HNRnipaW9p1XW6vX5n3TABmzTR2F43PnoKQb56S0eenKFVnBtTDVEMI4/JBN4vnGMVjUT+ddYLHjJWnRMhdhfICsKYBAVhR7oXDx+XXrQ3y5opmloY63rrfEvcSbbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dSZ4pUwR; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i4pBlUvu9eAYZ9wvnIMycmlVw5ryVXRu/Fa9NgFdJp4=;
	b=dSZ4pUwRjoOurpG8aLxHgli4vqTkfLCCwPpR5nnH7QIp4gNKBt46dM6/kD1l6SBz93V4RA9LF
	m9NCp6oSXTq/qeZ45FOY+ag0Kx8Pn4WMaXg4GbITvQaRpNscJDdb2Z6A8P19M3hB2P0nmVzUK7r
	eACabNV6AKbFTK1iVUJPVLU=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dVqPy1N9fzmV69;
	Tue, 16 Dec 2025 16:11:18 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A1041800B2;
	Tue, 16 Dec 2025 16:13:18 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Dec 2025 16:13:17 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chrisw@redhat.com>, <jbarnes@virtuousgeek.org>,
	<alex.williamson@redhat.com>, <liuyongqiang13@huawei.com>,
	<duziming2@huawei.com>
Subject: [PATCH 2/3] PCI/sysfs: Prohibit unaligned access to I/O port on non-x86
Date: Tue, 16 Dec 2025 16:39:11 +0800
Message-ID: <20251216083912.758219-3-duziming2@huawei.com>
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

From: Yongqiang Liu <liuyongqiang13@huawei.com>

Unaligned access is harmful for non-x86 archs such as arm64. When we
use pwrite or pread to access the I/O port resources with unaligned
offset, system will crash as follows:

Unable to handle kernel paging request at virtual address fffffbfffe8010c1
Internal error: Oops: 0000000096000061 [#1] SMP
Modules linked in:
CPU: 1 PID: 44230 Comm: syz.1.10955 Not tainted 6.6.0+ #1
Hardware name: linux,dummy-virt (DT)
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __raw_writew arch/arm64/include/asm/io.h:33 [inline]
pc : _outw include/asm-generic/io.h:594 [inline]
pc : logic_outw+0x54/0x218 lib/logic_pio.c:305
lr : _outw include/asm-generic/io.h:593 [inline]
lr : logic_outw+0x40/0x218 lib/logic_pio.c:305
sp : ffff800083097a30
x29: ffff800083097a30 x28: ffffba71ba86e130 x27: 1ffff00010612f93
x26: ffff3bae63b3a420 x25: ffffba71bbf585d0 x24: 0000000000005ac1
x23: 00000000000010c1 x22: ffff3baf0deb6488 x21: 0000000000000002
x20: 00000000000010c1 x19: 0000000000ffbffe x18: 0000000000000000
x17: 0000000000000000 x16: ffffba71b9f44b48 x15: 00000000200002c0
x14: 0000000000000000 x13: 0000000000000000 x12: ffff6775ca80451f
x11: 1fffe775ca80451e x10: ffff6775ca80451e x9 : ffffba71bb78cf2c
x8 : 0000988a357fbae2 x7 : ffff3bae540228f7 x6 : 0000000000000001
x5 : 1fffe775e2b43c78 x4 : dfff800000000000 x3 : ffffba71b9a00000
x2 : ffff80008d22a000 x1 : ffffc58ec6600000 x0 : fffffbfffe8010c1
Call trace:
 _outw include/asm-generic/io.h:594 [inline]
 logic_outw+0x54/0x218 lib/logic_pio.c:305
 pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
 pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
 pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
 sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
 kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
 call_write_iter include/linux/fs.h:2085 [inline]
 new_sync_write fs/read_write.c:493 [inline]
 vfs_write+0x7bc/0xac8 fs/read_write.c:586
 ksys_write+0x12c/0x270 fs/read_write.c:639
 __do_sys_write fs/read_write.c:651 [inline]
 __se_sys_write fs/read_write.c:648 [inline]
 __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x8c/0x2e0 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0x200/0x2a8 arch/arm64/kernel/syscall.c:134
 do_el0_svc+0x4c/0x70 arch/arm64/kernel/syscall.c:176
 el0_svc+0x44/0x1d8 arch/arm64/kernel/entry-common.c:806
 el0t_64_sync_handler+0x100/0x130 arch/arm64/kernel/entry-common.c:844
 el0t_64_sync+0x3c8/0x3d0 arch/arm64/kernel/entry.S:757

Powerpc seems affected as well, so prohibit the unaligned access
on non-x86 archs.

Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port resources")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/pci-sysfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7e697b82c5e1..6fa3c9d0e97e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1141,6 +1141,13 @@ static int pci_mmap_resource_wc(struct file *filp, struct kobject *kobj,
 	return pci_mmap_resource(kobj, attr, vma, 1);
 }
 
+#if !defined(CONFIG_X86)
+static bool is_unaligned(unsigned long port, size_t size)
+{
+	return port & (size - 1);
+}
+#endif
+
 static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 			       const struct bin_attribute *attr, char *buf,
 			       loff_t off, size_t count, bool write)
@@ -1158,6 +1165,11 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 	if (port + count - 1 > pci_resource_end(pdev, bar))
 		return -EINVAL;
 
+#if !defined(CONFIG_X86)
+	if (is_unaligned(port, count))
+		return -EFAULT;
+#endif
+
 	switch (count) {
 	case 1:
 		if (write)
-- 
2.43.0


