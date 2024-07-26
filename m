Return-Path: <linux-pci+bounces-10822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A494193CD69
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 07:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C852C1C2144E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 05:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FE3816;
	Fri, 26 Jul 2024 05:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQ9jG1ss"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F739FDD
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 05:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721970271; cv=none; b=hCrg9ltleWrH/9d6AeB+XBMvJNEWBfO7zqJRndYJ67SSsUtoLk926tGhiWP0+Yuw/d8dVHUxwizsnV9mzQWm8JC1gQLAsm3KNpnT+Q5lMYcAGFz5HdHxjymCJQxA3q+25UJyP89E9beJwwzmuQ/j+CAt3VjvO5zoIOJN6Uq8pTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721970271; c=relaxed/simple;
	bh=OwJ7YP0+np/+RjQ1EZiGr6NgT/Kssknb5vb4mbYf2gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYdl08OYRzH/3MTmeFVnU55J7akNithYrKXuYkdf3KRr73+XEM5h+tTFCiCtBdGQKcayQRZz551Cq1yOxuCnyKg/5pt88jpDwY2KVtrltuyc4nJ1FEYt7h05C1qznlk4RpCJedLR6Rk8/UwrOrbVOsJVnmweAKo8LH9a5bVHAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kQ9jG1ss; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc56fd4de1so1867295ad.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 22:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721970270; x=1722575070; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jVzY9HXY97cczgYDJULvCCMUVKhL5nbeKKOuLjBsycM=;
        b=kQ9jG1ssMq7a2T7ME3/Uf4MOc89P3kha6mJaFDTxOWfKbJW3VyhH3BhKwZ2fOPa9Si
         n7XlU7j7SKmSyk8o2yKAcI5iplhPOTrdxs0H+Vp52HJ2ISENGJVjAGS3FOIDu5CplCeS
         lqqJCPT9ZKLQmNr6WWqzwDDuR0YYjS43DS5dp4nXGpsCt/CLa0JsWxAeIdrjR5whi32k
         TEVkjvyRr2q6u29avCgY57Io+uzraEf0+RmjzUsn+9LXwHwcxKJWdyDC1svqUZ14hUO8
         I6hcsqQClEd/9hf2gYjBII3ek0fh1Z+FyYq4ji9fAO0eCENVTYhzhOc3mVLH/US3plT5
         qjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721970270; x=1722575070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVzY9HXY97cczgYDJULvCCMUVKhL5nbeKKOuLjBsycM=;
        b=KhMeckFY7akVRiZWtkrf6zzmlttONT0hmxjEOnC1VdKQ7spMYCya8wGcVW04qEKKSP
         rKZswqXCkCml8N3/Qv32kxiO0kXTF4Ho4r37IzoBGCr0yftrb4vWgxVL4usrD/zwaBCR
         SjJRsSbxQKmEu5jwG6DMtnw57i+a8SMJVf6NAN0ro7Flm0wraArNM8hejtrjqfx3v8iW
         DtMT/utm+8Ae45YVbXR3+ZXgl9WZMp8hcYWOz5kNtZ1imqsxEp7VwWyAdHbhqZBRJ0dl
         VcG1PHx+ITP8DrEU4NG5rMEDnHlypju6Ovj3OElR9OjkwaNim3Ny/NG9fDhOTAop7tCy
         sGvw==
X-Gm-Message-State: AOJu0YxPEcdU2sUIRdqhV8oQl3ECrbrijqwvt0gVApDjlJAmRPaWDdXQ
	CQI10pogqlVFsY+5XJ02nnwxDNcO8tiEiHduSb0VMWl/iehy8wcLs5B4StlgEQ==
X-Google-Smtp-Source: AGHT+IEv9bnCjkKaaT/mVatGZz8Er2pi/NLYy/srtwCMJgijY/eyFSkIBNPHBAyhamVGhdhOUZ8Aqg==
X-Received: by 2002:a17:903:1ce:b0:1fc:41c0:7a82 with SMTP id d9443c01a7336-1fed248c8c0mr82068615ad.0.1721970269543;
        Thu, 25 Jul 2024 22:04:29 -0700 (PDT)
Received: from thinkpad ([220.158.156.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c88aa1sm22840805ad.37.2024.07.25.22.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 22:04:29 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:34:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/12] PCI: brcmstb: Use common error handling code in
 brcm_pcie_probe()
Message-ID: <20240726050423.GB2628@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-4-james.quinlan@broadcom.com>
 <20240725043111.GD2317@thinkpad>
 <CA+-6iNz9R5uMogd6h+BkgRvKrsmyH2VXsGO_5e=6yqC=JzjigA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNz9R5uMogd6h+BkgRvKrsmyH2VXsGO_5e=6yqC=JzjigA@mail.gmail.com>

On Thu, Jul 25, 2024 at 03:45:59PM -0400, Jim Quinlan wrote:
> On Thu, Jul 25, 2024 at 12:31 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Jul 16, 2024 at 05:31:18PM -0400, Jim Quinlan wrote:
> > > o Move the clk_prepare_enable() below the resource allocations.
> > > o Add a jump target (clk_out) so that a bit of exception handling can be
> > >   better reused at the end of this function implementation.
> > >
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> > > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 29 +++++++++++++++------------
> > >  1 file changed, 16 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index c08683febdd4..c257434edc08 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -1613,31 +1613,30 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> > >
> > >       pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
> > >
> > > -     ret = clk_prepare_enable(pcie->clk);
> > > -     if (ret) {
> > > -             dev_err(&pdev->dev, "could not enable clock\n");
> > > -             return ret;
> > > -     }
> > >       pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> > > -     if (IS_ERR(pcie->rescal)) {
> > > -             clk_disable_unprepare(pcie->clk);
> > > +     if (IS_ERR(pcie->rescal))
> > >               return PTR_ERR(pcie->rescal);
> > > -     }
> > > +
> > >       pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
> > > -     if (IS_ERR(pcie->perst_reset)) {
> > > -             clk_disable_unprepare(pcie->clk);
> > > +     if (IS_ERR(pcie->perst_reset))
> > >               return PTR_ERR(pcie->perst_reset);
> > > +
> > > +     ret = clk_prepare_enable(pcie->clk);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "could not enable clock\n");
> > > +             return ret;
> > >       }
> > >
> > >       ret = reset_control_reset(pcie->rescal);
> > > -     if (ret)
> > > +     if (ret) {
> > >               dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> > > +             goto clk_out;
> >
> > Please use a descriptive name for the err labels. Here this err path disables
> > and unprepares the clk, so use 'clk_disable_unprepare'.
> ack
> >
> > > +     }
> > >
> > >       ret = brcm_phy_start(pcie);
> > >       if (ret) {
> > >               reset_control_rearm(pcie->rescal);
> > > -             clk_disable_unprepare(pcie->clk);
> > > -             return ret;
> > > +             goto clk_out;
> > >       }
> > >
> > >       ret = brcm_pcie_setup(pcie);
> > > @@ -1676,6 +1675,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> > >
> > >       return 0;
> > >
> > > +clk_out:
> > > +     clk_disable_unprepare(pcie->clk);
> > > +     return ret;
> > > +
> >
> > This is leaking the resources. Move this new label below 'fail'.
> What resources is it leaking?  At "clk_out" the return value will be negative
> and only managed resources have been allocated at that juncture.
> 

Right, but what about the err path below this one? If that path is taken, then
clks won't be released, right?

It is not a good design to return from each err labels. There should be only one
return for all err labels at the end and those labels need to be in reverse
order w.r.t the actual code.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

