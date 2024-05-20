Return-Path: <linux-pci+bounces-7683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693448CA1B6
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 20:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1601C21BB1
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7655F136986;
	Mon, 20 May 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nz2jfv0X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457834CDE;
	Mon, 20 May 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228027; cv=none; b=XaA/X4nZo4fjWj8xqFWrfgaoe5jjDmk0MqvtOJ3FmmX47INlu6+Pje1+RttxDJ3nmoWSDJbd39hv6pqgkwyzNmrn24c3IhPn5YUAOplNU+lcFJW7TJStJqyhwMhu2f2d9K4ZkanIwXwvX1pY372TKODOdNV9L48JSfWURyv+7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228027; c=relaxed/simple;
	bh=vVR9EAvK+2jMSL8py9fcIjHGGS71cFk9eRgtsSMxJ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o67AfKGW5QNsyKHU5N/kCD6foa8qgXYsQsHC4+L0R6mealxSMMD3p710zzalSUou0HOm7vj+ScqKTmx7Stu+P8uhw6LcR9D1OWNCNH1Gyq1rH8mUJCvCCySJrMbrnJ056cs7ee3Ogml5uw8dKNKBWrQSlEwq7UHqPUonQnPY89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nz2jfv0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9C4C32789;
	Mon, 20 May 2024 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716228026;
	bh=vVR9EAvK+2jMSL8py9fcIjHGGS71cFk9eRgtsSMxJ3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nz2jfv0XEg7U5RPgEE4Kz/1YSq4wbFkS4OHP9RSGruDTZQc0+oLvMOO+zq4xzYpHm
	 RndQzzc9nJyljmchgLvsxsAAlNS/T+ZEWoTvi1cNWPiGBi+7J1pv7GdUCWflZp98Ew
	 ZT30w6wE3rwuXw6J7WwjDELCgIhHK7/Qe9rzrDQg=
Date: Mon, 20 May 2024 20:00:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] rust: add abstraction for struct device
Message-ID: <2024052038-deviancy-criteria-e4fe@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-2-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240520172554.182094-2-dakr@redhat.com>

On Mon, May 20, 2024 at 07:25:38PM +0200, Danilo Krummrich wrote:
> Add an (always) reference counted abstraction for a generic struct
> device. This abstraction encapsulates existing struct device instances
> and manages its reference count.
> 
> Subsystems may use this abstraction as a base to abstract subsystem
> specific device instances based on a generic struct device.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/helpers.c        |  1 +
>  rust/kernel/device.rs | 76 +++++++++++++++++++++++++++++++++++++++++++

What's the status of moving .rs files next to their respective .c files
in the build system?  Keeping them separate like this just isn't going
to work, sorry.

> --- /dev/null
> +++ b/rust/kernel/device.rs
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic devices that are part of the kernel's driver model.
> +//!
> +//! C header: [`include/linux/device.h`](../../../../include/linux/device.h)

relative paths for a common "include <linux/device.h" type of thing?
Rust can't handle include paths from directories?

> +
> +use crate::{
> +    bindings,
> +    types::{ARef, Opaque},
> +};
> +use core::ptr;
> +
> +/// A ref-counted device.
> +///
> +/// # Invariants
> +///
> +/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
> +/// particular, the ARef instance owns an increment on underlying object’s reference count.
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::device>);
> +
> +impl Device {
> +    /// Creates a new ref-counted instance of an existing device pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.

Callers NEVER care about the reference count of a struct device, anyone
poking in that is asking for trouble.

And why non-NULL?  Can't you check for that here?  Shouldn't you check
for that here?  Many driver core functions can handle a NULL pointer
just fine (i.e. get/put_device() can), why should Rust code assume that
a pointer passed to it from the C layer is going to have stricter rules
than the C layer can provide?

> +    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> +        // SAFETY: By the safety requirements, ptr is valid.
> +        // Initially increase the reference count by one to compensate for the final decrement once
> +        // this newly created `ARef<Device>` instance is dropped.
> +        unsafe { bindings::get_device(ptr) };
> +
> +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::device`.
> +        let ptr = ptr.cast::<Self>();
> +
> +        // SAFETY: By the safety requirements, ptr is valid.
> +        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
> +    }
> +
> +    /// Obtain the raw `struct device *`.
> +    pub(crate) fn as_raw(&self) -> *mut bindings::device {
> +        self.0.get()
> +    }
> +
> +    /// Convert a raw `struct device` pointer to a `&Device`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count for
> +    /// the entire duration when the returned reference exists.

Again, non-NULL might not be true, and reference counts are never
tracked by any user EXCEPT to increment/decrement it, you never know if
it is 0 or not, all you know is that if a pointer is given to you by the
driver core to a 'struct device' for a function that it is a valid
reference at that point in time, or maybe NULL, until your function
returns.  Anything after that can not be counted on.

thanks,

greg k-h

