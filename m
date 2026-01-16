Return-Path: <linux-pci+bounces-45023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2093D2D825
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 08:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26EC23013179
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90CD1C84B8;
	Fri, 16 Jan 2026 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lxVLbGGP"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8F2D5950;
	Fri, 16 Jan 2026 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549956; cv=none; b=qnUWNV+xJnqtLS5b4ZVvOxI+L6YQws7I/h1rJQo7aeTku7pIoANyS3QX96vvjFqpC5055PDeogXcsA2GGQpn/1dwUX+HUij8WrDIBGK1werD+W1Nu5qA/2WlsShqEgwjsSSyg5cfprvJ5xorKkIj9WNwoDQrIdo9VD8ASgtqiE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549956; c=relaxed/simple;
	bh=u92f1kbTpIdKtEEuVeYvX55xieu/6RBt+ks+eV0Jdcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+U3U3fLuG1zG7UY42PlTY3rBhqLTHpyjCg+4cpRucVJc7f/i9LwIP1poPbVCTSc8+9mDnYjt0HgV9UdxYcacgBZiQXJiisHZpIansLjnZ9hTvL/Ec1RWCWs9t1aZmyez66t4YK5RdMLDGD095NvkR6yQRqrog1YO5DKrxAnPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lxVLbGGP; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3vxAPAMjiZnbkDd7gTIpK7c4P2xbFpz++FhONFEcjcg=;
	b=lxVLbGGPAJ1Q2ZkMqwn2Y1+76UEq84emQlyR5k6Tibxp037a6+mhKCE9ZMUIMpZW0/IphQZ/m
	rkSJ+P5k+TONPtt/biXHy0wmfXqyoMycqT4mZ4EPT3P5aWUrq2uZcuuqyhRf/Lgl5wqIWmWNmjW
	DeDZ6zJAPAu3uMux3SUeh8c=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dssRx3nFwzmVWy;
	Fri, 16 Jan 2026 15:49:01 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id DC4684055B;
	Fri, 16 Jan 2026 15:52:22 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Jan 2026 15:52:22 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <alex@shazbot.org>, <chrisw@redhat.com>,
	<jbarnes@virtuousgeek.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>
Subject: [PATCH v4 1/4] PCI/sysfs: Prohibit unaligned access to I/O port
Date: Fri, 16 Jan 2026 16:17:18 +0800
Message-ID: <20260116081723.1603603-2-duziming2@huawei.com>
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

Unaligned access is harmful for non-x86 archs such as arm64. When we
use pwrite or pread to access the I/O port resources with unaligned
offset, system will crash as follows:

Unable to handle kernel paging request at virtual address fffffbfffe8010c1
Internal error: Oops: 0000000096000061 [#1] SMP
Call trace:
 _outw include/asm-generic/io.h:594 [inline]
 logic_outw+0x54/0x218 lib/logic_pio.c:305
 pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
 pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
 pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
 sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
 kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
 vfs_write+0x7bc/0xac8 fs/read_write.c:586
 ksys_write+0x12c/0x270 fs/read_write.c:639
 __arm64_sys_write+0x78/0xb8 fs/read_write.c:648

Although x86 might handle unaligned I/O accesses by splitting cycles,
this approach is still limited because PCI device registers typically
expect natural alignment. A global prohibition of unaligned accesses
ensures consistent behavior across all architectures and prevents
unexpected hardware side effects.

Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port resources")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Signed-off-by: Ziming Du <duziming2@huawei.com>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c2df915ad2d29..18e5d4603b472 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/aperture.h>
 #include <linux/unaligned.h>
+#include <linux/align.h>
 #include "pci.h"
 
 #ifndef ARCH_PCI_DEV_GROUPS
@@ -1166,12 +1167,16 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 			*(u8 *)buf = inb(port);
 		return 1;
 	case 2:
+		if (!IS_ALIGNED(port, count))
+			return -EINVAL;
 		if (write)
 			outw(*(u16 *)buf, port);
 		else
 			*(u16 *)buf = inw(port);
 		return 2;
 	case 4:
+		if (!IS_ALIGNED(port, count))
+			return -EINVAL;
 		if (write)
 			outl(*(u32 *)buf, port);
 		else
-- 
2.43.0


