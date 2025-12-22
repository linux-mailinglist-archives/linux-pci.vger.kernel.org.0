Return-Path: <linux-pci+bounces-43538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CC4CD6DCF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 18:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C19E301C3E9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 17:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49B2337BA1;
	Mon, 22 Dec 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnTr8Jdt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAB336EE5
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766426268; cv=none; b=t+WeDWDYmDvhsnCY0MgxEUW5HPoq3KeHmGLLIPapy4LMO8sczfQlhFSBLVGh3WBeHzcufknwqS8JXLE+RoLSYt6oo/N2vhAuFK+vXljNutVqKtX1OfLREsBHWw4grH4A/oxsA//rMK9OfRZOw5ykh4rcFH41nUxjQGmbtYN4Lx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766426268; c=relaxed/simple;
	bh=cK8JSPveei5wsENv2SrSmILFcSEhWUWqcMbeDZ+Fi3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0hhggGXbVe/UDE8t+SzIIlngMek1Clk5pgdzvwI99FHejc4QTCKC2+ztlETZLeCjh1mw5C5js5hC6NlHh6n2xt9JqY4hYV+O3pa95wNrtvDZfkVUHcuKUGV1o3KJTak2wivDS6+RDz9HlZAgqcUOoAf6XXcvk2VIiqmaXZyhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnTr8Jdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6C3C19421
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766426268;
	bh=cK8JSPveei5wsENv2SrSmILFcSEhWUWqcMbeDZ+Fi3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EnTr8JdtDwY9RL3oZ93+GBRK3sfXVAFm/1Nj1EqbNUDbGMqy6rOSN+PRPlV5BiFPM
	 1swgB6TJE+ZOU+h78hJvfmmK90AvXZRS4rTkWB51emsnAXu8XqJjCYU+Wt8jclfORA
	 5sQEaqPv/bxfbrTn4swr2DRdbaMwAPJd/RFwOTeMPdFLUV8QjLUe1TtckpFeaB0QLz
	 w/kJpDvVyLsjSsZo7++b7B13YCOzwUpTu3JyZN0KucCL1zrg8YIjcBwnrkIruJn1F/
	 83kFRuFrhPsUWG8Up2z9DPMCyvhLu0+qtVXuR5uHOmwsF8AwecPE1zSspEE2IBNohW
	 My6FGXdWO7FQw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ec5df386acso3105525fac.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 09:57:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUA7Y8uCaE4ec3ittPxIPpRZs/FDIQJf8+ZyZFAWg4bEwVg11dbSaqTyYby1qNXYjg3/TEBBFVEgE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEn/BiHIpcgZqojftvhmXvuKZzNeMhKlyf0dtc6384DpOMs97s
	TlY2moHcjyYpJc/lEkJecA/pdud8dmkBkU9qIhUgfdZbTJpStjjnKjPVWbFJJiFDsX4tDJMDYP0
	Q4kCJbqHgqDXrgS+O6gMbNlY8LBiCJJc=
X-Google-Smtp-Source: AGHT+IGofvlRDPPf/G4j/ItWML8cVbQPm1XzywsvQj5slIDE+D6Yf4IBVlqyVw4ypXhrdG9AklYdeRAFKxaBekowf8A=
X-Received: by 2002:a05:6820:4d5b:20b0:659:9a49:8eca with SMTP id
 006d021491bc7-65d0ebef1fcmr3963983eaf.78.1766426267256; Mon, 22 Dec 2025
 09:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5049211.GXAFRqVoOG@rafael.j.wysocki> <20251219122620.00002049@huawei.com>
 <CAJZ5v0hnyBCv-=nq5XbimupJ5T9DS9f4eCgDEC2SiH1gw3zH-A@mail.gmail.com>
 <5967663.DvuYhMxLoT@rafael.j.wysocki> <20251222111808.00007b3c@huawei.com>
