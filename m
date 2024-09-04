Return-Path: <linux-pci+bounces-12777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C396C5E3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5930B1F234DC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C81E1A0B;
	Wed,  4 Sep 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWcdxymU"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727FA1E00AF
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472790; cv=none; b=CzW74KLti1W+k7kvQLoruD/Eifl6+Yt5L1y7xBRuzcGrvIlhZmGF78XWfYDh997rgrg7xeFw3LfiPHMZeE98LtM/Soa8tubToELfAvTHiJBNm/nyig2HqxYEN/+bpKuWslXrKOvImye0Dq1AoBbn4Vq+bMib6VxLMlIB5fpcct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472790; c=relaxed/simple;
	bh=LNsjyYpRLYKmaOoZYFt7a6yVFFHLKuyn19W4dBscXVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgALiMSudjGm16Nml5o5AFfmCiJWEfipegzmf1/neSi7WIL+JvkEBqjAUpKf3Fj2Ia+pSp87XPbwihz/zBKqPlbbJTSKat/3kHJg0L/HVB4HfCUGVISfDIUzk50oO3wSyYSptb6GTdVPPl6S8P0CSUUe8CYB/Qv+8f7NCyIxgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWcdxymU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725472787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsVcMtYUhB/J1lgh5WzPGIx1plvQhA+HpWBruuNcJgY=;
	b=cWcdxymULiHxvv90gOoBI7fGAfN+3NItrq7ryjjNfHhz1FhZRX/sN55AA4giy3ZfsNQ6Bh
	jbW71V0ZqqV2Mi9FX3Vd7j2a04UW9VDGJT5A1ZL2J2fZnmUpCL2GDp7F4cVK4lwQT281+v
	mbipuuJZnb8GlhhO6XuuAnglXzVXk6I=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-TU84QsZ1OQu9BBuI2KX6Rw-1; Wed, 04 Sep 2024 13:59:46 -0400
X-MC-Unique: TU84QsZ1OQu9BBuI2KX6Rw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f703d46c3so1920985ab.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2024 10:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472785; x=1726077585;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsVcMtYUhB/J1lgh5WzPGIx1plvQhA+HpWBruuNcJgY=;
        b=fs8cWYRv4BlfhH6EwfTY+zQjFp/E1iopRXFlCG0uAXkH0q8R79Jimj66gAf4jmkTII
         sUTnkV6nsguyDCOBUL/IO+beF89YZFE4MNOhcigG9YbbrRTU1eUAZFgUWSvUz4qQSOJ1
         xznEp3GsSj3hbyZAyb34RgKK0dRMx2IYJ89Xe5oZ3gucf8umzXyyzBZpDWbwcnkBAxBP
         9DmsIQf7X1w5ZL26l7vAsd/vRNz1YTBEsULkruI73ilxugSkfibBoA8CqvGfjN3x82kV
         V5TOTrWDyS9fd1B2V8GMemN6wDfjDmGvRxFjFZYfAFn/UC0hGNr4dESEncvcAd0e6r0W
         4Maw==
X-Forwarded-Encrypted: i=1; AJvYcCVYOUdKSSdgH+IZtMu0M2HVQKB6jFs6S4VeGllo2nF8wiYxk/74z8eLcJX89SxCbFln9XJlOFn6Bn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYi/7NuGhTolwriB2unnrRzCw91E8Qp47wialkT9tQ/yj6ICKN
	QkKVKBoNvkDUtZnfd4GbPrG439h6vETiFaYGXM0RmKwyAvcFClXd3/gt/mXSN8RwDERRRc8j6EB
	DjAbCoHHLQAXeU1BjIIA4mzjByAXwv6i9FvajiDr9LtIRVdKTfola5aSx3w==
X-Received: by 2002:a05:6e02:1fe1:b0:39f:74f9:f698 with SMTP id e9e14a558f8ab-39f74f9f815mr17790745ab.2.1725472785442;
        Wed, 04 Sep 2024 10:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8munDU2AJ7cYKC9Edk9AMUjHORmC/M9D0674ATSnT1Ii9frhidoGsJfdbmpoRrUE551PeJw==
X-Received: by 2002:a05:6e02:1fe1:b0:39f:74f9:f698 with SMTP id e9e14a558f8ab-39f74f9f815mr17790465ab.2.1725472784901;
        Wed, 04 Sep 2024 10:59:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b05b42dsm37367065ab.83.2024.09.04.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 10:59:44 -0700 (PDT)
