Return-Path: <linux-pci+bounces-41428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F59C6533C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 17:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 10FBA2417E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E40E2DF12C;
	Mon, 17 Nov 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEirt7fR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2E2DECC6
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397657; cv=none; b=h4pPLl6gej5bb7oxZG75yw6yXoOtSumlDMuVcDF5myF8roe8ZGXb0Tjk1z+45FJBg+0yTEdWxokg6tNldGK9ni4ulw/qrvm51IzyZtgnSWPbNnuEdlmAZHlbkfsTTyK0QK/xld2WgfJF3wgz9qKKElGnxxh9ccZTaJecqsvcXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397657; c=relaxed/simple;
	bh=qFBERkr6XCzbgs30TCa6vv7SrJ1+JY/phMy7Yqy9Fgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwwWAxuZtB8otej0ksjKrp5wdH97V7LUDDxk8UDuv73lT227EgHMmIZ93Vzv+K3F2mHNe3JBQ/cd7sMdb4OcTOg5K1H2Qsp+htwNmv+LwyVQCmGgbZxh0cVtcYgOV8rUW95m+clRfvXv3gAHEjJa7bD2dR7xMgmnGMJPhfIh6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEirt7fR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0776C2BCB0
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763397657;
	bh=qFBERkr6XCzbgs30TCa6vv7SrJ1+JY/phMy7Yqy9Fgw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sEirt7fRgMQzHLQOJVKKOtpaX4AfhC3Qw4zFy8NT4hayHHTX3VycbahZUSTT+Uksa
	 El4RokPZ+NqucGyc5w8a9AwbGJhGlUEl3aYd/J6rDidesXG7N1E2Fz2exEvLNv/LX5
	 rclYSqE5WNkkA1pd6md8IDOBrheXPsAUwLmpBZ+QbJmUQwraH+5Xh+AstQgIqD5w5r
	 08mSPeaXXtHylfg9FVM3esD9ku2pnKCPtKfUz0SUIkpQ62bTtUmVjEWAsBdC8rqfFZ
	 yz3C9vOPivwkNYBKwF8+NODaU4ed1MHHarKje6bE/iosWy+jew9Lg1FxNb5RqoyZ3r
	 da88YMeR7Ygmw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-450c6f5ff81so373061b6e.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 08:40:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXf/fzox80wkFxm0iol1bktIer+yVODAENNUr9Ayi0v1wnexx6G+w+Ex4jlIlrAPhdS/HTwc6APif8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHotIjeB5A1zxFOq7u0YtEeqw1VrhWZba+c3y5B3gvhehmdZX
	pQUutfrBnUwnJY8oSjOyv4Ks2prs0EPXBnpAUvAe+P9a7963jip+mFREnQ3LNalbtLpMIt3tfMU
	QeVQIAXCLXKAcGjNnKKTPm7cxld+8eS8=
X-Google-Smtp-Source: AGHT+IGjCWbn/4FxO34zdxvGK3Y3GbN7eVWlyB6JGLKZtagEgAHMOED+tQm3XlhpXo5RD10S3aH49KLxc7cj6yFMPVc=
X-Received: by 2002:a05:6808:f92:b0:450:c6af:7c10 with SMTP id
 5614622812f47-450c6af806emr1873953b6e.22.1763397656218; Mon, 17 Nov 2025
 08:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006120944.7880-1-spasswolf@web.de> <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de> <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com> <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de> <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
 <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de> <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
 <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org> <0cb75fae3a9cdb8dd82ca82348f4df919d34844d.camel@web.de>
 <ab51bd58919a31107caf8f8753804cb2dbfa791d.camel@web.de> <0719d985-1c09-4039-84c1-8736a1ca5e2d@amd.com>
 <3f790ee59129e5e49dd875526cb308cc4d97b99d.camel@web.de>
In-Reply-To: <3f790ee59129e5e49dd875526cb308cc4d97b99d.camel@web.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Nov 2025 17:40:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iRaYBU+1S4rqYR7D6XC+rfQ2+0hgbodweV5JsFr8EEnQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnrmhRSb2LuOTi4e1V5BT19T5ADZ3jCjDcsm02Z7jYTS2wZtzBMLa2Fgv0
Message-ID: <CAJZ5v0iRaYBU+1S4rqYR7D6XC+rfQ2+0hgbodweV5JsFr8EEnQ@mail.gmail.com>
Subject: Re: Crash during resume of pcie bridge due to infinite loop in ACPICA
To: Bert Karwatzki <spasswolf@web.de>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev, 
	Robert Moore <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Saket

