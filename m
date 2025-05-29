Return-Path: <linux-pci+bounces-28646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F31AC7EB6
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D664E6BB8
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD322687B;
	Thu, 29 May 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A3v8zUXn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D0226165
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525313; cv=none; b=c0187ZV5pZVGMeimF22ZTxcXjXiRp1+W/fukbC032OrMW+eKP7ABSy6wjtZL1iQD3XDhXIg04og/TqDTB6Jofj9NOxNHqr2KzhVEdcJrP8aHLtLstxFl2KRJK8p5xxa28c6quz01uaeuXbsNff0HpddezB/LW5d0022XOw2D45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525313; c=relaxed/simple;
	bh=dxaIdhwkxrcOH7PEuve5FxQGB0PHBCUqWE1E/dvQymc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SajptpRATuMcOGC/Kb0IwU2Jz9LN3WrwWeomMCAzUlGZ5HFjy4Idwk43dGl9q5c2CjdCvQIZpajcv9DqQyGnpZYTEx0nnUK7fBU/7SD35HJE+K6KfLeH6A6Efs1l+dMRUtSF3m3knr1OSTQVuLrA2eC8ZD8ngfre4Dv0xIz8iuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A3v8zUXn; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso1626202a12.3
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748525310; x=1749130110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1kiFDdDACgorTtuRk6Gy6UOaoSPvn2tyJrIu3RsE3v0=;
        b=A3v8zUXnzauQLe9ygE6mTbuXx1BUCCXTZaNjNvsVuhlJM4xdoOkcJZVNMEHC21WEDR
         oMYMuh6MVkOPh3tuPnDWs1noaLEPe2ioTEJQXn8E1p9L6RasaWKK9QHPk/ln0EOk09fN
         VEx08SFJHeYBdvO6QuKBXlyJjwNfITKmr6qnoyTsioaxGdxDwrFLHXfumzowGdqWBusE
         7oBr8AhYUM8JSI3APz2CfNeUkn2LfQyQWloaj7yEPiqWTooDA62nUc0Fr0ue6wnz1PoK
         GCoULDD35NKBw87W4rVdP8ZADod79bcKFVf9+VFckjV5RhFS/xJKOon8BlGh7AWeBprf
         m1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748525310; x=1749130110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kiFDdDACgorTtuRk6Gy6UOaoSPvn2tyJrIu3RsE3v0=;
        b=OrjOxZU6rSq/gCCKWjKIZXKEad7CWSbbHjfoggRTcMpS+POo+nQ6SNK6ys01IXE04L
         Tv895z0t5uip+4TUJOdCDJy5zdtGk7dSUjcyYQ82gOKTAlJ8UdJcgnYQnP4IP+tYybNb
         PyJp2iZNEHt9t8WgtskbwCEEOXJypY3Et5N7vrs8I4pu/XT2jSJrtDTFdKx3aDEqgp2o
         6eNPm7fIeDdSKPyufoJsv6zdQ1Nv8z1YfvnGi1NDEZHvxIwYMn1MDKe7O+1Ov3nrXWB4
         ltr9JZCwtIq+jGIZpteafLwHvEilNN7NSTDMAAeN2qJkcaEUcLX7jDCY9kBstU4b4vym
         zELw==
X-Forwarded-Encrypted: i=1; AJvYcCVzrqOuLvzflAMfdzEoAavF30LSkusRC5h4Gb0cc1F5mGHhV4nbvHHE4JaWv8LYoW18wmWMaHUxRn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyoirO7i6SJauNVu5USnrCdiiiqpHVygu0Kve9Zd7VeyOAUcRM
	WLILx919T1L7xiRJGMhLYkyxfIJggOXoDoS1hjfWmE2mAwOzoBPo6mvYfNTSLe5MqVg=
X-Gm-Gg: ASbGncuojCdXiDyTjzrS7fhN28c49CAPhwExihpnDSDVk1sekgZHO2Wg/8mDYnKQ2kV
	nm1BLj9M8+Frp41OOipaayYQUJb1mq/YWAMQ5WrfWeJA0SBBMqP4Z8PDLiVc9P0Pz1hMy0AQ3Sk
	yJPvLKpeSgfqWIpEVqWViQSHw1XdDYxDqO3N5HcZNNz24Nb5A3LgktHKRSHP6+uWxSgosHFEYv9
	N2ncNY/vzZM2JvK137yLrtOCm0AmLxVcB7naHcyTFl55csvKV0mBLD0i0gr7+QS6UuHsU3W8pnf
	b8r6mo1+JEKpoldPsSVA9ZgCb72HB9bT4DqM1ycjmstUBGAsrJMC5Rch9lFZbWK+CJqkl5LLIQd
	GNIcoSbjRh81sFEQ3YFnIv33AL6++A4+J
