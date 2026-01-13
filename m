Return-Path: <linux-pci+bounces-44618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A79D19DC0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 564BF300E3C2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708A5315D49;
	Tue, 13 Jan 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhP/y80K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00A70830;
	Tue, 13 Jan 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317890; cv=none; b=XdegkTWPinoSs4zuGe3Wp8HwcJjHo6L4MZaD22vdtzqkw0YY8umok1101Z+xwxVBxQLp+Wzk9ygeaFtZT+0hXbrJWGyI570T2Nlu/6uBIV2WtW99kighKwH6ce0b4lTIIOaudjxw6dtQ3kvFcopwXwGILaf2NXwrWitYadXssuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317890; c=relaxed/simple;
	bh=taak2UygMZbdacgSedIXzlFkiSjhrP80UZpBg3+A9T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKXTvmE5KTGkqPCVLoOGTPkma+MkZEPTRbdD2om7mf9QskYtaoc0d7f4ICyUmbcgMPwF4/nEgpSpUuR56u4sq8avld39mnCnmW0ZV3XKfB2A7R3m8D9YQh1fepebnWItR0z07A8mVoKv0476oS4Ipa0TETk11QbKO8rX/h4UuBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhP/y80K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D46C116C6;
	Tue, 13 Jan 2026 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768317889;
	bh=taak2UygMZbdacgSedIXzlFkiSjhrP80UZpBg3+A9T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AhP/y80KVpZcmRV1+NMKLTI7A3S3B1azBgUpQ1DJUoaoH/TdnGwIdSpNdf4iOtRl5
	 VMjPXhRqRohFjpEbWulvcJ9JjRwozK8fucaQwQiM8u0Gja1ik0Q3sTcW/6IIEq+3d5
	 hHD4PWcpVpfgVDOn0SV7bboOAc09bk7OwyDufmZublxhYqPbm49WVLbdvElM/VF8he
	 HvtLSZJ2jXKm2fI/o+QkcMPrelVltHLBYAFKn1iSoIrObiMteKseVxFxZCfeELV8Ah
	 IWAlUHyqaY0szCLSQBji+FnqKNi/kZEfK8gaMPepsMkMAyl1jzdeApqJdvxGLgQf5K
	 W731h5A9eUm3w==
From: Thomas Gleixner <tglx@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>, linux-next@vger.kernel.org, Mario
 Limonciello <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 regressions@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev, Robert Moore
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Clemens Ladisch <clemens@ladisch.de>,
 Jinchao Wang <wangjinchao600@gmail.com>, Yury Norov
 <yury.norov@gmail.com>, Anna Schumaker <anna.schumaker@oracle.com>,
 Baoquan He <bhe@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, Dave
 Young <dyoung@redhat.com>, Doug Anderson <dianders@chromium.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Helge Deller
 <deller@gmx.de>, Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Joanthan Cameron <Jonathan.Cameron@huawei.com>, Joel
 Granados <joel.granados@kernel.org>, John Ogness
 <john.ogness@linutronix.de>, Kees Cook <kees@kernel.org>, Li Huafei
 <lihuafei1@huawei.com>, "Luck, Tony" <tony.luck@intel.com>, Luo Gengkun
 <luogengkun@huaweicloud.com>, Max Kellermann <max.kellermann@ionos.com>,
 Nam Cao <namcao@linutronix.de>, oushixiong <oushixiong@kylinos.cn>, Petr
 Mladek <pmladek@suse.com>, Qianqiang Liu <qianqiang.liu@163.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Sohil Mehta
 <sohil.mehta@intel.com>, Tejun Heo <tj@kernel.org>, Thomas Zimemrmann
 <tzimmermann@suse.de>, Thorsten Blum <thorsten.blum@linux.dev>, Ville
 Syrjala <ville.syrjala@linux.intel.com>, Vivek Goyal <vgoyal@redhat.com>,
 Yicong Yang <yangyicong@hisilicon.com>, Yunhui Cui
 <cuiyunhui@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>,
 W_Armin@gmx.de
Subject: Re: NMI stack overflow during resume of PCIe bridge with
 CONFIG_HARDLOCKUP_DETECTOR=y
In-Reply-To: <20260113094129.3357-1-spasswolf@web.de>
References: <20260113094129.3357-1-spasswolf@web.de>
Date: Tue, 13 Jan 2026 16:24:46 +0100
Message-ID: <87h5spk01t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13 2026 at 10:41, Bert Karwatzki wrote:
> Here's the result in case of the crash:
> 2026-01-12T04:24:36.809904+01:00 T1510;acpi_ex_system_memory_space_handler 255: logical_addr_ptr = ffffc066977b3000
> 2026-01-12T04:24:36.846170+01:00 C14;exc_nmi: 0

