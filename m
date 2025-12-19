Return-Path: <linux-pci+bounces-43408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CB1CD11AA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 506623003B2D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC72BF00B;
	Fri, 19 Dec 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFs+q2jo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368F24DD1F
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164826; cv=none; b=ZcXbtQ3tjVQXHvyIE1FpvMIw4Q+rmFRSI5MIWNxYE0AxrmiacA1lzA3J4Y/R29gVm+tqFw97MOllU9rSd50TOT7QGF08467kQs+JBzf0OBZeVuhnWvFQSEyYFbwrtRYRybtmW9ju5sJwsZ4nj0CbjLdNHNJpF6eGHaiSKzMQq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164826; c=relaxed/simple;
	bh=gS0vJZS1Q2G6ZMQ50QIRMXn1y6w+zebL4C3mxh6tWgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXvhgWaBeoYS/3O0mlAsk4tOtdUlwYvY1zJZqcZxnFaufsAC1lIPdUFZWfkymRMrhfzhhbDipP4MjG0D7ZK859AcUhYoZhDPI2Cvz5MSlVMbqjJcTZf/vjz4HruVK5WON3DRIp7Bs5icmAbthALRk3JBuFcODuwl5aqeuYai9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFs+q2jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D59C4CEF1
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766164825;
	bh=gS0vJZS1Q2G6ZMQ50QIRMXn1y6w+zebL4C3mxh6tWgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bFs+q2joHvuOO6AsFgGaQ+H7U8NRoCy57xkPCOArdHYjFZktCWhA8PTl+PQQYaI9Z
	 mrxvVfpXFqkw0JB0IJKmVg5IUMeX3r3e+2PZn5Vwwa1EVip4/9c2XVCUg910sHNcJr
	 VnBvibEHLiTWlo2gZeoK37CtROYhCLQqGZJD/8dkjYjMTqqyhe2pcaUKfRfNUBjLZg
	 QTcQNAsIZRIAU8TQrajhWZByGHYxYfFQR7UbuUTKbKKOPU0s6w1ra4cfZwU/Oa+1n4
	 WQ+VoIZyd8lo+EXsrZXoWB5k3m9pfp+UeSRGgf6hd9eOdBwfBmyq3vGkuRwLFqgp/h
	 SQwz1ZPXFOefg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6597046fc87so710874eaf.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 09:20:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcqQeS9G8zI9lYCO7yuv6mmqCofnoko61lUQRWxaeyMFqPh0NHWwXPeEGrPt+zMlRi247lvu90vCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+uCg1qdrlHstXZCOQJaoGh+WffZKA4v4JaLDRRCoAE8ciLomE
	qZm06UhCvDJo06qgX3+It/hGj4YvqCPumvD8c3Q7sEYleMx16mqTBteBpebZ7/Qeq0/lKy3BfcA
	R9/YWt70OaJxyLMHTpIvgTQxhwz8W39c=
X-Google-Smtp-Source: AGHT+IE2wxi3ctNVzIp4rjh6qWyS9VkZFfUdBN0QiVrvNHfJFwkoiFupXNFLqDfw9yKvJK6Iw6i7+wEpZdpyxI0/hFI=
X-Received: by 2002:a05:6820:f028:b0:65b:38e2:33b5 with SMTP id
 006d021491bc7-65d0ea5a20cmr1755311eaf.49.1766164824659; Fri, 19 Dec 2025
 09:20:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5049211.GXAFRqVoOG@rafael.j.wysocki> <3036574.e9J7NaK4W3@rafael.j.wysocki>
 <20251219123319.00001e98@huawei.com>
In-Reply-To: <20251219123319.00001e98@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Dec 2025 18:20:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jgo4uCs9xcK0mKxO1yKy3NP1eubO01R7KE0G1AcBf9MQ@mail.gmail.com>
X-Gm-Features: AQt7F2oPPGCdvtBge9BJUT5Z7u_WA9mzZrImP9GaLAG1wHPv_3XW4an3eFIet2E
Message-ID: <CAJZ5v0jgo4uCs9xcK0mKxO1yKy3NP1eubO01R7KE0G1AcBf9MQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] ACPI: bus: Rework printing debug messages on _OSC errors
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 1:33=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Thu, 18 Dec 2025 21:35:27 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of using one function, acpi_print_osc_error(), for printing a
> > debug message and dumping the _OSC request data in one go, use
> > acpi_handle_debug() directly for printing messages and a separate
> > function called acpi_dump_osc_data() for dumping the _OSC request data
> > after printing one or more of them.
> >
> > This allows the message printing in the _OSC handling code to be
> > organized so that the messages printed by it are easier to parse.
>
> Hi Rafael,
>
> Perhaps an example of the print to motivate this change clearly?
> The absence of a guid on the error string line for instance may
> or may not bother people. It's there in the dump but that comes
> after the error print I think.

