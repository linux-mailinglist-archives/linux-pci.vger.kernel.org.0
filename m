Return-Path: <linux-pci+bounces-17372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4049D9E2C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 21:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C99B251C7
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 20:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F62E1DE2A8;
	Tue, 26 Nov 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImgBi/Bk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4CB1DA631;
	Tue, 26 Nov 2024 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651272; cv=none; b=HpKrVn/Q8QNFBpzd7c8LSAsF/Lsy38n04gcUCKRU3uYhqt/u9JbLcFuVaTrTgYDMHSxuRCG3X27/PahL0Ny9FU5irNWiteFLIoYhXxOODNPQniHc2q9/9Lvc2jYgZ+dD6ZU1UEQW5Gmf2UtHo9nbmOetUl4+m11j6S9sVS51b4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651272; c=relaxed/simple;
	bh=tFOXiwaiJaj2E20xWUg5m2/swEN8VrEOYNsFbge3+Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mdp9/9VhXnN5fKAuYfICsYjLdMETRMDRAjYe/ccCwFRUSbtDkcnS5ot0UBiJk1mHYW12P9W5zUV4wIV3F1d0ED7ak3gxOYLfzwe25yAxETgJrZ9H6yXh0lxegd6k7ec9tX8UXYghCxzUdTDzr/6hViFCMtQ6Um13soiElvnhF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImgBi/Bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2232C4CECF;
	Tue, 26 Nov 2024 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732651271;
	bh=tFOXiwaiJaj2E20xWUg5m2/swEN8VrEOYNsFbge3+Zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImgBi/BkNUAFiWJZodfCx6/+89NO8uuWh3+p8cqTEyiAddf33Ds2Jeo0KfsCbgmUq
	 wsDrePsIJP1pIc/q87z53M4ZeJprWvpN7ej+6OW7kJo55SlxTGNI47fNRvLccj91Tr
	 bgDS7i7+AgYMgxpCUusl/w3nbhrcd2eFeKDqiVFPp2grpfRpQ3KK4rmWPsxP3I7O8E
	 GDrNcqg9QugHSWJrH2hId7WvGE/1qs19JH1zX2tMeVmvut44eN1TEcIpELv1JnZO68
	 aXE0xydGBH0WsjAopWA8EKkCvNIUc/hsYhXiqEcNmFOYjgXdSiU6/HnN24lobupkpF
	 G8vqiLqvLquXQ==
Date: Tue, 26 Nov 2024 21:01:04 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
Message-ID: <Z0YpAMz4RlWwc9Zq@pollux>
References: <20241022213221.2383-16-dakr@kernel.org>
 <20241022234712.GB1848992-robh@kernel.org>
 <ZxibWpcswZxz5A07@pollux>
 <20241023142355.GA623906-robh@kernel.org>
 <Zx9kR4OhT1pErzEk@pollux>
 <CAL_JsqLVdoQNSSDCfGcf0wCZE9VQphRhHKANxhpei_UoFzkN9g@mail.gmail.com>
 <Z0XBbLb8NRQg_dek@cassiopeiae>
 <CAL_Jsq+TV486zw=hAWkFnNbPeA08mJh_4kVVJLSXiYkzWcOVDg@mail.gmail.com>
 <Z0XmgXwwNikW6oJw@cassiopeiae>
 <CAL_JsqLohzzxDrJPFiQ6v8X=2i7pPUJdwzVLxShbcX-SCz_3Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLohzzxDrJPFiQ6v8X=2i7pPUJdwzVLxShbcX-SCz_3Jg@mail.gmail.com>

