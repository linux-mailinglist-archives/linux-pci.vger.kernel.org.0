Return-Path: <linux-pci+bounces-28793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFD9ACAA22
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 09:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C063AA0C4
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 07:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9F21C1F02;
	Mon,  2 Jun 2025 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RaOXfqCB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3A128816
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748850904; cv=none; b=F+HjQhhAEbMwjXKTCdEBNTqHBXbCJ+/OD5QjwXLKInLYKCaarrlgYlfAN1zQnMh14cLs/RkntVRUjfZIN445Dz7x44egwZXfZzfb4VL8P8xCyOzshC+QtCJzIuQcdubTQCOMeXsTLRBXXqtqe2VHxUKUK6Ddg8/dduz7XX6FwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748850904; c=relaxed/simple;
	bh=/eCRwbS/rN2ZWoD/Lu11QTQjPmNCmF14z0tboBkD57o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rroLuWKNhfm32lX/MB+nztsY+x2a3dNLRNSHvLVsnblkqQbVIxeonAa1LXKCWg4CvKo4UL2Uqki+fNmHztP1SuAxOv0WHiwwhXCA2OdKNWu4HSpeszzm9nsCxPI/6o3xN4K4LqISCJO2Iwlo/mZ/glY1husETfGy6kH7Rz8ELsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RaOXfqCB; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6045b95d1feso7702325a12.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Jun 2025 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748850900; x=1749455700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pw+Y5BshWhNb94U5zV1jdIqM6Bb94uu0DoTvWRycrlQ=;
        b=RaOXfqCBEFW13E47e6E6zE4xdki3YIJFWC4NEPVDyuFCCw/2yhDOFcZxkN438eveoQ
         aTW3XtIUCK9jUWT/cBy6QAfOVsMGagaWd9ZKUxRl4CqyBDSb0Un4SZcIF9aTRUJKMa+D
         bfxwvEW4YvALnZIXWYithVRASjMllUUSnlBhHP0qMhj9ODbeLHV9nC6bGJ1EaoqDmDDR
         5PlPT83YmflW0D1RmSXAOkp37Oqf8aONdsI4kD7AlzpJhnB9FVGpxcPqcCKvFeNKtbMH
         57WbTEBBxJio47Xu2DwJLZD401he5r1/ODrfxNilpoBz8k2VyB+JvvwdCEgZN9aeDByR
         jW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748850900; x=1749455700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw+Y5BshWhNb94U5zV1jdIqM6Bb94uu0DoTvWRycrlQ=;
        b=iGc47QZpxJMwAmwbcNCCcrlqh3wc216Z2FTR9+iOQnc7i6nSsiazkdvOCyrr82vIzU
         eW8tj+yW3LPjedk74173gVmnE8SlZvw9tWw9lv9JCvNMwkOVm5tJ7GBQ1HO2Vyprrkvl
         +dsUukZOFTZp2emKSO0Y6QnScB7BLyV9wfEBR3ONJ2lCVz929qbQA/ZzzLGbCfi5RhXd
         ZGyva664DdR8cGWGXypg+umJnkBS/iFGHv6YT4GZapqkrsVsdzATNfqtQj48zx3uoYKg
         cydbasOrD/ABFRjOCsVTe9xKh6wvgb4cc7HOrUN73003WwC39F6BmYI1YVj5Zm1xcSCd
         D+mw==
X-Forwarded-Encrypted: i=1; AJvYcCV75uNe/Dvez2MmQqiESTPgpMUtbPjVXdVSG5EXC7Y0L8UPGFXyvLj4/3eohYQl5EGSr8EOKP1ZVgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrAehbOOMz5w+MbHowqlPMWy+KOFsZEh/tVuQAu1sps73cdZ+
	GZU05XyHdgfv/Yozx3AwXHQ6w4vLLVEnHiJhTIPo67d41JCDufT6cfSX/lZJvF6rFHk=