Yes, it's there.

I guess I can add examples of "before" and "after" printouts to the
patch changelog.

> > Also, use %pUL for UUID printing instead of printing UUIDs as strings
> > and include the revision number into the dumped _OSC request data.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/bus.c |   35 ++++++++++++++++-------------------
> >  1 file changed, 16 insertions(+), 19 deletions(-)
> >
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -180,18 +180,15 @@ void acpi_bus_detach_private_data(acpi_h
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_bus_detach_private_data);
> >
> > -static void acpi_print_osc_error(acpi_handle handle,
> > -                              struct acpi_osc_context *context, char *=
error)
> > +static void acpi_dump_osc_data(acpi_handle handle, const guid_t *guid,=
 int rev,
> > +                            struct acpi_buffer *cap)
> >  {
> > +     u32 *capbuf =3D cap->pointer;
> >       int i;
> >
> > -     acpi_handle_debug(handle, "(%s): %s\n", context->uuid_str, error)=
;
> > -
> > -     pr_debug("_OSC request data:");
> > -     for (i =3D 0; i < context->cap.length; i +=3D sizeof(u32))
> > -             pr_debug(" %x", *((u32 *)(context->cap.pointer + i)));
> > -
> > -     pr_debug("\n");
> > +     for (i =3D 0; i < cap->length / sizeof(u32); i++)
> > +             acpi_handle_debug(handle, "(%pUL, %d): capabilities DWORD=
 %i: [%08x]\n",
> > +                               guid, rev, i, capbuf[i]);
> >  }
> >
> >  #define OSC_ERROR_MASK       (OSC_REQUEST_ERROR | OSC_INVALID_UUID_ERR=
OR | \
> > @@ -239,8 +236,8 @@ acpi_status acpi_run_osc(acpi_handle han
> >       out_obj =3D output.pointer;
> >       if (out_obj->type !=3D ACPI_TYPE_BUFFER
> >               || out_obj->buffer.length !=3D context->cap.length) {
> > -             acpi_print_osc_error(handle, context,
> > -                     "_OSC evaluation returned wrong type");
> > +             acpi_handle_debug(handle, "_OSC evaluation returned wrong=
 type");
> > +             acpi_dump_osc_data(handle, &guid, context->rev, &context-=
>cap);
> >               status =3D AE_TYPE;
> >               goto out_kfree;
> >       }
> > @@ -252,18 +249,18 @@ acpi_status acpi_run_osc(acpi_handle han
> >
> >       if (errors) {
> >               if (errors & OSC_REQUEST_ERROR)
> > -                     acpi_print_osc_error(handle, context,
> > -                             "_OSC request failed");
> > +                     acpi_handle_debug(handle, "_OSC request failed");
> > +
> >               if (errors & OSC_INVALID_UUID_ERROR)
> > -                     acpi_print_osc_error(handle, context,
> > -                             "_OSC invalid UUID");
> > +                     acpi_handle_debug(handle, "_OSC invalid UUID");
> > +
> >               if (errors & OSC_INVALID_REVISION_ERROR)
> > -                     acpi_print_osc_error(handle, context,
> > -                             "_OSC invalid revision");
> > +                     acpi_handle_debug(handle, "_OSC invalid revision"=
);
> > +
> >               if (errors & OSC_CAPABILITIES_MASK_ERROR)
> > -                     acpi_print_osc_error(handle, context,
> > -                             "_OSC capability bits masked");
> > +                     acpi_handle_debug(handle, "_OSC capability bits m=
asked");
> >
> > +             acpi_dump_osc_data(handle, &guid, context->rev, &context-=
>cap);
> >               status =3D AE_ERROR;
> >               goto out_kfree;
> >       }

