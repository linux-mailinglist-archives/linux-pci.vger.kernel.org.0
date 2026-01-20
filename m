Return-Path: <linux-pci+bounces-45249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08127D3C26D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 09:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B413600707
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 08:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB73AE6F7;
	Tue, 20 Jan 2026 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrDqE1EJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30043B8BDB
	for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896664; cv=none; b=IUbQ3Ak7bkD9oVJ8f70rH0O7k/wrA/hwMYCjvKV3ps8Qgvbq84lUGr6ZtNvyLcEJwQUtLU+Qsxr4Nlooc885SXHBRfQlzWo4uzR71BHKwsDg1imzrJ5tb3q+RtLpMhW0AF4wXKsexkwNwW4fAwKX7O/9enYZcMMTV9v6HfsTkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896664; c=relaxed/simple;
	bh=P+SC1Lv8GtKFMmDmSP1puIAFS8fxxtphwLdKaMU0tBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZVrHlBEboof557hIbIATe41aKse9d7EVBj9/ZI3rDv+WlVBWUVSSLyOJgZejZGPtVraiq2hxHco67a7pEU4ZrcDEc5+/6K7n35VPOLNRKB+OvtarKjcbJRB6yTPZqABXbvU8PnmwZD+FEH0VdhIZPaiZCMDaLBQeBZJxtaxbJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrDqE1EJ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b871e14de77so1230732266b.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 00:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768896661; x=1769501461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4fFtv+H37c+9JHNHcFH2S2lHNgEGMW4y4wNCwUNdFE=;
        b=wrDqE1EJVkL3N/rsFq/LO+Z70VvTe65FznBb1G3/Z6FuT7Rchu2cFhbV0YCZgWwSbD
         /c46y2TDpLJ+QgvS7AiQiMLuN/yzyDG855HyBuqeJXxWTR/NndntXkafPscLHiw11Awa
         ggyejAdp3Q7AvsNFzwpsysB7uEH80OmiI9gprG+cWSslMTfJMnLgtRww7EhzHXaB9sLP
         EXv6t1A2mt19UYqedJ+q2oEujMx5cPm0nD4Rs6BtBdJCFtoPYRyHAX0RFbFfjHDx4CCy
         Vd27dNlt/x1sKbcJZr5Z3IItpsMCsKO+41knjlqsJURLPrzOsjp2C0NEXLVnkEpPHnN2
         TqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768896661; x=1769501461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4fFtv+H37c+9JHNHcFH2S2lHNgEGMW4y4wNCwUNdFE=;
        b=je4UmdVm1e2JC6HdUOlulyBo9Nva4KqvPfXpoqBieQDQskMG7I90ckOfbOOiJIv4Vz
         trFoy8GXcw/OG4JLs8NeP0KgfqOdOmJ2WjdyZO3QBCz5+F88ZP4ow9Rzk5huQzA+Z753
         QWY3qVdpxws1eL/GL68g7xv6j8K3Kj7cCxjIg98Nqj7taLkkECPkamVHN/py9rqthaoe
         QqtOUoVgWgB+iRMeOJuFMmjWC9CEMEdKJf7BbbQ9K0bywyxKJHP47/gquzmJ4KpHY+CE
         d8Isfhl+y62pYglzUwhMW7nOlxfh6tLfpJBrU5T5tX7D6vQ/LUtY9iAcnSMiQkZn2hY0
         HJSA==
X-Forwarded-Encrypted: i=1; AJvYcCX1hd6p25f9+NXBoKRQHzSg87sEfC2sFWGOxzgHsP0hJRQxmjcG+9w835RnrWKYehPhKqLwHlL5Yrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBshyPrAlmasm+3KxhI70E4O4FbyNpftj5cnEnXii+bVHQrZB
	4p7WmCXwon4S/GZSvmEvApSNkHjif8KjrbxBCavtW4A4it4T9DsStsNBDVSI8ZQaRvYx+I9uRr+
	OoQP8BXlGnN3Jm8Zecw==
X-Received: from wmgb2.prod.google.com ([2002:a05:600c:1502:b0:477:9801:6a64])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e0d:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-4803e803c1amr13091405e9.36.1768896286451;
 Tue, 20 Jan 2026 00:04:46 -0800 (PST)
