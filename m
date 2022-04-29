Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05FA515340
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 20:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379867AbiD2SGj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 14:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiD2SGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 14:06:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D366D4C48
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 11:03:19 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id m6so6393216iob.4
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 11:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UEKgXrrD0bBkveYKV1BzyuG02j+m4QM4Vug4t1K1Lc=;
        b=QTAhsROB7PeybDtVIea7NpCcw6Y2SGXrxVNMO7ueaeqMjkvhygrvrO0CB92dH9jYHv
         /1nCwI6Csg2CaPABJV27UPGb+RZGethrwyW6l9S/0RC4pDBGuwKfa+1q7I/+z5H21Z+w
         +7l5ZduiDLL6NLD8GFd41Tsa7yF5dg6x6s+q3kbxi4YNf3F7vWX1I2KU7vW2wJ2z/HrJ
         TdeOd6pFhgxZGYn+oda5ArqSaiiM9auNh6u6kBlG8er/5Dn7LqYesgqm6k8RG1rG2swV
         jLFb9vwGPv4PNejd+S6r4d5/N9/J7CVn5pzUglxFfDhAg7y/B0z64DikIAot0VeJMD+r
         oaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UEKgXrrD0bBkveYKV1BzyuG02j+m4QM4Vug4t1K1Lc=;
        b=l6wWg0jbufVBmSjrIjFNvYNFB9rXkH+5Hrzo5euuLIR4298NoaIU9e00DUqW+e224w
         R4E59V6jQFS0HT3VQfIn2SDTLFPg2tnVDsmFhOt3G2BwyGYMP1DnsGMg5fSidyOBcS0D
         dGzWb1598bksLyKXGSrXdLcvLaX+FfTfXA679VTE3myNqE6md/qJHZJAf3+bV54VhL//
         UtdERGCJ3CqXS7+Taf39w6ggMZeoV2kLLFY+VvxwEFWe3Ys1TOUsXBs+i4DKFN76REIU
         N9TzCLMgybC2332R8hG7/krBwyH4I3ilmFWdmv09PIMDLgJCwAc27WFf+zNuRO5jscSk
         xloQ==
X-Gm-Message-State: AOAM531p8plc6ovRHVrwHjpwUk+NJ25RLF+UfouvD2mEO0TRYXZLCkUs
        hbrkLzAPQUbfj025e0wl5nBu2KlVmXRwuALBb3enwA==
X-Google-Smtp-Source: ABdhPJxlXzGicn38bpRJBvIzpXXTfNsqk06DDdDi/Q9CDMeryZztyna/X6hAAJIMQXteAb0adbuW7DcpXj+kgmwV6hg=
X-Received: by 2002:a02:7a06:0:b0:32b:1b83:649a with SMTP id
 a6-20020a027a06000000b0032b1b83649amr229323jac.29.1651255398079; Fri, 29 Apr
 2022 11:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220412224348.1038613-1-tansuresh@google.com>
 <20220412224348.1038613-2-tansuresh@google.com> <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
From:   Tanjore Suresh <tansuresh@google.com>
Date:   Fri, 29 Apr 2022 11:03:07 -0700
Message-ID: <CALVARr6v5hcY0Vcf1izPUX-tXNJyyNXBMANbKX4CW9wfRf-pYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rafael,

That is a good observation, however, many of the use cases in data
centers (deployment of devices in data centers) do not exploit device
power management. Therefore, I'm not sure that is the right way to
design this.

Also if you look into device_shutdown (drivers/base/core.c) generic
kernel routine does not exploit the shutdown method suggested by you
instead use the generic shutdown methods defined in bus, class,
drivers structures. Therefore, adopting to expand on those generic
shutdown interfaces is the incremental choice to not confuse driver
developers.

Hope this clarifies why this extension is proposed when compared to
overloading a generic shutdown entry point with device power
management requirements.

Thanks
sureshtk