Date: Wed, 4 Sep 2024 11:59:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?UTF-8?B?V2lsY3p5xYRz?=
 =?UTF-8?B?a2k=?= <kwilczynski@kernel.org>, Damien Le Moal
 <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix might_sleep() lockdep warning in pcim_intx()
Message-ID: <20240904115942.7ff0cfcb.alex.williamson@redhat.com>
In-Reply-To: <20240904072541.8746-2-pstanner@redhat.com>
References: <20240904072541.8746-2-pstanner@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 09:25:42 +0200
Philipp Stanner <pstanner@redhat.com> wrote:

> commit 25216afc9db5 ("PCI: Add managed pcim_intx()") moved the
> allocation step for pci_intx()'s device resource from
> pcim_enable_device() to pcim_intx(). As before, pcim_enable_device()
> sets pci_dev.is_managed to true; and it is never set to false again.
> 
> Under some circumstances it can happen that drivers share a struct
> pci_dev. If one driver uses pcim_enable_device() and the other doesn't,
> this causes the other driver to run into managed pcim_intx(), which will
> try to allocate when called for the first time.

I don't think "share" is the correct way to describe this.  The struct
pci_dev is never shared between drivers, it's more of a lifecycle
issue.  The struct pci_dev persists for the life of the device, but
is_managed is relative to the driver that is currently bound to the
device.  The issue is that the devres infrastructure doesn't clear this
flag when the managed driver that set it releases the struct pci_dev.

As we discussed in the other thread, this is a latent issue that has
existed for some time, but it's only when pcim_intx() starts allocating
memory, as introduced in the Fixes commit below, that the calling
requirements for pcim_intx() are narrowed and become incompatible (and
visible via lockdep) with existing drivers.

> Allocations might sleep, so calling pci_intx() while holding spinlocks
> becomes then invalid, which causes lockdep warnings and could cause
> deadlocks.
> 
> Have pcim_enable_device()'s release function, pcim_disable_device(), set
> pci_dev.is_managed to false so that subsequent drivers using the same
> struct pci_dev do not run implicitly into managed code.
> 
> Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes: https://lore.kernel.org/all/20240903094431.63551744.alex.williamson@redhat.com/
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> @Alex:
> Please have a look whether this fixes your issue.

Yes, this works for me.

Tested-by: Alex Williamson <alex.williamson@redhat.com>

> Might also be cool to include your lockdep warning in the commit
> message, if you can provide that.

See below.  Thanks,

Alex

========================================================
WARNING: possible irq lock inversion dependency detected
6.11.0-rc6+ #59 Tainted: G        W         
--------------------------------------------------------
CPU 0/KVM/1537 just changed the state of lock:
ffffa0f0cff965f0 (&vdev->irqlock){-...}-{2:2}, at:
vfio_intx_handler+0x21/0xd0 [vfio_pci_core] but this lock took another,
HARDIRQ-unsafe lock in the past: (fs_reclaim){+.+.}-{0:0}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               local_irq_disable();
                               lock(&vdev->irqlock);
                               lock(fs_reclaim);
  <Interrupt>
    lock(&vdev->irqlock);

 *** DEADLOCK ***

1 lock held by CPU 0/KVM/1537:
 #0: ffffa0f0eaffc3b0 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x86/0x9a0 [kvm]

