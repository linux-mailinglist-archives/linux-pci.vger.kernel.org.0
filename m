Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD81A3700
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 17:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgDIPZz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 11:25:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38324 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgDIPZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 11:25:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id e5so201122edq.5
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2020 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+YPmeD+PitY2RmZtfp5S+usW5k66t76AbKWZfy/QI8c=;
        b=Plr1FxjEDNAezd3PTHYSk/2UcaH4NVq6tZdzuJRuB4t6HxArcMcMT9RA5mJj+rmSxe
         DzZK1yKOZEdEEDd/ggn3Py/Ui1Xv7t4DlTNejl3RzgtpZka7wc/oNjvs1/h9a/PrRwfC
         +9sPgrGEMY3Cj1KJiiPjxr6cVG0u51RDq8KRJ/LahE+MFjk5tqdu5AFP7jIBuR8lmWYU
         SGKh7rkZBgP58OxRyUqwTLqL+Upjciefpa4fljlWgl7vjxXbEXlToS1qO7vORTl1FTeo
         xbpJrOoU9UnsF4Ck7d6IVO9dR6K3NftECQITLF9GNnrsbdGmJHkwcliy0vC5KHVLUt96
         35aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+YPmeD+PitY2RmZtfp5S+usW5k66t76AbKWZfy/QI8c=;
        b=rqC4UTVDn5m8I2Op5Dv4ysgYO770RTEbesVJL27ryTIIRoMmqx/Av39fk4EB6kFewD
         jS6OBJDfwSzDJ2x9xITphs2D/TTuDDi0DJX5hk1klxUKlWpVHGswOkYJ/3MzG+9tix6/
         Sa3S78aeAqy41+AUvHXO4E4QRMy0OOHBIVHswIBG448JsJG07GicPpubbLjxIG1b1xin
         lVjw6uxCU9MUUlYztCM2eeboO3AgZZlW9yGS6mQibOf1RJsAMRxLZ/yi3VhnchimGztr
         EsRE1ZX1zNt0CVEEg6BP9DPspLhZ73TQO3rx2r89TsMGs7NjF6QbFzAcHyCnENtInna3
         hlsQ==
X-Gm-Message-State: AGi0PuYzEH+vCWwCiUM6agF/0e+4PHbSvyBrsny/XWzelypwZ1s6vhgV
        KW+qxGWVvMSqTCSmqvPpT+B6jt+aqBC5Pb5aCD2tTIsU
X-Google-Smtp-Source: APiQypKwiIyy2fv4CAIttoJhvLNyWXLKPDv7NTgu/SwnlseGAeMHX8oC+4cRjVdhPE05QGI7UW05udXefGCmmhcdyxY=
X-Received: by 2002:a17:906:11d9:: with SMTP id o25mr12290839eja.331.1586445951982;
 Thu, 09 Apr 2020 08:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1qmYkpHzhbBmYG_Mvk+s6-NAJO-17+VW9fm-=trSZ-v5Q@mail.gmail.com>
 <20200404013233.GA30614@google.com> <CAEzXK1pNiy_pjDh_=2XKpKUwEfO39rFubkviZyT_7DqEaQ7z5w@mail.gmail.com>
 <CAEzXK1oU4KwatuXAjUwj5arZtdmDSgFsm2vn8DrAWCJu-v-r0g@mail.gmail.com>
In-Reply-To: <CAEzXK1oU4KwatuXAjUwj5arZtdmDSgFsm2vn8DrAWCJu-v-r0g@mail.gmail.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Thu, 9 Apr 2020 16:25:40 +0100
Message-ID: <CAEzXK1oCwx=w3S0ednwM2mJEEidqF3saEKu9OQP=i82y3Az0Aw@mail.gmail.com>
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

Hi Bjorn,

I've good news. I've found the culprit and it is a pretty simple
issue, however the good solution is not obvious to me.
Can you help in finding the best way to patch this issue?

So first detailing the problem in file setup_bus.c there is this *if
condition* to ignore resources from classless devices and so
it is that this Google/Coral Edge TPU is a classless device with class 0xff=
:

static void __dev_sort_resources(struct pci_dev *dev, struct list_head *hea=
d)
{
    u16 class =3D dev->class >> 8;

       pci_info(dev, "%s\n", __func__);
    /* Don't touch classless devices or host bridges or IOAPICs */
    if (class =3D=3D PCI_CLASS_NOT_DEFINED || class =3D=3D PCI_CLASS_BRIDGE=
_HOST)
        return;
   ....

So the one possible trivial, non generic, attempt that works is to do:
static void __dev_sort_resources(struct pci_dev *dev, struct list_head *hea=
d)
{
    u16 class =3D dev->class >> 8;

       pci_info(dev, "%s\n", __func__);
    /* Don't touch classless devices or host bridges or IOAPICs */
    if ((class =3D=3D PCI_CLASS_NOT_DEFINED &&  !(dev->vendor =3D=3D 0x1ac1=
 &&
dev->device=3D=3D0x089a)) || class =3D=3D PCI_CLASS_BRIDGE_HOST)
        return;
   ....

What is your suggestion to make the solution generic? Create a
whitelist? Remove this verification? I have no idea... nothing sounds
good to me...
01:00.0 Ethernet controller: Device 1ac1:089a (prog-if ff)
    Subsystem: Device 1ac1:089a
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 0
    Region 0: Memory at d0100000 (64-bit, prefetchable) [disabled] [size=3D=
16K]
    Region 2: Memory at d0000000 (64-bit, prefetchable) [disabled] [size=3D=
1M]
    Capabilities: <access denied>



Best regards.
Lu=C3=ADs Mendes

On Thu, Apr 9, 2020 at 12:05 AM Lu=C3=ADs Mendes <luis.p.mendes@gmail.com> =
wrote:
>
> Hi Bjorn,
>
> I have successfully setup a JTAG remote debug environment.
> And I found this:
> First call to __pci_bus_assign_resources visits 11ab:6828 -> SLOT 1,
> which in turn calls __pci_bus_assign_resources which visits device
> 1ac1:089a on that slot and calls:
