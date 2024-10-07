Return-Path: <linux-pci+bounces-13976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F88B9934BB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28B11F248B3
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC011DD522;
	Mon,  7 Oct 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZwX1yPj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F518BBB2;
	Mon,  7 Oct 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321604; cv=none; b=u+PlCn563hcm8JKWgDpytvf6ukAdwDsYBZWt7P10AcSXKwWfOK3Y21z7Qrop3BNjXTTayIDCSxYwlmoNEmSTnbO3KPc5/zJS8OtJjcc9oskd4T/95VQYVifZ3oG90mhKQLH+TAbkmHN82d4nS1trIV/CITkHBpYRFNz/Nnvw1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321604; c=relaxed/simple;
	bh=/6cuJXSJ0+dZhbzuOH/2Sf0T5uix55JR/2eAWrJmBOg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AZ2ehN4rRx8iAU4Wq3CemHra3pfQzZpoAiAuWCl7hMfHZ5ZKKoaYmsylL+MZaA/D2yK6oPI6+hMDVBOiIcRSJ2kJfNBnWbZ4WQqud4XsZdyhobgSzBksVcpBSRwF+na/mR9o17JHDsVBlR3V4Yn9WuHvR985nCSO0pS4ENS97CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZwX1yPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BDBC4CEC6;
	Mon,  7 Oct 2024 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728321603;
	bh=/6cuJXSJ0+dZhbzuOH/2Sf0T5uix55JR/2eAWrJmBOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VZwX1yPjSE6J8xTDvfazfXKkn1UfV97NHHjp9HD/UxVVUxi8Nazs4mAF//qumIiuw
	 JlhEX+KOLJE0l0Bq3Nn7iqQRbEzGd3k65AWPd5kpa2533x5YNUUHx+o9BU3SZV5Dm7
	 XOTFAcudNg1Dv3gE+Ogmr6tMKLxFCw9zpBoOfn6XeXvNKKl3nydKoy3pvXJc8gYwth
	 2pJbVuAT6l/6BcAbr4kqj07sePlFUABBZn4HcLLkjX+s7Ki946QcWH53ZN6a9Dkf1k
	 A339NJZGFg6XmnQhLSmIeVQlD6rEk/TebwQhvSYMwqqdqoJbNlG8PMEAdsSSC9XM07
	 pGtpGG52hJIcQ==
Date: Mon, 7 Oct 2024 12:20:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	Marcin =?utf-8?B?TWlyb3PFgmF3?= <marcin@mejor.pl>
Subject: Re: [Bug 219349] New: RIP: 0010:pci_for_each_dma_alias
 (./include/linux/pci.h:692 drivers/pci/search.c:41)
Message-ID: <20241007172001.GA441460@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05a69933-cd90-4d68-8eb0-95013d3a98c9@mejor.pl>

[+to Lu, author of 2031c469f816]

