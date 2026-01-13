Return-Path: <linux-pci+bounces-44683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE629D1B92A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 23:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121EB30111BF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 22:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C203559C8;
	Tue, 13 Jan 2026 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="WS28GEqT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492CC352C53;
	Tue, 13 Jan 2026 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768342859; cv=none; b=FnRRnYfmKZsTGlcgsoFC312QK6jal14YAhZiuAZD7JxoiflmHrSr3JTEWADMJvMdlsToyZvr3Syb5V4RJ2vVObOb6cZDcAV6YMIgzpS416GOqkRCHYeUeC6JVe4fj+0X1YtAXAFYNvB8/LfA2DVylyJr8rDL9Yd16zjjhTgVu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768342859; c=relaxed/simple;
	bh=WYhN3zVo5gDJhDidN7wy254wIzbZOO7AN1+sV+pWZlA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSlMvm3f8sKNUbMYcwmZpXmwCN5TKQBPVASwJfpJSMhf4n/2qIgIlri2yan9EvuC5YthbxEzN1uoKn1cC4bTogtRgdI9wZV5LFxYXGDtaSzhAIDMuKIL6aGce467lvYtkPskEWQJ6MjKtLgvSaYEc9qGThMFUwQRMDp77VSfjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=WS28GEqT; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768342779; x=1768947579; i=spasswolf@web.de;
	bh=ViocbYXnpPhckKciY+v6ul/mpk6ZAETgKmZBKuvqAko=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WS28GEqTedh1nOr4/AqLYuu1ap//KAL14PY6Ub3B4y5TYdX7pO+wDskB1P4N332W
	 0p0iVSstxZUmzABBNmQVt1iaV3X10WQcXrqDT2EZe3R+83p4xKXMixjl6jFHl5IIl
	 Jgu5GBSvKqwsdVsnKEzFbUQqLyiZrgf91fPlVUUNmg9kbUiPtus7JZDxl31o8/bKG
	 6Gc34IW2ZV0xYIpGd7z7ewxO9snnLPzLY3/c5zwuo1uQqetLGPWx3zVh0hgi6Ngq0
	 Ue21kaKgpNn8Vew2YxqGSGDFxwhcjjf17Iq6Cp6dTNZgQwQ96Ke7pdR5q3ZOpk/w0
	 72BOw+p1ZBrk5XyE6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxHYK-1w3nnP1LdQ-010E0L; Tue, 13
 Jan 2026 23:19:39 +0100
Message-ID: <99f1aaba32030d2b9285dbd983fdf8518a181a8d.camel@web.de>
Subject: Re: NMI stack overflow during resume of PCIe bridge with
 CONFIG_HARDLOCKUP_DETECTOR=y
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org
Cc: spasswolf@web.de, linux-next@vger.kernel.org, Mario Limonciello	
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
Date: Tue, 13 Jan 2026 23:19:30 +0100
In-Reply-To: <87v7h5ia3d.ffs@tglx>
References: <20260113094129.3357-1-spasswolf@web.de> <87h5spk01t.ffs@tglx>
	 <bc20529d7520e7db7de2022bf9c96a1bc3a2f0df.camel@web.de>
	 <87v7h5ia3d.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LppR69MnC15AfVNPjVetIGXteEXzL4GPbGOwMYJbG209YGnxwa3
 TGRqZ5IfstTQVstWDV9hgwiaa9lWnCXm87PwpF8dYuBFKrPKWzuz9arNS+zhJ2i1PED3Plv
 blnB/sNPkHTjtysxvgkrg/B2FOaof1jecj+F4XGEviVhvPBeCpE9415JWjHSyS8S1QqK1/N
 KK6TF0+BXMdYuWyFucxDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BIKblzywJ3g=;I9+oETfIpdaAu61bNhbJuNwKF0U
 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
 759SRgtuFsr7AgHOMr0alLxpu0Abt2zt0VxvUv

Am Dienstag, dem 13.01.2026 um 20:30 +0100 schrieb Thomas Gleixner:
> On Tue, Jan 13 2026 at 18:50, Bert Karwatzki wrote:
> > Am Dienstag, dem 13.01.2026 um 16:24 +0100 schrieb Thomas Gleixner:
> >=20
> > >  What's more likely is that after a while _ALL_ CPUs are hung up in
> > > the NMI handler after they tripped over the HPET read.
> >=20
> > I'm not sure about that, my latest testrun (with v6.18) crashed with
> > only one message from exc_nmi().
>=20
> What means crashed? Did it actually crash and output something or does
> the machine just go dead? I assume the latter as you have no output.
>=20
Crashed means, rebooting and trying to reboot into the new kernel, which f=
ails
(i.e. drops to rescue mode)
because one of my 2 nvme devices (not the root fs) is missing from the PCI=
 bus
(the missing device reappears after a shutdown).
When sound is running while such a crash occurs the sound loops for about =
~2s,
before such a reboot occurs (a behaviour I've seen during an unrelated NUL=
L ptr deref in an
interrupt handler once). There's no additional error message output when s=
uch
a crash occurs, only my printk()s.

> > > along with the full output of /proc/iomem
> >=20
> > The physical address is 0xf0100000
> >=20
> > $ cat /proc/iomem
> > f0000000-fcffffff : PCI Bus 0000:00
> >   f0000000-f7ffffff : PCI ECAM 0000 [bus 00-7f]
> >     f0000000-f7ffffff : pnp 00:00
>=20
> That's the memory mapped PCI config space and this tries to access:
>=20
>    MMIO_START			0xf0000000
>    BUSNUM	0x01 << 20      0x00100000
>    SLOT/FN	0x00 << 12      0x00000000
>    OFFSET	0x00 <<  0      0x00000000
>                                -----------
>                                 0xf0100000
>=20
> Offset 0 is vendor/device ID IIRC.
>=20
> Anyway if that access does not complete because of a hardware issue,
> then any subsequent access to the MMIO mapped HPET goes stale as well.
>=20
> As the HPET is the active clocksource on your machine, this obviously
> does not only affect the NMI watchdog readout, it affects the regular
> timekeeper accesses too and all other MMIO accesses all over the place.
> So gradually your machine just stalls on outstanding MMIO transactions
> w/o further notice... The NMI is just a red herring.
>=20
I've already tried different clocsources, with mixed results. tsc does not
work on my system as it is unstable, while acpi_pm also crashed. With jiff=
ies
I had mixed results. It might have avoided one crash, but crashed on anoth=
er
testrun in the same situation.

> You need to figure out why that MMIO access to that device's
> configuration space stalls as anything else is just subsequent
> damage.
>=20
> There is not much what can be done about that unless the PCI bus raises
> a failure interrupt and some magic reset sequence aborts the outstanding
> stalled transactions.
>=20
> Whether that's feasible or not, I don't know. The failure mechanism
> might run into the same stall scenario when accessing the PCI muck for
> reset...

In the two testruns without CONFIG_HARDLOCKUP_DETECTOR I simply lost the d=
iscrete
GPU without a crash, i.e. after 4 and 8.5h the GPU would not resume any mo=
re, and
accessing the GPU with DRI_PRIME=3D1 glxinfo just gives a (user) segfault.=
 But I need
more testruns to see if this behaviour is consistent.

>=20
> Sorry for not being helpful.
>=20
> Thanks,
>=20
>         tglx
>=20

Thanks you

Bert Karwatzki

