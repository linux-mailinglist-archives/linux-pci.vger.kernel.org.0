Return-Path: <linux-pci+bounces-10133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A64D92DE3F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 04:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFD01F22313
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 02:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8F5383;
	Thu, 11 Jul 2024 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9TIiq7o"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922A748E
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663594; cv=none; b=W8c8N7g7GVHZbNVhEjGkSVqGZ63HIU2MDx70YJTWMgdm1XlZh6mJKdDb/91Vi6YSFORI7H4dtqVq6j7krDG1jBKDjcBtUO7YlguEOdJpV9rwwRVY2rw8W4f3N7+7qs5hQkiB7a/uyO/8G5CVze+WHhjVUk0HtVePR/pMh1TVYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663594; c=relaxed/simple;
	bh=jLHlF2+3ZslEz4HaF4uJ++EoxxhHzrAg4SdWVYBDh1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vzz7RjoKaWZONW7TSzWT0GrZ5iN6FgFlycAVQ35sDWxP6rEzJuX0VrRYwYlNY3WIL1PsZyi7g9GYzFUf7Brr23aiS2cCgLQO8bcqY+WQ+GYIWjGbgllb7I1IFsRUUc4Dy8xJP04onQs+k4b3SaOURlKzn1aMH6G+Bb2i0zoJUTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9TIiq7o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720663591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kINeQaiFD2+zZLi5RcydFvV8vCk0A3FwjY3UQp7XkyI=;
	b=P9TIiq7omuHj1WD0qcuyq1plW3qOUwx5vlRFGFia34HvNIz+dvA8dJga3GvId23UTUodM2
	NL8qs8YpXJqb1YhFmgrdm1BbqIdTyMCDfiukCt4EgS4sWGrXxBM3uqF4GLC9g0oRyY6Mxp
	Q23I3TPc4iy2ezuEwNA2jWsflArM4RE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-7CArlwGnOrqBT6tTfuIE2Q-1; Wed, 10 Jul 2024 22:06:30 -0400
X-MC-Unique: 7CArlwGnOrqBT6tTfuIE2Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57d5467c427so241071a12.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 19:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720663589; x=1721268389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kINeQaiFD2+zZLi5RcydFvV8vCk0A3FwjY3UQp7XkyI=;
        b=s9fbHa1EaWmfskvrEm60VQnYuIu0Dy8tNoo6TEoScuCcDtPQkYB0dc0JAYu/vpTIcY
         BkO//32LwYMHyTj9FGYqfOLp6vj4m99mT2GkHFTBmUt2UNxGU/bo7sJEgG6rbCzXTIQo
         cM0eLE9rQhe9azgW7eNqApH3snt1zrwkCLWpbBrEuSRIFFTqQpeNzjNO9QXLmp3xarSc
         5nd/T2wLBbztrOVkGw27UV1QQfrzuQuHfMcZQ4KoSSL4g7YbbW0TSYtH48WGdGw5a5hY
         llTPUSt5lJ7D7sKpP+yi5F91QoQZWs6eJiKn7XVKdwKPY66DKyXT0I/PqyOVzD2u6Ct0
         tY8g==
X-Forwarded-Encrypted: i=1; AJvYcCVUAb+lwdHHNpPfxUvnVqSL59+2Xue6AwJj1QCy8GRhc/yv7UDj2vNi1dgvXNMBr/KP17YxN93MpPRPICjhizqZp8F99UHZLj7C
X-Gm-Message-State: AOJu0Ywf0XrNffg4iP5DkioWF+1/WhLzckI2d6kWLLYoMMnVory4fiPJ
	Igv/6646PbOlPT/swajdUh7EpTm/qoZCfZKdJDsRl1gWhSbOvok6SU9DkvellLBG4LgoUWiyy4X
	1T+hGpsSumNtDgzYd+aIqyxB4gEVLmn0ACZlo39o1bTIdxnbZJJ2joBAj/w==
