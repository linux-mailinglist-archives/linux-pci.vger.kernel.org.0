Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC12214F09F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 17:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgAaQeU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 11:34:20 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44808 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgAaQeU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2020 11:34:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so7704920ljj.11;
        Fri, 31 Jan 2020 08:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rVk7M4gYPu86cgQ1So8LoJbxA77sG+PGy1cjE43BUxw=;
        b=Q1RNrkco8oJmb4qm8h8JK+tx2kOBaKVwC4ENwcuBF9leg9BALyybP+jSbSGTh0pH+W
         fwi5a4jxwU5b7GdJhKOksn93GT8i/SqGWyhyi9A2ol3KkOxS1RT9OnZ2l+IENHPcbOOf
         Asd3UhH4jkSHvjKb2WSztjSEOtGO1T6/EKVpgFr09tzufmdhl7ZgBeHYhI5R9oPL2G4p
         O0XXlU2hX77unIK13NQ32BIpyVI4RjpPTHWc2bYqpm9oyCy2tfF1pTTJFGLVS9SywHH5
         d/6j3FbCWy1BRGu74TMMzA9TpQF7JU35bKzKazmXm1sRkfDQRV/Cnzwfd23mgqP2VUuh
         gnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rVk7M4gYPu86cgQ1So8LoJbxA77sG+PGy1cjE43BUxw=;
        b=QHzL3PYlPULTbqm8nuCmTK9rKmOmy3EgJmGrxMLagBY9Qi2Zp5a3KzlUYWPjzL0ZBT
         7+pMzKzKqVfSis2RmpTmdZ30o3ng/de7rwh4ofIQQ/NhmKOUEB5l06swtnNHH6c/hJLt
         sUAfK8JGEaXrWZOxtus9mLZ0rWvIIO2ckgN6EagScqyGtAvdh5Jj52F1Cq3UMAMemsqC
         l+ljZTuVyHToZt6NBEqm/yOJoziuNw2tkuFsm1pjxkKhXApdqGk3E3TBzwKwPfnxhq17
         ATUCMT+kfupMnYa6vLXRj3UT+FEVKiDSzX7G42cDvYCdkyJO2yTr1AoHTbYe/rSIcxnI
         1tvw==
X-Gm-Message-State: APjAAAVDnmmDTtTtawLQSR5IU+Kr0vf5xjnnl4dSHqhmbFaTV+241e1w
        IeYxJMwXwkcioLfOS9vmJf+9EC27t4eKhiqrNm9jAGhy
X-Google-Smtp-Source: APXvYqyQM7lg4jmHwHYH6zJL6QogrN9+0F9lGLdiR/nKZk9ErDODUTx34W5medZl0f3g9PAzFqJnqDTB1vAxF3MRcTo=
X-Received: by 2002:a2e:978c:: with SMTP id y12mr6264141lji.167.1580488457582;
 Fri, 31 Jan 2020 08:34:17 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+ijB_SNqRiC1Fn0Uw3OpiS7go4dPPYm6YZckaQ0fuq=QQ@mail.gmail.com>
 <20200130190040.GA96992@google.com>
In-Reply-To: <20200130190040.GA96992@google.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Fri, 31 Jan 2020 22:04:05 +0530
Message-ID: <CAHhAz+i4HVymeCzyPFRe+1E0R8_nD4LHmHApD2BrLfoWRKSJFA@mail.gmail.com>
Subject: Re: pcie: xilinx: kernel hang - ISR readl()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 31, 2020 at 12:30 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jan 30, 2020 at 09:37:48PM +0530, Muni Sekhar wrote:
> > On Thu, Jan 9, 2020 at 10:05 AM Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> > >
> > > On Thu, Jan 09, 2020 at 08:47:51AM +0530, Muni Sekhar wrote:
> > > > On Thu, Jan 9, 2020 at 1:45 AM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
> > > > > On Tue, Jan 07, 2020 at 09:45:13PM +0530, Muni Sekhar wrote:
> > > > > > Hi,
> > > > > >
> > > > > > I have module with Xilinx FPGA. It implements UART(s), SPI(s),
> > > > > > parallel I/O and interfaces them to the Host CPU via PCI Expres=
s bus.
> > > > > > I see that my system freezes without capturing the crash dump f=
or
> > > > > > certain tests. I debugged this issue and it was tracked down to=
 the
