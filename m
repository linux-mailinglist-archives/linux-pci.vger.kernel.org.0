Return-Path: <linux-pci+bounces-12725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0328396B499
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 10:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BF81C2162A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31E81CC151;
	Wed,  4 Sep 2024 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AEbkVfIg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465A1CB53D
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438779; cv=none; b=LkM1+tLRYgGP/4Rk6qMvlaGkHJky4uhhG+XZXjiHWwuvexa0LWMA7af4DZH1xN0kop8uydxKbIWREMrWrThxFdY/8BRhZl1wm8gYexoBLqGvRgon4EcclRprHJkpks21xpI01bQcFsJ/m16B6MPj6OqgQpTmG2Cp7MuYv6Sx1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438779; c=relaxed/simple;
	bh=Xv0p+AJofBlCcpb3u4bgKBZYMhgzStHTHgFTPhmw1pE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmYj1L5cSi3PjSGnMHbYZHCysZXM8BKtD42qDv2pErqv/tdQP1BPizJeqkdxi5ckHn+7WBx2b+8ajUWo+kAj3U+0SWUiLK7lljsbb4RLgDZ2zo8BZhlD4lIYi/vhmHb3joae1QQ21AdhuGC4iANAvop0wnkStu/fZDKBU4u6Si0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AEbkVfIg; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a80eab3945eso602506566b.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2024 01:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725438775; x=1726043575; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=czuWwJfvtYwCI1yRbL1xXo5MWTUEx5+lgQqq8jdG4Bg=;
        b=AEbkVfIgg41Etbmw1+4g5J0R5NmCwhfHwx23LU+LzIEk7m0E4mAqRG6jgZUsJFamgn
         L+mOk9hNx0oQ8wypBYKuu6KvJCMQGWXUKkxULYzmg6o+0VJn5HTHqJRjekkFYxaLKCM1
         hLG3RbpQ8/4y82I5tH9ONW8PpzQBn7JJW29XPtChfemnXe+ahNuXwfis2VOB7/rcd88v
         gqNZXb93EJtHOyCG1yq4LzDFuRyfnmvZ86A9xDX+0TVqOXBU+g2NO5L6cpgwclT3eLmr
         63KsmC6AVXKiuwwyi6gSHvZ7Rr9UV4fzYskeuZRaHhHpKlmeZ9yd2LgRDp1ZxKFCjV49
         tt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725438775; x=1726043575;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czuWwJfvtYwCI1yRbL1xXo5MWTUEx5+lgQqq8jdG4Bg=;
        b=EPBpb6gYq+eyBJceZVTPuFCzot8u3o+fVHfdGWNJCVUtzhrytUQII3qYuLeaTWFjga
         IrhSFkJD+yAfG8pk76GSnIFfelICRyMyt5PnUb2wMphFb7pwYxFANLrV+mhatrp39Iim
         eyrYykECnXKHewtV4hckxfUu8Sa7mddknS+cbRtO5L/2TrRzZzOU3B9xPxA9P5+E5Wa7
         eOdNofNRjpjA2esifCcvbIcTilNBXypaDI0GDmzl1b0jngAPYSPHm1jTX8BDa/u03R6q
         yRDR12g8TLJh911AI65aYplPbNgg0n4rZiBqUCbQ7YLhYuvQoQE5TKeazmj3tN9EZg1N
         LX5w==
X-Forwarded-Encrypted: i=1; AJvYcCXau1PUMzZ94HpVHlH71Neu27AmvmUA6nN1o3Fte39SmnwCImvdbmSKGlgMjWigG/FEOOAZs82ECRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YycAo+FMG8NGDInYNWUHVDokPCXReyyYpcJHTK14u3i5fSWeTA6
	0s1F/CQKNDDtX77wzEvduZSENuXBWdfXhvuKhm5Cjppg145/MZK3lxIxKEl4pQI=
