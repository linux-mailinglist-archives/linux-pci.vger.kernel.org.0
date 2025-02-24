Return-Path: <linux-pci+bounces-22187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65580A41A66
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 11:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFBF3A588C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A00245037;
	Mon, 24 Feb 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3eNsTRc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88993197A8B;
	Mon, 24 Feb 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391730; cv=none; b=Ab38uH/ANJ/fxM76Iq1ZO2IJnG/JnV7PuEca8ntAzfrGd3mSfFv+a/8uUzNAOTcASK5btGqLck1UvRJLWQ0mNyREfj2m+9RB8/Flmyt5O/L5lrdr8KmPVlJaf3WvyWe2f2/H7J2IuvEdYXVWp4t7B3tMyIO4yzJFl0bHHYC0hFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391730; c=relaxed/simple;
	bh=KoNPKyz/l+4PIEHUeghyq2QWuFg/jPzqOguImorm1vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tM0/dAsq2Id4vAqunzEu+u/00NuJ90Iu3m1btQA6v0TG4mVvWVBuutLW+kPKheDmodaf/hMntd5HCQdztUVxXdG65Cbqsi4OO9ZgY4xQaQ/hqxkVNlobyPP1vrraKPDm25lKN/2sSktgXz4L+4xp+LDbIrERmQrJMznU1AU/BG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3eNsTRc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so7055161a12.2;
        Mon, 24 Feb 2025 02:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740391727; x=1740996527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSl7SVpv3ZdvG/pUATCrI0YoKzpq2HEPnlV8gsZDiUw=;
        b=B3eNsTRciFqe1EW3pdnTrgt9mwmLcG615A7nfUw5HDEtJgK0GwIRhMGGCCN5ROsYri
         WDPiTqrq4YcY6SoBjfESmTuZ+QdZstIkcXs6PjAduOWd3mnTobLFcv/PR8qKHmese2L6
         4TSyFZ/HYGhT7Vqxg4/2pCrKnCFNhfnIwRNsaeQdRAiodmB933fEl75ibL+tCGRC/O+/
         5TJdhfkDmOS9wiA/r2nJy6vV7ENqNayQfD0+xxFExrIo0Myk4nv2Im8gapameCNtjBBL
         8LyIshEhzp8Fw6WgDWbodzNwuHVljSvrEEatKjrxNjqmAaizd9e+W94RlVY55kUuGKGZ
         v99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391727; x=1740996527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSl7SVpv3ZdvG/pUATCrI0YoKzpq2HEPnlV8gsZDiUw=;
        b=cTx2Dp+dHjYXt5hLcM6hST5vpWU6ovD8x/8Ypg25A2B9IP0qW53Tt1cGvEyyJdvjo9
         bTm8v1JTJCVekGrOnX0X1mrbUXo53RozM3A311SLjsAsRGL/gdBEXRqeKnzFxfi3j7wM
         fose9PGb6gBf9KGSVCZB8W2qQBd2Cp/MmCkNmSriU0AZqnlwMQwG2ZKg6X5AWdkht/2U
         8G5ljtJu8E98Y5X3HJf1IC657mJKcX/AOg8k+b8XE/imyxCSza5ttB59IYLFHgfhfMm5
         3srw0I26k3XlzCzh0QJqtULq1UPnWNowB1xQ7rBqrMslSCgchXJ+tDlrbcKOxRuZRzph
         Be0w==
X-Forwarded-Encrypted: i=1; AJvYcCVOwBCDVpR6Txu63IfLnSJ7gs3+ZK+aOJ2FmDk2P4ifWik7Jp7qKFfzixGtkQzt3DAMB/kiFqEwUc9K@vger.kernel.org, AJvYcCW+zhhMRgafaXsWg+HG9n/iDgPty+ktA8hlF7b39ml2dI1MOf/5PrPOAGIFTrzkmQ3F380QzdBQod4HUuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zy67Rj6wYse8kLnJqsQzpcyUUQycD8Yvsnisv/zr/Is9eYb/
	AVmCKlfyGGOSSLns6cPMLkbMryFRm9ka+u4p8CN20OzbTvToeiW+I4dfUax8Rnhibnk3GF0Si64
	HXe7XrZvpN0tMS9gnt3vESoUCF7Y=
X-Gm-Gg: ASbGncvtuENx9y04S5j1/W0MVrXqCSpeFc1j4TT3w9/D70tlJazECFy7cjSpX+lDWie
	qXVghuoLYQFCMM87CaPC0luBm17DDTdUcg1XRqHyWIEioURc8ljlBO0pI8FdcEDNigMA653VknU
	ZJY+RX4XA=
