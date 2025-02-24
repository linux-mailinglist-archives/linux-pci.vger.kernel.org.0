Return-Path: <linux-pci+bounces-22234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F3EA42767
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3481D164885
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D925A626;
	Mon, 24 Feb 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpREEWox"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEDB25A648;
	Mon, 24 Feb 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413255; cv=none; b=XvcvrleF52E0InPgZxLt1zvjR1Tdbvs/j3z8uWZa3P7GO2eknwyvarODqWVsjPrmf9aPCuTm+ZODr8naVl0yNMsm/o3Ei8I/U7yrb+olwCW4VDMbSl0aIXGLMXWorxiYgk8DbMpCjaMnfe7i3Zxg3HRcRdLiXzm9mLzNRCxBzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413255; c=relaxed/simple;
	bh=PbkGzzm55MOcg3pcCAX/7s1Nfyu5gqW4PEX9y1ulVJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxH4cp2IpoMWgew3X4XRx/Cd4kV0PifoEm5zVDTXI1H245feQYMUYw+qCH+Mu7fWB7P5htianJQkdCFHucvH4Nm4oREsHyJli0YfxgYEnXITuuDyHjXNUY7DtN53UnwrXp+WIkS6x5/4SjDCGvYFGjvzO+FFDkkKcdnGLM5FUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpREEWox; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso725380766b.2;
        Mon, 24 Feb 2025 08:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740413252; x=1741018052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa4nOseN9oCX6EjVrP+lzLNNY0r/kZRu3ZNXY5eaEfg=;
        b=ZpREEWoxIttGbZSkEACwXigAQ6TJ2jzbgohSqg/2jIfYFWq/ihwCmuvXO6LEivG0+8
         naM8ZLmSmUZDTWZOVxM6yCLKEoZN0qj06OzBEPqjqxsbePvq849h2xnVsrkmhKB6yiVi
         aOMO/jdQ3hfATAkcLctifOPXmuTFEIm6oC9rdGlsznA/sd52RTLQuKjtW8cE7Z34ddBK
         huyhhFH3hdr64fM7rIAMj8TvbevBrXqWFGa7IC19xnE5pHRO9LHzpUSivkyHFNa1chU/
         0xKq5AHlCJ2W4A/V0I58vgc7yC42sTNcf5VOLxOy4l+4sade27XzPZVzH9t/ERKSrV0h
         ZGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740413252; x=1741018052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa4nOseN9oCX6EjVrP+lzLNNY0r/kZRu3ZNXY5eaEfg=;
        b=ph0JzMugiLDhHHYVzk+9md+XYvpxZcLQMu0wyT/ppT5gFidnxGFk7Aj0QfyPrzUKlw
         UIkiRC/betr5/FRbc/YQjM8I4FbBLSnlAnYGBVq1hHYhj5r9sstXIwRZbDlRfxAn7tCQ
         q2SJvGOBAXZ0npfUOG4Rdi5uxjrHN2OkYjL2HF35DnCY6Npp8NNDKwbVRnE3iyuc+P/n
         JTcDXmRlG5DICMG2ktQzPhmdY5D/aIcSTOUjJaRZMWHWiSBnQWKxiV9zA2q3UkOP4HvT
         fWm6fiGfVMBYxMlb102G0LGFOREQ/JusE5EDr40OUfzAWEyT6u+TdRN0tTWSSZQeiGXA
         y7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx5NgiGug6d6lKdTyPZd+C2pFyK+9caDX+sRqPo3KuemYd7yiNAGQiNtdHTuBlB/TJhVJRS629Bw9v@vger.kernel.org, AJvYcCXbSTyJ/DcyRoFgxzfYZ6fr9CniZ+eSJfvMmeUM88dznoDHRYZYoyGbCzg3ElXOR2ZFGzrZBOGpn6AfGkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+w0ZueO2tHInl6QTySnDrO3o7Hre//v9Jzlintw/g+sijB9G
	C7Hxe2UVtMWxGww2Wi23Q094WY+KGRPoasEBXNgSLryK3mFqaV83SP6TvJ4ubqvAEyIsy4V4lft
	acXbo1URboWrEDcmeuVam4Ktk6SA=
