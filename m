Return-Path: <linux-pci+bounces-24049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA4A676F5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 15:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C7019A71C0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7C20CCEA;
	Tue, 18 Mar 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4oxc0Pv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4520C47B;
	Tue, 18 Mar 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309460; cv=none; b=ONqKOHSg6g/6SLLUlU+eAp3dXyys11vaTYAcazGmoygRZw6OnW2x5rOoi3N82+Ihhu3JjqBEa3sOAO5S6qGCx8W6Gblpc8G4h89WXs4MLzpYzr7XvoL9IQT+XwKd1SAVn8DM11GyxUxddsRvdyQcIPUhkrKDmFf6qZFTZLDTFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309460; c=relaxed/simple;
	bh=AV1Nxik7JBkOIVEYVNlGI3SIY7/qAIdx7hP6IDQ9sHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRl+OVte8SUGGPwHWkXPDlpKeb2iWjvrUE4DoaOkxTeXjjFjTezXgajuD2H/PMagzETa5qoA3pzhPZUjRUbknORw2dHT5TYa25NCxwZXM2PJZP9fo707RQljZpiWHgR0baqr9KYIqHoszbFQdD37ioYe2mUsuqYsKz/iIjE9SsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4oxc0Pv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso57204491fa.1;
        Tue, 18 Mar 2025 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742309453; x=1742914253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AV1Nxik7JBkOIVEYVNlGI3SIY7/qAIdx7hP6IDQ9sHw=;
        b=H4oxc0PvCeDDPsJArDnxVmZV9LI/er2Ez4zQlfQ+13cnk0XCAq6B5b7Usw1GoNraT/
         GoFSGsMEVCME632Cus2a4lW42GDMNbqqHCX0QHdsZpPJtxoE8qjUYA4HhvenrVzRB0mY
         AcgcSlNhPkCBpmfpPZmnMPPn24FeBzlFPkOZVMWpbNI4VHrkmxcm19PCbXrjG9/pZS2G
         I6KX7ifVLYFi0+AaAeVjl8m19ALMKRcat7BVa8G+YByo7nb9psRgvJbrywSd4s2uNKat
         XLEpmNyJyvgVOGoT6BqHZDmDSfqKZ3xzyliK/Pp6BAO8GnESgwC7C+H/KO9RnAMxfJZ3
         OMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309453; x=1742914253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AV1Nxik7JBkOIVEYVNlGI3SIY7/qAIdx7hP6IDQ9sHw=;
        b=uQGl49eggbc4ry7wa/IGCGHqIsgFTQWHm8kUjHtP0ocAhBiy3/UmLRVsFv6260/Ls6
         tYel5DCPZyuIfbTdypWRh6ZXW/QGruMp90MndYwnmMGBJKjgssvAePhVeCsj8eMiwlZo
         WNm8V7Gz0rnaEXc2GUEawuL7q+nIM9j/5JlXIBTRN0Fvluh8isFPhcNRG7mspYJlUq97
         KOuWQUru6fi1RdGquQOmgUmXNO2Jjli/W6Vm5p8cBoTR4TFJCftUWgpqnOnlvoL8BANg
         0XnkdZxxGqVtk/+qK9iGwGbohJr0AYjXa7jnTMKP9yHTU4gxSMk+0hPwm0x3xDVQGFVl
         IK0w==
X-Forwarded-Encrypted: i=1; AJvYcCVMCz1XFXQjmAlTIYeXxMnTY5XsGQJ/0kgvUcO/hN3YDxPSztMafEc7Qlg2RT7TW/D85/ZoVbWnmBJs78IOVAM=@vger.kernel.org, AJvYcCW0cpqSAkeI6OlNpYaLKxGgWLlxSFeIHoq3Zf/u67Sj/gE0HIry3AZ3RCs1YtjpFIe74pxW7hJzXlj5@vger.kernel.org, AJvYcCWZUyQQTMyq3YXKrTqcUUPPf2/Cz4yqamok4EavW42WZ8ywSNV857sXpyey3VtkQTZ+gfEKnuD7LR4=@vger.kernel.org, AJvYcCWbwe/FZqsJKw66wqhBpkNpvr3/OGFJ+vHHmtGyC7NKrVTi1Oj5lHzlF/VAo/LDrISGUd/vp/IGxFHK488K@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0OH0Swj/gS6Bf3lT++KBhVGjiwvYfia6ehKSoZn7vVbz9zZgr
	62RWeWaqYkOjNpqPInOLFCjCISHrPoEaUFAehQ2FZ7d0MZKtqmRoqZYw6IZFIxrT0OGektSj7NR
	Qb3EoSfZfMUsEcl6JmESOVAYi/kI=
