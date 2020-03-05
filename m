Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3973F17AA43
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 17:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCEQM3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Mar 2020 11:12:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29278 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726173AbgCEQM3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2020 11:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583424747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RfAp+QEMnxTnSpjbGYRyc5CB4JP8k7vpqPIomYHh+V8=;
        b=OP2frLjfZfFolnkoq6lKX+or/7bKlIPref08cHJgPL4sldL7sSfklJ4NLgNzjP4IEV6f7P
        VsHnlcjrgSb7HHh05YCHcEkis/GCYjIZHEayDoecAS9BiRtE+XiHiU0lSk+S+qqubyHL0e
        tiPh7qAhCp1BpdsD2j9Bqt5qfXJo2Jc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-SiLyIMVkPSOdzA9ymUBgJQ-1; Thu, 05 Mar 2020 11:12:22 -0500
X-MC-Unique: SiLyIMVkPSOdzA9ymUBgJQ-1
Received: by mail-qv1-f69.google.com with SMTP id r9so3306884qvs.19
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2020 08:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RfAp+QEMnxTnSpjbGYRyc5CB4JP8k7vpqPIomYHh+V8=;
        b=HXax34cJ4DLsJbj+SP93UqwNmprGmIVP7upWfR4YmUJm67hrtQwdkjnfd9FFWjlyfy
         w0m60K7fO2WWpP/+1NHfrFaE3eCVYWsUy4Jy+9GqJaZ3lvB+aS6nW00cpEf6wksYJaqx
         22uGgGMk2C9BG1ZtQDbnUfl8hCx+KLojcAMWqE/HYlXwqW8VAEKDsBxBks/HFVhfOXeR
         QtY+vgek5H7ajbj9IZ/FlQGl9xF8SAqjTQowQFbjwJ4tCl8Mc1WXaZVur6exBk5ILkOl
         w9F6i4vRNWu4NPzdIsG9//TXNEI7P7FOHT7KixFIj+XYYbzvM+B4S9MurraRuzgW7g8X
         O19w==
X-Gm-Message-State: ANhLgQ09GEF6W4VrqaceTeGwgceq/rZHwxB6nS/JUh4wEZWCoaZwKtCm
        5/I5cXmipfTkqPXm05FQMgn9wkdhKL9V9jedKTtnIpZiv/d78/faN6NWsRis3p5UEoC8GDg9xHe
        PqRrzt4knv74b1NkywyDbmORwnAzBNJAMKRs3
X-Received: by 2002:ac8:735a:: with SMTP id q26mr7887417qtp.286.1583424741120;
        Thu, 05 Mar 2020 08:12:21 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtI0DaYbPJTTjYz+0cU0CzTU3WBaRpIc/MxzYtluJjxUhYaSvH7/RNYoOEGro4prZPyjY8QVzAQdKVHn5xeTbU=
X-Received: by 2002:ac8:735a:: with SMTP id q26mr7887385qtp.286.1583424740750;
 Thu, 05 Mar 2020 08:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20200303101052.133631-1-kherbst@redhat.com> <20200304093324.GI2540@lahna.fi.intel.com>
In-Reply-To: <20200304093324.GI2540@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 5 Mar 2020 17:11:57 +0100
Message-ID: <CACO55ts7VGUJoSM_X_huZ0o68+P6SaWgFKbQzkw=-F+Kh5WfcA@mail.gmail.com>
Subject: Re: [PATCH v6] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 4, 2020 at 10:33 AM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> Hi,
>
> On Tue, Mar 03, 2020 at 11:10:52AM +0100, Karol Herbst wrote:
> > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher d=
evice
> > states.
>
> I think it is good to explain bit more here why this fix is needed.
>

is something like this fine?

Fixes the infamous 'runpm' bug many users are facing on Laptops with Nvidia
Pascal GPUs by skipping PCI power state changes on the GPU.

It's still unknown why this issue exists, but this is a reliable workaround
and solves a very annoying issue for user having to choose between a
crashing kernel or higher power consumption of their Laptops.

