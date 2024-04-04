Return-Path: <linux-pci+bounces-5754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB9889924F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 01:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9561C225ED
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 23:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4819E13C693;
	Thu,  4 Apr 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOKeEufW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203013C3FC;
	Thu,  4 Apr 2024 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712274684; cv=none; b=VUzJr4CPSQMj3fmjmL4Jt6CZBuAwc5OABQZaog+1tu0156XE1nZA/GKXoRq3FGpIoVV3VERR/XaPcdSHPyVQbNiCDFWjpZHqVPMHE4L2Cd7+2BHYKGK0/iJcYXDFlCgdsCCJYl9ISK61ls1XB0qpu0TMvHUtePidimNh50Xo7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712274684; c=relaxed/simple;
	bh=ptbhZ1FqqBBkuR5+U6bO7i5ZKxKbkEhwS4K/4wtLu+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qocj9YRtSrCEIHvxWPwTdsbbmeg8f+oWU1OPExyQU73wOK+nlmgE6XgRxdAM0RYFxl//lGeyrGDXq97YiI8eKB8uzM7mjjMQGcCg0zy7xadKA/f4k/SIslPv+Qw/oc4pZD7eYUHpphbljIoRWakqIGSPsDe+NLbRYDBAXq837pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOKeEufW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343e096965bso137849f8f.3;
        Thu, 04 Apr 2024 16:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712274681; x=1712879481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptbhZ1FqqBBkuR5+U6bO7i5ZKxKbkEhwS4K/4wtLu+U=;
        b=fOKeEufWgzhcQefE/rpLWWKU27nEYD8Z82kQU3QjNg+9Id+20st+edlf9IR5zyLg4s
         b/I8Q9cYXChxRxpaNRZEL7p/MG4jpaiylBP5eTOGIik2aAbFGEjXvMlOOBfDXrfb4mAv
         5EdfQy1/3rsh6nxmnIRSYB9KrWW9rxWZCwmVHukRkVVZZy1vJRSbRGPb9V1hKOg743Wu
         u/5rd9KrqHfBbM1Lj1Si2uRNXawqHKC2H/FNyQvP8oxQz/FL0UU7EFtBvYL5n0YquFNm
         64Tb+dA13rUHcc/B3JLz9sWnn6ob/q4ELQfpBfU1qasttRTxTS6AojQsXs3t0Je1C2ul
         CThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712274681; x=1712879481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptbhZ1FqqBBkuR5+U6bO7i5ZKxKbkEhwS4K/4wtLu+U=;
        b=fJFWfj7EWX7RDt0Y6vw/3UB/ToWrVhIQ+3ufuk5/zPf+s+8y4uW9yGvp05ENWSDQ90
         Il3ZCxduR4RlE7adMXPk4gcMCLIKDoK23LD3t6cHZ4INEeDW2+a+P9uaE8ADmbfoa9p4
         Dw+6fPa5UdSkIzXVPd/ryFQhU7tmGrAkqkhRG+JaK4WT2I9FeMxTBYpd3LyH3UuZXX6/
         0sN6yxhAYu3tpUisjXleUozr3oMi3AwMpPwCcyVMQPzfHCSzG1XrlxiepynAPS0/0Qao
         wmgG9WSZ5LwCtaatbwdxaWDTtpWgscNH5HA6O8Nvx+N+ij1cjK/UMWMaR0aWZ7FK4Xrl
         ar9g==
X-Forwarded-Encrypted: i=1; AJvYcCWPHC535KfKZDgSWHXz9xi4d0ntRBnPdud+qDImpGz/D8erXL2ctJ4RZvnGj7Ol0hxVpJsTIe8z6q5QnbU9IR5WTA/+NAZoFNGtoPuC+Ngca1zqJpd8DGzs7fP7t6xIOEEH
X-Gm-Message-State: AOJu0Yyf4CtigWtw83eOczLZ1g9k8sYwrEFab22aLqNlAg22KehKwb14
	AxEM6ljs7ftG55vHQ+DQ7WO1miF66okMw83CBfjZ2glpKaYlBGIm/5Y/fq0EoYkmgaPgQVrI/15
	u04wQNYbaJfU5mbqVzqUUFbQkTsaNlL/CDl8=
X-Google-Smtp-Source: AGHT+IGFxAtnrbTQocowjs4JXWVwByQYEpS+I7/eKJdywaxZs5ROgYE8u1N4ZPm2OK5E42RlIP2VC18YQseXJzpA6lA=
X-Received: by 2002:a5d:6dac:0:b0:343:ded0:1f94 with SMTP id
 u12-20020a5d6dac000000b00343ded01f94mr701290wrs.37.1712274680392; Thu, 04 Apr
 2024 16:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho> <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho> <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch>
