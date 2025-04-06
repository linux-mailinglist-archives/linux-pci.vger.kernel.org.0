Return-Path: <linux-pci+bounces-25351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE275A7D0AB
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 23:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B7316FF8A
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 21:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D061AAA1C;
	Sun,  6 Apr 2025 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="l34j6OkM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216E12CD8B;
	Sun,  6 Apr 2025 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743974449; cv=none; b=qhabPc0NbjdwUkB4qycX1OjmW30RXx58yk05AfMxlKHBAe76fFUx3XNWigMXwwXBkt3F+S6y/IOw0C5/3D5G7wkr0tEjsxUKZhdEhEWYN5e0U4ahagHJL47B7Eifgk9LZ0XvzebOEgQ2QZjP0h8UC1BTTDYzcWrYCETv/jqkJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743974449; c=relaxed/simple;
	bh=51tg3Od3eO74TkgCQSHss3Q4kOSYtoMyp3PIdsD9RLo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIVQO60aHgvuRJAtm64Xg0hcE5dMHoHaEeJVbkutDplbapnLmHzIiZiIfjT2sSoAseDrIse/26kPk2AJ7EPRo3n1zK6xXgq9G4X4F5oQ27OQJYTWXAkhiYbrE7eb5aJvNvYbuQQVgyeVNaVlKB2EJVkIiTMIHV79ToTNGwS2PwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=l34j6OkM; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7gwchjfi55cvvivonziowqzoji.protonmail; t=1743974445; x=1744233645;
	bh=ISWFelpkh6LRHzjfciYsxsLRW9qPCP2pJoMq0lL+F9w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=l34j6OkMOEwQ4WpQR2QONQ02aN8KI5ij5225WAvCHiL/M43GGh/WUYa9x4n/fea16
	 9E2il28j3kb8hvjCC+My9iRTA82mv6l6dygKNvmzkROIIsRE9piF9LVxF/WexTztZg
	 Ht3blfz6xBzKa/SG/loLJbJIIOkWOHDxGoeyPmQT5zqeLbB/oq1MyfW7Tk6fFagdg7
	 ywDkNaAGSodRnVzKarT1ojoZrh7UK0d9BLJ8Sk2FMUaiNycpJnaLQWaagYiOhN6h3x
	 LH5RGYIEmhmUDU/G2V446GCe0pDYI7OhJFQ/5sMVMyWm6yU7OuFIVqR3ibLvaKAxwN
	 doY+77R991l2Q==
Date: Sun, 06 Apr 2025 21:20:39 +0000
To: Alexandre Courbot <acourbot@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/2] samples: rust: convert PCI rust sample driver to use try_access_with()
Message-ID: <D8ZVCB2BC5L7.2FK9GSCBCEGMO@proton.me>
In-Reply-To: <20250406-try_with-v3-2-c0947842e768@nvidia.com>
References: <20250406-try_with-v3-0-c0947842e768@nvidia.com> <20250406-try_with-v3-2-c0947842e768@nvidia.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a2c9f068deb34495424d06e40fc0f0e73e7d45aa
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 6, 2025 at 3:58 PM CEST, Alexandre Courbot wrote:
> This method limits the scope of the revocable guard and is considered
> safer to use for most cases, so let's showcase it here.
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  samples/rust/rust_driver_pci.rs | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index 1fb6e44f33951c521c8b086a7a3a012af911cf26..f2cb1c220bce42d161cf48664=
e8a5dd19770ba97 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -83,13 +83,12 @@ fn probe(pdev: &mut pci::Device, info: &Self::IdInfo)=
 -> Result<Pin<KBox<Self>>>
>              GFP_KERNEL,
>          )?;
> =20
> -        let bar =3D drvdata.bar.try_access().ok_or(ENXIO)?;
> +        let res =3D drvdata
> +            .bar
> +            .try_access_with(|b| Self::testdev(info, b))
> +            .ok_or(ENXIO)??;
> =20
> -        dev_info!(
> -            pdev.as_ref(),
> -            "pci-testdev data-match count: {}\n",
> -            Self::testdev(info, &bar)?
> -        );
> +        dev_info!(pdev.as_ref(), "pci-testdev data-match count: {}\n", r=
es);
> =20
>          Ok(drvdata.into())
>      }



