Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293AB37FB70
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 18:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhEMQ2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 12:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhEMQ2P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 12:28:15 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED49C06175F
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 09:27:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y9so34438261ljn.6
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAhUG+aGhvPep7zLbCKo5tTIw/6MrIZxG30qK8WQQEo=;
        b=o6iS2tLrcncqkFTpw3ESLmK9G3xMcLQ16dJUFg2Rr6ozTGwFk0R/dsWAcEnjzWhcoS
         SEdbhKTR5Kv/Vtv44T/XbwTXqSZuRmlewLoUN0M/WjQ10VJDJbtLXTM4MnLYRVt4CPOM
         DClDGWPagpmdKTN22M97cofiYSQx/m4ObGoKTS797d3zOrthhotlVOenCuFJWmsnRkLF
         bzpogJyHxPXcIKbop7o4/rizPnXE+YML3og8SlCa78aCLtgMSUGdSSbi4kCzdnmSZtUO
         dh0/zPJ2ga+mCT3Hj6ZLQHNgjpbi6cPfqe2Lm/IfoVOJGFytWfH3Nmf/Y4cgs0//uKbs
         hnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAhUG+aGhvPep7zLbCKo5tTIw/6MrIZxG30qK8WQQEo=;
        b=heExsNoST3HKRcVLhE0ZP/m9enKHZZr/rHpHXIRAp+3wChXzMrM8G0m9+nzWhqONaA
         cDNP9H6ccjyUeGqpMVFHtrmIlmjPSPmyFWL8BKgSL+BpPFyIkejbfiuMeXCHUW4/cVNS
         79Np9E78I4lXqsbpikhWjzVFRyj54l8TwZuMIjTvSCEuTi7FQv0AbvWJosMtQajyAGP4
         iS72lC3pvR0ye644nkN1dPsdA7NNkC2EvT11OreYhR1MUKnyix3V+aZDwxx4d9erZP70
         HfnxreMUu9JEpwDjSntEwA4nsJIVO1hHzv/Evv7gwnbfA66OQdyBUGeONQlC9XfArU46
         4FpQ==
X-Gm-Message-State: AOAM533pWhgSLJqV2+gB990x7gzVHwMlq+cBGJuL9/2IV9qOT9cSDLA2
        gPq4220tgPAkIdTf0H2GDBFLRVnY4r7QFsUUpBl9QA==
X-Google-Smtp-Source: ABdhPJw/fv6RAy8JkcaDmuEHkkixQJMyfRIvA6CtltsprMrZTPBlkcDOz8WirO0NFuKjk16SgZ69FkDZVaCS/wo4OEA=
X-Received: by 2002:a2e:9006:: with SMTP id h6mr8191107ljg.323.1620923222872;
 Thu, 13 May 2021 09:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210512213457.1310774-1-rajatja@google.com> <YJ0v4G4UpeAvSEFT@kroah.com>
In-Reply-To: <YJ0v4G4UpeAvSEFT@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 13 May 2021 09:26:26 -0700
Message-ID: <CACK8Z6E+cpda6p0W+H+ZiEgaJNitf-O98giV_Uv2T7FoxsD4fg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Move the "removable" attribute from
 USB to core
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

Hello,

On Thu, May 13, 2021 at 6:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 12, 2021 at 02:34:56PM -0700, Rajat Jain wrote:
> > Move the "removable" attribute from USB to core in order to allow it to be
> > supported by other subsystem / buses. Individual buses that want to support
> > this attribute can opt-in by setting the supports_removable flag, and then
> > populating the removable property of the device while enumerating it. The
> > UAPI (location, symantics etc) for the attribute remains unchanged.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> > v3: - Minor commit log / comments updated.
> >     - use sysfs_emit()
> >     - Rename local variable name (state -> loc)
> >     - change supports_removable flag from bool to bitfield.
> > v2: Add documentation
> >
> >  Documentation/ABI/testing/sysfs-bus-usb       | 11 -------
> >  .../ABI/testing/sysfs-devices-removable       | 17 ++++++++++
> >  drivers/base/core.c                           | 28 ++++++++++++++++
> >  drivers/usb/core/hub.c                        |  8 ++---
> >  drivers/usb/core/sysfs.c                      | 24 --------------
> >  drivers/usb/core/usb.c                        |  1 +
> >  include/linux/device.h                        | 32 +++++++++++++++++++
> >  include/linux/usb.h                           |  7 ----
> >  8 files changed, 82 insertions(+), 46 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-devices-removable
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
> > index bf2c1968525f..73eb23bc1f34 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-usb
> > +++ b/Documentation/ABI/testing/sysfs-bus-usb
> > @@ -154,17 +154,6 @@ Description:
> >               files hold a string value (enable or disable) indicating whether
> >               or not USB3 hardware LPM U1 or U2 is enabled for the device.
> >
> > -What:                /sys/bus/usb/devices/.../removable
> > -Date:                February 2012
> > -Contact:     Matthew Garrett <mjg@redhat.com>
> > -Description:
> > -             Some information about whether a given USB device is
> > -             physically fixed to the platform can be inferred from a
> > -             combination of hub descriptor bits and platform-specific data
> > -             such as ACPI. This file will read either "removable" or
> > -             "fixed" if the information is available, and "unknown"
> > -             otherwise.
> > -
> >  What:                /sys/bus/usb/devices/.../ltm_capable
> >  Date:                July 2012
> >  Contact:     Sarah Sharp <sarah.a.sharp@linux.intel.com>
> > diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
> > new file mode 100644
> > index 000000000000..9dabcad7cdcd
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-devices-removable
> > @@ -0,0 +1,17 @@
> > +What:                /sys/devices/.../removable
>
> This should be "/sys/bus/devices/.../removable" perhaps?  Or not?  Is
> this moving in the existing USB cases?
>
> > +Date:                Apr 2021
> > +Contact:     Matthew Garrett <mjg@redhat.com>,
>
> This email address no longer works, so perhaps just use your own?

