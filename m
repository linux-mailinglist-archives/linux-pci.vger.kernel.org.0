Return-Path: <linux-pci+bounces-21896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D3A3D673
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AF83B596A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0631E5B6F;
	Thu, 20 Feb 2025 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMaYtmhW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97A1EF080;
	Thu, 20 Feb 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047032; cv=none; b=q1esCJ9jIIu3mFoEetnCztNmxBlNyeh+OA5oeC4ivAiEV0ulOtcaasuR0mNn86D8rtC9e6oXBNuecknx1Muwcckkv6Irw+i/Z6xzu/K/RAkMYRonrIz/TpqMtX094W0HWSNo7RrqzfO7SXoJYVDVYE+nSEmNWtfMq2Zt3MQneAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047032; c=relaxed/simple;
	bh=0helDRaCYLnEE74Bkw6/ilIDyOIv9Iq8QcsN2XlLpFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFSXVCEIs1jIHGCUySF11cDbKnZ9QbT2hg/K+TahWlNAUFpulrOZ0P5kuFEg+q3gz3GVfEQMZVTpkME897SMlXu5GKLb5c46Bci3e1T736WhIFiOlDv7Ss0AvN3o6j1XX1KFk4sWiYIvWrx7BZZWAWWJjEDMZP8vF0KU36rHdLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMaYtmhW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso1185072a12.2;
        Thu, 20 Feb 2025 02:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740047028; x=1740651828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTW9JQ6BVPrLLka+lHFZ6vOQyZlCPwf9f6ytVArycVQ=;
        b=QMaYtmhWR7ONfG2lhTlz8gRjyDqGJoIinVEvd0x5PtXUW0hwmq86iLx2FxfFnzhl2t
         /2gKWr9XRdeu91TVWhBkn8QKh7+TbDZ3rTcW2+P9twW2QAkOplrrR9wVg7iJ7G6OCNVn
         HRzgSDw2oLp7cgIabwIHHojiGprt6vajVEWM6fv4iGIW3xL3tijCVY4Qt/nVMCENRVWP
         xf51pERxsdhzfVBXXNFloWL1Ce75fjES2MDFYBrnpEtFFrmYkCz1MP7m/n+YKgRdHhiX
         zfG7QkkTtICVMhAgii88bKuHrVlpOyvtM6MU18lkE6sSx0QAB4MXd/sqMH7qDu/l6yMg
         vnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047028; x=1740651828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTW9JQ6BVPrLLka+lHFZ6vOQyZlCPwf9f6ytVArycVQ=;
        b=fGcdxPJZbTLw4d575v+2Mk53obsAeKNyJUMkk72p0BfwsJWz5l5qfuT32wLisjn2uj
         oA+AOKC/bl7Vj95BWqPlW+Xq+6dZ7+kv+fPwGT+o3g9H/Q5jw8wxVu1Y4efbW+TgjweV
         3NfJcxQIgbVnuuHjKg59zYIEH8M7aZf5e2AOJh4brSQtzPn9zqN8WZYhYn9fOWDtjN40
         VY4vtOttsuEIEkskZunwQMzNfdhr4M3WkD9Uf5Tst7cAIzwpLmSQxHUoaVufc/NBHAlF
         tNJwAMUy3p6gAT4pySRrUev8dCvZvcacXvvEG+QRla33ndF9Eoipt7Yfywngquw26fyu
         r4vg==
X-Forwarded-Encrypted: i=1; AJvYcCU/uHj9QpesZVN/TWuUOBAIO2/fssoWSOrJGnvuaDDNHp/3391f1YPl8iiYwQKlUvetOIgTGlv53cLpZkU=@vger.kernel.org, AJvYcCVbDZRHI3JTvJH3FvVPxcTtrI+8SaLV6kac3JguQURu01EjyUp9Bdp54wt979DL6x8O1VwezEOq5HO1@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2wYnnzQXKnvcbU18GRn6cuSvIGtwBYLGmpelBT6ZaMAXnPZv
	hNvCXY96iep+Xyn5dIg29Jc4aB6WMsv0ebM0falVAt27EVtZOMWLVp5lsXBxlaYrdm0vIwFj+Qi
	HLG2LQpHwwbhbWhXC1iw78UQbEDg=
