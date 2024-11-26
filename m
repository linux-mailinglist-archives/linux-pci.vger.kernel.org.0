Return-Path: <linux-pci+bounces-17352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723BF9D9920
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 15:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF81B22FF8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE531D5170;
	Tue, 26 Nov 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHjEaR9E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D96D528;
	Tue, 26 Nov 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630010; cv=none; b=Onz8botrJ8PGwJ1nbCtVAwTwZfEiERjUKLjPCTdEoNJ+1Q+NVX97MBnhlUhWMJMIb6CoEH07+qX79zKhGm0VFKvUkfbaX+qXTnEhncgJ+kW3jdvIl8RN6nyiYxz+my8gBZ7CTLAsi0rg616qzy+Kb5DMaiyLM4rIZpUPOArx+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630010; c=relaxed/simple;
	bh=q3P3bD8s7pucDmumXMg6Ga4FB2wZ4IMiuEZe4IDTCmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF1YO+4tVLG/UIVLXbMaAb4lx8Opbl5jtiRupHcDI1LdzaNWZTjpt2szxJc/NOHmRTrA75u52QBflu5YB5WWSbHhYTGbc8BtNBOvun4/6rHbcXUU5G5LUqdF3KZkt9hZAAHD8ShDAeJf4tMB3R/jPpRIR4WI96htAdAtpntzihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHjEaR9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FF4C4CED7;
	Tue, 26 Nov 2024 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732630009;
	bh=q3P3bD8s7pucDmumXMg6Ga4FB2wZ4IMiuEZe4IDTCmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHjEaR9EQsUyKZy1CnbOnQsXBlcuQFoH5boQpyGmn7Ll1MtOhoxex+5l0EG5bReKF
	 VQ46JoFBUQteKqaKIzqIqEZul7AayLZ8R/ohaLtzuKHQ9NHutedWhoq3aLM23/qasP
	 Vc7dCgBOQ5RBSHHOOoEuSLkgH/tLvqIlK9nZFchpArszPmeLvj9UkeNwmOoEuocn7C
	 1rGG36onjPiTd0XbREjzyOhAmhWHbdmbpWgWcUiDgWm2H8qVWWQ7AiXpG+SENTU+8W
	 TuxRI62cRTMdvpJHuuIbTAWPFRZJKMV4NfvOF4iHLss66jgyxlMKdfZQt8ErGuX+ID
	 gpl5PjCOmIDWQ==
Date: Tue, 26 Nov 2024 15:06:41 +0100
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
Message-ID: <Z0XV8R8Sbgd9mAq7@cassiopeiae>
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

It's not wrapping a pointer, but an `ARef<device::Device>`.

> 
>     #[repr(transparent)]
>     pub struct Device(Opaque<bindings::pci_dev>);
> 
>     impl AlwaysRefCounted for Device {
>         <put_device() and get_device() on ->dev>
>     }

This implementation is currently implicit, since `pci::Device` just wraps an
`ARef<device::Device>` (like any other bus specific device structure does), and
hence increments and decrements the reference count of the underlying `struct
device` automatically.

However, what I dislike about it is that with that, `pci::Device` behaves like
an `ARef<T>`, but isn't wrapped by `ARef` itself.

Just doing what you proposed is probably cleaner is this aspect, but generates a
bit of duplicated code in reference counting the underlying `struct device`.

- Danilo

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

