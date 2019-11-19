Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFC102F45
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 23:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfKSW1A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 17:27:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbfKSW1A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2019 17:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574202418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9+2Of/JdwkMJ/5DVFqN56BMJnwie49nbvR6omMsAHk=;
        b=TsaBY8o0i+73vNFO39Uo3jMPEA8D9FfjZdD99CSK5gngNWEQVuAbvyP9F4yLdrOyP869FE
        df5HQS6r0+Qni5ub6/owFdpc76I9STcztnx0rESE91OY1TCZ9tkBAmoUuDJpP/cD16C4a5
        WTRyw1831zuUO7KeinIeeIBvlFDld/4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-g9TirkdkN_ijBrgy8G9HMw-1; Tue, 19 Nov 2019 17:26:57 -0500
Received: by mail-qv1-f70.google.com with SMTP id g30so15737944qvb.11
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2019 14:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JJ9qTkIZ5pbEqHxQeFx7D/UDQ3GJJHCp8GOIGv7IY0=;
        b=YMexoB0e9wkl+qJLutKV25PfhehMMUmbIy86Kd0+Yzi7VUExqErLMUiqESYIsgYcHI
         jPfX4DgPK6FfwiACMY0gg0m2v8Qn1SkCDzVbbgWUQ9/AB0Jwtw+uYu2UF+aUbOydCjSr
         HeowPcACFmyHLIuZ5Rdbut/RDXzCdDos/XjjZOL/iQDWZeLmVLDYrS8nENmPg+VNXv0Q
         tWQM6mxEXKz/HzqUkuYC7rPYHZ9j397jtSUt4HaHzwpm0QXSJyGtZemJdSz80tE6JaNa
         vEmLeOjVPbIkoQhgGjW/+aA4qSkhU4qrg1tAQANiOb+OcLk1iUrVVntMNY20IZ7xQsW0
         2ZBw==
X-Gm-Message-State: APjAAAUlFd2ZgRuyZ1wsZeSBiWYxFFeS6CTgKSW0qdh2uwuzil6tDNzi
        DJs+gtd5A1q7+6JsFTTwsm6V+Pa63Vg/PPIoZhgIjcUa4HhHqWbSbXw58xlNUwQ2w6gBoQj/LcX
        gFO+LQfxkYc03oDQZi9ASkjIRAwuyVwAMcr3E
X-Received: by 2002:ad4:57aa:: with SMTP id g10mr33792335qvx.164.1574202416562;
        Tue, 19 Nov 2019 14:26:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjkmduJajkhDyL8hf02lCTu0z/7c6ej7rn+GB+Bsw0kebnFXtswdrtZS2lguoJuTWz7/XJSH3kak+1V3EIa9I=
X-Received: by 2002:ad4:57aa:: with SMTP id g10mr33792310qvx.164.1574202416211;
 Tue, 19 Nov 2019 14:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
In-Reply-To: <20191119214955.GA223696@google.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 19 Nov 2019 23:26:45 +0100
Message-ID: <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>
X-MC-Unique: g9TirkdkN_ijBrgy8G9HMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 10:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Dave]
>
> On Thu, Oct 17, 2019 at 02:19:01PM +0200, Karol Herbst wrote:
> > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher d=
evice
> > states.
> >
> > v2: convert to pci_dev quirk
> >     put a proper technical explanation of the issue as a in-code commen=
t
> > v3: disable it only for certain combinations of intel and nvidia hardwa=
re
> > v4: simplify quirk by setting flag on the GPU itself
>
> I have zero confidence that we understand the real problem, but we do
> need to do something with this.  I'll merge it for v5.5 if we get the
> minor procedural stuff below straightened out.
>

Thanks, and I agree with your statement, but at this point I think
only Intel can help out digging deeper as I see no way to debug this
further.

> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Mika Westerberg <mika.westerberg@intel.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > ---
> >  drivers/pci/pci.c    |  7 ++++++
> >  drivers/pci/quirks.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h  |  1 +
> >  3 files changed, 61 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b97d9e10c9cc..02e71e0bcdd7 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -850,6 +850,13 @@ static int pci_raw_set_power_state(struct pci_dev =
*dev, pci_power_t state)
> >          || (state =3D=3D PCI_D2 && !dev->d2_support))
> >               return -EIO;
> >
> > +     /*
> > +      * check if we have a bad combination of bridge controller and nv=
idia
> > +         * GPU, see quirk_broken_nv_runpm for more info
>
> Whitespace damage.  Capitalized incorrectly (see other comments
> nearby).
>
> > +      */
> > +     if (state !=3D PCI_D0 && dev->broken_nv_runpm)
> > +             return 0;
> > +
> >       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >
> >       /*
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 44c4ae1abd00..0006c9e37b6f 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5268,3 +5268,56 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgp=
u(struct pci_dev *pdev)
> >  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> >                             PCI_CLASS_DISPLAY_VGA, 8,
> >                             quirk_reset_lenovo_thinkpad_p50_nvgpu);
> > +
> > +/*
> > + * Some Intel PCIe bridges cause devices to disappear from the PCIe bu=
s after
> > + * those were put into D3cold state if they were put into a non D0 PCI=
 PM
> > + * device state before doing so.
>
> A device in D3cold is off the bus by definition.
>
> IIUC the problem is that the sequence D0 -> D3hot -> D3cold -> D0 for
> the GPU fails in the transition back to D0, while D0 -> D3cold -> D0
> works fine.
>
> So I guess the problem is that we can put the device in D3cold with no
> problem, but if we put in D3hot before going to D3cold, the device
> never comes back to D0.  Right?
>

correct. It By the way, it doesn't matter if I put the device into D1
instead, as long as the device is not in D0 state before putting it
into D3cold, it fails.

> > + * This leads to various issue different issues which all manifest dif=
ferently,
>
> s/issue different//
>
> Actually, I think there's only one underlying issue with several
> manifestations.
>
> > + * but have the same root cause:
> > + *  - AIML code execution hits an infinite loop (as the coe waits on d=
evice
> > + *    memory to change).
>
> s/AIML/AML/
> s/coe/code/
>
> > + *  - kernel crashes, as all pci reads return -1, which most code isn'=
t able
> > + *    to handle well enough.
>
> s/pci/PCI/
>
> More details about these crashes would be useful as we look at places
> that *should* be able to handle errors like this.
>

makes sense, I could ,orthogonal to this, make the code more robust if
we hit issues like this in the future. What I am mostly wondering
about is, why pci core doesn't give up if the device doesn't come back
from D3cold? It sounds like, that the most sane thing to do here is to
just give up and fail runtime_resume and report errors back to
userspace trying to make use of the devices.

> > + *  - sudden shutdowns, as the kernel identified an unrecoverable erro=
r after
> > + *    userspace tries to access the GPU.
>
> This doesn't fit with the others and more details might be
> informative here as well.
>

yeah.. I try to get more infos on that. But at least for me (and it
might be a distribution thing) if I execute lspci, the system shuts
down, or at least tries to and might fail.

> > + * In all cases dmesg will contain at least one line like this:
> > + * 'nouveau 0000:01:00.0: Refused to change power state, currently in =
D3'
> > + * followed by a lot of nouveau timeouts.
> > + *
> > + * ACPI code writes bit 0x80 to the not documented PCI register 0x248 =
of the
> > + * PCIe bridge controller in order to power down the GPU.
> > + * Nonetheless, there are other code paths inside the ACPI firmware wh=
ich use
> > + * other registers, which seem to work fine:
> > + *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved=
')
> > + *  - 0xb0 bit 0x10 (link disable)
>
> All these register addresses are device-specific, so they're useless
> without identifying the device.  "lspci -vvnn" output would let us at
> least connect this with something.  It would be nice to have that info
> archived along with your acpidump and python repro scripts in a
> bugzilla with the URL in the commit log.
>
> These are likely in PCI capabilities.  If I make the leap of assuming
> the "link disable" bit is PCI_EXP_LNKCTL_LD, that would mean the Link
> Control register is at 0xb0 and the register at 0xbc would be the Root
> Control register, and indeed 0x20 in Root Control is reserved.
>
> I don't know what the relevance of all this is, though.  It's not
> remarkable that accesses to these registers work.
>

those are registers on the bridge controller and are using inside ACPI
to power down the link. Depending on the OS detected other methods are
used afaik.

> Unless you mean you can access these registers *after* trying to put
> the device back in D0, but other accesses to the device fail.  That
> would indeed be very interesting.
>
> > + * Changing the conditions inside the firmware by poking into the rele=
vant
> > + * addresses does resolve the issue, but it seemed to be ACPI private =
memory
> > + * and not any device accessible memory at all, so there is no portabl=
e way of
> > + * changing the conditions.
> > + *
> > + * The only systems where this behavior can be seen are hybrid graphic=
s laptops
> > + * with a secondary Nvidia Pascal GPU. It cannot be ruled out that thi=
s issue
> > + * only occurs in combination with listed Intel PCIe bridge controller=
s and
> > + * the mentioned GPUs or if it's only a hw bug in the bridge controlle=
r.
> > + *
> > + * But because this issue was NOT seen on laptops with an Nvidia Pasca=
l GPU
> > + * and an Intel Coffee Lake SoC, there is a higher chance of there bei=
ng a bug
> > + * in the bridge controller rather than in the GPU.
>
> I don't think we can conclude anything about where the defect is and I
> don't think speculating here will help future readers of this code.
>
> I *would* still like to see a bugzilla listing the systems where this
> problem has been seen with the "lspci -vvnn", dmesg logs, and at least
> one acpidump.  I think there's more to this story, and I suspect we
> may be revisiting this in the future.
>

one big one is https://bugzilla.kernel.org/show_bug.cgi?id=3D156341 but
it's filled with a lot of different reports, but I am sure most of
them point to this very issue.

Sadly nobody thought of checking lspci with runpm disabled.. but I
could check for other bugs.

> > + * This issue was not able to be reproduced on non laptop systems.
> > + */
> > +
> > +static void quirk_broken_nv_runpm(struct pci_dev *dev)
> > +{
> > +     struct pci_dev *bridge =3D pci_upstream_bridge(dev);
> > +
> > +     if (bridge->vendor =3D=3D PCI_VENDOR_ID_INTEL &&
> > +         bridge->device =3D=3D 0x1901)
>
> pci_upstream_bridge() may return NULL, so you need
>
>   if (bridge && bridge->vendor =3D=3D PCI_VENDOR_ID_INTEL ...
>
> https://lore.kernel.org/r/20190927144421.22608-1-kherbst@redhat.com
> says Skylake and Kaby Lake SoCs are affected.  But here you only check
> for one Device ID?
>

yes, I found this bridge controllers on skylake and kaby lake SoCs,
but I could verify there are systems with a different architecture
(using the "PCI Express Root Port" devices instead of "Processor PCIe
Controller") do not show this issue, so I think it might indeed be
just this one bridge controller. I couldn't verify this issue on any
other so far.

But I could verify this issue with this one bridge controller in
combination with Maxwell, Pascal and Turing Nvidia GPUs.

> > +             dev->broken_nv_runpm =3D 1;
> > +}
> > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> > +                           PCI_BASE_CLASS_DISPLAY, 16,
> > +                           quirk_broken_nv_runpm);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index ac8a6c4e1792..903a0b3a39ec 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -416,6 +416,7 @@ struct pci_dev {
> >       unsigned int    __aer_firmware_first_valid:1;
> >       unsigned int    __aer_firmware_first:1;
> >       unsigned int    broken_intx_masking:1;  /* INTx masking can't be =
used */
> > +     unsigned int    broken_nv_runpm:1;      /* some combinations of i=
ntel bridge controller and nvidia GPUs break rtd3 */
> >       unsigned int    io_window_1k:1;         /* Intel bridge 1K I/O wi=
ndows */
> >       unsigned int    irq_managed:1;
> >       unsigned int    has_secondary_link:1;
> > --
> > 2.21.0
> >
>

Will send out a v5 later addressing you review. Thanks!

