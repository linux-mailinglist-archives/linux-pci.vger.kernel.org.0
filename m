Return-Path: <linux-pci+bounces-26836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B16A9DD1D
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 22:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020DE5A6D03
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 20:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E501F3BAC;
	Sat, 26 Apr 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ONhBxUON"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5921AD3F6;
	Sat, 26 Apr 2025 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745699450; cv=none; b=Wy32zip2Bm7R4EryRizZ3jEftHB9HOUKsFDyWTDFAeUdUBke5dxaIfz0/ZSB0s6rVxT+x6jdkHjJFXDEtwoI/NNlS2xWeTSii5rTp6xIwl2KCkvivjiTdRv043niPeshs9pZtfK+iKlxVs98O69H7O1XshFgnYCyjEhZuT1pNBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745699450; c=relaxed/simple;
	bh=+nmKiUjEEox7XNLRBATJdYPinA8FVwEJGegf7U+k6Io=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7Rx425fQ+mmxpvrXN3VhIS/Z6G44raETScU8A6918aqthxOWYnC1n36WGmJEr2SNG47v0Jks16tDClPLb3S1rzC6Ky7wAmBvrc7J++KgjvdUuy46RqCImqL0dXlBqBH9joKotU6XjnG5giC168b4UivsGmNcEQ77mQh2o4G3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ONhBxUON; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1745699446; x=1745958646;
	bh=F5aVZIYhmzSD+hbmShagvcb5LiFVBTl3TseGY+Mtgpk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ONhBxUONiUZ3zeKDgWwXPyIkiiEZcLKSVmep9xJPyEA5X88V5Tc20vh8X8aX51qGe
	 J92a+lDbAKCLVLRbzg1m9onbOXsCLfS6r+lLVNXiVD1jSTrZIPwSs7kjQ5gXx9c/30
	 pQR5ZR8ChY3/i3QsQUk2VEntpWG5sGi60rSiUCIc/cdIUTY4yrVyZ/AN0qLgRA16LM
	 +nzA0Q08RqpIHSEwQiXrk4ktdPDLB5Dz4mqVoWR+y1jNXLMcPKEtmbMxA/npPzW3mg
	 nJn4UJpq1EcAOx254jZ65qaCY6hI2hfp+laFHAO47rhozYNwgIZWcjqkTTQLO3sEAx
	 AtH8BHwo+1RIA==
Date: Sat, 26 Apr 2025 20:30:39 +0000
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] samples: rust: pci: take advantage of Devres::access_with()
Message-ID: <D9GUSVZY3ZT7.O3RTG4N0ZIK0@proton.me>
In-Reply-To: <20250426133254.61383-4-dakr@kernel.org>
References: <20250426133254.61383-1-dakr@kernel.org> <20250426133254.61383-4-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 290df5c563af9ef6991f59c11dee525e66be2616
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
> For the I/O operations executed from the probe() method, take advantage
> of Devres::access_with(), avoiding the atomic check and RCU read lock
> required otherwise entirely.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  samples/rust/rust_driver_pci.rs | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index 9ce3a7323a16..3e1569e5096e 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -83,12 +83,12 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInf=
o) -> Result<Pin<KBox<Self>
>              GFP_KERNEL,
>          )?;
> =20
> -        let res =3D drvdata
> -            .bar
> -            .try_access_with(|b| Self::testdev(info, b))
> -            .ok_or(ENXIO)??;
> -
> -        dev_info!(pdev.as_ref(), "pci-testdev data-match count: {}\n", r=
es);
> +        let bar =3D drvdata.bar.access_with(pdev.as_ref())?;

Since this code might inspire other code, I don't think that we should
return `EINVAL` here (bubbled up from `access_with`). Not sure what the
correct thing here would be though...

---
Cheers,
Benno

> +        dev_info!(
> +            pdev.as_ref(),
> +            "pci-testdev data-match count: {}\n",
> +            Self::testdev(info, bar)?
> +        );
> =20
>          Ok(drvdata.into())
>      }



