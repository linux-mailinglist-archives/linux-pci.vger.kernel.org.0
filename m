Return-Path: <linux-pci+bounces-7690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CC98CA336
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 22:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B346C282DC6
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 20:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F31139580;
	Mon, 20 May 2024 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBEryTdn"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532561386D2
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236552; cv=none; b=QMlyNJhpyWjf2vNGjr4jZIj3rPlwmujS6joC3/ilzcfhpS8DpizrrDAMUr6QnMJfMclAyJVub4OQGSRhjg/0pzVXZydfOfOVMMqZ84nqIbAC6vpihgu025jkMGJ2pnLntJUsshlmzP3ustwgNkjHEPPpEpLN3fww9i5fTomjqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236552; c=relaxed/simple;
	bh=h82oms+S4ZqhezICJF1lVrBXzTaNsQqctTiKigj0+xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOj5KD61oFP6tACR7xu748q/kpYyQs/+372oGkwiVp7zivUYTLieU7DWP8spu/R6ddpHsR31RvWhivFQY6E9htpBRcExA7HVkZikEgaHRGCW2dRfj4s9KaJ6CavvBK5VXwd71yZ9n1vNAEP6rlELHInhQUHN6nxLOrsA9OYf2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBEryTdn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716236550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6RnZUBoxUD6NzsSDJ/u34264/igGKdQsISSA8Ua+dg=;
	b=fBEryTdnqVnwu4SlL6Hbj3I1a8bNukk1n8T/gI7JmEL70a+rRT5oOf4HWmDt7sgJmFnsXh
	p4nxMwpmJfBHbdGLImSKIEnJKt2hroQN+lSJQ0mbOIG35d6qoF0dWKBq7BgCoboWOrxiTq
	+2IO6VFcgnG3RbJ41zKfJQmRpUj4/oQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-_M1xkrNbO7i1EQXcO8RxXA-1; Mon, 20 May 2024 16:22:27 -0400
X-MC-Unique: _M1xkrNbO7i1EQXcO8RxXA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34c93732095so6092844f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 13:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716236546; x=1716841346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6RnZUBoxUD6NzsSDJ/u34264/igGKdQsISSA8Ua+dg=;
        b=K48gRg269o9D2vA61IXnjykMc7BmWMtxwD64Y0sofZ5Oqnygm3UmDGRVExjyDTwFQW
         PxRJuaKPkcUukNzv/L4kdVCboBDmP5nZcyp1najRSWYtSdbGQ+RASpkD37iVS5jycXTA
         yx31PhWX1u9Juc/zVvlQDGhzQ/nkpTuhBEzWxtw3WNVBSQBRCuQnn1jmAhxSN/vqYAiQ
         2Cc38Re/0BdA0rj5dh0nWBb4slYyUX/r/sbDMWhQCfy0tUFVlD/d7PG6fXcbCh/nSls3
         EmDdk4oxyWXPyffm3AtIgDUt5KR2R86lsVEL75W3HUiBH/hHCrwwib78YG0R0zmIrr8T
         NQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCV7R0tTSD/P2XaxE1DHMMWJs3UPWZpH8LOk4GPjdEOjZkH4e1tdduYdTjqqBSPUuJQW6rB1ZM057Fm7s9ZWsic+3+gytvw7bog3
X-Gm-Message-State: AOJu0YxdY4yu11+gfK1bEZ5Wc5cgviLaieacf9/m3UVHgm42LQQeXGxx
	hJ/mqZEvS/wDxVQuZGQcwErcrvQfsmxHstJD73fZdSyfbdtqANQn4Dsuic/Q+t5z/PrfVTL1M+6
	OW0mwnugcZv/H+iyNau+hYtXUWp4gkHyEmbdorccq8FrSKzSkLGmICeAbvA==
X-Received: by 2002:a05:600c:3b0a:b0:418:f760:abfb with SMTP id 5b1f17b1804b1-41feaa2f33dmr254811365e9.5.1716236545794;
        Mon, 20 May 2024 13:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiBX7TF3VYI458zR+snYs8gVOilufr0L2BENKNJZOWNwGABF0bKrNr94hKWY7DBWstk87Kvw==
X-Received: by 2002:a05:600c:3b0a:b0:418:f760:abfb with SMTP id 5b1f17b1804b1-41feaa2f33dmr254811035e9.5.1716236545357;
        Mon, 20 May 2024 13:22:25 -0700 (PDT)
Received: from pollux.localdomain ([2a02:810d:4b3f:ee94:acb0:ae3f:f045:1823])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420111f2decsm349165465e9.22.2024.05.20.13.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:22:24 -0700 (PDT)
Date: Mon, 20 May 2024 22:22:22 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] rust: add abstraction for struct device
Message-ID: <Zkuw/nOlpAe1OesV@pollux.localdomain>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-2-dakr@redhat.com>
 <2024052038-deviancy-criteria-e4fe@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024052038-deviancy-criteria-e4fe@gregkh>

