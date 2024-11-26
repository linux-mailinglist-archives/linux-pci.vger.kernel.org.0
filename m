Return-Path: <linux-pci+bounces-17357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAE59D9A44
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 16:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13ED916560F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA951C1F02;
	Tue, 26 Nov 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mENdPAck"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73B17591;
	Tue, 26 Nov 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634250; cv=none; b=baLu7Oh9Yfx7trxQswlhczEsXD4I0DCr5Fb7+526UrynFhCA+La0TOexAro7HQxc/mkzfLCwkr8mJVzlAFGyoOYm9GCS2w0X2nbL6B4+TedzckHd0sitAibP5Vp1ZiyfeT1BYSNQDSB3BtvbvEEQfUHZXrbMqrAu5Mippc7VU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634250; c=relaxed/simple;
	bh=31VYdU13LysCO/yvKvq+N5wabf3c68mQyQuU1zSGNlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6xcPBDtIX6Ypm7fiB5TMc5KLUk4+6FtnM6j8ztVMbJOBy4vnOb8Uai6aWRYSupAmcgNL2NUEwcssWYNDiY5WSJ2wD2r4jsI7QcSJNBKDH5Ns8wNNOmZr6E6YbJJPVTG3F/7zyp/cmNG6mcQ1yF+MOCQpf/jj0R9OoGs22hOVLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mENdPAck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59871C4CECF;
	Tue, 26 Nov 2024 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732634249;
	bh=31VYdU13LysCO/yvKvq+N5wabf3c68mQyQuU1zSGNlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mENdPAcka6aUcWnm2cD849yzIT163GdRQ45x0k2OeyEQe2W8IUskkxqt6Neba6i6X
	 f3TpOZbIQx/dQphGvL7P2mff/j/oYry1r1ZJELlVoM5Ba8S6ur6aFDwW+Av6VAcQ9R
	 Eo4yB67IXhNJys+zdEeaVyZs6BrNBIk0xV7PMIMcBTheMmzl4K6lMNgtxF20h5W3cu
	 QeOuw7udZoe3C2b9GnB6DW0PSXbLS8j4ccKB+nt/bujFJZTtrMwJbqsylRAyZE1p4H
	 Jd/bBPr1Uk3yiG9Bh0E3F9jMTgeVaqHLFkRwXi/sJzCavRpR5AGqvuuz1810n22dRK
	 jKxwwE2XA2DjQ==
Date: Tue, 26 Nov 2024 16:17:21 +0100
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
Message-ID: <Z0XmgXwwNikW6oJw@cassiopeiae>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <20241022234712.GB1848992-robh@kernel.org>
 <ZxibWpcswZxz5A07@pollux>
 <20241023142355.GA623906-robh@kernel.org>
 <Zx9kR4OhT1pErzEk@pollux>
 <CAL_JsqLVdoQNSSDCfGcf0wCZE9VQphRhHKANxhpei_UoFzkN9g@mail.gmail.com>
 <Z0XBbLb8NRQg_dek@cassiopeiae>
 <CAL_Jsq+TV486zw=hAWkFnNbPeA08mJh_4kVVJLSXiYkzWcOVDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+TV486zw=hAWkFnNbPeA08mJh_4kVVJLSXiYkzWcOVDg@mail.gmail.com>

On Tue, Nov 26, 2024 at 08:44:19AM -0600, Rob Herring wrote:
> > > > > The DT type and name fields are pretty much legacy, so I don't think the
> > > > > rust bindings need to worry about them until someone converts Sparc and
> > > > > PowerMac drivers to rust (i.e. never).
> > > > >
> > > > > I would guess the PCI cases might be questionable, too. Like DT, drivers
> > > > > may be accessing the table fields, but that's not best practice. All the
> > > > > match fields are stored in pci_dev, so why get them from the match
> > > > > table?
> > > >
> > > > Fair question, I'd like to forward it to Greg. IIRC, he explicitly requested to
> > > > make the corresponding struct pci_device_id available in probe() at Kangrejos.
> 
> Making it available is not necessarily the same thing as passing it in
> via probe.

IIRC, that was exactly the request.

> I agree it may need to be available in probe(), but that
> can be an explicit call to get it.

Sure, I did exactly that for the platform abstraction, because there we may
probe through different ID tables.

A `struct pci_driver`'s probe function has the following signature [1] though:

`int (*probe)(struct pci_dev *dev, const struct pci_device_id *id)`

[1] https://elixir.bootlin.com/linux/v6.12/source/include/linux/pci.h#L950

> 
> > > Which table gets passed in though? Is the IdInfo parameter generic and
> > > can be platform_device_id, of_device_id or acpi_device_id? Not sure if
> > > that's possible in rust or not.
> >
> > Not sure I can follow you here.
> >
> > The `IdInfo` parameter is of a type given by the driver for driver specific data
> > for a certain ID table entry.
> >
> > It's analogue to resolving `pci_device_id::driver_data` in C.
> 
> As I said below, the PCI case is simpler than for platform devices.
> Platform devices have 3 possible match tables. The *_device_id type we
> end up with is determined at runtime (because matching is done at
> runtime), so IdInfo could be any of those 3 types.

`IdInfo` is *not* any of the three *_device_id types. It's the type of the
drivers private data associated with an entry of any of the three ID tables.

It is true that a driver, which registers multiple out of those three tables is
currently forced to have the same private data type for all of them.

I don't think this is a concern, is it? If so, it's easily resolvable by just
adding two more associated types, e.g. `PlatformIdInfo`, `DtIdInfo` and
`AcpiIdInfo`.

In this case we would indeed need accessor functions like `dt_match_data`,
`platform_match_data`, `acpi_match_data`, since we don't know the type at
compile time anymore.

I don't think that's necessary though.

> Is the exact type
> opaque to probe() and will that magically work in rust? Or do we need
> to pass in the 'driver_data' ptr (or reference) itself? The matched
> driver data is generally all the driver needs or cares about. We can
> probably assume that it is the same type no matter which match table
> is used whether it is platform_device_id::driver_data,
> of_device_id::data, or acpi_device_id::driver_data. Nothing in the C
> API guarantees that, but that's just best practice. Best practice in C
> looks like this:
> 
> my_probe()
> {
>   struct my_driver_data *data = device_get_match_data();
>   ...
> }
> 
> device_get_match_data() is just a wrapper to handle the 3 possible match tables.
> 
> The decision for rust is whether we pass in "data" to probe or have an
> explicit call. There is a need to get to the *_device_id entry, but
> that's the exception. I would go as far as saying we may never need
> that in rust drivers.
> 
> Rob
> 
> > > PCI is the exception, not the rule here, in that it only matches with
> > > pci_device_id. At least I think that is the case currently, but it is
> > > entirely possible we may want to do ACPI/DT matching like every other
> > > bus. There are cases where PCI devices are described in DT.
> > >
> > > Rob
> > >
> 

