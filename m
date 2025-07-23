Return-Path: <linux-pci+bounces-32779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB06B0E996
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 06:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3056562CB0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 04:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA9188CC9;
	Wed, 23 Jul 2025 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlqDtr9w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F462AE72;
	Wed, 23 Jul 2025 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245167; cv=none; b=k29qCIYaPBjS6JIZYH4AAXAw+AGKkiW6N8ov/ALu4ZHZXlo/5lB1Gzk1RoH74pu+UlYbNtOJ4klrspoA/LKomYhesumjQSl6Bf03OAKBKpEu78AsAMV+dD9JEOw3d/KmyDIi6QuYrbisDHZEyXhYcFBJlphEC8ysaHJUKkaUcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245167; c=relaxed/simple;
	bh=4ZRl4YU3pJ6bUAAVBCb6nh/Podn/keXReS0/x6i8/C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuCveZ0ZmvqyDaXJjQ/8fuwgFTTxlTUbCVBzV5zDPjqdPjsCS3Vw+sSA+esMyV32UbXRCCOH9tDBKmVuXfKxtFBUzHhCQjVURdh1vHLON1qManxPW2lCrOazLiHByE0WXffqY/1kgMZkRsIFVZDITHTmsMBRRzC/u3ziQeiPQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlqDtr9w; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4abd3627e7eso44579101cf.0;
        Tue, 22 Jul 2025 21:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753245164; x=1753849964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qu86ci4s4LMiG2GGQOdBaBtL5gMWKnNyMbxfsXlXuq0=;
        b=QlqDtr9wW9VYikqHFZzkCdtXP/E0mR6Fe6jx9qHji+XWcvZqPB5EQZbN+qJ8cW39qJ
         oSKQKDyF7qeW9Xfswn7RTjwtDdmFNhjfMqCN3r7JTIqa+awwj9azhT5vrW/PVgMQLeSd
         8aIZskzyIUnbXDwwuw2jkxa1i894jsyRsxBYyUPHO+sihyfY8kOVysWJwSQ4+biGA8LX
         Kj6SUIMjRy7aE9Wxou8Moq/7wVcEeURYaNcY12MejDFqyFJEX5cZBelAT+m8pRlDKYLl
         0L6Frx76xBgDPm2bTWBdrkI8GK2aGH0MabEOcMtJz7m52WO3nqvPwPwTMxmHYRe4vP+K
         ErPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753245164; x=1753849964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qu86ci4s4LMiG2GGQOdBaBtL5gMWKnNyMbxfsXlXuq0=;
        b=ZUkvfpHTNaiwtyche3S2S3Qd8PnTObRR4Iwcs2PgxLGtlBauQ3g0wfLknRl+spnEfm
         AgKDyDQ5yMXqjsFDQodKPUyUTc4l5hvH7Ei4o2LeqB4xqdf6hHTva25jBaLrmbriGiDA
         fqI+SnjJJn+KSr1GeaYaNUOJv43129v3q9RmSQ/PK7jKGPYEdOoAHjhM5Y/Uuzf4xmvT
         5rECotx73euF4HDNoV5lCNJMEMwNIAWai5HcjI4eW93R5m8hvCQKL/iCCDXjcYq/35qz
         JEelaNhLef1piAVbCvo2VrcWqB8S9FT7u22gUgSx6oSNu4GKBx9MIfJ5VqyX2sxl/N8B
         nBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7yYxps/OoSxhoRwYLSjmCkcL4JfeDvgDMOlW+BoAJSSg6UTuaPTHovxBFA6r/CPxsMC3R0zDIEz7l@vger.kernel.org, AJvYcCVHC0MuFyLgS3bYBdyc3R1DE5TRpdyqe5MkCu8sunpCZvzLWcoF1snzK7cFnCag3MYlcfzsCrzvugj/i7E=@vger.kernel.org, AJvYcCW520JSWPaWgeI4ZYIBO8zNCl5CljKqaeVLKWVXdvrN40uM+szWK6QFTqOTRZu7cCzQDTJeD/bgRJ+zJqGDU3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6o2YcgLMNhy8r00EX97m/PAkvEAzF0uuXMrcLstF6SjbgUXyI
	Frk6Bx/iPrpzOWEPtA7ZMGB1nw3Pd+2U3WV/+wBB1YWYuPNPdqIf4Kfp
