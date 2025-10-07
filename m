Return-Path: <linux-pci+bounces-37679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3C1BC20B9
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B2FA34FF69
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050BF2DCF78;
	Tue,  7 Oct 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/dm62JI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E328F5
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853458; cv=none; b=Dyl74xQlDA00IMthhoP7RF5RXNoIlfm2XWH16S9Y71VfaIZUOb3QCmRJt5dDP1wOo1QG/X/mWvippbsZGj0jBG8yTaxU3v0CfKMV8400B1L8qZg+PoRAJQWQETRq8xp9A0BUvOCxAwL0FckyGHXsuErT9iE7HBFyrXFYkhghC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853458; c=relaxed/simple;
	bh=23spyynB0cqNsHrBwAdRF5C6HK5JcUDPHhLhZJ27dIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8k3lZNyqJxYBx4gl+DfU2FTbWNeXYLB2FrFNOEXqdBGOTNPfBnEB9ymrZ/zSqd6CX62WcB94+aBirkdVWHejeUKS/BTpse7E3Jhb/4sn8Bczbyo7k0nFY5IagngqPGuzQefFptH82XWrTIvjqMdtcRP4CfNV1pBIV3wXzknDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/dm62JI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-339d53f4960so3555106a91.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759853457; x=1760458257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ww5A9QLVLF9MHFrBjtfqLgeO9mCIYxCjgSA4ZPNH8dU=;
        b=V/dm62JIxZfXT3/CKZ3NUX91jTzNnHZW2lUrzH+7HdBK+JvELhbgDxQOZmXRmCYw69
         S3mPsqciSbOccJvEOSlWH6A9/eSAjk/oKaLLZwDLr5UgM32ou6Unu9udZhlPUIqhFVv3
         z9ke4Gxk7oNN6RQlOScqm1rxzlpEFzaXuLknAhBhAFwOg0xO/xAs2HL0I8qP1P8rjabf
         0BvmpBiv3dkWQH16FJUHpees+14hfFmWHYAnYQU0N2Noslm5jGHel7TtFYuJyNeiD1A1
         1NbM9nBDWGcKogdICWe14kVoKVlo8c/ZWrgbhb3gL2q73Kx5sN/F7zhRDnq2v6ECo3XC
         421w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853457; x=1760458257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ww5A9QLVLF9MHFrBjtfqLgeO9mCIYxCjgSA4ZPNH8dU=;
        b=INRms97iN04LEyw0QLJliZW21VEwUd+TTVjiYsplCHEKGx5oTE3qERZFKU5QR0y1kJ
         iIJoT4lOZrr86FP2DmjrEVaThS66cbjkdoyPUuqsehIwXu0ZpvN2dgPhK5HWrOOJg20V
         1bC3SJLmB+bSVbw/ob4fwAi1U96DZ7V9mdUcSVHZYnbOwu/3jLgVV5/7myOucteAn7Yp
         IZGCUYM/M0ClLuFtZBX4Qq7KO+fjRmC6F7rH/4byuwN9pg/H8/hApQ/Jw54UGYQbBg9E
         zdfUkCKkotEvrno2YRqahXqqlC49/bsLt7qOApTy+utY8hvvk7/09fcktyD6Vz/JTm5a
         unHw==
X-Forwarded-Encrypted: i=1; AJvYcCV+pox9SvteOt8wX5vvcYHGgJ5uqlr0pBXBq83u7l34c+1RnLCZ5xufe1lSpyJD+9clGvPwb5AZfmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vfEusmrwP6hLA1O5vVVRFNDObRfDCFB1Ck41E7QPr2yWSFrw
	CXgjPmNxDY533RbmOiYqZLOHlBFCMVAai0UBYdFQTi08km7urtsQVPLVqUtAV0Z1QxiVO7rZhzY
	hzGS8jSTzI7tiFFmJ1fET8PruUnR1Sb0=
X-Gm-Gg: ASbGncv31ClSzVIadaxClr1OCEZAWNxWa4iIh7+HTWt0MfQAgM+4Le8XcUbEqxfLjRU
	9alzA4fNRZopQOdxggcKteRp3lIMh752LGcW27ys+yG/c+ahFdpd9EU79pox9MgrS49CBk/CK85
	tQX0V2cJbI5+kMqsiVVZWo+01Tipj5EZNVvrqGrLOIjuOTkGJ2NWxOqpXcw/pNTywcKZgiycjm9
	rkOWfASqXXAVG0SMV75/uNp6T1UWRNyMgTU0G6tPe4=
X-Google-Smtp-Source: AGHT+IGJJpzPBxcd6aeQej3XljQ3lxvUxspSqUl1LdUZeeFNyJ+K+vdK7I6p2lY3vune3YygMz/VZesA43Ks3Af09Ak=
X-Received: by 2002:a17:90b:3b49:b0:330:a301:35f4 with SMTP id
 98e67ed59e1d1-33b513b4b46mr44952a91.20.1759853456576; Tue, 07 Oct 2025
 09:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007060218.57222-1-jckeep.cuiguangbo@gmail.com> <4ab58884-aad3-4c99-a5f9-b23e775a1514@redhat.com>
