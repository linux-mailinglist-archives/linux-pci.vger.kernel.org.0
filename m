Return-Path: <linux-pci+bounces-21882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A01A3D2E7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 09:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF2F3BBB30
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 08:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEFE1E9B2C;
	Thu, 20 Feb 2025 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX+C8qN+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4981E9B2F;
	Thu, 20 Feb 2025 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039238; cv=none; b=UJcSFO8JtHqLnFpJdu9cixXj3avA6VoomND/Jx+EYVDzP1Q0AzFzVQNh7vrOPWGpvmsqi47Ig86pxMKTZ2j4kZkOW1uMQVzOidRQ6JIl25wQF5mSEKAiknMHdT030sa2lSTDOThFwf8RcyMEG/zAMPs1elwCKOJWaiAaWkscuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039238; c=relaxed/simple;
	bh=Ts5ro0Nma2w9Fs7gmMtDJIx8s8uZEBSsGN6VGxOwjW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZ3EK7sAgMzF+1D4yKnFfXhbmULBAHNxXqH8Dc0D0MPYBmOqrt6/Q3uBfp89DM8YTmZk2ZfHVr3mj1z+KLTBC5hksye8zU8FLl1kfUKxpsuHC8DXQlkUom5PJBsMP+hTWpoRW8mfxAHjwgQuAjzZ7HiTTmpPpDBnzgob2DXmFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hX+C8qN+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb892fe379so114842266b.0;
        Thu, 20 Feb 2025 00:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740039235; x=1740644035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00ltXR+zojYOd5CStCmbVrQEHhnEDcFy/ALKAk/csH0=;
        b=hX+C8qN+NS5rV8xAm6hUMPS7yUnFJWqlvpkbmP5lfAwB38AtqzMVFjLCJL/pBJPNLN
         WHhltRdahsFCO3nGgjDHQ9RNP8P2LqYFe/NQEM2A1kPg4PA1ZCLHktvXoFD3v91UFL77
         mxeQ76FYAIXC3SwRSdm3CkIdGy39pV7O9RRQU1xWufDEkAvrqbA+7dqbNsZUIJe+ZI1h
         p3Bv9TpWnJ09PYveLCSXSMPG4CRunSIBdtEpH/O9GhK/589Pv85tkR9cXmsP9G2IG375
         I95drYeQ+UcjO8ep5V4MsysSrVuM7JR26TsF7LE0jATVoDi2rpFFJIlEPXbqwB+C2N2s
         yE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740039235; x=1740644035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00ltXR+zojYOd5CStCmbVrQEHhnEDcFy/ALKAk/csH0=;
        b=kJSNBO3RQqoX68chk6X2zDBqzdpOjjI+/mt8oHJvaAmvFllhfEBxQBJ1WXU/h9g8PU
         1jvC9fQA3m3VIrh37BEbhtsWDpI6piyX8F0fid9Xf9MnG2NoO0L17carN+nAldE0Gk4n
         uxXcbV5uIMKlLiFthdJRwRh7geTJIy+0oSTlKauB2/7AlgCqVAOGLQqA5J1W+qX3e52o
         92i+TKHQysbg7QA3L4IFcBlhpxwPF2Iu/D9FnVGndaALjJD13ULLFSXd3hLNm114rovz
         J9BpGZ2s8abWe1AZMUnR5d77FG/QTKlTy09+UerDKBWTO977HSr4YMD1/4uq/2xOJFLV
         ci3A==
X-Forwarded-Encrypted: i=1; AJvYcCVLsJjd0mKACTfn+fJejPBSd/OmXOynELz09wgQjdAk2eY/5Hhv4OgcH/VFUBQgwCOj9E1fj0sS68HxxDM=@vger.kernel.org, AJvYcCWx7+dGgf6nRv9o3UFEhww3QoM+cARvVbzvV5J35ZMexyHc/lHIaKMT8t4qrg9YQ4nWkoHOX4W7Oc6z@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/qxhGszxkF34rRc704UyFhjN1yUxzXD8QvSsQGF5FRfHWhoc
	JJfR9o9CXOlGeNQpGN8b/Xd2cld64Ad6NlShNY7BGJKX587ouS9HyVmCfnpFkYVFGHkzvkPnuRn
	hlnbQnNUYn+8LIZFiwWAyxvw02HY=
X-Gm-Gg: ASbGncvKTp5Ik8mHDrxAE1YfEovNFaTfvPy362bDFia3ZCx2Tr/su/Fxz8N7LqJ0LNb
	aej9QL+y0lsnR64ngiB9D7Rx0yIzQIIfO3g9oAM23hBWgmqOMJqzHMfCU2+79HZ2QYk2/+oHf
X-Google-Smtp-Source: AGHT+IED8wK1KPR1PBGlA4EiCndsxJGYfRg9UK16KQYpuUuvmqvVtNWG6Opo105NHbDs/ILshsW1q1Jll/IOTxZ0gqc=
X-Received: by 2002:a05:6402:350d:b0:5e0:2d53:b2a with SMTP id
 4fb4d7f45d1cf-5e035ff9ca1mr56747410a12.3.1740039234751; Thu, 20 Feb 2025
 00:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208140110.2389-1-linux.amoon@gmail.com> <20250210174400.b63bhmtkuqhktb57@thinkpad>
 <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com> <20250214060935.cgnc436upawnfzn6@thinkpad>
