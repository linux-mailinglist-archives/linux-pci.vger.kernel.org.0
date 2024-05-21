Return-Path: <linux-pci+bounces-7728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 857FD8CB4CA
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 22:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24071F22C2A
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F7114883E;
	Tue, 21 May 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNFkVW6G"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945C1487D4
	for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324133; cv=none; b=ZhRdszE6fSfMP2Mv5dUSNph44IwQuDv56ZCapz0wK5D1lTpZXB9/D1eTpT0fGkRjeSzUNZQvCdI0Hp1oJHOcVf6/NRDcfis/aMxoqmgjd871bAquMEEaggWHXAbdCoF2b2QJt4plpFPagYYvmQUfaEPHAkyuOnto20XuJO+JpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324133; c=relaxed/simple;
	bh=DeVryntqW6T9gzJ3NkQ54JUgALeUyNz/fkIreO4nDrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5tjf0hZ1ibNpx9iqrZDpbTV8GrUx9tzItcJt4woPE0kubViVd5F3oTI/bLxwMJ8D2cJVEoV2aT7e2xJWhtwlepXsGKar69JNvfCOwaxOxG7HDaFoCQOHrhsTBcaBy+T3EZnfYcEH/Dfae2kqEahcob/XKHUVCb8n0Iqqv1AXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNFkVW6G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716324130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GyEo75ShgkctdoTB9XVFsNNvhww6FBPThPwlmflGWzU=;
	b=eNFkVW6GQvHPNN+S7aGzXJOQSZAUr51FGMX6H70WDZUrtihTUmADS3mleJXkIVeuNwYE0r
	sUcq7MXmXyb4ZLJnlBeml1XfXp+Qj3WqD3tXjX9hN7FTklJalWjyq3q4zPCqgyTzcOrwmg
	u+rZHQvjvopfCgSDTvKTO44xAoJsUTk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-6QWGppyaPmOJjuh_MDSahg-1; Tue, 21 May 2024 16:42:08 -0400
X-MC-Unique: 6QWGppyaPmOJjuh_MDSahg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42024ca94d0so41214865e9.1
        for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 13:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324127; x=1716928927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyEo75ShgkctdoTB9XVFsNNvhww6FBPThPwlmflGWzU=;
        b=h3iN31ymZIMC8xkF6NOAkjiP4B5MmbxApbZZRBhHE9Pv4tNF7zQB78oqWsUlJOFMg6
         xN49WG7TnG2sQ4yb2KyYMU3wbPn0wn3x3trtIKCKY6TW+U8YcOo+YIpolx+3YTSTr2Oh
         ugBGK3Xrebrymy4yyJ5DJlQOEbTLapfFQFcRyC4BS0CBku4ittclPisEN5Vwdemo3Wy3
         ReoGU6AthQDHAp9FPvPbNCeY607LLmU6+Nr/Wj4Ilnc3Sqz4BG6AX0Tv4ksfVTVa9j1C
         wVczh2hLJ/JYWPnSQSSfnKl+kKn87scy+1E1Tyyze5qg9O5SLvIM4lIEs9386z5lhW/8
         RulA==
X-Forwarded-Encrypted: i=1; AJvYcCVuuRtb1ECqr1aOq3/m81+HWBdaHCOb0UzWJ+hPfovRCZk4DjSvGfexLLKsA8MeCZ9uCSVGqUetfuEDeYDjydnqedOR9ea0M76/
X-Gm-Message-State: AOJu0Yzvn0Rvjps5B5PGsSdcRL/9ab2lcoRp4VJ+4Aas7v9IXcYpuP1t
	URu3cK+Sk7Y9h7W4pUOtZdRjilR6CIqQR679FcU/WxIwd04OyY+yrp9baFcKiR5J33gwyBax8bV
	yP/Zo0GYUaz8XREBGXeI0IJe11bohBWJ8u4i3b+wfIw2GGwGM+iGPoYCkdw==
X-Received: by 2002:a05:600c:2211:b0:420:1592:da3f with SMTP id 5b1f17b1804b1-420fd3136dcmr85905e9.11.1716324127640;
        Tue, 21 May 2024 13:42:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnUJVaYVtACB++fi5RssmcOEjMUtrwFF1XJNUHwn8eHCCHFpci+u9toh2LA44i0R8lQkT4UA==
X-Received: by 2002:a05:600c:2211:b0:420:1592:da3f with SMTP id 5b1f17b1804b1-420fd3136dcmr85425e9.11.1716324126890;
        Tue, 21 May 2024 13:42:06 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420193b0903sm335271625e9.47.2024.05.21.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 13:42:05 -0700 (PDT)
Date: Tue, 21 May 2024 22:42:03 +0200
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
Message-ID: <Zk0HG5Ot-_e0o89p@pollux>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-2-dakr@redhat.com>
 <2024052038-deviancy-criteria-e4fe@gregkh>
 <Zkuw/nOlpAe1OesV@pollux.localdomain>
 <2024052144-alibi-mourner-d463@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024052144-alibi-mourner-d463@gregkh>

