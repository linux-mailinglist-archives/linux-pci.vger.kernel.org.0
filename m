Return-Path: <linux-pci+bounces-29221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E305FAD1E21
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 14:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9BF16B2B6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 12:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68FA255E34;
	Mon,  9 Jun 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBz5dMPV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EEE10E3;
	Mon,  9 Jun 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749473514; cv=none; b=HgvNm9JYdrQgp/nGZc34lxohUIx2Ahh1V/skSWjDo2iqX2H7RQrkew3pb8SzRs61shAHF0vDj/GHBHQYmX62B11X/7mkBtZT4AWDTdHIdhyYTqH7EgUKgkSxtXkCCJ6MRKk1EzeYAoFcrlF/rrB2k+A7OJ2eoAe6zaU9P6nKENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749473514; c=relaxed/simple;
	bh=C7g6IkUaAnFKUAqlv0oijHXBJSuQkmiZUwfkcYEAqT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTIjT/wdk5ihNqLg5jJbIqHhwtqw8OM2gFk2fjBKrt17DUEPkWX1cc7foC4C6/xwpsYC/z9Obft9mIF0Wgkd3twuGk9oTpfo4U8r9XCpMKqJ75Lo2//BYWWt6i/j5G1hjznQc8oTa7lpbqXfGHehXwe4ECEyRl5ssGtzh1WnoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBz5dMPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3C7C4CEEB;
	Mon,  9 Jun 2025 12:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749473514;
	bh=C7g6IkUaAnFKUAqlv0oijHXBJSuQkmiZUwfkcYEAqT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBz5dMPVknKxqr0cExJ931ERpZNK00CWEmYY8OmCP9obB96lk8t/zZ9MSovaIe7Td
	 JbL73T5nvu243sk9T37YJMGdfnOqR4tNN1KdwGpjy1Ol6PUdH8EYNzDlsbZA+aa7Am
	 IXA/6++xWbGBKuJW4HyaPQGO/qPb1jNM5ftD2HGBvnihS803JgYwlrRnbdskt98RRE
	 QG5UyAapYM2YqHZPIX8+ukFFaTeBZ5rq3wuXHgxATHFzAtymUhcQCnace8q3+sfTtv
	 qNcDdu+ZD8j9DBSlDgzWnKww4lUVCzO6QI1Povbwb1zjkMNxu56cjy3Sk13D4Hn1He
	 0kXEJQUJ9zFGw==
Date: Mon, 9 Jun 2025 14:51:48 +0200
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
Subject: Re: [PATCH v4 5/6] rust: platform: add irq accessors
Message-ID: <aEbY5GWyXI3OEZOa@pollux>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-5-81cb81fb8073@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608-topics-tyr-request_irq-v4-5-81cb81fb8073@collabora.com>

On Sun, Jun 08, 2025 at 07:51:10PM -0300, Daniel Almeida wrote:
> +macro_rules! gen_irq_accessor {
> +    ($(#[$meta:meta])* $fn_name:ident, $reg_type:ident, $handler_trait:ident, index, $irq_fn:ident) => {
> +        $(#[$meta])*
> +        pub fn $fn_name<T: irq::$handler_trait + 'static>(
> +            &self,
> +            index: u32,
> +            flags: irq::flags::Flags,
> +            name: &'static CStr,
> +            handler: T,
> +        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + '_> {
> +            // SAFETY: `self.as_raw` returns a valid pointer to a `struct platform_device`.
> +            let irq = unsafe { bindings::$irq_fn(self.as_raw(), index) };
> +
> +            if irq < 0 {
> +                return Err(Error::from_errno(irq));
> +            }
> +
> +            Ok(irq::$reg_type::<T>::register(
> +                self.as_ref(),
> +                irq as u32,
> +                flags,
> +                name,
> +                handler,
> +            ))
> +        }
> +    };
> +
> +    ($(#[$meta:meta])* $fn_name:ident, $reg_type:ident, $handler_trait:ident, name, $irq_fn:ident) => {
> +        $(#[$meta])*
> +        pub fn $fn_name<T: irq::$handler_trait + 'static>(
> +            &self,
> +            name: &'static CStr,
> +            flags: irq::flags::Flags,
> +            handler: T,
> +        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + '_> {
> +            // SAFETY: `self.as_raw` returns a valid pointer to a `struct platform_device`.
> +            let irq = unsafe { bindings::$irq_fn(self.as_raw(), name.as_char_ptr()) };

Do we always want to force that this name is the same name as...

> +
> +            if irq < 0 {
> +                return Err(Error::from_errno(irq));
> +            }
> +
> +            Ok(irq::$reg_type::<T>::register(
> +                self.as_ref(),
> +                irq as u32,
> +                flags,
> +                name,

...this name?

> +                handler,
> +            ))
> +        }
> +    };
> +}

Please split this in two macros, define_request_irq_by_index!() and
define_request_irq_by_name!() and keep the order of arguments the same between
the two.

