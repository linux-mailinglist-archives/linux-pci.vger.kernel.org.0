Return-Path: <linux-pci+bounces-5901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B872D89CD06
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 22:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F776281D20
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 20:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7292146D60;
	Mon,  8 Apr 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBzXOJim"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767C5FB8F;
	Mon,  8 Apr 2024 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609049; cv=none; b=fpK7T1TEuocOuGwIdHBPJsnBker+sIvQ12su2YDutr0ntokinsXP8O1Fy3RHH9mhiSrV9OtQAXBwMkTYmj2MNjoFOnkg+335Sv8f05UtgRqTWjblOtmzoF7s4D6X3ubF8xH7n7qtKNgxpSNb7fj4xUnCSGQxw/iAMlzOFF0Szn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609049; c=relaxed/simple;
	bh=Y5tz8yV+GP68iA41T4sdpFzai98Z9vK2g0m0fVuViBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/9pNqH+RaY89wb2JuxBkxFp7hK+5fYIyyp7+Bs6rHYoMWJ1JBL5m8Y/aS2xIu/fNsS1bNoKAZmXEbkKqXB1dli3Dv5u3NwN8bEN9hC/XivMhoofLqSzhU/QQ0o8+KM9j7uj3ypWXlPy7D7HcCWn2N/zYhz5AQz3w+HQpoH4UJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBzXOJim; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4155819f710so37967895e9.2;
        Mon, 08 Apr 2024 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712609046; x=1713213846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1o+4pjY29HDvvdTfVxnJIAgrnAGVX4TFUsURZsKsfc=;
        b=hBzXOJimy/AMV5IlCwN8R6LTFyPhwNGSDAPxmLVJwpI3+wjgPC8601wKW2ojaF9gOz
         W67J7aYJ5h05PkoZnGqwsOsytmvh6RN85e6LvJdBi9dTanE3XoawxPp3wpGN2FR+1ntz
         FtMCGFbsYSriWguFvq94xLxJZkXBdSIH1KjHcr4bhxix6HkwQTjj0gbr90ZrsFaFloT0
         g3ia9k9fxTs1BWt3zN10i0Ocp5Tsdkf4EIDQ8eE5NNdNtxcrHyXbqcmqubDzC6EcR8fN
         F1yq7BxrTyQv1v1u6ylagJqGZYJFVrktPnGaTKTiFo+opuBay56Ym72p+OPiqhnL4Wes
         HjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712609046; x=1713213846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1o+4pjY29HDvvdTfVxnJIAgrnAGVX4TFUsURZsKsfc=;
        b=qqcNXHLDeXsqAYYzpxb4HG/5XVQp9MN/TltHmKnCctwWeXZJ1uMJ5M17o6dw3HpoUL
         a3qS/k6ucERiqF5nEN0vEImGn3EESyf7+b1ZKItXdiXGFaRHkhqHpSWybgQSKo8/Wsp8
         jiiatDl3aS64pw/1vms0/NaDO2PbY9m9Z3eQSXIGQsPSj9Rxw7VQ40GzOKyxsQ1cmUjx
         dU7bMG9f+mgtuasXL1jjXhO6+vynhIvD6O7CUq5XTy9XPC02Tj32kgFZHjfb4mD0KMCN
         wi9jXcIgF1EE8YOQHi4P4tCY2FWHwJedoeDwEvuJIkbv0TNE+X7X1buOlVQ+fTX6LJi3
         sshw==
X-Forwarded-Encrypted: i=1; AJvYcCW8uOjx9BSivRq6SZcOoGRrtwFNdpSpdHx3/J8em87ubbIlV9++26LOk3JsDWL16PMtzZdWWLLMOjH752T9aHNfXg1xhvxz2Xp1cjB2kT/0QrVbT8AlQTaNkvdMA/ILYqa/
X-Gm-Message-State: AOJu0YwwZpgZkCtH+o65wKkSXvqd14muJAEhgYDUWB5KMzsB5iJS36oz
	35mp6l09BjQ366ONE6pnPgZWvd2kSnWpbOFH2IeudOLcxhtCnV7sGgSta45lJIvN56bmUQlGpA7
	lFy26hwUSuj0HaausAj6l35DEh5s=
X-Google-Smtp-Source: AGHT+IEO1N3e3RDKuQmb5tG2Jt5wT6nHcgPVNQPpVpGkMgSV0JrZPJbgdbxGeDa6u9x/O+vcH2YTT5y37o/8DqMt3nA=
X-Received: by 2002:a05:600c:4e02:b0:416:9e38:3bdd with SMTP id
 b2-20020a05600c4e0200b004169e383bddmr419800wmq.27.1712609045767; Mon, 08 Apr
 2024 13:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zg7JDL2WOaIf3dxI@nanopsycho> <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org> <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <20240404193817.500523aa@kernel.org> <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
 <20240408061846.GA8764@unreal> <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal>
In-Reply-To: <20240408184102.GA4195@unreal>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 8 Apr 2024 13:43:28 -0700
Message-ID: <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:41=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Apr 08, 2024 at 08:26:33AM -0700, Alexander Duyck wrote:
> > On Sun, Apr 7, 2024 at 11:18=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Fri, Apr 05, 2024 at 08:41:11AM -0700, Alexander Duyck wrote:
> > > > On Thu, Apr 4, 2024 at 7:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.=
org> wrote:
> > >
> > > <...>
> > >
> > > > > > > Technical solution? Maybe if it's not a public device regress=
ion rules
> > > > > > > don't apply? Seems fairly reasonable.
> > > > > >
> > > > > > This is a hypothetical. This driver currently isn't changing an=
ything
> > > > > > outside of itself. At this point the driver would only be build=
 tested
