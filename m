Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA23237FC84
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 19:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhEMR3Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhEMR3P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 13:29:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921ABC061756
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 10:28:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p20so10691767ljj.8
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mrNjY7B7RhMGjzcyAALH6BMidIjG9PYGm2iFaBxLPWU=;
        b=gw0qVY+MdqpAKcHf8Ifw79XmeEWUl1BMliSmPuZAMcxx3qHwcPr2l4Naqtfy/qgU6/
         0i1zUFcfG3Hm1Ccf7Gf+DPZ+hax1qb0TfKega+NTTAtqF11dIYbVBy/eSZ68NakuZxVS
         40LvXCU6UXJ4zswnL0t1ZUL8m26d508CbbdhlPcpaRfsWUw/1IKQMWuTJRL7ao8DtrEI
         z0ggVgdAUrNv7OvDwpGNVwI6V1pUNj4qFaQ9dvfCWfI4Jf6K34hyGQQSEd5SBCdsDPGu
         DeJDcJFlQyV0XsPULu6FyOXX4xG4hfd7jFIboqy8+J+P1eKepbIPw5DDvaSh4OPMU6gg
         XtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mrNjY7B7RhMGjzcyAALH6BMidIjG9PYGm2iFaBxLPWU=;
        b=OdfShYKOqG2tCX6C1DZsQDZ2Z4V2Q9Yo+quhxTLvg7iUVBqIdtGykQGyZ+mgbiApo/
         aAblwPW+xKMqSRajfgYRiOA3Ys8C6j/UnP9ETMjp8l7zdtiLSOK1hfq/CAKUlra0ukYs
         qKF7d+RrvvpWsBXxaeSseLsV09YDGOIgi48R5iLA841rH8OKsVFf4yuioKrUm4c1LgQ8
         4Z/Q5NWAdIlPlZq2orePcadGVbrmoBFj1XX+9cjOOwKmCmX4hBfcLhmZBQuXD3c1lSAn
         hawxFmtsGswPwuqG5JLgXDcH1a7nPbKJ0PU4EBZKft4bFYcrU2y5SP7VqXidmDlmSKGR
         I0rQ==
X-Gm-Message-State: AOAM533AkmctlG5zTxTrSPz9tKuPZaHqeuq0CSBv6HwXvJjihwfjPgBo
        AL/wrViQ6dl2yagEMvm9QuBdPG18fivRmk/LbliHIw==
X-Google-Smtp-Source: ABdhPJwBHpmf2wj1X33WBubj32Wbl3S/1AQEWPsj45Yh2mgFzwcnXGX0w8WjCF/Y0zTgEsMYrxbGBwtLGRj/Qi6FOkg=
X-Received: by 2002:a2e:9b8c:: with SMTP id z12mr35297361lji.267.1620926882716;
 Thu, 13 May 2021 10:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210512213457.1310774-1-rajatja@google.com> <YJ0v4G4UpeAvSEFT@kroah.com>
 <CACK8Z6E+cpda6p0W+H+ZiEgaJNitf-O98giV_Uv2T7FoxsD4fg@mail.gmail.com> <YJ1WYyh5/A9PUz7T@kroah.com>
In-Reply-To: <YJ1WYyh5/A9PUz7T@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 13 May 2021 10:27:26 -0700
Message-ID: <CACK8Z6EPRdHb3ckMKhh2rPZRpahhLwtqBfLtoRbApRv+XRKLEA@mail.gmail.com>
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

