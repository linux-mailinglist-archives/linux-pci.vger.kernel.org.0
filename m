Return-Path: <linux-pci+bounces-31055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31103AED56B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 09:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA4C3A858E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 07:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8E91DF75D;
	Mon, 30 Jun 2025 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJt6Mp4x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687C91FDD;
	Mon, 30 Jun 2025 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268037; cv=none; b=h7quAbLtCLL7H7weCkXiLL1wD9BAQuPhxoJ+W6vjPsnA4+9/28IqchoCfobvcgJK3IXbNUakj7a0QMKSrpGhX3NjaOHjpYH058HIW7IMLYfEmqlK2LUZdVKnG4KtL4DfNOkdpqMBYsVC1EqB8FpzBWl+xA6gjBKlqILk82mggfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268037; c=relaxed/simple;
	bh=j8gArzniIGkkAWG+ouaYATMEvt6mFEDaFB28LnAOnic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UcH+KS8BghfuexZ4PSaHhATgV0RGIpGBh5nYP2yaCtklXiVsudLf2Enrmz6njtJW0Stt+PhZp+wwkpYdbJ2gU44Swfe7hXcTUIHB1Huvo75m1lvyKz3SQgoMc+scYWGOUSRS6oJG/4K38QegUWni76JtGg4Sirs6GzFiiRRJ3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJt6Mp4x; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af51596da56so1809497a12.0;
        Mon, 30 Jun 2025 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751268034; x=1751872834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DttZca4H6CBXm/X6mCOIuNHic7ttctct+0OCFubo14=;
        b=dJt6Mp4xRQcjAJ63mSG5OIVmeK2yAen95vCjH5T18w4JJvFZvf2pbAsg3mZC0hMRiL
         Mk6tkjOt8X+3z9uj7lvZrVdBMC6kfppjMZynRacX6RVYzSCMriPo0xKfSpTeyLLHBTrM
         fjDGmTIZEqvFUtSH7J8Kz3y7CX1ezk36fa3pdVEX7jumJFnerUJvFp1fLhXBN/T3yp9z
         fEzsU6rM2wq5nr64Xzg7d35ZAMuqkwECi/imh/HGeWMR+olcsXVtRT0XmVmUxNuJWC6a
         bN6Fj3PQgnY2QspQkcX/xh94HgYuQ09nyT3slwS9VfgSIYeUcKRu2FJ+hyArzXoFLvPG
         FJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751268034; x=1751872834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DttZca4H6CBXm/X6mCOIuNHic7ttctct+0OCFubo14=;
        b=gifVlcsNRCvOxE3BJ5Ai5tixWfUtRKtV5p+QGdoTejaUSfGav5kuuSKr9n0z6qewPH
         2i5rR2aXzYH44FFuvcdNV/5C1hjLXzQWkre8Gp4KRMmK64Awoo12FDAIsibsjel1Y/Mw
         vSJFeTuE+Acmc0fuaiIdFxsJfIpzOfb462YZSz8ziK/0EKkgVCZw90JK+SAbaPn953yW
         AfKzMSqPoASPTBtGVVVo/gVvpit+9d3syM1v9e6QAwVWE/qGxXnaUaVhCmooxNqWCIcI
         DHKRG6b464VrsVJUdzZiL2wM1kOMZdWLcQOqxIdui2Z/Wl5fguXhOOXg+5IEyTUVQ+gn
         6Hyw==
X-Forwarded-Encrypted: i=1; AJvYcCUbYNUofrKSEcFHJl+Z26NpIjBzuQkNuFj/paOrGH9YTh59pcW1CWJZpNBQmmrCJ79hDiKR2nX3EE6uvoYh@vger.kernel.org, AJvYcCXVQzBnMHWfnrEXxRjdXqjRn1QdI6hq7D21buFwQdQ8zzmMDjT22cwYo59tMJEvSbhYt9p84WrvpeIF@vger.kernel.org, AJvYcCXynW3M36jq/pJxZss67WLDARiietHJwHEerMCy1UPmUH8J9q44DWSZuOmBxXX9yoVk+Hpv8kClNDsl@vger.kernel.org
X-Gm-Message-State: AOJu0YxaVKhSegSRiLyNfjSLpYvzvCnhm0p7v235r7jq5gKgOMohXVM1
	QzbX/OcAWiYoYzLQSqlcP1hQ6FOJHflbifUY7kD/N4l5en1tnzsOZfj5Qrbqa20L4z0=
