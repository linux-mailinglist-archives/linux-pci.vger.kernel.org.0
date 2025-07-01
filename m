Return-Path: <linux-pci+bounces-31149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31485AEF344
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF367AC309
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3112526A1DE;
	Tue,  1 Jul 2025 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3MuvWrA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB6264F87;
	Tue,  1 Jul 2025 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362078; cv=none; b=GYCP3+kImmTFFeFKO901Cl2Rch1x1jLUOPKSUYIG2dyeGvurEyR91th+Ptwok5WSqt/9+llBgEjczNZglIF56tUHOGmgU39G6ckY9ABjYnLPT6oKclt4FDwxb6j4NgekY565KHjpkURdxrvX7XXbwLoEddcFSaxes11e3DGSIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362078; c=relaxed/simple;
	bh=tQKErcrdrMNmuQer95ZwCiVwMfr20yJXT4KLL57Odb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeveLzIrMQ18KWO3/ADQKR8GlnZ5CTLNasM0z3wPALRIcbKEXw37edsXpU0nAnBbcES9NaMsGLB51yh5ZKQtuOH8Sc7h9n+QOMysUR2Kwuhytkm5VelR8dtyyPichtbA9kVSQ1XX+NjH4Vk7LYB5OJhnVhoeGqL9PhO3eVsrKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3MuvWrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC8FC4CEEB;
	Tue,  1 Jul 2025 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751362077;
	bh=tQKErcrdrMNmuQer95ZwCiVwMfr20yJXT4KLL57Odb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3MuvWrABdTNO8UBoTb0anlbZvJzxAj2ppy40MKWn+MXu9k362JEr8XknRn/Rh+ie
	 X+n42y+rJrKFp5z8P0LAFtKPtno7JhrBN77NtL2RDC7FfZo2nCD2INKFbx6mbGZj+a
	 NO1oud9wGUPLV0QJIoiBG4NDHxqpRfc8pMhudO4w=
Date: Tue, 1 Jul 2025 11:27:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/8] rust: device: add drvdata accessors
Message-ID: <2025070159-perkiness-bullion-da76@gregkh>
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621195118.124245-3-dakr@kernel.org>

On Sat, Jun 21, 2025 at 09:43:28PM +0200, Danilo Krummrich wrote:
> Implement generic accessors for the private data of a driver bound to a
> device.
> 
> Those accessors should be used by bus abstractions from their
> corresponding core callbacks, such as probe(), remove(), etc.
> 
> Implementing them for device::Internal guarantees that driver's can't
> interfere with the logic implemented by the bus abstraction.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers/device.c | 10 ++++++++++
>  rust/kernel/device.rs | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers/device.c b/rust/helpers/device.c
> index b2135c6686b0..9bf252649c75 100644
> --- a/rust/helpers/device.c
> +++ b/rust/helpers/device.c
> @@ -8,3 +8,13 @@ int rust_helper_devm_add_action(struct device *dev,
>  {
>  	return devm_add_action(dev, action, data);
>  }
> +
> +void *rust_helper_dev_get_drvdata(const struct device *dev)
> +{
> +	return dev_get_drvdata(dev);
> +}
> +
> +void rust_helper_dev_set_drvdata(struct device *dev, void *data)
> +{
> +	dev_set_drvdata(dev, data);
> +}
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index e9094d8322d5..146eba147d2f 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -6,7 +6,7 @@
>  
>  use crate::{
>      bindings,
> -    types::{ARef, Opaque},
> +    types::{ARef, ForeignOwnable, Opaque},
>  };
>  use core::{fmt, marker::PhantomData, ptr};
>  
> @@ -62,6 +62,47 @@ pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
>      }
>  }
>  
> +impl Device<Internal> {
> +    /// Store a pointer to the bound driver's private data.
> +    pub fn set_drvdata(&self, data: impl ForeignOwnable) {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> +        unsafe { bindings::dev_set_drvdata(self.as_raw(), data.into_foreign().cast()) }
> +    }

Ah, but a driver's private data in the device is NOT a bus-specific
thing, it's a driver-specific thing, so your previous patch about
Internal being there for busses feels odd.


> +
> +    /// Take ownership of the private data stored in this [`Device`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// - Must only be called once after a preceding call to [`Device::set_drvdata`].
> +    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
> +    ///   [`Device::set_drvdata`].
> +    pub unsafe fn drvdata_obtain<T: ForeignOwnable>(&self) -> T {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> +        let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> +
> +        // SAFETY: By the safety requirements of this function, `ptr` comes from a previous call to
> +        // `into_foreign()`.
> +        unsafe { T::from_foreign(ptr.cast()) }
> +    }
> +
> +    /// Borrow the driver's private data bound to this [`Device`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// - Must only be called after a preceding call to [`Device::set_drvdata`] and before
> +    ///   [`Device::drvdata_obtain`].
> +    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
> +    ///   [`Device::set_drvdata`].
> +    pub unsafe fn drvdata_borrow<T: ForeignOwnable>(&self) -> T::Borrowed<'_> {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> +        let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> +
> +        // SAFETY: By the safety requirements of this function, `ptr` comes from a previous call to
> +        // `into_foreign()`.
> +        unsafe { T::borrow(ptr.cast()) }
> +    }
> +}

Why can't this be part of Core?

thanks,

greg k-h

