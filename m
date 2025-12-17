Return-Path: <linux-pci+bounces-43168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FCFCC7920
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 13:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FF7F31252BB
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FEF3446BD;
	Wed, 17 Dec 2025 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZk1DshR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44F34405E
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973727; cv=none; b=lBTm0qxbrjxOM8dRTgvuPjnalpIPWND80EKsQokd+comIq2QN/FSdRrEnMcOWmV21SFXkEPTgUS9V1LTOrGFWBEyaSUAGdpQjivvwslB1w+/T/86IJKyuTK70829w/dlM5F9wSFHXkVUllRz3vSD2gpme8+Zeq5leDw2e2RqNg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973727; c=relaxed/simple;
	bh=/V8ME6f+TcgocYWeUfh3JcmMnxNfhnvIgnWS2xnaweE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ucw+8geRBQsRorL6MzZrbvKi/KUxuM3kS0l1xjwgBWxqcXjrEgLaObpPm8PT49hHVed9wdT6o47R0GqWHrChMcANOnmxWMKqEl67uvPQc6+aVw//fkNfWKvzp6lgn5TDZ+3npLWId5TbevpzYjlHCEt1zgTG5LZfLo7iWtkeouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZk1DshR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A9FC116B1
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 12:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765973726;
	bh=/V8ME6f+TcgocYWeUfh3JcmMnxNfhnvIgnWS2xnaweE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WZk1DshRF4J8H62SIWCs+GT0cHE9p8SDp+FfTS1QjiVp/HeNxOw5xWp4IY4a8Vpzt
	 TZQft9cB1IDI8t5gAli9IFhZVKg9F7WAwv8i9exLJnyHFKEOE1suY9JJ5XzAnmXwO7
	 aBEsb0WN2iO8c3cmxO6KN5jLp3xzrxiExdwwzXS2qD+BwvkLSePR+KyCu9nunBF+rZ
	 fBD30EDyqY57UPe7RS1wHs0GBdwy1RLLwCgRE8+P4lMm0UrDKlHa5wEWkG/yZwiNJg
	 6JWpCBQ920XRKV+qYSycQUXJxNkqRsmG5JrmL5C8AW+g5LAajpm35IIkxK0QfOzNSI
	 JGt/8bRPGFEFg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c75fc222c3so2749810a34.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 04:15:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJUN0WSCYR1PRkmJ/L2f9RfHrYA/6Vee3SZiDg4rgWvWwXtt0nzNnLG2MW/QY1jrnzse0pc011f18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/UHxIFbj5JwJRDVCPhvkKaI1ZACDpSV1VqO1v9Q4nyBlrszr
	AqVvosjYKCl+gYrGoz/Og04FQ3zWngxg5jzGeqNF7ZVvn3EoLEcj3bjNO4xgqueiw95z9gXpG2B
	n8dXrsV00UPk1Z9Egj0W+ZZtym9o3aow=
X-Google-Smtp-Source: AGHT+IFyPbK46RYLF3hgXBIkJIBqNyWVP/G0zIpkadF1YIRRTqJbQ/yhJ/sPg9kgC4x6e6vBet5QlpdwjzUpLYOVIYQ=
X-Received: by 2002:a05:6820:229c:b0:659:9a49:8e54 with SMTP id
 006d021491bc7-65b451c58bdmr8367653eaf.36.1765973725926; Wed, 17 Dec 2025
 04:15:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12803663.O9o76ZdvQC@rafael.j.wysocki> <6225184.lOV4Wx5bFT@rafael.j.wysocki>
 <5536fc1a-4bc9-413e-a903-08090217979b@amd.com>
