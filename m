Return-Path: <linux-pci+bounces-17339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F909D9757
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 13:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA02284F19
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38E01BD012;
	Tue, 26 Nov 2024 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSx3YnZF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14A27442;
	Tue, 26 Nov 2024 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732624756; cv=none; b=R2cfYO92f63XU4EbTZlV/Sbd71t6zXVT5QF6mnPpjmwZzri/wSL8uZtaPDw/57EFFT5eqr3LT/xDqUSigpXt2IG4yxaSjEH2yaSN6iJjeT18HR5wZZbCkWX0h70iAZxuCJ4Cl7Sf/zyHeE7IxCshWfESUyOxjCAdJlR9yFTXHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732624756; c=relaxed/simple;
	bh=mYv37OE2DecgbcMq0q2JvxnQqKQgrHopLS4szLMPhro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8N6oave+/K7bbJWLNsrs3zOiE4TKFqGKkYbmVxSOFT4IPiZhJ7Eoo9KZSvAi8PZj7luy0qs6v7hKd7Std9Ob+xGjWXVU33HzmNQw56Gm7gH+bu4IwlGCC3UIh5NxcwzAmSllDFYThdG7jWIFSl58lMKMV4QdjrIQFbSsf7rYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSx3YnZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55924C4CECF;
	Tue, 26 Nov 2024 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732624756;
	bh=mYv37OE2DecgbcMq0q2JvxnQqKQgrHopLS4szLMPhro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSx3YnZFImp3n1I1cPNJF+hEd3oPLAUEogGS/AJ+DUecMoWGBtOvst9AUKC1tyYVp
	 22sToN2aUViQ9J5UA1HB854ITvkbDXbWtCfpPx4pKGLb5qkGqKrQClsm/8htKh05VE
	 AxeuVuC4tgM9EmeozEcuuxSO9DfjfbyY29oaeS2lpj25UidXUici9FqSYmTy6bMYSf
	 ROWrp98amKd15GpfGj+cuTdEcPIF1afn+uzC4YKxhK955jsRqSykYs14/zFGyWt85+
	 cZXCKRlDNqGpU3KPwoubus0gKREGC9TxoVGJZYqdz60P75fqe3hWvEuG92xOqlTfmm
	 76IA9Zk8rTGeg==
Date: Tue, 26 Nov 2024 13:39:08 +0100
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
Message-ID: <Z0XBbLb8NRQg_dek@cassiopeiae>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <20241022234712.GB1848992-robh@kernel.org>
 <ZxibWpcswZxz5A07@pollux>
 <20241023142355.GA623906-robh@kernel.org>
 <Zx9kR4OhT1pErzEk@pollux>
 <CAL_JsqLVdoQNSSDCfGcf0wCZE9VQphRhHKANxhpei_UoFzkN9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLVdoQNSSDCfGcf0wCZE9VQphRhHKANxhpei_UoFzkN9g@mail.gmail.com>