On Tue, May 21, 2024 at 11:24:38AM +0200, Greg KH wrote:
> On Mon, May 20, 2024 at 10:22:22PM +0200, Danilo Krummrich wrote:
> > On Mon, May 20, 2024 at 08:00:23PM +0200, Greg KH wrote:
> > > On Mon, May 20, 2024 at 07:25:38PM +0200, Danilo Krummrich wrote:
> > > > Add an (always) reference counted abstraction for a generic struct
> > > > device. This abstraction encapsulates existing struct device instances
> > > > and manages its reference count.
> > > > 
> > > > Subsystems may use this abstraction as a base to abstract subsystem
> > > > specific device instances based on a generic struct device.
> > > > 
> > > > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > > ---
> > > >  rust/helpers.c        |  1 +
> > > >  rust/kernel/device.rs | 76 +++++++++++++++++++++++++++++++++++++++++++
> > > 
> > > What's the status of moving .rs files next to their respective .c files
> > > in the build system?  Keeping them separate like this just isn't going
> > > to work, sorry.
> > > 
> > > > --- /dev/null
> > > > +++ b/rust/kernel/device.rs
> > > > @@ -0,0 +1,76 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +//! Generic devices that are part of the kernel's driver model.
> > > > +//!
> > > > +//! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
> > > 
> > > relative paths for a common "include <linux/device.h" type of thing?
> > > Rust can't handle include paths from directories?
> > 
> > Going to change this to `srctree/` as proposed by Miguel.
> > 
> > > 
> > > > +
> > > > +use crate::{
> > > > +    bindings,
> > > > +    types::{ARef, Opaque},
> > > > +};
> > > > +use core::ptr;
> > > > +
> > > > +/// A ref-counted device.
> > > > +///
> > > > +/// # Invariants
> > > > +///
> > > > +/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
> > > > +/// particular, the ARef instance owns an increment on underlying object’s reference count.
> > > > +#[repr(transparent)]
> > > > +pub struct Device(Opaque<bindings::device>);
> > > > +
> > > > +impl Device {
> > > > +    /// Creates a new ref-counted instance of an existing device pointer.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
> > > 
> > > Callers NEVER care about the reference count of a struct device, anyone
> > > poking in that is asking for trouble.
> > 
> > That's confusing, if not the caller who's passing the device pointer somewhere,
> > who else?
> > 
> > Who takes care that a device' reference count is non-zero when a driver's probe
> > function is called?
> 
> A device's reference count will be non-zero, I'm saying that sometimes,
> some driver core functions are called with a 'struct device' that is
> NULL, and it can handle it just fine.  Hopefully no callbacks to the
> rust code will happen that way, but why aren't you checking just "to be
> sure!" otherwise you could have a bug here, and it costs nothing to
> verify it, right?

I get your point on that one. But let me explain a bit more why I think that
check is not overly helpful here.

In Rust we have the concept of marking functions as 'unsafe'. Unsafe functions
need to document their safety preconsitions, i.e. the conditions the caller of
the function must guarantee. The caller of an unsafe function needs an unsafe
block for it to compile and every unsafe block needs an explanation why it is
safe to call this function with the corresponding arguments.

(Ideally, we want to avoid having them in the first place, but for C abstractions
we have to deal with raw pointers we receive from the C side and dereferencing a
raw pointer is unsafe by definition.)

In this case we have a function that constructs the Rust `Device` structure from
a raw (device) pointer we potentially received from the C side. Now we have to
decide whether this function is going to be unsafe or safe.

In order for this function to be safe we would need to be able to guarantee that
this is a valid, non-null pointer with a non-zero reference count, which
unfortunately we can't. Hence, it's going to be an unsafe function.

A NULL pointer check would not make it a safe function either, since the pointer
could still be an invalid one, or a pointer to a device it's not guaranteed that
the reference count is held up for the duration of the function call.

Given that, we could add the NULL check and change the safety precondition to
"valid pointer to a device with non-zero reference count OR NULL", but I don't
see how this improves the situation for the caller, plus we'd need to return
`Result<Device>` instead and let the caller handle that the `Device` was not
created.

> 
> > It's the same here. The PCI code calls Device::from_raw() from its
> > probe_callback() function, which is called from the C side. For instance:
> > 
> > extern "C" fn probe_callback(
> >    pdev: *mut bindings::pci_dev,
> >    id: *const bindings::pci_device_id,
> > ) -> core::ffi::c_int {
> >    // SAFETY: This is safe, since the C side guarantees that pdev is a valid,
> >    // non-null pointer to a struct pci_dev with a non-zero reference count.
> >    let dev = unsafe { device::Device::from_raw(&mut (*pdev).dev) };
> 
> Yes, that's fine, if you are calling this from a probe callback, but
> again, the driver core has lots of functions in it :)

See explanation above.

> 
> >    [...]
> > }
> > 
> > > 
> > > And why non-NULL?  Can't you check for that here?  Shouldn't you check
> > > for that here?  Many driver core functions can handle a NULL pointer
> > > just fine (i.e. get/put_device() can), why should Rust code assume that
> > > a pointer passed to it from the C layer is going to have stricter rules
> > > than the C layer can provide?
> > 
> > We could check for NULL here, but I think it'd be pointless. Even if the pointer
> > is not NULL, it can still be an invalid one. There is no check we can do to
> > guarantee safety, hence the function is and remains unsafe and has safety
> > requirements instead that the caller must guarantee to fulfil.
> > 
> > Like in the example above, probe_callback() can give those guarantees instead.
> 
> Ok, if you say so, should we bookmark this thread for when this does
> happen?  :)

I'm just saying the caller has to validate that or provide a rationale why this
is safe anyways, hence it'd be just a duplicate check.

> 
> What will the rust code do if it is passed in a NULL pointer?  Will it
> crash like C code does?  Or something else?

It mostly calls into C functions with this pointer, depends on what they do.

Checking a few random places, e.g. [1], it seems to crash in most cases.

[1] https://elixir.free-electrons.com/linux/latest/source/drivers/base/core.c#L3863

> 
> thanks,
> 
> greg k-h
> 


