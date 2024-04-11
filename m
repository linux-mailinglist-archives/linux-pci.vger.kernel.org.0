Return-Path: <linux-pci+bounces-6143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F5A8A1D0D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 20:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CEB1F22A55
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F5D17730;
	Thu, 11 Apr 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdZqXjiL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC91C8213;
	Thu, 11 Apr 2024 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854013; cv=none; b=WdLrn3vrEbAn42zgIcoKlpWUeHK8kNVtuMCvQFJLHb1yaV6zAG6GJwLsMVy/K+zvkGQXChf6mju8gPytQyMBPoveALO2maUYVttMymBw3eZt1KHNYiyh/mZe2i1jd/pMm875MX8mV+4Q0uH1pVa/0x0MbI9s7x4rV+VSWv74HCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854013; c=relaxed/simple;
	bh=//EpDYqbcR42WpSWZOUSBOGSgHXmWkJR381g5p+LZQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SigLm4LOK2mev3U03ZS5rIIpTL5s2A6iXI9s4QOIg0ubWkY5G7wjF1Z9TQdYEyisqqXgTTp6AmMOycVs2yGRkubNx5hfuLBMVIrGCbLPlBtPvMHPQyEts8CXHCzrsywrWNs3E2dhpaNBToNjaIneOtLATykknpPyIk1ZYGxDIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdZqXjiL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-346f4266e59so2127f8f.3;
        Thu, 11 Apr 2024 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712854010; x=1713458810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPJHPfk1DWuUb9QneEeKlCQYn+Oo4UzmYfz2J/EFH/Y=;
        b=NdZqXjiLzP+MQLLZnWjIPw9UO5JM1EoXRTTy4grpdTwBt1ejdluXn2CN3RZ9jW4IA8
         RlMmF/UlLtcGBL6mUFuW0swYsnqIEe5GNYQ62WZA5tnFEAsL73dURFlDsei3NDaka4pc
         1fePdUrDwwG4xXL0OS6MoNpfZtPiwNF8jwT/LZqWwCAucLnEDysTfvW8e8PU1KbN+n/t
         2b4Wqv528/0sC4npcg8TxpA37s3Kbs8HOX3DFzdn0Z5g/QApw3WmC2w4l00WBM0k9SMO
         JWJsAYI8h94irSwDzsCwrpHdnXR8apXFWBQ/Bs/mu0UzwS18s0MG1R9GU7sACeHh7IO2
         6KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712854010; x=1713458810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPJHPfk1DWuUb9QneEeKlCQYn+Oo4UzmYfz2J/EFH/Y=;
        b=OvZQy1PD9GT30Zw4k5hqSJ+pH0pFvByXA82jrCdAbefwjY6SDUVloTZDrxG8EQa8Oi
         ztbUKnjMdcHHVV/klOm95KKSwvtLmmMzpWQynYnReooHbUqsgsTXkD5fuh1irefQVpm/
         Ee+Y6vx04DgD61PogTrz/+it/6Y9A0M71tcVCeGXjnBVNeJ+wB2FrCmfnEbgEtSeEBy1
         QrEN6VTIYYjoBriWs+lFf6bcI0XU3NTJs+QiytJDd+v6aC/Ed4Cplc/9nKeYKgWvkYIx
         htwJaJgNSEUbNkjXU/ZG2E9BANKJ6XkbyCb35TNBSpN6ya+9iqlXkB7Qg9CzVn1yVdBW
         0WFA==
X-Forwarded-Encrypted: i=1; AJvYcCVt04DBHMGitPhNdFxzYNNfIOQAzuE1hZS1kJHaPUKGpOLp70+k8xjfmHRjNlV9Bq3pRvCMmlK6/t+ws7wO3CERtGebjuJa0ydE2Knk+X6QrdEdNfkQ/zRol5H4AoIHmb3J
X-Gm-Message-State: AOJu0Ywp2vnS/GFCuU5SpAlgdodzDgNWtoJpSg1zDEetb7LCG8+FcfVT
	w/boFauux1+OLYmoUWR+Md5M+BMzVFlnKTs/KKttXn3mQcjIlK/qF05ksWFI3PZ65KuuaMpRaV2
	8evQKwLGw/Dz5q9QHJBIPa+ZaF7k=
