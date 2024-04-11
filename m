Return-Path: <linux-pci+bounces-6156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B1A8A2222
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 01:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8327B21F41
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 23:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0624047A74;
	Thu, 11 Apr 2024 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtjkXQXB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2D3FE54;
	Thu, 11 Apr 2024 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877174; cv=none; b=CC0CYb02wIH9ycPpUlDB8jcqdjbkkhcEwu5vKDwOd7jCnMcIFvAaZ1reMHEVdwno5en2v1zp5uWZGh+yDL9qUonAnLDCm+wR6v1zwCsQO8RAPXqBmzXeG0abydok4zphGT4HGsMOHgavcldsac/HZUnYhEB/9Us4sQ4+J6NuCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877174; c=relaxed/simple;
	bh=hdeI8NrGkvT/Vd5qwYRruu3DRd4Jdrbcc1kftFqabYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COnWDMMfzgLhxWsDJFrz6e5PvObuOpOJM6OznlBiL/OlHB6AFdryozKAQlfKIFRoRu46HQ6LnptMkixJoSIrIfAGV9zOEYDrOxpOAEduh0rjoQyyD7ndwRHJU/9w1SHR5CZe3ML5orwNr10EF6p9tPAQdbuj0EdV+kBuN/V9sPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtjkXQXB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso227663f8f.2;
        Thu, 11 Apr 2024 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712877171; x=1713481971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdeI8NrGkvT/Vd5qwYRruu3DRd4Jdrbcc1kftFqabYU=;
        b=DtjkXQXBXdaBtot7rd0PABEy21Ig8AYRdFL3vM87ykPEHNujYmTT036bH60/zntbI7
         +qF6Q00Z3cGyxE4sRVDoQTJmXwNZVHkRo9apqR0FTFgGvdwFj7Iir/REeRBd4QjQ9XIQ
         AeEwx4qeYdy20QtVmi6L21qxI/9wOrTM1P47/ZEXaFdOymbGnRmSAEHX+ymt76wQAqjv
         wv8gFVqOBRgigrW/wKgwH+IKN5quuTUTVuez57b2MN7Ru/Lvf28G9QsVpiWTL9Hx1MbM
         gFXhQIR6yo2BAdpzTUCKeRhkFS3XLo+ILTII7JcrtDh4YlfgMOOam2sd/HKfHOLP+RuO
         wDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877171; x=1713481971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdeI8NrGkvT/Vd5qwYRruu3DRd4Jdrbcc1kftFqabYU=;
        b=HkrGTq8TYOfhWs5ujY73QxuL6QNPTOW99k65erCU01tApkqRlZ0vIE7uHoajUVwcEv
         beuSldJ/ZXFgZXJIB20LsdzmHhkjGRZwq8/19x54VvxSRyS8CC3kpYx3dF9AqX1vCHqo
         UEtRRqDZAGdNroIQElLpwDxpRRZpfYSw3bfAjfxCV8muMntAiPvCrASS7UUJjAxDMfJx
         fWX19mXkSLud3zsYjp5W1RZZXdd7Z31k1F5S+bv0GoWYyDiKoKbyrhu6YZMp+KOonCgl
         r5yi7sMRHStWQbZp31MEMaZWieZBdlqusf44TP7lxjHpJfHU5OxqN8+shscw6aMF28jM
         7X8A==
X-Forwarded-Encrypted: i=1; AJvYcCX3hCC6NZRxJ6PNlwolTMbQ4RhtrLqWYpAJ5E3ZTpKhDbVGruAWtqHSW7ygHlRZuraYIq4Opdaij6sSYgEPvBMjaZ6VxvgeY94bWd0E+IaKToAflz6OlwEO96impcvQ2+47
X-Gm-Message-State: AOJu0YwdYjZkUA+aUwBZlkBfwOARcBvQEb8MWBcCNMO8je/KqVnHg4jV
	7TQzJC7ogNRSCx6/k7/3d1W0aXymqjHGX3XStwCBMGP3vrmu57oXvmVlHvNfUjo1/kMdK3mVcUv
	4CAo8eIlEjUHfTEFJINZRJrbe0PI=
X-Google-Smtp-Source: AGHT+IFZq07WBeCr7eODrDno1cPdCotcTL9CZaAHN6yhjQv2O0MUoTiCAdW8paIMAjf5e/zqFKaK/p379IZYSw9rpLg=
X-Received: by 2002:adf:f1c6:0:b0:341:ca5c:93da with SMTP id
 z6-20020adff1c6000000b00341ca5c93damr584076wro.1.1712877171316; Thu, 11 Apr
 2024 16:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org> <44093329-f90e-41a6-a610-0f9dd88254eb@lunn.ch>
 <CAKgT0UcVnhgmXNU2FGcy6hbzUQZwNBZw0EKbFF3DsKDc8r452A@mail.gmail.com>
 <c820695d-bda7-4452-a563-170700baf958@lunn.ch> <CAKgT0Uf4i_MN-Wkvpk29YevwsgFrQ3TeQ5-ogLrF-QyMSjtiug@mail.gmail.com>
 <c437cf8e-57d5-44d3-a71d-c95ea84838fd@lunn.ch> <CAKgT0UcO-=dg2g0uFSMt2UnyzF7y2W8RVFDp15RZhy=Vb4g61Q@mail.gmail.com>
 <70bccb10-cc76-4eec-b2cf-975ed422c443@lunn.ch>