> > v2: convert to pci_dev quirk
> >     put a proper technical explanation of the issue as a in-code commen=
t
> > v3: disable it only for certain combinations of intel and nvidia hardwa=
re
> > v4: simplify quirk by setting flag on the GPU itself
> > v5: restructure quirk to make it easier to add new IDs
> >     fix whitespace issues
> >     fix potential NULL pointer access
> >     update the quirk documentation
> > v6: move quirk into nouveau
>
> This information typically goes under the '---' line.
>
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Mika Westerberg <mika.westerberg@intel.com>
>
> I have few minor comments but regardless,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D205623
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_drm.c | 56 +++++++++++++++++++++++++++
> >  drivers/pci/pci.c                     |  8 ++++
> >  include/linux/pci.h                   |  1 +
> >  3 files changed, 65 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/no=
uveau/nouveau_drm.c
> > index 2cd83849600f..51d3a7ba7731 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > @@ -618,6 +618,59 @@ nouveau_drm_device_fini(struct drm_device *dev)
> >       kfree(drm);
> >  }
> >
> > +/*
> > + * On some Intel PCIe bridge controllers doing a
> > + * D0 -> D3hot -> D3cold -> D0 sequence causes Nvidia GPUs to not reap=
pear.
> > + * Skipping the intermediate D3hot step seems to make it work again. T=
hise is
>                                                                         ^=
^^^^
> Thise -> This
>
> > + * probably caused by not meeting the expectation the involved AML cod=
e has
> > + * when the GPU is put into D3hot state before invoking it.
> > + *
> > + * This leads to various manifestations of this issue:
> > + *  - AML code execution to power on the GPU hits an infinite loop (as=
 the
> > + *    code waits on device memory to change).
> > + *  - kernel crashes, as all PCI reads return -1, which most code isn'=
t able
> > + *    to handle well enough.
> > + *
> > + * In all cases dmesg will contain at least one line like this:
> > + * 'nouveau 0000:01:00.0: Refused to change power state, currently in =
D3'
> > + * followed by a lot of nouveau timeouts.
> > + *
> > + * In the \_SB.PCI0.PEG0.PG00._OFF code deeper down writes bit 0x80 to=
 the not
> > + * documented PCI config space register 0x248 of the Intel PCIe bridge
> > + * controller (0x1901) in order to change the state of the PCIe link b=
etween
> > + * the PCIe port and the GPU. There are alternative code paths using o=
ther
> > + * registers, which seem to work fine (executed pre Windows 8):
> > + *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved=
')
> > + *  - 0xb0 bit 0x10 (link disable)
> > + * Changing the conditions inside the firmware by poking into the rele=
vant
> > + * addresses does resolve the issue, but it seemed to be ACPI private =
memory
> > + * and not any device accessible memory at all, so there is no portabl=
e way of
> > + * changing the conditions.
> > + * On a XPS 9560 that means bits [0,3] on \CPEX need to be cleared.
> > + *
> > + * The only systems where this behavior can be seen are hybrid graphic=
s laptops
> > + * with a secondary Nvidia Maxwell, Pascal or Turing GPU. Its unclear =
wheather
>                                                              ^^^         =
^^^^^^^^
> Its -> It's
> wheather -> whether
>
> > + * this issue only occurs in combination with listed Intel PCIe bridge
> > + * controllers and the mentioned GPUs or other devices as well.
> > + *
> > + * documentation on the PCIe bridge controller can be found in the
> > + * "7th Generation Intel=C2=AE Processor Families for H Platforms Data=
sheet Volume 2"
> > + * Section "12 PCI Express* Controller (x16) Registers"
> > + */
> > +
> > +static void quirk_broken_nv_runpm(struct pci_dev *dev)
> > +{
> > +     struct pci_dev *bridge =3D pci_upstream_bridge(dev);
> > +
> > +     if (!bridge || bridge->vendor !=3D PCI_VENDOR_ID_INTEL)
> > +             return;
> > +
> > +     switch (bridge->device) {
> > +     case 0x1901:
> > +             dev->parent_d3cold =3D 1;
>
> I think it is better to add
>
>                 break;
>
> here.
>
> > +     }
> > +}
> > +
> >  static int nouveau_drm_probe(struct pci_dev *pdev,
> >                            const struct pci_device_id *pent)
> >  {
> > @@ -699,6 +752,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
> >       if (ret)
> >               goto fail_drm_dev_init;
> >
> > +     quirk_broken_nv_runpm(pdev);
> >       return 0;
> >
> >  fail_drm_dev_init:
> > @@ -737,6 +791,8 @@ nouveau_drm_remove(struct pci_dev *pdev)
> >  {
> >       struct drm_device *dev =3D pci_get_drvdata(pdev);
> >
> > +     /* revert our workaround */
> > +     pdev->parent_d3cold =3D false;
> >       nouveau_drm_device_remove(dev);
> >  }
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 951099279192..6ece05723fa2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -860,6 +860,14 @@ static int pci_raw_set_power_state(struct pci_dev =
*dev, pci_power_t state)
> >          || (state =3D=3D PCI_D2 && !dev->d2_support))
> >               return -EIO;
> >
> > +     /*
> > +      * Power management can be disabled for certain devices as they d=
on't
> > +      * come back up later on runtime_resume. We rely on platform mean=
s to
> > +      * cut power consumption instead (e.g. ACPI).
> > +      */
> > +     if (state !=3D PCI_D0 && dev->parent_d3cold)
> > +             return 0;
> > +
> >       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >       if (pmcsr =3D=3D (u16) ~0) {
> >               pci_err(dev, "can't change power state from %s to %s (con=
fig space inaccessible)\n",
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 930fab293073..3e5938b91966 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -340,6 +340,7 @@ struct pci_dev {
> >       unsigned int    no_d3cold:1;    /* D3cold is forbidden */
> >       unsigned int    bridge_d3:1;    /* Allow D3 for bridge */
> >       unsigned int    d3cold_allowed:1;       /* D3cold is allowed by u=
ser */
> > +     unsigned int    parent_d3cold:1;        /* power manage the paren=
t instead */
>
> Just to be consistent with the other comments, start with a capital
> letter:
>
>         unsigned int    parent_d3cold:1;        /* Power manage the paren=
t instead */
>

