Return-Path: <linux-pci+bounces-5821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B589ABE5
	for <lists+linux-pci@lfdr.de>; Sat,  6 Apr 2024 18:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59818B20B93
	for <lists+linux-pci@lfdr.de>; Sat,  6 Apr 2024 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040A03BBDE;
	Sat,  6 Apr 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldwEta1/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EFC3BB27;
	Sat,  6 Apr 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419541; cv=none; b=lHVMmh9pMlNQ/1o8op92QQaljKPQHaNpI69Thl2cpB9NTefUW0JDT1rO7fvR0wh+2kOdHOpvUBsY86NDdBj+ZXFlagG9E4Bb78/LMejvevrumChClW6L1D4xC5REiLMsEzx7PC9CweH49HYC90pafdEG9Tzvtm6GbCv0eJwBsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419541; c=relaxed/simple;
	bh=CBwzvXlwE/04S64iG57gVVhRBVD7dFZIWBG8rhN+KXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gn5ZhrHgbPtilsp4Alh5Qmo0ahVMdj6E+8JO583EC1I3/d5L4HmEpsDSbeWO9mx7TCJnYY3HyziVYsb9zFWop0zj2nFidZ0C6X1o86a5tkI1xXshS7fIChVN/SoTun6GXDmVrvB+H3z7wyqJOVU62u11hLA4DCwpYiKta4KRYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldwEta1/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34388753650so1360395f8f.3;
        Sat, 06 Apr 2024 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712419538; x=1713024338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBwzvXlwE/04S64iG57gVVhRBVD7dFZIWBG8rhN+KXU=;
        b=ldwEta1/Gg1L1OFZ+EZDZ52928ov0Nn2xmOSJc8E/k7AiOvq1Af6dOwwFxhCZGbW9q
         hK4iYm2nHQOV/Qq3WE0tUyLOsZPZGp5h8ghdkVjyH/mOtu3UiGo7PVLYUSOvpGdr/xnU
         TBL5WMKQEJJ1zqBG+GmFGOUPqyCC7bWHvLpT1E6IMZJU/5BmoKfw8L2QJgpgDPfUATOx
         rXrufvsio2cH8bscdsSd2FG+GvXXolGQYgic4mtWWCRSthIk4UrzSXGw23GFeR3ylJyc
         Nt8VcEiIyIu3Z8YHJiqXJ8bd6ykbsoFn7GYsex7xFte5UaBxlC6HLyHZX7sbe0631o+s
         8MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712419538; x=1713024338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBwzvXlwE/04S64iG57gVVhRBVD7dFZIWBG8rhN+KXU=;
        b=QM8pVXBrLiVrI+nC2xdQ4D3D5gRVp+UWFgP9PSdM3V8DjO2m8Y4kfm6nczlvf6aRIp
         tQBCBhtSR21CdAu88jkcoY1n+Zoy3SEgd8mE4IIojkw1NG7O8mM2PPYObVJpQlXKjV3J
         Oawwk1gzK+QAwhOHNI7UExJSJcQdiScbI7ENz8x93JlQ1LwNMhdO9FxfoEVi4ZqeeQ0g
         vwhkjwhCrpK1kwijoPqDm1qlXVruUiMQDs3UbwlofJ8Wy31Nk2LHukHE4D2Cq+NLq3OG
         K3hGoLj2ROedy4l7yHJVqWwPb8bwx1c9LmrIl+nh3OXoWrvyPEDgYFD3CFuU1MmnAwun
         /vPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvMc5BN6Kcd+crAAwbzAnLbo8yyhWq2DsqwVsKZAzKocFd6jGuDispU98iUk1nZHpYFhsgxVwu4L5DNKPS/oSWVEcAP7EYGFuyB8wL0+pT3bWTmYvzZvFmfbeqiP2bKVu1
X-Gm-Message-State: AOJu0Yzizx79V+k5fBLeUsWNs76jyK1tmxCCoEYgQCNOn+FvZvUM57Vd
	ItBvgH29Qow3PZzql8gsCpTZtGBNnCyOdMCnKD5/u31Y5o2HAXTB/gFNoN3Zp37zQtKsEXPqpa1
	lnrCuZ5NqE2LjdhwsQo27qJAQygY=
X-Google-Smtp-Source: AGHT+IEPFj1U6qjrPKXNRfrFpeucL6owxOcmahMkByTWw2/6GWgY0+9prl1Q6hCmeJt3W57QXObLWYmT0vk2JAflBlw=
X-Received: by 2002:adf:fd91:0:b0:343:6b0c:7553 with SMTP id
 d17-20020adffd91000000b003436b0c7553mr2893888wrr.55.1712419538113; Sat, 06
 Apr 2024 09:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org> <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com> <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com> <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <20240405190209.GJ5383@nvidia.com>