X-Google-Smtp-Source: AGHT+IHK4Y7PatnxnQUlnLwZj15PpOrDfyPqPLYipWAui/kq0fXHKQv8bz76vrMm7M/L8eA7f812UQ==
X-Received: by 2002:a05:6402:27c6:b0:5fc:954e:bd4f with SMTP id 4fb4d7f45d1cf-602d906bc1amr16501831a12.8.1748525309931;
        Thu, 29 May 2025 06:28:29 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6051d5d9587sm2364236a12.15.2025.05.29.06.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:28:29 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 29 May 2025 15:30:04 +0200
To: Matthias Brugger <mbrugger@suse.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH v11 07/13] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <aDhhXF_MNn34Bu2N@apocalypse>
References: <cover.1748522349.git.andrea.porta@suse.com>
 <20250529124412.26311-2-andrea.porta@suse.com>
 <bdd3fe2f-28eb-4c85-99b2-7220cb15b9bc@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdd3fe2f-28eb-4c85-99b2-7220cb15b9bc@suse.com>

Hi Matthias,

On 15:24 Thu 29 May     , Matthias Brugger wrote:
> 
> 
> On 29/05/2025 14:43, Andrea della Porta wrote:
> > The RaspberryPi RP1 is a PCI multi function device containing
> > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > and others.
> > 
> > Implement a bare minimum driver to operate the RP1, leveraging
> > actual OF based driver implementations for the on-board peripherals
> > by loading a devicetree overlay during driver probe if the RP1
> > node is not already present in the DT.
> > 
> > The peripherals are accessed by mapping MMIO registers starting
> > from PCI BAR1 region.
> > 
> > With the overlay approach we can achieve more generic and agnostic
> > approach to managing this chipset, being that it is a PCI endpoint
> > and could possibly be reused in other hw implementations. The
> > presented approach is also used by Bootlin's Microchip LAN966x
> > patchset (see link) as well, for a similar chipset.
> > In this case, the inclusion tree for the DT overlay is as follow
> > (the arrow points to the includer):
> > 
> >   rp1-pci.dtso <---- rp1-common.dtsi
> > 
> > On the other hand, to ensure compatibility with downstream, this
> > driver can also work with a DT already comprising the RP1 node, so
> > the dynamically loaded overlay will not be used if the DT is already
> > fully defined.
> > 
> > The reason why this driver is contained in drivers/misc has
> > been paved by Bootlin's LAN966X driver, which first used the
> > overlay approach to implement non discoverable peripherals behind a
> > PCI bus. For RP1, the same arguments apply: it's not used as an SoC
> > since the driver code is not running on-chip and is not like an MFD
> > since it does not really need all the MFD infrastructure (shared regs,
> > etc.). So, for this particular use, misc has been proposed and deemed
> > as a good choice. For further details about that please check the links.
> > 
> > This driver is heavily based on downstream code from RaspberryPi
> > Foundation, and the original author is Phil Elwell.
> > 
> > Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> > Link: https://lore.kernel.org/all/20240612140208.GC1504919@google.com/
> > Link: https://lore.kernel.org/all/83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com/
> > Link: https://lore.kernel.org/all/2024081356-mutable-everyday-6f9d@gregkh/
> > Link: https://lore.kernel.org/all/20240808154658.247873-1-herve.codina@bootlin.com/
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>   # quirks.c, pci_ids.h
> 
> What changed in this patch so that you didn't include the Acked-by from Greg
> [1], or is this an oversight?

Nothing really, just an oversight. Thanks for spotting that out. I will resend V12
with it as I also notice that are some inconsistencies with mail Message-id, as a
result of subseqeunt invokation of git-format-patch from different branch.

Thanks,
Andrea

> 
> Regards,
> Matthias
> 
> [1] https://lore.kernel.org/linux-arm-kernel/2025042551-agency-boozy-dc3b@gregkh/
> 

