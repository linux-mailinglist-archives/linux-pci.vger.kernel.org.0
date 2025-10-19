Return-Path: <linux-pci+bounces-38687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37987BEED1F
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 23:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C250B189745B
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334E9221F2F;
	Sun, 19 Oct 2025 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFVHgf1e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E019D074
	for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909132; cv=none; b=CjzgodpM4Aa56vRoA59hSmNgaRl1QfbybWSv8URkVx8zLKjtqBYWaysGKtFcDGw/uTxjHGqxJk3CNfQUMUy141UMxxRe7D5qUqRB7danb1PvrhSbrgEY7RD6RX2I4HyWEz0gsQrLDnMiYiYQASxBLCp4AvuUy+rhYXJjGq+QiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909132; c=relaxed/simple;
	bh=VMzOcGlzTmgP7Sx2K6Mr5nIuxpWb7Ycpm/3lBUKh9gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muTKMRUR29vmrwhrby47F4VjiG9yST51AheFe6VuaHhC+S8nU/Djw7bwntEWq7yRUngkE6qLKObHUoXcd17sZG+t2pvOOCDEeLmsp6oMZEXfiSFHDWI5qvN2+frs8Tc+Q1/tSCwNu170e9wi3V+B6nhCh8vI1wAxHgjenrGPvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFVHgf1e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28d18e933a9so5597515ad.3
        for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909129; x=1761513929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMzOcGlzTmgP7Sx2K6Mr5nIuxpWb7Ycpm/3lBUKh9gU=;
        b=BFVHgf1eBxrRlVa4HQwtg+9JdGx+ckCck1jX46JQ5chJaRBSqsc6IKXoNvNltJhS5z
         SrqUVnX4pqzWiqNACvkDi1zVvk0GidVr9CkWudBq60rIZd3EAb5DXaA+0AHy7UMlu2IG
         fOjsqzm45BHLYsgMbYQvLre1c4z0LdXIonBIBz/gncQQg8glng0WpBLHu/TfVJFWVi2R
         N6nphsFpZ+PNw+cXdn0SfRcjuXCDssB1hHtfya3a4thXk9G7paDwq4vzO7Ul3foqBdju
         mPnqrYMM8J9oyfVNXdQhhChz/diK6X8qnWUsWRiaNkBcK76mIzKAYNBEDTup+TwJgR3A
         HOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909129; x=1761513929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMzOcGlzTmgP7Sx2K6Mr5nIuxpWb7Ycpm/3lBUKh9gU=;
        b=XNL+j2DoldDyJIs/gRsbi6w2pDEAoQnSmAfop0aW21lwMYmWWd1AOsAsv4S/ZjpdGK
         F9x8KtZn4cTnltHdKQmDt+o+lnwvdJ58nQErCRepVYVN0lUfTKVk6XUuvk9tBRymn+aY
         Eer/Wpds+hsGVVpWdD8xbw8ydH1hXWuU0j1YdhWshcMbAmFj6Wl9WZ15IxufqAbQjlwf
         rJQS13buuVlOnU1c+r6EipIegHJmLWMBQkl7EvwBQ17Q49KBeJJmZ5T+OQJtW5LHeFlP
         XfVd9ZsjEQ/idKhg4+jvG/ojkfusjzUVQ2fpRjX5G4qVo/ecd4Z1pNrsZQLxeOLo/OGB
         B61g==
X-Forwarded-Encrypted: i=1; AJvYcCXVu+Noya85kiih52yrqXSC+9A3BSpXnQT/VFZL3ETW024Y14cyUbpippGGRbaLwkHU/IjL4Dyad/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4DbvchD4Ie066pplpIUJU+Y3N/oq5CpkCksxaoybfT9OSHzYN
	Pw69EnKsgHvGn/nhquLjRakUKRozABR9IGg7Pkx8Cr7/tBkZAKl7FRNjTLQuzgcM0dEHI1HtOQH
	5tH2Wu8G7nbRKeNRdyuPrki4OhWrQpPU=
X-Gm-Gg: ASbGncvOsL00vhFIehLP4QV350+WRMuwLUlpMfwNm5jgh7tjOY4ZszYM/VHryfLZdVI
	ErKkoj9IErgUMhGo7m6lal5wMf5oYVohYWFkQzjsnDMpu2YNiOzXp62Uo4mk9gr50P9mrdgfrdY
	uZUNVx786G6NfflVolK/GXfpnk+LScDNeFRLLojLEksKzLpSLr3ViOhRhxNCtIFbk7HClNoOOsS
	mugS5i0wWwiD3mITvt5K0Qs+218ZrMq8Nfcb59ocG3rG1vKi9eeN0/XPRm0cd3w/0ECo3nD5ZkG
	zEvyIEs8Ov5ZRG0ES8teIVEb0PqxNFF3/4DwkQUf7tyWboVnLPFpnJn7mhPaJXjuVHcFp3f+vk3
	+YWnYwHnprb7w5g==
X-Google-Smtp-Source: AGHT+IFkXmb/qgb/KgY8CoxXBFCqji+DioDep8k1ccK80l52uLY2VJCsOrEx4mXqL5zBbM0jkYzLAt9Oa8qgqgiQULk=
X-Received: by 2002:a17:903:1a0b:b0:27e:eb9b:b80f with SMTP id
 d9443c01a7336-290c9c9a8a7mr71999045ad.2.1760909129461; Sun, 19 Oct 2025
 14:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-13-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-13-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:25:16 +0200
X-Gm-Features: AS18NWDXrZ8O-3KwwwBOxfZWPwAGhp3HE5GT4mOk-9o3K1qGCus24KCpGnZzuZA
Message-ID: <CANiq72mpmO2fyfHmkipYZmirRg-x90Hi3Ly+2mriuGX96bOuew@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 13/16] rust: regulator: use `CStr::as_char_ptr`
To: Tamir Duberstein <tamird@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Michael Turquette <mturquette@baylibre.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev, 
	Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 9:17=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> From: Tamir Duberstein <tamird@gmail.com>
>
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=3D&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=3D&[u8]>`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Liam, Mark: I will apply this since it would be nice to try to get the
flag day patch in this series finally done -- please shout if you have
a problem with this.

An Acked-by would be very appreciated, thanks!

Cheers,
Miguel

