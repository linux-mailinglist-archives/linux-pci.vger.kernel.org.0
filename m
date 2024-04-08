Return-Path: <linux-pci+bounces-5888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 263EB89C8AE
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65254B21E52
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E8B5F87E;
	Mon,  8 Apr 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbmngdNZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A324B4A;
	Mon,  8 Apr 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591236; cv=none; b=cooes9R5ZiS+EblWSnT4b65nlgU+UIuhx7Rg6oTg8CdNBKJ/YWe7A3qdi484MIqspqk5VtQsXw1P+8UGg3CDr500BfQILWwao6VsV9zlKBD8zSLWHnTdxovMFp2mPb5cK2+hBpSLMP/hR0Oh4oLhA56DyPceAHHTn0QMtD91vnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591236; c=relaxed/simple;
	bh=XWTxD0GDjCGkak87HIqNe6ZKIZfYTqzhwrsShJ6reOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+3QyQdvjEmh/NzWz4BpCauxLm4eVnXiv6jvvNPJU0cFFMLDljplsOI7mdN9dxTCpkB8KD+HHoQRrBYDkDEAGhdDc/is1JUSlUcfXup1LD259IYafu2lP/xAfIbjHmOIzXt0/67Qmsga3MvJ3t2hjRJySkGF1CKz/GMeIEiai5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbmngdNZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d89f7cf980so1124121fa.1;
        Mon, 08 Apr 2024 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591232; x=1713196032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWTxD0GDjCGkak87HIqNe6ZKIZfYTqzhwrsShJ6reOU=;
        b=KbmngdNZCqFrdRYKpLLlD4pGXQa0ORe+EQC13PTYqe5Ctr9+O1UI3oXQWnuouZunWq
         O42nhkVYVd1VGqZeChN9NhxFspO+DDaH3YQ+bJC3FaEGjNt5CCW10RUJQkHv4Fq9N6mH
         K6jyNESAUSbj0CR+B5aew+k0kXnYAi7mD9eJLpZbNf+ZBw7Ko8urcckV9+gdefiJ0gsY
         ZgFokV2PJPSFVT0a+XfbPna47sHFPZXF3TktlY9Ejq7uAhf3A6lz0X2VwvhGr8f9QOuk
         +QgQrU/uVhG0y/RHW/6l6Zk0OvyRRx2YjM9GIoUIiRo7JoGEb0RPEY4NerZMtrtPagtU
         UZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591232; x=1713196032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWTxD0GDjCGkak87HIqNe6ZKIZfYTqzhwrsShJ6reOU=;
        b=VJYuA1PyZK1EAksjzKQKvsn99FQeWL/0hWGx1RJobQDPAinVqvJ4eI9asTueBTbIk+
         ysED8wTjm0+CekgE/jl79IcrVWG7f6RUIaGLirB85utpm6CCTh4E3XCxQjI8Sd+G2uwX
         oOuJkbZiWxWluUp2j+13i3qu0TsKvDirTUiTreukleCbR8IuYb6C9Rd904YqvqISmDwD
         0VATxBbvO4YsORUcj8YmXmsUOHTKBPyRxnZjHj2W65G2DpG6bGpdXTN9/VNakiMUAKDd
         4wSjoQChITwMilWo9hwnf/i2dh5XKZx0goeZBwadiuajXZgLib4URv1pJy4pVVC9RQAh
         EwkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/zVh7TNBBybfgWnQZ+Nlj3sV3o4JkUvFakHkmvit+os6/fUcm5IHS5nl9E3KT5a/D8MGqxeaeV3FYGVZPRMYgJ+wOdhJI8plJOWbuLqF9kiiECDInfGq+Y9PututpuoCi
X-Gm-Message-State: AOJu0YyAsbMtXZIJedSe6deZIfalUCv5Em9zk4NLJVOodVlhZ1vHHOLE
	KIBtWzvS71vx8uY6338DhDM11tT742xOeFV/kz2+ImlGJKb7TMhgkHaG9zAXqbDoLSRn1wZsU0f
	Bro1Uddp/laVMM+bX5Oayz9Z96qw=
