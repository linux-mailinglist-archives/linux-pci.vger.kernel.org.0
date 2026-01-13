Return-Path: <linux-pci+bounces-44657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E6CD1ABE6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 18:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD95B302F69C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9273350A19;
	Tue, 13 Jan 2026 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="i15xUiSj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D834D90C;
	Tue, 13 Jan 2026 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326723; cv=none; b=t2nb+ILxTrVP9qPcoBfXTizISlooqgl4r6Y7uyAciAcKxnLl+JrpCxZXevs9F3AdW0VO6usk1fvmmwOGaT1ukz3M/Z6wjpR1QDsZGKcmTv/tWTTCGa9aHD0OqlJCVDUEGolXwUY9nIDqxmw/W3bQ0oKNeJssgFuS5d7oM4+dRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326723; c=relaxed/simple;
	bh=AJeoNGr6qdm3JXDhXCojLqGsQMtN+7j7kjNUl8uKIHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RuHlqT7oLpbDb7pHXj7PuWbazivaObaKEV9jDTxd7HtUld2/zAH9/EpdMegx1cY+BS+2Rd5PTxhjfy4mzAyiCmgS6XckPGaadIHU91H92wj+EhqecisVZ92dcmefTSqpLl5ZVrAZtgfKzSxCcvzWXGZcpiF9gsOj8n6GcaZctvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=i15xUiSj; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768326633; x=1768931433; i=spasswolf@web.de;
	bh=7n1iR718T5o0BcQlqMpvq+uG03+9ZCF5Usnrjmuc3fw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i15xUiSjKH29vo5vLYEIvH9gaTRIZFC5KKaIa9yc6+tKNQp1vtoL5ABtXg6NQAlI
	 ANPdbJxWIqcOsgPXJUX0SGjow0Xt7/e1GjnDnjQp0jVmVQZHR51BSSCU9tD89AZbN
	 j7FFdlO4SNuiuw2M/B7gbJ7RoctmPnJKfEo/m2r9gisHMmI/sVFmV0FaTUh5a387T
	 CQsgxu/FNeoMOD8gaX5ubzicPfUg/saFNleKt64yoNR/HcVpgYW2/ZJW7g3pcTR1t
	 R2D5GSVGJeKEGbq7/ic1Da7RAhv2GppJddMX9O6E02oml/BtxGAxSXQwEVlxvUMTZ
	 ohEHn9Nvgpgi9g31Bg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvsq5-1vvruY2BqJ-00sx6O; Tue, 13
 Jan 2026 18:50:33 +0100
Message-ID: <bc20529d7520e7db7de2022bf9c96a1bc3a2f0df.camel@web.de>
Subject: Re: NMI stack overflow during resume of PCIe bridge with
 CONFIG_HARDLOCKUP_DETECTOR=y
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, spasswolf@web.de, Mario Limonciello	
 <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev, Robert Moore	
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Clemens Ladisch <clemens@ladisch.de>,
 Jinchao Wang	 <wangjinchao600@gmail.com>, Yury Norov
 <yury.norov@gmail.com>, Anna Schumaker	 <anna.schumaker@oracle.com>,
 Baoquan He <bhe@redhat.com>, "Darrick J. Wong"	 <djwong@kernel.org>, Dave
 Young <dyoung@redhat.com>, Doug Anderson	 <dianders@chromium.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Helge Deller <deller@gmx.de>,
 Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,  Joanthan
 Cameron <Jonathan.Cameron@huawei.com>, Joel Granados
 <joel.granados@kernel.org>, John Ogness	 <john.ogness@linutronix.de>, Kees
 Cook <kees@kernel.org>, Li Huafei	 <lihuafei1@huawei.com>, "Luck, Tony"
 <tony.luck@intel.com>, Luo Gengkun	 <luogengkun@huaweicloud.com>, Max
 Kellermann <max.kellermann@ionos.com>, Nam Cao <namcao@linutronix.de>,
 oushixiong <oushixiong@kylinos.cn>, Petr Mladek	 <pmladek@suse.com>,
 Qianqiang Liu <qianqiang.liu@163.com>, Sergey Senozhatsky	
 <senozhatsky@chromium.org>, Sohil Mehta <sohil.mehta@intel.com>, Tejun Heo	
 <tj@kernel.org>, Thomas Zimemrmann <tzimmermann@suse.de>, Thorsten Blum	
 <thorsten.blum@linux.dev>, Ville Syrjala <ville.syrjala@linux.intel.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Andrew Morton	 <akpm@linux-foundation.org>, W_Armin@gmx.de
