Return-Path: <linux-pci+bounces-29222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295CAD1E28
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 14:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0847A4293
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E02A2571BF;
	Mon,  9 Jun 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4spZsG9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EECD1F4C85;
	Mon,  9 Jun 2025 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749473644; cv=none; b=qDUAta10/CkNMzJL61bi4n6OAPVO+ybI5u2OaF8ED4lFUwBBcHbN3jHnVUddYoYfLZiDQ2XQcpyX6rJ7rE3A5OCoYqTJHspinA3FzQRKEX28AM1K3gJqyWJ6/EZSQb/Y9XqNY554y9PYnYQt7dISgKx4+RYf7cCqkJCUy8Ss2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749473644; c=relaxed/simple;
	bh=LsqrPCaLGDlDsOmOjM99nlNpVzIVulusbtzC2DuBADU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igC5Tr/Ci90nkON/qY+O3FkvRQlgmgR/Ztq8pzZoTK5k9ESXBoRRzFAvMZHDRI/vBYPQ/c7FTShtaIFTCbLG3bsC3/HU7ClTvssDipA1QSFS24WryaZpJsTOEUZQmqT1n1mM5ycKlrODQuLuIZ+HnljMHz7168D/09mO+ZL9LZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4spZsG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16141C4CEEB;
	Mon,  9 Jun 2025 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749473643;
	bh=LsqrPCaLGDlDsOmOjM99nlNpVzIVulusbtzC2DuBADU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4spZsG9iao/qhmYKPIIF8aAtXKEbbs/6V453Fp4u+JZ8q/QmjTgTGSt22/8TiyzU
	 1Iyz9dOF4U1J3nsw4cHGY6MihNjWx5FlJQ5qw2vVbVDqG8L+wBS0yYJIoVYthTEmNA
	 /ZEM41Riel8ZUEtbiZLmClbHblgNk7Bw35BeW0kJnyc00yLLhWcC4MGTwRTqw0IhY6
	 YyYWo4PNV+HzO+pHUbKn5x17J9gx1V9aDFafOYQZP70d6+7KPQjhDt7ocwCLWhSB2N
	 WyhPzWI4669M95YMrti9QDkDg5sGDlrhLg3sK47x9kJADPjNJ3YFJfwSBeu0MGeeP6
	 +Cnc9duhR5aYg==
Date: Mon, 9 Jun 2025 14:53:57 +0200
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
Subject: Re: [PATCH v4 6/6] rust: pci: add irq accessors
Message-ID: <aEbZZTx99Tu1Zsd4@pollux>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-6-81cb81fb8073@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608-topics-tyr-request_irq-v4-6-81cb81fb8073@collabora.com>

On Sun, Jun 08, 2025 at 07:51:11PM -0300, Daniel Almeida wrote:
> These accessors can be used to retrieve a irq::Registration or a
> irq::ThreadedRegistration from a pci device.
> 
> These accessors ensure that only valid IRQ lines can ever be registered.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/pci.rs | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 8435f8132e38129ccc3495e7c4d3237fcaa97ad9..c690fa1c739c937324e902e61e68df238dbd733b 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -395,6 +395,32 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
>      }
>  }
>  
> +macro_rules! gen_irq_accessor {
> +    ($(#[$meta:meta])* $fn_name:ident, $reg_type:ident, $handler_trait:ident) => {
> +        $(#[$meta])*
> +        pub fn $fn_name<T: crate::irq::$handler_trait + 'static>(
> +            &self,
> +            index: u32,
> +            flags: crate::irq::flags::Flags,
> +            name: &'static crate::str::CStr,
> +            handler: T,
> +        ) -> Result<impl PinInit<crate::irq::$reg_type<T>, crate::error::Error> + '_> {
> +            // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +            let irq = unsafe { crate::bindings::pci_irq_vector(self.as_raw(), index) };
> +            if irq < 0 {
> +                return Err(crate::error::Error::from_errno(irq));
> +            }
> +            Ok(crate::irq::$reg_type::<T>::register(
> +                self.as_ref(),
> +                irq as u32,
> +                flags,
> +                name,
> +                handler,
> +            ))
> +        }
> +    };
> +}

Given that we only have two invocations below, please implement them in-place. I
don't think it's worth having the macro indirection.

>  impl Device<device::Bound> {
>      /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
>      /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
> @@ -413,6 +439,15 @@ pub fn iomap_region_sized<const SIZE: usize>(
>      pub fn iomap_region(&self, bar: u32, name: &CStr) -> Result<Devres<Bar>> {
>          self.iomap_region_sized::<0>(bar, name)
>      }
> +
> +    gen_irq_accessor!(
> +        /// Returns a [`kernel::irq::Registration`] for the IRQ vector at the given index.
> +        irq_by_index, Registration, Handler
> +    );
> +    gen_irq_accessor!(
> +        /// Returns a [`kernel::irq::ThreadedRegistration`] for the IRQ vector at the given index.
> +        threaded_irq_by_index, ThreadedRegistration, ThreadedHandler
> +    );
>  }
>  
>  impl Device<device::Core> {
> 
> -- 
> 2.49.0
> 