Here the NMI triggers in non-task context on CPU14

> 2026-01-12T04:24:36.960760+01:00 C14;exc_nmi: 10.3
> 2026-01-12T04:24:36.960760+01:00 C14;default_do_nmi 
> 2026-01-12T04:24:36.960760+01:00 C14;nmi_handle: type=0x0
> 2026-01-12T04:24:36.960760+01:00 C14;nmi_handle: a=0xffffffffa1612de0
> 2026-01-12T04:24:36.960760+01:00 C14;nmi_handle: a->handler=perf_event_nmi_handler+0x0/0xa6
> 2026-01-12T04:24:36.960760+01:00 C14;perf_event_nmi_handler: 0
> 2026-01-12T04:24:36.960760+01:00 C14;perf_event_nmi_handler: 1
> 2026-01-12T04:24:36.960760+01:00 C14;perf_event_nmi_handler: 2
> 2026-01-12T04:24:36.960760+01:00 C14;x86_pmu_handle_irq: 2
> 2026-01-12T04:24:36.960760+01:00 C14;x86_pmu_handle_irq: 2.6
> 2026-01-12T04:24:36.960760+01:00 C14;__perf_event_overflow: 0
> 2026-01-12T04:24:36.960760+01:00 C14;__perf_event_overflow: 6.99: overflow_handler=watchdog_overflow_callback+0x0/0x10d
> 2026-01-12T04:24:36.960760+01:00 C14;watchdog_overflow_callback: 0
> 2026-01-12T04:24:36.960760+01:00 C14;__ktime_get_fast_ns_debug: 0.1
> 2026-01-12T04:24:36.960760+01:00 C14;tk_clock_read_debug: read=read_hpet+0x0/0xf0
> 2026-01-12T04:24:36.960760+01:00 C14;read_hpet: 0
> 2026-01-12T04:24:36.960760+01:00 C14;read_hpet: 0.1

> 2026-01-12T04:24:36.960760+01:00 T0;exc_nmi: 0

This one triggers in task context of PID0, aka idle task, but it's not
clear on which CPU that happens. It's probably CPU13 as that continues
with the expected 10.3 output, but that's almost ~1.71 seconds later.

> 2026-01-12T04:24:38.674625+01:00 C13;exc_nmi: 10.3
> 2026-01-12T04:24:38.674625+01:00 C13;default_do_nmi 
> 2026-01-12T04:24:38.674625+01:00 C13;nmi_handle: type=0x0
> 2026-01-12T04:24:38.674625+01:00 C13;nmi_handle: a=0xffffffffa1612de0
> 2026-01-12T04:24:38.674625+01:00 C13;nmi_handle: a->handler=perf_event_nmi_handler+0x0/0xa6
> 2026-01-12T04:24:38.674625+01:00 C13;perf_event_nmi_handler: 0
> 2026-01-12T04:24:38.674625+01:00 C13;perf_event_nmi_handler: 1
> 2026-01-12T04:24:38.674625+01:00 C13;perf_event_nmi_handler: 2
> 2026-01-12T04:24:38.674625+01:00 C13;x86_pmu_handle_irq: 2
> 2026-01-12T04:24:38.674625+01:00 C13;x86_pmu_handle_irq: 2.6
> 2026-01-12T04:24:38.674625+01:00 C13;__perf_event_overflow: 0
> 2026-01-12T04:24:38.674625+01:00 C13;__perf_event_overflow: 6.99: overflow_handler=watchdog_overflow_callback+0x0/0x10d
> 2026-01-12T04:24:38.674625+01:00 C13;watchdog_overflow_callback: 0
> 2026-01-12T04:24:38.674625+01:00 C13;__ktime_get_fast_ns_debug: 0.1
> 2026-01-12T04:24:38.674625+01:00 C13;tk_clock_read_debug: read=read_hpet+0x0/0xf0
> 2026-01-12T04:24:38.674625+01:00 C13;read_hpet: 0
> 2026-01-12T04:24:38.674625+01:00 C13;read_hpet: 0.1

> 2026-01-12T04:24:38.674625+01:00 T0;exc_nmi: 0

Same picture as above, but this time on CPU2 with a delay of 0.68
seconds

