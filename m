Return-Path: <linux-pci+bounces-42927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94367CB4A40
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 04:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 563AD30011A0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 03:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F726B96A;
	Thu, 11 Dec 2025 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xj3Qz++8"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBDB2853F7
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765424588; cv=none; b=GtBo2HGrgDvSjPy/n8yOrjoRE5DGa9nxMMoRcmiMj8oZDX2CWY+kmUTff6DUgq1QxKkxBX52EBH6gfANXt7CZS2OnpKXnRQI/aKQsAuiC/kjrHJemyBurwp5yGS926uYlI9Sb0GyJmqphED665lzozgQEUYDtvy2k3VHzvA49Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765424588; c=relaxed/simple;
	bh=7NBoJgh5OkyTPWq0At/G6wa5nFnDrZ8BNnT6Cqb4DS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbGGspFmVtBVnSkCsGTrfpXXpf9c/qVOCODqV4bcB0rtTefkwnAMMDVDtHK1fp1HjZHiFsHCaLSQ4n5BO4pn3NvU7eOvddEl3p1hJ+1oK97WE3Gt4jT7Xz0iwz6EV+DJ5bgrLnEcIZ3xAQ5x7+zKXC9N5RIdscaX+eq6EgjiYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xj3Qz++8; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765424583; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=F0fQz+fKcYw2Lt8N26wFLWnRzzmmTax3KIFNNCIQb+g=;
	b=xj3Qz++8Rh9hqwYi8On+VUpO43UZTbo/AtlUwZ6rdt/uiy5+R8Xt+e22IKi2aZ7+OjZGi0sW/QkOAQ5DC/hi2mstpXnF0EXqFAN+tf6kqJdNMu/NHYsKwLjzDqxN1UuBkwQMfWbfKzeCLuh5N3wZEFas1s4hR9FQLIyA4ZHalms=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuYov8t_1765424261 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 11:37:46 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH v7 0/2] PCI: Fix crash when access broken rom 
Date: Thu, 11 Dec 2025 11:37:39 +0800
Message-ID: <20251211033741.53072-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


v6 -> v7:
- Put all named defines to a separate patch.
- Change PCI_ROM_IMAGE_LEN_UNIT_BYTES to PCI_ROM_IMAGE_LEN_UNIT_SZ_512.
- Named BIT(7) to PCI_ROM_LAST_IMAGE_INDICATOR_BIT.
- Fix all other comments from Ilpo, such as including header files,
and aligment fault, Thanks.

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
- Remove every step checking, just check the addr is in header or data struct.
- Add Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com> tag.

Guixin Liu (2):
  PCI: Introduce named defines for pci rom
  PCI: Check rom header and data structure addr before accessing

 drivers/pci/rom.c | 130 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 108 insertions(+), 22 deletions(-)

-- 
2.43.0


