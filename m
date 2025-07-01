Return-Path: <linux-pci+bounces-31151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8431BAEF548
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 12:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439137A730D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BD826D4D4;
	Tue,  1 Jul 2025 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFTovyDT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B8239E6A;
	Tue,  1 Jul 2025 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366411; cv=none; b=HiN8+/bR96J78EJhwTJloE3u/6trinwLn4NE+vC4otCitxeiZI/tiYifdpajA+E7C9tnbpB9GR+gjMA7/IoebrXQ5Q9ixkCRvyR899Pb2LeAGuLnqsvBc/6+m7GUw+AFvaLk5ssRuqI/Z8nhlCo5gRUJVptHgaXwWT0xabQVbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366411; c=relaxed/simple;
	bh=4q5eEKQGOug08pTmwxuaY7C2xv4i14LRs5CG9K+y0G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdqV9FVweF1+n6SIR5Lk7WHZounHGtAKcuHt3rftEBj9sEYoHWt0AK/guD0Hk9DeJZz6uUmhXh4m8nCKKUailfTHQY72dtex7nVCTs0sARCUw+9OLg5ndqY8pAIT5TVNysc40DH0uYK/GoegVEiDmi+YluRfRwxraKuvwg5BtVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFTovyDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BE0C4CEEB;
	Tue,  1 Jul 2025 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751366411;
	bh=4q5eEKQGOug08pTmwxuaY7C2xv4i14LRs5CG9K+y0G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFTovyDTaAKvJDx/A2lxFYmJRzlAKblZsTueQ6e/os0Y3FO0JdpTM0hWqUu3oGYFO
	 Cp4x2bSHKxvCrnR0+oukwjNl6akJhjhUJBj/WO2lUlP6PPjtEzSEg1xxXrLscvkBm2
	 TK5s0kckgLcPJzMV1PXOWIgfYf0M1nK8B+D1b5AO/c+neBBsWq1/eGiHgQOJXb/knO
	 bDC2QV9qmb9xgjcnD8xR8ILXVqGUqt52iKdLbc3GkfYjd8o1V52O27qatIK4NyvhGl
	 kRqdIYsYUL4V3LcNRTe605PUfF/cvDRv8RO6I3hQe2v7mFeDAcmhy3gbySuufBeire
	 13rq4mkgCFrRw==
Date: Tue, 1 Jul 2025 12:40:04 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/8] Device: generic accessors for drvdata +
 Driver::unbind()
Message-ID: <aGO7BP1t-A_CQ700@pollux>
References: <20250621195118.124245-1-dakr@kernel.org>
 <2025070142-difficult-lucid-d949@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025070142-difficult-lucid-d949@gregkh>

On Tue, Jul 01, 2025 at 11:25:41AM +0200, Greg KH wrote:
> On Sat, Jun 21, 2025 at 09:43:26PM +0200, Danilo Krummrich wrote:
> > This patch series consists of the following three parts.
> > 
> >   1. Introduce the 'Internal' device context (semantically identical to the
> >      'Core' device context), but only accessible for bus abstractions.
> > 
> >   2. Introduce generic accessors for a device's driver_data  pointer. Those are
> >      implemented for the 'Internal' device context only, in order to only enable
> >      bus abstractions to mess with the driver_data pointer of struct device.
> > 
> >   3. Implement the Driver::unbind() callback (details below).
> > 
> > Driver::unbind()
> > ----------------
> > 
> > Currently, there's really only one core callback for drivers, which is
> > probe().
> > 
> > Now, this isn't entirely true, since there is also the drop() callback of
> > the driver type (serving as the driver's private data), which is returned
> > by probe() and is dropped in remove().
> > 
> > On the C side remove() mainly serves two purposes:
> > 
> >   (1) Tear down the device that is operated by the driver, e.g. call bus
> >       specific functions, write I/O memory to reset the device, etc.
> > 
> >   (2) Release the resources that have been allocated by a driver for a
> >       specific device.
> > 
> > The drop() callback mentioned above is intended to cover (2) as the Rust
> > idiomatic way.
> > 
> > However, it is partially insufficient and inefficient to cover (1)
> > properly, since drop() can't be called with additional arguments, such as
> > the reference to the corresponding device that has the correct device
> > context, i.e. the Core device context.
> 
> I'm missing something, why doesn't drop() have access to the device
> itself, which has the Core device context?  It's the same "object",
> right?

Not exactly, the thing in drop() is the driver's private data, which has the
exact lifetime of a driver being bound to a device, which makes drop() pretty
much identical to remove() in this aspect.

	// This is the private data of the driver.
	struct MyDriver {
	   bar: Devres<pci::Bar>,
	   ...
	}

	impl pci::Driver for MyDriver {
	   fn probe(
	      pdev: &pci::Device<Core>,
	      info: &Self::IdInfo
	   ) -> Result<Pin<KBox<Self>>> {
	      let bar = ...;
	      pdev.enable_device()?;

	      KBox::pin_init(Self { bar }, GFP_KERNEL)
	   }

	   fn unbind(&self, pdev: &Device<Core>) {
	      // Can only be called with a `&Device<Core>`.
	      pdev.disable_device();
	   }
	}

	impl Drop for MyDriver {
	   fn drop(&mut self) {
	      // We don't need to do anything here, the destructor of `self.bar`
	      // is called automatically, which is where the PCI BAR is unmapped
	      // and the resource region is released. In fact, this impl block
	      // is optional and can be omitted.
	   }
	}

The probe() method's return value is the driver's private data, which, due to
being a ForeignOwnable, is stored in dev->driver_data by the bus abstraction.

The lifetime goes until remove(), which is where the bus abstraction does not
borrow dev->driver_data, but instead re-creates the original driver data object,
which subsequently in the bus abstraction's remove() function goes out of scope
and hence is dropped.

From the bus abstraction side of things it conceptually looks like this:

	 extern "C" fn probe_callback(pdev, ...) {
	    let data = T::probe();

	    pdev.as_ref().set_drvdata(data);
	 }

	extern "C" fn remove_callback(pdev) {
	   let data = unsafe { pdev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() }

	   T::unbind(pdev, data.as_ref());
	} // data.drop() is called here, since data goes out of scope.

> > This makes it inefficient (but not impossible) to access device
> > resources, e.g. to write device registers, and impossible to call device
> > methods, which are only accessible under the Core device context.
> > 
> > In order to solve this, add an additional callback for (1), which we
> > call unbind().
> > 
> > The reason for calling it unbind() is that, unlike remove(), it is *only*
> > meant to be used to perform teardown operations on the device (1), but
> > *not* to release resources (2).
> 
> Ick.  I get the idea, but unbind() is going to get confusing fast.
> Determining what is, and is not, a "resource" is going to be hard over
> time.  In fact, how would you define it?  :)

I think the definition is simple: All teardown operations a driver needs a
&Device<Core> for go into unbind().

Whereas drop() really only is the destructor of the driver's private data.

> Is "teardown" only allowed to write to resources, but not free them?

"Teardown" is everything that involves interaction with the device when the
driver is unbound.

However, we can't free things there, that happens in the automatically when the
destructor of the driver's private data is called, i.e. in drop().

> If so, why can't that happen in drop() as the resources are available there.

For instance, some functions can only be implemented for a &Device<Core>, such
as pci_disable_device(), which hence we can't call from drop().

> I'm loath to have a 2-step destroy system here for rust only, and not
> for C, as maintaining this over time is going to be rough.

Why do you think so? To me it seems pretty clean to separate the "unbind()
teardown sequence" from the destructor of the driver's private data, even if
there wouldn't be a technical reason to do so.