On Fri, Apr 15, 2022 at 7:42 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Apr 13, 2022 at 12:44 AM Tanjore Suresh <tansuresh@google.com> wrote:
> >
> > This changes the bus driver interface with additional entry points
> > to enable devices to implement asynchronous shutdown. The existing
> > synchronous interface to shutdown is unmodified and retained for
> > backward compatibility.
> >
> > This changes the common device shutdown code to enable devices to
> > participate in asynchronous shutdown implementation.
> >
> > Signed-off-by: Tanjore Suresh <tansuresh@google.com>
>
> Is there any specific reason why you didn't follow the design of, say,
> dpm_suspend(), where the "async" devices only need to have a flag set
> and the driver is not required to implement any new callbacks?
>
> IMO having different driver interfaces for asynchronous suspend and
> shutdown would be quite confusing for driver developers, wouldn't it?
>
> > ---
> >  drivers/base/core.c        | 38 +++++++++++++++++++++++++++++++++++++-
> >  include/linux/device/bus.h | 12 ++++++++++++
> >  2 files changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 3d6430eb0c6a..ba267ae70a22 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
> >  void device_shutdown(void)
> >  {
> >         struct device *dev, *parent;
> > +       LIST_HEAD(async_shutdown_list);
> >
> >         wait_for_device_probe();
> >         device_block_probing();
> > @@ -4523,7 +4524,13 @@ void device_shutdown(void)
> >                                 dev_info(dev, "shutdown_pre\n");
> >                         dev->class->shutdown_pre(dev);
> >                 }
> > -               if (dev->bus && dev->bus->shutdown) {
> > +               if (dev->bus && dev->bus->async_shutdown_start) {
> > +                       if (initcall_debug)
> > +                               dev_info(dev, "async_shutdown_start\n");
> > +                       dev->bus->async_shutdown_start(dev);
> > +                       list_add_tail(&dev->kobj.entry,
> > +                               &async_shutdown_list);
> > +               } else if (dev->bus && dev->bus->shutdown) {
> >                         if (initcall_debug)
> >                                 dev_info(dev, "shutdown\n");
> >                         dev->bus->shutdown(dev);
> > @@ -4543,6 +4550,35 @@ void device_shutdown(void)
> >                 spin_lock(&devices_kset->list_lock);
> >         }
> >         spin_unlock(&devices_kset->list_lock);
> > +
> > +       /*
> > +        * Second pass spin for only devices, that have configured
> > +        * Asynchronous shutdown.
> > +        */
> > +       while (!list_empty(&async_shutdown_list)) {
> > +               dev = list_entry(async_shutdown_list.next, struct device,
> > +                               kobj.entry);
> > +               parent = get_device(dev->parent);
> > +               get_device(dev);
> > +               /*
> > +                * Make sure the device is off the  list
> > +                */
> > +               list_del_init(&dev->kobj.entry);
> > +               if (parent)
> > +                       device_lock(parent);
> > +               device_lock(dev);
> > +               if (dev->bus && dev->bus->async_shutdown_end) {
> > +                       if (initcall_debug)
> > +                               dev_info(dev,
> > +                               "async_shutdown_end called\n");
> > +                       dev->bus->async_shutdown_end(dev);
> > +               }
> > +               device_unlock(dev);
> > +               if (parent)
> > +                       device_unlock(parent);
> > +               put_device(dev);
> > +               put_device(parent);
> > +       }
> >  }
> >
> >  /*
> > diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> > index a039ab809753..f582c9d21515 100644
> > --- a/include/linux/device/bus.h
> > +++ b/include/linux/device/bus.h
> > @@ -49,6 +49,16 @@ struct fwnode_handle;
> >   *             will never get called until they do.
> >   * @remove:    Called when a device removed from this bus.
> >   * @shutdown:  Called at shut-down time to quiesce the device.
> > + * @async_shutdown_start:      Called at the shutdown-time to start
> > + *                             the shutdown process on the device.
> > + *                             This entry point will be called only
> > + *                             when the bus driver has indicated it would
> > + *                             like to participate in asynchronous shutdown
> > + *                             completion.
> > + * @async_shutdown_end:        Called at shutdown-time  to complete the shutdown
> > + *                     process of the device. This entry point will be called
> > + *                     only when the bus drive has indicated it would like to
> > + *                     participate in the asynchronous shutdown completion.
> >   *
> >   * @online:    Called to put the device back online (after offlining it).
> >   * @offline:   Called to put the device offline for hot-removal. May fail.
> > @@ -93,6 +103,8 @@ struct bus_type {
> >         void (*sync_state)(struct device *dev);
> >         void (*remove)(struct device *dev);
> >         void (*shutdown)(struct device *dev);
> > +       void (*async_shutdown_start)(struct device *dev);
> > +       void (*async_shutdown_end)(struct device *dev);
> >
> >         int (*online)(struct device *dev);
> >         int (*offline)(struct device *dev);
> > --
> > 2.36.0.rc0.470.gd361397f0d-goog
> >
