Return-Path: <linux-pci+bounces-8268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B2B8FBD12
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 22:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0EC1F25EB0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3314D28A;
	Tue,  4 Jun 2024 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQyJX+fX"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04C14B976
	for <linux-pci@vger.kernel.org>; Tue,  4 Jun 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531604; cv=none; b=DKspBXZI8Ru+BUZrX6yM93JN6xzWkFFMEVQQKDpVpCcyVM89wP3p8QSXhXHCyJu/8L8dV0MnncTf5cRVTLTWWm/9bzyr6bKLdLOWPX/zV5Ggq22742g5MQDVxe0JcKmmmSfOLMSMl5uQbYb79L3ufdwEjFaQGUW2S+OgDnffuBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531604; c=relaxed/simple;
	bh=aSCQYI2hmOCD/IbP1xwsFpZTAcY2IeBlcORVlIkjZRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOFBH4945mXASPhCEANpAwAOLlP0xEPiCHAubNijGyTezW82lnnYLQgSBSaKZTujc3LomHZCjM4aqy0E9IvabR2q8nJDtz9xwLczBz4uv1rlbBAeEPUeo19ee5k6huHe4s2vqW5IU+7ynoLry5Al/3xsIm68Gt9kVo1sI0JMiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQyJX+fX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717531600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOQwPW0aG2Foum3BxxDnBe7vRUHsrv0pioUfgn6NI/E=;
	b=BQyJX+fXhYiIxejCwt/8jux9rWaiqqJaGdHmJSXmS3TNP9RKqQogzMdFBW3J4utzUplteT
	MHVV+i5Xfi7OFVmLoEBJfF8KwQzUEH8UvobqT6Zfx51WH1lKj6FdBU/wj/5YLFy/zE51Z7
	strAlipYrHrmkx8NNs8bbQbpKGRBh7w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-y0Q4NyEIMZWm_-Bn453m_A-1; Tue, 04 Jun 2024 16:06:37 -0400
X-MC-Unique: y0Q4NyEIMZWm_-Bn453m_A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42133ebdf24so30706195e9.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2024 13:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717531596; x=1718136396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOQwPW0aG2Foum3BxxDnBe7vRUHsrv0pioUfgn6NI/E=;
        b=vokSd8nQg+B/D/3EFn7MCFIyZo0d/SbTl0ar3jmQHSwu2L7zCEXxcXFRt2UO3DaqPF
         pdylBlhbyBauEEJeVYbxc06FUClqdtBFUYqbRbov1NmCISfvg4i5/k8JvzxYa5YTFiaE
         YtMAwVBvA+Bis/CpFn6FtMYG0cBuIkESOzliT2HDvbOJKLR44u/OsiRUPO+byGVb1OpX
         ujJyR0rsnmaGrUEqhPL7DlIs1oSXOk/n8tpEtv4WxqI269Xvts9fWR2039vAf3j6USrM
         44L6QjQcSFHwBaYYV708V4qReyYnSZhPHvq/MScsutLcys2L5K9ed49lgfmbGBjxvZxP
         sgAw==
X-Forwarded-Encrypted: i=1; AJvYcCVuhGNI1WpRM50sbAC17OsC4puI74K+E6CF7/gumewbypYMOArCly5MondkEUV9rA2/mXDe0thnqK1ZQqYdA8Ql2eN+RjXaEfnP
X-Gm-Message-State: AOJu0YxzKmk59g8YupGj6nph+S9bjdC70lvCNkc+Ru56fXUEP2rnvOjh
	7lJfgwZuJo0J0PIJNgtMTyz3EXko5uSPq1SwKAJc+C8/SqJ/P0UJtrvpR6e4yfnHM5/KGH2tLqZ
	YHg0tK3B8XXeAzYTw3YP/TpEZVB0NA5jarJB4Zs9+NwkJdHiIH9t+2XKaOQ==
X-Received: by 2002:a05:600c:3c97:b0:41a:c170:701f with SMTP id 5b1f17b1804b1-42156356ac6mr3558025e9.38.1717531596366;
        Tue, 04 Jun 2024 13:06:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvgnv3dsKpQRLAsQ3oX8Eyk4WLvjXVlc3Cl2eoNi52H9/3hBfkpYiRdpbspAeOhGIOZiuWIQ==
