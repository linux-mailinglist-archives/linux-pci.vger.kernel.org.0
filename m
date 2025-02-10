Return-Path: <linux-pci+bounces-21111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE9A2F926
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 20:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD057A2F5F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB66253F07;
	Mon, 10 Feb 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMBbGDjA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C6257AD8;
	Mon, 10 Feb 2025 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216365; cv=none; b=CjpIs1lSx2w2K2yQeP39/Tjo8goHLvHlla4kwoAT2K7LhALYP4O2gjXZx6ZvVsNc1HnMLWo8J56559d74tyD5Lpcq+19ckuzkYesg3me3/LG9qcvHhu60Vntv1BySW3DG7SAM59lpcJnsTlm7E6YmPaZX+9AEnhRc2Cmsyy7Mvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216365; c=relaxed/simple;
	bh=BgdNhKDXz/no7DglHpg1Pb5zNJDUriBtVyzHzDAG2Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQOANu6LbZIGPRCNKGrrohUUacooCdP2mdw7YICll8K7do4HajkPvoZQvWm7pidpBSRckHOsGqX9MMrDUAS8Mt/wEeq4zRvm6zpwIriIZ3sbZPEVe1ErCdLbr9kuS0l89e+iV2IowOxqBT0zafyXHXP71QhDh6pnXaavcVSFZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMBbGDjA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaeec07b705so755171766b.2;
        Mon, 10 Feb 2025 11:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739216362; x=1739821162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UGevfOpAUPjzC/KiI8YLKFnVe3l8iDORylTqnw5Vwk=;
        b=ZMBbGDjAnjbONph0O5EGnIgQCG1J0M0/C+swNfZDcEIqac60fq66nigcguMaq0S91R
         atHeSM6DGJOrf+CwSFrGoy3Ffwsf2scQM9cO4XgWIEIQlkKdAGs/MkmsNR2fTSbz5WaU
         00y+GvdOv84VxzpbzfzHrV/upAPPrOU31HMlJ9D692Mler+WE/EapwFQe5qo0tNPgN3W
         6ILu9cJ1ZT97xI0u06DGfx/m3LNghcWqEJdAOP/imT4ZrDQH30GuaoHfqh0eRw/kHb6o
         Rnl2ie3H7HfKXlqsWerdvlenmRrlQ+jSkW31CTJffC43WNgndZS5rrBQUWhDhIU/tQQ0
         QGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216362; x=1739821162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UGevfOpAUPjzC/KiI8YLKFnVe3l8iDORylTqnw5Vwk=;
        b=PrRh0sTDJiiAlP+ujV9ipgiET/6r4qxplz65S94sg40KRK07tAiSYykMZodUPqxUHg
         FY5RyXs3FTDdtgLz3FNrnUEGAv6ekv1jOfy3VFcca6RqabQUuUNvQ5RS67QQIBpaZlWQ
         Fh6ernjpUzteBlgiX7Wg41Wzkc3KdyYY54g12NVlxqD42X4v+9SdgW1DHGCflKzpbBhp
         Q0hjrTHHcvuRR5vNMBIu+fEaoIyfc4lVwdtJ5slPQLU4f9w4b5eeQ2CjOA9ciiCiYzYd
         AS+8dA1lDUD50mvlUl+5xLFXp0UqNcoGrOc7MNtOvSQM8kbHN59FLQAlC4QEgit5Dpeh
         e4PA==
X-Forwarded-Encrypted: i=1; AJvYcCVDDkX/RXYmT83/n/3pAuyjupaMvaMLX/uJbnLPO2I3/mBkuNaaDQTzWfoygUUPo0bKtFP8y+yJTr7nkmI=@vger.kernel.org, AJvYcCXZmSS0YDPVm/kia4k9ReYaW72Rbynmlrp3olTsfxpEZKmdHrfyMyEpDEGQDZK3+XY6MJDVKTA6q9cL@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpxfZ+j4JLBMlljKlNJGr56VUmTNbg8UlvhiuE+tL4tr4gfru
	+NCzAjBrlGcuQtq5wmz/DpNUhdTL84ed6aQPB7Mcs+KJD8ZLT6i8XG2bTcgF4RBZwWwc73cLeY+
	Z9EreJDj/r2a7+ikKqk2rFwHLlt4=
