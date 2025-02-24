Return-Path: <linux-pci+bounces-22204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15DA42294
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14393BC007
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3BE15852E;
	Mon, 24 Feb 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnDTuGdR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A526F30F;
	Mon, 24 Feb 2025 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405839; cv=none; b=ZsBlaA8SZA0A2OKYMPyn3qN/JmHp1nqnhWaYdc3iD5WxaOhy2xflJPl/PXLzG8L8VKonSdzHFzKh4MMLjYDNn85x/3b+sLRUr3JhhUmvYe2Z2ohrs6G30kPP2+h57o9qFKdgm3nUjJYamlI58WtG2TNNp8bHz2GZyF6YAySo+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405839; c=relaxed/simple;
	bh=9IBItuJCtI6rP0dQgpzFLxJ+0BfCOiZsZ4iT8cwQa6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkkQTGSyaOaOdprrNBmlj+Iy4DXH8N7i1hAkrgL90eYePNR0s5HZPgssOYoM3FpyQbKaiDBef39O8MLGtj3QiJJQQFS3XqDkGkY+/x/299Pux867Fd9kWSchdw7TfEQtgsPB9Y02GrtAZUmgfcLAxKOBAhSlUjJLA4aQcfbBONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnDTuGdR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso5933004a12.1;
        Mon, 24 Feb 2025 06:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740405836; x=1741010636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyOPDoI0Eogi/b2Cq8dwITJr9g85wE8cbU6hW1YTZ+s=;
        b=gnDTuGdRHkzVx57xPTNMR7Sfo/2kA0DcY5Vwli3MxXEmErBK3gjWa/4/CpO19O7W0u
         v9tbcjgoy+KU+Ft8lgNbXPDJZhL+Gj2mMlGFh2REngvsDrBi6+mEV6cbBwUXYuVN6ZgH
         5Gsf1h/U9ffnsBv2UAQ54zZXyPlDryykf2nucHAEgwLxuzZgxr2BSgFHwYVCJYWIJKfF
         mJiaBIESDX69H6BdNSUKQIGEjh1JBq0Gs5n+hhabAcJ83gzTEnHUUZ4e1f58UTnQ0aZG
         WhO+GgmugertXPxnFxcsgJ8fuVAxa3Z0MY7YPh3P8d0Tzvbgl80KzQcOnxFz/ud75B+N
         ZTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740405836; x=1741010636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyOPDoI0Eogi/b2Cq8dwITJr9g85wE8cbU6hW1YTZ+s=;
        b=b2QkXtdZgu+puiB166pdjqnE67S5widrNQmfq/lyezOg1dBxcumEtCyhddJbeA2ggI
         3khVYLZ62en8sUeJYS5xx6PeF/Po2tOrrwDGIiroZyWaY/XtAS/AXwbwrwEHp2vgDgZt
         dPBCT7aTMDtKUkNE0VahLUHlQZPSO1JwUvXOs4OlhrsFOSUD0DBaQpHKL5o3FUYqak8e
         iZoeyuCIJ+fUnDrLZqqJVFs6z//M0bUeeea1qApnd7+LmHt7dY5YGhbxV4k9CsAC4gEP
         H5YQSioDIbTbOXsKNm8C62y7pjFL1Qc/8K1vuLmncy5lU32WkmYVsWkaQY9EjAVbuEjO
         Vr8g==
X-Forwarded-Encrypted: i=1; AJvYcCU9kWWrS0Mbhj4MDyV6f5EfG3wVo69jufPi9v4howeUsgq0r6MEHLUwAN1MuRYemjxe9htltQoZHFpeJCM=@vger.kernel.org, AJvYcCVSwda8Lxqce5G/cr5tEPvASOCLK8bz9eU2rVeqaXJJGZ36u6g8yePzL0DtfQ9g9Z6FPA7wlANVd5tp@vger.kernel.org
X-Gm-Message-State: AOJu0Yywmn4Ky5rp6KDlbEoEWQ02HGR5ttLIccTmspJiFvVVuSfr1nn/
	oZi7syFZkaZzH2pRPVO/59gBN7LE1Xn7qw4pao64imSM5MGZQtE3do7IpswiTD5Blppf8Y2NElU
	042razuEW+jpObpaxHFV+vfDQ8tM=
X-Gm-Gg: ASbGnctUVLK2wvOVlButAlubWghjbBGXf258iPt8WdhQba9Sa6f1qwYlVpe0HFQ7pqm
	MS5BhOR1VFfe8AyxGmAnc5saPcr60CXLmoHq+19KiI+lCO29ke3tPCU65KqY8pa6057lnIk7ENn
	tPZc84Myk=
X-Google-Smtp-Source: AGHT+IFeUgyMUaWKHecgd7TN0zdK291Jsh6XT92yIKm1gna15uyC7jmJmw1HU7BwyYFNn+7J0OHd5/+WF264WU2tiOA=
X-Received: by 2002:a05:6402:4409:b0:5db:f5bc:f696 with SMTP id
 4fb4d7f45d1cf-5e0b70bf576mr11703033a12.5.1740405835774; Mon, 24 Feb 2025
 06:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208140110.2389-1-linux.amoon@gmail.com> <20250210174400.b63bhmtkuqhktb57@thinkpad>
 <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>
 <20250214060935.cgnc436upawnfzn6@thinkpad> <CANAwSgTWa9gwpPhVCYzJM5BL5wUkpB4eyDtX+Vs3SX3a9541wA@mail.gmail.com>
 <CANAwSgRvT-Mqj3XPrME6oKhYmnCUZLnwHfFHmSL=PK+xVLHAqw@mail.gmail.com>
 <20250224080129.zm7fvxermgeyycav@thinkpad> <CANAwSgTsp19ri5SYYtD+VOYgBLYg5UqvGRrtNTXOWw7umxGCQg@mail.gmail.com>
 <20250224115452.micfqctwjkt6gwrs@thinkpad>
