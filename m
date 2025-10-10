Return-Path: <linux-pci+bounces-37787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D4CBCBE35
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF353B02C7
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 07:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD20175D53;
	Fri, 10 Oct 2025 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zJKpNwev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DRYvxN0h"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92BA15E90;
	Fri, 10 Oct 2025 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080560; cv=none; b=TpGUk1aIqLu9P+XsBOmWoWy9L5EyHrsZoe8AvsTq+grMAzRnMnlYM8ENTd7ISaH0q9/nTdyzvv5y3+Ds3qa/o/gc+0y7JHq8WItXUWceLb2SCKAZdD6ZBXifpLt/BHi1/wB7FngfbilA4BINUcGO5xKlDA2xE6t/liM6QqSay0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080560; c=relaxed/simple;
	bh=dRoOPR29iySi0tptZHIOHY6lhyS+1YJkli0s3czvg+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7Huy5YOnJ3W2V2n+XxRt6rouDrUSyxhXdXaEaNIy2tzbyErgNwQM+rszft3h7RC/HK4L2r4kTVGvS25/d0T750nJ1M5mZW4RPr+mkXrFs+f0qQPNynt4tqL9Jgz2n1t+/lz8Z3+v7cI40CiVVFrELOT0KvaG0inh4ZUE5WmCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zJKpNwev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DRYvxN0h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 Oct 2025 09:15:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760080557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Rp/JfHMIffiimy4DDTGv8kJRHufu9eKtuWQ4rilImI=;
	b=zJKpNwev0yHJ34PKGzAOecp+Mu9MRZY8nhVl7+uc/mkG4AG5paz9fU31g/FI9cjCjD9wJk
	IWDPuSv0+7s2oQfS5CsgP4ce62O7AzL2uPr9mtWCAaM2WdNJeT70pbqDH+dtOKHsxnIi8g
	OvvsdXVhlMKluAQ9NraDjypJfDo/gVN/SrE83THY8HMDvjac5c7SkgpuobVW+cIrgDcLZ7
	zQ3EX/pQw9WkHMzGsjuYNJHLyJQBlTN1r5ovA6NMFnseS7SbU0y8Qtzkc5Du2xxBxLE0pq
	k7UNrBX8RMUpSOVUQJaQ60hJCBagwv6yOH6HHuDxmyeWknaJte5/ItouVS4hXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760080557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Rp/JfHMIffiimy4DDTGv8kJRHufu9eKtuWQ4rilImI=;
	b=DRYvxN0hkH+E9O3t7Xn7E/Kj+AoAN/uYU3ry8ffIZNJHJYAgmGfbwTrCoCMnPMlAIEMmw/
	uheeLPCqC1RDLWDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci/aer_inject: switching inject_lock to
 raw_spinlock_t
Message-ID: <20251010071555.u4ubYPid@linutronix.de>
References: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com>

On 2025-10-09 15:06:50 [+0000], Guangbo Cui wrote:
> When injecting AER errors under PREEMPT_RT, the kernel may trigger a
> lockdep warning about an invalid wait context:
>=20
> ```
> [ 1850.950780] [ BUG: Invalid wait context ]
> [ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
> [ 1850.951457] -----------------------------
> [ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
> [ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_re=
ad_config+0x38/0x1dc
> [ 1850.952731] other info that might help us debug this:
> [ 1850.952997] context-{5:5}
> [ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
> [ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_=
bh_disable_ip+0x30/0x268
> [ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu=
_lock_acquire+0x4/0x48
> [ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_=
pme_irq+0x34/0xc4
> [ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu=
_lock_acquire+0x4/0x48
> [ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_=
read_config_dword+0x5c/0xd8
> ```
>=20
> This happens because the AER injection path (`aer_inj_read_config()`)
> is called in the context of the PCIe PME interrupt thread, which runs
> through `irq_forced_thread_fn()` under PREEMPT_RT. In this context,
> `pci_lock` (a raw_spinlock_t) is held with interrupts disabled
> (`spin_lock_irqsave()`), and then `aer_inj_read_config()` tries to
> acquire `inject_lock`, which is a `rt_spin_lock`. (Thanks Waiman Long)

This is way more verbose than it has to be. The key point here is that
it is a "sleeping while atomic" condition because, as you correctly
identified, a raw_spinlock_t is held while a sleeping lock und
PREEMPT_RT is accessed. No need to paste halve of lockdep's output.

> `rt_spin_lock` may sleep, so acquiring it while holding a raw spinlock
> with IRQs disabled violates the lock ordering rules. This leads to
> the =E2=80=9CInvalid wait context=E2=80=9D lockdep warning.
>=20
> In other words, the lock order looks like this:
>=20
> ```
>   raw_spin_lock_irqsave(&pci_lock);
>       =E2=86=93
>   rt_spin_lock(&inject_lock);   <-- not allowed
> ```

=2E..

> To fix this, convert `inject_lock` from an `rt_spin_lock` to a
> `raw_spinlock_t`, a raw spinlock is safe and consistent with the
> surrounding locking scheme.

Switching the lock type is a possible solution. It must not become the
default solution if things like this happen. In this case it is okay as
lock usage is limited and the only source of "unbound latencies" is the
list it protects. This is of no concern as you explained it should not
contain thousands of items _and_ it is used only for debugging and
development.

