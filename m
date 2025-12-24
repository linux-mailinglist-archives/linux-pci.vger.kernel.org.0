Return-Path: <linux-pci+bounces-43650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB953CDBBC0
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 10:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0014C302E169
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9EA32E738;
	Wed, 24 Dec 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cGENi2Rd"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5380314A7B;
	Wed, 24 Dec 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766566908; cv=none; b=iMbLwPGLV0BPv4MXgc2IfjFJIpwys1K3hjKhMNPuxwREKiOmPsPfB0Z/7lkqPK1k8As2cKmeYhBwkVkh76WtB0zSoN4Sf2SHPer8kLbyDgmXf99947ZZTlW6WHaLQNkgW4J+NAGuiy5qhMWVz9nryotpHhOprJH7o5XICXZxMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766566908; c=relaxed/simple;
	bh=gqGNglFqxB3NK3YoIJJNhmr0t9roIe6C3Tobjiu1Wuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsVvssUPYM4ygqGMU7UvQzd8ZMJGtgjaQPALKfnnmXqiyDA7UUiee6Iq2Mmmb3Rth3NbSqNaKC6Sy+2v+13F2TJGEr1m1Qt569mOzvmg1dz8NmWI5jSBtuY2IlXCYiTJ0pXvcyA8VFN12gfVvAKagAK+hbbe4yESskMZaYvhqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cGENi2Rd; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LeSG1t0UVv0W2wY0c6r0HUfGpaiRuahJotWBLjChAX0=;
	b=cGENi2RdKsGfAjgQzI/qRsR4kLwubIFqM4UzlUg0HXyGbAuydOe6smIAHBsTf1m84u6ywx7vG
	/OlNtvQYdHawUsD0Rj/udhvMlQ30uBSf6lZHX30R9kL0+x8cStfRLjeey+JFmxDuqkeZBzdalOj
	PkqP8PyYZSfqfdOZBjB5TJs=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dbm4j45TlznTZQ;
	Wed, 24 Dec 2025 16:58:29 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id EF9974056E;
	Wed, 24 Dec 2025 17:01:41 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Dec 2025 17:01:41 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <jbarnes@virtuousgeek.org>, <chrisw@redhat.com>,
	<alex.williamson@redhat.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v2 3/3] PCI/sysfs: Prohibit unaligned access to I/O port on non-x86
Date: Wed, 24 Dec 2025 17:27:19 +0800
Message-ID: <20251224092721.2034529-4-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224092721.2034529-1-duziming2@huawei.com>
References: <20251224092721.2034529-1-duziming2@huawei.com>
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
 drivers/pci/pci-sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7e697b82c5e1..c44a9c4a91ab 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1166,12 +1166,20 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 			*(u8 *)buf = inb(port);
 		return 1;
 	case 2:
+#if !defined(CONFIG_X86)
+		if (!IS_ALIGNED(port, count))
+			return -EFAULT;
+#endif
 		if (write)
 			outw(*(u16 *)buf, port);
 		else
 			*(u16 *)buf = inw(port);
 		return 2;
 	case 4:
+#if !defined(CONFIG_X86)
+		if (!IS_ALIGNED(port, count))
+			return -EFAULT;
+#endif
 		if (write)
 			outl(*(u32 *)buf, port);
 		else
-- 
2.43.0


