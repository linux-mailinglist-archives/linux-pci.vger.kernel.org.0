Return-Path: <linux-pci+bounces-23909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A02A64787
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 10:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9163A6471
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDD5222594;
	Mon, 17 Mar 2025 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="O6yrVXnX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8D21D595;
	Mon, 17 Mar 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204047; cv=none; b=W6TJfwxg09jU180W5Vn48WZ1c6P0lNn5P3t1F+lm0676o+GMY34UguOwvSF5XJ8NdjGmMucPFD/HfP42WxrV+AajcxQkMwWFBwxZXNqpp3+Lm+dTlG1OEN1IgxYw4pjG2aqQbTXDZtmYCBaeoeM2UjjfMm9ELqwDQlsJY1x+nEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204047; c=relaxed/simple;
	bh=ELzfSEZuhr25sXbSFYa8Pvn+Hzk6Nq+k/X6C4475L78=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7jn0LWx2U3R9f0RtVEn6kigwoB7ggMdkYAgG5xdNE1/7CcUsaTRFAuGI7GvTRdzaEjQ2wo6JkKVaEy86fMCpTgYjQX5ANiMpH10J5+0C9FxYhDh1bW35iwwBs7fTHoB++ooi1wGs1sgQ6NvhJsZOrs1Llk4X7dWXLA7MZkgNKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=O6yrVXnX; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742204040; x=1742463240;
	bh=FMpu9u3oj6vcJmcZvMEZn/YisvXXjcOdgQLecCKsTSY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=O6yrVXnXOA3zGBPsi58FLNfuNpgVmzRiUQVSt6n2RvDFaScYeNrmXm3L1XRnQzrCB
	 8YlXNeEvc40Q8ELt8iWYb+KxAyvWpjqulvZgkNYKWJO35Cij+vUrsQ0GE7dUOlk+Jc
	 rzMvfujAWxXxusZkbpaGYypuRMbU0pOLD+IP4MHj08+imTci+wd6XeRMC5LuYndpni
	 M9/0EHtFyD89TeUGfSMNoe5XXrjHoXufvS4DgXPkj63oNVXQntmnqx4q3dqLr5UZPP
	 OuNLW59d65h/ntfWzcGZJHsxtH2V6/1dpPJRMXGxgh4h0t6z0VLLIpNrDRSFWnHQPf
	 hwkSkhYH00J8Q==
Date: Mon, 17 Mar 2025 09:33:52 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 6/6] rust: use strict provenance APIs
Message-ID: <D8IFS7175NNQ.3VAP8WA2QC8WF@proton.me>
In-Reply-To: <20250315-ptr-as-ptr-v4-6-b2d72c14dc26@gmail.com>
References: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com> <20250315-ptr-as-ptr-v4-6-b2d72c14dc26@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ae828af5ffc8f596a802aaa8ecc51e4ae679d167
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Mar 15, 2025 at 1:17 PM CET, Tamir Duberstein wrote:
> Throughout the tree, use the strict provenance APIs stabilized in Rust
> 1.84.0[1]. Retain backwards-compatibility by introducing forwarding
> functions at the `kernel` crate root along with polyfills for rustc <
> 1.84.0.
>
> Use `#[allow(clippy::incompatible_msrv)]` to avoid warnings on rustc <
> 1.84.0 as our MSRV is 1.78.0.

This isn't necessary, right?

> In the `kernel` crate, enable the strict provenance lints on rustc >=3D
> 1.84.0; do this in `lib.rs` rather than `Makefile` to avoid introducing
> compiler flags that are dependent on the rustc version in use.

So it won't be enabled in the doctests, right?

> Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-prove=
nance-apis [1]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  init/Kconfig           |  3 +++
>  rust/kernel/alloc.rs   |  2 +-
>  rust/kernel/devres.rs  |  4 ++--
>  rust/kernel/io.rs      | 14 +++++++-------
>  rust/kernel/lib.rs     | 52 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/of.rs      |  2 +-
>  rust/kernel/pci.rs     |  4 ++--
>  rust/kernel/str.rs     | 16 ++++++----------
>  rust/kernel/uaccess.rs | 12 ++++++++----
>  9 files changed, 82 insertions(+), 27 deletions(-)


> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 486715528587..84eb2602e79e 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -17,6 +17,9 @@
>  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_unsized=
))]
>  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch_from_=
dyn))]
>  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
> +#![cfg_attr(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE, feature(strict_pr=
ovenance_lints))]
> +#![cfg_attr(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE, deny(fuzzy_proven=
ance_casts))]
> +#![cfg_attr(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE, deny(lossy_proven=
ance_casts))]
>  #![feature(inline_const)]
>  #![feature(lint_reasons)]
>  // Stable in Rust 1.83
> @@ -25,6 +28,55 @@
>  #![feature(const_ptr_write)]
>  #![feature(const_refs_to_cell)]
> =20
> +#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
> +#[allow(clippy::incompatible_msrv)]

Do we still need this allow?

> +mod strict_provenance {
> +    #[doc(hidden)]

Why make them hidden in docs?

> +    pub fn expose_provenance<T>(addr: *const T) -> usize {
> +        addr.expose_provenance()

Instead of having these stubs here, you can probably just do

    pub use core::ptr::expose_provenance;

> +    }
> +
> +    #[doc(hidden)]
> +    pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
> +        core::ptr::without_provenance_mut(addr)
> +    }
> +
> +    #[doc(hidden)]
> +    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
> +        core::ptr::with_exposed_provenance(addr)
> +    }
> +
> +    #[doc(hidden)]
> +    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
> +        core::ptr::with_exposed_provenance_mut(addr)
> +    }
> +}
> +
> +#[cfg(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE))]
> +mod strict_provenance {
> +    #[doc(hidden)]

I think we should document these.

---
Cheers,
Benno

> +    pub fn expose_provenance<T>(addr: *const T) -> usize {
> +        addr.cast::<()>() as usize
> +    }
> +
> +    #[doc(hidden)]
> +    pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
> +        addr as *mut T
> +    }
> +
> +    #[doc(hidden)]
> +    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
> +        addr as *const T
> +    }
> +
> +    #[doc(hidden)]
> +    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
> +        addr as *mut T
> +    }
> +}
> +
> +pub use strict_provenance::*;


