Return-Path: <linux-pci+bounces-15512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353689B4592
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 10:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED22283810
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A71E0DEA;
	Tue, 29 Oct 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAATjhVM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94EE1DED7D;
	Tue, 29 Oct 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193662; cv=none; b=AfH+LToUPPLwWk7SG8El2ug+5Fe6L4fBDrG+wgBcm9IC+23RRLUlfi1459hnj7Z2fcBRqvk6Czu5JYxg4adAy8pUSNoqrD+CUg/vzKw19Q80+VjWcylRSFH9pAuiPdxh20lpc95j6sKjtZPrSX2QomlLR1O2oWTvbEvl6Jb9DXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193662; c=relaxed/simple;
	bh=GjTReHWGV6rszkOE6k4zHrl1t2L3x/04FxHrfnEJ1+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZAJBJNwJ1emwfhaL49+rCJkO+FnovNTtoANtiKyyVE/RcHUfivGMwEuwXQq56ZNgtLGj913mxT/BQb46j0IJaVxVaoP1dVlHupLrtB08a7NyPwhcBSzIU+rb+7DKKno1ZT8qqZOLbP6YNg7zDBUcBb9d/jyxqh0k7Bhec6UrDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAATjhVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8968EC4CECD;
	Tue, 29 Oct 2024 09:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730193661;
	bh=GjTReHWGV6rszkOE6k4zHrl1t2L3x/04FxHrfnEJ1+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAATjhVMq2PNlF1OCTlGtQottODNS6M3rP23Iy6ciGtr2Bz2ETtdQxgImTc9jdPCu
	 ISa+2j3bZEJYKyp69lDGZAbirqNUeiIrpDj9w4tJHd/blUzHnlUUFy1VemezzHE/sW
	 3dDJRztIyL8Bvb3BHyvHfyBVewf0/N3NV8qwZ+5rdTFMjBPXRiaHF+r1M9mq+0GKvK
	 EMpJIbmYvXcor0C7rynZnVJja3Az7cYA/UCWhxmcFh3zJ7fFga6XLHSrcU9Jx8Js+b
	 iNTVv4r1aQIbns2EU9F3XJMMcnu1rGuUhCqzdagSO9jh1MZfd9ETvpnzCyTekkvvBl
	 S5PrVa2K48M8Q==
Date: Tue, 29 Oct 2024 10:20:53 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 09/16] rust: add `io::Io` base type
Message-ID: <ZyCo9SRP4aFZ6KsZ@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-10-dakr@kernel.org>
 <CAH5fLggFD7pq0WCfMPYTZcFkvrXajPbxTBtkvSeh-N2isT1Ryw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggFD7pq0WCfMPYTZcFkvrXajPbxTBtkvSeh-N2isT1Ryw@mail.gmail.com>

On Mon, Oct 28, 2024 at 04:43:02PM +0100, Alice Ryhl wrote:
> On Tue, Oct 22, 2024 at 11:33 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > I/O memory is typically either mapped through direct calls to ioremap()
> > or subsystem / bus specific ones such as pci_iomap().
> >
> > Even though subsystem / bus specific functions to map I/O memory are
> > based on ioremap() / iounmap() it is not desirable to re-implement them
> > in Rust.
> >
> > Instead, implement a base type for I/O mapped memory, which generically
> > provides the corresponding accessors, such as `Io::readb` or
> > `Io:try_readb`.
> >
> > `Io` supports an optional const generic, such that a driver can indicate
> > the minimal expected and required size of the mapping at compile time.
> > Correspondingly, calls to the 'non-try' accessors, support compile time
> > checks of the I/O memory offset to read / write, while the 'try'
> > accessors, provide boundary checks on runtime.
> 
> And using zero works because the user then statically knows that zero
> bytes are available ... ?

Zero would mean that the (minimum) resource size is unknown at compile time.
Correspondingly, any call to `read` and `write` would not compile, since the
compile time check requires that `offset + type_size <= SIZE`.

(Hope this answers the questions, I'm not sure I got it correctly.)

> 
> > `Io` is meant to be embedded into a structure (e.g. pci::Bar or
> > io::IoMem) which creates the actual I/O memory mapping and initializes
> > `Io` accordingly.
> >
> > To ensure that I/O mapped memory can't out-live the device it may be
> > bound to, subsystems should embedd the corresponding I/O memory type
> > (e.g. pci::Bar) into a `Devres` container, such that it gets revoked
> > once the device is unbound.
> 
> I wonder if `Io` should be a reference type instead. That is:
> 
> struct Io<'a, const SIZE: usize> {
>     addr: usize,
>     maxsize: usize,
>     _lifetime: PhantomData<&'a ()>,
> }
> 
> and then the constructor requires "addr must be valid I/O mapped
> memory for maxsize bytes for the duration of 'a". And instead of
> embedding it in another struct, the other struct creates an `Io` on
> each access?

So, we'd create the `Io` instance in `deref` of the parent structure, right?
What would be the advantage?

> 
> > Co-developed-by: Philipp Stanner <pstanner@redhat.com>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> [...]
> 
> > diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> > new file mode 100644
> > index 000000000000..750af938f83e
> > --- /dev/null
> > +++ b/rust/kernel/io.rs
> > @@ -0,0 +1,234 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Memory-mapped IO.
> > +//!
> > +//! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
> > +
> > +use crate::error::{code::EINVAL, Result};
> > +use crate::{bindings, build_assert};
> > +
> > +/// IO-mapped memory, starting at the base address @addr and spanning @maxlen bytes.
> > +///
> > +/// The creator (usually a subsystem / bus such as PCI) is responsible for creating the
> > +/// mapping, performing an additional region request etc.
> > +///
> > +/// # Invariant
> > +///
> > +/// `addr` is the start and `maxsize` the length of valid I/O mapped memory region of size
> > +/// `maxsize`.
> 
> Do you not also need an invariant that `SIZE <= maxsize`?

I guess so, yes. It's enforced by `Io::new`, which fails if `SIZE > maxsize`.

> 
> Alice
> 