In-Reply-To: <70bccb10-cc76-4eec-b2cf-975ed422c443@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 11 Apr 2024 16:12:14 -0700
Message-ID: <CAKgT0UfY3MQumrSpLL_tP-xCLjYThsrfH7vFW810f5FsWWJskA@mail.gmail.com>
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

On Thu, Apr 11, 2024 at 10:32=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Thu, Apr 11, 2024 at 09:00:17AM -0700, Alexander Duyck wrote:
> > On Wed, Apr 10, 2024 at 3:37=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > Well I was referring more to the data path level more than the phy
> > > > configuration. I suspect different people have different levels of
> > > > expectations on what minimal firmware is. With this hardware we at
> > > > least don't need to use firmware commands to enable or disable queu=
es,
> > > > get the device stats, or update a MAC address.
> > > >
> > > > When it comes to multi-host NICs I am not sure there are going to b=
e
> > > > any solutions that don't have some level of firmware due to the fac=
t
> > > > that the cable is physically shared with multiple slots.
> > >
> > > This is something Russell King at least considered. I don't really
> > > know enough to know why its impossible for Linux to deal with multipl=
e
> > > slots.
> >
> > It mostly has to do with the arbitration between them. It is a matter
> > of having to pass a TON of info to the individual slice and then the
> > problem is it would have to do things correctly and not manage to take
> > out it's neighbor or the BMC.
>
> How much is specific to your device? How much is just following 802.3
> and the CMIS standards? I assume anything which is just following
> 802.3 and CMIS could actually be re-used? And you have some glue to
> combine them in a way that is specific to your device?
>
> > > > I am assuming we still want to do the PCS driver. So I will still s=
ee
> > > > what I can do to get that setup.
> > >
> > > You should look at the API offered by drivers in drivers/net/pcs. It
> > > is designed to be used with drivers which actually drive the hardware=
,
> > > and use phylink. Who is responsible for configuring and looking at th=
e
> > > results of auto negotiation? Who is responsible for putting the PCS
> > > into the correct mode depending on the SFP modules capabilities?
> > > Because you seemed to of split the PCS into two, and hidden some of i=
t
> > > away, i don't know if it makes sense to try to shoehorn what is left
> > > into a Linux driver.
> >
> > We have control of the auto negotiation as that is north of the PMA
> > and is configured per host. We should support clause 73 autoneg.
> > Although we haven't done much with it as most of our use cases are
> > just fixed speed setups to the switch over either 25G-CR1, 50G-CR2,
> > 50G-CR1, or 100G-CR2. So odds are we aren't going to be doing anything
> > too terribly exciting.
>
> Maybe not, but you might of gained from the community here, if others
> could of adopted this code for their devices. You might not need
> clause 73, but phylink provides helpers to implement it, so it is
> pretty easy to add. Maybe your initial PCS driver does not support it,
> but later adopters who also licence this PCS might add it, and you get
> the feature for free. The corrected/uncorrected counters i asked
> about, are something you might not export in your current code via
> ethtool. But again, this is something which somebody else could add a
> helper for, and you would get it nearly for free.

You don't have to sell me on the reuse advantages of open source. I
will probably look at adding autoneg at some point in the future, but
for our main use case it wasn't needed. If nothing else I will
probably hand it off to one of the new hires on the team when I get
some time.

The counters are exported. Just haven't gotten far enough to show the
ethtool patches yet.. :-)

> > As far as the QSFP setup the FW is responsible for any communication
> > with it. I suspect that the expectation is that we aren't going to
> > need much in the way of config since we are just using direct attach
> > cables.
>
> Another place you might of got features for free. The Linux SFP driver
> exports HWMON values for temperature, power, received power, etc, but
> for 1G. The QSFP+ standard Versatile Diagnostics Monitoring is
> different, but i could see somebody adding a generic implementation in
> the Linux SFP driver, so that the HWMON support is just free. Same
> goes for the error performance statics. Parts of power management
> could easily be generic. It might be possible to use Linux regulators
> to describe what your board is capable if, and the SFP core could then
> implement the ethtool ops, checking with the regulator to see if the
> power is actually available, and then talking to the SFP to tell it to
> change its power class?

Again, for us it ends up not having much value adding additional QSFP
logic because we aren't using anything fancy. It is all just direct
attach cables.

> Florian posted some interesting statistics, that vendors tend to
> maintain their own drivers, and don't get much support from the
> community. However I suspect it is a different story for shared
> infrastructure like PCS drivers, PHY drivers, SFP drivers. That is
> where you get the most community support and the most stuff for free.
> But you actually have to use it to benefit from it.

I'll probably get started on the PCS drivers for this next week. I
will follow up with questions if I run into any issues.

Thanks,

- Alex

