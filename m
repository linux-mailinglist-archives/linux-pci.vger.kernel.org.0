Return-Path: <linux-pci+bounces-5958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A989E071
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 18:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2521F229EB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B04714EC55;
	Tue,  9 Apr 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPhJdsli"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC79314E2FA;
	Tue,  9 Apr 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680307; cv=none; b=bqglP1Txf7jt3X9mnaiq8CFEz0cs418PCPgwG/x1sjwmojg1m8PaX0m/eusBV3bNDaviGpFqno8g0CYNmcuXlc7xhntt6QAPrg2wy2VffxH9S19ZDkXmbJ2dFIExdG+9HYrDRIITBVYVXwt4aDsJSiZkgBIq/DqYHvyNpiz32uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680307; c=relaxed/simple;
	bh=4+5+t9ivZThSeoTjClZN1zIyssiggPgMe259i9/bH6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTtzhADHJYDC2pzOxAzVKZ1JdPmOnKs+9aFtjo5JCyV+G8ytOOZJLQMl9SpIrX9wJPlT6Zhkqn9lr7TnTUVI/q5FMxj98M6sylDiWuOydmDhfx7TXMLiXeRJOhpZtThFpVmTrU0dVgGhRSdVvJk5dZKtpXKyOGXw8zFqWwpinP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPhJdsli; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-415515178ceso37808915e9.0;
        Tue, 09 Apr 2024 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712680304; x=1713285104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gCQfMJnF5/zaFvkv148A9uprhljB7Ds6cmqVUuQOMk=;
        b=NPhJdsli81ZJh2Yhr9lCq2Qrw3cP4kb1b4UK5xk5q7tP3skpODZsaiVoYFMAcCYNTg
         jgM1LTK6BH6FOWdkS/qmeNkcPap0vPnb0weo/clijbSfzuitRwaBcAin9QcT9FrkYqKQ
         lXULm17uWQkEWM/4EADK01SBB9CXtKhEpV/hp/sL9XpPY5s5YF85r0Jnvb3IwTgWNG7t
         7lBV/g98HHtP3TQGxUDqkV6+DY8Hdwt8ZrHvN3v8WOcYIuIR/rkuHhgdJMx6UnN8povE
         D8DHDbbfAnQUAI7DyBaT0bkJxWMlIqvjA+ji22CK2NwhwS9ETx8hPkpP7tlL4TBoZ5m6
         EZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680304; x=1713285104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gCQfMJnF5/zaFvkv148A9uprhljB7Ds6cmqVUuQOMk=;
        b=J/PseOLPQTcvlXG4Mrn8L5I9Lg4Sg/36rLc/Wnp2NhmbnyWnpJl6MWFR1yL25vQ6gf
         Oa3y0OKHKA7mT1LY8rimCcDeDyLU+6rLvTQqxg2a6xJ8zOK7KXb4i1i1+tW/OcV5DtFN
         BpovmNcNzIaRPc9nwlv7JB+kz9DbWj9zKN+KgBwxZ0SfEkwmydMRSqqHMPNv82UXbczB
         1rIZq+J5q9BOBdrejRl2hY3rnfyJibxrbGIun3YSPysSabsmkzrBYx/fHiK0ZOEkM/JX
         fPBu3QmaJ+r88qNjP75xa+bdrxyFhyfoBXBEt06WR8qN1SL51t607VoeDIrdOLVc8zKY
         ztEA==
X-Forwarded-Encrypted: i=1; AJvYcCURTprlNDOkntJWooj6BSVLGrlqRve2Fz78lrJOv0uS3fROp50AQvDRUOx7y0r65g3/GeYnINogTeyu2eLSlJ0xnwMDQh9NU/Izwk7pslkcz7RqHeJVAwxSHqfeQiiQKMJ7
X-Gm-Message-State: AOJu0Yz03ymNffWGuPZWEtI9endWTsTaCfESR82Kw1rGIGPRMU3OHAzr
	/NBfuejRfoz8d/m4zsmpp2CIE0I3jnS/S3V/BrhjxlJCr7YFsUe/dxWwY4F8Fv1w+pjyI3oycb4
	LNAiz3l6T56uPgqt5Bl/4VFk7psY=
X-Google-Smtp-Source: AGHT+IH3ZMJs8B8V2n9l9tJX0XL9K3/OdZubIcGN8oNrV+TqdQ05Qu2wsK4v0rCz6IACPnEde/F2qOCL8j33X8ZxaA4=
X-Received: by 2002:a5d:6d85:0:b0:33e:48f9:169d with SMTP id
 l5-20020a5d6d85000000b0033e48f9169dmr194224wrs.31.1712680303633; Tue, 09 Apr
 2024 09:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404165000.47ce17e6@kernel.org> <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <20240404193817.500523aa@kernel.org> <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
 <20240408061846.GA8764@unreal> <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal> <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
 <20240409081856.GC4195@unreal> <CAKgT0UewAZSqU6JF4-cPf7hZM41n_QMuiF_K8SY8hyoROQLgfQ@mail.gmail.com>
 <20240409153932.GY5383@nvidia.com>
