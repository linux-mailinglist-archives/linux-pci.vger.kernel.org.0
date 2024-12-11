Return-Path: <linux-pci+bounces-18141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B9A9ECECD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 15:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB721882D32
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945F18732B;
	Wed, 11 Dec 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JI3cIjG7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD1246354;
	Wed, 11 Dec 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928099; cv=none; b=H/uHF1RrbS765Vi30Z+ZyqFuQ6z6CGXOeyUdXnTEp2kNepddqumb6S9okYjgXZkEyBtreG3by9zXXiy689uyHkJGdSo8RZ69J8Dsm+hG79hghOtkUTXTjXE0eirEHTCPyk+4QJBMt04hF0LxHWHhbifVm7BzRxuB+XsVOChY1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928099; c=relaxed/simple;
	bh=fCFbfMe8cxr7MuwrcGE04ewr4544yF5SgkWopH5f3pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd5ekbBbue0xQR7Hk+ddPSVJp7oadUx2SOTjh2gswChTSUDuUivNFOgh6daMxc1QfThopcc1p32kf3OwLP2QLbQTImoXowl+Mutm3pyJOBSP8Om/K/6XHM0v9wXucB5llGt4xPWHrKfQNhmp8NlLG2qIJaHVXfEFZwc7NtTUeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JI3cIjG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CDEC4CED2;
	Wed, 11 Dec 2024 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733928099;
	bh=fCFbfMe8cxr7MuwrcGE04ewr4544yF5SgkWopH5f3pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JI3cIjG7YYoZ1CnoPMyJP2W1zkpTEs5XqdtTzkNDwPoQcoQbKzR7rSFYf7ir9KJGj
	 j2WXv8s0mutFH5O1/O4fk2KsmjoU9f/YkOQ7SA6EyDTG7imgrWfhicmGH5xn6aGVnp
	 FJmfzWzy57gL5E83HhyyclOCwx5yPMwJBQsSNsnY=
Date: Wed, 11 Dec 2024 15:41:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, rafael@kernel.org,
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 08/13] rust: pci: add basic PCI device / driver
 abstractions
Message-ID: <2024121104-curling-frostily-7b47@gregkh>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-9-dakr@kernel.org>
 <CAH5fLgh6qgQ=SBn17biSRbqO8pNtSEq=5fDY3iuGzbuf2Aqjeg@mail.gmail.com>
 <Z1bKA5efDYxd8sTC@pollux.localdomain>
 <CAH5fLgixvBWSf-3WDRj=Mxtn4ArQLqdKqMF0aSxyC6xVNPfTFQ@mail.gmail.com>
 <Z1jC7NnmwidLPT9Z@pollux>
 <CAH5fLgg=fvQOVL-FH72BFtv-5r_e35=esNir9itG_29am_5Sng@mail.gmail.com>
 <Z1midaMMA1xBgBrg@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1midaMMA1xBgBrg@cassiopeiae>

On Wed, Dec 11, 2024 at 03:32:21PM +0100, Danilo Krummrich wrote:
> On Wed, Dec 11, 2024 at 02:06:50PM +0100, Alice Ryhl wrote:
> > On Tue, Dec 10, 2024 at 11:38 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > >
> > > On Tue, Dec 10, 2024 at 11:55:33AM +0100, Alice Ryhl wrote:
> > > > On Mon, Dec 9, 2024 at 11:44 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > >
> > > > > On Fri, Dec 06, 2024 at 03:01:18PM +0100, Alice Ryhl wrote:
> > > > > > On Thu, Dec 5, 2024 at 3:16 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > > > >
> > > > > > > Implement the basic PCI abstractions required to write a basic PCI
> > > > > > > driver. This includes the following data structures:
> > > > > > >
> > > > > > > The `pci::Driver` trait represents the interface to the driver and
> > > > > > > provides `pci::Driver::probe` for the driver to implement.
> > > > > > >
> > > > > > > The `pci::Device` abstraction represents a `struct pci_dev` and provides
> > > > > > > abstractions for common functions, such as `pci::Device::set_master`.
> > > > > > >
> > > > > > > In order to provide the PCI specific parts to a generic
> > > > > > > `driver::Registration` the `driver::RegistrationOps` trait is implemented
> > > > > > > by `pci::Adapter`.
> > > > > > >
> > > > > > > `pci::DeviceId` implements PCI device IDs based on the generic
> > > > > > > `device_id::RawDevceId` abstraction.
> > > > > > >
> > > > > > > Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > > > > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > > > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > > >
> > > > > > > +/// The PCI device representation.
> > > > > > > +///
> > > > > > > +/// A PCI device is based on an always reference counted `device:Device` instance. Cloning a PCI
> > > > > > > +/// device, hence, also increments the base device' reference count.
> > > > > > > +#[derive(Clone)]
> > > > > > > +pub struct Device(ARef<device::Device>);
> > > > > >
> > > > > > It seems more natural for this to be a wrapper around
> > > > > > `Opaque<bindings::pci_dev>`. Then you can have both &Device and
> > > > > > ARef<Device> depending on whether you want to hold a refcount or not.
> > > > >
> > > > > Yeah, but then every bus device has to re-implement the refcount dance we
> > > > > already have in `device::Device` for the underlying base `struct device`.
> > > > >
> > > > > I forgot to mention this in my previous reply to Boqun, but we even documented
> > > > > it this way in `device::Device` [1].
> > > > >
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/device.rs#n28
> > > >
> > > > We could perhaps write a derive macro for AlwaysRefCounted that
> > > > delegates to the inner type? That way, we can have the best of both
> > > > worlds.
> > >
> > > Sounds interesting, how exactly would this work?
> > >
> > > (I'll already send out a v5, but let's keep discussing this.)
> > 
> > Well, the derive macro could assume that the refcount is manipulated
> > in the same way as the inner type does it. I admit that the idea is
> > not fully formed, but if we can avoid wrapping ARef, that would be
> > ideal.
> 
> If we can get this to work, I agree it's a good solution.
> 
> What do you think about making this a follow up of this series?

That's fine, if you remove the patch that adds the module name to the
function as ideally that's what we are trying to remove here :)

thanks,

greg k-h

