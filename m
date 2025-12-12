Return-Path: <linux-pci+bounces-42991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31788CB8815
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 10:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFC0B309A7EB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 09:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5CB2DC354;
	Fri, 12 Dec 2025 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v/elayVQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2337331327B
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532244; cv=none; b=bTz3zL4sr2/9P6YeOLkj/9FyTdkoyBIj2fWz7g2oOi2p0hIbJ8dHQQ/060Z4KFZhnZ+VKauZVSI8FpHjFGi1Gwuzc09/r0kHhG+GOKrUZIr11d05v3xFuO2sLzLeDG/7+Oo/O8X4bKe/S3Bfv5Y/9y84LrKN99NNq8y+70M3hqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532244; c=relaxed/simple;
	bh=FKJ/m4ulrD5X+QBNHeaAoynsXA0CGUUwyiO1MHv85gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8Fzpbnnd7mhvRTWEJDN66THkmWxCuPYSeibnyL2F3CfLo8LRbfyAszQx7A7tctHppFpWhrPABSTA5srHvjT8C/EQYUf32iaG12/9wSsHC8g0zwcwAkX4GSoWrA16Vf+HmDXdc9e0BUUjLyuAR90rzWC0rpwUNNu13fvhpjf/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v/elayVQ; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765532235; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0+QIxxVRH2EjZiwQWnC1Jsy6fk3l7QYFdtrsoMK7vLU=;
	b=v/elayVQOjUg36gOAMSwE0ROLhvWDHUnpC1cCFcfqzewQCTkCSvAKKPh1Yk9vADTVspvBT2Nh8wb63pXPw2Rlxfj3j1z1Px/eyhfMsDV8uBx1kZDB/kur53AKACLha/3fjHZa3p4PxhgjBfq2C3SruFUEINfkLljB9WT4+snKlI=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WudrzjR_1765532231 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Dec 2025 17:37:14 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH v10 0/2] PCI: Fix crash when access broken rom
Date: Fri, 12 Dec 2025 17:37:08 +0800
Message-ID: <20251212093711.36407-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v9 -> v10:
- Reorder the header files, and not touch kernel.h
- Change PCI_ROM_IMAGE_LEN_UNIT_BYTES to PCI_ROM_IMAGE_SECTOR_SIZE.
- Add a comment for PCI_ROM_DATA_STRUCT_SIGNATURE.

v8 -> v9:
- Supplemental explanation for the commit body of the first patch.
- Change PCI_ROM_IMAGE_LEN_UNIT_SZ_512 to PCI_ROM_IMAGE_LEN_UNIT_BYTES,
and change it's definition to SZ_512.
- Use u16 and u32 for signature val instead of unsigned short/int.

v7 -> v8:
- Ordered header files alphabetically.
- Convert the literals too in the firt patch.
- Use local val to save signature instead of reading twice.

v6 -> v7:
- Put all named defines to a separate patch.
- Change PCI_ROM_IMAGE_LEN_UNIT_BYTES to PCI_ROM_IMAGE_LEN_UNIT_SZ_512.
- Named BIT(7) to PCI_ROM_LAST_IMAGE_INDICATOR_BIT.
- Fix all other comments from Ilpo, such as including header files,
and alignment fault, Thanks.

v5 -> v6:
- Convert some magic number to named defines, suggested by
Ilpo, thanks.

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
- Remove every step checking, just check the addr is in header or data
struct.
- Add Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com> tag.

Guixin Liu (2):
  PCI: Introduce named defines for pci rom
  PCI: Check rom header and data structure addr before accessing

 drivers/pci/rom.c | 137 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 115 insertions(+), 22 deletions(-)

-- 
2.43.0


