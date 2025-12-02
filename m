Return-Path: <linux-pci+bounces-42527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2540AC9CDB1
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 21:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DFB74E2DD9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E742F12CC;
	Tue,  2 Dec 2025 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8b6HBDS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE32F12A1
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764705680; cv=none; b=t7ztitquvJAPkMyrQnBCntqz03KeqyfApIHCgpcQ8xD9gJsJJMkj1cn4FEDLCiHZt1qo3Us9WZIBTFLslEtxA6D482mS2VJHwqonv0eFEsIQjujpys5vs7k+uiwHbQbyuX2F8QYeY5zHsnhiuzKP4helK46cWwn3kouwDUXUgoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764705680; c=relaxed/simple;
	bh=I9hyJowrJ8w4OBtxg1Lnw+N1KJ+v/IB99h4H7E1DTog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ge9nR/E26w7L8XJPmUulRpSiI83pDPmgdVEl9VyeL3/BBGdtBpoHyaAiTODtGZDzSwRFvbSpyTELwM6+o485i/AkYXSs2Hh6xYcIH4v1LhlGBaQr4tUYWmhc5jeEtqnuUcxED8O6C2kLIdFFWXyGwHNsSFYQVmiMHfpJbQRrK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8b6HBDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A311C19422
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764705680;
	bh=I9hyJowrJ8w4OBtxg1Lnw+N1KJ+v/IB99h4H7E1DTog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B8b6HBDSQPZfTkv1P/Gu0kQt02RUH2OdqW/tEopVaOC+j9uzVr0QVu6qCEtbnHiv3
	 fIamy+0pPJQnuATCi0Sx7pNqiE6Alykjiqk2xzuIStAUJPIZB978LCjpnx4Qbjcsol
	 udIJK3WROvxFO0uxrCOoqqw9cXV2otMPU/pxAZPYX668fr1NoHfgCBBT7bZCoG9vXp
	 euc9r14AqfoJui2T4+O455M6J6NR2GN0XkavUB/+Aq6nNnOBwz0ewFBwJjIE8nO2yI
	 Cta3P/8VxYxcA0t6qp4C06tLr7iLmYohEiceGrj0UEUmm1sY30jfV5qXmqUfofHAqm
	 Zw7uCJRteztkw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3e12fd71984so4214107fac.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 12:01:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXn08CO6yafW6rwIJ8oQBxTgwjYnql86BV55kbjJdRLoxi+Zl2tJaeGDzapkVBElCUS/BIvV4McVAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ojXdPIdeGJmoUr8PsvXbtbPY+cUCi4Th5RzVwasigBQladdj
	buPBYFL5PCz31GvfV0T799RtyAv21KCbuBlIErF4APGsQAisJ4uyZDrbrDKbq30kgQFYunc7ioD
	5PnwHBijTOSvtdEJV4YARROnmD7XU8Yk=
X-Google-Smtp-Source: AGHT+IH0T9sO6A/DJjwfS6r57/3uHvQKkq0Yihuvk6t+8Hag36p5PZpP3fVwwcETGeOL4pVOOP6RlcQt9GkisTn1kwI=
X-Received: by 2002:a05:6808:2220:b0:450:3ff9:f4ef with SMTP id
 5614622812f47-45112bdc818mr20574779b6e.56.1764705679446; Tue, 02 Dec 2025
 12:01:19 -0800 (PST)
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
 <3f790ee59129e5e49dd875526cb308cc4d97b99d.camel@web.de> <CAJZ5v0iRaYBU+1S4rqYR7D6XC+rfQ2+0hgbodweV5JsFr8EEnQ@mail.gmail.com>
 <b1fadb15d1869bde81315be7488c50dbbc9f7dbd.camel@web.de> <CAJZ5v0iAJN4eTdp9S=CKbMnVn78R7UnBKbLjBTdRhHebE0i7dA@mail.gmail.com>
 <8273a7755f90a3e41782f1d820dd9f0c22be78b7.camel@web.de> <CAJZ5v0i2T7HpV4jN6NJk=ruBvjecPRU2PyuYf0_TSPQU6FZ5rg@mail.gmail.com>
 <e807ca71fdef97c931fd9f92eda0f7551aa3ef7b.camel@web.de> <CAJZ5v0heOKxk8=4kwXcRLFfKhxYBX+ze_Dc2w90xrM14jvCirg@mail.gmail.com>
 <a3e1729912a94d10d7dd211efe837d4d6c7a3eaf.camel@web.de>
In-Reply-To: <a3e1729912a94d10d7dd211efe837d4d6c7a3eaf.camel@web.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Dec 2025 21:01:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gfRmr=q=SYLSWO9px6uUq5ZPQxJ=peo7JHDP926niB8A@mail.gmail.com>
X-Gm-Features: AWmQ_bkSSdnvB--_beAjQpzBsZBsLomRuZxCu0qBJOx853jx8qMRzteAKnaKmy4
Message-ID: <CAJZ5v0gfRmr=q=SYLSWO9px6uUq5ZPQxJ=peo7JHDP926niB8A@mail.gmail.com>
Subject: Re: Crash during resume of pcie bridge due to infinite loop in ACPICA
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev, 
	Robert Moore <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 8:54=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> wr=
