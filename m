Return-Path: <linux-pci+bounces-5751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B320C8990A3
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 23:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177A0288BFC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D27F13AD22;
	Thu,  4 Apr 2024 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNWNQPHj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BE12D1EF;
	Thu,  4 Apr 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712267977; cv=none; b=rK/FJktN4NWUG9f+VO1NjwXhAHXUBoC+tjonoo0D9oT3lV+01QOO/bdk6pxSt1uRrKYPsUFFNw6YpsF2jKaJCnvvRu6DfmVQsR0ASF4cVQbHlHwoIiklVCE2CwKog6VJsWSrVu0jYVTJ45tnwtCi1AXwp71icL2gHr90WSF/kn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712267977; c=relaxed/simple;
	bh=sX9uoGi43CCPt+PhgNoq1Pq6O7XF0XaBCfZQ7zRFB7Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZaHwU2jfqR1/rZZRJ68jSp3zKECnexO99tCiZOZVNWyGUofMXhRfuTcP0l5HbYI5szPr8bDpVMQO69ShIcRr9ncWIwYeKZ4f25UZuFh4fsAU7z4AxPiLh87Mo6LYvlMSMiMguczvd6XteNVwdgbWrCWHy2YUPzfHLX0qlPFPD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNWNQPHj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecf3f001c5so884972b3a.1;
        Thu, 04 Apr 2024 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712267975; x=1712872775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrkGHjiHmUY/gKDbNB9chzEuUYm95/thM+vcpjSq034=;
        b=kNWNQPHjzyiqL6K9Ga5lqU1DdLzNgYgJgH06yqDCxRH5nfsBgXu9HPHhBV0Z+vlkGU
         3mtTAzmVy7bK6lmg0LjwZfQLwnZ8phYF1d2fd9FiOoDEeS3iSCswavdmMklTGDUoOVLc
         stsbUN+OQvU3d8y4oqtC5j7x8rlapXVeFNtVH/QNMFzTeVMR7B41bLUD0aeCsfZC7/Be
         mHdBeGmTPPTlpBVi8iEJ6E6u3wiBT+qU9Bi+Amtvws3S9jb2p2CEUdJ/CA9gzvjfgWGM
         wEDDaXY3zMHjLF+6VLaVzUO3lnLWvHa5pxlQmAi7yPfP65MDLRpNyo8FuAs6+t/WheuZ
         LKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712267975; x=1712872775;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CrkGHjiHmUY/gKDbNB9chzEuUYm95/thM+vcpjSq034=;
        b=A30+M6niIR8A8C/2xdwesf8CYiNfvuqMkYHSnS+r+3wPZlEY2NCK+RFMHY+6MKdSOf
         +XPSO9OJBphhAM4rqY/S+xgKjOJ2S8bpjZIUM6bgFBZntRhtvU9488155C18L0W8Tl2A
         iah6uU2FYKT5H3Aupj8thqVl/OTmzVous07sc7ZtcwDCe3I50USvQMU3hfxku+au9LwU
         8HP0zJJbInFxaJooYt+Kqk1385+9AZ+5X6qCJyrwW2D4zkHvUTiUV3YrM0ca61YYrevb
         pax4bLszjBTKcJrdmH8SiGBbbVkYlnnrSpCw6DkG5Fr3E8lSxu56Ur5f2uAQVerr/Ieq
         VjnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOjblL9Myjl6nksJEB3b+Tu/9g6L1p3v7ExOPW2w0IABJAUh2ilO84WwxjBw+CRSMjLw+6QlVLaUjI36IDa8Wq1g7QFEz/eOm0mjnOZcdVVPvv/QwrdrLOYC0y5zkC1ro7
X-Gm-Message-State: AOJu0YxU/Kk6YqoBSsfJn1baZhgm0KMUfzEiyTs7/xeDjqYSoo65eKMQ
	FBAQQLK9avJB45bTDnWF+//SJVW89RotlKlrMHb55t6Xk+t3A24n
X-Google-Smtp-Source: AGHT+IF54ZsQXQgdenyf/wtK819T3em8CVKGK5ZCgoJpT6TnudRX0bdsIEHuqU2V4rf1WJUlrtt3sQ==
X-Received: by 2002:a05:6a21:2783:b0:1a7:2d38:85b with SMTP id rn3-20020a056a21278300b001a72d38085bmr3585426pzb.53.1712267974764;
        Thu, 04 Apr 2024 14:59:34 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id i14-20020aa78b4e000000b006ecfd012e03sm134364pfd.90.2024.04.04.14.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 14:59:34 -0700 (PDT)