X-Gm-Gg: ASbGncvqlYSSfYZIbBUlfuk6b+LfglmnRrVx29Bg4S6Fc1sZIqYCjzKB9tmDoopOtCH
	zqqjD2fZdAIEQUSA4g9JBiTHC5fvGc3uDXauKIOSzX8hbjmTyOM6f0T0lvteyYIIDZi+SXxoFd9
	uCJGeHPUk=
X-Google-Smtp-Source: AGHT+IHoJ2J7rE9qT9w6tspwiuPKWlGlrPLjFaolcYqGwX3+e1AxF8oFVC1tnk6IIYedrOb8so1Qh4c5Bil7XhnoigE=
X-Received: by 2002:a17:907:940e:b0:abb:b209:ab98 with SMTP id
 a640c23a62f3a-abc09ab52ccmr1394087466b.34.1740413251311; Mon, 24 Feb 2025
 08:07:31 -0800 (PST)
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
 <20250224115452.micfqctwjkt6gwrs@thinkpad> <CANAwSgSdEr0X0F1AFAUfJoEjT1a63nj5Ar-ZfmehfhnE0=v+CA@mail.gmail.com>
 <20250224144155.omzrmls7hpjqw6yl@thinkpad>
In-Reply-To: <20250224144155.omzrmls7hpjqw6yl@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 24 Feb 2025 21:37:14 +0530
X-Gm-Features: AWEUYZkRpUY7D3uhqIzkz1pBVpJa6c92IhX92KHCEfsKNimU-7sgHALH8dPETwI
Message-ID: <CANAwSgQFET-vWoOSSMFWs3LZeQMaP+VgU6o2_1Rro6NmGXQbVQ@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: starfive: Fix kmemleak in StarFive PCIe driver's
 IRQ handling
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Minda Chen <minda.chen@starfivetech.com>, 
	"open list:PCIE DRIVER FOR STARFIVE JH71x0" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

