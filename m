Return-Path: <linux-pci+bounces-29556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FA9AD74A7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D3B2C1E94
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB4426FD97;
	Thu, 12 Jun 2025 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeYAYC1p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DFB26FA7E;
	Thu, 12 Jun 2025 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739941; cv=none; b=diW8ENv5UfyxTIDzKsTZd6mJSVVQrti0OTf8Tf+Oz9AaOGD5sfYneudjcVgrZNgsdD9fSiN9m6dBH0HvsXLv/JG/CEJWF0ihJUFoaOxDUPs0SQajQ1Fo0a30sjLFFd6MQiPZa630UfxuddoiEdD6qVemFvEF+CW0Bo3MmaCizTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739941; c=relaxed/simple;
	bh=m6NyqVWcWAB8aZ/nz34ATunc9qSW/wqIr84I2Z9j8i0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=UxWIZJsR6XlCvd3n7x3DBb8tCzxptwXrkck5RExjq2m3ZrJ7q2bF9tHEeOGJfMvGnWCSIguwu7bMc1UHzKLnTlwCZJ8Bp5dSXqQduPMAXJ6A1Cqw8KWbFaBid1vntWxfRRIVyClSjDZ+CNhmpu8Z9DvYsTiwAPXIS/BVrAWV6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeYAYC1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0121C4CEEA;
	Thu, 12 Jun 2025 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749739941;
	bh=m6NyqVWcWAB8aZ/nz34ATunc9qSW/wqIr84I2Z9j8i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JeYAYC1pgOTLgRtJQR3ro4v2evFDxPvv7OltvZWSAFXXZ+ZiA/at2rRH9xdJ7vF97
	 VJdO1LiOYdXjl5huYnGF9lJ5T0UfW2s/OmeDhw+DxTDhq9oSP17wuFALaZOWk0pNHi
	 3/P/nSDT+R3NLsuqFpQHMvc2pceSxnbawpMU8L0AZbL6x2PsvGjaahoz7iHio6/xHA
	 fQZ0TDQol/WMTztVVX3RKvTepsVgprKEOT1NNj/xDLdM1RrkyfFcDY3OASbC9FVW3o
	 x0vQKXphjHf+WGhTQB1TKOEiLMVN7syh9AkTcoeH2pNhM0bcSBgflp5aX2Jcm1BDLD
	 MvFiGhn+6l8tA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Jun 2025 16:52:15 +0200
Message-Id: <DAKN1HO7WUXY.QS098VXTDICU@kernel.org>
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
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] rust: types: require
 `ForeignOwnable::into_foreign` return non-null
X-Mailer: aerc 0.20.1
References: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
 <20250612-pointed-to-v3-2-b009006d86a1@kernel.org>
In-Reply-To: <20250612-pointed-to-v3-2-b009006d86a1@kernel.org>

On Thu Jun 12, 2025 at 3:09 PM CEST, Andreas Hindborg wrote:
> The intended implementations of `ForeignOwnable` will not return null
> pointers from `into_foreign`, as this would render the implementation of
> `try_from_foreign` useless. Current users of `ForeignOwnable` rely on
> `into_foreign` returning non-null pointers. So require `into_foreign` to
> return non-null pointers.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/types.rs | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index c156808a78d3..63a2559a545f 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -43,6 +43,7 @@ pub unsafe trait ForeignOwnable: Sized {
>      /// # Guarantees
>      ///
>      /// - Minimum alignment of returned pointer is [`Self::FOREIGN_ALIGN=
`].
> +    /// - The returned pointer is not null.

This also needs to be mentioned in the `Safety` section of this trait.
Alternatively you can put "Implementers must ensure the guarantees on
[`into_foreign`] are upheld." or similar.

---
Cheers,
Benno

>      ///
>      /// [`from_foreign`]: Self::from_foreign
>      /// [`try_from_foreign`]: Self::try_from_foreign


