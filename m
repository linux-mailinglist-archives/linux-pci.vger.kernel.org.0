Return-Path: <linux-pci+bounces-31150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C6CAEF367
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 11:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BF07AFA83
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B97F26E15D;
	Tue,  1 Jul 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jrd5r3pp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB026D4CA;
	Tue,  1 Jul 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362214; cv=none; b=MCaJzDeSWtiw/qd+zQ1jU+bBvmkvUUvfITqNXStRvLiVmV2D5fgHQwqOMicUIsiq8fJbqVP8tRvjEZBXDZFOzQX7yZ0A9av3CMBQDMEVZxfAC3qTZYO+ShLGKS56EgxY9gx++zX9EG+RNpHGmPqVjjuf0rb/vDbJCVKG+UBpNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362214; c=relaxed/simple;
	bh=unCvwSHCZ9bTTw5zoAQ4qelo85nP20ruT74PbSMjF8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igs3wbzE7WC67BEFHGMsDyvlZ/z+7D4oln6uRvyxfEL2uIxqMWFn7Rcw4FVqZvuWzDwJ73QOEJ4hXLdBewsNqln/OcYxkvIJRkUyyb+uuQawBGQ4o5+vJHDhHlogJi4kftlKPuNmMnc15KXUyxsfhcoEyl0eHC8rUhVZCLPdAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jrd5r3pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD23C4CEEB;
	Tue,  1 Jul 2025 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751362214;
	bh=unCvwSHCZ9bTTw5zoAQ4qelo85nP20ruT74PbSMjF8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrd5r3ppONphEHNx5Q2dIIXU6MFC13Ypmcqh7qCZiQlk29yCNRgrgsqRrAXRAGhgi
	 7nW99krx9AGPtEQ/Jmiox9wAEz4cCMf1EDIXz6Z47K/KOhMfRsX0S/sUhZzFIsydT6
	 oQdAILH98o8EgLZzBup+kuoeo4y2u0mIPxfq8k5A=
Date: Tue, 1 Jul 2025 11:30:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/8] rust: pci: use generic device drvdata accessors
Message-ID: <2025070142-scrambler-ramp-cd7e@gregkh>
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-5-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621195118.124245-5-dakr@kernel.org>

On Sat, Jun 21, 2025 at 09:43:30PM +0200, Danilo Krummrich wrote:
> Take advantage of the generic drvdata accessors of the generic Device
> type.
> 
> While at it, use from_result() instead of match.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers/pci.c | 10 ----------
>  rust/kernel/pci.rs | 31 ++++++++++++++-----------------
>  2 files changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> index cd0e6bf2cc4d..ef9cb38c81a6 100644
> --- a/rust/helpers/pci.c
> +++ b/rust/helpers/pci.c
> @@ -2,16 +2,6 @@
>  
>  #include <linux/pci.h>
>  
> -void rust_helper_pci_set_drvdata(struct pci_dev *pdev, void *data)
> -{
> -	pci_set_drvdata(pdev, data);
> -}
> -
> -void *rust_helper_pci_get_drvdata(struct pci_dev *pdev)
> -{
> -	return pci_get_drvdata(pdev);
> -}
> -
>  resource_size_t rust_helper_pci_resource_len(struct pci_dev *pdev, int bar)
>  {
>  	return pci_resource_len(pdev, bar);
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 8435f8132e38..064e74a90904 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -10,11 +10,11 @@
>      device_id::RawDeviceId,
>      devres::Devres,
>      driver,
> -    error::{to_result, Result},
> +    error::{from_result, to_result, Result},
>      io::Io,
>      io::IoRaw,
>      str::CStr,
> -    types::{ARef, ForeignOwnable, Opaque},
> +    types::{ARef, Opaque},
>      ThisModule,
>  };
>  use core::{
> @@ -66,35 +66,32 @@ extern "C" fn probe_callback(
>          // `struct pci_dev`.
>          //
>          // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
> -        let pdev = unsafe { &*pdev.cast::<Device<device::Core>>() };
> +        let pdev = unsafe { &*pdev.cast::<Device<device::Internal>>() };
>  
>          // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct pci_device_id` and
>          // does not add additional invariants, so it's safe to transmute.
>          let id = unsafe { &*id.cast::<DeviceId>() };
>          let info = T::ID_TABLE.info(id.index());
>  
> -        match T::probe(pdev, info) {
> -            Ok(data) => {
> -                // Let the `struct pci_dev` own a reference of the driver's private data.
> -                // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
> -                // `struct pci_dev`.
> -                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
> -            }
> -            Err(err) => return Error::to_errno(err),
> -        }
> +        from_result(|| {
> +            let data = T::probe(pdev, info)?;
>  
> -        0
> +            pdev.as_ref().set_drvdata(data);
> +            Ok(0)
> +        })
>      }
>  
>      extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
>          // SAFETY: The PCI bus only ever calls the remove callback with a valid pointer to a
>          // `struct pci_dev`.
> -        let ptr = unsafe { bindings::pci_get_drvdata(pdev) }.cast();
> +        //
> +        // INVARIANT: `pdev` is valid for the duration of `remove_callback()`.
> +        let pdev = unsafe { &*pdev.cast::<Device<device::Internal>>() };
>  
>          // SAFETY: `remove_callback` is only ever called after a successful call to
> -        // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
> -        // `KBox<T>` pointer created through `KBox::into_foreign`.
> -        let _ = unsafe { KBox::<T>::from_foreign(ptr) };
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
> +        // and stored a `Pin<KBox<T>>`.
> +        let _ = unsafe { pdev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() };
>      }
>  }
>  
> -- 
> 2.49.0
> 
> 

Overall, I like this, same for the other bus types.  But again, can't it
be part of Core?

thanks,

greg k-h

