Return-Path: <linux-pci+bounces-31892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6D8B00DE4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 23:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7143AEDC9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A2C290D96;
	Thu, 10 Jul 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kElexbOF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SIVDeLGE"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B52FE374;
	Thu, 10 Jul 2025 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183077; cv=none; b=NcFhzKD0tNaz0lHzpmReylGMnXXP/NJ6H5MXpI/A7rrR9DJTMNmfJoCFj4Ss6iQxkg75Al+IpJGFBXLXQU+T1hfRT7gaiM/WAG65kPvTls23/qjCnmZYC8BrWLSyvbfqaw5x8k7CQvhE67G3O1HfuloSG/O5Vzlsyxlfiqy1AMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183077; c=relaxed/simple;
	bh=tGYg4t+rXasZtBJGh63ctK0rqt1xmnO7zkhh+wDaeLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iDDi+jbr8o2P3YZDbFFr4wldM+pVSjcsMs6UeiRuuhVO3S+Yaq8lqGMlmr889GjITmYcUgdJF1ZqIx+ABq2uUflNTRvZQ+wAyYBEs5OXSQYvb3PP508jqxO9BKjS9K9aGvDQ9zLt9L4/5f4nTulTzpa3yKhlMkfJ6da52nSCYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kElexbOF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SIVDeLGE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752183072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDXEiQ/5g6I7b+UjIzpiX9vF7wJQ5C15ONwOm46wuN0=;
	b=kElexbOFo/y0DXaCpMAEbUuUXnszxquJoMv8oM9kGYYRJGUOMgHC1X4KhuScS7+gfAyAqg
	dSr2cw1WDzH7gOYFEAqicsaWELM+x4Ez05mP4r0eix/x3WQTroB703LO3RXIavjpPA7JYY
	Ws7jrHs0nWkYjEueLWsJ+zhBVyjrEIyVI9E9a89xFoLD7uE5cqA9C5kUAD6LtI4XlSjbI8
	FD3vEaUNAkUnkfnPq352qpmvizifsjTISdrAE3z2zCUEDOtQIwfI8wTJg/9ea2/aQekSuW
	FcnwmxbNmBDjzwpBI3aWqDMl4k+mafkcrCLTCZLekRxWM2BS0RbUXc2HJ09Wzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752183072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDXEiQ/5g6I7b+UjIzpiX9vF7wJQ5C15ONwOm46wuN0=;
	b=SIVDeLGEwSMWJf9qDnxgEBvAl7aPIFH/4hcnqBBsISNKbWxnL9ptZqKCc/6jE7RDUMiD7j
	vLDUlqYeWY5KBWDA==
To: himanshu.madhani@oracle.com, linux-kernel@vger.kernel.org
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>, Jorge Lopez
 <jorge.jo.lopez@oracle.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/THP: Fix hang due to incorrect guard lock
In-Reply-To: <20250708222530.1041477-1-himanshu.madhani@oracle.com>
References: <20250708222530.1041477-1-himanshu.madhani@oracle.com>
Date: Thu, 10 Jul 2025 23:31:11 +0200
Message-ID: <87frf3wx5s.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 08 2025 at 22:25, himanshu madhani wrote:

> From: Himanshu Madhani <himanshu.madhani@oracle.com>

The subject line is misleading because the problem is not in the THP
code. It's in the PCI/MSI code implementation of the function which is
used by THP.

> Fix system hang due to incorrect mutex lock placement.
>
> following stack trace will be seen on system boot

Please trim down stack traces to the bare minimum which is required to
illustrate your point.

> [  525.664681] task:systemd-shutdow state:D stack:0     pid:1     tgid:1     ppid:0      task_flags:0x400100 flags:0x00004002
> [  525.796878] Call Trace:
> [  525.826116]  <TASK>
> [  525.851195]  __schedule+0x2d1/0x730
> [  525.892917]  schedule+0x27/0x80
> [  525.930478]  schedule_preempt_disabled+0x15/0x30
> [  525.985718]  __mutex_lock.constprop.0+0x4be/0x8a0
> [  526.041993]  msi_domain_get_virq+0xcc/0x110
> [  526.092031]  pci_msix_write_tph_tag+0x3c/0x100
> [  526.145186]  pcie_tph_set_st_entry+0x125/0x1d0
> [  526.198346]  bnxt_irq_affinity_release+0x35/0x50 [bnxt_en]
> [  526.264015]  irq_set_affinity_notifier+0xe0/0x130
> [  526.320291]  bnxt_free_irq+0x6e/0x110 [bnxt_en]
> [  526.374507]  __bnxt_close_nic.isra.0+0x1eb/0x220 [bnxt_en]
> [  526.440175]  bnxt_close+0x3a/0x100 [bnxt_en]
> [  526.491264]  __dev_close_many+0xae/0x220
> [  526.538179]  dev_close_many+0xc2/0x1b0
> [  526.583014]  netif_close+0x9d/0xd0
> [  526.623693]  bnxt_shutdown+0xb1/0xe0 [bnxt_en]
> [  526.676874]  pci_device_shutdown+0x35/0x70
> [  526.725871]  device_shutdown+0x118/0x1a0

You trimmed the interesting information that this is a softlockup and
kept all the gunk below whihc is completely useless.

> [  526.772788]  kernel_restart+0x3a/0x70
> [  526.816588]  __do_sys_reboot+0x150/0x250
> [  526.863504]  do_syscall_64+0x84/0x940
> [  526.907300]  ? __put_user_8+0xd/0x20
> [  526.950059]  ? rseq_ip_fixup+0x90/0x1e0
> [  526.995937]  ? task_mm_cid_work+0x1ad/0x220
> [  527.045971]  ? __rseq_handle_notify_resume+0x35/0x90
> [  527.105367]  ? arch_exit_to_user_mode_prepare.isra.0+0x98/0xb0
> [  527.175166]  ? do_syscall_64+0xba/0x940
> [  527.221040]  ? do_filp_open+0xd7/0x1a0
> [  527.265882]  ? alloc_fd+0xba/0x110
> [  527.306556]  ? do_sys_openat2+0xa4/0xf0
> [  527.352434]  ? __x64_sys_openat+0x54/0xb0
> [  527.400389]  ? arch_exit_to_user_mode_prepare.isra.0+0x9/0xb0
> [  527.469150]  ? do_syscall_64+0xba/0x940
> [  527.515023]  ? do_user_addr_fault+0x221/0x690
> [  527.567141]  ? clear_bhb_loop+0x30/0x80
> [  527.613017]  ? clear_bhb_loop+0x30/0x80
> [  527.658895]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  527.719332] RIP: 0033:0x7fc3ec504777
> [  527.762091] RSP: 002b:00007ffecd62c4f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
> [  527.852685] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc3ec504777
> [  527.938085] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
> [  528.023485] RBP: 00007ffecd62c700 R08: 0000000000000000 R09: 00007ffecd62b8e0
> [  528.108878] R10: 0000000000000001 R11: 0000000000000202 R12: 00007ffecd62c568
> [  528.194273] R13: 00007ffecd62c548 R14: 00007ffecd62c568 R15: 0000000000000000
> [  528.279672]  </TASK>

See https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces

> Fixes: d5124a9957b2 ("PCI/MSI: Provide a sane mechanism for TPH")

This fixes tag is correct

> Fixes: 71296eae5887 ("PCI/TPH: Replace the broken MSI-X control word update")

This one not because it's a subsequent problem caused by the above.

> Reported-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>

Other than that this looks good.

I pick it up tomorrow through the tip irq/urgent branch and fixup the
changelog, so no need to resend.

Thanks,

        tglx