X-Google-Smtp-Source: AGHT+IH4j28uyhCCp51xP1X5ObgHfPjb7XMEiZmcd9u+YRthVMtC338rqCEkv5JXCy0op0kyt4VhpIiJAKqKSNODiYU=
X-Received: by 2002:a5d:6da5:0:b0:346:42d5:2d86 with SMTP id
 u5-20020a5d6da5000000b0034642d52d86mr97469wrs.46.1712854010316; Thu, 11 Apr
 2024 09:46:50 -0700 (PDT)
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
 <ZheFp_Sf66DpaFFm@nanopsycho>
In-Reply-To: <ZheFp_Sf66DpaFFm@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 11 Apr 2024 09:46:13 -0700
Message-ID: <CAKgT0UdepdJZ=QMxaAtquuUM421jkXsj8km588rooFpZRgbuVQ@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jiri Pirko <jiri@resnulli.us>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, 
	John Fastabend <john.fastabend@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:39=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Wed, Apr 10, 2024 at 11:07:02PM CEST, alexander.duyck@gmail.com wrote:
> >On Wed, Apr 10, 2024 at 1:01=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> >>
> >> On Wed, Apr 10, 2024 at 08:56:31AM -0700, Alexander Duyck wrote:
> >> > On Tue, Apr 9, 2024 at 4:42=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> =
wrote:
> >> > >
> >> > > > What is less clear to me is what do we do about uAPI / core chan=
ges.
> >> > >
> >> > > I would differentiate between core change and core additions. If t=
here
> >> > > is very limited firmware on this device, i assume Linux is managin=
g
> >> > > the SFP cage, and to some extend the PCS. Extending the core to ha=
ndle
> >> > > these at higher speeds than currently supported would be one such =
core
> >> > > addition. I've no problem with this. And i doubt it will be a sing=
le
> >> > > NIC using such additions for too long. It looks like ClearFog CX L=
X2
> >> > > could make use of such extensions as well, and there are probably
> >> > > other boards and devices, maybe the Zynq 7000?
> >> >
> >> > The driver on this device doesn't have full access over the PHY.
> >> > Basically we control everything from the PCS north, and the firmware
> >> > controls everything from the PMA south as the physical connection is
> >> > MUXed between 4 slices. So this means the firmware also controls all
> >> > the I2C and the QSFP and EEPROM. The main reason for this is that
> >> > those blocks are shared resources between the slices, as such the
> >> > firmware acts as the arbitrator for 4 slices and the BMC.
> >>
> >> Ah, shame. You took what is probably the least valuable intellectual
> >> property, and most shareable with the community and locked it up in
> >> firmware where nobody can use it.
> >>
> >> You should probably stop saying there is not much firmware with this
> >> device, and that Linux controls it. It clearly does not...
> >>
> >>         Andrew
> >
> >Well I was referring more to the data path level more than the phy
> >configuration. I suspect different people have different levels of
> >expectations on what minimal firmware is. With this hardware we at
> >least don't need to use firmware commands to enable or disable queues,
> >get the device stats, or update a MAC address.
> >
> >When it comes to multi-host NICs I am not sure there are going to be
> >any solutions that don't have some level of firmware due to the fact
>
> A small linux host on the nic that controls the eswitch perhaps? I mean,
> the multi pf nic without a host in charge of the physical port and
> swithing between it and pf is simply broken design. And yeah you would
> probably now want to argue others are doing it already in the same way :)
> True that.

Well in our case there isn't an eswitch. The issue is more the logic
for the Ethernet PHY isn't setup to only run one port. Instead the PHY
is MUXed over 2 ports per interface, and then the QSFP interface
itself is spread over 4 ports.

What you end up with is something like the second to last image in
this article[1] where you have a MAC/PCS pair per host sitting on top
of one PMA with some blocks that are shared between the hosts and some
that are not. The issue becomes management of access to the QSFP and
PHY and how to prevent one host from being able to monopolize the
PHY/QSFP or crash the others if something goes sideways. Then you have
to also add in the BMC management on top of that.

[1]: https://semiengineering.com/integrated-ethernet-pcs-and-phy-ip-for-400=
g-800g-hyperscale-data-centers/

