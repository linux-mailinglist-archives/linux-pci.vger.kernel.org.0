Return-Path: <linux-pci+bounces-17355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0309D99D8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 15:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF938283617
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A81D63C1;
	Tue, 26 Nov 2024 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcvLQa8U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390ABE46;
	Tue, 26 Nov 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632272; cv=none; b=thykGGN51kZjWbS2BkGaWrIYxNjKMBMtmcKrw7StFPOscI+zPckeepv1cmmt8XfOdjNX1diVzR2Crn/TxY+EgLIZN7MQy7i0HMSNC0BKrNZG8/wxd8zNzgz9kUL2Nahdq+C+M5THSJgmUb7N/3ZHP8ImlAqmruPKWQTnn8EdQzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632272; c=relaxed/simple;
	bh=Rp1i+YK9SNFf15Z19uehbh8DuABXEgZ7TwsuCaYXqak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGgrxm/FVlkxarlKSInIm5w4sZPsINYOoNhPbp6qEjgXWC+Fwk4megx7hXXhGzZJlCLrses34See6xWaX7DS6SmemUdguk2VsTUprj3IgKCVQ4uuTvzqbdfLNJk0XUTYkBarcxZP/smXWJ6WP/kFXXZ2lxqTitq2ePcG9IQ0Ldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcvLQa8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2776C4CEDC;
	Tue, 26 Nov 2024 14:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732632271;
	bh=Rp1i+YK9SNFf15Z19uehbh8DuABXEgZ7TwsuCaYXqak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qcvLQa8UILu+IXYCyCKgwQ+6at8fPzw90s/e082v9PVuTmwA3oc0qCwf3IxAKL6Yh
	 xrIObF09eu/ufCmad8Ob466LyVLoLTdH0UnZj1o1A3aIqpGnnEsOhfzEx9j6d1G5mJ
	 gTPfWxmYTLV0AHRjKQa2seov9LTvWWKxGUVCjlyiuR+H1UD6oyoQuxsA3p8+qb5AN5
	 /b2Bpa+ayaNkXWp7u1i8LFLZVCC/C9dwedt5o2FRvw0BonI9oIR9ZFFd06Cd9W5m6A
	 fCX10JmKSjnsOHatMVJRzK18amO9qtzAorzyB8LSfiE3ODPyzvTyE68x5e9IMNTruw
	 JgAHemVwXtlOw==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e382589e8fdso5584039276.0;
        Tue, 26 Nov 2024 06:44:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7Pi2RW6CjD+UCq8hewZ/7Zk/9e4BLp8PpfBYEXCGJUfKNupN7jnugOaigivW6cRM6w1WvSffrDbIk@vger.kernel.org, AJvYcCUWamdOxHaPf26GWnT6rdRxrMjU2yx26S3xv5vD2jpFfRA1dre9wKKH27Y5xYYclzoBI26gBs0cZi1U@vger.kernel.org, AJvYcCVr/udCGztPYnyha+g6mo9ODyViIb8TNM1ZyHlEw213rjaGZBxeacmlf9hVSKnl6qcTxt7T9I0Iw7uYO0tpxes=@vger.kernel.org, AJvYcCXazFO+e4oh1U0bjBoITa8ZyBo1ckOrz/jqa57DPfwuxU21ZtwQMW5iq5tbgWouKSpxH1k0KnFlpY/FU7Qs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3dhtjJH1toniHW2+ZX5664FoO15KLzUBSiULSppkQg2w2NcJ
	xDHWbjyv3sLnpweBjmOEmCOFCmEsNfUCttCX04c7kam5BJkH4Vm0EaEvPVe+aLrLApOf64Bs+gP
	Vrond5cWem2agyOjgM0bazFYVBg==
