Return-Path: <linux-pci+bounces-12130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A180695D418
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 19:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570852842AE
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5426A18E035;
	Fri, 23 Aug 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fXIE0q43"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7E18C330
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433358; cv=none; b=iSVSycmKZhQZyjhe+ceRtV4ifmkJjurhYmA3balwv8TAPgzeRD9AeII274nGnJN+EzrUvzAVLIPCfUVLFBy2EDV38DyLItLKCQk/av6mJMSjXpsBuVSsxO2zsNV0/wXqK44j4DBTaQ8zVwxqoG7wiqsZFI7YG9RX1yMwCd5BoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433358; c=relaxed/simple;
	bh=VPZAtg08Wy5/FG+Kj/wTZuQQZpFnItvR2PIwTa5Vc/I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxdDQO4RTVBBVxwNodgUXlQSKJcaRtWtdtzN8Vq3OEaboI6hlE6/CsUIhu4o40CraSSmFmMnCxGGGy+VjOyECcVFy0CFfVHY51ReOyPk1r1aGAytvBau8KB+5ObCY5e7gGxSTn2FsH6V50TnPBkPOIaLN2kOTEeN/mktBmlZycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fXIE0q43; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bf0261f162so2927844a12.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724433355; x=1725038155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5kboO0j45Is859BAgD4iFoFAta2hgxS6Xgur8E+680=;
        b=fXIE0q43JG/afuGoJEo+1ZFmAZyWLPTmqGuQgqMJ/4lFrRm0qZuHBzQqU5pb+FghpW
         h9I+J8sE1cbOerZ1XocD/Dsjwv0sbkDb32VVtnF1twJKGQ21qxpF9uoorvT2sCcHwf+f
         E68DXoobn8xvzK4zt9C+WC6FwLmWrhsoMdKaO9jWeCLyYa4VSPEBQifovEROjvrizcCJ
         zdYaEmq2IsAmQ6sS1DHygrF7Deu/CD1RCjMmo5B0fHQbG3J5ndKE/SQDnbvlvUfpdMbU
         1mEq6JtTvaicqO++blC68QVaO4O2PyziwJPlE3P24TJ8Dfy6CkEplcuE68KAAQANAHAi
         nrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724433355; x=1725038155;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5kboO0j45Is859BAgD4iFoFAta2hgxS6Xgur8E+680=;
        b=w1iNaYPk7L2IchZoJzAju0tnz1iTlaqC05tFsNFsMcL2VeJnX8hM2yVqsPpJcKHYfX
         vwt8e12q7/lyc5khv/1hVTZgWIPxr6wXNrddefbXwS3pWr9HW+kCKBdF0UH1Qz5FlHoD
         enTnoKt59GdPcrluhM3zKlfjrNJoEqzaXM14sDbRmAPJlLVFIwdHysTiWIcLEjP+I9WZ
         m5h7L9kDDJyJjkI5Cmxasumbuo/flXMc18uQtnCDN4BYZqYdp8ws+Ome4Q9ZC9VklUZe
         p0SAsnS5AgVNT0jkRiD5gh0ZDOsegPZLkPVqIhhMbiE3DWhGnnQ3+seyCeh/b+0YU+g5
         OKdg==
X-Forwarded-Encrypted: i=1; AJvYcCXf1WECaKf42U8uNI4PzfyTwbtk174Qkh7vSnXtdSj0Ek+DQhwoEVXzF8+WFClK44thDNlqgmo9cOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJCm4Pzx9kS9nuZZEhN9puq7gPuGGvpxMA+pyg8/+nIOd5qIE
	cU+xMm3U/Wrm2cRdfiYKQYgcKvowYfuFXl8zGc/nC/BNDeidXP5sYHcDPTvkGH4=
X-Google-Smtp-Source: AGHT+IGi+ju94qIZV+5dh+FC4edd1LJS/Rb5jnDSsIsgwxHk/+itiIP1aidxM/8be626D3wcbLPt/A==
X-Received: by 2002:a17:907:2d0a:b0:a86:7199:af37 with SMTP id a640c23a62f3a-a86a54f142dmr198119466b.58.1724433354052;
        Fri, 23 Aug 2024 10:15:54 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4862e8sm287339466b.173.2024.08.23.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:15:53 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 23 Aug 2024 19:16:00 +0200
To: Simon Horman <horms@kernel.org>
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
Subject: Re: [PATCH 07/11] pinctrl: rp1: Implement RaspberryPi RP1 gpio
 support
Message-ID: <ZsjD0C8oYmUi5I7n@apocalypse>
Mail-Followup-To: Simon Horman <horms@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
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
References: <cover.1724159867.git.andrea.porta@suse.com>
 <eb39a5f3cefff2a1240a18a255dac090af16f223.1724159867.git.andrea.porta@suse.com>
 <20240821132754.GC6387@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821132754.GC6387@kernel.org>

On 14:27 Wed 21 Aug     , Simon Horman wrote:
> On Tue, Aug 20, 2024 at 04:36:09PM +0200, Andrea della Porta wrote:
> > The RP1 is an MFD supporting a gpio controller and /pinmux/pinctrl.
> > Add minimum support for the gpio only portion. The driver is in
> > pinctrl folder since upcoming patches will add the pinmux/pinctrl
> > support where the gpio part can be seen as an addition.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> 
> ...
> 
> > diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
> 
> ...
> 
> > +const struct rp1_iobank_desc rp1_iobanks[RP1_NUM_BANKS] = {
> > +	/*         gpio   inte    ints     rio    pads */
> > +	{  0, 28, 0x0000, 0x011c, 0x0124, 0x0000, 0x0004 },
> > +	{ 28,  6, 0x4000, 0x411c, 0x4124, 0x4000, 0x4004 },
> > +	{ 34, 20, 0x8000, 0x811c, 0x8124, 0x8000, 0x8004 },
> > +};
> 
> rp1_iobanks seems to only be used in this file.
> If so, it should be static.

Fixed, thanks.

> 
> Flagged by Sparse.
> 
> ...

