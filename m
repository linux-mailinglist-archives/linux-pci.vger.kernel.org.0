Return-Path: <linux-pci+bounces-18055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CA89EBDEE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B58428195D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D52F1F1917;
	Tue, 10 Dec 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzVrKZVN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB11F190E;
	Tue, 10 Dec 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870325; cv=none; b=d25RupwDaW0hQna2RW2N25HqQkwmlMQh1gYmQFjacvltGm97/WpSZFq5YO3ATaeFPNeYeFLYa8Tx6aaN31QxgummdonVDDfFMZ3LZfd3sO9We7wSB4dCEWvbfoQQwXnD+DSKg3q7kmjyFv+SEXTYKmTAPtgG03bfZKRy/s1xT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870325; c=relaxed/simple;
	bh=Pj68NnG+ybo7R+I0+KAmmUzmxouhp3o3i9jOI5/YzPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIO7OvQoThyyY/CIHladDkyr6h3tWDt18bsd1Aucalnh29aK+Q2iVkYAm9hztxFi6WeUylCUMySBhB2jedqm0fGBUrmcZXhNIzeXP5TPc1tfTnmUmIDRfKpaBeWGIoCS0K5j4hppRPXDTRQT7KxieCKLD3nfmrpB+ghHV3ZbImk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzVrKZVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5EDC4CED6;
	Tue, 10 Dec 2024 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733870324;
	bh=Pj68NnG+ybo7R+I0+KAmmUzmxouhp3o3i9jOI5/YzPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzVrKZVNRJiLoSUEuo1TpKdQM2qzf9EH6SeE4GOi2QcOGR1RIkMx9T7LRdl+O7QSX
	 pBFkX0x/F1kfejU11v+oadbwE0JW8sZt4YSsXplhZRM5PFhmb+gHUKdPpyXja6ffBw
	 RIbh5cUNxGalxpDbm3N+fjMsvKaO89GzMCJq7vBxJDhjyoXiR9p2xSQ0ahqD1Fb27D
	 aM2aLjG5Gs77Vf47t9fMGRJ67Vg+lRr1cVvVwWOy4aIgiLtPZusIuomYKAZnuzpldX
	 kiR521E9weditQmzRp1uJgiEkNI5pkJIseU+tqCFr776RGoplT61bQ2/wikKX68c7N
	 btIz1q3EhvvcQ==
Date: Tue, 10 Dec 2024 23:38:36 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 08/13] rust: pci: add basic PCI device / driver
 abstractions
Message-ID: <Z1jC7NnmwidLPT9Z@pollux>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-9-dakr@kernel.org>
 <CAH5fLgh6qgQ=SBn17biSRbqO8pNtSEq=5fDY3iuGzbuf2Aqjeg@mail.gmail.com>
 <Z1bKA5efDYxd8sTC@pollux.localdomain>
 <CAH5fLgixvBWSf-3WDRj=Mxtn4ArQLqdKqMF0aSxyC6xVNPfTFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgixvBWSf-3WDRj=Mxtn4ArQLqdKqMF0aSxyC6xVNPfTFQ@mail.gmail.com>

On Tue, Dec 10, 2024 at 11:55:33AM +0100, Alice Ryhl wrote:
> On Mon, Dec 9, 2024 at 11:44 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Fri, Dec 06, 2024 at 03:01:18PM +0100, Alice Ryhl wrote:
> > > On Thu, Dec 5, 2024 at 3:16 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > >
> > > > Implement the basic PCI abstractions required to write a basic PCI
> > > > driver. This includes the following data structures:
> > > >
> > > > The `pci::Driver` trait represents the interface to the driver and
> > > > provides `pci::Driver::probe` for the driver to implement.
> > > >
> > > > The `pci::Device` abstraction represents a `struct pci_dev` and provides
> > > > abstractions for common functions, such as `pci::Device::set_master`.
> > > >
> > > > In order to provide the PCI specific parts to a generic
> > > > `driver::Registration` the `driver::RegistrationOps` trait is implemented
> > > > by `pci::Adapter`.
> > > >
> > > > `pci::DeviceId` implements PCI device IDs based on the generic
> > > > `device_id::RawDevceId` abstraction.
> > > >
> > > > Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > >
> > > > +/// The PCI device representation.
> > > > +///
> > > > +/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
> > > > +/// device, hence, also increments the base device' reference count.
> > > > +#[derive(Clone)]
> > > > +pub struct Device(ARef<device::Device>);
> > >
> > > It seems more natural for this to be a wrapper around
> > > `Opaque<bindings::pci_dev>`. Then you can have both &Device and
> > > ARef<Device> depending on whether you want to hold a refcount or not.
> >
> > Yeah, but then every bus device has to re-implement the refcount dance we
> > already have in `device::Device` for the underlying base `struct device`.
> >
> > I forgot to mention this in my previous reply to Boqun, but we even documented
> > it this way in `device::Device` [1].
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/device.rs#n28
> 
> We could perhaps write a derive macro for AlwaysRefCounted that
> delegates to the inner type? That way, we can have the best of both
> worlds.

Sounds interesting, how exactly would this work?

(I'll already send out a v5, but let's keep discussing this.)

> 
> Alice

