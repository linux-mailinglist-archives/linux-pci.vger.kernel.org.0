Return-Path: <linux-pci+bounces-42526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 581D5C9CD81
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 20:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC7B3A52F3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 19:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CAA2E62C3;
	Tue,  2 Dec 2025 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="S9NVYRGy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92812E7160;
	Tue,  2 Dec 2025 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764705271; cv=none; b=QHT98bnowbRBTm6gmM/dUBQVeqKaTFwouBKnEheZA0+P4QR5v4eXXHRwQPYbJJTKzWuOfeD824dp+ZVIhzC5hjq3Cvi/ULcRrSQHQ6+4l6AQH+kJEOY56Xn4xyXg/EI+bHfNZCjKCiH+tlwmjxLcvddRLeRgBOi0GO6z04qhUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764705271; c=relaxed/simple;
	bh=RBs0L7T251HxmnLjc8CleKWrD68HfP9uudb5E18fgg8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nj6AkAjBCSQO+qI6bAiT6x1dX0T+qtwbTJo7yTIzsGJOAG1yKRZJ3MWooZLJjBAekuOhNLZUwGbHDyhWB6LCknGIe5UjVhN0DlWN9U7AB5qCsTt+/VGTnHebLMNI9j7h7YGai/83V7jELRj26kpoeANqHtJkdHGJv9Im9YYJQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=S9NVYRGy; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764705240; x=1765310040; i=spasswolf@web.de;
	bh=RBs0L7T251HxmnLjc8CleKWrD68HfP9uudb5E18fgg8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S9NVYRGypWYEkxnEhejLFUUymI9KGmidUd2I53Pcr50SSSiADcnuNuPtRp1dijeo
	 jX88fEcaJmvQRzkFNhdLbKU8pJycuFg48SNDxzZxkb99NmxCVaof4VpcPyTOnwT2i
	 sMuCSID59J+VMAQMGsovphy64WbuPgcQJEm82MNzu5SbSjsxs+j9cwYHXgeWWWz0G
	 yfPW1UPU+MidMCUUxUTiwrUPiiOcqi8CPZqbtbVK3XHeFAfsSvZp1YfGJml0DozYu
	 ANJXwy2kciJf7XE46dBEOtJ4PVSyMXWjAB/i8Dz21Y/c65tOqFjhvGrCtGolRM3Mg
	 5yjdGctM6W28Vqq4Zw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxpiO-1wHxsE0lPK-00tQy7; Tue, 02
 Dec 2025 20:54:00 +0100
Message-ID: <a3e1729912a94d10d7dd211efe837d4d6c7a3eaf.camel@web.de>
Subject: Re: Crash during resume of pcie bridge due to infinite loop in
 ACPICA
From: Bert Karwatzki <spasswolf@web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello (AMD) (kernel.org)"	 <superm1@kernel.org>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	regressions@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, 	acpica-devel@lists.linux.dev, Robert Moore
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>,
 spasswolf@web.de
Date: Tue, 02 Dec 2025 20:53:58 +0100
In-Reply-To: <CAJZ5v0heOKxk8=4kwXcRLFfKhxYBX+ze_Dc2w90xrM14jvCirg@mail.gmail.com>
References: <20251006120944.7880-1-spasswolf@web.de>
		 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
		 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
		 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
		 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
		 <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
		 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
		 <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
		 <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de>
		 <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
		 <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org>
		 <0cb75fae3a9cdb8dd82ca82348f4df919d34844d.camel@web.de>
		 <ab51bd58919a31107caf8f8753804cb2dbfa791d.camel@web.de>
		 <0719d985-1c09-4039-84c1-8736a1ca5e2d@amd.com>
		 <3f790ee59129e5e49dd875526cb308cc4d97b99d.camel@web.de>
		 <CAJZ5v0iRaYBU+1S4rqYR7D6XC+rfQ2+0hgbodweV5JsFr8EEnQ@mail.gmail.com>
		 <b1fadb15d1869bde81315be7488c50dbbc9f7dbd.camel@web.de>
		 <CAJZ5v0iAJN4eTdp9S=CKbMnVn78R7UnBKbLjBTdRhHebE0i7dA@mail.gmail.com>
		 <8273a7755f90a3e41782f1d820dd9f0c22be78b7.camel@web.de>
		 <CAJZ5v0i2T7HpV4jN6NJk=ruBvjecPRU2PyuYf0_TSPQU6FZ5rg@mail.gmail.com>
		 <e807ca71fdef97c931fd9f92eda0f7551aa3ef7b.camel@web.de>
		 <CAJZ5v0heOKxk8=4kwXcRLFfKhxYBX+ze_Dc2w90xrM14jvCirg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CdxAHnhmDv6/aGN/do7Gl20cSw2JF/3p7UzgjFdyJnaFJJHS3PW
 r7Pcxs8GK87gh6IYBVgVE2SUPQxwq9l7zlB7kCiQRkwz9MPVWJhDS9wfhk9E0vfV3P1Fj+U
 cxDrNHTxLAhf0n+VqZIvvfNijw2VJUe3cs7ijmmFGZQ7gKX+0cuG8u2FHjAU6KhZ2zj9Tj0
 WY0BTZuTxTogfDWjynuwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+DqTYYN669w=;ok/pKiIYbjPgVvHi71BQLYNWHCB
 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