X-Gm-Gg: ASbGncvQNRnRPeuxyfKXawPYnOf6QSQfuYpHoNCVC0RHyNgZu+zhAxrJdqAKEWx7hcm
	8pTqPacN9UXO9vwPaX5nvQsgE2eCFsx+tYqAATeNs2pmF7x9RIbuLnWyz3XPUD9PTH5jezF4N
X-Google-Smtp-Source: AGHT+IG/YBcv0jlVxd1Dsly8KZN+lsED1+IXEzcMF/mPJVM7E5GmfDfmQEoy/eO99a4Eh905mqj/gm/Sz+sME9o8KZw=
X-Received: by 2002:a05:6402:5411:b0:5d0:f9f1:cd73 with SMTP id
 4fb4d7f45d1cf-5e08950d212mr6456185a12.13.1740047028024; Thu, 20 Feb 2025
 02:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208140110.2389-1-linux.amoon@gmail.com> <20250210174400.b63bhmtkuqhktb57@thinkpad>
 <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>
 <20250214060935.cgnc436upawnfzn6@thinkpad> <CANAwSgTWa9gwpPhVCYzJM5BL5wUkpB4eyDtX+Vs3SX3a9541wA@mail.gmail.com>
In-Reply-To: <CANAwSgTWa9gwpPhVCYzJM5BL5wUkpB4eyDtX+Vs3SX3a9541wA@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 20 Feb 2025 15:53:31 +0530
X-Gm-Features: AWEUYZmqz8wU1T6QmC-Vtq0Pg6l3DfCcfhyI17Ar7weexcUjspqcPZLiQMdvpto
Message-ID: <CANAwSgRvT-Mqj3XPrME6oKhYmnCUZLnwHfFHmSL=PK+xVLHAqw@mail.gmail.com>
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

Hi Manivannan,

On Thu, 20 Feb 2025 at 13:43, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Manivannan
>
> On Fri, 14 Feb 2025 at 11:39, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Feb 11, 2025 at 01:09:04AM +0530, Anand Moon wrote:
> > > Hi Manivannan
> > >
> > > On Mon, 10 Feb 2025 at 23:14, Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Sat, Feb 08, 2025 at 07:31:08PM +0530, Anand Moon wrote:
> > > > > kmemleak reported following debug log
> > > > >
> > > > > $ sudo cat /sys/kernel/debug/kmemleak
> > > > > unreferenced object 0xffffffd6c47c2600 (size 128):
> > > > >   comm "kworker/u16:2", pid 38, jiffies 4294942263
> > > > >   hex dump (first 32 bytes):
> > > > >     cc 7c 5a 8d ff ff ff ff 40 b0 47 c8 d6 ff ff ff  .|Z.....@.G.=
....
> > > > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
> > > > >   backtrace (crc 4f07ff07):
> > > > >     __create_object+0x2a/0xfc
> > > > >     kmemleak_alloc+0x38/0x98
> > > > >     __kmalloc_cache_noprof+0x296/0x444
> > > > >     request_threaded_irq+0x168/0x284
> > > > >     devm_request_threaded_irq+0xa8/0x13c
> > > > >     plda_init_interrupts+0x46e/0x858
> > > > >     plda_pcie_host_init+0x356/0x468
> > > > >     starfive_pcie_probe+0x2f6/0x398
> > > > >     platform_probe+0x106/0x150
> > > > >     really_probe+0x30e/0x746
> > > > >     __driver_probe_device+0x11c/0x2c2
> > > > >     driver_probe_device+0x5e/0x316
> > > > >     __device_attach_driver+0x296/0x3a4
> > > > >     bus_for_each_drv+0x1d0/0x260
> > > > >     __device_attach+0x1fa/0x2d6
> > > > >     device_initial_probe+0x14/0x28
> > > > > unreferenced object 0xffffffd6c47c2900 (size 128):
> > > > >   comm "kworker/u16:2", pid 38, jiffies 4294942281
> > > > >
> > > > > This patch addresses a kmemleak reported during StarFive PCIe dri=
ver
> > > > > initialization. The leak was observed with kmemleak reporting
> > > > > unreferenced objects related to IRQ handling. The backtrace point=
ed
> > > > > to the `request_threaded_irq` and related functions within the
> > > > > `plda_init_interrupts` path, indicating that some allocated memor=
y
> > > > > related to IRQs was not being properly freed.
> > > > >
> > > > > The issue was that while the driver requested IRQs, it wasn't
> > > > > correctly handling the lifecycle of the associated resources.
> > > >
> > > > What resources?
> > > >
> > > The Microchip PCIe host driver [1] handles  PCI, SEC, DEBUG, and LOCA=
L
> > > hardware events
> > > through a dedicated framework [2]. This framework allows the core dri=
ver [3]
> > > to monitor and wait for these specific events.
> > >
> >
> > Microchip driver also has its own 'event_ops' and 'event_irq_chip', so =
defining
> > 'request_event_irq()' callback makes sense to me.
> >
> > > [1]: https://github.com/torvalds/linux/blob/master/drivers/pci/contro=
ller/plda/pcie-microchip-host.c#L90-L292
> > > [2]: https://github.com/torvalds/linux/blob/master/drivers/pci/contro=
ller/plda/pcie-microchip-host.c#L374-L499
> > > [3]: https://github.com/torvalds/linux/blob/master/drivers/pci/contro=
ller/plda/pcie-plda-host.c#L448-L466
> > >
> > > StarFive PCIe driver currently lacks the necessary `request_event_irq=
`
> > > implementation
> > > to integrate with this event-handling mechanism, which prevents the c=
ore driver
> > > from properly responding to these events on StarFive platforms.
> > >
> > > static const struct plda_event mc_event =3D {
> > > .  request_event_irq =3D mc_request_event_irq,
> > >   .intx_event        =3D EVENT_LOCAL_PM_MSI_INT_INTX,
> > >   .msi_event         =3D EVENT_LOCAL_PM_MSI_INT_MSI,
> > > };
> > >
> > > This patch implements dummy `request_event_irq` for the StarFive PCIe=
 driver,
