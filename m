Return-Path: <linux-pci+bounces-10819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EF393CC09
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 02:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356411F2124C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 00:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ABE64C;
	Fri, 26 Jul 2024 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx7QFyFB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E37F8;
	Fri, 26 Jul 2024 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953149; cv=none; b=dozdiR5J70zhyVY/rJAwDci2YhsOivFUriYj3NqUimWd/ama+yd1+BE+v76WDQpEvPG3UKSdveoMCcGR7BDlARrVqYRo/dF8GVkKzjKZPnzyJswx5419jCdlMjaV70WRfVkkcQnhQBD6A6AtXehTsaTUPydd74kefeDwivImOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953149; c=relaxed/simple;
	bh=h7QQQ/cL9B3zsUIxNYJxH5Zo9oaHmGrGVKPAw8+uHOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7kqvit5zacj5lnKKTE0JX27HyoXBrw5TbKkzLGTjhy8kPKsZmmIwHPfRDqJjYoivL70jafHmzspWICTZZU8wUdz5sIr7EoDYXBYRYmg8lwccwj4KPijTnzb+Px/yP8nzenZtvSYyZwlPatbeeEnYQT8G/UuzWWELDm8wq5ANig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx7QFyFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BFEC116B1;
	Fri, 26 Jul 2024 00:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721953148;
	bh=h7QQQ/cL9B3zsUIxNYJxH5Zo9oaHmGrGVKPAw8+uHOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xx7QFyFBlnUXkzo1rT3tHt93osQJ0la0PO/KuQBai43BdF2EYS2vOXZKssSIfVtQD
	 8KQV/SCpTTl4BrQDCrNj/tBLgclkhRG3qMOPeaejkUavRJ3Dl99hNaF5jb1qXC/PCL
	 2v50YWkPJo/0LQ666mHZZ0a6QI2OQ0gVY/WCQ4wp7GgnvER8EimY2ARPjG4fpIc+NK
	 kewAtQxPrYZa6zCvuu6KlOk0qwwFwTsmCQ7PwgOV0CAIPriVu/T38DpKnIV59nI64r
	 DSVAHfkiOMQmDdyBpoN4bagPkeCa/cEPrw9AMTVzzbR7U0FCUE+0DCtx6Bf+I4xJN7
	 YCaK/YLqF8nCg==
Message-ID: <6ce4c9f4-7c75-4451-8c6f-fe3d6a3dd913@kernel.org>
Date: Fri, 26 Jul 2024 09:19:06 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
To: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725120729.59788-2-pstanner@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240725120729.59788-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/24 21:07, Philipp Stanner wrote:
> pci_intx() is a function that becomes managed if pcim_enable_device()
> has been called in advance. Commit 25216afc9db5 ("PCI: Add managed
> pcim_intx()") changed this behavior so that pci_intx() always leads to
> creation of a separate device resource for itself, whereas earlier, a
> shared resource was used for all PCI devres operations.
> 
> Unfortunately, pci_intx() seems to be used in some drivers' remove()
> paths; in the managed case this causes a device resource to be created
> on driver detach.
> 
> Fix the regression by only redirecting pci_intx() to its managed twin
> pcim_intx() if the pci_command changes.
> 
> Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> Reported-by: Damien Le Moal <dlemoal@kernel.org>
> Closes: https://lore.kernel.org/all/b8f4ba97-84fc-4b7e-ba1a-99de2d9f0118@kernel.org/
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> Alright, I reproduced this with QEMU as Damien described and this here
> fixes the issue on my side. Feedback welcome. Thank you very much,
> Damien.

This works ans is cleaner that what I had :)

Tested-by: Damien Le Moal <dlemoal@kernel.org>

> It seems that this might yet again be the issue of drivers not being
> aware that pci_intx() might become managed, so they use it in their
> unwind path (rightfully so; there probably was no alternative back
> then).

At least for the ahci driver with wich I found the issue, what is odd is that
there is only a single call to pci_intx() to *enable* intx, and that call is in
the probe path. With QEMU, this call is not even done as the qemu AHCI support MSI.

Adding a WARN_ON(!enable) at the beginning of pci_inx(), we can see that what
happens is that during device probe, we get this backtrace:

[   34.658988] WARNING: CPU: 0 PID: 999 at drivers/pci/pci.c:4480 pci_intx+0x7f/0xc0
[   34.660799] Modules linked in: ahci(+) rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace netfs]
[   34.673784] CPU: 0 UID: 0 PID: 999 Comm: modprobe Tainted: G        W
 6.10.0+ #1948