On Mon, 24 Feb 2025 at 20:12, Manivannan Sadhasivam <mani@kernel.org> wrote=
:
>
> On Mon, Feb 24, 2025 at 07:33:37PM +0530, Anand Moon wrote:
> > Hi Manivannan
> >
> > On Mon, 24 Feb 2025 at 17:24, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 03:38:29PM +0530, Anand Moon wrote:
> > > > Hi Manivannan
> > > >
> > > > On Mon, 24 Feb 2025 at 13:31, Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > >
> > > > > On Thu, Feb 20, 2025 at 03:53:31PM +0530, Anand Moon wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > Following the change fix this warning in a kernel memory leak.
> > > > > > Would you happen to have any comments on these changes?
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > > b/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > > index 4153214ca410..5a72a5a33074 100644
> > > > > > --- a/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > > +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> > > > > > @@ -280,11 +280,6 @@ static u32 plda_get_events(struct plda_pci=
e_rp *port)
> > > > > >         return events;
> > > > > >  }
> > > > > >
> > > > > > -static irqreturn_t plda_event_handler(int irq, void *dev_id)
> > > > > > -{
> > > > > > -       return IRQ_HANDLED;
> > > > > > -}
> > > > > > -
> > > > > >  static void plda_handle_event(struct irq_desc *desc)
> > > > > >  {
> > > > > >         struct plda_pcie_rp *port =3D irq_desc_get_handler_data=
(desc);
> > > > > > @@ -454,13 +449,10 @@ int plda_init_interrupts(struct platform_=
device *pdev,
> > > > > >
> > > > > >                 if (event->request_event_irq)
> > > > > >                         ret =3D event->request_event_irq(port, =
event_irq, i);
> > > > > > -               else
> > > > > > -                       ret =3D devm_request_irq(dev, event_irq=
,
> > > > > > -                                              plda_event_handl=
er,
> > > > > > -                                              0, NULL, port);
> > > > >
> > > > > This change is not related to the memleak. But I'd like to have i=
t in a separate
> > > > > patch since this code is absolutely not required, rather pointles=
s.
> > > > >
> > > > Yes, remove these changes to fix the memory leak issue I observed.
> > > >
> > >
> > > Sorry, I don't get you. This specific code change of removing 'devm_r=
equest_irq'
> > > is not supposed to fix memleak.
> > >
> > > If you are seeing the memleak getting fixed because of it, then somet=
hing is
> > > wrong with the irq implementation. You need to figure it out.
> >
> > Declaring request_event_irq in the host controller facilitates the
> > creation of a dedicated IRQ event handler.
> > In its absence, a dummy devm_request_irq was employed, but this
> > resulted in unhandled IRQs and subsequent memory leaks.
>
> What do you mean by 'unhandled IRQs'? There is a dummy IRQ handler invoke=
d to
> handle these IRQs. Even your starfive_event_handler() that you proposed w=
as
> doing the same thing.
>
Yes, but my solution was to work around

> > Eliminating the dummy code eliminated the memory leak logs.
>
From the code, we are creating a mapping of the IRQ event

     for_each_set_bit(i, &port->events_bitmap, port->num_events) {
                event_irq =3D irq_create_mapping(port->event_domain, i);
                if (!event_irq) {
                        dev_err(dev, "failed to map hwirq %d\n", i);
                        return -ENXIO;
                }

                if (event->request_event_irq)
                        ret =3D event->request_event_irq(port,
event_irq, i);   <---
                else
                        ret =3D devm_request_irq(dev, event_irq,
                                               plda_event_handler,
                                               0, NULL, port);

                if (ret) {
                        dev_err(dev, "failed to request IRQ %d\n", event_ir=
q);
                        return ret;
                }
        }

in the microchip PCIe host we are requesting those IRQ events mapping.

static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
                                int event)
{
        return devm_request_irq(plda->dev, event_irq, mc_event_handler,
                                0, event_cause[event].sym, plda);
}

static const struct plda_event_ops mc_event_ops =3D {
        .get_events =3D mc_get_events,
};

static const struct plda_event mc_event =3D {
        .request_event_irq =3D mc_request_event_irq,
        .intx_event        =3D EVENT_LOCAL_PM_MSI_INT_INTX,
        .msi_event         =3D EVENT_LOCAL_PM_MSI_INT_MSI,
};

> Sorry, this is not a valid justification. But as I said before, the chang=
e
> itself (removing the dummy irq handler and related code) looks good to me=
 as I
> see no need for that. But I cannot accept it as a fix for the memleak.

The StarFive PCIe host lacks the necessary hardware event mapping.
Consequently, the system attempts to handle dummy events, resulting
in observed log messages.

The issue is likely due to devm_request_irq being called with a NULL devnam=
e,
preventing proper IRQ mapping.

I have tested on the StarFive JH7110 VisionFive2 RISC-V board.

$ sudo cat /sys/kernel/debug/kmemleak
unreferenced object 0xffffffd6c47c2600 (size 128):
  comm "kworker/u16:2", pid 38, jiffies 4294942263
  hex dump (first 32 bytes):
    cc 7c 5a 8d ff ff ff ff 40 b0 47 c8 d6 ff ff ff  .|Z.....@.G.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 4f07ff07):
    __create_object+0x2a/0xfc
    kmemleak_alloc+0x38/0x98
    __kmalloc_cache_noprof+0x296/0x444
    request_threaded_irq+0x168/0x284
    devm_request_threaded_irq+0xa8/0x13c
    plda_init_interrupts+0x46e/0x858
    plda_pcie_host_init+0x356/0x468
    starfive_pcie_probe+0x2f6/0x398
    platform_probe+0x106/0x150
    really_probe+0x30e/0x746
    __driver_probe_device+0x11c/0x2c2
    driver_probe_device+0x5e/0x316
    __device_attach_driver+0x296/0x3a4
    bus_for_each_drv+0x1d0/0x260
    __device_attach+0x1fa/0x2d6
    device_initial_probe+0x14/0x28
unreferenced object 0xffffffd6c47c2900 (size 128):
  comm "kworker/u16:2", pid 38, jiffies 4294942281

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Thanks
-Anand

