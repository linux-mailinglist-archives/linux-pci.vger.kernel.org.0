Return-Path: <linux-pci+bounces-7105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AED8BC99F
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 10:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2620A1F22417
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43695A788;
	Mon,  6 May 2024 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odVp1UH1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1c3Rod3x"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F89107A6;
	Mon,  6 May 2024 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984637; cv=none; b=V65r2QqBRNN4+A6nBOBZgAFV61JdgtH2DuAd1coD+36Lty8V3EF5I6rxB29Zo7+NepU4j3Y9x1/GoOhxvCpTkVhFOnloYubN3dfBDHk1bEpJ4mqd8nm4D1xpr3tCOjyr4JY7HT2b6thHS+bO0LJRNBC/shzwQyuwQZ/bw6TcqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984637; c=relaxed/simple;
	bh=hxmlYudd0T814h0F19WwBcuLSjbQeMFtaKxVtn2P2Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxL8gS28m0tUk2/C49DlLZK3F5kupYqIRHG1MKBi/V25I/bRPek1PW3Vip0mGx8oodfsxcOS3pF2TgqH4OefTY46NT3avflMxT+LwCneIOQ/Dg5mudeBuepo/Nel3ayXv8k0NQq7TO7q/qnADMaqGa4fVoM+MP9W28qYpi4WfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odVp1UH1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1c3Rod3x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 6 May 2024 10:37:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714984628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JllM/6f2i64vYeYOp06WCUKnYAzhnpgw3MJvupu+GV8=;
	b=odVp1UH1iOi4MfIQbOW2isS+JxKgZPzr8plYa96tUloGxQGiCrmJrDLzvrdCYcFtLCAFAA
	96tf8OQbGRbmoylikqDhJMqCmx0xqdKTdLuk9uUPMZu0X6CJqmL51K3J3nBM/q8VAdCuQi
	c6rrNH3YlrAMaZs1cB0IX7YYMAukZ6VXkBqjw+Eyj5+Ik9x8F0EBWdpaKriNUMcKAQ6WO2
	TstVp/nymUvD8S+9QijVUawUWeqA8+EVJNczfMlQlon8qgFRkMmpyRHl9pJDcy4G3GituK
	RD8DutN1oXTb01sXrar1Q40oSK7AoxH4mKz3B1q/+DnLTYTbEDVrtnsTNBBHJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714984628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JllM/6f2i64vYeYOp06WCUKnYAzhnpgw3MJvupu+GV8=;
	b=1c3Rod3xL8W3ZZnfK3oPE/X6pc0xSDWv2SMKcR0OSJBkq0lKtVmMw+ajz5f45GRkBZv7j3
	4iDQgMlnHRpGMkBw==
From: Nam Cao <namcao@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Abort hot-plug if
 pci_hp_add_bridge() fails
Message-ID: <20240506083701.NZNifFGn@linutronix.de>
References: <cover.1714838173.git.namcao@linutronix.de>
 <f3db713f4a737756782be6e94fcea3eda352e39f.1714838173.git.namcao@linutronix.de>
 <Zjcc6Suf5HmmZVM9@wunner.de>
 <20240505071451.df3l6mdK@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505071451.df3l6mdK@linutronix.de>

On Sun, May 05, 2024 at 09:15:00AM +0200, Nam Cao wrote:
> On Sun, May 05, 2024 at 07:45:13AM +0200, Lukas Wunner wrote:
> > Have you gone through the testing steps you spoke of earlier
> > (replacing the hot-added bridge with an Ethernet card) and do
> > they work correctly with this patch?
> 
> Yes.

I just discovered a new crash scenario with shpchp:

First, hot-add a bridge:
(qemu) device_add pci-bridge,id=br2,bus=br1,chassis_nr=1,addr=1

But with the current patch, the hot-plug is still successful, just that the
bridge is not properly configured:
$ lspci -t
-[0000:00]-+-00.0
           +-01.0
           +-02.0
           +-03.0-[01-02]----00.0-[02]----01.0--  <-- new hot-added bridge
           +-1f.0
           +-1f.2
           \-1f.3

But! Now I leave the hot-added bridge as is, and hot-add an ethernet card:
(qemu) device_add e1000,bus=br1,id=eth0,addr=2

this command crashes the kernel (full crash log below).

The problem is because during hot-plugging of this ethernet card,
pci_bus_add_devices() is invoked and the previously hot-plugged bridge hasn't
been marked as "added" yet, so the driver attempts to add this bridge
again, leading to the crash.

