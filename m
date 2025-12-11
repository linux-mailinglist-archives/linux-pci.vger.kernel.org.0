Return-Path: <linux-pci+bounces-42957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F215CB5F9B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 14:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90D5E30155F5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F90192D8A;
	Thu, 11 Dec 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yC2VSMy+"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2A286418
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765458288; cv=none; b=MEwMXL27Rp8/e9toX0L5ZxX1m4pGo440g7yjF5BUj3rL6/fmcLMewD9iRMPBPqzGab6xG6G6bLqgp1OTP4fp8dTePtm7n7TTGq9Egry27EnhINmRqltkavWOVjaylVpjK9BFH2jvw0kbPxqGpLsi5BSE7MeTz14kk/JmRh39pEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765458288; c=relaxed/simple;
	bh=JbDJCJDwlgoNXiKK2YbYjx9rH04qPwc9QeWFs8jsvsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci+cTZmZAq92UFqUj3fkO4//e7ci+lbmSDLuEBms1LYSeN6iNlN0kfLL6X7p2gRz32dgcVfQLdqZ7NvHSmuJuVgJAmdqCm6UDiGBynyrz4k2Enkx+ZnZaNTOtuulLLVVbm99zYAFJCfdaV9Sc0xj0Enq3/QYTohZ02+ZZLVCeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yC2VSMy+; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765458276; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PUVXmZSDUy0SM1YjCddp2yinMSycmf20lebDpcijVu8=;
	b=yC2VSMy+ujRL9C/yE5vsbp/i4mhcWqHbtQXgh3bHWfh5nNYrBMd/URwkSEgFAii4IqTST7s5hP5VUqEjWlIXhowu1cXfpAQNqP696PzK1u1hCLwaoCxOcKssB0KIiTlEaY3O4hNLiFY8C27XAnWJWUUprSx2rbMuB3Jo93559PQ=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuaaUIu_1765457954 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 20:59:18 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH v9 2/2] PCI: Check rom header and data structure addr before accessing
Date: Thu, 11 Dec 2025 20:59:06 +0800
Message-ID: <20251211125906.57027-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211125906.57027-1-kanie@linux.alibaba.com>
References: <20251211125906.57027-1-kanie@linux.alibaba.com>
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
 drivers/pci/rom.c | 116 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 97 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index e2e37a9090f1..658536861785 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -6,9 +6,12 @@
  * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
  */
 
+#include <linux/align.h>
 #include <linux/bits.h>
-#include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/sizes.h>
@@ -82,6 +85,91 @@ void pci_disable_rom(struct pci_dev *pdev)
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
@@ -97,38 +185,28 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
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
+
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
 		image += length * PCI_ROM_IMAGE_LEN_UNIT_BYTES;
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


