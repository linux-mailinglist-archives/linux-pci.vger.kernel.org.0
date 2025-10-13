Return-Path: <linux-pci+bounces-37898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB2BD3533
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3EF04E4F88
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF38256C6D;
	Mon, 13 Oct 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4RbxTFX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5924A044
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364199; cv=none; b=RmcgFnOWlvYBJzpOeWKbw39my9EdydL5+VGtBcUnsWL4c2jrn6hBxbl6tS132R1HJ3uRe1g2GfelS9/8y83FJv3OBNhrx3vtDdvDUJVZOuGmO+L3ZLbjiosgbCcR6kMjeyoCJHLnoF6YeStipiKLcsEOk0P/Dj4+5SsE2ABpDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364199; c=relaxed/simple;
	bh=BU/7EF66SaZEq5fKsw17Zn90ugTD8GUecHTRIFKoZmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S505zUqLGltpXFMp9qTpCIIJZIOw+yv+BgvLZ6+oJO15PT9lmSbihFPVl8IzovPFxc/9eOnsYEY15MRLVer6h3eJUAatfpYX/G2YNZUBZwJuYhJ69N7SmSy17TGVrV6LByFK95TgnAI3K++UgEJBuOYtz5bgSSWOnJTY5FCZpX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4RbxTFX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso2008785a12.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760364196; x=1760968996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSsfnjXFCg6rG3NcR1UlA7/Xq7/GSJvjS3osS5RyZYU=;
        b=D4RbxTFXDHN/Sh0BInz4RTK8RL61sjrkzpkAd/GSmEPwAGKb8uHalvpBGfaTuWoffz
         TB6lZ6aLEveqCIdtLB9iT19LJ1nu6tLu63s0ONu8U9kDecvlkERFN2e1F8YXzHwTURwf
         GKs813hR6lDZHRhCub53aGCnX1dIjCujamqvX0ObYa4ykameECYBAerm31LCzxqRNr0y
         HSce08W5cXhnEkxs/WstVVCPhNfhakrGfW2VVad5fLV+dxZCftpL4cywASn1ZSB1sHeh
         hkRFwrJaWLAQoGoaOwdNM/SP/TFU3fHIc8L69MfFXdo4WdwNV/KLvZo18+zmUuz/lmyE
         l+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364196; x=1760968996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSsfnjXFCg6rG3NcR1UlA7/Xq7/GSJvjS3osS5RyZYU=;
        b=s9EXtUiDeeMy0kClwWPUW2zVbRW4QZ0FF+1qjJGgk3XHEYBNUOu9FrRSoVnveROd/F
         ZvjnaXXjhkSpqX2VSMtav6L3iN2U0686xby4Gfbdkzqv34d1dsMNweJVBLmAtGI3fhtV
         MsKVdz86g6IUSvVD7sCvYMn7zP/s8ErCK6ak1+3ZEVZTEuXPYilLr2wri9FALMTltx3P
         6cOaWjHRBHheDAkVZBjBPA+6xTEYcQGuKrCYP5OEAxne/+RynsUBvf0QbKovoWxabUPp
         5E7f/IoDfJQrvAGkDz5Zpezl3TCCoZnmzicGn4zxBAVE5MrWId8vlbQHmS+v0FHg/KyZ
         1nHA==
X-Forwarded-Encrypted: i=1; AJvYcCXBvIY9htG8moyYBDPrgKmzuG/93/xIsZG/GMnEUHuNdhUCVbL96jIflRZs5dKNHcohKZBuIxrOzYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/LAQCrQSNHfOhdcsJsch4KbmPH8LpUCGk72iVSenbwFuodzm
	8ljMn1PQxzIX6HzaEfJSVGZ3oTupuXynVa4ewGICaPBAqDo+y1CN+Vq88REA6snyukvq9qL7FQu
	XxzzepCqA3PVei6rS3GOlXgc8yWoGOSM=
