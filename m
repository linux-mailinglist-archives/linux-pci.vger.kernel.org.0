Return-Path: <linux-pci+bounces-5899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5B489CCAC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 21:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA711F22BF9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99476146019;
	Mon,  8 Apr 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxWVPtzn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514CC14601D
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605826; cv=none; b=nIKjh+ZdmFLU1yIAqmQssY6FSYQ6o54ctC6E5b+0VT4yeNX9virWTVkx8MY8QG2kFsWoUto74kRUslu+zAlfIK7LtEeYZUZLaZ2CIG1RIlkKJ/i2IVfUAho92Bi5pJriyDX816D5781BKXfmdoryUy9YppeBey4aAeBEZEoHLY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605826; c=relaxed/simple;
	bh=JjKQNFwllksFgRPBLRvoHBOCq6aFlTpzZMgB9FrxS9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfrqszNbWz+oZTESyF4Nc06YMORO/CAggDLr7av65t5BEcOqKZ9UAJR8ti/67Gcop2Fn3tJkKZXFpZYj1oR7fUmI2F2rF7eroccA2MGl2PEIJ71MSEc0gJ9TboOM4WI83bZxIYbYsozonHKCB9vC7b8+phIkUH+4Rd8hn7A3hF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxWVPtzn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso6648941a12.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712605821; x=1713210621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjKQNFwllksFgRPBLRvoHBOCq6aFlTpzZMgB9FrxS9k=;
        b=UxWVPtzndzja55vqTUUnSV8vpV2At1AuamDiJdoptD/UqiKm+PFe9BdX2BXdZW1t4O
         CB9fzV4BnQeMAoR5xcK2A6nYGDemAGtSpPMO5ROEfKy85a2ntid6WYNkRL2c2O34Zt1I
         k/5Gn403VeVSnxftd3xcY7NkrjpOvNM1ncryEmQYQT8VFRY9QJgYpYvjBXR5rACJnfEs
         T8AGSY2V521UxGu2RgxJvepWDlMhJ4puAa2LA1iHgG+T6wex5fGMumyHpefdi0lX72xy
         mqJ8lZPd+ZZCkqnyYlqEGN/fSz+ZKTsCUoZKhIG4SZX4yKY8d5BZCA+tA9780uTTz/ZG
         d0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712605821; x=1713210621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjKQNFwllksFgRPBLRvoHBOCq6aFlTpzZMgB9FrxS9k=;
        b=gT1vzeKNmAeVbLkfaqBma3BE4HlA9+zZwLCoP7tw0GMzciYzPMF4Rv0Pod7WyUelbT
         iKYitqFnqjAyFwXcpqLdd5xUYMuPdPDrD2iKtMpF7gu/NVl8pE5rZOewyYYNBDM+9l+y
         PR3vx77hqQhgfDa2x+W0cBedpFwCKu/MZDATKiQvD/VfV2cWlttsmq7ZWWRyC8FtTJjA
         +kAyue7VLYjZCKDiXUtxFEgmHv3MRoNUQtAxW47Ssm9ZenSkB+nQAYF4eZOOLnQFsYwg
         caZ3/kkSXYBfyoS5liJDzkBwnhrnGS48MAoDyryLxO13syLj3nEw+spKDINZML8N66p7
         AFMw==
X-Forwarded-Encrypted: i=1; AJvYcCWWFrKh1Bi4ENY3Zm8YovFGRQvF6CAeGY2h8w931zGkVFiH72zHwNs/vAcYh9ZXRzq8MC29vgHK0dPQTxTN2EF8LfFVJ0vyRC1z
X-Gm-Message-State: AOJu0YynuvIeNlYKVaqByh7509zHeU221riok1x31m3k+vDs4gkR3T25
	MadhuHAUzeZKP+CN2Iuc9pvCRrDkaO3SsgwLfJGpBOubLFTQc/Jf6F31xWT3A+Eqoi3w96e+bkj
	d4aZPyLoRKQ2cLTR5qqCWzRpmBxxvAIm5CPHC
X-Google-Smtp-Source: AGHT+IHVzkkoMgsAyVJZUQkSXu1B8zeCMn9DkJtjVrTmXb52LArEmzcVkeTpkQDA7zBc34jUEeRbIfG4BhSGsdLRAqc=
X-Received: by 2002:a17:906:ad90:b0:a51:e2d2:c236 with SMTP id
 la16-20020a170906ad9000b00a51e2d2c236mr1014157ejb.39.1712605821430; Mon, 08
 Apr 2024 12:50:21 -0700 (PDT)
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
 <20240405190209.GJ5383@nvidia.com> <CAKgT0UdZz3fKpkTRnq5ZO2nW3NQcQ_DWahHMyddODjmNDLSaZQ@mail.gmail.com>
In-Reply-To: <CAKgT0UdZz3fKpkTRnq5ZO2nW3NQcQ_DWahHMyddODjmNDLSaZQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 8 Apr 2024 12:50:07 -0700
Message-ID: <CAHS8izNTLbi5vzi6ThVo7jcyOyhhv13eyEZT8wMowWceZyNqPg@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, Christoph Hellwig <hch@lst.de>, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 9:05=E2=80=AFAM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> > > > You have an unavailable NIC, so we know it is only ever operated wi=
th
> > > > Meta's proprietary kernel fork, supporting Meta's proprietary
> > > > userspace software. Where exactly is the open source?
> > >
> > > It depends on your definition of "unavailable". I could argue that fo=
r
> > > many most of the Mellanox NICs are also have limited availability as
> > > they aren't exactly easy to get a hold of without paying a hefty
> > > ransom.
> >
> > And GNIC's that run Mina's series are completely unavailable right
> > now. That is still a big different from a temporary issue to a
> > permanent structural intention of the manufacturer.
>
> I'm assuming it is some sort of firmware functionality that is needed
> to enable it? One thing with our design is that the firmware actually
> has minimal functionality. Basically it is the liaison between the
> BMC, Host, and the MAC. Otherwise it has no role to play in the
> control path so when the driver is loaded it is running the show.
>

Sorry, I didn't realize our devmem TCP work was mentioned in this
context. Just jumping in to say, no, this is not the case, devmem TCP
does not require firmware functionality AFAICT. The selftest provided
with the devmem TCP series should work on any driver that:

1. supports header split/flow steering/rss/page pool (I guess this
support may need firmware changes...).

2. supports the new queue configuration ndos:
https://patchwork.kernel.org/project/netdevbpf/patch/20240403002053.2376017=
-2-almasrymina@google.com/

3. supports the new netmem page_pool APIs:
https://patchwork.kernel.org/project/netdevbpf/patch/20240403002053.2376017=
-8-almasrymina@google.com/

No firmware changes specific to devmem TCP are needed, AFAICT. All
these are driver changes. I also always publish a full branch with all
the GVE changes so reviewers can check if there is anything too
specific to GVE that we're doing, so far there are been no issues, and
to be honest I can't see anything specific that we do with GVE for
devmem TCP:

https://github.com/mina/linux/commits/tcpdevmem-v7/

In fact, GVE is IMO a relatively feature light driver, and the fact
that GVE can do devmem TCP IMO makes it easier for fancier NICs to
also do devmem TCP.

I'm working with folks interested in extending devmem TCP to their
drivers, and they may follow up with patches after the series is
merged (or before). The only reason I haven't implemented devmem TCP
for multiple different drivers is a logistical one. I don't have
access to hardware that supports all these prerequisite features other
than GVE.

--=20
Thanks,
Mina