> > > Since the core [3] driver is monitoring for these events
> > >
> >
> > This still doesn't make sense to me. Under what condition you observed =
the
> > kmemleak? Since it points to devm_request_irq(), I can understand that =
the
> > memory allocated for the IRQ is not freed. But when does it happen?
> >
> The PCIe host driver is responsible for monitoring the PLDA PCIe EVENT ir=
q.
> However, I have been unable to locate the register map necessary to
> implement the
> required code updates,
>
> alarm@archriscv:/media/nvme0/mainline/linux-riscv-6.y-devel$ cat
> /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  10:     101145      76126      79040      80218 RISC-V INTC   5 Edge
>     riscv-timer
>  12:          3          0          0          0 SiFive PLIC 111 Edge
>     17030000.power-controller
>  13:         20          0          0          0 SiFive PLIC  30 Edge
>     1600c000.rng
>  14:          0          0          0          0 SiFive PLIC   1 Edge
>     ccache_ecc
>  15:          0          0          0          0 SiFive PLIC   3 Edge
>     ccache_ecc
>  16:          0          0          0          0 SiFive PLIC   4 Edge
>     ccache_ecc
>  17:          0          0          0          0 SiFive PLIC   2 Edge
>     ccache_ecc
>  20:          0          0          0          0 SiFive PLIC  73 Edge
>     dw_axi_dmac_platform
>  21:       1694          0          0          0 SiFive PLIC  32 Edge    =
  ttyS0
>  22:          0          0          0          0 SiFive PLIC  35 Edge
>     10030000.i2c
>  23:          0          0          0          0 SiFive PLIC  75 Edge
>     dw-mci
>  24:          0          0          0          0 SiFive PLIC  37 Edge
>     10050000.i2c
>  25:        171          0          0          0 SiFive PLIC  50 Edge
>     12050000.i2c
>  26:          0          0          0          0 SiFive PLIC  51 Edge
>     12060000.i2c
>  27:      10419          0          0          0 SiFive PLIC  74 Edge
>     dw-mci
>  28:          6          0          0          0 SiFive PLIC  25 Edge
>     13010000.spi
>  29:          0          0          0          0 SiFive PLIC  38 Edge    =
  pl022