Ack, will do.

>
> > +             Rajat Jain <rajatja@google.com>
> > +Description:
> > +             Information about whether a given device is physically fixed to
> > +             the platform. This is determined by the device's subsystem in a
> > +             bus / platform-specific way. This attribute is only present for
> > +             buses that can support determining such information:
> > +
> > +             "removable": The device is external / removable from the system.
> > +             "fixed":     The device is internal / fixed to the system.
> > +             "unknown":   The information is unavailable.
> > +
> > +             Currently this is only supported by USB (which infers the
> > +             information from a combination of hub descriptor bits and
> > +             platform-specific data such as ACPI).
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 4a8bf8cda52b..9e6bf9e71a7e 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2404,6 +2404,25 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RW(online);
> >
> > +static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
> > +                           char *buf)
> > +{
> > +     const char *loc;
> > +
> > +     switch (dev->removable) {
> > +     case DEVICE_REMOVABLE:
> > +             loc = "removable";
> > +             break;
> > +     case DEVICE_FIXED:
> > +             loc = "fixed";
> > +             break;
> > +     default:
> > +             loc = "unknown";
> > +     }
> > +     return sysfs_emit(buf, "%s\n", loc);
> > +}
> > +static DEVICE_ATTR_RO(removable);
> > +
> >  int device_add_groups(struct device *dev, const struct attribute_group **groups)
> >  {
> >       return sysfs_create_groups(&dev->kobj, groups);
> > @@ -2581,8 +2600,16 @@ static int device_add_attrs(struct device *dev)
> >                       goto err_remove_dev_online;
> >       }
> >
> > +     if (type && type->supports_removable) {
> > +             error = device_create_file(dev, &dev_attr_removable);
> > +             if (error)
> > +                     goto err_remove_dev_waiting_for_supplier;
> > +     }
> > +
> >       return 0;
> >
> > + err_remove_dev_waiting_for_supplier:
> > +     device_remove_file(dev, &dev_attr_waiting_for_supplier);
> >   err_remove_dev_online:
> >       device_remove_file(dev, &dev_attr_online);
> >   err_remove_dev_groups:
> > @@ -2602,6 +2629,7 @@ static void device_remove_attrs(struct device *dev)
> >       struct class *class = dev->class;
> >       const struct device_type *type = dev->type;
> >
> > +     device_remove_file(dev, &dev_attr_removable);
> >       device_remove_file(dev, &dev_attr_waiting_for_supplier);
> >       device_remove_file(dev, &dev_attr_online);
> >       device_remove_groups(dev, dev->groups);
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index b2bc4b7c4289..7a3c28b14ca1 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -2443,11 +2443,11 @@ static void set_usb_port_removable(struct usb_device *udev)
> >        */
> >       switch (hub->ports[udev->portnum - 1]->connect_type) {
> >       case USB_PORT_CONNECT_TYPE_HOT_PLUG:
> > -             udev->removable = USB_DEVICE_REMOVABLE;
> > +             dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
> >               return;
> >       case USB_PORT_CONNECT_TYPE_HARD_WIRED:
> >       case USB_PORT_NOT_USED:
> > -             udev->removable = USB_DEVICE_FIXED;
> > +             dev_set_removable(&udev->dev, DEVICE_FIXED);
> >               return;
> >       default:
> >               break;
> > @@ -2472,9 +2472,9 @@ static void set_usb_port_removable(struct usb_device *udev)
> >       }
> >
> >       if (removable)
> > -             udev->removable = USB_DEVICE_REMOVABLE;
> > +             dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
> >       else
> > -             udev->removable = USB_DEVICE_FIXED;
> > +             dev_set_removable(&udev->dev, DEVICE_FIXED);
> >
> >  }
> >
> > diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> > index 5a168ba9fc51..fa2e49d432ff 100644
> > --- a/drivers/usb/core/sysfs.c
> > +++ b/drivers/usb/core/sysfs.c
> > @@ -301,29 +301,6 @@ static ssize_t urbnum_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(urbnum);
> >
> > -static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
> > -                           char *buf)
> > -{
> > -     struct usb_device *udev;
> > -     char *state;
> > -
> > -     udev = to_usb_device(dev);
> > -
> > -     switch (udev->removable) {
> > -     case USB_DEVICE_REMOVABLE:
> > -             state = "removable";
> > -             break;
> > -     case USB_DEVICE_FIXED:
> > -             state = "fixed";
> > -             break;
> > -     default:
> > -             state = "unknown";
> > -     }
> > -
> > -     return sprintf(buf, "%s\n", state);
> > -}
> > -static DEVICE_ATTR_RO(removable);
> > -
> >  static ssize_t ltm_capable_show(struct device *dev,
> >                               struct device_attribute *attr, char *buf)
> >  {
> > @@ -828,7 +805,6 @@ static struct attribute *dev_attrs[] = {
> >       &dev_attr_avoid_reset_quirk.attr,
> >       &dev_attr_authorized.attr,
> >       &dev_attr_remove.attr,
> > -     &dev_attr_removable.attr,
> >       &dev_attr_ltm_capable.attr,
> >  #ifdef CONFIG_OF
> >       &dev_attr_devspec.attr,
> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > index 62368c4ed37a..ce18e84528cf 100644
> > --- a/drivers/usb/core/usb.c
> > +++ b/drivers/usb/core/usb.c
> > @@ -569,6 +569,7 @@ struct device_type usb_device_type = {
> >  #ifdef CONFIG_PM
> >       .pm =           &usb_device_pm_ops,
> >  #endif
> > +     .supports_removable = true,
> >  };
> >
> >
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 38a2071cf776..7e87ab048307 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -93,6 +93,8 @@ struct device_type {
> >       void (*release)(struct device *dev);
> >
> >       const struct dev_pm_ops *pm;
> > +
> > +     bool supports_removable:1; /* subsystem can classify removable/fixed */
>
> Why isn't this a bus type?  Shouldn't it go there and not in the device
> type?

Please see below.

>
> >  };
> >
> >  /* interface for exporting device attributes */
> > @@ -350,6 +352,19 @@ enum dl_dev_state {
> >       DL_DEV_UNBINDING,
> >  };
> >
> > +/**
> > + * enum device_removable - Whether the device is removable. The criteria for a
> > + * device to be classified as removable is determined by its subsystem or bus.
> > + * @DEVICE_REMOVABLE_UNKNOWN:  Device location is Unknown (default).
> > + * @DEVICE_REMOVABLE: Device is removable by the user.
> > + * @DEVICE_FIXED: Device is not removable by the user.
> > + */
> > +enum device_removable {
> > +     DEVICE_REMOVABLE_UNKNOWN = 0,
> > +     DEVICE_REMOVABLE,
> > +     DEVICE_FIXED,
> > +};
> > +
> >  /**
> >   * struct dev_links_info - Device data related to device links.
> >   * @suppliers: List of links to supplier devices.
> > @@ -431,6 +446,9 @@ struct dev_links_info {
> >   *           device (i.e. the bus driver that discovered the device).
> >   * @iommu_group: IOMMU group the device belongs to.
> >   * @iommu:   Per device generic IOMMU runtime data
> > + * @removable:  Whether the device can be removed from the system. This
> > + *              should be set by the subsystem / bus driver that discovered
> > + *              the device.
> >   *
> >   * @offline_disabled: If set, the device is permanently online.
> >   * @offline: Set after successful invocation of bus type's .offline().
> > @@ -544,6 +562,8 @@ struct device {
> >       struct iommu_group      *iommu_group;
> >       struct dev_iommu        *iommu;
> >
> > +     enum device_removable   removable;
> > +
> >       bool                    offline_disabled:1;
> >       bool                    offline:1;
> >       bool                    of_node_reused:1;
> > @@ -782,6 +802,18 @@ static inline bool dev_has_sync_state(struct device *dev)
> >       return false;
> >  }
> >
> > +static inline void dev_set_removable(struct device *dev,
> > +                                  enum device_removable removable)
> > +{
> > +     dev->removable = removable;
> > +}
> > +
> > +static inline bool dev_is_removable(struct device *dev)
> > +{
> > +     return dev && dev->type && dev->type->supports_removable
> > +         && dev->removable == DEVICE_REMOVABLE;
>
> Again, shouldn't this be a bus type, and not a device type?
>
> Where are you going to have devices of different types on a bus that do,
> or do not, allow this attribute?

USB. Presently, both the usb_device_type and usb_if_device_type sit on
the usb_bus_type but "removable" only applies to usb_device_type (the
attribute shows up only under usb_devices and not under
usb_interfaces).

Thus, I put the supports_removable flag in device_type instead of bus_type.

Thanks,

Rajat

>
> thanks,
>
> greg k-h
