Return-Path: <linux-pci+bounces-30323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC76AE31F5
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 22:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB54616D836
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 20:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871FAAD2C;
	Sun, 22 Jun 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejmG2Ngd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3D8BEE;
	Sun, 22 Jun 2025 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750624226; cv=none; b=mylNcR3HwR0NvmAPnjBTCJDUTb847leqIYRKL4NwP1pSYfOe+6gV9W39CJS+T/+Mszf1QszS3urlEPVjcNJXqjn+rV0yEQr6I7BrC61nJ0D2H1tFpzjSNj5QU4vGAi91UodRkRQoUxLZnyVSX3kN2FzR1+sDZ7E4ju8at+jTtPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750624226; c=relaxed/simple;
	bh=E68xa/wJ3ERVn/8w2ChgPu5W6LivVD/2yytTsX6AysI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ7UAtfedHAw9mG4ZxCiLYowMjp13SWzO2RNiblqBXVzuIgtA9zVakTyD0qHviGzWEbAKlRRipBXI/K3fbL/9ccuYevyRzAEKslsV9F6IBozjMoq6n7BbfrXuRKCg7vWOIKrZoIjsnnfXBa5Fxhk5abjCa9tBfTcz5OiF/ZIdvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejmG2Ngd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so327468a91.2;
        Sun, 22 Jun 2025 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750624224; x=1751229024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E68xa/wJ3ERVn/8w2ChgPu5W6LivVD/2yytTsX6AysI=;
        b=ejmG2NgdiEbMnEHbOfN4CKflHl5PB+nG4Wll+WlZYlTkNQgmy60pKbqyW4Kg5+Ip38
         zqWqFoTvmRhthDkotzFTFN6aP5Bem1w9tsQeWemP6ObklUl+w1dwZLQVIngb+dSqn1Ef
         qIaZKD1beIapaKx+oYaja2QbZ5v7Co/9hUOWc+3Iyrww1k42302sf/V9MAWQknoazUJ/
         O2SnwoHz5tx6QRdxofVbmaVX7m3bpblfb/vgMXUK3UoMViXy1Bbdhv3aVfIHg9eEkxR0
         iRhziOd4m4YhNiM1SdWN4hTwTkId/H1Z13GKDwMGhb0kFbsrdPUb5nG6wf9kRqUWjKw7
         f9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750624224; x=1751229024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E68xa/wJ3ERVn/8w2ChgPu5W6LivVD/2yytTsX6AysI=;
        b=a8lmYlBG1ptb7+DizGo9DryWtlg/WcQZhvBDxKXn1s5Rn9vQ8KWss/UiVbMjKNiFzH
         a7FsIETsLsbTo6mGvKbEip6AYacBnWD6cQfdqjkUNUMkFSjym+SftJ7gpmZle7YDHWWk
         QLXJjObpJYbUga6ImdhhCSJLFQjT2zPlGiEooV92r1F6dtp0KVv+FmY3PpHRg0xRZBGj
         VazuBXHKhNGsucVj+4+OvtSNVVLFp3mPRPwLlFLv2z5737l5mVyYCCK41l4VKi4rzHAv
         nrsaMCMP8L6qTFfsiMHmGj50qdef6WGLtGfaOlLbZyar87tdzGsMHGo81x9EUm2tt3Yg
         L57g==
X-Forwarded-Encrypted: i=1; AJvYcCVKfzMYllwrhx11zfuv59JTyu8vJbnLsmPKzr3/bdLUY/vg0zLajQg+Uy29GtSoiXGE34Vio/HITqPd@vger.kernel.org, AJvYcCVmmmInrMI63nIA6eSFh2eBVqmgdFv5mIrGw7IwnYm8MOlbJkkVEw4QsZSwywZI5r0QrTR39Yv9xQ5nH8s=@vger.kernel.org, AJvYcCXOOV1cC0QwFXWakVHMubcEniH7CgBjlXKX4rssUPzr9EwX9Z35+rVWbb0llgWr+9Iti3CSxhKk/d0XnRbUzlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9VG59MI24TFbgTRZxbeJndoNa0En5SmK+TOTAbkknWspO77a3
	RKa/H2U8RS0udOyzunE6klO5TC9ICh2CY9zi8fLLVEJa+mc8zKxgnY5TVV0Qo9mZAZczIHNj3D1
	LDX2oeUii6tGqawf/SuuGlEbUmC2G+4c=
X-Gm-Gg: ASbGncsGerPu7XMrIBVuXBO9tPnLgzQhIlSRcizt8zdKpdme3nz1CV8Uoafd8WhoCHT
	Opaa6EfrHLdDVhl71fcZFSnhXeZyrrUYsgE0pdkA4M6FqpjOVd0ybuDI/3NVr7S28spY3A8QkfJ
	1nV6wlblzoW4gIXD1lWej8VMZ/eCHOwQNoMv5vmYS8BitRE1l6qhP+9A==
X-Google-Smtp-Source: AGHT+IFqmwSiQ6ti/Fk+Cp/rpFBgXOOjjk2KcKnh+N3PiClihLFHHS3K79RHZ8uMM20utmIM+aDfD0F/gk97lNr1E7k=
X-Received: by 2002:a17:903:1210:b0:234:8f5d:e3a0 with SMTP id
 d9443c01a7336-237d97acbb5mr60871075ad.2.1750624224369; Sun, 22 Jun 2025
 13:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622164050.20358-1-dakr@kernel.org> <20250622164050.20358-2-dakr@kernel.org>
In-Reply-To: <20250622164050.20358-2-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 22 Jun 2025 22:30:10 +0200
X-Gm-Features: Ac12FXzUQVmbc9GxqhzqZpPb-uvoCNwGrPnJ5b2ZkVtgm02QVi1eakVHnjR2Po4
Message-ID: <CANiq72k8yhJkS5zCKnSUMoWZtAnJNKePaoMDRoNSnqACWiUtKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] rust: revocable: support fallible PinInit types
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com, 
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 6:41=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Currently, Revocable::new() only supports infallible PinInit
> implementations, i.e. impl PinInit<T, Infallible>.
>
> This has been sufficient so far, since users such as Devres do not
> support fallibility.
>
> Since this is about to change, make Revocable::new() generic over the
> error type E.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

If the series goes through driver-core, please feel free to take:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