In-Reply-To: <20250214060935.cgnc436upawnfzn6@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 20 Feb 2025 13:43:37 +0530
X-Gm-Features: AWEUYZk-6uTOYBKC1UrD7Huuzq3kPXLOxJDngC64OXeczWriHg3dyKBlisMrB44
Message-ID: <CANAwSgTWa9gwpPhVCYzJM5BL5wUkpB4eyDtX+Vs3SX3a9541wA@mail.gmail.com>
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

On Fri, 14 Feb 2025 at 11:39, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Feb 11, 2025 at 01:09:04AM +0530, Anand Moon wrote:
> > Hi Manivannan
> >
> > On Mon, 10 Feb 2025 at 23:14, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Sat, Feb 08, 2025 at 07:31:08PM +0530, Anand Moon wrote:
> > > > kmemleak reported following debug log
> > > >
> > > > $ sudo cat /sys/kernel/debug/kmemleak
> > > > unreferenced object 0xffffffd6c47c2600 (size 128):
> > > >   comm "kworker/u16:2", pid 38, jiffies 4294942263
> > > >   hex dump (first 32 bytes):
> > > >     cc 7c 5a 8d ff ff ff ff 40 b0 47 c8 d6 ff ff ff  .|Z.....@.G...=
..
> > > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
> > > >   backtrace (crc 4f07ff07):
> > > >     __create_object+0x2a/0xfc
> > > >     kmemleak_alloc+0x38/0x98
> > > >     __kmalloc_cache_noprof+0x296/0x444
> > > >     request_threaded_irq+0x168/0x284
> > > >     devm_request_threaded_irq+0xa8/0x13c
> > > >     plda_init_interrupts+0x46e/0x858
> > > >     plda_pcie_host_init+0x356/0x468
> > > >     starfive_pcie_probe+0x2f6/0x398
> > > >     platform_probe+0x106/0x150
> > > >     really_probe+0x30e/0x746
> > > >     __driver_probe_device+0x11c/0x2c2
> > > >     driver_probe_device+0x5e/0x316
> > > >     __device_attach_driver+0x296/0x3a4
> > > >     bus_for_each_drv+0x1d0/0x260
> > > >     __device_attach+0x1fa/0x2d6
> > > >     device_initial_probe+0x14/0x28
> > > > unreferenced object 0xffffffd6c47c2900 (size 128):
> > > >   comm "kworker/u16:2", pid 38, jiffies 4294942281
> > > >
> > > > This patch addresses a kmemleak reported during StarFive PCIe drive=
r
> > > > initialization. The leak was observed with kmemleak reporting
> > > > unreferenced objects related to IRQ handling. The backtrace pointed
> > > > to the `request_threaded_irq` and related functions within the
> > > > `plda_init_interrupts` path, indicating that some allocated memory
> > > > related to IRQs was not being properly freed.
> > > >
> > > > The issue was that while the driver requested IRQs, it wasn't
> > > > correctly handling the lifecycle of the associated resources.
> > >
> > > What resources?
> > >
> > The Microchip PCIe host driver [1] handles  PCI, SEC, DEBUG, and LOCAL
> > hardware events
> > through a dedicated framework [2]. This framework allows the core drive=
r [3]
> > to monitor and wait for these specific events.
> >
>
> Microchip driver also has its own 'event_ops' and 'event_irq_chip', so de=
fining
> 'request_event_irq()' callback makes sense to me.
>
> > [1]: https://github.com/torvalds/linux/blob/master/drivers/pci/controll=
er/plda/pcie-microchip-host.c#L90-L292
> > [2]: https://github.com/torvalds/linux/blob/master/drivers/pci/controll=
er/plda/pcie-microchip-host.c#L374-L499
> > [3]: https://github.com/torvalds/linux/blob/master/drivers/pci/controll=
er/plda/pcie-plda-host.c#L448-L466
> >
> > StarFive PCIe driver currently lacks the necessary `request_event_irq`
> > implementation
> > to integrate with this event-handling mechanism, which prevents the cor=
e driver
> > from properly responding to these events on StarFive platforms.
> >
> > static const struct plda_event mc_event =3D {
> > .  request_event_irq =3D mc_request_event_irq,
> >   .intx_event        =3D EVENT_LOCAL_PM_MSI_INT_INTX,
> >   .msi_event         =3D EVENT_LOCAL_PM_MSI_INT_MSI,
> > };
> >
> > This patch implements dummy `request_event_irq` for the StarFive PCIe d=
river,
> > Since the core [3] driver is monitoring for these events
> >
>
> This still doesn't make sense to me. Under what condition you observed th=
e
> kmemleak? Since it points to devm_request_irq(), I can understand that th=
e
> memory allocated for the IRQ is not freed. But when does it happen?
>
The PCIe host driver is responsible for monitoring the PLDA PCIe EVENT irq.
However, I have been unable to locate the register map necessary to
implement the
required code updates,