X-Gm-Gg: ASbGncvfSd3MzPaMRZxDt/gBGqli5JHKXqByDh+P0KeJhm0RS+9qjBd0QathMUEEFrM
	U4KLcW93jlbSwMhbaALuiOjARrIAE5KvYdHwMMyLsDN5NGv6TN49lJlJeRV+KXZMcAO7xSwozBM
	MY4oIZNaHABeiaxwVVieRKE8UE/lH7Fej3qIPsD8IHuimF8JymCHqCBca5BeqskFGRBhqpKJLQF
	ZL4NF2RdvP/Xqux2Qehfcytyy+SLEJ9PrWjouWqs65YVCYwGlX+PsYOpQYH3r+tIpneSVXVCr6a
	BBuvhgnzW43ZU16hKoQZZaX+kXaSa+aiEeF9ayaJvZ0tk65jw9cFYkxsM7H+1NVo
X-Google-Smtp-Source: AGHT+IFNfnhS4SJNhSiO7/WTxOgwWl5cz4as13ze1C+5b8UztDamYXc5EtE3RqspmnNrOz2GzvGyGw==
X-Received: by 2002:a05:6a21:15cf:b0:1fd:f4df:96ed with SMTP id adf61e73a8af0-220a1696177mr16134092637.26.1751268034529;
        Mon, 30 Jun 2025 00:20:34 -0700 (PDT)
Received: from localhost.localdomain ([103.149.27.191])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3029858sm6864109a12.31.2025.06.30.00.20.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 30 Jun 2025 00:20:34 -0700 (PDT)
From: fuqiang wang <fuqiang.wng@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wangfuqiang49 <wangfuqiang49@jd.com>,
	yaozhenguo <yaozhenguo@jd.com>,
	fuqiang wang <fuqiang.wng@gmail.com>
Subject: [RFC PATCH] pci hotplug: fix hotplug bug during kernel boot
Date: Mon, 30 Jun 2025 15:20:28 +0800
Message-ID: <20250630072028.35178-1-fuqiang.wng@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Performing hotplug operations when the virtual machine is just started
may cause the virtual machine kernel to trigger a bug_on in x86
architecture, with the bug_on dmesg as follows:

  ------------[ cut here ]------------
  kernel BUG at kernel/resource.c:792!
  Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
  CPU: 1 UID: 0 PID: 215 Comm: kworker/u128:5 Not tainted 6.14.0-rc1+ #17
  Hardware name: JD JCloud Iaas Jvirt, BIOS unknown 2/2/2022
  Workqueue: kacpi_hotplug acpi_hotplug_work_fn

  RIP: 0010:reallocate_resource+0x197/0x1d0
  Code: 20 48 8b 44 24 28 48 89 43 28 48 8b 44 24 30 48 89 43 30 48 8b 44 24 38 48 89 43 38 e8 12 db ff ff 48 85 c0 0f 84 5d ff ff ff <0f> 0b 48 8b 74 24 08 48 3b 73 08 0f 82 1c ff ff ff 48 89 0b 48 89
  RSP: 0000:ffffc900008479b0 EFLAGS: 00010282
  RAX: ffff8881020c73b0 RBX: ffff8881021813b0 RCX: 000000000000343f
  RDX: 0000000000003400 RSI: ffff8881021813b0 RDI: ffff8881020c73b0
  RBP: 0000000000000000 R08: ffff8881021863e0 R09: 0000000000000040
  R10: 0000000000000000 R11: 000000000000343f R12: ffff88810020d6f0
  R13: ffffc90000847a20 R14: ffff88810020d6f0 R15: ffffffff82edb970
  FS:  0000000000000000(0000) GS:ffff88842ee80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 0000000003036001 CR4: 0000000000170ef0
  Call Trace:
   <TASK>
   ? die+0x32/0x80
   ? do_trap+0xd9/0x100
   ? reallocate_resource+0x197/0x1d0
   ? do_error_trap+0x65/0x80
   ? reallocate_resource+0x197/0x1d0
   ? exc_invalid_op+0x4c/0x60
   ? reallocate_resource+0x197/0x1d0
   ? asm_exc_invalid_op+0x16/0x20
   ? reallocate_resource+0x197/0x1d0
   allocate_resource+0x57/0xd0
   ? __pfx_pcibios_align_resource+0x10/0x10
   pci_bus_alloc_from_region+0x1df/0x240
   ? __pfx_pcibios_align_resource+0x10/0x10
   ? __pfx_pcibios_align_resource+0x10/0x10
   ? __pfx_pcibios_align_resource+0x10/0x10
   pci_bus_alloc_resource+0x86/0xb0
   ? __pfx_pcibios_align_resource+0x10/0x10
   _pci_assign_resource+0x9e/0x120
   ? __pfx_pcibios_align_resource+0x10/0x10
   pci_assign_resource+0xae/0x290
   assign_requested_resources_sorted+0x4a/0xb0
   __assign_resources_sorted+0x491/0x4d0
   ? __dev_sort_resources+0x9b/0x2a0
   __pci_bus_assign_resources+0x6f/0x1f0
   enable_slot+0x25e/0x440
   ? pci_device_is_present+0x49/0x70
   acpiphp_check_bridge.part.0+0x117/0x150
   hotplug_event+0x13d/0x220
   ? __pfx_acpiphp_hotplug_notify+0x10/0x10
   acpiphp_hotplug_notify+0x20/0x60
   acpi_device_hotplug+0xae/0x240
   acpi_hotplug_work_fn+0x1a/0x30
   process_one_work+0x184/0x3a0
   worker_thread+0x24d/0x360
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xed/0x220
   ? finish_task_switch.isra.0+0x88/0x2b0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x30/0x50
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  Modules linked in:

