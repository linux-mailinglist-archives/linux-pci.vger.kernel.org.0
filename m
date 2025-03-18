Return-Path: <linux-pci+bounces-24011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7E4A66AE9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 07:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2147173F5E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 06:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A81BD4F7;
	Tue, 18 Mar 2025 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/yu8Tz7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B81A2643;
	Tue, 18 Mar 2025 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742280817; cv=none; b=uVSs6d3ICtoc0ho6/NlKGd0rA79p2BCi+ptMLHsGlDrln5j+cn2aFwqA9DHbVHvDQvXRnDTyB4NCSyXctVtyjrmOzXh6yih9jUND1OZGtBwWukRhgvfCJ2t4FZfMpVKbqbFeSgsSSlVl0P67iohbsvKtaGYte09wOXWFHxd/ZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742280817; c=relaxed/simple;
	bh=FRAcuRcyfjK2vsi/p7eiYS7Mv5TYPG4QdBuhO0/m2/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fizMyZdW5JyW6VWKeKTYxuPSyRRt3RjM2MhhQc/Svd/onJZwQN0sl1CBZj9y//YEZd7VShoSNDLJuXv8+xy2gf2keAmP0J4uXgMzdVYspvEqp/x15ZhiLoqldZKySYp25sV3b8Rhcl4DaYPVpkkoKOJn+3u3k0dgLR5M+AvukxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/yu8Tz7; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d36e41070so2220021241.3;
        Mon, 17 Mar 2025 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742280814; x=1742885614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR7STtbjDPO6lmSbp4QD6SK3P/KeQf8lIol2C5kgJAI=;
        b=D/yu8Tz7k6amxc+2QGzv9TVjYSC9kuJWCgW4/lGtO4OKMK1ysoJiCgLMMsuZOLlGzN
         hamNpCiY4Y87IVC69+jeVRdynfNdLB/rQ1qX3+jgihDp7yNJHz+qyfrgLIDK3uClpbu3
         dSkytCU8i6Uic2VOxByfmIJUKLtXG6L6iBR1a4T5goBC69vwdsDEutxweQUbBLagEeMK
         /P1BvvSRlY+eW5NnR/5D0QPwIuf5XQgG6xZcoeI9yypOdV8ojy9UKFBjyPERhAHq4NWN
         dVg5jQAqNF/KW+wcUgSQcJ3LEFbb9QgyjYNsENRqfoijC/MajEwiJifC5lpeKxyD3j31
         P7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742280814; x=1742885614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BR7STtbjDPO6lmSbp4QD6SK3P/KeQf8lIol2C5kgJAI=;
        b=bL/DNF9J+HPL+w5AfXA8hcDKVUsd2cVPuut5TCD3U6w09qXVhRsCdfsHarLFt82Her
         T+4yC1e+VK1G/+qZdfKw5O8gGv9yNurbw9rolmTui5gR1B4kdIJTJTTR8wb9uE/WfjfV
         JWWMtMf0LEjAbtmGRYkFUB/tbjbfGWFvCPLuaCA1LXDXzs0gOCjXJU74cMOrJbv1QfxF
         pc16xbGl75BnDaJeW8wLjBfoYiBzqy4GTpyVoCLJMIU1JZuso2tUpuXRv4XEw+V6SGCq
         8SmRDEbfbUHL7KFEsEvfmC7HIYUhq7zSeUbyDdF7bxUTqlNZCgM6rjZAxXV2cFUihOPK
         fpOw==
X-Forwarded-Encrypted: i=1; AJvYcCUvdLh8+9xaXmqPDe3eBvrQMa9w4jbbdFT7CQxloTQtHptttpRNUGyxPXsrB25+H2oABGaaMiNKQ24=@vger.kernel.org, AJvYcCVOgKUZcXL7pgpuDiY4EIfHPD4PXv+M7WO42XW9E1V4UQTrB/+8hceR8Q8hcmGa96i20/JkkoRLrSF1xSn/@vger.kernel.org, AJvYcCWQuLGjmXmRTfgAB6gJxknF2FKwmramS97TO1vzMYBvnhQIKJ+F74ShqB8v4pK7SpVC/MD5scI6+z2gk4YMHA8=@vger.kernel.org, AJvYcCWuJpfc6tgOgtuHZfBUbg56+NSmIx+tDoeCcQynv7fI/9YZjVGELvmhVK28hK26xFJgGycfB2a5MmBN@vger.kernel.org
X-Gm-Message-State: AOJu0YzSpT5BbH4YKZZ4DUD0FiapbUHvxXyf7BH1MiNjKEkfefVLA/rH
	4cVfhZUDOIsEo0RVZ+6O1IcF2cF89LQzrxrHrQ0yaFJHhSicIu9iMa8dk6VHMyvsYVE7yWq7Ft2
	BRG+eU77eHX/E7h5Irx45WantSSD7xQ==
X-Gm-Gg: ASbGncuLQBXQbaVwAV71KgalB14zECehV/RbX4VV30g25lPhYUpYvoNL+LnDahVvvIe
	Goh46gUrD0Da/Tbv7k1PeHF6vg5Eb6C2QVAKySXu570tcm4ZQF8VTgznkX3wy4QmYnX9/Cw0Uwb
	xRQeRouVE2P1jv7GBBym8M1mhGYPrDiDAw7iOCpXn7IErFImlRbXJ/+Eg=
