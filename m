Return-Path: <linux-pci+bounces-41211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5848C5B954
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 07:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E916D357AF2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 06:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2528021C167;
	Fri, 14 Nov 2025 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AymIXa04"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB1238C0D
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763102069; cv=none; b=L1/R+JcgOyc33/cshqA4hyL1uTUlBw0H9CV5K5jnP/2d7MNgZQ4z+fykh62jmG2Qbept+ai79o7qwWp0siIGXcpRyx2sPJX2f6jVdgr6vS2WUOdotnyB+9orAWTL4rN+CZooFh+ruYO8caOhgBoyn+XkyN9pVLW8DExkLh91kuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763102069; c=relaxed/simple;
	bh=2EWosRrj/oOhMzK1pVKJ4A8AHtZY7Q6uYpKRr2PTnjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=np9RuM82AQ2uEabMEV4cJ+MJoyiwRirZRtgeA9p1P+cx4TGtGXvd1s2jtfr6qR+6FYypexYimyqceK5p76wiA3UWPSJVjiJe7cSWSGYrOyxJKpaOlQRW1F+WdJHiwBsRV8k4Zf6enJOkmgYdMv5xSYtRKo9AaMpsaN2uTp1d8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AymIXa04; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763102057; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=02VBpEBQJUk8ZqnUjOWPEzyczRrzeCVD6w+ycuMnCpI=;
	b=AymIXa04T9aB0BaEG+4y59QMCpRyR+EhTkQIX9DliTPS4IVizsDLHjOI3yt46XeCTyxIPlLt+hxUv/XfY8FlmR5MGW6SXv1oHwuOtHD4GZHgx0p+Jj61nnJKXQlwyxRHjHJvR0YLJHLp3E6bEhTOmH8AAxqB/7Df+fZiU44JAeY=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WsM3bFI_1763102051 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Nov 2025 14:34:17 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Check rom image addr at every step
Date: Fri, 14 Nov 2025 14:34:11 +0800
Message-ID: <20251114063411.88744-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We meet a crash when running stress-ng:
  BUG: unable to handle page fault for address: ffa0000007f40000
  RIP: 0010:pci_get_rom_size+0x52/0x220
  Call Trace:
  <TASK>
  pci_map_rom+0x80/0x130
  pci_read_rom+0x4b/0xe0
  kernfs_file_read_iter+0x96/0x180
  vfs_read+0x1b1/0x300
  ksys_read+0x63/0xe0
  do_syscall_64+0x34/0x80
  entry_SYSCALL_64_after_hwframe+0x78/0xe2
Bcause of broken rom space, before calling readl(pds), pds already
points to the rom space end (rom + size - 1), invoking readl()
would therefore cause an out-of-bounds access and trigger a crash.

Fix this by adding every step address checking.

Fixes: 47b975d234ea ("PCI: Avoid iterating through memory outside the resource window")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/pci/rom.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index e18d3a4383ba..f9377ad3f89f 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -69,6 +69,10 @@ void pci_disable_rom(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_disable_rom);
 
+#define PCI_ROM_DATA_STRUCT_OFFSET 24
+#define PCI_ROM_LAST_IMAGE_OFFSET 21
+#define PCI_ROM_LAST_IMAGE_LEN_OFFSET 16
+
 /**
  * pci_get_rom_size - obtain the actual size of the ROM image
  * @pdev: target PCI device
@@ -86,28 +90,41 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
 	void __iomem *image;
 	int last_image;
 	unsigned int length;
+	void __iomem *end = rom + size;
 
 	image = rom;
 	do {
 		void __iomem *pds;
+
+		if (image + 2 >= end)
+			break;
+
 		/* Standard PCI ROMs start out with these bytes 55 AA */
 		if (readw(image) != 0xAA55) {
 			pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
 				 readw(image));
 			break;
 		}
+
+		if (image + PCI_ROM_DATA_STRUCT_OFFSET + 2 >= end)
+			break;
 		/* get the PCI data structure and check its "PCIR" signature */
-		pds = image + readw(image + 24);
+		pds = image + readw(image + PCI_ROM_DATA_STRUCT_OFFSET);
+		if (pds + 4 >= end)
+			break;
 		if (readl(pds) != 0x52494350) {
 			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
 				 readl(pds));
 			break;
 		}
-		last_image = readb(pds + 21) & 0x80;
-		length = readw(pds + 16);
+
+		if (pds + PCI_ROM_LAST_IMAGE_OFFSET + 1 >= end)
+			break;
+		last_image = readb(pds + PCI_ROM_LAST_IMAGE_OFFSET) & 0x80;
+		length = readw(pds + PCI_ROM_LAST_IMAGE_LEN_OFFSET);
 		image += length * 512;
 		/* Avoid iterating through memory outside the resource window */
-		if (image >= rom + size)
+		if (image + 2 >= end)
 			break;
 		if (!last_image) {
 			if (readw(image) != 0xAA55) {
-- 
2.43.0


