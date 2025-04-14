Return-Path: <linux-pci+bounces-25812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2F1A87DE0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BE53B195A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC8725F7BD;
	Mon, 14 Apr 2025 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AGJQs2Z0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666126E166;
	Mon, 14 Apr 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627484; cv=none; b=peO0Q3btuDqR3eM+HbyAkiazYGxGG3B6Kw4Mfg1IK5af+AI6fWBi1miMACqsGz6qs9WzQvRE4s8PGraS1Bex6mUNkMXi7sxZ4CcTA4dbXM5PBIFJpzQmqoUw8LqD8PvyQgJIFbdzkyl0Ne714PhLubDsp1BCjcnH9/4ZHX6GoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627484; c=relaxed/simple;
	bh=gIv5RXGhRhSvSRzNRg63Sn+Y+HEZk33ik3pEUfW7oAA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ic5aN0ZOmW3NVgvA8fT0GGRxDgVJ8Srj05lQXcy8HbMugte3EsqbNnhyIHys1GzwFRPq+70fF9xrLGwV49Hy0oAd1xNv3cvBhDRyV2YgZ1o6yB9uUqsHeQqBTzo9rUBlxdsecaWLwQci0pGCsBz0afulWK7Xnxv8+iU1IGPpcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AGJQs2Z0; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744627480; x=1744886680;
	bh=a4fdBrOJHLc+DHsG3VDUOfov4qzwi8oBYErf1tej1Qw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=AGJQs2Z0Qiu0X9DkkvmwgauhP0ikhR1iKCdFbBnIX6opMA5QuPHACGpmLNUDF1b58
	 KCJLDtcRzEqGszCz9yZhp6LDg3itvcg9tTSjLK9O3xEm9hqOk5N/T5X+GPrvhHGkXW
	 NfbyKG91bHLW+cHAuMwxVsgsXwwf99cVqfF/LMx0ScaxdNpc2D80vBLnT7F1Ng4RPq
	 0I6plFLc4VLfA7FptzxoBT3mqH27tvf7xFmLuQFInyv57LtcuwKAar+GrOoQLnDUHh
	 FAxxVNZKcWf0nyXQyPqiUUVwAuQKs8rn32hBNwwZ7smKUQ0CUBfLcjtQ8ClNhLXn4O
	 VJaWSzxo6fkzw==
Date: Mon, 14 Apr 2025 10:44:35 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, abdiel.janulgue@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com, robin.murphy@arm.com, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] rust: device: implement Bound device context
Message-ID: <D96ATODOGB6O.2JAJOWXMJG3VC@proton.me>
In-Reply-To: <20250413173758.12068-7-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org> <20250413173758.12068-7-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 035391338b03753296f1b07ce9ddbadec2b91b50
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 13, 2025 at 7:37 PM CEST, Danilo Krummrich wrote:
> The Bound device context indicates that a device is bound to a driver.
> It must be used for APIs that require the device to be bound, such as
> Devres or dma::CoherentAllocation.
>
> Implement Bound and add the corresponding Deref hierarchy, as well as the
> corresponding ARef conversion for this device context.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

One suggestion below, feel free to make it its own patch or fold it into
the correct ones. Also two `::` nits below, with those fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  rust/kernel/device.rs | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 487211842f77..585a3fcfeea3 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs

> @@ -281,7 +287,14 @@ macro_rules! impl_device_context_deref {
>          // `__impl_device_context_deref!`.
>          kernel::__impl_device_context_deref!(unsafe {
>              $device,
> -            $crate::device::Core =3D> $crate::device::Normal
> +            $crate::device::Core =3D> $crate::device::Bound
> +        });
> +
> +        // SAFETY: This macro has the exact same safety requirement as
> +        // `__impl_device_context_deref!`.
> +        kernel::__impl_device_context_deref!(unsafe {

Missing `::`.

> +            $device,
> +            $crate::device::Bound =3D> $crate::device::Normal

IIUC, all "devices" (so eg `pci::Device`) will use this macro, right? In
that case, I think we can document this behavior a bit better, possibly
on the `DeviceContext` context trait and/or on the different type
states. So on `Core` we could say "The `Core` context is a supercontext
of the [`Bound`] context and devices also expose operations available in
that context while in `Core`." and similarly on `Bound` with `Normal`.

>          });
>      };
>  }
> @@ -304,6 +317,7 @@ fn from(dev: &$device<$src>) -> Self {
>  macro_rules! impl_device_context_into_aref {
>      ($device:tt) =3D> {
>          kernel::__impl_device_context_into_aref!($crate::device::Core, $=
device);
> +        kernel::__impl_device_context_into_aref!($crate::device::Bound, =
$device);

Missing `::`.

---
Cheers,
Benno

>      };
>  }
> =20



