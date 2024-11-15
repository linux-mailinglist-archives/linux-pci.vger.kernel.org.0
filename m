Return-Path: <linux-pci+bounces-16907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A79CF294
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FDF28E26F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84A715F3F9;
	Fri, 15 Nov 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J59Euu/g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654C15573A;
	Fri, 15 Nov 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690952; cv=none; b=cs+QxDjQnAbYVlPj88oCKX0iolNNvc/vG2RpMiW8BfhQei84je73v2ShhHYqOyua8KA7dIBjlZITvQvQmyg9R9bWH/PVoAxEznkZahN04RyyRUPo+hHbREC7YCXgQbYAaR2JfPEZYuupEyxICthnqWAbP6fSzMl64oi1Ehh3L/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690952; c=relaxed/simple;
	bh=5MnfwGwjjZ5e3fIepXk3xCVSfgNw+NvODegrk9C883E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb20zSPWS45CaWW92JrQq07dIW/l7evwraYc/jzkOm1geXeTBVRkPK/KmyQOP9sKTxCghZD5dzv9kuxv+Wwu8Axq7sImkGf3XafkFohe/9so9KabMgWZdAs9fsMuiAR0FyrLOfxEphN4/5OdzJmTUBwjem6q1473fbocMGkzWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J59Euu/g; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e9ecb67701so303349a91.1;
        Fri, 15 Nov 2024 09:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731690950; x=1732295750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwEDCmCjDAFPLessQ1VxzKc/71Q2iWV02aJqLKUeeu8=;
        b=J59Euu/glW/c2OAo+cyEYK+gtMxkpHiVLtd5Eb1uOc/qGrhAPIp1LSFQ84MArrmxmK
         HHXegIkVUSsgWGW29OBrFXg1mr8A+EIb7zmrbQLxnIloj5rWpX7zCoT33r1UNFgxAEno
         uM0OSOz77QSVmUkjA7zEOOJU4EKrd4qRFgqXRIUgnyjJbvlTeZKhHDUXkwKrOWZMVhIO
         BinPMsSvivVV6e6Ww6vkeVz2zbpZ64Ch+VjXZGq++yNSSby6WNGV1wsvgj3FpT1YjYpP
         SwFJXf55SUogCUGdJLg/FMVhY9y+v/De3TZEM4OeSWh4PX8r7O9BMzgW0g42QLfhzi23
         xt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731690950; x=1732295750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwEDCmCjDAFPLessQ1VxzKc/71Q2iWV02aJqLKUeeu8=;
        b=e0X+YQB6ckIVkwmkeOqEutxyOYnq/N1imW+KgnRMcsLNUiu2KedX/YKIA+R7CzpojR
         Pct9nIMMpmwEOp5JxZB5W7Jnq4nCIcyOJ5wSs6TdozkLcjcAObgsgxGN0cQwcx/NiM9j
         qA33Y4mTOhE99qwJb5ve1ii5lOLxgy5YW2P2s6AJJB8mnZ6RrkuHmVSMdhgSe74BBSWm
         xvXSz7WEVI1rgfOxdSizmT/7OxIM73BylrSL3YNx2WZ+wL5pU+J2coYHi2Nlku35d5dp
         Xw05SVu6veOCtChVBYIqmz6j96snA/Ka7li/DBRDaSGjzE8GCPDniF2A+pfeCHunXAKN
         kSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU74ZsfOXf2JHpmRhIZ6cFvQc2106rKFRxd3QqpGPD9AwCEp6MbrvXeurwzEVoGwZ0OXa0PXsjwekFhtFEL@vger.kernel.org, AJvYcCVq3dIubsi2ti3u73Zo3tZvrk+Jwb5A71FS8+ioN31Eswgl1Cov7AgJ2JliOFcURu2P8G14cT4gOMM=@vger.kernel.org, AJvYcCWxw4+bUvb+LNt+LIR9W0x7yJcKWy5qViyyNpk3bLwd+Acv6jXbNIxds/z6o+Yl4yYuRMeUtTUis3NQ@vger.kernel.org, AJvYcCXayCpZIC7HP0SljoWJ/BNd8rXUJ4eslzvBPP7ZPmNdVGpGbolc9M+1H4pNRBcGjzRqOasdQy5USsxAYW9wYpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Hh8epHaCDdlJ15OPpbojIZcExXv23DLntsWS2EADP65Aeu/O
	y3GrleMT3xTgnuicJoEuYz+UpB2kc/OkNKaHf2EitRT3Z1oOBXJ6K3m3FY4B0lXUuiEPojMj5U6
	jz5zZYJWV9D+amfzWZgApMVv2JE8=