X-Google-Smtp-Source: AGHT+IFmFJWf1WU6vBi8vHbFV0pukUSqPQpDYvejuGLEmStp7nUfeWncTakw2iHQ5OwZwQV3oIpkHHmir4p5muQOzRI=
X-Received: by 2002:a05:6902:278a:b0:e38:b48b:5fc3 with SMTP id
 3f1490d57ef6-e38f8be3986mr13689567276.32.1732632270826; Tue, 26 Nov 2024
 06:44:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-16-dakr@kernel.org>
 <20241022234712.GB1848992-robh@kernel.org> <ZxibWpcswZxz5A07@pollux>
 <20241023142355.GA623906-robh@kernel.org> <Zx9kR4OhT1pErzEk@pollux>
 <CAL_JsqLVdoQNSSDCfGcf0wCZE9VQphRhHKANxhpei_UoFzkN9g@mail.gmail.com> <Z0XBbLb8NRQg_dek@cassiopeiae>
In-Reply-To: <Z0XBbLb8NRQg_dek@cassiopeiae>
From: Rob Herring <robh@kernel.org>
Date: Tue, 26 Nov 2024 08:44:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+TV486zw=hAWkFnNbPeA08mJh_4kVVJLSXiYkzWcOVDg@mail.gmail.com>
Message-ID: <CAL_Jsq+TV486zw=hAWkFnNbPeA08mJh_4kVVJLSXiYkzWcOVDg@mail.gmail.com>
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