Am Dienstag, dem 02.12.2025 um 19:59 +0100 schrieb Rafael J. Wysocki:
> On Fri, Nov 28, 2025 at 9:47=E2=80=AFPM Bert Karwatzki <spasswolf@web.de=
> wrote:
> >=20
> > This is not an ACPICA problem after all:
> >=20
> > I did some more monitoring:
> > https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgpu=
_suspend_resume?ref_type=3Dheads
> > and I still get a crash, but perhaps due to the delays the printk()s c=
aused I actually get a helpful error message in netconsole:
> >=20
> > T5971;ACPI BIOS Error (bug): Could not resolve symbol [\x5cM013.VARR],=
 AE_NOT_FOUND (20240827/psargs-332)
> > T5971;acpi_ps_complete_op returned 0x5
> > T5971;acpi_ps_parse_aml_debug: parse loop returned =3D 0x5
> > T5971;ACPI Error: Aborting method \x5cM013 due to previous error (AE_N=
OT_FOUND) (20240827/psparse-935)
> > T5971;ACPI Error: Aborting method \x5cM017 due to previous error (AE_N=
OT_FOUND) (20240827/psparse-935)
> > T5971;ACPI Error: Aborting method \x5cM019 due to previous error (AE_N=
OT_FOUND) (20240827/psparse-935)
> > T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M439 due to previo=
us error (AE_NOT_FOUND) (20240827/psparse-935)
> > T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M241 due to previo=
us error (AE_NOT_FOUND) (20240827/psparse-935)
> > T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M237._ON due to pr=
evious error (AE_NOT_FOUND) (20240827/psparse-935)
> > T5971;acpi_ps_parse_aml_debug: after walk loop
> > T5971;acpi_ps_execute_method_debug 331
> > T5971;acpi_ns_evaluate_debug 475 METHOD
> > T5971;acpi_evaluate_object_debug 255
> > T5971;__acpi_power_on_debug 369
> > T5971;acpi_power_on_unlocked_debug 442
> > T5971;acpi_power_on_unlocked_debug 446
> > T5971;acpi_power_on_debug 471
> > T5971;acpi_power_on_list_debug 649: result =3D -19
> > T5971;pcieport 0000:00:01.1: pci_pm_default_resume_early 568#012 SUBSY=
STEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
> > T5971;pcieport 0000:00:01.1: broken device, retraining non-functional =
downstream link at 2.5GT/s#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:0=
1.1
> > T5971;pcieport 0000:00:01.1: retraining failed#012 SUBSYSTEM=3Dpci#012=
 DEVICE=3D+pci:0000:00:01.1
> > T5971;pcieport 0000:00:01.1: Data Link Layer Link Active not set in 10=
00 msec#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
> > T5971;pcieport 0000:01:00.0: Unable to change power state from D3cold =
to D0, device inaccessible#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:01:0=
0.0
> >=20
> > This shows that there seems to be no problem with ACPICA, and acpi_pow=
er_on_list(_debug)() returns -ENODEV,
> > the crash occurs later.
> >=20
> > This leaves two question:
> > 1. Is this crash avoidable by different error handling in the pci code=
?
> > 2. If the crash is not avoidable, can we at least modify the error han=
dling in such a way that
> > we get an error message through netconsole by default? (perhaps a litt=
le delay will suffice)
>=20
> I'm not sure how far this is going to get you, but you may try the
> attached patch.

This looks worth trying, I'll try it once my current test run has crashed.

Currently I'm trying to figure out why this line is there:

pcieport 0000:01:00.0: Unable to change power state from D3cold to D0, dev=
ice inaccessible#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:01:00.0

This line comes from this part of pci_power_up():

 pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 if (PCI_POSSIBLE_ERROR(pmcsr)) {
 pci_err(dev, "Unable to change power state from %s to D0, device inaccess=
ible\n",
 pci_power_name(dev->current_state));
 WARN(1, "Who is calling %s?\n", __func__); // My debug statement. (No res=
ult, yet.)
 dev->current_state =3D PCI_D3cold;
 return -EIO;
 }

The interesting thing here is that the pci device 0000:01:00.0 has already=
 been disconnected=C2=A0
(with pci_dev_set_disconnected()) when the resume of the bridge at 0000:00=
:01.1 failed
(in the failure path of pci_pm_bridge_power_up_actions()) (I know for sure
because I put printk()s there, too). I'm not sure if pci_power_up should b=
e called in this case.

Bert Karwatzki






