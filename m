Return-Path: <linux-pci+bounces-5972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA0A89E41B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 22:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D4D287330
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C899B157E9E;
	Tue,  9 Apr 2024 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk8+QkA5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1D157E97;
	Tue,  9 Apr 2024 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693026; cv=none; b=Trlcn1omo8o/pZ1xqVh34SY8QvH3LjkgGpN3CK2gdahMNT699ADzt5d3E8wkBghIe8xlLhaFU1T084R7KCavbj6uBgZwJeF0OH/gb+90UeuqQ4wPmReWFlJhucPWtozN/VkwrOQBvuPeHQ+DzPbqIUNzix816Y+INa6iqEeGDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693026; c=relaxed/simple;
	bh=BKPwDcilCk7Fpstj6G3Bqf1RwwGG2vSjtmGmwoMFgxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWfS42erFxmEhyU+wark02GOpkFzhHv8u+lA7tqam4biX+A53FqLAP/jDUw5AUsvywrftTeBjtuAXB+x9uniNvLmbS/mgu5/VoUuHOmRNPf+rkSzk5e1ODd3Vk+Thd8H/0flr9QAf4w2FrRbUpZpr2x/thM+T0CLG2anL+VQRkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk8+QkA5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4169ebcc924so9840745e9.0;
        Tue, 09 Apr 2024 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712693023; x=1713297823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKPwDcilCk7Fpstj6G3Bqf1RwwGG2vSjtmGmwoMFgxI=;
        b=Hk8+QkA5d8uf+E/jZE103P2edF9EcjOz+FMGbfpX+AYz/LQGaD9FKytkcRxQ76GJNa
         bGfzyPBx1BCAmhGmoTRDqlDcEWDQ1O4mXAM+JvrXGBbtWz0MrhpXwnllrfx88LWwPAdm
         NZ4sZRsowH9BHdMcO7wG+7OEWL4jWhAcBfqMA8qcrNcylRjb4qI3Vhs49ABL1KWfSPoP
         7R2Pgqjx2AKY46EDPPKLto6TDkMrjsH5p9Ey+qAkRB9UYvju9Xw5Ub/tvBXEeOUG+Ptt
         7yHHZVKc0Wjiqrc7NG4LQFIUhD6J2CxwULMtZBKNcWxVdxwB9DzXZbbnBBWHVh8j/g+n
         PpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712693023; x=1713297823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKPwDcilCk7Fpstj6G3Bqf1RwwGG2vSjtmGmwoMFgxI=;
        b=UKajBP5NPYkZWXizbNDlAYubAv0Onl8k49hiEK/0QXxnrLW61sMzulYu3T/qkJJJTu
         6hXbxlT4gA8tltBgz5DL4elQi8NZ25T7qDtm+FrcXSIYweE4c5x4FuyoXkSuTUWKGqdg
         Yw6pDtNd0B9BLZuGwC+Jxq9MvWNYExHNE71/22DTWxrv5hIuu3qYYHTYNe2RT/5CVrw0
         B72xGxiFz3hQ9ajS83fB5BA+mVIWi2XwtdgQBtrhnmIrGiAuDVJ6jrR1ZeX+gG/fmXt3
         V17G//OSujo2PtlBMPis9TySEGSKAeygBV7YLC3ShzKkhK69cwvZf24P061smIPk6uLP
         To/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQFvrQVtG/CEqMp1yEEq7t5s0oKKyDgWMpPMmIV3Re9TNouOUbtl/lj9ibZXOX0WU7V+U1Ag7oPGo6vIi51u9htLN0hlHD9X2JE8p7Q+qO/iksR8jNOvzKcT1CZVhpPX3j