> This resolves the lockdep =E2=80=9CInvalid wait context=E2=80=9D warning =
observed when
> injecting correctable AER errors through `/dev/aer_inject` on PREEMPT_RT.
>=20
> This was discovered while testing PCIe AER error injection on an arm64
> QEMU virtual machine:
>=20
> ```
>   qemu-system-aarch64 \
>       -nographic \
>       -machine virt,highmem=3Doff,gic-version=3D3 \
>       -cpu cortex-a72 \
>       -kernel arch/arm64/boot/Image \
>       -initrd initramfs.cpio.gz \
>       -append "console=3DttyAMA0 root=3D/dev/ram rdinit=3D/linuxrc earlyp=
rintk nokaslr" \
>       -m 2G \
>       -smp 1 \
>       -netdev user,id=3Dnet0,hostfwd=3Dtcp::2223-:22 \
>       -device virtio-net-pci,netdev=3Dnet0 \
>       -device pcie-root-port,id=3Drp0,chassis=3D1,slot=3D0x0 \
>       -device pci-testdev -s -S
> ```
>=20
> Injecting a correctable PCIe error via /dev/aer_inject caused a BUG
> report with "Invalid wait context" in the irq/PCIe thread.
>=20
> ```
> ~ # export HEX=3D"0002000000000000010000000000000000000000000000000000000=
0"
> ~ # echo -n "$HEX" | xxd -r -p | tee /dev/aer_inject >/dev/null
> [ 1850.947170] pcieport 0000:00:02.0: aer_inject: Injecting errors 000000=
01/00000000 into device 0000:00:02.0
> [ 1850.949951]
> [ 1850.950479] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 1850.950780] [ BUG: Invalid wait context ]
> [ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
> [ 1850.951457] -----------------------------
> [ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
> [ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_re=
ad_config+0x38/0x1dc
> [ 1850.952731] other info that might help us debug this:
> [ 1850.952997] context-{5:5}
> [ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
> [ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_=
bh_disable_ip+0x30/0x268
> [ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu=
_lock_acquire+0x4/0x48
> [ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_=
pme_irq+0x34/0xc4
> [ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu=
_lock_acquire+0x4/0x48
> [ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_=
read_config_dword+0x5c/0xd8
> [ 1850.955932] stack backtrace:
> [ 1850.956412] CPU: 0 UID: 0 PID: 56 Comm: irq/16-PCIe PME Not tainted 6.=
17.0-11316-g7a405dbb0f03-dirty #7 PREEMPT_{RT,(full)}
> [ 1850.957039] Hardware name: linux,dummy-virt (DT)
> [ 1850.957409] Call trace:
> [ 1850.957727]  show_stack+0x18/0x24 (C)
> [ 1850.958089]  dump_stack_lvl+0x40/0xbc
> [ 1850.958339]  dump_stack+0x18/0x24
> [ 1850.958586]  __lock_acquire+0xa84/0x3008
> [ 1850.958907]  lock_acquire+0x128/0x2a8
> [ 1850.959171]  rt_spin_lock+0x50/0x1b8
> [ 1850.959476]  aer_inj_read_config+0x38/0x1dc
> [ 1850.959821]  pci_bus_read_config_dword+0x80/0xd8
> [ 1850.960079]  pcie_capability_read_dword+0xac/0xd8
> [ 1850.960454]  pcie_pme_irq+0x44/0xc4
> [ 1850.960728]  irq_forced_thread_fn+0x30/0x94
> [ 1850.960984]  irq_thread+0x1ac/0x3a4
> [ 1850.961308]  kthread+0x1b4/0x208
> [ 1850.961557]  ret_from_fork+0x10/0x20
> [ 1850.963088] pcieport 0000:00:02.0: AER: Correctable error message rece=
ived from 0000:00:02.0
> [ 1850.963330] pcieport 0000:00:02.0: PCIe Bus Error: severity=3DCorrecta=
ble, type=3DPhysical Layer, (Receiver ID)
> [ 1850.963351] pcieport 0000:00:02.0:   device [1b36:000c] error status/m=
ask=3D00000001/0000e000
> [ 1850.963385] pcieport 0000:00:02.0:    [ 0] RxErr                  (Fir=
st)
> ```

This is a lot. And I don't think this belongs here. The part how to use
aer_inject should be described somewhere in Documentation/ as _this_ is
not unique to your usage but a general problem of the driver.
The commit message should describe the problem you are facing and your
solution to it. Please take a look at
	https://docs.kernel.org/process/submitting-patches.html#describe-your-chan=
ges

> Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
> ---
> index 91acc7b17f68..6dd231d9fccd 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -523,8 +523,8 @@ static int __init aer_inject_init(void)
>  static void __exit aer_inject_exit(void)
>  {
>  	struct aer_error *err, *err_next;
> -	unsigned long flags;
>  	struct pci_bus_ops *bus_ops;
> +	LIST_HEAD(einjected_to_free);
> =20
>  	misc_deregister(&aer_inject_device);
> =20
> @@ -533,12 +533,14 @@ static void __exit aer_inject_exit(void)
>  		kfree(bus_ops);
>  	}
> =20
> -	spin_lock_irqsave(&inject_lock, flags);
> -	list_for_each_entry_safe(err, err_next, &einjected, list) {
> +	scoped_guard(raw_spinlock_irqsave, &inject_lock) {
> +		list_splice_init(&einjected, &einjected_to_free);
> +	}

I would either convert _all_ instance of the lock usage to guard
notation or none. But not one.
Also I wouldn't split everything to another list just to free it later.
I would argue here that locking in aer_inject_exit() locking is not
required because the misc device is removed (no one can keep it open as
it would not allow module removal) and so this is the only possible
user.
Therefore you can iterate over the list and free items lock less.
This reasoning of this change needs to be part of your commit
description. Also _why_ this becomes a problem. You do not mention this
change at all.

> +	list_for_each_entry_safe(err, err_next, &einjected_to_free, list) {
>  		list_del(&err->list);
>  		kfree(err);
>  	}
> -	spin_unlock_irqrestore(&inject_lock, flags);
>  }
> =20
>  module_init(aer_inject_init);

Sebastian

