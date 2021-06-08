Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC0D3A07FD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 01:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhFHXuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFHXuJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 19:50:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6BFC061574
        for <linux-pci@vger.kernel.org>; Tue,  8 Jun 2021 16:48:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h12so14133932pfe.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Jun 2021 16:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sap44HZUeMl7nx9za1mZOMogIkd9R62xvnkQFKrxIkI=;
        b=O5TmFV1KAdvN1D+AcTNDCooaSYRBMSacr/BZI0dJKrXFv26uFzf0BUAhUTHSPGamM0
         yVLHKBorRkwDZBvuA3vIspehTxmki2oOsN5O9OZzcocfqZiZqOCmykT17gkeAyRNEcE5
         atyZ/SzGsfWelzMUq9EuInKkO4pEeBilb+IvrODPS971VZQdfZ9Uo0PLIACOTG8V/17f
         kH13SDHGy8UEAB3ri9KPeBJJ1FZxva2m9CMRnkJCP2qhrNTqNM6nSftjmXkxqD7HeuLA
         IQbQvYYUTByGm1S2IiSiK3hw1OW7PUeqyyCruS25BmqofBN9vKQPWvlj5Im/sPb5EWjm
         oSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sap44HZUeMl7nx9za1mZOMogIkd9R62xvnkQFKrxIkI=;
        b=tWy/ptk2HQRMi1w4qddJRv7ytyzG6lgBwzyPVb+LZVa/fQaEve5k98GoFC5GjOZtDS
         VionS927ewEYNPBujXdEGIz6G3ofivBWpyvRSanJh9RW9oGzCiogEsWet/k8BX6WkV4C
         40OAZQb20/+ZG/YcTnxONSG+mYF1pTY+kqexb+3BKPmoXoBuR09w2JstmBTuTy1/SZso
         +VGrAbChcjawKau2G/Q9MVKHx/Sa/jUp2riNIfOMuB4e+FoMmDhOEKD/nKUCX94iS1gf
         40zAlglEV6YLWt7yVI1HEfDIwFnAsi02JaDZAcvsb0QY155bkU1xUg23npoLtLxhiTFO
         ujUg==
X-Gm-Message-State: AOAM530UwlM6DUYkFrnuwWjSn0szowde9D2IqlQ7IcUtoCTLf+LkP11O
        jeLYa80tEOZHUItAuoNHVdPBbwVgZmLjADY1CTW5Iu3eNU3GUQ==
X-Google-Smtp-Source: ABdhPJyRXDadjIRcbEA1ewvrO1tynnhcz0NyuPDRX/2VUt6h8SZwLOi28NHvvbNDeuZkUK4V02BnJNVgPSDfWxePbfo=
X-Received: by 2002:a63:195b:: with SMTP id 27mr784144pgz.450.1623196093214;
 Tue, 08 Jun 2021 16:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162295952770.1109360.877553895768113895.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210608140602.00004f0f@Huawei.com>
In-Reply-To: <20210608140602.00004f0f@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 16:48:02 -0700
Message-ID: <CAPcyv4ipuqcLPaMa+Md5HvpWi8nrExsKn1jg0TaKkHhMz5V0Pw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] cxl/acpi: Introduce cxl_decoder objects
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 8, 2021 at 6:06 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sat, 5 Jun 2021 23:05:27 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > A cxl_decoder is a child of a cxl_port. It represents a hardware
> > decoder configuration of an upstream port to one or more of its
> > downstream ports. The decoder is either represented in standard HDM
> > decoder registers (see CXL 2.0 section 8.2.5.12 CXL HDM Decoder
> > Capability Structure), or it is a static decode configuration
> > communicated by platform firmware (see the CXL Early Discovery Table:
> > Fixed Memory Window Structure).
> >
> > The firmware described and hardware described decoders differ slightly
> > leading to 2 different sub-types of decoders, cxl_decoder_root and
> > cxl_decoder_switch. At the root level the decode capabilities restrict
> > what can be mapped beneath them. Mid-level switch decoders are
> > configured for either acclerator (type-2) or memory-expander (type-3)
> > operation, but they are otherwise agnostic to the type of memory
> > (volatile vs persistent) being mapped.
> >
> > Here is an example topology from a single-ported host-bridge environmen=
t
> > without CFMWS decodes enumerated.
> >
> > /sys/bus/cxl/devices/root0
> > =E2=94=9C=E2=94=80=E2=94=80 devtype
> > =E2=94=9C=E2=94=80=E2=94=80 dport0 -> ../LNXSYSTM:00/LNXSYBUS:00/ACPI00=
16:00
> > =E2=94=9C=E2=94=80=E2=94=80 port1
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 decoder1.0
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 devtype
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 end
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 locked
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 start
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../=
../../bus/cxl
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 target_list
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 target_type
> > =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 uevent
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 devtype
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 dport0 -> ../../pci0000:34/0000=
:34:00.0
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../bus/cxl
> > =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 uevent
> > =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 uport -> ../../LNXSYSTM:00/LNXS=
YBUS:00/ACPI0016:00
> > =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../bus/cxl
> > =E2=94=9C=E2=94=80=E2=94=80 uevent
> > =E2=94=94=E2=94=80=E2=94=80 uport -> ../platform/ACPI0017:00
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> One trivial docs issue and a suggestion that -2 is a bit too magic.
> Otherwise looks good to me.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |   70 ++++++++
> >  drivers/cxl/acpi.c                      |   21 ++
> >  drivers/cxl/core.c                      |  265 +++++++++++++++++++++++=
++++++++
> >  drivers/cxl/cxl.h                       |   48 ++++++
> >  4 files changed, 403 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/AB=
I/testing/sysfs-bus-cxl
> > index 0cb31b7ad17b..f16f18e77578 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -48,3 +48,73 @@ Description:
> >               decode of CXL memory resources.  The 'Y' integer reflects=
 the
