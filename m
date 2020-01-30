Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5A814DE64
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 17:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgA3QIF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 11:08:05 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:35097 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA3QIF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2020 11:08:05 -0500
Received: by mail-lj1-f172.google.com with SMTP id q8so3979287ljb.2;
        Thu, 30 Jan 2020 08:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Sjycvy3blJghe69pG4Km+eObfl7ZjEyHXevLfvs8A8=;
        b=RzpRM1GHbCqcuvXJsJ8OwSNswRNTf5cIuOPiomhhXxg2kjYWmV86ERw++s9x7tFM0s
         tPXSr5NSSd1BRrhKYJUOUqMzq/rA2JvcKRcYan1Z9vCgipoGrtr0yUEFZbLhFb0jD4NM
         rUIJ+CXXwLtBqAexpyTT1+CgBocesTv7CJTnTLCBcnL5SP87g0EynIjr54ixQUok0A5r
         b0jsMrKXhOw4AEZv582ypb/PQCEIPNbphcv7ipqHs5eS0IMbK5dw5JxBlO9DeJ1j3f2F
         HbBjPFBmFGSsusxYI3ZUFHX2JrnoaVpPAId4yFSr2oXLm4jctEWLr5amW0nDgC8l3Mc5
         WQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Sjycvy3blJghe69pG4Km+eObfl7ZjEyHXevLfvs8A8=;
        b=Dh8aNXWEeJHHzsT+T3w21HOKAlj6soz/vbYmVApZqk6vqk1HBAhogd5XcoypG0245w
         N2qTOMZJ2RQOUO37lmi1TkqcqSHhsNsfZJRTWaM+Ft97AnuOx+hsyNsAWuQ3BYg9Lq/B
         pUuND9y3bHcV4ZFk0VSPMB+1na6emJoc0C4Up5tn1HZunpEODi9aaodArkgt1rVmzOsL
         8ExPruDbkYgJcFnck7kH1LGWS+K8duz2iE+X2EEzMSJ3CC2+zn66qv6De5TqyLg/Ac6o
         0ZZhcm3Wu2/DuzNoVlPSlzCyKoqofw3gR4mKlYIEGW8BHCkSoDKlP3QlaxCeOZwS6t3J
         OBLg==
X-Gm-Message-State: APjAAAWE8oGazOFCTyJNnawQb6XWQqiHSENNuk72CHPynDQFNmU9RT0X
        EAzels70wjtXW40qiGpXjw6yjVorIBK8t3VdETlUe3mB
X-Google-Smtp-Source: APXvYqy1lu0pzAuXtXNNsC5AAhp1/LRjlYC3u43goD7GXWgOIPDDyV7XKEapcNLrs2rklG7NdnsFil1gDsbWehfU+SY=
X-Received: by 2002:a2e:90c6:: with SMTP id o6mr3337859ljg.129.1580400481542;
 Thu, 30 Jan 2020 08:08:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+iy9b8Cyc6O=tjzjjixUQqKpTchrQWc+Y4JicAxB_HY5A@mail.gmail.com>
 <20200109043505.GA223446@google.com>
