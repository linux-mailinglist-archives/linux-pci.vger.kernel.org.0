Return-Path: <linux-pci+bounces-15597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37A9B6301
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 13:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645051F2109E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 12:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA051E5710;
	Wed, 30 Oct 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEhdjvWK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC601D1E7A;
	Wed, 30 Oct 2024 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291044; cv=none; b=QdtdV3gwafP85Vb3VgCS70ey7JKE0i/ErI0QG/ZYx6Bn3lfSJGdg0Oe+OUzEhKwq/3xj4D/mqjZpe3wOxNjjjrRB+vj6+9kzLcdoUdjO8NoyBjMEn+LvhgwN6tUDSDwT5f1A63KdBIm01WRyxQbG/VnwvAeYRfNltrep3/dqQcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291044; c=relaxed/simple;
	bh=bY0GAYNYCE+RSpo4fyBnoTfZwqxIoHX79jv6jrJ4QT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VChlk8L2lpqb4AwmLAbOwYwWG1JQXyhEZA9ZERHVLaHYUnqo2FywKb/sVLTvyiei4GqvWkgAfpuSQ1W67YOO4EpBDx+Y7/0bwo83MxRhrmW8JqeIpfMSFoOPyc2Ydgq0dtRxr0Qhr6XPdxtdw3VEPfhxEIvv8CZFZwyzlXTUAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEhdjvWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70262C4AF09;
	Wed, 30 Oct 2024 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730291043;
	bh=bY0GAYNYCE+RSpo4fyBnoTfZwqxIoHX79jv6jrJ4QT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LEhdjvWK4A9Zgjc5KoJoLfBA1TF5llAqVoIoB6Pc4P5I9gWgPPeOmMYOIWYmZ9CgY
	 ZZhK4eeg2bxiccWbkgTpssSJUBgBpKe7J05noYaarosExUgW12+bhuKJi1OWVPjQPC
	 uIJfqkPTZtDmpFzVj35uoJFZsjIXarXUjQl2XsNGsSpEuMusMr7vFm2/BlJSKqJJVt
	 npJ6McW+76DExTE2qXvmffaWpLTtt8nzBmOyBOjzbSqDts/ekjVuvBCSwPW7FCSpbT
	 Utd79sQsdlnhWa8StSFEK4l8j6ydLXSh3wlCDRnqRBdFJxuk/abBQKd1tJPAF2hIBS
	 6BNmnznGY4fAA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e59dadebso7775998e87.0;
        Wed, 30 Oct 2024 05:24:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrEeV0jZ1EcqM19I4D/lmyl8ibicLndeMZWiAnoKTfmMn0U82/+odK7L8gxXPMifguWFgj/WzXJ4OkSyaRcVg=@vger.kernel.org, AJvYcCWBVL5DwP9hzqUXGGURkWXSRLDc9DUs2nSvpjppQXc9Jsv9cC90L5fiJLJqiPlWyFTUyH4gXZfb4WI6@vger.kernel.org, AJvYcCX8fF6/HNz0ogiR4HVeDpKj/CjyNSVPS0JIQoPyWOI/T3KchufvBecwJ2yAWSi1vA5L16pOtpnn1lSUAAtt@vger.kernel.org, AJvYcCXySi80zeLg7lZcnCOC15z9l3yBxcWssz8F1ZGCVUlHJ8LvsTrOevvgj1C5WuaI39er7WmwsrdYirBV@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/ng5DaNDFSjEsgMoepSy0bi8uqKRNQZlw/IDqHf2CBeN/EtT
	/nllG/GDc17inHqQFoAIuvOszmgOEYBHaqq9mSNXni5nCdvpvWjaxu38V+DsPOhvPM7xKUpyUp0
	ST4g1HM3iXuktOfvO41UTZYj+wg==
X-Google-Smtp-Source: AGHT+IEjmd362Hqb5BBG6j7OLpPRxtrkzKY/9eQkTx2RwWQmpEEJo7tsXGjQ/w8hsZo0lxGp1u96hzI1IqyL3t6dZZs=
X-Received: by 2002:a05:6512:3d26:b0:539:f4a6:ef4b with SMTP id
 2adb3069b0e04-53b34c8db59mr8102763e87.55.1730291041754; Wed, 30 Oct 2024
 05:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-16-dakr@kernel.org>
 <20241022234712.GB1848992-robh@kernel.org> <ZxibWpcswZxz5A07@pollux>
 <20241023142355.GA623906-robh@kernel.org> <Zx9kR4OhT1pErzEk@pollux>
In-Reply-To: <Zx9kR4OhT1pErzEk@pollux>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Oct 2024 07:23:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLVdoQNSSDCfGcf0wCZE9VQphRhHKANxhpei_UoFzkN9g@mail.gmail.com>
Message-ID: <CAL_JsqLVdoQNSSDCfGcf0wCZE9VQphRhHKANxhpei_UoFzkN9g@mail.gmail.com>
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

