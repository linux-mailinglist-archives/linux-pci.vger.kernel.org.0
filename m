Return-Path: <linux-pci+bounces-12855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9108996E27F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 20:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE6FEB26DA0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 18:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5519DFB8;
	Thu,  5 Sep 2024 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bppyafcJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50625199237
	for <linux-pci@vger.kernel.org>; Thu,  5 Sep 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725562457; cv=none; b=ieKwh/fd4PFPOnXpiUUYGhwAyHFA6oyetO7vNxuli7Es+b1QqDSElj15RnD4fliqBunvXf60X054NzzDnUxDd2hztqBq+VPpMbPNvhZvyYOC6110EIJSVQyeU9d4tfnuefLj2Kv1bgaG7SuirpR+4yTD1tRo9ZL+PreYftvFQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725562457; c=relaxed/simple;
	bh=+X3EGBbsnfThSA6bfkbEMEawCDcd9CImfSQq8Sv6HaI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeI9IMe1e7jQISz+0iHB2geYraHihgfq/+2Lx0h4ET8aIuH0leVY76NhEjbVBqq/e9eZgcf1/+w9rmBVWjRA9ilM6KURWPACWCyK7d+TD1aE6xFYmY+4HcGplaFuQKFi1hbhz4akYxZg8pbmICvwu1tv2eNlXiAQo/Ij2gNdmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bppyafcJ; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a86a37208b2so168361366b.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2024 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725562454; x=1726167254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RxABoZy7M/TZG8opuKEUGg9PIAepW4IWO/Hnr8c+uSo=;
        b=bppyafcJoWlFgS8M2UEohwoJYcIWa32E1DW48VgOBaEV/dvI4G0dIdbhmRkujthpK/
         XivKiGFCzh37sUL3g5wMcIK5RYUNXcSoDxSIYJpbW16wBkOUN9eT+9MDETM8yeZOLzhx
         7bOL4qh4ZD9+M+XXikQI0pLTZbH3EO8wHRL5f1D5wEq2K3Meh3ZYbOhBMxw2ioIeb/wU
         aaiAHgns6/6NQockmvPY4ZiaMfpitnOxDjaKsMo0VcghnTsI16h3hXg9FlLmwcwXrJN1
         debI9J+wlOAeXnn6EaqSRyTvuNzO9zcQBKN3xe9VculiteYxvcIMweeueic6SIVQtlb8
         h0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725562454; x=1726167254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxABoZy7M/TZG8opuKEUGg9PIAepW4IWO/Hnr8c+uSo=;
        b=wZZ8NiR5YAY0qnzV9smFwtLsObpkTbTBr3A75pgnPwKwvMw/sTK4f0cErAoWjHr82s
         W9Q44nrDtvVsRFhGCbyaS1XQqJ5eNLBrWAQOOqNqSzRD2ybllfFOTHNaf8oxm8n6xcUT
         HFjtGYVPvb1F6jC9ayFgn2udS7jKXYpN657dVe77OUtxDsLrOshxhzZj56AYyjGq9uUP
         0QDRs2aWmIxeEZCf+qUv2EqHvPE7aLXgVCNms3G/sFoNAKMoZ7/J4C50EKCNguZhiGNi
         2/u9qV+uGTUbp6QONrAgZexcndWt3xQoA67tLhZekdSHb2/9vrNZoup120tNKCty/4XN
         OeSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGD0EHZyh4mMm285T8zcmPOlm7HDmNH8VLkwFli49qDPU6VSpWoT2YC8D9ppQ/6bUlwgJ1UsUJFEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4My9185AWPepfMhSVaQ4k6yjr2uXevLNODG1dnAxxKi/oVE7
	kTEtJSn0fqJEr9//NR5B2kDknxaCPoW05xOImw0C+pzpwJjuEtek5fBn3n/qmZY=
X-Google-Smtp-Source: AGHT+IFjEgRGyH+GaPbngGsdDcuBB5u6KOKaz4oCTouY+y9qZ4ACBcA78wca7rCiKJ55uLq+Ab/vJw==
X-Received: by 2002:a17:907:9486:b0:a86:b042:585a with SMTP id a640c23a62f3a-a897fad5108mr2030528766b.57.1725562452809;
        Thu, 05 Sep 2024 11:54:12 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62038d8bsm168982266b.64.2024.09.05.11.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:54:12 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 5 Sep 2024 20:54:20 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <Ztn-XOvtk_d3U6XJ@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <lrv7cpbt2n7eidog5ydhrbyo5se5l2j23n7ljxvojclnhykqs2@nfeu4wpi2d76>
 <ZtHN0B8VEGZFXs95@apocalypse>
 <b74327b8-43f6-47cf-ba9d-cc9a4559767b@kernel.org>
 <ZtcoFmK6NPLcIwVt@apocalypse>
 <39735704-ae94-4ff8-bf4d-d2638b046c8e@kernel.org>
 <ZtndaYh2Faf6t3fC@apocalypse>
 <f39edf3d-aa9e-43a0-8997-762d76c9c248@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f39edf3d-aa9e-43a0-8997-762d76c9c248@kernel.org>

Hi Krzysztof,