X-Received: by 2002:a05:600c:3c97:b0:41a:c170:701f with SMTP id 5b1f17b1804b1-42156356ac6mr3557815e9.38.1717531595889;
        Tue, 04 Jun 2024 13:06:35 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42138260c5asm123349765e9.41.2024.06.04.13.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 13:06:35 -0700 (PDT)
Date: Tue, 4 Jun 2024 22:06:33 +0200
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
Subject: Re: [RFC PATCH 02/11] rust: add driver abstraction
Message-ID: <Zl9zybWIeZqt8tWc@pollux>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-3-dakr@redhat.com>
 <2024052045-lived-retiree-d8b9@gregkh>
 <ZkvPDbAQLo2/7acY@pollux.localdomain>
 <2024052155-pulverize-feeble-49bb@gregkh>
 <Zk0egew_AxvNpUG-@pollux>
 <2024060432-chloride-grappling-cf95@gregkh>
 <Zl81oUmNO5TX063x@cassiopeiae>
 <2024060404-figment-resolute-7c6c@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024060404-figment-resolute-7c6c@gregkh>

On Tue, Jun 04, 2024 at 06:00:11PM +0200, Greg KH wrote:
> On Tue, Jun 04, 2024 at 05:41:21PM +0200, Danilo Krummrich wrote:
> > On Tue, Jun 04, 2024 at 04:27:31PM +0200, Greg KH wrote:
> > > On Wed, May 22, 2024 at 12:21:53AM +0200, Danilo Krummrich wrote:
> > > > On Tue, May 21, 2024 at 11:35:43AM +0200, Greg KH wrote:
> > > > > On Tue, May 21, 2024 at 12:30:37AM +0200, Danilo Krummrich wrote:
> > > > > > On Mon, May 20, 2024 at 08:14:18PM +0200, Greg KH wrote:
> > > > > > > On Mon, May 20, 2024 at 07:25:39PM +0200, Danilo Krummrich wrote:
> > > > > > > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > > > > > 
> > > > > > > > This defines general functionality related to registering drivers with
> > > > > > > > their respective subsystems, and registering modules that implement
> > > > > > > > drivers.
> > > > > > > > 
> > > > > > > > Co-developed-by: Asahi Lina <lina@asahilina.net>
> > > > > > > > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > > > > > > > Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
> > > > > > > > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> > > > > > > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > > > > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > > > > > > ---
> > > > > > > >  rust/kernel/driver.rs        | 492 +++++++++++++++++++++++++++++++++++
> > > > > > > >  rust/kernel/lib.rs           |   4 +-
> > > > > > > >  rust/macros/module.rs        |   2 +-
> > > > > > > >  samples/rust/rust_minimal.rs |   2 +-
> > > > > > > >  samples/rust/rust_print.rs   |   2 +-
> > > > > > > >  5 files changed, 498 insertions(+), 4 deletions(-)
> > > > > > > >  create mode 100644 rust/kernel/driver.rs
> > > > > > > > 
> > > > > > > > diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..e0cfc36d47ff
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/rust/kernel/driver.rs
> > > > > > > > @@ -0,0 +1,492 @@
> > > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > > +
> > > > > > > > +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
> > > > > > > > +//!
> > > > > > > > +//! Each bus/subsystem is expected to implement [`DriverOps`], which allows drivers to register
> > > > > > > > +//! using the [`Registration`] class.
> > > > > > > 
> > > > > > > Why are you creating new "names" here?  "DriverOps" is part of a 'struct
> > > > > > > device_driver' why are you separating it out here?  And what is
> > > > > > 
> > > > > > DriverOps is a trait which abstracts a subsystems register() and unregister()
> > > > > > functions to (un)register drivers. It exists such that a generic Registration
> > > > > > implementation calls the correct one for the subsystem.
> > > > > > 
> > > > > > For instance, PCI would implement DriverOps::register() by calling into
> > > > > > bindings::__pci_register_driver().
> > > > > > 
> > > > > > We can discuss whether DriverOps is a good name for the trait, but it's not a
> > > > > > (different) name for something that already exists and already has a name.
> > > > > 
> > > > > It's a name we don't have in the C code as the design of the driver core
> > > > > does not need or provide it.  It's just the section of 'struct
> > > > > device_driver' that provides function callbacks, why does it need to be
> > > > > separate at all?
> > > > 
> > > > I'm confused by the relationship to `struct device_driver` you seem to imply.
> > > > How is it related?
> > > > 
> > > > Again, this is just a trait for subsystems to provide their corresponding
> > > > register and unregister implementation, e.g. pci_register_driver() and
> > > > pci_unregister_driver(), such that they can be called from the generic
> > > > Registration code below.
> > > > 
> > > > See [1] for an example implementation in PCI.
> > > 
> > > registering and unregistering drivers belongs in the bus code, NOT in
> > > the driver code.
> > 
> > Why? We're not (re-)implementing a bus here. Again, those are just abstractions
> > to call the C functions to register a driver. The corresponding C functions are
> > e.g. driver_register() or __pci_register_driver(). Those are defined in
> > drivers/base/driver.c and drivers/pci/pci-driver.c respectively.
> > 
> > Why wouldn't we follow the same scheme in Rust abstractions?
> 
> It's the bus that does the registering, so yeah, don't put it here at
> all as it's not going to be needed (i.e. unless you write a bus in rust
> you will never call driver_register())  So this can just be a wrapper
> for the pci bus logic, keeping it simpler.

