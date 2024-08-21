Return-Path: <linux-pci+bounces-11928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3519596D6
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 10:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFC31C21A04
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915BD1667C2;
	Wed, 21 Aug 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gSCQtxnS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A4188CDA
	for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228341; cv=none; b=A5JPsXa5MJhbQw5BsAewLPWbct1XYA1Sazip5y/UjJYH5Lo7cU72lUR0+2Oxgda82AXlU9zD8TzaqYO8lSvAuk17LdfNQukEoqU/ejxLcH/U9KXP6WRSilwnhccunfVHoZ3AbyPrmao1MuVzTYBkb7zbwpf9pdm+QMmlVHvpdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228341; c=relaxed/simple;
	bh=vvDhsaCryXbtPrm4x2WVrkEnasWmvVZ55jHbWMa9Atw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkOYbqevSFVXc3vYR9RqLWi6rlnfVt+e1xIOq5Xr5rIH9Bvt0+i8NoVbhJnvKBBIa3xpVGmxBZsRjM4feQlL19LDefOXSdVROQnk0a+LUjsj5fJYjnY1MIZ002DGLt2d0Exhz4Ue9pbiEEaSV0q+ER2x17j3p6Mb1l37XJwJPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gSCQtxnS; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533461323cdso1297777e87.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724228337; x=1724833137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WArzVvvD78lqDslWIGWtUOH/nDlCZabytUDmTejWvRw=;
        b=gSCQtxnSGHa0WQ1+ycKb7gQmJ2hTfUVEUhY8UxFm++8wjcHTwTqeXjx50NGsLCogWZ
         tivg42vqMmi9P65NpH1Yi2ZlecHUYnbGwep0OQy73UjRCBGX7i83Xby3DJR0+xa6SUpe
         Ow/ug67wqxCFq8Mx+jagvGl98PSzW01F5dhAsFAJy0/GRWWdkdOwdsvghUKMG+D60i5q
         jzaUZcSpvLdfZefUPFX1pfMjTvbVvn3yPjYBkr7ODefpE3t9NxndeN1KzGBnt/UZZqK0
         4XkkW0a4C6N0aAOKP7BfkSEomolkcA+FClPabzXH1EjSvOTu5pq4uQMDVbGJZm3cVu0O
         46vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228337; x=1724833137;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WArzVvvD78lqDslWIGWtUOH/nDlCZabytUDmTejWvRw=;
        b=Hovk3gThryoBNtiBpUuZQ4CUaQjn7m5Ee7CQufhxkjZBqkVQxYEYzdTMAiWgeoldZQ
         DLOcZ1GExBpTWVsSn6Te5Dxfu1u8+mxTgEDEOvsds2SdUjxnQrRgA4vKoy1+RZdm3Rrp
         V+3bOQlJhh+M+5Nql7kGA7TCIPcr4MjyWDqTtbPh4FljX+ISar8QYDbbzW9aNR3WOZC6
         TuWvaIC4eabdUSSGac67PtbcvsRLGTRkkS2+CQCVzyBXJEUUrg+5VkNFhfdKjY4Tp2qd
         eZ4/OmORcIX7OVFuV7+BUhMIuRgHnMpySxA/vy72Km84tPYXwLGVnYTsRwQuqO6Qj175
         Pt6g==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3gISBi4w1rFsobiNHbIEHN7dwz9iNb6K0eHLn3b0QcqP2gQiGad+2xAF0Wf61zdlINWhvV4zZWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh5Fi3EqP91iaHGubMQpXbfJELydIYzIMnXNTuvmTebfgcWynX
	rTeOrcZqeZW40TGhB0/DngLMFA00zDnDYtqsY9ddYfP/I5vHt+UJfFSyGKFYKPA=