On Tue, Nov 26, 2024 at 01:15:59PM -0600, Rob Herring wrote:
> On Tue, Nov 26, 2024 at 9:17 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Tue, Nov 26, 2024 at 08:44:19AM -0600, Rob Herring wrote:
> > > > > > > The DT type and name fields are pretty much legacy, so I don't think the
> > > > > > > rust bindings need to worry about them until someone converts Sparc and
> > > > > > > PowerMac drivers to rust (i.e. never).
> > > > > > >
> > > > > > > I would guess the PCI cases might be questionable, too. Like DT, drivers
> > > > > > > may be accessing the table fields, but that's not best practice. All the
> > > > > > > match fields are stored in pci_dev, so why get them from the match
> > > > > > > table?
> > > > > >
> > > > > > Fair question, I'd like to forward it to Greg. IIRC, he explicitly requested to
> > > > > > make the corresponding struct pci_device_id available in probe() at Kangrejos.
> > >
> > > Making it available is not necessarily the same thing as passing it in
> > > via probe.
> >
> > IIRC, that was exactly the request.
> >
> > > I agree it may need to be available in probe(), but that
> > > can be an explicit call to get it.
> >
> > Sure, I did exactly that for the platform abstraction, because there we may
> > probe through different ID tables.
> 
> TBC, I think of_match_device() (both calling the C API and the method)
> should not be part of this series. I think we agreed on that already.
> Only if there is a need at some point later should we add it.

That matches my understanding.

> 
> > A `struct pci_driver`'s probe function has the following signature [1] though:
> >
> > `int (*probe)(struct pci_dev *dev, const struct pci_device_id *id)`
> >
> > [1] https://elixir.bootlin.com/linux/v6.12/source/include/linux/pci.h#L950
> 
> We have a mixture of probe with and without the _device_id parameter.
> I'd question if we really want to keep that for PCI when we have a
> chance to align things with Rust. We can't really with C as it would
> be too many drivers to change. Passing the _device_id only works if
> firmware matching is never used which can change over time. But if
> aligning things is not something we want to do, then I'll shut up.

I don't disagree. Again, this one is on Greg to comment on. Personally, I'm
fine with both.

> 
> > > > > Which table gets passed in though? Is the IdInfo parameter generic and
> > > > > can be platform_device_id, of_device_id or acpi_device_id? Not sure if
> > > > > that's possible in rust or not.
> > > >
> > > > Not sure I can follow you here.
> > > >
> > > > The `IdInfo` parameter is of a type given by the driver for driver specific data
> > > > for a certain ID table entry.
> > > >
> > > > It's analogue to resolving `pci_device_id::driver_data` in C.
> > >
> > > As I said below, the PCI case is simpler than for platform devices.
> > > Platform devices have 3 possible match tables. The *_device_id type we
> > > end up with is determined at runtime (because matching is done at
> > > runtime), so IdInfo could be any of those 3 types.
> >
> > `IdInfo` is *not* any of the three *_device_id types. It's the type of the
> > drivers private data associated with an entry of any of the three ID tables.
> 
> Ah yes, indeed. So no issue with the probe method.
> 
> > It is true that a driver, which registers multiple out of those three tables is
> > currently forced to have the same private data type for all of them.
> 
> I think that's a feature actually as it enforces best practices.

Agreed.

> 
> > I don't think this is a concern, is it? If so, it's easily resolvable by just
> > adding two more associated types, e.g. `PlatformIdInfo`, `DtIdInfo` and
> > `AcpiIdInfo`.
> >
> > In this case we would indeed need accessor functions like `dt_match_data`,
> > `platform_match_data`, `acpi_match_data`, since we don't know the type at
> > compile time anymore.
> 
> Do we need to split those out in rust or can we just call
> device_get_match_data()?

We'd need to split them, because they potentially would return different types.
(Again, I don't think that's necessary though.)

For C it's just a void pointer, so we don't bother there, but in Rust we'd want
it type safe.

> 
> >
> > I don't think that's necessary though.
> 
> Even if you don't support all 3 tables now, at a minimum I think you
> need to rename things to be clear what table type is supported and
> allow for adding the other types. For example, T::ID_TABLE needs to be
> renamed to be clear it's the of_device_id table.

Sure, I already got this on my list of changes for the next version.

> 
> Rob
> 