The cause of the issue is that the enable_slot process in hotplug
conflicts with the pcibios_init process during kernel initialization.
This leads to the situation where, in the enable_slot process,
__dev_sort_resources first links all the resources of the devices
downstream of the bridge into the head (since there is no parent).
Subsequently, in the pcibios_init process, pci_claim_resource allocates
the BIOS-assigned ranges for these devices.

  hotplug CPU                              kernel init CPU
  enable_slot
  ...
   __dev_sort_resources

   //link all resources behind the bus
   //into head
                                           pci_bios_init
                                           ...
                                             pcibios_allocate_bus_resources
                                           //alloc resource for all bus
   //resources linked into head have
   //sibling and parent

However, in the subsequent steps of enable_slot, certain resources may
be reallocated due to the x86 alignment rule -- "0x00, 0xff region
modulo 0x400" (see pcibios_align_resource). During this reallocation,
alignment can cause gaps, leading to allocation failures and resulting
in the resource reset. Additionally, since this resource has already
been linked into bus->resource[]->child during the kernel initialization
process, a strange resource range [0, 0] appears in this chain. This
causes subsequent devices to be allocated ranges that conflict with
other resources. For a detailed analysis, see [1]:

This patch will make the hotplug process wait for the pcibios_init
process in kernel initialization to complete. (However, I am not sure if
this modification is appropriate, so I would appreciate your advice.)

[1]: https://github.com/cai-fuqiang/md/blob/master/case/guestkernel_hotplug_BUG_ON/kernel_panic.md

Signed-off-by: fuqiang wang <fuqiang.wng@gmail.com>
---
 arch/x86/pci/common.c | 16 ++++++++++++++++
 drivers/acpi/scan.c   |  6 ++++++
 include/linux/pci.h   |  1 +
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index ddb798603201..06ff04ab2a26 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -37,6 +37,8 @@ unsigned long pirq_table_addr;
 const struct pci_raw_ops *__read_mostly raw_pci_ops;
 const struct pci_raw_ops *__read_mostly raw_pci_ext_ops;
 
+DECLARE_COMPLETION(pcibios_init_completion);
+
 int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
 						int reg, int len, u32 *val)
 {
@@ -498,6 +500,17 @@ void __init pcibios_set_cache_line_size(void)
 	}
 }
 
+static DEFINE_STATIC_KEY_FALSE(pcibios_init_done);
+
+void arch_wait_pcibios_init_complete(void)
+{
+	if (static_branch_likely(&pcibios_init_done))
+		return;
+
+	wait_for_completion(&pcibios_init_completion);
+	static_branch_enable(&pcibios_init_done);
+}
+
 int __init pcibios_init(void)
 {
 	if (!raw_pci_ops && !raw_pci_ext_ops) {
@@ -510,6 +523,9 @@ int __init pcibios_init(void)
 
 	if (pci_bf_sort >= pci_force_bf)
 		pci_sort_breadthfirst();
+
+	complete(&pcibios_init_completion);
+
 	return 0;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9f4efa8f75a6..a66fbc262fb8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -21,6 +21,7 @@
 #include <linux/pgtable.h>
 #include <linux/crc32.h>
 #include <linux/dma-direct.h>
+#include <linux/pci.h>
 
 #include "internal.h"
 #include "sleep.h"
@@ -435,12 +436,17 @@ static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
 	return -EINVAL;
 }
 
+void __weak arch_wait_pcibios_init_complete(void) {}
+
 void acpi_device_hotplug(struct acpi_device *adev, u32 src)
 {
 	u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE;
 	int error = -ENODEV;
 
 	lock_device_hotplug();
+
+	arch_wait_pcibios_init_complete();
+
 	mutex_lock(&acpi_scan_lock);
 
 	/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..8078b68a9b0f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2356,6 +2356,7 @@ static inline void pcibios_penalize_isa_irq(int irq, int active) {}
 int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
 resource_size_t pcibios_default_alignment(void);
+void arch_wait_pcibios_init_complete(void);
 
 #if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 extern int pci_create_resource_files(struct pci_dev *dev);
-- 
2.47.0