X-Google-Smtp-Source: AGHT+IEL8Q9c8iW6LU5Zvu1ChEfBIQpUuvo6C3xns0qZKNHZdslM5QCPSgRla9iNvwZuRV2iyiygYA==
X-Received: by 2002:a05:6512:3092:b0:52e:f4b4:6ec1 with SMTP id 2adb3069b0e04-533485994fcmr644542e87.46.1724228336862;
        Wed, 21 Aug 2024 01:18:56 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33ef56adsm3210337b6e.50.2024.08.21.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:18:56 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 21 Aug 2024 10:18:59 +0200
To: Rob Herring <robh@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
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
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 04/11] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
Message-ID: <ZsWi86I1KG91fteb@apocalypse>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
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
	Stefan Wahren <wahrenst@gmx.net>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>
 <20240821001618.GA2309328-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821001618.GA2309328-robh@kernel.org>

Hi Rob,

On 19:16 Tue 20 Aug     , Rob Herring wrote:
> On Tue, Aug 20, 2024 at 04:36:06PM +0200, Andrea della Porta wrote:
> > A missing or empty dma-ranges in a DT node implies a 1:1 mapping for dma
> > translations. In this specific case, rhe current behaviour is to zero out
> 
> typo

Fixed, thanks!

> 
> > the entire specifier so that the translation could be carried on as an
> > offset from zero.  This includes address specifier that has flags (e.g.
> > PCI ranges).
> > Once the flags portion has been zeroed, the translation chain is broken
> > since the mapping functions will check the upcoming address specifier
> 
> What does "upcoming address" mean?

Sorry for the confusion, this means "address specifier (with valid flags) fed
to the translating functions and for which we are looking for a translation".
While this address has some valid flags set, it will fail the translation step
since the ranges it is matched against have flags zeroed out by the 1:1 mapping
condition.

> 
> > against mismatching flags, always failing the 1:1 mapping and its entire
> > purpose of always succeeding.
> > Set to zero only the address portion while passing the flags through.
> 
> Can you point me to what the failing DT looks like. I'm puzzled how 
> things would have worked for anyone.
> 

The following is a simplified and lightly edited) version of the resulting DT
from RPi5:

 pci@0,0 {
	#address-cells = <0x03>;
	#size-cells = <0x02>;
	......
	device_type = "pci";
	compatible = "pci14e4,2712\0pciclass,060400\0pciclass,0604";
	ranges = <0x82000000 0x00 0x00   0x82000000 0x00 0x00   0x00 0x600000>;
	reg = <0x00 0x00 0x00   0x00 0x00>;

	......

	rp1@0 {
		#address-cells = <0x02>;
		#size-cells = <0x02>;
		compatible = "simple-bus";
		ranges = <0xc0 0x40000000   0x01 0x00 0x00   0x00 0x400000>;
		dma-ranges = <0x10 0x00   0x43000000 0x10 0x00   0x10 0x00>;
		......
	};
 };

The pci@0,0 bridge node is automatically created by virtue of
CONFIG_PCI_DYNAMIC_OF_NODES, and has no dma-ranges, hence it implies 1:1 dma
mappings (flags for this mapping are set to zero).  The rp1@0 node has
dma-ranges with flags set (0x43000000). Since 0x43000000 != 0x00 any translation
will fail.
Regarding why no one has really complained about that: AFAIK this could
very well be an unusual scenario that is arising now that we have real use
case for platform devices behind a PCI endpoint and devices populated
dynamically from dtb overlay.

Many thanks,
Andrea

> 
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  drivers/of/address.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index d669ce25b5f9..5a6d55a67aa8 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -443,7 +443,8 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
> >  	}
> >  	if (ranges == NULL || rlen == 0) {
> >  		offset = of_read_number(addr, na);
> > -		memset(addr, 0, pna * 4);
> > +		/* copy the address while preserving the flags */
> > +		memset(addr + pbus->flag_cells, 0, (pna - pbus->flag_cells) * 4);
> >  		pr_debug("empty ranges; 1:1 translation\n");
> >  		goto finish;
> >  	}
> > -- 
> > 2.35.3
> > 

