Return-Path: <linux-pci+bounces-17371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0B9D9DE9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 20:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683A1B214FE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 19:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541211DD9AD;
	Tue, 26 Nov 2024 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoEjGWG5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A318858E;
	Tue, 26 Nov 2024 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648572; cv=none; b=SBlaERuG1xpHxS80i3PmIq5Nx9dG2Hsj7r2XaMh5/CJsOptH28YfZk6VzYpwjkwuuRafQns8barB9/PGhhmm5lpu0WZKjUfEZzdeACXquxh8M8a4gCz3Hh4ylN1bcdxZh9RQnWwBrZrk1qVkADShl/68KgtYWgE/fVSdIFNstpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648572; c=relaxed/simple;
	bh=1TUlJKf5nQjkOH60EGQT6g00V3SndGrR+iyif5lajog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAslMTgZJAwl/0tbv2UqUpJReQpKgr6cxmtVU2AK9gVlqKtG3li86wgdcHBRKd+830S1AvXsdl5/1CguSD/gF2n7BaJFHVg4QsXa6zLSg7Bkw3dV5Ib3fJV6Q/c+4QgnXrA29CItctCQizGJMpGi9JP7QUE1HGQ9orP5ch5DWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoEjGWG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A334CC4CEDE;
	Tue, 26 Nov 2024 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732648571;
	bh=1TUlJKf5nQjkOH60EGQT6g00V3SndGrR+iyif5lajog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hoEjGWG5m4OidOkXh3CuRiD5M+R1koohQf3ZG7SeTyPQjWJQByP8NK0jLdOGEDpIH
	 l9XklPzFRqQ1FH9DBeN5hoHlVHQH7VuLyZBRyDSOyTotnx94GMwBDKTKpbqyKwxm0p
	 91H7NITpW7H8XGKXBS8j3L7kgfK7wlMP2cYMbRjHBHNR1BlcKYrpwlzYD3/hFep7Op
	 ESEuTJikK6Ysc625JG4R97ykuKZ0qgbl5wNSctVKRdXJLoX4lRBotUhL3K6Qn5syYW
	 Z/MqWtXjmsjkY4z6RNQ/x88vldOIxps1XiFH1qoXzMVaO2GsBLMWrCwzT4bkoFWd7w
	 rfMlBgUqRVA9w==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ee7a48377cso56273417b3.3;
        Tue, 26 Nov 2024 11:16:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUG/UJJDByr1W83Lxv8K9yfz31lzyuMK5jajCHdfie0nb+95gZCG+JlLlig66rjvkOSvLvVLsyNwWdZ+v40@vger.kernel.org, AJvYcCVg436dEOk3Z4HHyHBbqBSMO39WMUdotg2/M6L5HsVRlZM6ZTt54TMvizj2cZd3gZF8LC+JzOi7LD+G@vger.kernel.org, AJvYcCWzJgZYl8NY8XoGDtCaQFJjJ4IOgHt9yM+38eyixCX6fbd1vfekRT7GugPBK+otsXm9K7/v1AHikWLi@vger.kernel.org, AJvYcCXArw7azpaSDY7+539yMbsKJ9Cufp4Z3skdl2Nc0Bill+VlhQZxkhV+YGNEXGygmt0hCJcoICl2edCqpljqBK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywra98NW4T8nONqP2nFlrMDAT8ZKA8FVmRckCmjqm7YuuPUeYNX
	wZhTlmyXQtkZhoG8fmKKnzf8EwJrkkiANcJfB+8C+EN6n5B4ZZwukfXYQOa+y1NzquFVPL5Q+4e
	ofwLQy3yCBv5TsGwZqqDDODgEJA==
X-Google-Smtp-Source: AGHT+IETEyEPXVtA8SN5jspf5+8jw4sIaeRGhfLum4QaxlBpG1gledPn1oBWZED7v15tAMHRuQ9YyLA2/RSuZ+ZVqsY=
X-Received: by 2002:a05:690c:7009:b0:6e2:313a:a01e with SMTP id
 00721157ae682-6ef3727a856mr4520407b3.32.1732648570631; Tue, 26 Nov 2024
 11:16:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-16-dakr@kernel.org>
 <20241022234712.GB1848992-robh@kernel.org> <ZxibWpcswZxz5A07@pollux>
 <20241023142355.GA623906-robh@kernel.org> <Zx9kR4OhT1pErzEk@pollux>
 <CAL_JsqLVdoQNSSDCfGcf0wCZE9VQphRhHKANxhpei_UoFzkN9g@mail.gmail.com>
 <Z0XBbLb8NRQg_dek@cassiopeiae> <CAL_Jsq+TV486zw=hAWkFnNbPeA08mJh_4kVVJLSXiYkzWcOVDg@mail.gmail.com>
 <Z0XmgXwwNikW6oJw@cassiopeiae>