X-Google-Smtp-Source: AGHT+IGE7hhWr4lBUp2iXX61mOHrHkLHcdsZ+lfSmDPcbezM6eWo2r4cHmhD0lVawhY5flsil/9O0ciB1HTJ1THSObY=
X-Received: by 2002:a05:6102:3908:b0:4bb:eb4a:f9ec with SMTP id
 ada2fe7eead31-4c4d91601c2mr2350382137.16.1742280814182; Mon, 17 Mar 2025
 23:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PsAMnW6hScU1fLV8ucb6wOkHECGXCrwXeSEfeVs3Hc-zbwrML674jGT8H_XNvWiF6EdymYJZSusanBrtAsZjAg==@protonmail.internalid>
 <20250107035058.818539-1-alistair@alistair23.me> <878qrm6e2p.fsf@kernel.org> <CAKmqyKO+O6H8+Y2ybz+qiAtgGbLeHMzswo9weWbg0Wc--gEiMA@mail.gmail.com>
In-Reply-To: <CAKmqyKO+O6H8+Y2ybz+qiAtgGbLeHMzswo9weWbg0Wc--gEiMA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Mar 2025 16:53:08 +1000
X-Gm-Features: AQ5f1Joy-EDdMlhXi465AXJ7d9QJ1VvxVVGStzCd-Shl2lbZ3RxltcRyszgw8bw
Message-ID: <CAKmqyKMFAUp0=FzNfhs+r+RfLK0n_Fp7YhUhjY2m=p7wSgFONg@mail.gmail.com>
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

On Tue, Jan 14, 2025 at 4:02=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Tue, Jan 7, 2025 at 9:48=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
> >
> > "Alistair Francis" <alistair@alistair23.me> writes:
> >
> > > The kernel includes a large number of static inline functions that ar=
e
> > > defined in header files. One example is the crypto_shash_descsize()
> > > function which is defined in hash.h as
> > >
> > > ```
> > > static inline unsigned int crypto_shash_descsize(struct crypto_shash =
*tfm)
> > > {
> > >         return tfm->descsize;
> > > }
> > > ```
> > >
> > > bindgen is currently unable to generate bindings to these functions a=
s
> > > they are not publically exposed (they are static after all).
> > >
> > > The Rust code currently uses rust_helper_* functions, such as
> > > rust_helper_alloc_pages() for example to call the static inline
> > > functions. But this is a hassle as someone needs to write a C helper
> > > function.
> > >
> > > Instead we can use the bindgen wrap-static-fns feature. The feature
> > > is marked as experimental, but has recently been promoted to
> > > non-experimental (depending on your version of bindgen).
> > >
> > > By supporting wrap-static-fns we automatically generate a C file call=
ed
> > > extern.c that exposes the static inline functions, for example like t=
his
> > >
> > > ```
> > > unsigned int crypto_shash_descsize__extern(struct crypto_shash *tfm) =
{ return crypto_shash_descsize(tfm); }
> > > ```
> > >
> > > The nice part is that this is auto-generated.
> > >
> > > We then also get a bindings_generate_static.rs file with the Rust
> > > binding, like this
> > >
> > > ```
> > > extern "C" {
> > >     #[link_name =3D "crypto_shash_descsize__extern"]
> > >     pub fn crypto_shash_descsize(tfm: *mut crypto_shash) -> core::ffi=
::c_uint;
> > > }
> > > ```
> > >
> > > So now we can use the static inline functions just like normal
> > > functions.
> > >
> > > There are a bunch of static inline functions that don't work though, =
because
> > > the C compiler fails to build extern.c:
> > >  * functions with inline asm generate "operand probably does not matc=
h constraints"
> > >    errors (rip_rel_ptr() for example)
> > >  * functions with bit masks (u32_encode_bits() and friends) result in
> > >    "call to =E2=80=98__bad_mask=E2=80=99 declared with attribute erro=
r: bad bitfield mask"
> > >    errors
> > >
> > > As well as that any static inline function that calls a function that=
 has been
> > > kconfig-ed out will fail to link as the function being called isn't b=
uilt
> > > (mdio45_ethtool_gset_npage for example)
> > >
> > > Due to these failures we use a allow-list system (where functions mus=
t
> > > be manually enabled).
> > >
> > > This series adds support for bindgen generating wrappers for inline s=
tatics and
> > > then converts the existing helper functions to this new method. This =
doesn't
> > > work for C macros, so we can't reamove all of the helper functions, b=
ut we
> > > can remove most.
> > >
> > > v5:
> > >  - Rebase on latest rust-next on top of v6.13-rc6
> > >  - Allow support for LTO inlining (not in this series, see
> > >    https://github.com/alistair23/linux/commit/e6b847324b4f5e904e007c0=
e288c88d2483928a8)
> >
> > Thanks! Since Gary just sent v2 of the LTO patch [1], could you rebase
> > on that and list it as a dependency? If you are using b4 there is a nic=
e
>
> I can't get Gary's series to apply on rust-next (it does apply on
> master though).
>
> I might just wait until Gary's series gets picked up to rust-next as
> there is already a lot of manual rebasing going on and my series
> currently applies on rust-next.
>
> Unfortunately there are just constant conflicts as the number of
> manual C helpers are continually growing.
>
> Obviously when/if this series is approved I can do a final rebase, I
> would just like to avoid unnecessary churn in the meantime

Any more thoughts on this?

Alistair