In-Reply-To: <20251222111808.00007b3c@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Dec 2025 18:57:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jkdi_+zyqUKCb8pUzSYA9P5u4Ob3WgoJ8FMjMA=r0nug@mail.gmail.com>
X-Gm-Features: AQt7F2r_9hIGRVdnl5zPS90uuFUmGQaxhiSLRZKa7gjMBUbl9cgj0TDI16fqFk0
Message-ID: <CAJZ5v0jkdi_+zyqUKCb8pUzSYA9P5u4Ob3WgoJ8FMjMA=r0nug@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: bus: Fix handling of _OSC errors in acpi_run_osc()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 12:18=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Fri, 19 Dec 2025 22:28:02 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Friday, December 19, 2025 9:38:44 PM CET Rafael J. Wysocki wrote:
> > > On Fri, Dec 19, 2025 at 1:26=E2=80=AFPM Jonathan Cameron
> > > <jonathan.cameron@huawei.com> wrote:
> > > >
> > > > On Thu, 18 Dec 2025 21:34:26 +0100
> > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > >
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > The handling of _OSC errors in acpi_run_osc() is inconsistent.
> > > >
> > > > I wonder if this would be easier to follow with a brief statement
> > > > of why we threat OSC_CAPABILITIES_MASK_ERROR as an error in the fir=
st
> > > > place for non query cases?  It took me a brief think and spec read
> > > > to figure that out, but maybe more coffee needed.
> > >
> > > Well, this is a good question and it is not obvious IMV.
> > >
> > > The current code treats it as an error, but arguably it is not really=
 an error.
> > >
> > > If it is a query, it doesn't even make sense to print a debug message
> > > for it, but if it is not a query, the feature mask in the _OSC return
> > > buffer still represents the feature that the OS is expected to
> > > control.  So print the debug messages, but do not fail in that case.
> > >
> > > I'll update the patch.
> >
> > I have come to the conclusion that the underlying issue can be addresse=
d in
> > this patch and it basically boils down to the compliance with the spec.
> >
> > Please see below.  If we can agree that this is the way to go, I'll rew=
ork
> > the rest of the patch series as a follow-up on top of this one.
> >
> > Thanks!
> >
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH v2] ACPI: bus: Fix handling of _OSC errors in acpi_run_=
osc()
> >
> > The handling of _OSC errors in acpi_run_osc() is inconsistent and
> > arguably not compliant with the _OSC definition (cf. Section 6.2.12 of
> > ACPI 6.6 [1]).
> >
> > Namely, if OSC_QUERY_ENABLE is not set in the capabilities buffer and
> > any of the error bits are set in the _OSC return buffer, acpi_run_osc()
> > returns an error code and the _OSC return buffer is discarded.  However=
,
> > in that case, depending on what error bits are set, the return buffer
> > may contain acknowledged bits for features that need to be controlled b=
y
> > the kernel going forward.
> >
> > If the OSC_INVALID_UUID_ERROR bit is set, the request could not be
> > processed at all and so in that particular case discarding the _OSC
> > return buffer and returning an error is the right thing to do regardles=
s
> > of whether or not OSC_QUERY_ENABLE is set in the capabilities buffer.
> >
> > If OSC_QUERY_ENABLE is set in the capabilities buffer and the
> > OSC_REQUEST_ERROR or OSC_INVALID_REVISION_ERROR bits are set in the
>
> For the _OSC Failure =3D OSC_REQUEST_ERROR the 'capabilities bits may hav=
e been
> masked' bothers me a little but other that that vagueness I think your
> interpretation is correct.  The spec could definitely have been more tigh=
tly
> written though

Totally agreed and I'm going to do something on that front.

> so I suspect there may be implementations out there that
> get this wrong in the corner cases.  Mind you we shouldn't see them anywa=
y
> assuming correct negotiation and nothing unexpected!

Right.

> > return buffer, acpi_run_osc() may return an error and discard the _OSC
> > return buffer because in that case the platform configuration does not
> > change.  However, if any of them is set in the return buffer when
> > OSC_QUERY_ENABLE is not set in the capabilities buffer, the feature
> > mask in the _OSC return buffer still representes a set of acknowleded
> > features as per the _OSC definition:
> >
> >  The platform acknowledges the Capabilities Buffer by returning a
> >  buffer of DWORDs of the same length. Set bits indicate acknowledgment
> >  that OSPM may take control of the capability and cleared bits indicate
> >  that the platform either does not support the capability or that OSPM
> >  may not assume control.
> >
> > which is not conditional on the error bits being clear, so in that case=
,
> > discarding the _OSC return buffer is questionable.  There is also no
> > reason to return an error and discard the _OSC return buffer if the
> > OSC_CAPABILITIES_MASK_ERROR bit is set in it, but printing diagnostic
> > messages is not unreasonable when that happens with OSC_QUERY_ENABLE
> > clear in the capabilities buffer.
> I'd got further and say "printing diagnostic messages is appropriate"
> given this happening is indicating something we don't expect to see.

