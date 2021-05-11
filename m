Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D8837B17C
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 00:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhEKWQ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 18:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKWQ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 18:16:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF4AC061574
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 15:15:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a2so9854177lfc.9
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geG8UxbiX+LmppPLWMLmqqexOU0/3p6/e8F1xtwYWJk=;
        b=fkSzyWH1kw+2/ntTT5TfdkVaqMe5JnHeZCVK8V2HNnVxQFIwG5owh2kk0rHf0gWtvG
         UiNL3/5Q5Yw39F4kp+BhdEPo/PubkI7eGh+JKIOnCp+mXNObsgq5jAG3ySihQIYqnoZn
         Y+/UQXlxYHj0j2KVKSh/dqzP0IUuq1Gs5vfS9FUbIilRA2LCF3ZzoqdkktgbXNMFQxEX
         Vpb0JK9qfJMndkjt9kmDFjufMoA4Mevvz2dTFzIi1wqRISqbWlQ/j5DT9covKlaBPwCl
         KcWcfu/kt1JuBLZAzVAjVA6uDI5z1wK3ddYb/2EFrgrZU1DnhfN/mNrMdAwOyXQBaCo4
         bvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geG8UxbiX+LmppPLWMLmqqexOU0/3p6/e8F1xtwYWJk=;
        b=JVsTlX2Kp56jKfL4PtIhKBpV5BtcwmfQaDBRTQ3vSTBwoXJLJ5t58eh2ZAWUZjSAnU
         ojCUbT7eGFyFcHp2CNMX0RtK8urg8ci4vAl5yio4FlZuTNwGBQ+KuCgoUU7+8CMnTIwf
         CnXnKW52pw3wbhg44WnTewMmV4OUujT9aSFPqaHzgL3YDzzRaR1Aea0zepsYIA895ote
         /V19wIRtkneotJVACdgF4hD2OD15EI/z9oW/MsIzAhUD0Kl+layW1v7PQwb9BuOrHHZf
         u+kQCU7+ijVR6QPXT/gb0sxW2LquNaPc1kzP+NQnrbZdookaLGTIIvxznNpvQBTggiSb
         VR6g==
X-Gm-Message-State: AOAM532UaMBL+rspfhl8eDNKKYbOyb1xjUMB3b1cuQ2f0KJkkCm99GSR
        1JGvidFrmdhGkdD8mVMAmDIPH0OwLxqntkFoIw20Q2HIHxQyNhhR
X-Google-Smtp-Source: ABdhPJyUEA9JjBvHPnTF9Zoi1m8ozY+gTfTZLBNQ7IoGh5Zaj02FaxsZ4bB5/83dTn69LQBgVYEEN42g9qMZygBw+Eg=
X-Received: by 2002:a19:4086:: with SMTP id n128mr9583920lfa.464.1620771347588;
 Tue, 11 May 2021 15:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210424021631.1972022-2-rajatja@google.com> <20210511213047.GA2417208@bjorn-Precision-5520>
In-Reply-To: <20210511213047.GA2417208@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 11 May 2021 15:15:11 -0700
Message-ID: <CACK8Z6GP415hmDUYU74LRrGYKCN4aAXGD-B=ctN8R7P3LnFUrw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the review. Please see inline.



On Tue, May 11, 2021 at 2:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Oliver, David]
>
> Please update the subject line, e.g.,
>
>   PCI: Add sysfs "removable" attribute

Will do.

>
> On Fri, Apr 23, 2021 at 07:16:31PM -0700, Rajat Jain wrote:
> > Export the already available info, to the userspace via the
> > device core, so that userspace can implement whatever policies it
> > wants to, for external removable devices.
>
> I know it's not strictly part of *this* patch, but I think we should
> connect the dots a little here, something like this:
>
>   PCI: Add sysfs "removable" attribute
>
>   A PCI device is "external_facing" if it's a Root Port with the ACPI
>   "ExternalFacingPort" property or if it has the DT "external-facing"
>   property.  We consider everything downstream from such a device to
>   be removable.
>
>   Set pci_dev_type.supports_removable so the device core exposes the
>   "removable" file in sysfs, and tell the device core about removable
>   devices.
>
> Wrap to fill 75 columns.

Will do.

