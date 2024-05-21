Return-Path: <linux-pci+bounces-7698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052628CA693
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 05:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937D91F225EA
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 03:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8281078B;
	Tue, 21 May 2024 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSlCxhG1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF421BC44;
	Tue, 21 May 2024 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260517; cv=none; b=LLSIJj2BJIsMPajoWpc4XbO9Itkf7DaYf0YDNOn3sN9JDHjmgyv2tg/eXaACw5Xg97aH8xcfhDycmB5gY53vaYbBuGNjslzZ/chJ0LLcQf0f2R5KELxxqYjuIxHfM4bZWlTfxa2eeyrCLstXcg+9RQBcey05ePfIExaEbX3M8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260517; c=relaxed/simple;
	bh=akufwTAxaGwYpcPiUZ4tvDW/YYUXHCiwJM49ewu8Q34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceUqOwcrHVuL0SWjLue7IUBujqlQod9uCsksph4OmWpfFLFq1SxJJng3c0loklUqWSgWuwo9w2P3fxpPqhVJG5/0nBVA+E9jnCWXcz5/+1Gy6fRBgWsnCkgAHZZDjINtvK7K4tAyKoVKzUSNo8UgcBQko5+JS6y2IGm41HouDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSlCxhG1; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-df475159042so2683187276.1;
        Mon, 20 May 2024 20:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716260515; x=1716865315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=akufwTAxaGwYpcPiUZ4tvDW/YYUXHCiwJM49ewu8Q34=;
        b=RSlCxhG1V6P2kT2DRXdwZXlQvcinFC1YgWJJdA2Ti7gWwOBXzjDWEjKDXwizl4JaUq
         It+QxURrVVwPrfv/4CVxowy/Zrb8ubJBf6oD/u8PTwfvm+jqFu6hgtDMKs8jz+KnpEh3
         ilUIv2fr5J+58fmKndfWKwu9JjH+fwkKDFdzPXL2aqwDFbc3QrFNFtSFdLFlaQaC0veU
         AUFhbSg9p0MgkiRep3EzagG6g+xc++OaEUbhC3yBpezWOJhgcIQ1J8VS3EGKOl9iPToj
         z3AvNPnnnoeEAgaxjeEMEglT8NEUrgaX4W0KfWO+Qhhga62eWIv9/wF3WZVNNNIuDCGO
         iUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716260515; x=1716865315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akufwTAxaGwYpcPiUZ4tvDW/YYUXHCiwJM49ewu8Q34=;
        b=QnIsgZO0Jabmkceo7CY1jqmV8hW86muxWVXRlavuzEo5j4sHuiRwYRDVdbYLk2kTE/
         9L0GbXzzzuCdIjo58JRVNq54X2/zUtKyv3and8hmUf0j3qN0SlQGrujMGq3kcUcRTdL5
         qLmi5Yfq1jotc8NaFmLU5EHjPXeyql9SiquA+idGbDnN7b9EYDksEWsbRABWWEn+dQfc
         nyaa4RSeYyaHU5/HsB2QU7ZiHPb/3t6Y5JQ+WtnAnyhjEyPDl+ysaEpskS0kmBhopJGN
         3u8docqx2pxE6AW92HfRUz2/3uV5f0q4h6CYct1GIpXdPHA00vZpYatDThzCV+5w56H7
         c6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVjv/NvYNJxOj9xX2cUyZs6zKmMaYo/S5TQMsekP4zNSmf2ska+F23Zi64KoQpbLFv7a63ETNU4DzJF5RVxP4wMzZs8teenYU685508SMINibszxWl67zafYAJZvghmiiAuI301Nxrsm02hW46jdCGGcYTRVpL0EPSpqygzHTNW9iimskGx/5A=
X-Gm-Message-State: AOJu0YzHEdL++ZKf6WqnACOe6YTHKwWcK8878VyBVxMpTaJMcwUNEq8k
	OFm1EyCQnqPUkLVhL5DGaCazWt2w+d6Usa34TKEr15NqYf8HNP1cpvPrcCyBVWYqNBcFoTw42yc
	AyHi+3rRvXWIx+FlkIYG0HJGEfzQ=
X-Google-Smtp-Source: AGHT+IE0/WVO6nR4/cHU1sX1iomx+pe/SEQq3X/aVg/mNrKACAn0MJCQM6DnG6b8Mgh1xr/qfS4c6yNYgy2o1QZO8ek=
X-Received: by 2002:a25:c945:0:b0:de5:5b81:c724 with SMTP id
 3f1490d57ef6-dee4f1a61ebmr26963127276.23.1716260514826; Mon, 20 May 2024
 20:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520172554.182094-1-dakr@redhat.com> <20240520172554.182094-11-dakr@redhat.com>
 <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com> <CAPM=9txb5STBo05xiTy9+wF7=mMO=X2==BP4JVORPFAtX=nS0g@mail.gmail.com>
In-Reply-To: <CAPM=9txb5STBo05xiTy9+wF7=mMO=X2==BP4JVORPFAtX=nS0g@mail.gmail.com>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 21 May 2024 00:01:45 -0300
Message-ID: <CANeycqpNeHFUu-RwSc6Ewa3r5TMhYYFDC6bO+sj3OZ398JfJ1A@mail.gmail.com>
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem operations
To: Dave Airlie <airlied@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Danilo Krummrich <dakr@redhat.com>, 
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@samsung.com, aliceryhl@google.com, fujita.tomonori@gmail.com, 
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 23:07, Dave Airlie <airlied@gmail.com> wrote:
>
> >
> > Wedson wrote a similar abstraction in the past
> > (`rust/kernel/io_mem.rs` in the old `rust` branch), with a
> > compile-time `SIZE` -- it is probably worth taking a look.
> >
>
> Just on this point, we can't know in advance what size the IO BARs are
> at compile time.
>
> The old method just isn't useful for real devices with runtime IO BAR sizes.

The compile-time `SIZE` in my implementation is a minimum size.

Attempts to read/write with constants within that size (offset + size)
were checked at compile time, that is, they would have zero additional
runtime cost when compared to C. Reads/writes beyond the minimum would
have to be checked at runtime.