X-Received: by 2002:a05:6402:1909:b0:57a:2eff:8ae with SMTP id 4fb4d7f45d1cf-594ba9974edmr5588185a12.1.1720663588684;
        Wed, 10 Jul 2024 19:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiP/pYQDTC9BV8X+L6QH+4qpGo89YriyOSrvVhjXTQSJ0p5pIzO4nSYG4u/Y+8MfqUFfrfhQ==
X-Received: by 2002:a05:6402:1909:b0:57a:2eff:8ae with SMTP id 4fb4d7f45d1cf-594ba9974edmr5588155a12.1.1720663588180;
        Wed, 10 Jul 2024 19:06:28 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd459de5sm2864380a12.70.2024.07.10.19.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 19:06:27 -0700 (PDT)
Date: Thu, 11 Jul 2024 04:06:25 +0200
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
Message-ID: <Zo8-IZgJswTlyP8H@pollux>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-2-dakr@redhat.com>
 <2024062038-backroom-crunchy-d4c9@gregkh>
 <ZnRUXdMaFJydAn__@cassiopeiae>
 <2024062010-change-clubhouse-b16c@gregkh>
 <ZnSeAZu3IMA4fR8P@cassiopeiae>
 <2024071046-gaining-gave-b38f@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071046-gaining-gave-b38f@gregkh>

On Wed, Jul 10, 2024 at 04:02:04PM +0200, Greg KH wrote:
> On Thu, Jun 20, 2024 at 11:24:17PM +0200, Danilo Krummrich wrote:
> > Ok, good you point this out. We should definitely discuss this point then and
> > build some consensus around it.
> > 
> > I propose to focus on this point first and follow up with the discussion of the
> > rest of the series afterwards.
> > 
> > Let me explain why I am convinced that it's very important to have abstractions
> > in place in general and from the get-go.
> > 
> > In general, having abstractions for C APIs is the foundation of being able to
> > make use of a lot of advantages Rust has to offer.
> > 
> > The most obvious one are all the safety aspects. For instance, with an
> > abstraction we have to get exactly one piece of code right in terms of pointer
> > validity, lifetimes, type safety, API semantics, etc. and in all other places
> > (e.g. drivers) we get the compiler to check those things for us through the
> > abstraction.
> > 
> > Now, the abstraction can be buggy or insufficient and hence there is no absolute
> > safety guarantee. *But*, if we get this one thing right, there is nothing a
> > driver can mess up by itself trying to do stupid things anymore.
> > 
> > If we just call the C code instead we have to get it right everywhere instead.
> 
> I too want a pony.  But unfortunatly you are shaving a yak here instead :)
> 
> I'm not saying to call C code from rust, I'm saying call rust code from
> C.
> 
> Have a "normal" pci_driver structure with C functions that THEN call
> into the rust code that you want to implement them, with a pointer to
> the proper structure.  That gives you everything that you really want
> here, EXCEPT you don't have to build the whole tower of drivers and
> busses and the like.

Please find my reply below where you expand this point.

> 
> > Now, you could approach this top-down instead and argue that we could at least
> > benefit from Rust for the driver specific parts.
> > 
> > Unfortunately, this doesn't really work out either. Also driver specific code is
> > typically (very) closely connected to kernel APIs. If you want to use the safety
> > aspects of Rust for the driver specific parts you inevitably end up writing
> > abstractions for the C APIs in your driver.
> > 
> > There are basically three options you can end up with:
> > 
> > (1) An abstraction for the C API within your driver that is actually generic
> >     for every driver, and hence shouldn't be there.
> > (2) Your driver specific code is full of raw pointers and `unsafe {}` calls,
> >     which in the end just means that you ended up baking the abstraction into
> >     your driver specific code.
> > (3) You ignore everything, put everything in a huge `unsafe {}` block and
> >     compile C code with the Rust compiler. (Admittedly, maybe slightly
> >     overstated, but not that far off either.)
> > 
> > The latter is also the reason why it doesn't make sense to only have
> > abstractions for some things, but not for other.
> > 
> > If an abstraction for B is based on A, but we don't start with A, then B ends up
> > implementing (at least partially) the abstraction for A as well. For instance,
> > if we don't implement `driver::Registration` then the PCI abstractions (and
> > platform, usb, etc.) have to implement it.
> > 
> > It really comes down to the point that it just bubbles up. We really have to do
> > this bottom-up, otherwise we just end up moving those abstractions up, layer by
> > layer, where they don't belong to and we re-implement them over and over again.
> 
> I think we are talking past each other.

