Return-Path: <linux-pci+bounces-5944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE4B89DD1B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EFE1F21752
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD9912F5AF;
	Tue,  9 Apr 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5r2XKN5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF8B50275;
	Tue,  9 Apr 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673829; cv=none; b=Ahi66O1z7rGMZKGHgVRpwp+ARPkO2dEY1IZ14ibMnJzJA65jcAEXCZgKugyDC6jSCINaZs0qUwhCuJHp9oMYHEbQ+SOip1W3vM4/NC+7uIOY9W8T5LsdFezQOYR6ErT2jH63WiKTWf85BnuZxwxpgcHyTXNWiARNZX6SZvbM6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673829; c=relaxed/simple;
	bh=n9tQsLOyEcQf8vlY4RV5gPxuCqiukaMIvcLOHq/0ouo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClZJDBTVOq4ae9LcU5zCgg7HjIMCD4NvMFUqqmyKwSfn8Ri6QGgWJKESPR8yRZIfXrtDEi+GvxViVMMZu0yONScupNl+I3fi0zulvrckQTTE5KWUy9Jo//i7Ja9zrQsT8BfS5tURihGAACEQyh0zhXv0bdF+jievhXdwfNjG3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5r2XKN5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so76793381fa.0;
        Tue, 09 Apr 2024 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712673825; x=1713278625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpG1egRcf2YviGdFgIY5mkdL66YS2IFlhDf2Y7Ur080=;
        b=X5r2XKN5OrY7z58By9Ah11+rTWOD373VUYO3xu9H7KAaQVMEQ3/EaqHRx+O9aSeeEa
         TUWPNC/1La4uUlcUPPkDFQiW0+aBwWsvTzuGI6ftEU5OrEp8CQr3plzn+qG7r2hkcElk
         io22uMY/lWZBvmTvUOMFJt3E13SNzfLOoIKS9qIgxxZC3KRTDOfqFMJT5zHGphC9gaM7
         VVzUZippW6n/uIbe7QkaLP6QNWvEWsS9dKXCqg1zq5ctAmIOcHmwIHrJpq/stv5EQ6BF
         Woi/hmAwsTgnbNdglQLiSk/WiCMR1tzZIIq+BtOOPBTlMqbWNqUEVMQ9ss4X23C9KlJc
         LSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673825; x=1713278625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpG1egRcf2YviGdFgIY5mkdL66YS2IFlhDf2Y7Ur080=;
        b=vR8H090SHIGj66DCVmhRUa5WvLqSDWPi2uIYkYpJGd6dMJ3fQi63iEZQa6W0DwyuZh
         jrzWUzZJ4H+e6mu+3n5MzdhYPiGp4k8JnbZpQ4qXFyMGmBNTtR3xbq6ttxxCx9x57OvV
         ma3m/0B5sFopBh9zhl0xTk2T49G5DtKpVZduY3Ag04dRkUynXaK6nBVu8MFnNZOMg/2t
         5JGBX2oYhPvP3qUF99sGt5lxTb7TSpFdFhuQ3RS4/jdVDp/5sxsyby+/gZ09S9yY/oAv
         di5hs4PQkAJeDPscK8hrZ73MPq4fPNu83h0pffdRSyNO+r4WRcCIyC6RV8Y9rJL/VMRp
         4DWg==
X-Forwarded-Encrypted: i=1; AJvYcCVBqEYRQIGVaTswOwcqkIOn8PIVIbA4Xe+FlDVsYisqccRs48YMV8n5PjkCKo4v8401IAHBk7ujbSUQTDdCyfQVow9Z+sLR4jAiiOQIrDpHz34+VHNxTBsQ+J9bb7atlgQT
X-Gm-Message-State: AOJu0YzAiIk+wNW7wHAE4AcRRqHjhVu+IqsTM0cfxpnKLuEuORcgombj
	/V/dEZI2BMPi5FRviAceeF2sOvx8jQdv+RTpSxlPgjNkHAnGq0cowpihhORmw4UIusKs1KRN1fT
	wZgmxVu/B9V2X9+UzCHre7kA+GE7nw5z2PqQ=
X-Google-Smtp-Source: AGHT+IHAFEzl3DHWl/i8AnFdUQy7LRVeJy1u8HmFgYCgdAHJry0I0hwIjypKFOFGIc5R9alUx9dUkkDlb7S/VI47gFQ=
X-Received: by 2002:a2e:bc11:0:b0:2d7:b4f:e3fe with SMTP id
 b17-20020a2ebc11000000b002d70b4fe3femr22628ljf.34.1712673825015; Tue, 09 Apr
 2024 07:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org> <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <20240404193817.500523aa@kernel.org> <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
 <20240408061846.GA8764@unreal> <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal> <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
 <20240409081856.GC4195@unreal>
