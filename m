Return-Path: <linux-pci+bounces-44242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A9DD00907
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 02:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2BC7304A93F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 01:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A10224249;
	Thu,  8 Jan 2026 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MGUri89d"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30B228CB8;
	Thu,  8 Jan 2026 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836082; cv=none; b=JB96ybT8DbyGH1ULClzxNWj5RNOECbrwtKshmQxZ+TinkNgM3JGimMYcUAPGFZmc+4MhTPpxwfH8ZJED3FBgwMo1QE1eL9NKUdUbmQDk/n26r6FGAdaotoItzzzq2XUr7j7IWMKXHejeI8jEyhPMQFfLgvchU4S0zRvSI1OMv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836082; c=relaxed/simple;
	bh=KOkz3kBXR1AOxj5d2DWLCyUG8LTzFoNgD0ueSEz5crM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXOs71oKR2BOJkzzgV1Q5Hkk3U1BBeTKw7WVinBN9QQw0kJAiQ2+R+a50yDn+zMFfFALJKt33Dk1yXzUVFIyVZY8L+RSpJHOzushS7I9zIpCQ31dVoTOx2uH0J1eG2pPNcyJyVclBLbTFkVwJ9UF20YC4bM6WOr4u+1mjVLDXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MGUri89d; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VJtMqKEIPPguPZMN5Ybem/NDDQKThnVR4N7EDyWD6oQ=;
	b=MGUri89dIU7W+g2XFhY0h9bRNF1uWRSfJR8nmlmHTNNlpsEuM1UH0qc8F+w5F3qBYyw2xzbuD
	oaS/dn/F3FtANWIRGpXVasXO5pCjioAcx91KRnqcByC9CHKvDkr+BVHSFtdq2iwElFWujfKLrFJ
	2AgZ+yykdHHMlBOMFyXsR5k=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dmnRy38Z6znTX0;
	Thu,  8 Jan 2026 09:31:26 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 522594055B;
	Thu,  8 Jan 2026 09:34:30 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 09:34:29 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v3 3/3] PCI/sysfs: Prohibit unaligned access to I/O port on non-x86
Date: Thu, 8 Jan 2026 09:59:44 +0800
Message-ID: <20260108015944.3520719-4-duziming2@huawei.com>
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

Powerpc seems affected as well, so prohibit the unaligned access
on non-x86 archs.

Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port resources")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/pci-sysfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7e697b82c5e1..11d8b7ec4263 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/aperture.h>
 #include <linux/unaligned.h>
+#include <linux/align.h>
 #include "pci.h"
 
 #ifndef ARCH_PCI_DEV_GROUPS
@@ -1166,12 +1167,20 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 			*(u8 *)buf = inb(port);
 		return 1;
 	case 2:
+		#if !defined(CONFIG_X86)
+			if (!IS_ALIGNED(port, count))
+				return -EFAULT;
+		#endif
 		if (write)
 			outw(*(u16 *)buf, port);
 		else
 			*(u16 *)buf = inw(port);
 		return 2;
 	case 4:
+		#if !defined(CONFIG_X86)
+			if (!IS_ALIGNED(port, count))
+				return -EFAULT;
+		#endif
 		if (write)
 			outl(*(u32 *)buf, port);
 		else
-- 
2.43.0