In-Reply-To: <4ab58884-aad3-4c99-a5f9-b23e775a1514@redhat.com>
From: guangbo cui <jckeep.cuiguangbo@gmail.com>
Date: Wed, 8 Oct 2025 00:10:45 +0800
X-Gm-Features: AS18NWCS1wxb3gY3lfJbMPL239E4u53x8rH8x6LyTql4zmMXKbknajNjC1YY13M
Message-ID: <CAH6oFv+KYGZNzb7gySoyQAB3tn2CrH+H_-vi4E=4NS6pvTBHvw@mail.gmail.com>
Subject: Re: [PATCH] pci/aer_inject: switching inject_lock to raw_spinlock_t
To: Waiman Long <llong@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 07, 2025 at 11:13:33AM -0400, Waiman Long wrote:
> On 10/7/25 2:02 AM, Guangbo Cui wrote:
> > [ 1850.947170] pcieport 0000:00:02.0: aer_inject: Injecting errors 00000001/00000000 into device 0000:00:02.0
> > [ 1850.949951]
> > [ 1850.950479] =============================
> > [ 1850.950780] [ BUG: Invalid wait context ]
> > [ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
> > [ 1850.951457] -----------------------------
> > [ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
> > [ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_read_config+0x38/0x1dc
> > [ 1850.952731] other info that might help us debug this:
> > [ 1850.952997] context-{5:5}
> > [ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
> > [ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x30/0x268
> > [ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> > [ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_pme_irq+0x34/0xc4
> > [ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> > [ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x5c/0xd8
> > [ 1850.955932] stack backtrace:
> > [ 1850.956412] CPU: 0 UID: 0 PID: 56 Comm: irq/16-PCIe PME Not tainted 6.17.0-11316-g7a405dbb0f03-dirty #7 PREEMPT_{RT,(full)}
> > [ 1850.957039] Hardware name: linux,dummy-virt (DT)
> > [ 1850.957409] Call trace:
> > [ 1850.957727]  show_stack+0x18/0x24 (C)
> > [ 1850.958089]  dump_stack_lvl+0x40/0xbc
> > [ 1850.958339]  dump_stack+0x18/0x24
> > [ 1850.958586]  __lock_acquire+0xa84/0x3008
> > [ 1850.958907]  lock_acquire+0x128/0x2a8
> > [ 1850.959171]  rt_spin_lock+0x50/0x1b8
> > [ 1850.959476]  aer_inj_read_config+0x38/0x1dc
> > [ 1850.959821]  pci_bus_read_config_dword+0x80/0xd8
> > [ 1850.960079]  pcie_capability_read_dword+0xac/0xd8
> > [ 1850.960454]  pcie_pme_irq+0x44/0xc4
> > [ 1850.960728]  irq_forced_thread_fn+0x30/0x94
> > [ 1850.960984]  irq_thread+0x1ac/0x3a4
> > [ 1850.961308]  kthread+0x1b4/0x208
> > [ 1850.961557]  ret_from_fork+0x10/0x20
> > [ 1850.963088] pcieport 0000:00:02.0: AER: Correctable error message received from 0000:00:02.0
> > [ 1850.963330] pcieport 0000:00:02.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
> > [ 1850.963351] pcieport 0000:00:02.0:   device [1b36:000c] error status/mask=00000001/0000e000
> > [ 1850.963385] pcieport 0000:00:02.0:    [ 0] RxErr                  (First)
>
> Changing inject_lock into a raw_spinlock is the most obvious solution as
> long as it meets the criteria that the lock hold time is deterministic and
> relatively short and no other sleeping locks are being acquired down the
> locking chain.
>
> I am afraid that the these criteria are not met. First of all in
> aer_inject_exit(), inject_lock is acquired while iterating the a linked list
> which can last for while depending on how many items are in the list. This
> may be OK as long as it is guaranteed the list will not be long. Another
> problem is that it call kfree() while holding the lock. kfree() will likely
> acquire another rt_spin_lock which is a sleeping lock. You will have to
> consider pulling kfree() out from the lock critical section.

The list length depends on how many error injections the user performs,
which is typically small since this feature is mainly used for development
and debugging purposes. So the list traversal time should be acceptable
in practice.

Yeah, pulling kfree() out from the lock critical section is right, I
will fix it in the next version.

> Another function __find_aer_error() which does list iteration is called
> while holding inject_lock. Again this may be a problem. If the linked list
> can be long, you may have to consider breaking inject_lock into 2 or more
> separate locks to guard different data.

As mentioned above, the list is usually short in typical use cases,
since error injection is mainly used for debugging or development
purposes. Perhaps we can also get some advice from the PCI folks.

Best regards,
Guangbo

