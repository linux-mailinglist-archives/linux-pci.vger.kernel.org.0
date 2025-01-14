Return-Path: <linux-pci+bounces-19734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8DCA10C59
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368FF7A20FE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA851CCED2;
	Tue, 14 Jan 2025 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuSNBXZd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342F01885BF;
	Tue, 14 Jan 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872426; cv=none; b=GR2hysQA7btCumeLPv3RWp+qGSSLLZsqfupy+We1I3daT6hjmGtQTAG/e8mTtSFHPBre5i+FFYP8Bx91/TTzD1vrBC/JQap9xlZjsNsTBAHWOCiHsdk1zaeKNCOPr1kkYjVwwX2wBxzus7NugxKVg0fU4ArMX5auFZQesxBtAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872426; c=relaxed/simple;
	bh=KVUmaLRhmiiEcQyF5SAfptVzJKeJAVpd3dFJ7EyCHPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmuGr7U+ILsfJPHoi/q9l7ZBtwTg5wXjdmpqw4ypRktCJZVSVX5yNjtjq9rPMl9i+pWyvcudVVWw65KNJe6+qpZ1qDF+qKmXlq9H2i13UdUnjVxl+1Bck1dbrAPkcSaDMPnP/ezBB+qfAHFt7Lj6EUsjeip+Mp1A72Qu46LOX+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuSNBXZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C3BC4CEDD;
	Tue, 14 Jan 2025 16:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736872425;
	bh=KVUmaLRhmiiEcQyF5SAfptVzJKeJAVpd3dFJ7EyCHPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuSNBXZdQ0ZNDBmy/o0/hbmUxaJ0eS8W+atRLHoWNLKyLvTfu1h+Ybl0S89OnIOCu
	 dmNyUDmRn/BIoI/+259dFtpwEfeRKiVvXipgnDW7tY4xC2YgP+e6FX9IQ1SZeRdJgQ
	 VN/Gr/EBqutCR6RRQAys7F40zN/l+Cw3mNCzGF7ACipSaZT+5fkhG8q9bXxdu6itjg
	 D+2jNh17C2z+gLVbkkgpslNqlsO82DMGCVrpU3B4Yj9XQVmz4pKtqSlqvKAZotBc0w
	 qzE+claz2bULPMGNl5esAgaH/yhM+NojZO3Bv61ifjK11IxRZL5q6TNyhORQ+sT39t
	 seOEZvmS77NYA==
Date: Tue, 14 Jan 2025 17:33:36 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>, gregkh@linuxfoundation.org
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com,
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
Message-ID: <Z4aR4OrCQMoF6Boo@pollux>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-9-dakr@kernel.org>
 <20241224215323.560f17a9.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224215323.560f17a9.gary@garyguo.net>