Date: Tue, 20 Jan 2026 08:04:45 +0000
In-Reply-To: <20260119202250.870588-3-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260119202250.870588-1-zhiw@nvidia.com> <20260119202250.870588-3-zhiw@nvidia.com>
Message-ID: <aW83HV4lVR5MQlDd@google.com>
Subject: Re: [PATCH v10 2/5] rust: io: separate generic I/O helpers from MMIO implementation
From: Alice Ryhl <aliceryhl@google.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dakr@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	markus.probst@posteo.de, helgaas@kernel.org, cjia@nvidia.com, 
	smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com, 
	joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="utf-8"

On Mon, Jan 19, 2026 at 10:22:44PM +0200, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct. This coupling prevented
> reusing the I/O helpers for other backends, such as PCI configuration
> space.
> 
> Establish a clean separation between the I/O interface and concrete backends
> by separating generic I/O helpers from MMIO implementation.
> 
> Introduce two traits to handle different access capabilities:
> - IoCapable<T> trait provides infallible I/O operations (read/write)
>   with compile-time bounds checking.
> - IoTryCapable<T> trait provides fallible I/O operations
>   (try_read/try_write) with runtime bounds checking.
> - The Io trait defines convenience accessors (read8/write8, try_read8/
>   try_write8, etc.) that forward to the corresponding IoCapable<T> or
>   IoTryCapable<T> implementations.
> 
> This separation allows backends to selectively implement only the operations
> they support. For example, PCI configuration space can implement IoCapable<T>
> for infallible operations while MMIO regions can implement both IoCapable<T>
> and IoTryCapable<T>.
> 
> Move the MMIO-specific logic into a dedicated Mmio<SIZE> type that
> implements Io and the corresponding `IoCapable<T>` and `IoTryCapable<T>` traits.
> Rename IoRaw to MmioRaw and update consumers to use the new types.
> 
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Overall looks good to me. Some comments below:

> +/// Trait representing infallible I/O operations of a certain type.
> +///
> +/// This trait is used to provide compile-time bounds-checked I/O operations.
> +/// Different I/O backends can implement this trait to expose only the operations they support.
> +///
> +/// For example, a PCI configuration space may implement `IoCapable<u8>`, `IoCapable<u16>`,
> +/// and `IoCapable<u32>`, but not `IoCapable<u64>`, while an MMIO region on a 64-bit
> +/// system might implement all four.
> +pub trait IoCapable<T> {
> +    /// Infallible read with compile-time bounds check.
> +    fn read(&self, offset: usize) -> T;
> +
> +    /// Infallible write with compile-time bounds check.
> +    fn write(&self, value: T, offset: usize);
> +}
> +
> +/// Trait representing fallible I/O operations of a certain type.
> +///
> +/// This trait is used to provide runtime bounds-checked I/O operations.
> +/// Backends that do not support fallible operations (e.g., PCI configuration space)
> +/// do not need to implement this trait.
> +pub trait IoTryCapable<T> {
> +    /// Fallible read with runtime bounds check.
> +    fn try_read(&self, offset: usize) -> Result<T>;
> +
> +    /// Fallible write with runtime bounds check.
> +    fn try_write(&self, value: T, offset: usize) -> Result;
> +}

I still think it would make sense to have `IoCapable<T>: IoTryCapable<T>`,
but it's not a big deal.

> +    /// Infallible 64-bit read with compile-time bounds check.
> +    #[cfg(CONFIG_64BIT)]
> +    fn read64(&self, offset: usize) -> u64
> +    #[cfg(CONFIG_64BIT)]
> +    fn try_read64(&self, offset: usize) -> Result<u64>

These don't really need cfg(CONFIG_64BIT). You can place that cfg on
impl blocks of IoCapable<u64>.

e.g., remove above but keep here:

> +// MMIO regions on 64-bit systems also support 64-bit accesses.
> +#[cfg(CONFIG_64BIT)]
> +impl<const SIZE: usize> IoCapable<u64> for Mmio<SIZE> {
> +    define_read!(infallible, read, readq -> u64);
> +    define_write!(infallible, write, writeq <- u64);
> +}

> +#[cfg(CONFIG_64BIT)]
> +impl<const SIZE: usize> IoTryCapable<u64> for Mmio<SIZE> {
> +    define_read!(fallible, try_read, readq -> u64);
> +    define_write!(fallible, try_write, writeq <- u64);
> +}

Alice

