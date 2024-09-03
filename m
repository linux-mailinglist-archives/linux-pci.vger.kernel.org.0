Return-Path: <linux-pci+bounces-12652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0536A969922
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 11:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D40283E7C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59918786B;
	Tue,  3 Sep 2024 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ID+2qPcP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C61D0942
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355989; cv=none; b=thH6jgIRDpUoWcY8tqApODecso30ElAxxR5Bm2RPzFc3bKd1v7Uq+d7QdumIL1rAeA3bIUXjwnfHRtsonycJXhkZYx6AO4B0yA/2eU2x2dkvJfZtgRpjGfiOC2nLuyWRlqVjY0yas7kDxXq2rl4w6/uTnLNGJLB/fMyVTPFwf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355989; c=relaxed/simple;
	bh=9bwQymfzf4ndqd3FHXuhSQAaB8hV+38lgAKZNuAsONE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB+5bGF4uMg5U2ichV4YjCcEz9n6efzNtDkBP+83RrnoqFZLHgdnQY+z/BTc4pAWSp4OGKgNL01eTYHqyB1nh+sZ7Ql49hXswg47eUFBIS+qCSjUrfZOO66Fmg/IDr++NZW7JlwDaioRLLnX7LfZQ23auj5Z1k4RDPkSRse+aC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ID+2qPcP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a80eab3945eso460514866b.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725355985; x=1725960785; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wTnKFrfUmE/uIkrL7Z9DoBSa27AtxRfrH2Z2SWNCR6U=;
        b=ID+2qPcPviliUAh87/JIQZz+GwIz0+ikXhuwcYGZa9KU6XMlIU8hFqVZRSbEdsPIqr
         MZ78jllU9dwC2lQ7yQsdVW9FRGjchQFvttzbA8u9FExn48Ek0g8SwUcTUp6kABIsboFJ
         p4N4aWiEW0akaDfCUe+a/XbTz0mC65VUvR6UxL93A7ImF5ivD7UTiuPVUm1cGNzWM514
         xPQfTF0sp6IBRDO/nNmPZd3k8qjC1RGxuwvbITv5tPpgzgva7ucgxfmgn98mN7dhFPnC
         AOkbFRyJv6vQJSMupMAO1d7rVN2dxZAPCccFCd6xrJi3fMINK4Xy6po0g50gS0w3rNZT
         0yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725355985; x=1725960785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTnKFrfUmE/uIkrL7Z9DoBSa27AtxRfrH2Z2SWNCR6U=;
        b=SNxR2wOCEQb1nfhLqPlcSvYjBwsFMkry2/y68AzMwwPz1JnVE/62HsdwMlj3zZ7Q7n
         55NnA7eHF6wCuJ/5UDtCes+5w/l+OnfvzPJsEyNKySKJj3sDyLMlCjtQ7V6ucLi36VjI
         M9P/09pp3y2VD4pS8eCpNvU6rX1rpQ8gEh3usZNN+EIRL8qakB5t1xjVPMrp4o2Uo+5C
         pussatHhyeJBeG47rvcmmq94hsgCdP/oMLOmtUgUNHwM0ht8VMgdQYOzMBPxp8PDtj2d
         qdnQEp0RhB1tkI2dqVkJMELIZmAQ5ldX3nhZXe+CvEpFot9D3Gx9iaZfhFg+tTkVnGbb
         k3iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbN7RejN7Vw0T0owgfxjP56ROjfZCdlT9P2E1Gaqa+dKK1JoG6g7gzSUxv9CmLZDiPo97GLXss4XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAAmMpxjj9OBqkRnfhxxQZr7Ek1Mafu5AnUbZv0lbfGqTiBe5W
	kA9ESqBR92/1NoKHDTYKNTajsi07xKFI9B4DHooXN3Q/sLrhLr3qD/sDGE1RFq8=
X-Google-Smtp-Source: AGHT+IF1reVINALdSgJc0RMsY6rt9TxEJ4rR+Xojf3y9r57wj6wnX0V9PBsi2NJ940berEZ0OfsA7Q==
X-Received: by 2002:a17:907:72c7:b0:a86:a30f:4aef with SMTP id a640c23a62f3a-a89a35dee4cmr901597466b.22.1725355985011;
        Tue, 03 Sep 2024 02:33:05 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988bdcf57sm659603066b.0.2024.09.03.02.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:33:04 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 3 Sep 2024 11:33:12 +0200
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
	Stefan Wahren <wahrenst@gmx.net>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 04/11] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