X-Gm-Gg: ASbGnctuRO9520dVXm546bx2fY1UsGCAzfuHFRBBcGVbEVzGnjILqss0Nwm0Td/vKUv
	CrXdPPhxffJ1SdLUYWW0MKpsicLXUA4X7gfF18EHO+ejbczxV3JMHKs8A1Ie17U5k7jUKhPcd
X-Google-Smtp-Source: AGHT+IHkH1T+CuWeIT0XKMZ6C94TIWLCg4ypBx01FMwdD/FhknfWIjYmY5tPWTGl4EGOg28RVj85qmiAFX2QsLtQwbc=
X-Received: by 2002:a17:907:6d1e:b0:ab2:faed:f180 with SMTP id
 a640c23a62f3a-ab789aef85amr1823164866b.33.1739216361832; Mon, 10 Feb 2025
 11:39:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208140110.2389-1-linux.amoon@gmail.com> <20250210174400.b63bhmtkuqhktb57@thinkpad>
In-Reply-To: <20250210174400.b63bhmtkuqhktb57@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 11 Feb 2025 01:09:04 +0530
X-Gm-Features: AWEUYZkHVuEkkPy1KSE2EKLXcjM9zVRd3pbM5-SmxlzbW8tM9XT1xK4MY0lSdG4
Message-ID: <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>
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

On Mon, 10 Feb 2025 at 23:14, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Sat, Feb 08, 2025 at 07:31:08PM +0530, Anand Moon wrote:
> > kmemleak reported following debug log
> >
> > $ sudo cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffffffd6c47c2600 (size 128):
> >   comm "kworker/u16:2", pid 38, jiffies 4294942263
> >   hex dump (first 32 bytes):
> >     cc 7c 5a 8d ff ff ff ff 40 b0 47 c8 d6 ff ff ff  .|Z.....@.G.....
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace (crc 4f07ff07):
> >     __create_object+0x2a/0xfc
> >     kmemleak_alloc+0x38/0x98
> >     __kmalloc_cache_noprof+0x296/0x444
> >     request_threaded_irq+0x168/0x284
> >     devm_request_threaded_irq+0xa8/0x13c
> >     plda_init_interrupts+0x46e/0x858
> >     plda_pcie_host_init+0x356/0x468
> >     starfive_pcie_probe+0x2f6/0x398
> >     platform_probe+0x106/0x150
> >     really_probe+0x30e/0x746
> >     __driver_probe_device+0x11c/0x2c2
> >     driver_probe_device+0x5e/0x316
> >     __device_attach_driver+0x296/0x3a4
> >     bus_for_each_drv+0x1d0/0x260
> >     __device_attach+0x1fa/0x2d6
> >     device_initial_probe+0x14/0x28
> > unreferenced object 0xffffffd6c47c2900 (size 128):
> >   comm "kworker/u16:2", pid 38, jiffies 4294942281
> >
> > This patch addresses a kmemleak reported during StarFive PCIe driver
> > initialization. The leak was observed with kmemleak reporting
> > unreferenced objects related to IRQ handling. The backtrace pointed
> > to the `request_threaded_irq` and related functions within the
> > `plda_init_interrupts` path, indicating that some allocated memory
> > related to IRQs was not being properly freed.
> >
> > The issue was that while the driver requested IRQs, it wasn't
> > correctly handling the lifecycle of the associated resources.
>
> What resources?
>
The Microchip PCIe host driver [1] handles  PCI, SEC, DEBUG, and LOCAL
hardware events
through a dedicated framework [2]. This framework allows the core driver [3=
]
to monitor and wait for these specific events.