On Sun, Nov 16, 2025 at 10:09=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> =
wrote:
>
> Am Montag, dem 10.11.2025 um 14:33 +0100 schrieb Christian K=C3=B6nig:
> > Hi Bert,
> >
> > well sorry to say that but from your dumps it looks more and more like =
you just have faulty HW.
> >
> > An SMU response of 0xFFFFFFFF means that the device has spontaneously f=
allen of the bus while trying to resume it.
> >
> > My educated guess is that this is caused by a faulty power management, =
but basically it could be anything.
> >
> > Regards,
> > Christian.
>
> I think there may be more than one error here. The loss of the GPU (with =
SMU respone log message) may be caused
> by faulty hardware but does not cause "the" crash (i.e. the crash which s=
howed no log messages and was so hard
> one of my nvme devices was missing temporarily afterward, and which cause=
d me to investigate this in the first place ...).
>
> As bisection of the crash is impossible I went back to inserting printk()=
s into acpi_power_transition() and the
> functions called by it. To reduce log spam I created _debug suffixed copi=
es of the original functions.
> The code is found here in branch amdgpu_suspend_resume:
> https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgpu_su=
spend_resume?ref_type=3Dheads
> (Should I post the debug patches to the list?)
>
> The last two commits finally cleared up what happens (but I've yet to fin=
d out why this happens).
>
> 6.14.0-debug-00014-g2e933c56f3b6        booted 20:17, 15.11.2025 crashed =
0:50, 16.11.2025
>                                         (~4.5h, 518 GPP0 events, 393 GPU =
resumes)
>
> The interesting part of the instrumented code is this:
>
> acpi_status acpi_ps_parse_aml_debug(struct acpi_walk_state *walk_state)
> {
>         [...]
>         printk(KERN_INFO "%s: before walk loop\n", __func__);
>         while (walk_state) {
>                 if (ACPI_SUCCESS(status)) {
>                         /*
>                          * The parse_loop executes AML until the method t=
erminates
>                          * or calls another method.
>                          */
>                         status =3D acpi_ps_parse_loop(walk_state);
>                 }
>         [...]
>         }
>         printk(KERN_INFO "%s: after walk loop\n", __func__);
>         [...]
> }
>
> This gives the following message in netconsole
> 1. No crash:
> 2025-11-16T00:50:35.634745+01:00 10.0.0.1 6,21514,16419759755,-,caller=3D=
T59901;acpi_ps_execute_method_debug 329
> 2025-11-16T00:50:35.634745+01:00 10.0.0.1 6,21515,16419759781,-,caller=3D=
T59901;acpi_ps_parse_aml_debug: before walk loop
> 2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21516,16420046219,-,caller=3D=
T59901;acpi_ps_parse_aml_debug: after walk loop
> 2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21517,16420046231,-,caller=3D=
T59901;acpi_ps_execute_method_debug 331
> 2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21518,16420046235,-,caller=3D=
T59901;acpi_ns_evaluate_debug 475 METHOD
> 2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21519,16420046240,-,caller=3D=
T59901;acpi_evaluate_object_debug 255
> 2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21520,16420046244,-,caller=3D=
T59901;__acpi_power_on_debug 369
> 2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21521,16420046248,-,caller=3D=
T59901;acpi_power_on_unlocked_debug 446
> 2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21522,16420046251,-,caller=3D=
T59901;acpi_power_on_debug 471
> 2025-11-16T00:50:35.921210+01:00 10.0.0.1 6,21523,16420046255,-,caller=3D=
T59901;acpi_power_on_list_debug 642: result =3D 0
> Resume successful, normal messages from resuming GPU follow.
>
> 2. Crash:
> 2025-11-16T00:50:46.483555+01:00 10.0.0.1 6,21566,16430609060,-,caller=3D=
T59702;acpi_ps_execute_method_debug 329
> 2025-11-16T00:50:46.483555+01:00 10.0.0.1 6,21567,16430609083,-,caller=3D=
T59702;acpi_ps_parse_aml_debug: before walk loop
> No more messages via netconsole due to crash.
>
> So here we can already say that the main loop in acpi_ps_parse_aml_debug(=
) is not finishing properly.
>
> The next step is to put monitoring inside the loop:
>
> 6.14.0-debug-00015-gc09fd8dd0492        booted 12:09, 16.11.2025 crashed =
19:55, 16.11.2025
>                                         (~8h, 1539 GPP0 events, 587 GPU r=
esumes) "infinite" walk loop
>
> The interesting part of the instrumented code is this:
>
> acpi_status acpi_ps_parse_aml_debug(struct acpi_walk_state *walk_state)
> {
>         [...]
>         printk(KERN_INFO "%s: before walk loop\n", __func__);
>         while (walk_state) {
>                 if (ACPI_SUCCESS(status)) {
>                         /*
>                          * The parse_loop executes AML until the method t=
erminates
>                          * or calls another method.
>                          */
>                         printk(KERN_INFO "%s: before parse loop\n", __fun=
c__);
>                         status =3D acpi_ps_parse_loop(walk_state);
>                         printk(KERN_INFO "%s: after parse loop\n", __func=
__);
>                 }
>         [...]
>         }
>         printk(KERN_INFO "%s: after walk loop\n", __func__);
>         [...]
> }
>
> This gives the following message in netconsole
> 1. No crash:
> 2025-11-16T19:55:54.203765+01:00 localhost 6,5479352,28054924877,-,caller=
=3DT5967;acpi_ps_execute_method_debug 329
> 2025-11-16T19:55:54.203765+01:00 localhost 6,5479353,28054924889,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: before walk loop
> The next two lines are repeated 1500-1700 times (it varies a little ...):
> 2025-11-16T19:55:54.203765+01:00 localhost 6,5479354,28054924894,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: before parse loop
> 2025-11-16T19:55:54.203765+01:00 localhost 6,5479355,28054924908,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: after parse loop
>
> 2025-11-16T19:55:54.498216+01:00 localhost 6,5482288,28055219778,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: after walk loop
> 2025-11-16T19:55:54.498216+01:00 localhost 6,5482289,28055219782,-,caller=
=3DT5967;acpi_ps_execute_method_debug 331
> 2025-11-16T19:55:54.498233+01:00 localhost 6,5482290,28055219786,-,caller=
=3DT5967;acpi_ns_evaluate_debug 475 METHOD
> 2025-11-16T19:55:54.498233+01:00 localhost 6,5482291,28055219791,-,caller=
=3DT5967;acpi_evaluate_object_debug 255
> 2025-11-16T19:55:54.498233+01:00 localhost 6,5482292,28055219795,-,caller=
=3DT5967;__acpi_power_on_debug 369
> 2025-11-16T19:55:54.498247+01:00 localhost 6,5482293,28055219799,-,caller=
=3DT5967;acpi_power_on_unlocked_debug 446
> 2025-11-16T19:55:54.498247+01:00 localhost 6,5482294,28055219802,-,caller=
=3DT5967;acpi_power_on_debug 471
> 2025-11-16T19:55:54.498247+01:00 localhost 6,5482295,28055219806,-,caller=
=3DT5967;acpi_power_on_list_debug 642: result =3D 0
> Resume successful, normal messages from resuming GPU follow.
>
> 2. Crash:
> 2025-11-16T19:56:24.213495+01:00 localhost 6,5483042,28084932950,-,caller=
=3DT5967;acpi_ps_execute_method_debug 329
> 2025-11-16T19:56:24.213495+01:00 localhost 6,5483043,28084932965,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: before walk loop
> The next two lines are repeated more than 30000 times, then the transmiti=
on stops due to the crash:
> 2025-11-16T19:56:24.213495+01:00 localhost 6,5483044,28084932971,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: before parse loop
> 2025-11-16T19:56:24.213495+01:00 localhost 6,5483045,28084932991,-,caller=
=3DT5967;acpi_ps_parse_aml_debug: after parse loop
> No more messages via netconsole due to crash.
>
> So there is some kind of infinite recursion happening inside the loop in =
acpi_ps_parse_aml(). Even if there is some kind
> of error in the hardware this shouldn't happen, I think.
>
> This bug is present in every kernel version I've tested so far, that is 6=
.12.x, 6.13.x, 6.14.x,
> 6.15.x, 6.16.x, 6.17.x (here I only tested the release candidates). 6.18 =
has not been tested, yet.
>
> To get to this result took several months of 24/7 test runs, I hope resol=
ving this will
> be faster.

Well, what you have found appears to be an issue in the AML bytecode
interpreter which may be one of two things: (1) a bug in the
interpreter itself or (2) a bytecode issue that causes the interpreter
to crash (eventually) and the latter is quite a bit more likely.

I'd suggest opening a new issue at
https://github.com/acpica/acpica/issues and attaching the acpidump
output from the affected system, to start with.

