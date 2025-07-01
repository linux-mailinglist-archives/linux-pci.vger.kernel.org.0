Return-Path: <linux-pci+bounces-31155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C6CAEF5C9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 12:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A68F1C01710
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 10:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305926FDBF;
	Tue,  1 Jul 2025 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUzxtVUf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A226FD84;
	Tue,  1 Jul 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367505; cv=none; b=fd3m2LdAXRYS3NChl3WiRbPnwOBz8uQ19jEOnEayWQ6ipUMP8BghLKfaad2A/9JxKTYSV/Ua8J0OGMbb5qOJGUMq+cf/vQvN4TiQTf+EWNGmbphxl44paKSyqGVD89JruOjAQ5Ze38DfVlylCfKS5sDJl5LjV7ONb5CWfKi4vlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367505; c=relaxed/simple;
	bh=rkk9UXLbZVSCdjtp0NqI8G1ocVmjPZNAkzoBEd4QeOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSWk3vjDwjBnfIOHwNKwT0Ls41/0Y5mqLZDdZM/Fqh00KxrwU88u4rkdXTcMA00LMc/Bvy1Kx0sLD0YPun+E9p1glLgRbtN8hX4N82jl4NcEHNxPs+PUiGvOUlKinyX8/TTke0NErjxkae9ZjnG3APCw0M19wuYzN9ygLu/T1Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUzxtVUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4DAC4CEF2;
	Tue,  1 Jul 2025 10:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751367504;
	bh=rkk9UXLbZVSCdjtp0NqI8G1ocVmjPZNAkzoBEd4QeOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUzxtVUfD+FrdmJ4uxcXRjHlmlp2bY+JUoTNEReVPbJZGHiSZZI9q6rLqHcHT0cg8
	 fReLHXJHPb7dOmIb9xkRccCpQlfgPeH9Rb0kyjUrekLeGkQ27twK+dN6xcVBZq7CiS
	 RtINx2Q5gNubSCw3xUCGMJnpkEVm2Kr9uX5EdA2BD550F8TLssLt6RNlUSAIsmcKLe
	 I+05mSRTsPhteQ1V/Sz/5f0Xf3nSGV39EG/SRGiDaiZHdssO38GAxtfwOfw6P8FFYT
	 9AduqGDx+AOvI6bp5jI6WeRgFv1x0U/WNfrNAGKYl2inFZ6sAGHIhcNlzOqrbh3YDt
	 9UMzA7B53hYuw==
Date: Tue, 1 Jul 2025 12:58:17 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/8] rust: device: add drvdata accessors
Message-ID: <aGO_SS20fttVZM6D@pollux>
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-3-dakr@kernel.org>
 <2025070159-perkiness-bullion-da76@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025070159-perkiness-bullion-da76@gregkh>

On Tue, Jul 01, 2025 at 11:27:54AM +0200, Greg KH wrote:
> On Sat, Jun 21, 2025 at 09:43:28PM +0200, Danilo Krummrich wrote:

> > +impl Device<Internal> {
> > +    /// Store a pointer to the bound driver's private data.
> > +    pub fn set_drvdata(&self, data: impl ForeignOwnable) {
> > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> > +        unsafe { bindings::dev_set_drvdata(self.as_raw(), data.into_foreign().cast()) }
> > +    }
> 
> Ah, but a driver's private data in the device is NOT a bus-specific
> thing, it's a driver-specific thing, so your previous patch about
> Internal being there for busses feels odd.

It's because we only want to allow the bus abstraction to call
Device::set_drvdata().

The reason is the lifecycle of the driver's private data:

It starts when the driver returns the private data object in probe(). In the bus
abstraction's probe() function, we're calling set_drvdata().

At this point the ownership of the object technically goes to the device. And it
is our responsibility to extract the object from dev->driver_data at some point
again through drvdata_obtain(). With calling drvdata_obtain() we take back
ownership of the object.

Obviously, we do this in the bus abstraction's remove() callback, where we then
let the object go out of scope, such that it's destructor gets called.

In contrast, drvdata_borrow() does what its name implies, it only borrows the
object from dev->driver_data, such that we can provide it for the driver to use.

In the bus abstraction's remove() callback, drvdata_obtain() must be able to
proof that the object we extract from dev->driver_data is the exact object that
we set when calling set_drvdata() from probe().

If we'd allow the driver to call set_drvdata() itself (which is unnecessary
anyways), drivers could:

  1) Call set_drvdata() multiple times, where every previous call would leak the
     object, since the pointer would be overwritten.

  2) We'd loose any guarantee about the type we extract from dev->driver_data
     in the bus abstraction's remove() callback wioth drvdata_obtain().

> > +
> > +    /// Take ownership of the private data stored in this [`Device`].
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// - Must only be called once after a preceding call to [`Device::set_drvdata`].
> > +    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
> > +    ///   [`Device::set_drvdata`].
> > +    pub unsafe fn drvdata_obtain<T: ForeignOwnable>(&self) -> T {
> > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> > +        let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> > +
> > +        // SAFETY: By the safety requirements of this function, `ptr` comes from a previous call to
> > +        // `into_foreign()`.
> > +        unsafe { T::from_foreign(ptr.cast()) }
> > +    }
> > +
> > +    /// Borrow the driver's private data bound to this [`Device`].
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// - Must only be called after a preceding call to [`Device::set_drvdata`] and before
> > +    ///   [`Device::drvdata_obtain`].
> > +    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
> > +    ///   [`Device::set_drvdata`].
> > +    pub unsafe fn drvdata_borrow<T: ForeignOwnable>(&self) -> T::Borrowed<'_> {
> > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> > +        let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> > +
> > +        // SAFETY: By the safety requirements of this function, `ptr` comes from a previous call to
> > +        // `into_foreign()`.
> > +        unsafe { T::borrow(ptr.cast()) }
> > +    }
> > +}
> 
> Why can't this be part of Core?

Device::drvdata_borrow() itself can indeed be part of Core. It has to remain
unsafe though, because the type T has to match the type that the driver returned
from probe().

Instead, we should provide a reference of the driver's private data in every bus
callback, such that drivers don't need unsafe code.

In order to not tempt drivers to use the unsafe method drvdata_borrow()
directly, I went for hiding it behind the BusInternal device context.