In-Reply-To: <20200109043505.GA223446@google.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Thu, 30 Jan 2020 21:37:48 +0530
Message-ID: <CAHhAz+ijB_SNqRiC1Fn0Uw3OpiS7go4dPPYm6YZckaQ0fuq=QQ@mail.gmail.com>
Subject: Re: pcie: xilinx: kernel hang - ISR readl()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 9, 2020 at 10:05 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jan 09, 2020 at 08:47:51AM +0530, Muni Sekhar wrote:
> > On Thu, Jan 9, 2020 at 1:45 AM Bjorn Helgaas <helgaas@kernel.org> wrote=
:
> > > On Tue, Jan 07, 2020 at 09:45:13PM +0530, Muni Sekhar wrote:
> > > > Hi,
> > > >
> > > > I have module with Xilinx FPGA. It implements UART(s), SPI(s),
> > > > parallel I/O and interfaces them to the Host CPU via PCI Express bu=
s.
> > > > I see that my system freezes without capturing the crash dump for
> > > > certain tests. I debugged this issue and it was tracked down to the
> > > > below mentioned interrupt handler code.
> > > >
> > > >
> > > > In ISR, first reads the Interrupt Status register using =E2=80=98re=
adl()=E2=80=99 as
> > > > given below.
> > > >     status =3D readl(ctrl->reg + INT_STATUS);
> > > >
> > > >
> > > > And then clears the pending interrupts using =E2=80=98writel()=E2=
=80=99 as given blow.
> > > >         writel(status, ctrl->reg + INT_STATUS);
> > > >
> > > >
> > > > I've noticed a kernel hang if INT_STATUS register read again after
> > > > clearing the pending interrupts.
> > > >
> > > > Can someone clarify me why the kernel hangs without crash dump inca=
se
> > > > if I read the INT_STATUS register using readl() after clearing the
> > > > pending bits?
> > > >
> > > > Can readl() block?
> > >
> > > readl() should not block in software.  Obviously at the hardware CPU
> > > instruction level, the read instruction has to wait for the result of
> > > the read.  Since that data is provided by the device, i.e., your FPGA=
,
> > > it's possible there's a problem there.
> >
> > Thank you very much for your reply.
> > Where can I find the details about what is protocol for reading the
> > =E2=80=98memory mapped IO=E2=80=99? Can you point me to any useful link=
s..
> > I tried locate the exact point of the kernel code where CPU waits for
> > read instruction as given below.
> > readl() -> __raw_readl() -> return *(const volatile u32 __force *)add
> > Do I need to check for the assembly instructions, here?
>
> The C pointer dereference, e.g., "*address", will be some sort of a
> "load" instruction in assembly.  The CPU wait isn't explicit; it's
> just that when you load a value, the CPU waits for the value.
>
> > > Can you tell whether the FPGA has received the Memory Read for
> > > INT_STATUS and sent the completion?
> >
> > Is there a way to know this with the help of software debugging(either
> > enabling dynamic debugging or adding new debug prints)? Can you please
> > point some tools\hw needed to find this?
>
> You could learn this either via a PCIe analyzer (expensive piece of
> hardware) or possibly some logic in the FPGA that would log PCIe
> transactions in a buffer and make them accessible via some other
> interface (you mentioned it had parallel and other interfaces).
>
> > > On the architectures I'm familiar with, if a device doesn't respond,
> > > something would eventually time out so the CPU doesn't wait forever.
> >
> > What is timeout here? I mean how long CPU waits for completion? Since
> > this code runs from interrupt context, does it causes the system to
> > freeze if timeout is more?
>
> The Root Port should have a Completion Timeout.  This is required by
> the PCIe spec.  The *reporting* of the timeout is somewhat
> implementation-specific since the reporting is outside the PCIe
> domain.  I don't know the duration of the timeout, but it certainly
> shouldn't be long enough to look like a "system freeze".
Does kernel writes to PCIe configuration space register =E2=80=98Device
Control 2 Register=E2=80=99 (Offset 0x28)? When I tried to read this regist=
er,
I noticed bit 4 is set (which disables completion timeouts) and rest
all other bits are zero. So, Completion Timeout detection mechanism is
disabled, right? If so what could be the reason for this?

>
> > lspci output:
> > $ lspci
> > 00:00.0 Host bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
> > Series SoC Transaction Register (rev 11)
> > 00:02.0 VGA compatible controller: Intel Corporation Atom Processor
> > Z36xxx/Z37xxx Series Graphics & Display (rev 11)
> > 00:13.0 SATA controller: Intel Corporation Atom Processor E3800 Series
> > SATA AHCI Controller (rev 11)
> > 00:14.0 USB controller: Intel Corporation Atom Processor
> > Z36xxx/Z37xxx, Celeron N2000 Series USB xHCI (rev 11)
> > 00:1a.0 Encryption controller: Intel Corporation Atom Processor
> > Z36xxx/Z37xxx Series Trusted Execution Engine (rev 11)
> > 00:1b.0 Audio device: Intel Corporation Atom Processor Z36xxx/Z37xxx
> > Series High Definition Audio Controller (rev 11)
> > 00:1c.0 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
> > Express Root Port 1 (rev 11)
> > 00:1c.2 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
> > Express Root Port 3 (rev 11)
> > 00:1c.3 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
> > Express Root Port 4 (rev 11)
> > 00:1d.0 USB controller: Intel Corporation Atom Processor Z36xxx/Z37xxx
> > Series USB EHCI (rev 11)
> > 00:1f.0 ISA bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
> > Series Power Control Unit (rev 11)
> > 00:1f.3 SMBus: Intel Corporation Atom Processor E3800 Series SMBus
> > Controller (rev 11)
> > 01:00.0 RAM memory: PLDA Device 5555
>
> Is this 01:00.0 device the FPGA?
>
> > 03:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
> > Connection (rev 03)



--=20
Thanks,
Sekhar
