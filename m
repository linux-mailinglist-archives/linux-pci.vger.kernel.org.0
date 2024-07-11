Return-Path: <linux-pci+bounces-10134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7537092DE41
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 04:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99271F2240B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 02:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C9383;
	Thu, 11 Jul 2024 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3qtBzKq"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D2F9F0
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 02:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663604; cv=none; b=pSRMlS7kxeobYr6cIA/9aAqIOE8MJ0H+f7iOxavVw5rkgqD9NeiBQWL5CNzv7WOtAAEhBM/ACXzeG1AdF/q2cp2NfYcQOkSWfqsPPuB812S1XwFvVU81za3mk8toan2T35Pre5VY1syFdP7pgI+ot2xeqwRAt3CdpWm8CYEwPhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663604; c=relaxed/simple;
	bh=pJyHRJDFncPPTGOMQDSJyJR4PDpISzhTeqHtdLZeCR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI/UrcH4MYJDLV5s+OBTdbp/Eh24ErmPlyYQwK8PIITRJkwFcnd/Kqkj5iwv8ocLjOUksUVt6AgcRXZ06VyWL1q4fFv51JTBqz1F7onU48hKn8MlcdtHa/X6wNl3GqEtEWH6VblGapSM+i+4forqLF2fORnUFFCyD2dek3sDG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3qtBzKq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720663601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gcJ+bhwHv55iisJI251dNo25fMgIA/xRWTiXDkq/ZHQ=;
	b=O3qtBzKq1tJsgVReVOn1rprHFvvFysQRJPftA5+Pb5Y2WAshJteQWTrQEilDHhglp9eE5g
	SeEsjqWXmetVk+36GYPSSSKW8DQuHVwZymtoVU7SgQfqtm31yJFnOVVdJ9tilrp4UFp+//
	fqqtMt8F0jSaymkd+yWMvIiMT5xyIuQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-biDiNB2VPQuqnpc0Ejp_GA-1; Wed, 10 Jul 2024 22:06:39 -0400
X-MC-Unique: biDiNB2VPQuqnpc0Ejp_GA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77af33ce50so39053866b.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 19:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720663598; x=1721268398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcJ+bhwHv55iisJI251dNo25fMgIA/xRWTiXDkq/ZHQ=;
        b=pGKGNHXzQk3MDZVtnn0no73b4nf5xspwX3pQIL128HWUxAviHEp/xeNiytp6fbfgwp
         n3JHzlADfFZfy5nJTirp1kW363VjkO+wIpvMeb1+eNtF6t+Gtx5eFvjzX40taDIa3aI8
         qBdKi20mzxMprVSrQ9TdxWLeASjV04FVEEuOuav7vOZXXP8kQ7svNkhRWfAIcpM7CmvV
         qSEfll+tBSEUjuGPPJ8jP0rWabyr+IvMbbzpdGga5VZynZV6eXjU3S8TYhWiwDHb4LaS
         nkP8Jv6d/31fPbrQgwOdStFf6y6cCpkmdk0ShooMXQn/mFVqcQvkzweLYmrMIm6nGWSZ
         n/kw==
X-Forwarded-Encrypted: i=1; AJvYcCW4hvlIvHVF2B9lRI2z3wKvtbHVyzuSj233UExFnAwvPjrNGZxiBvbTExDu3MQ9KHn8WhqCqxsrsrJxf2kawIZ/HtyUOQt67lfU
X-Gm-Message-State: AOJu0YzPvlf9mE1wBHS5FKaNTagCcyQrBprhKwpBItJ107AzafyleSke
	ON8O4xxPrKcPLAVsg9bhWjkNF00ilM0m//SDBImqVI0Wx8y6ePLtGn5e9welwmV8kC0IobJzznQ
	/srl4CRwIWOO3eZM+M5aWmj1S24gz3UplIikEsXCnBSm4fnrpB6F+tVVWUg==
X-Received: by 2002:a17:906:245a:b0:a77:cbe5:413d with SMTP id a640c23a62f3a-a780b688a51mr485392066b.6.1720663597975;
        Wed, 10 Jul 2024 19:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIGxch+yWX7RBH3S75Tadyo+mN5FVAEvp1K/XMHtNfD9634tiEoeb73S5vShoe4GvzAAaCcA==
X-Received: by 2002:a17:906:245a:b0:a77:cbe5:413d with SMTP id a640c23a62f3a-a780b688a51mr485389666b.6.1720663597631;
        Wed, 10 Jul 2024 19:06:37 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a797f300b05sm92729666b.134.2024.07.10.19.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 19:06:37 -0700 (PDT)
Date: Thu, 11 Jul 2024 04:06:35 +0200
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
Subject: Re: [PATCH v2 02/10] rust: implement generic driver registration
Message-ID: <Zo8-K7vKECn0X9cR@pollux>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-3-dakr@redhat.com>
 <2024062025-wrecking-utilize-30cf@gregkh>
 <ZnRjCnvtPBhEatt_@cassiopeiae>
 <2024071052-bunion-kinswoman-6577@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071052-bunion-kinswoman-6577@gregkh>

(Please read my reply to Patch 1 first)

