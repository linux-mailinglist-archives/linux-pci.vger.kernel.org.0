Return-Path: <linux-pci+bounces-37620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D713BBBEA2E
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 18:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CADA189BDA7
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EBC2DC775;
	Mon,  6 Oct 2025 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="rlSchkIY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1B2DAFBB;
	Mon,  6 Oct 2025 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767775; cv=none; b=RyiT28MoC5L0FmgZC3RcA/nuTDegK4r2/WEGg75iOmLFgENeDVy6N96e1l2SJMGXOMudEeKk0N0lIIK2vYBlyxGwE1+S1KgniddnJKX2worpDH1gvyLaxYhwG0lMu0qgqWVftyhbxAuL9bYANAaysdzOv41NwV513HAcluoZM0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767775; c=relaxed/simple;
	bh=884PvJHcm2i0Tf4+TwZK5v+OMKywwSpAClbiq7l7D1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxEwyN2vwOU3S8FyrZJpQTxAsZNWu97oHO6EOLNcdPlhLpuRkaDHEzm+Vu8c4z4UeGj2Ui/1DRaWZHBwNZinPTh+CDZmWpZVfsp14usZvD2OQmpS0cGuyKIf8fPkfn2y05oMUKQZr4aA4GlPfp/Eq3UofU8ZMTKpBasdxmbaB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=rlSchkIY; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759767753; x=1760372553; i=spasswolf@web.de;
	bh=uxOUA7vfdhaJVB3s0ofk5wbAtw/kPvEKyV3TRgRaZQU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rlSchkIYyzSidwJKXq1vPE6J7JMiGP0nd4cqxRYF4A5eFfUoz4rH34Zx2Mw56Y5f
	 uzpe08vD2PuXg2fDBdGgHUL252IPIIfPzmedYYmJNytpGS+M/LCmCBKIvTADlvTms
	 zOm+STAIZmoA0W9eILs+/UzFisxjkyJRUWm5YwGCup9CAoMUdjq/mj+2ACwRYSQt5
	 Boe4cHzYRDV03f/Uz2Sc4DvvYQ3YHtUZ4qCaJSD0jHdhHqI5lUOA1a38DC4YfvWPF
	 9k0SEuNhNAUDB6rRFJI9+7jlb8fGEHVzJ26EUM7stS3E/VBI7ft3c++dJfdYFNi66
	 kFbhk7jktp4Glwgo1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MECCd-1uxnEy12Xd-0054Qx; Mon, 06
 Oct 2025 18:22:33 +0200
Message-ID: <e60d2cf59666b6f670996bac80cb948acb1d7b5c.camel@web.de>
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
From: Bert Karwatzki <spasswolf@web.de>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-stable@vger.kernel.org, 
	regressions@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Mario Limonciello <superm1@kernel.org>, "Rafael
 J . Wysocki" <rafael.j.wysocki@intel.com>, spasswolf@web.de
Date: Mon, 06 Oct 2025 18:22:31 +0200
In-Reply-To: <232324a9-e82d-40b3-b88b-538947411a24@amd.com>
References: <20251006120944.7880-1-spasswolf@web.de>
	 <232324a9-e82d-40b3-b88b-538947411a24@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7cQZzUVy1ojSzHMbW/eUEZ6O/KpGeiU4sASK9dN7IHrgWmGoXNX
 61vpV1modSJBe+6mNXKTX8JzRLNcSXYX+E4lSDht033bKkR0UOpYJnpRt8lPlRjzrVChqTA
 UG9BFxL5NGzepHWyfTch4bMarNJdd2Qr0672zz4otyIJkI3uKAqGSv7vDOoMZ+psUcbsmNo
 76/iwRA/TAXlCcL5MpOcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E4teUIpIjH4=;wZmGLM/xSZt9VfD/NO5BwFC0qNf
 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
 bCAJTMXHrD3dQe5H0=

Am Montag, dem 06.10.2025 um 14:39 +0200 schrieb Christian K=C3=B6nig:
> On 06.10.25 14:09, Bert Karwatzki wrote:
> > Since linux version v6.15 I experience random crashes on my MSI Alpha =
15 Laptop
> > running debian trixie (amd64). The first such crash happened about in =
the midth
> > of june, and as there were no useful log messages and even using netco=
nsole
> > gave no useful message I suspected faulty hardware. So I ran memtest86=
+ and
> > found a faulty address line and replaced the memory (unfortunately 64G=
 to 16G).
