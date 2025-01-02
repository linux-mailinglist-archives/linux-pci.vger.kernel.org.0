Return-Path: <linux-pci+bounces-19170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24DA9FFB46
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 17:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B803F162972
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B1D1B2187;
	Thu,  2 Jan 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6FqLxVB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5624C9A;
	Thu,  2 Jan 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735833597; cv=none; b=Zd7oGO4Wc+CVbAoOAxhY+pEYZCFHwwIiXt3eS2SRS4/SBa6jKD+Un1IE/WypqyA48oRhnFRZ1Yedt1Y8q5DwY7IvxwzfRaDM8S/0rOI/Ip5nC8bsDZpA7rPsYLo48azyym3Vy6ty6YD8vJXVkYulISdVByLsXgsayBuw6gb7jIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735833597; c=relaxed/simple;
	bh=BqOMtO8Bwl7/G6kuHHogfyiuNc7p+CqAVlm89FXFZLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEXUL08zAq0XJCWmg4rjhHOkio+qCbaPeYIWrRh3H0g0qXwh6+20WwDq/PX/RzBbVv7/huLxZfhfKFycVNxBGk9qflkcV7IWK0jLj6l8IE2EP+Jgf+HVbSt7qeslWBLun0YkOxKLP1oORcaaeCQC8O0j54gNdc9nOFsTDjDtmFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6FqLxVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F6FC4CED0;
	Thu,  2 Jan 2025 15:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735833597;
	bh=BqOMtO8Bwl7/G6kuHHogfyiuNc7p+CqAVlm89FXFZLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6FqLxVBpQJPvR8zNZsDQilPidtiWiXWFy/7bi5l68zxHIoJTei0VPskM/zu+BlwB
	 VOkoOShHUNsQMJUwRQhrXD2rEyBbLmBCvqxQ0p/4QWRKN3cy+xIHapMk3eL7AKMrWc
	 rLIe9WwpZEq6cpEdG6j8paXlpo1/pyoIp8ORbHGQ9Kejvg2bHQOcRt8x7GsvzmUePi
	 BB3dmx0PS8nt+OUbrpwb6SD5JIBZtGsQUO6We5yv3Vee/3IVuM5Gyk0iQG+mUk1AlP
	 rNNTXtIVNyoANL9aRsx5Ika+sKRe5Lh9AAiRbtXa+sGwoCWy7dosQni9H4zqrqmBKG
	 6UkGc5xVcl2yw==
Date: Thu, 2 Jan 2025 16:59:48 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v7 08/16] rust: add devres abstraction
Message-ID: <Z3a39FM0oXHbitDz@cassiopeiae>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-9-dakr@kernel.org>
 <20241224215323.560f17a9.gary@garyguo.net>
 <Z3Zqq5qLht2j9Qqq@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3Zqq5qLht2j9Qqq@cassiopeiae>

