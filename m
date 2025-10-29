Return-Path: <linux-pci+bounces-39640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF26C1AD9A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 14:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B04625D52
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6550325734;
	Wed, 29 Oct 2025 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bmrs+KJG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31C7286416
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742785; cv=none; b=O4WU+INe5JRoXUM09l3xfzzVI3NnHr1dhZtciYqXUTrbbMzIoPxD24c/ZUOkL90I19H1EDzrLQVLJ9cHB3m6K8DOPvnvCIybPGCtUGCd63gMgFYzX8tVsU/uy2hTpIntotskKVg73lV0zcpNKLN/hIJ424or8qSASIf65yGmkvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742785; c=relaxed/simple;
	bh=cZUqEi7ArJBgqnrq/LGfj3bUXfY69RvPu1cvwBiVCak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ww2DwFAFxxVdCEYK5HEprnPgOyFGpVQXdhLVkXSAFbpd89MJsYZStYbOoZshTk6DoX7PL/QzuU+pCRbX2D7OmjcCOtR47RbDcnFd86FrYbWYG5keQISDNVPRu98TOcJYqvRyOaEoBt3J0qEBXXBrdn8wzsz56kC1MEwJ8A9xDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bmrs+KJG; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429893e2905so7046953f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761742782; x=1762347582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvcZ242I0xNV0Bj8P2kxRpXu3YYgCUlfHC5XSdPNaN0=;
        b=Bmrs+KJGpZa4aRNYwF4tRU2pbINS1yxabO0L36mrLHRQcM7y823X047mv+4lH2uhIP
         KpUyJGNS5SxrvRzQAs6AwdP8OKq5JwBtMwKtMD+KsBkakcp/GrU9ssK+8w9On1IJVI97
         3qYTF4s5fRVPXFe85bNPVBTRxggroBVIxausqXfZGYbu8YkNjrTyzC2csBL/gFVQSxUh
         YnLQAO2XVcKFVnOrccVADIob3k3A9pLF6T626b11yIxGnNzoMrkY6x+pFou35KjqmM9n
         Teo6y/tNdpcn3DPBbIi2jj1KIcVuUY/mpowzuGEDHl2QRgNQyh5i54yoUt7KZ0TESpo+
         kF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761742782; x=1762347582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvcZ242I0xNV0Bj8P2kxRpXu3YYgCUlfHC5XSdPNaN0=;
        b=Yzsk5dmsYPexjivVqm3/D6GjnR91is7nN1whs5qwMJwNpk07tRgYCFaesNKuScprkH
         oEv8uJauKrWDgJazdGd3qRowiozSDJgdvTAieJw0nr9l4UBF2rCsIc5uCmV5VsEPaiBS
         56creXDYRepkBArYfzH4PaJf6J91nr66LD/AlFKxammJOHmuV+xa+FCSF1LXUvqGXFN9
         bOeKF7I4DezECy48nuwzbHOTOf+VXoOn9vvC9xqxq7OXQChWqxUbh0URN2+ZjnFZiwN/
         KxUB9zTnrsIz8fdh5YEEUR47vikdli36jFSEdMYm9Da0X/voddGBobz2MzuqonVJHkUP
         Cspg==
X-Forwarded-Encrypted: i=1; AJvYcCVeeJVB+IbRSULCbu3utup/GkxAiRUa2IZrb3PhZcEzc5At3cAYtknP7qFAkT9wiIF4QyzGJ9tEKjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLRjHXffJVUen7eaKVB8PSmaW0K61R2QE0FXLlAJYEU8CGY7Qe
	5NNecqmOH217skYo9ZogEVmQDiSq8iuiKM+6Li9kvBc9hW4SGzelZx3fG/dRE/RYtJq0PCo09tl
	EnaMNuKsTs0cfqWL2FA==
X-Google-Smtp-Source: AGHT+IFnbvPlsvZotzy1WsN3Ocy8uT6OxjkU13FGbFqNo33aQaiOVG8eFJ1A1TVPzk6tojTsAQa4tCIT+M/iM9c=
X-Received: from wmvz2.prod.google.com ([2002:a05:600d:6282:b0:477:d21:4a92])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:26d2:b0:429:91ca:70f1 with SMTP id ffacd0b85a97d-429aefccf44mr2238605f8f.57.1761742782357;
 Wed, 29 Oct 2025 05:59:42 -0700 (PDT)