X-Gm-Gg: ASbGnctpYznuc+kj2pnCk/9TREK80b+yugDCrXSsiF7Vl7CqTtwURbVpm6JptOzdp1s
	nSRJ6nOL4B52YZ8DXMcKunevDRiEsHQ==
X-Google-Smtp-Source: AGHT+IEMA27ToWetHcKHOD4q2Ez8uWpsjU80vnlXvxOsubs0bToSiqQ3t/nzHMIQrl7xRONsJLIJF1jxXEKP5JlZ0mo=
X-Received: by 2002:a17:90b:1a91:b0:2e2:abab:c456 with SMTP id
 98e67ed59e1d1-2ea154c3e0dmr1848576a91.1.1731690950377; Fri, 15 Nov 2024
 09:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115054616.1226735-1-alistair@alistair23.me> <20241115054616.1226735-4-alistair@alistair23.me>
In-Reply-To: <20241115054616.1226735-4-alistair@alistair23.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 15 Nov 2024 18:15:38 +0100
Message-ID: <CANiq72=3p50vyA5MsqZD6_Ma53DSLyrqyKYUwH9o-+Bq=REaQQ@mail.gmail.com>
Subject: Re: [RFC 3/6] lib: rspdm: Initial commit of Rust SPDM
To: Alistair Francis <alistair@alistair23.me>
Cc: lukas@wunner.de, Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	bjorn3_gh@protonmail.com, ojeda@kernel.org, tmgross@umich.edu, 
	boqun.feng@gmail.com, benno.lossin@proton.me, a.hindborg@kernel.org, 
	wilfred.mallawa@wdc.com, alistair23@gmail.com, alex.gaynor@gmail.com, 
	gary@garyguo.net, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

It is nice to see more Rust, thanks!

Some quick consistency nits I noticed for future non-RFC versions (I
didn't check the code). Some apply in several cases.

On Fri, Nov 15, 2024 at 6:46=E2=80=AFAM Alistair Francis <alistair@alistair=
23.me> wrote:
>
> +#[allow(dead_code)]

It may be possible to use `expect` here instead of `allow` -- e.g. if
it does not depend on conditional compilation.

Also, later in the series, is it used? (I imagine it is a temporary
`allow`? If so, please delete it when you introduce the first use.
`expect` can help here to not forget to delete it.

> +#[repr(u8)]

It is probably a good idea to mention why it needs this `repr`. I
imagine it is related to `SpdmErrorRsp` being `packed` and so on, but
it wouldn't hurt documenting it.

> +    InvalidRequest =3D 0x01,

Please feel free to ignore this one (especially if the idea is to
replace the C implementation eventually, or to just showcase how it
would look like if the C one was removed), but one idea here would be
to pick the values from a common C header? i.e. moving that `enum` to
its own header that both use.

> +//! Top level library, including C compatible public functions to be cal=
led
> +//! from other subsytems.

Typo.

> +/// spdm_create() - Allocate SPDM session

I think these are copied from the C one, so it is fine for the RFC,
but the subsystem ends up accepting this, then please use the usual
Markdown style of the rest of the Rust code, instead of kernel-doc
style. While we don't render the docs of these just yet, we will start
doing it at some point, and e.g. IDEs may do so too. Even if we
didn't, the comments could be copied into other docs at some point, so
it is always useful to have them formatted properly.

> +    /* Negotiated state */
> +    pub(crate) version: u8,

Please use `//`.

> +                bindings::EINVAL
> +            }
> +        };
> +
> +        to_result(-(ret as i32))

These are errors you create directly, so you can do directly e.g.
`Err(EINVAL)`, i.e. please avoid `bindings::`.

> +        let length =3D unsafe {

Missing `SAFETY` comment.

If you based this on top of `rust-next` as you noted in the cover
letter, you should be getting a warning under `CLIPPY=3D1`. There may be
other cleanups under `CLIPPY=3D1` if you weren't using it so far.

> +            return Ok(length); /* Truncated response is handled by calle=
rs */

Please use `//` for comments.

> +// SPDX-License-Identifier: GPL-2.0

New line between SPDX and the crate docs.

> +//! Rust implementation of the DMTF Security Protocol and Data Model (SP=
DM)
> +//! https://www.dmtf.org/dsp/DSP0274

This should be a link (using <>) or a link for the "DMTF Security
Protocol and Data Model (SPDM)" text.

> +//! Rust sysfs helper functions

This should be the title, at the top. In Rust the first paragraph
(which typically should be short, e.g. a single line) is considered
the "short description"  and used e.g. for lists.

> +//! Copyright (C) 2024 Western Digital

This should be a comment (likely near the SPDX), rather than part of
the documentation -- see e.g. how it is done in `rust/kernel/list.rs`.

> +pub unsafe extern "C" fn rust_authenticated_show(

`unsafe` functions should have a `# Safety` section.

Thanks again!

Cheers,
Miguel

