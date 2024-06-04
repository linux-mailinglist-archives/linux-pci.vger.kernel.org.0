Return-Path: <linux-pci+bounces-8250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D2C8FB8C4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 18:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C741F248F4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF3E148307;
	Tue,  4 Jun 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkuYICvZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8B33F6
	for <linux-pci@vger.kernel.org>; Tue,  4 Jun 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518198; cv=none; b=bmc5b9+YtA5d25RD5hk/KKKsp6FKc76kkpz5TAUhoziLbtAmcGW458UHgHstCvQrr0TCerjZyaOGUgB4oCIFxr9F4P/GpekCIyi8zenlutxvmWOycDPmWrdw4SpCI40YRjzsSCJx1SpJj/tdFlXdkN9vZlckXhEmyNnEQAnRE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518198; c=relaxed/simple;
	bh=L42C0MqxlWUis1/vQ2kmicKTlDmz8GjJwo4hZVEkM70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+Te9VV1KvOk7vpeZHPre8cXtFE3QkEj2ZR6NONsykpaQffhh2XkfeiHxHFqNtwA2/m9kj82mVARZcp+aFD/PPo0NvET4+GSoqQHjLI2Qy4HKWdylQCIQaH/Hwji7jQfd08NA2/uIuFzd4yaN8nhJPFvY+HJzdUGcfhZGRhj1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkuYICvZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717518195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t9m4FJ0/GJVz2wRY4oBw6RkZiK4RCdJiPQkTonn2MFI=;
	b=OkuYICvZqpVMACEz0GDleuN8shS8+iJpLuhpuz79CWe8tgnLXbtnlBr7SkDt/ACzrWKBp4
	bJUl3tYnOQyLz1EYHmf4JftBeBGDqo1OZhJE0sftRqCsGTNJqoFzrJTvMujuiRwBTHgFu1
	dYqetdk22t9iKjkLXo0xPxmcc2LODgE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-BSN7LcJRPUKS_9C_xFThzQ-1; Tue, 04 Jun 2024 12:23:13 -0400
X-MC-Unique: BSN7LcJRPUKS_9C_xFThzQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2eaa90653adso19568891fa.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2024 09:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717518192; x=1718122992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9m4FJ0/GJVz2wRY4oBw6RkZiK4RCdJiPQkTonn2MFI=;
        b=IvJ3bimEHBvXM6jmc+zfoR/eE/bGAIByp9u778Dz5gW9suXBw3vRu9stZaIJ/lZMAU
         eezGPhwH32VRn/kESMZmKEHcxqzNP1KhD/C947nZAYiheTmO4+ksWIFCiIuyIN1jfyOk
         arG0iZRv6cvyBXRhITjU3tm7MmbCc/c6Jo7ftq9mEKPT0Kp43zHaIthXMAXmOStGmVSW
         NEcnH0msLadM9lrHxkX52PDGGbRZt6/T1md9LOe4kCYx0g9NeMKn9uGeQRdU2E2ZgSFo
         Vz8r9vTadvr505yN5Uxf8JQLJf6CD7crA4KyBTw5YZlnPa9qeerDHJdeo73JYvI3D7P3
         x1Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUriZq7osiWjwQobsn6Gf+vTc2/CuKn+MWMNUsykizK1WRMhOvHmi3Se5xLfdRCid+cfEFqGkznNV2bBwWqKQEKTsqp3QaPITVU
X-Gm-Message-State: AOJu0YwhgHn+AI4o7K+HvMO1FCE8ptjRkX+4cxW8kQN4UPIbT4BWdOS0
	e3qcG1D10Xi94x2Cr5MPrBHgsTdjYJo53grC89wIYZd25859EgzWvJaGEuvtnIFTwUy7PH47acG
	QR9o2e++yr3JlwIl3PcpFCQ/lTPnE52UQ8T4Y5CpYE+hs/mBjhUkRIp/67w==
X-Received: by 2002:a2e:b053:0:b0:2ea:938f:a23d with SMTP id 38308e7fff4ca-2ea951b6102mr79735611fa.42.1717518192417;
        Tue, 04 Jun 2024 09:23:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpDgl6mVBcVb02NoTlLuJeCPaA3ijNInKKoW4CUr3sKzP9Qc3fogPqdIuifYw03YqFir9JPw==
X-Received: by 2002:a2e:b053:0:b0:2ea:938f:a23d with SMTP id 38308e7fff4ca-2ea951b6102mr79735491fa.42.1717518191954;
        Tue, 04 Jun 2024 09:23:11 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212709d336sm190116295e9.37.2024.06.04.09.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:23:11 -0700 (PDT)
Date: Tue, 4 Jun 2024 18:23:09 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] rust: add abstraction for struct device
Message-ID: <Zl8_bXqK-T24y1kp@cassiopeiae>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-2-dakr@redhat.com>
 <2024052038-deviancy-criteria-e4fe@gregkh>
 <Zkuw/nOlpAe1OesV@pollux.localdomain>
 <2024052144-alibi-mourner-d463@gregkh>
 <Zk0HG5Ot-_e0o89p@pollux>
 <2024060428-whoops-flattop-7f43@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024060428-whoops-flattop-7f43@gregkh>