[1]: https://github.com/torvalds/linux/blob/master/drivers/pci/controller/p=
lda/pcie-microchip-host.c#L90-L292
[2]: https://github.com/torvalds/linux/blob/master/drivers/pci/controller/p=
lda/pcie-microchip-host.c#L374-L499
[3]: https://github.com/torvalds/linux/blob/master/drivers/pci/controller/p=
lda/pcie-plda-host.c#L448-L466

StarFive PCIe driver currently lacks the necessary `request_event_irq`
implementation
to integrate with this event-handling mechanism, which prevents the core dr=
iver
from properly responding to these events on StarFive platforms.

static const struct plda_event mc_event =3D {
.  request_event_irq =3D mc_request_event_irq,
  .intx_event        =3D EVENT_LOCAL_PM_MSI_INT_INTX,
  .msi_event         =3D EVENT_LOCAL_PM_MSI_INT_MSI,
};

This patch implements dummy `request_event_irq` for the StarFive PCIe drive=
r,
Since the core [3] driver is monitoring for these events

> > This patch introduces an event IRQ handler and the necessary
> > infrastructure to manage these IRQs, preventing the memory leak.
> >
>
> These handles appear pointless to me. What purpose are they serving?
>
Yes, you are correct, the core event monitoring framework [3] triggered a
kernel memory leak. This patch adds a dummy IRQ callback as a
placeholder for proper event handling, which can be implemented in a
future patch.

> - Mani
>
Thanks
-Anand

> > Fixes: 647690479660 ("PCI: microchip: Add request_event_irq() callback =
function")
> > Cc: Minda Chen <minda.chen@starfivetech.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/plda/pcie-starfive.c | 39 +++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/=
controller/plda/pcie-starfive.c
> > index e73c1b7bc8ef..a57177a8be8a 100644
> > --- a/drivers/pci/controller/plda/pcie-starfive.c
> > +++ b/drivers/pci/controller/plda/pcie-starfive.c
> > @@ -381,7 +381,46 @@ static const struct plda_pcie_host_ops sf_host_ops=
 =3D {
> >       .host_deinit =3D starfive_pcie_host_deinit,
> >  };
> >
> > +/* IRQ handler for PCIe events */
> > +static irqreturn_t starfive_event_handler(int irq, void *dev_id)
> > +{
> > +     struct plda_pcie_rp *port =3D dev_id;
> > +     struct irq_data *data;
> > +
> > +     /* Retrieve IRQ data */
> > +     data =3D irq_domain_get_irq_data(port->event_domain, irq);
> > +
> > +     if (data) {
> > +             dev_err_ratelimited(port->dev, "Event IRQ %ld triggered\n=
",
> > +                                 data->hwirq);
> > +     } else {
> > +             dev_err_ratelimited(port->dev, "Invalid event IRQ %d\n", =
irq);
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +/* Request an IRQ for a specific event */
> > +static int starfive_request_event_irq(struct plda_pcie_rp *plda, int e=
vent_irq,
> > +                                   int event)
> > +{
> > +     int ret;
> > +
> > +     /* Request the IRQ and associate it with the handler */
> > +     ret =3D devm_request_irq(plda->dev, event_irq, starfive_event_han=
dler,
> > +                            IRQF_SHARED, "starfivepcie", plda);
> > +
> > +     if (ret) {
> > +             dev_err(plda->dev, "Failed to request IRQ %d: %d\n", even=
t_irq,
> > +                     ret);
> > +             return ret;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  static const struct plda_event stf_pcie_event =3D {
> > +     .request_event_irq =3D starfive_request_event_irq,
> >       .intx_event =3D EVENT_PM_MSI_INT_INTX,
> >       .msi_event  =3D EVENT_PM_MSI_INT_MSI
> >  };
> >
> > base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
> > --
> > 2.48.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

