Return-Path: <linux-pci+bounces-12847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB30596DFE0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 18:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29D428DF7C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7571A0734;
	Thu,  5 Sep 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CwUDpRHu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371971A2878
	for <linux-pci@vger.kernel.org>; Thu,  5 Sep 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554022; cv=none; b=ab2QCgoNyYxKTxPhgnNxDciqMp+CDHHoW4T6IPpWVblgd7YwukDk90iN8a0M/DKtPoD+QZwBrDvhL+oz+GDxAU1KSEABrhpl7JsV0NJqlDRHs90OvcCJoLaNNqtsE2WL3n11EqF5jPboRZhAnaTp2kT8cdOVzyXP6MMHYmtJZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554022; c=relaxed/simple;
	bh=3NAVcB6qwQxaSWihdV8SEeK1WvVXg/JpPm7/aLNJ3gI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFGF5BFeY9s52PmgTTu7+UYIuiBA3pEONfBZj47r0L1HwlartuVMf0Tgj0h98OsrG+VdV69pQq6ehxwkTLKTFuFtlwo2x0bvu/2HmU5E7mVfaThk9FXsKOGtQ5v2nMuidagik/T86Ipx51UVXcrqVIc08Fpfir/now+s4N3YR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CwUDpRHu; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so1137427a12.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2024 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725554018; x=1726158818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kJHk6dVcMot+83fqcyHPWmLjMUPxP5z8vxp/ZBkDsTM=;
        b=CwUDpRHumS+xhjkOkSNcYkerUfHWVG+TzIQhXbhoKRrPX3T8LQnbOri7aQY0Mxr+hH
         zt9JN5f0NuQEW68wTKFZPMxsN0cTQnN277Bx5updO5jz6Mg0MfitxiCobve9Zgj29Wmj
         s1eNiGWZl0WErt/F4BipQoxnmWnLzxTNOGHpJu4fH+nCdUrkRfLK3o5126IeBhE5xGNq
         IbVS0h+UpD15k9HDTFTSEkc2nozDjTu5yhu8fLc+0zFX9uJd2fl+MAiXFdeCcW0xR08i
         PzGb93V+xzaO149I50uhyz0MgRfiEcgUtOmJ2VXPArnCtjCkEpl9ZuE2WXwJjroq8+z/
         AWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725554018; x=1726158818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJHk6dVcMot+83fqcyHPWmLjMUPxP5z8vxp/ZBkDsTM=;
        b=VOzfYUsA89c/m+vMmWEfHDfRsimlZCBcsly5xobd8m42IoflQLVagjuL632GLzPlzq
         pQPLMMQFQWFj6RyoxIYOJ1LZIQsa4Edlt/Cemfrenfufwy7IhYSVtV+nsUYn8Y8YGt6s
         o8mrM1MgGIvwIYyZOAX3a7Mv4fhtPxB6msyC389Kdmu4DeNLqLNR88yZ6UptzA96VQuf
         KG2w55VDktWBQOcUHZ7xzT0wytGEw9zRnAQ4In3K3Ity7a8cNKpb9CgrAOrXaBFCnelp
         IRQCX3XfGMPiDnJZnh+mDaSPqmxVqVP+E4nEH22Jab2ZfhJKlZ6BqJXir3KuoTRdVrAX
         KyRw==
X-Forwarded-Encrypted: i=1; AJvYcCVu8titRmeFkOLWHEH+CcSe0Xaxl7nLvvZYSPjkLwoiTn31blODJDALlPE6hP6gWS8MMnnYjAvK7GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1uzBlHTUrh6aLHa2o1yIN85jNnNea0e9DACfWiMZaKZV2cptY
	2k8iRak+I7rS1dwx07eyewrvG2Pu/tbiHl7K0tgIubmp7NsX113CibCKLp42I1o=
X-Google-Smtp-Source: AGHT+IHU/avyIpf1tRzphlO3ca0BhbKJKByf8ZqboDAgvuiywTcmj9UX7KVZcHdK/Ol0/Wbwf0Mx9g==
X-Received: by 2002:a05:6402:3226:b0:5c2:6bf7:8531 with SMTP id 4fb4d7f45d1cf-5c2caf33541mr5644250a12.33.1725554018023;
        Thu, 05 Sep 2024 09:33:38 -0700 (PDT)
