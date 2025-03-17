Return-Path: <linux-pci+bounces-23902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C487A63D10
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 04:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F839188E7CB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 03:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4123B207DFE;
	Mon, 17 Mar 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVRWX00+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F497322B;
	Mon, 17 Mar 2025 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182020; cv=none; b=FzL77vH++s3E05XHkmjh6y7R0oE39kWFQ3sWT8EYmg/xufl7o5Ixf5fzbMuzV8sUgeQWwGIDtR7UelJxsPHWMU9/tXcNlM+i2+JQ5V2ApZWTokFXRfok2DTjWTQG/5H+IxGcDNyO2UGQc1Rff4hdIUO7WwjJowgV8xfhWBXZxaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182020; c=relaxed/simple;
	bh=jo3XbSFL3LH3YXoNw8nLYH1e6fdgcaJFMQ+QEKVdyhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuuOFacKVPk2JZnaAqeE6FIFmsXykFzZqyIlQoOG6/mkkmdsD9E3iGJC1o662PfgojBVDrCN21cXYOSBxIAAmLgfu3MEC3FUHKbuZYtqVuP2GDX5NDLJBBDMaTH+L44GgVtJDLnAu2I+P4NZoPHhonOsTyb0iBhSW58gx14Q7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVRWX00+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so3448122a12.1;
        Sun, 16 Mar 2025 20:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742182017; x=1742786817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ew9cK3VwqmmSRKM9CfCwZLqsPTxGVr8AsBsVV+VELps=;
        b=UVRWX00+EWnKspxRNuKwMV8TmOUhWj9ueeeH+QiHp4UkT9L6reDR2NZNhVuXUrek/n
         bxz03JdxzZDp/etvNNNXL3KKrtoae5gGTjf3BldJDlj+YwYT/EjoumZ/iot5iQ6qGU68
         TO1FlzLGVQMqd/4kaDza+O4dSEs3aaQEPgNVM3VPcuaRAOkGworWQzBhxQfXYcDE1Xwf
         PLLCDlSxpWccMdeOBzpmSYc9FCIwJIukpWuuUNHaq+/5cBy3Avn8Z4Pc/Vz0qPSR3kUa
         rcuuZnbhVAyC3DX7qvNzDcdkGeXzhAyQVppLYairKauitKTzsh7QuBHBlBqm1py0z19Y
         SZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742182017; x=1742786817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ew9cK3VwqmmSRKM9CfCwZLqsPTxGVr8AsBsVV+VELps=;
        b=e3fGsgr0eyIJRfEn6u43peHkr4AqvH8rHk5/TO3O11pcv+PVP321L5e26GmYJCWHZe
         cb6S7CK2+bKZpzzkpaHXzk3iNOfCvSgTIMze43AmDG3Anbwn+1OyIAKloIaX8HRkm8ht
         46u8qgH79agPVIMu2MmuqXApCejWcOJQD5uf1W5qwN9ba3kMSleGx8ieb8GBGVvgvWNc
         PVJjJYmBktcg1BwI81jYw3HpeRLHzNq46IHCYtc0RTIIjTyDGS7ClQHngMRz0Wc42FHx
         Z2YJbSaRkiTUdSad5pCh0QOxgIe6gKUd8Ko1W4lCQB2ZHcR7efOcIG26+igko5gDBxLB
         Kg7g==
X-Forwarded-Encrypted: i=1; AJvYcCUR7GrS+C/10YU7X+W0jbGvq4LRr8RihqXh7nvXa1tb0P/8RewMezxKVqgNKFWAFyRyBgSwDSr4w3NE@vger.kernel.org, AJvYcCVOhPAOTsZx6XivP+oIog42NobY/n29vBT0t1fsw7iM47xP/1or54SfjSBQE1hkUgDeRDqGpsbfuEZTlAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QaTS0OwF+3/dc0YaHBOIiwx88XPVji4U6N2ia91vxc8Qs3uN
	FPrm0uTbJyWiWgggk45HnTPQ0hWSjg0H/VqV4xpxvjwb9/n5IeXpjgXVHnC5hFXPEko7Fo2owuK
	qsRjovASwXM1IGqGg3GSGI3b4T88=