[   34.675961] Tainted: [W]=WARN
[   34.676891] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-2.fc40 04/01/2014
[   34.679197] RIP: 0010:pci_intx+0x7f/0xc0
[   34.680348] Code: b7 d2 be 04 00 00 00 48 89 df e8 0c 84 ff ff 48 8b 44 24 08
65 48 2b 04 25 28 00 00 00 756
[   34.685015] RSP: 0018:ffffb60f40e2f7f0 EFLAGS: 00010246
[   34.686436] RAX: 0000000000000000 RBX: ffff9dbb81237000 RCX: ffffb60f40e2f64c
[   34.688294] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9dbb81237000
[   34.690120] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
[   34.691986] R10: ffff9dbb88883538 R11: 0000000000000001 R12: 0000000000000001
[   34.693687] R13: ffff9dbb812370c8 R14: ffff9dbb86eeaa00 R15: 0000000000000000
[   34.695140] FS:  00007f9d81465740(0000) GS:ffff9dbcf7c00000(0000)
knlGS:0000000000000000
[   34.696884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.698107] CR2: 00007ffc786ed8b8 CR3: 00000001088da000 CR4: 0000000000350ef0
[   34.699562] Call Trace:
[   34.700215]  <TASK>
[   34.700802]  ? pci_intx+0x7f/0xc0
[   34.701607]  ? __warn.cold+0xa5/0x13c
[   34.702448]  ? pci_intx+0x7f/0xc0
[   34.703257]  ? report_bug+0xff/0x140
[   34.704105]  ? handle_bug+0x3a/0x70
[   34.704938]  ? exc_invalid_op+0x17/0x70
[   34.705826]  ? asm_exc_invalid_op+0x1a/0x20
[   34.706593]  ? pci_intx+0x7f/0xc0
[   34.707086]  msi_capability_init+0x35a/0x370
[   34.707723]  __pci_enable_msi_range+0x187/0x240
[   34.708356]  pci_alloc_irq_vectors_affinity+0xc4/0x110
[   34.709058]  ahci_init_one+0x6ec/0xcc0 [ahci]
[   34.709692]  ? __pm_runtime_resume+0x58/0x90
[   34.710311]  local_pci_probe+0x45/0x90
[   34.710865]  pci_device_probe+0xbb/0x230
[   34.711433]  really_probe+0xcc/0x350
[   34.711976]  ? pm_runtime_barrier+0x54/0x90
[   34.712569]  ? __pfx___driver_attach+0x10/0x10
[   34.713206]  __driver_probe_device+0x78/0x110
[   34.713837]  driver_probe_device+0x1f/0xa0
[   34.714427]  __driver_attach+0xbe/0x1d0
[   34.715001]  bus_for_each_dev+0x92/0xe0
[   34.715563]  bus_add_driver+0x115/0x200
[   34.716136]  driver_register+0x72/0xd0
[   34.716704]  ? __pfx_ahci_pci_driver_init+0x10/0x10 [ahci]
[   34.717457]  do_one_initcall+0x76/0x3a0
[   34.718036]  do_init_module+0x60/0x210
[   34.718616]  init_module_from_file+0x86/0xc0
[   34.719243]  idempotent_init_module+0x127/0x2c0
[   34.719913]  __x64_sys_finit_module+0x5e/0xb0
[   34.720546]  do_syscall_64+0x7d/0x160
[   34.721100]  ? srso_return_thunk+0x5/0x5f
[   34.721695]  ? do_syscall_64+0x89/0x160
[   34.722258]  ? srso_return_thunk+0x5/0x5f
[   34.722846]  ? do_sys_openat2+0x9c/0xe0
[   34.723421]  ? srso_return_thunk+0x5/0x5f
[   34.724012]  ? syscall_exit_to_user_mode+0x64/0x1f0
[   34.724703]  ? srso_return_thunk+0x5/0x5f
[   34.725293]  ? do_syscall_64+0x89/0x160
[   34.725883]  ? srso_return_thunk+0x5/0x5f
[   34.726467]  ? syscall_exit_to_user_mode+0x64/0x1f0
[   34.727159]  ? srso_return_thunk+0x5/0x5f
[   34.727764]  ? do_syscall_64+0x89/0x160
[   34.728341]  ? srso_return_thunk+0x5/0x5f
[   34.728937]  ? exc_page_fault+0x6c/0x200
[   34.729511]  ? srso_return_thunk+0x5/0x5f
[   34.730109]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   34.730837] RIP: 0033:0x7f9d80d281dd
[   34.731375] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8
48 89 f7 48 89 d6 48 89 ca 4d8
[   34.733796] RSP: 002b:00007ffc786f0898 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   34.734894] RAX: ffffffffffffffda RBX: 00005617347f09a0 RCX: 00007f9d80d281dd
[   34.735850] RDX: 0000000000000000 RSI: 0000561715fe5e79 RDI: 0000000000000003
[   34.736812] RBP: 00007ffc786f0950 R08: 00007f9d80df6b20 R09: 00007ffc786f08e0
[   34.737769] R10: 00005617347f13e0 R11: 0000000000000246 R12: 0000561715fe5e79
[   34.738725] R13: 0000000000040000 R14: 00005617347f8990 R15: 00005617347f8b20
[   34.739695]  </TASK>
[   34.740075] ---[ end trace 0000000000000000 ]---

So it is msi_capability_init() that is the problem: that function calls
pci_intx_for_msi(dev, 0) which then calls pci_intx(dev, 0), thus creating the
intx devres for the device despite the driver code not touching intx at all.
The driver is fine ! It is MSI touching INTX that is messing things up.

That said, I do not see that as an issue in itself. What I fail to understand
though is why that intx devres is not deleted on device teardown. I think this
may have something to do with the fact that pcim_intx() always does
"res->orig_intx = !enable;", that is, it assumes that if there is a call to
pcim_intx(dev, 0), then it is because intx where enabled already, which I do not
think is true for most drivers... So we endup with INTX being wrongly enabled on
device teardown by pcim_intx_restore(), and because of that, the intx resource
is not deleted ?

Re-enabling intx on teardown is wrong I think, but that still does not explain
why that resource is not deleted. I fail to see why.


-- 
Damien Le Moal
Western Digital Research


