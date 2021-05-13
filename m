Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FEE37FCF7
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhEMR5U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 13:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhEMR44 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 13:56:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C5C06175F
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 10:55:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a2so18675856lfc.9
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdaEM0ON7dQpiFlQC2MX8fS7tFjVU+eRgp02YMvQRpE=;
        b=ZkvfYrC9VP8wOYhxR6XUUPvLtpuvnHHaWEwfH/GvvNi4ko7hdEgEvhpI8MVVZZhODM
         s8u4iHRE6RO6S2Z6AynjymUXNUK/jTnJ+6OGBF6ifJjO0tdfD3he7QdtPHGA2FFATnDP
         RSBX9q9VzC/N30ezYCSb7DpjS6wJ096Tjye2c5n4o+yVuLO5l3W+yUYNH8yO+xpk9HTN
         k5TKUmR3LVnLYQ1YnuNQi8FDHZtkEiDuVN1sUXS+AdiTTuAueqIhF2sajVclqWCvHbHa
         vHgdq/IXAdvoAebVbLMv9d+K/6mC72hDmCTn70S3UbwGYWGnxWINHlbyGlYEjwd4xcdG
         Q4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdaEM0ON7dQpiFlQC2MX8fS7tFjVU+eRgp02YMvQRpE=;
        b=IpA5y4oHqrwNFaoBhJv/SSfrjk4pqi5fZRi8bRtkJy7KU4afQMTafS7T9PtbncKzQo
         dcQpYP4i6Lni1+y2BaBmlLuFnt7k/3Nj+EP9u5OyyTbgXJcdDnsml80ldIh3Gc44HfLr
         H6sJfex0BdoRnjBFnNkhQjKsGkh+LpCc+TDF+GcW6RsBP/P7a9Pm18BvaXPdc4UirnU3
         oiNDvBaI9Rx7Y3aNIFk219GOdKAqTD9fW7N7CIKxYMvoSWX2ApTTniXani3u+ef2Gjxj
         xgheOCyO15OeDJpY0LzHpW4YIlQKyqnHIfZg7E12/1FiRf+dQMENLvdznyy7ZfvPd9kq
         Ijlg==
X-Gm-Message-State: AOAM532S++QagLCXhn0VciFY6Hu71q2REoCOOEkwTWrif4emnTviewbG
        KKAnydUWeFL3Tzh3zH9fvU3g0ulhSW7kTKOXIWEFug==
X-Google-Smtp-Source: ABdhPJyG7vEpJCS47UxFr7r2N5zQLS4PoZ4Akf1Y0RanFN/USNYX3dBcH9yk2b7Wt23wachj+TbFkTZhKVCLAlQ/Oo0=
X-Received: by 2002:ac2:414e:: with SMTP id c14mr30376645lfi.155.1620928522965;
 Thu, 13 May 2021 10:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210512213457.1310774-1-rajatja@google.com> <20210512213457.1310774-2-rajatja@google.com>
 <YJ0wgdUaOyaJpaXi@kroah.com> <CACK8Z6EH7jmw9ODqvhxV7EHQjPsj9z++6OT3NAmhem4v68w7yA@mail.gmail.com>
 <YJ1k5w/6g6XFrSJ2@kroah.com>