Given your proposal below, that is correct.

I read your previous mail as if you question having abstractions for C APIs at
all. And some parts of your latest reply still read like that to me, but for the
rest of my reply I will assume that's not the case.

> 
> Here is an example .c file that you can use today for your "implement a
> PCI driver in rust" wish in a mere 34 lines of .c code:

Your proposal below actually only discards a rather small amount of the proposed
abstractions, in particular:

  (1) the code to create a struct pci_driver and the code to call
      pci_register_driver() and pci_unregister_driver() (implemented in Patch 2)
  (2) the generic code to create the struct pci_device_id table (or any other ID
      table) (implemented in Patch 3)

As I understand you, the concern here really seems to be about the complexity
vs. what we get from it and that someone has to maintain this.

I got the point and I take it seriously. As already mentioned, I'm also willing
to take responsibility for the code and offer to maintain it.

But back to the technical details.

Let's start with (2):

I agree that this seems a bit complicated. I'd propose to remove the
abstractions in device_id.rs (i.e. Patch 3) for now and let the PCI abstraction
simply create a struct pci_device_id table directly.

As for (1):

This just makes a pretty small part of the abstractions and, it's really only
about creating the struct pci_driver (or another driver type) instance and
call the corresponding register() / unregister() functions, since we already
have the Rust module support upstream.

As in C, we really just call register() from module_init() and unregister() from
module_exit() and the code for that, without comments, is around 50 lines of
code.

As mentioned this is implemented in Patch 2; Hence, please see my reply on Patch
2, where I put a rather long and detailed explanation which hopefully clarifies
things.

Now, what do we get from that compared to the proposal below?

  - The driver's probe() and remove() functions get called with the
    corresponding abstraction types directly instead of raw pointers; this moves
    the required  `unsafe {}` blocks to a cental place which otherwise *every*
    driver would need to implement itself (obviously it'd be the same for future
    suspend, resume, shutdown, etc. callbacks).

  - More complex drivers can do the work required to be done in module_init()
    and module_exit() in Rust directly, which allows them to attach the lifetime
    of structures to the lifetime of the `Module` structure in Rust which avoids
    the need for explicit cleanup in module_exit() since they can just implement
    in Rust's drop() trait.

The latter may sound a bit less important than it actually is, since it can break
the design, safety and soundness of Rust types. Let me explain:

In Rust a type instance should cleanup after itself when it goes out of scope.

Let's make up an example:

```
// DISCLAIMER: Obviously, this is not how we actually handle memory allocations
// in Rust, it's just an example.
struct Buffer {
	ptr: *const u8,
}

impl Buffer {
	fn alloc(size: u8) -> Result<Self> {
		let ptr = Kmalloc::alloc(size, GFP_KERNEL)?;

		// Return an instance of `Buffer` initialized with a pointer to
		// the above memory allocation.
		Ok(Self {
			ptr,
		})
	}
}

impl Drop for Buffer {
	fn drop(&mut self) {
		// SAFETY: `Self` is always holding a pointer to valid memory
		// allocated with `Kmalloc`.
		unsafe { Kmalloc::free(self.ptr) };
	}
}
```

(Side note: `Kmalloc::free` is unsafe since it has no control on whether the
pointer passed to it is valid and was allocated with `Kmalloc` previously.)

In Rust's module_init() you could now attach an instance of `Buffer` to the
`Module` instance, which lives until module_exit(), which looks like this:

```
struct MyModule {
	buffer: Buffer,
}

impl kernel::Moduke for MyModule {
	fn init(module: &'static ThisModule) -> Result<Self> {
		Ok(MyModule {
			buffer: Buffer::alloc(0x100)?,
		})
	}
}
```