On Tue, Jun 04, 2024 at 04:17:29PM +0200, Greg KH wrote:
> On Tue, May 21, 2024 at 10:42:03PM +0200, Danilo Krummrich wrote:
> > On Tue, May 21, 2024 at 11:24:38AM +0200, Greg KH wrote:
> > > On Mon, May 20, 2024 at 10:22:22PM +0200, Danilo Krummrich wrote:
> > > > > > +impl Device {
> > > > > > +    /// Creates a new ref-counted instance of an existing device pointer.
> > > > > > +    ///
> > > > > > +    /// # Safety
> > > > > > +    ///
> > > > > > +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
> > > > > 
> > > > > Callers NEVER care about the reference count of a struct device, anyone
> > > > > poking in that is asking for trouble.
> > > > 
> > > > That's confusing, if not the caller who's passing the device pointer somewhere,
> > > > who else?
> > > > 
> > > > Who takes care that a device' reference count is non-zero when a driver's probe
> > > > function is called?
> > > 
> > > A device's reference count will be non-zero, I'm saying that sometimes,
> > > some driver core functions are called with a 'struct device' that is
> > > NULL, and it can handle it just fine.  Hopefully no callbacks to the
> > > rust code will happen that way, but why aren't you checking just "to be
> > > sure!" otherwise you could have a bug here, and it costs nothing to
> > > verify it, right?
> > 
> > I get your point on that one. But let me explain a bit more why I think that
> > check is not overly helpful here.
> > 
> > In Rust we have the concept of marking functions as 'unsafe'. Unsafe functions
> > need to document their safety preconsitions, i.e. the conditions the caller of
> > the function must guarantee. The caller of an unsafe function needs an unsafe
> > block for it to compile and every unsafe block needs an explanation why it is
> > safe to call this function with the corresponding arguments.
> > 
> > (Ideally, we want to avoid having them in the first place, but for C abstractions
> > we have to deal with raw pointers we receive from the C side and dereferencing a
> > raw pointer is unsafe by definition.)
> > 
> > In this case we have a function that constructs the Rust `Device` structure from
> > a raw (device) pointer we potentially received from the C side. Now we have to
> > decide whether this function is going to be unsafe or safe.
> > 
> > In order for this function to be safe we would need to be able to guarantee that
> > this is a valid, non-null pointer with a non-zero reference count, which
> > unfortunately we can't. Hence, it's going to be an unsafe function.
> 
> But you can verify it is non-null, so why not?

I suggest to check out the code making use of this.

From the PCI abstractions:

    extern "C" fn probe_callback(
        pdev: *mut bindings::pci_dev,
        id: *const bindings::pci_device_id,
    ) -> core::ffi::c_int {
        // SAFETY: Safe because the core kernel only ever calls the probe callback with a valid
        // `pdev`.
        let dev = unsafe { device::Device::from_raw(&mut (*pdev).dev) };

        [...]
    }

Doing the NULL check would turn this into something like:

    extern "C" fn probe_callback(
        pdev: *mut bindings::pci_dev,
        id: *const bindings::pci_device_id,
    ) -> core::ffi::c_int {
        // SAFETY: Safe because the core kernel only ever calls the probe callback with a valid
        // `pdev`, but we still have to handle `Device::from_raw`'s NULL check.
        let dev = match unsafe { device::Device::from_raw(&mut (*pdev).dev) } {
           Ok(dev) => dev,
           Err(err) => return Error::to_errno(err),
        }
    }

This would be super odd. If `Device::from_raw` reports "Ok" it actually wouldn't
mean everything is well. It would *only* mean that the pointer that was passed
is not NULL. This is counter intuitive; IMHO unsafe functions shouldn't return
any type of result, because it just isn't meaningful.

> 
> > A NULL pointer check would not make it a safe function either, since the pointer
> > could still be an invalid one, or a pointer to a device it's not guaranteed that
> > the reference count is held up for the duration of the function call.
> 
> True, but you just took one huge swatch of "potential crashes" off the
> table.  To ignore that feels odd.
> 
> > Given that, we could add the NULL check and change the safety precondition to
> > "valid pointer to a device with non-zero reference count OR NULL", but I don't
> > see how this improves the situation for the caller, plus we'd need to return
> > `Result<Device>` instead and let the caller handle that the `Device` was not
> > created.
> 
> It better be able to handle if `Device` was not created, as you could
> have been out of memory and nothing would have been allocated.  To not
> check feels very broken.

The abstraction is not allocating a new C struct device, it's just abstracting a
pointer to an existing struct device. There is no OOM case to handle, the
abstraction holding the pointer lives on the stack.

> 
> > > Ok, if you say so, should we bookmark this thread for when this does
> > > happen?  :)
> > 
> > I'm just saying the caller has to validate that or provide a rationale why this
> > is safe anyways, hence it'd be just a duplicate check.
> > 
> > > 
> > > What will the rust code do if it is passed in a NULL pointer?  Will it
> > > crash like C code does?  Or something else?
> > 
> > It mostly calls into C functions with this pointer, depends on what they do.
> > 
> > Checking a few random places, e.g. [1], it seems to crash in most cases.
> > 
> > [1] https://elixir.free-electrons.com/linux/latest/source/drivers/base/core.c#L3863
> 
> Great, then you should check :)

Why isn't the conclusion that the C code should check (as well)? :) Would you
want to add a NULL check at the beginning of device_del()?

In Rust we have a clear separation between safe and unsafe functions with, for
the latter, documented requirements on what's actually allowed to pass in and
which preconditions must be guaranteed. The check happens, just not within the
unsafe function.

> 
> thanks,
> 
> greg k-h
> 


