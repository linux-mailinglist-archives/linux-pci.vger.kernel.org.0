Return-Path: <linux-pci+bounces-19405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB331A03E38
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFD17A3246
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12D1E9B39;
	Tue,  7 Jan 2025 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGi+DUWs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0911E5738;
	Tue,  7 Jan 2025 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250503; cv=none; b=Bwp2qYSNIO7aF0fI6D/XK/cxZhDheLYsrIq8WmRWoJH3aZAuV5napoFnIkPZV+pPhbeOkm/m9s1ZQZXSMv2rv95I14yC9kBPGES6ZWG2OUuOA1Iekp+rwSf3sQwZhnkir3ulFjrgWa5U0zNohZW9yQiRNdOGKzF/TCZxnlEJO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250503; c=relaxed/simple;
	bh=Eip+DrhNbLbq1UfPZongISxQ1F7rV6nxezYq+mp8lEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qCH4I51nSuBMk/vCgZufp5vUPkl/oHiwfO8IylnTdW1dB0qv9urYVtFnBl/RXdRPnP5lDYGuJRN7/RywlSqJkKM5KHonjokZpFifIjgMayFDAy0ZFGYuZU5gORs/xOsZ7gBCHjdgruoCQxeQFGf4lgci+UDnYVcf0hDhIkALS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGi+DUWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA05DC4CEDD;
	Tue,  7 Jan 2025 11:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736250502;
	bh=Eip+DrhNbLbq1UfPZongISxQ1F7rV6nxezYq+mp8lEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YGi+DUWsLoOIAdLwb9yEOFwDPXtVhePTCzpFSR+5a067JNxZw0UJKn/u0kT7hWGkZ
	 6+EbNDR4KIL8JQwDJN9KzFluLEdPgbD9Ip5OMW+iDJBm/YD6sfwWM1OXdpuM9+sZrw
	 IJ01BrB54vOhuuijW7hZyIs6gjxE6TJ/qOYM1jx8iBio/Wnq9QM5H6FvlfGUcoSrvO
	 dOV4Wfh0TdgGhQKt4UTDKFjxfEBFu94I148JJB1d9ZjXbR+T2HnhwyAPn2NmT8FK+8
	 wGMGfHdsd0soFN829jx54uXolCypTOYWGtomsZw++eg1fM6+umhDr3Al3nJdMXVDil
	 vIQzQ7UScKnSQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alistair Francis" <alistair@alistair23.me>
Cc: <bhelgaas@google.com>,  <rust-for-linux@vger.kernel.org>,
  <lukas@wunner.de>,  <gary@garyguo.net>,  <akpm@linux-foundation.org>,
  <tmgross@umich.edu>,  <boqun.feng@gmail.com>,  <ojeda@kernel.org>,
  <linux-cxl@vger.kernel.org>,  <bjorn3_gh@protonmail.com>,
  <me@kloenk.dev>,  <linux-kernel@vger.kernel.org>,
  <aliceryhl@google.com>,  <alistair.francis@wdc.com>,
  <linux-pci@vger.kernel.org>,  <benno.lossin@proton.me>,
  <alex.gaynor@gmail.com>,  <Jonathan.Cameron@huawei.com>,
  <alistair23@gmail.com>,  <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v5 00/11] rust: bindings: Auto-generate inline static
 functions
In-Reply-To: <20250107035058.818539-1-alistair@alistair23.me> (Alistair
	Francis's message of "Tue, 07 Jan 2025 13:50:47 +1000")
References: <PsAMnW6hScU1fLV8ucb6wOkHECGXCrwXeSEfeVs3Hc-zbwrML674jGT8H_XNvWiF6EdymYJZSusanBrtAsZjAg==@protonmail.internalid>
	<20250107035058.818539-1-alistair@alistair23.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 07 Jan 2025 12:47:10 +0100
Message-ID: <878qrm6e2p.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alistair Francis" <alistair@alistair23.me> writes:

> The kernel includes a large number of static inline functions that are
> defined in header files. One example is the crypto_shash_descsize()
> function which is defined in hash.h as
>
> ```
> static inline unsigned int crypto_shash_descsize(struct crypto_shash *tfm)
> {
>         return tfm->descsize;
> }
> ```
>
> bindgen is currently unable to generate bindings to these functions as
> they are not publically exposed (they are static after all).
>
> The Rust code currently uses rust_helper_* functions, such as
> rust_helper_alloc_pages() for example to call the static inline
> functions. But this is a hassle as someone needs to write a C helper
> function.
>
> Instead we can use the bindgen wrap-static-fns feature. The feature
> is marked as experimental, but has recently been promoted to
> non-experimental (depending on your version of bindgen).
>
> By supporting wrap-static-fns we automatically generate a C file called
> extern.c that exposes the static inline functions, for example like this
>
> ```
> unsigned int crypto_shash_descsize__extern(struct crypto_shash *tfm) { re=
turn crypto_shash_descsize(tfm); }
> ```
>
> The nice part is that this is auto-generated.
>
> We then also get a bindings_generate_static.rs file with the Rust
> binding, like this
>
> ```
> extern "C" {
>     #[link_name =3D "crypto_shash_descsize__extern"]
>     pub fn crypto_shash_descsize(tfm: *mut crypto_shash) -> core::ffi::c_=
uint;
> }
> ```
>
> So now we can use the static inline functions just like normal
> functions.
>
> There are a bunch of static inline functions that don't work though, beca=
use
> the C compiler fails to build extern.c:
>  * functions with inline asm generate "operand probably does not match co=
nstraints"
>    errors (rip_rel_ptr() for example)
>  * functions with bit masks (u32_encode_bits() and friends) result in
>    "call to =E2=80=98__bad_mask=E2=80=99 declared with attribute error: b=
ad bitfield mask"
>    errors
>
> As well as that any static inline function that calls a function that has=
 been
> kconfig-ed out will fail to link as the function being called isn't built
> (mdio45_ethtool_gset_npage for example)
>
> Due to these failures we use a allow-list system (where functions must
> be manually enabled).
>
> This series adds support for bindgen generating wrappers for inline stati=
cs and
> then converts the existing helper functions to this new method. This does=
n't
> work for C macros, so we can't reamove all of the helper functions, but we
> can remove most.
>
> v5:
>  - Rebase on latest rust-next on top of v6.13-rc6
>  - Allow support for LTO inlining (not in this series, see
>    https://github.com/alistair23/linux/commit/e6b847324b4f5e904e007c0e288=
c88d2483928a8)

Thanks! Since Gary just sent v2 of the LTO patch [1], could you rebase
on that and list it as a dependency? If you are using b4 there is a nice
feature for that [2].


Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/all/20250105194054.545201-1-gary@garyguo.net/
[2] https://b4.docs.kernel.org/en/latest/contributor/prep.html#working-with=
-series-dependencies


