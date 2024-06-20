Return-Path: <linux-pci+bounces-9029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FFE910B6F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 18:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CFB1C24E24
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840C1AF697;
	Thu, 20 Jun 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rmt/2x/H"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC61BF53
	for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899814; cv=none; b=DkPF1RjGsKY/i5xQOgtTuOBRmaUecpxihLgLPzQk+0x2YFhw3P5JY+DkYil7zLW8Ay6jW/y93cT5X80+vVFnu60Ah6rxBDbDm25midZMYCysgmYO05JlGEmChFZZnvlqwdRblzPWEFb17PURB/WeUDkx7ldUa+l0cgWboH1HZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899814; c=relaxed/simple;
	bh=ssSMczIhe71muC2Ge+dwgnfPO/j9QwLwj7JhCu3oUzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRXGGmO9kxl7S9A0lzdpDZhQoP/U9y/5FTGduD+3eMXTSBTWxeOmGjo9sFachaOLvYZdqiuc0/ilANy5b6xy8uMloJadnNfl+ylj4gFgcjoLktXGsHY12kcAND09MUTt6gWciuJ2/w+yD+dUbd6bMxZbz40vRnD5ZqzviBZKOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rmt/2x/H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718899811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JWEIbolo6Iwem2kYP/7UWqPpNHLzHJcoF74xqzSRPHU=;
	b=Rmt/2x/HTlBGHiAb4xTd66kafkMIdDwp6D/mjGoDJ2JacvlodvvWrxg/j6ljN+orCuXiDv
	Yv0pj5m/s/6+VBonQxaieT6p5F6gWM6MSeIq92n2tKNhcvtRhEpkXBLz0dhbXtl9uholbc
	1Xjxa4436RdN+N4pWfXPJJW8JE4fmjU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-T3pGW0PuORC4lnL7Uxo3KQ-1; Thu, 20 Jun 2024 12:10:10 -0400
X-MC-Unique: T3pGW0PuORC4lnL7Uxo3KQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ec3d6c2cf1so8986691fa.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2024 09:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899809; x=1719504609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWEIbolo6Iwem2kYP/7UWqPpNHLzHJcoF74xqzSRPHU=;
        b=W/QZ4sjyuexOYDksaL0TxWOvJquQmvfM63VqnDyeorxy4xyGk5DB9uf/WieYg6Y03+
         kJx6I7BkSJ2PaGJaM+oZ7wzPE4UZsvy53uGoLT9OBLLdcPcP8WEFRm8dwISqfywZ9hUY
         NXXYYSvqED/6MIfdTKBxfEm9nq96GDq923H/v33oodC5diV59ovVVlyhTZ8661DkPZZ9
         IvL7g3ZEcRh/VMVsecHuqPnthsEph8LSvRxMzuEBm5/u4n99VFRwBQgBj41qjAdRLQUz
         nR+l57mtq5Gw+Ol/W1q4eBxecM0GrRjCWE2Q/o+Cqprdc7f7JAIRNye77remK9jQdEzA
         jeHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6r1HdXwWyQg9JlUStRCzcOdjmZ+Lq9RbnPj8kXDLUuTujfU9g1p9u4FhaH3FvBaAia8ltDDGV12GuM5m1vKIZd0RASWMlGRHK
X-Gm-Message-State: AOJu0YxbBADQ7fMST2DVLFkbv2xeU21tNpGnLj8nuuUokAPwBWZNKr2z
	jOnkNaZO/UClspEeoJUlfmYV+n+5oJ9K4WVcPJuftImTYQX4ndcYgsniXX9Z1mVxKgiJRkBHTlI
	DoPmZvd5J8w2mv/u5QnJW6M8pDo70SHoxUIqVL5+QIzAQxp2raZZEDppYUQ==
X-Received: by 2002:a2e:9c04:0:b0:2ec:4399:9c0f with SMTP id 38308e7fff4ca-2ec4399a2b0mr23102261fa.0.1718899808746;
        Thu, 20 Jun 2024 09:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqT2XLxCu5eI2DOyMEtopS2O39oKnD5e98TK9RmyDbH3ZDUd9YDTErMjogmKKv4i+QXKnhpQ==