In-Reply-To: <20240409153932.GY5383@nvidia.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 9 Apr 2024 09:31:06 -0700
Message-ID: <CAKgT0UeSNxbq3JYe8oNaoWYWSn9+vd1c+AfjvUsietUtS09r0g@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 8:39=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Tue, Apr 09, 2024 at 07:43:07AM -0700, Alexander Duyck wrote:
>
> > I see. So this is what you were referencing. Arguably I can see both
> > sides of the issue. Ideally what should have been presented would have
> > been the root cause of why the diff
>
> Uh, that almost never happens in the kernel world. Someone does a
> great favour to us all to test rc kernels and finds bugs. The

Thus why I mentioned "Ideally". Most often that cannot be the case due
to various reasons. However, that said that would have been the Ideal
solution, not the practical one.

> expectation is generally things like:
>
>  - The bug is fixed immediately because the issue is obvious to the
>    author
>  - Iteration and rapid progress is seen toward enlightening the author
>  - The patch is reverted, often rapidly, try again later with a good
>    patch

When working on a development branch that shouldn't be the
expectation. I suspect that is why the revert was pushed back on
initially. The developer wanted a chance to try to debug and resolve
the issue with root cause.

Honestly what I probably would have proposed was a build flag that
would have allowed the code to stay but be disabled with a "Broken"
label to allow both developers to work on their own thing. Then if
people complained about the RFC non-compliance issue, but didn't care
about the Vagrant setup they could have just turned it on to test and
verify it fixed their issue and get additional testing. However I
assume that would have introduced additional maintenance overhead.

> Unsophisticated reporters should not experience regressions,
> period. Unsophisticated reporters shuld not be expected to debug
> things on their own (though it sure is nice if they can!). We really
> like it and appreciate it if reporters can run experiments!

Unsophisticated reporters/users shouldn't be running net-next. If this
has made it to or is about to go into Linus's tree then I would agree
the regression needs to be resolved ASAP as that stuff shouldn't exist
past rc1 at the latest.

> In this particular instance there was some resistance getting to a fix
> quickly. I think a revert for something like this that could not be
> immediately fixed is the correct thing, especially when it effects
> significant work within the community. It gives the submitter time to
> find out how to solve the regression.
>
> That there is now so much ongoing bad blood over such an ordinary
> matter is what is really distressing here.

Well much of it has to do with the fact that this is supposed to be a
community. Generally I help you, you help me and together we both make
progress. So within the community people tend to build up what we
could call karma. Generally I think some of the messages sent seemed
to make it come across that the Mellanox/Nvidia folks felt it "wasn't
their problem" so they elicited a bit of frustration from the other
maintainers and built up some negative karma.

As I had mentioned in the case of the e1000e NVRAM corruption. It
wasn't an Intel issue that caused the problem but Intel had to jump in
to address it until they found the root cause that was function
tracing. Unfortunately one thing that tends to happen with upstream is
that we get asked to do things that aren't directly related to the
project we are working on. We saw that at Intel quite often. I
referred to it at one point as the "you stepped in it, you own it"
phenomenon where if we even brushed against block of upstream code
that wasn't being well maintained we would be asked to fix it up and
address existing issues before we could upstream any patches.

> I think Leon's point is broadly that those on the "vendor" side seem
> to often be accused of being a "bad vendor". I couldn't help but
> notice the language from Meta on this thread seemed to place Meta
> outside of being a vendor, despite having always very much been doing
> typical vendor activities like downstream forks, proprietary userspace
> and now drivers for their own devices.

I wouldn't disagree that we are doing "vendor" things. Up until about
4 years ago I was on the "vendor" side at Intel. One difference is
that Meta is also the "consumer". So if I report an issue it is me
complaining about something as a sophisticated user instead of a
unsophisticated one. So hopefully we have gone though and done some
triage to at least bisect it down to a patch and are willing to work
with the community as you guys did. If we can work with the other
maintainers to enable them to debug and root cause the issue then even
better. The revert is normally the weapon of last resort to be broken
out before the merge window opens, or if an issue is caught in Linus's
tree.

> In my view the vendor/!vendor distinction is really toxic and should
> stop.

I agree. However that was essentially what started all this when Jiri
pointed out that we weren't selling the NIC to anyone else. That made
this all about vendor vs !vendor, and his suggestion of just giving
the NICs away isn't exactly practical. At least not an any sort of
large scale. Maybe we should start coming up with a new term for the
!vendor case. How about "prosumer", as in "producer" and "consumer"?

