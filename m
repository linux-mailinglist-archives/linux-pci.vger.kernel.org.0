Return-Path: <linux-pci+bounces-22196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3025FA41E53
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 13:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B077189FAAC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0D92192E1;
	Mon, 24 Feb 2025 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gsIpx2Cq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3D2192EB
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398099; cv=none; b=o8L75fVp8/NkkbxvvKSoQrGebMuzRAxaeGF5Vie+Ie0BsPKdJGvlZSPzmcbFDjLmIo/TGFaiPq3icF9X0zr4ruT04aiS7S3dYmWtBpjNPtjVJC6SufFWI/lFL4SSYhs6sn5aQGyVxGZHqsVRGYyUhR5neQZ0cT5mvYRf3EVrVvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398099; c=relaxed/simple;
	bh=rOprXm82okdY/KlMUZ3w74nT4emJ5jwW/UJLnTKC3ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyWWvSauQm0RNb8Tsm8YMTxB0uHiR55tBdicuohd+KYJIDzgZp2gqARHOH4OYtgf4l34CRd5LvhA/6oN7XVD5WrwZopY8ufZhz8Vuk0LMdhTJYwG7Fu2Fa9Kc8R4rnLK3e7899BiOM6WpDeiFUfU7LqKdcKKNWsU6KUEhZXpmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gsIpx2Cq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22114b800f7so80713165ad.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 03:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740398097; x=1741002897; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v+iFNVpGUmMFzQSXzDgeeu0QHpe9S71wTLihb0U3yO4=;
        b=gsIpx2CqJUuyYo/A4970OBGoh6pV0GYfwBQafF7Cd610+2okUfjmCVHOPgqzEfIdz7
         cV2PgxIEdWbhxHEq8q7fZDf8JYcN4eytEF0g1DKkb53PdjDoXNkGE5Pk7DNuvKquiyNF
         YRIfLxoyj9A4GWdB73M6EkGIXKHjDHDli24OUjaDUqEHt8T8n3lu9NXBju3U9X5mw1YP
         S7Au6MjLr8Kav2vlci+CRC00L780DC5+vo9EUn5VFUZxp9sUljIVMh/4/8NKKqoP3pnw
         5w9JS/S939rwPEF2HVTqtK+LYIlD/PP1VE480xp1q7/KBPS3s/1Fzvw16GRyoHbnQAXU
         HwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740398097; x=1741002897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+iFNVpGUmMFzQSXzDgeeu0QHpe9S71wTLihb0U3yO4=;
        b=Wlj9AL4Bf5ThYNmDdUcbIoTR2Rti1EF2Q5okVEUV9hgqeoVJSemmLCXdbWcu2PfzTa
         zZS+HMfjFDb9wHOOCilajJbrDuViGKO5BWyYL9q6xA1AYxcH3hxhy69wJWfro13KZW1h
         nfEqy1afqBgbB8zZ4Bwi82KKjSB/H4suv5CkK2froMARf5nL/buKu8HVyCDexb9xbZDZ
         Nn6AUXBJfl1CvDdVuaau/x4mGV0sy5hGBhddrweahwyVgqSK3UNhRTZr5uxPkBvxcG6v
         xHbommjJFAnb9N2Id02OMvVjt6axT1u4M67oJidsNvATTlBzsu8sdt6GIloZvNWgYSVZ
         etag==
X-Forwarded-Encrypted: i=1; AJvYcCUGZ5LRpKbQaCD/+jE+wQwixn76ql0vhgDarswJ9ibi6ToiO4GwEcV6Ao8FkV6i/ZMDCIZwovYFUSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAhZ89AR8aToUXoE/C+BMgSHz5LvIZDbdIZSPFXDBofz4nQ5jM
	9xsXVZ5FV/WfS+DI+tTEYP9qMIk+kOPoiFIlE1pOnI181kSlJ3+cOciycOeMow==
X-Gm-Gg: ASbGnctXIG9ccf68c1yjxmiNd/idCxKoacFT4MmI9m9j3xU8F6271iDxUd9ccamhbhH
	A2UYjaGkXoxveRe2C72ICh9Pk+V4CzNgtZC/Q5g9Helct9J+Kx9kwOqZ72YIbtknW3pVf5vi/1o
	3ewbIkoGhuBwARwYU6WCNnSbFxvcCG2pIxcn7OQmvjq9h/NZNgnCDlUHakUHG4IHNOhL7UjqlT9
	fsgvUHBigTK/VzcNoS78ZlRTdq6fbn9kl/sZOSCgMlNj53d3M3F1rZ/45OQqRxw+mAWIva9C0UJ
	bi95evIlm7yWiD0tsSSO3oW08uyt1HBMk12K3LA=
X-Google-Smtp-Source: AGHT+IHNJW28+htkmToyI+q9OTvpWx6Kawty/jaa2u3yXSLrfbqqTtiiK6tDw4N1s5eKYCkye4wF/A==
X-Received: by 2002:a05:6a21:501:b0:1d9:c615:d1e6 with SMTP id adf61e73a8af0-1eef3b1aa6dmr23697828637.0.1740398097482;
        Mon, 24 Feb 2025 03:54:57 -0800 (PST)
