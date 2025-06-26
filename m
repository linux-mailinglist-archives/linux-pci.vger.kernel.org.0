Return-Path: <linux-pci+bounces-30834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D99AEA867
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9457AB507
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E601F9F7A;
	Thu, 26 Jun 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh5mgufi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2BD1DFFD;
	Thu, 26 Jun 2025 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750970890; cv=none; b=ILv3Y4Bm2gImyHT0fXSny96SQZO3Z5hXDa4bb6hC1JHkd/FdskMY3h55lR0L+zpfVv8FypGhks+GzkGJmUcx/fqujR4wrPuidP72c3s2Zr0j99sZN4X8FIcm5TQ8qOq2gCv0MYho9hQ65udmn4p1xPdcCR49RGyhLqAnKCCzp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750970890; c=relaxed/simple;
	bh=7z6321plEQZT+2ZW+imOOp3mUqwzt6EqgUbPghQ4g14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWFHDyuJKlNKxGPdgWq0qotoWOZWjQqZaNj8HC10OWmN7UDLyjZaAhD0xSEDyEYV2XXY3cFfPgvMNkrO+5yn9CQBDPKwvmIrjsIgM6SPms/TqmyZ9aNgYK33HVC1HACqtNWkBjOu8zEbleLIUbUYUoV8y54Zsc5zLdDtSNgE6B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh5mgufi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7269C4CEEB;
	Thu, 26 Jun 2025 20:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750970889;
	bh=7z6321plEQZT+2ZW+imOOp3mUqwzt6EqgUbPghQ4g14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rh5mgufiRVHufKUNpaxAtyi0MkSAQIG24UdKl5C4U45muLrijDAAgGD7BBMXFN51A
	 ySJAKcP5E/XfzsZOiZLp/9vSnhk/0p5vVXPangtey4dXiO7u5GGBFG6TltEx5KugfN
	 zEL1ZrU0+rZn55bd6kNYbnuwUr6ZTfLrfjkg6vYjxlHQtGmfHKh0zBTBHkBpPwhl1p
	 Sq2YSEIvKlcIrDVkYIhAuhA7QpZDtuKiauRvIOc3mk5PNhrJOYCmln6Q8QMTFUSK3G
	 Rp5ZNX47yU7Qr42D//F0fAHCEK8y4ajxpz0u4/I1oipQcJqd50jt7jPXovUkgnY9Yi
	 +Bz9OkOhKg3cw==
Date: Thu, 26 Jun 2025 22:48:03 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/5] rust: devres: implement register_release()
Message-ID: <aF2yA9TbeIrTg-XG@cassiopeiae>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-6-dakr@kernel.org>
 <aF2vgthQlNA3BsCD@tardis.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF2vgthQlNA3BsCD@tardis.local>

On Thu, Jun 26, 2025 at 01:37:22PM -0700, Boqun Feng wrote:
> On Thu, Jun 26, 2025 at 10:00:43PM +0200, Danilo Krummrich wrote:
> > register_release() is useful when a device resource has associated data,
> > but does not require the capability of accessing it or manually releasing
> > it.
> > 
> > If we would want to be able to access the device resource and release the
> > device resource manually before the device is unbound, but still keep
> > access to the associated data, we could implement it as follows.
> > 
> > 	struct Registration<T> {
> > 	   inner: Devres<RegistrationInner>,
> > 	   data: T,
> > 	}
> > 
> > However, if we never need to access the resource or release it manually,
> > register_release() is great optimization for the above, since it does not
> > require the synchronization of the Devres type.
> > 
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/devres.rs | 73 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> > 
> > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> > index 3ce8d6161778..92aca78874ff 100644
> > --- a/rust/kernel/devres.rs
> > +++ b/rust/kernel/devres.rs
> > @@ -353,3 +353,76 @@ pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flag
> >  
> >      register_foreign(dev, data)
> >  }
> > +
> > +/// [`Devres`]-releaseable resource.
> > +///
> > +/// Register an object implementing this trait with [`register_release`]. Its `release`
> > +/// function will be called once the device is being unbound.
> > +pub trait Release {
> > +    /// The [`ForeignOwnable`] pointer type consumed by [`register_release`].
> > +    type Ptr: ForeignOwnable;
> > +
> > +    /// Called once the [`Device`] given to [`register_release`] is unbound.
> > +    fn release(this: Self::Ptr);
> > +}
> > +
> 
> I would like to point out the limitation of this design, say you have a
> `Foo` that can ipml `Release`, with this, I think you could only support
> either `Arc<Foo>` or `KBox<Foo>`. You cannot support both as the input
> for `register_release()`. Maybe we want:
> 
>     pub trait Release<Ptr: ForeignOwnable> {
>         fn release(this: Ptr);
>     }

Good catch! I think this wasn't possible without ForeignOwnable::Target.

Here's the diff for the change:

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 92aca78874ff..42a9cd2812d8 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -358,12 +358,9 @@ pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flag
 ///
 /// Register an object implementing this trait with [`register_release`]. Its `release`
 /// function will be called once the device is being unbound.
-pub trait Release {
-    /// The [`ForeignOwnable`] pointer type consumed by [`register_release`].
-    type Ptr: ForeignOwnable;
-
+pub trait Release<Ptr: ForeignOwnable> {
     /// Called once the [`Device`] given to [`register_release`] is unbound.
-    fn release(this: Self::Ptr);
+    fn release(this: Ptr);
 }

 /// Consume the `data`, [`Release::release`] and [`Drop::drop`] `data` once `dev` is unbound.
@@ -384,9 +381,7 @@ pub trait Release {
 ///     }
 /// }
 ///
-/// impl Release for Registration {
-///     type Ptr = Arc<Self>;
-///
+/// impl Release<Arc<Self>> for Registration {
 ///     fn release(this: Arc<Self>) {
 ///        // unregister
 ///     }
@@ -401,7 +396,7 @@ pub trait Release {
 pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
 where
     P: ForeignOwnable,
-    P::Target: Release<Ptr = P> + Send,
+    P::Target: Release<P> + Send,
 {
     let ptr = data.into_foreign();

@@ -409,7 +404,7 @@ pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
     unsafe extern "C" fn callback<P>(ptr: *mut kernel::ffi::c_void)
     where
         P: ForeignOwnable,
-        P::Target: Release<Ptr = P>,
+        P::Target: Release<P>,
     {
         // SAFETY: `ptr` is the pointer to the `ForeignOwnable` leaked above and hence valid.
         let data = unsafe { P::from_foreign(ptr.cast()) };

