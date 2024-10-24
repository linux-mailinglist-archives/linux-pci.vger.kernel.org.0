Return-Path: <linux-pci+bounces-15159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F37089AD986
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 04:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D90028193D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 02:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357D01CAAC;
	Thu, 24 Oct 2024 02:03:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7E156CA;
	Thu, 24 Oct 2024 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729735429; cv=none; b=ghCMvDek+dxdu5ov4XGfIqnSrKIeUeerjB4PH646rR2dRnTXBnmTQjWpv/Rqj3sVZvmyrWsS3Yje73LlE0MdvKss4n//1NE0X8ZiAudrUg4VNf+nvdl2gIhtagMBknEzrIIF30YIfYMd1EiJ9q1OnVJBd9KlMwx4jK2LMfXgDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729735429; c=relaxed/simple;
	bh=PyQrMV6z3u0TP6bvWdvWQm1mSb57Wpnk7Pak+HE+kNw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uujHE7quwQAL0sSHREdRfuFs4BNSqKoKC/SZG9idZ9O/VufY6Q0TqWSQl328obkQOJVjQ9q8hCiqxia0iAZPYxPFB6Dofxg55fk2OdiUlNUBifLLiE/P8Pt6WEM9Uivf9cJ+M+hX/x1mBccIbTlLrHFqrk6MIYAUTdQRjlE83RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XYpzr1P6zzdkNL;
	Thu, 24 Oct 2024 10:01:12 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id CDE2B180103;
	Thu, 24 Oct 2024 10:03:42 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemj200003.china.huawei.com
 (7.202.194.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Oct
 2024 10:03:42 +0800
From: liwei <liwei728@huawei.com>
To: <bhelgaas@google.com>, <jpk@sgi.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bobo.shaobowang@huawei.com>, <liwei728@huawei.com>
Subject: [PATCH] PCI/ROM: Fix PCI ROM header check bug
Date: Thu, 24 Oct 2024 10:17:25 +0800
Message-ID: <20241024021725.2608037-1-liwei728@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemj200003.china.huawei.com (7.202.194.15)

'pds' does not perform 4-byte alignment check. If 'pds' is not 4-byte
aligned, it will cause alignment fault.

Mem abort info:
ESR = 0x0000000096000021
EC = 0x25: DABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
FSC = 0x21: alignment fault
Data abort info:
ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
CM = 0, WnR = 0, TnD = 0, TagAccess = 0
GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000203ef6a0d000
[ffff8000c930ffff] pgd=1000002080bcf003, p4d=1000002080bcf003, pud=100000403ae8a003, pmd=1000202027498003, pte=00680000b000ff13
Internal error: Oops: 0000000096000021 [#1] SMP
CPU: 16 PID: 451316 Comm: read_all Kdump: loaded Tainted: G W 6.6.0+ #6
Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, BIOS 6.57 05/17/2023
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : pci_get_rom_size+0x74/0x1f0
lr : pci_map_rom+0x140/0x280
sp : ffff8000b96178f0
x29: ffff8000b96178f0 x28: ffff004e284b3f80 x27: ffff8000b9617be8
x26: ffff0020facb7020 x25: 0000000000100000 x24: 00000000b0000000
x23: ffff00208c8ea740 x22: 1ffff000172c2f2e x21: ffff8000c9300000
x20: 0000000000100000 x19: ffff8000c9300000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000041b58ab3 x12: 1ffff000172c2ec8
x11: 00000000f1f1f1f1 x10: ffff7000172c2ec8 x9 : ffffb9ba9db93ad8
x8 : ffff7000172c2eac x7 : ffff8000c9400000 x6 : 0000000052494350
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000c930ffff
x2 : 000000000000aa55 x1 : 0000000000000000 x0 : ffff00208c8ea000
Call trace:
  pci_get_rom_size+0x74/0x1f0
  pci_map_rom+0x140/0x280
  pci_read_rom+0xa8/0x158
  sysfs_kf_bin_read+0xb8/0x130
  kernfs_file_read_iter+0x124/0x278
  kernfs_fop_read_iter+0x6c/0xa8
  new_sync_read+0x128/0x208
  Inject: max_dir_depth
  vfs_read+0x244/0x2b0
  ksys_read+0xd0/0x188
  __arm64_sys_read+0x4c/0x68
  invoke_syscall+0x68/0x1a0
  el0_svc_common.constprop.0+0x11c/0x150
  do_el0_svc+0x38/0x50
  el0_svc+0x64/0x258
  el0t_64_sync_handler+0x100/0x130
  el0t_64_sync+0x188/0x190
Code: d50331bf ca030061 b5000001 8b030263 (b9400064)
SMP: stopping secondary CPUs
Starting crashdump kernel...

In UEFI Specification Version 2.8, describes that the PCIR data structure must
start on a 4-byte boundary. Fix it by verifying the 'pds' is aligned.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: liwei <liwei728@huawei.com>
---
 drivers/pci/rom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index e18d3a4383ba..0fa6b3da63cc 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -98,6 +98,12 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
 		}
 		/* get the PCI data structure and check its "PCIR" signature */
 		pds = image + readw(image + 24);
+		/* The PCIR data structure must begin on a 4-byte boundary */
+		if (!IS_ALIGNED((unsigned long)pds, 4)) {
+			pci_info(pdev, "Invalid PCI ROM header signature: PCIR %#06x\n",
+				 readw(image + 24));
+			break;
+		}
 		if (readl(pds) != 0x52494350) {
 			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
 				 readl(pds));
-- 
2.25.1


