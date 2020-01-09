Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B70D1351D5
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 04:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgAIDSE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 22:18:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39373 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIDSD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 22:18:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so4676979oib.6;
        Wed, 08 Jan 2020 19:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kMxWLP5AvH5IYgX1VCW6zdr/ftmh1hngWdvNnRgFFEo=;
        b=VORrxRgUgexswE69vnqeV3cEteMR/wL4/MP/ugnNqwzaG8qb0/EYuGXD9dfy0ok58Q
         szjzntt3xTayYNs2JivFfdo1bGiD74e1tJLw9EGPHRkbsSZR0KdeuuH/vFN/I99iQhoE
         /AHdT3JZxfO1ktbSFwNfB9V6h1qxLc+m3tnho1LY6k+uCwcez4GWD/ZSHpsf59YPlkJa
         rkI/I/WW+Ynurv98B8yetNiECHrpsuRp3kBTccow53UrxzD8M6bGnk9zsxGXMup8T7Ei
         ZQm3qizDkrUC2Seuc4o51Iw0ObBc386cTUfRqgNg4xNbw7Ywr4r/Ca378xm/5D2bQRBR
         SNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kMxWLP5AvH5IYgX1VCW6zdr/ftmh1hngWdvNnRgFFEo=;
        b=EW2nWBFcgEklz08gt9XiQOi1eoL77zNlVjp/mWqXh8ZKC6h0Yhge49WvIiL+WcZO5n
         al1vJguCBpDg5APX86tZSJaeaZuyYaRXSfVvO6MQtBWLCM9PlNcwpNC9ttecVH8jmzc5
         4Wuso+eo0z8p40dUc2vRJsPIty7fh8qak5NQPPwKnbZNx7meQl/k/giDCDMzlZG+YGmU
         NIiWlizsz4lb0MT4p5v9rUw1mB4ktVug6KVxOt+bOAy33kU2Ba8eqPEpuR6+VCYTBmVj
         SktIPS9AJSYZekhpG2VzjpHuqHl/vSiS6MTxAMDTV85q4OoCRFYM7gvzGws8sX//wvA+
         hubg==
X-Gm-Message-State: APjAAAXTOLx5x9z+T4GDG5hTgnU8pfCfFRz7NGGOey6xZOXBa1uC/GxB
        O37+YxjSzz9P4HowiNlfC7OtiP7vhucMZWdudSCqSTua
X-Google-Smtp-Source: APXvYqwdVp2OHdNEgJxcl5S2pNXZoxvcSAVzYDvDyacbeid2izqY0SHOzen+JhS83JzgsuXoF9HZSqLjnIC+rselkPY=
X-Received: by 2002:aca:c3c4:: with SMTP id t187mr1533945oif.89.1578539883135;
 Wed, 08 Jan 2020 19:18:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+ijBTp55gZYAejWthnvdmR_qyQJpVV4r1gyQ-Kud6t9qg@mail.gmail.com>
 <20200108201511.GA195980@google.com>
In-Reply-To: <20200108201511.GA195980@google.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Thu, 9 Jan 2020 08:47:51 +0530
Message-ID: <CAHhAz+iy9b8Cyc6O=tjzjjixUQqKpTchrQWc+Y4JicAxB_HY5A@mail.gmail.com>
Subject: Re: pcie: xilinx: kernel hang - ISR readl()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 9, 2020 at 1:45 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jan 07, 2020 at 09:45:13PM +0530, Muni Sekhar wrote:
> > Hi,
> >
> > I have module with Xilinx FPGA. It implements UART(s), SPI(s),
> > parallel I/O and interfaces them to the Host CPU via PCI Express bus.
> > I see that my system freezes without capturing the crash dump for
> > certain tests. I debugged this issue and it was tracked down to the
> > below mentioned interrupt handler code.
> >
> >
> > In ISR, first reads the Interrupt Status register using =E2=80=98readl(=
)=E2=80=99 as
> > given below.
> >     status =3D readl(ctrl->reg + INT_STATUS);
> >
> >
> > And then clears the pending interrupts using =E2=80=98writel()=E2=80=99=
 as given blow.
