Return-Path: <linux-pci+bounces-24663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BD1A6F578
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 12:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452577A39EA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96E22561DC;
	Tue, 25 Mar 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgLXv+cB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA262566C5
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902895; cv=none; b=OukByJ+v40Lp58qb3OQZLfLlGsejRuoFu+3DYOf9Kv23eyoZceqatYlRi5JJV9G+hTqhnN8MbYl+TbhHbiLGC0phqMuf+pVnLyvIH6xRRsnVUYaeMkryShFFDhuZmxlovPij2Jn6itHnNYDI1SEDttv/F4b+entdKTu9Fho1u+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902895; c=relaxed/simple;
	bh=/4MN9pL13QS8WSvmrDAkH9tjZnUJYGKfLLZEMOGkYI4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qJeZotMoK0uI4DGnc24iKUTiido4M821ueCzgcEEpK7OdbSwIzfSrgGXWMGROU9TEICeFnG7qfPFzUXDBOm/DYB3ZA60prcoZNZuykyk7cMKUWs2Xxvxv+oW4+1u+CDF0++RI7dT1wOB4fNx0KYmGRErVQOdk/UD/8Di3WYkx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MgLXv+cB; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5259327a937so2148145e0c.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742902892; x=1743507692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GojWv6JgO00ZhMt6mOebWUL6XxDfc/RWWGCpH5UC34U=;
        b=MgLXv+cB28foKrGLTatBjcBBVIBvdKNDE/yoCExu1J7VUIPu0WgZsxMobKaqeekO07
         +vINemjTkv1e6VVZPUyaoj+Bz2FTBTVaxnqTwAuTyUPqoHsifCcOMwxPxWznJ0vWScuk
         7mvozJuvnQGNorY0y0rD7e2iAga/OJpGq/8dc/YV8AwS9IpLb+Fh4u2uYhjl5ITafmkH
         5OJ/ZhKLVqX01/Bww+fAd0NAQMJZiM0aR9IZ41mREVruHreSbZgsnyc8RzmRvqYOZTd4
         B0lw67JonW+lzQkU2Ix2UTj9fj4K0x95vCTvua4NgK5uzhoI02PsgKeB2TKagljd7Fv8
         OPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902892; x=1743507692;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GojWv6JgO00ZhMt6mOebWUL6XxDfc/RWWGCpH5UC34U=;
        b=EbbiTH9QbBMY9js7Kzl+Mgq0CJ22dSZHiubFpn6Z7Onv2IrdJkJXfzrNhbUPwtPWQn
         QRKp3VNwwz8YPtI1/Df28f+LWzZ+x5Cr6xqO4uvUQ7fpVtCghTO9xkG6SndGWzglyjKz
         /xC3P/xLMH+9y0lmp++Li1kr0zubIb8VPyDRvBeMzaP3FEczKPlBGB98kK4FZXrv8QLs
         GBJU0NCZFmpXTT9u9Qwhm5PMmo7Vp/iDBRdyt7Rct28ZplaBnmXRCOE9X09hDYVZlOkF
         Pkv35idIH92udC2CLxlEGibE12Mbe8+f4UR5wBQL1Vd3SYPdu8XPAfJqUYyPsSfMRqFs
         zh9g==
X-Gm-Message-State: AOJu0Yzm9HKaXHt9mqej+Y+fN5wcTPo1WgcOx7WD84qpdW9BrVydCTHd
	yoXwPisd43FNH0Xv+X6zCJESpTwWUGF9ypTmL4kuDYc8jBmulxf4G8FqUwu6m2QxH5g8cxFAtWb
	yVsFMi6UWn0TqQvacbC41S1EGKxB9FbhxAMsEaxENZjr5VxVfcxI=
X-Gm-Gg: ASbGncshKT1OJfm3BANbdpfoc1HdLG+F7IDgldGhCaF2OLfObvVfNtqdOzqxwMOZVwV
	YYj0OIO9ovkrJJUmbj7hlJsPu9tV4n1vm/ZHc4c8P0LGZmeyKamar3/ttpKWITeD9doWreSdan5
	lhaozrViyNuORm9SvHFmMI/l/51CWqA46uTxaifcC7ju6RGtPRNBE5+EOcryg=
X-Google-Smtp-Source: AGHT+IErnLB8k2eURQkQuvonw7hDaTgDK/6MY679H/xblBZRcECFv8MSDYwthPn/gDiugNBls/DTd74DC7XLhdBeVrs=
X-Received: by 2002:a05:6122:2783:b0:51b:a11f:cbdb with SMTP id
 71dfb90a1353d-525a833b0cfmr11322920e0c.4.1742902892035; Tue, 25 Mar 2025
 04:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Mar 2025 17:11:20 +0530