In-Reply-To: <YJ1k5w/6g6XFrSJ2@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 13 May 2021 10:54:47 -0700
Message-ID: <CACK8Z6E3r=HxRzLyhx5MxAz8+5GgFR8nfYy-mkD4s6oMGxVYhA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: Add sysfs "removable" attribute
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 10:42 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 13, 2021 at 09:39:58AM -0700, Rajat Jain wrote:
> > Hello,
> >
> > On Thu, May 13, 2021 at 6:58 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, May 12, 2021 at 02:34:57PM -0700, Rajat Jain wrote:
> > > > A PCI device is "external_facing" if it's a Root Port with the ACPI
> > > > "ExternalFacingPort" property or if it has the DT "external-facing"
> > > > property.  We consider everything downstream from such a device to
> > > > be removable by user.
> > > >
> > > > We're mainly concerned with consumer platforms with user accessible
> > > > thunderbolt ports that are vulnerable to DMA attacks, and we expect those
> > > > ports to be identified as "ExternalFacingPort". Devices in traditional
> > > > hotplug slots can technically be removed, but the expectation is that
> > > > unless the port is marked with "ExternalFacingPort", such devices are less
> > > > accessible to user / may not be removed by end user, and thus not exposed
> > > > as "removable" to userspace.
> > > >
> > > > Set pci_dev_type.supports_removable so the device core exposes the
> > > > "removable" file in sysfs, and tell the device core about removable
> > > > devices.
> > > >
> > > > This can be used by userspace to implment any policies it wants to,
> > > > tailored specifically for user removable devices. Eg usage:
> > > > https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2591812
> > > > https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2795038
> > > > (code uses such an attribute to remove external PCI devicces or disable
> > > > features on them as needed by the policy desired)
> > > >
> > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > ---
> > > > v3: - commit log updated
> > > >     - Rename set_pci_dev_removable() -> pci_set_removable()
> > > >     - Call it after applying early PCI quirks.
> > > > v2: Add documentation
> > > >
> > > >  Documentation/ABI/testing/sysfs-devices-removable |  3 ++-
> > > >  drivers/pci/pci-sysfs.c                           |  1 +
> > > >  drivers/pci/probe.c                               | 12 ++++++++++++
> > > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
> > > > index 9dabcad7cdcd..ec0b243f5db4 100644
> > > > --- a/Documentation/ABI/testing/sysfs-devices-removable
> > > > +++ b/Documentation/ABI/testing/sysfs-devices-removable
> > > > @@ -14,4 +14,5 @@ Description:
> > > >
> > > >               Currently this is only supported by USB (which infers the
> > > >               information from a combination of hub descriptor bits and
> > > > -             platform-specific data such as ACPI).
> > > > +             platform-specific data such as ACPI) and PCI (which gets this
> > > > +             from ACPI / device tree).
> > > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > > index beb8d1f4fafe..38b3259ba333 100644
> > > > --- a/drivers/pci/pci-sysfs.c
> > > > +++ b/drivers/pci/pci-sysfs.c
> > > > @@ -1541,4 +1541,5 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
> > > >
> > > >  const struct device_type pci_dev_type = {
> > > >       .groups = pci_dev_attr_groups,
> > > > +     .supports_removable = true,
> > > >  };
> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > index 3a62d09b8869..3515afeeaba8 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -1575,6 +1575,16 @@ static void set_pcie_untrusted(struct pci_dev *dev)
> > > >               dev->untrusted = true;
> > > >  }
> > > >
> > > > +static void pci_set_removable(struct pci_dev *dev)
> > > > +{
> > > > +     struct pci_dev *parent = pci_upstream_bridge(dev);
> > > > +     if (parent &&
> > > > +         (parent->external_facing || dev_is_removable(&parent->dev)))
> > > > +             dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> > > > +     else
> > > > +             dev_set_removable(&dev->dev, DEVICE_FIXED);
> > > > +}
> > >
> > > Always run checkpatch.pl so you don't get grumpy maintainers telling you
> > > to run checkpatch.pl :(
> >
> > Yes, I did (it gave me 0 errors and 0 warnings). Please let me know if
> > I need to fix something and I'll be happy to fix that.
> >
> > >
> > > And why does external_facing come into play here?  I know you say it
> > > above, but you should also put it here into the code for when we need to
> > > look at it in a few months and wonder what in the world this is doing.
> >
> > Ack, will do.
> >
> > >
> > > Also, are you SURE this is correct and will handle the hotpluggable PCI
> > > devices in things like drawers and the like?
> >
> > Yes, me and Bjorn discussed this in the v2 of this patch
> > (https://patchwork.kernel.org/project/linux-usb/patch/20210424021631.1972022-2-rajatja@google.com/),
> > and yes, this can take care of the hot-pluggable trays if the firmware
> > marks the slots external-facing.
>
> Ok, I'll trust you two :)
>
> > > What is the goal here in exposing this information to userspace, who is
> > > going to use it and what is it going to be used for?
> >
> > The goal here is to implement policies regarding usage of external PCI
> > devices, in userspace. ChromeOS is using it for things like:
> > - Remove external PCI devices when a user logs out.
>
> remove them how?  disconnect the device from the system through what
> method?

echo 1 > /sys/bus/pci/devices/<device>/remove

>
> > - Don't allow new external PCI devices while the screen is locked.
>
> Don't allow how?  Don't allow the binding of a driver to a device, or
> the device to be discovered at all?  What controls this?

Actually Sorry, this was a wrong recollection.

>
> > - collect metrics about usage of external PCI devices (how many users
> > actually use it etc).
> > - disable certain features (that are deemed to be dangerous) for
> > external PCI network cards.
>
> What is a "dangerous" network feature, RDMA?

For now, we disable offloading of receive path generic / segmentation
/ checksum features to the external PCI hardware, based on our
security team's recommendations.

Thanks,

Rajat

>
> thanks,
>
> greg k-h
