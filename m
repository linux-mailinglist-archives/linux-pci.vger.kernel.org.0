Return-Path: <linux-pci+bounces-7710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACFE8CAAB6
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 11:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B630D283123
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864456757;
	Tue, 21 May 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v1HmjlGW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E147A7C;
	Tue, 21 May 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283482; cv=none; b=XvhU8ktDDrxvCkn4VPuaFEMlX4v5YZc4onADowUPjuBdAidFwzw9PbNFeaMjCweHd7sxMAm6IORCQnKLip/LpSqG2W0Aq8XcxdvOs7gX+lh2l/DVjQqoaHVZCkx28LQQdIhz8f7hEfWzUieyIIs8+HgG9CPBp/KhCcYY8vXdcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283482; c=relaxed/simple;
	bh=FEogP54CIU9xaB8QKnpEHU5LEWGFTI1i0FIogAWOYnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYNqIVo8DRBbvZINU66MKABc/OO0v69cyvfZF4aqYYXY7M59xi7p4PCJtFLKCHpi0RRatji1a1q6LcbVxSn8GE6jR1VizHUd9IW7vlzm0miSxIfkngNe1JAwSxW+IYxc9XmAjLCXtwklLZ4I1N7V+lhSAiYsRYpYty78V1v+rPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v1HmjlGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6764FC2BD11;
	Tue, 21 May 2024 09:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716283481;
	bh=FEogP54CIU9xaB8QKnpEHU5LEWGFTI1i0FIogAWOYnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v1HmjlGWxxHiyySnPlxSFqAvAIuGRYYuvq8udMwgQx56u166ipR6O1snh2qaWLBYq
	 9pNUn1pfdZSXkDbWXuHJgcMvvQwdJAm+hCjgwcn/r7YPWVpB6M30/W8Uag488+YIre
	 TCf94Vw6F+3IVv+LzHKfFJdD8SD3NqW8BBSbJsNk=
Date: Tue, 21 May 2024 11:24:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] rust: add abstraction for struct device
Message-ID: <2024052144-alibi-mourner-d463@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-2-dakr@redhat.com>
 <2024052038-deviancy-criteria-e4fe@gregkh>
 <Zkuw/nOlpAe1OesV@pollux.localdomain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zkuw/nOlpAe1OesV@pollux.localdomain>

On Mon, May 20, 2024 at 10:22:22PM +0200, Danilo Krummrich wrote:
> On Mon, May 20, 2024 at 08:00:23PM +0200, Greg KH wrote:
> > On Mon, May 20, 2024 at 07:25:38PM +0200, Danilo Krummrich wrote:
> > > Add an (always) reference counted abstraction for a generic struct
> > > device. This abstraction encapsulates existing struct device instances
> > > and manages its reference count.
> > > 
> > > Subsystems may use this abstraction as a base to abstract subsystem
> > > specific device instances based on a generic struct device.
> > > 
> > > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > ---
> > >  rust/helpers.c        |  1 +
> > >  rust/kernel/device.rs | 76 +++++++++++++++++++++++++++++++++++++++++++
> > 
> > What's the status of moving .rs files next to their respective .c files
> > in the build system?  Keeping them separate like this just isn't going
> > to work, sorry.
> > 
> > > --- /dev/null
> > > +++ b/rust/kernel/device.rs
> > > @@ -0,0 +1,76 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Generic devices that are part of the kernel's driver model.
> > > +//!
> > > +//! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
> > 
> > relative paths for a common "include <linux/device.h" type of thing?
> > Rust can't handle include paths from directories?
> 
> Going to change this to `srctree/` as proposed by Miguel.
> 
> > 
> > > +
> > > +use crate::{
> > > +    bindings,
> > > +    types::{ARef, Opaque},
> > > +};
> > > +use core::ptr;
> > > +
> > > +/// A ref-counted device.
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
> > > +/// particular, the ARef instance owns an increment on underlying object’s reference count.
> > > +#[repr(transparent)]
> > > +pub struct Device(Opaque<bindings::device>);
> > > +
> > > +impl Device {
> > > +    /// Creates a new ref-counted instance of an existing device pointer.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
> > 
> > Callers NEVER care about the reference count of a struct device, anyone
> > poking in that is asking for trouble.
> 
> That's confusing, if not the caller who's passing the device pointer somewhere,
> who else?
> 
> Who takes care that a device' reference count is non-zero when a driver's probe
> function is called?

A device's reference count will be non-zero, I'm saying that sometimes,
some driver core functions are called with a 'struct device' that is
NULL, and it can handle it just fine.  Hopefully no callbacks to the
rust code will happen that way, but why aren't you checking just "to be
sure!" otherwise you could have a bug here, and it costs nothing to
verify it, right?

> It's the same here. The PCI code calls Device::from_raw() from its
> probe_callback() function, which is called from the C side. For instance:
> 
> extern "C" fn probe_callback(
>    pdev: *mut bindings::pci_dev,
>    id: *const bindings::pci_device_id,
> ) -> core::ffi::c_int {
>    // SAFETY: This is safe, since the C side guarantees that pdev is a valid,
>    // non-null pointer to a struct pci_dev with a non-zero reference count.
>    let dev = unsafe { device::Device::from_raw(&mut (*pdev).dev) };

Yes, that's fine, if you are calling this from a probe callback, but
again, the driver core has lots of functions in it :)

>    [...]
> }
> 
> > 
> > And why non-NULL?  Can't you check for that here?  Shouldn't you check
> > for that here?  Many driver core functions can handle a NULL pointer
> > just fine (i.e. get/put_device() can), why should Rust code assume that
> > a pointer passed to it from the C layer is going to have stricter rules
> > than the C layer can provide?
> 
> We could check for NULL here, but I think it'd be pointless. Even if the pointer
> is not NULL, it can still be an invalid one. There is no check we can do to
> guarantee safety, hence the function is and remains unsafe and has safety
> requirements instead that the caller must guarantee to fulfil.
> 
> Like in the example above, probe_callback() can give those guarantees instead.

Ok, if you say so, should we bookmark this thread for when this does
happen?  :)

What will the rust code do if it is passed in a NULL pointer?  Will it
crash like C code does?  Or something else?

thanks,

greg k-h