> > > > > > below mentioned interrupt handler code.
> > > > > >
> > > > > >
> > > > > > In ISR, first reads the Interrupt Status register using =E2=80=
=98readl()=E2=80=99 as
> > > > > > given below.
> > > > > >     status =3D readl(ctrl->reg + INT_STATUS);
> > > > > >
> > > > > >
> > > > > > And then clears the pending interrupts using =E2=80=98writel()=
=E2=80=99 as given blow.
> > > > > >         writel(status, ctrl->reg + INT_STATUS);
> > > > > >
> > > > > >
> > > > > > I've noticed a kernel hang if INT_STATUS register read again af=
ter
> > > > > > clearing the pending interrupts.
> > > > > >
> > > > > > Can someone clarify me why the kernel hangs without crash dump =
incase
> > > > > > if I read the INT_STATUS register using readl() after clearing =
the
> > > > > > pending bits?
> > > > > >
> > > > > > Can readl() block?
> > > > >
> > > > > readl() should not block in software.  Obviously at the hardware =
CPU
> > > > > instruction level, the read instruction has to wait for the resul=
t of
> > > > > the read.  Since that data is provided by the device, i.e., your =
FPGA,
> > > > > it's possible there's a problem there.
> > > >
> > > > Thank you very much for your reply.
> > > > Where can I find the details about what is protocol for reading the
> > > > =E2=80=98memory mapped IO=E2=80=99? Can you point me to any useful =
links..
> > > > I tried locate the exact point of the kernel code where CPU waits f=
or
> > > > read instruction as given below.
> > > > readl() -> __raw_readl() -> return *(const volatile u32 __force *)a=
dd
> > > > Do I need to check for the assembly instructions, here?
> > >
> > > The C pointer dereference, e.g., "*address", will be some sort of a
> > > "load" instruction in assembly.  The CPU wait isn't explicit; it's
> > > just that when you load a value, the CPU waits for the value.
> > >
> > > > > Can you tell whether the FPGA has received the Memory Read for
> > > > > INT_STATUS and sent the completion?
> > > >
> > > > Is there a way to know this with the help of software debugging(eit=
her
> > > > enabling dynamic debugging or adding new debug prints)? Can you ple=
ase
> > > > point some tools\hw needed to find this?
> > >
> > > You could learn this either via a PCIe analyzer (expensive piece of
> > > hardware) or possibly some logic in the FPGA that would log PCIe
> > > transactions in a buffer and make them accessible via some other
> > > interface (you mentioned it had parallel and other interfaces).
> > >
> > > > > On the architectures I'm familiar with, if a device doesn't respo=
nd,
> > > > > something would eventually time out so the CPU doesn't wait forev=
er.
> > > >
> > > > What is timeout here? I mean how long CPU waits for completion? Sin=
ce
> > > > this code runs from interrupt context, does it causes the system to
> > > > freeze if timeout is more?
> > >
> > > The Root Port should have a Completion Timeout.  This is required by
> > > the PCIe spec.  The *reporting* of the timeout is somewhat
> > > implementation-specific since the reporting is outside the PCIe
> > > domain.  I don't know the duration of the timeout, but it certainly
> > > shouldn't be long enough to look like a "system freeze".
> > Does kernel writes to PCIe configuration space register =E2=80=98Device
> > Control 2 Register=E2=80=99 (Offset 0x28)? When I tried to read this re=
gister,
> > I noticed bit 4 is set (which disables completion timeouts) and rest
> > all other bits are zero. So, Completion Timeout detection mechanism is
> > disabled, right? If so what could be the reason for this?
>
> To my knowledge Linux doesn't set PCI_EXP_DEVCTL2_COMP_TMOUT_DIS
> except for one powerpc case.  You can check yourself by using cscope
> or grep to look for PCI_EXP_DEVCTL2_COMP_TMOUT_DIS or PCI_EXP_DEVCTL2.
>
> If you're seeing bit 4 (PCI_EXP_DEVCTL2_COMP_TMOUT_DIS) set, it's
> likely because firmware set it.  You can try booting with
> "pci=3Dearlydump" to see what's there before Linux starts changing
> things.

[    0.000000] pci 0000:01:00.0 config space:

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


Device Control 2" is located @offset 0x28 in PCI Express Capability
Structure. But where does 'PCI Express Capability Structure' located
in the above mentioned 'PCI Express Configuration Space'?
>
> Bjorn



--=20
Thanks,
Sekhar
