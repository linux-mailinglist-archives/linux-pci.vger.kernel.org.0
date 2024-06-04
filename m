Return-Path: <linux-pci+bounces-8247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BDF8FB844
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 18:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7B91F2240F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E741F13D2AB;
	Tue,  4 Jun 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UvAm38Wh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8B13D24C;
	Tue,  4 Jun 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516827; cv=none; b=AWhZRpke+sY+3HPbR+pjIJ210nmQ8wO2DftWBdwjqyqLDJ2nFcGD4Nmw9SGa10npJxEX0bDWRpcknSqA2mhovieGR1jmKQ10CFGE/2vN7zrwhFBbUCrwwIKeF7XbQFa/Td95y4Ub16srrvOjT6vB1RAJPrNvNbhggJAanpeDqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516827; c=relaxed/simple;
	bh=BxCSO+fGtXTUJMw9EKNtVRrbNiOWFPCkp6QfB+XW/ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXIfHYh2v+QlTJcD9UR39VbhH24XXoEphcgFWf2lzt/7g/2SmnDnWs0xpWmi1vSiY/8ufHwzKdTmebdoodwubZaMVsjdu64/OjzCLanbkoRi5KKdWXy03NUR/eOMhgeoasNMTgZc19r5dyYliKXrqidL2JzhSwzoETY4xgY+0Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UvAm38Wh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48161C2BBFC;
	Tue,  4 Jun 2024 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717516827;
	bh=BxCSO+fGtXTUJMw9EKNtVRrbNiOWFPCkp6QfB+XW/ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvAm38WhzO8Qb/h0lksWwkAkeBuBLrpV8ICbpLssLATGPP/n1PPw4szKNAcmtgzZU
	 ZjZFnBUCx+uRZxuNFNZrv/w7Ha/wvx/OIQYqdtLx0TE0SXhDjYo+uMDFLsbH9gem8B
	 jVvEHUm7utX33vuQF25fcCRxz1rHKXpDH1ZjnMKI=
Date: Tue, 4 Jun 2024 18:00:11 +0200
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
Subject: Re: [RFC PATCH 02/11] rust: add driver abstraction
Message-ID: <2024060404-figment-resolute-7c6c@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-3-dakr@redhat.com>
 <2024052045-lived-retiree-d8b9@gregkh>
 <ZkvPDbAQLo2/7acY@pollux.localdomain>
 <2024052155-pulverize-feeble-49bb@gregkh>
 <Zk0egew_AxvNpUG-@pollux>
 <2024060432-chloride-grappling-cf95@gregkh>
 <Zl81oUmNO5TX063x@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl81oUmNO5TX063x@cassiopeiae>

On Tue, Jun 04, 2024 at 05:41:21PM +0200, Danilo Krummrich wrote:
> On Tue, Jun 04, 2024 at 04:27:31PM +0200, Greg KH wrote:
> > On Wed, May 22, 2024 at 12:21:53AM +0200, Danilo Krummrich wrote:
> > > On Tue, May 21, 2024 at 11:35:43AM +0200, Greg KH wrote:
> > > > On Tue, May 21, 2024 at 12:30:37AM +0200, Danilo Krummrich wrote:
> > > > > On Mon, May 20, 2024 at 08:14:18PM +0200, Greg KH wrote:
> > > > > > On Mon, May 20, 2024 at 07:25:39PM +0200, Danilo Krummrich wrote:
> > > > > > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > > > > 
> > > > > > > This defines general functionality related to registering drivers with
> > > > > > > their respective subsystems, and registering modules that implement
> > > > > > > drivers.
> > > > > > > 
> > > > > > > Co-developed-by: Asahi Lina <lina@asahilina.net>
> > > > > > > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > > > > > > Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
> > > > > > > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> > > > > > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > > > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > > > > > ---
> > > > > > >  rust/kernel/driver.rs        | 492 +++++++++++++++++++++++++++++++++++
> > > > > > >  rust/kernel/lib.rs           |   4 +-
> > > > > > >  rust/macros/module.rs        |   2 +-
> > > > > > >  samples/rust/rust_minimal.rs |   2 +-
> > > > > > >  samples/rust/rust_print.rs   |   2 +-
> > > > > > >  5 files changed, 498 insertions(+), 4 deletions(-)
> > > > > > >  create mode 100644 rust/kernel/driver.rs
> > > > > > > 
> > > > > > > diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..e0cfc36d47ff
> > > > > > > --- /dev/null
> > > > > > > +++ b/rust/kernel/driver.rs
> > > > > > > @@ -0,0 +1,492 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > +
> > > > > > > +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
> > > > > > > +//!
> > > > > > > +//! Each bus/subsystem is expected to implement [`DriverOps`], which allows drivers to register
> > > > > > > +//! using the [`Registration`] class.
> > > > > > 
> > > > > > Why are you creating new "names" here?  "DriverOps" is part of a 'struct
> > > > > > device_driver' why are you separating it out here?  And what is
> > > > > 
> > > > > DriverOps is a trait which abstracts a subsystems register() and unregister()
> > > > > functions to (un)register drivers. It exists such that a generic Registration
> > > > > implementation calls the correct one for the subsystem.
> > > > > 
> > > > > For instance, PCI would implement DriverOps::register() by calling into
> > > > > bindings::__pci_register_driver().
> > > > > 
> > > > > We can discuss whether DriverOps is a good name for the trait, but it's not a
> > > > > (different) name for something that already exists and already has a name.
> > > > 
> > > > It's a name we don't have in the C code as the design of the driver core
> > > > does not need or provide it.  It's just the section of 'struct
> > > > device_driver' that provides function callbacks, why does it need to be
> > > > separate at all?
> > > 
> > > I'm confused by the relationship to `struct device_driver` you seem to imply.
> > > How is it related?
> > > 
> > > Again, this is just a trait for subsystems to provide their corresponding
> > > register and unregister implementation, e.g. pci_register_driver() and
> > > pci_unregister_driver(), such that they can be called from the generic
> > > Registration code below.
> > > 
> > > See [1] for an example implementation in PCI.
> > 
> > registering and unregistering drivers belongs in the bus code, NOT in
> > the driver code.
> 
> Why? We're not (re-)implementing a bus here. Again, those are just abstractions
> to call the C functions to register a driver. The corresponding C functions are
> e.g. driver_register() or __pci_register_driver(). Those are defined in
> drivers/base/driver.c and drivers/pci/pci-driver.c respectively.
> 
> Why wouldn't we follow the same scheme in Rust abstractions?

It's the bus that does the registering, so yeah, don't put it here at
all as it's not going to be needed (i.e. unless you write a bus in rust
you will never call driver_register())  So this can just be a wrapper
for the pci bus logic, keeping it simpler.

So you might be able to delete a lot of code here, only deal with a
"dumb" struct device wrapper to handle reference counts, and then do the
rest for the specific bus bindings?  Or is that too much to dream?

You aren't writing a "raw" driver here, no one does that, it's a bus
that handles that logic for you, and you should not have to expose any
"raw" driver attributes.

Yes, for some busses, they like to force a driver to set the "raw"
driver attribute, but I don't think that's a good idea and for the pci
driver layer, that shouldn't be necessary now, right?  If not, what
fields are you wanting to get direct access to?

thanks,

greg k-h

