Return-Path: <linux-pci+bounces-18140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5565A9ECEB5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874BB188AA43
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63F0165F1A;
	Wed, 11 Dec 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHO5Bmzk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891A1494DD;
	Wed, 11 Dec 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927550; cv=none; b=LgWau1G5CONIZANSXObsztHkZwZkyZ9mtB9CbvlpHMJr0KlEeMHXpVkjrqSpN3cmKsJ0Dgzd+ngsD4jrJ0m/tDkVDYUKHpe2+wP5jtNQmh5CguPrE7Jt0/EQHpkfjQIz0y2H+wgD9a26EH1simy6t2IS30SiIN3Vro4LivhKDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927550; c=relaxed/simple;
	bh=hVduLjdvtwk/jSlcpLB3nZnk3Bh/+0CbGBpin9xdFQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPLUYZi7A8p/MpWvnwdwqZHTP08BlpUndyINyTXh+8Ghn1a1hPhmAY1sj+ujaxawHVE94uu1ecwuyRTUAJjgii6rmBSKg+gK5qNJFR2S/zbv8cyugv/0/ZL5NqMz14RNbhxUQpTbc+RmfPkSv8k4DoZVgzHPReJQzSW9KjGe6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHO5Bmzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A849C4CED2;
	Wed, 11 Dec 2024 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733927550;
	bh=hVduLjdvtwk/jSlcpLB3nZnk3Bh/+0CbGBpin9xdFQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHO5BmzkP6HQKhPhS4My0GgYJkV9rej7LQWH+Ts+HnknVLWqaojyEiXm81Mpe4C0J
	 01DOcLP+JlBKOd3YSa1cEWWlAy+qnitiLV8EOeR3LMUk9UciuIsOmvguooZzvpB/eB
	 Q18uJ/+xpFb/HKZgu2hv7xt4YE1gJbyMUlKLSXdtETJDEGKQ9KbrbZcIwV0ukxb+01
	 ZH07spbj0hsWj4ZB/9D6gnnun77lwSH0rPSILuOEGWldn0N/OQ2+fl2GhGEU+eDeFp
	 Nj98NxGZKwimxDv3XTVkpl3gE6mGQ5nr/tjK/fIfSt0YNCrQxzbHWvkpjoeFJrFjBj
	 23zGvBQwDEXJg==
Date: Wed, 11 Dec 2024 15:32:21 +0100
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
Message-ID: <Z1midaMMA1xBgBrg@cassiopeiae>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-9-dakr@kernel.org>
 <CAH5fLgh6qgQ=SBn17biSRbqO8pNtSEq=5fDY3iuGzbuf2Aqjeg@mail.gmail.com>
 <Z1bKA5efDYxd8sTC@pollux.localdomain>
 <CAH5fLgixvBWSf-3WDRj=Mxtn4ArQLqdKqMF0aSxyC6xVNPfTFQ@mail.gmail.com>
 <Z1jC7NnmwidLPT9Z@pollux>
 <CAH5fLgg=fvQOVL-FH72BFtv-5r_e35=esNir9itG_29am_5Sng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgg=fvQOVL-FH72BFtv-5r_e35=esNir9itG_29am_5Sng@mail.gmail.com>

On Wed, Dec 11, 2024 at 02:06:50PM +0100, Alice Ryhl wrote:
> On Tue, Dec 10, 2024 at 11:38 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Tue, Dec 10, 2024 at 11:55:33AM +0100, Alice Ryhl wrote:
> > > On Mon, Dec 9, 2024 at 11:44 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > >
> > > > On Fri, Dec 06, 2024 at 03:01:18PM +0100, Alice Ryhl wrote:
> > > > > On Thu, Dec 5, 2024 at 3:16 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > > >
> > > > > > Implement the basic PCI abstractions required to write a basic PCI
> > > > > > driver. This includes the following data structures:
> > > > > >
> > > > > > The `pci::Driver` trait represents the interface to the driver and
> > > > > > provides `pci::Driver::probe` for the driver to implement.
> > > > > >
> > > > > > The `pci::Device` abstraction represents a `struct pci_dev` and provides
> > > > > > abstractions for common functions, such as `pci::Device::set_master`.
> > > > > >
> > > > > > In order to provide the PCI specific parts to a generic
> > > > > > `driver::Registration` the `driver::RegistrationOps` trait is implemented
> > > > > > by `pci::Adapter`.
> > > > > >
> > > > > > `pci::DeviceId` implements PCI device IDs based on the generic
> > > > > > `device_id::RawDevceId` abstraction.
> > > > > >
> > > > > > Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > > > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > >
> > > > > > +/// The PCI device representation.
> > > > > > +///
> > > > > > +/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
> > > > > > +/// device, hence, also increments the base device' reference count.
> > > > > > +#[derive(Clone)]
> > > > > > +pub struct Device(ARef<device::Device>);
> > > > >
> > > > > It seems more natural for this to be a wrapper around
> > > > > `Opaque<bindings::pci_dev>`. Then you can have both &Device and
> > > > > ARef<Device> depending on whether you want to hold a refcount or not.
> > > >
> > > > Yeah, but then every bus device has to re-implement the refcount dance we
> > > > already have in `device::Device` for the underlying base `struct device`.
> > > >
> > > > I forgot to mention this in my previous reply to Boqun, but we even documented
> > > > it this way in `device::Device` [1].
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/device.rs#n28
> > >
> > > We could perhaps write a derive macro for AlwaysRefCounted that
> > > delegates to the inner type? That way, we can have the best of both
> > > worlds.
> >
> > Sounds interesting, how exactly would this work?
> >
> > (I'll already send out a v5, but let's keep discussing this.)
> 
> Well, the derive macro could assume that the refcount is manipulated
> in the same way as the inner type does it. I admit that the idea is
> not fully formed, but if we can avoid wrapping ARef, that would be
> ideal.

If we can get this to work, I agree it's a good solution.

What do you think about making this a follow up of this series?

> It sounds like the only reason you don't do that is that it's
> more unsafe, which the macro could reduce.

Exactly, yes.

> 
> 
> Alice