Date: Thu, 04 Apr 2024 14:59:33 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, 
 netdev@vger.kernel.org, 
 bhelgaas@google.com, 
 linux-pci@vger.kernel.org, 
 Alexander Duyck <alexanderduyck@fb.com>, 
 davem@davemloft.net, 
 pabeni@redhat.com
Message-ID: <660f22c56a0a2_442282088b@john.notmuch>
In-Reply-To: <20240404132548.3229f6c8@kernel.org>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 4 Apr 2024 12:22:02 -0700 Alexander Duyck wrote:
> > The argument itself doesn't really hold water. The fact is the Meta
> > data centers are not an insignificant consumer of Linux, 
> 
> customer or beneficiary ?
> 
> > so it isn't as if the driver isn't going to be used. This implies
> > some lack of good faith from Meta.
> 
> "Good faith" is not a sufficient foundation for a community consisting
> of volunteers, and commercial entities (with the xz debacle maybe even
> less today than it was a month ago). As a maintainer I really don't want
> to be in position of judging the "good faith" of corporate actors.
> 
> > I don't understand that as we are
> > contributing across multiple areas in the kernel including networking
> > and ebpf. Is Meta expected to start pulling time from our upstream
> > maintainers to have them update out-of-tree kernel modules since the
> > community isn't willing to let us maintain it in the kernel? Is the
> > message that the kernel is expected to get value from Meta, but that
> > value is not meant to be reciprocated? Would you really rather have
> > us start maintaining our own internal kernel with our own
> > "proprietary goodness", and ask other NIC vendors to have to maintain
> > their drivers against yet another kernel if they want to be used in
> > our data centers?
> 
> Please allow the community to make rational choices in the interest of
> the project and more importantly the interest of its broader user base.
> 
> Google would also claim "good faith" -- undoubtedly is supports 
> the kernel, and lets some of its best engineers contribute.
> Did that make them stop trying to build Fuchsia? The "good faith" of
> companies operates with the limits of margin of error of they consider
> rational and beneficial.
> 
> I don't want to put my thumb on the scale (yet?), but (with my
> maintainer hat on) please don't use the "Meta is good" argument, because
> someone will send a similar driver from a less involved company later on
> and we'll be accused of playing favorites :( Plus companies can change
> their approach to open source from "inclusive" to "extractive" 
> (to borrow the economic terminology) rather quickly.
> 

I'll throw my $.02 in. In this case you have a driver that I only scanned
so far, but looks well done. Alex has written lots of drivers I trust he
will not just abondon it. And if it does end up abondoned and no one
supports it at some future point we can deprecate it same as any other
driver in the networking tree. All the feedback is being answered and
debate is happening so I expect will get a v2, v3 or so. All good signs
in my point.

Back to your point about faith in a company. I don't think we even need
to care about whatever companies business plans. The author could have
submitted with their personal address for what its worth and called it
drivers/alexware/duyck.o Bit extreme and I would have called him on it,
but hopefully the point is clear.

We have lots of drivers in the tree that are hard to physically get ahold
of. Or otherwise gated by paying some vendor for compute time, etc. to
use. We even have some drivers where the hardware itself never made
it out into the wild or only a single customer used it before sellers 
burned it for commercial reasons or hw wasn't workable, team was cut, etc.

I can't see how if I have a physical NIC for it on my desk here makes
much difference one way or the other.

The alternative is much worse someone builds a team of engineers locks
them up they build some interesting pieces and we never get to see it
because we tried to block someone from opensourcing their driver?
Eventually they need some kernel changes and than we block those too
because we didn't allow the driver that was the use case? This seems
wrong to me.

Anyways we have zero ways to enforce such a policy. Have vendors
ship a NIC to somebody with the v0 of the patch set? Attach a picture? 
Even if vendor X claims they will have a product in N months and
than only sells it to qualified customers what to do we do then.
Driver author could even believe the hardware will be available
when they post the driver, but business may change out of hands
of the developer.

I'm 100% on letting this through assuming Alex is on top of feedback
and the code is good. I think any other policy would be very ugly
to enforce, prove, and even understand. Obviously code and architecture
debates I'm all for. Ensuring we have a trusted, experienced person
signed up to review code, address feedback, fix whatever syzbot finds
and so on is also a must I think. I'm sure Alex will take care of
it.

Thanks,
John

