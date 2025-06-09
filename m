Return-Path: <linux-pci+bounces-29217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EEDAD1CA9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 13:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE91F188DCD8
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CFD1F4192;
	Mon,  9 Jun 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgnwGBvE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7042A9D;
	Mon,  9 Jun 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749469631; cv=none; b=TRI5jhyaZyUMC6Qj669dgjSvYkdy5koFaHJJVIBtTn0AYjZxEDsfCffpbBBF6PfGileG08IETJ9peAs+ON06lxoeJOCb9JNaryA7/IZ/sbF4JYlueR92EF47hy2S0KN5UmLeOBNVwIMz47TEG8OVJmMTxN8GNBrNTbKaYjWuorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749469631; c=relaxed/simple;
	bh=buO5PB98t7ItquVg1z9ulKzig9nWCwyDK2VeW+eHhBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwdpet9l7enpc1o8OrbOaFXRlqSTTfd7ObQdhGM9+hEeyWnfIcho3RyimrtiMgOauPW/61ASr63A0iif3qyytchBmcQ3fdtUTuyYanCaJT21EiVCHXu8bV3NxTb/sYgIPAGquOqlqr6ODlZ0DX6lLTx/vIhrF+5zxRcDbSDrIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgnwGBvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00763C4CEEB;
	Mon,  9 Jun 2025 11:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749469629;
	bh=buO5PB98t7ItquVg1z9ulKzig9nWCwyDK2VeW+eHhBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgnwGBvEpG0AiZ5eLmLGmU8qfw7a8ViPqusbpmrHUA3lxthvOn7YDXul8VLRfdlCR
	 mCYaETqOchaq5Jvysz83johT75uPcKPFRnotj4CTGIWhXSIcCb3QXkq2ZP6oytRu/F
	 JSeiq790YJs91KfuLbKcJ2LUgIyriWjTdVcoj6+b9p2Ogxi7lIsASumdYk5MC6RqwY
	 mf3lxKYYzZuCjXOBK97c/Tq4dVgNL5aAdsDvmDwzV1drh7uORr7doOkcxlOMCDSEHh
	 azotAKksoGcsfuVolyhfWMZf8rutJzosm7+3nbzRW3aVAi29WQQhv7ceMyRE1jG5Cu
	 IdqfdwdBg4qVA==
Date: Mon, 9 Jun 2025 13:47:03 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Message-ID: <aEbJt0YSc3-60OBY@pollux>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com>

On Sun, Jun 08, 2025 at 07:51:08PM -0300, Daniel Almeida wrote:
> +/// // This is running in process context.
> +/// fn register_irq(handler: Handler, dev: &platform::Device<Bound>) -> Result<Arc<Registration<Handler>>> {
> +///     let registration = dev.irq_by_index(0, flags::SHARED, c_str!("my-device"), handler)?;
> +///
> +///     // You can have as many references to the registration as you want, so
> +///     // multiple parts of the driver can access it.
> +///     let registration = Arc::pin_init(registration, GFP_KERNEL)?;
> +///
> +///     // The handler may be called immediately after the function above
> +///     // returns, possibly in a different CPU.
> +///
> +///     {
> +///         // The data can be accessed from the process context too.
> +///         registration.handler().0.fetch_add(1, Ordering::Relaxed);
> +///     }

Why the extra scope?

> +///
> +///     Ok(registration)
> +/// }
> +///
> +/// # Ok::<(), Error>(())
> +///```
> +///
> +/// # Invariants
> +///
> +/// * We own an irq handler using `&self` as its private data.
> +///
> +#[pin_data]
> +pub struct Registration<T: Handler + 'static> {
> +    inner: Devres<RegistrationInner>,
> +
> +    #[pin]
> +    handler: T,
> +
> +    /// Pinned because we need address stability so that we can pass a pointer
> +    /// to the callback.
> +    #[pin]
> +    _pin: PhantomPinned,
> +}
> +
> +impl<T: Handler + 'static> Registration<T> {
> +    /// Registers the IRQ handler with the system for the given IRQ number.
> +    pub(crate) fn register<'a>(

I think we should call this Registration::new() instead. Except for
MiscDeviceRegistration, which is representing not *only* a registration, all
other Registration types just use new() and it'd be nice to be consistent.

> +        dev: &'a Device<Bound>,
> +        irq: u32,
> +        flags: Flags,
> +        name: &'static CStr,
> +        handler: T,
> +    ) -> impl PinInit<Self, Error> + 'a {
> +        let closure = move |slot: *mut Self| {
> +            // SAFETY: The slot passed to pin initializer is valid for writing.
> +            unsafe {
> +                slot.write(Self {
> +                    inner: Devres::new(
> +                        dev,
> +                        RegistrationInner {
> +                            irq,
> +                            cookie: slot.cast(),
> +                        },
> +                        GFP_KERNEL,
> +                    )?,
> +                    handler,
> +                    _pin: PhantomPinned,
> +                })
> +            };
> +
> +            // SAFETY:
> +            // - The callbacks are valid for use with request_irq.
> +            // - If this succeeds, the slot is guaranteed to be valid until the
> +            // destructor of Self runs, which will deregister the callbacks
> +            // before the memory location becomes invalid.
> +            let res = to_result(unsafe {
> +                bindings::request_irq(
> +                    irq,
> +                    Some(handle_irq_callback::<T>),
> +                    flags.into_inner() as usize,
> +                    name.as_char_ptr(),
> +                    slot.cast(),
> +                )
> +            });
> +
> +            if res.is_err() {
> +                // SAFETY: We are returning an error, so we can destroy the slot.
> +                unsafe { core::ptr::drop_in_place(&raw mut (*slot).handler) };
> +            }
> +
> +            res
> +        };
> +
> +        // SAFETY:
> +        // - if this returns Ok, then every field of `slot` is fully
> +        // initialized.
> +        // - if this returns an error, then the slot does not need to remain
> +        // valid.
> +        unsafe { pin_init_from_closure(closure) }

Can't we use try_pin_init!() instead, move request_irq() into the initializer of
RegistrationInner and initialize inner last?

> +    }
> +
> +    /// Returns a reference to the handler that was registered with the system.
> +    pub fn handler(&self) -> &T {
> +        &self.handler
> +    }
> +
> +    /// Wait for pending IRQ handlers on other CPUs.
> +    ///
> +    /// This will attempt to access the inner [`Devres`] container.
> +    pub fn try_synchronize(&self) -> Result {
> +        let inner = self.inner.try_access().ok_or(ENODEV)?;
> +        inner.synchronize();
> +        Ok(())
> +    }
> +
> +    /// Wait for pending IRQ handlers on other CPUs.
> +    pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
> +        let inner = self.inner.access(dev)?;
> +        inner.synchronize();
> +        Ok(())
> +    }
> +}
> +
> +/// # Safety
> +///
> +/// This function should be only used as the callback in `request_irq`.
> +unsafe extern "C" fn handle_irq_callback<T: Handler>(
> +    _irq: i32,
> +    ptr: *mut core::ffi::c_void,
> +) -> core::ffi::c_uint {
> +    // SAFETY: `ptr` is a pointer to Registration<T> set in `Registration::new`
> +    let data = unsafe { &*(ptr as *const Registration<T>) };
> +    T::handle_irq(&data.handler).into_inner()
> +}
> 
> -- 
> 2.49.0
> 