ote:
>
> Am Dienstag, dem 02.12.2025 um 19:59 +0100 schrieb Rafael J. Wysocki:
> > On Fri, Nov 28, 2025 at 9:47=E2=80=AFPM Bert Karwatzki <spasswolf@web.d=
e> wrote:
> > >
> > > This is not an ACPICA problem after all:
> > >
> > > I did some more monitoring:
> > > https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgp=
u_suspend_resume?ref_type=3Dheads
> > > and I still get a crash, but perhaps due to the delays the printk()s =
caused I actually get a helpful error message in netconsole:
> > >
> > > T5971;ACPI BIOS Error (bug): Could not resolve symbol [\x5cM013.VARR]=
, AE_NOT_FOUND (20240827/psargs-332)
> > > T5971;acpi_ps_complete_op returned 0x5
> > > T5971;acpi_ps_parse_aml_debug: parse loop returned =3D 0x5
> > > T5971;ACPI Error: Aborting method \x5cM013 due to previous error (AE_=
NOT_FOUND) (20240827/psparse-935)
> > > T5971;ACPI Error: Aborting method \x5cM017 due to previous error (AE_=
NOT_FOUND) (20240827/psparse-935)
> > > T5971;ACPI Error: Aborting method \x5cM019 due to previous error (AE_=
NOT_FOUND) (20240827/psparse-935)
> > > T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M439 due to previ=
ous error (AE_NOT_FOUND) (20240827/psparse-935)
> > > T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M241 due to previ=
ous error (AE_NOT_FOUND) (20240827/psparse-935)
> > > T5971;ACPI Error: Aborting method \x5c_SB.PCI0.GPP0.M237._ON due to p=
revious error (AE_NOT_FOUND) (20240827/psparse-935)
> > > T5971;acpi_ps_parse_aml_debug: after walk loop
> > > T5971;acpi_ps_execute_method_debug 331
> > > T5971;acpi_ns_evaluate_debug 475 METHOD
> > > T5971;acpi_evaluate_object_debug 255
> > > T5971;__acpi_power_on_debug 369
> > > T5971;acpi_power_on_unlocked_debug 442
> > > T5971;acpi_power_on_unlocked_debug 446
> > > T5971;acpi_power_on_debug 471
> > > T5971;acpi_power_on_list_debug 649: result =3D -19
> > > T5971;pcieport 0000:00:01.1: pci_pm_default_resume_early 568#012 SUBS=
YSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
> > > T5971;pcieport 0000:00:01.1: broken device, retraining non-functional=
 downstream link at 2.5GT/s#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:0=
1.1
> > > T5971;pcieport 0000:00:01.1: retraining failed#012 SUBSYSTEM=3Dpci#01=
2 DEVICE=3D+pci:0000:00:01.1
> > > T5971;pcieport 0000:00:01.1: Data Link Layer Link Active not set in 1=
000 msec#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
> > > T5971;pcieport 0000:01:00.0: Unable to change power state from D3cold=
 to D0, device inaccessible#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:01:0=
0.0
> > >
> > > This shows that there seems to be no problem with ACPICA, and acpi_po=
wer_on_list(_debug)() returns -ENODEV,
> > > the crash occurs later.
> > >
> > > This leaves two question:
> > > 1. Is this crash avoidable by different error handling in the pci cod=
e?
> > > 2. If the crash is not avoidable, can we at least modify the error ha=
ndling in such a way that
> > > we get an error message through netconsole by default? (perhaps a lit=
tle delay will suffice)
> >
> > I'm not sure how far this is going to get you, but you may try the
> > attached patch.
>
> This looks worth trying, I'll try it once my current test run has crashed=
.
>
> Currently I'm trying to figure out why this line is there:
>
> pcieport 0000:01:00.0: Unable to change power state from D3cold to D0, de=
vice inaccessible#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:01:00.0
>
> This line comes from this part of pci_power_up():
>
>  pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  if (PCI_POSSIBLE_ERROR(pmcsr)) {
>  pci_err(dev, "Unable to change power state from %s to D0, device inacces=
sible\n",
>  pci_power_name(dev->current_state));
>  WARN(1, "Who is calling %s?\n", __func__); // My debug statement. (No re=
sult, yet.)
>  dev->current_state =3D PCI_D3cold;
>  return -EIO;
>  }
>
> The interesting thing here is that the pci device 0000:01:00.0 has alread=
y been disconnected
> (with pci_dev_set_disconnected()) when the resume of the bridge at 0000:0=
0:01.1 failed
> (in the failure path of pci_pm_bridge_power_up_actions()) (I know for sur=
e
> because I put printk()s there, too).

I would expect the pci_dev_is_disconnected() check in pci_power_up()
to trigger then.

> I'm not sure if pci_power_up should be called in this case.

This is a failing case anyway, I don't think that avoiding to call it
would help much.