>  31:          0          0          0          0 PLDA PCIe EVENT  16
> Edge      940000000.pcie
>  32:          0          0          0          0 PLDA PCIe EVENT  17
> Edge      940000000.pcie
>  33:          0          0          0          0 PLDA PCIe EVENT  18
> Edge      940000000.pcie
>  34:          0          0          0          0 PLDA PCIe EVENT  20
> Edge      940000000.pcie
>  35:          0          0          0          0 PLDA PCIe EVENT  21
> Edge      940000000.pcie
>  36:          0          0          0          0 PLDA PCIe EVENT  22
> Edge      940000000.pcie
>  39:          0          0          0          0 PLDA PCIe EVENT  26
> Edge      940000000.pcie
>  40:          0          0          0          0 PLDA PCIe EVENT  27
> Edge      940000000.pcie
>  41:          0          0          0          0 17020000.pinctrl  41
> Edge      16020000.mmc cd
>  42:          0          0          0          0 PLDA PCIe EVENT  28
> Edge      940000000.pcie
>  44:          0          0          0          0 PLDA PCIe MSI   0
> Edge      PCIe PME, aerdrv, PCIe bwctrl
>  46:          0          0          0          0 PLDA PCIe EVENT  16
> Edge      9c0000000.pcie
>  47:          0          0          0          0 PLDA PCIe EVENT  17
> Edge      9c0000000.pcie
>  48:          0          0          0          0 PLDA PCIe EVENT  18
> Edge      9c0000000.pcie
>  49:          0          0          0          0 PLDA PCIe EVENT  20
> Edge      9c0000000.pcie
>  50:          0          0          0          0 PLDA PCIe EVENT  21
> Edge      9c0000000.pcie
>  51:          0          0          0          0 PLDA PCIe EVENT  22
> Edge      9c0000000.pcie
>  54:          0          0          0          0 PLDA PCIe EVENT  26
> Edge      9c0000000.pcie
>  55:          0          0          0          0 PLDA PCIe EVENT  27
> Edge      9c0000000.pcie
>  56:          0          0          0          0 PLDA PCIe EVENT  28
> Edge      9c0000000.pcie
>  58:          0          0          0          0 PLDA PCIe MSI
> 134217728 Edge      PCIe PME, aerdrv, PCIe bwctrl
>
> Yep, Thanks for your review comment.
>
> The following changes fix the kernel memory leak warning at my end.
>
> $ git diff
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c
> b/drivers/pci/controller/plda/pcie-plda-host.c
> index 4153214ca410..d4e7c1b49607 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -461,6 +461,7 @@ int plda_init_interrupts(struct platform_device *pdev=
,
>
>                 if (ret) {
>                         dev_err(dev, "failed to request IRQ %d\n", event_=
irq);
> +                       irq_dispose_mapping(event_irq);
>                         return ret;
>                 }
>         }

Following the change fix this warning in a kernel memory leak.
Would you happen to have any comments on these changes?

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c
b/drivers/pci/controller/plda/pcie-plda-host.c
index 4153214ca410..5a72a5a33074 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -280,11 +280,6 @@ static u32 plda_get_events(struct plda_pcie_rp *port)
        return events;
 }

-static irqreturn_t plda_event_handler(int irq, void *dev_id)
-{
-       return IRQ_HANDLED;
-}
-
 static void plda_handle_event(struct irq_desc *desc)
 {
        struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
@@ -454,13 +449,10 @@ int plda_init_interrupts(struct platform_device *pdev=
,

                if (event->request_event_irq)
                        ret =3D event->request_event_irq(port, event_irq, i=
);
-               else
-                       ret =3D devm_request_irq(dev, event_irq,
-                                              plda_event_handler,
-                                              0, NULL, port);

                if (ret) {
                        dev_err(dev, "failed to request IRQ %d\n", event_ir=
q);
+                       irq_dispose_mapping(event_irq);
                        return ret;
                }
        }
> > > > > This patch introduces an event IRQ handler and the necessary
> > > > > infrastructure to manage these IRQs, preventing the memory leak.
> > > > >
> > > >
> > > > These handles appear pointless to me. What purpose are they serving=
?
> > > >
> > > Yes, you are correct, the core event monitoring framework [3] trigger=
ed a
> > > kernel memory leak. This patch adds a dummy IRQ callback as a
> > > placeholder for proper event handling, which can be implemented in a
> > > future patch.
> > >
> >
> > The dummy request_event_irq() callback is not supposed to be needed in =
the first
> > place. So clearly, this patch is not fixing the actual memory leak but =
trying to
> > cover it up.
> You are correct.
> >
> > - Mani
> >
> Thanks
> -Anand
Thanks
-Anand
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D