X-Gm-Message-State: AOJu0Yy8KqcbHeXqUvQ4FmkY4J13IlTkYy3HPKIifmiRNsc1ZtS4qGj0
	1wRNxs3Nhhb+MTyfrlOG78co+beDMrRETT1RAcER1qW1XkDnW3Ucqj8+PDVpDTOTsylYtUTCkeP
	L7TH60qpiWGHvI3YNVpb+KBBN4Hg=
X-Google-Smtp-Source: AGHT+IHhhLBHCcP6lU7shcoNGE+mY6oH/uAljMisFfwT1uSEfASNoK/aaQGGa1ES7AjXNjhEKSZkVxq/oG0TerZcM0A=
X-Received: by 2002:adf:f8d0:0:b0:343:f335:58b with SMTP id
 f16-20020adff8d0000000b00343f335058bmr459924wrq.62.1712693023173; Tue, 09 Apr
 2024 13:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408061846.GA8764@unreal> <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal> <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
 <20240409081856.GC4195@unreal> <CAKgT0UewAZSqU6JF4-cPf7hZM41n_QMuiF_K8SY8hyoROQLgfQ@mail.gmail.com>
 <20240409153932.GY5383@nvidia.com> <CAKgT0UeSNxbq3JYe8oNaoWYWSn9+vd1c+AfjvUsietUtS09r0g@mail.gmail.com>
 <20240409171235.GZ5383@nvidia.com> <CAKgT0Ufc0Zx6-UwCNbwtEahdbCv=eVqJKoDuoQdz6QMD2tv-ww@mail.gmail.com>
 <20240409185457.GF5383@nvidia.com>
In-Reply-To: <20240409185457.GF5383@nvidia.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 9 Apr 2024 13:03:06 -0700
Message-ID: <CAKgT0UcqJr4s8jMGW0a4BA6gUs+ey9X2JAOpeEP9cBW1qHmizw@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:55=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Apr 09, 2024 at 11:38:59AM -0700, Alexander Duyck wrote:
> > > > phenomenon where if we even brushed against block of upstream code
> > > > that wasn't being well maintained we would be asked to fix it up an=
d
> > > > address existing issues before we could upstream any patches.
> > >
> > > Well, Intel has it's own karma problems in the kernel community. :(
> >
> > Oh, I know. I resisted the urge to push out the driver as "idgaf:
> > Internal Device Generated at Facebook" on April 1st instead of
> > "fbnic"
>
> That would have been hilarious!
>
> > to poke fun at the presentation they did at Netdev 0x16 where they
> > were trying to say all the vendors should be implementing "idpf" since
> > they made it a standard.
>
> Yes, I noticed this also. For all the worries I've heard lately about
> lack of commonality/etc it seems like a major missed ecosystem
> opportunity to have not invested in an industry standard. From what I
> can see fbnic has no hope of being anything more than a one-off
> generation for Meta. Too many silicon design micro-details are exposed
> to the OS.

I know. The fact is we aren't trying to abstract away anything as that
would mean a larger firmware blob. That is the problem with an
abstraction like idpf is that it just adds more overhead as you have
to have the firmware manage more of the control plane.

> > It all depends on your definition of being extractive. I would assume
> > a "consumer" that is running a large number of systems and is capable
> > of providing sophisticated feedback on issues found within the kernel,
> > in many cases providing fixes for said issues, or working with
> > maintainers on resolution of said issues, is not extractive.
>
> I don't know, as I said there is some grey scale.
>
> IMHO it is not appropriate to make such decisions based on some
> company wide metric. fbnic team alone should be judged and shouldn't
> get a free ride based on the other good work Meta is doing. Otherwise
> it turns into a thing where bigger/richer companies just get to do
> whatever they want because they do the most "good" in aggregate.

The problem here in this case is that I am pretty much the heart of
the software driver team with a few new hires onboarding the next
couple months. People were asking why others were jumping to my
defense, well if we are going to judge the team they are mostly
judging me. I'm just hoping my reputation has spoken for itself
considering I was making significant contributions to the drivers even
after I have gone through several changes of employer.

