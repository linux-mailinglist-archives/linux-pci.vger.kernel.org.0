Return-Path: <linux-pci+bounces-15648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9206B9B6BA9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 19:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499661F22387
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F21B373A;
	Wed, 30 Oct 2024 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th2/OQfg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1A19E99F;
	Wed, 30 Oct 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311677; cv=none; b=nOFfkk11NC6dFhyFK8RVrPs2VkhlIoIZ3ndpQxkBjzgrXH4UDoAFrv4LTfsB9ATLcaRaarLMdPK3VialW61UvcHFniuZYCWC51wAzaoaPVI/FX4R6vBFhYKpuNkbUBe/ae6TTQIlU+Fjic6nta2ZOBirdvQ71k0OhRXtE2axhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311677; c=relaxed/simple;
	bh=DacE1b7YBHxbFapNdObTjtI7fWH1r3sD6tkMcvfimYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQANE8NsXrLZFgYPTkYaA5tW4nz0fMBl0IM+mEiURSwKBhE+2lQT/OrEzMM4CiOeRor72pQHadsbYLFL3sAaTub0FPDgtGZIZP0T6ptybIpyVL7hb38Dy42eN9mZ9TnWtiM++Tb4Nl5XrKVpScQ+PGPIgXDj9ChgI3VOAN889Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th2/OQfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F5EC4CED2;
	Wed, 30 Oct 2024 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730311676;
	bh=DacE1b7YBHxbFapNdObTjtI7fWH1r3sD6tkMcvfimYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Th2/OQfge7Cqb5FSvk4tgbZgUOx/XFaqwtFDnx7Na4WLRcSFpDC5YfkBqoNsXIkdE
	 FeZAA2bNDZnLgebiYO1Z8Rw6relTq2lWLOpQtFH8HUNIWDVKgZjsNHFvmOXTPYO3yH
	 Nh9cuArCAA8zc4efk+R/0kdcFR1AQPG42SHqggBqPyIUxp21fOLjdmB9Pb7Zw048Ff
	 sXpF51GnDccvIrxGQHVw3njuZvS7nUUGMTge4EWjwBjDIHy0FjyeM13chZ1dX2NRiH
	 6ROUWEWDciA/OI3Bc0CFLJHLEH3W6kx9URVlNLZZMo12G+Yn0JLksUocfe0Hwo3mzt
	 Kdkw+BoC157Wg==
Date: Wed, 30 Oct 2024 19:07:48 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
Message-ID: <ZyJ19GDyVrGPbSEM@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <CAH5fLghVDqWiWfi2WKsNi3n=2pR_Hy3ZLwY8q2xfjAvpHuDx=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghVDqWiWfi2WKsNi3n=2pR_Hy3ZLwY8q2xfjAvpHuDx=w@mail.gmail.com>

On Wed, Oct 30, 2024 at 04:50:43PM +0100, Alice Ryhl wrote:
> On Tue, Oct 22, 2024 at 11:33 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > +/// Drivers must implement this trait in order to get a platform driver registered. Please refer to
> > +/// the `Adapter` documentation for an example.
> > +pub trait Driver {
> > +    /// The type holding information about each device id supported by the driver.
> > +    ///
> > +    /// TODO: Use associated_type_defaults once stabilized:
> > +    ///
> > +    /// type IdInfo: 'static = ();
> > +    type IdInfo: 'static;
> > +
> > +    /// The table of device ids supported by the driver.
> > +    const ID_TABLE: IdTable<Self::IdInfo>;
> > +
> > +    /// Platform driver probe.
> > +    ///
> > +    /// Called when a new platform device is added or discovered.
> > +    /// Implementers should attempt to initialize the device here.
> > +    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>>;
> 
> This forces the user to put their driver data in a KBox, but they
> might want to use an Arc instead. You don't actually *need* a KBox -
> any ForeignOwnable seems to fit your purposes.

This is intentional, I do need a `KBox` here.

The reason is that I want to enforce that the returned `Pin<KBox<Self>>` has
exactly the lifetime of the binding of the device and driver, i.e. from probe()
until remove(). This is the lifetime the structure should actually represent.

This way we can attach things like `Registration` objects to this structure, or
anything else that should only exist from probe() until remove().

If a driver needs some private driver data that needs to be reference counted,
it is usually attached to the class representation of the driver.

For instance, in Nova the reference counted stuff is attached to the DRM device
and then I just have the DRM device (which itself is reference counted) embedded
in the `Driver` structure.

In any case, drivers can always embed a separate `Arc` in their `Driver`
structure if they really have a need for that.

- Danilo

> 
> Please see my miscdevice and shrinker patchsets for examples of how
> you can extend this to allow any ForeignOwnable.
> 
> Alice
> 

