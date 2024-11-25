Return-Path: <linux-pci+bounces-17275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158779D7E99
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 09:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5386DB24F4B
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0166E18E047;
	Mon, 25 Nov 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dr/JP/rg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B3A18FC84
	for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525035; cv=none; b=B0WWFrawYWqnnZSmzP9R/EMf7TLZk633vlDDGPMiFVWpwJG50BMhj5M3mCn8VG1vAjP5pm9ikQ0Iodic4waOt3UQQjF1zROPYpBTX/3cML+6DgWSEY0HIZCWRfBiWl2zQJ3vqC1ONYfNX2dcITaHb/K5bQGxDwSvaireMQcnoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525035; c=relaxed/simple;
	bh=lGs7WCnVDsN7XxJSV5nbIsOaHiSpnOd0xbhnLSv2cgw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh8djZESwUYORP2Ore2kO5Kj8iT3mt6a+ctbsDljC28EbDsXeDY3MaT+N04R6RtDslvepT47ZQJVmNgk7wfna+XZDdR/rFA53GKFA2bb9yOZpQHg1aABhg7KHrbYPCwfx5UhJEvEJsVBJcOng+R4Zb8j/PLo6qVZvgSold/5y7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dr/JP/rg; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so5094088a12.2
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 00:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732525032; x=1733129832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNEkjXcR05MS0wp8vkwMgIPKD9D5sF3FToehB53AVps=;
        b=Dr/JP/rgWuMDD8gXvo5DbToxBHJOsLqp363vitL2SMxDTGSnehP/kOR1YPCBdVCvZ+
         +YQ1OFwBBCfdAoz5/6SGQYV3PufeSxM6fTDvRhebkdp6f3TaBSb+bDvqCmpPH1X5gACO
         BJWyl00o9tsqeOcsE9ufEmEwbF2fxhJXTWK0cyojCBRwkR23UoCOdA2l4lSa/X+vU/dF
         Av/TKXPbHZ+fUHdCWA7EPsGuMuOopLRmnuIGYlp2fydTIf4l74v5lTb3jTDHwZ9sBrcd
         r3yvBMQTItzKpcxIGjhmHRz+T8TiRnSATxt9aLQvdaxhCagZ2rPv4+zLpsKGg7UA6qih
         Q3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525032; x=1733129832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNEkjXcR05MS0wp8vkwMgIPKD9D5sF3FToehB53AVps=;
        b=ugLqTT+OkDFO8IXSC2r1a0h6gIY6TQC7Im2V0WddcbDHz5IgXUP/ugg/qkFvsDhCVc
         hAKd40styDIigr45J63BpSLOCVmA+C920d0+z8YUOSXGVCMlGZkmIavoZI5qhSalpWuZ
         tahc8gli3UXI+N81FWc61D6w1oo1LxcW2gOnoJY1qLeDMnazyNPW0UzpcLIj3hQQakaz
         bFOhFKTvfCmDiZaM1lmv7IeaIZPv2NZjUlzgbJElpjz3nRI6WhwqiV+LspmiNzf21hhC
         jNxTFKfIyUEdkZS+YwA908QSohq4hH4naVQb/gHtogRPi88Q2fd+NugsvdlXqdZhUjeJ
         OtCg==
X-Forwarded-Encrypted: i=1; AJvYcCXe0cCR2mjYHtV0Fwp2Vpjg1pWCVCdBI7wAmonZtJQa4O5JqF6fFEr9vaQRXQQ9yvYJ/4CjMxAHaCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnOZ3zC0mOW6kIzyeVk21wKDVL1YKe3IHnqPTOtSyANirH+JH
	DkHqKIxaDEIX07SXvrl73ey8K4JsA07SFuhPXVvMgFIFihrm0IoKqWm5dzeaVew=
X-Gm-Gg: ASbGnculi1JY69LCORvSnjqXUJCTC0h8JhUcLjy/Zl78OsK075lQnCDT66FOd+17Etj
	1fLC628m0NjnqQpkjduFT/JWweLo8pKmIaVMbqjOqHcO+3yDdfBeEYMC75Ja9U76ET/sAQfKf5S
	OLoaFJM7MMc060EiQsbkXm1Qw133SSXTZNAKG8RAS99UUK/Pj1YFtxWNDDTT7tLk4is/VMYETgM
	l2064BMCKtGaC7H/kc32FDAz+o2w1NvVZ0Qf8NfZB0+9zSAtbXsKj8vgpgusn0Z2o42aiusDTxU
	3VHvDND48Uzqnxbelgry
X-Google-Smtp-Source: AGHT+IH55hAqFtF1SAZEH6TDiO7aHZVwXL0OCOENrWcyyZFBIRACNLLEe84rTZrGuYqyUatS9TtS7A==
X-Received: by 2002:a17:906:292a:b0:aa5:1cbd:def8 with SMTP id a640c23a62f3a-aa51cbdeea1mr942300566b.17.1732525032462;
        Mon, 25 Nov 2024 00:57:12 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52f9b9sm442025666b.105.2024.11.25.00.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 00:57:12 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 25 Nov 2024 09:57:45 +0100
To: Andrew Lunn <andrew@lunn.ch>
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
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 00/10] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <Z0Q8CekmPV4fAN6f@apocalypse>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <22e08939-fa89-4781-824e-1ea01648fb1b@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e08939-fa89-4781-824e-1ea01648fb1b@lunn.ch>

Hi Andrew,

On 20:26 Sun 24 Nov     , Andrew Lunn wrote:
> > This patchset is also a first attempt to be more agnostic wrt hardware
> > description standards such as OF devicetree and ACPI, where 'agnostic'
> > means "using DT in coexistence with ACPI", as been already promoted
> > by e.g. AL (see [4]). Although there's currently no evidence it will also
> > run out of the box on purely ACPI system, it is a first step towards
> > that direction.
> 
> When combined with CONFIG_PCI_DYNAMIC_OF_NODES and this patch series:
> 
> https://patchwork.kernel.org/project/linux-pci/cover/20241114165446.611458-1-herve.codina@bootlin.com/

That's great. I'll do some tests as soon as I can start my rpi5 from ACPI,
I saw there has been some experimentation about it and should be feasible
to run it succesfuly.

> 
> It probably does work, or is very near to working. Bootlin appear to
> have the LAN966x working on an ACPI system, and what you are adding is
> not very different.
> 
> I'm also currently playing around in this area, trying to instantiate
> some complex networking hardware using DT overlays on an ACPI system.

Nice!

Cheers,
Andrea

> 
>      Andrew