alarm@archriscv:/media/nvme0/mainline/linux-riscv-6.y-devel$ cat
/proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 10:     101145      76126      79040      80218 RISC-V INTC   5 Edge
    riscv-timer
 12:          3          0          0          0 SiFive PLIC 111 Edge
    17030000.power-controller
 13:         20          0          0          0 SiFive PLIC  30 Edge
    1600c000.rng
 14:          0          0          0          0 SiFive PLIC   1 Edge
    ccache_ecc
 15:          0          0          0          0 SiFive PLIC   3 Edge
    ccache_ecc
 16:          0          0          0          0 SiFive PLIC   4 Edge
    ccache_ecc
 17:          0          0          0          0 SiFive PLIC   2 Edge
    ccache_ecc
 20:          0          0          0          0 SiFive PLIC  73 Edge
    dw_axi_dmac_platform
 21:       1694          0          0          0 SiFive PLIC  32 Edge      =
ttyS0
 22:          0          0          0          0 SiFive PLIC  35 Edge
    10030000.i2c
 23:          0          0          0          0 SiFive PLIC  75 Edge
    dw-mci
 24:          0          0          0          0 SiFive PLIC  37 Edge
    10050000.i2c
 25:        171          0          0          0 SiFive PLIC  50 Edge
    12050000.i2c
 26:          0          0          0          0 SiFive PLIC  51 Edge
    12060000.i2c
 27:      10419          0          0          0 SiFive PLIC  74 Edge
    dw-mci
 28:          6          0          0          0 SiFive PLIC  25 Edge
    13010000.spi
 29:          0          0          0          0 SiFive PLIC  38 Edge      =
pl022
 31:          0          0          0          0 PLDA PCIe EVENT  16
Edge      940000000.pcie
 32:          0          0          0          0 PLDA PCIe EVENT  17
Edge      940000000.pcie
 33:          0          0          0          0 PLDA PCIe EVENT  18
Edge      940000000.pcie
 34:          0          0          0          0 PLDA PCIe EVENT  20
Edge      940000000.pcie
 35:          0          0          0          0 PLDA PCIe EVENT  21
Edge      940000000.pcie
 36:          0          0          0          0 PLDA PCIe EVENT  22
Edge      940000000.pcie
 39:          0          0          0          0 PLDA PCIe EVENT  26
Edge      940000000.pcie
 40:          0          0          0          0 PLDA PCIe EVENT  27
Edge      940000000.pcie
 41:          0          0          0          0 17020000.pinctrl  41
Edge      16020000.mmc cd
 42:          0          0          0          0 PLDA PCIe EVENT  28
Edge      940000000.pcie
 44:          0          0          0          0 PLDA PCIe MSI   0
Edge      PCIe PME, aerdrv, PCIe bwctrl
 46:          0          0          0          0 PLDA PCIe EVENT  16
Edge      9c0000000.pcie
 47:          0          0          0          0 PLDA PCIe EVENT  17
Edge      9c0000000.pcie
 48:          0          0          0          0 PLDA PCIe EVENT  18
Edge      9c0000000.pcie
 49:          0          0          0          0 PLDA PCIe EVENT  20
Edge      9c0000000.pcie
 50:          0          0          0          0 PLDA PCIe EVENT  21
Edge      9c0000000.pcie
 51:          0          0          0          0 PLDA PCIe EVENT  22
Edge      9c0000000.pcie
 54:          0          0          0          0 PLDA PCIe EVENT  26
Edge      9c0000000.pcie
 55:          0          0          0          0 PLDA PCIe EVENT  27
Edge      9c0000000.pcie
 56:          0          0          0          0 PLDA PCIe EVENT  28
Edge      9c0000000.pcie
 58:          0          0          0          0 PLDA PCIe MSI
134217728 Edge      PCIe PME, aerdrv, PCIe bwctrl

Yep, Thanks for your review comment.

The following changes fix the kernel memory leak warning at my end.

$ git diff
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c
b/drivers/pci/controller/plda/pcie-plda-host.c
index 4153214ca410..d4e7c1b49607 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -461,6 +461,7 @@ int plda_init_interrupts(struct platform_device *pdev,

                if (ret) {
                        dev_err(dev, "failed to request IRQ %d\n", event_ir=
q);
+                       irq_dispose_mapping(event_irq);
                        return ret;
                }
        }
> > > > This patch introduces an event IRQ handler and the necessary
> > > > infrastructure to manage these IRQs, preventing the memory leak.
> > > >
> > >
> > > These handles appear pointless to me. What purpose are they serving?
> > >
> > Yes, you are correct, the core event monitoring framework [3] triggered=
 a
> > kernel memory leak. This patch adds a dummy IRQ callback as a
> > placeholder for proper event handling, which can be implemented in a
> > future patch.
> >
>
> The dummy request_event_irq() callback is not supposed to be needed in th=
e first
> place. So clearly, this patch is not fixing the actual memory leak but tr=
ying to
> cover it up.
You are correct.
>
> - Mani
>
Thanks
-Anand
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