In-Reply-To: <5536fc1a-4bc9-413e-a903-08090217979b@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Dec 2025 13:15:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iaH9eU1A7d0TmJC4cktO=zh1r998R-59FyDQa1xJOCrQ@mail.gmail.com>
X-Gm-Features: AQt7F2pYJy-v4RTgH2Xseqt9He4niysrExACC7GMuG2cmFyoAqN6C3IhQFnIKEY
Message-ID: <CAJZ5v0iaH9eU1A7d0TmJC4cktO=zh1r998R-59FyDQa1xJOCrQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: bus: Adjust error handling in acpi_run_osc()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:04=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 12/16/2025 2:17 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Some platform firmware incorrectly sets the OSC_CAPABILITIES_MASK_ERROR
> > bit in its _OSC return buffer even if no support bits have been actuall=
y
> > masked, which causes acpi_run_osc() to return an error when executed
> > with OSC_QUERY_ENABLE clear in the OC capabilities buffer.  As a result=
,
> > the OS assumes that the _OSC evaluation has failed and the platform has
> > not acknowledged any capabilities, while the platform assumes that it
> > actually has acknowledged some of them.  This confusion may lead to
> > missing functionality (and possibly other issues) down the road.
> >
> > To address this problem, adjust acpi_run_osc() to avoid returning an
> > error when OSC_CAPABILITIES_MASK_ERROR is set in the return buffer
> > and OSC_QUERY_ENABLE is clear in the OC capabilities, but all of the
> > bits in the support mask supplied by the OS are also set in the bit
> > mask returned by the platform firmware.
>
> If possible can you add some more context to explain which _OSC was
> behaving this way?

\_SB._OSC

>  And if it's production hardware what hardware was affected?

No, it isn't, but this was not caught by Windows validation, so it is
likely that Linux will be exposed to this again.

> It sounds like a viable workaround, I just want to make sure that if we
> have to change this again later we have more information to look back upo=
n.
>
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/acpi/bus.c |   23 +++++++++++++++--------
> >   1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -240,9 +240,13 @@ acpi_status acpi_run_osc(acpi_handle han
> >               status =3D AE_TYPE;
> >               goto out_kfree;
> >       }
> > +     if (out_obj->buffer.length <=3D OSC_SUPPORT_DWORD) {
> > +             status =3D AE_BAD_DATA;
> > +             goto out_kfree;
> > +     }
> >       /* Need to ignore the bit0 in result code */
> >       errors =3D *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
> > -     if (errors) {
> > +     if (errors & ~OSC_CAPABILITIES_MASK_ERROR) {
> >               if (errors & OSC_REQUEST_ERROR)
> >                       acpi_print_osc_error(handle, context,
> >                               "_OSC request failed");
> > @@ -252,17 +256,20 @@ acpi_status acpi_run_osc(acpi_handle han
> >               if (errors & OSC_INVALID_REVISION_ERROR)
> >                       acpi_print_osc_error(handle, context,
> >                               "_OSC invalid revision");
> > -             if (errors & OSC_CAPABILITIES_MASK_ERROR) {
> > -                     if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD=
]
> > -                         & OSC_QUERY_ENABLE)
> > -                             goto out_success;
> > +             status =3D AE_ERROR;
> > +             goto out_kfree;
> > +     }
> > +     if (errors) {
> > +             u32 retbuf =3D ((u32 *)out_obj->buffer.pointer)[OSC_SUPPO=
RT_DWORD];
> > +             u32 capbuf =3D ((u32 *)context->cap.pointer)[OSC_SUPPORT_=
DWORD];
> > +             u32 querybuf =3D ((u32 *)context->cap.pointer)[OSC_QUERY_=
DWORD];
> > +
> > +             /* OSC_CAPABILITIES_MASK_ERROR is set in errors. */
> > +             if (!(querybuf & OSC_QUERY_ENABLE) && (capbuf & retbuf) !=
=3D capbuf) {
> >                       status =3D AE_SUPPORT;
> >                       goto out_kfree;
> >               }
> > -             status =3D AE_ERROR;
> > -             goto out_kfree;
> >       }
> > -out_success:
> >       context->ret.length =3D out_obj->buffer.length;
> >       context->ret.pointer =3D kmemdup(out_obj->buffer.pointer,
> >                                      context->ret.length, GFP_KERNEL);
> >
> >
> >
>