On 18:52 Thu 05 Sep     , Krzysztof Kozlowski wrote:
> On 05/09/2024 18:33, Andrea della Porta wrote:
> > Hi Krzysztof,
> > 
> > On 20:27 Tue 03 Sep     , Krzysztof Kozlowski wrote:
> >> On 03/09/2024 17:15, Andrea della Porta wrote:
> >>>>>>> +
> >>>>>>> +				rp1_clocks: clocks@c040018000 {
> >>>>>>
> >>>>>> Why do you mix MMIO with non-MMIO nodes? This really does not look
> >>>>>> correct.
> >>>>>>
> >>>>>
> >>>>> Right. This is already under discussion here:
> >>>>> https://lore.kernel.org/all/ZtBzis5CzQMm8loh@apocalypse/
> >>>>>
> >>>>> IIUC you proposed to instantiate the non-MMIO nodes (the three clocks) by
> >>>>> using CLK_OF_DECLARE.
> >>>>
> >>>> Depends. Where are these clocks? Naming suggests they might not be even
> >>>> part of this device. But if these are part of the device, then why this
> >>>> is not a clock controller (if they are controllable) or even removed
> >>>> (because we do not represent internal clock tree in DTS).
> >>>
> >>> xosc is a crystal connected to the oscillator input of the RP1, so I would
> >>> consider it an external fixed-clock. If we were in the entire dts, I would have
> >>> put it in root under /clocks node, but here we're in the dtbo so I'm not sure
> >>> where else should I put it.
> >>
> >> But physically, on which PCB, where is this clock located?
> > 
> > xosc is a crystal, feeding the reference clock oscillator input pins of the RP1,
> > please see page 12 of the following document:
> > https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> 
> That's not the answer. Where is it physically located?

Please see below.

> 
> > On Rpi5, the PCB is the very same as the one on which the BCM2712 (SoC) and RP1
> > are soldered. Would you consider it external (since the crystal is outside the RP1)
> > or internal (since the oscillator feeded by the crystal is inside the RP1)?
> 
> So it is on RPi 5 board? Just like every other SoC and every other
> vendor? Then just like every other SoC and every other vendor it is in
> board DTS file.

Yes it's on the Rpi5 board. These are two separate thing, though: one is where
to put it (DTS, DTSO) and another is in what target path relative to root. I
was trying to understand the latter.
The clock node should be put in the DTBO since we are loading this driver at
runtime and we probably don't want to depend on some specific node name to be
present in the DTS. This is also true because this driver should possibly work
also on ACPI system and on hypothetical PCI card on which the RP1 could be mounted
in the future, and in that case a DTS could be not even there. 
After all, those clocks must be in the immediate proximity to the RP1, and on the
same board, which may or may not be the main board as the Rpi5 case.
I think that, since this application is a little bit peculiar, maybe some
compromises could be legit.

> 
> > 
> >>
> >>>
> >>> Regarding pclk and hclk, I'm still trying to understand where they come from.
> >>> If they are external clocks (since they are fixed-clock too), they should be
> >>> in the same node as xosc. CLK_OF_DECLARE does not seem to fit here because
> >>
> >> There is no such node as "/clocks" so do not focus on that. That's just
> >> placeholder but useless and it is inconsistent with other cases (e.g.
> >> regulators).
> > 
> > Fine, I beleve that the root node would be okay then, or some other carefully named
> > node in root, if the clock is not internal to any chip.
> > 
> >>
> >> If this is external oscillator then it is not part of RP1 and you cannot
> >> put it inside just to satisfy your drivers.
> > 
> > Ack.
> > 
> >>
> >>> there's no special management of these clocks, so no new clock definition is
> >>> needed.
> >>
> >>> If they are internal tree, I cannot simply get rid of them because rp1_eth node
> >>> references these two clocks (see clocks property), so they must be decalred 
> >>> somewhere. Any hint about this?.
> >>>
> >>
> >> Describe the hardware. Show the diagram or schematics where is which device.
> > 
> > Unfortunately I don't have the documentation (schematics or other info) about
> > how these two clocks (pclk and hclk) are arranged, but I'm trying to get
> > some insight about that from various sources. While we're waiting for some
> > (hopefully) more certain info, I'd like to speculate a bit. I would say that
> > they both probably be either external (just like xosc), or generated internally
> > to the RP1:
> > 
> > If externals, I would place them in the same position as xosc, so root node
> > or some other node under root (eg.: /rp1-clocks)
> 
> Just like /clocks, /rp1-clocks is not better. Neither /rp1-foo-clocks.

Right. So in this case, since xosc seems to be on the same level and on the same
board of the RP1 and the SoC, and it's also external to the RP1, can I assume that
placing xosc node in root is ok?

> 
> I think there is some sort of big misunderstanding here. Is this RP1
> co-processor on the RP board, connected over PCI to Broadcom SoC?

Yes. 

 ---------------Rpi5 board---------------------
 |                                            |
 |    SoC ==pci bus==> RP1 <== xosc crystal   |
 |                                            |
 ----------------------------------------------

> 
> > 
> > If internals, I would leave them just where they are, i.e. inside the rp1 node
> > 
> > Does it make sense?
> 
> No, because you do not have xosc there, according to my knowledge.

Hmmm sorry, not sure what this negation was referring to... I was talking about
hclk and pclk, not xosc here. Could you please add some details?

Many thanks,
Andrea

> 
> Best regards,
> Krzysztof
> 

