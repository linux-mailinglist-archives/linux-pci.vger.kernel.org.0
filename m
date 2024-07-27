Return-Path: <linux-pci+bounces-10865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFC193DD92
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 08:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364B1B222B2
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A224B208B0;
	Sat, 27 Jul 2024 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjcwWZRx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E31B974
	for <linux-pci@vger.kernel.org>; Sat, 27 Jul 2024 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722062425; cv=none; b=az5/6/HuVdKUip365fnabEXuJen6bLc0Ng2/vOQvoBAG5c+gjGDKDmMQmQpV/d47T7uScfhrunnqfVZoQKkLsv/vzxkSJ8tem5N6St7E3HFNvxTQvvFk8nY9K4wkndbXs+cea3T4EJXn04E1tVXaBCNCYH/oAWu0u09v49i8h4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722062425; c=relaxed/simple;
	bh=OXKBrPrL25aam8XjpMYme4BwhCrlNIj9shfk12QYcGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwminVU9V5erIdNMyvGB0e9MeRLB7JqUGvnvJEir9a2FdewP+4426B+Z8P6cdluKm1grMYd6M8N//1eMlB74/jRtfu/GcYsE//fgYkXGuOtF32GXL5NlbiOBkDWk9yxY3S9bfuOhvUTPSBYJ+qYGj9YIJO61XLXcrQ+3u2qvmLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EjcwWZRx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd90c2fc68so11871065ad.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 23:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722062423; x=1722667223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KruoNU1ECeduc4ttqiLP75/tZo5xqSr0uZUmxvRMw4Y=;
        b=EjcwWZRxxNMb01wQ/gaDcwl++b1gydxW3taDqY3klLMiWP4NbjoXWYUbIHw1OLY3bB
         0m/jVH2B5Q/KHGNUZuIP/Qsv7LFrnzB/gLLH2VvJQR6//Vy1mAL8GSNtHgI9M305/MHw
         ajpqga66cEQSmolMlYpT4uJO9zaaRK78/9VJEnFqGsCBm392F+LPZ3vbgT0CQ0g8rCAF
         Tnt7H/C6vL7L+MQOIvSxLHiY8A/Oi3YauF0ETlU0SwExH0E4JNqt+ULlwVvK56xPEVkk
         6pLVah5oUNOMXd7ncAT5dnmn3MvJ/Mf22Sv6cvn0e/KRVGVeigTW5amdEwZyAivycUmu
         1izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722062423; x=1722667223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KruoNU1ECeduc4ttqiLP75/tZo5xqSr0uZUmxvRMw4Y=;
        b=tbYvmE+b+bhYS5Uo4FfjXMlejlslCbptaTQTPGyoD4GYNj3oahJut0W4LQ3xGCr98x
         9AGzC4HhrL+YsroK4KDKg7AaUPPdChmgusziEWC+qfz3K19lb2QTuvwJekrR0nHqzY/U
         Mqjpz3TSlk7UEZcd8n8hCl3+K9Z5nawy8FH4zXrqVxxNQrCmLsWazcOg0c08UpYF/GEk
         WrKZJpKgRWiOAz1UNF2C/NWbbpmBPopKNFVzXI7kwtFo4MCt6UMXDoUg9of2CgqQ+J7x
         MmN3ZshWLMvVy16vss0ZxRXl1lD6+xexa4J7IuRk9FcRE8n8YNShnnm7Wq+G/P/QLDEe
         VUXg==
X-Gm-Message-State: AOJu0Yzpu8lxM3s4np/UzIC4JrAQHFKf/ws8HKjZfndLuT4exx/kyzuY
	2ueeQXPeNLePB3fETzaCNpf/Qr6EEZRDBz2In3/X6cg7xMmNAiUEqz/6dhDHVw==
X-Google-Smtp-Source: AGHT+IENJIkVYk0rpCVthW0PQEkqM+SCa3WgfxY8ADZSjTocFT+s7pDZP7ZlTCOhfSzDNDgG2/7LNA==
X-Received: by 2002:a17:903:186:b0:1fd:5fa0:e996 with SMTP id d9443c01a7336-1ff048e4f43mr21262975ad.43.1722062422683;
        Fri, 26 Jul 2024 23:40:22 -0700 (PDT)
