Return-Path: <linux-pci+bounces-5891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2FC89CAD4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602671C219BD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD3D142915;
	Mon,  8 Apr 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYBpueSU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04747460;
	Mon,  8 Apr 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597583; cv=none; b=sFw2Rud+5fSAzmlDJ16pErDcNkiLh1805Uly9h/ALtBbpi//iEOOJWvEEX5tyR322zJuhqOvye/rHquGxMjXIXLRzydhEsObFImm8Ips93YhfF95z6lYEMiw9GVuBdoaAyb91OcfikeMYF8g9kx2YL88W+hYM+br/uSNLbjLv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597583; c=relaxed/simple;
	bh=VujkYUwZHpelKAzf22YulKQS5Zq2tILK4od2AbVneOA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CUHqk/oYu8+TK1kLfISUZbDO8Kg82xCt7E3Yqr+iCW49zwpfvaAfNsqsJisqDvKNMxr5FFlJpqtHMiaQGgoRIO8t7CeN2ykonCuBrnC1ssmqzSQcZViiZ8cDYXRd7EqhA74+JjJCzAGmVB7YHxbinCN7UOKsTJM3rFEBZjxea3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYBpueSU; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5aa4a1246b1so477034eaf.3;
        Mon, 08 Apr 2024 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712597581; x=1713202381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VujkYUwZHpelKAzf22YulKQS5Zq2tILK4od2AbVneOA=;
        b=IYBpueSUcxnb1mXq/Sr8NKHu9mMhIOtNWRYh/HggUhvEYL/6xgCyw00uK1972r1OOL
         H1JJUvjMvQSPNMZyT3CKMpfflBzQqki4SOYH4tx0ZfbTbGJygIb37seauKrwQ7dBqMZp
         EpUGdjVwXaBjj/hjwUfrcj17j0fly6u/QlOkADgdPhx6WARb+tKNwp6h/vY/FJRwKSK0
         h4EwB2uJv7ySCsHCDtXgLA2r6j1MH43ZD9PPER4EyIWYvBR5hjMxD50oRACdW+S5bATs
         7a8H6b3KEUqL/1RkOq9FthE+3A4foIL1cscclp9t1KUhpzPw02RrhsqrZ0fkAeyJXZx/
         y0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597581; x=1713202381;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VujkYUwZHpelKAzf22YulKQS5Zq2tILK4od2AbVneOA=;
        b=PJG9xD3mIKl7ABaB0Rm++wCnHEwVIEQ5yEnCWCNc1/HSSTwAS6aiPJSKm9TA9rTtxy
         uUnfyr5i+M3gyAmmuLC3h5lM+MsrNwFcMaZnelPL+Q/3GsZTIOF2IQc5yHjeFYoltURC
         X3qBzTZ+o2v0mUsYIIlbKbPfQEHSPvmv9iFzQ+iOsuuF3jsTCveWpuu72ix1yIqXcuYF
         UUP+XYw0ddKOPh6ai5lex5eWRjK2mzlM7oxuAw3zcrWTry2KDdolzyZcYhXF/H6UCULL
         F0sRiXXBI1SRlnQzfuF23nbFSySSQBK8vJS4msZJ8EtKEUCIVt9qGRwhnM/fel2ELLxQ
         Bb4w==
X-Forwarded-Encrypted: i=1; AJvYcCVUysW5QW08IuA1bSJPfY+L9rFdv6BoPR+o1wn51RzxMCY43XAC7mWcjN3IVb4HkFG5zEAdYEzHe+TM+w+hA0UKm9K3rXEiKb5Fj8ehlZ0HwfHq6A8zOtrvyy0JXDfLSe5c
X-Gm-Message-State: AOJu0Yx2A8o5jsnhHW0EhACJ4opfBXF18gtwIglGYqZY6qEz+bXD3QqO
	QV0sxrMuQ0dcgEDidZ29B5C7exGf4G03wnjg9L5n5E7CmKJ1hshE
X-Google-Smtp-Source: AGHT+IFZUnzosi0Jh/kv5bkOmZ9pVxZp+Z5kqClLfw+UB59ZN2xaJPVHv3imFmyZk/avzOzUqBUlCw==
X-Received: by 2002:a05:6358:3912:b0:17f:565c:8db2 with SMTP id y18-20020a056358391200b0017f565c8db2mr14649654rwd.12.1712597580586;
        Mon, 08 Apr 2024 10:33:00 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id e7-20020a63aa07000000b005f09e966e8asm6638300pgf.60.2024.04.08.10.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:33:00 -0700 (PDT)
Date: Mon, 08 Apr 2024 10:32:59 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>, 
 Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 netdev@vger.kernel.org, 
 bhelgaas@google.com, 
 linux-pci@vger.kernel.org, 
 Alexander Duyck <alexanderduyck@fb.com>, 
 davem@davemloft.net, 
 Christoph Hellwig <hch@lst.de>