X-Google-Smtp-Source: AGHT+IGeDWpiwwWJWla3HaW7oM4L55n5TbZipzYlv7EfnvAMgjVEH+suSkVYAEe20cor22O/gSx4hsRxasu9gYyNXgg=
X-Received: by 2002:a17:907:1ca0:b0:ab7:bcf1:264 with SMTP id
 a640c23a62f3a-abc099b81bfmr1376082066b.5.1740391726541; Mon, 24 Feb 2025
 02:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208140110.2389-1-linux.amoon@gmail.com> <20250210174400.b63bhmtkuqhktb57@thinkpad>
 <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>
 <20250214060935.cgnc436upawnfzn6@thinkpad> <CANAwSgTWa9gwpPhVCYzJM5BL5wUkpB4eyDtX+Vs3SX3a9541wA@mail.gmail.com>
 <CANAwSgRvT-Mqj3XPrME6oKhYmnCUZLnwHfFHmSL=PK+xVLHAqw@mail.gmail.com> <20250224080129.zm7fvxermgeyycav@thinkpad>
In-Reply-To: <20250224080129.zm7fvxermgeyycav@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 24 Feb 2025 15:38:29 +0530
X-Gm-Features: AWEUYZn-GahK4UXEV5TeUPLgW8tudIzB_lnSgUjj_ww7YjayCEXug59G2a6ICB8
Message-ID: <CANAwSgTsp19ri5SYYtD+VOYgBLYg5UqvGRrtNTXOWw7umxGCQg@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: starfive: Fix kmemleak in StarFive PCIe driver's
 IRQ handling
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Kevin Xie <kevin.xie@starfivetech.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Minda Chen <minda.chen@starfivetech.com>, 
	"open list:PCIE DRIVER FOR STARFIVE JH71x0" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan

On Mon, 24 Feb 2025 at 13:31, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Feb 20, 2025 at 03:53:31PM +0530, Anand Moon wrote:
>
> [...]
>
> > Following the change fix this warning in a kernel memory leak.
> > Would you happen to have any comments on these changes?
> >
> > diff --git a/drivers/pci/controller/plda/pcie-plda-host.c
> > b/drivers/pci/controller/plda/pcie-plda-host.c
> > index 4153214ca410..5a72a5a33074 100644
> > --- a/drivers/pci/controller/plda/pcie-plda-host.c
> > +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> > @@ -280,11 +280,6 @@ static u32 plda_get_events(struct plda_pcie_rp *po=
rt)
> >         return events;
> >  }
> >
> > -static irqreturn_t plda_event_handler(int irq, void *dev_id)
> > -{
> > -       return IRQ_HANDLED;
> > -}
> > -
> >  static void plda_handle_event(struct irq_desc *desc)
> >  {
> >         struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
> > @@ -454,13 +449,10 @@ int plda_init_interrupts(struct platform_device *=
pdev,
> >
> >                 if (event->request_event_irq)
> >                         ret =3D event->request_event_irq(port, event_ir=
q, i);
> > -               else
> > -                       ret =3D devm_request_irq(dev, event_irq,
> > -                                              plda_event_handler,
> > -                                              0, NULL, port);
>
> This change is not related to the memleak. But I'd like to have it in a s=
eparate
> patch since this code is absolutely not required, rather pointless.
>
Yes, remove these changes to fix the memory leak issue I observed.

> >
> >                 if (ret) {
> >                         dev_err(dev, "failed to request IRQ %d\n", even=
t_irq);
> > +                       irq_dispose_mapping(event_irq);
>
> So the issue overall is that the 'devm_request_irq' fails on your platfor=
m
> because the interrupts are not defined in DT and then the IRQ is not disp=
osed in
> the error path?
>
On microchip PCIe driver utilizes interrupt resources from its
"bridge" and "cntrl"
components, accessed via ioremap, to handle hardware events.
These resources are absent in the StarFive PCIe controller.

While the StarFive JH-7110 datasheet [1] indicates support for PME, MSI, an=
d INT
messages and specific implementation details for leveraging these interrupt=
s are
unavailable.

As per StarFive JH-7110 Datasheet PCI support [1]
1 Power Management Event (PME message) =E2=97=A6
2  MSI (up to 32) and INT message support

[1] https://doc-en.rvspace.org/JH7110/PDF/JH7110I_DS.pdf

> In that case, none of the error paths below for_each_set_bit() loop is di=
sposing
> the IRQs. Also, calling 'irq_dispose_mapping()' only once is not going to
> dispose all mappings that were created before in the loop.

I was looking at how the IRQ error path will clean up IRQ in case of failur=
e
hence, I added this in case of failure to unmap IRQ events,
I will drop this if not required.
>
> - Mani
>
Thanks
-Anand
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

