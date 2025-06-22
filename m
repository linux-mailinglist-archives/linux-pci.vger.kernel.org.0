Return-Path: <linux-pci+bounces-30327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C652AE323B
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 23:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E68A16F57C
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 21:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1588C190679;
	Sun, 22 Jun 2025 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T57gGK94"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F162EAE5;
	Sun, 22 Jun 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626581; cv=none; b=tuQ15y88zLO4QLA9KFl82AgbcsA7Q6jaywdRlMl4JJ54Q/gS/FPq5GJobYfJtqGp+nOyAeQBjL30amLrjpXvBR8jNXfi2LNtiIhk8nP5Z0RrsT2lOjhEjFSBMhwJgrlMg9egQYukyXI51TwyPO6fxKE65uXTOjO6mq/25+nSR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626581; c=relaxed/simple;
	bh=VU50fIJz5j/p3NRq2ZTbVf/o2bg6Np4BV9khuwB3pjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVLBPXue9Gwawk/OJy6yZILH5bKpjE/1NfuC3JMke9SVNeUf9usfk1U/GjwTIVtlJNP3OLmMcgrGWTYqIUZbzryokvCP8NQXF8jle2xyk8aDNDjvL4+gDkLfyDD40LPbkubB4PCEYOO5JVO4Zh98s3Q41blCWE1ANTA1lU8Uhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T57gGK94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E2CC4CEE3;
	Sun, 22 Jun 2025 21:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750626580;
	bh=VU50fIJz5j/p3NRq2ZTbVf/o2bg6Np4BV9khuwB3pjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T57gGK94lNq6JjwOZrbuQZoRWjCfCYc6iO9Ri+sDRRUe9j28VT4hd2Hv3Y9e44pD3
	 Y6dfI6ucJr5xEPHdcDCe4Ww6pzJymbCsB75ZQ3LXL9bNV4STPyJiFCya1dn4XhanhE
	 vOHcycu8dlKVwjv42hZQ+4/7HNgtnYTFzOJLoF8REipFAVAdrxaUL8OY/AgDpVtg1c
	 xYUvSDZYXbkbJjEnWSAy3+BAb7HyWD2k/QJOKZ+kLgg+RrWoL7q/d7eIV3kR6gCRjR
	 26CMN2GRcLYbd2GVCggL29upRGqFzjDy4WAbtMTtYoHIaxEF2ng7zSvSgb8OhBRgfP
	 k6ZcROizMlULA==
Date: Sun, 22 Jun 2025 23:09:33 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: devres: get rid of Devres' inner Arc
Message-ID: <aFhxDascMUg3KzZc@pollux>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-4-dakr@kernel.org>
 <DATCT1EG0Z70.3ON7LFZEEZ93M@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DATCT1EG0Z70.3ON7LFZEEZ93M@kernel.org>

On Sun, Jun 22, 2025 at 10:45:02PM +0200, Benno Lossin wrote:
> On Sun Jun 22, 2025 at 6:40 PM CEST, Danilo Krummrich wrote:
> > +impl<T> Inner<T> {
> > +    fn as_ptr(&self) -> *const Self {
> > +        self
> > +    }
> > +}
> 
> Instead of creating this function, you can use `ptr::from_ref`.

Yeah, I like this much better.

> > +impl<T> Devres<T> {
> > +    /// Creates a new [`Devres`] instance of the given `data`.
> > +    ///
> > +    /// The `data` encapsulated within the returned `Devres` instance' `data` will be
> > +    /// (revoked)[`Revocable`] once the device is detached.
> > +    pub fn new<'a, E>(
> > +        dev: &'a Device<Bound>,
> > +        data: impl PinInit<T, E> + 'a,
> > +    ) -> impl PinInit<Self, Error> + 'a
> > +    where
> > +        T: 'a,
> > +        Error: From<E>,
> > +    {
> > +        let callback = Self::devres_callback;
> > +
> > +        try_pin_init!(&this in Self {
> > +            inner <- Opaque::pin_init(try_pin_init!(Inner {
> >                  data <- Revocable::new(data),
> > +                devm <- Completion::new(),
> >                  revoke <- Completion::new(),
> > -            }),
> > -            flags,
> > -        )?;
> > -
> > -        // Convert `Arc<DevresInner>` into a raw pointer and make devres own this reference until
> > -        // `Self::devres_callback` is called.
> > -        let data = inner.clone().into_raw();
> > +            })),
> > +            callback,
> > +            dev: {
> > +                // SAFETY: It is valid to dereference `this` to find the address of `inner`.
> 
>     // SAFETY: `this` is a valid pointer to uninitialized memory.
> 
> > +                let inner = unsafe { core::ptr::addr_of_mut!((*this.as_ptr()).inner) };
> 
> We can use `raw` instead of `addr_of_mut!`:
> 
>     let inner = unsafe { &raw mut (*this.as_ptr()).inner };

Indeed, forgot we finally have raw_ref_op since v6.15. :)

> >  
> > -        // SAFETY: `devm_add_action` guarantees to call `Self::devres_callback` once `dev` is
> > -        // detached.
> > -        let ret =
> > -            unsafe { bindings::devm_add_action(dev.as_raw(), Some(inner.callback), data as _) };
> > -
> > -        if ret != 0 {
> > -            // SAFETY: We just created another reference to `inner` in order to pass it to
> > -            // `bindings::devm_add_action`. If `bindings::devm_add_action` fails, we have to drop
> > -            // this reference accordingly.
> > -            let _ = unsafe { Arc::from_raw(data) };
> > -            return Err(Error::from_errno(ret));
> > -        }
> > +                // SAFETY:
> > +                // - `dev.as_raw()` is a pointer to a valid bound device.
> > +                // - `inner` is guaranteed to be a valid for the duration of the lifetime of `Self`.
> > +                // - `devm_add_action()` is guaranteed not to call `callback` until `this` has been
> > +                //    properly initialized, because we require `dev` (i.e. the *bound* device) to
> > +                //    live at least as long as the returned `impl PinInit<Self, Error>`.
> 
> Just wanted to highlight that this is a very cool application of the
> borrow checker :)

It is indeed -- I really like this one!

> > +                to_result(unsafe {
> > +                    bindings::devm_add_action(dev.as_raw(), Some(callback), inner.cast())
> > +                })?;
> >  
> > -        Ok(inner)
> > +                dev.into()
> > +            },
> > +        })
> >      }
> >  
> > -    fn as_ptr(&self) -> *const Self {
> > -        self as _
> > +    fn inner(&self) -> &Inner<T> {
> > +        // SAFETY: `inner` is valid and properly initialized.
> 
> We should have an invariant here that `inner` is always accessed
> read-only and that it is initialized.

Makes sense, gonna add it.

