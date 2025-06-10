Return-Path: <linux-pci+bounces-29322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30875AD3795
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 14:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC711899912
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 12:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581C529A9FA;
	Tue, 10 Jun 2025 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwUg6wmW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD12980BC;
	Tue, 10 Jun 2025 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559792; cv=none; b=iozG9rQUxKEGaRCstt1DPE6yfMbkNQw81F16DbZkwVNJRxFqVErIip6ds0COfJSq98XcjQHLu/TOJqsiFo0AS8DEapR8EE84GUtHSzQX6aJDEocQCAVtbcxNZdxlBaEMORtRbUouizFsBGUY78kgqsALRLZ5vEhOqPI2G11462w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559792; c=relaxed/simple;
	bh=W25gwF8YLypX00uVpfkkP6wlbnXPxSb2jvfHBAnd+vY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lJubkXEyRNO7jdi++gHu7bfUrSJGBBAnGd+BIolsmEnUK1XWrW6BFB3HDkL61aGyOjiEXk+ILt+dKI1t8ujKVARDfxPZmNs5egQXCzBFza/AWBJZakZp5QZzueSe1Ptyb6J8ihdFI5DePMllyGFCV90VKxwjlfmBvr3T845AUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwUg6wmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2F3C4CEED;
	Tue, 10 Jun 2025 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559792;
	bh=W25gwF8YLypX00uVpfkkP6wlbnXPxSb2jvfHBAnd+vY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=VwUg6wmWcuTukn6x1MQGWJPG+DKhnF59n+5X7dRAFpNe9wLyOZUORUruold83pPJB
	 bj9cUFcdGcwRTmqRe1QJrvcNaGpT4Th/3mWc72HdtaMPxBjuw3O5XQblI2i2oY8nXT
	 L3taybLarOHsO/T1+5z3pIpkQdsF4ZnOF8zKXn8BaNBkC7oX6XCBQYxvLxoPp9NhLy
	 1nk/dp4mTL8TcPpEScGuJW6VI+BWDrvXhKEfsxcmbs7RzsSBqetC126UdT5W2iZFMp
	 gdfi9PFgSsMe3rNi1AC5u9W0TCBRza9ek1otV993a1VUp7GYyGo2rrL+0+2dXcG4YJ
	 8EDLEncuDDzvg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 14:49:47 +0200
Message-Id: <DAIV6MJAJ5R0.3TZ4IC2KO9MOL@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, =?utf-8?q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>
Subject: Re: [PATCH v2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Tamir Duberstein" <tamird@gmail.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>
X-Mailer: aerc 0.20.1
References: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
In-Reply-To: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>

On Tue Jun 10, 2025 at 1:30 PM CEST, Andreas Hindborg wrote:
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 22985b6f6982..0ccef6b5a20a 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -21,15 +21,11 @@
>  ///
>  /// # Safety
>  ///
> -/// Implementers must ensure that [`into_foreign`] returns a pointer whi=
ch meets the alignment
> -/// requirements of [`PointedTo`].
> -///
> -/// [`into_foreign`]: Self::into_foreign
> -/// [`PointedTo`]: Self::PointedTo
> +/// Implementers must ensure that [`Self::into_foreign`] returns pointer=
s aligned to
> +/// [`Self::FOREIGN_ALIGN`].
>  pub unsafe trait ForeignOwnable: Sized {
> -    /// Type used when the value is foreign-owned. In practical terms on=
ly defines the alignment of
> -    /// the pointer.
> -    type PointedTo;
> +    /// The alignment of pointers returned by `into_foreign`.
> +    const FOREIGN_ALIGN: usize;
> =20
>      /// Type used to immutably borrow a value that is currently foreign-=
owned.
>      type Borrowed<'a>;
> @@ -39,18 +35,20 @@ pub unsafe trait ForeignOwnable: Sized {
> =20
>      /// Converts a Rust-owned object to a foreign-owned one.
>      ///
> +    /// The foreign representation is a pointer to void. Aside from the =
guarantees listed below,

I feel like this reads better:

s/guarantees/ones/

> +    /// there are no other guarantees for this pointer. For example, it =
might be invalid, dangling

We should also mention that it could be null. (or is that assumption
wrong?)

---
Cheers,
Benno

> +    /// or pointing to uninitialized memory. Using it in any way except =
for [`from_foreign`],
> +    /// [`try_from_foreign`], [`borrow`], or [`borrow_mut`] can result i=
n undefined behavior.
> +    ///
>      /// # Guarantees
>      ///
> -    /// The return value is guaranteed to be well-aligned, but there are=
 no other guarantees for
> -    /// this pointer. For example, it might be null, dangling, or point =
to uninitialized memory.
> -    /// Using it in any way except for [`ForeignOwnable::from_foreign`],=
 [`ForeignOwnable::borrow`],
> -    /// [`ForeignOwnable::try_from_foreign`] can result in undefined beh=
avior.
> +    /// - Minimum alignment of returned pointer is [`Self::FOREIGN_ALIGN=
`].
>      ///
>      /// [`from_foreign`]: Self::from_foreign
>      /// [`try_from_foreign`]: Self::try_from_foreign
>      /// [`borrow`]: Self::borrow
>      /// [`borrow_mut`]: Self::borrow_mut
> -    fn into_foreign(self) -> *mut Self::PointedTo;
> +    fn into_foreign(self) -> *mut crate::ffi::c_void;
> =20
>      /// Converts a foreign-owned object back to a Rust-owned one.
>      ///

