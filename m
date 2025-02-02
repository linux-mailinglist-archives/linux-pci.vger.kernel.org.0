Return-Path: <linux-pci+bounces-20643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11348A25052
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 23:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74F87A2621
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E21C5F34;
	Sun,  2 Feb 2025 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/0ZKwtO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D635958;
	Sun,  2 Feb 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738534817; cv=none; b=j2k65hLlcq3ct5FE9h+L1CmCdeVSB7L6HYXiNB/X9rckuIwDcqCBbHfurORACt5mYnSAy686jIfqfSPm45WEeTC8GrXqSAMAkmKLzf83w9EPMlYNtz6jV59v7+msK6ttrZLObmXf7wZfgQK4z04R8NJi9JYLnt9KzSsxTAX3o3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738534817; c=relaxed/simple;
	bh=47Sj8QlzCdHjqFpTfcqafTjOi7EXJNwpxAbrE3Llj4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/JDEV859pyIXMnpQtJDw/aY73GZQUim4BLHZU5zRERz/Nnta7Qc2wZeYdvF86+iimtRHk4dhzy1EdgzpTDhmVdR76tsZOwgcRAhtFfvj3OBH9YoTgcbZlHQCnLU6DDTE6pjnqMl4jUkNzfRAIZt250tpUOVyTU4HueJcns8Gwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/0ZKwtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA747C4CED1;
	Sun,  2 Feb 2025 22:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738534815;
	bh=47Sj8QlzCdHjqFpTfcqafTjOi7EXJNwpxAbrE3Llj4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/0ZKwtOOvvs8FaBuqA3o8a27nyB0LRBzEtSi7dnePEIszlqV5alvmPI7Ly/6vprr
	 QKzPYdzm73tF0aqhRtGJzaEYlj1xeJ76be4buHzxlLqBU6vQGY0K+pwzlBIp6LnJi8
	 FrIASclHEB79QqZSqlIQEu1KXm6MhXO+bnPFMLGDnHegGRG5ZMKw+Ijsjz14cDfX2m
	 t2P5j7iaN5GKtnfE9o/Kgtta+Cjz/B1IdbPbqUav4D5dJjzQ9K7AL7wvwr0UAdLAYs
	 FIwgEtZqLeYSXYdyz1Z4RnV+1/Rj9gSOHdkzcAY2kAFchGlpk95Gz/UXTNo+Z39eNt
	 PSumgQdJzE/tQ==
Date: Sun, 2 Feb 2025 23:20:07 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Asahi Lina <lina@asahilina.net>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v6 07/16] rust: add `io::{Io, IoRaw}` base types
Message-ID: <Z5_vlx1BZuJGOvK7@pollux>
References: <20241212163357.35934-1-dakr@kernel.org>
 <20241212163357.35934-8-dakr@kernel.org>
 <Z2BTSbOjWa8R29i5@cassiopeiae>
 <e8da15f0-5b97-4569-842c-891cdf886978@asahilina.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8da15f0-5b97-4569-842c-891cdf886978@asahilina.net>

Hi Lina,

On Mon, Feb 03, 2025 at 06:19:57AM +0900, Asahi Lina wrote:

> 
> 
> On 12/17/24 1:20 AM, Danilo Krummrich wrote:
> > On Thu, Dec 12, 2024 at 05:33:38PM +0100, Danilo Krummrich wrote:
> >> +/// IO-mapped memory, starting at the base address @addr and spanning @maxlen bytes.
> >> +///
> >> +/// The creator (usually a subsystem / bus such as PCI) is responsible for creating the
> >> +/// mapping, performing an additional region request etc.
> >> +///
> >> +/// # Invariant
> >> +///
> >> +/// `addr` is the start and `maxsize` the length of valid I/O mapped memory region of size
> >> +/// `maxsize`.
> >> +///
> >> +/// # Examples
> >> +///
> >> +/// ```no_run
> >> +/// # use kernel::{bindings, io::{Io, IoRaw}};
> >> +/// # use core::ops::Deref;
> >> +///
> >> +/// // See also [`pci::Bar`] for a real example.
> >> +/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
> >> +///
> >> +/// impl<const SIZE: usize> IoMem<SIZE> {
> >> +///     /// # Safety
> >> +///     ///
> >> +///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
> >> +///     /// virtual address space.
> >> +///     unsafe fn new(paddr: usize) -> Result<Self>{
> >> +///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
> >> +///         // valid for `ioremap`.
> >> +///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE.try_into().unwrap()) };
> 
> This is a problematic API. ioremap() does not work on some platforms
> like Apple Silicon. Instead, you have to use ioremap_np() for most devices.
> 
> Please add a bindings::resource abstraction and use that to construct
> IoMem. Then, you can check the flags for
> bindings::IORESOURCE_MEM_NONPOSTED and use the appropriate function,
> like this:

This is just a very simplified example of how to use `IoRaw` and `Io` base
types in the scope of an example section within a doc-comment.

There is an actual `IoMem` implementation including a struct resource
abstraction [1] from Daniel though. Maybe you want to have a look at this
instead.

[1] https://lore.kernel.org/rust-for-linux/20250130220529.665896-1-daniel.almeida@collabora.com/

> 
> https://github.com/AsahiLinux/linux/blob/fce34c83f1dca5b10cc2c866fd8832a362de7974/rust/kernel/io_mem.rs#L152
> 
> 
> >> +///         if addr.is_null() {
> >> +///             return Err(ENOMEM);
> >> +///         }
> >> +///
> >> +///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> >> +///     }
> >> +/// }
> >> +///
> >> +/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> >> +///     fn drop(&mut self) {
> >> +///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
> >> +///         unsafe { bindings::iounmap(self.0.addr() as _); };
> >> +///     }
> >> +/// }
> >> +///
> >> +/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> >> +///    type Target = Io<SIZE>;
> >> +///
> >> +///    fn deref(&self) -> &Self::Target {
> >> +///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
> >> +///         unsafe { Io::from_raw(&self.0) }
> >> +///    }
> >> +/// }
> >> +///
> >> +///# fn no_run() -> Result<(), Error> {
> >> +/// // SAFETY: Invalid usage for example purposes.
> >> +/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
> >> +/// iomem.writel(0x42, 0x0);
> >> +/// assert!(iomem.try_writel(0x42, 0x0).is_ok());
> >> +/// assert!(iomem.try_writel(0x42, 0x4).is_err());
> >> +/// # Ok(())
> >> +/// # }
> >> +/// ```
> >> +#[repr(transparent)]
> >> +pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);