Date: Tue, 13 Jan 2026 18:50:24 +0100
In-Reply-To: <87h5spk01t.ffs@tglx>
References: <20260113094129.3357-1-spasswolf@web.de> <87h5spk01t.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yd/0p+R+wmB/X5XU+AzsenSFPtTWu5+LvJ0pTPE/mWBomKw3Sg2
 XuMKmj43glTkPM4AN1qzKa9foxoXFBRVad+uVe1ekRXwQRPOur6CW20OxQN96NWqKy0tYEo
 ZEjkKJTb7aORlGW5mR+cKJrBeizF9ELwR76NoxXbKAQRFxA5+mN2HIALmRiHxh8qPWZzIty
 J8WB4wUGor29KHbB4ceZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Fbty3AKeeMs=;iDLqpakMiMtS5nThElexEffKna4
 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

Am Dienstag, dem 13.01.2026 um 16:24 +0100 schrieb Thomas Gleixner:
> On Tue, Jan 13 2026 at 10:41, Bert Karwatzki wrote:
> > Here's the result in case of the crash:
> > 2026-01-12T04:24:36.809904+01:00 T1510;acpi_ex_system_memory_space_han=
dler 255: logical_addr_ptr =3D ffffc066977b3000
> > 2026-01-12T04:24:36.846170+01:00 C14;exc_nmi: 0
>=20
> Here the NMI triggers in non-task context on CPU14
>=20
> > 2026-01-12T04:24:36.960760+01:00 C14;exc_nmi: 10.3
> > 2026-01-12T04:24:36.960760+01:00 C14;default_do_nmi=20
> > 2026-01-12T04:24:36.960760+01:00 C14;nmi_handle: type=3D0x0
> > 2026-01-12T04:24:36.960760+01:00 C14;nmi_handle: a=3D0xffffffffa1612de=
0
> > 2026-01-12T04:24:36.960760+01:00 C14;nmi_handle: a->handler=3Dperf_eve=
nt_nmi_handler+0x0/0xa6
> > 2026-01-12T04:24:36.960760+01:00 C14;perf_event_nmi_handler: 0
> > 2026-01-12T04:24:36.960760+01:00 C14;perf_event_nmi_handler: 1
> > 2026-01-12T04:24:36.960760+01:00 C14;perf_event_nmi_handler: 2
> > 2026-01-12T04:24:36.960760+01:00 C14;x86_pmu_handle_irq: 2
> > 2026-01-12T04:24:36.960760+01:00 C14;x86_pmu_handle_irq: 2.6
> > 2026-01-12T04:24:36.960760+01:00 C14;__perf_event_overflow: 0
> > 2026-01-12T04:24:36.960760+01:00 C14;__perf_event_overflow: 6.99: over=
flow_handler=3Dwatchdog_overflow_callback+0x0/0x10d
> > 2026-01-12T04:24:36.960760+01:00 C14;watchdog_overflow_callback: 0
> > 2026-01-12T04:24:36.960760+01:00 C14;__ktime_get_fast_ns_debug: 0.1
> > 2026-01-12T04:24:36.960760+01:00 C14;tk_clock_read_debug: read=3Dread_=
hpet+0x0/0xf0
> > 2026-01-12T04:24:36.960760+01:00 C14;read_hpet: 0
> > 2026-01-12T04:24:36.960760+01:00 C14;read_hpet: 0.1
>=20
> > 2026-01-12T04:24:36.960760+01:00 T0;exc_nmi: 0
>=20
> This one triggers in task context of PID0, aka idle task, but it's not
> clear on which CPU that happens. It's probably CPU13 as that continues
> with the expected 10.3 output, but that's almost ~1.71 seconds later.
>=20
The long delays seem to be typical for the first NMI after trying to acces=
s
the broken memory at phys_addr 0xf0100000, here's an example from an earli=
er
run with more printk()s in that part of the code (too many printk()s seem =
to
cause addtional system freezes ...)


2026-01-03T14:10:10.312182+01:00 T1511;acpi_ex_system_memory_space_handler=
 255: logical_addr_ptr =3D ffffbaa49c15d000
