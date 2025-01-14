Return-Path: <linux-pci+bounces-19707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2AFA100B7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 07:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8503E18840E8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 06:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3891FBBFE;
	Tue, 14 Jan 2025 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LomXt7aW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7924022E;
	Tue, 14 Jan 2025 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736834564; cv=none; b=hWd3Akwn38vPQc8bSrQcSBOSuWrP//RRtTjAQB4dG+EIVG/SNt5vM9IC+L7h9Af8g7O/mvhQsax39lwXPY5kbSmfkmdVK3pxFPWeUjcYm4/2HHea/uZocDvC5JrH7bEP6NbluwMiXqoqRyMo0k8ZF3LMxd4ETJIeZ6Wsp3h4+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736834564; c=relaxed/simple;
	bh=EglESEDjJAvBxMyYsCyMQ/hc2dz+8A+8RM+JV7U3WIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCmkDdVsh9pXahnIqS2LZHn9R/0lOTJ2+FDxUf7fnwXLJz0hx3tq49TM2YWOjRGmiYpW3u84N1TSXnj5BP7UuWPnzAJXVwwgPdhQRUSArYhfNkphsFB5KIckM3vqj08p4rMQCv2pavCUrE8/mQ2gAcdyW0+LE3CAFoO+WfcfTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LomXt7aW; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4b6398d477fso607749137.0;
        Mon, 13 Jan 2025 22:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736834562; x=1737439362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkiGGN3usxKGcjHnnfjxo/y86ISLASVjG3WOea2vePc=;
        b=LomXt7aW8Dxd5Y5OVyvP0z63h35W/mkVx5Y+McrWZ9bSGYgQWjC+eaTjSjt/LZWPFd
         a1Xu09ayGFaeHWiBMG2Vvp8kK8ixjg1Zdx4MSyIAs32vAfHXLDEU6JM6rf5OLFZ3Ivkf
         YiZ0CMPnz5Ylb43VPdkLcAa5Ue4n3qVnyhAbTgSkv+sCuzgvde97TYKb8HhCD+4/9fiT
         /Zscul/zUuJ0I6OpU/KHWy1EC07biriiJThjEDtILodmYK113AwSz293ayHX8w0e2rJ1
         lpLT7asuX0wP8LEbq9dPLR8480nKbogNn92bvCQ1ikvWMp/mLAamJAYeX84C5IZN5SQf
         yWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736834562; x=1737439362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkiGGN3usxKGcjHnnfjxo/y86ISLASVjG3WOea2vePc=;
        b=gpRuFkF9riYeRXTnrkQor/aV3nzn8zkC8x7tJ6U233hvDkfdd98heqTAA6zZ8eD8a4
         +9Jn1StEUr1a6mTYRp0OJqi9aGtEd3mh7I9oW2VppV5Mr9H7uu2JAV3OiNehw38Vov1u
         +1gZnD/4sXVwoTLbc6CDWQpBBhUZh0zjcziW8r67w6P6A+1vrKsbhvF7Tp9zzG8f72Qm
         hAQdsUdBjFtKIJaFODgc38TwnBLC1KHhfq4ugvCELE8Q6F/wgHv8Wp4ezN5GRJNFgIft
         Zb75Dyg1QvDq+hJvBO4Oy665cfXeyy+s4djZDIZc71NLR0TEL+X0zFd891E/hMP0IuDs
         Yi/w==
X-Forwarded-Encrypted: i=1; AJvYcCUGXWnL/7l5BBTQVqN8DjV8W6wHYEgiBxvZ3pkriiLuZUFQqK89yvXwwO49Oc3HpCxRunZgCFWLJdk=@vger.kernel.org, AJvYcCVi74pXoMOILh49fx1BNkT7rfzL65k31kLWrj6X+3xrtreN49o5ssw3fPiFAzdffGpFmbG3SQB/yPlDbUuKnBQ=@vger.kernel.org, AJvYcCX/GVZBJvXdoZZCdHJ+a3F9Q9zO2nlfrm8ReQmHLkCO/QaQlhDLYqjHqQA1Tr8uQygztkGuGfT8DRJ8A/nO@vger.kernel.org, AJvYcCX7z1wOZD6L18lUKUqLVLfVqwlqYt+dh//1nTNtlDZMSvIkqT550tZLOYJkplKFuH0Z1StZH+gpc9Ls@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZs6CGC6n6jy0CG8Le4fr3UGRvyoMM4c0dx/PLCjnPapq6UtR
	ywjwSxGFXMClj7unlAhBfSTSGwkcioM5hmHTgnVDz4QnEl9mHAOL9ZUED+t5YQy2siD7D4wisxq
	ItSnqF0eJ4gpf0oojoYB+yQNH3w0=
X-Gm-Gg: ASbGncvLlANV/zY9sH9QbN2vRenAwPAMqfpJjmQ2DoKUBZ0JuTWIEF2yS8h4QxhUIum
	XluEjmfwVx+w7lj7zMv8Ddexy52yWG8T5nlZeG+hvYBD/kHCpddL6z8+1rkl72++Qpn4=