In-Reply-To: <20240409081856.GC4195@unreal>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 9 Apr 2024 07:43:07 -0700
Message-ID: <CAKgT0UewAZSqU6JF4-cPf7hZM41n_QMuiF_K8SY8hyoROQLgfQ@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:19=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Mon, Apr 08, 2024 at 01:43:28PM -0700, Alexander Duyck wrote:
> > On Mon, Apr 8, 2024 at 11:41=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Mon, Apr 08, 2024 at 08:26:33AM -0700, Alexander Duyck wrote:
> > > > On Sun, Apr 7, 2024 at 11:18=E2=80=AFPM Leon Romanovsky <leon@kerne=
l.org> wrote:
> > > > >
> > > > > On Fri, Apr 05, 2024 at 08:41:11AM -0700, Alexander Duyck wrote:
> > > > > > On Thu, Apr 4, 2024 at 7:38=E2=80=AFPM Jakub Kicinski <kuba@ker=
nel.org> wrote:
> > > > >
> > > > > <...>
> > > > >
> > > > > > > > > Technical solution? Maybe if it's not a public device reg=
ression rules
> > > > > > > > > don't apply? Seems fairly reasonable.
> > > > > > > >
> > > > > > > > This is a hypothetical. This driver currently isn't changin=
g anything
> > > > > > > > outside of itself. At this point the driver would only be b=
uild tested
> > > > > > > > by everyone else. They could just not include it in their K=
config and
> > > > > > > > then out-of-sight, out-of-mind.
> > > > > > >
> > > > > > > Not changing does not mean not depending on existing behavior=
.
> > > > > > > Investigating and fixing properly even the hardest regression=
s in
> > > > > > > the stack is a bar that Meta can so easily clear. I don't und=
erstand
> > > > > > > why you are arguing.
> > > > > >
> > > > > > I wasn't saying the driver wouldn't be dependent on existing be=
havior.
> > > > > > I was saying that it was a hypothetical that Meta would be a "l=
ess
> > > > > > than cooperative user" and demand a revert.  It is also a hypot=
hetical
> > > > > > that Linus wouldn't just propose a revert of the fbnic driver i=
nstead
> > > > > > of the API for the crime of being a "less than cooperative main=
tainer"
> > > > > > and  then give Meta the Nvidia treatment.
> > > > >
> > > > > It is very easy to be "less than cooperative maintainer" in netde=
v world.
> > > > > 1. Be vendor.
> > > > > 2. Propose ideas which are different.
> > > > > 3. Report for user-visible regression.
> > > > > 4. Ask for a fix from the patch author or demand a revert accordi=
ng to netdev rules/practice.
> > > > >
> > > > > And voil=C3=A0, you are "less than cooperative maintainer".
> > > > >
> > > > > So in reality, the "hypothetical" is very close to the reality, u=
nless
> > > > > Meta contribution will be treated as a special case.
> > > > >
> > > > > Thanks
> > > >
> > > > How many cases of that have we had in the past? I'm honestly curiou=
s
> > > > as I don't actually have any reference.
> > >
> > > And this is the problem, you don't have "any reference" and accurate
> > > knowledge what happened, but you are saying "less than cooperative
> > > maintainer".
>
> <...>
>
> > Any more info on this? Without context it is hard to say one way or the=
 other.
>
> <...>
>
> > I didn't say you couldn't. Without context I cannot say if it was
> > deserved or not.
>
> Florian gave links to the context, so I'll skip this part.
>
> In this thread, Jakub tried to revive the discussion about it.
> https://lore.kernel.org/netdev/20240326133412.47cf6d99@kernel.org/
>
> <...>

I see. So this is what you were referencing. Arguably I can see both
sides of the issue. Ideally what should have been presented would have
been the root cause of why the diff was breaking things and then it
could have been fixed. However instead what was presented was
essentially a bisect with a request to revert.

Ultimately Eric accepted the revert since there was an issue that
needed to be fixed. However I can't tell what went on in terms of
trying to get to the root cause as that was taken offline for
discussion so I can't say what role Mellanox played in either good or
bad other than at least performing the bisect.

Ultimately I think this kind of comes down to the hobbyist versus
commercial interests issue that I brought up earlier. The hobbyist
side should at least be curious about what about the Vagrant
implementation was not RFC compliant which the changes supposedly
were, thus the interest in getting a root cause. However that said it
is broken and needs to be fixed so curiosity be damned, we cannot
break userspace or not interop with other TCP implementations.

> > The point I was trying to make is that if you are the only owner of
> > something, and not willing to work with the community as a maintainer
>
> Like Jakub, I don't understand why you are talking about regressions in
> the driver, while you brought the label of "less than cooperative maintai=
ner"
> and asked for "then give Meta the Nvidia treatment".

Because I have been trying to keep the  whole discussion about the
fbnic driver that is presented in this patch set. When I was referring
to a "less than cooperative maintainer" it was in response to the
hypothetical about what if Meta started refusing to work with the
community after this was accepted, and the "Nvidia treatment" I was
referring was the graphics side about 10 years ago[1] as the question
was about somebody running to Linus to complain that their proprietary
hardware got broken by a kernel change. The general idea being if we
are a proprietary NIC with ourselves as the only customer Linus would
be more likely to give Meta a similar message.


> I don't want to get into the discussion about if this driver should be
> accepted or not.
>
> I'm just asking to stop label people and companies based on descriptions
> from other people, but rely on facts.

Sorry, it wasn't meant to be any sort of attack on Nvidia/Mellanox.
The Nvidia I was referencing was the graphics side which had a bad
reputation with the community long before Mellanox got involved.

> Thanks

Thank you. I understand now that you and Jason were just trying to
warn me about what the community will and won't accept. Like I
mentioned before I had just misconstrued Jason's comments as backing
Jiri initially in this. In my mind I was prepared for the
Nvidia/Mellanox folks dog piling me so I was just prepared for
attacks.

Just for the record this will be the third NIC driver I have added to
the kernel following igbvf and fm10k, and years maintaining some of
the other Intel network drivers. So I am well aware of the
expectations of a maintainer. I might be a bit rusty due to a couple
years of being focused on this project and not being able to post as
much upstream, but as the expression goes "This isn't my first rodeo".

- Alex

[1]: https://arstechnica.com/information-technology/2012/06/linus-torvalds-=
says-f-k-you-to-nvidia/

