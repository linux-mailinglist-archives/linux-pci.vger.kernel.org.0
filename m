Return-Path: <linux-pci+bounces-39641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4325C1A93C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 14:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42F35587A3D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BB021B9C0;
	Wed, 29 Oct 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjGAoRmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190423C513
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743003; cv=none; b=eSp5mPv6uOSEnsySeJS0N+p2oju7K6HLRKGhnUcKGkdvCGaMzUR1y3qkTN29PfpPGML/RkVjQFYsEofwKew7Gwqb9Uq/PnHKBCE31D+10X/FhARSMhFzgOuYNWgkY2HQifusC25CBTB7HeC4eE6dqeGOEMR9NipIJnPmuo2DTyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743003; c=relaxed/simple;
	bh=pi5yuhKxOE0klx8JCfsVD+GqZGX1kT6HdPKMNpthFto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b06Xntzc7Qpf2FIQY2AVWRYAbzKZR97nJTXVkl54pJ657bsECwx6VBhNX9yrxQzalVDBRjyqv9i9/x+fO9+usG8vWMjEAi9yLfgMRfBQ5GTFnSMnHxXb7MNsvtoFOybzoA29wPWaooz5fqJYb9V/X0XeJNlX3z9Y6wAYXtQJI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjGAoRmS; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so4450751f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761743000; x=1762347800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Udy7SqhBXKYC8gHDKeSCQJFDpbdKzPFYXaEf65zBeu4=;
        b=sjGAoRmSWjF5qBw7a+8Zh3RcSGPUExLIbTwok0B0F5NrgzWUmC7sCgbSC33Ua58Odz
         4ACsw7BYKI2crv3xjOh61dhmf+BChAXoV3o3KBsT7Z6WEAI6AdFL4CfJB0zsyYZ2r4W/
         Ent6fV/syZmAh2lzhhsRYdSb0PnwzXsNtD9IO1PfB6mFKk22Gi0LbjdfAMZPJEdj9oIG
         kTKVDHnd4jpNXIQqAPQVDuxGd2VDhrWm82e8WuV0jQ2JSIXgF3xIgmRAjoVlDtm8OA3E
         r7rF97e4QSCWKcNgwT92zBlmxBLKYjIy54IuE3VQnicL7iGSrOK3Cjqn8ZyDez1US/50
         ugXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743000; x=1762347800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Udy7SqhBXKYC8gHDKeSCQJFDpbdKzPFYXaEf65zBeu4=;
        b=eqt3Wm6m2jKInNGztUJp4ENmm2Uj2RCM5RUM8T4cKDvSGju2vEISGx0+WZluV3F4IL
         Wps1Vfvvg1nBCGyRq7izo0734AB2kVPgUqMn+M9xKtk3wbOAaFIcqOJOX9F60+ANzdXr
         4TYdzVtWZ1sYDK2m3ijxha2+ohHDSq2cnnAE9eI1oGqpUdA/pNMeUKFLRy2TY2e4jCaH
         NUH5XniYJv2muMXk7+7KnB17fJKtaBXGq4jpk1SYzT/S45JfaEtQC8vj6/i407JWipZh
         VUE/LlTuDmOnTCQ0HcrcJSD/H908Z8HOB2PYpwmoyustdsa0ilmg+H33c+GeJbGUej/4
         SBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXytiiXhs1jIw6N3hExWBSXgkBgRd8JrJm+Y5tLINQmXaSNBkJxShVLebdEdmREqvJp2GA/Zs5zErw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgPXzZTn7Huwfw4OY/N3+PS50BQ40PYB4Xyuq2FAYc1OtHJAn
	eoIKeTLYvDpLiZiPXDJzL04oHMQCvcsorvrpW9L3GqIXrI3drxWLJwFXXaSm2Pr0QJXOrCUDuBk
	hdhIS2hlPDoU0mIQt/Q==
