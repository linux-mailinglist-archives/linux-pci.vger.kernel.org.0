Return-Path: <linux-pci+bounces-42274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC09C93217
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 21:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572033A890F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 20:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30E2D7DF8;
	Fri, 28 Nov 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="uB/B053b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738726C3BE;
	Fri, 28 Nov 2025 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764362870; cv=none; b=ls9EbY60hZoI+ek5vXjW1vKoroPvsSynGqIvbVTj+DnzNp9ex9iaXqFVW4xGwKcaQ1wGUoxyHufDYoyEJZ5cVUVpu13BuUPsG97WhU+KR5AKcc97XHyVmih3Vw3QgI1Pgvfxo8i3RqYi3/ffdRQm8YFnRI8HDtBPgyM1wLRAlsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764362870; c=relaxed/simple;
	bh=GwRXatWWRlSaL5xAAZbvc5qnbjgthJo6tQ/TVokcPbQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQwJcY+mGM90tHgNT24s4BhMCxnIEwon7ezih/Q/d5aqLhYv45NzchSva5q/Y2+pvDLvK2DPjkz7YX3sw9UBrLjrEO4VsIjZB7y5GTwFXupLfEFU+7p1BEePBaTEDbx/97CsTgFc1Hd9oj476Yo28AqqDWx679W3/Mjqz0/3DAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=uB/B053b; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764362857; x=1764967657; i=spasswolf@web.de;
	bh=GwRXatWWRlSaL5xAAZbvc5qnbjgthJo6tQ/TVokcPbQ=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uB/B053bIUbWUjJFGJpZLPTwI5lozybhHMvUL+PrETRi8cxDWyzbcYWn3KCB8Uob
	 tfrJ0e7rrKzHVSJFueQKapl34etOOIsAblzfzI7E9X2TQXSuIY0oJFP+ZYAhNWreN
	 Ro7rP5SHuPR0G9ELoh0wO+e5B9HnFu+oW9nFs85MlzId3yCSf4i0ibMvgzZVuRCQk
	 bCTwreDHQgfclGreQSGNXm16MrIwOFEXCRpTxOk28KhdNef14MSYjpQa0u5Ht0Ty/
	 B4JnZwvmEWkw0MBohEANVNFbv855GvRD9LlvQ4uRokX0Rnc+SlfyLf3DR22NChhuq
	 U2SIpzpHgil23oZSig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrLL-1vktUR3xUx-00QEo6; Fri, 28
 Nov 2025 21:47:37 +0100
Message-ID: <e807ca71fdef97c931fd9f92eda0f7551aa3ef7b.camel@web.de>
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
Date: Fri, 28 Nov 2025 21:47:35 +0100
In-Reply-To: <CAJZ5v0i2T7HpV4jN6NJk=ruBvjecPRU2PyuYf0_TSPQU6FZ5rg@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q3/Cy5Pef9xmrvTwSTq53bpK2erqSntl06FHdL6/6pctlExVrXT
 /6yyebbiOW7brTOtGY0ZDVOBEZ9LEzdvjw6ivcENKX5SDGMd+BdAERa+PHj4VuFEKUZf3vm
 A1kHJ8WXArZJ9OwoK0kAwnB1FaGptBSIRDelF2PP/qd07xr0i53TidpFHHKjtbO4jAlj+6o
 mOVrFVfXAPKe8ZyHVqJAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cN+bqbYSrDs=;93PqB5glEnXKZmIMJ4TrS0QkcnS
 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
 FhirjP2hwZ7AP6S1MpBmI6KqJ+hbEnz3Bhlxri

This is not an ACPICA problem after all:

I did some more monitoring:
https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgpu_sus=
pend_resume?ref_type=3Dheads
and I still get a crash, but perhaps due to the delays the printk()s cause=
d I actually get a helpful error message in netconsole:

T5971;ACPI BIOS Error (bug): Could not resolve symbol [\x5cM013.VARR], AE_=
NOT_FOUND (20240827/psargs-332)
T5971;acpi_ps_complete_op returned 0x5
T5971;acpi_ps_parse_aml_debug: parse loop returned =3D 0x5
T5971;ACPI Error: Aborting method \x5cM013 due to previous error (AE_NOT_F=
OUND) (20240827/psparse-935)
T5971;ACPI Error: Aborting method \x5cM017 due to previous error (AE_NOT_F=
OUND) (20240827/psparse-935)
T5971;ACPI Error: Aborting method \x5cM019 due to previous error (AE_NOT_F=
OUND) (20240827/psparse-935)
T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M439 due to previous e=
rror (AE_NOT_FOUND) (20240827/psparse-935)
T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M241 due to previous e=
rror (AE_NOT_FOUND) (20240827/psparse-935)
T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M237._ON due to previo=
us error (AE_NOT_FOUND) (20240827/psparse-935)
T5971;acpi_ps_parse_aml_debug: after walk loop
T5971;acpi_ps_execute_method_debug 331
T5971;acpi_ns_evaluate_debug 475 METHOD
T5971;acpi_evaluate_object_debug 255
T5971;__acpi_power_on_debug 369
T5971;acpi_power_on_unlocked_debug 442
T5971;acpi_power_on_unlocked_debug 446
T5971;acpi_power_on_debug 471
T5971;acpi_power_on_list_debug 649: result =3D -19
T5971;pcieport 0000:00:01.1: pci_pm_default_resume_early 568#012 SUBSYSTEM=
=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
T5971;pcieport 0000:00:01.1: broken device, retraining non-functional down=
stream link at 2.5GT/s#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
T5971;pcieport 0000:00:01.1: retraining failed#012 SUBSYSTEM=3Dpci#012 DEV=
ICE=3D+pci:0000:00:01.1
T5971;pcieport 0000:00:01.1: Data Link Layer Link Active not set in 1000 m=
sec#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
T5971;pcieport 0000:01:00.0: Unable to change power state from D3cold to D=
0, device inaccessible#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:01:00.0

This shows that there seems to be no problem with ACPICA, and acpi_power_o=
n_list(_debug)() returns -ENODEV,
the crash occurs later.

This leaves two question:
1. Is this crash avoidable by different error handling in the pci code?
2. If the crash is not avoidable, can we at least modify the error handlin=
g in such a way that=C2=A0
we get an error message through netconsole by default? (perhaps a little d=
elay will suffice)

Bert Karwatzki