>
> > Signed-off-by: Rajat Jain <rajatja@google.com>
>
> This looks like a good start.  I think it would be useful to have a
> more concrete example of how this information will be used.  I know
> that use would be in userspace, so an example probably would not be a
> kernel patch.  If you have user code published anywhere, that would
> help.  Or even a patch to an existing daemon.  Or pointers to how
> "removable" is used for USB devices.

Sure, I'll point to some existing user space code (which will be using
a similar attribute we are carrying internally).

>
> > ---
> > v2: Add documentation
> >
> >  Documentation/ABI/testing/sysfs-devices-removable |  3 ++-
> >  drivers/pci/pci-sysfs.c                           |  1 +
> >  drivers/pci/probe.c                               | 12 ++++++++++++
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
> > index e13dddd547b5..daac4f007619 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-removable
> > +++ b/Documentation/ABI/testing/sysfs-devices-removable
> > @@ -14,4 +14,5 @@ Description:
> >
> >               Currently this is only supported by USB (which infers the
> >               information from a combination of hub descriptor bits and
> > -             platform-specific data such as ACPI).
> > +             platform-specific data such as ACPI) and PCI (which gets this
> > +             from ACPI / device tree).
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index f8afd54ca3e1..9302f0076e73 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1582,4 +1582,5 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
> >
> >  const struct device_type pci_dev_type = {
> >       .groups = pci_dev_attr_groups,
> > +     .supports_removable = true,
> >  };
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 953f15abc850..d1cceee62e1b 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1575,6 +1575,16 @@ static void set_pcie_untrusted(struct pci_dev *dev)
> >               dev->untrusted = true;
> >  }
> >
> > +static void set_pci_dev_removable(struct pci_dev *dev)
>
> Maybe just "pci_set_removable()"?  These "set_pci*" functions look a
> little weird.

Will do.

>
> > +{
> > +     struct pci_dev *parent = pci_upstream_bridge(dev);
> > +     if (parent &&
> > +         (parent->external_facing || dev_is_removable(&parent->dev)))
> > +             dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> > +     else
> > +             dev_set_removable(&dev->dev, DEVICE_FIXED);
> > +}
> > +
> >  /**
> >   * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
> >   * @dev: PCI device
> > @@ -1819,6 +1829,8 @@ int pci_setup_device(struct pci_dev *dev)
> >       /* "Unknown power state" */
> >       dev->current_state = PCI_UNKNOWN;
> >
> > +     set_pci_dev_removable(dev);
>
> So this *only* sets the "removable" attribute based on the
> ExternalFacingPort or external-facing properties.  I think Oliver and
> David were hinting that maybe we should also set it for devices in
> hotpluggable slots.  What do you think?

I did think about it. So I have a mixed feeling about this. Primarily
because I have seen the use of hotpluggable slots in situations where
we wouldn't want to classify the device as removable:

- Using link-state based hotplug as a way to work around unstable PCIe
links. I have seen PCIe devices marked as hot-pluggable only to ensure
that if the PCIe device falls off PCI bus due to some reason (e.g. due
to SI issues or device firmware bugs), the kernel should be able to
detect it if it does come back up (remember quick "Link-Down" /
"Link-Up" events in succession?).

- Internal hot-pluggable PCI devices. In my past life, I was working
on a large system that would have hot-pluggable daughter cards, but
those wouldn't be user removable. Also, it is conceivable to have
hot-pluggable M.2 slots for PCIe devices such as NVMEs etc, but they
may still not be removable by user. I don't think these should be
treated as "removable". I was also looking at USB as an example where
this originally came from, USB does ensure that only devices that are
"user visible" devices are marked as "removable":

54d3f8c63d69 ("usb: Set device removable state based on ACPI USB data")
d35e70d50a06 ("usb: Use hub port data to determine whether a port is removable")

>
> I wonder if this (and similar hooks like set_pcie_port_type(),
> set_pcie_untrusted(), set_pcie_thunderbolt(), etc) should go *after*
> the early fixups so we could use fixups to work around issues?

I agree. We can do that if none of the early fixups actually use the
fields set by these functions. I think it should be ok to move
set_pcie_untrusted(), set_pcie_thunderbolt(), but I wonder if any
early fixups already use the pcie_cap or any other fields set by
set_pcie_port_type().

Thanks,

Rajat

>
> >       /* Early fixups, before probing the BARs */
> >       pci_fixup_device(pci_fixup_early, dev);
> >
> > --
> > 2.31.1.498.g6c1eba8ee3d-goog
> >