X-Google-Smtp-Source: AGHT+IENECAAoljYNXJnRu1Y9gGPhJkJ3Bue+J1Hc+807eNndTdTYUWDuu128dSwta2oivz2LOgodjnqaCtDDIo=
X-Received: from wrhm10.prod.google.com ([2002:a05:6000:180a:b0:427:60a:e74c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:18a5:b0:429:8b44:57bc with SMTP id ffacd0b85a97d-429af002335mr2543993f8f.60.1761743000569;
 Wed, 29 Oct 2025 06:03:20 -0700 (PDT)
Date: Wed, 29 Oct 2025 13:03:19 +0000
In-Reply-To: <20251020223516.241050-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020223516.241050-1-dakr@kernel.org>
Message-ID: <aQIQl8lMhztucZhK@google.com>
Subject: Re: [PATCH 0/8] Device::drvdata() and driver/driver interaction (auxiliary)
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

On Tue, Oct 21, 2025 at 12:34:22AM +0200, Danilo Krummrich wrote:
> tl;dr:
> 
> Implement a safe Device<Bound>::drvdata() accessor (used for driver to
> driver interactions) based on the auxiliary bus.
> 
> This provides a way to derive a driver's device private data when
> serving as a parent in a driver hierarchy, such as a driver utilizing
> the auxiliary bus.
> 
> Please have a look at patch 8 ("samples: rust: auxiliary: illustrate
> driver interaction") to see how it turns out.
> 
> --
> 
> Full cover letter:
> 
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
> dev_set_drvdata() is called [2].
> 
> Example:
> 
>         // `dev` is a `&Device<Bound>`.
>         let data = dev.drvdata::<SampleDriver>()?;
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
> Therefore this patch series also contains the corresponding patches for
> the auxiliary bus abstraction, i.e. guarantee that the auxiliary
> device's parent is guaranteed to be bound when the auxiliary device
> itself is guaranteed to be bound, plus the corresponding
> Device<Bound>::parent() method.
> 
> Finally, illustrate how things turn out by updating the auxiliary sample
> driver.
> 
> Similarly, the same thing can be done for PCI virtual function drivers
> calling back into the corresponding physical function driver or MFD.
> 
> The former (PCI PF/VF interaction) will be addressed by a separate patch
> series. Both, auxiliary and PCI PF/VF is required by the Nova project.
> 
> A branch containing the series can be found in [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=drvdata
> [2] Type hash (TypeId) stored in struct device_private:
> 
>         The Rust type stored in struct device_private could be replaced
>         by a dedicated (and transparent) private pointer (e.g.
>         struct device_private::rust).
> 
>         While I'm not overly concerned about the extra allocation (not a
>         hot path at all), I still wanted to try to store it directly in
>         struct device_private, see how it turns out and gather opinions.
> 
>         Additionally, I don't expect any additional Rust specific
>         private data to be required. But even if, changing things up to
>         use a separate transparent allocation in the future is trivial.
> 
> Danilo Krummrich (8):
>   rust: device: narrow the generic of drvdata_obtain()
>   rust: device: introduce Device::drvdata()
>   rust: auxiliary: consider auxiliary devices always have a parent
>   rust: auxiliary: unregister on parent device unbind
>   rust: auxiliary: move parent() to impl Device
>   rust: auxiliary: implement parent() for Device<Bound>
>   samples: rust: auxiliary: misc cleanup of ParentDriver::connect()
>   samples: rust: auxiliary: illustrate driver interaction
> 
>  drivers/base/base.h                   |  16 ++++
>  drivers/gpu/drm/nova/file.rs          |   2 +-
>  drivers/gpu/nova-core/driver.rs       |   8 +-
>  rust/bindings/bindings_helper.h       |   6 ++
>  rust/kernel/auxiliary.rs              | 108 ++++++++++++++++----------
>  rust/kernel/device.rs                 |  83 ++++++++++++++++++--
>  rust/kernel/pci.rs                    |   2 +-
>  rust/kernel/platform.rs               |   2 +-
>  rust/kernel/usb.rs                    |   4 +-
>  samples/rust/rust_driver_auxiliary.rs |  44 +++++++----
>  10 files changed, 207 insertions(+), 68 deletions(-)

It looks like there are some patches that add code that doesn't pass
rustfmt, which are then fixed in follow-up commits. You might want to do
a pass of rustfmt after each commit.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