On Mon, May 20, 2024 at 08:00:23PM +0200, Greg KH wrote:
> On Mon, May 20, 2024 at 07:25:38PM +0200, Danilo Krummrich wrote:
> > Add an (always) reference counted abstraction for a generic struct
> > device. This abstraction encapsulates existing struct device instances
> > and manages its reference count.
> > 
> > Subsystems may use this abstraction as a base to abstract subsystem
> > specific device instances based on a generic struct device.
> > 
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  rust/helpers.c        |  1 +
> >  rust/kernel/device.rs | 76 +++++++++++++++++++++++++++++++++++++++++++
> 
> What's the status of moving .rs files next to their respective .c files
> in the build system?  Keeping them separate like this just isn't going
> to work, sorry.
> 
> > --- /dev/null
> > +++ b/rust/kernel/device.rs
> > @@ -0,0 +1,76 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Generic devices that are part of the kernel's driver model.
> > +//!
> > +//! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
> 
> relative paths for a common "include <linux/device.h" type of thing?
> Rust can't handle include paths from directories?

Going to change this to `srctree/` as proposed by Miguel.

> 
> > +
> > +use crate::{
> > +    bindings,
> > +    types::{ARef, Opaque},
> > +};
> > +use core::ptr;
> > +
> > +/// A ref-counted device.
> > +///
> > +/// # Invariants
> > +///
> > +/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
> > +/// particular, the ARef instance owns an increment on underlying object’s reference count.
> > +#[repr(transparent)]
> > +pub struct Device(Opaque<bindings::device>);
> > +
> > +impl Device {
> > +    /// Creates a new ref-counted instance of an existing device pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
> 
> Callers NEVER care about the reference count of a struct device, anyone
> poking in that is asking for trouble.

That's confusing, if not the caller who's passing the device pointer somewhere,
who else?

Who takes care that a device' reference count is non-zero when a driver's probe
function is called?

It's the same here. The PCI code calls Device::from_raw() from its
probe_callback() function, which is called from the C side. For instance:

extern "C" fn probe_callback(
   pdev: *mut bindings::pci_dev,
   id: *const bindings::pci_device_id,
) -> core::ffi::c_int {
   // SAFETY: This is safe, since the C side guarantees that pdev is a valid,
   // non-null pointer to a struct pci_dev with a non-zero reference count.
   let dev = unsafe { device::Device::from_raw(&mut (*pdev).dev) };

   [...]
}

> 
> And why non-NULL?  Can't you check for that here?  Shouldn't you check
> for that here?  Many driver core functions can handle a NULL pointer
> just fine (i.e. get/put_device() can), why should Rust code assume that
> a pointer passed to it from the C layer is going to have stricter rules
> than the C layer can provide?

We could check for NULL here, but I think it'd be pointless. Even if the pointer
is not NULL, it can still be an invalid one. There is no check we can do to
guarantee safety, hence the function is and remains unsafe and has safety
requirements instead that the caller must guarantee to fulfil.

Like in the example above, probe_callback() can give those guarantees instead.

> 
> > +    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> > +        // SAFETY: By the safety requirements, ptr is valid.
> > +        // Initially increase the reference count by one to compensate for the final decrement once
> > +        // this newly created `ARef<Device>` instance is dropped.
> > +        unsafe { bindings::get_device(ptr) };
> > +
> > +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::device`.
> > +        let ptr = ptr.cast::<Self>();
> > +
> > +        // SAFETY: By the safety requirements, ptr is valid.
> > +        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
> > +    }
> > +
> > +    /// Obtain the raw `struct device *`.
> > +    pub(crate) fn as_raw(&self) -> *mut bindings::device {
> > +        self.0.get()
> > +    }
> > +
> > +    /// Convert a raw `struct device` pointer to a `&Device`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count for
> > +    /// the entire duration when the returned reference exists.
> 

This is the doc comment of pub unsafe fn as_ref<'a>(ptr: *mut bindings::device)
-> &'a Self. Let's keep this context, it's confusing for other readers
otherwise.

> Again, non-NULL might not be true, and reference counts are never

Like above, it's just the safety precondition. Checking for NULL does not
improve the situation, we still need to rely on the pointer being a valid one.

> tracked by any user EXCEPT to increment/decrement it, you never know if

That's the whole point, if one takes an increment on the reference count they
can guarantee it's non-zero.

> it is 0 or not, all you know is that if a pointer is given to you by the
> driver core to a 'struct device' for a function that it is a valid
> reference at that point in time, or maybe NULL, until your function
> returns.  Anything after that can not be counted on.

That's not contradictive to those safety comments. When Device::from_raw()
returns it has increased the reference count of the device by one. And when
Device::as_ref() returns the returned reference' lifetime is bound to the
lifetime of the pointer passed to it.

> 
> thanks,
> 
> greg k-h
> 


