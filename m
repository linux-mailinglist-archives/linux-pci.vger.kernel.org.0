Return-Path: <linux-pci+bounces-33721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B3FB206C4
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39D72A147A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868E2BE7AD;
	Mon, 11 Aug 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4NDh5La"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8062BE65A
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910153; cv=none; b=Qjo7itcjzKL8KRi2f8PI22RlwLvxqSSu/8m4VyS318J4bLHIVwFgmJpGS1hL7SrKwjXEoFO1tHSVKJ2hvYI/fNA0PnVL9fKsK1fVLw3CbNOHhkeMhCVVf1AQ/cpyyrd//o/5i8amix0s34PJsaP1KFjOEDF7wzLnjia+yjwBk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910153; c=relaxed/simple;
	bh=PZvpmMGKZoBLVkqYrM3rKvbs5tN16syyK8pG0HEe30E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nn+m4fxZJTnxaSkIKhYovS23OBtQ/w9UlJhrOx8J3YygzcTZDQsEpm2jd4CbvNIo3GzXMZVhPClyf4eCG893CMBaQhc+XRGeLAMKtkLG4dAvGmakYAw+JPcfK2n81S0SNe1UyI0XkB5ZEQYOZMop/pYK5uFZHo0Q087W9cI5ikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4NDh5La; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so24217455e9.3
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754910149; x=1755514949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XoFLgAaU3dTMlkB3ivuNiJh7YAxvoPGHMa/b1QxLM0U=;
        b=q4NDh5Latt5zJ/bzhTzRV3KKeCBgd40ySBv5apIR4hMVMPIGRbT80C5QupvbSq3vEc
         WlJt0AhlF9IBFWwVF3Z76EyLrCpqSWKMa0JSPwbUNGZSPunKLL/1zinw3oJyTZf0dPef
         nhyigFjmRhWVh3P95UhwW2jfZqOLZEZ2i82H0Zl4qF0BgCrUFlKE5r6qZ+KrBLtbr58U
         2J9FbkEIYLa8fOFnWjamOJUuqH6OYJQWEHzTsLznt4toYX560yL7/53oSGK+GYfShXvv
         RQxEYQrmAYgzFK542LL6JHUxMOcQ5OdMYo/nsve9tscUxy+spFW48OgK/9Ko9O6DKKa+
         OXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910149; x=1755514949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoFLgAaU3dTMlkB3ivuNiJh7YAxvoPGHMa/b1QxLM0U=;
        b=XJLa+wp5MCZJepj3iOCP23QClUlaSghbiOBuM4EEYCUIu6Hc5DN8ybM6l5MyWF6sJU
         aublDvnE/MdbSlfJ2E1lOzvCKZWq4TUEFAsq4K9FHRHfP7SAE5as+nl0DgmVWYymiTH+
         Nqh2379Fim2y4YMsFu5FDnCecmaxtSrDYbaK+iSOt9oH1wdrb7cAWEaP05MShG/PuIlx
         yojZiX8ejyKG2B6mhqUhYZPDlpuWZ3sheGEf+JNsyJpOWw0lK5+bFv7kxQ2xRo6nFVIS
         QRYAGtjc6Rio3pdYF8O1bzyPNOK90zXOcn8tg2698E2cheJsAkYHyIojtTdf2DKeFgaj
         cLPg==
X-Forwarded-Encrypted: i=1; AJvYcCWGYidNxI24+2Y9rqY72hbojceOs3ts5mVsnJKpu48qCDOyzad4Dfa3z3TO1hg1RA5VjW5j+7EyVGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqk4wlUpu0oYFY97DCq7IlXdqg8x57r87UWr3T3Rd4nb3zXqT2
	ZeUsI1NUWyHk/IlKpCfl31/wgRgjcjU1rHWIfT8PtTktaakVK9uNrQ5E5opa0yXY4HC3jWolDkx
	NSAZ6m5VxIMZPcwskCQ==