the shortest dependencies between 2nd lock and 1st lock:
 -> (fs_reclaim){+.+.}-{0:0} {
    HARDIRQ-ON-W at:
                      lock_acquire+0xba/0x2c0
                      fs_reclaim_acquire+0x99/0xf0
                      __kmalloc_node_noprof+0x93/0x470
                      alloc_cpumask_var_node+0x21/0x30
                      smp_prepare_cpus_common+0x90/0x140
                      native_smp_prepare_cpus+0xa/0xc0
                      kernel_init_freeable+0x23d/0x5a0
                      kernel_init+0x16/0x1d0
                      ret_from_fork+0x2d/0x50
                      ret_from_fork_asm+0x1a/0x30
    SOFTIRQ-ON-W at:
                      lock_acquire+0xba/0x2c0
                      fs_reclaim_acquire+0x99/0xf0
                      __kmalloc_node_noprof+0x93/0x470
                      alloc_cpumask_var_node+0x21/0x30
                      smp_prepare_cpus_common+0x90/0x140
                      native_smp_prepare_cpus+0xa/0xc0
                      kernel_init_freeable+0x23d/0x5a0
                      kernel_init+0x16/0x1d0
                      ret_from_fork+0x2d/0x50
                      ret_from_fork_asm+0x1a/0x30
    INITIAL USE at:
                     lock_acquire+0xba/0x2c0
                     fs_reclaim_acquire+0x99/0xf0
                     __kmalloc_node_noprof+0x93/0x470
                     alloc_cpumask_var_node+0x21/0x30
                     smp_prepare_cpus_common+0x90/0x140
                     native_smp_prepare_cpus+0xa/0xc0
                     kernel_init_freeable+0x23d/0x5a0
                     kernel_init+0x16/0x1d0
                     ret_from_fork+0x2d/0x50
                     ret_from_fork_asm+0x1a/0x30
  }
  ... key      at: [<ffffffffb2250300>] __fs_reclaim_map+0x0/0x28
  ... acquired at:
   fs_reclaim_acquire+0x99/0xf0
   __kmalloc_node_track_caller_noprof+0x8f/0x460
   __devres_alloc_node+0x42/0x80
   pcim_intx+0xb6/0xe0
   pci_intx+0x67/0x80
   __vfio_pci_intx_mask+0x70/0xe0 [vfio_pci_core]
   vfio_pci_set_intx_mask+0x40/0x50 [vfio_pci_core]
   vfio_pci_core_ioctl+0x74e/0xf50 [vfio_pci_core]
   vfio_device_fops_unl_ioctl+0xa5/0x870 [vfio]
   __x64_sys_ioctl+0x90/0xd0
   do_syscall_64+0x8e/0x180
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> (&vdev->irqlock){-...}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0xba/0x2c0
                    _raw_spin_lock_irqsave+0x3b/0x60
                    vfio_intx_handler+0x21/0xd0 [vfio_pci_core]
                    __handle_irq_event_percpu+0x81/0x260
                    handle_irq_event+0x34/0x70
                    handle_fasteoi_irq+0x91/0x210
                    __common_interrupt+0x6f/0x140
                    common_interrupt+0xb3/0xd0
                    asm_common_interrupt+0x22/0x40
                    vmx_do_interrupt_irqoff+0x10/0x20 [kvm_intel]
                    vmx_handle_exit_irqoff+0xc3/0x220 [kvm_intel]
                    kvm_arch_vcpu_ioctl_run+0x12e9/0x1d20 [kvm]
                    kvm_vcpu_ioctl+0x239/0x9a0 [kvm]
                    __x64_sys_ioctl+0x90/0xd0
                    do_syscall_64+0x8e/0x180
                    entry_SYSCALL_64_after_hwframe+0x76/0x7e
   INITIAL USE at:
                   lock_acquire+0xba/0x2c0
                   _raw_spin_lock_irqsave+0x3b/0x60
                   __vfio_pci_intx_mask+0x30/0xe0 [vfio_pci_core]
                   vfio_pci_set_intx_mask+0x40/0x50 [vfio_pci_core]
                   vfio_pci_core_ioctl+0x74e/0xf50 [vfio_pci_core]
                   vfio_device_fops_unl_ioctl+0xa5/0x870 [vfio]
                   __x64_sys_ioctl+0x90/0xd0
                   do_syscall_64+0x8e/0x180
                   entry_SYSCALL_64_after_hwframe+0x76/0x7e
 }
 ... key      at: [<ffffffffc0a68800>] __key.90+0x0/0x10 [vfio_pci_core]
 ... acquired at:
   __lock_acquire+0x9b0/0x2130
   lock_acquire+0xba/0x2c0
   _raw_spin_lock_irqsave+0x3b/0x60
   vfio_intx_handler+0x21/0xd0 [vfio_pci_core]
   __handle_irq_event_percpu+0x81/0x260
   handle_irq_event+0x34/0x70
   handle_fasteoi_irq+0x91/0x210
   __common_interrupt+0x6f/0x140
   common_interrupt+0xb3/0xd0
   asm_common_interrupt+0x22/0x40
   vmx_do_interrupt_irqoff+0x10/0x20 [kvm_intel]
   vmx_handle_exit_irqoff+0xc3/0x220 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0x12e9/0x1d20 [kvm]
   kvm_vcpu_ioctl+0x239/0x9a0 [kvm]
   __x64_sys_ioctl+0x90/0xd0
   do_syscall_64+0x8e/0x180
   entry_SYSCALL_64_after_hwframe+0x76/0x7e


