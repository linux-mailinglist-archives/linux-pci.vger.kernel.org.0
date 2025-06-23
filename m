Return-Path: <linux-pci+bounces-30355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D896AE39E1
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B10F3A4C62
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0F52367C3;
	Mon, 23 Jun 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KE4vB10O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D91DDA0C;
	Mon, 23 Jun 2025 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670534; cv=none; b=YI63ll9SZkD6DolRMbhgWVvc/XskH3s46GWpXuAmFMeXfXVMYpo9r/KGQg3bufV3rdJfUMmPhEvexjHTlb+OiFPev8EMZxIw8TlExnC58mRDwbAmCJUC2d5fqJcUo1xLh7aTYxdovx72MmS1ct6aWSEd0CDbdUV7q9OU4m/DAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670534; c=relaxed/simple;
	bh=soXQq3t1dya0s4CrtzGp9pj1ITZrvf2REkC+7bGtSPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2slo+q/M8btb/jHzvSA6aa5zvq4/VyGBJavrutm3HWMLahJkc95a1XzzJullAt0CPqSqhw5V5ydGFhWJEDljJ9As+i3a9tSTmkxn5DbZOVbYUfupKVZjQHj7+2UFVHpDUSDi9i6/As7GieNOune7ejclIfHbXx/2rFs4Bm1SFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KE4vB10O; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313dc7be67aso631685a91.0;
        Mon, 23 Jun 2025 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750670533; x=1751275333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjkYyHNx4rWTzzDDcjQiY+paHZsU2z/srVTm68tEwz8=;
        b=KE4vB10O85DXKk+z3Sc0Qz1Jx2iYgbu75daxMvr1/pQxkbzLfcRcBjFQrRo/AJ4qED
         TSWIgo4TZjIaRT0pPwxDgX2zlVhXDr/tGrU1j4oVRiyu7AhM0u3zpvUOdekWBP93jdkO
         kfgytsD7csaN7FvZLJvKFNLfP4rAL6rqAwy77ZVvsZFm2tYsWR80xuN6mDdT/qSYeRfo
         F96Zk+5FWklyjBUaipA3bDkjxIjRyIO1K5YbLz/dt36bNgLEDKm4IIRtlef64yvd2gRs
         AM4+CZELN0oy2gRLjoyFLbE0ksGaq3aQsL+yynB1a9WOGN8Nnob+mltrLoELsVOVu0+Q
         hwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750670533; x=1751275333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjkYyHNx4rWTzzDDcjQiY+paHZsU2z/srVTm68tEwz8=;
        b=JqTMzwXfhqXvEhUixc9BEvWe7CqZTAkm8PxdpFykrHeN9TCqIDpV71DxLBlwb4GcO1
         i6bTPmeZxKpsmwS/C4NNh1HK2du7QLBYeUt2i6/TZjhlHZxU0uGMkl+zIEYpWA3m/yKP
         UT7jPt0U9Q8NkC26TI+m/pcCZDnZQXOnz/2NHDFz5LoVugkB1IDN9rwk+NTbptdzcCSL
         ug5pOtU71SnHcEHLicDJNiBRzvhO8Z3VNDRrEWZuaczFfktuVk+hbz6AoKd0FQNANtC7
         I+VwcGoKCcU1Vp3gcIwKJuKDYAOeTvpq1K5Ztlha8D44pm2WE7CRlrbxfHYQx/DZE2Ie
         bNVw==
X-Forwarded-Encrypted: i=1; AJvYcCUHVlDslrEiYbjwxSwSTzK9OVT6Wy9hkE7UU1q/aCJTgjwIt4VvTf7ehZSEZ7/P52SsppMPRn9N4JGs@vger.kernel.org, AJvYcCUrOW5JyOhtWRHvxBvp9I1tS+gO6fFsFih/LJOYEIPsD/nFqbdlfmSxZfK4i5uiMnoI1QJxT/RgV5NREZFm@vger.kernel.org, AJvYcCVIXBhhoMprsii2yH2NmO/nIAySxmd2aMIC2ZAwIo1G0kTnSboknjBZ+NS6T0qvg1BG/QF+V2fG@vger.kernel.org, AJvYcCWEC7nrMPI/2hibi5FdLQm4uEcqcFVd8ClzMFekf+9HKU3/RL147PTWBbImimKPyflvfPcutiybcdS2+GG0VT8=@vger.kernel.org, AJvYcCXvySV4gzL7ClETPQULnL/zvxgZwU6uIr0pbBZU/B9Dw5JrQusyTKF6H0r8Ix73KTE2pLI41gXOMzB8@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMEo+CuXPAHZd5CcX6G5fnysLS5EMqX11fG4WGCg5Rq3W6Mi5
	i7WsIq4EJxtv5kLOXSGVpr55HUhONd8bg/xsv4B2uIR4BpB1dY+14H4c1/Y+DUTQwzJDcD4lO3j
	h3w5a6TkJHdvy/ILddMbWfPQELcSvww0=
X-Gm-Gg: ASbGncs7Wv4jZGZavY2oZkLEh5B7ZqglA22BzKlkR1y47blwt9wI1Paz0lAinxbPLmZ
	toZ36+x/Ft45SGmwk9efXF/jFHGTZEDvev6DmdBAnQLu9ENbqYqHkoBGiSbmaPUAfL0PoY041v4
	vQLLp0WBGtoBBakfQsBLPQ5lpfG7Bg+zNtW3y0vm1VDNw=
X-Google-Smtp-Source: AGHT+IETxn7v6zwYEwXoHczuLS/HNhU6MCkte75ZxXO1tVQqUFugpt4MXRo2X8xQeuyDb+oMCcOcOosrSzyu4AlrH8Y=
X-Received: by 2002:a17:90a:e185:b0:312:db8:dbd3 with SMTP id
 98e67ed59e1d1-3159d8e2bc3mr8097731a91.6.1750670532832; Mon, 23 Jun 2025
 02:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623060951.118564-1-fujita.tomonori@gmail.com> <20250623060951.118564-4-fujita.tomonori@gmail.com>
In-Reply-To: <20250623060951.118564-4-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Jun 2025 11:21:59 +0200
X-Gm-Features: Ac12FXyBpI3ZOawhrOYIBpBEywpexKv74tsF0NMaWmLvsufKlgJjeslNJFwjXGg
Message-ID: <CANiq72k0sdUoBxVYghgh50+ZRV2gbDkgVjuZgJLtj=4s9852xg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] rust: net::phy Change module_phy_driver macro to
 use module_device_table macro
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alex.gaynor@gmail.com, dakr@kernel.org, gregkh@linuxfoundation.org, 
	ojeda@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, 
	a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, david.m.ertman@intel.com, 
	devicetree@vger.kernel.org, gary@garyguo.net, ira.weiny@intel.com, 
	kwilczynski@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, lossin@kernel.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 8:10=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> +// SAFETY: [`DeviceId`] is a `#[repr(transparent)` wrapper of `struct md=
io_device_id`

No need for intra-doc link in normal comments.

Also, missing bracket (which apparently comes from another comment, so
probably copy-pasted).

> +    // This should never be called.
> +    fn index(&self) -> usize {
> +        0
> +    }

Hmm... This isn't great. Could this perhaps be designed differently?
e.g. split into two traits, possibly based one on another, or similar?

Worst case, we should at least do a `debug_assert!` or similar.

Cheers,
Miguel