X-Google-Smtp-Source: AGHT+IFsYrIc/8V6Dd0Wb4ac4K3yCfFqAZyqP0j4It4wu1Ti01Hf/Xj9KyshDVwvjUwn7G7BVIArrg==
X-Received: by 2002:a17:907:1c94:b0:a7a:b643:654f with SMTP id a640c23a62f3a-a89a358274emr1229334866b.15.1725438774327;
        Wed, 04 Sep 2024 01:32:54 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a3d3177basm69728966b.64.2024.09.04.01.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:32:53 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 4 Sep 2024 10:33:02 +0200
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
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 04/11] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
Message-ID: <ZtgbPtYXu0yOieou@apocalypse>
References: <5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>
 <20240821001618.GA2309328-robh@kernel.org>
 <ZsWi86I1KG91fteb@apocalypse>
 <CAL_JsqKN0ZNMtq+_dhurwLR+FL2MBOmWujp7uy+5HzXxUb_qDQ@mail.gmail.com>
 <ZtBJ0jIq-QrTVs1m@apocalypse>
 <CAL_Jsq+_-m3cjTRsFZ0RwVpot3Pdcr1GWt-qiiFC8kQvsmV7VQ@mail.gmail.com>
 <ZtChPt4cD8PzfEkF@apocalypse>
 <CAL_JsqJNcZx-HH-TJhsNai2fqwPJ+dtcWTdPagRjgqM31wsJkA@mail.gmail.com>
 <Ztc2DadAnxLIYFj-@apocalypse>
 <CAL_Jsq+mpVEDthuViQZ6T7tDQ_krgxYSQ0Qg1pBMNW8Kpr+Qcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+mpVEDthuViQZ6T7tDQ_krgxYSQ0Qg1pBMNW8Kpr+Qcw@mail.gmail.com>

Hi Rob,

On 13:46 Tue 03 Sep     , Rob Herring wrote:
> On Tue, Sep 3, 2024 at 11:15 AM Andrea della Porta
> <andrea.porta@suse.com> wrote:
> >
> > Hi Rob,
> >
> > On 14:37 Fri 30 Aug     , Rob Herring wrote:
> > > On Thu, Aug 29, 2024 at 11:26 AM Andrea della Porta
> > > <andrea.porta@suse.com> wrote:
> > > >
> > > > Hi Rob,
> > > >
> >
> > ...
> >
> > >
> > > I think simple-bus where you have it is fine. It is really 1 level up
> > > that needs to be specified. Basically something that's referenced from
> > > the specific PCI device's schema (e.g. the RP1 schema (which you are
> > > missing)).
> > >
> > > That schema needs to roughly look like this:
> > >
> > > properties:
> > >   "#address-cells":
> > >     const: 3
> > >   "#size-cells":
> > >     const: 2
> > >   ranges:
> > >     minItems: 1
> > >     maxItems: 6
> > >     items:
> > >       additionalItems: true
> > >       items:
> > >         - maximum: 5  # The BAR number
> > >         - const: 0
> > >         - const: 0
> > >         - # TODO: valid PCI memory flags
> > >
> > > patternProperties:
> > >   "^bar-bus@[0-5]$":
> > >     type: object
> > >     additionalProperties: true
> > >     properties:
> > >       compatible:
> > >         const: simple-bus
> > >       ranges: true
> > >
> >
> > Hmmm.. not sure how this is going to work. The PCI device (RP1) will
> > havei, at runtime, a compatible like this:
> >
> > compatible = "pci1de4,1\0pciclass,0200000\0pciclass,0200";
> >
> > that is basically generated automatically by the OF framework. So, in the
> > schema you proposed above, I can put something like:
> >
> > properties:
> >   compatible:
> >     contains:
> >       pattern: '^pci1de4,1'
> 
> No, it should be like this:
> 
> compatible:
>   items:
>     - const: pci1de4,1
>     - const: pciclass,0200000
>     - const: pciclass,0200
> 
> or
> 
> compatible:
>   addtionalItems: true
>   maxItems: 3
>   items:
>     - const: pci1de4,1
>

Ack.
 
> 
> Alternatively, we could instead only generate 'pciclass' compatibles
> for bridge nodes. The reason being that being an ethernet controller
> doesn't really tell us anything. There's no standard interface
> associated with that class.

I'd avoid this one, since the class is not representative in this case. RP1
is an MFD and not an Ethernet controller. Also, it would prevent other similar
PCI devices with differnt class from using this schema.

> 
> > or maybe I could omit the compatible entirely, like in:
> 
> No.
> 
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-iommu.yaml
> 
> That's not a device node, but just part of pci-host-bridge.yaml.
> 
> > that seems to refer to generic compatible values.
> > In both cases though, I don't see how these binding could work with
> > make dt_binding_check, since there's no compatible known at compile
> > time (for the first approach), or no compatible at all (the second
> > approach).
> > Is it intended only as a loose documentation?
> 
> No, schemas define exactly what a binding can and can't contain. But
> they are divided into device schemas and common schemas. The latter
> are incomplete and are included by the former. Generally, "compatible"
> goes in device schemas.

Ack.

> 
> > Or are you proposing that for a future new bus (hence with a new, specific,
> > compatible) that could be described by the schema above?
> 
> The above schema would be the common schema included by a RP1 schema,
> LAN966x schema, or any other device doing the same thing.

Many thanks, I believe I've got it now :)

Cheers,
Andrea

> Rob

