Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14626135243
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 05:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgAIEuq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 23:50:46 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34538 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgAIEup (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 23:50:45 -0500
Received: by mail-ot1-f54.google.com with SMTP id a15so6020850otf.1;
        Wed, 08 Jan 2020 20:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W3O5nIcFKxaFgkWc12HCywMQWOvEI9x36sCRsT6hEps=;
        b=WZ7Hn4jCSv4LSKuxn2A2iFb4MOyxGmne6T1uqasQOIZVxyfKwN4Fs5qMOoE++eUH6h
         R5e8XAJNLObNlPeng7tp93kXMeZ3R8W9iyn9viszqTZKPQTDXcZ+M+7F3rm4/QlCpYh4
         YXeilGKcqFyZzzE32Q6mVVqMcA3hPcTg0UscliaT8gkltPBQazbvsD0xY9zluh3dd8uo
         sVqePtBnasfwkVBTUtJJzUc4f1TS7hleoIHumGQsqrUoNb+wIMSBCl++YuvqTV2CYV/1
         hod+oPDr+winwMnBtzzLhYPDe3d7nULUivX9yKkP6rM2iglX7tJp8H+jyjlShbRaxZ49
         rAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W3O5nIcFKxaFgkWc12HCywMQWOvEI9x36sCRsT6hEps=;
        b=O4KypuyJZ/iMltvqyvz24WH8RbZcyuVB7+s4L2WmZIiWpbI09r8uncFTz4My7yfYaD
         UEkoOsoP+ZxW1Bqy36XhI7fDcm0GXXbwIxnq8KSk5PgBZGDbCtACKZQGIElq8wruouQb
         vhydj7T21oAD0gwC30T+nSOkoYiQ2u2K6aglNE3lnY4J9gs0XE9V3b2H1vyV8LgpPwWz
         2OsDz+VdGqw4Z4P4kzsC9B9/1zCRiYv2erNXVu3vRDYgJQzt2K6PM8bHZD3KjXSFY5vy
         iCPor+qvUpIhtvazshqVXCuVAaqdGKT8xOCrH2h33nQCtcy05aKxqRAyoZPmjNVVHYdW
         7j0Q==
X-Gm-Message-State: APjAAAXPbZXayBQHMpNy84Rahr8AoqxCcaIvM7seFBn5iI0ZoKDyevPw
        WOL4gOC/rwfe5YbOK6bllQk2SFFpO0rpCEwXIZsX4EOd
X-Google-Smtp-Source: APXvYqzTftxnnmGHL9Y3nqnlGfdsAAbMXG7jnFOss/mF59XGZtYjw9VRPTfE6HjAPG7OXfPFJu2ZlsZp6CH4sLs1WBg=
X-Received: by 2002:a9d:754a:: with SMTP id b10mr7114902otl.273.1578545444736;
 Wed, 08 Jan 2020 20:50:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+iy9b8Cyc6O=tjzjjixUQqKpTchrQWc+Y4JicAxB_HY5A@mail.gmail.com>
 <20200109043505.GA223446@google.com>
In-Reply-To: <20200109043505.GA223446@google.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Thu, 9 Jan 2020 10:20:32 +0530
Message-ID: <CAHhAz+h4_nenXjUb9Up2Djx3e_d1J3zPmiCENjSbyJmxPJTb8g@mail.gmail.com>
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
Yes you are correct. 01:00.0 RAM memory: PLDA Device 5555

>
> > 03:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
> > Connection (rev 03)



--=20
Thanks,
Sekhar
