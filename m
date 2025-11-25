Return-Path: <linux-pci+bounces-42082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD0C86D86
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 20:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B207F3B3EEF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E551FBC8C;
	Tue, 25 Nov 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx7b6fVI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1081F9F7A
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100008; cv=none; b=bH362QBoBixLZoqjTG7/3SZkam0IZik/4UKIyF3D+9QZ0Y6pOnXMvtsHZW98jWYf6wv2ACGZKe5K5Y50+WmR4F6H6GmHK2rhNpl6cKcxZ171NxPT8jd/FsO3O7DuWTgvDIAkgCupWyvwgIMiMdo87BeV/IiVqFaRfcJuDzrh3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100008; c=relaxed/simple;
	bh=yvrl0wOjR+XSH5uRR3LWNSF0SaBkf3JIyH+0olitB1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFx84hh7fLKbd8S38QbI/qdgZfYpDyjTAf1hBH6pMuPPpwJD7lPSr4uqWDtNY05q/VHOXl9iAT5I3z2INFa2CiH+ehz6Cr3fVblQ9Xf560FAmAE4hFEPB61cpxaacMB7QS/Vpydkj15q1qC5Vjfyt5k+xIQPoq/mxaGvKe8FOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx7b6fVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3768C116D0
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 19:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764100008;
	bh=yvrl0wOjR+XSH5uRR3LWNSF0SaBkf3JIyH+0olitB1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gx7b6fVIqOl4LtYkUHQfgWaRe3aaZTA/qrAlds132jXu590WaSwd4CWT+XoaKmYah
	 BJV1g6TgMaCNdqZ5WlqDZQsoGT2lobf1Wr/nacgWPXX4xJWGuVHVEZWx5HtpDhf6cU
	 aHMBURi2qnZVQ6mk5/NXLPbd52K4ZbORQJg85yOd0QP1O1f2ukOwgw52OuT6/zGtIG
	 eqd8DsC7k7bYIbIIXmhJ/OKzUK7KhoQUj3vMe4I0809E2j8/2AWXpXW9KPFAjK11/4
	 RY17sDV9GNjitBDBsaVWZeppeyrpkWBJ9B1V5ja3VWMyzMn3y6yuxnytboqZ6vRXkm
	 kIivrQSB2rjbg==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c750b10e14so1966515a34.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 11:46:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHdzZqepX2MMYzoJJWYHyuppBBb5WRtKipZs28/SSMrQ49oYKQIpcQ1YMqTm0Fzwb6jetVBdTDfs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwroI8+nEiTHTZt70f4MSe1dzSGzQA55gBELmZ2owwRMxS/3Msf
	gQsdc6VN+Fa/2LOs7E+t7FJXpMf4x6hV8oQ/xUaZRFXFrL2v+/WPmRyF/eKsaYYTEvjKQyZfkFh
	RBZGtEmLDSv9yx6HWUUUbe34eeNRi6Qw=
X-Google-Smtp-Source: AGHT+IFGMFIfq2+kvnTPZJazL4Yeg+8WQgSO/dFZk40t4JEEBh6K8WyxoehpLBTypvtAqzSsfFAhpjmr/CS3BpOKo/A=
X-Received: by 2002:a05:6830:4424:b0:7c7:6348:594a with SMTP id
 46e09a7af769-7c798ac9963mr8031111a34.7.1764100007330; Tue, 25 Nov 2025
 11:46:47 -0800 (PST)
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
 <b1fadb15d1869bde81315be7488c50dbbc9f7dbd.camel@web.de>
In-Reply-To: <b1fadb15d1869bde81315be7488c50dbbc9f7dbd.camel@web.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 20:46:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iAJN4eTdp9S=CKbMnVn78R7UnBKbLjBTdRhHebE0i7dA@mail.gmail.com>
X-Gm-Features: AWmQ_bmiY3C3Fd0jUd8YOkwb-S7v2_w9pN95wDBnISKEEEKCJJwUosvxEK3SrZI
Message-ID: <CAJZ5v0iAJN4eTdp9S=CKbMnVn78R7UnBKbLjBTdRhHebE0i7dA@mail.gmail.com>
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

On Mon, Nov 24, 2025 at 11:34=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> =
wrote:
>
> Am Montag, dem 17.11.2025 um 17:40 +0100 schrieb Rafael J. Wysocki:
> >
> > Well, what you have found appears to be an issue in the AML bytecode
> > interpreter which may be one of two things: (1) a bug in the
> > interpreter itself or (2) a bytecode issue that causes the interpreter
> > to crash (eventually) and the latter is quite a bit more likely.
> >
> > I'd suggest opening a new issue at
> > https://github.com/acpica/acpica/issues and attaching the acpidump
> > output from the affected system, to start with.
>
> I've reported the bug to ACPICA github:
> https://github.com/acpica/acpica/issues/1060

I've seen your report, thanks for filing it.

> There's no "infinite" loop, but a loop running for 5051 (0x13BB) iteratio=
n until its timeout
> counter reaches Zero (most likely because the hardware is unresponsive). =
Soon (only a
> handfull of iterations in the walk loop in acpi_ps_parse_aml()) the crash=
 happens. I think
> the crash actually occurs inside acpi_ps_parse_loop(), so I wouldn't rule=
 out an interpreter
> bug just yet.
>  The crash also always happens (if it happens ...) in the 30592th iterati=
on of the walk loop,
> so I'm now monitoring the internal of acpi_ps_parse_loop() only in this i=
teration of the walk
> loop. (I've tried to monitor the parse loop before, but that only led to =
excessive memory
> consumption and an activated OOM killer). The debugging code can be found=
 here:
> https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgpu_su=
spend_resume?ref_type=3Dheads
>
> So far I've had no crash with this.

What may be happening, but this is just a theory, is that the
interpreter aborts the evaluation of a method due to an internal
timeout, essentially the control_state->control.loop_timeout check in
acpi_ds_exec_end_control_op() and that leads to a subsequent hard
failure like a deadlock.

This may be tested by increasing the ACPI_MAX_LOOP_TIMEOUT value, but
I'm not sure it's practical to try that.