We never call driver_register() of course, I gave this example for another
reason above. Sorry if that was confusing.

> 
> So you might be able to delete a lot of code here, only deal with a
> "dumb" struct device wrapper to handle reference counts, and then do the
> rest for the specific bus bindings?  Or is that too much to dream?

Again, this is a generalization such that we do not have to replicate code for
every subsystem / bus. Please see the full explanation below.

> 
> You aren't writing a "raw" driver here, no one does that, it's a bus
> that handles that logic for you, and you should not have to expose any
> "raw" driver attributes.

Indeed - we're not doing that here.

> 
> Yes, for some busses, they like to force a driver to set the "raw"
> driver attribute, but I don't think that's a good idea and for the pci
> driver layer, that shouldn't be necessary now, right?  If not, what
> fields are you wanting to get direct access to?

Honestly, this all reads as if you did not (carefully) read the code we're
discussing about in the first place, did you?

It reads more as if you take assumptions based on my previous explanations, and
since communication is difficult, it looks like we're talking past each other.
Maybe also my explanations were just not good enough. :(

Either way, I suggest to focus more on the actual code. In particular let's have
a look at the `Registration` and `DriverOps` struct from this patch and how
they're used in the PCI code and in an actual driver.

Please have a look at how the PCI code implements the `DriverOps` trait (or
interface as many other languages would call it) [1]. In `DriverOps::register`
and `DriverOps::unregister` the PCI code simply calls the C functions
__pci_register_driver() and pci_unregister_driver().

A driver can use the `module_pci_driver!` macro [2] to declare a kernel module
that registers a single PCI driver. This is equivalent to C's
module_pci_driver() macro.

The `module_pci_driver!` macro calls the generic `module_driver!` macro [3] and
passes the `pci::Adapter` [1] (the PCI thing that actually calls the C
pci_{un}register_driver() functions).

The `module_driver!` macro creates a new `Module` structure [4] that holds the
`Registration` structure. This `Registration` structure has a generic argument
which is the `pci::Adapter` [1]. Which means that once the `Registration` is
created C's __pci_register_driver() is called and once it is destroyed C's
pci_unregister_driver() is called. The `Registration` is created in
module_init() and destroyed in module_exit() accordingly.

So, as you can see a `Registration` is really just the parts generalized that
otherwise every subsystem would need to implement and `DriverOps` is the glue
between a driver `Registration` and the subsystem (e.g. PCI) defining which
function to call on driver register() or driver unregister().

My argument above is simply that since  all this is just the abstraction to
declare a driver structure and register it, it belongs into driver.rs. At least
if we want to go along with where the C side places the correspong functions on
the C side.

(The links already point to the new code that allocates the driver statically,
but this should not matter, since conceptually it's the same.)

[1] https://gitlab.freedesktop.org/drm/nova/-/blob/989338f129146af9952304c2cc6b33fbd90e8909/rust/kernel/pci.rs#L24
[2] https://gitlab.freedesktop.org/drm/nova/-/blob/989338f129146af9952304c2cc6b33fbd90e8909/rust/kernel/pci.rs#L135
[3] https://gitlab.freedesktop.org/drm/nova/-/blob/989338f129146af9952304c2cc6b33fbd90e8909/rust/kernel/driver.rs#L453
[4] https://gitlab.freedesktop.org/drm/nova/-/blob/989338f129146af9952304c2cc6b33fbd90e8909/rust/kernel/driver.rs#L435

> 
> thanks,
> 
> greg k-h
> 


