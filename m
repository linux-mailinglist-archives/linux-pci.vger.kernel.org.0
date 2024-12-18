Return-Path: <linux-pci+bounces-18695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85259F663E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 13:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E353316EAF2
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6831D1AAA23;
	Wed, 18 Dec 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh8IU1b+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F5150980;
	Wed, 18 Dec 2024 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734526562; cv=none; b=EuBxQT+/oHTFbeSq2WXNsMhaW8XC7zUVqKLCAsaqMVmrV8P5qXHHOHKgK/bANi+anOkUvnzjxuWMtEz9ybE+5yhFqRn21zeP7rDca1rKYpwY3BMyxp+BXQEWXx5re6q1cBmj8iV1/RyX/wJgveP2Pm7FMt2ts2TeROv6W5cz46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734526562; c=relaxed/simple;
	bh=4Bdmkc5+uHpQm21WMuPqV+PE4F1RQKa0AcQ02X2oPN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BetnNBmXRrf9oyyjGgwV/MUySKIYSJhiUZ/PBQzRBkMTZe0PyP7EYR2DZ9CDZuBXflNiJNpLKahEOEG+zxiG1fRsUpoQkNy8UKJsm31B1a0jb0MazBiwImtOAGNIDqoKY23QNRwN0Kti335I58WGfGYWFrJ3ZCZgSFNtsIUBl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh8IU1b+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917EFC4CECE;
	Wed, 18 Dec 2024 12:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734526561;
	bh=4Bdmkc5+uHpQm21WMuPqV+PE4F1RQKa0AcQ02X2oPN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kh8IU1b+12QL0hWYMcZk6RSc3dkBDc+FCtFvPC+teujFU8WE52pEbBiqw3QcN3y+V
	 YoCUN7uefMgxgdPMDEaUVUHxl8AKaBMqtu39vIG1dTQyZX57BaOx3mgGkzrS8CnHlV
	 h3WUyAwuncrmIgEOf1yBK9KQV6RfHH663x9Rk2IeCeplXMcBZ3elkPEEUZn+aosKHT
	 JAFRkVXdpNJa2N0r5GW2FmNNsRNpT9YFPVBi/rY7vHwDjbLdpZuAOH4s0iua7oLONi
	 wq88tpKmTIS47TWL4jyoC7Phqc4lcJlKFh0kb9bLj3ROBJ2Rp69L5/IL8o9F7mXxmC
	 69fR30oTN+Vkg==
Date: Wed, 18 Dec 2024 13:55:52 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Fabien Parent <fabien.parent@linaro.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, chrisi.schrefl@gmail.com,
	paulmck@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v6 07/16] rust: add `io::{Io, IoRaw}` base types
Message-ID: <Z2LGWFXx8mjGvH8-@pollux>
References: <20241212163357.35934-1-dakr@kernel.org>
 <20241212163357.35934-8-dakr@kernel.org>
 <CAPFo5V+WOWzzXxN=-n+ADrFdkSV7C66Lq-+gitx+TnrsAzYJnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPFo5V+WOWzzXxN=-n+ADrFdkSV7C66Lq-+gitx+TnrsAzYJnw@mail.gmail.com>

On Tue, Dec 17, 2024 at 12:10:38PM -0800, Fabien Parent wrote:
> Hi Danilo,
> 
> > +/// ```no_run
> > +/// # use kernel::{bindings, io::{Io, IoRaw}};
> > +/// # use core::ops::Deref;
> > +///
> > +/// // See also [`pci::Bar`] for a real example.
> > +/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
> > +///
> > +/// impl<const SIZE: usize> IoMem<SIZE> {
> > +///     /// # Safety
> > +///     ///
> > +///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
> > +///     /// virtual address space.
> > +///     unsafe fn new(paddr: usize) -> Result<Self>{
> > +///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
> > +///         // valid for `ioremap`.
> > +///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE.try_into().unwrap()) };
> 
> This line generates a warning when building the doctests on arm64:
> 
> warning: useless conversion to the same type: usize
>     --> rust/doctests_kernel_generated.rs:3601:59
>      |
> 3601 |         let addr = unsafe { bindings::ioremap(paddr as _,
> SIZE.try_into().unwrap()) };
>      |                                                           ^^^^^^^^^^^^^^^
>      |
>      = help: consider removing .try_into()
>      = help: for further information visit
> https://rust-lang.github.io/rust-clippy/master/index.html#useless_conversion
> 
> Same things happens as well in devres.rs

I think that's because arch specific ioremap() implementations sometimes use
unsigned long and sometimes size_t.

I think we can just change this line to

`let addr = unsafe { bindings::ioremap(paddr as _, SIZE as _) };`

instead.

- Danilo

> 
> > +///         if addr.is_null() {
> > +///             return Err(ENOMEM);
> > +///         }
> > +///
> > +///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> > +///     }
> > +/// }
> > +///
> > +/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> > +///     fn drop(&mut self) {
> > +///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
> > +///         unsafe { bindings::iounmap(self.0.addr() as _); };
> > +///     }
> > +/// }
> > +///
> > +/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> > +///    type Target = Io<SIZE>;
> > +///
> > +///    fn deref(&self) -> &Self::Target {
> > +///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
> > +///         unsafe { Io::from_raw(&self.0) }
> > +///    }
> > +/// }
> > +///
> > +///# fn no_run() -> Result<(), Error> {
> > +/// // SAFETY: Invalid usage for example purposes.
> > +/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
> > +/// iomem.writel(0x42, 0x0);
> > +/// assert!(iomem.try_writel(0x42, 0x0).is_ok());
> > +/// assert!(iomem.try_writel(0x42, 0x4).is_err());
> > +/// # Ok(())
> > +/// # }
> > +/// ```