Received: from thinkpad ([120.56.198.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1b6c3sm43588715ad.192.2024.07.26.23.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 23:40:22 -0700 (PDT)
Date: Sat, 27 Jul 2024 12:10:13 +0530
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
Message-ID: <20240727064013.GA2974@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-4-james.quinlan@broadcom.com>
 <20240725043111.GD2317@thinkpad>
 <CA+-6iNz9R5uMogd6h+BkgRvKrsmyH2VXsGO_5e=6yqC=JzjigA@mail.gmail.com>
 <20240726050423.GB2628@thinkpad>
 <CA+-6iNzpfh7_rXUEXNjZLCLQKu-e_bYMAO6PdKaxqReJRKjuAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzpfh7_rXUEXNjZLCLQKu-e_bYMAO6PdKaxqReJRKjuAQ@mail.gmail.com>

On Fri, Jul 26, 2024 at 02:34:54PM -0400, Jim Quinlan wrote:
> On Fri, Jul 26, 2024 at 1:04 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Thu, Jul 25, 2024 at 03:45:59PM -0400, Jim Quinlan wrote:
> > > On Thu, Jul 25, 2024 at 12:31 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Tue, Jul 16, 2024 at 05:31:18PM -0400, Jim Quinlan wrote:
> > > > > o Move the clk_prepare_enable() below the resource allocations.
> > > > > o Add a jump target (clk_out) so that a bit of exception handling can be
> > > > >   better reused at the end of this function implementation.
> > > > >
> > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> > > > > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > > > ---
> > > > >  drivers/pci/controller/pcie-brcmstb.c | 29 +++++++++++++++------------
> > > > >  1 file changed, 16 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > > > index c08683febdd4..c257434edc08 100644
> > > > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > > > @@ -1613,31 +1613,30 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> > > > >
> > > > >       pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
> > > > >
> > > > > -     ret = clk_prepare_enable(pcie->clk);
> > > > > -     if (ret) {
> > > > > -             dev_err(&pdev->dev, "could not enable clock\n");
> > > > > -             return ret;
> > > > > -     }
> > > > >       pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> > > > > -     if (IS_ERR(pcie->rescal)) {
> > > > > -             clk_disable_unprepare(pcie->clk);
> > > > > +     if (IS_ERR(pcie->rescal))
> > > > >               return PTR_ERR(pcie->rescal);
> > > > > -     }
> > > > > +
> > > > >       pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
> > > > > -     if (IS_ERR(pcie->perst_reset)) {
> > > > > -             clk_disable_unprepare(pcie->clk);
> > > > > +     if (IS_ERR(pcie->perst_reset))
> > > > >               return PTR_ERR(pcie->perst_reset);
> > > > > +
> > > > > +     ret = clk_prepare_enable(pcie->clk);
> > > > > +     if (ret) {
> > > > > +             dev_err(&pdev->dev, "could not enable clock\n");
> > > > > +             return ret;
> > > > >       }
> > > > >
> > > > >       ret = reset_control_reset(pcie->rescal);
> > > > > -     if (ret)
> > > > > +     if (ret) {
> > > > >               dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> > > > > +             goto clk_out;
> > > >
> > > > Please use a descriptive name for the err labels. Here this err path disables
> > > > and unprepares the clk, so use 'clk_disable_unprepare'.
> > > ack
> > > >
> > > > > +     }
> > > > >
> > > > >       ret = brcm_phy_start(pcie);
> > > > >       if (ret) {
> > > > >               reset_control_rearm(pcie->rescal);
> > > > > -             clk_disable_unprepare(pcie->clk);
> > > > > -             return ret;
> > > > > +             goto clk_out;
> > > > >       }
> > > > >
> > > > >       ret = brcm_pcie_setup(pcie);
> > > > > @@ -1676,6 +1675,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> > > > >
> > > > >       return 0;
> > > > >
> > > > > +clk_out:
> > > > > +     clk_disable_unprepare(pcie->clk);
> > > > > +     return ret;
> > > > > +
> > > >
> > > > This is leaking the resources. Move this new label below 'fail'.
> > > What resources is it leaking?  At "clk_out" the return value will be negative
> > > and only managed resources have been allocated at that juncture.
> > >
> >
> > Right, but what about the err path below this one? If that path is taken, then
> > clks won't be released, right?
> No, that is the same situation.  The clock is originally allocated
> with "devm_clk_get_optional()", i.e. it is a managed resource.
>  If the probe fails, and it does in both of these error paths,
> Linux deallocates the newly formed device structure and all of its resources.
> Perhaps I am missing something?
> 

No, I missed the fact that __brcm_pcie_remove() is freeing all resources. But
grouping all release functions in a single helper and using it in multiple err
paths even when the err path need not release everything the helper is
releasing, warrants trouble.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

