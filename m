Return-Path: <linux-pci+bounces-30742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFFEAE9B9E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D6416E5B1
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C12C25A2C3;
	Thu, 26 Jun 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIimtl2L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C81222590;
	Thu, 26 Jun 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750934189; cv=none; b=dDO47fhPrOokNTKtjsg7maHX4Wzh8bx/AN9NcrXBF4vESNCjSpNRro4uyGa4Sf/L6EcEjE4LUMDtDnqKBdWk/hZ1ADcWxfU/6NGlRWekNt7HXZbLcnI98m6wkpaDGMP7wlG0h9DidbGb1hzdpj74oZMzxTObDo1gKwpvmM38Mlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750934189; c=relaxed/simple;
	bh=awgx4GCv+DU9O391SVRk/D4EEDX+wR3EWr3gJ0RVJZ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=AsChr+hJ+18U0OO9FQ6ZSpUqswoZaRIvKa7aZJ6z4iYoABkWO75N6bTHvyzYPUaqA010EQFV1DtxkzYceuvi/7Kv70HRNroTChKHsFZaPJjCpKJL3/IgFtvL4vb9/PNFTMr1IXYZHqNI529XZAJgj3gSIwGoYLgZidKNyq7RP3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIimtl2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FF4C4CEEB;
	Thu, 26 Jun 2025 10:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750934188;
	bh=awgx4GCv+DU9O391SVRk/D4EEDX+wR3EWr3gJ0RVJZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UIimtl2LFIMtv61BMJTLnOiyklJzr5y1r/gaLDPPDy+hHVsUj825W7EO1MpTh98KO
	 Bfyys9ZRcY85iIqA4qvdHGYDdwwTtvocxo5GxYiUTuQ0MJHGxUZ3i6+ZEo+ip679gh
	 I+5xTGkWfvVweJIaE7SkDYjnw0G5xI8evVeI6ErRSUeYMEgpLUU2jlyhg8iBek3GOP
	 ya+du6Mw+aelhuVjgctRiT70B9Y5lfLkndKtGWm0ylBUJEWDsDMTs/Sqe8QvcSCIQm
	 qzxDUiW3Gw3FBD4ZzpEK9xjNa3Yywu54oNlU5KvdNDYGj4ayDtY2lH9mEIplohJp53
	 WLAbq0M+3A10g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 12:36:23 +0200
Message-Id: <DAWED7BIC32G.338MXRHK4NSJG@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] rust: devres: implement register_release()
X-Mailer: aerc 0.20.1
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-5-dakr@kernel.org>
In-Reply-To: <20250624215600.221167-5-dakr@kernel.org>

On Tue Jun 24, 2025 at 11:54 PM CEST, Danilo Krummrich wrote:
> +pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
> +where
> +    P: ForeignOwnable + 'static,
> +    for<'a> P::Borrowed<'a>: Release,
> +{
> +    let ptr =3D data.into_foreign();
> +
> +    #[allow(clippy::missing_safety_doc)]
> +    unsafe extern "C" fn callback<P>(ptr: *mut kernel::ffi::c_void)
> +    where
> +        P: ForeignOwnable,
> +        for<'a> P::Borrowed<'a>: Release,
> +    {
> +        // SAFETY: `ptr` is the pointer to the `ForeignOwnable` leaked a=
bove and hence valid.
> +        unsafe { P::borrow(ptr.cast()) }.release();
> +
> +        // SAFETY: `ptr` is the pointer to the `ForeignOwnable` leaked a=
bove and hence valid.
> +        drop(unsafe { P::from_foreign(ptr.cast()) });

Maybe this function should just be:

    let p =3D unsafe { P::from_foreign(ptr.cast()) };
    p.release();

And we require `P: ForeignOwnable + Release + 'static`?

We then need these impls instead:

    impl<T: Release, A: Allocator> Release for Pin<Box<T, A>>;
    impl<T: Release, A: Allocator> Release for Box<T, A>;
    impl<T: Release> Release for Arc<T>;

Or, we could change `Release` to be:

    pub trait Release {
        type Ptr: ForeignOwnable;

        fn release(this: Self::Ptr);
    }

and then `register_release` is:

    pub fn register_release<T: Release>(dev: &Device<Bound>, data: T::Ptr) =
-> Result

This way, one can store a `Box<T>` and get access to the `T` at the end.
Or if they store the value in an `Arc<T>`, they have the option to clone
it and give it to somewhere else.

Related questions:

* should we implement `ForeignOwnable` for `&'static T`?
* should we require `'static` in `ForeignOwnable`? At the moment we only
  have those kinds supported and it only makes sense, a foreign owned
  object can be owned for any amount of time (so it must stay valid
  indefinitely).

---
Cheers,
Benno

> +    }
> +
> +    // SAFETY:
> +    // - `dev.as_raw()` is a pointer to a valid and bound device.
> +    // - `ptr` is a valid pointer the `ForeignOwnable` devres takes owne=
rship of.
> +    to_result(unsafe {
> +        // `devm_add_action_or_reset()` also calls `callback` on failure=
, such that the
> +        // `ForeignOwnable` is released eventually.
> +        bindings::devm_add_action_or_reset(dev.as_raw(), Some(callback::=
<P>), ptr.cast())
> +    })
> +}