> 2026-01-12T04:24:39.355101+01:00 C2;exc_nmi: 10.3
> 2026-01-12T04:24:39.355101+01:00 C2;default_do_nmi 
> 2026-01-12T04:24:39.355101+01:00 C2;nmi_handle: type=0x0
> 2026-01-12T04:24:39.355101+01:00 C2;nmi_handle: a=0xffffffffa1612de0
> 2026-01-12T04:24:39.355101+01:00 C2;nmi_handle: a->handler=perf_event_nmi_handler+0x0/0xa6
> 2026-01-12T04:24:39.355101+01:00 C2;perf_event_nmi_handler: 0
> 2026-01-12T04:24:39.355101+01:00 C2;perf_event_nmi_handler: 1
> 2026-01-12T04:24:39.355101+01:00 C2;perf_event_nmi_handler: 2
> 2026-01-12T04:24:39.355101+01:00 C2;x86_pmu_handle_irq: 2
> 2026-01-12T04:24:39.355101+01:00 C2;x86_pmu_handle_irq: 2.6
> 2026-01-12T04:24:39.355101+01:00 C2;__perf_event_overflow: 0
> 2026-01-12T04:24:39.355101+01:00 C2;__perf_event_overflow: 6.99: overflow_handler=watchdog_overflow_callback+0x0/0x10d
> 2026-01-12T04:24:39.355101+01:00 C2;watchdog_overflow_callback: 0
> 2026-01-12T04:24:39.355101+01:00 C2;__ktime_get_fast_ns_debug: 0.1
> 2026-01-12T04:24:39.355101+01:00 C2;tk_clock_read_debug: read=read_hpet+0x0/0xf0
> 2026-01-12T04:24:39.355101+01:00 C2;read_hpet: 0
> 2026-01-12T04:24:39.355101+01:00 C2;read_hpet: 0.1

> 2026-01-12T04:24:39.355101+01:00 T0;exc_nmi: 0

Again on CPU0 with a delay of 0.06 seconds

> 2026-01-12T04:24:39.410207+01:00 C0;exc_nmi: 10.3
> 2026-01-12T04:24:39.410207+01:00 C0;default_do_nmi 
> 2026-01-12T04:24:39.410207+01:00 C0;nmi_handle: type=0x0
> 2026-01-12T04:24:39.410207+01:00 C0;nmi_handle: a=0xffffffffa1612de0
> 2026-01-12T04:24:39.410207+01:00 C0;nmi_handle: a->handler=perf_event_nmi_handler+0x0/0xa6
> 2026-01-12T04:24:39.410207+01:00 C0;perf_event_nmi_handler: 0
> 2026-01-12T04:24:39.410207+01:00 C0;perf_event_nmi_handler: 1
> 2026-01-12T04:24:39.410207+01:00 C0;perf_event_nmi_handler: 2
> 2026-01-12T04:24:39.410207+01:00 C0;x86_pmu_handle_irq: 2
> 2026-01-12T04:24:39.410207+01:00 C0;x86_pmu_handle_irq: 2.6
> 2026-01-12T04:24:39.410207+01:00 C0;__perf_event_overflow: 0
> 2026-01-12T04:24:39.410207+01:00 C0;__perf_event_overflow: 6.99: overflow_handler=watchdog_overflow_callback+0x0/0x10d
> 2026-01-12T04:24:39.410207+01:00 C0;watchdog_overflow_callback: 0
> 2026-01-12T04:24:39.410207+01:00 C0;__ktime_get_fast_ns_debug: 0.1
> 2026-01-12T04:24:39.410207+01:00 C0;tk_clock_read_debug: read=read_hpet+0x0/0xf0
> 2026-01-12T04:24:39.410207+01:00 C0;read_hpet: 0
> 2026-01-12T04:24:39.410207+01:00 C0;read_hpet: 0.1

> 2026-01-12T04:24:39.410207+01:00 T0;exc_nmi: 0

....

> In the case of the crash the interrupt handler never returns because when accessing
> the HPET another NMI is triggered. This goes on until a crash happens, probably because
> of stack overflow.

No. NMI nesting is only one level deep and immediately returns:

        if (this_cpu_read(nmi_state) != NMI_NOT_RUNNING) {
		this_cpu_write(nmi_state, NMI_LATCHED);
		return;
	}


So it's not a stack overflow. What's more likely is that after a while
_ALL_ CPUs are hung up in the NMI handler after they tripped over the
HPET read.

> The behaviour described here seems to be similar to the bug that commit
> 3d5f4f15b778 ("watchdog: skip checks when panic is in progress") is fixing, but
> this is actually a different bug as kernel 6.18 (which contains 3d5f4f15b778)
> is also affected (I've conducted 5 tests with 6.18 so far and got 4 crashes (crashes occured
> after (0.5h, 1h, 4.5h, 1.5h) of testing)). 
> Nevertheless these look similar enough to CC the involved people.

There is nothing similar.

Your problem originates from a screwed up hardware state which in turn
causes the HPET to go haywire for unknown reasons.

What is the physical address of this ACPI handler access:

       logical_addr_ptr = ffffc066977b3000

along with the full output of /proc/iomem

Thanks,

        tglx