On Fri, Oct 04, 2024 at 07:55:29AM +0200, Marcin Mirosław wrote:
> W dniu 03.10.2024 o 23:39, Bjorn Helgaas pisze:
> > On Thu, Oct 03, 2024 at 08:15:16PM +0000, bugzilla-daemon@kernel.org wrote:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=219349
> > > 
> > >             Summary: RIP: 0010:pci_for_each_dma_alias
> > >                      (./include/linux/pci.h:692 drivers/pci/search.c:41)
> > >      Kernel Version: 6.12.0-rc1  8c245fe7dde3
> > >          Regression: Yes
> > > 
> > > Created attachment 306959
> > >    --> https://bugzilla.kernel.org/attachment.cgi?id=306959&action=edit
> > > lspci -vv
> > > 
> > > Hello,
> > > I see BUG: kernel NULL pointer dereference using kernel 6.12.0-rc1 (actually at
> > > 8c245fe7dde3 but don't know what is first bad commit).
> > 
> > Thanks very much for this report!  You marked this as a regression;
> > Marcin, do you know the most recent kernel where you did not see this
> > issue?
> 
> Kernel 6.11 works correctly, I didn't narrow suspect commit yet.

Update from the bugzilla:

Marcin bisected the problem to 2031c469f816 ("iommu/vt-d: Add support
for static identity domain") and verified that reverting that commit
from v6.12-rc2 avoids the problem.

> > > RPC: Registered tcp NFSv4.1 backchannel transport module.
> > > intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)#012 SUBSYSTEM=pci#012
> > > DEVICE=+pci:0000:00:15.0
> > > platform idma64.0: Adding to iommu group 12#012 SUBSYSTEM=platform#012
> > > DEVICE=+platform:idma64.0
> > > BUG: kernel NULL pointer dereference, address: 00000000000000d8
> > > #PF: supervisor read access in kernel mode
> > > #PF: error_code(0x0000) - not-present page
> > > PGD 0 P4D 0
> > > Oops: Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
> > > CPU: 0 UID: 0 PID: 430 Comm: (udev-worker) Not tainted
> > > 6.12.0-rc1-00113-g8c245fe7dde3 #50
> > > Hardware name: MSI MS-7982/B150M PRO-VDH (MS-7982), BIOS 3.H0 07/10/2018
> > > RIP: 0010:pci_for_each_dma_alias (./include/linux/pci.h:692
> > > drivers/pci/search.c:41)
> > > Code: 00 0f 1f 40 00 0f 1f 44 00 00 41 56 41 55 41 54 49 89 d4 55 48 89 f5 53
> > > e8 18 d2 ff ff 4c 89 e2 48 89 c3 48 8b 40 10 48 89 df <0f> b6 b0 d8 00 00 00 c1
> > > e6 08 66 0b 73 38 0f b7 f6 ff d5 85 c0 41
> > > All code
> > > ========
> > >     0:   00 0f                   add    %cl,(%rdi)
> > >     2:   1f                      (bad)
> > >     3:   40 00 0f                rex add %cl,(%rdi)
> > >     6:   1f                      (bad)
> > >     7:   44 00 00                add    %r8b,(%rax)
> > >     a:   41 56                   push   %r14
> > >     c:   41 55                   push   %r13
> > >     e:   41 54                   push   %r12
> > >    10:   49 89 d4                mov    %rdx,%r12
> > >    13:   55                      push   %rbp
> > >    14:   48 89 f5                mov    %rsi,%rbp
> > >    17:   53                      push   %rbx
> > >    18:   e8 18 d2 ff ff          call   0xffffffffffffd235
> > >    1d:   4c 89 e2                mov    %r12,%rdx
> > >    20:   48 89 c3                mov    %rax,%rbx
> > >    23:   48 8b 40 10             mov    0x10(%rax),%rax
> > >    27:   48 89 df                mov    %rbx,%rdi
> > >    2a:*  0f b6 b0 d8 00 00 00    movzbl 0xd8(%rax),%esi          <-- trapping
> > > instruction
> > >    31:   c1 e6 08                shl    $0x8,%esi
> > >    34:   66 0b 73 38             or     0x38(%rbx),%si
> > >    38:   0f b7 f6                movzwl %si,%esi
> > >    3b:   ff d5                   call   *%rbp
> > >    3d:   85 c0                   test   %eax,%eax
> > >    3f:   41                      rex.B
> > > 
> > > Code starting with the faulting instruction
> > > ===========================================
> > >     0:   0f b6 b0 d8 00 00 00    movzbl 0xd8(%rax),%esi
> > >     7:   c1 e6 08                shl    $0x8,%esi
> > >     a:   66 0b 73 38             or     0x38(%rbx),%si
> > >     e:   0f b7 f6                movzwl %si,%esi
> > >    11:   ff d5                   call   *%rbp
> > >    13:   85 c0                   test   %eax,%eax
> > >    15:   41                      rex.B
> > > RSP: 0018:ffffbff6006bb3a8 EFLAGS: 00010296
> > > RAX: 0000000000000000 RBX: ffff9dd828880348 RCX: 0000000000000000
> > > RDX: ffff9dd80f838ea0 RSI: ffffffffac8045b0 RDI: ffff9dd828880348
> > > RBP: ffffffffac8045b0 R08: 0000000000000000 R09: 0000000200000025
> > > R10: 000000000000007c R11: 00000000000001f4 R12: ffff9dd80f838ea0
> > > R13: ffff9dd826ab9700 R14: 0000000000000001 R15: 0000000000000001
> > > FS:  00007fe4921ab5c0(0000) GS:ffff9ddb5c600000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00000000000000d8 CR3: 000000010fa9b004 CR4: 00000000003706f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >   <TASK>
> > >   ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
> > >   ? page_fault_oops (arch/x86/mm/fault.c:715)
> > >   ? do_user_addr_fault (./include/linux/kprobes.h:589 (discriminator 1)
> > > arch/x86/mm/fault.c:1240 (discriminator 1))
> > >   ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:152
> > > kernel/locking/spinlock.c:194)
> > >   ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37
> > > ./arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489
> > > arch/x86/mm/fault.c:1539)
> > >   ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
> > >   ? domain_context_clear_one (drivers/iommu/intel/iommu.c:3328)
> > >   ? domain_context_clear_one (drivers/iommu/intel/iommu.c:3328)
> > >   ? pci_for_each_dma_alias (./include/linux/pci.h:692 drivers/pci/search.c:41)
> > >   ? pci_for_each_dma_alias (drivers/pci/search.c:41 (discriminator 1))
> > >   device_block_translation (drivers/iommu/intel/iommu.c:3370)
> > >   intel_iommu_attach_device (drivers/iommu/intel/iommu.c:3635)
> > >   __iommu_attach_device (drivers/iommu/iommu.c:2084)
> > >   __iommu_device_set_domain (drivers/iommu/iommu.c:2272)
> > 
> > I suspect this path:
> > 
> >    __iommu_device_set_domain
> >      __iommu_attach_device
> >        domain->ops->attach_dev
> >          intel_iommu_attach_device
> >            device_block_translation
> >              domain_context_clear
> >                if (!dev_is_pci(info->dev))
> >                  domain_context_clear_one
> >                pci_for_each_dma_alias
> > 
> > and 9a16ab9d6402 ("iommu/vt-d: Make context clearing consistent with
> > context mapping") looks a little suspicious to me since
> > domain_context_clear() now calls domain_context_clear_one() for
> > non-PCI devices, but then goes on to also use pci_for_each_dma_alias()
> > for ALL devices, even non-PCI ones.
> > 
> > But 9a16ab9d6402 appeared in v6.7-rc4, so it's been around a while.
> > Maybe a more recent change added non-PCI devices into the mix, so
> > previously we only got there with PCI devices?
> > 
> > >   iommu_setup_default_domain (drivers/iommu/iommu.c:2326 (discriminator 2)
> > > drivers/iommu/iommu.c:2992 (discriminator 2))
> > >   __iommu_probe_device (drivers/iommu/iommu.c:567)
> > >   iommu_probe_device (drivers/iommu/iommu.c:604)
> > >   iommu_bus_notifier (drivers/iommu/iommu.c:1668 drivers/iommu/iommu.c:1659)
> > >   notifier_call_chain (kernel/notifier.c:95)
> > >   blocking_notifier_call_chain (kernel/notifier.c:389 kernel/notifier.c:376)
> > >   bus_notify (./include/linux/kobject.h:193 drivers/base/base.h:73
> > > drivers/base/bus.c:999)
> > >   device_add (drivers/base/core.c:3656)
> > >   platform_device_add (drivers/base/platform.c:717)
> > >   mfd_add_device (drivers/mfd/mfd-core.c:274) mfd_core
> > >   ? alloc_inode (fs/inode.c:265)
> > >   ? make_kgid (kernel/user_namespace.c:483)
> > >   ? inode_init_always (fs/inode.c:219)
> > >   mfd_add_devices (drivers/mfd/mfd-core.c:329) mfd_core
> > >   intel_lpss_probe (drivers/mfd/intel-lpss.c:443 drivers/mfd/intel-lpss.c:390)
> > > intel_lpss
> > >   ? _raw_spin_lock_irqsave (./arch/x86/include/asm/paravirt.h:584
> > > ./arch/x86/include/asm/qspinlock.h:51 ./include/asm-generic/qspinlock.h:114
> > > ./include/linux/spinlock.h:187 ./include/linux/spinlock_api_smp.h:111
> > > kernel/locking/spinlock.c:162)
> > >   ? pci_conf1_write (arch/x86/pci/direct.c:78)
> > >   intel_lpss_pci_probe (drivers/mfd/intel-lpss-pci.c:80) intel_lpss_pci
> > >   local_pci_probe (drivers/pci/pci-driver.c:325)
> > >   pci_device_probe (drivers/pci/pci-driver.c:392 (discriminator 1)
> > > drivers/pci/pci-driver.c:417 (discriminator 1) drivers/pci/pci-driver.c:451
> > > (discriminator 1))
> > >   really_probe (drivers/base/dd.c:581 drivers/base/dd.c:658)
> > >   ? __device_attach_driver (drivers/base/dd.c:1157)
> > >   __driver_probe_device (drivers/base/dd.c:800)
> > >   driver_probe_device (drivers/base/dd.c:831)
> > >   __driver_attach (drivers/base/dd.c:1217 drivers/base/dd.c:1156)
> > >   bus_for_each_dev (drivers/base/bus.c:369)
> > >   bus_add_driver (drivers/base/bus.c:676)
> > >   driver_register (drivers/base/driver.c:247)
> > >   ? 0xffffffffc061b000
> > >   do_one_initcall (init/main.c:1269)
> > >   do_init_module (kernel/module/main.c:2544)
> > >   init_module_from_file (kernel/module/main.c:3199)
> > >   idempotent_init_module (kernel/module/main.c:3210)
> > >   __x64_sys_finit_module (./include/linux/file.h:68 kernel/module/main.c:3238
> > > kernel/module/main.c:3220 kernel/module/main.c:3220)
> > >   do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1)
> > > arch/x86/entry/common.c:83 (discriminator 1))
> > >   ? mntput_no_expire (fs/namespace.c:1460)
> > >   ? terminate_walk (fs/namei.c:693 (discriminator 1))
> > >   ? path_openat (fs/namei.c:3934)
> > >   ? do_filp_open (fs/namei.c:3961 (discriminator 2))
> > >   ? copy_from_kernel_nofault (mm/maccess.c:31 (discriminator 1))
> > >   ? kmem_cache_alloc_noprof (mm/slub.c:494 mm/slub.c:539 mm/slub.c:528
> > > mm/slub.c:3964 mm/slub.c:4123 mm/slub.c:4142)
> > >   ? do_sys_openat2 (fs/open.c:1424)
> > >   ? syscall_exit_to_user_mode (./arch/x86/include/asm/processor.h:701
> > > ./arch/x86/include/asm/entry-common.h:100 ./include/linux/entry-common.h:364
> > > kernel/entry/common.c:220)
> > >   ? do_syscall_64 (arch/x86/entry/common.c:102)
> > >   ? do_syscall_64 (arch/x86/entry/common.c:102)
> > >   ? do_syscall_64 (arch/x86/entry/common.c:102)
> > >   ? do_syscall_64 (arch/x86/entry/common.c:102)
> > >   ? syscall_exit_to_user_mode (./arch/x86/include/asm/processor.h:701
> > > ./arch/x86/include/asm/entry-common.h:100 ./include/linux/entry-common.h:364
> > > kernel/entry/common.c:220)
> > >   ? do_syscall_64 (arch/x86/entry/common.c:102)
> > >   ? syscall_exit_to_user_mode (./arch/x86/include/asm/processor.h:701
> > > ./arch/x86/include/asm/entry-common.h:100 ./include/linux/entry-common.h:364
> > > kernel/entry/common.c:220)
> > >   ? do_syscall_64 (arch/x86/entry/common.c:102)
> > >   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > > RIP: 0033:0x7fe49238eb8d
> > > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48
> > > 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01
> > > c3 48 8b 0d 6b 72 0c 00 f7 d8 64 89 01 48
> > > All code
> > > ========
> > >     0:   ff c3                   inc    %ebx
> > >     2:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
> > >     9:   00 00 00
> > >     c:   90                      nop
> > >     d:   f3 0f 1e fa             endbr64
> > >    11:   48 89 f8                mov    %rdi,%rax
> > >    14:   48 89 f7                mov    %rsi,%rdi
> > >    17:   48 89 d6                mov    %rdx,%rsi
> > >    1a:   48 89 ca                mov    %rcx,%rdx
> > >    1d:   4d 89 c2                mov    %r8,%r10
> > >    20:   4d 89 c8                mov    %r9,%r8
> > >    23:   4c 8b 4c 24 08          mov    0x8(%rsp),%r9
> > >    28:   0f 05                   syscall
> > >    2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax         <--
> > > trapping instruction
> > >    30:   73 01                   jae    0x33
> > >    32:   c3                      ret
> > >    33:   48 8b 0d 6b 72 0c 00    mov    0xc726b(%rip),%rcx        # 0xc72a5
> > >    3a:   f7 d8                   neg    %eax
> > >    3c:   64 89 01                mov    %eax,%fs:(%rcx)
> > >    3f:   48                      rex.W
> > > 
> > > Code starting with the faulting instruction
> > > ===========================================
> > >     0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> > >     6:   73 01                   jae    0x9
> > >     8:   c3                      ret
> > >     9:   48 8b 0d 6b 72 0c 00    mov    0xc726b(%rip),%rcx        # 0xc727b
> > >    10:   f7 d8                   neg    %eax
> > >    12:   64 89 01                mov    %eax,%fs:(%rcx)
> > >    15:   48                      rex.W
> > > RSP: 002b:00007ffdf72f16f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> > > RAX: ffffffffffffffda RBX: 000055b0dae03330 RCX: 00007fe49238eb8d
> > > RDX: 0000000000000004 RSI: 00007fe49252231b RDI: 000000000000000d
> > > RBP: 0000000000000004 R08: 000055b0dae05940 R09: 000055b0dae03e80
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe49252231b
> > > R13: 0000000000020000 R14: 000055b0dadd00e0 R15: 000055b0dae03330
> > >   </TASK>
> > > Modules linked in: intel_lpss_pci(+) intel_lpss idma64 raid_class virt_dma
> > > scsi_transport_sas mfd_core sunrpc dm_mirror dm_region_hash dm_log dm_mod btrfs
> > > blake2b_generic
> > > CR2: 00000000000000d8
> > > ---[ end trace 0000000000000000 ]---
> > > RIP: 0010:pci_for_each_dma_alias (./include/linux/pci.h:692
> > > drivers/pci/search.c:41)
> > > Code: 00 0f 1f 40 00 0f 1f 44 00 00 41 56 41 55 41 54 49 89 d4 55 48 89 f5 53
> > > e8 18 d2 ff ff 4c 89 e2 48 89 c3 48 8b 40 10 48 89 df <0f> b6 b0 d8 00 00 00 c1
> > > e6 08 66 0b 73 38 0f b7 f6 ff d5 85 c0 41
> > > All code
> > > ========
> > >     0:   00 0f                   add    %cl,(%rdi)
> > >     2:   1f                      (bad)
> > >     3:   40 00 0f                rex add %cl,(%rdi)
> > >     6:   1f                      (bad)
> > >     7:   44 00 00                add    %r8b,(%rax)
> > >     a:   41 56                   push   %r14
> > >     c:   41 55                   push   %r13
> > >     e:   41 54                   push   %r12
> > >    10:   49 89 d4                mov    %rdx,%r12
> > >    13:   55                      push   %rbp
> > >    14:   48 89 f5                mov    %rsi,%rbp
> > >    17:   53                      push   %rbx
> > >    18:   e8 18 d2 ff ff          call   0xffffffffffffd235
> > >    1d:   4c 89 e2                mov    %r12,%rdx
> > >    20:   48 89 c3                mov    %rax,%rbx
> > >    23:   48 8b 40 10             mov    0x10(%rax),%rax
> > >    27:   48 89 df                mov    %rbx,%rdi
> > >    2a:*  0f b6 b0 d8 00 00 00    movzbl 0xd8(%rax),%esi          <-- trapping
> > > instruction
> > >    31:   c1 e6 08                shl    $0x8,%esi
> > >    34:   66 0b 73 38             or     0x38(%rbx),%si
> > >    38:   0f b7 f6                movzwl %si,%esi
> > >    3b:   ff d5                   call   *%rbp
> > >    3d:   85 c0                   test   %eax,%eax
> > >    3f:   41                      rex.B
> > > 
> > > Code starting with the faulting instruction
> > >     0:   0f b6 b0 d8 00 00 00    movzbl 0xd8(%rax),%esi
> > >     7:   c1 e6 08                shl    $0x8,%esi
> > >     a:   66 0b 73 38             or     0x38(%rbx),%si
> > >     e:   0f b7 f6                movzwl %si,%esi
> > >    11:   ff d5                   call   *%rbp
> > >    13:   85 c0                   test   %eax,%eax
> > >    15:   41                      rex.B
> > > RSP: 0018:ffffbff6006bb3a8 EFLAGS: 00010296
> > > RAX: 0000000000000000 RBX: ffff9dd828880348 RCX: 0000000000000000
> > > RDX: ffff9dd80f838ea0 RSI: ffffffffac8045b0 RDI: ffff9dd828880348
> > > RBP: ffffffffac8045b0 R08: 0000000000000000 R09: 0000000200000025
> > > R10: 000000000000007c R11: 00000000000001f4 R12: ffff9dd80f838ea0
> > > R13: ffff9dd826ab9700 R14: 0000000000000001 R15: 0000000000000001
> > > FS:  00007fe4921ab5c0(0000) GS:ffff9ddb5c600000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00000000000000d8 CR3: 000000010fa9b004 CR4: 00000000003706f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > note: (udev-worker)[430] exited with irqs disabled
> > > mpt3sas version 48.100.00.00 loaded
> > > md/raid1: md22: active with 2 out of 2 mirrors
> > > md22: detected capacity change from 0 to 62912512
> > 
> 
> 
> Marcin
> 