> >               hardware port unique-id used in the hardware decoder targ=
et
> >               list.
> > +
> > +What:                /sys/bus/cxl/devices/decoderX.Y
> > +Date:                June, 2021
> > +KernelVersion:       v5.14
> > +Contact:     linux-cxl@vger.kernel.org
> > +Description:
> > +             CXL decoder objects are enumerated from either a platform
> > +             firmware description, or a CXL HDM decoder register set i=
n a
> > +             PCIe device (see CXL 2.0 section 8.2.5.12 CXL HDM Decoder
> > +             Capability Structure). The 'X' in decoderX.Y represents t=
he
> > +             cxl_port container of this decoder, and 'Y' represents th=
e
> > +             instance id of a given decoder resource.
> > +
> > +What:                /sys/bus/cxl/devices/decoderX.Y/{start,end}
> > +Date:                June, 2021
> > +KernelVersion:       v5.14
> > +Contact:     linux-cxl@vger.kernel.org
> > +Description:
> > +             The 'start' and 'end' attributes together convey the phys=
ical
> > +             address base and last addressable byte of the decoder's d=
ecode
> > +             window. For decoders of devtype "cxl_decoder_root" the ad=
dress
> > +             range is fixed. For decoders of devtype "cxl_decoder_swit=
ch" the
> > +             address is bounded by the decode range of the cxl_port an=
cestor
> > +             of the decoder's cxl_port, and dynamically updates based =
on the
> > +             active memory regions in that address space.
> > +
> > +What:                /sys/bus/cxl/devices/decoderX.Y/locked
> > +Date:                June, 2021
> > +KernelVersion:       v5.14
> > +Contact:     linux-cxl@vger.kernel.org
> > +Description:
> > +             CXL HDM decoders have the capability to lock the configur=
ation
> > +             until the next device reset. For decoders of devtype
> > +             "cxl_decoder_root" there is no standard facility to unloc=
k them.
> > +             For decoders of devtype "cxl_decoder_switch" a secondary =
bus
> > +             reset, of the PCIe bridge that provides the bus for this
> > +             decoders uport, unlocks / resets the decoder.
> > +
> > +What:                /sys/bus/cxl/devices/decoderX.Y/target_list
> > +Date:                June, 2021
> > +KernelVersion:       v5.14
> > +Contact:     linux-cxl@vger.kernel.org
> > +Description:
> > +             Display a comma separated list of the current decoder tar=
get
> > +             configuration. The list is ordered by the current configu=
red
> > +             interleave order of the decoder's dport instances. Each e=
ntry in
> > +             the list is a dport id.
> > +
> > +What:                /sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,typ=
e2,type3}
> > +Date:                June, 2021
> > +KernelVersion:       v5.14
> > +Contact:     linux-cxl@vger.kernel.org
> > +Description:
> > +             When a CXL decoder is of devtype "cxl_decoder_root", it
> > +             represents a fixed memory window identified by platform
> > +             firmware. A fixed window may only support a subset of mem=
ory
> > +             types. The 'cap_*' attributes indicate whether persistent
> > +             memory, volatile memory, accelerator memory, and / or exp=
ander
> > +             memory may be mapped behind this decoder's memory window.
> > +
> > +What:                /sys/bus/cxl/devices/decoderX.Y/target_type
> > +Date:                June, 2021
> > +KernelVersion:       v5.14
> > +Contact:     linux-cxl@vger.kernel.org
> > +Description:
> > +             When a CXL decoder is of devtype "cxl_decoder_switch", it=
 can
> > +             optionally decode either accelerator memory (type-2) or e=
xpander
> > +             memory (type-3). The 'target_type' attribute indicates th=
e
> > +             current setting which may dynamically change based on wha=
t
> > +             memory regions are activated in this decode hierarchy.
>
> Nice docs.
>
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index ec324bf063b8..6f203ba7fc1d 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -70,6 +70,7 @@ static int add_host_bridge_uport(struct device *match=
, void *arg)
> >       struct device *host =3D root_port->dev.parent;
> >       struct acpi_pci_root *pci_root;
> >       struct cxl_walk_context ctx;
> > +     struct cxl_decoder *cxld;
> >       struct cxl_port *port;
> >
> >       if (!bridge)
> > @@ -94,7 +95,25 @@ static int add_host_bridge_uport(struct device *matc=
h, void *arg)
> >
> >       if (ctx.count =3D=3D 0)
> >               return -ENODEV;
> > -     return ctx.error;
> > +     if (ctx.error)
> > +             return ctx.error;
> > +
> > +     /* TODO: Scan CHBCR for HDM Decoder resources */
> > +
> > +     /*
> > +      * In the single-port host-bridge case there are no HDM decoders
> > +      * in the CHBCR and a 1:1 passthrough decode is implied.
> > +      */
> > +     if (ctx.count =3D=3D 1) {
> > +             cxld =3D devm_cxl_add_decoder(host, port, 1, 0, -2, 1, 0,
>
> -2?  I'm guessing that has some special meaning and perhaps warrants
> a nice define to let us know what that is.

Um, yes, I think I went back and forth on whether this should be a
zero-length range starting at zero or a zero-length range starting at
UINT64_MAX, and I ended up botching it with a range of 0 to UINT64_MAX
- 1. I'll fix this up to provide a "passthrough" version of
devm_cxl_add_decoder() for the cases like this where a port does not
adjust the decode from the parent port down to the next level.

>
> Given this interface is a bit long perhaps even wroth a comment here on
> why the values are what they are?

The passthrough helper will address this.
