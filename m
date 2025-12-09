Return-Path: <linux-pci+bounces-42819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A61F2CAEF81
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 06:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CA5F3030FD0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 05:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B63826F296;
	Tue,  9 Dec 2025 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ftepztPW"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5931ED80
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 05:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765259485; cv=none; b=bwo819NsBQjPF+Qw978Zk2JhLfvGTTFdg0czLragCsidS0+gY1CgS0RzDifLYIZcuzaifwTswS1xT9tyVjEVSYlpMeFf6xMxvPXmZ/mKc/CMORcDveiIvhQeuLB8uzRy01zqqHA21MV7/TRAgIXl04TUkFkmXNO5VEYu+k2btM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765259485; c=relaxed/simple;
	bh=2AMcSjxozP6dAKJwja4nQgJqZCwC1TTxXyQZ7goxiss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gv7yn0S6NT0rT9hzR5PAtsES+QtPreIOnHydG/nitpTdrejSv6o0hm1u0Z4TAXnXamT5+LlOVS3b0JzR7bDazxARS4r1X7xScYqv5aal+Zvgl+lAPUQ4K9x0mvyjsOfvk1NtauYl6fxLsJSfNxmj5L6TLNFjT9fUW2Ozjpa027U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ftepztPW; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765259479; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Oqa1fSl1VRU960YkLa4xiKTvgFqZNsxLfz7X/Igln84=;
	b=ftepztPWiIuFOAxLk6z0yrTas0kiOiQHvAHC+UZbo4ttWfAo3aQxCnVQTEwaRVBxOLpBRfc+N//VKFFfLwSHwdUeygblmdncEgDhJ8tk0lbXs0Hvr7ZJKnnOggmvqz7Y4pWXwFUOWwZpkpl3LNoVMD9elDnuyZ40t6PKAKRkunk=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuRS1ah_1765259474 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Dec 2025 13:51:19 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH RESEND v5] PCI: Check rom header and data structure addr before accessing
Date: Tue,  9 Dec 2025 13:51:14 +0800
Message-ID: <20251209055114.66392-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
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
v4 -> v5:
- Add Andy Shevchenko's rb tag, thanks.
- Change u64 to unsigned long.
- Change pci_rom_header_valid() to pci_rom_is_header_valid() and
change pci_rom_data_struct_valid() to pci_rom_is_data_struct_valid().
- Change rom_end from rom+size to rom+size-1 for more readble,
and also change header_end >= rom_end to header_end > rom_end, same
as data structure end.
- Change if(!last_image) to if (last_image)..
- Use U16_MAX instead of 0xffff.
- Split check_add_overflow() from data_len checking.
- Remove !!() when reading last_image, and Use BIT(7) instead of 0x80.

v3 -> v4:
- Use "u64" instead of "uintptr_t".
- Invert the if statement to avoid excessive indentation.
- Add comment for alignment checking.
- Change last_image's type from int to bool.

v2 -> v3:
- Add pci_rom_header_valid() helper for checking image addr and signature.
- Add pci_rom_data_struct_valid() helper for checking data struct add
and signature.
- Handle overflow issue when adding addr with size.
- Handle alignment fault when running on arm64.

v1 -> v2:
- Fix commit body problems, such as blank line in "Call Trace" both sides,
  thanks, (Andy Shevchenko).
- Remove every step checking, just check the addr is in header or data struct.
- Add Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com> tag.
 drivers/pci/rom.c | 109 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 90 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index e18d3a4383ba..b0de38211f39 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -69,6 +69,87 @@ void pci_disable_rom(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_disable_rom);
 
+#define PCI_ROM_HEADER_SIZE 0x1A
+
+static bool pci_rom_is_header_valid(struct pci_dev *pdev,
+				    void __iomem *image,
+				    void __iomem *rom,
+				    size_t size,
+				    bool last_image)
+{
+	unsigned long rom_end = (unsigned long)rom + size - 1;
+	unsigned long header_end;
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
+	    &header_end))
+		return false;
+
+	if (image < rom || header_end > rom_end)
+		return false;
+
+	/* Standard PCI ROMs start out with these bytes 55 AA */
+	if (readw(image) == 0xAA55)
+		return true;
+
+	if (last_image)
+		pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
+			 readw(image));
+	else
+		pci_info(pdev, "No more image in the PCI ROM\n");
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
+	/* Before reading length, check range. */
+	if (check_add_overflow((unsigned long)pds, 0x0B, &end))
+		return false;
+
+	if (pds < rom || end > rom_end)
+		return false;
+
+	data_len = readw(pds + 0x0A);
+	if (!data_len || data_len == U16_MAX)
+		return false;
+
+	if (check_add_overflow((unsigned long)pds, data_len, &end))
+		return false;
+
+	if (end > rom_end)
+		return false;
+
+	if (readl(pds) == 0x52494350)
+		return true;
+
+	pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
+		 readl(pds));
+	return false;
+}
+
 /**
  * pci_get_rom_size - obtain the actual size of the ROM image
  * @pdev: target PCI device
@@ -84,37 +165,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
 			       size_t size)
 {
 	void __iomem *image;
-	int last_image;
+	bool last_image;
 	unsigned int length;
 
 	image = rom;
 	do {
 		void __iomem *pds;
-		/* Standard PCI ROMs start out with these bytes 55 AA */
-		if (readw(image) != 0xAA55) {
-			pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
-				 readw(image));
+
+		if (!pci_rom_is_header_valid(pdev, image, rom, size, true))
 			break;
-		}
+
 		/* get the PCI data structure and check its "PCIR" signature */
 		pds = image + readw(image + 24);
-		if (readl(pds) != 0x52494350) {
-			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
-				 readl(pds));
+		if (!pci_rom_is_data_struct_valid(pdev, pds, rom, size))
 			break;
-		}
-		last_image = readb(pds + 21) & 0x80;
+
+		last_image = readb(pds + 21) & BIT(7);
 		length = readw(pds + 16);
 		image += length * 512;
-		/* Avoid iterating through memory outside the resource window */
-		if (image >= rom + size)
+
+		if (!pci_rom_is_header_valid(pdev, image, rom, size, last_image))
 			break;
-		if (!last_image) {
-			if (readw(image) != 0xAA55) {
-				pci_info(pdev, "No more image in the PCI ROM\n");
-				break;
-			}
-		}
 	} while (length && !last_image);
 
 	/* never return a size larger than the PCI resource window */
-- 
2.43.0


