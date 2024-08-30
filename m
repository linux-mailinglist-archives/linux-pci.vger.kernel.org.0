Return-Path: <linux-pci+bounces-12486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19B99656D6
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 07:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF51B23004
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 05:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C4B14F135;
	Fri, 30 Aug 2024 05:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GsFkRnyD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6D14AD2D
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 05:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724995271; cv=none; b=EC/0YJfiUQl2rbg5pMtD+qa2unxSpEzSWVST3x/1ctSXQNx5b/QttUew8moExM1jOqbQaHxIk6YlCGuwUien64gbMDGtUV1djFcRQCwSROL5DaHrRZHBvpJraeqfnNR7GsBduS3aCwemR4vYiBPBp9kV6CsbSfg2nyEvsxwOe0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724995271; c=relaxed/simple;
	bh=jtf7PV5qM5aW2ZTufnYu/xPa7oOq40+0/uQGqTwb61k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBqyRKPnnavVYbXZOj8hXOyth5/M22vF6THRXUr8kLr/5uP1jfRy0WL3AfdI/saoGhHS53PDSwlw5p9uoF26yPxl3bzbaJImubqzBJ5qKSszeI81IyTOo9u1x6yJYQFB90ywkxhE7/6TGmpEJjVR0bcXot79UtLtJ88RsprE+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GsFkRnyD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86a37208b2so166997366b.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 22:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724995267; x=1725600067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GExFSIDcR+m296qL0+T8lfbyMBHXGvoOKDeyXebihgs=;
        b=GsFkRnyDx48N26VCklfdB2GSObBJ3t8yj/CrliklVlkfQn3wrBQGaceW/ki3DjbDcx
         1A3SybfgZCfcPvhsmS37VUfaCM3IXhnu9xeLOSbPRek9Y3wiv1/Q7Zomq95opPya7Uzo
         0Zh2qm1famEmU79YhHqopS24/5GvaxxjrTk3cNsN1S9ZLIJkdCKo5dMgfL1OgAbUNXnn
         LqGDntT2J7eVsAiBd1mP6ZWrSKUdbakMlSganQZbjRZjS2M1+WXhEIAi3MZBhp5nl3vW
         wO8JZ9JlJ38w1TEGMjk53Tjkiv31euGaL2Nuuzv9NjbTCzOsu/RMJOo/4/8fuq1B4rno
         ouBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724995267; x=1725600067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GExFSIDcR+m296qL0+T8lfbyMBHXGvoOKDeyXebihgs=;
        b=Cu0OuHfqQaLAA3bpZnEHhjuwybFgAKGC5301ylxcWG3ZtMiP+AG2mfxQa0yu62enld
         js1MHN1Ukkj7zpaeBNcbol4/AT3WQ4hcb6YqmA0d4GfgSwqVC1Z7kgVLLeT0dx8ejiBw
         6wAsNm+XrQXtil+aeAXmd612hQO2GfaHGweQRK+qjjwIdRCUfHf6keGBcJv/BmTxwihM
         hsnNKlS820Ejyc/LKCby7PCwVE2COqU8Mobo+wcn7JpjPOEtV21yIUg5rzH9NMZIE/gU
         MJvJQ2Ne9m0mfJy4X05W+co1MCYFVf8WFcsUAD2aSQBePCmxbRzk9EAirfSRZC/jrCNI
         6N/A==
X-Forwarded-Encrypted: i=1; AJvYcCXiBqTKFP2NvT+Hh7CKlE8n+OxmI4Xo3M9mcp9cU/H5idUpXXomGJFLSD3KZSlqLgzAYNBMSuw0UZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dg6+fOLYbrW/f4gpqmwkagmIf38HR0dST+DDSD6035k/ptuq
	qjVhzuuGqr+B33OUyIEgdeM6ZHIzcrj073ivD0qxH2YpOexS/liFWy3iBaJ+aZ4=
X-Google-Smtp-Source: AGHT+IF7+hVzizb5h2RAOKpmPeEAucZHJJ8SE3J6cbyAO0CAecmSuqQGdIsglF6MfVFAtKQonNztKg==
X-Received: by 2002:a17:907:7da8:b0:a86:8b7b:7880 with SMTP id a640c23a62f3a-a897fad50fdmr358086866b.63.1724995265995;
        Thu, 29 Aug 2024 22:21:05 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988ff4233sm166746966b.25.2024.08.29.22.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 22:21:05 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 30 Aug 2024 07:21:12 +0200
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
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
	Lee Jones <lee@kernel.org>, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/11] Add support for RaspberryPi RP1 PCI device using a
 DT overlay
Message-ID: <ZtFWyAX_7OR5yYDS@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <14990d25-40a2-46c0-bf94-25800f379a30@kernel.org>
 <Zsb_ZeczWd-gQ5po@apocalypse>
 <45a41ed9-2e42-4fd5-a1d5-35de93ce0512@lunn.ch>
 <ZtBjMpMGtA4WfDij@apocalypse>
 <e6e6c230-370f-4b04-8cb7-4158dd51efdc@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6e6c230-370f-4b04-8cb7-4158dd51efdc@lunn.ch>

Hi Andrew,

On 15:04 Thu 29 Aug     , Andrew Lunn wrote:
> > > > WARNING: externs should be avoided in .c files
> > > > #331: FILE: drivers/misc/rp1/rp1-pci.c:58:
> > > > +extern char __dtbo_rp1_pci_begin[];
> > > > 
> > > > True, but in this case we don't have a symbol that should be exported to other
> > > > translation units, it just needs to be referenced inside the driver and
> > > > consumed locally. Hence it would be better to place the extern in .c file.
> > >  
> > > Did you try making it static.
> > 
> > The dtso is compiled into an obj and linked with the driver which is in
> > a different transaltion unit. I'm not aware on other ways to include that
> > symbol without declaring it extern (the exception being some hackery 
> > trick that compile the dtso into a .c file to be included into the driver
> > main source file). 
> > Or probably I'm not seeing what you are proposing, could you please elaborate
> > on that?
> 
> Sorry, i jumped to the wrong conclusion. Often it is missing static
> keyword which causes warnings. However, you say it needs to be global
> scope.
> 
> Reading the warning again:
> 
> > > > WARNING: externs should be avoided in .c files
> 
> It is wanting you to put it in a .h file, which then gets
> included by the two users.

On a second thought, are you really sure we want to proceed with the header file?
After all the only line in it would be the extern declaration and the only one to
include it would be rp1-dev.c. Moreover, an header file would convey the false
premise that you can include it and use that symbol while in fact it should be
only used inside the driver.
OTOH, not creating that header file will continue to trigger the warning...

Many thanks,
Andrea

> 
> 	Andrew

