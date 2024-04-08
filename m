Return-Path: <linux-pci+bounces-5887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18BA89C83C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 17:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BDD1C2127C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FBF140399;
	Mon,  8 Apr 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7K7pxFA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AED13E88F;
	Mon,  8 Apr 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590033; cv=none; b=D1zS5gMT14n+r7Mg58v3i5ttY2z195xnaPz8UdRPgaiB+sIKVCqg4Wo+l34GfF7XIDiXbGBn55yJtGoBC4/Xwqu66CYkrLXwVJ+mvyTkUMVzzNEUV0u6VZQ1CQBF14+LxUvJC5N/lf6SVvYTqX0uXafhNXoVchKT3ScrWRsZWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590033; c=relaxed/simple;
	bh=3foDZQVCE9h+vCaa0c8f4ymTE90zsHWqZ+9zfPuIJ50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMkJfE7Wmj6vV+2fW3A85qYBa+GwVDbyW3Zv3KRagI8Lgbs/O4gEtomP3wp0UitafVnjAlBhCteENFvyYbp1ioZMPIpNe4mLh2mmk3phy/LBtX5ZlSrlvaJPXUIlzCZ0tramVskJqX9wBkBRPzky4KgzH5kJy/CMc1E+lVXiDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7K7pxFA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343e46ec237so2606069f8f.2;
        Mon, 08 Apr 2024 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712590030; x=1713194830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxlFKPbTGJC+nZ4viqvDhx3xfCRju+xx+nTFlelxLEQ=;
        b=K7K7pxFAeF0cMC6FY9bWy8G/9luK/6tStHcbZyAq+iTgFO6Mb8oz2I6F6bs/uptk1+
         Fhm69gxghotYfsMa9UKn1jSYlBVK/pcFW40Y2daZ+2YM/sWq9o7a9EedVFsEjB6Io0Ly
         hoNRdW0nfr0W5yc1GvQ8GC5JrVWo8jTLlTj9leJpMryEYkfyoQpf2A6ywREqtI9Du74n
         I6/JqwXTD+ejuCaY6idD5M+KwPakfxYb9cPz5HkOMk8xZ04Z551us6BdbL+D/SJNiy+x
         +RA/2f2u2RIYOsncWA4F59EymCx2DJTxbDSbXxCsTa0p+Mm/XrGZ9tXl83hA7VjBswnH
         9ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590030; x=1713194830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxlFKPbTGJC+nZ4viqvDhx3xfCRju+xx+nTFlelxLEQ=;
        b=qeVGXUegtWTds0v0E2mU4Zti41a/489Hue9+YwOPG+0wF2dwR5pavpV0HSp65TbPvq
         +2FLKgf/6Et00Kf9GDzWrzCJTWof7FMOl3s17+LnDGQClWC7/ufiL9Gy3HHv4AaoshTy
         ScwiBF6YyDMJzbLIpVcrM4KNUFL0xXQ57PPUPrIFqpfuPHaiMP973tMVpQkE0QiZJ392
         8zJajXdLJcbHgV4OixMODedqx/DI8Li02DXiH7BDeOiDwWkDdo/yeKpgEGtrbTP/J2Fr
         X0HTUsGNE5nqvULx9qRjFfA/zlMudIbQ6sLKLcwV0NjS29SMSE/380sUihkFr1tfceMs
         SyDA==
X-Forwarded-Encrypted: i=1; AJvYcCVxojzDJYtag9RW8bmypPpdXiauUq2rFWXuZ/4PWnO/LiKL7bJe2ENjVfpZJFEgIJz+9b6e/HMGj2ybIum4cl9gGRPI2KQRIU15enfR/fb1IpjanjOBbH7jzts8+0kLjOz0
X-Gm-Message-State: AOJu0Yw5JUW0W6Qxyyrq7PRWCoB6OkqPFd8dLhgF9Aq55+xxZvqFApVI
	S1/e7sszsPeONevfISHoFNE6RvSYaktaWtqDGcoMBTSPbPS0ITYBkBuNmphJxDAtb+VpzO2D52b
	AChKhrTfWTe3lN0uCLusXO662Zoc=
X-Google-Smtp-Source: AGHT+IEtrOxjmyNRURkAxVwwTKmft/RG0xyBmmm8uwi2Q3wqt2J/AKZ3hloz2706R/DbLGktlXZEz8o1K++xythm0is=
X-Received: by 2002:a5d:588b:0:b0:345:ca71:5ddb with SMTP id
 n11-20020a5d588b000000b00345ca715ddbmr2053513wrf.66.1712590029594; Mon, 08
 Apr 2024 08:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zg6Q8Re0TlkDkrkr@nanopsycho> <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho> <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org> <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <20240404193817.500523aa@kernel.org> <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
 <20240408061846.GA8764@unreal>
In-Reply-To: <20240408061846.GA8764@unreal>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 8 Apr 2024 08:26:33 -0700
Message-ID: <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 11:18=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Fri, Apr 05, 2024 at 08:41:11AM -0700, Alexander Duyck wrote:
> > On Thu, Apr 4, 2024 at 7:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
>
> <...>
>
> > > > > Technical solution? Maybe if it's not a public device regression =
rules
> > > > > don't apply? Seems fairly reasonable.
> > > >
> > > > This is a hypothetical. This driver currently isn't changing anythi=
ng
> > > > outside of itself. At this point the driver would only be build tes=
ted
> > > > by everyone else. They could just not include it in their Kconfig a=
nd
> > > > then out-of-sight, out-of-mind.
> > >
> > > Not changing does not mean not depending on existing behavior.
> > > Investigating and fixing properly even the hardest regressions in
> > > the stack is a bar that Meta can so easily clear. I don't understand
> > > why you are arguing.
> >
> > I wasn't saying the driver wouldn't be dependent on existing behavior.
> > I was saying that it was a hypothetical that Meta would be a "less
> > than cooperative user" and demand a revert.  It is also a hypothetical
> > that Linus wouldn't just propose a revert of the fbnic driver instead
> > of the API for the crime of being a "less than cooperative maintainer"
> > and  then give Meta the Nvidia treatment.
>
> It is very easy to be "less than cooperative maintainer" in netdev world.
> 1. Be vendor.
> 2. Propose ideas which are different.
> 3. Report for user-visible regression.
> 4. Ask for a fix from the patch author or demand a revert according to ne=
tdev rules/practice.
>
> And voil=C3=A0, you are "less than cooperative maintainer".
>
> So in reality, the "hypothetical" is very close to the reality, unless
> Meta contribution will be treated as a special case.
>
> Thanks

How many cases of that have we had in the past? I'm honestly curious
as I don't actually have any reference.

Also as far as item 3 isn't hard for it to be a "user-visible"
regression if there are no users outside of the vendor that is
maintaining the driver to report it? Again I am assuming that the same
rules wouldn't necessarily apply in the vendor/consumer being one
entity case.

Also from my past experience the community doesn't give a damn about
1. It is only if 3 is being reported by actual users that somebody
would care. The fact is if vendors held that much power they would
have run roughshod over the community long ago as I know there are
vendors who love to provide one-off projects outside of the kernel and
usually have to work to get things into the upstream later and no
amount of complaining about "the users" will get their code accepted.
The users may complain but it is the vendors fault for that so the
community doesn't have to take action.