On Mon, Oct 28, 2024 at 5:15=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed, Oct 23, 2024 at 09:23:55AM -0500, Rob Herring wrote:
> > On Wed, Oct 23, 2024 at 08:44:42AM +0200, Danilo Krummrich wrote:
> > > On Tue, Oct 22, 2024 at 06:47:12PM -0500, Rob Herring wrote:
> > > > On Tue, Oct 22, 2024 at 11:31:52PM +0200, Danilo Krummrich wrote:
> > > > > +///     ]
> > > > > +/// );
> > > > > +///
> > > > > +/// impl platform::Driver for MyDriver {
> > > > > +///     type IdInfo =3D ();
> > > > > +///     const ID_TABLE: platform::IdTable<Self::IdInfo> =3D &OF_=
TABLE;
> > > > > +///
> > > > > +///     fn probe(
> > > > > +///         _pdev: &mut platform::Device,
> > > > > +///         _id_info: Option<&Self::IdInfo>,
> > > > > +///     ) -> Result<Pin<KBox<Self>>> {
> > > > > +///         Err(ENODEV)
> > > > > +///     }
> > > > > +/// }
> > > > > +///```
> > > > > +/// Drivers must implement this trait in order to get a platform=
 driver registered. Please refer to
> > > > > +/// the `Adapter` documentation for an example.
> > > > > +pub trait Driver {
> > > > > +    /// The type holding information about each device id suppor=
ted by the driver.
> > > > > +    ///
> > > > > +    /// TODO: Use associated_type_defaults once stabilized:
> > > > > +    ///
> > > > > +    /// type IdInfo: 'static =3D ();
> > > > > +    type IdInfo: 'static;
> > > > > +
> > > > > +    /// The table of device ids supported by the driver.
> > > > > +    const ID_TABLE: IdTable<Self::IdInfo>;
> >
> > Another thing. I don't think this is quite right. Well, this part is
> > fine, but assigning the DT table to it is not. The underlying C code ha=
s
> > 2 id tables in struct device_driver (DT and ACPI) and then the bus
> > specific one in the struct ${bus}_driver.
>
> The assignment of this table in `Adapter::register` looks like this:
>
> `pdrv.driver.of_match_table =3D T::ID_TABLE.as_ptr();`
>
> What do you think is wrong with this assignment?

Every bus implementation will need the DT and ACPI tables, so they
should not be declared and assigned in platform driver code, but in
the generic device/driver abstractions just like the underlying C
code. The one here should be for platform_device_id. You could put all
3 tables here, but that's going to be a lot of duplication I think.

> >
> > > > > +
> > > > > +    /// Platform driver probe.
> > > > > +    ///
> > > > > +    /// Called when a new platform device is added or discovered=
.
> > > > > +    /// Implementers should attempt to initialize the device her=
e.
> > > > > +    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -=
> Result<Pin<KBox<Self>>>;
> > > > > +
> > > > > +    /// Find the [`of::DeviceId`] within [`Driver::ID_TABLE`] ma=
tching the given [`Device`], if any.
> > > > > +    fn of_match_device(pdev: &Device) -> Option<&of::DeviceId> {
> > > >
> > > > Is this visible to drivers? It shouldn't be.
> > >
> > > Yeah, I think we should just remove it. Looking at struct of_device_i=
d, it
> > > doesn't contain any useful information for a driver. I think when I a=
dded this I
> > > was a bit in "autopilot" mode from the PCI stuff, where struct pci_de=
vice_id is
> > > useful to drivers.
> >
> > TBC, you mean other than *data, right? If so, I agree.
>
> Yes.
>
> >
> > The DT type and name fields are pretty much legacy, so I don't think th=
e
> > rust bindings need to worry about them until someone converts Sparc and
> > PowerMac drivers to rust (i.e. never).
> >
> > I would guess the PCI cases might be questionable, too. Like DT, driver=
s
> > may be accessing the table fields, but that's not best practice. All th=
e
> > match fields are stored in pci_dev, so why get them from the match
> > table?
>
> Fair question, I'd like to forward it to Greg. IIRC, he explicitly reques=
ted to
> make the corresponding struct pci_device_id available in probe() at Kangr=
ejos.

Which table gets passed in though? Is the IdInfo parameter generic and
can be platform_device_id, of_device_id or acpi_device_id? Not sure if
that's possible in rust or not.

PCI is the exception, not the rule here, in that it only matches with
pci_device_id. At least I think that is the case currently, but it is
entirely possible we may want to do ACPI/DT matching like every other
bus. There are cases where PCI devices are described in DT.

Rob

