Return-Path: <linux-pci+bounces-5964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A49089E2B3
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4131F238E5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03F4156C5F;
	Tue,  9 Apr 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0qfCJmF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F2412FF67;
	Tue,  9 Apr 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687980; cv=none; b=PZKALm1PGeoeMjRj7do/Bng1NwA80DzEbxG2p1Iw6RWTm3JWEsAtagFdkzXotBN3izqU9FT0jJ4dIxA3XHMC1LsH3q7ROO1mvWyDQo5RT2hAGz0JSoUaNtBRBuWsPHXvZXCqRCoOk6LXZkgrjeAVgTutZPlPUQl4st1bwFkfeoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687980; c=relaxed/simple;
	bh=1kaR/vo0jU4WKSIYLCwlNMYTQVsfy9zi5AmnV/VsFl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nu/0wp1dIPbEETHGm+lsssMD/qj4mMuZRNO+9IORW/hTA1EktBZAoG5i0l95mWhLDeHg+j4yKVuZ8YrZyPx7hZQqz2VnuTIyqdUnoGSntw2dfMWdU8audvvKNMy8LAaQjuO6z8WmQirXYCHNuj+CJrUaoaPw8FTuB2ugIhpfZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0qfCJmF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343d6b55c42so4122450f8f.2;
        Tue, 09 Apr 2024 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712687977; x=1713292777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEQX7TGhPKs1Hxa4DOyzx3wiR0UYps9oRpePb0o9NKg=;
        b=I0qfCJmFVrEMCMZdVhHbHj38y2yVzmo8/5JacExD3X00FPPz9/SwnicgS4a7g5N6jP
         rgTk9izEMM9oaHokE6vcxd5gCe88ES1Q1EMHHYBsNGFBIYKvIbbNyOqJamHKkPInKCHp
         XvGytJasgo2zpfXJZSXZWXoC3vfoOH6omjX3gIQmUkKoq5pS1cjKxYbHGTkt+jI+8MiU
         Xv3MBoFAd2vEvug6YmlY5JTWk0xIjh+JoBE23cv62QUeOlhC/j1TjfckmVvwHoK50VXp
         ItWv3H8im3Ufi7bS2lHdbyeurkfmeSR9P6vNYN44lPRFnnEuvGjdaorH9o2qmJGQuMhV
         NelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712687977; x=1713292777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEQX7TGhPKs1Hxa4DOyzx3wiR0UYps9oRpePb0o9NKg=;
        b=weQ4BA52F0If9BuXVs8E+zH/nQg7edFuUTQsuoi+YY3vc5nIk6ZvjFUt7AlbkfWUSj
         v4Bg6s1Fs+cyoUitMM1D9MFspjhZvicFVYrTaBVkwbvdi7pQOlb8sFmyykvFUOZD3bSM
         YzQlDIzxWkrrvNNlEn1UjA3hMlCUWLkdnOlFU58PC5HFLS7xlllZYrgn93SeA+TDhq79
         6dnShY1J0VXBxh7fzu0SHx+9FHIQlpIUx6EqKFaAdrSMsbQrN2/bGyp3Nq3OmtqlbRkt
         koxU6Gsa2i8vgXcGaDga+Kwsmj42NX3wequaGz60VwP3b5yVhnmfTasGQqOoWpRPHN4m
         ppJw==
X-Forwarded-Encrypted: i=1; AJvYcCUaRGTN2rr96mxvxVm3vwgeFecYR4y2QIcUpIO0ur/E6NCGhLViMK+bZy66iZmUkEm/iPaBPfEyfVt5ZSCEomVKHBKvMF9C0sLSYhoouFqCqyDViNtJ9eQk9eOsSsnv3JoR
X-Gm-Message-State: AOJu0Yx1Paq9EAS6pT+6cHNTmjL+9Nx7MELMc5qUgLmW4bUc/7aPI+UH
	xjzIAkCW6XbLWqlBfF3NBOykB8FDyFFrp9jRnScWu1MgWzCiwNuzbJrIjqQF6vROJD3mY8qo2rt
	Am6TAPoGfvcL170hhll2GfemcXijp9/IJ