Date: Wed, 29 Oct 2025 12:59:41 +0000
In-Reply-To: <20251020223516.241050-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020223516.241050-1-dakr@kernel.org> <20251020223516.241050-3-dakr@kernel.org>
Message-ID: <aQIPvaFJIXySV-Q5@google.com>
Subject: Re: [PATCH 2/8] rust: device: introduce Device::drvdata()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	pcolberg@redhat.com, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Oct 21, 2025 at 12:34:24AM +0200, Danilo Krummrich wrote:
> In C dev_get_drvdata() has specific requirements under which it is valid
> to access the returned pointer. That is, drivers have to ensure that
> 
>   (1) for the duration the returned pointer is accessed the driver is
>       bound and remains to be bound to the corresponding device,
> 
>   (2) the returned void * is treated according to the driver's private
>       data type, i.e. according to what has been passed to
>       dev_set_drvdata().
> 
> In Rust, (1) can be ensured by simply requiring the Bound device
> context, i.e. provide the drvdata() method for Device<Bound> only.
> 
> For (2) we would usually make the device type generic over the driver
> type, e.g. Device<T: Driver>, where <T as Driver>::Data is the type of
> the driver's private data.
> 
> However, a device does not have a driver type known at compile time and
> may be bound to multiple drivers throughout its lifetime.
> 
> Hence, in order to be able to provide a safe accessor for the driver's
> device private data, we have to do the type check on runtime.
> 
> This is achieved by letting a driver assert the expected type, which is
> then compared to a type hash stored in struct device_private when
> dev_set_drvdata() is called.
> 
> Example:
> 
> 	// `dev` is a `&Device<Bound>`.
> 	let data = dev.drvdata::<SampleDriver>()?;
> 
> There are two aspects to note:
> 
>   (1) Technically, the same check could be achieved by comparing the
>       struct device_driver pointer of struct device with the struct
>       device_driver pointer of the driver struct (e.g. struct
>       pci_driver).
> 
>       However, this would - in addition the pointer comparison - require
>       to tie back the private driver data type to the struct
>       device_driver pointer of the driver struct to prove correctness.
> 
>       Besides that, accessing the driver struct (stored in the module
>       structure) isn't trivial and would result into horrible code and
>       API ergonomics.
> 
>   (2) Having a direct accessor to the driver's private data is not
>       commonly required (at least in Rust): Bus callback methods already
>       provide access to the driver's device private data through a &self
>       argument, while other driver entry points such as IRQs,
>       workqueues, timers, IOCTLs, etc. have their own private data with
>       separate ownership and lifetime.
> 
>       In other words, a driver's device private data is only relevant
>       for driver model contexts (such a file private is only relevant
>       for file contexts).
> 
> Having that said, the motivation for accessing the driver's device
> private data with Device<Bound>::drvdata() are interactions between
> drivers. For instance, when an auxiliary driver calls back into its
> parent, the parent has to be capable to derive its private data from the
> corresponding device (i.e. the parent of the auxiliary device).
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Are you going to open that docs PR to the Rust compiler about the size
of TypeID that we talked about? :)

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +// Compile-time checks.
> +const _: () = {
> +    // Assert that we can `read()` / `write()` a `TypeId` instance from / into `struct driver_type`.
> +    static_assert!(core::mem::size_of::<bindings::driver_type>() == core::mem::size_of::<TypeId>());
> +};

You don't need the "const _: ()" part. See the definition of
static_assert! to see why.

Also, I would not require equality. The Rust team did not think that it
would ever increase in size, but it may decrease.

>  /// The core representation of a device in the kernel's driver model.
>  ///
>  /// This structure represents the Rust abstraction for a C `struct device`. A [`Device`] can either
> @@ -198,12 +204,29 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {
>  }
>  
>  impl Device<CoreInternal> {
> +    fn type_id_store<T: 'static>(&self) {

This name isn't great. How about "set_type_id()" instead?

Alice 