X-Gm-Gg: ASbGnctRFL/HeWYmlB30bdsix1naDlKVQ+3foZKcsJtCQJNeEy9XfwS0ko89fe209oT
	qJ0q/jOTtuR96/MBUCnVTFJx7bpKl6y3QIMhfIN2nD36vJuXIl/8DuxKRYnq32RmdN7V3kIbfnM
	Vtlib/0PWWcbs53GEZmRUsk7QXWkTIN9pXmY00DfRyJcDR5RXEVNy42Ie+d5DX0pI7o22Fs66Vc
	uBmQwJweKkMyURWYTO3vAcrnZfdkHDoNzLz0t2nrYwBucR+L8wIVhnqlLoKR1MRPydwjOsNBwqq
	15XJHEdfMtWzrizuLo0uZ1Zxh7N0/f9EZFgd5j2Mus5jRa7xGpwtPozxRZAgWbzCP3hVzAA1MyE
	x2YPxOn6DRbI8xQdyOGMPtQ==
X-Google-Smtp-Source: AGHT+IHF9M9iH6tYPPh5MIhkY3Ci/eDAulcraBxUrXh9olFXnZZZyiItNIM7oMxNMVOCoyclD4K34g==
X-Received: by 2002:a17:907:d8f:b0:ad8:8eb7:1c7a with SMTP id a640c23a62f3a-adb36c0767emr1041585566b.52.1748850900474;
        Mon, 02 Jun 2025 00:55:00 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd045bbsm749892766b.118.2025.06.02.00.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 00:55:00 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 2 Jun 2025 09:56:36 +0200
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	"derek.kiernan@amd.com" <derek.kiernan@amd.com>,
	"dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v12 0/13] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <aD1ZNAeB4tpMNTGZ@apocalypse>
References: <cover.1748526284.git.andrea.porta@suse.com>
 <0580b026-5139-4079-b1a7-464224a7d239@kernel.org>
 <aDholLnKwql-jHm1@apocalypse>
 <7934ae2a-3fc5-4ea2-b79a-ecbe668fd032@app.fastmail.com>
 <0e154ae3-e0ab-4a4e-aa39-999ea1c720ed@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e154ae3-e0ab-4a4e-aa39-999ea1c720ed@broadcom.com>

Hi Florian,

On 16:46 Fri 30 May     , Florian Fainelli wrote:
> On 5/29/25 23:03, Arnd Bergmann wrote:
> > On Thu, May 29, 2025, at 16:00, Andrea della Porta wrote:
> > > Hi Krzysztof,
> > > 
> > > On 15:50 Thu 29 May     , Krzysztof Kozlowski wrote:
> > > > On 29/05/2025 15:50, Andrea della Porta wrote:
> > > > > *** RESENDING PATCHSET AS V12 SINCE LAST ONE HAS CLOBBERED EMAIL Message-Id ***
> > > > > 
> > > > Can you slow down please? It's merge window and you keep sending the
> > > > same big patchset third time today.
> > > 
> > > Sorry for that, I was sending it so Florian can pick it up for this
> > > merge window, and I had some trouble with formatting. Hopefully
> > > this was the last one.
> > 
> > That's not how the merge window works, you missed 6.16 long ago:
> > 
> > Florian sent his pull requests for 6.16 in early may, see
> > https://lore.kernel.org/linux-arm-kernel/20250505165810.1948927-1-florian.fainelli@broadcom.com/
> > 
> > and he needed time to test the contents before sending them to me.
> > 
> > If the driver is ready to be merged now, Florian can pick it up
> > after -rc1 is out, and then include it in the 6.17 pull requests
> > so I can include them in the next merge window.
> 
> I have applied all of the patches in the respective branch as we had
> discussed with Andrea and also merged all of the branches into my "next"
> branch so we can give this some proper soak testing. Once 6.16-rc1 is
> available, all those branches (devicetree/next, defconfig-arm64/next,
> drivers/next, etc.) will be rebased against that tag such that the patches
> that are already included will be dropped, and only this patch set plus what
> I have accumulated will be applied on top (if that makes sense).
> 
> As Arnd says though, this is too late for 6.16 so this would be included in
> 6.17. Andrea, thank you very much for your persistence working on this patch
> series, and sorry that the request to merge those patches came in during a
> time where I was away. The good news is that I am not doing that again
> anytime soon.

It was a pleasure, and many thanks for your patience too.

Andrea

> 
> Thank you!
> -- 
> Florian

