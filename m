Return-Path: <linux-pci+bounces-24274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7FDA6B147
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACA818944B5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3C224240;
	Thu, 20 Mar 2025 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CDgK8GhM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD922155C
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742511365; cv=none; b=T2cqKwlO8U2RKJNMIre66kI9RIVRpBtzcs3ALKkrne9gWxNcS6A8CVcO16JFnD/TgsPF5JYcDPYZV/3E70H0Gq6UBuCEgIybx5KSDxmFFAqdO63UwHtNRs0kGJ/iGOSDFpKotTFBAscWwN+LRQJdNk6UKgkHsGWCDtTjrJM7y7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742511365; c=relaxed/simple;
	bh=ma8MNS39u0Sxa1/Tgus3sjjGzSbvJGwyPTv7J+m5aaw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGEMvf/zOdDBrSZUrbLiKq4HYIf+Mge1uu9oLT4/dLAnziTvZk0bvh81BHp1ic3clXI6o3CAgVEoCych5kIaDr7f1iHum8LAt7z8hF7UM8LYEK4+YqiXfrfdKuEShh3zHKWVbsvPuf8OmD+TbXZlpwdaRZoV0FCyUWpziN1Xcrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CDgK8GhM; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742511361; x=1742770561;
	bh=ddBTulHymzLE55DHUMDCG5+higdRgLgEM8VGyZIKU+k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=CDgK8GhMm66yUJBY8ooaRmHDp6u0E+BKtOc+2H2PqraEfrgccjK6HrbD+jcjjOd3w
	 RYCEZooOhMPyN8K8mYqtdntPoqf3uNSQPZ1iRR20Hb+I8V3V+/nigGDviJQAyiWxj1
	 kPmJLFlTKcj1KWquYwuMvKkMGVkAqTVjbrFuhejZuDNpIdZA7Cmp3pxCVCt8ayR942
	 F/ePN2RfSTb5b8StFFj6l5fyQEIWUb8dHQ+4Lk3glr9OGm+/KZEc9W+36eh2cbf/xe
	 Q7txswYslCxWylftCvxAEsMiFAOYE0bTnEKLR95PZnmHoAAvZukGLiGuxKkqyG6JpG
	 hMcdr6VhdSkZw==
Date: Thu, 20 Mar 2025 22:55:56 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] rust: device: implement bus_type_raw()
Message-ID: <D8LGQ1BTPFBR.1P5LGD0LWP32W@proton.me>
In-Reply-To: <20250320222823.16509-3-dakr@kernel.org>
References: <20250320222823.16509-1-dakr@kernel.org> <20250320222823.16509-3-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ccff88a94d296e77877278f3b8e6a9ada1123fb4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 11:27 PM CET, Danilo Krummrich wrote:
> Implement bus_type_raw(), which returns a raw pointer to the device'
> struct bus_type.
>
> This is useful for bus devices, to implement the following trait.
>
> =09impl TryFrom<&Device> for &pci::Device
>
> With this a caller can try to get the bus specific device from a generic
> device in a safe way. try_from() will only succeed if the generic
> device' bus type pointer matches the pointer of the bus' type.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/device.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index f6bdc2646028..1b554fdd93e9 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -80,6 +80,16 @@ pub fn parent<'a>(&self) -> Option<&'a Self> {
>          }
>      }
> =20
> +    /// Returns a raw pointer to the device' bus type.
> +    #[expect(unused)]
> +    pub(crate) fn bus_type_raw(&self) -> *const bindings::bus_type {
> +        // SAFETY:
> +        // - By the type invariants, `self.as_raw()` is a valid pointer =
to a `struct device`.
> +        // - `dev->bus` is a pointer to a `const struct bus_type`, which=
 is only ever set at device
> +        //    creation.
> +        unsafe { (*self.as_raw()).bus }
> +    }
> +
>      /// Convert a raw C `struct device` pointer to a `&'a Device`.
>      ///
>      /// # Safety



