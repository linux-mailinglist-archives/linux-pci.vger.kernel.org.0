Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA275151D58
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2020 16:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgBDPda (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Feb 2020 10:33:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45487 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgBDPda (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Feb 2020 10:33:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so12445124lfa.12;
        Tue, 04 Feb 2020 07:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LJmRxK69K+rajTw2que8OstYhrowSd+8M9XTFk/1QkA=;
        b=T5ANIsVwlVe60RMMAUn3OidOFSAXyCix0iT0VVndvG7px8TKS/1JHG6leOy3PZMKkQ
         Srb/GUKR4KYFRxk1fo8Re+2Yz1e11WWRfMQDIoNOZ1066ZrBYSmmnvFTeeN5C8RCXsRy
         DkOf4ILB6ndo7ZX279hxVgV6nYNr80ftTCu8NAd5bv3iqFNIh2vRqb1FKLT1BqAiHQz/
         6oTimcn/BqH/1+wXVYTw4DVu9DfHUtWfYl5BZ1J7kKbemT7vaJ2aM/HboYKVJLLVNdSf
         ypnTwqWVeQkDBNX16nAi4pJfD4IvPj2jEv01TPJHmWbCNtRgRQ/+MMjMteNFKaP6mNps
         Q+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LJmRxK69K+rajTw2que8OstYhrowSd+8M9XTFk/1QkA=;
        b=qlNQLPYlzk2h5BnuotTkbM69n8AC6ZBPrNLxE2RAxxI3GKGoaeSFBP61k7zDF6LH2C
         06vN9iV0NAxBGEjEN70D0gxwXhiPtf46NCJAEI393TXFVtph+p0moM7imYzQYKRTt+tB
         Ly37YZzyhtbqLoAhLHdhZVv+kGMfael+h53/OlQ8CXrwJLKIPJQ2oK2RFZAkBcd8K4jU
         jt4+4L8ZhekC6j0TmVVK0y5yIvOLflxwz/6EVs2pBh/uoW4gPz8Bhd4yb7qywpuSHQVC
         zYS9dDsB95x2LqXfLT8oB0f0GMmpY9fBi2SGmudhWLA++D4Opp2zTXKsbC6F4Fu16BTi
         iC2Q==
X-Gm-Message-State: APjAAAXwQbk+TTB6P1nH4Jp0AStuIVmuslIvI2k89m+Hg9qQhjqUp48Z
        D4vC70m6VzsAuKJZSEL6FxkPL1Z0IhY4aPIo1K4=
X-Google-Smtp-Source: APXvYqyqe8H3q4eNfWTPGLVxh9V3VpWL8s7A0cFOaqb2aemuxZ+s+DN/YJvDqDiTDFzchFMZ2S85NoN4Oqd5PUCVz+k=
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr15385274lfl.125.1580830407423;
 Tue, 04 Feb 2020 07:33:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+jdUT6d4CHWFyd1vLopY89YeobaSmzsfXL1u=Lt+hHtnA@mail.gmail.com>
 <20200201182934.GA6311@google.com>
In-Reply-To: <20200201182934.GA6311@google.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 4 Feb 2020 21:03:15 +0530
Message-ID: <CAHhAz+h680cNoT8C2VnfQiXc-qxihJmOw8zzd=PdZhg_OiDBbw@mail.gmail.com>
Subject: Re: pcie: xilinx: kernel hang - ISR readl()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 1, 2020 at 11:59 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Feb 01, 2020 at 08:44:40AM +0530, Muni Sekhar wrote:
> > On Sat, Feb 1, 2020 at 2:16 AM Bjorn Helgaas <helgaas@kernel.org> wrote=
:
> > > On Fri, Jan 31, 2020 at 10:04:05PM +0530, Muni Sekhar wrote:
> > > > On Fri, Jan 31, 2020 at 12:30 AM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> > > > > On Thu, Jan 30, 2020 at 09:37:48PM +0530, Muni Sekhar wrote:
> > > > > > On Thu, Jan 9, 2020 at 10:05 AM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 09, 2020 at 08:47:51AM +0530, Muni Sekhar wrote:
> > > > > > > > On Thu, Jan 9, 2020 at 1:45 AM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> > > > > > > > > On Tue, Jan 07, 2020 at 09:45:13PM +0530, Muni Sekhar wro=
te:
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > I have module with Xilinx FPGA. It implements UART(s), =
SPI(s),
> > > > > > > > > > parallel I/O and interfaces them to the Host CPU via PC=
I Express bus.
> > > > > > > > > > I see that my system freezes without capturing the cras=
h dump for
> > > > > > > > > > certain tests. I debugged this issue and it was tracked=
 down to the
> > > > > > > > > > below mentioned interrupt handler code.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > In ISR, first reads the Interrupt Status register using=
 =E2=80=98readl()=E2=80=99 as
> > > > > > > > > > given below.
> > > > > > > > > >     status =3D readl(ctrl->reg + INT_STATUS);
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > And then clears the pending interrupts using =E2=80=98w=
ritel()=E2=80=99 as given blow.
> > > > > > > > > >         writel(status, ctrl->reg + INT_STATUS);
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I've noticed a kernel hang if INT_STATUS register read =
again after
> > > > > > > > > > clearing the pending interrupts.
> > > > > > > > > >
> > > > > > > > > > Can someone clarify me why the kernel hangs without cra=
sh dump incase
> > > > > > > > > > if I read the INT_STATUS register using readl() after c=
learing the
> > > > > > > > > > pending bits?
> > > > > > > > > >
> > > > > > > > > > Can readl() block?
> > > > > > > > >
> > > > > > > > > readl() should not block in software.  Obviously at the h=
ardware CPU
> > > > > > > > > instruction level, the read instruction has to wait for t=
he result of
> > > > > > > > > the read.  Since that data is provided by the device, i.e=
., your FPGA,
> > > > > > > > > it's possible there's a problem there.
> > > > > > > >
> > > > > > > > Thank you very much for your reply.
> > > > > > > > Where can I find the details about what is protocol for rea=
ding the
> > > > > > > > =E2=80=98memory mapped IO=E2=80=99? Can you point me to any=
 useful links..
> > > > > > > > I tried locate the exact point of the kernel code where CPU=
 waits for
> > > > > > > > read instruction as given below.
> > > > > > > > readl() -> __raw_readl() -> return *(const volatile u32 __f=
orce *)add
> > > > > > > > Do I need to check for the assembly instructions, here?
> > > > > > >
> > > > > > > The C pointer dereference, e.g., "*address", will be some sor=
t of a
> > > > > > > "load" instruction in assembly.  The CPU wait isn't explicit;=
 it's
> > > > > > > just that when you load a value, the CPU waits for the value.
> > > > > > >
> > > > > > > > > Can you tell whether the FPGA has received the Memory Rea=
d for
> > > > > > > > > INT_STATUS and sent the completion?
> > > > > > > >
> > > > > > > > Is there a way to know this with the help of software debug=
ging(either
> > > > > > > > enabling dynamic debugging or adding new debug prints)? Can=
 you please
> > > > > > > > point some tools\hw needed to find this?
> > > > > > >
> > > > > > > You could learn this either via a PCIe analyzer (expensive pi=
ece of
> > > > > > > hardware) or possibly some logic in the FPGA that would log P=
CIe
> > > > > > > transactions in a buffer and make them accessible via some ot=
her
> > > > > > > interface (you mentioned it had parallel and other interfaces=
).
> > > > > > >
> > > > > > > > > On the architectures I'm familiar with, if a device doesn=
't respond,
> > > > > > > > > something would eventually time out so the CPU doesn't wa=
it forever.
> > > > > > > >
> > > > > > > > What is timeout here? I mean how long CPU waits for complet=
ion? Since
> > > > > > > > this code runs from interrupt context, does it causes the s=
ystem to
> > > > > > > > freeze if timeout is more?
> > > > > > >
> > > > > > > The Root Port should have a Completion Timeout.  This is requ=
ired by
> > > > > > > the PCIe spec.  The *reporting* of the timeout is somewhat
> > > > > > > implementation-specific since the reporting is outside the PC=
Ie
> > > > > > > domain.  I don't know the duration of the timeout, but it cer=
tainly
> > > > > > > shouldn't be long enough to look like a "system freeze".
> > > > > > Does kernel writes to PCIe configuration space register =E2=80=
=98Device
> > > > > > Control 2 Register=E2=80=99 (Offset 0x28)? When I tried to read=
 this register,
> > > > > > I noticed bit 4 is set (which disables completion timeouts) and=
 rest
> > > > > > all other bits are zero. So, Completion Timeout detection mecha=
nism is
> > > > > > disabled, right? If so what could be the reason for this?
> > > > >
> > > > > To my knowledge Linux doesn't set PCI_EXP_DEVCTL2_COMP_TMOUT_DIS
> > > > > except for one powerpc case.  You can check yourself by using csc=
ope
> > > > > or grep to look for PCI_EXP_DEVCTL2_COMP_TMOUT_DIS or PCI_EXP_DEV=
CTL2.
> > > > >
> > > > > If you're seeing bit 4 (PCI_EXP_DEVCTL2_COMP_TMOUT_DIS) set, it's
> > > > > likely because firmware set it.  You can try booting with
> > > > > "pci=3Dearlydump" to see what's there before Linux starts changin=
g
> > > > > things.
> >
> > Yes Linux doesn't set PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, verified with ear=
lydump.
> > Firmware means BIOS? If so is there a way to enable the timeout detecti=
on?
>
> Sure; you can change the kernel to turn off
> PCI_EXP_DEVCTL2_COMP_TMOUT_DIS (for debugging purposes, at least), or
> you can do it with setpci, e.g.,
>
>   # setpci -s01:00.0 CAP_EXP+0x28.W=3D0x0000
If a PCIe device(endpoint) doesn't respond for non-posted memory reads
and if we turn off PCI_EXP_DEVCTL2_COMP_TMOUT_DIS as mentioned above
then it should result time out instead of system freeze, right?

Also, is there a way to know whether timeout occurred at the host
side(with the help of kernel log by enabling dynamic debug)?

>
> > 01:00.0 RAM memory: PLDA Device 5555
> >         Subsystem: Device 4000:0000
> >         Flags: bus master, fast devsel, latency 0, IRQ 16
> >         Memory at d0400000 (32-bit, non-prefetchable) [size=3D4M]
> >         Capabilities: [40] Power Management version 3
> >         Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> >         Capabilities: [60] Express Endpoint, MSI 00
> >         Kernel driver in use: PLDA PCI
> >         Kernel modules: plda_pci
> >
> > 00: 56 15 55 55 07 00 10 00 00 00 00 05 10 00 00 00
> > 10: 00 00 40 d0 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
> > 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
> > 40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 60: 10 00 02 00 c2 8f 00 00 00 28 01 00 21 f4 03 00
> > 70: 01 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 80: 00 00 00 00 02 00 00 00 10 00 00 00 00 00 00 00
> > 90: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> > So, on my system, the PCI Express capability is at "[60]" and
> > PCI_EXP_DEVCTL2 is at 0x88 with value 0x0010
> > (PCI_EXP_DEVCTL2_COMP_TMOUT_DIS). Also this matches what lspci
> > decodes:
> >
> > $ sudo lspci -vvs00.0 | grep -A1 DevCtl2
> >                 DevCtl2: Completion Timeout: 50us to 50ms,
> > TimeoutDis+, LTR-, OBFF Disabled
> >                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- S=
peedDis-



--=20
Thanks,
Sekhar