Note that we don't need to implement module_exit() here, since `MyModule` lives
until module_exit() and hence `buffer` has the same lifetime. Once `buffer` goes
out of scope it frees itself due to the drop() trait. In fact, buffer can never
leak it's memory.

With the proposed approach below we can't do this, we'd need to play dirty and
unsafe tricks in order to not entirely break the design of `Buffer`, or any
other more complex data structure that the module needs.

> 
> ------------------------------------------------------------------------
> // SPDX-License-Identifier: GPL-2.0-only
> #include <linux/module.h>
> #include <linux/pci.h>
> #include "my_pci_rust_bindings.h"
> 
> #define PCI_DEVICE_ID_FOO		0x0f00
> #define PCI_VENDOR_ID_FOO		0x0f00
> 
> static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> {
> 	return my_rust_probe(pdev);
> }
> 
> static void remove(struct pci_dev *pdev)
> {
> 	my_rust_remove(pdev);
> }
> 
> static const struct pci_device_id pci_ids[] = {
> 	{PCI_DEVICE(PCI_VENDOR_ID_FOO, PCI_DEVICE_ID_FOO)},
> 	{}
> };
> MODULE_DEVICE_TABLE(pci, pci_ids);
> 
> static struct pci_driver my_rust_pci_driver = {
> 	.name = "my_pci_rust_driver",
> 	.id_table = pci_ids,
> 	.probe = probe,
> 	.remove = remove,
> };
> module_pci_driver(my_rust_pci_driver);
> 
> MODULE_DESCRIPTION("Driver for my fancy PCI device");
> MODULE_LICENSE("GPL v2");
> ------------------------------------------------------------------------
> 
> Now, all you have to do is provide a my_rust_probe() and
> my_rust_remove() call in your rust code, and handle the conversion of a
> struct pci_dev to whatever you want to use (which you had to do anyway),
> and you are set!
> 
> That .c code above is "obviously" correct, and much simpler and worlds
> easier for all of us to understand instead of the huge .rs files that
> this patch series was attempting to implement.
> 
> You have to draw the c/rust line somewhere, you all seem to be wanting
> to draw that line at "no .c in my module at all!" and I'm saying "put 34
> lines of .c in your module and you will save a LOT of headache now."
> 
> All of the "real" work you want to do for your driver is behind the
> probe/remove callbacks (ok, add a suspend/resume as well, forgot that),
> and stop worrying about all of the bindings and other mess to tie into
> the driver model for a specific bus type and the lunacy that the device
> id mess was.
> 
> In short, KEEP IT SIMPLE!
> 
> Then, after we are comfortable with stuff like the above, slowly think
> about moving the line back a bit more, if you really even need to.  But
> why would you need to?  Only reason I can think of is if you wanted to
> write an entire bus in rust, and for right now, I would strongly suggest
> anyone not attempt that.

We're not trying to do that. Also, please note that all the abstractions are
*only* making use of APIs that C drivers use directly, just abstracting them
in a way, such that we can actually use the strength of Rust.

> 
> The "joy" of writing a driver in rust is that a driver consumes from
> EVERYWHERE in the kernel (as you well know.)  Having to write bindings
> and mappings for EVERYTHING all at once, when all you really want to do
> is implement the logic between probe/remove is rough, I'm sorry.  I'm
> suggesting that you stop at the above line for now, which should make
> your life easier as the .c code is obviously correct, and anything you
> do in the rust side is your problem, not mine as a bus maintainer :)

As explained above, we already have the module abstraction in place. Really all
that we're left with is creating the struct pci_driver and call register() /
remove() from it.

Now, this could be fully done in the PCI abstraction. The only reason we have
the `Registration` and `DriverOps` (again there are a few misunderstandings
around that, that I try to clarify in the corresponding thread) in "driver.rs"
is to not duplicate code for maintainability.

What I'm trying to say, the stuff in "driver.rs" is not even abstracting things
from drivers/base/, but is Rust helper code for subsystems to abstract their
stuff (e.g. struct pci_driver).

And again, I'm willing to take responsibility for the code and offer to maintain
it - I really want to do this the proper way.

- Danilo

(cutting of the rest since it was based on the misunderstanding mentioned above)