X-Gm-Features: AQ5f1Jp4MnK8M9WIj6QfiQc4fPhqZDUJiPB_52yu7nH9UEpCQdOPXm-gf5TLGEQ
Message-ID: <CA+G9fYs4-4y=edxddERXQ_fMsW_nUJU+V0bSMHFDL3St7NiLxQ@mail.gmail.com>
Subject: next-20250324: x86_64: BUG: kernel NULL pointer dereference __pci_enable_msi_range
To: PCI <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, shivamurthy.shastri@linutronix.de, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Regressions on x86_64 boot failed with Linux next-20250324 tag kernel
6.14.0-rc7-next-20250324

First seen on the next-20250324
 Good: next-20250321
 Bad:  next-20250324 ..next-20250325

Regressions found on x86_84:
 - boot

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Boot regression: x86 boot fail kernel panic __pci_enable_msi_range
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Boot log
<1>[    1.525485] BUG: kernel NULL pointer dereference, address:
0000000000000002
<1>[    1.525573] #PF: supervisor read access in kernel mode
<1>[    1.525573] #PF: error_code(0x0000) - not-present page
<6>[    1.525573] PGD 0 P4D 0
<4>[    1.525573] Oops: Oops: 0000 [#1] SMP PTI
<4>[    1.525573] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.14.0-rc7-next-20250324 #1 PREEMPT(voluntary)
<4>[    1.525573] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
<4>[    1.525573] RIP: 0010:__pci_enable_msi_range+0x306/0x6b0
<4>[    1.525573] Code: ff ff ff e8 1c 05 fe ff f6 83 21 08 00 00 10
0f b7 85 6e ff ff ff 74 0c 0d 00 01 00 00 66 89 85 6e ff ff ff 8b 8d
68 ff ff ff <41> f6 44 24 02 40 74 0c 25 ff fe 00 00 66 89 85 6e ff ff
ff 89 8d
<4>[    1.525573] RSP: 0000:ffffa83b00013740 EFLAGS: 00010246
<4>[    1.525573] RAX: 0000000000000080 RBX: ffffa11c8023e000 RCX:
0000000000000001
<4>[    1.525573] RDX: 0000000000000000 RSI: ffffffff9e60c683 RDI:
ffffffff9e6519a8
<4>[    1.525573] RBP: ffffa83b00013810 R08: 0000000000000002 R09:
ffffa83b0001370c
<4>[    1.525573] R10: 0000000000000001 R11: ffffffff9e60c5b0 R12:
0000000000000000
<4>[    1.525573] R13: 0000000000000000 R14: 0000000000000001 R15:
ffffa11c8023e000
<4>[    1.525573] FS:  0000000000000000(0000)
GS:ffffa11d5c339000(0000) knlGS:0000000000000000
<4>[    1.525573] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    1.525573] CR2: 0000000000000002 CR3: 000000007d844000 CR4:
00000000000006f0
<4>[    1.525573] Call Trace:
<4>[    1.525573]  <TASK>
<4>[    1.525573]  ? __die_body+0xb4/0xc0
<4>[    1.525573]  ? __die+0x2e/0x40
<4>[    1.525573]  ? page_fault_oops+0x3ae/0x410
<4>[    1.525573]  ? kernelmode_fixup_or_oops+0x54/0x70
<4>[    1.525573]  ? __bad_area_nosemaphore+0x52/0x240
<4>[    1.525573]  ? bad_area_nosemaphore+0x16/0x20
<4>[    1.525573]  ? do_user_addr_fault+0x738/0x7a0
<4>[    1.525573]  ? irqentry_enter+0x2d/0x50
<4>[    1.525573]  ? exc_page_fault+0x4d/0x120
<4>[    1.525573]  ? exc_page_fault+0x70/0x120
<4>[    1.525573]  ? asm_exc_page_fault+0x2b/0x30
<4>[    1.525573]  ? __pfx_pci_conf1_read+0x10/0x10
<4>[    1.525573]  ? pci_conf1_read+0xd3/0xf0
<4>[    1.525573]  ? _raw_spin_unlock_irqrestore+0x28/0x50
<4>[    1.525573]  ? __pci_enable_msi_range+0x306/0x6b0
<4>[    1.525573]  ? _raw_spin_unlock_irqrestore+0x28/0x50
<4>[    1.525573]  pci_alloc_irq_vectors_affinity+0xbf/0x140
<4>[    1.525573]  pci_alloc_irq_vectors+0x15/0x20
<4>[    1.525573]  ahci_init_irq+0x90/0xc0
<4>[    1.525573]  ahci_init_one+0x82c/0xd10
<4>[    1.525573]  pci_device_probe+0x198/0x230
<4>[    1.525573]  really_probe+0x146/0x450
<4>[    1.525573]  __driver_probe_device+0x7a/0xf0
<4>[    1.525573]  driver_probe_device+0x24/0x190
<4>[    1.525573]  __driver_attach+0x104/0x250
<4>[    1.525573]  ? __pfx___driver_attach+0x10/0x10
<4>[    1.525573]  bus_for_each_dev+0x10e/0x160
<4>[    1.525573]  driver_attach+0x22/0x30
<4>[    1.525573]  bus_add_driver+0x175/0x2c0
<4>[    1.525573]  driver_register+0x65/0xf0
<4>[    1.525573]  ? __pfx_ahci_pci_driver_init+0x10/0x10
<4>[    1.525573]  __pci_register_driver+0x68/0x70
<4>[    1.525573]  ahci_pci_driver_init+0x22/0x30
<4>[    1.525573]  do_one_initcall+0x121/0x330
<4>[    1.525573]  ? alloc_pages_mpol+0x170/0x1c0
<4>[    1.525573]  ? alloc_pages_mpol+0x170/0x1c0
<4>[    1.525573]  ? trace_preempt_on+0x12/0x80
<4>[    1.525573]  ? alloc_pages_mpol+0x170/0x1c0
<4>[    1.525573]  ? preempt_count_sub+0x63/0x80
<4>[    1.525573]  ? alloc_pages_mpol+0x170/0x1c0
<4>[    1.525573]  ? trace_hardirqs_on+0x29/0xa0
<4>[    1.525573]  ? irqentry_exit+0x57/0x60
<4>[    1.525573]  ? sysvec_apic_timer_interrupt+0x52/0x90
<4>[    1.525573]  ? next_arg+0xcd/0x150
<4>[    1.525573]  ? next_arg+0x138/0x150
<4>[    1.525573]  ? parse_args+0x16e/0x440
<4>[    1.525573]  do_initcall_level+0x80/0xf0
<4>[    1.525573]  do_initcalls+0x48/0x80
<4>[    1.525573]  do_basic_setup+0x1d/0x30
<4>[    1.525573]  kernel_init_freeable+0x10c/0x180
<4>[    1.525573]  ? __pfx_kernel_init+0x10/0x10
<4>[    1.525573]  kernel_init+0x1e/0x130
<4>[    1.525573]  ret_from_fork+0x45/0x50
<4>[    1.525573]  ? __pfx_kernel_init+0x10/0x10
<4>[    1.525573]  ret_from_fork_asm+0x1a/0x30
<4>[    1.525573]  </TASK>
<4>[    1.525573] Modules linked in:
<4>[    1.525573] CR2: 0000000000000002
<4>[    1.525573] ---[ end trace 0000000000000000 ]---
<4>[    1.525573] RIP: 0010:__pci_enable_msi_range+0x306/0x6b0
<4>[    1.525573] Code: ff ff ff e8 1c 05 fe ff f6 83 21 08 00 00 10
0f b7 85 6e ff ff ff 74 0c 0d 00 01 00 00 66 89 85 6e ff ff ff 8b 8d
68 ff ff ff <41> f6 44 24 02 40 74 0c 25 ff fe 00 00 66 89 85 6e ff ff
ff 89 8d
<4>[    1.525573] RSP: 0000:ffffa83b00013740 EFLAGS: 00010246
<4>[    1.525573] RAX: 0000000000000080 RBX: ffffa11c8023e000 RCX:
0000000000000001
<4>[    1.525573] RDX: 0000000000000000 RSI: ffffffff9e60c683 RDI:
ffffffff9e6519a8
<4>[    1.525573] RBP: ffffa83b00013810 R08: 0000000000000002 R09:
ffffa83b0001370c
<4>[    1.525573] R10: 0000000000000001 R11: ffffffff9e60c5b0 R12:
0000000000000000
<4>[    1.525573] R13: 0000000000000000 R14: 0000000000000001 R15:
ffffa11c8023e000
<4>[    1.525573] FS:  0000000000000000(0000)
GS:ffffa11d5c339000(0000) knlGS:0000000000000000
<4>[    1.525573] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    1.525573] CR2: 0000000000000002 CR3: 000000007d844000 CR4:
00000000000006f0
<6>[    1.525573] note: swapper/0[1] exited with irqs disabled
<0>[    1.553459] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000009
<0>[    1.553844] Kernel Offset: 0x1c000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
<0>[    1.553844] ---[ end Kernel panic - not syncing: Attempted to
kill init! exitcode=0x00000009 ]---


## Source
* Kernel version: 6.14.0-rc7-next-20250324
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 882a18c2c14fc79adb30fe57a9758283aa20efaa
* Git describe: next-20250324
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250324/

## Test
* Test log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250324/testrun/27735988/suite/boot/test/clang-20-lkftconfig/log
* Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250324/testrun/27735988/suite/boot/test/clang-20-lkftconfig/history/
* Test details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250324/testrun/27735936/suite/boot/test/clang-20-lkftconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ulLSNJUAxmyv6UZdUMeoptIZNn/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ulLSNJUAxmyv6UZdUMeoptIZNn/config


--
Linaro LKFT
https://lkft.linaro.org