In-Reply-To: <20250224115452.micfqctwjkt6gwrs@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 24 Feb 2025 19:33:37 +0530
X-Gm-Features: AWEUYZl0WwBYeavHRI5Yd0joAtTXYmQANZduMOH2ulN0Vy4vz_jyQz91yJCGVRU
Message-ID: <CANAwSgSdEr0X0F1AFAUfJoEjT1a63nj5Ar-ZfmehfhnE0=v+CA@mail.gmail.com>
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

On Mon, 24 Feb 2025 at 17:24, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Feb 24, 2025 at 03:38:29PM +0530, Anand Moon wrote:
> > Hi Manivannan
> >
> > On Mon, 24 Feb 2025 at 13:31, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 03:53:31PM +0530, Anand Moon wrote:
> > >
> > > [...]
> > >
> > > > Following the change fix this warning in a kernel memory leak.
> > > > Would you happen to have any comments on these changes?
> > > >
> > > > diff --git a/drivers/pci/controller/plda/pcie-plda-host.c
> > > > b/drivers/pci/controller/plda/pcie-plda-host.c
> > > > index 4153214ca410..5a72a5a33074 100644
> > > > --- a/drivers/pci/controller/plda/pcie-plda-host.c
> > > > +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> > > > @@ -280,11 +280,6 @@ static u32 plda_get_events(struct plda_pcie_rp=
 *port)
> > > >         return events;
> > > >  }
> > > >
> > > > -static irqreturn_t plda_event_handler(int irq, void *dev_id)
> > > > -{
> > > > -       return IRQ_HANDLED;
> > > > -}
> > > > -
> > > >  static void plda_handle_event(struct irq_desc *desc)
> > > >  {
> > > >         struct plda_pcie_rp *port =3D irq_desc_get_handler_data(des=
c);
> > > > @@ -454,13 +449,10 @@ int plda_init_interrupts(struct platform_devi=
ce *pdev,
> > > >
> > > >                 if (event->request_event_irq)
> > > >                         ret =3D event->request_event_irq(port, even=
t_irq, i);
> > > > -               else
> > > > -                       ret =3D devm_request_irq(dev, event_irq,
> > > > -                                              plda_event_handler,
> > > > -                                              0, NULL, port);
> > >
> > > This change is not related to the memleak. But I'd like to have it in=
 a separate
> > > patch since this code is absolutely not required, rather pointless.
> > >
> > Yes, remove these changes to fix the memory leak issue I observed.
> >
>
> Sorry, I don't get you. This specific code change of removing 'devm_reque=
st_irq'
> is not supposed to fix memleak.
>
> If you are seeing the memleak getting fixed because of it, then something=
 is
> wrong with the irq implementation. You need to figure it out.

Declaring request_event_irq in the host controller facilitates the
creation of a dedicated IRQ event handler.
In its absence, a dummy devm_request_irq was employed, but this
resulted in unhandled IRQs and subsequent memory leaks.
Eliminating the dummy code eliminated the memory leak logs.
>
> > > >
> > > >                 if (ret) {
> > > >                         dev_err(dev, "failed to request IRQ %d\n", =
event_irq);
> > > > +                       irq_dispose_mapping(event_irq);
> > >
> > > So the issue overall is that the 'devm_request_irq' fails on your pla=
tform
> > > because the interrupts are not defined in DT and then the IRQ is not =
disposed in
> > > the error path?
> > >
> > On microchip PCIe driver utilizes interrupt resources from its
> > "bridge" and "cntrl"
> > components, accessed via ioremap, to handle hardware events.
> > These resources are absent in the StarFive PCIe controller.
> >
> > While the StarFive JH-7110 datasheet [1] indicates support for PME, MSI=
, and INT
> > messages and specific implementation details for leveraging these inter=
rupts are
> > unavailable.
> >
> > As per StarFive JH-7110 Datasheet PCI support [1]
> > 1 Power Management Event (PME message) =E2=97=A6
> > 2  MSI (up to 32) and INT message support
> >
> > [1] https://doc-en.rvspace.org/JH7110/PDF/JH7110I_DS.pdf
> >
>
> Fine.
>
> > > In that case, none of the error paths below for_each_set_bit() loop i=
s disposing
> > > the IRQs. Also, calling 'irq_dispose_mapping()' only once is not goin=
g to
> > > dispose all mappings that were created before in the loop.
> >
> > I was looking at how the IRQ error path will clean up IRQ in case of fa=
ilure
> > hence, I added this in case of failure to unmap IRQ events,
> > I will drop this if not required.
>
> Absolutely not. These are fixing the irq leaks. But if it is not related =
to the
> 'memleak' you observed, then these should be part of a separate patch.
>
Ok will drop this.
> - Mani
>
Thank
-Anand
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