On Tue, Nov 26, 2024 at 6:39=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed, Oct 30, 2024 at 07:23:47AM -0500, Rob Herring wrote:
> > On Mon, Oct 28, 2024 at 5:15=E2=80=AFAM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > >
> > > On Wed, Oct 23, 2024 at 09:23:55AM -0500, Rob Herring wrote:
> > > > On Wed, Oct 23, 2024 at 08:44:42AM +0200, Danilo Krummrich wrote:
> > > > > On Tue, Oct 22, 2024 at 06:47:12PM -0500, Rob Herring wrote:
> > > > > > On Tue, Oct 22, 2024 at 11:31:52PM +0200, Danilo Krummrich wrot=
e:
> > > > > > > +///     ]
> > > > > > > +/// );
> > > > > > > +///
> > > > > > > +/// impl platform::Driver for MyDriver {
> > > > > > > +///     type IdInfo =3D ();
> > > > > > > +///     const ID_TABLE: platform::IdTable<Self::IdInfo> =3D =
&OF_TABLE;
> > > > > > > +///
> > > > > > > +///     fn probe(
> > > > > > > +///         _pdev: &mut platform::Device,
> > > > > > > +///         _id_info: Option<&Self::IdInfo>,
> > > > > > > +///     ) -> Result<Pin<KBox<Self>>> {
> > > > > > > +///         Err(ENODEV)
> > > > > > > +///     }
> > > > > > > +/// }
> > > > > > > +///```
> > > > > > > +/// Drivers must implement this trait in order to get a plat=
form driver registered. Please refer to
> > > > > > > +/// the `Adapter` documentation for an example.
> > > > > > > +pub trait Driver {
> > > > > > > +    /// The type holding information about each device id su=
pported by the driver.
> > > > > > > +    ///
> > > > > > > +    /// TODO: Use associated_type_defaults once stabilized:
> > > > > > > +    ///
> > > > > > > +    /// type IdInfo: 'static =3D ();
> > > > > > > +    type IdInfo: 'static;
> > > > > > > +
> > > > > > > +    /// The table of device ids supported by the driver.
> > > > > > > +    const ID_TABLE: IdTable<Self::IdInfo>;
> > > >
> > > > Another thing. I don't think this is quite right. Well, this part i=
s
> > > > fine, but assigning the DT table to it is not. The underlying C cod=
e has
> > > > 2 id tables in struct device_driver (DT and ACPI) and then the bus
> > > > specific one in the struct ${bus}_driver.
> > >
> > > The assignment of this table in `Adapter::register` looks like this:
> > >
> > > `pdrv.driver.of_match_table =3D T::ID_TABLE.as_ptr();`
> > >
> > > What do you think is wrong with this assignment?
> >
> > Every bus implementation will need the DT and ACPI tables, so they
> > should not be declared and assigned in platform driver code, but in
> > the generic device/driver abstractions just like the underlying C
> > code. The one here should be for platform_device_id. You could put all
> > 3 tables here, but that's going to be a lot of duplication I think.
>
> That's indeed true. But I'm not sure that at this point we need a general=
ized
> `Driver` abstraction just for assigning the DT and ACPI tables.

Why not? Practically *every* non-discoverable bus type needs that.
That's essentially everything except USB and PCI.

> Maybe it's better to do this in a subsequent series?

Sure, but only because there will be a limited number of users to fix.
It looks to me like things are designed for exactly 1 IdInfo
type/table per driver and that's not a correct assumption.

> > > > > > > +
> > > > > > > +    /// Platform driver probe.
> > > > > > > +    ///
> > > > > > > +    /// Called when a new platform device is added or discov=
ered.
> > > > > > > +    /// Implementers should attempt to initialize the device=
 here.
> > > > > > > +    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo=
>) -> Result<Pin<KBox<Self>>>;
> > > > > > > +
> > > > > > > +    /// Find the [`of::DeviceId`] within [`Driver::ID_TABLE`=
] matching the given [`Device`], if any.
> > > > > > > +    fn of_match_device(pdev: &Device) -> Option<&of::DeviceI=
d> {
> > > > > >
> > > > > > Is this visible to drivers? It shouldn't be.
> > > > >
> > > > > Yeah, I think we should just remove it. Looking at struct of_devi=
ce_id, it
> > > > > doesn't contain any useful information for a driver. I think when=
 I added this I
> > > > > was a bit in "autopilot" mode from the PCI stuff, where struct pc=
i_device_id is
> > > > > useful to drivers.
> > > >
> > > > TBC, you mean other than *data, right? If so, I agree.
> > >
> > > Yes.
> > >
> > > >
> > > > The DT type and name fields are pretty much legacy, so I don't thin=
k the
> > > > rust bindings need to worry about them until someone converts Sparc=
 and
> > > > PowerMac drivers to rust (i.e. never).
> > > >
> > > > I would guess the PCI cases might be questionable, too. Like DT, dr=
ivers
> > > > may be accessing the table fields, but that's not best practice. Al=
l the
> > > > match fields are stored in pci_dev, so why get them from the match
> > > > table?
> > >
> > > Fair question, I'd like to forward it to Greg. IIRC, he explicitly re=
quested to
> > > make the corresponding struct pci_device_id available in probe() at K=
angrejos.

Making it available is not necessarily the same thing as passing it in
via probe. I agree it may need to be available in probe(), but that
can be an explicit call to get it.

> > Which table gets passed in though? Is the IdInfo parameter generic and
> > can be platform_device_id, of_device_id or acpi_device_id? Not sure if
> > that's possible in rust or not.
>
> Not sure I can follow you here.
>
> The `IdInfo` parameter is of a type given by the driver for driver specif=
ic data
> for a certain ID table entry.
>
> It's analogue to resolving `pci_device_id::driver_data` in C.

As I said below, the PCI case is simpler than for platform devices.
Platform devices have 3 possible match tables. The *_device_id type we
end up with is determined at runtime (because matching is done at
runtime), so IdInfo could be any of those 3 types. Is the exact type
opaque to probe() and will that magically work in rust? Or do we need
to pass in the 'driver_data' ptr (or reference) itself? The matched
driver data is generally all the driver needs or cares about. We can
probably assume that it is the same type no matter which match table
is used whether it is platform_device_id::driver_data,
of_device_id::data, or acpi_device_id::driver_data. Nothing in the C
API guarantees that, but that's just best practice. Best practice in C
looks like this:

my_probe()
{
  struct my_driver_data *data =3D device_get_match_data();
  ...
}

device_get_match_data() is just a wrapper to handle the 3 possible match ta=
bles.

The decision for rust is whether we pass in "data" to probe or have an
explicit call. There is a need to get to the *_device_id entry, but
that's the exception. I would go as far as saying we may never need
that in rust drivers.

Rob

> > PCI is the exception, not the rule here, in that it only matches with
> > pci_device_id. At least I think that is the case currently, but it is
> > entirely possible we may want to do ACPI/DT matching like every other
> > bus. There are cases where PCI devices are described in DT.
> >
> > Rob
> >

