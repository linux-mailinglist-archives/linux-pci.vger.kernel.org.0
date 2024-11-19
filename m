Return-Path: <linux-pci+bounces-17059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE4E9D1F2F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 05:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43002B22DFE
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 04:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2913B287;
	Tue, 19 Nov 2024 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc0gzeO6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7414883F;
	Tue, 19 Nov 2024 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990323; cv=none; b=KcCW+LYzYPNGPmtMccMxES6Aux9dj+CSqr7mhYIOwk6304JdNZwERJXSuxrL2+9Fso95fnJFLcV2/ql/h818t1zr4Yzi0P0SFrWnFF05F8hLYUc93e0YV5o6hNmKnEGPw/8oI8JrmIshcqFbpXe81emc4cFdrSFJlc58s5J5l7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990323; c=relaxed/simple;
	bh=ZRevxrcorG7DNt0MLGoUwVY4NqN3vTro8V2wy1v5q54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+CXNjvTUaIKmNdI3berxgaaJsNuA1fyyDHEeMyDzXsHXP+yDS5xE03XF/mRJqdlT3suZqeJVObNoJrknZhqh80SWhXGS3BzkynbdFZH5AtrLQytvQbTQYP34oJ2XAqUXI3e1LLbuUEpRjV8kA8EUT44KKiyQG2ZTM5JIgRrdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc0gzeO6; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-856e82a32bcso2142580241.1;
        Mon, 18 Nov 2024 20:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731990321; x=1732595121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj0tB5qWB5eBVnJSIKjBHXelqo6byuXYMX77lezcMMw=;
        b=Hc0gzeO6lTcdKzvajaOtzBnl9UcdxXPM0sMN6u2LRWWDOKzsrzayAYAEXvaebMfQrg
         TB6stQgNhIf1odW/tjfiCxuHzuymOj9qlXe8U8vD7tzgte+EhobnRK9rKbIX2fhDtCdv
         HK5BSLn3P22Xpr9nXyXCTQ8dhyhAKX9LgbNHc3X/HiamtVv+k+quC59rVpn/ptgarxVw
         nQCk+ChjC0YRRZjv5B12PwMTul2NhekAP43gseWE+FhW3NZJ6R6qxdlS5zBgZ8wLMfAd
         LyYDaN638g9/yZXFSPKX148j5O1g2OoByO1r2DaGpED6Q/3QibwcQOnHgkEuZYyUOwo5
         9sYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731990321; x=1732595121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lj0tB5qWB5eBVnJSIKjBHXelqo6byuXYMX77lezcMMw=;
        b=Ur2RSNhK2KpP8eO+S9A12C0zn7YY36r7dA6l9eLh/d3tdDLG7QISM2qNgtoovGHNuW
         KEgvnyu52EMPAl6NsW5cm8jFtpHGi4XNb4xbedTC3Q2YFQUx3IOMA24C93CAE+YNiVYn
         cC2Hu2G2Z86Gbwsl3lWsN3bOMVgqP+aTfF8Rf1GtDPUW7XrquJCs8+cRlMqGWtsFN5rE
         SkzIcwSqieZ09neMNUyFjOhWwY/XeuLyhurxoRnjcK9Uk0nsjTgBiHagFuyywZlZmcTw
         sPJBxDXR1NGmyd3kluS4nEYkFUuV9a+dIaql5HRciFlJwoh5mmEDMlu2KBnfwy1G21z4
         5nAg==
X-Forwarded-Encrypted: i=1; AJvYcCU5c38jZZ/DCbeO0sYwucuVLmR7E5dCFHrh7Pwyu/MCXfgCHclrb0yjnwNrz/dfk6D4zY9lXDOEe1GfqY7P@vger.kernel.org, AJvYcCUdMNhXJJDZ9PbXrSxDvFw4ucbmESDGaigUbeLWBDpX2/iYvQFF52sQcswzBaB8KoUVyueTj/njgL1quT79RrY=@vger.kernel.org, AJvYcCVO1Usxthi44BPnVqiFO8MG03Rcx6+dlHyiRWfAKmqDcVa+9+xILc1LuZHPSmO9JiqPEpBSAMCknEg=@vger.kernel.org, AJvYcCWeFm5KRrHYjaCoPge6n2EQWEnJ61H8kQHezAH0oPhfQEg35OuE+80Pukm3HYf3sQBwZZAm9eeiLDlu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8Kz4EiEHJ1ffaxx6k2KyW5dtswaodNzqioayGFxFqsRRU8vK
	Z13TBVGkUXjOiRxoDbArp3QeYbM4KVYcARSMP5An1yBPKkGOetjkE7CXi6b1FpBJyvcMZn/O1Xc
	eJw810SBh41jMIGEbMdqeUDxS0Gg=
