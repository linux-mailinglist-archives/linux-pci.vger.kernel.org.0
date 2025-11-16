Return-Path: <linux-pci+bounces-41325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B13DFC61D4A
	for <lists+linux-pci@lfdr.de>; Sun, 16 Nov 2025 22:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F83C352601
	for <lists+linux-pci@lfdr.de>; Sun, 16 Nov 2025 21:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C6242D88;
	Sun, 16 Nov 2025 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="TqPLhN/E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032C1DED4C;
	Sun, 16 Nov 2025 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763327350; cv=none; b=HgBfJmqIQkzscDjEzq8CPj/qTW71NNJOM1OlSzK+fvhBcLj4mlEz1GUxl+AdzFiJWSiqKO7beyiSSfm2uRSEZ7qZBNu2ZInaJWuh0UXJcYoEL3PVQXqIzyo7yybbcj0bwARXsbcS147bHJGQEmqYPqhVrYPn3ThluTjfzRkaYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763327350; c=relaxed/simple;
	bh=hDbzqfWxD3g3Yjt2W/La7aCBsFh6EBwI3gv4abUoYrs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pcAnwXFx9HNSEz8TAx0DHRQgrij+TsKe5mrX75oPt70Fvpbb+fN7DVxESRDlMSZYyb9gkxJJ1uJhte+wJqYoLUFXuo+QSRHtKVhUah8p43E+uJIqsMSfN/ef4/mXkr+2REQz1g0IvfCDhoYw31niJZoG2qWrlebcPWIBiOF29Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=TqPLhN/E; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763327336; x=1763932136; i=spasswolf@web.de;
	bh=H34mB2us/ARTGeJI9/zWf+TinG8f+xy61EW5M3DNobQ=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TqPLhN/Ex9Qya+ja+vKONU4PnhUh0FC1WdKYy2zHE8wGRcSz26PpzchRlKRA6/hF
	 NbF39nGmUpckxaifKbSmJ8TNDmDF8ceqznE1gP1JrUXarI515Ud/9M0EeMpp9rhJ2
	 S5VksJF8XZDRb5GwmSzFcxB+fRWnwTOrfv8q1iPR7XM0kqc1iF/AUa+i0PBHmHjYj
	 vXliov0aqphWk0PEDsPfwjxMIiDicgrFuRZO4NYnw4rLPFfQ13HfonStumRR2/TIN
	 YQ751XlBW5Avs0WIS+UE0PudFKSPnQsyK+/AB4mC8ZUGRFhpJw801KVBmtyNqnR53
	 TTcueGCBjhoD4htExA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4621-1wKman0DqL-011qDw; Sun, 16
 Nov 2025 22:08:56 +0100
Message-ID: <3f790ee59129e5e49dd875526cb308cc4d97b99d.camel@web.de>
Subject: Re: Crash during resume of pcie bridge due to infinite loop in
 ACPICA
From: Bert Karwatzki <spasswolf@web.de>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello (AMD) (kernel.org)"
	 <superm1@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, spasswolf@web.de,
 acpica-devel@lists.linux.dev,  Robert Moore <robert.moore@intel.com>
Date: Sun, 16 Nov 2025 22:08:54 +0100
In-Reply-To: <0719d985-1c09-4039-84c1-8736a1ca5e2d@amd.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5jb8xiLJso85XyLQcTc4dt4y5Sq7bFIMRmt4LVPzD9SK4tg3L5n
 /XEyvRoMEqK5xr0VbUIM6H0IR/9xorOfvZj+FiM+eCf+gQr7MGKp7KVLVF9i2B1nUoyT6J6
 c5JMHg+IuBBJZFDXkrW6p/n9zYUWBAYyLscq5WV93S6WEplCM2SKscUOD29HvnZMicx0mUb
 D4dqfL6S7l0lYICNoSZoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lQREV7KdzKc=;qxsGyEUsWcBl2G4dSvsgqJGuuK0
 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
 IrHiDGPesjfh/8zK2rmbLAvJe1iC7