2026-01-03T14:10:10.616281+01:00 T0;exc_nmi: 0
2026-01-03T14:10:10.616281+01:00 T0;exc_nmi: 1
2026-01-03T14:10:10.616281+01:00 T0;exc_nmi: 2
2026-01-03T14:10:10.616281+01:00 T0;exc_nmi: 3
2026-01-03T14:10:10.616281+01:00 T0;exc_nmi: 4
2026-01-03T14:10:10.616281+01:00 T0;exc_nmi: 5
2026-01-03T14:10:10.616281+01:00 T0;exc_nmi: 6
2026-01-03T14:10:10.616281+01:00 T0;exc_nmi: 7
2026-01-03T14:10:10.616281+01:00 T0;irqentry_nmi_enter: 0
2026-01-03T14:10:10.616281+01:00 T0;irqentry_nmi_enter: 1
2026-01-03T14:10:11.055800+01:00 C8;irqentry_nmi_enter: 2
2026-01-03T14:10:11.055800+01:00 C8;irqentry_nmi_enter: 3
2026-01-03T14:10:11.055800+01:00 C8;irqentry_nmi_enter: 4
2026-01-03T14:10:11.055800+01:00 C8;irqentry_nmi_enter: 5
2026-01-03T14:10:11.055800+01:00 C8;irqentry_nmi_enter: irq_state=3D0x0
2026-01-03T14:10:11.055800+01:00 C8;exc_nmi: 8
2026-01-03T14:10:11.055800+01:00 C8;exc_nmi: 9
2026-01-03T14:10:11.055800+01:00 C8;exc_nmi: 10.3

Position of printk()s in irqentry_nmi_enter() was:
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e33691d5adf7..42cba2ea7aa1 100644
=2D-- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -370,12 +370,18 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct p=
t_regs *regs)
 {
        irqentry_state_t irq_state;
=20
+       printk(KERN_INFO "%s: 0\n", __func__);
        irq_state.lockdep =3D lockdep_hardirqs_enabled();
+       printk(KERN_INFO "%s: 1\n", __func__);
=20
        __nmi_enter();
+       printk(KERN_INFO "%s: 2\n", __func__);
        lockdep_hardirqs_off(CALLER_ADDR0);
+       printk(KERN_INFO "%s: 3\n", __func__);
        lockdep_hardirq_enter();
+       printk(KERN_INFO "%s: 4\n", __func__);
        ct_nmi_enter();
+       printk(KERN_INFO "%s: 5\n", __func__);
=20
        instrumentation_begin();
        kmsan_unpoison_entry_regs(regs);
@@ -383,6 +389,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_=
regs *regs)
        ftrace_nmi_enter();
        instrumentation_end();
=20
+       printk(KERN_INFO "%s: irq_state=3D0x%x\n", __func__, irq_state);
        return irq_state;
 }
=20

>  What's more likely is that after a while
> _ALL_ CPUs are hung up in the NMI handler after they tripped over the
> HPET read.

I'm not sure about that, my latest testrun (with v6.18) crashed with only =
one message
from exc_nmi().

>=20
> > The behaviour described here seems to be similar to the bug that commi=
t
> > 3d5f4f15b778 ("watchdog: skip checks when panic is in progress") is fi=
xing, but
> > this is actually a different bug as kernel 6.18 (which contains 3d5f4f=
15b778)
> > is also affected (I've conducted 5 tests with 6.18 so far and got 4 cr=
ashes (crashes occured
> > after (0.5h, 1h, 4.5h, 1.5h) of testing)).=20
> > Nevertheless these look similar enough to CC the involved people.
>=20
> There is nothing similar.
>=20
> Your problem originates from a screwed up hardware state which in turn
> causes the HPET to go haywire for unknown reasons.
>=20
> What is the physical address of this ACPI handler access:
>=20
>        logical_addr_ptr =3D ffffc066977b3000
>=20
> along with the full output of /proc/iomem

The physical address is 0xf0100000

$ cat /proc/iomem
00000000-00000fff : Reserved
00001000-0009ffff : System RAM
000a0000-000fffff : Reserved
  000a0000-000dffff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-09bfefff : System RAM
09bff000-0a000fff : Reserved
0a001000-0a1fffff : System RAM
0a200000-0a20efff : ACPI Non-volatile Storage
0a20f000-e6057fff : System RAM
  15000000-15b252c1 : Kernel code
  15c00000-15f60fff : Kernel rodata
  16000000-1610e27f : Kernel data
  165ce000-167fffff : Kernel bss
  9c000000-dbffffff : Crash kernel
e6058000-e614bfff : Reserved
e614c000-e868afff : System RAM
e868b000-e868bfff : Reserved
e868c000-e9cdefff : System RAM
e9cdf000-eb1fdfff : Reserved
  eb1dd000-eb1e0fff : MSFT0101:00
  eb1e1000-eb1e4fff : MSFT0101:00