X-Google-Smtp-Source: AGHT+IHEfYgDdv4MvgwCPy7Cw0PJrNHEjYl4IU6F+ST7c1cmi65B6mLtjuX1z9erY0mlCQTZWxTRLgZgxRx7j+yvZr8=
X-Received: by 2002:a05:6102:390c:b0:4b4:6988:b12b with SMTP id
 ada2fe7eead31-4b635e2272cmr7559631137.23.1736834561988; Mon, 13 Jan 2025
 22:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PsAMnW6hScU1fLV8ucb6wOkHECGXCrwXeSEfeVs3Hc-zbwrML674jGT8H_XNvWiF6EdymYJZSusanBrtAsZjAg==@protonmail.internalid>
 <20250107035058.818539-1-alistair@alistair23.me> <878qrm6e2p.fsf@kernel.org>
In-Reply-To: <878qrm6e2p.fsf@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Jan 2025 16:02:16 +1000
X-Gm-Features: AbW1kvaISrrHWVCve7qN8lWuuI74XwUdVsKcEayIn9m2IPJ66xG_6P9XF0a_KuU
Message-ID: <CAKmqyKO+O6H8+Y2ybz+qiAtgGbLeHMzswo9weWbg0Wc--gEiMA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] rust: bindings: Auto-generate inline static functions
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alistair Francis <alistair@alistair23.me>, bhelgaas@google.com, 
	rust-for-linux@vger.kernel.org, lukas@wunner.de, gary@garyguo.net, 
	akpm@linux-foundation.org, tmgross@umich.edu, boqun.feng@gmail.com, 
	ojeda@kernel.org, linux-cxl@vger.kernel.org, bjorn3_gh@protonmail.com, 
	me@kloenk.dev, linux-kernel@vger.kernel.org, aliceryhl@google.com, 
	alistair.francis@wdc.com, linux-pci@vger.kernel.org, benno.lossin@proton.me, 
	alex.gaynor@gmail.com, Jonathan.Cameron@huawei.com, wilfred.mallawa@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 9:48=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> "Alistair Francis" <alistair@alistair23.me> writes:
>
> > The kernel includes a large number of static inline functions that are
> > defined in header files. One example is the crypto_shash_descsize()
> > function which is defined in hash.h as
> >
> > ```
> > static inline unsigned int crypto_shash_descsize(struct crypto_shash *t=
fm)
> > {
> >         return tfm->descsize;
> > }
> > ```
> >
> > bindgen is currently unable to generate bindings to these functions as
> > they are not publically exposed (they are static after all).
> >
> > The Rust code currently uses rust_helper_* functions, such as
> > rust_helper_alloc_pages() for example to call the static inline
> > functions. But this is a hassle as someone needs to write a C helper
> > function.
> >
> > Instead we can use the bindgen wrap-static-fns feature. The feature
> > is marked as experimental, but has recently been promoted to
> > non-experimental (depending on your version of bindgen).
> >
> > By supporting wrap-static-fns we automatically generate a C file called
> > extern.c that exposes the static inline functions, for example like thi=
s
> >
> > ```
> > unsigned int crypto_shash_descsize__extern(struct crypto_shash *tfm) { =
return crypto_shash_descsize(tfm); }
> > ```
> >
> > The nice part is that this is auto-generated.
> >
> > We then also get a bindings_generate_static.rs file with the Rust
> > binding, like this
> >
> > ```
> > extern "C" {
> >     #[link_name =3D "crypto_shash_descsize__extern"]
> >     pub fn crypto_shash_descsize(tfm: *mut crypto_shash) -> core::ffi::=
c_uint;
> > }
> > ```
> >
> > So now we can use the static inline functions just like normal
> > functions.
> >
> > There are a bunch of static inline functions that don't work though, be=
cause
> > the C compiler fails to build extern.c:
> >  * functions with inline asm generate "operand probably does not match =
constraints"
> >    errors (rip_rel_ptr() for example)
> >  * functions with bit masks (u32_encode_bits() and friends) result in
> >    "call to =E2=80=98__bad_mask=E2=80=99 declared with attribute error:=
 bad bitfield mask"
> >    errors
> >
> > As well as that any static inline function that calls a function that h=
as been
> > kconfig-ed out will fail to link as the function being called isn't bui=
lt
> > (mdio45_ethtool_gset_npage for example)
> >
> > Due to these failures we use a allow-list system (where functions must
> > be manually enabled).
> >
> > This series adds support for bindgen generating wrappers for inline sta=
tics and
> > then converts the existing helper functions to this new method. This do=
esn't
> > work for C macros, so we can't reamove all of the helper functions, but=
 we
> > can remove most.
> >
> > v5:
> >  - Rebase on latest rust-next on top of v6.13-rc6
> >  - Allow support for LTO inlining (not in this series, see
> >    https://github.com/alistair23/linux/commit/e6b847324b4f5e904e007c0e2=
88c88d2483928a8)
>
> Thanks! Since Gary just sent v2 of the LTO patch [1], could you rebase
> on that and list it as a dependency? If you are using b4 there is a nice

I can't get Gary's series to apply on rust-next (it does apply on
master though).

I might just wait until Gary's series gets picked up to rust-next as
there is already a lot of manual rebasing going on and my series
currently applies on rust-next.

Unfortunately there are just constant conflicts as the number of
manual C helpers are continually growing.

Obviously when/if this series is approved I can do a final rebase, I
would just like to avoid unnecessary churn in the meantime

Alistair

> feature for that [2].
>
>
> Best regards,
> Andreas Hindborg
>
>
> [1] https://lore.kernel.org/all/20250105194054.545201-1-gary@garyguo.net/
> [2] https://b4.docs.kernel.org/en/latest/contributor/prep.html#working-wi=
th-series-dependencies
>

