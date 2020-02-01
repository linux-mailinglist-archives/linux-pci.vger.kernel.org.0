Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E54B14F5FE
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2020 04:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgBADO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 22:14:58 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:33350 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgBADO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2020 22:14:57 -0500
Received: by mail-lj1-f170.google.com with SMTP id y6so9156475lji.0;
        Fri, 31 Jan 2020 19:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=93pwNI+EA5KXGtDcgQq49ylUkDy3Gx7TemF452cUd7E=;
        b=HfD1FEkjJGgbHqXtOHHdxSzeOaur4CKIhxlIL4i/EGkGUBdJqkjgS579AG0TZTI3xp
         Wacf6h6IWj/XTk2y5VXsjYVZruQFRfK/nIK2Q+wwGGCdtyJdFUxGwID0bayTH2WPjyad
         6ri8i1HKVPH2WTGGJCqohfIS8o6QQwIdr/vOXpC+mOhrKfuLQvznwAdgciRnxhbAsIqD
         dqnDsBECOSHfzkLINRq5CcJr9T9pWPwNFFGXd/AioPXDfEYoKm6SjHPikOZVOInufaav
         aGgUE/ErrpK7rG4b3D/wo0lguqHrq3n2GxlwL1YXI6+TVx2rJxqWWzTz+tdRZd/cPQ15
         SJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=93pwNI+EA5KXGtDcgQq49ylUkDy3Gx7TemF452cUd7E=;
        b=r5jE9C4GOjHvQEwVvbjrsnqexkjHr1zNQe7sdEilVSEYNWGS5p1AAZjPyrEwP9lfu2
         OAviDyQPxC0u6qQLdQYzu8qNJiWVEZN3YokbwisS9wlrzHyzApKbbnVYpqOdt66KFrNP
         gyTjE7aDLZjuI2XOX0pTjolGduxG+ESF/6RE6f8X+KxOeLHJfkPuqu7ByaWIORXUhciB
         U86lQncu9XdeLstK8wRj6Ez354/oBKvEC/LabmWERntTx83h6J7H6zzZHCGJfsh7mBwh
         LjxtY0DUfFoVxcgsp1YMr0GiCIczxe6pC7V6elBo1ZqVqu4dcplvfzVG8YYvrqaxgSYW
         h05A==
X-Gm-Message-State: APjAAAWbyqMl3Ut72lYJx4LnZwS51L9vGwtMEaNvKrriSQroznniEGwQ
        nocci1gT+p/WulgmER8nu99tuU3u0gw+A46egwM=
X-Google-Smtp-Source: APXvYqzv4taPaERf3o0vcoSQm08a1NdRfjUt7sWTeTsGNtGyI6ho8ZurQyn9t0rRzUr5oBYGuaXgY1XpEfiBKEn6Pq0=
X-Received: by 2002:a2e:9218:: with SMTP id k24mr7455698ljg.262.1580526893026;
 Fri, 31 Jan 2020 19:14:53 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+i4HVymeCzyPFRe+1E0R8_nD4LHmHApD2BrLfoWRKSJFA@mail.gmail.com>
 <20200131204630.GA90018@google.com>