Message-ID: <66142a4b402d5_2cb7208ec@john.notmuch>
In-Reply-To: <ZhQgmrH-QGu6HP-k@nanopsycho>
References: <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
 <ZhQgmrH-QGu6HP-k@nanopsycho>
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
Content-Transfer-Encoding: quoted-printable

Jiri Pirko wrote:
> Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
> >On Mon, Apr 8, 2024 at 4:51=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >>
> >> Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrot=
e:
> >> >On Fri, Apr 5, 2024 at 8:17=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.=
com> wrote:
> >> >>
> >> >> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
> >> >> > > Alex already indicated new features are coming, changes to th=
e core
> >> >> > > code will be proposed. How should those be evaluated? Hypothe=
tically
> >> >> > > should fbnic be allowed to be the first implementation of som=
ething
> >> >> > > invasive like Mina's DMABUF work? Google published an open us=
erspace
> >> >> > > for NCCL that people can (in theory at least) actually run. M=
eta would
> >> >> > > not be able to do that. I would say that clearly crosses the =
line and
> >> >> > > should not be accepted.
> >> >> >
> >> >> > Why not? Just because we are not commercially selling it doesn'=
t mean
> >> >> > we couldn't look at other solutions such as QEMU. If we were to=

> >> >> > provide a github repo with an emulation of the NIC would that b=
e
> >> >> > enough to satisfy the "commercial" requirement?
> >> >>
> >> >> My test is not "commercial", it is enabling open source ecosystem=
 vs
> >> >> benefiting only proprietary software.
> >> >
> >> >Sorry, that was where this started where Jiri was stating that we h=
ad
> >> >to be selling this.
> >>
> >> For the record, I never wrote that. Not sure why you repeat this ove=
r
> >> this thread.
> >
> >Because you seem to be implying that the Meta NIC driver shouldn't be
> >included simply since it isn't going to be available outside of Meta.
> >The fact is Meta employs a number of kernel developers and as a result=

> >of that there will be a number of kernel developers that will have
> >access to this NIC and likely do development on systems containing it.=

> >In addition simply due to the size of the datacenters that we will be
> >populating there is actually a strong likelihood that there will be
> >more instances of this NIC running on Linux than there are of some
> >other vendor devices that have been allowed to have drivers in the
> >kernel.
> =

> So? The gain for community is still 0. No matter how many instances is
> private hw you privately have. Just have a private driver.

The gain is the same as if company X makes a card and sells it
exclusively to datacenter provider Y. We know this happens.
Vendors would happily spin up a NIC if a DC with scale like this
would pay for it. They just don't advertise it in patch 0/X,
"adding device for cloud provider foo".

There is no difference here. We gain developers, we gain insights,
learnings and Linux and OSS drivers are running on another big
DC. They improve things and find bugs they upstream them its a win.

The opposite is also true if we exclude a driver/NIC HW that is
running on major DCs we lose a lot of insight, experience, value.
DCs are all starting to build their own hardware if we lose this
section of HW we lose those developers too. We are less likely
to get any advances they come up with. I think you have it backwards.
Eventually Linux networking becomes either commodity and irrelevant
for DC deployments.

So I strongly disagree we lose by excluding drivers and win by
bringing it in.

> =

> =

> >
> >So from what I can tell the only difference is if we are manufacturing=

> >this for sale, or for personal use. Thus why I mention "commercial"
> >since the only difference from my perspective is the fact that we are
> >making it for our own use instead of selling it.
> =

> Give it for free.

Huh?

> =

> =

> >
> >[...]
> >
> >> >> > I agree. We need a consistent set of standards. I just strongly=

> >> >> > believe commercial availability shouldn't be one of them.
> >> >>
> >> >> I never said commercial availability. I talked about open source =
vs
> >> >> proprietary userspace. This is very standard kernel stuff.
> >> >>
> >> >> You have an unavailable NIC, so we know it is only ever operated =
with
> >> >> Meta's proprietary kernel fork, supporting Meta's proprietary
> >> >> userspace software. Where exactly is the open source?
> >> >
> >> >It depends on your definition of "unavailable". I could argue that =
for
> >> >many most of the Mellanox NICs are also have limited availability a=
s
> >> >they aren't exactly easy to get a hold of without paying a hefty
> >> >ransom.
> >>
> >> Sorry, but I have to say this is ridiculous argument, really Alex.
> >> Apples and oranges.
> >
> >Really? So would you be making the same argument if it was
> >Nvidia/Mellanox pushing the driver and they were exclusively making it=

> >just for Meta, Google, or some other big cloud provider? I suspect
> =

> Heh, what ifs :) Anyway, chance that happens is very close to 0.
> =

> =

> >not. If nothing else they likely wouldn't disclose the plan for
> >exclusive sales to get around this sort of thing. The fact is I know
> >many of the vendors make proprietary spins of their firmware and
> >hardware for specific customers. The way I see it this patchset is
> >being rejected as I was too honest about the general plan and use case=

> >for it.
> >
> >This is what I am getting at. It just seems like we are playing games
> >with semantics where if it is a vendor making the arrangement then it
> >is okay for them to make hardware that is inaccessible to most, but if=

> >it is Meta then somehow it isn't.



