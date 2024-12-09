Return-Path: <linux-pci+bounces-17915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416D09E909E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 11:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B9163CF2
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 10:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D0217707;
	Mon,  9 Dec 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXH/n/ts"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7CF216E2C;
	Mon,  9 Dec 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740821; cv=none; b=Zme+9uDvvAVeLiRZ/s1sHQVlfRWytFuWOJYNHOzoOrUx7ukBONIjzsOfnteU1ZI7L7M5ITf/FhMvfMYn/aDsfyh/76HnBn2EiZFVGLxkb9TM/1KQwDgV2MA2N+cBJIMPANFTO1Z0vN7V1LBBHEAq+ZFw8I0oOteXLB2nddO76K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740821; c=relaxed/simple;
	bh=avWm92IZbV3zV0THAJkoJq+gi5r1S20UDkgXChXm71c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOjgZShzbU5nvRpupcewjk4bYrv7RgCI9ix6gH+jdVz5LJd9+qIaCSCwBXbtkXlXwyic8Q0SFqEj7+iwbba7dhkPeGHAYe40MsYlX+8qWMu25gBX4mbP7PSgXCx3LgZqnSw/rzZpPUOAvjL59UfS1OMdjszsU5NcZnkwnXr7xsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXH/n/ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA74C4CED1;
	Mon,  9 Dec 2024 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733740821;
	bh=avWm92IZbV3zV0THAJkoJq+gi5r1S20UDkgXChXm71c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXH/n/tsqMWYgbT6T2HJfSJMIxgE3PnNesKooQ67+7g+m5yTwUmilf8w8sXEkX3V7
	 oMJz2WpwxLcOhBwbY10FGaYz8g3g7aIaPzxaHU54cgiaA4uCz1DMCdALjAr+IceWpz
	 b0GCped62wLmhXqTAcbyscj7MAUeUktoIR7ByP7gVgqGDQvvgfDHD+9uXcoRSVr7SA
	 sbXZXvJWGAk6Gp9HrVuxwCpE/V4FKgbPlAa+auovKRQ+X/D1jizfDmiKCTjnf00ELP
	 PXihNW+2U6yfqtINqTNMOqiTgt8k1r8Ji0ouwYQa+nWw6g2Hny4ODZvpH8U8vPKvVL
	 a9viUyAn7nsQg==
Date: Mon, 9 Dec 2024 11:40:12 +0100
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
	devicetree@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v4 05/13] rust: add `Revocable` type
Message-ID: <Z1bJDDEmI8Ew0exS@pollux.localdomain>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-6-dakr@kernel.org>
 <CAH5fLggw8Z74updxX6HtXRnZ7Zk16_ZLCoi-wkj=t2khhoV6mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggw8Z74updxX6HtXRnZ7Zk16_ZLCoi-wkj=t2khhoV6mQ@mail.gmail.com>

On Fri, Dec 06, 2024 at 04:11:39PM +0100, Alice Ryhl wrote:
> On Thu, Dec 5, 2024 at 3:16 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >
> > Revocable allows access to objects to be safely revoked at run time.
> >
> > This is useful, for example, for resources allocated during device probe;
> > when the device is removed, the driver should stop accessing the device
> > resources even if another state is kept in memory due to existing
> > references (i.e., device context data is ref-counted and has a non-zero
> > refcount after removal of the device).
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> Overall looks reasonable, but some comments below.
> 
> > +impl<T> Revocable<T> {
> > +    /// Creates a new revocable instance of the given data.
> > +    pub fn new(data: impl PinInit<T>) -> impl PinInit<Self> {
> > +        pin_init!(Self {
> > +            is_available: AtomicBool::new(true),
> > +            // SAFETY: The closure only returns `Ok(())` if `ptr` is fully initialized; on error
> > +            // `ptr` is not partially initialized and does not need to be dropped.
> > +            data <- unsafe {
> > +                Opaque::try_ffi_init(|ptr: *mut T| {
> > +                    init::PinInit::<T, core::convert::Infallible>::__pinned_init(data, ptr)
> > +                })
> 
> This is pretty awkward ... could we have an Opaque::pin_init that
> takes an `impl PinInit instead of using fii_init?

Using ffi_init was your suggestion. :) But I agree, having Opaque::pin_init
would be more convenient. I can add a patch for that.

> 
> > +            },
> > +        })
> > +    }
> > +
> > +    /// Tries to access the revocable wrapped object.
> > +    ///
> > +    /// Returns `None` if the object has been revoked and is therefore no longer accessible.
> > +    ///
> > +    /// Returns a guard that gives access to the object otherwise; the object is guaranteed to
> > +    /// remain accessible while the guard is alive. In such cases, callers are not allowed to sleep
> > +    /// because another CPU may be waiting to complete the revocation of this object.
> > +    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
> > +        let guard = rcu::read_lock();
> > +        if self.is_available.load(Ordering::Relaxed) {
> > +            // Since `self.is_available` is true, data is initialised and has to remain valid
> > +            // because the RCU read side lock prevents it from being dropped.
> > +            Some(RevocableGuard::new(self.data.get(), guard))
> > +        } else {
> > +            None
> > +        }
> > +    }
> > +
> > +    /// Tries to access the revocable wrapped object.
> > +    ///
> > +    /// Returns `None` if the object has been revoked and is therefore no longer accessible.
> > +    ///
> > +    /// Returns a shared reference to the object otherwise; the object is guaranteed to
> > +    /// remain accessible while the rcu read side guard is alive. In such cases, callers are not
> > +    /// allowed to sleep because another CPU may be waiting to complete the revocation of this
> > +    /// object.
> > +    pub fn try_access_with_guard<'a>(&'a self, _guard: &'a rcu::Guard) -> Option<&'a T> {
> > +        if self.is_available.load(Ordering::Relaxed) {
> > +            // SAFETY: Since `self.is_available` is true, data is initialised and has to remain
> > +            // valid because the RCU read side lock prevents it from being dropped.
> > +            Some(unsafe { &*self.data.get() })
> > +        } else {
> > +            None
> > +        }
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that there are no more concurrent users of the revocable object.
> > +    unsafe fn revoke_internal(&self, sync: bool) {
> 
> This boolean could be a const generic to enforce that it must be a
> compile-time value.

Agreed.

> 
> Alice