In-Reply-To: <20200131204630.GA90018@google.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Sat, 1 Feb 2020 08:44:40 +0530
Message-ID: <CAHhAz+jdUT6d4CHWFyd1vLopY89YeobaSmzsfXL1u=Lt+hHtnA@mail.gmail.com>
Subject: Re: pcie: xilinx: kernel hang - ISR readl()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 1, 2020 at 2:16 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jan 31, 2020 at 10:04:05PM +0530, Muni Sekhar wrote:
> > On Fri, Jan 31, 2020 at 12:30 AM Bjorn Helgaas <helgaas@kernel.org> wro=
te:
> > > On Thu, Jan 30, 2020 at 09:37:48PM +0530, Muni Sekhar wrote:
> > > > On Thu, Jan 9, 2020 at 10:05 AM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> > > > >
> > > > > On Thu, Jan 09, 2020 at 08:47:51AM +0530, Muni Sekhar wrote:
> > > > > > On Thu, Jan 9, 2020 at 1:45 AM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > > > > > On Tue, Jan 07, 2020 at 09:45:13PM +0530, Muni Sekhar wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > I have module with Xilinx FPGA. It implements UART(s), SPI(=
s),
> > > > > > > > parallel I/O and interfaces them to the Host CPU via PCI Ex=
press bus.
> > > > > > > > I see that my system freezes without capturing the crash du=
mp for
> > > > > > > > certain tests. I debugged this issue and it was tracked dow=
n to the
> > > > > > > > below mentioned interrupt handler code.
> > > > > > > >
> > > > > > > >
> > > > > > > > In ISR, first reads the Interrupt Status register using =E2=
=80=98readl()=E2=80=99 as
> > > > > > > > given below.
> > > > > > > >     status =3D readl(ctrl->reg + INT_STATUS);
> > > > > > > >
> > > > > > > >
> > > > > > > > And then clears the pending interrupts using =E2=80=98write=
l()=E2=80=99 as given blow.
> > > > > > > >         writel(status, ctrl->reg + INT_STATUS);
> > > > > > > >
> > > > > > > >
> > > > > > > > I've noticed a kernel hang if INT_STATUS register read agai=
n after
> > > > > > > > clearing the pending interrupts.
> > > > > > > >
> > > > > > > > Can someone clarify me why the kernel hangs without crash d=
ump incase
> > > > > > > > if I read the INT_STATUS register using readl() after clear=
ing the
> > > > > > > > pending bits?
> > > > > > > >
> > > > > > > > Can readl() block?
> > > > > > >
> > > > > > > readl() should not block in software.  Obviously at the hardw=
are CPU
> > > > > > > instruction level, the read instruction has to wait for the r=
esult of
> > > > > > > the read.  Since that data is provided by the device, i.e., y=
our FPGA,
> > > > > > > it's possible there's a problem there.
> > > > > >
> > > > > > Thank you very much for your reply.
> > > > > > Where can I find the details about what is protocol for reading=
 the
> > > > > > =E2=80=98memory mapped IO=E2=80=99? Can you point me to any use=
ful links..
> > > > > > I tried locate the exact point of the kernel code where CPU wai=
ts for
> > > > > > read instruction as given below.
> > > > > > readl() -> __raw_readl() -> return *(const volatile u32 __force=
 *)add
> > > > > > Do I need to check for the assembly instructions, here?
> > > > >
> > > > > The C pointer dereference, e.g., "*address", will be some sort of=
 a
> > > > > "load" instruction in assembly.  The CPU wait isn't explicit; it'=
s
> > > > > just that when you load a value, the CPU waits for the value.
> > > > >
> > > > > > > Can you tell whether the FPGA has received the Memory Read fo=
r
> > > > > > > INT_STATUS and sent the completion?
> > > > > >
> > > > > > Is there a way to know this with the help of software debugging=
(either
> > > > > > enabling dynamic debugging or adding new debug prints)? Can you=
 please
> > > > > > point some tools\hw needed to find this?
> > > > >
> > > > > You could learn this either via a PCIe analyzer (expensive piece =
of
> > > > > hardware) or possibly some logic in the FPGA that would log PCIe
> > > > > transactions in a buffer and make them accessible via some other
> > > > > interface (you mentioned it had parallel and other interfaces).
> > > > >
> > > > > > > On the architectures I'm familiar with, if a device doesn't r=
espond,
> > > > > > > something would eventually time out so the CPU doesn't wait f=
orever.
> > > > > >
> > > > > > What is timeout here? I mean how long CPU waits for completion?=
 Since
> > > > > > this code runs from interrupt context, does it causes the syste=
m to
> > > > > > freeze if timeout is more?
> > > > >
> > > > > The Root Port should have a Completion Timeout.  This is required=
 by
> > > > > the PCIe spec.  The *reporting* of the timeout is somewhat
> > > > > implementation-specific since the reporting is outside the PCIe
> > > > > domain.  I don't know the duration of the timeout, but it certain=
ly
> > > > > shouldn't be long enough to look like a "system freeze".
> > > > Does kernel writes to PCIe configuration space register =E2=80=98De=
vice
> > > > Control 2 Register=E2=80=99 (Offset 0x28)? When I tried to read thi=
s register,
> > > > I noticed bit 4 is set (which disables completion timeouts) and res=
t
> > > > all other bits are zero. So, Completion Timeout detection mechanism=
 is
> > > > disabled, right? If so what could be the reason for this?
> > >
> > > To my knowledge Linux doesn't set PCI_EXP_DEVCTL2_COMP_TMOUT_DIS
> > > except for one powerpc case.  You can check yourself by using cscope
> > > or grep to look for PCI_EXP_DEVCTL2_COMP_TMOUT_DIS or PCI_EXP_DEVCTL2=
.
> > >
> > > If you're seeing bit 4 (PCI_EXP_DEVCTL2_COMP_TMOUT_DIS) set, it's
> > > likely because firmware set it.  You can try booting with
> > > "pci=3Dearlydump" to see what's there before Linux starts changing
> > > things.
Yes Linux doesn't set PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, verified with earlydu=
mp.
Firmware means BIOS? If so is there a way to enable the timeout detection?