X-Google-Smtp-Source: AGHT+IG9cYL7X7lQrZvN9juAb1bSQkn5t3vl1U1eQFOkiscnlC3aPmlnuxF/hD8Suf18QUYmbd0PyLVmnPwfdDEyxqE=
X-Received: by 2002:a05:6102:e12:b0:4a4:6fde:d1c5 with SMTP id
 ada2fe7eead31-4ad62b4da71mr15033196137.12.1731990320763; Mon, 18 Nov 2024
 20:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115054616.1226735-1-alistair@alistair23.me>
 <20241115054616.1226735-4-alistair@alistair23.me> <6737d101993ba_5c832943d@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6737d101993ba_5c832943d@dwillia2-xfh.jf.intel.com.notmuch>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 14:24:54 +1000
Message-ID: <CAKmqyKPXo1KdTSVsEZSUt4Fj8gaWgg8XJzf6E+FsuaeMOdFv1w@mail.gmail.com>
Subject: Re: [RFC 3/6] lib: rspdm: Initial commit of Rust SPDM
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Francis <alistair@alistair23.me>, lukas@wunner.de, Jonathan.Cameron@huawei.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-cxl@vger.kernel.org, bjorn3_gh@protonmail.com, ojeda@kernel.org, 
	tmgross@umich.edu, boqun.feng@gmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, wilfred.mallawa@wdc.com, alex.gaynor@gmail.com, 
	gary@garyguo.net, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 8:54=E2=80=AFAM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Alistair Francis wrote:
> > This is the initial commit of the Rust SPDM library. It is based on and
> > compatible with the C SPDM library in the kernel (lib/spdm).
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> [..]
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 690a2a38cb52..744d35d28dc7 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -128,7 +128,7 @@ config PCI_CMA
> >       select CRYPTO_SHA256
> >       select CRYPTO_SHA512
> >       select PCI_DOE
> > -     depends on SPDM
> > +     depends on SPDM || RSPDM
> >       help
> >         Authenticate devices on enumeration per PCIe r6.2 sec 6.31.
> >         A PCI DOE mailbox is used as transport for DMTF SPDM based
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 4db9bc8e29f8..a47650a6757c 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -754,6 +754,23 @@ config SPDM
> >         in .config.  Drivers selecting SPDM therefore need to also sele=
ct
> >         any algorithms they deem mandatory.
> >
> > +config RSPDM
> > +     bool "Rust SPDM"
> > +     select CRYPTO
> > +     select KEYS
> > +     select ASYMMETRIC_KEY_TYPE
> > +     select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > +     select X509_CERTIFICATE_PARSER
> > +     depends on SPDM =3D "n"
>
> I trust these last 2 diff hunks never actually go upstream, right? I.e.
> if the kernel has no SPDM today it should not plan to carry 2
> implementations just for language differences.
>
> I am not sure if that is already the plan, but the cover letter seemed
> ambiguous with its "maintaining compatibility" statement. On one hand,
> that does not make sense when this is brand new upstream code (i.e. C
> version is not even in linux-next), and there are no chances for
> regressions. Just embrace the attempt to be a Rust library for C
> consumers or otherwise help the C version along.
>
> However, if "maintain compatibility" means "make it easy for the
> work-in-progress C-effort to switch dependencies", then that makes
> sense and is worth clarifying in the next posting.

It is ambiguous, because I'm not really sure what the best approach is.

I think everyone agrees SPDM in the kernel is the way to go and there
is a work in progress C implementation.

I think that SPDM is the exact type of library that would be great to
be written in Rust. My only worry is that Rust in the kernel is still
experimental. I don't want to have a Rust SPDM implementation that
isn't used or enabled by default because Rust is still experimental,
hence the option of supporting the C or the Rust implementation.

If a Rust only implementation is acceptable, then I'm happy to switch
this series to "make it easy for the work-in-progress C-effort to
switch dependencies". At which point I can continue to support more
SPDM features here and work on a better userspace interface as
discussed at Plumbers.

Alistair