On Wed, Jul 10, 2024 at 04:10:40PM +0200, Greg KH wrote:
> On Thu, Jun 20, 2024 at 07:12:42PM +0200, Danilo Krummrich wrote:
> > On Thu, Jun 20, 2024 at 04:28:23PM +0200, Greg KH wrote:
> > > On Wed, Jun 19, 2024 at 01:39:48AM +0200, Danilo Krummrich wrote:
> > > > Implement the generic `Registration` type and the `DriverOps` trait.
> > > 
> > > I don't think this is needed, more below...
> > > 
> > > > The `Registration` structure is the common type that represents a driver
> > > > registration and is typically bound to the lifetime of a module. However,
> > > > it doesn't implement actual calls to the kernel's driver core to register
> > > > drivers itself.
> > > 
> > > But that's not what normally happens, more below...
> > 
> > I can't find below a paragraph that seems related to this, hence I reply here.
> > 
> > The above is just different wording for: A driver is typically registered in
> > module_init() and unregistered in module_exit().
> > 
> > Isn't that what happens normally?
> 
> Yes, but it's nothing we have ever used in the kernel before.  You are
> defining new terms in some places, and renaming existing ones in others,
> which is going to do nothing but confuse us all.

We're not renaming anything, but...

New terms, yes, because it's new structures that aren't needed in C, but in
Rust. Why do we need those things in Rust, but not in C you may ask.

Let me try to explain it while trying to clarify what the `Registration` and
`DriverOps` types are actually used for, as promised in my reply to Patch 1.

The first misunderstanding may be that they abstract something in drivers/base/,
but that's not the case. In fact, those are not abstractions around C
structures themselfes. Think of them as small helpers to implement driver
abstractions in general (e.g. PCI, platform, etc.), which is why they are in a
file named driver.rs.

Now, what are `DriverOps`? It's just an interface that asks the implementer of
the interface to implement a register() and an unregister() function. PCI
obviously does implement this as pci_register_driver() and
pci_unregister_driver().

Having that said, I agree with you that `DriverOps` is a bad name, I think it
should be `RegistrationOps` instead - it represents the operations to register()
and unregister() a driver. I will use this name in the following instead, it is
less confusing.

In terms of what a `Registration` does and why we need this in Rust, but not in
C it is easiest to see from an example with some inline comments:

```
struct MyDriver;

impl pci::Driver for MyDriver {
	define_pci_id_table! {
		bindings::PCI_VENDOR_ID_FOO, bindings::PCI_ANY_ID,
		None,
	}

	fn probe(dev: ARef<pci::Device>) {}
	fn remove() {}
}

struct MyModule {
	// `pci::RegOps` is the PCI implementation of `RegistrationOps`, i.e.
	// `pci::Ops::register()` calls pci_register_driver() and 
	// `pci::Ops::unregister()` calls pci_unregister_driver().
	//
	// `pci::RegOps` also creates the `struct pci_dev` setting probe() to
	// `MyDriver::probe` and remove() to `MyDriver::remove()`.
	reg: Registration<pci::RegOps<MyDriver>>,
}

impl kernel::Moduke for MyModule {
fn init(name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
		Ok(MyModule {
			reg: Registration::<pci::RegOps<MyDriver>>::new(name, module),
		})
	}
}
```

This code is equivalent to the following C code:

```
static int probe(struct pci_dev *pdev, const struct pci_device_id *ent) {}

static void remove(struct pci_dev *pdev) {}

static struct pci_driver my_pci_driver {
	.name = "my_driver",
	.id_table = pci_ids,
	.probe = probe,
	.remove = remove,
};

static int __init my_module_init(void)
{
	pci_register_driver(my_pci_driver);
}
module_init(my_module_init);

static void __exit my_module_exit(void)
{
	pci_unregister_driver(my_pci_driver();
}
module_exit(my_module_exit);
```

You may have noticed that the Rust code doesn't need `Module::exit` at all. And
the reason is the `Registration` type.

`Registration` is implemented as:

```
struct Registration<T: RegistrationOps> {
	// In the example above `T::DriverType` is struct pci_dev.
	drv: T::DriverType,
}

impl<T: RegistrationOps> Registration<T> {
	pub fn new(name: &'static Cstr, module &'static ThisModule) -> Self {
		// SAFETY: `T::DriverType` is a C type (e.g. struct pci_dev) and
		// can be zero initialized.
		// This is a bit simplified, to not bloat the example with
		// pinning.
		let drv: T::DriverType = unsafe { core::mem::zeroed() };

		// In this example, this calls `pci::RegOps::register`, which
		// initializes the struct pci_dev and calls
		// pci_register_driver().
		T::register(drv, name, module);
	}
}

impl<T: RegistrationOps> Drop for Registration<T> {
	fn drop(&mut self) {
		// This calls pci_unregister_driver() on the struct pci_dev
		// stored in `self.drv`.
		T::unregister(self.drv);
	}
}
```

As you can see, once the `Registration` goes out of scope the driver is
automatically unregistered due to the drop() implementation, which is why we
don't need `Module::exit`. 

This also answers why we need a `Registration` structure in Rust, but not in C.
Rust uses different programming paradigms than C, and it uses type
representations with `Drop` traits to clean things up, rather than relying on
the user of the API doing it manually.

I really hope this explanation and example helps and contributes to progress.
As you can see I really put a lot of effort and dedication into this work.

- Danilo

--

Just for completeness, please find the relevant parts of `pci::RegOps` below.

```
impl<T: Driver> driver::DriverOps for Adapter<T> {
	type DriverType = bindings::pci_driver;

	fn register(
		pdrv: &mut bindings::pci_driver,
		name: &'static CStr,
		module: &'static ThisModule,
	) -> Result {
		pdrv.name = name.as_char_ptr();
		pdrv.probe = Some(Self::probe_callback);
		pdrv.remove = Some(Self::remove_callback);
		pdrv.id_table = T::ID_TABLE.as_ref();

		// SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
		to_result(unsafe {
			bindings::__pci_register_driver(pdrv as _, module.0, name.as_char_ptr())
		})
	}

	fn unregister(pdrv: &mut Self::RegType) {
		// SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
		unsafe { bindings::pci_unregister_driver(pdrv) }
	}
}
```

(cutting the rest of the mail, since everything else is covered already)