X-Gm-Gg: ASbGnctdZE6+EX8fakrifKDZNZpgISbDoKdfvHDSaEwN85875rS5vmpngab+LkDouYH
	jx5eUv/LOcnkJUj7GbUtrLlK6bXRA9WeM9yzJoNl2IFslj4nAgaUy4+YUjvw/621Gu605ZPaz78
	SnUmuPawb4DXIr8eeUJIZLXpDojIlhpuspTv5fM5qvBQ==
X-Google-Smtp-Source: AGHT+IHoYcofaDV167At8gyTlcxgahoKqecaiJRiqZIsUp3WL1jI7jHwfGXN+eAotV8neRNb+frmdsSnmpBQRfzAEi4=
X-Received: by 2002:a2e:a781:0:b0:30c:12b8:fb97 with SMTP id
 38308e7fff4ca-30cd95cdfb0mr22215931fa.11.1742309452463; Tue, 18 Mar 2025
 07:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PsAMnW6hScU1fLV8ucb6wOkHECGXCrwXeSEfeVs3Hc-zbwrML674jGT8H_XNvWiF6EdymYJZSusanBrtAsZjAg==@protonmail.internalid>
 <20250107035058.818539-1-alistair@alistair23.me> <878qrm6e2p.fsf@kernel.org>
 <CAKmqyKO+O6H8+Y2ybz+qiAtgGbLeHMzswo9weWbg0Wc--gEiMA@mail.gmail.com> <CAKmqyKMFAUp0=FzNfhs+r+RfLK0n_Fp7YhUhjY2m=p7wSgFONg@mail.gmail.com>
In-Reply-To: <CAKmqyKMFAUp0=FzNfhs+r+RfLK0n_Fp7YhUhjY2m=p7wSgFONg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 10:50:15 -0400
X-Gm-Features: AQ5f1Jpsgdw9M0V8e3T4BspLDyv9RIhRJmXxkp78APBJs9vA4fZG8z3nwGNCckY
Message-ID: <CAJ-ks9mtG+QcGNpSgZ2Wh-wgXtFiJ-7Xrr4-07xe9hxxdRuTSA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] rust: bindings: Auto-generate inline static functions
To: Alistair Francis <alistair23@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Alistair Francis <alistair@alistair23.me>, bhelgaas@google.com, 
	rust-for-linux@vger.kernel.org, lukas@wunner.de, gary@garyguo.net, 
	akpm@linux-foundation.org, tmgross@umich.edu, boqun.feng@gmail.com, 
	ojeda@kernel.org, linux-cxl@vger.kernel.org, bjorn3_gh@protonmail.com, 
	me@kloenk.dev, linux-kernel@vger.kernel.org, aliceryhl@google.com, 
	alistair.francis@wdc.com, linux-pci@vger.kernel.org, benno.lossin@proton.me, 
	alex.gaynor@gmail.com, Jonathan.Cameron@huawei.com, wilfred.mallawa@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:53=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Tue, Jan 14, 2025 at 4:02=E2=80=AFPM Alistair Francis <alistair23@gmai=
l.com> wrote:
> >
> > On Tue, Jan 7, 2025 at 9:48=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
> > >
> > > Thanks! Since Gary just sent v2 of the LTO patch [1], could you rebas=
e
> > > on that and list it as a dependency? If you are using b4 there is a n=
ice
> >
> > I can't get Gary's series to apply on rust-next (it does apply on
> > master though).
> >
> > I might just wait until Gary's series gets picked up to rust-next as
> > there is already a lot of manual rebasing going on and my series
> > currently applies on rust-next.
> >
> > Unfortunately there are just constant conflicts as the number of
> > manual C helpers are continually growing.
> >
> > Obviously when/if this series is approved I can do a final rebase, I
> > would just like to avoid unnecessary churn in the meantime
>
> Any more thoughts on this?

Hi Alistair,

I can't speak for Gary as I don't know what his plans are for that LTO
series, but I did review that series and this one, and at first glance
the two seem orthogonal. The goal of Gary's series is to LTO C helpers
into Rust, while the goal of this series is to machine-generate those
helpers. Do I have that right?

If yes, I think it's important to think about how the two fit
together, at least conceptually. Mechanically I think there's an issue
with this trick:

#ifdef __BINDGEN__
#define __rust_helper
#else
#define __rust_helper inline
#endif

which the LTO series uses to generate Rust stubs for these functions
while also keeping them marked inline in LLVM IR/bitcode.

That said, I see some discussion of cross-language LTO in "How to
handle static inline functions" [1], so maybe there's another way that
makes more sense in light of this series.

Updating the cover letter to elucidate these details is where I'd
suggest you start.

Cheers.
Tamir

[1] https://github.com/rust-lang/rust-bindgen/discussions/2405