On Tue, Dec 24, 2024 at 09:53:23PM +0000, Gary Guo wrote:
> On Thu, 19 Dec 2024 18:04:10 +0100
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Add a Rust abstraction for the kernel's devres (device resource
> > management) implementation.
> > 
> > The Devres type acts as a container to manage the lifetime and
> > accessibility of device bound resources. Therefore it registers a
> > devres callback and revokes access to the resource on invocation.
> > 
> > Users of the Devres abstraction can simply free the corresponding
> > resources in their Drop implementation, which is invoked when either the
> > Devres instance goes out of scope or the devres callback leads to the
> > resource being revoked, which implies a call to drop_in_place().
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  MAINTAINERS            |   1 +
> >  rust/helpers/device.c  |  10 +++
> >  rust/helpers/helpers.c |   1 +
> >  rust/kernel/devres.rs  | 178 +++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs     |   1 +
> >  5 files changed, 191 insertions(+)
> >  create mode 100644 rust/helpers/device.c
> >  create mode 100644 rust/kernel/devres.rs
> > 
> > <snip>
> >
> > +pub struct Devres<T>(Arc<DevresInner<T>>);
> > +
> > +impl<T> DevresInner<T> {
> > +    fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
> > +        let inner = Arc::pin_init(
> > +            pin_init!( DevresInner {
> > +                data <- Revocable::new(data),
> > +            }),
> > +            flags,
> > +        )?;
> > +
> > +        // Convert `Arc<DevresInner>` into a raw pointer and make devres own this reference until
> > +        // `Self::devres_callback` is called.
> > +        let data = inner.clone().into_raw();
> > +
> > +        // SAFETY: `devm_add_action` guarantees to call `Self::devres_callback` once `dev` is
> > +        // detached.
> > +        let ret = unsafe {
> > +            bindings::devm_add_action(dev.as_raw(), Some(Self::devres_callback), data as _)
> > +        };
> > +
> > +        if ret != 0 {
> > +            // SAFETY: We just created another reference to `inner` in order to pass it to
> > +            // `bindings::devm_add_action`. If `bindings::devm_add_action` fails, we have to drop
> > +            // this reference accordingly.
> > +            let _ = unsafe { Arc::from_raw(data) };
> > +            return Err(Error::from_errno(ret));
> > +        }
> > +
> > +        Ok(inner)
> > +    }
> > +
> > +    #[allow(clippy::missing_safety_doc)]
> > +    unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
> > +        let ptr = ptr as *mut DevresInner<T>;
> > +        // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
> > +        // reference.
> > +        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
> > +        //         `DevresInner::new`.
> > +        let inner = unsafe { Arc::from_raw(ptr) };
> > +
> > +        inner.data.revoke();
> > +    }
> > +}
> > +
> > +impl<T> Devres<T> {
> > +    /// Creates a new [`Devres`] instance of the given `data`. The `data` encapsulated within the
> > +    /// returned `Devres` instance' `data` will be revoked once the device is detached.
> > +    pub fn new(dev: &Device, data: T, flags: Flags) -> Result<Self> {
> > +        let inner = DevresInner::new(dev, data, flags)?;
> > +
> > +        Ok(Devres(inner))
> > +    }
> > +
> > +    /// Same as [`Devres::new`], but does not return a `Devres` instance. Instead the given `data`
> > +    /// is owned by devres and will be revoked / dropped, once the device is detached.
> > +    pub fn new_foreign_owned(dev: &Device, data: T, flags: Flags) -> Result {
> > +        let _ = DevresInner::new(dev, data, flags)?;
> > +
> > +        Ok(())
> > +    }
> > +}
> > +
> > +impl<T> Deref for Devres<T> {
> > +    type Target = Revocable<T>;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        &self.0.data
> > +    }
> > +}
> > +
> > +impl<T> Drop for Devres<T> {
> > +    fn drop(&mut self) {
> > +        // Revoke the data, such that it gets dropped already and the actual resource is freed.
> > +        //
> > +        // `DevresInner` has to stay alive until the devres callback has been called. This is
> > +        // necessary since we don't know when `Devres` is dropped and calling
> > +        // `devm_remove_action()` instead could race with `devres_release_all()`.
> 
> IIUC, the outcome of that race is the `WARN` if
> devres_release_all takes the spinlock first and has already remvoed the
> action?
> 
> Could you do a custom devres_release here that mimick
> `devm_remove_action` but omit the `WARN`? This way it allows the memory
> behind DevresInner to be freed early without keeping it allocated until
> the end of device lifetime.

Better late than never, I now remember what's the *actual* race I was preventing
here:

  | Task 0                               | Task 1
--|----------------------------------------------------------------------------
1 | Devres::drop() {                     | devres_release_all() {
2 |    DevresInner::remove_action() {    |    spin_lock_irqsave();
3 |                                      |    remove_nodes(&todo);
4 |                                      |    spin_unlock_irqrestore();
5 |       devm_remove_action_nowarn();   |
6 |       let _ = Arc::from_raw();       |
7 |    }                                 |
8 | }                                    |
9 |                                      |    release_nodes(&todo);
10|                                      | }

So, if devres_release_all() wins the race it stores the devres action within the
temporary todo list. Which means that in 9 we enter
DevresInner::devres_callback() even though DevresInner has been freed already.

Unfortunately, this race can happen with [1], but not with this original version
of Devres.

I see two ways to fix it:

1) Just revert [1] and stick with the original version.

2) Use devm_release_action() instead of devm_remove_action() and don't drop the
   reference in DevresInner::remove_action() (6). This way the reference is
   always dropped from the callback.

With 2) we still have an unnecessary call to revoke() if Devres is dropped
before the device is detached from the driver, but that's still better than
keeping DevresInner alive until the device is detached from the driver, which
the original version did. Hence, I'll go ahead and prepare a patch for this,
unless there are any concerns.

- Danilo

[1] https://lore.kernel.org/rust-for-linux/20250107122609.8135-2-dakr@kernel.org/

> 
> > +        //
> > +        // SAFETY: When `drop` runs, it's guaranteed that nobody is accessing the revocable data
> > +        // anymore, hence it is safe not to wait for the grace period to finish.
> > +        unsafe { self.revoke_nosync() };
> > +    }
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 6c836ab73771..2b61bf99d1ee 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -41,6 +41,7 @@
> >  pub mod cred;
> >  pub mod device;
> >  pub mod device_id;
> > +pub mod devres;
> >  pub mod driver;
> >  pub mod error;
> >  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> 