X-Gm-Gg: ASbGncvaArr4TZ+ybGeAkNNIcsVclQhlVtJHNcOOGfdkLIqJzZ15/O/6o+aKo3DB5Jk
	DCBpt75okzaoU9yBh0K8YPTK1d9nE7f6lzWHdDtEg9EFA8r0NZrOF7Ft5U/MNAhS11LKxlJTono
	IQnNMmJ0w67fzYLBaBjRp/crkmOHRvwHHXaDfw9GjQT56REqFVpn4ugUT+xP/uDEQg6edLbgHZx
	NcykKOeNbppy+ga7o51L8d2QY8A4TpowTw=
X-Google-Smtp-Source: AGHT+IG1H5x/3Hw2x99ssho3c2GS311XkT8BwdZCay2Lc0xiXSDo5L8TJutYi6w3Oy++gD7LUBz2wwFZk5Y65Fe3Ir4=
X-Received: by 2002:a17:906:af19:b0:b55:d205:f40e with SMTP id
 a640c23a62f3a-b55d205f96cmr1243656866b.33.1760364195682; Mon, 13 Oct 2025
 07:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101727.129260-1-linux.amoon@gmail.com>
 <20251013101727.129260-2-linux.amoon@gmail.com> <11a8783345566d5ea6c696ecd007490289ba0b5f.camel@ti.com>
In-Reply-To: <11a8783345566d5ea6c696ecd007490289ba0b5f.camel@ti.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 13 Oct 2025 19:32:59 +0530
X-Gm-Features: AS18NWD3OIfNtpl-KFzVJ14mdZzPNIWP10Za43Y5NpiOwkGmGSbzZ3gomqupFk8
Message-ID: <CANAwSgTXC0uOwZhZ69viUB3t4-jH+XArP8e4vukDb2zrSgOTuA@mail.gmail.com>
Subject: Re: [RFC v1 1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to
 get the clock
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>, 
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Siddharth,

Thanks for your review comment

On Mon, 13 Oct 2025 at 16:43, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
>
> On Mon, 2025-10-13 at 15:47 +0530, Anand Moon wrote:
> > Use devm_clk_get_optional_enabled() helper instead of calling
> > devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> > the error handling and makes the code more compact. This changes removes
> > the unnecessary clk variable and assigns the result of the
> > devm_clk_get_optional_enabled() call directly to pcie->refclk.
> > This makes the code more concise and readable without changing the
> > behavior.
> >
> > Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/cadence/pci-j721e.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > index 5bc5ab20aa6d..d6bbd04c615b 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > @@ -479,7 +479,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
> >       struct cdns_pcie_ep *ep = NULL;
> >       struct gpio_desc *gpiod;
> >       void __iomem *base;
> > -     struct clk *clk;
> >       u32 num_lanes;
> >       u32 mode;
> >       int ret;
> > @@ -603,18 +602,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
> >                       goto err_get_sync;
> >               }
> >
> > -             clk = devm_clk_get_optional(dev, "pcie_refclk");
> > -             if (IS_ERR(clk)) {
> > -                     ret = dev_err_probe(dev, PTR_ERR(clk), "failed to get pcie_refclk\n");
> > -                     goto err_pcie_setup;
> > -             }
> > -
> > -             ret = clk_prepare_enable(clk);
> > -             if (ret) {
> > +             pcie->refclk = devm_clk_get_optional_enabled(dev, "pcie_refclk");
> > +             if (IS_ERR(pcie->refclk)) {
> >                       dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");
> >                       goto err_pcie_setup;
>
> 'err_pcie_setup' returns 'ret' which isn't being updated above.
> Maybe add:
>                 ret = pcie->refclk;
> above dev_err_probe(...
All return values from the dev_err_probe function appear to be missing
in this file.
I'll address this in the next revision through a separate patch.
>
> >               }
> > -             pcie->refclk = clk;
> >
> >               /*
> >                * Section 2.2 of the PCI Express Card Electromechanical
>
> Regards,
> Siddharth.

Thanks
-Anand

