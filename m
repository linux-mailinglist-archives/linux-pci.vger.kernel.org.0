Return-Path: <linux-pci+bounces-7694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3088CA479
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 00:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BE71F2231A
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 22:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09E38DD3;
	Mon, 20 May 2024 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L18bQqHN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218BEA929;
	Mon, 20 May 2024 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716244336; cv=none; b=utsCn9fhpdFtCaOmR3a1PcarBiErTbPRliXX7ZR1AhiEqDhBAiTs2+h2dtnQjeBXOMs00MiEc4v3/JCZ4oO3qBCM1AfbIB5rzHVTk4dK+V423ZqF2FXloV7IS6xg3vQfATZgSse1MEYeiaRjiHHZ4dy73gSh0KUlXDwY40XIurg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716244336; c=relaxed/simple;
	bh=Nfd/hotRsNGOUrVaiD/+D1eNGry9/QIrEElvqfwSwYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPMdEohPuniZNV6VOJ+LZzsP/m/zJEwXgMYozYsclu6JW5Jpq3YfN6ZCZvk8y+/OimwOoUqSqfvoC3NzLuQ6G3YxmiIJspU6VHMASCjIUjGIbqIMayDHAwyKbGaXTqcwbPEo8o5rvjGgNAw8T2TlPlDM4Y1Stu+GH++9ZGY6ItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L18bQqHN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bd9000dc87so353908a91.0;
        Mon, 20 May 2024 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716244334; x=1716849134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLfT69TsEa3c895CC5YzoNBNMLq5vydc1ZiuXwGInhw=;
        b=L18bQqHNzFJBE81Hp4VHgdcoq3n3gEVV2kpxBkjAgqp5t6u0EwSXufRPL4rEvs8HLR
         8RjLtHGkGDayNlBi3AKB659W0j8k6USHzgcBtbDbkyt7pzOzp3l5aCnS0Ux+6AxPqND5
         4XQdqsj1Tlog3hjhC4lGE8RkdiGtzYUSEXC87bnNbkTtJqbdxjwHjMgxDPI+sVunVymx
         XaS4s+9MQwB0XXjxbFFBOYU6Ruzat1MwVfDFa+h/k/4M1JVoGzZyNU+faFk0IlXtTVCw
         VGXiK0vchzqSDHfNexQHYnCOfRhum5hOUuvsdXT0o4A7ED2C99K7Uy85g7NeRmIO+qUg
         uoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716244334; x=1716849134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLfT69TsEa3c895CC5YzoNBNMLq5vydc1ZiuXwGInhw=;
        b=li9kx0jdO616AVZDvS5PCmbdb9auSWrhV3YJUov+LihZWhsmWa5bwBbE9CzXLq8d8f
         +lnLCZI+YmCximBZHOv8ES+6WY0NU5GcD/xw/a57vZM/iA9tCHrPk7NKSHb7+aBQPO2s
         2rq/mTAYgGSuIjpQTCeb1nHVKm44+bgKkt7do1MItM6gebxU6xkgFSQosQ8bRlLr4mdv
         TcC0oCpaMSLSspMlxFHB4dZmbVgL7NonpOxJqAgbX/yJxkgV0pnlftDFYthy/1HQz59H
         4x3Lh+9uJuDBkF6AZlHZR0NPAb1/KwRi8qK0uSn1c8w74uULVCbQyQfoluiR49BZ4v6R
         XtXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXJxOGegEBqhzhgpUJeLm7SYHFzoX/Y2XjZcp7dzV1h8KKb/ixzThB3vmn+jdTQ4uHGXMp7EZ0I2MXyTuN9vnI7IF8Mep/MNZES8qgzs2396KHzOKdD3ZzRbKgzZb6SRGVcNbvNjYVXB/TwMSlqnLx6oBbaLRjX289N57iMBerQ+56YX0LQNI=
X-Gm-Message-State: AOJu0YwLcKbf9j6KjPl48O9/Y6Ib93O8lAlQamSTZY2W6HdiKyGXE19t
	LMLiBG3SEh2XboseFXVx3kgsX/LC7KNVkjl0Sja+1+Vl2FgKGD4GT/vNaVqgTol00EXnpIaeXk3
	IkeUXNyyXx4vLWJ/tDojGuK8aAxF+aipO
X-Google-Smtp-Source: AGHT+IFvqS0iVQIkq63MK0TTou44XjHDozUcq4RYICj4/VXpRTq0S7tMbcgtrYO6JiWDTsdNF9mZvrvoa1bzNOw7dx8=
X-Received: by 2002:a17:90a:bf15:b0:2bd:85e8:79de with SMTP id
 98e67ed59e1d1-2bd85e87aa2mr4104579a91.11.1716244334350; Mon, 20 May 2024
 15:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520172554.182094-1-dakr@redhat.com> <20240520172554.182094-11-dakr@redhat.com>
In-Reply-To: <20240520172554.182094-11-dakr@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 May 2024 00:32:02 +0200
Message-ID: <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem operations
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 7:27=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> through its Drop() implementation.

Nit: `Drop`, `Deref` and so on are traits -- what do the `()` mean
here? I guess you may be referring to their method, but those are
lowercase.

> +/// IO-mapped memory, starting at the base pointer @ioptr and spanning @=
malxen bytes.

Please use Markdown code spans instead (and intra-doc links where
possible) -- we don't use the `@` notation. There is a typo on the
variable name too.

> +pub struct IoMem {
> +    pub ioptr: usize,

This field is public, which raises some questions...

> +    pub fn readb(&self, offset: usize) -> Result<u8> {
> +        let ioptr: usize =3D self.get_io_addr(offset, 1)?;
> +
> +        Ok(unsafe { bindings::readb(ioptr as _) })
> +    }

These methods are unsound, since `ioptr` may end up being anything
here, given `self.ioptr` it is controlled by the caller. One could
also trigger an overflow in `get_io_addr`.

Wedson wrote a similar abstraction in the past
(`rust/kernel/io_mem.rs` in the old `rust` branch), with a
compile-time `SIZE` -- it is probably worth taking a look.

Also, there are missing `// SAFETY:` comments here. Documentation and
examples would also be nice to have.

Thanks!

Cheers,
Miguel