Now for pciehp, this scenario cannot happen, because there is only a single
slot, so we cannot hot-plug another device. But still, this makes me think
perhaps we shouldn't leave the hot-plugged bridge in a improperly-configured
state as this patch is doing. I cannot think of a scenario that would crash pciehp
similarly to shpchp. But that's just me, maybe there is a rare scenario
that can crash pciehp, but I just haven't seen yet.

My point is: better safe than sorry. I propose going back to the original
solution: calling pci_stop_and_remove_bus_device() and return a negative
error, and get rid of this improperly configured bridge. It is useless
anyways without a subordinate bus number.

What do you think?

Best regards,
Nam

(qemu) device_add e1000,bus=br1,id=eth0,addr=2
[  140.536933] shpchp 0000:01:00.0: Latch close on Slot(2)
[  140.538466] shpchp 0000:01:00.0: Button pressed on Slot(2)
[  140.539992] shpchp 0000:01:00.0: Card present on Slot(2)
[  140.541600] shpchp 0000:01:00.0: PCI slot #2 - powering on due to button press
[  146.604107] pci 0000:02:02.0: [8086:100e] type 00 class 0x020000 conventional PCI endpoint
[  146.606679] pci 0000:02:02.0: BAR 0 [mem 0x00000000-0x0001ffff]
[  146.608438] pci 0000:02:02.0: BAR 1 [io  0x0000-0x003f]
[  146.610340] pci 0000:02:02.0: ROM [mem 0x00000000-0x0003ffff pref]
[  146.612326] pci 0000:02:02.0: vgaarb: pci_notify
[  146.613730] pci 0000:02:02.0: ROM [mem 0xfe600000-0xfe63ffff pref]: assigned
[  146.615705] pci 0000:02:02.0: BAR 0 [mem 0xfe640000-0xfe65ffff]: assigned
[  146.617685] pci 0000:02:01.0: BAR 0 [mem 0xfe660000-0xfe6600ff 64bit]: assigned
[  146.621397] pci 0000:02:02.0: BAR 1 [io  0xc000-0xc03f]: assigned
[  146.623184] shpchp 0000:01:00.0: PCI bridge to [bus 02]
[  146.624704] shpchp 0000:01:00.0:   bridge window [io  0xc000-0xcfff]
[  146.628853] shpchp 0000:01:00.0:   bridge window [mem 0xfe600000-0xfe7fffff]
[  146.632415] shpchp 0000:01:00.0:   bridge window [mem 0xfe000000-0xfe1fffff 64bit pref]
[  146.637717] pcieport 0000:02:01.0: vgaarb: pci_notify
[  146.639172] pcieport 0000:02:01.0: runtime IRQ mapping not provided by arch
[  146.641635] pcieport 0000:02:01.0: vgaarb: pci_notify
[  146.643093] shpchp 0000:02:01.0: vgaarb: pci_notify
[  146.644501] shpchp 0000:02:01.0: runtime IRQ mapping not provided by arch
[  146.647967] shpchp 0000:02:01.0: HPC vendor_id 1b36 device_id 1 ss_vid 0 ss_did 0
[  146.650106] shpchp 0000:02:01.0: enabling device (0000 -> 0002)
[  146.653840] ACPI: \_SB_.GSIE: Enabled at IRQ 20
[  146.656699] shpchp 0000:02:01.0: enabling bus mastering
[  146.659567] BUG: kernel NULL pointer dereference, address: 00000000000000da
[  146.661532] #PF: supervisor write access in kernel mode
[  146.663006] #PF: error_code(0x0002) - not-present page
[  146.664453] PGD 0 P4D 0 
[  146.665208] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  146.666447] CPU: 1 PID: 35 Comm: kworker/1:1 Not tainted 6.9.0-rc1-00003-g5ef667cf77c0 #59
[  146.668743] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  146.671314] Workqueue: shpchp-2 shpchp_pushbutton_thread
[  146.672817] RIP: 0010:shpc_init+0x3fb/0x9d0
[  146.674282] Code: 8b 48 08 40 80 ff 02 0f 84 15 04 00 00 f7 c2 00 00 00 1f 0f 84 44 02 00 00 b8 04 00 00 00 b9 04 00 0f
[  146.679118] RSP: 0018:ffffc90000133ab0 EFLAGS: 00010246
[  146.680245] RAX: 0000000000000000 RBX: ffff8880056fd600 RCX: 0000000000000000
[  146.681782] RDX: 00000000000000ff RSI: 0000000000000000 RDI: ffffffff83059101
[  146.683307] RBP: ffffc90000133af8 R08: ffff88800364f500 R09: 0000000000000000
[  146.684831] R10: 0000000000000000 R11: ffff88800470b840 R12: ffff888006af7000
[  146.686361] R13: 0000000000000000 R14: 000000007f000d0f R15: 000000000000001f
[  146.687882] FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[  146.689597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  146.690821] CR2: 00000000000000da CR3: 000000000432a000 CR4: 00000000000006f0
[  146.692331] Call Trace:
[  146.692869]  <TASK>
[  146.693351]  ? show_regs+0x63/0x70
[  146.694097]  ? __die+0x23/0x70
[  146.694771]  ? page_fault_oops+0x17a/0x470
[  146.695659]  ? search_module_extables+0x18/0x60
[  146.696644]  ? shpc_init+0x3fb/0x9d0
[  146.697435]  ? kernelmode_fixup_or_oops+0x9b/0x120
[  146.698474]  ? __bad_area_nosemaphore+0x16e/0x240
[  146.699495]  ? bad_area_nosemaphore+0x11/0x20
[  146.700442]  ? do_user_addr_fault+0x2a8/0x610
[  146.701405]  ? exc_page_fault+0x6d/0x160
[  146.702263]  ? asm_exc_page_fault+0x2b/0x30
[  146.703171]  ? shpc_init+0x3fb/0x9d0
[  146.704213]  shpc_probe+0x92/0x390
[  146.704880]  local_pci_probe+0x46/0xa0
[  146.705626]  pci_device_probe+0xb0/0x190
[  146.706386]  really_probe+0xc7/0x390
[  146.707080]  ? __pfx___device_attach_driver+0x10/0x10
[  146.708044]  __driver_probe_device+0x78/0x150
[  146.708880]  driver_probe_device+0x1f/0x90
[  146.709679]  __device_attach_driver+0x93/0x120
[  146.710538]  bus_for_each_drv+0x96/0xf0
[  146.711277]  __device_attach+0xb1/0x1c0
[  146.712018]  device_attach+0xf/0x20
[  146.712695]  pci_bus_add_device+0x58/0x90
[  146.713480]  pci_bus_add_devices+0x30/0x70
[  146.714292]  shpchp_configure_device+0xd8/0x150
[  146.715200]  board_added+0x115/0x420
[  146.715898]  shpchp_enable_slot+0x114/0x3b0
[  146.716711]  shpchp_pushbutton_thread+0x77/0xa0
[  146.717605]  process_one_work+0x153/0x390
[  146.718387]  worker_thread+0x2c9/0x400
[  146.719111]  ? __pfx_worker_thread+0x10/0x10
[  146.719945]  kthread+0xd7/0x100
[  146.720566]  ? __pfx_kthread+0x10/0x10
[  146.721306]  ret_from_fork+0x3c/0x60
[  146.722006]  ? __pfx_kthread+0x10/0x10
[  146.722734]  ret_from_fork_asm+0x1a/0x30
[  146.723498]  </TASK>
[  146.723931] Modules linked in:
[  146.724529] CR2: 00000000000000da
[  146.725182] ---[ end trace 0000000000000000 ]---
[  146.726065] RIP: 0010:shpc_init+0x3fb/0x9d0
[  146.726862] Code: 8b 48 08 40 80 ff 02 0f 84 15 04 00 00 f7 c2 00 00 00 1f 0f 84 44 02 00 00 b8 04 00 00 00 b9 04 00 0f
[  146.730372] RSP: 0018:ffffc90000133ab0 EFLAGS: 00010246
[  146.731363] RAX: 0000000000000000 RBX: ffff8880056fd600 RCX: 0000000000000000
[  146.732714] RDX: 00000000000000ff RSI: 0000000000000000 RDI: ffffffff83059101
[  146.734072] RBP: ffffc90000133af8 R08: ffff88800364f500 R09: 0000000000000000
[  146.735429] R10: 0000000000000000 R11: ffff88800470b840 R12: ffff888006af7000
[  146.736779] R13: 0000000000000000 R14: 000000007f000d0f R15: 000000000000001f
[  146.738143] FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[  146.739673] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  146.740764] CR2: 00000000000000da CR3: 000000000432a000 CR4: 00000000000006f0
[  146.742116] note: kworker/1:1[35] exited with irqs disabled
[  146.743232] kworker/1:1 (35) used greatest stack depth: 12352 bytes left