X-Google-Smtp-Source: AGHT+IGIQZnLjgx9HHyb69wZviN7mn4HV0dhMzfiJf3+/dHDemCOy40Z+kds1Lh504MKYWTIifBbhwPh1rKnpTfvtKQ=
X-Received: by 2002:a05:651c:1411:b0:2d8:3d69:b066 with SMTP id
 u17-20020a05651c141100b002d83d69b066mr5195169lje.7.1712591232034; Mon, 08 Apr
 2024 08:47:12 -0700 (PDT)
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
 <ZhPaIjlGKe4qcfh_@nanopsycho>
In-Reply-To: <ZhPaIjlGKe4qcfh_@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 8 Apr 2024 08:46:35 -0700
Message-ID: <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 4:51=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
> >On Fri, Apr 5, 2024 at 8:17=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
> >>
> >> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
> >> > > Alex already indicated new features are coming, changes to the cor=
e
> >> > > code will be proposed. How should those be evaluated? Hypothetical=
ly
> >> > > should fbnic be allowed to be the first implementation of somethin=
g
> >> > > invasive like Mina's DMABUF work? Google published an open userspa=
ce
> >> > > for NCCL that people can (in theory at least) actually run. Meta w=
ould
> >> > > not be able to do that. I would say that clearly crosses the line =
and
> >> > > should not be accepted.
> >> >
> >> > Why not? Just because we are not commercially selling it doesn't mea=
n
> >> > we couldn't look at other solutions such as QEMU. If we were to
> >> > provide a github repo with an emulation of the NIC would that be
> >> > enough to satisfy the "commercial" requirement?
> >>
> >> My test is not "commercial", it is enabling open source ecosystem vs
> >> benefiting only proprietary software.
> >
> >Sorry, that was where this started where Jiri was stating that we had
> >to be selling this.
>
> For the record, I never wrote that. Not sure why you repeat this over
> this thread.

Because you seem to be implying that the Meta NIC driver shouldn't be
included simply since it isn't going to be available outside of Meta.
The fact is Meta employs a number of kernel developers and as a result
of that there will be a number of kernel developers that will have
access to this NIC and likely do development on systems containing it.
In addition simply due to the size of the datacenters that we will be
populating there is actually a strong likelihood that there will be
more instances of this NIC running on Linux than there are of some
other vendor devices that have been allowed to have drivers in the
kernel.

So from what I can tell the only difference is if we are manufacturing
this for sale, or for personal use. Thus why I mention "commercial"
since the only difference from my perspective is the fact that we are
making it for our own use instead of selling it.

[...]

> >> > I agree. We need a consistent set of standards. I just strongly
> >> > believe commercial availability shouldn't be one of them.
> >>
> >> I never said commercial availability. I talked about open source vs
> >> proprietary userspace. This is very standard kernel stuff.
> >>
> >> You have an unavailable NIC, so we know it is only ever operated with
> >> Meta's proprietary kernel fork, supporting Meta's proprietary
> >> userspace software. Where exactly is the open source?
> >
> >It depends on your definition of "unavailable". I could argue that for
> >many most of the Mellanox NICs are also have limited availability as
> >they aren't exactly easy to get a hold of without paying a hefty
> >ransom.
>
> Sorry, but I have to say this is ridiculous argument, really Alex.
> Apples and oranges.

Really? So would you be making the same argument if it was
Nvidia/Mellanox pushing the driver and they were exclusively making it
just for Meta, Google, or some other big cloud provider? I suspect
not. If nothing else they likely wouldn't disclose the plan for
exclusive sales to get around this sort of thing. The fact is I know
many of the vendors make proprietary spins of their firmware and
hardware for specific customers. The way I see it this patchset is
being rejected as I was too honest about the general plan and use case
for it.

This is what I am getting at. It just seems like we are playing games
with semantics where if it is a vendor making the arrangement then it
is okay for them to make hardware that is inaccessible to most, but if
it is Meta then somehow it isn't.

