Return-Path: <linux-pci+bounces-15442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ED89B2CAC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 11:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08A0282352
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A031D0E38;
	Mon, 28 Oct 2024 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFJ6YR4v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24721193091;
	Mon, 28 Oct 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110884; cv=none; b=r8Bdlye2grBZcaGY8I35D2dXGEWpU9tkYCuGaGgotpwsHBd1vsWujKdPdhdWJWhsqcJ60W4gDccopnM6+6Ui4WBd1X67BykQKmmHkpItlUFufejuZkRcmVhQeibW0TZ6Qz2dB7x/oMHbOgS0xhZehNuYNJd46DmKWziFPsZjFhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110884; c=relaxed/simple;
	bh=owNUxo2qvIqiw6YFzUe3v+lHPOEmrIQQY5K8b53qT60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgLb0GBuHhZyTkp+m5GrymEAy9GmFntbuGw/aojlg/VdbvS8ueIVqfCMk0NW1wDL4jhsXPkKMj2yixrSV8Qhx9qEXKgaJt01gODPHiOZ2pkkxOHA0qDxbRr6KEWYy/qQUoCvC4249Lj5nJ4mHSUV+ZcuYguZ4t33tMnuEabdMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFJ6YR4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDE1C4CEC3;
	Mon, 28 Oct 2024 10:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730110883;
	bh=owNUxo2qvIqiw6YFzUe3v+lHPOEmrIQQY5K8b53qT60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFJ6YR4v9rfHzqTOjhA3QuldxEbUh9bUsWCIlSZRiS1yTs9WbHQFLCrkQkL1sCvSs
	 IHH8XLVXwJFAhVFyEjx/4O6tD0AB444yGdk6zufQ4XPFnDp2j7XJuwG393PP6M3uz6
	 5GxSIp8WR13wevxTKL2rAOMaaOn8zw/pXJ6BRK0dEZgckXDx5ATOJyn9STqwCIwI7u
	 jeAXhragt3V2YJ/lHUSWlBGfkgE+wiq/TRlwZL5M+l0usM4NRApQwNCkYVEMeebZft
	 fXpgrXAOt9C22EEAms1nuU16QtWlCxfPanH03kyfD7r820IJim30lSAYkKsQUaPxEH
	 OG4TeHKDB0htQ==
Date: Mon, 28 Oct 2024 11:21:15 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 11/16] rust: pci: add basic PCI device / driver
 abstractions
Message-ID: <Zx9lm9pSq2ymnJZL@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-12-dakr@kernel.org>
 <Zx7B4Y5iegKVXpC4@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx7B4Y5iegKVXpC4@Boquns-Mac-mini.local>

On Sun, Oct 27, 2024 at 03:42:41PM -0700, Boqun Feng wrote:
> Hi Danilo,
> 
> On Tue, Oct 22, 2024 at 11:31:48PM +0200, Danilo Krummrich wrote:
> [...]
> > +/// The PCI device representation.
> > +///
> > +/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
> > +/// device, hence, also increments the base device' reference count.
> > +#[derive(Clone)]
> > +pub struct Device(ARef<device::Device>);
> > +
> 
> Similar to https://lore.kernel.org/rust-for-linux/ZgG7TlybSa00cuoy@boqun-archlinux/
> 
> Could you also avoid wrapping a point to a PCI device? Instead, wrap the
> object type:
> 
>     #[repr(transparent)]
>     pub struct Device(Opaque<bindings::pci_dev>);
> 
>     impl AlwaysRefCounted for Device {
>         <put_device() and get_device() on ->dev>
>     }

Yeah, the idea was to avoid the duplicate implementation of `AlwaysRefCounted`,
but I agree it's a bit messy. Will change it.

> 
> Regards,
> Boqun
> 
> > +impl Device {
> > +    /// Create a PCI Device instance from an existing `device::Device`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `dev` must be an `ARef<device::Device>` whose underlying `bindings::device` is a member of
> > +    /// a `bindings::pci_dev`.
> > +    pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
> > +        Self(dev)
> > +    }
> > +
> > +    fn as_raw(&self) -> *mut bindings::pci_dev {
> > +        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
> > +        // embedded in `struct pci_dev`.
> > +        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
> > +    }
> > +
> > +    /// Enable memory resources for this device.
> > +    pub fn enable_device_mem(&self) -> Result {
> > +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
> > +        let ret = unsafe { bindings::pci_enable_device_mem(self.as_raw()) };
> > +        if ret != 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(())
> > +        }
> > +    }
> > +
> > +    /// Enable bus-mastering for this device.
> > +    pub fn set_master(&self) {
> > +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
> > +        unsafe { bindings::pci_set_master(self.as_raw()) };
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
> > 
> 

