Return-Path: <linux-pci+bounces-30880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835DAEAAF4
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE9D188E2C3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4A227563;
	Thu, 26 Jun 2025 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6qAS0JV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775D226D16;
	Thu, 26 Jun 2025 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750982044; cv=none; b=okTw3vNNRq/ozpvNJudErl6izkVCiM0Ky938Da3ImEx83NHaqveYAe/RPAbifQzcW7xrBGPy4mxNJXMd2k8J3RIpieOGpkn9A5dcY2xK4rQBb39GZAXMEwqfGq0UEOh5nqiVYGDoyERY+FdqaHWcCYgRlkEiiZtpaQHXj4M6qYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750982044; c=relaxed/simple;
	bh=9jMk2VOPIyOuPQYHmKiJKGD9tr+LmBkm+Y+Wr9wrZug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYmB6ucmbiNUv1jaz6Wk8Fbe0mf/FgOpT37GPyai4BcWpA5+YcjBlf6oJ13zIheW397b6aOQLeIfiS0iPUP6lk7k2W9C8wbneowlaLMtDa/22CKRtWyZDNeMgfSDPVZm+lgSrPjaa5Jl/xEFY8zO2dmtZHFPDHN6nRRsFphn8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6qAS0JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD98C4CEEB;
	Thu, 26 Jun 2025 23:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750982043;
	bh=9jMk2VOPIyOuPQYHmKiJKGD9tr+LmBkm+Y+Wr9wrZug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6qAS0JV58LBck04TfM5h98ITIxBgBWOyFELhYatII0nn82u26DHgngkyN/VdKe/q
	 +CPTjMGB2VIlr59acCqCR+eoibqvOM6VPtz2h3auyfRadPHVcjXhnhqPn32i4Dvsh5
	 /3yLD45/o9fupbYwad0SALbN5OvtudMLaBPwpfRRTqUE4mQ+uC0IcWLYCaoV13rfEP
	 pW108JtnojGUaNVstxdsRRN9OuTTdRrQ+BqH+LI9eS7ZDRbPMepeK8mvAL3zazDE5E
	 j6Cq8gPLQqyuh0mjNjgxpbJacNk08RK2xS5LS3CApAJ6oUS3MHbGFX1YcMnUsHq63u
	 8tk0/ThNFXKpw==
Date: Fri, 27 Jun 2025 01:53:57 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/5] rust: devres: get rid of Devres' inner Arc
Message-ID: <aF3dlfLiy8w4henN@pollux>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-4-dakr@kernel.org>
 <DAWUWCQCW7WD.29U1POJFXTLXS@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAWUWCQCW7WD.29U1POJFXTLXS@kernel.org>

On Fri, Jun 27, 2025 at 01:33:41AM +0200, Benno Lossin wrote:
> On Thu Jun 26, 2025 at 10:00 PM CEST, Danilo Krummrich wrote:
> > diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> > index 60b86f370284..47653c14838b 100644
> > --- a/drivers/gpu/nova-core/gpu.rs
> > +++ b/drivers/gpu/nova-core/gpu.rs
> 
> > @@ -161,14 +161,14 @@ fn new(bar: &Bar0) -> Result<Spec> {
> >  pub(crate) struct Gpu {
> >      spec: Spec,
> >      /// MMIO mapping of PCI BAR 0
> > -    bar: Devres<Bar0>,
> > +    bar: Arc<Devres<Bar0>>,
> 
> Can't you store it inline, given that you return an `impl PinInit<Self>`
> below?

I could, but I already know that we'll have to share bar later on.

> >      fw: Firmware,
> >  }
> >  
> >  impl Gpu {
> >      pub(crate) fn new(
> >          pdev: &pci::Device<device::Bound>,
> > -        devres_bar: Devres<Bar0>,
> > +        devres_bar: Arc<Devres<Bar0>>,
> >      ) -> Result<impl PinInit<Self>> {
> 
> While I see this code, is it really necessary to return `Result`
> wrapping the initializer here? I think it's probably better to return
> `impl PinInit<Self, Error>` instead. (of course in a different patch/an
> issue)

I will double check, but it's rather unlikely it makes sense. There's a lot of
initialization going on in Gpu::new(), the try_pin_init! call would probably get
too crazy.

> 
> >          let bar = devres_bar.access(pdev.as_ref())?;
> >          let spec = Spec::new(bar)?;
> 
> > @@ -44,6 +49,10 @@ struct DevresInner<T: Send> {
> >  /// [`Devres`] users should make sure to simply free the corresponding backing resource in `T`'s
> >  /// [`Drop`] implementation.
> >  ///
> > +/// # Invariants
> > +///
> > +/// [`Self::inner`] is guaranteed to be initialized and is always accessed read-only.
> > +///
> 
> Let's put this section below the examples, I really ought to write the
> safety docs one day and let everyone vote on this kind of stuff...

Sure!

> >  /// # Example
> >  ///
> >  /// ```no_run
> 
> > @@ -213,44 +233,63 @@ pub fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Self> {
> >      /// }
> >      /// ```
> >      pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T> {
> > -        if self.0.dev.as_raw() != dev.as_raw() {
> > +        if self.dev.as_raw() != dev.as_raw() {
> >              return Err(EINVAL);
> >          }
> >  
> >          // SAFETY: `dev` being the same device as the device this `Devres` has been created for
> > -        // proves that `self.0.data` hasn't been revoked and is guaranteed to not be revoked as
> > -        // long as `dev` lives; `dev` lives at least as long as `self`.
> > -        Ok(unsafe { self.0.data.access() })
> > +        // proves that `self.data` hasn't been revoked and is guaranteed to not be revoked as long
> > +        // as `dev` lives; `dev` lives at least as long as `self`.
> 
> What if the device has been unbound and a new device has been allocated
> in the exact same memory?

Unbound doesn't mean freed. Devres holds a reference of the device is was
created with, so it is impossible that it has been freed.

