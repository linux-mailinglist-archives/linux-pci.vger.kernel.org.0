Return-Path: <linux-pci+bounces-42993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A5FCB87DC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 10:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E131F300A8F4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87D2DC354;
	Fri, 12 Dec 2025 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OPk4Au65"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134F31352F
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532248; cv=none; b=iM/aQO0l5JItFN5wvCoHYC7//mI2Wc5pxxs0SzjFEL5j9L57goL8uOtxugRvksyh1QX0pP5Xsoq0F8vN75UBsIN/Ksrl+Y22KmzMkJfsXqz3n+hCeqxcN8+i9k/fvNagfNl9e9LiLqzWFZQ3Xk/rlfX6YYUQYdq9Chwadnbs2BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532248; c=relaxed/simple;
	bh=tcrMzTZHvhVzbDplnRz0effeVvCpjiYZRNrVL+YswL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+kqI+Ab4jsH/vDjfz8Jz614SeQiXjJtk3C/ajliIKaGsulAr4Cwh9lvc7LnUH4Ck5RHx44lO2MIpTOcUCAjGkFiqBf9v18rNZWVw23JSg+Fi3X2reYiMwU3BamioQq887SAqa0jtx8FgN8TckbM6B+gmip46VenSxAf4ihpnzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OPk4Au65; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765532243; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HJqMhMabzl55vTIuxLVWDJetZUDYDgOXo5K1yLTkpZY=;
	b=OPk4Au657V51YBYuiXkS2ZeHMJZDrX+OpsKhLW2JdgEf9Bhtj7jG8q/P6BGIfu4yLUmPeV9dL1+otqmrycV1jk2wVJRSvTcJOCm6+vOAqyMTjS1zB1Dqw704w9dcBfHnJp166ME3VA+XMqHLJ9En9kNMbgoakS4FG0UI4VNumgs=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WudraaP_1765532239 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Dec 2025 17:37:22 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH v10 2/2] PCI: Check rom header and data structure addr before accessing
Date: Fri, 12 Dec 2025 17:37:10 +0800
Message-ID: <20251212093711.36407-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212093711.36407-1-kanie@linux.alibaba.com>
References: <20251212093711.36407-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We meet a crash when running stress-ng on x86_64 machine:

  BUG: unable to handle page fault for address: ffa0000007f40000
  RIP: 0010:pci_get_rom_size+0x52/0x220
  Call Trace:
  <TASK>
    pci_map_rom+0x80/0x130
    pci_read_rom+0x4b/0xe0
    kernfs_file_read_iter+0x96/0x180
    vfs_read+0x1b1/0x300

Our analysis reveals that the rom space's start address is
0xffa0000007f30000, and size is 0x10000. Because of broken rom
space, before calling readl(pds), the pds's value is
0xffa0000007f3ffff, which is already pointed to the rom space
end, invoking readl() would read 4 bytes therefore cause an
out-of-bounds access and trigger a crash.
Fix this by adding image header and data structure checking.

We also found another crash on arm64 machine:

  Unable to handle kernel paging request at virtual address
ffff8000dd1393ff
  Mem abort info:
  ESR = 0x0000000096000021
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x21: alignment fault

The call trace is the same with x86_64, but the crash reason is
that the data structure addr is not aligned with 4, and arm64
machine report "alignment fault". Fix this by adding alignment
checking.

Fixes: 47b975d234ea ("PCI: Avoid iterating through memory outside the resource window")
Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/pci/rom.c | 113 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 95 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 4f7641b93b4b..d8abed669fac 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -6,9 +6,12 @@
  * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
  */
 
+#include <linux/align.h>
 #include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -84,6 +87,91 @@ void pci_disable_rom(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_disable_rom);
 