On Wed, Oct 30, 2024 at 07:23:47AM -0500, Rob Herring wrote:
> On Mon, Oct 28, 2024 at 5:15 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Wed, Oct 23, 2024 at 09:23:55AM -0500, Rob Herring wrote:
> > > On Wed, Oct 23, 2024 at 08:44:42AM +0200, Danilo Krummrich wrote:
> > > > On Tue, Oct 22, 2024 at 06:47:12PM -0500, Rob Herring wrote:
> > > > > On Tue, Oct 22, 2024 at 11:31:52PM +0200, Danilo Krummrich wrote:
> > > > > > +///     ]
> > > > > > +/// );
> > > > > > +///
> > > > > > +/// impl platform::Driver for MyDriver {
> > > > > > +///     type IdInfo = ();
> > > > > > +///     const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
> > > > > > +///
> > > > > > +///     fn probe(
> > > > > > +///         _pdev: &mut platform::Device,
> > > > > > +///         _id_info: Option<&Self::IdInfo>,
> > > > > > +///     ) -> Result<Pin<KBox<Self>>> {
> > > > > > +///         Err(ENODEV)
> > > > > > +///     }
> > > > > > +/// }
> > > > > > +///```
> > > > > > +/// Drivers must implement this trait in order to get a platform driver registered. Please refer to
> > > > > > +/// the `Adapter` documentation for an example.
> > > > > > +pub trait Driver {
> > > > > > +    /// The type holding information about each device id supported by the driver.
> > > > > > +    ///
> > > > > > +    /// TODO: Use associated_type_defaults once stabilized:
> > > > > > +    ///
> > > > > > +    /// type IdInfo: 'static = ();
> > > > > > +    type IdInfo: 'static;
> > > > > > +
> > > > > > +    /// The table of device ids supported by the driver.
> > > > > > +    const ID_TABLE: IdTable<Self::IdInfo>;
> > >
> > > Another thing. I don't think this is quite right. Well, this part is
> > > fine, but assigning the DT table to it is not. The underlying C code has
> > > 2 id tables in struct device_driver (DT and ACPI) and then the bus
> > > specific one in the struct ${bus}_driver.
> >
> > The assignment of this table in `Adapter::register` looks like this:
> >
> > `pdrv.driver.of_match_table = T::ID_TABLE.as_ptr();`
> >
> > What do you think is wrong with this assignment?
> 
> Every bus implementation will need the DT and ACPI tables, so they
> should not be declared and assigned in platform driver code, but in
> the generic device/driver abstractions just like the underlying C
> code. The one here should be for platform_device_id. You could put all
> 3 tables here, but that's going to be a lot of duplication I think.

That's indeed true. But I'm not sure that at this point we need a generalized
`Driver` abstraction just for assigning the DT and ACPI tables.

Maybe it's better to do this in a subsequent series?

> 
> > >
> > > > > > +
> > > > > > +    /// Platform driver probe.
> > > > > > +    ///
> > > > > > +    /// Called when a new platform device is added or discovered.
> > > > > > +    /// Implementers should attempt to initialize the device here.
> > > > > > +    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>>;
> > > > > > +
> > > > > > +    /// Find the [`of::DeviceId`] within [`Driver::ID_TABLE`] matching the given [`Device`], if any.
> > > > > > +    fn of_match_device(pdev: &Device) -> Option<&of::DeviceId> {
> > > > >
> > > > > Is this visible to drivers? It shouldn't be.
> > > >
> > > > Yeah, I think we should just remove it. Looking at struct of_device_id, it
> > > > doesn't contain any useful information for a driver. I think when I added this I
> > > > was a bit in "autopilot" mode from the PCI stuff, where struct pci_device_id is
> > > > useful to drivers.
> > >
> > > TBC, you mean other than *data, right? If so, I agree.
> >
> > Yes.
> >
> > >
> > > The DT type and name fields are pretty much legacy, so I don't think the
> > > rust bindings need to worry about them until someone converts Sparc and
> > > PowerMac drivers to rust (i.e. never).
> > >
> > > I would guess the PCI cases might be questionable, too. Like DT, drivers
> > > may be accessing the table fields, but that's not best practice. All the
> > > match fields are stored in pci_dev, so why get them from the match
> > > table?
> >
> > Fair question, I'd like to forward it to Greg. IIRC, he explicitly requested to
> > make the corresponding struct pci_device_id available in probe() at Kangrejos.
> 
> Which table gets passed in though? Is the IdInfo parameter generic and
> can be platform_device_id, of_device_id or acpi_device_id? Not sure if
> that's possible in rust or not.

Not sure I can follow you here.

The `IdInfo` parameter is of a type given by the driver for driver specific data
for a certain ID table entry.

It's analogue to resolving `pci_device_id::driver_data` in C.

> 
> PCI is the exception, not the rule here, in that it only matches with
> pci_device_id. At least I think that is the case currently, but it is
> entirely possible we may want to do ACPI/DT matching like every other
> bus. There are cases where PCI devices are described in DT.
> 
> Rob
> 

