Return-Path: <linux-pci+bounces-9025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2E3910909
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694831F244C6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF601AED20;
	Thu, 20 Jun 2024 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0jRFSQUo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D81AE0B3;
	Thu, 20 Jun 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895204; cv=none; b=ajoIfP3COIkmXldbLo6s+ctVFMXgZtPxTw7OFl6r7HCOG2EgoXij1j5htDDzTpYfHS2T5cEMHKwnlIMPggAaqgue/yBCbwueg7Y62iAgcL+xjwi7KJAh6Qk5i9dMOEX1vdN/+hgOdSEmD73INzcc7Lo8jgzX2nq97H863pZG/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895204; c=relaxed/simple;
	bh=avc6OvD0XCRHJMx1PZPh4isAaMtN3R3Nbi8f+bLT0vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScxutoJ+M3WhALDImS7kjmgMjZaJ1kRNifeW+rYE7XCem8KLyt32AkeNvWFZDMof6c9Iy/c0ThfIQOg9bjxgT4pD/tP+dZQIFPgiLAv1mA0R1uj5O7qdD4glM+WpJwv5Qdk2+Yy3m/gg1U32y60zHRfZGq7RaktyPXhofyRce/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0jRFSQUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF21C2BD10;
	Thu, 20 Jun 2024 14:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718895203;
	bh=avc6OvD0XCRHJMx1PZPh4isAaMtN3R3Nbi8f+bLT0vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0jRFSQUo2GH5KBK6nnRNsJ9n69tAf0RM3ZBbZ+QAWvYJOYe8HF4TJ4Vj31K3ipY4Y
	 U77I0HEdeLHXNN7CiZ4CoyrdO+1J9eK8Tx+vkqnI+mCjK5okTt+7kNIjPxKXJXv14I
	 8bwXdBDuqTY95EHpjkIy91ln8oexJYQdYd+V5fa8=
Date: Thu, 20 Jun 2024 16:53:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 07/10] rust: add `io::Io` base type
Message-ID: <2024062040-wannabe-composer-91bc@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-8-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618234025.15036-8-dakr@redhat.com>

On Wed, Jun 19, 2024 at 01:39:53AM +0200, Danilo Krummrich wrote:
> I/O memory is typically either mapped through direct calls to ioremap()
> or subsystem / bus specific ones such as pci_iomap().
> 
> Even though subsystem / bus specific functions to map I/O memory are
> based on ioremap() / iounmap() it is not desirable to re-implement them
> in Rust.

Why not?

> Instead, implement a base type for I/O mapped memory, which generically
> provides the corresponding accessors, such as `Io::readb` or
> `Io:try_readb`.

It provides a subset of the existing accessors, one you might want to
trim down for now, see below...

> +/* io.h */
> +u8 rust_helper_readb(const volatile void __iomem *addr)
> +{
> +	return readb(addr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_readb);

<snip>

You provide wrappers for a subset of what io.h provides, why that
specific subset?

Why not just add what you need, when you need it?  I doubt you need all
of these, and odds are you will need more.

> +u32 rust_helper_readl_relaxed(const volatile void __iomem *addr)
> +{
> +	return readl_relaxed(addr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_readl_relaxed);

I know everyone complains about wrapper functions around inline
functions, so I'll just say it again, this is horrid.  And it's going to
hurt performance, so any rust code people write is not on a level
playing field here.

Your call, but ick...

> +#ifdef CONFIG_64BIT
> +u64 rust_helper_readq_relaxed(const volatile void __iomem *addr)
> +{
> +	return readq_relaxed(addr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_readq_relaxed);
> +#endif

Rust works on 32bit targets in the kernel now?

> +macro_rules! define_read {
> +    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
> +        /// Read IO data from a given offset known at compile time.
> +        ///
> +        /// Bound checks are performed on compile time, hence if the offset is not known at compile
> +        /// time, the build will fail.

offsets aren't know at compile time for many implementations, as it
could be a dynamically allocated memory range.  How is this going to
work for that?  Heck, how does this work for DT-defined memory ranges
today?

thanks,

greg k-h