> > But the crashes occured again and so I did a thorough investigation.
> >=20
> > The crashes occur after 30min to 33h (yes, hours) of uptime and consis=
t of a
> > sudden reboot after which the PCI bridge at 00:02.4 and the nvme devic=
e=20
> > connected to it are missing. If there's sound running during the crash=
 then the
> > first sign of the crash is the sound looping like a broken record for =
about 2s,
> > after which the reboot happens. With the missing nvme device the reboo=
t drops to
> > a rescue shell. Using "shutdown -h now" from that shell and starting t=
he laptop
> > with the power button restores the missing PCI bridge and nvme device.
>=20
> Oh well, it sounds like some PCIe device is dropping of the bus and taki=
ng it's upstream bridge with it.
>=20
> > As the bisections were not succesfull I tried to monitor the crash usi=
ng
> > netconsole and CONFIG_ACPI_DEBUG and "acpi.debug_layer=3D0xf acpi.debu=
g_level=3D0x107"
> > as command line parameters. With this the last message on netconsole b=
efore
> > the crash is usually:
> >=20
> > [21465.639279] [    T251]    evmisc-0132 ev_queue_notify_reques: Dispa=
tching Notify on [GPP0] (Device) Value 0x00 (Bus Check) Node 00000000f81f3=
6b8
>=20
> A full dump of that might be helpful. That sounds like the dGPU is power=
ing up/down.

Yes, that's what's happening.

>=20
> >=20
> > GPP0 is the ACPI name of this PCI bridge (at least that's my best gues=
s):
> >=20
> > 00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir P=
CIe GPP Bridge [1022:1633]
> >=20
> > to which the discrete GPU is connected
> >=20
> > 03:00.0 Display controller [0380]: Advanced Micro Devices, Inc. [AMD/A=
TI] Navi 23 [Radeon RX 6600/6600 XT/6600M] [1002:73ff] (rev c3)
> >=20
> > via the pci express switch
> >=20
> > 01:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi=
 10 XL Upstream Port of PCI Express Switch [1002:1478] (rev c3)
> > 02:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi=
 10 XL Downstream Port of PCI Express Switch [1002:1479]
> >=20
> > While the GUI (xfce on xorg) on my laptop runs on the built-in GPU the=
 discrete=20
> > GPU usually wakes up quite often, e.g. when a window is opened or when=
 scrolling down on youtube.
>=20
> Yeah, that is a known issue and we are working on it.

Until linux v6.15 this didn't cause any harm.

>=20
> Basically an application enumerates the possible render or video decode =
devices in the system and that wakes up the dGPU even when it isn't actual=
ly used.
>=20
> > A somewhat reliable method to generate GPP0 notifies is putting on a y=
outube
> > video and the periodically starting evolution with this script:
> >=20
> > #!/bin/bash
> > for i in {0..1000}
> > do
> > 	echo $i
> > 	evolution &
> > 	sleep 5
> > 	killall evolution
> > 	sleep 55
> > done
> >=20
> > This is also the method I used to test the debug kernel in the followi=
ng mails.
>=20
> To further narrow down the issue please run your laptop with amdgpu.runp=
m=3D0 on the kernel command line for a while and see if that is stable or =
not.
>=20
Even versions that did crash can be stable for 24h of uptime so I think th=
is=C2=A0
will take too long.
I think I've already chased down the crash to this part of rpm_resume()
(I'm currently doing a testrun with more dev_info()s in this part):

 skip_parent:

	if (!strcmp(dev_name(dev), "0000:00:01.1"))
		dev_info(dev, "%s %d\n", __func__, __LINE__); // this is the last report=
ed line in netconsole
	if (dev->power.no_callbacks)
		goto no_callback;	/* Assume success. */

	__update_runtime_status(dev, RPM_RESUMING);

	callback =3D RPM_GET_CALLBACK(dev, runtime_resume);

	dev_pm_disable_wake_irq_check(dev, false);
	retval =3D rpm_callback(callback, dev);
	if (retval) {
		__update_runtime_status(dev, RPM_SUSPENDED);
		pm_runtime_cancel_pending(dev);
		dev_pm_enable_wake_irq_check(dev, false);
	} else {
 no_callback:


Bert Karwatzki