In-Reply-To: <Z0XmgXwwNikW6oJw@cassiopeiae>
From: Rob Herring <robh@kernel.org>
Date: Tue, 26 Nov 2024 13:15:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLohzzxDrJPFiQ6v8X=2i7pPUJdwzVLxShbcX-SCz_3Jg@mail.gmail.com>
Message-ID: <CAL_JsqLohzzxDrJPFiQ6v8X=2i7pPUJdwzVLxShbcX-SCz_3Jg@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 9:17=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue, Nov 26, 2024 at 08:44:19AM -0600, Rob Herring wrote:
> > > > > > The DT type and name fields are pretty much legacy, so I don't =
think the
> > > > > > rust bindings need to worry about them until someone converts S=
parc and
> > > > > > PowerMac drivers to rust (i.e. never).
> > > > > >
> > > > > > I would guess the PCI cases might be questionable, too. Like DT=
, drivers
> > > > > > may be accessing the table fields, but that's not best practice=
. All the
> > > > > > match fields are stored in pci_dev, so why get them from the ma=
tch
> > > > > > table?
> > > > >
> > > > > Fair question, I'd like to forward it to Greg. IIRC, he explicitl=
y requested to
> > > > > make the corresponding struct pci_device_id available in probe() =
at Kangrejos.
> >
> > Making it available is not necessarily the same thing as passing it in
> > via probe.
>
> IIRC, that was exactly the request.
>
> > I agree it may need to be available in probe(), but that
> > can be an explicit call to get it.
>
> Sure, I did exactly that for the platform abstraction, because there we m=
ay
> probe through different ID tables.

TBC, I think of_match_device() (both calling the C API and the method)
should not be part of this series. I think we agreed on that already.
Only if there is a need at some point later should we add it.

> A `struct pci_driver`'s probe function has the following signature [1] th=
ough:
>
> `int (*probe)(struct pci_dev *dev, const struct pci_device_id *id)`
>
> [1] https://elixir.bootlin.com/linux/v6.12/source/include/linux/pci.h#L95=
0

We have a mixture of probe with and without the _device_id parameter.
I'd question if we really want to keep that for PCI when we have a
chance to align things with Rust. We can't really with C as it would
be too many drivers to change. Passing the _device_id only works if
firmware matching is never used which can change over time. But if
aligning things is not something we want to do, then I'll shut up.

> > > > Which table gets passed in though? Is the IdInfo parameter generic =
and
> > > > can be platform_device_id, of_device_id or acpi_device_id? Not sure=
 if
> > > > that's possible in rust or not.
> > >
> > > Not sure I can follow you here.
> > >
> > > The `IdInfo` parameter is of a type given by the driver for driver sp=
ecific data
> > > for a certain ID table entry.
> > >
> > > It's analogue to resolving `pci_device_id::driver_data` in C.
> >
> > As I said below, the PCI case is simpler than for platform devices.
> > Platform devices have 3 possible match tables. The *_device_id type we
> > end up with is determined at runtime (because matching is done at
> > runtime), so IdInfo could be any of those 3 types.
>
> `IdInfo` is *not* any of the three *_device_id types. It's the type of th=
e
> drivers private data associated with an entry of any of the three ID tabl=
es.

Ah yes, indeed. So no issue with the probe method.

> It is true that a driver, which registers multiple out of those three tab=
les is
> currently forced to have the same private data type for all of them.

I think that's a feature actually as it enforces best practices.

> I don't think this is a concern, is it? If so, it's easily resolvable by =
just
> adding two more associated types, e.g. `PlatformIdInfo`, `DtIdInfo` and
> `AcpiIdInfo`.
>
> In this case we would indeed need accessor functions like `dt_match_data`=
,
> `platform_match_data`, `acpi_match_data`, since we don't know the type at
> compile time anymore.

Do we need to split those out in rust or can we just call
device_get_match_data()?

>
> I don't think that's necessary though.

Even if you don't support all 3 tables now, at a minimum I think you
need to rename things to be clear what table type is supported and
allow for adding the other types. For example, T::ID_TABLE needs to be
renamed to be clear it's the of_device_id table.

Rob