> > > > > > by everyone else. They could just not include it in their Kconf=
ig and
> > > > > > then out-of-sight, out-of-mind.
> > > > >
> > > > > Not changing does not mean not depending on existing behavior.
> > > > > Investigating and fixing properly even the hardest regressions in
> > > > > the stack is a bar that Meta can so easily clear. I don't underst=
and
> > > > > why you are arguing.
> > > >
> > > > I wasn't saying the driver wouldn't be dependent on existing behavi=
or.
> > > > I was saying that it was a hypothetical that Meta would be a "less
> > > > than cooperative user" and demand a revert.  It is also a hypotheti=
cal
> > > > that Linus wouldn't just propose a revert of the fbnic driver inste=
ad
> > > > of the API for the crime of being a "less than cooperative maintain=
er"
> > > > and  then give Meta the Nvidia treatment.
> > >
> > > It is very easy to be "less than cooperative maintainer" in netdev wo=
rld.
> > > 1. Be vendor.
> > > 2. Propose ideas which are different.
> > > 3. Report for user-visible regression.
> > > 4. Ask for a fix from the patch author or demand a revert according t=
o netdev rules/practice.
> > >
> > > And voil=C3=A0, you are "less than cooperative maintainer".
> > >
> > > So in reality, the "hypothetical" is very close to the reality, unles=
s
> > > Meta contribution will be treated as a special case.
> > >
> > > Thanks
> >
> > How many cases of that have we had in the past? I'm honestly curious
> > as I don't actually have any reference.
>
> And this is the problem, you don't have "any reference" and accurate
> knowledge what happened, but you are saying "less than cooperative
> maintainer".

By "less than cooperative maintainer" I was referring to the scenario
where somebody is maintaining something unique to them, such as the
Meta Host NIC, and not willing to work with the community to fix it
and instead just demanding a revert of a change. It doesn't seem like
it would be too much to ask to work with the author on a fix for the
problem as long as the maintainer is willing to work with the author
on putting together and testing the fix.

With that said if the upstream version of things aren't broken then it
doesn't matter. It shouldn't be expected of the community to maintain
any proprietary code that wasn't accepted upstream.

> >
> > Also as far as item 3 isn't hard for it to be a "user-visible"
> > regression if there are no users outside of the vendor that is
> > maintaining the driver to report it?
>
> This wasn't the case. It was change in core code, which broke specific
> version of vagrant. Vendor caught it simply by luck.

Any more info on this? Without context it is hard to say one way or the oth=
er.

I know I have seen my fair share of hot issues such as when the
introduction of the tracing framework was corrupting the NVRAM on
e1000e NICs.[1] It got everyone's attention when it essentially
bricked one of Linus's systems. I don't recall us doing a full revert
on function tracing as a result, but I believe it was flagged as
broken until it could be resolved. So depending on the situation there
are cases where asking for a fix or revert might be appropriate.

> > Again I am assuming that the same rules wouldn't necessarily apply
> > in the vendor/consumer being one entity case.
> >
> > Also from my past experience the community doesn't give a damn about
> > 1. It is only if 3 is being reported by actual users that somebody
> > would care. The fact is if vendors held that much power they would
> > have run roughshod over the community long ago as I know there are
> > vendors who love to provide one-off projects outside of the kernel and
> > usually have to work to get things into the upstream later and no
> > amount of complaining about "the users" will get their code accepted.
> > The users may complain but it is the vendors fault for that so the
> > community doesn't have to take action.
>
> You are taking it to completely wrong direction with your assumptions.
> The reality is that regression was reported by real user without any
> vendor code involved. This is why the end result was so bad for all parti=
es.

Okay, but that doesn't tie into what is going on here. In this case
"vendor" =3D=3D "user". Like I was saying the community generally cares
about the user so 3 would be the important case assuming they are
using a stock kernel and driver and not hiding behind the vendor
expecting some sort of proprietary fix. If they are using some
proprietary stuff behind the scenes, then tough luck.

> So no, you can get "less than cooperative maintainer" label really easy i=
n
> current environment.

I didn't say you couldn't. Without context I cannot say if it was
deserved or not. I know in the example I cited above Intel had to add
changes to the e1000e driver to make the NVRAM non-writable until the
problem patch was found. So Intel was having to patch to fix an issue
it didn't introduce and deal with the negative press and blow-back
from a function tracing patch that was damaging NICs.

The point I was trying to make is that if you are the only owner of
something, and not willing to work with the community as a maintainer
it becomes much easier for the community to just revert the driver
rather than try to change the code if you aren't willing to work with
them. Thus the "less than cooperative" part. The argument being made
seems to be that once something is in the kernel it is forever and if
we get it in and then refuse to work with the community it couldn't be
reverted. I am arguing that isn't the case, especially if Meta were to
become a "less than cooperative maintainer" for a device that is
primarily only going to be available in Meta data centers.

Thanks,

- Alex

[1]: https://lwn.net/Articles/304105/