Received: from localhost (host-80-182-198-72.pool80182.interbusiness.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc528bcfsm1430637a12.16.2024.09.05.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:33:37 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 5 Sep 2024 18:33:45 +0200
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
Message-ID: <ZtndaYh2Faf6t3fC@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <lrv7cpbt2n7eidog5ydhrbyo5se5l2j23n7ljxvojclnhykqs2@nfeu4wpi2d76>
 <ZtHN0B8VEGZFXs95@apocalypse>
 <b74327b8-43f6-47cf-ba9d-cc9a4559767b@kernel.org>
 <ZtcoFmK6NPLcIwVt@apocalypse>
 <39735704-ae94-4ff8-bf4d-d2638b046c8e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39735704-ae94-4ff8-bf4d-d2638b046c8e@kernel.org>

Hi Krzysztof,

On 20:27 Tue 03 Sep     , Krzysztof Kozlowski wrote:
> On 03/09/2024 17:15, Andrea della Porta wrote:
> >>>>> +
> >>>>> +				rp1_clocks: clocks@c040018000 {
> >>>>
> >>>> Why do you mix MMIO with non-MMIO nodes? This really does not look
> >>>> correct.
> >>>>
> >>>
> >>> Right. This is already under discussion here:
> >>> https://lore.kernel.org/all/ZtBzis5CzQMm8loh@apocalypse/
> >>>
> >>> IIUC you proposed to instantiate the non-MMIO nodes (the three clocks) by
> >>> using CLK_OF_DECLARE.
> >>
> >> Depends. Where are these clocks? Naming suggests they might not be even
> >> part of this device. But if these are part of the device, then why this
> >> is not a clock controller (if they are controllable) or even removed
> >> (because we do not represent internal clock tree in DTS).
> > 
> > xosc is a crystal connected to the oscillator input of the RP1, so I would
> > consider it an external fixed-clock. If we were in the entire dts, I would have
> > put it in root under /clocks node, but here we're in the dtbo so I'm not sure
> > where else should I put it.
> 
> But physically, on which PCB, where is this clock located?

xosc is a crystal, feeding the reference clock oscillator input pins of the RP1,
please see page 12 of the following document:
https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
On Rpi5, the PCB is the very same as the one on which the BCM2712 (SoC) and RP1
are soldered. Would you consider it external (since the crystal is outside the RP1)
or internal (since the oscillator feeded by the crystal is inside the RP1)?

> 
> > 
> > Regarding pclk and hclk, I'm still trying to understand where they come from.
> > If they are external clocks (since they are fixed-clock too), they should be
> > in the same node as xosc. CLK_OF_DECLARE does not seem to fit here because
> 
> There is no such node as "/clocks" so do not focus on that. That's just
> placeholder but useless and it is inconsistent with other cases (e.g.
> regulators).

Fine, I beleve that the root node would be okay then, or some other carefully named
node in root, if the clock is not internal to any chip.

> 
> If this is external oscillator then it is not part of RP1 and you cannot
> put it inside just to satisfy your drivers.

Ack.

> 
> > there's no special management of these clocks, so no new clock definition is
> > needed.
> 
> > If they are internal tree, I cannot simply get rid of them because rp1_eth node
> > references these two clocks (see clocks property), so they must be decalred 
> > somewhere. Any hint about this?.
> > 
> 
> Describe the hardware. Show the diagram or schematics where is which device.

Unfortunately I don't have the documentation (schematics or other info) about
how these two clocks (pclk and hclk) are arranged, but I'm trying to get
some insight about that from various sources. While we're waiting for some
(hopefully) more certain info, I'd like to speculate a bit. I would say that
they both probably be either external (just like xosc), or generated internally
to the RP1:

If externals, I would place them in the same position as xosc, so root node
or some other node under root (eg.: /rp1-clocks)

If internals, I would leave them just where they are, i.e. inside the rp1 node

Does it make sense?

Many thnaks,
Andrea

> 
> Best regards,
> Krzysztof
> 