01:00.0 RAM memory: PLDA Device 5555
        Subsystem: Device 4000:0000
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at d0400000 (32-bit, non-prefetchable) [size=3D4M]
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit-
        Capabilities: [60] Express Endpoint, MSI 00
        Kernel driver in use: PLDA PCI
        Kernel modules: plda_pci

00: 56 15 55 55 07 00 10 00 00 00 00 05 10 00 00 00
10: 00 00 40 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 02 00 c2 8f 00 00 00 28 01 00 21 f4 03 00
70: 01 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 02 00 00 00 10 00 00 00 00 00 00 00
90: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

So, on my system, the PCI Express capability is at "[60]" and
PCI_EXP_DEVCTL2 is at 0x88 with value 0x0010
(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS). Also this matches what lspci
decodes:

$ sudo lspci -vvs00.0 | grep -A1 DevCtl2
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis+, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Speed=
Dis-



> >
> > [    0.000000] pci 0000:01:00.0 config space:
> >
> >                  00: 56 15 55 55 07 00 10 00 00 00 00 05 10 00 00 00
> >                  10: 00 00 40 d0 00 00 00 00 00 00 00 00 00 00 00 00
> >                  20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
> >                  30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
> >                  40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
> >                  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >                  60: 10 00 02 00 c2 8f 00 00 00 28 01 00 21 f4 03 00
> >                  70: 01 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
> >                  80: 00 00 00 00 02 00 00 00 10 00 00 00 00 00 00 00
> >                  90: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> >                  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >                  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >                  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >                  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >                  e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >                  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> >
> > Device Control 2" is located @offset 0x28 in PCI Express Capability
> > Structure. But where does 'PCI Express Capability Structure' located
> > in the above mentioned 'PCI Express Configuration Space'?
>
> "lspci -v" tells you the location of the capability.  For example, on
> my system:
>
>   # lspci -vxxxs1c.0
>   00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root=
 Port (rev f1) (prog-if 00 [Normal decode])
>           Flags: bus master, fast devsel, latency 0, IRQ 122
>           Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latenc=
y=3D0
>           I/O behind bridge: None
>           Memory behind bridge: f1100000-f11fffff [size=3D1M]
>           Prefetchable memory behind bridge: None
>           Capabilities: [40] Express Root Port (Slot+), MSI 00
>           Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>           Capabilities: [90] Subsystem: Lenovo Sunrise Point-LP PCI Expre=
ss Root Port
>           Capabilities: [a0] Power Management version 3
>           Capabilities: [100] Advanced Error Reporting
>           Capabilities: [140] Access Control Services
>           Capabilities: [200] L1 PM Substates
>           Capabilities: [220] Secondary PCI Express
>                   LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
>                   LaneErrStat: 0
>           Kernel driver in use: pcieport
>   00: 86 80 10 9d 07 04 10 00 f1 00 04 06 00 00 81 00
>   10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 20
>   20: 10 f1 10 f1 f1 ff 01 00 00 00 00 00 00 00 00 00
>   30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 02 00
>   40: 10 80 42 01 01 80 00 00 20 00 10 00 13 48 72 01
>   50: 42 00 12 70 00 b2 04 00 00 00 48 01 00 00 00 00
>   60: 00 00 00 00 37 08 00 00 00 04 00 00 0e 00 00 00
>   70: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   80: 05 90 01 00 18 02 e0 fe 00 00 00 00 00 00 00 00
>   90: 0d a0 00 00 aa 17 38 22 00 00 00 00 00 00 00 00
>   a0: 01 00 03 c8 00 00 00 00 00 00 00 00 00 00 00 00
>   b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   d0: 11 10 00 07 42 18 00 00 08 00 9e 8b 00 00 00 00
>   e0: 00 f7 73 00 03 90 00 00 16 80 12 00 00 00 00 00
>   f0: 50 01 00 00 00 03 00 40 b3 0f 30 08 04 00 00 01
>
> The PCI Express capability is at "[40]" (0x40) and PCI_EXP_DEVCTL2 is
> a 16-bit register at offset 40 (0x28) from that.  So on my system,
> PCI_EXP_DEVCTL2 is at 0x68 with value 0x0400 (PCI_EXP_DEVCTL2_LTR_EN).
> This matches what lspci decodes:
>
>   # lspci -vvs1c.0 | grep -A1 DevCtl2
>        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF=
 Disabled ARIFwd-
>                 AtomicOpsCtl: ReqEn- EgressBlck-
>
>


--=20
Thanks,
Sekhar