Message-ID: <ZtbX2NZ6A6ATqQLh@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>
 <20240821001618.GA2309328-robh@kernel.org>
 <ZsWi86I1KG91fteb@apocalypse>
 <CAL_JsqKN0ZNMtq+_dhurwLR+FL2MBOmWujp7uy+5HzXxUb_qDQ@mail.gmail.com>
 <ZtBJ0jIq-QrTVs1m@apocalypse>
 <CAL_Jsq+_-m3cjTRsFZ0RwVpot3Pdcr1GWt-qiiFC8kQvsmV7VQ@mail.gmail.com>
 <ZtChPt4cD8PzfEkF@apocalypse>
 <CAL_JsqJNcZx-HH-TJhsNai2fqwPJ+dtcWTdPagRjgqM31wsJkA@mail.gmail.com>
 <20240903110953.2b1f55b6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903110953.2b1f55b6@bootlin.com>

Hi Herve,

On 11:09 Tue 03 Sep     , Herve Codina wrote:
> Hi,
> 
> On Fri, 30 Aug 2024 14:37:54 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> ...
> 
> > > this view is much like Bootlin's approach, also my pci-ep-bus node now would look
> > > like this:
> > >  ...
> > >  pci-ep-bus@0 {
> > >         ranges = <0xc0 0x40000000
> > >                   0x01 0x00 0x00000000
> > >                   0x00 0x00400000>;
> > >         ...
> > >  };
> > >
> > > and also the correct unit address here is 0 again, since the parent address in
> > > ranges is 0x01 0x00 0x00000000 (0x01 is the flags and in this case represent
> > > BAR1, I assume that for the unit address I should use only the address part that
> > > is 0, right?).  
> > 
> > No, it should be 1 for BAR1. It's 1 node per BAR.
> 
> It should be 1 node per BAR but in some cases it is not.
> 
> Indeed, in the LAN966x case, the pci-ep-bus need to have access to several
> BARs and we have:

I second this, on RP1 there are multiple BARs too, but for this minimal
implementation we need only one. Splitting them in one bus per BAR or
merging them with multiple ranges entries depend on whether the peripherals
can access different BARs simultaneously. Besides this contraint, I would
say both approach are viable.

> 	...
> 	pci-ep-bus@0 {
> 		compatible = "simple-bus";
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 
> 		/*
> 		 * map @0xe2000000 (32MB) to BAR0 (CPU)
> 		 * map @0xe0000000 (16MB) to BAR1 (AMBA)
> 		 */
> 		ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
> 		          0xe0000000 0x01 0x00 0x00 0x1000000>;
> 	...
> 
> Some devices under this bus need to use both BARs and use two regs values
> in their reg properties to access BAR0 and BAR1.
> 
> 
> > > > > > The assumption so far with all of this is that you have some specific
> > > > > > PCI device (and therefore a driver). The simple-buses under it are
> > > > > > defined per BAR. Not really certain if that makes sense in all cases,
> > > > > > but since the address assignment is dynamic, it may have to. I'm also
> > > > > > not completely convinced we should reuse 'simple-bus' here or define
> > > > > > something specific like 'pci-bar-bus' or something.  
> > > > >
> > > > > Good point. Labeling a new bus for this kind of 'appliance' could be
> > > > > beneficial to unify the dt overlay approach, and I guess it could be
> > > > > adopted by the aforementioned Bootlin's Microchip patchset too.
> > > > > However, since the difference with simple-bus would be basically non
> > > > > existent, I believe that this could be done in a future patch due to
> > > > > the fact that the dtbo is contained into the driver itself, so we do
> > > > > not suffer from the proliferation that happens when dtb are managed
> > > > > outside.  
> > > >
> > > > It's an ABI, so we really need to decide first.  
> > >
> > > Okay. How should we proceed?  
> > 
> > I think simple-bus where you have it is fine. It is really 1 level up
> > that needs to be specified. Basically something that's referenced from
> > the specific PCI device's schema (e.g. the RP1 schema (which you are
> > missing)).
> > 
> > That schema needs to roughly look like this:
> > 
> > properties:
> >   "#address-cells":
> >     const: 3
> >   "#size-cells":
> >     const: 2
> >   ranges:
> >     minItems: 1
> >     maxItems: 6
> >     items:
> >       additionalItems: true
> >       items:
> >         - maximum: 5  # The BAR number
> >         - const: 0
> >         - const: 0
> >         - # TODO: valid PCI memory flags
> > 
> > patternProperties:
> >   "^bar-bus@[0-5]$":
> >     type: object
> >     additionalProperties: true
> >     properties:
> >       compatible:
> >         const: simple-bus
> >       ranges: true
> > 
> 
> IMHO, the node should not have 'bar' in the name.
> In the LAN966x PCI use case, multiple BARs have to be accessed by devices
> under this simple-bus. That's why I choose pci-ep-bus for this node name.
>

Agreed for your scenario. Anyway, since the dtbo and driver are shipped together,
we are free to change the name anytime without impacting anything.

Many thanks,
Andrea
 
> Best regards,
> Hervé