Am Montag, dem 10.11.2025 um 14:33 +0100 schrieb Christian K=C3=B6nig:
> Hi Bert,
>=20
> well sorry to say that but from your dumps it looks more and more like y=
ou just have faulty HW.
>=20
> An SMU response of 0xFFFFFFFF means that the device has spontaneously fa=
llen of the bus while trying to resume it.
>=20
> My educated guess is that this is caused by a faulty power management, b=
ut basically it could be anything.
>=20
> Regards,
> Christian.

I think there may be more than one error here. The loss of the GPU (with S=
MU respone log message) may be caused
by faulty hardware but does not cause "the" crash (i.e. the crash which sh=
owed no log messages and was so hard
one of my nvme devices was missing temporarily afterward, and which caused=
 me to investigate this in the first place ...).

As bisection of the crash is impossible I went back to inserting printk()s=
 into acpi_power_transition() and the
functions called by it. To reduce log spam I created _debug suffixed copie=
s of the original functions.
The code is found here in branch amdgpu_suspend_resume:
https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgpu_sus=
pend_resume?ref_type=3Dheads
(Should I post the debug patches to the list?)

The last two commits finally cleared up what happens (but I've yet to find=
 out why this happens).

6.14.0-debug-00014-g2e933c56f3b6	booted 20:17, 15.11.2025 crashed 0:50, 16=
.11.2025
					(~4.5h, 518 GPP0 events, 393 GPU resumes)

The interesting part of the instrumented code is this:

acpi_status acpi_ps_parse_aml_debug(struct acpi_walk_state *walk_state)
{
	[...]
	printk(KERN_INFO "%s: before walk loop\n", __func__);
	while (walk_state) {
		if (ACPI_SUCCESS(status)) {
			/*
			 * The parse_loop executes AML until the method terminates
			 * or calls another method.
			 */
			status =3D acpi_ps_parse_loop(walk_state);
		}
	[...]
	}
	printk(KERN_INFO "%s: after walk loop\n", __func__);
	[...]
}

This gives the following message in netconsole
1. No crash:
2025-11-16T00:50:35.634745+01:00 10.0.0.1 6,21514,16419759755,-,caller=3DT=
59901;acpi_ps_execute_method_debug 329
2025-11-16T00:50:35.634745+01:00 10.0.0.1 6,21515,16419759781,-,caller=3DT=
59901;acpi_ps_parse_aml_debug: before walk loop
2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21516,16420046219,-,caller=3DT=
59901;acpi_ps_parse_aml_debug: after walk loop
2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21517,16420046231,-,caller=3DT=
59901;acpi_ps_execute_method_debug 331
2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21518,16420046235,-,caller=3DT=
59901;acpi_ns_evaluate_debug 475 METHOD
2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21519,16420046240,-,caller=3DT=
59901;acpi_evaluate_object_debug 255
2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21520,16420046244,-,caller=3DT=
59901;__acpi_power_on_debug 369
2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21521,16420046248,-,caller=3DT=
59901;acpi_power_on_unlocked_debug 446
2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21522,16420046251,-,caller=3DT=
59901;acpi_power_on_debug 471
2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21523,16420046255,-,caller=3DT=
59901;acpi_power_on_list_debug 642: result =3D 0
Resume successful, normal messages from resuming GPU follow.

2. Crash:
2025-11-16T00:50:46.483555+01:00 10.0.0.1 6,21566,16430609060,-,caller=3DT=
59702;acpi_ps_execute_method_debug 329
2025-11-16T00:50:46.483555+01:00 10.0.0.1 6,21567,16430609083,-,caller=3DT=
59702;acpi_ps_parse_aml_debug: before walk loop
No more messages via netconsole due to crash.

So here we can already say that the main loop in acpi_ps_parse_aml_debug()=
 is not finishing properly.

The next step is to put monitoring inside the loop:

6.14.0-debug-00015-gc09fd8dd0492	booted 12:09, 16.11.2025 crashed 19:55, 1=
6.11.2025=20
					(~8h, 1539 GPP0 events, 587 GPU resumes) "infinite" walk loop

The interesting part of the instrumented code is this:

acpi_status acpi_ps_parse_aml_debug(struct acpi_walk_state *walk_state)
{
	[...]
	printk(KERN_INFO "%s: before walk loop\n", __func__);
	while (walk_state) {
		if (ACPI_SUCCESS(status)) {
			/*
			 * The parse_loop executes AML until the method terminates
			 * or calls another method.
			 */
			printk(KERN_INFO "%s: before parse loop\n", __func__);
			status =3D acpi_ps_parse_loop(walk_state);
			printk(KERN_INFO "%s: after parse loop\n", __func__);
		}
	[...]
	}
	printk(KERN_INFO "%s: after walk loop\n", __func__);
	[...]
}

This gives the following message in netconsole
1. No crash:
2025-11-16T19:55:54.203765+01:00 localhost 6,5479352,28054924877,-,caller=
=3DT5967;acpi_ps_execute_method_debug 329
2025-11-16T19:55:54.203765+01:00 localhost 6,5479353,28054924889,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: before walk loop
The next two lines are repeated 1500-1700 times (it varies a little ...):
2025-11-16T19:55:54.203765+01:00 localhost 6,5479354,28054924894,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: before parse loop
2025-11-16T19:55:54.203765+01:00 localhost 6,5479355,28054924908,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: after parse loop

2025-11-16T19:55:54.498216+01:00 localhost 6,5482288,28055219778,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: after walk loop
2025-11-16T19:55:54.498216+01:00 localhost 6,5482289,28055219782,-,caller=
=3DT5967;acpi_ps_execute_method_debug 331
2025-11-16T19:55:54.498233+01:00 localhost 6,5482290,28055219786,-,caller=
=3DT5967;acpi_ns_evaluate_debug 475 METHOD
2025-11-16T19:55:54.498233+01:00 localhost 6,5482291,28055219791,-,caller=
=3DT5967;acpi_evaluate_object_debug 255
2025-11-16T19:55:54.498233+01:00 localhost 6,5482292,28055219795,-,caller=
=3DT5967;__acpi_power_on_debug 369
2025-11-16T19:55:54.498247+01:00 localhost 6,5482293,28055219799,-,caller=
=3DT5967;acpi_power_on_unlocked_debug 446
2025-11-16T19:55:54.498247+01:00 localhost 6,5482294,28055219802,-,caller=
=3DT5967;acpi_power_on_debug 471
2025-11-16T19:55:54.498247+01:00 localhost 6,5482295,28055219806,-,caller=
=3DT5967;acpi_power_on_list_debug 642: result =3D 0
Resume successful, normal messages from resuming GPU follow.

2. Crash:
2025-11-16T19:56:24.213495+01:00 localhost 6,5483042,28084932950,-,caller=
=3DT5967;acpi_ps_execute_method_debug 329
2025-11-16T19:56:24.213495+01:00 localhost 6,5483043,28084932965,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: before walk loop
The next two lines are repeated more than 30000 times, then the transmitio=
n stops due to the crash:
2025-11-16T19:56:24.213495+01:00 localhost 6,5483044,28084932971,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: before parse loop
2025-11-16T19:56:24.213495+01:00 localhost 6,5483045,28084932991,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: after parse loop
No more messages via netconsole due to crash.

So there is some kind of infinite recursion happening inside the loop in a=
cpi_ps_parse_aml(). Even if there is some kind
of error in the hardware this shouldn't happen, I think.

This bug is present in every kernel version I've tested so far, that is 6.=
12.x, 6.13.x, 6.14.x,
6.15.x, 6.16.x, 6.17.x (here I only tested the release candidates). 6.18 h=
as not been tested, yet.

To get to this result took several months of 24/7 test runs, I hope resolv=
ing this will
be faster.

Bert Karwatzki

