Return-Path: <linux-pci+bounces-23932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C25A6507F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 14:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8184188D030
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EA82376FF;
	Mon, 17 Mar 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g04jHRKW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AD221F32;
	Mon, 17 Mar 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217548; cv=none; b=SheoxpJzXUo6r0Cjx4O0OTAhC/3CRLdGSOlJWWjM+RwT6EsIOy3tf6H5/mtkbXxNY8BTPdBRocWs4s19w9BHK4l6Xm66klXHh3InFnKgkRdvqM0Tr3niXSeLD6WZvP6c8ldI+w/kKnLptSwRzvbP2MSfCGr7EKz2Qq0TFhHvdUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217548; c=relaxed/simple;
	bh=/U1ZYfUDOFP0bW+Z3XsUnLRwFyKjGlp0THGpGlr1K+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcRi6/LjshPCI5JUUr9/aE7fhvWg+ox8p+EczF9POxh/YWqHgVqDk8hi7yIL1IHVxN4LbGsn83BGQG9a1g/l09Jz4kXbAVN5LLhvkv3m/SwaV/U+8i+TPgW/A6RhUgG6q32egy8BRRrS/los7ei81PQtSLjojOWMNAvFsvPrTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g04jHRKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2101EC4CEE3;
	Mon, 17 Mar 2025 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742217548;
	bh=/U1ZYfUDOFP0bW+Z3XsUnLRwFyKjGlp0THGpGlr1K+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g04jHRKWFxDXd2boNwLITh5VyZSRwGA9I3kdQvAxLEdg8/DGW3c5dtaVT40TdYIp8
	 sqIml6Fn7HYvM+r3y5ZZpCi+xydqUSwvnFX6/NLBDqyqAPFEWD0BAl8xfN2R/+P3UF
	 nN32iPen3kRbTMPM0Vf5PgNcoQlxd4sg1hfFsZnw=
Date: Mon, 17 Mar 2025 14:17:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Improve soundness of bus device abstractions
Message-ID: <2025031711-create-proponent-5397@gregkh>
References: <20250314160932.100165-1-dakr@kernel.org>
 <2025031542-starry-finally-1a2c@gregkh>
 <Z9gLeaQqZOef0Fqz@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9gLeaQqZOef0Fqz@pollux>

On Mon, Mar 17, 2025 at 12:46:01PM +0100, Danilo Krummrich wrote:
> On Sat, Mar 15, 2025 at 09:34:17AM +0100, Greg KH wrote:
> > On Fri, Mar 14, 2025 at 05:09:03PM +0100, Danilo Krummrich wrote:
> > > Currently, when sharing references of bus devices (e.g. ARef<pci::Device>), we
> > > do not have a way to restrict which functions of a bus device can be called.
> > > 
> > > Consequently, it is possible to call all bus device functions concurrently from
> > > any context. This includes functions, which access fields of the (bus) device,
> > > which are not protected against concurrent access.
> > > 
> > > This is improved by applying an execution context to the bus device in form of a
> > > generic type.
> > > 
> > > For instance, the PCI device reference that is passed to probe() has the type
> > > pci::Device<Core>, which implements all functions that are only allowed to be
> > > called from bus callbacks.
> > > 
> > > The implementation for the default context (pci::Device) contains all functions
> > > that are safe to call from any context concurrently.
> > > 
> > > The context types can be extended as required, e.g. to limit availability  of
> > > certain (bus) device functions to probe().
> > > 
> > > A branch containing the patches can be found in [1].
> > > 
> > > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device
> > > 
> > > Changes in v2:
> > >   - make `DeviceContext` trait sealed
> > >   - impl From<&pci::Device<device::Core>> for ARef<pci::Device>
> > >   - impl From<&platform::Device<device::Core>> for ARef<platform::Device>
> > >   - rebase onto v6.14-rc6
> > >   - apply RBs
> > > 
> > > Danilo Krummrich (4):
> > >   rust: pci: use to_result() in enable_device_mem()
> > >   rust: device: implement device context marker
> > >   rust: pci: fix unrestricted &mut pci::Device
> > >   rust: platform: fix unrestricted &mut platform::Device
> > > 
> > >  rust/kernel/device.rs                |  26 +++++
> > >  rust/kernel/pci.rs                   | 137 +++++++++++++++++----------
> > >  rust/kernel/platform.rs              |  95 +++++++++++++------
> > >  samples/rust/rust_driver_pci.rs      |   8 +-
> > >  samples/rust/rust_driver_platform.rs |  11 ++-
> > >  5 files changed, 187 insertions(+), 90 deletions(-)
> > 
> > Thanks for doing this work, looks good to me.  Mind if I suck it into
> > the driver-core tree now?  Or do you want it to go through a different
> > tree?
> 
> This series has a conflict with nova-core, it will require the following fixup
> in -next and Linus' tree when he pulls things.
> 
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
> index 63c19f140fbd..a08fb6599267 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -use kernel::{bindings, c_str, pci, prelude::*};
> +use kernel::{bindings, c_str, device::Core, pci, prelude::*};
>  
>  use crate::gpu::Gpu;
>  
> @@ -27,7 +27,7 @@ impl pci::Driver for NovaCore {
>      type IdInfo = ();
>      const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
>  
> -    fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
> +    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
>          dev_dbg!(pdev.as_ref(), "Probe Nova Core GPU driver.\n");
>  
>          pdev.enable_device_mem()?;
> 

Ok, shouldn't be that hard of a merge issue, thanks for the diff as
linux-next should soon hit this as well.

greg k-h

