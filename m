Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D59EE1A3728
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgDIP3h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 11:29:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34482 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgDIP3h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 11:29:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id x62so245829ede.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2020 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CfiEPinAvMSeTaqZujjBwW71izU09MCDUP6YwiiDajE=;
        b=FOLHuxAyIWaAzX6DrtolUKtVbd6zixjyTa54I2/4h4ngbWbr0k8gsSK1n1u6bFJ9O+
         qUstiAUPu5Rckpck8utssBIxB+VsR1U2g7odBOXg4lOC0f2rJ+FOZoPb2AJQYOGzjKVQ
         DygyBP3jX5Lf0tniAxHi1gzRcZxDsHZYDj0dUa06HMHKT61dQSkyhXu378Mxhjbh7QmS
         pPwGxF78TguMPb5PiA+3R9kF7QyCLAaf0mbSi0DAjp8egh/dAyjmLktHwzbOjHSaKWmP
         NXFXG4liUN3xZm65vUOlicOuBYy6wyH5woBZNUJKgZkQSdDJLC7fEXQir3xd/UtUh93r
         LaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CfiEPinAvMSeTaqZujjBwW71izU09MCDUP6YwiiDajE=;
        b=Z6uMB4fVOgkVYzoBzmkI08b/0YcBPgtMwBSkbhuCuw9VjrXr2sIW6U8bhBQT1K00c2
         eC1ae32KHUX6LYolzLLEZehmtlQZgVPGDqiPnyMJxiV4v3FNF0h9TiwSEfMg8sY5I9oR
         br4Hihof89BIKUfn40Pcm5mDZUlpLNquyAuE6M6sf1SvUVY2rVicZfTPsdMiT24P4k7B
         ndBYtSXi66tiy2r8qovgjnDSwcoTRvQfT4KuAJ6Hy3tN3FTnguGtSFjXufUiwiu1fmb0
         ZuAYP6hr+doZsCloitTTWeSPY+TBdRe3vdTsI5XmMaoaObJuuJkcB7o2LqheHi0NrKGH
         OF5Q==
X-Gm-Message-State: AGi0PuboBDeGXKwjjWAnlNV44cIapYx1Gb9dQbZhER+ZD/JUEOKRJpna
        dy1aNBgclciiPxdBnpWuxmZq8UXA9p0zYDVKoBM=
X-Google-Smtp-Source: APiQypKZQ8dSuTONmzl6FfCEzrcrf3PpCgKKd/2TnBGRUgGb+ykQQY4gryBAny5NJdJ1/JeEX0Rj75yE2osJbKOcLaw=
X-Received: by 2002:a17:906:d7a2:: with SMTP id pk2mr1276086ejb.272.1586446174750;
 Thu, 09 Apr 2020 08:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1qmYkpHzhbBmYG_Mvk+s6-NAJO-17+VW9fm-=trSZ-v5Q@mail.gmail.com>
 <20200404013233.GA30614@google.com> <CAEzXK1pNiy_pjDh_=2XKpKUwEfO39rFubkviZyT_7DqEaQ7z5w@mail.gmail.com>
 <CAEzXK1oU4KwatuXAjUwj5arZtdmDSgFsm2vn8DrAWCJu-v-r0g@mail.gmail.com> <CAEzXK1oCwx=w3S0ednwM2mJEEidqF3saEKu9OQP=i82y3Az0Aw@mail.gmail.com>
In-Reply-To: <CAEzXK1oCwx=w3S0ednwM2mJEEidqF3saEKu9OQP=i82y3Az0Aw@mail.gmail.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Thu, 9 Apr 2020 16:29:23 +0100
Message-ID: <CAEzXK1oMPkJLBby8ABSTrNkZpKKFkd2yBGhvzeXC38gg2FDWPA@mail.gmail.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on Linux
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Regarding my previous email please ignore the that device is being
detected as Ethernet controller I have forced class change by making
dev->class=3D=3D0x020000, which also works. Which is also another option
for possible a solution...

On Thu, Apr 9, 2020 at 4:25 PM Lu=C3=ADs Mendes <luis.p.mendes@gmail.com> w=
rote:
>
> Hi Bjorn,
>
> I've good news. I've found the culprit and it is a pretty simple
> issue, however the good solution is not obvious to me.
> Can you help in finding the best way to patch this issue?
>
> So first detailing the problem in file setup_bus.c there is this *if
> condition* to ignore resources from classless devices and so
> it is that this Google/Coral Edge TPU is a classless device with class 0x=
ff:
>
> static void __dev_sort_resources(struct pci_dev *dev, struct list_head *h=
ead)
> {
>     u16 class =3D dev->class >> 8;
>
>        pci_info(dev, "%s\n", __func__);
>     /* Don't touch classless devices or host bridges or IOAPICs */
>     if (class =3D=3D PCI_CLASS_NOT_DEFINED || class =3D=3D PCI_CLASS_BRID=
GE_HOST)
>         return;
>    ....
>
> So the one possible trivial, non generic, attempt that works is to do:
> static void __dev_sort_resources(struct pci_dev *dev, struct list_head *h=
ead)
> {
>     u16 class =3D dev->class >> 8;
>
>        pci_info(dev, "%s\n", __func__);
>     /* Don't touch classless devices or host bridges or IOAPICs */
>     if ((class =3D=3D PCI_CLASS_NOT_DEFINED &&  !(dev->vendor =3D=3D 0x1a=
c1 &&
> dev->device=3D=3D0x089a)) || class =3D=3D PCI_CLASS_BRIDGE_HOST)
>         return;
>    ....
>
> What is your suggestion to make the solution generic? Create a
> whitelist? Remove this verification? I have no idea... nothing sounds
> good to me...
> 01:00.0 Ethernet controller: Device 1ac1:089a (prog-if ff)
>     Subsystem: Device 1ac1:089a
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin A routed to IRQ 0
>     Region 0: Memory at d0100000 (64-bit, prefetchable) [disabled] [size=
=3D16K]
>     Region 2: Memory at d0000000 (64-bit, prefetchable) [disabled] [size=
=3D1M]
>     Capabilities: <access denied>
>
>
>
> Best regards.
> Lu=C3=ADs Mendes
>
> On Thu, Apr 9, 2020 at 12:05 AM Lu=C3=ADs Mendes <luis.p.mendes@gmail.com=
> wrote:
> >
> > Hi Bjorn,
> >
> > I have successfully setup a JTAG remote debug environment.
> > And I found this:
> > First call to __pci_bus_assign_resources visits 11ab:6828 -> SLOT 1,
> > which in turn calls __pci_bus_assign_resources which visits device
> > 1ac1:089a on that slot and calls:
