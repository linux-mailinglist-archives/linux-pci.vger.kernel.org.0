Return-Path: <linux-pci+bounces-17700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE759E449B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 20:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DC8167360
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7031C3BF9;
	Wed,  4 Dec 2024 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnZ+uEiw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3D2391B3;
	Wed,  4 Dec 2024 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340636; cv=none; b=OtUXgu2TOi9/lA9cYhY75nkYXVsrkzAzRuG1ZIWFSApiiPCRYx0mR7kQ79Bl/xmIVpRZNxFqXTm1hPCDetschaqKlPx8kFbh9R6EZ2n3QEFNLy0NS3cSvJCnUT8mmLaT85+ljFaVPD2bYCJTeuhlPM1+6TiYkRvhFN0T/B5doOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340636; c=relaxed/simple;
	bh=ihTJ2yXjg6e57IAiUEukEcJ9ypSdLyvvGf7Ps6RHyt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMpcMdxgwSeEuxhNmmMUtr1NJpX417MALBk+gKL+fSZAlg+sXVCjiiB2BuDPf0ZC3wvlaz+9ODIcoUQr10vO21em7qeqEGKOSEhA3AL09Mj65vpS5ApmEvgmzjs58HvcxIk4VIVOKMpCHKzeqKhi35fhVtOd2lQaG8E6pWVhVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnZ+uEiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E9CC4CECD;
	Wed,  4 Dec 2024 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733340636;
	bh=ihTJ2yXjg6e57IAiUEukEcJ9ypSdLyvvGf7Ps6RHyt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnZ+uEiw68/OknjbhzgE+/eIr8+afVQ3AJWoZGCkSot6CAZdVdgTue6fDmbb1x1rX
	 wIODjfF3hRtRWvjM747e+BRK8d9ymv17QK9eKDI1+xB+a3jqJp1QdZZib7gJGQokPO
	 66v2ClrheJoJfWREGiOLZTyksrhNxg6DPlmANx+m94PgybMW3IKwrZUbIFsZBDz3On
	 1fRbCOXjFTgAGaWUtcHbjqYIcUjKj5yp9q38enqHLcqmi5X0ae2uOYaD9atrNJXu+G
	 ddRtepnXXcZ1AmDVTwizihUYWiQumh+TSk6f2SUhJEJM56vuHfsC0wTor/4JZbuOve
	 CZcPAzztRHpyQ==
Date: Wed, 4 Dec 2024 20:30:28 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
Message-ID: <Z1Ct1PhowNg4HiET@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <7EA482EF-1D3E-4C3E-A805-4F404758610C@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7EA482EF-1D3E-4C3E-A805-4F404758610C@collabora.com>

On Wed, Dec 04, 2024 at 04:25:32PM -0300, Daniel Almeida wrote:
> Hi Danilo,
> 
> > On 22 Oct 2024, at 18:31, Danilo Krummrich <dakr@kernel.org> wrote:
> > +
> > +/// The platform device representation.
> > +///
> > +/// A platform device is based on an always reference counted `device:Device` instance. Cloning a
> > +/// platform device, hence, also increments the base device' reference count.
> > +///
> > +/// # Invariants
> > +///
> > +/// `Device` holds a valid reference of `ARef<device::Device>` whose underlying `struct device` is a
> > +/// member of a `struct platform_device`.
> > +#[derive(Clone)]
> > +pub struct Device(ARef<device::Device>);
> > +
> > +impl Device {
> > +    /// Convert a raw kernel device into a `Device`
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `dev` must be an `Aref<device::Device>` whose underlying `bindings::device` is a member of a
> > +    /// `bindings::platform_device`.
> > +    unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
> > +        Self(dev)
> > +    }
> > +
> > +    fn as_dev(&self) -> &device::Device {
> 
> This has to be pub, since a platform::Device is at least as useful as a device::Device.
> 
> IOW: if an API takes &device::Device, there is no reason why someone with a &platform::Device
> shouldn’t be able to call it.
> 
> In particular, having this as private makes it impossible for a platform driver to use Abdiel’s DMA allocator at [0].

No worries, I already made it public in my branch [1], I'll send out a v4 soon.

[1] https://github.com/Rust-for-Linux/linux/blob/staging/dev/rust/kernel/platform.rs#L213

- Danilo

> 
> > +        &self.0
> > +    }
> > +
> > +    fn as_raw(&self) -> *mut bindings::platform_device {
> > +        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
> > +        // embedded in `struct platform_device`.
> > +        unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
> > +    }
> > +}
> > +
> > +impl AsRef<device::Device> for Device {
> > +    fn as_ref(&self) -> &device::Device {
> > +        &self.0
> > +    }
> > +}
> > -- 
> > 2.46.2
> > 
> 
> — Daniel
> 
> [0]: https://lkml.org/lkml/2024/12/3/1281
> 

