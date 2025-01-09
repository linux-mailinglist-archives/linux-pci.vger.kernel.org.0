Return-Path: <linux-pci+bounces-19608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFE8A07C8E
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 16:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612E13A80C8
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92632206BB;
	Thu,  9 Jan 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bl/mYVoK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DE22068A
	for <linux-pci@vger.kernel.org>; Thu,  9 Jan 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437988; cv=none; b=qqj6MMRY9VeQ0MFEkHeSGNv+bc+LWWxU66XxM24KhnaKwrNs8aKQlymZ2hVBbnhDuKPaDfOfwHtSGNZ3BNImgmIlCquLwx8a8T9cH1a7DSLuSSi1jwNm+dvDc/+7crHh6i3agJtGlGbFogAt1Q6q3ve+wcfUZW4Y/Npi6UtXY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437988; c=relaxed/simple;
	bh=pJgGVj88K8V7gJ0zgIUhUwlsCxKgV+W4Ci2hCN34mIY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7lo93uN4xkqPBa8UuyG0LZ9h8ZAw6FVwE6yHgWBQIiaJWf5J8vIYbhYyoz3yHVXBNKkcR16HLSdGMiYD00BrzCMYt7sC8XO2TY2CNF4hDaHRWF53pscIcqtTasDGEs0sp3wIHgBYGOf/RfryEOufrGTgteylVS5z12wsAJti5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bl/mYVoK; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-aaf60d85238so215308466b.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Jan 2025 07:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736437985; x=1737042785; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aiM8y2KF3+onAr2SvicvIVsqQjxBJ+k4H+eZXUhohgA=;
        b=Bl/mYVoKctKrr4gURZuPaipQQxFpkN47P0NlpCMfjizKqQNYQVhLEN+Rrs1NmO6Bbl
         Pk0gJ699p+KTMEwouYyn5iWanH06Zfa8lCBNjlTFl7Vsb1+MZr/5bicGx9uRLFleFiT9
         rgTppDeph9xyTknOcMsi/Zma8kkEErYrwCbAfR1jbPcBNswOMQzcWUXL1mXsaCVhauMl
         fUvIGf+9SAIUDmL+1Y+f+DiF9C7JPvtot6yczg+M574vA9tgtRKVZ84mdAClQqcWYUrP
         Jiag7lXRPPPKmsgTX0C42XLBThXjXic+pkAAjgFyP0NONL0CF0HPhMXwbySw60jCxTvB
         vQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736437985; x=1737042785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiM8y2KF3+onAr2SvicvIVsqQjxBJ+k4H+eZXUhohgA=;
        b=jWDGl1kaIiBRtRyyVsmBZKkCVWLqNA4T86Oa+yrWnH7061Zo7UEbSN1/O1N0nEW5Ao
         0lmOqCW3p+fqOOSwpqgGKwhYjl8VJhg32c5afjkIjeaNcyVkDQnHo+4fdBdMdNd3+JIa
         nbg6Z89WT49pAmo5MvWoMw+sJeevIK1JymzFmorgE1Wgb4ezvAflPguGmL/KNNMSqCCy
         7tJ11Tu7r4pol5mOwgulmXYPa8ALtk7WrNHDJNcFQ/DHkEnLZkL4grX2/J/XGDTzVWwP
         yGqBgqlNJkGkvhRZOnQ8vTpzpHuNUnQtW3TCxaP/d5budu4Fj/PD+r0xG8+K5l/ZsXLM
         Hxkg==
X-Forwarded-Encrypted: i=1; AJvYcCVm5uqF5RYATFSu7C8uTuIEw9cXnBQ+19P+b1skvt6O4TXsia/s/FAS5FyAZUzR+2+xMesEVsPryhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSqrX/uI8IfbHd5gXJhx6t5aSGDC451a/oWcHegnN7DJ+HRaX
	ezeJn9LO2N/57tZeYP4J/oDTEf/nUCecHTxxwA0MY4rCFfh0vMBb9vXmsf68Z3Q=
X-Gm-Gg: ASbGncvPmG6aCHXKYoF1lrV8wLdooagZ4tgT4q6bLGi4kA2koxVRI6mCD8aIewMoWSu
	9bFv8Oypo1vcplA2ObraoqQcytQ4KPLW2iHr5gBR6NSUig3z5vnYE+pZJxkCTKqsxHE9GtZs3rw
	cfWoLdhfsk6ZnixJr2+gstUoT+6Q9zzw5IRatH4sfG17IxzKuIAlUHrwFJhH5wCwGkyt40e7GwK
	1VehbQkFkr1bPmvMcMJ095lnZQRM14x1fMlIkZd0ip1PTydg/cZFGUcGlfQTRrRa4H5CUbfcT7C
	qEDqCcj08DaQyo/X9QpXBdCFV7jkSA==
