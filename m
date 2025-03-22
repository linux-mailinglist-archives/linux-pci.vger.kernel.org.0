Return-Path: <linux-pci+bounces-24437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17B5A6C8F2
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 11:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438DE170C43
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 10:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176B1F4634;
	Sat, 22 Mar 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsWK3eIF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE31F37CE;
	Sat, 22 Mar 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638257; cv=none; b=F74WKqGU5r9goS1bTqeuv5kLRnrJ022DafzFFfHkkTurBNEaxPsUBBxCM53e00ROyTAZ2GlK43F562rnT3dIwHNy0+J9JSj7QdGEuF/1APpD1ICf4hG1wHdJ9DIV+XzpoCj8eGrMRzTp2O7eHCWO5oVu6RFS4MkIM9IPArX/Y3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638257; c=relaxed/simple;
	bh=s5SsZ1ZfndtxDRrW4P12D0A21t0bU6sBDxfleux/0uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAyUZlo6P0/iMYZbw3/cv0Ni6KUfLhC2tomW4nsrShJ8qG6NcMabC9YuWrpYpOMTXgMEezdVYiJJRgo5Fc1c9swfv6NsngbRiPPXmINgfq2PtQDxdNjBWXAQ8wgnACfdgp1U4Wh6iZ6XEie+l/SY1AemWW93XhwKRPPnte7tMxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsWK3eIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40E2C4CEE9;
	Sat, 22 Mar 2025 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638257;
	bh=s5SsZ1ZfndtxDRrW4P12D0A21t0bU6sBDxfleux/0uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BsWK3eIFYMcUcy1Z5eM8u03+bcapNKK46RHNpRtZHnm3pon4s9JTzepGl+8but9Bi
	 gY33Lmtfm7iLJalJDYY9ofnutGwNbuNhI/zKQp+24WlMHWJvYYQqqhfVnRCl2Vsum0
	 4ywkwlT1wpmnryS6IqUra7U5btGujaL2VjEBP4Ml4Qxc2kFLRhvnltdtKydals44DN
	 E5MYMFA3XD15NnRh+WWGPUnM5alkv9f6zba0qUGPeJqKurh33HzzjYkuKSnIKtI8rp
	 VQtNGacLRi+f7P2L3VrnPY2L1dksWCSNAIw8aQF1KsWAN8nNxkSS4cXD2BxnHsCC1J
	 o/PQaYxt/FrXw==
Date: Sat, 22 Mar 2025 11:10:52 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <Z96MrGQvpVrFqWYJ@pollux>
References: <20250321214826.140946-1-dakr@kernel.org>
 <20250321214826.140946-3-dakr@kernel.org>
 <2025032158-embezzle-life-8810@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025032158-embezzle-life-8810@gregkh>

On Fri, Mar 21, 2025 at 08:25:07PM -0700, Greg KH wrote:
> On Fri, Mar 21, 2025 at 10:47:54PM +0100, Danilo Krummrich wrote:
>
> Yes, over time, many subsystems were forced to come up with ways of
> determining the device type, look at dev_is_pci() and where it's used
> all over the place (wait, why can't you just use that here too?)

It's a macro and bindgen doesn't pick it up for us to use.

> But
> those usages are the rare exception.  And I still think that was the
> wrong choice.
> 
> What I don't want to see is this type of function to be the only way you
> can get a pci device from a struct device in rust.

I see where you're coming from and I totally agree with that.

The goal is to cover as much as possible by the corresponding abstractions, such
that the abstraction already provide the driver with the correct (device) type,
just like the bus callbacks do.

We can do the same thing with IOCTLs, sysfs ops, etc. The miscdevice
abstractions are a good example for this. The DRM abstractions will also provide
the DRM device (typed to its corresponding driver) for all DRM IOCTLs a driver
registers.

> That's going to be
> messy as that is going to be a very common occurance (maybe, I haven't
> seen how you use this), and would force everyone to always test the
> return value, adding complexity and additional work for everyone, just
> because the few wants it.

Given the above, I think in most cases we are (and plan to be) a step ahead and
(almost) never have the driver in the situation that it ever needs any
container_of() like thing, because the abstraction already provides the correct
type.

However, there may be some rare exceptions, where we need the driver to
"upcast", more below.

> So where/how are you going to use this?  Why can't you just store the
> "real" reference to the pci device?  If you want to save off a generic
> device reference, where did it come from?  Why can't you just explicitly
> save off the correct type at the time you stored it?  Is this just
> attempting to save a few pointers?  Is this going to be required to be
> called as the only way to get from a device to a pci device in a rust
> driver?

As mentioned above, wherever the abstraction can already provide the correct
(device) type to the driver, that's what we should do instead.

One specific use-case I see with this is for the auxiliary bus and likely MFD,
where we want to access the parent of a certain device.

For instance, in nova-drm we'll probe against an auxiliary device registered by
nova-core. nova-drm will use its auxiliary device to call into nova-core.
nova-core can then validate that it is the originator of the auxiliary device
(e.g. by name and ID, or simply pointer comparison).

Subsequently, nova-core can find its (in this case) pci::Device instance through
the parent device (Note that I changed this, such that you can only get the
parent device from an auxiliary::Device, as discussed).

	pub fn some_operation(adev: &auxiliary::Device, ...) -> ... {
	   // validate that `adev` was created by us

	   if let Some(parent) = adev.parent() {
              let pdev: &pci::Device = parent.try_into()?;
	      ...
	   }
	}

Now, I understand that your concern isn't necessarily about the fact that we
"upcast", but that it is fallible.

And you're not wrong about this, nova-core knows for sure that the parent device
must be its PCI device, since it can indeed validate that the auxiliary device
was created and registered by itself.

However, any other API that does not validate that `parent` is actually a
pci::Device in the example above would be fundamentally unsafe. And I think we
don't want to give out unsafe APIs to drivers.

Given that this is only needed in very rare cases (since most of the time the
driver should be provided with the correct type directly) I'm not concerned
about the small overhead of the underlying pointer comparison. It's also not
creating messy code as it would be in C.

In C it would be

		struct pci_dev *pdev;

		if (!dev_is_pci(parent))
			return -EINVAL;

		pdev = to_pci_dev(parent);

Whereas in Rust it's only

		let pdev: &pci::Device = parent.try_into()?;

and without any validation in Rust

		// SAFETY: explain why this is safe to do
		let pdev = unsafe { pci::Device::from_device(parent) };

> Along these lines, if you can convince me that this is something that we
> really should be doing, in that we should always be checking every time
> someone would want to call to_pci_dev(), that the return value is
> checked, then why don't we also do this in C if it's going to be
> something to assure people it is going to be correct?  I don't want to
> see the rust and C sides get "out of sync" here for things that can be
> kept in sync, as that reduces the mental load of all of us as we travers
> across the boundry for the next 20+ years.

I think in this case it is good when the C and Rust side get a bit
"out of sync":

For most of the cases where we can cover things through the type system and
already provide the driver with the correct object instance from the get-go,
that's a great improvement over C.

For the very rare cases where we have to "upcast", I really think it's better to
uphold providing safe APIs to drivers, rather than unsafe ones.

