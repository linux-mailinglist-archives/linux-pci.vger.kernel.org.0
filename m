Return-Path: <linux-pci+bounces-6083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833CC8A01B4
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 23:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F551F23998
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94021181D17;
	Wed, 10 Apr 2024 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXvDEJlo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C2181BBF;
	Wed, 10 Apr 2024 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783263; cv=none; b=ohqslGsCqP9bYMmEj3I+TByP6lS3McKL4k+6sJhjWfoh3LfDY+N8J9Z3BPxrCizKVS0+HXz8iKWCiLZ37dcsSZ6ykx5zqXQz/i+q7KAIMTZ5TtaFmpna5vKw7MJI3wJLb+mJwTgCi6MqACGeXFtcWXFIkZwwEX/K31hR38r80Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783263; c=relaxed/simple;
	bh=tVgQIDwbSdQwUlahpci6ahtFLNpumdd3V7FRxsMhjYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDZ1GOb29EMjD1hpUr4VtvDiBGCbCampPsNxzWMSY7nkW0R0ACtqhUnXgJSqycPxQAD2f51QflwvHZzT4ZVl5BVeTAHaALp69b7VshVKMc+HDFnoa62gEkysUpz2bLs9cECLlWYwMevu7g1pN8CtmSoP6gcBn6NbcfC8wPyqaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXvDEJlo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-417d029bf15so1474975e9.3;
        Wed, 10 Apr 2024 14:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712783260; x=1713388060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qQQYgKvYQRWXJV9/5TVuEp1hplQNtziCS82L6bFylQ=;
        b=KXvDEJlok1YyPZ4vk3h3xp7uJ5P7qYq/F5A2XSEjD/n8S58B3S3cfo8h2ni22i1yBN
         gnL4emV2skw5aeFDee+qQLmkotsUZbHR0Oy+0oHwpFs+qrqCroM2YG702QYNTy5v3G0U
         5POoQldO3HBhB8DpbrL8sPDq6zDw1uQp8c1oTR5wgATDXTsDSXU9MFnJOYNGlR1nacsI
         dMDxMWKILamjeEy/ufe5T8IVSQczjACeero4xZFhMkcvEs8ZnOt/32duQWzbLf71WzlP
         cX9zplST4VfkrGvhO/e0njSwaLUKoCVi2nlUXrptuqqsNXD5yrDp3J8oyKdc02tKa2AK
         kJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712783260; x=1713388060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qQQYgKvYQRWXJV9/5TVuEp1hplQNtziCS82L6bFylQ=;
        b=NVLY9Mlcrsb7eF7b3kGt4UJmyFDMOL0Awtzju/nBC08vu8JK9ZOwqtoll0IWiZ/y1J
         RiQMyVl+w/Lnv1ssjDYzx3ihIWPI6ChT5eT+Fm3Hq0l2OCu+1t9AFnYmS088Iu1jWTQO
         h/VArujTGS8XVjJ+sHJ/PeNuTNn2BQ8UAENbZqtA5UKeeS5FB+yuEAWCc3YuKpQ5dpof
         mZLNbqwSl9iGG9olZ89z2hesMgjvL61f+cWVTyxazqmypIPwBYDln+JQS5Otyax+/dIk
         fpfHjytu/6Rw0hqVghHPUzgWVw0RjkNx3JeUWCbqZU/p1t7T3VM/NOvdBwxN0//I2eTV
         FuiA==
X-Forwarded-Encrypted: i=1; AJvYcCWxrzQgt5exvXA8Z9ZFqdJAnCp7vFvGkmmBRW2CVrhqF5ZWfQxrf1TgyaBGEq0YuwiVp3EJAFzaWIsCHLJhu/X11f/hLOL5TNVlMRXq6fGiMkJNWOLsT9w5aJu0arpsowd1
X-Gm-Message-State: AOJu0YwCEs29qVDjqelo3ZE997JI2wVvIQHg72pJdmxBtw1Bu7xcYxSs
	XjOLjr9/rYs8Ga49HbV2XzGH8iRI6FTR+SiCIeuaHgM/G41ADEX5/xGBjU2YiCmOGSZLlEEPe/P
	HGz0eG8uInq+Nvv6GY6zsfFGRplk=
X-Google-Smtp-Source: AGHT+IEADVvfiWhgUy2YljmuMUKwmAjGLdohNJrq+mqsxYO3BY0AdPzAL96haUo8WfMDLAoBdjN+hH/OpImi5hRmAeg=
X-Received: by 2002:a05:600c:3504:b0:416:5a88:4b49 with SMTP id
 h4-20020a05600c350400b004165a884b49mr3008330wmq.15.1712783259805; Wed, 10 Apr
 2024 14:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org> <44093329-f90e-41a6-a610-0f9dd88254eb@lunn.ch>
 <CAKgT0UcVnhgmXNU2FGcy6hbzUQZwNBZw0EKbFF3DsKDc8r452A@mail.gmail.com> <c820695d-bda7-4452-a563-170700baf958@lunn.ch>
In-Reply-To: <c820695d-bda7-4452-a563-170700baf958@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Apr 2024 14:07:02 -0700
Message-ID: <CAKgT0Uf4i_MN-Wkvpk29YevwsgFrQ3TeQ5-ogLrF-QyMSjtiug@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, 
	John Fastabend <john.fastabend@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 1:01=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Apr 10, 2024 at 08:56:31AM -0700, Alexander Duyck wrote:
> > On Tue, Apr 9, 2024 at 4:42=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > > What is less clear to me is what do we do about uAPI / core changes=
.
> > >
> > > I would differentiate between core change and core additions. If ther=
e
> > > is very limited firmware on this device, i assume Linux is managing
> > > the SFP cage, and to some extend the PCS. Extending the core to handl=
e
> > > these at higher speeds than currently supported would be one such cor=
e
> > > addition. I've no problem with this. And i doubt it will be a single
> > > NIC using such additions for too long. It looks like ClearFog CX LX2
> > > could make use of such extensions as well, and there are probably
> > > other boards and devices, maybe the Zynq 7000?
> >
> > The driver on this device doesn't have full access over the PHY.
> > Basically we control everything from the PCS north, and the firmware
> > controls everything from the PMA south as the physical connection is
> > MUXed between 4 slices. So this means the firmware also controls all
> > the I2C and the QSFP and EEPROM. The main reason for this is that
> > those blocks are shared resources between the slices, as such the
> > firmware acts as the arbitrator for 4 slices and the BMC.
>
> Ah, shame. You took what is probably the least valuable intellectual
> property, and most shareable with the community and locked it up in
> firmware where nobody can use it.
>
> You should probably stop saying there is not much firmware with this
> device, and that Linux controls it. It clearly does not...
>
>         Andrew

Well I was referring more to the data path level more than the phy
configuration. I suspect different people have different levels of
expectations on what minimal firmware is. With this hardware we at
least don't need to use firmware commands to enable or disable queues,
get the device stats, or update a MAC address.

When it comes to multi-host NICs I am not sure there are going to be
any solutions that don't have some level of firmware due to the fact
that the cable is physically shared with multiple slots.

I am assuming we still want to do the PCS driver. So I will still see
what I can do to get that setup.

Thanks,

- Alex