Received: from thinkpad ([220.158.156.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d348076sm16024354b3a.77.2025.02.24.03.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:54:57 -0800 (PST)
Date: Mon, 24 Feb 2025 17:24:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	"open list:PCIE DRIVER FOR STARFIVE JH71x0" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: starfive: Fix kmemleak in StarFive PCIe driver's
 IRQ handling
Message-ID: <20250224115452.micfqctwjkt6gwrs@thinkpad>
References: <20250208140110.2389-1-linux.amoon@gmail.com>
 <20250210174400.b63bhmtkuqhktb57@thinkpad>
 <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>
 <20250214060935.cgnc436upawnfzn6@thinkpad>
 <CANAwSgTWa9gwpPhVCYzJM5BL5wUkpB4eyDtX+Vs3SX3a9541wA@mail.gmail.com>
 <CANAwSgRvT-Mqj3XPrME6oKhYmnCUZLnwHfFHmSL=PK+xVLHAqw@mail.gmail.com>
 <20250224080129.zm7fvxermgeyycav@thinkpad>
 <CANAwSgTsp19ri5SYYtD+VOYgBLYg5UqvGRrtNTXOWw7umxGCQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgTsp19ri5SYYtD+VOYgBLYg5UqvGRrtNTXOWw7umxGCQg@mail.gmail.com>

On Mon, Feb 24, 2025 at 03:38:29PM +0530, Anand Moon wrote:
> Hi Manivannan
> 
> On Mon, 24 Feb 2025 at 13:31, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Thu, Feb 20, 2025 at 03:53:31PM +0530, Anand Moon wrote:
> >
> > [...]
> >
> > > Following the change fix this warning in a kernel memory leak.
> > > Would you happen to have any comments on these changes?
> > >
> > > diff --git a/drivers/pci/controller/plda/pcie-plda-host.c
> > > b/drivers/pci/controller/plda/pcie-plda-host.c
> > > index 4153214ca410..5a72a5a33074 100644
> > > --- a/drivers/pci/controller/plda/pcie-plda-host.c
> > > +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> > > @@ -280,11 +280,6 @@ static u32 plda_get_events(struct plda_pcie_rp *port)
> > >         return events;
> > >  }
> > >
> > > -static irqreturn_t plda_event_handler(int irq, void *dev_id)
> > > -{
> > > -       return IRQ_HANDLED;
> > > -}
> > > -
> > >  static void plda_handle_event(struct irq_desc *desc)
> > >  {
> > >         struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
> > > @@ -454,13 +449,10 @@ int plda_init_interrupts(struct platform_device *pdev,
> > >
> > >                 if (event->request_event_irq)
> > >                         ret = event->request_event_irq(port, event_irq, i);
> > > -               else
> > > -                       ret = devm_request_irq(dev, event_irq,
> > > -                                              plda_event_handler,
> > > -                                              0, NULL, port);
> >
> > This change is not related to the memleak. But I'd like to have it in a separate
> > patch since this code is absolutely not required, rather pointless.
> >
> Yes, remove these changes to fix the memory leak issue I observed.
> 

Sorry, I don't get you. This specific code change of removing 'devm_request_irq'
is not supposed to fix memleak.

If you are seeing the memleak getting fixed because of it, then something is
wrong with the irq implementation. You need to figure it out.

> > >
> > >                 if (ret) {
> > >                         dev_err(dev, "failed to request IRQ %d\n", event_irq);
> > > +                       irq_dispose_mapping(event_irq);
> >
> > So the issue overall is that the 'devm_request_irq' fails on your platform
> > because the interrupts are not defined in DT and then the IRQ is not disposed in
> > the error path?
> >
> On microchip PCIe driver utilizes interrupt resources from its
> "bridge" and "cntrl"
> components, accessed via ioremap, to handle hardware events.
> These resources are absent in the StarFive PCIe controller.
> 
> While the StarFive JH-7110 datasheet [1] indicates support for PME, MSI, and INT
> messages and specific implementation details for leveraging these interrupts are
> unavailable.
> 
> As per StarFive JH-7110 Datasheet PCI support [1]
> 1 Power Management Event (PME message) ◦
> 2  MSI (up to 32) and INT message support
> 
> [1] https://doc-en.rvspace.org/JH7110/PDF/JH7110I_DS.pdf
> 

Fine.

> > In that case, none of the error paths below for_each_set_bit() loop is disposing
> > the IRQs. Also, calling 'irq_dispose_mapping()' only once is not going to
> > dispose all mappings that were created before in the loop.
> 
> I was looking at how the IRQ error path will clean up IRQ in case of failure
> hence, I added this in case of failure to unmap IRQ events,
> I will drop this if not required.

Absolutely not. These are fixing the irq leaks. But if it is not related to the
'memleak' you observed, then these should be part of a separate patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