+static bool pci_rom_is_header_valid(struct pci_dev *pdev,
+				    void __iomem *image,
+				    void __iomem *rom,
+				    size_t size,
+				    bool last_image)
+{
+	unsigned long rom_end = (unsigned long)rom + size - 1;
+	unsigned long header_end;
+	u16 signature;
+
+	/*
+	 * Some CPU architectures require IOMEM access addresses to
+	 * be aligned, for example arm64, so since we're about to
+	 * call readw(), we check here for 2-byte alignment.
+	 */
+	if (!IS_ALIGNED((unsigned long)image, 2))
+		return false;
+
+	if (check_add_overflow((unsigned long)image, PCI_ROM_HEADER_SIZE,
+				&header_end))
+		return false;
+
+	if (image < rom || header_end > rom_end)
+		return false;
+
+	/* Standard PCI ROMs start out with these bytes 55 AA */
+	signature = readw(image);
+	if (signature == PCI_ROM_IMAGE_SIGNATURE)
+		return true;
+
+	if (last_image) {
+		pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
+			 PCI_ROM_IMAGE_SIGNATURE, signature);
+	} else {
+		pci_info(pdev, "No more image in the PCI ROM\n");
+	}
+
+	return false;
+}
+
+static bool pci_rom_is_data_struct_valid(struct pci_dev *pdev,
+					 void __iomem *pds,
+					 void __iomem *rom,
+					 size_t size)
+{
+	unsigned long rom_end = (unsigned long)rom + size - 1;
+	unsigned long end;
+	u32 signature;
+	u16 data_len;
+
+	/*
+	 * Some CPU architectures require IOMEM access addresses to
+	 * be aligned, for example arm64, so since we're about to
+	 * call readl(), we check here for 4-byte alignment.
+	 */
+	if (!IS_ALIGNED((unsigned long)pds, 4))
+		return false;
+
+	/* Before reading length, check addr range. */
+	if (check_add_overflow((unsigned long)pds, PCI_ROM_DATA_STRUCT_LEN + 1,
+				&end))
+		return false;
+
+	if (pds < rom || end > rom_end)
+		return false;
+
+	data_len = readw(pds + PCI_ROM_DATA_STRUCT_LEN);
+	if (!data_len || data_len == U16_MAX)
+		return false;
+
+	if (check_add_overflow((unsigned long)pds, data_len, &end))
+		return false;
+
+	if (end > rom_end)
+		return false;
+
+	signature = readl(pds);
+	if (signature == PCI_ROM_DATA_STRUCT_SIGNATURE)
+		return true;
+
+	pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
+		 PCI_ROM_DATA_STRUCT_SIGNATURE, signature);
+	return false;
+}
+
 /**
  * pci_get_rom_size - obtain the actual size of the ROM image
  * @pdev: target PCI device
@@ -99,38 +187,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
 			       size_t size)
 {
 	void __iomem *image;
-	int last_image;
 	unsigned int length;
+	bool last_image;
 
 	image = rom;
 	do {
 		void __iomem *pds;
-		/* Standard PCI ROMs start out with these bytes 55 AA */
-		if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
-			pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
-				 PCI_ROM_IMAGE_SIGNATURE, readw(image));
+		if (!pci_rom_is_header_valid(pdev, image, rom, size, true))
 			break;
-		}
+
 		/* get the PCI data structure and check its "PCIR" signature */
 		pds = image + readw(image + PCI_ROM_POINTER_TO_DATA_STRUCT);
-		if (readl(pds) != PCI_ROM_DATA_STRUCT_SIGNATURE) {
-			pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
-				 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));
+		if (!pci_rom_is_data_struct_valid(pdev, pds, rom, size))
 			break;
-		}
+
 		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) &
 				   PCI_ROM_LAST_IMAGE_INDICATOR_BIT;
 		length = readw(pds + PCI_ROM_IMAGE_LEN);
 		image += length * PCI_ROM_IMAGE_SECTOR_SIZE;
-		/* Avoid iterating through memory outside the resource window */
-		if (image >= rom + size)
+
+		if (!pci_rom_is_header_valid(pdev, image, rom, size, last_image))
 			break;
-		if (!last_image) {
-			if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
-				pci_info(pdev, "No more image in the PCI ROM\n");
-				break;
-			}
-		}
 	} while (length && !last_image);
 
 	/* never return a size larger than the PCI resource window */
-- 
2.43.0