X-Gm-Gg: ASbGncuqZNinVL4pGobYDh6LS0u8KsMUv4b4Q2iScQuS5VKh8IZGP43RPJwuXDUmyBv
	d0n/rhEKYD1aAYjcJWTvq1GlG/CbKGCbSTi3ZIrh5LOYDPF9Uu4oHJkE3jjst6NfbmgPHi+PWHL
	wZWwsGdSbpfvaC3ylzuaK7eKp2FPoKjK1qMtg6+wWH4DYYTn/fUd6tp8PBZGEVAIk/sQCyihNLK
	/XxrCZnCyJGr7pNzVIFM3cG3+B8cL3Jjyt+9AUklhf0Jq2xZSi7+xJOeCK3LmiyFoVznzPbpErB
	ELiXB7nduJg9pZukxW0+7PQiaykoeXVzdDx6jqOnUq9usqkNJWwxg3mAgTFyVdwXBCerdHkhM/T
	jOsvTSV+WYbZ/odYlyhxPnSC3SUMttdQPxTnDkkflqdHv8mC0qaX5cWDnWjxBJVJnw18eiRd+Vx
	7RKOeVhi6b8Z1ljyKp/SLTagrz3Wk8k/BaAA==
X-Google-Smtp-Source: AGHT+IF/TXny8grskWsjvR/3gy4+AmP6oR3BzCHYaXqEDnkzzCnPuqhS4QS0ZMCA/c/nCIGf+RYyYA==
X-Received: by 2002:ac8:7c48:0:b0:4ab:6964:7845 with SMTP id d75a77b69052e-4ae6dfda90dmr20423801cf.51.1753245164064;
        Tue, 22 Jul 2025 21:32:44 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4981ec5sm61121581cf.11.2025.07.22.21.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 21:32:43 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id F2A16F40066;
	Wed, 23 Jul 2025 00:32:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 23 Jul 2025 00:32:43 -0400
X-ME-Sender: <xms:6mWAaFcsSHGQwocmNXfnyZH9QlhNTohJUHpa8L9Dgtws3sReIOtKvQ>
    <xme:6mWAaJwUa3tr3emQkrivz0kbIPwOrm9l-FQo-bOPso_jlvbCpcSpcw_BWWg3EVVKd
    jv9davXrHvE9v_Uyg>
X-ME-Received: <xmr:6mWAaANMzx0JomjN7pUVhg20fXoo0E8aMmMoPot5O9j0tfHvtNIwYFacbPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeevueffieeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegurghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprh
    gtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidr
    ghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguh
    hordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhg
    rhhoshhssehumhhitghhrdgvughupdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:6mWAaIZhQU5i-ZWBqZGISMRHLq_LAQOnrIKwCP5jCONnL0Cs9jQucw>
    <xmx:6mWAaCois0_92RPTslMZ79NftX6nFVY9VDo5vyJDul0UhqLQ3kvxeQ>
    <xmx:6mWAaFw8DuUaqcYcCAnM5jKAGoywn8FPJSe0ZD69EMZJo4RTC1QO4Q>
    <xmx:6mWAaKIy7Doy8vUGQrFossCbfh3wao2vrln9ijPT4MLzjKQTHdeJYA>
    <xmx:6mWAaH5js6iZPfCa8IBanuryqxLq4Rw1jHxgMAmx5DXsMfneZIfViCJ8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 00:32:42 -0400 (EDT)
Date: Tue, 22 Jul 2025 21:32:40 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Message-ID: <aIBl6JPh4MQq-0gu@tardis-2.local>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>

On Tue, Jul 15, 2025 at 12:16:40PM -0300, Daniel Almeida wrote:
> This patch adds support for non-threaded IRQs and handlers through
> irq::Registration and the irq::Handler trait.
> 
> Registering an irq is dependent upon having a IrqRequest that was
> previously allocated by a given device. This will be introduced in
> subsequent patches.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
[...]
> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> index 9abd9a6dc36f3e3ecc1f92ad7b0040176b56a079..01bd08884b72c2a3a9460897bce751c732a19794 100644
> --- a/rust/kernel/irq.rs
> +++ b/rust/kernel/irq.rs
> @@ -12,3 +12,8 @@
>  
>  /// Flags to be used when registering IRQ handlers.
>  pub mod flags;
> +
> +/// IRQ allocation and handling.
> +pub mod request;
> +
> +pub use request::{Handler, IrqRequest, IrqReturn, Registration};

I woulde use #[doc(inline)] here for these re-export. It'll give a list
of struct/trait users can use in the `irq` module.

