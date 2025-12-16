Return-Path: <linux-pci+bounces-43099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1600CC114B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 07:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A19C0301C882
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 06:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53067336EF4;
	Tue, 16 Dec 2025 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGTelK3Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9523358DA;
	Tue, 16 Dec 2025 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765865556; cv=none; b=ufXOKjwgg3bGFZmFtLNxO1AI+3l3nRC9YU4oTBPQp8l6PRh3PycbVKJdqEeD5jES25HrIcDLi6zx9W1Fo9WwL7FSLhdQgmm9RzUDqSnwoeAI5U509AZAzq6d2p4adS6qN6KnW2KLh/p4d0mVDsQgS9XpOSKw9hOMrjn9q5VqiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765865556; c=relaxed/simple;
	bh=A+I04UHKw5lCsiggJwC3a6zTxGbfv3jvV4SKBE4/dIA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cZAzkpD3xjz6tc1BDmReg5iCgRHq6DWpFYLvDDcHbdD+TuUYmUiZ9WNs2e9LUdeLWY0asZbEuytqkqvdiavNmmtC0t/h+QK0GxtSbLpd1SAA+9otlo0zt9ygePHmTJQJSBBC5hc8WJfPGRjJLB1NpzSP884XV4kA9Tmi3TF6z0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGTelK3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23DAC4CEF1;
	Tue, 16 Dec 2025 06:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765865555;
	bh=A+I04UHKw5lCsiggJwC3a6zTxGbfv3jvV4SKBE4/dIA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tGTelK3QrmUWjrzbl++x6Q4x6OHDRdVlombnRPiRpgCFQ3inqoNZ6kLLmFJ//fAXP
	 6dhGAz9vuaka5p0xyBWMLk8pxcP3XWeQxXiSMe6YDWnfeSA2j1qxg76KY3+jAvwWqk
	 jHKdzzRnfBb+j5WBh21YZn6XUB7JANxaLDIG06rdkYwk/tISO6r8O1q5qpc86RdgZ6
	 a3aE3Spw97ncm9LKkgCgDa4nI+aVWFkeMII2lzNTqay7NJYiHMVNYZa6NJ/XIurr9A
	 xmcz73A6w2Q0DP3EU9JNr+UpweueFG8UlXfb0gDSelk/dM1NEp9Hq4TeSh4MeYqMhm
	 gxq3tZTalVndg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 07:12:27 +0100
Message-Id: <DEZF3DDSQXA9.2WAC2D5ZDKHDZ@kernel.org>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH RFC 4/7] rust: pin-init: allow `dead_code` on projection
 structure
From: "Benno Lossin" <lossin@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
X-Mailer: aerc 0.21.0
References: <20251216-nova-unload-v1-0-6a5d823be19d@nvidia.com>
 <20251216-nova-unload-v1-4-6a5d823be19d@nvidia.com>
In-Reply-To: <20251216-nova-unload-v1-4-6a5d823be19d@nvidia.com>

On Tue Dec 16, 2025 at 6:13 AM CET, Alexandre Courbot wrote:
> Projection structures are not necessarily (and often not) used in their
> entirety. At the moment partial uses result in warnings about the unused
> members.
>
> Discard them by allowing `dead_code` on the projection structure
>
> To: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> ---
> Benno, please let me know if this looks good to you and I will send you
> a Github PR for this.

Looks good :)

Cheers,
Benno

> ---
>  rust/pin-init/src/macros.rs | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
> index 682c61a587a0..fe60e570c729 100644
> --- a/rust/pin-init/src/macros.rs
> +++ b/rust/pin-init/src/macros.rs
> @@ -1004,6 +1004,7 @@ fn drop(&mut self) {
>          @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $type=
:ty),* $(,)?),
>      ) =3D> {
>          $crate::macros::paste! {
> +            #[allow(dead_code)]
>              #[doc(hidden)]
>              $vis struct [< $name Projection >] <'__pin, $($decl_generics=
)*> {
>                  $($(#[$($p_attr)*])* $pvis $p_field : ::core::pin::Pin<&=
'__pin mut $p_type>,)*