eb1fe000-eb25dfff : ACPI Tables
eb25e000-eb555fff : ACPI Non-volatile Storage
eb556000-ed1fefff : Reserved
ed1ff000-edffffff : System RAM
ee000000-efffffff : Reserved
f0000000-fcffffff : PCI Bus 0000:00
  f0000000-f7ffffff : PCI ECAM 0000 [bus 00-7f]
    f0000000-f7ffffff : pnp 00:00
  fc500000-fc9fffff : PCI Bus 0000:08
    fc500000-fc5fffff : 0000:08:00.7
      fc500000-fc5fffff : pcie_mp2_amd
    fc600000-fc6fffff : 0000:08:00.4
      fc600000-fc6fffff : xhci-hcd
    fc700000-fc7fffff : 0000:08:00.3
      fc700000-fc7fffff : xhci-hcd
    fc800000-fc8fffff : 0000:08:00.2
      fc800000-fc8fffff : ccp
    fc900000-fc97ffff : 0000:08:00.0
    fc980000-fc9bffff : 0000:08:00.5
      fc980000-fc9bffff : AMD ACP3x audio
        fc980000-fc990200 : acp_pdm_iomem
    fc9c0000-fc9c7fff : 0000:08:00.6
      fc9c0000-fc9c7fff : ICH HD audio
    fc9c8000-fc9cbfff : 0000:08:00.1
      fc9c8000-fc9cbfff : ICH HD audio
    fc9cc000-fc9cdfff : 0000:08:00.7
    fc9ce000-fc9cffff : 0000:08:00.2
      fc9ce000-fc9cffff : ccp
  fca00000-fccfffff : PCI Bus 0000:01
    fca00000-fcbfffff : PCI Bus 0000:02
      fca00000-fcbfffff : PCI Bus 0000:03
        fca00000-fcafffff : 0000:03:00.0
        fcb00000-fcb1ffff : 0000:03:00.0
        fcb20000-fcb23fff : 0000:03:00.1
          fcb20000-fcb23fff : ICH HD audio
    fcc00000-fcc03fff : 0000:01:00.0
  fcd00000-fcdfffff : PCI Bus 0000:07
    fcd00000-fcd03fff : 0000:07:00.0
      fcd00000-fcd03fff : nvme
  fce00000-fcefffff : PCI Bus 0000:06
    fce00000-fce03fff : 0000:06:00.0
      fce00000-fce03fff : nvme
  fcf00000-fcffffff : PCI Bus 0000:05
    fcf00000-fcf03fff : 0000:05:00.0
    fcf04000-fcf04fff : 0000:05:00.0
      fcf04000-fcf04fff : r8169
fd300000-fd37ffff : amd_iommu
fec00000-fec003ff : IOAPIC 0
fec01000-fec013ff : IOAPIC 1
fec10000-fec10fff : Reserved
  fec10000-fec10fff : pnp 00:04
fed00000-fed00fff : Reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed40000-fed44fff : Reserved
fed80000-fed8ffff : Reserved
  fed81200-fed812ff : AMDI0030:00
  fed81500-fed818ff : AMDI0030:00
    fed81500-fed818ff : AMDI0030:00 AMDI0030:00
fedc0000-fedc0fff : pnp 00:04
fedc4000-fedc9fff : Reserved
  fedc5000-fedc5fff : AMDI0010:03
    fedc5000-fedc5fff : AMDI0010:03 AMDI0010:03
fedcc000-fedcefff : Reserved
fedd5000-fedd5fff : Reserved
fee00000-fee00fff : pnp 00:04
ff000000-ffffffff : pnp 00:04
100000000-3ee2fffff : System RAM
3ee300000-40fffffff : Reserved
410000000-ffffffffff : PCI Bus 0000:00
  fc00000000-fe0fffffff : PCI Bus 0000:01
    fc00000000-fe0fffffff : PCI Bus 0000:02
      fc00000000-fe0fffffff : PCI Bus 0000:03
        fc00000000-fdffffffff : 0000:03:00.0
        fe00000000-fe0fffffff : 0000:03:00.0
  fe20000000-fe301fffff : PCI Bus 0000:08
    fe20000000-fe2fffffff : 0000:08:00.0
    fe30000000-fe301fffff : 0000:08:00.0
  fe30300000-fe304fffff : PCI Bus 0000:04
    fe30300000-fe303fffff : 0000:04:00.0
      fe30300000-fe303fffff : 0000:04:00.0
    fe30400000-fe30403fff : 0000:04:00.0
    fe30404000-fe30404fff : 0000:04:00.0

>=20
> Thanks,
>=20
>         tglx

Thank you,

Bert Karwatzki