[...]
> +
> +/// A request for an IRQ line for a given device.
> +///
> +/// # Invariants
> +///
> +/// - `ìrq` is the number of an interrupt source of `dev`.
> +/// - `irq` has not been registered yet.
> +pub struct IrqRequest<'a> {
> +    dev: &'a Device<Bound>,
> +    irq: u32,
> +}
> +
> +impl<'a> IrqRequest<'a> {
> +    /// Creates a new IRQ request for the given device and IRQ number.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `irq` should be a valid IRQ number for `dev`.
> +    pub(crate) unsafe fn new(dev: &'a Device<Bound>, irq: u32) -> Self {

Missing "// INVARIANT" comment here.

> +        IrqRequest { dev, irq }
> +    }
> +
> +    /// Returns the IRQ number of an [`IrqRequest`].
> +    pub fn irq(&self) -> u32 {
> +        self.irq
> +    }
> +}
> +
> +/// A registration of an IRQ handler for a given IRQ line.
> +///
> +/// # Examples
> +///
> +/// The following is an example of using `Registration`. It uses a
> +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior mutability.

We are going to remove all usage of core::sync::Atomic* when the LKMM
atomics [1] land. You can probably use `Completion` here (handler does
complete_all(), and registration uses wait_for_completion()) because
`Completion` is irq-safe. And this brings my next comment..

> +///
> +/// ```
> +/// use core::sync::atomic::AtomicU32;
> +/// use core::sync::atomic::Ordering;
> +///
> +/// use kernel::prelude::*;
> +/// use kernel::device::Bound;
> +/// use kernel::irq::flags;
> +/// use kernel::irq::Registration;
> +/// use kernel::irq::IrqRequest;
> +/// use kernel::irq::IrqReturn;
> +/// use kernel::sync::Arc;
> +/// use kernel::c_str;
> +/// use kernel::alloc::flags::GFP_KERNEL;
> +///
> +/// // Declare a struct that will be passed in when the interrupt fires. The u32
> +/// // merely serves as an example of some internal data.
> +/// struct Data(AtomicU32);
> +///
> +/// // [`kernel::irq::request::Handler::handle`] takes `&self`. This example
> +/// // illustrates how interior mutability can be used when sharing the data
> +/// // between process context and IRQ context.
> +///
> +/// type Handler = Data;
> +///
> +/// impl kernel::irq::request::Handler for Handler {
> +///     // This is executing in IRQ context in some CPU. Other CPUs can still
> +///     // try to access to data.
> +///     fn handle(&self) -> IrqReturn {
> +///         self.0.fetch_add(1, Ordering::Relaxed);
> +///
> +///         IrqReturn::Handled
> +///     }
> +/// }
> +///
> +/// // Registers an IRQ handler for the given IrqRequest.
> +/// //
> +/// // This is executing in process context and assumes that `request` was
> +/// // previously acquired from a device.
> +/// fn register_irq(handler: Handler, request: IrqRequest<'_>) -> Result<Arc<Registration<Handler>>> {
> +///     let registration = Registration::new(request, flags::SHARED, c_str!("my_device"), handler);
> +///
> +///     let registration = Arc::pin_init(registration, GFP_KERNEL)?;
> +///
> +///     // The data can be accessed from process context too.
> +///     registration.handler().0.fetch_add(1, Ordering::Relaxed);
> +///
> +///     Ok(registration)
> +/// }
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// * We own an irq handler using `&self.handler` as its private data.
> +///
> +#[pin_data]
> +pub struct Registration<T: Handler + 'static> {
> +    #[pin]
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
> +    pub fn new<'a>(
> +        request: IrqRequest<'a>,
> +        flags: Flags,
> +        name: &'static CStr,
> +        handler: T,

... to use `Completion` which requires pin-init, it seems that the
current API is a bit limited, we can make this parameter be a:

	handler: impl PinInit<T, Error>

? It'll still support the current usage because we have blanket impl.

Regards,
Boqun

> +    ) -> impl PinInit<Self, Error> + 'a {
> +        try_pin_init!(&this in Self {
> +            handler,
> +            inner <- Devres::new(
> +                request.dev,
> +                try_pin_init!(RegistrationInner {
> +                    // SAFETY: `this` is a valid pointer to the `Registration` instance
> +                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
> +                    irq: {
> +                        // SAFETY:
> +                        // - The callbacks are valid for use with request_irq.
> +                        // - If this succeeds, the slot is guaranteed to be valid until the
> +                        //   destructor of Self runs, which will deregister the callbacks
> +                        //   before the memory location becomes invalid.
> +                        to_result(unsafe {
> +                            bindings::request_irq(
> +                                request.irq,
> +                                Some(handle_irq_callback::<T>),
> +                                flags.into_inner(),
> +                                name.as_char_ptr(),
> +                                (&raw mut (*this.as_ptr()).handler).cast(),
> +                            )
> +                        })?;
> +                        request.irq
> +                    }
> +                })
> +            ),
> +            _pin: PhantomPinned,
> +        })
> +    }
[...]