stack backtrace:
CPU: 4 UID: 107 PID: 1537 Comm: CPU 0/KVM Tainted: G        W          6.11.0-rc6+ #59
Tainted: [W]=WARN
Hardware name: HP HP ProDesk 600 G3 MT/829D, BIOS P02 Ver. 02.44 09/13/2022
Call Trace:
 <IRQ>
 dump_stack_lvl+0x62/0x90
 mark_lock+0x3b7/0x960
 __lock_acquire+0x9b0/0x2130
 lock_acquire+0xba/0x2c0
 ? vfio_intx_handler+0x21/0xd0 [vfio_pci_core]
 _raw_spin_lock_irqsave+0x3b/0x60
 ? vfio_intx_handler+0x21/0xd0 [vfio_pci_core]
 vfio_intx_handler+0x21/0xd0 [vfio_pci_core]
 __handle_irq_event_percpu+0x81/0x260
 handle_irq_event+0x34/0x70
 handle_fasteoi_irq+0x91/0x210
 __common_interrupt+0x6f/0x140
 common_interrupt+0xb3/0xd0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x22/0x40
RIP: 0010:vmx_do_interrupt_irqoff+0x10/0x20 [kvm_intel]
Code: ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 48 83 e4 f0 6a 18 55 9c 6a 10 ff d7 <0f> 1f 00 48 89 ec 5d c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90
RSP: 0018:ffffbc4d8231ba78 EFLAGS: 00000082
RAX: 0000000000000240 RBX: ffffa0f0eaffc300 RCX: 0000000080000000
RDX: ffffffff00000000 RSI: 0000000080000022 RDI: ffffffffb1000240
RBP: ffffbc4d8231ba78 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffa0f0ea835000
R13: ffffa0f0e0d00000 R14: ffffa0f0eaffc300 R15: 0000000000000000
 ? irq_entries_start+0x10/0x660
 vmx_handle_exit_irqoff+0xc3/0x220 [kvm_intel]
 kvm_arch_vcpu_ioctl_run+0x12e9/0x1d20 [kvm]
 ? kvm_vcpu_ioctl+0x239/0x9a0 [kvm]
 kvm_vcpu_ioctl+0x239/0x9a0 [kvm]
 ? find_held_lock+0x2b/0x80
 __x64_sys_ioctl+0x90/0xd0
 do_syscall_64+0x8e/0x180
 ? lockdep_hardirqs_on+0x77/0x100
 ? do_syscall_64+0x9a/0x180
 ? vmx_vcpu_put+0xf6/0x270 [kvm_intel]
 ? kvm_arch_vcpu_put+0x191/0x270 [kvm]
 ? find_held_lock+0x2b/0x80
 ? kvm_vcpu_ioctl+0x197/0x9a0 [kvm]
 ? lock_release+0x132/0x290
 ? rcu_is_watching+0xd/0x40
 ? kfree+0x231/0x360
 ? __mutex_unlock_slowpath+0x2a/0x260
 ? kvm_vcpu_ioctl+0x1a7/0x9a0 [kvm]
 ? find_held_lock+0x2b/0x80
 ? user_return_notifier_unregister+0x3c/0x70
 ? do_syscall_64+0x9a/0x180
 ? lockdep_hardirqs_on+0x77/0x100
 ? do_syscall_64+0x9a/0x180
 ? syscall_exit_to_user_mode+0x1c2/0x2b0
 ? do_syscall_64+0x9a/0x180
 ? lockdep_hardirqs_on+0x77/0x100
 ? do_syscall_64+0x9a/0x180
 ? lockdep_hardirqs_on+0x77/0x100
 ? do_syscall_64+0x9a/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fd030fa13ed
Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
RSP: 002b:00007fd029bf6420 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000055b4692ec540 RCX: 00007fd030fa13ed
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000018
RBP: 00007fd029bf6470 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd029c006c0
R13: ffffffffffff7a90 R14: 0000000000000000 R15: 00007ffe459ab200
 </TASK>