Sure.

> Other than that this looks good to me.

Thanks!

> >
> > Adress this issue by making acpi_run_osc() follow the rules outlined
> > above.
> >
> > Moreover, make acpi_run_osc() only take the defined _OSC error bits int=
o
> > account when checking _OSC errors.
> >
> > Link: https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#osc-=
operating-system-capabilities
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/bus.c |   50 ++++++++++++++++++++++++++++++++++++--------=
------
> >  1 file changed, 36 insertions(+), 14 deletions(-)
> >
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -194,14 +194,18 @@ static void acpi_print_osc_error(acpi_ha
> >       pr_debug("\n");
> >  }
> >
> > +#define OSC_ERROR_MASK       (OSC_REQUEST_ERROR | OSC_INVALID_UUID_ERR=
OR | \
> > +                      OSC_INVALID_REVISION_ERROR | \
> > +                      OSC_CAPABILITIES_MASK_ERROR)
> > +
> >  acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *=
context)
> >  {
> > +     u32 errors, *capbuf =3D context->cap.pointer;
> >       acpi_status status;
> >       struct acpi_object_list input;
> >       union acpi_object in_params[4];
> >       union acpi_object *out_obj;
> >       guid_t guid;
> > -     u32 errors;
> >       struct acpi_buffer output =3D {ACPI_ALLOCATE_BUFFER, NULL};
> >
> >       if (!context)
> > @@ -240,29 +244,47 @@ acpi_status acpi_run_osc(acpi_handle han
> >               status =3D AE_TYPE;
> >               goto out_kfree;
> >       }
> > -     /* Need to ignore the bit0 in result code */
> > -     errors =3D *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
> > +     /* Only take defined error bits into account. */
> > +     errors =3D *((u32 *)out_obj->buffer.pointer) & OSC_ERROR_MASK;
> > +     /*
> > +      * If OSC_QUERY_ENABLE is set, ignore the "capabilities masked"
> > +      * bit because it merely means that some features have not been
> > +      * acknowledged which is not unexpected.
> > +      */
> > +     if (capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE)
> > +             errors &=3D ~OSC_CAPABILITIES_MASK_ERROR;
> > +
> >       if (errors) {
> > +             if (errors & OSC_INVALID_UUID_ERROR) {
> > +                     acpi_print_osc_error(handle, context,
> > +                             "_OSC invalid UUID");
> > +                     /*
> > +                      * Always fail if this bit is set because it mean=
s that
> > +                      * the request could not be processed.
> > +                      */
> > +                     status =3D AE_ERROR;
> > +                     goto out_kfree;
> > +             }
> >               if (errors & OSC_REQUEST_ERROR)
> >                       acpi_print_osc_error(handle, context,
> >                               "_OSC request failed");
> > -             if (errors & OSC_INVALID_UUID_ERROR)
> > -                     acpi_print_osc_error(handle, context,
> > -                             "_OSC invalid UUID");
> >               if (errors & OSC_INVALID_REVISION_ERROR)
> >                       acpi_print_osc_error(handle, context,
> >                               "_OSC invalid revision");
> > -             if (errors & OSC_CAPABILITIES_MASK_ERROR) {
> > -                     if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD=
]
> > -                         & OSC_QUERY_ENABLE)
> > -                             goto out_success;
> > -                     status =3D AE_SUPPORT;
> > +             if (errors & OSC_CAPABILITIES_MASK_ERROR)
> > +                     acpi_print_osc_error(handle, context,
> > +                             "_OSC capability bits masked");
> > +
> > +             /*
> > +              * Fail only if OSC_QUERY_ENABLE is set because otherwise=
 the
> > +              * acknowledged features need to be controlled.
> > +              */
> > +             if (capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE) {
> > +                     status =3D AE_ERROR;
> >                       goto out_kfree;
> >               }
> > -             status =3D AE_ERROR;
> > -             goto out_kfree;
> >       }
> > -out_success:
> > +
> >       context->ret.length =3D out_obj->buffer.length;
> >       context->ret.pointer =3D kmemdup(out_obj->buffer.pointer,
> >                                      context->ret.length, GFP_KERNEL);
> >
> >
> >
> >
> >
>

