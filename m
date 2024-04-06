Return-Path: <linux-pci+bounces-5824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE1589AC64
	for <lists+linux-pci@lfdr.de>; Sat,  6 Apr 2024 19:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203721C20AA7
	for <lists+linux-pci@lfdr.de>; Sat,  6 Apr 2024 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F83FB92;
	Sat,  6 Apr 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwTGRd+H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E03BBCB;
	Sat,  6 Apr 2024 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712423809; cv=none; b=TYcDEWeyk4LD9POBMt+aWPCIllstTFHL4uZRH6QpAFEH3yYcz13l7PYOYSo1pqtnUZv9dEOoCE7xQQPg/P9/zzniDn7qCRkyVpOOX6WTPooDADlUTl+HWsDq/4mRnlqa/NOfV8mJ3Jda1W+on6PPhCUom8ahbWaDpRh1hh6Xpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712423809; c=relaxed/simple;
	bh=gILLRIaVJ2bum2B26nurRKPjscbQyS4QY1lUR4suiu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oig7veuN0xsFNOhD22ljzUXVcXYIo5VC/1Eq+naVP1LjIHp+OF6ZlI6/ZEhdosGnjiN5p+756b7ds/mVEj2edl/L9gv09K3cRdgewrvNSm0i9my0sEtVoNn2seg0aR5Kvg2afxTVXaWipi24kKpOR/My5tWaq+8/ZtXANfMobA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwTGRd+H; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343b7c015a8so1930124f8f.1;
        Sat, 06 Apr 2024 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712423806; x=1713028606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39fZePlFT6ahGlwRwztLsqQQOhwi+xDfyqxIazasOhs=;
        b=AwTGRd+HR3Zbq2UDI11IhlewRpJumc2M/6Cdr21/cQ2qsMWcTBXOpebe5i0poQ42RO
         63S8GHdAFbRQGx5Pk/GUrOMW0bGhA2/fWkBh+49HOrjTdXQia/E4+kfBRi9H+cpB8cbk
         tROUgDB2k1biUviysZRqU6qaIwaOABwbpqSEEkmeXyrDf47rsV8HAexjDKFNhrkOyIBZ
         uC3EB7xitV4ke/UyidVc2lJgEN22eCOAOmvGL4etCW1u8ZyxYHHo1nRjjlwiDZjlB8b0
         ScAFncuFh0N9eU0L2h+KcWCZuZSFb1uv7JCOgfQ5qM8vQqt6W9rRoRjRy1hsdneuxVPp
         hOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712423806; x=1713028606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39fZePlFT6ahGlwRwztLsqQQOhwi+xDfyqxIazasOhs=;
        b=TVftaoRu5UOdxO7w0ccqM8E/4HRPs9Ge21RkO/WokMct9+6toivESX3bA6ssYJUBWe
         kxZupXmgiGJ6JRAdwD5ay6OGoAd8DedarQ8dh4jA1BF0+WEdyPTMSzwACJMQhnBvHt98
         8+bcz8zbQfi1Qgw0JYHVi+KE/SCbTMiiwj7CRX7Sj8BgmlMvwUOkZTgM9RqayqUgAehQ
         tfznasrakRLfw3HNB+AR3baBmf7swaEQbU9dWc+pUkpogE/waRRocuWlqjHNAXI+8Ihu
         bei0Q51wDLCyvx76AjuASP6I4mU3KyHvigDGBcvhaQTzF+OpUIcZBmwWs2r8s6yOVFru
         62Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVxsOm1Sftg2cBrjtM4dXRdeGea+c0mhA1IaKSeQK29HnUCdhDsH4udbB3guTOB7fhEzivoy8gmyRG5UynIGlfxjl8D1MwgLgHHLLgOoQLGMpLrPt49MFwNFhpan4guMKvL
X-Gm-Message-State: AOJu0YxJ5KQtWnJbkzGWyu7rkGh/4/KqGdqdS0VXjUXLDDTZjXtIhEz5
	HqzQ3U3ECZLad5gSXJ5K/fk0bCa0DO+Cl+vcC2auTP1BAWtBDYnORM0dyPfPHnc/YLxTMwWTJSo
	PfZVva0trtP7ImuehTIn/OG96Ol8=
X-Google-Smtp-Source: AGHT+IEaKC3u9TiPBaPvwW2S9KZJmF0eLrzaUJP1ztG7c00OyVwF7t31avqJIODgx5xZoB33xf+wdmin12B6ZVr0tE8=
X-Received: by 2002:a05:6000:e4c:b0:343:aeab:2cd9 with SMTP id
 dy12-20020a0560000e4c00b00343aeab2cd9mr3197668wrb.11.1712423806235; Sat, 06
 Apr 2024 10:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <660f22c56a0a2_442282088b@john.notmuch> <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com> <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com> <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <20240405190209.GJ5383@nvidia.com> <CAKgT0UdZz3fKpkTRnq5ZO2nW3NQcQ_DWahHMyddODjmNDLSaZQ@mail.gmail.com>
 <b3183aab-4071-460d-acf0-1b5caa8c67a5@lunn.ch>
In-Reply-To: <b3183aab-4071-460d-acf0-1b5caa8c67a5@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 6 Apr 2024 10:16:09 -0700
Message-ID: <CAKgT0UefOftypF89vb9+COtHXARzvSVBpDZdJ_hmpE-GJNs=4Q@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 9:49=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I'm assuming it is some sort of firmware functionality that is needed
> > to enable it? One thing with our design is that the firmware actually
> > has minimal functionality. Basically it is the liaison between the
> > BMC, Host, and the MAC. Otherwise it has no role to play in the
> > control path so when the driver is loaded it is running the show.
>
> Which i personally feel is great. In an odd way, this to me indicates
> this is a commodity product, or at least, leading the way towards
> commodity 100G products. Looking at the embedded SoC NIC market, which
> pretty is much about commodity, few 1G Ethernet NICs have firmware.
> Most 10G NICs also have no firmware. Linux is driving the hardware.
>
> Much of the current Linux infrastructure is limited to 10G, because
> currently everything faster than that hides away in firmware, Linux
> does not get to driver it. This driver could help push Linux
> controlling the hardware forward, to be benefit of us all. It would be
> great if this driver used phylink to manage the PCS and the SFP cage,
> that the PCS code is moved into drivers/net/pcs, etc. Assuming this
> PCS follows the standards, it would be great to add helpers like we
> have for clause 37, clause 73, to help support other future PCS
> drivers which will appear. 100G in SoCs is probably not going to
> appear too soon, but single channel 25G is probably the next step
> after 10G. And what is added for this device will probably also work
> for 25G. 40G via 4 channels is probably not too far away either.
>
> Our Linux SFP driver is also currently limited to 10G. It would be
> great if this driver could push that forwards to support faster SFP
> cages and devices, support splitting and merging, etc.
>
> None of this requires new kAPIs, they all already exist. There is
> nothing controversial here. Everything follows standards. So if Meta
> were to abandon the MAC driver, it would not matter, its not dead
> infrastructure code, future drivers would make use of it, as this
> technology becomes more and more commodity.
>
>         Andrew

As far as the MAC/PCS code goes I will have to see what I can do. I
think I have to check with our sourcing team to figure out what
contracts are in place for whatever IP we are currently using before I
can share any additional info beyond the code here.

One other complication I can think of in terms of switching things
over as you have requested is that we will probably need to look at
splitting up the fbnic_mac.c file as it is currently used for both the
UEFI driver and the Linux driver so I will need to have a solution for
the UEFI driver which wouldn't have the advantage of phylink.

Thanks,

- Alex

