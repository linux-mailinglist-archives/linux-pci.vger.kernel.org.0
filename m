Return-Path: <linux-pci+bounces-12616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFE996835A
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 11:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBE11C208F2
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027D1D2F73;
	Mon,  2 Sep 2024 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XwhWPDX8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552621D2F46
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269638; cv=none; b=ifaYyGN6wchqkDLBxTYilqxaIEaBdz5M5Jz7rlFFeNmT+0N6tnC00K2aiZxqjRSBbBQqWrrctiv29ojRoo+U5HvsSqF/ZKphweLhFJ6jsmQlgIADDhhPmuURM79IX4heMZPmvA3bssM2kjpNJAY7dZYhwfTDo2ZGEYj61zImjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269638; c=relaxed/simple;
	bh=bZT6HOFefTCtK8dJDH5XgBal9zoVpEOw5ZS27xXJrBw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cylz7cpabf+fwTVBzHkwg1mO1hNEvkP3/Z23Hz/ycAG2jV7b3SEVtuYWf3V2k63NB5X3s+IxMOFYKIuTWT663W1uyn2REhQQwr/JN/wTjtpI1vFwRWKMiCk6wwSerQyLa0gq5sWtS1RhwACt0nRD8jRzdQtmtjXBFXlILpPClWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XwhWPDX8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a83597ce5beso646712266b.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2024 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725269635; x=1725874435; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nkFfwghHSavbjYo+VJPUeYMN2TlcRh+j2R34rUyvbNY=;
        b=XwhWPDX8jDvrKTPDva8jFo1mIstNKJ+KKz71PfS3MtcQeLxeml9Q+OajUJ+06327j/
         jdVLQf2odYjxixUQf5X8EgRpw2usche70C4PtzsaYFk85k91ypUWcZ0x8zMNATRlBnnU
         cmKnsRDcBX6l5w4pvahJdOc/TJ104e19SXvB8hC6QiKr/8Y96/ot2vgiEJBXPqN2UTlk
         isRGM1OiJiS3Hweqp1yvUvXIugM57DoMB20gVoJEgu1nluhvF2zjVqVh8l/8Tskdanm8
         UZ+wlOK1U0mgTBpRXZmslX0qiuXcft5gZGR7SvBRPrTN2Srnt9hD1eXk2wgzIk2fOty8
         PRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725269635; x=1725874435;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkFfwghHSavbjYo+VJPUeYMN2TlcRh+j2R34rUyvbNY=;
        b=LRTxAYo7+X7rFQ9qMrBTzTk/iDvYz2vMtXrhxy57KTAmgLBNKmgmujeZfNGKM6dZ4P
         aTMK8zmZqC48gMvTnm5KodbSVoQk41YTZybscy1IYV9Kj+iiPgTLarJjcmnQIbqqigZB
         uAmgx298DXmttUtVWxAkvPnn+psHDVwua97g89G2Dda33cZBGxsvcQ8c9SuuP+tvlMs6
         k0zhXKOTjm0m4ynFXRDeAJI3w12ARBVRU1olswOR5efPAJ+1Gh/zRfqUsh7JSgpCAiNX
         PyIS4OLYTek5qLGXWhRqRBmtf1pRhTGq5MgWSOrCy5mOrJ3UR3tKpU5dFr9qjY8t3kF+
         0IKg==
X-Forwarded-Encrypted: i=1; AJvYcCXA5wf5rVZI+h6NQItAVWG98e8AI10Mnr6L8ASveOVVZpRBe59DFamE20lIljUO/1R3zPTqOFvYqn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjbkqA6N98SjScfC7owtDpsorCG6xWi1YuPVs/ahBDEfrpxKB
	D/8R32tYCQEJUfR8JT+dEW4vNHrLgo4If4AxZoVORfxDtQX2pugB+FlIwvijs4g=
X-Google-Smtp-Source: AGHT+IFzqMMMEekpBj1FaMcTXT8G69ZzPIWqB+7+/4FijlOwcga3oDJHGPe2vbWjoVRgbBwsvahR5w==
X-Received: by 2002:a17:906:d7c8:b0:a86:9fac:6939 with SMTP id a640c23a62f3a-a89a29f3862mr1013061366b.30.1725269634232;
        Mon, 02 Sep 2024 02:33:54 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892220e5sm527704366b.195.2024.09.02.02.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:33:53 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 2 Sep 2024 11:34:01 +0200
To: Rob Herring <robh@kernel.org>
Cc: Stefan Wahren <wahrenst@gmx.net>,
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
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <ZtWGiXUsWZOVAXRv@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <98c570cb-c2ca-4816-9ca4-94033f7fb3fb@gmx.net>
 <ZshZ6yAmyFoiF5qu@apocalypse>
 <015a0dd9-7a13-45b7-971a-19775a6bdd04@gmx.net>
 <Zsi5fNftL21vqJ3w@apocalypse>
 <CAL_Jsq+XSWEfNF-Dn3paf1io0vxTmfFNbPf7AfRWFf4XiOYkaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+XSWEfNF-Dn3paf1io0vxTmfFNbPf7AfRWFf4XiOYkaw@mail.gmail.com>

Hi Rob,

On 13:27 Fri 30 Aug     , Rob Herring wrote:
> On Fri, Aug 23, 2024 at 11:31 AM Andrea della Porta
> <andrea.porta@suse.com> wrote:
> >
...
> >
> > Since u-boot is lacking support for RP1 we cannot really produce some test
> > results to check the compatibility versus kernel dtb overlay but we can
> > speculate a little bit about it. AFAIK u-boot would probably place the rp1
> > node directly under its pcie@12000 node in DT while the dtb overlay will use
> > dynamically created PCI endpoint node (dev@0) as parent for rp1 node.
> 
> u-boot could do that and it would not be following the 25+ year old
> PCI bus bindings. Some things may be argued about as "Linux bindings",
> but that isn't one of them.

Indeed. It was just speculation, not something I would bet on.

Regards,
Andrea

> 
> Rob

