Return-Path: <linux-pci+bounces-21679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8E8A38E6D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 23:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79924170DEB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 22:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B2D1A8402;
	Mon, 17 Feb 2025 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN5Sp1Bg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E037D3F4;
	Mon, 17 Feb 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829612; cv=none; b=Xxbif8EViq8H1vanusaBb5M8OPdqjPedtlHaT8ydERjfcdR6Sy6PzApkV776gtFBiU/oAU9/fWzDMRKVGrfiO34JMlYh3YnPFwXmtDZfSH+GCVWm0rRcYdDC4DZiPsashEXr/bivzOWKoESyDoTorHfisvDL6ut4IzQxBc76jcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829612; c=relaxed/simple;
	bh=IfONhFmmTtzBGKoRKNyTp7A347ANRpAbiDzRPsXXjPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdJXCNS0lh9T7xmenWwkFup4Nh7Ald5nZEjE32QohWCYn1s3mc35SIQkyVVhuEXMSCAgsqJ4zjEzsNIs+4tf6/Bs/MMFoXWiU3uccKOs6Xob57X9woJAghz7Q2fnYTS/oWCG9X9551f5HQoxjTE3Qo5NF/r2uOAKyRteMrFBf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BN5Sp1Bg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc317ea4b3so652925a91.3;
        Mon, 17 Feb 2025 14:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739829611; x=1740434411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfONhFmmTtzBGKoRKNyTp7A347ANRpAbiDzRPsXXjPQ=;
        b=BN5Sp1BgrJann10EglOqnxtbDlgeIG0bVCDeXzvnYLL/50W6qHvupizEn7S6BgwmXI
         a+1ZdI7Z3gPEtMzy56JhhiNWAMiPkHCmUVhCL/OcG3txhEMTroIv5koZpwNnTQ2hOZlp
         ETbKbgW0v5CFh3xgJW9tAzS/5XlTUj+6WicPYxNsNRarYDq5Uzg8IggT/cl2CQJ01j7o
         gg4V1tTok341v4REbqRXF9nBUBEqXX8G8YWfgEdrmzmGqQizzLpMLZU3oFuo5NHeRnKl
         0uGloJS3piHmyNa4j0lM0+0BxWzdTiSQm/09t0FHp4XPA8TJ0fkN1iPmS1AthyVv1YeG
         HvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739829611; x=1740434411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfONhFmmTtzBGKoRKNyTp7A347ANRpAbiDzRPsXXjPQ=;
        b=ECB52HvHA3j3jeQtG9xambsxO4h+6+3gRt095H+WuLWge6EHYhJ6/iLRBB1G7Wg2LE
         7CNZN4MB4MKzCvX5gaZ0ZAmN3S193PwEkCUJG4MSqxP0m5K6wlG5xRxh+xALyhcpBqBD
         zYxqJ53tMRtPTeKv7tbDGGfm7dAdwLVG2xXWDoAr5TE3ca1WhvlbUpAhCONWO8ieFPJG
         7f0DZZsgJfyLHAy52V+cWdAOpMyGNddC515f9IWXVjwDQv/VMBvsIawpWYl9VrugvDqt
         jrXj1VMeGzAhQUUQ3Jydzz38VQP48o1Q17i77iTBYDVHKKFHNiKsPaElykEyQq/AKp63
         RGPA==
X-Forwarded-Encrypted: i=1; AJvYcCUetON2XixKh5r64487foaEedTf0LXB9gBQtd5ADWHsY/K/NYq2FyM1dMLBVTZfFWmwuKX6PF/1A5uO@vger.kernel.org, AJvYcCWOUvUTYNXbMtSdatPMwhGHr38Y/a9nxBVnUK6QEcn+n48TOQvGMxccrrw7d1BSGW0j7l5G0SjkphQSaDcEsvM=@vger.kernel.org, AJvYcCWOlNiA2FAP+SjbXtYV3+cYRvWuq5d5mNLmAiBH4i/BecaufyuSbXNMIn1cc77uln/0mVVG+FB0jqFrXPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfC3D429xaVwoetRD8ud4yHQaLbdv24KPczKOBAqhBugwIW2rm
	XJzlz4QiDGJjsnLK+sWmp1lSTlPZGVScYkzPz1QXJHBBgVBYmxJHr6xxA4IO9KyjNzG5SVHhrM9
	BChkC1Ne31daAzoLZXcM5hsa6wac=
X-Gm-Gg: ASbGncuOjWyWH/koEZtefLB+R3r2KdIptErF85inlNC/pOhtWJpJlL2m+//7rbtQs9Z
	Mvgv/mIspikIDkXiw4ol+1G2U6d864pmfJB/aXXw8yYG7G0MGIrcQsZplipEAKxKIzQq1M+ow
X-Google-Smtp-Source: AGHT+IG3ieUDZIVdbc/W5xBHwNbRELQ4AlnI+CANcQ8eq9KlZIEaL+dviX+t5hGQXhgC/+mMP+d9GKT81i4dmS5703A=
X-Received: by 2002:a17:90b:3a8f:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2fc40d126a3mr6991648a91.1.1739829610818; Mon, 17 Feb 2025
 14:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-io-generic-rename-v1-1-06d97a9e3179@kloenk.dev> <2244CEBA-3AF2-4572-B32E-8BA9F86417C9@collabora.com>
In-Reply-To: <2244CEBA-3AF2-4572-B32E-8BA9F86417C9@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Feb 2025 22:59:58 +0100
X-Gm-Features: AWEUYZl2iO4gA0ojAOrD5VjZ7RbLBrUt0TZo2TdfVHU3j5Yim0sZCEW6sqYO2P8
Message-ID: <CANiq72n=a+TjXNe13HuiuiLA+TE4pfMk6SB49AjpHkYju4pVag@mail.gmail.com>
Subject: Re: [PATCH] rust: io: rename `io::Io` accessors
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Fiona Behrens <me@kloenk.dev>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 10:37=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> IMHO, the `writel` and `readl` nomenclature is extremely widespread, so i=
t=E2=80=99s a bit confusing to see this renamed.

We could generate `#[doc(alias =3D "...")]`s if that helps -- it would
appear if you type `writel` in the search, for instance.

(I guess the rename could be justified (just a bit) by the fact that
in Rust we are using fixed-width integers and so on more...)

Cheers,
Miguel