> >         writel(status, ctrl->reg + INT_STATUS);
> >
> >
> > I've noticed a kernel hang if INT_STATUS register read again after
> > clearing the pending interrupts.
> >
> > Can someone clarify me why the kernel hangs without crash dump incase
> > if I read the INT_STATUS register using readl() after clearing the
> > pending bits?
> >
> > Can readl() block?
>
> readl() should not block in software.  Obviously at the hardware CPU
> instruction level, the read instruction has to wait for the result of
> the read.  Since that data is provided by the device, i.e., your FPGA,
> it's possible there's a problem there.

Thank you very much for your reply.
Where can I find the details about what is protocol for reading the
=E2=80=98memory mapped IO=E2=80=99? Can you point me to any useful links..
I tried locate the exact point of the kernel code where CPU waits for
read instruction as given below.
readl() -> __raw_readl() -> return *(const volatile u32 __force *)add
Do I need to check for the assembly instructions, here?

>
> Can you tell whether the FPGA has received the Memory Read for
> INT_STATUS and sent the completion?

Is there a way to know this with the help of software debugging(either
enabling dynamic debugging or adding new debug prints)? Can you please
point some tools\hw needed to find this?


>
> On the architectures I'm familiar with, if a device doesn't respond,
> something would eventually time out so the CPU doesn't wait forever.

What is timeout here? I mean how long CPU waits for completion? Since
this code runs from interrupt context, does it causes the system to
freeze if timeout is more?

lspci output:
$ lspci
00:00.0 Host bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series SoC Transaction Register (rev 11)
00:02.0 VGA compatible controller: Intel Corporation Atom Processor
Z36xxx/Z37xxx Series Graphics & Display (rev 11)
00:13.0 SATA controller: Intel Corporation Atom Processor E3800 Series
SATA AHCI Controller (rev 11)
00:14.0 USB controller: Intel Corporation Atom Processor
Z36xxx/Z37xxx, Celeron N2000 Series USB xHCI (rev 11)
00:1a.0 Encryption controller: Intel Corporation Atom Processor
Z36xxx/Z37xxx Series Trusted Execution Engine (rev 11)
00:1b.0 Audio device: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series High Definition Audio Controller (rev 11)
00:1c.0 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
Express Root Port 1 (rev 11)
00:1c.2 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
Express Root Port 3 (rev 11)
00:1c.3 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
Express Root Port 4 (rev 11)
00:1d.0 USB controller: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series USB EHCI (rev 11)
00:1f.0 ISA bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series Power Control Unit (rev 11)
00:1f.3 SMBus: Intel Corporation Atom Processor E3800 Series SMBus
Controller (rev 11)
01:00.0 RAM memory: PLDA Device 5555
03:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
Connection (rev 03)

>
> > Snippet of the ISR code is given blow:
> >
> > https://pastebin.com/WdnZJZF5
> >
> >
> >
> > static irqreturn_t pcie_isr(int irq, void *dev_id)
> >
> > {
> >
> >         struct test_device *ctrl =3D data;
> >
> >         u32 status;
> >
> > =E2=80=A6
> >
> >
> >
> >         status =3D readl(ctrl->reg + INT_STATUS);
> >
> >         /*
> >
> >          * Check to see if it was our interrupt
> >
> >          */
> >
> >         if (!(status & 0x000C))
> >
> >                 return IRQ_NONE;
> >
> >
> >
> >         /* Clear the interrupt */
> >
> >         writel(status, ctrl->reg + INT_STATUS);
> >
> >
> >
> >         if (status & 0x0004) {
> >
> >                 /*
> >
> >                  * Tx interrupt pending.
> >
> >                  */
> >
> >                  ....
> >
> >        }
> >
> >
> >
> >         if (status & 0x0008) {
> >
> >                 /* Rx interrupt Pending */
> >
> >                 /* The system freezes if I read again the INT_STATUS
> > register as given below */
> >
> >                 status =3D readl(ctrl->reg + INT_STATUS);
> >
> >                 ....
> >
> >         }
> >
> > ..
> >
> >         return IRQ_HANDLED;
> > }
> >
> >
> >
> > --
> > Thanks,
> > Sekhar



--=20
Thanks,
Sekhar