In-Reply-To: <660f22c56a0a2_442282088b@john.notmuch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 4 Apr 2024 16:50:43 -0700
Message-ID: <CAKgT0UcDrNfNsNDvOmi06eww0O13304vEm4JzLxCKR6L_M_GXw@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:59=E2=80=AFPM John Fastabend <john.fastabend@gmail=
.com> wrote:
>
> Jakub Kicinski wrote:
> > On Thu, 4 Apr 2024 12:22:02 -0700 Alexander Duyck wrote:
> > > I don't understand that as we are
> > > contributing across multiple areas in the kernel including networking
> > > and ebpf. Is Meta expected to start pulling time from our upstream
> > > maintainers to have them update out-of-tree kernel modules since the
> > > community isn't willing to let us maintain it in the kernel? Is the
> > > message that the kernel is expected to get value from Meta, but that
> > > value is not meant to be reciprocated? Would you really rather have
> > > us start maintaining our own internal kernel with our own
> > > "proprietary goodness", and ask other NIC vendors to have to maintain
> > > their drivers against yet another kernel if they want to be used in
> > > our data centers?
> >
> > Please allow the community to make rational choices in the interest of
> > the project and more importantly the interest of its broader user base.
> >
> > Google would also claim "good faith" -- undoubtedly is supports
> > the kernel, and lets some of its best engineers contribute.
> > Did that make them stop trying to build Fuchsia? The "good faith" of
> > companies operates with the limits of margin of error of they consider
> > rational and beneficial.
> >
> > I don't want to put my thumb on the scale (yet?), but (with my
> > maintainer hat on) please don't use the "Meta is good" argument, becaus=
e
> > someone will send a similar driver from a less involved company later o=
n
> > and we'll be accused of playing favorites :( Plus companies can change
> > their approach to open source from "inclusive" to "extractive"
> > (to borrow the economic terminology) rather quickly.
> >
>
> I'll throw my $.02 in. In this case you have a driver that I only scanned
> so far, but looks well done. Alex has written lots of drivers I trust he
> will not just abondon it. And if it does end up abondoned and no one
> supports it at some future point we can deprecate it same as any other
> driver in the networking tree. All the feedback is being answered and
> debate is happening so I expect will get a v2, v3 or so. All good signs
> in my point.
>
> Back to your point about faith in a company. I don't think we even need
> to care about whatever companies business plans. The author could have
> submitted with their personal address for what its worth and called it
> drivers/alexware/duyck.o Bit extreme and I would have called him on it,
> but hopefully the point is clear.
>
> We have lots of drivers in the tree that are hard to physically get ahold
> of. Or otherwise gated by paying some vendor for compute time, etc. to
> use. We even have some drivers where the hardware itself never made
> it out into the wild or only a single customer used it before sellers
> burned it for commercial reasons or hw wasn't workable, team was cut, etc=
.
>
> I can't see how if I have a physical NIC for it on my desk here makes
> much difference one way or the other.

The advantage of Meta not selling it publicly at this time is that
Meta is both the consumer and the maintainer so if a kernel API change
broke something Meta would be responsible for fixing it. It would be
Meta's own interest to maintain the part, and if it breaks Meta would
be the only one impacted assuming the breaking change at least builds.
So rather than "good faith", maybe I should have said "motivated self
interest".

It seems like the worst case scenario would actually be some
commercial product being sold. Worse yet, one with proprietary bits
such as firmware on the device. Should commercial vendors be required
to provide some sort of documentation proving they are dedicated to
their product and financially stable enough to maintain it for the
entire product life cycle? What if the vendor sells some significant
number of units to Linux users out there, and then either goes under,
gets acquired, and/or just decides to go in a new direction. In that
scenario we have the driver unmaintained and consumers impacted, but
the company responsible for it has no motivation to address it other
than maybe negative PR.

> The alternative is much worse someone builds a team of engineers locks
> them up they build some interesting pieces and we never get to see it
> because we tried to block someone from opensourcing their driver?
> Eventually they need some kernel changes and than we block those too
> because we didn't allow the driver that was the use case? This seems
> wrong to me.
>
> Anyways we have zero ways to enforce such a policy. Have vendors
> ship a NIC to somebody with the v0 of the patch set? Attach a picture?
> Even if vendor X claims they will have a product in N months and
> than only sells it to qualified customers what to do we do then.
> Driver author could even believe the hardware will be available
> when they post the driver, but business may change out of hands
> of the developer.

This is what I was referring to as being "arbitrary and capricious".
The issue is what would we define as a NIC being for sale
commercially. Do we have to support a certain form factor, sell it for
a certain price, or sell a certain quantity?

If anything maybe we should look more at something like a blast radius
in terms of inclusion. If this were to go wrong, how could it go wrong
and who would be impacted.

> I'm 100% on letting this through assuming Alex is on top of feedback
> and the code is good. I think any other policy would be very ugly
> to enforce, prove, and even understand. Obviously code and architecture
> debates I'm all for. Ensuring we have a trusted, experienced person
> signed up to review code, address feedback, fix whatever syzbot finds
> and so on is also a must I think. I'm sure Alex will take care of
> it.
>
> Thanks,
> John

Thanks for your reply. I had started a reply, but you probably worded
this better than I could have.

Thanks

- Alex