On Thu, May 13, 2021 at 9:40 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 13, 2021 at 09:26:26AM -0700, Rajat Jain wrote:
> > > >  static ssize_t ltm_capable_show(struct device *dev,
> > > >                               struct device_attribute *attr, char *buf)
> > > >  {
> > > > @@ -828,7 +805,6 @@ static struct attribute *dev_attrs[] = {
> > > >       &dev_attr_avoid_reset_quirk.attr,
> > > >       &dev_attr_authorized.attr,
> > > >       &dev_attr_remove.attr,
> > > > -     &dev_attr_removable.attr,
> > > >       &dev_attr_ltm_capable.attr,
> > > >  #ifdef CONFIG_OF
> > > >       &dev_attr_devspec.attr,
> > > > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > > > index 62368c4ed37a..ce18e84528cf 100644
> > > > --- a/drivers/usb/core/usb.c
> > > > +++ b/drivers/usb/core/usb.c
> > > > @@ -569,6 +569,7 @@ struct device_type usb_device_type = {
> > > >  #ifdef CONFIG_PM
> > > >       .pm =           &usb_device_pm_ops,
> > > >  #endif
> > > > +     .supports_removable = true,
> > > >  };
> > > >
> > > >
> > > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > > index 38a2071cf776..7e87ab048307 100644
> > > > --- a/include/linux/device.h
> > > > +++ b/include/linux/device.h
> > > > @@ -93,6 +93,8 @@ struct device_type {
> > > >       void (*release)(struct device *dev);
> > > >
> > > >       const struct dev_pm_ops *pm;
> > > > +
> > > > +     bool supports_removable:1; /* subsystem can classify removable/fixed */
> > >
> > > Why isn't this a bus type?  Shouldn't it go there and not in the device
> > > type?
> >
> > Please see below.
> >
> > >
> > > >  };
> > > >
> > > >  /* interface for exporting device attributes */
> > > > @@ -350,6 +352,19 @@ enum dl_dev_state {
> > > >       DL_DEV_UNBINDING,
> > > >  };
> > > >
> > > > +/**
> > > > + * enum device_removable - Whether the device is removable. The criteria for a
> > > > + * device to be classified as removable is determined by its subsystem or bus.
> > > > + * @DEVICE_REMOVABLE_UNKNOWN:  Device location is Unknown (default).
> > > > + * @DEVICE_REMOVABLE: Device is removable by the user.
> > > > + * @DEVICE_FIXED: Device is not removable by the user.
> > > > + */
> > > > +enum device_removable {
> > > > +     DEVICE_REMOVABLE_UNKNOWN = 0,
> > > > +     DEVICE_REMOVABLE,
> > > > +     DEVICE_FIXED,
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct dev_links_info - Device data related to device links.
> > > >   * @suppliers: List of links to supplier devices.
> > > > @@ -431,6 +446,9 @@ struct dev_links_info {
> > > >   *           device (i.e. the bus driver that discovered the device).
> > > >   * @iommu_group: IOMMU group the device belongs to.
> > > >   * @iommu:   Per device generic IOMMU runtime data
> > > > + * @removable:  Whether the device can be removed from the system. This
> > > > + *              should be set by the subsystem / bus driver that discovered
> > > > + *              the device.
> > > >   *
> > > >   * @offline_disabled: If set, the device is permanently online.
> > > >   * @offline: Set after successful invocation of bus type's .offline().
> > > > @@ -544,6 +562,8 @@ struct device {
> > > >       struct iommu_group      *iommu_group;
> > > >       struct dev_iommu        *iommu;
> > > >
> > > > +     enum device_removable   removable;
> > > > +
> > > >       bool                    offline_disabled:1;
> > > >       bool                    offline:1;
> > > >       bool                    of_node_reused:1;
> > > > @@ -782,6 +802,18 @@ static inline bool dev_has_sync_state(struct device *dev)
> > > >       return false;
> > > >  }
> > > >
> > > > +static inline void dev_set_removable(struct device *dev,
> > > > +                                  enum device_removable removable)
> > > > +{
> > > > +     dev->removable = removable;
> > > > +}
> > > > +
> > > > +static inline bool dev_is_removable(struct device *dev)
> > > > +{
> > > > +     return dev && dev->type && dev->type->supports_removable
> > > > +         && dev->removable == DEVICE_REMOVABLE;
> > >
> > > Again, shouldn't this be a bus type, and not a device type?
> > >
> > > Where are you going to have devices of different types on a bus that do,
> > > or do not, allow this attribute?
> >
> > USB. Presently, both the usb_device_type and usb_if_device_type sit on
> > the usb_bus_type but "removable" only applies to usb_device_type (the
> > attribute shows up only under usb_devices and not under
> > usb_interfaces).
>
> Ah.  Messy.
>
> Then should this be a per-device value and don't worry about the type at
> all?  You have a field in the device already, why not make it:
>
> enum device_removable {
>         DEVICE_REMOVABLE_NOT_SUPPORTED = 0,     /* must be 0 */
>         DEVICE_REMOVABLE_UNKNOWN,
>         DEVICE_REMOVABLE,
>         DEVICE_FIXED,
> };
>
> And then only show the file if a device does NOT have the value set to
> DEVICE_REMOVABLE_NOT_SUPPORTED?
>
> If a bus/subsystem/whatever wants the device to have a sysfs file and
> value there, then it needs to set it to anything other than 0 and it
> will be created?

Ack, will do.

Thanks,

Rajat


>
> That gets you out of the device bus/type mess and it is localized to
> only the device itself, allowing for any device to do this?  Should make
> the logic everywhere a bit simpler as well.
>
> thanks,
>
> greg k-h