X-Google-Smtp-Source: AGHT+IFMKYCTuZMWZrdehYXdI72sx0cVefgmzcr1kxl2KEXAzLZu75bCuz9MMehutKby422Kly4p+cH2uqPzmUo70h8=
X-Received: by 2002:adf:fa46:0:b0:33e:dbc0:773 with SMTP id
 y6-20020adffa46000000b0033edbc00773mr499925wrr.44.1712687976903; Tue, 09 Apr
 2024 11:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404193817.500523aa@kernel.org> <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
 <20240408061846.GA8764@unreal> <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal> <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
 <20240409081856.GC4195@unreal> <CAKgT0UewAZSqU6JF4-cPf7hZM41n_QMuiF_K8SY8hyoROQLgfQ@mail.gmail.com>
 <20240409153932.GY5383@nvidia.com> <CAKgT0UeSNxbq3JYe8oNaoWYWSn9+vd1c+AfjvUsietUtS09r0g@mail.gmail.com>
 <20240409171235.GZ5383@nvidia.com>
In-Reply-To: <20240409171235.GZ5383@nvidia.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 9 Apr 2024 11:38:59 -0700
Message-ID: <CAKgT0Ufc0Zx6-UwCNbwtEahdbCv=eVqJKoDuoQdz6QMD2tv-ww@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 10:12=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Apr 09, 2024 at 09:31:06AM -0700, Alexander Duyck wrote:
>
> > > expectation is generally things like:
> > >
> > >  - The bug is fixed immediately because the issue is obvious to the
> > >    author
> > >  - Iteration and rapid progress is seen toward enlightening the autho=
r
> > >  - The patch is reverted, often rapidly, try again later with a good
> > >    patch
> >
> > When working on a development branch that shouldn't be the
> > expectation. I suspect that is why the revert was pushed back on
> > initially. The developer wanted a chance to try to debug and resolve
> > the issue with root cause.
>
> Even mm-unstable drops patches on a hair trigger, as an example.
>
> You can't have an orderly development process if your development tree
> is broken in your CI.. Personally I'm grateful for the people who test
> linux-next (or the various constituent sub trees), it really helps.
>
> > Well much of it has to do with the fact that this is supposed to be a
> > community. Generally I help you, you help me and together we both make
> > progress. So within the community people tend to build up what we
> > could call karma. Generally I think some of the messages sent seemed
> > to make it come across that the Mellanox/Nvidia folks felt it "wasn't
> > their problem" so they elicited a bit of frustration from the other
> > maintainers and built up some negative karma.
>
> How could it be NVIDIA folks problem? They are not experts in TCP and
> can't debug it. The engineer running the CI systems did what he was
> asked by Eric from what I can tell.

No, I get your message. I wasn't saying it was your problem. All that
can be asked for is such cooperation. Like I said I think some of the
problem was the messaging more than the process.

> > phenomenon where if we even brushed against block of upstream code
> > that wasn't being well maintained we would be asked to fix it up and
> > address existing issues before we could upstream any patches.
>
> Well, Intel has it's own karma problems in the kernel community. :(

Oh, I know. I resisted the urge to push out the driver as "idgaf:
Internal Device Generated at Facebook" on April 1st instead of "fbnic"
to poke fun at the presentation they did at Netdev 0x16 where they
were trying to say all the vendors should be implementing "idpf" since
they made it a standard.

> > > In my view the vendor/!vendor distinction is really toxic and should
> > > stop.
> >
> > I agree. However that was essentially what started all this when Jiri
> > pointed out that we weren't selling the NIC to anyone else. That made
> > this all about vendor vs !vendor,
>
> That is not how I would sum up Jiri's position.
>
> By my read he is saying that contributing code to the kernel that only
> Meta can actually use is purely extractive. It is not about vendor or
> !vendor, it is taking-free-forwardporting or not. You have argued,
> and I would agree, that there is a grey scale between
> extractive/collaborative - but I also agree with Jiri that fbnic is
> undeniably far toward the extractive side.
>
> If being extractive is a problem in this case or not is another
> question, but I would say Jiri's objection is definitely not about
> selling or vendor vs !vendor.
>
> Jason

It all depends on your definition of being extractive. I would assume
a "consumer" that is running a large number of systems and is capable
of providing sophisticated feedback on issues found within the kernel,
in many cases providing fixes for said issues, or working with
maintainers on resolution of said issues, is not extractive.

The fact that said "consumer" decides to then produce their own device
becoming a "prosumer" means they are now able to more accurately and
quickly diagnose issues when they see them. They can design things
such that there isn't some black box of firmware, or a third party
driver, in the datapath that prevents them from quickly diagnosing the
issue. So if anything I would think that is a net positive for the
community as it allows the "prosumer" to provide much more quick and
useful feedback on issues found in the kernel rather than having to
wait on a third party vendor to provide additional input.

Note I am not going after any particular vendor with my comments. This
applies to all vendors. The problem as a customer is that you are
limited on what you can do once you find an issue. Quite often you are
at the mercy of the vendor in such cases, especially when there seems
to be either firmware or "security" issues involved.

Thanks,

- Alex