On Thu, Jan 02, 2025 at 11:30:11AM +0100, Danilo Krummrich wrote:
> On Tue, Dec 24, 2024 at 09:53:23PM +0000, Gary Guo wrote:
> > On Thu, 19 Dec 2024 18:04:10 +0100
> > Danilo Krummrich <dakr@kernel.org> wrote:
> > 
> > > Add a Rust abstraction for the kernel's devres (device resource
> > > management) implementation.
> > > 
> > > The Devres type acts as a container to manage the lifetime and
> > > accessibility of device bound resources. Therefore it registers a
> > > devres callback and revokes access to the resource on invocation.
> > > 
> > > Users of the Devres abstraction can simply free the corresponding
> > > resources in their Drop implementation, which is invoked when either the
> > > Devres instance goes out of scope or the devres callback leads to the
> > > resource being revoked, which implies a call to drop_in_place().
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  MAINTAINERS            |   1 +
> > >  rust/helpers/device.c  |  10 +++
> > >  rust/helpers/helpers.c |   1 +
> > >  rust/kernel/devres.rs  | 178 +++++++++++++++++++++++++++++++++++++++++
> > >  rust/kernel/lib.rs     |   1 +
> > >  5 files changed, 191 insertions(+)
> > >  create mode 100644 rust/helpers/device.c
> > >  create mode 100644 rust/kernel/devres.rs
> > > 
> > > <snip>
> > >
> > > +pub struct Devres<T>(Arc<DevresInner<T>>);
> > > +
> > > +impl<T> DevresInner<T> {
> > > +    fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
> > > +        let inner = Arc::pin_init(
> > > +            pin_init!( DevresInner {
> > > +                data <- Revocable::new(data),
> > > +            }),
> > > +            flags,
> > > +        )?;
> > > +
> > > +        // Convert `Arc<DevresInner>` into a raw pointer and make devres own this reference until
> > > +        // `Self::devres_callback` is called.
> > > +        let data = inner.clone().into_raw();
> > > +
> > > +        // SAFETY: `devm_add_action` guarantees to call `Self::devres_callback` once `dev` is
> > > +        // detached.
> > > +        let ret = unsafe {
> > > +            bindings::devm_add_action(dev.as_raw(), Some(Self::devres_callback), data as _)
> > > +        };
> > > +
> > > +        if ret != 0 {
> > > +            // SAFETY: We just created another reference to `inner` in order to pass it to
> > > +            // `bindings::devm_add_action`. If `bindings::devm_add_action` fails, we have to drop
> > > +            // this reference accordingly.
> > > +            let _ = unsafe { Arc::from_raw(data) };
> > > +            return Err(Error::from_errno(ret));
> > > +        }
> > > +
> > > +        Ok(inner)
> > > +    }
> > > +
> > > +    #[allow(clippy::missing_safety_doc)]
> > > +    unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
> > > +        let ptr = ptr as *mut DevresInner<T>;
> > > +        // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
> > > +        // reference.
> > > +        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
> > > +        //         `DevresInner::new`.
> > > +        let inner = unsafe { Arc::from_raw(ptr) };
> > > +
> > > +        inner.data.revoke();
> > > +    }
> > > +}
> > > +
> > > +impl<T> Devres<T> {
> > > +    /// Creates a new [`Devres`] instance of the given `data`. The `data` encapsulated within the
> > > +    /// returned `Devres` instance' `data` will be revoked once the device is detached.
> > > +    pub fn new(dev: &Device, data: T, flags: Flags) -> Result<Self> {
> > > +        let inner = DevresInner::new(dev, data, flags)?;
> > > +
> > > +        Ok(Devres(inner))
> > > +    }
> > > +
> > > +    /// Same as [`Devres::new`], but does not return a `Devres` instance. Instead the given `data`
> > > +    /// is owned by devres and will be revoked / dropped, once the device is detached.
> > > +    pub fn new_foreign_owned(dev: &Device, data: T, flags: Flags) -> Result {
> > > +        let _ = DevresInner::new(dev, data, flags)?;
> > > +
> > > +        Ok(())
> > > +    }
> > > +}
> > > +
> > > +impl<T> Deref for Devres<T> {
> > > +    type Target = Revocable<T>;
> > > +
> > > +    fn deref(&self) -> &Self::Target {
> > > +        &self.0.data
> > > +    }
> > > +}
> > > +
> > > +impl<T> Drop for Devres<T> {
> > > +    fn drop(&mut self) {
> > > +        // Revoke the data, such that it gets dropped already and the actual resource is freed.
> > > +        //
> > > +        // `DevresInner` has to stay alive until the devres callback has been called. This is
> > > +        // necessary since we don't know when `Devres` is dropped and calling
> > > +        // `devm_remove_action()` instead could race with `devres_release_all()`.
> > 
> > IIUC, the outcome of that race is the `WARN` if
> > devres_release_all takes the spinlock first and has already remvoed the
> > action?
> 
> Yes, this was one issue. But I think there was another when you have a class
> `Registration` that is owned by a `Devres`, which holds private data that is
> encapsulated in a `Devres` too.
> 
> I have this case in Nova where the DRM device' private data holds the PCI bar,
> and the DRM device registration has a reference of the corresponding DRM device.
> 
> But maybe this also was something else. I will double check and if I can confirm
> that the WARN_ON() in devm_remove_action() is the only issue, we can certainly
> change this.

Ok, I double checked and this should indeed be the only issue.

I can reproduce the race and can confirm that a devm_remove_action_nowarn()
works, as long as we make it return the integer that indicates whether the
action has been removed already, such that we can handle it from the Rust side
accordingly.

Generally, I don't think it's a big deal, drivers usually hold the resources
they request anyways until remove(). But it's still an improvement, so I'll send
a patch for that.

> 
> > 
> > Could you do a custom devres_release here that mimick
> > `devm_remove_action` but omit the `WARN`? This way it allows the memory
> > behind DevresInner to be freed early without keeping it allocated until
> > the end of device lifetime.
> > 
> > > +        //
> > > +        // SAFETY: When `drop` runs, it's guaranteed that nobody is accessing the revocable data
> > > +        // anymore, hence it is safe not to wait for the grace period to finish.
> > > +        unsafe { self.revoke_nosync() };
> > > +    }
> > > +}
> > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > index 6c836ab73771..2b61bf99d1ee 100644
> > > --- a/rust/kernel/lib.rs
> > > +++ b/rust/kernel/lib.rs
> > > @@ -41,6 +41,7 @@
> > >  pub mod cred;
> > >  pub mod device;
> > >  pub mod device_id;
> > > +pub mod devres;
> > >  pub mod driver;
> > >  pub mod error;
> > >  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> > 

