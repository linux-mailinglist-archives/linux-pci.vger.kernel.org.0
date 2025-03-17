Return-Path: <linux-pci+bounces-23929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422D0A64D27
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 12:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CDE16EE1B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F5321A42C;
	Mon, 17 Mar 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7Ua+Tfq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154A38DD8;
	Mon, 17 Mar 2025 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211968; cv=none; b=rtkubPBo7usOuTWP98u35cxAQzAz4fZMRu0NcWraCRdWBRk9pXpvaOqlsIY9CHxgBSdfQihyj8RHQMD2KVr+htTwR/z7Ooa+fCtflfiFG7SHRsV2u8dmlYrOkxf+vfWqojj08Qf1+t6TES3tIVLCkzEOhPmCTp/50lKk7dWR710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211968; c=relaxed/simple;
	bh=IUHSaJFW36Rq/yR/l9vcO9rORQ7Sa11dvwQP2YGMY9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuXVjKbJqUTebxVVqHOW/coIuIvL6Dehm7Y4ylBi3s87sD/Y7faThmNkrSZ+qPObyrTalGSKeAbdi4rYhZl1aV0fpQHKOQCZ2Wy1HJ+H9mDFELyuvVGPfiY7gh+V5i6t8q65OUFOt/+li8PLjgpz7H41JVXd8qP4/7mEG2ZK/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7Ua+Tfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76328C4CEE3;
	Mon, 17 Mar 2025 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742211967;
	bh=IUHSaJFW36Rq/yR/l9vcO9rORQ7Sa11dvwQP2YGMY9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7Ua+TfqVwTcP6xP05u325439tU+a7NmKr9czDj1VF5fEZr5vkmj2pjNlMn130Jxy
	 ZNYpNX62FDe1+QVea9RLWxFtnqkdFv47HUpKBUgowSHjYtAeHUib3L3HntEGV6nf74
	 hG4gXusTGb+aMcvT/B1Q0SEO8qzsFN+h/i19TLLAhif/yPDenrBLlwe/jsdJPraed/
	 J2xZWTWtbng3dNYK6v0pNr+5AUTlD22at8Se6Ch09u32Af7oNBlImxTgJw7WYsYXMP
	 JuD983eeXnJc3yOY0XkYOUBCg3+tNTPA7HB9tb3d7n3rVKR/wEgOIOMYdkCNQ5Xmzm
	 ygFO9Otbl4C7w==
Date: Mon, 17 Mar 2025 12:46:01 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Improve soundness of bus device abstractions
Message-ID: <Z9gLeaQqZOef0Fqz@pollux>
References: <20250314160932.100165-1-dakr@kernel.org>
 <2025031542-starry-finally-1a2c@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031542-starry-finally-1a2c@gregkh>

On Sat, Mar 15, 2025 at 09:34:17AM +0100, Greg KH wrote:
> On Fri, Mar 14, 2025 at 05:09:03PM +0100, Danilo Krummrich wrote:
> > Currently, when sharing references of bus devices (e.g. ARef<pci::Device>), we
> > do not have a way to restrict which functions of a bus device can be called.
> > 
> > Consequently, it is possible to call all bus device functions concurrently from
> > any context. This includes functions, which access fields of the (bus) device,
> > which are not protected against concurrent access.
> > 
> > This is improved by applying an execution context to the bus device in form of a
> > generic type.
> > 
> > For instance, the PCI device reference that is passed to probe() has the type
> > pci::Device<Core>, which implements all functions that are only allowed to be
> > called from bus callbacks.
> > 
> > The implementation for the default context (pci::Device) contains all functions
> > that are safe to call from any context concurrently.
> > 
> > The context types can be extended as required, e.g. to limit availability  of
> > certain (bus) device functions to probe().
> > 
> > A branch containing the patches can be found in [1].
> > 
> > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device
> > 
> > Changes in v2:
> >   - make `DeviceContext` trait sealed
> >   - impl From<&pci::Device<device::Core>> for ARef<pci::Device>
> >   - impl From<&platform::Device<device::Core>> for ARef<platform::Device>
> >   - rebase onto v6.14-rc6
> >   - apply RBs
> > 
> > Danilo Krummrich (4):
> >   rust: pci: use to_result() in enable_device_mem()
> >   rust: device: implement device context marker
> >   rust: pci: fix unrestricted &mut pci::Device
> >   rust: platform: fix unrestricted &mut platform::Device
> > 
> >  rust/kernel/device.rs                |  26 +++++
> >  rust/kernel/pci.rs                   | 137 +++++++++++++++++----------
> >  rust/kernel/platform.rs              |  95 +++++++++++++------
> >  samples/rust/rust_driver_pci.rs      |   8 +-
> >  samples/rust/rust_driver_platform.rs |  11 ++-
> >  5 files changed, 187 insertions(+), 90 deletions(-)
> 
> Thanks for doing this work, looks good to me.  Mind if I suck it into
> the driver-core tree now?  Or do you want it to go through a different
> tree?

This series has a conflict with nova-core, it will require the following fixup
in -next and Linus' tree when he pulls things.

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 63c19f140fbd..a08fb6599267 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{bindings, c_str, pci, prelude::*};
+use kernel::{bindings, c_str, device::Core, pci, prelude::*};
 
 use crate::gpu::Gpu;
 
@@ -27,7 +27,7 @@ impl pci::Driver for NovaCore {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
         dev_dbg!(pdev.as_ref(), "Probe Nova Core GPU driver.\n");
 
         pdev.enable_device_mem()?;