X-Gm-Gg: ASbGncu6Pe8uTKCwscEhoyzi+n5RqWd2zYBVoZx+RERaiMXxf6RqGCBSfloQ7UkZ0XC
	2bl4F95kl3FWTuWDu23hjSajJcDlFbrWlax8XpQKh+c4hiMjp5YCbZ3bKLk/12EBayNZr3hmIue
	+LKeffCqX4kAVKJ8n1WMiBdpXYtQ==
X-Google-Smtp-Source: AGHT+IGsZbe1TuR22q+uzkeQHGQ4QwuEq4vTb2qXLC4+gba6al+dR+brO1MSKqlHitMr+joW1Coja90NLgfxq6Hmfgc=
X-Received: by 2002:a05:6402:1d54:b0:5e5:b9b1:8117 with SMTP id
 4fb4d7f45d1cf-5e89fa3afc7mr10800086a12.18.1742182016369; Sun, 16 Mar 2025
 20:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316171250.5901-1-linux.amoon@gmail.com> <20250316171250.5901-2-linux.amoon@gmail.com>
 <SHXPR01MB08630F70345E05F6124B54B8E6DF2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <SHXPR01MB08630F70345E05F6124B54B8E6DF2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 17 Mar 2025 08:56:38 +0530
X-Gm-Features: AQ5f1JoMw6Pj9qFozta3p1hRlyepaxFMZtCw2sXiHZHf_NLToaOCXjhYCJz2H9U
Message-ID: <CANAwSgQObUP-Jxk4o5KokA=U4RsNz5uoqvyfU-Tcmj=YNM=pYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: starfive: Simplify event doorbell bitmap
 initialization in pcie-starfive
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Mason Huo <mason.huo@starfivetech.com>, 
	"open list:PCI DRIVER FOR PLDA PCIE IP" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Minda

On Mon, 17 Mar 2025 at 07:53, Minda Chen <minda.chen@starfivetech.com> wrote:
>
>
>
> >
> > The events_bitmap initialization in starfive_pcie_probe() previously masked out
> > the PLDA_AXI_DOORBELL and PLDA_PCIE_DOORBELL events.
> >
> > These masking has been removed, allowing these events to be included in the
> > bitmap. With this change ensures that all interrupt events are properly
> > accounted for and may be necessary for handling doorbell events in certain use
> > cases.
> >
> > PCIe Doorbell Events: These are typically used to notify a device about an event
> > or to trigger an action. For example, a host system can write to a doorbell
> > register on a PCIe device to signal that new data is available or that an
> > operation should start12.
> >
> > AXI-PCIe Bridge: This bridge acts as a protocol converter between AXI
> > (Advanced eXtensible Interface) and PCIe (Peripheral Component Interconnect
> > Express) domains. It allows transactions to be converted and communicated
> > between these two different protocols3.
> >
> > Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")
> > Cc: Minda Chen <minda.chen@starfivetech.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v2: new patch
> > ---
> >  drivers/pci/controller/plda/pcie-starfive.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/plda/pcie-starfive.c
> > b/drivers/pci/controller/plda/pcie-starfive.c
> > index e73c1b7bc8efc..d2c2a8e039e10 100644
> > --- a/drivers/pci/controller/plda/pcie-starfive.c
> > +++ b/drivers/pci/controller/plda/pcie-starfive.c
> > @@ -410,9 +410,7 @@ static int starfive_pcie_probe(struct platform_device
> > *pdev)
> >       plda->host_ops = &sf_host_ops;
> >       plda->num_events = PLDA_MAX_EVENT_NUM;
> >       /* mask doorbell event */
> > -     plda->events_bitmap = GENMASK(PLDA_INT_EVENT_NUM - 1, 0)
> > -                          & ~BIT(PLDA_AXI_DOORBELL)
> > -                          & ~BIT(PLDA_PCIE_DOORBELL);
> > +     plda->events_bitmap = GENMASK(PLDA_INT_EVENT_NUM - 1, 0);
> >       plda->events_bitmap <<= PLDA_NUM_DMA_EVENTS;
> >       ret = plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops,
> >                                 &stf_pcie_event);
> > --
> > 2.48.1
>
> Hi Anand
>    Mask the door bell interrupt is required. In some case, ( eg :NVMe read/write mass data) found error.

Thank you for your review comments.

I have tested using the Starfive Vision Five 2 board with a Samsung NVMe drive
and did not encounter any data read/write errors.
However, we can consider dropping this patch if there are issues with
other development boards.
I am also available to test with different NVMe modules if needed.

Thanks
-Anand

