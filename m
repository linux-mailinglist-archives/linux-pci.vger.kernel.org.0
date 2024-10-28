Return-Path: <linux-pci+bounces-15440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882CD9B2C8A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 11:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1651C21E7C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A118C910;
	Mon, 28 Oct 2024 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuokBvtN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088ECA59;
	Mon, 28 Oct 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110544; cv=none; b=N9zxfN0AtivIcytmLYIIg8RHiCXatg5Tprjt+M6fjPDfnL728KOWV9reDtzcJIq6H5WJkKNVUVPMIajyDz8MN6cSr3rbw57nijjJKCAiX9/BY2WQJGiQZOMYc81l/YxMP5saAq4Lwv+ooJFogyrw9Rnaif9cV6+WFyoTbmTsSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110544; c=relaxed/simple;
	bh=FNlGLpo7ThFgdkXFr0K2A7/imjFw4XYgmYXIs27D2C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0CK+Mbwe4gdKWOxk6j7oh4gQMfnr9nbYl5UQrafctEmALMFDupehoAD3gPZqOc2izE2Bort0uB+Db+C/j1faLi1aQtydGfGkTsqISnjxwPhsYqd1KR6ZLjnyBtDey/uEi5kmy12lFYKFHXx2+ELfOwHtmGyG1+GxdvmB3kLDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuokBvtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD2BC4CEC3;
	Mon, 28 Oct 2024 10:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730110543;
	bh=FNlGLpo7ThFgdkXFr0K2A7/imjFw4XYgmYXIs27D2C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuokBvtNFNZMki3pSHIjGzx63J/7nixUiryJ3SYdiBZD5oG7tzDC/rbcQ+K66/9KQ
	 nM+ngcqiMRKxpTeSbP+FJzn03qqie8T6mTKojTU+sviDw2hcKkJHgDvhaNxNDkFJ0f
	 JwRlE48oJNkINFvUXwkLjOY2cfq7ucMA4AhW7D2N6wf+Xnag5hqnXlJl6+5bt3F0K9
	 Uwlj9bgIwZuqyogtOxiTOAFz7gtVwq9KYSfVfpEavk34jBHo7GgHyY14e3kkwmxL3I
	 TJSWQLKLcqyjQpnS0PCLRrCxvxhZXX2aFvNr7/V1wV9jmuakzbIX1uiCkE6t5k5fwq
	 OJ7fUY80ShSyQ==
Date: Mon, 28 Oct 2024 11:15:35 +0100
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
Message-ID: <Zx9kR4OhT1pErzEk@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <20241022234712.GB1848992-robh@kernel.org>
 <ZxibWpcswZxz5A07@pollux>
 <20241023142355.GA623906-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023142355.GA623906-robh@kernel.org>

On Wed, Oct 23, 2024 at 09:23:55AM -0500, Rob Herring wrote:
> On Wed, Oct 23, 2024 at 08:44:42AM +0200, Danilo Krummrich wrote:
> > On Tue, Oct 22, 2024 at 06:47:12PM -0500, Rob Herring wrote:
> > > On Tue, Oct 22, 2024 at 11:31:52PM +0200, Danilo Krummrich wrote:
> > > > +///     ]
> > > > +/// );
> > > > +///
> > > > +/// impl platform::Driver for MyDriver {
> > > > +///     type IdInfo = ();
> > > > +///     const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
> > > > +///
> > > > +///     fn probe(
> > > > +///         _pdev: &mut platform::Device,
> > > > +///         _id_info: Option<&Self::IdInfo>,
> > > > +///     ) -> Result<Pin<KBox<Self>>> {
> > > > +///         Err(ENODEV)
> > > > +///     }
> > > > +/// }
> > > > +///```
> > > > +/// Drivers must implement this trait in order to get a platform driver registered. Please refer to
> > > > +/// the `Adapter` documentation for an example.
> > > > +pub trait Driver {
> > > > +    /// The type holding information about each device id supported by the driver.
> > > > +    ///
> > > > +    /// TODO: Use associated_type_defaults once stabilized:
> > > > +    ///
> > > > +    /// type IdInfo: 'static = ();
> > > > +    type IdInfo: 'static;
> > > > +
> > > > +    /// The table of device ids supported by the driver.
> > > > +    const ID_TABLE: IdTable<Self::IdInfo>;
> 
> Another thing. I don't think this is quite right. Well, this part is 
> fine, but assigning the DT table to it is not. The underlying C code has 
> 2 id tables in struct device_driver (DT and ACPI) and then the bus 
> specific one in the struct ${bus}_driver.

The assignment of this table in `Adapter::register` looks like this:

`pdrv.driver.of_match_table = T::ID_TABLE.as_ptr();`

What do you think is wrong with this assignment?

> 
> > > > +
> > > > +    /// Platform driver probe.
> > > > +    ///
> > > > +    /// Called when a new platform device is added or discovered.
> > > > +    /// Implementers should attempt to initialize the device here.
> > > > +    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>>;
> > > > +
> > > > +    /// Find the [`of::DeviceId`] within [`Driver::ID_TABLE`] matching the given [`Device`], if any.
> > > > +    fn of_match_device(pdev: &Device) -> Option<&of::DeviceId> {
> > > 
> > > Is this visible to drivers? It shouldn't be.
> > 
> > Yeah, I think we should just remove it. Looking at struct of_device_id, it
> > doesn't contain any useful information for a driver. I think when I added this I
> > was a bit in "autopilot" mode from the PCI stuff, where struct pci_device_id is
> > useful to drivers.
> 
> TBC, you mean other than *data, right? If so, I agree. 

Yes.

> 
> The DT type and name fields are pretty much legacy, so I don't think the 
> rust bindings need to worry about them until someone converts Sparc and 
> PowerMac drivers to rust (i.e. never).
> 
> I would guess the PCI cases might be questionable, too. Like DT, drivers 
> may be accessing the table fields, but that's not best practice. All the 
> match fields are stored in pci_dev, so why get them from the match 
> table?

Fair question, I'd like to forward it to Greg. IIRC, he explicitly requested to
make the corresponding struct pci_device_id available in probe() at Kangrejos.

> 
> Rob
> 