In-Reply-To: <20240405190209.GJ5383@nvidia.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 6 Apr 2024 09:05:01 -0700
Message-ID: <CAKgT0UdZz3fKpkTRnq5ZO2nW3NQcQ_DWahHMyddODjmNDLSaZQ@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 12:02=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Apr 05, 2024 at 11:38:25AM -0700, Alexander Duyck wrote:
>
> > > In my hypothetical you'd need to do something like open source Meta's
> > > implementation of the AI networking that the DMABUF patches enable,
> > > and even then since nobody could run it at performance the thing is
> > > pretty questionable.
> > >
> > > IMHO publishing a qemu chip emulator would not advance the open sourc=
e
> > > ecosystem around building a DMABUF AI networking scheme.
> >
> > Well not too many will be able to afford getting the types of systems
> > and hardware needed for this in the first place. Primarily just your
> > large data center companies can afford it.
> >
> > I never said this hardware is about enabling DMABUF.
>
> I presented a hypothetical to be able to illustrate a scenario where
> this driver should not be used to justify invasive core kernel
> changes.
>
> I have no idea what future things you have in mind, or if any will
> reach a threshold where I would expect they should not be
> included. You where the one saying a key reason you wanted this driver
> was to push core changes and you said you imagine changes that are
> unique to fbnic that "others might like to follow".
>
> I'm being very clear to say that there are some core changes should
> not be accepted due to the kernel's open source ideology.

Okay, on core changes I 100% agree. That is one of the reasons why we
have the whole thing about any feature really needing to be enabled on
at least 2 different vendor devices.

> > Right, nouveau is fully open source. That is what I am trying to do
> > with fbnic. That is what I am getting at. This isn't connecting to
> > some proprietary stack or engaging in any sort of bypass.
>
> The basic driver presented here is not, a future driver that justifies
> unknown changes to the core may be.
>
> This is why my message was pretty clear. IMHO there is nothing wrong
> with this series, but I do not expect you will get everything you want
> in future due to this issue.
>
> I said decide if you want to continue. I'm not NAKing anything on this
> series.

My apologies. I had interpreted your statement as essentially agreeing
with Jiri and NAKing the patches simply for not being commercially
available.

> > I'm trying to say that both those projects are essentially doing the
> > same thing you are accusing fbnic of doing,
>
> Not even close. Both those projects support open source ecosystems,
> have wide cross vendor participating. fbnic isn't even going to be
> enabled in any distribution.

I can't say for certain if that will be the case going forward or not.
I know we haven't reached out to any distros and currently don't need
to. With that said though, having the driver available as a module
shouldn't cause any harm either so I don't really have a strong
opinion about it either way.

Seeing as how we arne't in the NIC business I am not sure how
restrictive we would be about licensing out the IP. I could see Meta
potentially trying to open up the specs just to take the manufacturing
burden off of us and enable more competition, though I am on the
engineering side and not so much sourcing so I am just speculating.

> > > You have an unavailable NIC, so we know it is only ever operated with
> > > Meta's proprietary kernel fork, supporting Meta's proprietary
> > > userspace software. Where exactly is the open source?
> >
> > It depends on your definition of "unavailable". I could argue that for
> > many most of the Mellanox NICs are also have limited availability as
> > they aren't exactly easy to get a hold of without paying a hefty
> > ransom.
>
> And GNIC's that run Mina's series are completely unavailable right
> now. That is still a big different from a temporary issue to a
> permanent structural intention of the manufacturer.

I'm assuming it is some sort of firmware functionality that is needed
to enable it? One thing with our design is that the firmware actually
has minimal functionality. Basically it is the liaison between the
BMC, Host, and the MAC. Otherwise it has no role to play in the
control path so when the driver is loaded it is running the show.

> > > Why should someone working to improve only their proprietary
> > > environment be welcomed in the same way as someone working to improve
> > > the open source ecosystem? That has never been the kernel communities
> > > position.
> >
> > To quote Linus `I do not see open source as some big goody-goody
> > "let's all sing kumbaya around the campfire and make the world a
> > better place". No, open source only really works if everybody is
> > contributing for their own selfish reasons.`[1]
>
> I think that stance has evolved and the consensus position toward uapi
> is stronger.

I assume you are talking about the need to have an open source
consumer for any exposed uapi? That makes sense from the test and
development standpoint as you need to have some way to exercise and
test any interface that is available in the kernel.

> > different. Given enough time it is likely this will end up in the
> > hands of those outside Meta anyway, at that point the argument would
> > be moot.
>
> Oh, I'm skeptical about that.

I didn't say how widely or when. I got my introduction to Linux by
buying used server systems and trying to get something maintainable in
terms of OS on them. From my experience you end up with all sorts of
odd-ball proprietary parts that eventually end up leaking out to the
public. Though back then it was more likely to be a proprietary spin
of some known silicon with a few tweaks that had to be accounted for.

> You seem to have taken my original email in a strange direction. I
> said this series was fine but cautioned that if you proceed you should
> be expecting an eventual feature rejection for idological reasons, and
> gave a hypothetical example what that would look like.
>
> If you want to continue or not is up to Meta, in my view.
>
> Jason

Yeah, I think I had misunderstood your original comment as being in
support of Jiri's position. I hadn't fully grokked that you were doing
more of a "yes, but" versus an "yes, and".

For this driver I don't see there being too much in the way of
complications as there shouldn't be much in the way of any sort of
kernel-bypass that would be applicable to this driver uniquely.

Thanks,

- Alex