X-Received: by 2002:a2e:9c04:0:b0:2ec:4399:9c0f with SMTP id 38308e7fff4ca-2ec4399a2b0mr23102001fa.0.1718899808264;
        Thu, 20 Jun 2024 09:10:08 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d1e390bsm30844945e9.35.2024.06.20.09.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:10:07 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:10:05 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 01/10] rust: pass module name to `Module::init`
Message-ID: <ZnRUXdMaFJydAn__@cassiopeiae>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-2-dakr@redhat.com>
 <2024062038-backroom-crunchy-d4c9@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024062038-backroom-crunchy-d4c9@gregkh>

On Thu, Jun 20, 2024 at 04:19:48PM +0200, Greg KH wrote:
> On Wed, Jun 19, 2024 at 01:39:47AM +0200, Danilo Krummrich wrote:
> > In a subsequent patch we introduce the `Registration` abstraction used
> > to register driver structures. Some subsystems require the module name on
> > driver registration (e.g. PCI in __pci_register_driver()), hence pass
> > the module name to `Module::init`.
> 
> I understand the need/want here, but it feels odd that you have to
> change anything to do it.
> 
> > 
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  rust/kernel/lib.rs           | 14 ++++++++++----
> >  rust/kernel/net/phy.rs       |  2 +-
> >  rust/macros/module.rs        |  3 ++-
> >  samples/rust/rust_minimal.rs |  2 +-
> >  samples/rust/rust_print.rs   |  2 +-
> >  5 files changed, 15 insertions(+), 8 deletions(-)
> > 
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index a791702b4fee..5af00e072a58 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -71,7 +71,7 @@ pub trait Module: Sized + Sync + Send {
> >      /// should do.
> >      ///
> >      /// Equivalent to the `module_init` macro in the C API.
> > -    fn init(module: &'static ThisModule) -> error::Result<Self>;
> > +    fn init(name: &'static str::CStr, module: &'static ThisModule) -> error::Result<Self>;
> 
> Why can't the name come directly from the build system?  Why must it be
> passed into the init function of the module "class"?  What is it going
> to do with it?

The name does come from the build system, that's where `Module::init` gets it
from.

> 
> A PCI, or other bus, driver "knows" it's name already by virtue of the
> build system, so it can pass that string into whatever function needs

Let's take pci_register_driver() as example.

```
#define pci_register_driver(driver)		\
	__pci_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
```

In C drivers this works because (1) it's a macro and (2) it's called directly
from the driver code.

In Rust, for very good reasons, we have abstractions for C APIs, hence the
actual call to __pci_register_driver() does not come from code within the
module, but from the PCI Rust abstraction `Module::init` calls into instead.

Consequently, we have to pass things through. This also isn't new, please note
that the current code already does the same thing: `Module::init` (without this
patch) is already declared as

`fn init(module: &'static ThisModule) -> error::Result<Self>`

passing through `ThisModule` for the exact same reason.

Please also note that in the most common case (one driver per module) we don't
see any of this anyway.

Just like the C macro module_pci_driver(), Rust drivers can use the
`module_pci_driver!` macro.

Example from Nova:

```
    kernel::module_pci_driver! {
        // The driver type that implements the corresponding probe() and
        // remove() driver callbacks.
        type: NovaDriver,
        name: "Nova",
        author: "Danilo Krummrich",
        description: "Nova GPU driver",
        license: "GPL v2",
    }
```

> that, but the module init function itself does NOT need that.
> 
> So I fail to understand why we need to burden ALL module init functions
> with this, when only a very very very tiny subset of all drivers will
> ever need to know this, and even then, they don't need to know it at
> init module time, they know it at build time and it will be a static
> string at that point, it will not be coming in through an init call.
> 
> thanks,
> 
> greg k-h
> 