X-Google-Smtp-Source: AGHT+IHcBvpBouxzG2xA8PisFV1s3Jhs8UiQjwM9GQq0MdUzIaP9cn8QbUIcgBfqgLqpN4NyhXITew==
X-Received: by 2002:a17:906:fd87:b0:aab:cce0:f8b4 with SMTP id a640c23a62f3a-ab2abc9ed6cmr644656666b.52.1736437984935;
        Thu, 09 Jan 2025 07:53:04 -0800 (PST)
Received: from localhost (host-79-40-232-186.business.telecomitalia.it. [79.40.232.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9563b32sm82250366b.122.2025.01.09.07.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:53:04 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 9 Jan 2025 16:53:52 +0100
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 08/10] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <Z3_xEEGVWFu-bDjT@apocalypse>
References: <cover.1733136811.git.andrea.porta@suse.com>
 <28fe72eec1c08781770cee65032bb10a6d5994a9.1733136811.git.andrea.porta@suse.com>
 <20241210224837.GA702616-robh@kernel.org>
 <Z2A0aAPotT0NvoCl@apocalypse>
 <Z3_ZlvbszezcanA4@apocalypse>
 <20250109155036.27b82b7e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109155036.27b82b7e@bootlin.com>

Hi Herve,

On 15:50 Thu 09 Jan     , Herve Codina wrote:
> Hi Andrea,
> 
> On Thu, 9 Jan 2025 15:13:42 +0100
> Andrea della Porta <andrea.porta@suse.com> wrote:
> 
> > Hi Rob,
> > 
> > On 15:08 Mon 16 Dec     , Andrea della Porta wrote:
> > > Hi Rob,
> > > 
> > > On 16:48 Tue 10 Dec     , Rob Herring wrote:  
> > > > On Mon, Dec 02, 2024 at 12:19:32PM +0100, Andrea della Porta wrote:  
> > > > > The RaspberryPi RP1 is a PCI multi function device containing
> > > > > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > > > > and others.  
> > 
> > ...
> > 
> > > > > +#define RP1_INT_ADC_FIFO	52
> > > > > +#define RP1_INT_PCIE_OUT	53
> > > > > +#define RP1_INT_SPI6		54
> > > > > +#define RP1_INT_SPI7		55
> > > > > +#define RP1_INT_SPI8		56
> > > > > +#define RP1_INT_SYSCFG		58
> > > > > +#define RP1_INT_CLOCKS_DEFAULT	59
> > > > > +#define RP1_INT_VBUSCTRL	60
> > > > > +#define RP1_INT_PROC_MISC	57  
> > > > 
> > > > Why all these defines which will never be used because they come from 
> > > > DT?
> > > >  
> > > 
> > > Right, those defines where originally designed to be included from dts, but
> > > previous discussion deemed interrupt numbers to be hardcoded instead of being
> > > specified as mnemonics. In the driver source code I just use RP1_INT_END as the
> > > number of interrupts but I thought that the specific interrupt numbers should
> > > be documented in some way or another. Since no one is currently referencing
> > > those defines, would it be better to just turn those in a multiline comment
> > > just to describe them in a more compact form?  
> > 
> > So, here's a couple of proposals about the interrupt defines:
> > 
> > - since they were banned from devicetree, and are not used anywhere in the code,
> >   turn them into a (admittedly long) multiline comment, so they are still at
> >   least documented
> > 
> > - since they were banned from devicetree, and are not use anywhere in the code,
> >   just drop them, we don't currently need them after all
> > 
> > Not sure what's the best way here, anyone can advise?
> 
> Maybe in the #interrupt-cells description in the device-tree binding?
> 
> In your patch 4, you describe this interrupt controller and you have:
>   '#interrupt-cells':
>     const: 2
>     description:
>       Specifies respectively the interrupt number and flags as defined
>       in include/dt-bindings/interrupt-controller/irq.h.
> 
> In this description, why not add the supported interrupt number values?
>     description: |
>       Specifies respectively the interrupt number and flags as defined
>       in include/dt-bindings/interrupt-controller/irq.h.
>       The supported values for the interrupt number are:
>         - IO BANK0: 0
>         - IO BANK1: 1
> ...
> 
> Or something similar.
> 
> This kind of description is already available. For instance:
>   https://elixir.bootlin.com/linux/v6.13-rc1/source/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml#L64
> 
> Does it make sense?

Seems fine to me, if there's no concern from anyone I will procede like that.
Thanks for the suggestion.

Andrea

> 
> Best regards,
> Hervé