X-Google-Smtp-Source: AGHT+IEHj90/RHzHpvJsu5QjMlw4g2edIeCdvOyz1s9R5fzcMKzgwi4o+H+e3XIfZKtOyXsp93grjLNDgnKyY0Q=
X-Received: from wmbay18.prod.google.com ([2002:a05:600c:1e12:b0:459:e01c:3d6d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:15d1:b0:459:e025:8c5b with SMTP id 5b1f17b1804b1-459f60d2211mr79186135e9.30.1754910149427;
 Mon, 11 Aug 2025 04:02:29 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:02:28 +0000
In-Reply-To: <20250810-topics-tyr-request_irq2-v8-4-8163f4c4c3a6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com> <20250810-topics-tyr-request_irq2-v8-4-8163f4c4c3a6@collabora.com>
Message-ID: <aJnNxMmWarz9MWKH@google.com>
Subject: Re: [PATCH v8 4/6] rust: irq: add support for threaded IRQs and handlers
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dirk Behme <dirk.behme@de.bosch.com>
Content-Type: text/plain; charset="utf-8"

On Sun, Aug 10, 2025 at 09:32:17PM -0300, Daniel Almeida wrote:
> This patch adds support for threaded IRQs and handlers through
> irq::ThreadedRegistration and the irq::ThreadedHandler trait.
> 
> Threaded interrupts are more permissive in the sense that further
> processing is possible in a kthread. This means that said execution takes
> place outside of interrupt context, which is rather restrictive in many
> ways.
> 
> Registering a threaded irq is dependent upon having an IrqRequest that
> was previously allocated by a given device. This will be introduced in
> subsequent patches.
> 
> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +/// # Examples
> +///
> +/// The following is an example of using [`ThreadedRegistration`]. It uses a
> +/// [`Mutex`](kernel::sync::Mutex) to provide interior mutability.
> +///
> +/// ```
> +/// # use kernel::c_str;
> +/// # use kernel::device::Bound;
> +/// # use kernel::irq::{
> +/// #   self, Flags, IrqRequest, IrqReturn, ThreadedHandler, ThreadedIrqReturn,
> +/// #   ThreadedRegistration,
> +/// # };
> +/// # use kernel::prelude::*;
> +/// # use kernel::sync::{Arc, Mutex};

I would probably remove the # and keep imports visible in the example.

> +/// // Declare a struct that will be passed in when the interrupt fires. The u32
> +/// // merely serves as an example of some internal data.
> +/// //
> +/// // [`irq::ThreadedHandler::handle`] takes `&self`. This example
> +/// // illustrates how interior mutability can be used when sharing the data
> +/// // between process context and IRQ context.
> +/// struct Data {
> +///     value: Mutex<u32>,
> +/// }

This example struct should use #[pin_data].

> +///
> +/// type Handler = Data;

I think the type alias is confusing in this example. I'd either rename
the struct or use "Data" everywhere.

> +/// impl ThreadedHandler for Handler {
> +///     // This will run (in a separate kthread) if and only if
> +///     // [`ThreadedHandler::handle`] returns [`WakeThread`], which it does by
> +///     // default.
> +///     fn handle_threaded(&self) -> IrqReturn {
> +///         let mut data = self.value.lock();
> +///         *data += 1;
> +///         IrqReturn::Handled
> +///     }
> +/// }
> +///
> +/// // Registers a threaded IRQ handler for the given [`IrqRequest`].
> +/// //
> +/// // This is executing in process context and assumes that `request` was
> +/// // previously acquired from a device.
> +/// fn register_threaded_irq(
> +///     handler: impl PinInit<Handler, Error>,
> +///     request: IrqRequest<'_>,
> +/// ) -> Result<Arc<ThreadedRegistration<Handler>>> {
> +///     let registration =
> +///         ThreadedRegistration::new(request, Flags::SHARED, c_str!("my_device"), handler);
> +///
> +///     let registration = Arc::pin_init(registration, GFP_KERNEL)?;
> +///
> +///     {
> +///         // The data can be accessed from process context too.
> +///         let mut data = registration.handler().value.lock();
> +///         *data += 1;
> +///     }
> +///
> +///     Ok(registration)
> +/// }
> +/// # Ok::<(), Error>(())
> +/// ```

Alice

